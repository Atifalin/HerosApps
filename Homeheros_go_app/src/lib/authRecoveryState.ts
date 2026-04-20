/**
 * Shared module-level flag indicating a password recovery flow is active.
 * When true, AuthContext should NOT elevate the user to "signed in" state
 * even if Supabase creates a session, so the AuthNavigator stack (where
 * ResetPassword lives) stays active.
 */
let recovering = false;

export const setRecoveryActive = (value: boolean) => {
  recovering = value;
  console.log('🔐 Recovery state set to:', value);
};

export const isRecoveryActive = () => recovering;
