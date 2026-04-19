-- Add legal acceptance tracking fields to profiles table
-- These fields record when users accept privacy policy, terms, and contractor agreement

ALTER TABLE public.profiles
ADD COLUMN IF NOT EXISTS privacy_policy_accepted_at TIMESTAMPTZ,
ADD COLUMN IF NOT EXISTS terms_accepted_at TIMESTAMPTZ,
ADD COLUMN IF NOT EXISTS contractor_agreement_accepted_at TIMESTAMPTZ;

-- Add indexes for querying users by acceptance status
CREATE INDEX IF NOT EXISTS idx_profiles_privacy_accepted ON public.profiles(privacy_policy_accepted_at);
CREATE INDEX IF NOT EXISTS idx_profiles_terms_accepted ON public.profiles(terms_accepted_at);
CREATE INDEX IF NOT EXISTS idx_profiles_contractor_agreement_accepted ON public.profiles(contractor_agreement_accepted_at);

-- Add comment for documentation
COMMENT ON COLUMN public.profiles.privacy_policy_accepted_at IS 'Timestamp when user accepted the privacy policy';
COMMENT ON COLUMN public.profiles.terms_accepted_at IS 'Timestamp when user accepted the terms and conditions';
COMMENT ON COLUMN public.profiles.contractor_agreement_accepted_at IS 'Timestamp when hero accepted the contractor agreement (heroes only)';
