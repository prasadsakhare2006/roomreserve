-- ============================================
-- RoomReserve - V2
-- Create Organization Structure Tables
-- ============================================

-- 1. Organization
CREATE TABLE organization (
                              id UUID PRIMARY KEY,
                              name VARCHAR(150) NOT NULL,
                              status VARCHAR(30) NOT NULL DEFAULT 'ACTIVE',
                              created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
                              updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

                              CONSTRAINT uk_organization_name
                                  UNIQUE (name),

                              CONSTRAINT chk_organization_status
                                  CHECK (status IN ('ACTIVE', 'INACTIVE'))
);

-- 2. Office
CREATE TABLE office (
                        id UUID PRIMARY KEY,
                        organization_id UUID NOT NULL,
                        name VARCHAR(150) NOT NULL,
                        address VARCHAR(500),
                        timezone VARCHAR(100) NOT NULL,
                        status VARCHAR(30) NOT NULL DEFAULT 'ACTIVE',
                        created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

                        CONSTRAINT fk_office_organization
                            FOREIGN KEY (organization_id)
                                REFERENCES organization(id),

                        CONSTRAINT uk_office_name_per_organization
                            UNIQUE (organization_id, name),

                        CONSTRAINT chk_office_status
                            CHECK (status IN ('ACTIVE', 'INACTIVE'))
);

-- 3. Building
CREATE TABLE building (
                          id UUID PRIMARY KEY,
                          office_id UUID NOT NULL,
                          name VARCHAR(150) NOT NULL,
                          code VARCHAR(50) NOT NULL,
                          status VARCHAR(30) NOT NULL DEFAULT 'ACTIVE',
                          created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

                          CONSTRAINT fk_building_office
                              FOREIGN KEY (office_id)
                                  REFERENCES office(id),

                          CONSTRAINT uk_building_code_per_office
                              UNIQUE (office_id, code),

                          CONSTRAINT chk_building_status
                              CHECK (status IN ('ACTIVE', 'INACTIVE'))
);

-- 4. Floor
CREATE TABLE floor (
                       id UUID PRIMARY KEY,
                       building_id UUID NOT NULL,
                       floor_number VARCHAR(20) NOT NULL,
                       name VARCHAR(100),
                       status VARCHAR(30) NOT NULL DEFAULT 'ACTIVE',

                       CONSTRAINT fk_floor_building
                           FOREIGN KEY (building_id)
                               REFERENCES building(id),

                       CONSTRAINT uk_floor_per_building
                           UNIQUE (building_id, floor_number),

                       CONSTRAINT chk_floor_status
                           CHECK (status IN ('ACTIVE', 'INACTIVE'))
);

-- ============================================
-- Indexes for foreign key lookup performance
-- ============================================

CREATE INDEX idx_office_organization_id
    ON office(organization_id);

CREATE INDEX idx_building_office_id
    ON building(office_id);

CREATE INDEX idx_floor_building_id
    ON floor(building_id);
