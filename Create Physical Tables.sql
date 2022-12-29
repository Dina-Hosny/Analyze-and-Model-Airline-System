-- Create Passenger Dimension

CREATE TABLE passenger_dim (
passenger_key NUMBER CONSTRAINT pk_cons PRIMARY KEY,
passenger_id NUMBER CONSTRAINT unq_cons UNIQUE,
passenger_name VARCHAR(250),
address VARCHAR(250),
phone VARCHAR(250),
sub_stat VARCHAR(250),
total_miles NUMBER
);


-- Create Flight Dimension

CREATE TABLE flight_dim(
flight_key NUMBER CONSTRAINT flight_pk_cons PRIMARY KEY,
flight_id NUMBER CONSTRAINT flight_unq_cons UNIQUE,
depature_airport VARCHAR(250),
arraival_airport VARCHAR(250),
comany_name VARCHAR(250),
actual_price NUMBER,
flight_miles NUMBER,
depature_date DATE,
arraival_date DATE,
total_passenger_count NUMBER
);


-- Create Date Dimension

CREATE TABLE date_dim(
date_key NUMBER CONSTRAINT date_pk_cons PRIMARY KEY,
minitue NUMBER,
hours NUMBER,
days NUMBER,
months NUMBER,
quarter NUMBER,
years NUMBER
);

-- Create Class Dimension

CREATE TABLE class_dim(
class_key NUMBER CONSTRAINT class_pk_cons PRIMARY KEY,
class_id NUMBER CONSTRAINT class_unq_cons UNIQUE,
class_type VARCHAR(250)
);

-- Create Reservation Channel Dimension

CREATE TABLE reservation_channel_dim(
channel_key NUMBER CONSTRAINT channel_pk_con PRIMARY KEY,
channel_id NUMBER CONSTRAINT channel_unq_cond UNIQUE,
reservation_channel_type VARCHAR(250),
payment_method VARCHAR(250)
);

-- Create Fare Base Dimension

CREATE TABLE fare_base_dim(
fare_base_key NUMBER CONSTRAINT fare_pk_cons PRIMARY KEY,
fare_base_id NUMBER CONSTRAINT fare_unq_cons UNIQUE,
fare_base_type VARCHAR(250)
);

-- Create Hotel Dimension

CREATE TABLE hotel_dim(
hotel_key NUMBER CONSTRAINT hotel_pk_cons PRIMARY KEY,
hotel_id NUMBER CONSTRAINT hotel_unq_cons UNIQUE,
hotel_name VARCHAR(250),
hotel_location VARCHAR(250)
);

-- Create Customer Services Dimension

CREATE TABLE cutomer_services_dim(
employee_key NUMBER CONSTRAINT emp_pk_cons PRIMARY KEY,
employee_id NUMBER CONSTRAINT emp_unq_cons UNIQUE,
employee_name VARCHAR(250),
office_number VARCHAR(250)
);

-- Create Interaction Dimension

CREATE TABLE interation_dim(
interaction_key NUMBER CONSTRAINT inter_pk_cons PRIMARY KEY,
interaction_id NUMBER CONSTRAINT inter_unq_cons UNIQUE,
interaction_time VARCHAR(250),
interaction_type VARCHAR(250),
discription VARCHAR(250)
);

-- Create Reservation Fact

CREATE TABLE reservation_fact(
reservation_key NUMBER CONSTRAINT res_pk_cons PRIMARY KEY,
passenger_key NUMBER,
flight_key NUMBER,
reservation_channel_key NUMBER,
class_key NUMBER,
fare_base_key NUMBER,
date_key NUMBER,
discount NUMBER,
total_price NUMBER,
seat_number NUMBER
);


ALTER TABLE reservation_fact
ADD(
CONSTRAINT pass_fk_cons FOREIGN KEY(passenger_key) REFERENCES passenger_dim(passenger_key),
CONSTRAINT flight_fk_con FOREIGN KEY(flight_key) REFERENCES flight_dim(flight_key),
CONSTRAINT channel_fk_cons FOREIGN KEY(reservation_channel_key) REFERENCES reservation_channel_dim(channel_key),
CONSTRAINT class_fk_cons FOREIGN KEY(class_key) REFERENCES class_dim(class_key),
CONSTRAINT fare_fk_cons FOREIGN KEY(fare_base_key) REFERENCES fare_base_dim(fare_base_key),
CONSTRAINT date_fk_cons FOREIGN KEY(date_key) REFERENCES date_dim(date_key)
);


-- Create Transit Hotel Fact

CREATE TABLE transit_hotel_fact (
flight_key NUMBER,
passenger_key NUMBER,
reservation_channel_key NUMBER,
hotel_key NUMBER,
date_key NUMBER,
ticket_number NUMBER,
number_of_nights NUMBER
);

ALTER TABLE transit_hotel_fact
ADD(
CONSTRAINT flight_fk_conss FOREIGN KEY(flight_key) REFERENCES flight_dim(flight_key),
CONSTRAINT pass_fk_conss FOREIGN KEY(passenger_key) REFERENCES passenger_dim(passenger_key),
CONSTRAINT rese_fk_conss FOREIGN KEY(reservation_channel_key) REFERENCES reservation_channel_dim(channel_key),
CONSTRAINT hotel_fk_conss FOREIGN KEY(hotel_key) REFERENCES hotel_dim(hotel_key),
CONSTRAINT date_fk_conss FOREIGN KEY(date_key) REFERENCES date_dim(date_key)
);


-- Create Customer Care Fact

CREATE TABLE customer_care_fact(
case_key NUMBER CONSTRAINT case_pk_cons PRIMARY KEY,
passenger_key NUMBER,
flight_key NUMBER,
hotel_key NUMBER,
date_key NUMBER,
interaction_key NUMBER,
employee_key NUMBER,
problem_severity NUMBER
);



ALTER TABLE customer_care_fact
ADD(
CONSTRAINT pass_fk_consss FOREIGN KEY(passenger_key) REFERENCES passenger_dim(passenger_key),
CONSTRAINT flight_fk_consss FOREIGN KEY(flight_key) REFERENCES flight_dim(flight_key),
CONSTRAINT hotel_fk_consss FOREIGN KEY(hotel_key) REFERENCES hotel_dim(hotel_key),
CONSTRAINT date_fk_consss FOREIGN KEY(date_key) REFERENCES date_dim(date_key),
CONSTRAINT inter_fk_consss FOREIGN KEY(interaction_key) REFERENCES interation_dim(interaction_key),
CONSTRAINT emp_fk_consss FOREIGN KEY(employee_key) REFERENCES cutomer_services_dim(employee_key)
);



