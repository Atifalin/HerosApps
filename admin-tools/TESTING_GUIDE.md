# Chat System Testing Guide

## ✅ Database Connection Status

**All systems verified and ready:**
- ✅ Database tables created successfully
- ✅ 7 AI scripts loaded and active
- ✅ RLS policies enabled
- ✅ Real-time subscriptions configured
- ✅ Storage bucket ready

---

## 🧪 Manual Testing Steps

### **Step 1: Test CSR Dashboard**

1. **Open the dashboard:**
   ```bash
   open "/Users/atifali/Code/Paid Apps/Homeheros/admin-tools/csr-chat-dashboard.html"
   ```

2. **Verify dashboard loads:**
   - Should show "Test Agent (No Auth)" in header
   - Conversations panel on left (will be empty initially)
   - Chat panel in center
   - Customer info panel on right

3. **Test AI Scripts Manager:**
   - Click "Load Scripts" button in right panel
   - Should see 7 AI scripts:
     - agent_request
     - technical_issue
     - service_question
     - account_help
     - payment_issue
     - cancel_booking
     - booking_tracking
   - Try editing a script response
   - Toggle a script active/inactive

**Expected Result:** Dashboard loads without errors, scripts display and are editable.

---

### **Step 2: Test Mobile App Chat**

1. **Start the mobile app:**
   ```bash
   cd "/Users/atifali/Code/Paid Apps/Homeheros/Homeheros_app"
   npm start
   ```

2. **Launch on simulator/device:**
   - Press `i` for iOS or `a` for Android

3. **Navigate to chat:**
   - Login to the app (as a customer)
   - Tap the chat icon in the header (on HomeScreen or BookingStatusScreen)
   - Should see SupportScreen with quick actions

4. **Start a conversation:**
   - Tap "Start Chat" button
   - Should see ChatScreen with AI greeting
   - AI should say: "Hi [your name]! 👋 I'm your HomeHeros assistant..."

**Expected Result:** Chat screen loads, AI greeting appears.

---

### **Step 3: Test AI Responses**

**In the mobile app ChatScreen, try these messages:**

1. **Test booking tracking:**
   - Type: "track my booking"
   - Expected: AI responds with booking tracking help
   - Should see quick reply buttons

2. **Test payment help:**
   - Type: "I have a payment issue"
   - Expected: AI responds with payment options
   - Quick replies: "Refund request", "Update payment", etc.

3. **Test cancellation:**
   - Type: "cancel my booking"
   - Expected: AI provides cancellation steps

4. **Test agent request:**
   - Type: "I need to talk to a person"
   - Expected: AI offers to connect to agent

**Expected Result:** AI responds appropriately to each keyword.

---

### **Step 4: Test Real-Time Sync**

**You'll need both dashboard and mobile app open:**

1. **Send message from mobile app:**
   - Type any message in the mobile chat
   - Press send

2. **Check CSR dashboard:**
   - Refresh the conversations list
   - You should see a new conversation appear
   - Click on it to view messages

3. **Reply from dashboard:**
   - Type a message in the dashboard
   - Press send

4. **Check mobile app:**
   - Message should appear in real-time (within 1-2 seconds)

**Expected Result:** Messages sync in real-time between mobile and dashboard.

---

### **Step 5: Test Image Upload**

**In mobile app:**

1. Tap the image icon (📎) in chat input
2. Select an image from gallery
3. Image should upload and appear in chat

**In CSR dashboard:**
4. Refresh conversation
5. Image should be visible in the message

**Expected Result:** Images upload and display in both interfaces.

---

### **Step 6: Test Customer Context**

**In CSR dashboard:**

1. Select a conversation with a logged-in customer
2. Check right panel "Customer Information"
3. Should display:
   - Customer name
   - Email
   - Phone
   - Total bookings
   - Last booking date

4. If customer has bookings, "Recent Bookings" section should show:
   - Service name
   - Status
   - Price
   - Date

**Expected Result:** Customer context displays correctly with booking history.

---

### **Step 7: Test Agent Features**

