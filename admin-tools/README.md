# HomeHeros Admin Tools

## Admin Tools

Standalone HTML admin tools for managing HomeHeros operations.

---

## 1. Hero Approval Page (`hero-approval.html`)

A standalone HTML admin tool for reviewing and approving hero profiles.

### Features

✅ **View All Hero Profiles**
- See all users with hero role
- Filter by verification status (Pending, Verified, Rejected)
- Real-time stats dashboard

✅ **Approve/Reject Heroes**
- One-click approval for pending heroes
- Reject with reason tracking
- Automatic status updates

✅ **Create Hero Profiles**
- Create hero profiles for existing users
- Assign to contractors
- Set categories, skills, and bio

### How to Use

1. **Open the page**
   ```bash
   open admin-tools/hero-approval.html
   ```
   Or simply double-click the `hero-approval.html` file

2. **Review pending heroes**
   - The page loads with "Pending" filter by default
   - Review each hero's information
   - Click "✓ Approve" to verify the hero
   - Click "✗ Reject" to reject (with reason)

3. **Create new hero profiles**
   - Click "➕ Create Hero Profile" button
   - Enter user email (must exist in profiles table)
   - Fill in hero details
   - Select contractor
   - Add categories and skills
   - Click "Create"

### Workflow

**For new signups in GO app:**
1. User signs up in HomeHeros GO app
2. Profile is created with `role: 'hero'`
3. Open this admin page
4. Click "➕ Create Hero Profile" for the user
5. Fill in details and create
6. Review and approve the hero profile
7. User can now access the GO app fully

**For existing users:**
1. User already exists with `role: 'customer'`
2. Open this admin page
3. Click "➕ Create Hero Profile"
4. Enter their email
5. System will update role to `hero` and create profile
6. Review and approve

### Technical Details

- **No server required** - runs entirely in the browser
- **Direct Supabase connection** - uses Supabase JS client
- **Real-time updates** - refresh to see latest data
- **Responsive design** - works on desktop and mobile

### Security Note

This is a temporary admin tool for development. For production:
- Move to the ERP/Admin Portal
- Add authentication
- Implement role-based access control
- Add audit logging

### Future Enhancements

- [ ] Email notifications to heroes on approval/rejection
- [ ] Bulk approval actions
- [ ] Document upload for verification
- [ ] Hero profile editing
- [ ] Activity logs
- [ ] Advanced filtering and search

---

## 2. Job Assignment Dashboard (`job-assignment.html`)

A drag-and-drop interface for assigning service providers (heroes) to open bookings.

### Features

✅ **Visual Job Management**
- See all open bookings (requested/confirmed status)
- Drag-and-drop jobs onto heroes to assign
- Real-time stats (unassigned jobs, assigned jobs, available heroes)
- Auto-refresh every 30 seconds

✅ **Hero Assignment**
- View all verified, active heroes
- See hero ratings and stats
- Assign/unassign heroes with one action
- Automatic status updates

✅ **Job Details**
- Service name and variant
- Scheduled date and time
- Location and pricing
- Current assignment status

### How to Use

1. **Open the dashboard**
   ```bash
   open admin-tools/job-assignment.html
   ```
   Or simply double-click the `job-assignment.html` file

2. **Assign heroes to jobs**
   - Drag a job card from the left panel
   - Drop it onto a hero card in the right panel
   - Job status automatically updates to "confirmed"
   - Hero is assigned to the booking

3. **Unassign heroes**
   - Click "Unassign" button on any assigned job
   - Job status reverts to "requested"
   - Hero assignment is removed

### Workflow

**For new bookings:**
1. Customer creates booking in main app
2. Booking appears in "Open Jobs" with "Unassigned" status
3. Admin drags job onto appropriate hero
4. Booking status changes to "confirmed"
5. Customer sees hero assignment in their booking status

**For reassignment:**
1. Click "Unassign" on current assignment
2. Drag job to different hero
3. New hero is assigned

### Technical Details

- **No server required** - runs entirely in the browser
- **Direct Supabase connection** - uses Supabase JS client
- **Real-time updates** - auto-refreshes every 30 seconds
- **Drag-and-drop interface** - HTML5 drag and drop API
- **Responsive design** - works on desktop and tablets

### Security Note

This is a temporary admin tool for development. For production:
- Move to the ERP/Admin Portal
- Add authentication
- Implement role-based access control
- Add audit logging
- Add notifications to heroes and customers

### Future Enhancements

- [ ] Filter jobs by date, location, service type
- [ ] Search functionality for jobs and heroes
- [ ] Bulk assignment actions
- [ ] Hero availability calendar
- [ ] Automatic assignment suggestions based on location/skills
- [ ] Email/SMS notifications on assignment
- [ ] Job priority management
- [ ] Hero workload visualization
