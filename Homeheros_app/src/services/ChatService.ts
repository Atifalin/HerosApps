import { supabase } from '../lib/supabase';
import * as ImagePicker from 'expo-image-picker';

export interface SupportConversation {
  id: string;
  user_id: string;
  customer_name: string | null;
  customer_email: string | null;
  customer_phone: string | null;
  status: 'open' | 'assigned' | 'resolved' | 'closed';
  priority: 'low' | 'normal' | 'high' | 'urgent';
  category: string | null;
  ai_handled: boolean;
  agent_id: string | null;
  agent_name: string | null;
  customer_context: any;
  metadata: any;
  last_message_at: string;
  created_at: string;
  updated_at: string;
  resolved_at: string | null;
  closed_at: string | null;
}

export interface SupportMessage {
  id: string;
  conversation_id: string;
  sender_id: string | null;
  sender_type: 'customer' | 'agent' | 'ai' | 'system';
  sender_name: string | null;
  message_text: string | null;
  message_type: 'text' | 'image' | 'system_note' | 'status_change';
  image_url: string | null;
  metadata: any;
  read_at: string | null;
  created_at: string;
}

export interface AIScript {
  id: string;
  category: string;
  trigger_keywords: string[];
  response_template: string;
  quick_replies: string[] | null;
  escalation_threshold: number;
  is_active: boolean;
  priority: number;
}

export class ChatService {
  /**
   * Get or create a conversation for the current user
   */
  static async getOrCreateConversation(userId: string, userProfile: any): Promise<SupportConversation | null> {
    try {
      // Check for existing open conversation
      const { data: existing, error: fetchError } = await supabase
        .from('support_conversations')
        .select('*')
        .eq('user_id', userId)
        .in('status', ['open', 'assigned'])
        .order('created_at', { ascending: false })
        .limit(1)
        .single();

      if (existing && !fetchError) {
        return existing;
      }

      // Fetch customer context (bookings, profile, etc.)
      const customerContext = await this.getCustomerContext(userId);

      // Create new conversation
      const { data: newConversation, error: createError } = await supabase
        .from('support_conversations')
        .insert({
          user_id: userId,
          customer_name: userProfile?.name || null,
          customer_email: userProfile?.email || null,
          customer_phone: userProfile?.phone || null,
          status: 'open',
          priority: 'normal',
          ai_handled: true,
          customer_context: customerContext,
        })
        .select()
        .single();

      if (createError) {
        console.error('Error creating conversation:', createError);
        return null;
      }

      return newConversation;
    } catch (error) {
      console.error('Error in getOrCreateConversation:', error);
      return null;
    }
  }

  /**
   * Get comprehensive customer context for CSR
   */
  static async getCustomerContext(userId: string): Promise<any> {
    try {
      // Fetch user profile
      const { data: profile } = await supabase
        .from('profiles')
        .select('*')
        .eq('id', userId)
        .single();

      // Fetch recent bookings
      const { data: bookings } = await supabase
        .from('bookings')
        .select(`
          id,
          status,
          scheduled_at,
          price_cents,
          services (title),
          service_variants (name),
          addresses (street, city, province)
        `)
        .eq('customer_id', userId)
        .order('created_at', { ascending: false })
        .limit(5);

      // Fetch saved addresses
      const { data: addresses } = await supabase
        .from('addresses')
        .select('*')
        .eq('user_id', userId)
        .limit(3);

      return {
        profile,
        recent_bookings: bookings || [],
        saved_addresses: addresses || [],
        total_bookings: bookings?.length || 0,
        last_booking_date: bookings?.[0]?.scheduled_at || null,
      };
    } catch (error) {
      console.error('Error fetching customer context:', error);
      return {};
    }
  }

  /**
   * Send a message in a conversation
   */
  static async sendMessage(
    conversationId: string,
    userId: string,
    messageText: string,
    senderType: 'customer' | 'agent' | 'ai' = 'customer',
    senderName?: string
  ): Promise<SupportMessage | null> {
    try {
      const { data, error } = await supabase
        .from('support_messages')
        .insert({
          conversation_id: conversationId,
          sender_id: userId,
          sender_type: senderType,
          sender_name: senderName,
          message_text: messageText,
          message_type: 'text',
        })
        .select()
        .single();

      if (error) {
        console.error('Error sending message:', error);
        return null;
      }

      return data;
    } catch (error) {
      console.error('Error in sendMessage:', error);
      return null;
    }
  }

  /**
   * Get AI response based on message content
   */
  static async getAIResponse(messageText: string): Promise<{ response: string; quickReplies: string[] } | null> {
    try {
      const lowerMessage = messageText.toLowerCase();

      // Fetch matching AI scripts
      const { data: scripts, error } = await supabase
        .from('support_ai_scripts')
        .select('*')
        .eq('is_active', true)
        .order('priority', { ascending: false });

      if (error || !scripts) {
        return this.getDefaultResponse();
      }

      // Find best matching script
      let bestMatch: AIScript | null = null;
      let maxMatches = 0;

      for (const script of scripts) {
        const matches = script.trigger_keywords.filter((keyword: string) =>
          lowerMessage.includes(keyword.toLowerCase())
        ).length;

        if (matches > maxMatches) {
          maxMatches = matches;
          bestMatch = script;
        }
      }

      if (bestMatch && maxMatches > 0) {
        return {
          response: bestMatch.response_template,
          quickReplies: bestMatch.quick_replies || [],
        };
      }

      return this.getDefaultResponse();
    } catch (error) {
      console.error('Error getting AI response:', error);
      return this.getDefaultResponse();
    }
  }

