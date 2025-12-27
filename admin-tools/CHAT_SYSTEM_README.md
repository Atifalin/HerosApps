# HomeHeros Support Chat System

## Overview
A comprehensive real-time support chat system with AI assistance and CSR agent management.

## Components

### 1. Database Schema
- **support_conversations**: Main conversation tracking
- **support_messages**: Individual chat messages
- **support_attachments**: File/image uploads
- **support_ai_scripts**: Editable AI response templates
- **support_agent_activity**: Agent status tracking

### 2. Mobile App (React Native)
- **ChatService.ts**: Core service for chat operations
- **SupportScreen.tsx**: Support hub with quick actions
- **ChatScreen.tsx**: Real-time chat interface

### 3. CSR Dashboard (HTML)
- **csr-chat-dashboard.html**: Full-featured admin interface
- Real-time conversation monitoring
- Customer context display
- AI script management
- Message history

## Features

### Customer App Features
✅ AI-powered instant responses
✅ Quick action buttons
✅ Image/screenshot upload
✅ Real-time messaging
✅ Agent escalation
✅ Conversation history

### CSR Dashboard Features
✅ Real-time conversation list
✅ Customer information panel
✅ Booking history display
✅ AI script editor (live editing)
✅ Message read receipts
✅ Conversation assignment
✅ Priority management
✅ Status filtering

### AI Assistant Features
✅ Keyword-based intent recognition
✅ Category-specific responses
✅ Quick reply suggestions
✅ Escalation detection
✅ Editable response templates
✅ Priority-based matching

## Setup Instructions

### 1. Database Setup
All migrations have been applied to Supabase project: `vttzuaerdwagipyocpha`

Tables created:
- support_conversations
- support_messages
- support_attachments
- support_ai_scripts
- support_agent_activity

### 2. Storage Setup
Bucket created: `support-attachments`
- Max file size: 5MB
- Allowed types: images (JPEG, PNG, GIF, WebP), PDF

### 3. Real-time Setup
Enabled real-time for:
- support_conversations
- support_messages
- support_agent_activity

### 4. CSR Dashboard Setup

#### Access the Dashboard
1. Open `admin-tools/csr-chat-dashboard.html` in a web browser
2. Login with CS agent credentials
3. Dashboard will load all active conversations

#### Create CS Agent Account
```sql
-- Create CS agent user in Supabase Auth
-- Then update user metadata:
UPDATE auth.users
SET raw_user_meta_data = jsonb_set(
    raw_user_meta_data,
    '{role}',
    '"cs"'
)
WHERE email = 'agent@homeheros.com';
```

### 5. Mobile App Integration

#### Install Dependencies
```bash
cd Homeheros_app
npm install expo-image-picker
```

#### Update ChatScreen
The ChatScreen needs to be updated to use the real ChatService instead of mock data.

## AI Script Management

### Default Scripts Included
1. **booking_tracking**: Track booking status and location
2. **payment_issue**: Payment and billing help
3. **cancel_booking**: Cancellation and rescheduling
4. **service_question**: Service information
5. **account_help**: Account settings
6. **technical_issue**: App bugs and errors
7. **agent_request**: Escalate to human agent

### Editing AI Scripts
1. Open CSR Dashboard
2. Click "Load Scripts" in the right panel
3. Edit response templates directly
4. Toggle active/inactive status
5. Changes save automatically

### Adding New Scripts
```sql
INSERT INTO support_ai_scripts (
    category,
    trigger_keywords,
    response_template,
    quick_replies,
    priority
) VALUES (
    'new_category',
    ARRAY['keyword1', 'keyword2'],
    'Your response template here',
    '["Option 1", "Option 2"]'::jsonb,
    5
);
```

## Security Features

### Row Level Security (RLS)
✅ Customers can only view their own conversations
✅ CS agents can view all conversations
✅ Admins can manage AI scripts
✅ Secure file upload with user-based paths

### Data Privacy
- Customer context stored securely
- Message encryption in transit
- File access controlled by RLS
- Agent activity tracking

## Usage Guide

### For Customers (Mobile App)
1. Tap chat icon in header
2. Select quick action or start typing
3. AI responds instantly
4. Request agent if needed
5. Upload screenshots for issues

### For CS Agents (Dashboard)
1. Login to CSR dashboard
2. View conversation list (sorted by recent)
3. Click conversation to view details
4. See customer info and booking history
5. Respond to messages in real-time
6. Assign conversation to yourself
7. Mark as resolved when done

### For Admins
1. Access AI Scripts Manager
2. Edit response templates
3. Add/remove keywords
4. Toggle script active status
5. Monitor agent activity

## API Reference

### ChatService Methods

#### `getOrCreateConversation(userId, userProfile)`
Get existing or create new conversation

#### `sendMessage(conversationId, userId, messageText, senderType, senderName)`
Send a text message

#### `getAIResponse(messageText)`
Get AI-generated response based on keywords

#### `uploadImage(conversationId, userId)`
Upload image and return URL

#### `sendImageMessage(conversationId, userId, imageUrl, caption)`
Send message with image attachment

#### `requestAgent(conversationId)`
Escalate conversation to human agent

#### `subscribeToMessages(conversationId, callback)`
Subscribe to real-time message updates

#### `markAsRead(conversationId, userId)`
Mark messages as read

## Database Schema Details

### support_conversations
```sql
- id: UUID (PK)
- user_id: UUID (FK to auth.users)
- customer_name: TEXT
- customer_email: TEXT
- customer_phone: TEXT
- status: TEXT (open, assigned, resolved, closed)
- priority: TEXT (low, normal, high, urgent)
- category: TEXT
- ai_handled: BOOLEAN
- agent_id: UUID (FK to auth.users)
- agent_name: TEXT
- customer_context: JSONB
- metadata: JSONB
- last_message_at: TIMESTAMP
- created_at: TIMESTAMP
- updated_at: TIMESTAMP
```

### support_messages
```sql
- id: UUID (PK)
- conversation_id: UUID (FK)
- sender_id: UUID (FK to auth.users)
- sender_type: TEXT (customer, agent, ai, system)
- sender_name: TEXT
- message_text: TEXT
- message_type: TEXT (text, image, system_note, status_change)
- image_url: TEXT
- metadata: JSONB
- read_at: TIMESTAMP
- created_at: TIMESTAMP
```

## Troubleshooting

### Messages Not Appearing
- Check real-time subscription is active
- Verify RLS policies allow access
- Check browser console for errors

### AI Not Responding
- Verify AI scripts are active
- Check trigger keywords match
- Review script priority order

### Images Not Uploading
- Check file size < 5MB
- Verify file type is allowed
- Check storage bucket permissions

### Agent Can't See Conversations
- Verify user role is 'cs' or 'admin'
- Check RLS policies
- Ensure user is authenticated

## Performance Optimization

### Indexes Created
- conversation user_id
- conversation agent_id
- conversation status
- conversation created_at
- messages conversation_id
- messages created_at
- ai_scripts category

### Real-time Optimization
- Subscribe only to active conversation
- Unsubscribe when switching conversations
- Limit message history to recent 100

## Future Enhancements

### Planned Features
- [ ] Chat analytics dashboard
- [ ] Automated ticket creation
- [ ] Multi-language support
- [ ] Voice message support
- [ ] Canned responses library
- [ ] Customer satisfaction ratings
- [ ] Agent performance metrics
- [ ] Chat transcripts export

## Support

For issues or questions:
- Check database logs in Supabase
- Review browser console errors
- Verify authentication status
- Check RLS policy permissions
