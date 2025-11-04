-- 003_seed_rbac.sql
-- Seed basic RBAC roles and link a default admin if present

-- Upsert roles
INSERT INTO roles (id, name, description)
VALUES
    (gen_random_uuid(), 'admin', 'Full administrative access'),
    (gen_random_uuid(), 'reviewer', 'Can review and decide on KYC cases'),
    (gen_random_uuid(), 'user', 'Standard user who can submit KYC')
ON CONFLICT (name) DO UPDATE
SET description = EXCLUDED.description;

-- Optionally assign admin role to the first user if exists
DO $$
DECLARE
    admin_role_id UUID;
    first_user_id UUID;
BEGIN
    SELECT id INTO admin_role_id FROM roles WHERE name = 'admin';
    SELECT id INTO first_user_id FROM users ORDER BY created_at ASC LIMIT 1;

    IF first_user_id IS NOT NULL AND admin_role_id IS NOT NULL THEN
        INSERT INTO user_roles (user_id, role_id)
        VALUES (first_user_id, admin_role_id)
        ON CONFLICT (user_id, role_id) DO NOTHING;
    END IF;
END$$;
