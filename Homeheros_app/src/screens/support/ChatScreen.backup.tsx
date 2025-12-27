import React, { useState, useEffect, useRef } from 'react';
import {
  View,
  StyleSheet,
  ScrollView,
  TouchableOpacity,
  TextInput,
  KeyboardAvoidingView,
  Platform,
} from 'react-native';
import { SafeAreaView } from 'react-native-safe-area-context';
import { StatusBar } from 'expo-status-bar';
import { Ionicons } from '@expo/vector-icons';
import { Typography, Card } from '../../components/ui';
import { theme } from '../../theme';
import { useAuth } from '../../contexts/AuthContext';

interface Message {
  id: string;
  text: string;
  sender: 'user' | 'ai' | 'agent';
  timestamp: Date;
  quickReplies?: string[];
}

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
  const { profile } = useAuth();
  const [messages, setMessages] = useState<Message[]>([]);
  const [inputText, setInputText] = useState('');
  const [isTyping, setIsTyping] = useState(false);
  const scrollViewRef = useRef<ScrollView>(null);

  useEffect(() => {
    // Initial greeting
    const greeting: Message = {
      id: '1',
      text: `Hi ${profile?.name || 'there'}! 👋 I'm your HomeHeros assistant. How can I help you today?`,
      sender: 'ai',
      timestamp: new Date(),
      quickReplies: [
        'Track my booking',
        'Payment issue',
        'Cancel booking',
        'Talk to agent',
      ],
    };
    setMessages([greeting]);

    // If there's an initial message from route params, send it
    if (route?.params?.initialMessage) {
      setTimeout(() => {
        handleSend(route?.params?.initialMessage || '');
      }, 500);
    }
  }, []);

  const handleSend = (text?: string) => {
    const messageText = text || inputText.trim();
    if (!messageText) return;

    // Add user message
    const userMessage: Message = {
      id: Date.now().toString(),
      text: messageText,
      sender: 'user',
      timestamp: new Date(),
    };

    setMessages((prev) => [...prev, userMessage]);
    setInputText('');
    setIsTyping(true);

    // Simulate AI response
    setTimeout(() => {
      const aiResponse = generateAIResponse(messageText);
      setMessages((prev) => [...prev, aiResponse]);
      setIsTyping(false);
    }, 1000);
  };

  const generateAIResponse = (userMessage: string): Message => {
    const lowerMessage = userMessage.toLowerCase();

    // Simple keyword-based responses
    if (lowerMessage.includes('track') || lowerMessage.includes('booking')) {
      return {
        id: Date.now().toString(),
        text: "I can help you track your booking! To view your active bookings, go to the Home screen. You'll see any active bookings at the top with real-time tracking.\n\nWould you like me to connect you with an agent for more specific help?",
        sender: 'ai',
        timestamp: new Date(),
        quickReplies: ['Yes, connect me', 'No, thanks'],
      };
    }

    if (lowerMessage.includes('payment') || lowerMessage.includes('charge')) {
      return {
        id: Date.now().toString(),
        text: "I understand you have a payment question. Here's what I can help with:\n\n• View payment history in your Account\n• Update payment methods\n• Request refunds\n• Dispute charges\n\nWhat specifically would you like help with?",
        sender: 'ai',
        timestamp: new Date(),
        quickReplies: ['Refund request', 'Update payment', 'Talk to agent'],
      };
    }

    if (lowerMessage.includes('cancel')) {
      return {
        id: Date.now().toString(),
        text: "To cancel a booking:\n\n1. Go to your active booking\n2. Tap 'Cancel Booking'\n3. Confirm cancellation\n\nNote: Cancellation fees may apply depending on timing.\n\nWould you like me to connect you with an agent?",
        sender: 'ai',
        timestamp: new Date(),
        quickReplies: ['Yes, connect me', 'No, thanks'],
      };
    }

    if (lowerMessage.includes('agent') || lowerMessage.includes('human') || lowerMessage.includes('person')) {
      return {
        id: Date.now().toString(),
        text: "I'll connect you with a live agent right away! They'll be able to help you with your specific situation.\n\nPlease provide your email or phone number so our agent can reach you:",
        sender: 'ai',
        timestamp: new Date(),
      };
    }

    // Default response
    return {
      id: Date.now().toString(),
      text: "I'm here to help! I can assist with:\n\n• Booking status and tracking\n• Payment and billing questions\n• Cancellations and rescheduling\n• Service information\n• Account settings\n\nWhat would you like help with?",
      sender: 'ai',
      timestamp: new Date(),
      quickReplies: ['Track booking', 'Payment help', 'Talk to agent'],
    };
  };

  const handleQuickReply = (reply: string) => {
    handleSend(reply);
  };

  const renderMessage = (message: Message) => {
    const isUser = message.sender === 'user';
    
    return (
      <View key={message.id} style={[styles.messageContainer, isUser && styles.userMessageContainer]}>
        <View style={[styles.messageBubble, isUser ? styles.userBubble : styles.aiBubble]}>
          {!isUser && (
            <View style={styles.aiAvatar}>
              <Ionicons name="chatbubbles" size={16} color={theme.colors.primary.main} />
            </View>
          )}
          <View style={styles.messageContent}>
            <Typography 
              variant="body2" 
              color={isUser ? 'inverse' : 'primary'}
              style={styles.messageText}
            >
              {message.text}
            </Typography>
            <Typography 
              variant="caption" 
              color={isUser ? 'inverse' : 'secondary'}
              style={styles.timestamp}
            >
              {message.timestamp.toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit' })}
            </Typography>
          </View>
        </View>

        {/* Quick Replies */}
        {message.quickReplies && (
          <View style={styles.quickRepliesContainer}>
            {message.quickReplies.map((reply, index) => (
              <TouchableOpacity
                key={index}
                style={styles.quickReplyButton}
                onPress={() => handleQuickReply(reply)}
              >
                <Typography variant="body2" color="brand" weight="medium">
                  {reply}
                </Typography>
              </TouchableOpacity>
            ))}
          </View>
        )}
      </View>
    );
  };

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

        <TouchableOpacity style={styles.headerButton}>
          <Ionicons name="ellipsis-vertical" size={20} color={theme.colors.text.primary} />
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
          onContentSizeChange={() => scrollViewRef.current?.scrollToEnd({ animated: true })}
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
  userBubble: {
    backgroundColor: theme.colors.primary.main,
    borderRadius: theme.borderRadius.lg,
    padding: theme.semanticSpacing.sm,
  },
  aiAvatar: {
    width: 32,
    height: 32,
    borderRadius: 16,
    backgroundColor: `${theme.colors.primary.main}15`,
    justifyContent: 'center',
    alignItems: 'center',
    marginRight: theme.semanticSpacing.sm,
  },
  messageContent: {
    flex: 1,
  },
  messageText: {
    lineHeight: 20,
  },
  timestamp: {
    marginTop: 4,
    opacity: 0.7,
  },
  quickRepliesContainer: {
    flexDirection: 'row',
    flexWrap: 'wrap',
    marginTop: theme.semanticSpacing.sm,
    gap: theme.semanticSpacing.xs,
  },
  quickReplyButton: {
    backgroundColor: theme.colors.background.primary,
    paddingHorizontal: theme.semanticSpacing.md,
    paddingVertical: theme.semanticSpacing.sm,
    borderRadius: theme.borderRadius.full,
    borderWidth: 1,
    borderColor: theme.colors.primary.main,
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