**In CSR dashboard:**

1. **Assign conversation:**
   - Click "Assign to Me" button
   - Conversation status should change to "assigned"

2. **Resolve conversation:**
   - Click "Resolve" button
   - Conversation should move to resolved status

3. **Filter conversations:**
   - Try clicking different filter tabs: All, Open, Assigned, Urgent
   - Conversations should filter accordingly

**Expected Result:** Agent actions work and update conversation status.

---

## 🔍 Troubleshooting

### Dashboard shows "Loading conversations..." forever
**Fix:** Check browser console (F12) for errors. Verify Supabase URL and key are correct.

### Mobile app shows "Failed to create conversation"
**Fix:** 
- Ensure user is logged in
- Check network connection
- Verify Supabase credentials in `src/lib/supabase.ts`

### AI not responding
**Fix:**
- Verify AI scripts are active in dashboard
- Check that keywords match (case-insensitive)
- Look for errors in browser/app console

### Messages not syncing in real-time
**Fix:**
- Check that real-time is enabled for tables
- Verify subscription is active (check console logs)
- Try refreshing both interfaces

### Images not uploading
**Fix:**
- Check file size < 5MB
- Verify file type is image (JPEG, PNG, GIF, WebP)
- Check storage bucket permissions in Supabase

---

## 📊 What to Look For

### ✅ Success Indicators:
- Dashboard loads without errors
- AI scripts display and are editable
- Mobile chat connects and shows greeting
- AI responds to keywords appropriately
- Messages appear in both interfaces
- Customer context displays correctly
- Real-time updates work (< 2 second delay)
- Images upload successfully

### ❌ Failure Indicators:
- Console errors (check browser F12 and app logs)
- "Failed to..." error messages
- Infinite loading states
- Messages not appearing
- 404 errors on API calls
- Authentication errors

---

## 🎯 Testing Checklist

- [ ] CSR Dashboard opens successfully
- [ ] AI Scripts load and display (7 scripts)
- [ ] Can edit AI script responses
- [ ] Mobile app chat screen loads
- [ ] AI greeting message appears
- [ ] AI responds to "track booking" keyword
- [ ] AI responds to "payment" keyword
- [ ] AI responds to "cancel" keyword
- [ ] AI responds to "agent" keyword
- [ ] Messages sync from mobile to dashboard
- [ ] Messages sync from dashboard to mobile
- [ ] Image upload works from mobile
- [ ] Customer info displays in dashboard
- [ ] Booking history shows (if available)
- [ ] Can assign conversation to agent
- [ ] Can resolve conversation
- [ ] Filter tabs work in dashboard
- [ ] Real-time updates work (< 2 sec)

---

## 📝 Test Data

### Sample Messages to Test:
```
"Where is my hero?"          → booking_tracking
"I need a refund"            → payment_issue
"Cancel my booking"          → cancel_booking
"What's included?"           → service_question
"Update my profile"          → account_help
"App is crashing"            → technical_issue
"Talk to a human"            → agent_request
```

---

## 🚀 Next Steps After Testing

1. **If everything works:**
   - Start using the system
   - Monitor for any issues
   - Collect feedback from CS agents

2. **If issues found:**
   - Note the specific error messages
   - Check browser/app console logs
   - Review the error in context
   - Report issues with screenshots

3. **Production readiness:**
   - Re-enable authentication in CSR dashboard
   - Set up proper CS agent accounts
   - Configure production Supabase credentials
   - Test with real customer data

---

## 💡 Tips

- **Keep browser console open** (F12) to see real-time logs
- **Test with multiple conversations** to verify filtering works
- **Try different keywords** to test AI matching
- **Test on both iOS and Android** if possible
- **Monitor database** in Supabase dashboard during testing
- **Check real-time subscriptions** in Supabase dashboard

---

## 📞 Support

If you encounter issues:
1. Check console logs first
2. Verify database tables exist in Supabase
3. Confirm RLS policies are enabled
4. Test with a fresh conversation
5. Clear browser cache and app data

Good luck with testing! 🎉