  /**
   * Default AI response
   */
  static getDefaultResponse(): { response: string; quickReplies: string[] } {
    return {
      response: "I'm here to help! I can assist with:\n\n• Booking status and tracking\n• Payment and billing questions\n• Cancellations and rescheduling\n• Service information\n• Account settings\n\nWhat would you like help with?",
      quickReplies: ['Track booking', 'Payment help', 'Talk to agent'],
    };
  }

  /**
   * Get messages for a conversation
   */
  static async getMessages(conversationId: string): Promise<SupportMessage[]> {
    try {
      const { data, error } = await supabase
        .from('support_messages')
        .select('*')
        .eq('conversation_id', conversationId)
        .order('created_at', { ascending: true });

      if (error) {
        console.error('Error fetching messages:', error);
        return [];
      }

      return data || [];
    } catch (error) {
      console.error('Error in getMessages:', error);
      return [];
    }
  }

  /**
   * Subscribe to real-time message updates
   */
  static subscribeToMessages(conversationId: string, callback: (message: SupportMessage) => void) {
    const channel = supabase
      .channel(`conversation-${conversationId}`)
      .on(
        'postgres_changes',
        {
          event: 'INSERT',
          schema: 'public',
          table: 'support_messages',
          filter: `conversation_id=eq.${conversationId}`,
        },
        (payload) => {
          callback(payload.new as SupportMessage);
        }
      )
      .subscribe();

    return channel;
  }

  /**
   * Upload image to chat
   */
  static async uploadImage(conversationId: string, userId: string): Promise<string | null> {
    try {
      // Request permission
      const { status } = await ImagePicker.requestMediaLibraryPermissionsAsync();
      if (status !== 'granted') {
        console.error('Permission denied');
        return null;
      }

      // Pick image
      const result = await ImagePicker.launchImageLibraryAsync({
        mediaTypes: ImagePicker.MediaTypeOptions.Images,
        allowsEditing: true,
        quality: 0.8,
        base64: true,
      });

      if (result.canceled || !result.assets[0]) {
        return null;
      }

      const image = result.assets[0];
      const fileExt = image.uri.split('.').pop();
      const fileName = `${userId}/${conversationId}/${Date.now()}.${fileExt}`;

      // Convert to blob
      const response = await fetch(image.uri);
      const blob = await response.blob();

      // Upload to Supabase Storage
      const { data, error } = await supabase.storage
        .from('support-attachments')
        .upload(fileName, blob, {
          contentType: image.type || 'image/jpeg',
          upsert: false,
        });

      if (error) {
        console.error('Error uploading image:', error);
        return null;
      }

      // Get public URL
      const { data: urlData } = supabase.storage
        .from('support-attachments')
        .getPublicUrl(fileName);

      return urlData.publicUrl;
    } catch (error) {
      console.error('Error in uploadImage:', error);
      return null;
    }
  }

  /**
   * Send image message
   */
  static async sendImageMessage(
    conversationId: string,
    userId: string,
    imageUrl: string,
    caption?: string
  ): Promise<SupportMessage | null> {
    try {
      const { data, error } = await supabase
        .from('support_messages')
        .insert({
          conversation_id: conversationId,
          sender_id: userId,
          sender_type: 'customer',
          message_text: caption || null,
          message_type: 'image',
          image_url: imageUrl,
        })
        .select()
        .single();

      if (error) {
        console.error('Error sending image message:', error);
        return null;
      }

      return data;
    } catch (error) {
      console.error('Error in sendImageMessage:', error);
      return null;
    }
  }

  /**
   * Request agent escalation
   */
  static async requestAgent(conversationId: string): Promise<boolean> {
    try {
      const { error } = await supabase
        .from('support_conversations')
        .update({
          ai_handled: false,
          priority: 'high',
          status: 'assigned',
        })
        .eq('id', conversationId);

      if (error) {
        console.error('Error requesting agent:', error);
        return false;
      }

      // Send system message
      await supabase.from('support_messages').insert({
        conversation_id: conversationId,
        sender_type: 'system',
        message_text: 'Customer requested to speak with an agent. Finding available agent...',
        message_type: 'system_note',
      });

      return true;
    } catch (error) {
      console.error('Error in requestAgent:', error);
      return false;
    }
  }

  /**
   * Mark messages as read
   */
  static async markAsRead(conversationId: string, userId: string): Promise<void> {
    try {
      await supabase
        .from('support_messages')
        .update({ read_at: new Date().toISOString() })
        .eq('conversation_id', conversationId)
        .neq('sender_id', userId)
        .is('read_at', null);
    } catch (error) {
      console.error('Error marking messages as read:', error);
    }
  }
}
