CREATE TABLE Student (
                         id INT PRIMARY KEY AUTO_INCREMENT,
                         name VARCHAR(255) NOT NULL,
                         age INT NOT NULL,
                         gender VARCHAR(10) NOT NULL,
                         address VARCHAR(255) NOT NULL,
                         phone VARCHAR(15) NOT NULL
);

INSERT INTO Student (name, age, gender, address, phone)
VALUES ('John Doe', 22, 'Male', '123 Main St, New York, NY', '123-456-7890');

INSERT INTO Student (name, age, gender, address, phone)
VALUES ('Jane Smith', 21, 'Female', '456 Oak St, Los Angeles, CA', '987-654-3210');

INSERT INTO Student (name, age, gender, address, phone)
VALUES ('Alice Johnson', 23, 'Female', '789 Pine St, Chicago, IL', '456-789-0123');

INSERT INTO Student (name, age, gender, address, phone)
VALUES ('Bob Brown', 20, 'Male', '321 Elm St, Houston, TX', '321-654-0987');

INSERT INTO Student (name, age, gender, address, phone)
VALUES ('Charlie Wilson', 25, 'Male', '567 Maple St, San Francisco, CA', '654-321-6789');

INSERT INTO Student (name, age, gender, address, phone)
VALUES ('Emily Davis', 24, 'Female', '890 Birch St, Miami, FL', '987-123-4567');

INSERT INTO Student (name, age, gender, address, phone)
VALUES ('David Lee', 22, 'Male', '234 Cedar St, Seattle, WA', '456-987-1230');

INSERT INTO Student (name, age, gender, address, phone)
VALUES ('Sophia Martinez', 21, 'Female', '678 Redwood St, Boston, MA', '789-456-3210');

INSERT INTO Student (name, age, gender, address, phone)
VALUES ('Liam Harris', 23, 'Male', '135 Spruce St, Denver, CO', '321-987-6543');

INSERT INTO Student (name, age, gender, address, phone)
VALUES ('Olivia White', 20, 'Female', '246 Walnut St, Phoenix, AZ', '654-789-0123');
