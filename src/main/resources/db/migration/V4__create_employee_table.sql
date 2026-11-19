
-- V3: Create Employee table

CREATE TABLE employee (
                          id UUID PRIMARY KEY,
                          organization_id UUID NOT NULL,
                          employee_code VARCHAR(50) NOT NULL,
                          first_name VARCHAR(100) NOT NULL,
                          last_name VARCHAR(100) NOT NULL,
                          email VARCHAR(255) NOT NULL,
                          department VARCHAR(100),
                          default_office_id UUID,
                          status VARCHAR(30) NOT NULL DEFAULT 'ACTIVE',
                          created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
                          updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

                          CONSTRAINT fk_employee_organization
                              FOREIGN KEY (organization_id)
                                  REFERENCES organization(id),

                          CONSTRAINT fk_employee_default_office
                              FOREIGN KEY (default_office_id)
                                  REFERENCES office(id),

                          CONSTRAINT uk_employee_code_per_organization
                              UNIQUE (organization_id, employee_code),

                          CONSTRAINT uk_employee_email_per_organization
                              UNIQUE (organization_id, email),

                          CONSTRAINT chk_employee_status
                              CHECK (status IN ('ACTIVE', 'INACTIVE'))
);

-- Indexes
CREATE INDEX idx_employee_organization_id
    ON employee(organization_id);

CREATE INDEX idx_employee_default_office_id
    ON employee(default_office_id);
