import React, { useState, useEffect, useRef } from 'react';
import {
  View,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  TextInput,
  KeyboardAvoidingView,
  Platform,
  Alert,
  Image,
  ActivityIndicator,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { StatusBar } from 'expo-status-bar';
import { Ionicons } from '@expo/vector-icons';
import { Typography } from '../../components/ui';
import { theme } from '../../theme';
import { useAuth } from '../../contexts/AuthContext';
import { ChatService, SupportMessage } from '../../services/ChatService';

interface ChatScreenProps {
  navigation: any;
  route?: {
    params?: {
      category?: string;
      initialMessage?: string;
    };
  };
}

export const ChatScreen: React.FC<ChatScreenProps> = ({ navigation, route }) => {
  const { user, profile } = useAuth();
  const [messages, setMessages] = useState<SupportMessage[]>([]);
  const [inputText, setInputText] = useState('');
  const [isTyping, setIsTyping] = useState(false);
  const [conversationId, setConversationId] = useState<string | null>(null);
  const [loading, setLoading] = useState(true);
  const scrollViewRef = useRef<ScrollView>(null);
  const channelRef = useRef<any>(null);

  useEffect(() => {
    initializeChat();
    
    return () => {
      // Cleanup subscription
      if (channelRef.current) {
        channelRef.current.unsubscribe();
      }
    };
  }, []);

  const initializeChat = async () => {
    if (!user) {
      Alert.alert('Error', 'You must be logged in to use chat');
      navigation.goBack();
      return;
    }

    try {
      // Get or create conversation
      const conversation = await ChatService.getOrCreateConversation(user.id, profile);
      
      if (!conversation) {
        Alert.alert('Error', 'Failed to create conversation');
        navigation.goBack();
        return;
      }

      setConversationId(conversation.id);

      // Load existing messages
      const existingMessages = await ChatService.getMessages(conversation.id);
      setMessages(existingMessages);

      // If no messages, send AI greeting
      if (existingMessages.length === 0) {
        await sendAIGreeting(conversation.id);
      }

      // Subscribe to real-time updates
      channelRef.current = ChatService.subscribeToMessages(conversation.id, (newMessage) => {
        setMessages(prev => [...prev, newMessage]);
        scrollToBottom();
      });

      // Send initial message if provided
      if (route?.params?.initialMessage) {
        setTimeout(() => {
          handleSend(route?.params?.initialMessage || '');
        }, 1000);
      }

      setLoading(false);
    } catch (error) {
      console.error('Error initializing chat:', error);
      Alert.alert('Error', 'Failed to initialize chat');
      setLoading(false);
    }
  };

  const sendAIGreeting = async (convId: string) => {
    const greeting = `Hi ${profile?.name || 'there'}! 👋 I'm your HomeHeros assistant. How can I help you today?`;
    
    await ChatService.sendMessage(
      convId,
      user!.id,
      greeting,
      'ai',
      'HomeHeros AI'
    );
  };

  const handleSend = async (text?: string) => {
    const messageText = text || inputText.trim();
    if (!messageText || !conversationId || !user) return;

    setInputText('');
    setIsTyping(true);

    try {
      // Send user message
      await ChatService.sendMessage(
        conversationId,
        user.id,
        messageText,
        'customer',
        profile?.name || user.email
      );

      // Get AI response
      const aiResponse = await ChatService.getAIResponse(messageText);
      
      if (aiResponse) {
        // Simulate typing delay
        setTimeout(async () => {
          await ChatService.sendMessage(
            conversationId,
            user.id,
            aiResponse.response,
            'ai',
            'HomeHeros AI'
          );
          setIsTyping(false);
        }, 1000);
      } else {
        setIsTyping(false);
      }
    } catch (error) {
      console.error('Error sending message:', error);
      Alert.alert('Error', 'Failed to send message');
      setIsTyping(false);
    }
  };

  const handleImageUpload = async () => {
    if (!conversationId || !user) return;

    try {
      const imageUrl = await ChatService.uploadImage(conversationId, user.id);
      
      if (imageUrl) {
        await ChatService.sendImageMessage(conversationId, user.id, imageUrl);
        Alert.alert('Success', 'Image uploaded successfully');
      }
    } catch (error) {
      console.error('Error uploading image:', error);
      Alert.alert('Error', 'Failed to upload image');
    }
  };

  const handleRequestAgent = async () => {
    if (!conversationId) return;

    Alert.alert(
      'Request Agent',
      'Would you like to speak with a live agent? They will be able to help you with your specific situation.',
      [
        { text: 'Cancel', style: 'cancel' },
        {
          text: 'Yes, Connect Me',
          onPress: async () => {
            const success = await ChatService.requestAgent(conversationId);
            if (success) {
              Alert.alert('Agent Requested', 'An agent will be with you shortly!');
            } else {
              Alert.alert('Error', 'Failed to request agent');
            }
          },
        },
      ]
    );
  };

  const scrollToBottom = () => {
    setTimeout(() => {
      scrollViewRef.current?.scrollToEnd({ animated: true });
    }, 100);
  };

  const renderMessage = (message: SupportMessage) => {
    const isUser = message.sender_type === 'customer';
    const isAI = message.sender_type === 'ai';
    const isAgent = message.sender_type === 'agent';
    const isSystem = message.sender_type === 'system';
    
    return (
      <View key={message.id} style={[styles.messageContainer, isUser && styles.userMessageContainer]}>
        <View style={[styles.messageBubble, isUser ? styles.userBubble : isAI ? styles.aiBubble : isAgent ? styles.agentBubble : styles.systemBubble]}>
          {!isUser && !isSystem && (
            <View style={[styles.avatar, isAI && styles.aiAvatar, isAgent && styles.agentAvatar]}>
              <Ionicons 
                name={isAI ? 'chatbubbles' : 'person'} 
                size={16} 
                color={theme.colors.primary.main} 
              />
            </View>
          )}
          <View style={styles.messageContent}>
            {message.message_text && (
              <Typography 
                variant="body2" 
                color={isUser ? 'inverse' : 'primary'}
                style={styles.messageText}
              >
                {message.message_text}
              </Typography>
            )}
            {message.image_url && (
              <Image 
                source={{ uri: message.image_url }} 
                style={styles.messageImage}
                resizeMode="cover"
              />
            )}
            <Typography 
              variant="caption" 
              color={isUser ? 'inverse' : 'secondary'}
              style={styles.timestamp}
            >
              {new Date(message.created_at).toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit' })}
            </Typography>
          </View>
        </View>
      </View>
    );
  };

  if (loading) {
    return (
      <SafeAreaView style={styles.container}>
        <View style={styles.loadingContainer}>
          <ActivityIndicator size="large" color={theme.colors.primary.main} />
          <Typography variant="body1" style={styles.loadingText}>
            Connecting to support...
          </Typography>
        </View>
      </SafeAreaView>
    );
  }

  return (
    <SafeAreaView style={styles.container}>
      <StatusBar style="dark" backgroundColor={theme.colors.background.primary} />
      
      {/* Header */}
      <View style={styles.header}>
        <TouchableOpacity
          style={styles.backButton}
          onPress={() => navigation.goBack()}
        >
          <Ionicons name="arrow-back" size={24} color={theme.colors.text.primary} />
        </TouchableOpacity>
        
        <View style={styles.headerContent}>
          <Typography variant="h6" weight="semibold">
            Support Chat
          </Typography>
          <View style={styles.statusContainer}>
            <View style={styles.onlineDot} />
            <Typography variant="caption" color="secondary">
              AI Assistant Active
            </Typography>
          </View>
        </View>

        <TouchableOpacity style={styles.headerButton} onPress={handleRequestAgent}>
          <Ionicons name="person-add" size={20} color={theme.colors.text.primary} />
        </TouchableOpacity>
      </View>

      <KeyboardAvoidingView 
        style={styles.keyboardView}
        behavior={Platform.OS === 'ios' ? 'padding' : undefined}
        keyboardVerticalOffset={Platform.OS === 'ios' ? 90 : 0}
      >
        {/* Messages */}
        <ScrollView
          ref={scrollViewRef}
          style={styles.messagesContainer}
          contentContainerStyle={styles.messagesContent}
          onContentSizeChange={scrollToBottom}
        >
          {messages.map(renderMessage)}
          
          {/* Typing Indicator */}
          {isTyping && (
            <View style={styles.typingContainer}>
              <View style={styles.typingBubble}>
                <View style={styles.typingDot} />
                <View style={[styles.typingDot, styles.typingDotDelay1]} />
                <View style={[styles.typingDot, styles.typingDotDelay2]} />
              </View>
            </View>
          )}
        </ScrollView>

        {/* Input Area */}
        <View style={styles.inputContainer}>
          <View style={styles.inputWrapper}>
            <TextInput
              style={styles.input}
              placeholder="Type your message..."
              placeholderTextColor={theme.colors.text.secondary}
              value={inputText}
              onChangeText={setInputText}
              multiline
              maxLength={500}
            />
            <TouchableOpacity 
              style={styles.iconBtn}
              onPress={handleImageUpload}
            >
              <Ionicons name="image" size={20} color={theme.colors.text.secondary} />
            </TouchableOpacity>
            <TouchableOpacity 
              style={[styles.sendButton, inputText.trim() && styles.sendButtonActive]}
              onPress={() => handleSend()}
              disabled={!inputText.trim()}
            >
              <Ionicons 
                name="send" 
                size={20} 
                color={inputText.trim() ? theme.colors.primary.main : theme.colors.text.secondary} 
              />
            </TouchableOpacity>
          </View>
        </View>
      </KeyboardAvoidingView>
    </SafeAreaView>
  );
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: theme.colors.background.secondary,
  },
  loadingContainer: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
  },
  loadingText: {
    marginTop: theme.semanticSpacing.md,
  },
  header: {
    flexDirection: 'row',
    alignItems: 'center',
    paddingHorizontal: theme.semanticSpacing.md,
    paddingVertical: theme.semanticSpacing.md,
    backgroundColor: theme.colors.background.primary,
    borderBottomWidth: 1,
    borderBottomColor: theme.colors.border.light,
  },
  backButton: {
    marginRight: theme.semanticSpacing.sm,
    padding: theme.semanticSpacing.xs,
  },
  headerContent: {
    flex: 1,
  },
  statusContainer: {
    flexDirection: 'row',
    alignItems: 'center',
    marginTop: 2,
  },
  onlineDot: {
    width: 8,
    height: 8,
    borderRadius: 4,
    backgroundColor: theme.colors.success.main,
    marginRight: 6,
  },
  headerButton: {
    padding: theme.semanticSpacing.xs,
  },
  keyboardView: {
    flex: 1,
  },
  messagesContainer: {
    flex: 1,
  },
  messagesContent: {
    padding: theme.semanticSpacing.md,
    paddingBottom: theme.semanticSpacing.lg,
  },
  messageContainer: {
    marginBottom: theme.semanticSpacing.md,
    alignItems: 'flex-start',
  },
  userMessageContainer: {
    alignItems: 'flex-end',
  },
  messageBubble: {
    flexDirection: 'row',
    maxWidth: '80%',
  },
  aiBubble: {
    backgroundColor: theme.colors.background.primary,
    borderRadius: theme.borderRadius.lg,
    padding: theme.semanticSpacing.sm,
    ...theme.shadows.sm,
  },
  agentBubble: {
    backgroundColor: '#E8F5E9',
    borderRadius: theme.borderRadius.lg,
    padding: theme.semanticSpacing.sm,
    ...theme.shadows.sm,
  },
  userBubble: {
    backgroundColor: theme.colors.primary.main,
    borderRadius: theme.borderRadius.lg,
    padding: theme.semanticSpacing.sm,
  },
  systemBubble: {
    backgroundColor: theme.colors.neutral[200],
    borderRadius: theme.borderRadius.lg,
    padding: theme.semanticSpacing.sm,
  },
  avatar: {
    width: 32,
    height: 32,
    borderRadius: 16,
    backgroundColor: `${theme.colors.primary.main}15`,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: theme.semanticSpacing.sm,
  },
  aiAvatar: {
    backgroundColor: `${theme.colors.primary.main}15`,
  },
  agentAvatar: {
    backgroundColor: `${theme.colors.success.main}15`,
  },
  messageContent: {
    flex: 1,
  },
  messageText: {
    lineHeight: 20,
  },
  messageImage: {
    width: 200,
    height: 200,
    borderRadius: theme.borderRadius.md,
    marginTop: theme.semanticSpacing.xs,
  },
  timestamp: {
    marginTop: 4,
    opacity: 0.7,
  },
  typingContainer: {
    alignItems: 'flex-start',
    marginBottom: theme.semanticSpacing.md,
  },
  typingBubble: {
    flexDirection: 'row',
    backgroundColor: theme.colors.background.primary,
    borderRadius: theme.borderRadius.lg,
    padding: theme.semanticSpacing.md,
    gap: 6,
    ...theme.shadows.sm,
  },
  typingDot: {
    width: 8,
    height: 8,
    borderRadius: 4,
    backgroundColor: theme.colors.text.secondary,
    opacity: 0.4,
  },
  typingDotDelay1: {
    opacity: 0.6,
  },
  typingDotDelay2: {
    opacity: 0.8,
  },
  inputContainer: {
    backgroundColor: theme.colors.background.primary,
    borderTopWidth: 1,
    borderTopColor: theme.colors.border.light,
    paddingHorizontal: theme.semanticSpacing.md,
    paddingVertical: theme.semanticSpacing.sm,
  },
  inputWrapper: {
    flexDirection: 'row',
    alignItems: 'flex-end',
    backgroundColor: theme.colors.background.secondary,
    borderRadius: theme.borderRadius.xl,
    paddingHorizontal: theme.semanticSpacing.md,
    paddingVertical: theme.semanticSpacing.xs,
    minHeight: 44,
  },
  input: {
    flex: 1,
    fontSize: 16,
    color: theme.colors.text.primary,
    maxHeight: 100,
    paddingVertical: theme.semanticSpacing.sm,
  },
  iconBtn: {
    width: 36,
    height: 36,
    borderRadius: 18,
    justifyContent: 'center',
    alignItems: 'center',
    marginLeft: theme.semanticSpacing.xs,
  },
  sendButton: {
    width: 36,
    height: 36,
    borderRadius: 18,
    justifyContent: 'center',
    alignItems: 'center',
    marginLeft: theme.semanticSpacing.xs,
  },
  sendButtonActive: {
    backgroundColor: `${theme.colors.primary.main}15`,
  },
});
