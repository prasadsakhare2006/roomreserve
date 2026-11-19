
-- V2: Create Room and Equipment tables

-- 1. Room
CREATE TABLE room (
                      id UUID PRIMARY KEY,
                      floor_id UUID NOT NULL,
                      name VARCHAR(150) NOT NULL,
                      room_code VARCHAR(50) NOT NULL,
                      capacity INTEGER NOT NULL,
                      status VARCHAR(30) NOT NULL DEFAULT 'ACTIVE',
                      created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
                      updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

                      CONSTRAINT fk_room_floor
                          FOREIGN KEY (floor_id) REFERENCES floor(id),

                      CONSTRAINT uk_room_code_per_floor
                          UNIQUE (floor_id, room_code),

                      CONSTRAINT chk_room_capacity
                          CHECK (capacity > 0),

                      CONSTRAINT chk_room_status
                          CHECK (status IN ('ACTIVE', 'INACTIVE'))
);

-- 2. Equipment
CREATE TABLE equipment (
                           id UUID PRIMARY KEY,
                           name VARCHAR(100) NOT NULL,
                           description VARCHAR(300),

                           CONSTRAINT uk_equipment_name UNIQUE (name)
);

-- 3. Room Equipment (Many-to-Many)
CREATE TABLE room_equipment (
                                room_id UUID NOT NULL,
                                equipment_id UUID NOT NULL,

                                CONSTRAINT pk_room_equipment
                                    PRIMARY KEY (room_id, equipment_id),

                                CONSTRAINT fk_room_equipment_room
                                    FOREIGN KEY (room_id)
                                        REFERENCES room(id)
                                        ON DELETE CASCADE,

                                CONSTRAINT fk_room_equipment_equipment
                                    FOREIGN KEY (equipment_id)
                                        REFERENCES equipment(id)
                                        ON DELETE CASCADE
);

-- Indexes
CREATE INDEX idx_room_floor_id
    ON room(floor_id);

CREATE INDEX idx_room_equipment_equipment_id
    ON room_equipment(equipment_id);
