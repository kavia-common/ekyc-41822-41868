-- 002_indexes.sql
-- Add indexes to speed up frequent queries

-- Users
CREATE INDEX IF NOT EXISTS idx_users_email ON users (email);

-- KYC cases
CREATE INDEX IF NOT EXISTS idx_kyc_cases_user ON kyc_cases (user_id);
CREATE INDEX IF NOT EXISTS idx_kyc_cases_status ON kyc_cases (status);
CREATE INDEX IF NOT EXISTS idx_kyc_cases_reviewed_by ON kyc_cases (reviewed_by);
CREATE INDEX IF NOT EXISTS idx_kyc_cases_created_at ON kyc_cases (created_at);

-- Documents
CREATE INDEX IF NOT EXISTS idx_documents_case ON documents (kyc_case_id);
CREATE INDEX IF NOT EXISTS idx_documents_user ON documents (user_id);
CREATE INDEX IF NOT EXISTS idx_documents_type ON documents (doc_type);

-- Audit logs
CREATE INDEX IF NOT EXISTS idx_audit_logs_actor ON audit_logs (actor_user_id);
CREATE INDEX IF NOT EXISTS idx_audit_logs_created_at ON audit_logs (created_at);
CREATE INDEX IF NOT EXISTS idx_audit_logs_target ON audit_logs (target_type, target_id);
