-- Insert Data into Passenger Dimension

CREATE SEQUENCE passenger_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

INSERT INTO passenger_dim 
(passenger_key,passenger_id, passenger_name, phone)
SELECT passenger_seq.NEXTVAL,employee_id, first_name, phone_number
FROM HR.EMPLOYEES;

INSERT INTO passenger_dim 
(passenger_key,address)
SELECT passenger_seq.NEXTVAL,street_address
FROM hr.locations;

-- Insert Data into Date Dimension

CREATE SEQUENCE date_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

INSERT INTO date_dim (date_key, days, months, years)
SELECT date_seq.NEXTVAL, EXTRACT(DAY FROM HR.EMPLOYEES.hire_date),  EXTRACT(MONTH FROM HR.EMPLOYEES.hire_date),  EXTRACT(YEAR FROM HR.EMPLOYEES.hire_date)
FROM HR.EMPLOYEES;

DECLARE

BEGIN

    FOR i in 1 .. 107
    LOOP
        UPDATE date_dim
        SET MINITUE = TRUNC(dbms_random.value(0,59),0)
        WHERE date_key = i;
        
        UPDATE date_dim
        SET hours = TRUNC(dbms_random.value(0,24),0)
        WHERE date_key = i;
        
        UPDATE date_dim
        SET quarter = TRUNC(dbms_random.value(1,4),0)
        WHERE date_key = i;
        
    END LOOP;

END;


-- Insert Data into Flight Dimension

CREATE SEQUENCE flight_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
 CREATE SEQUENCE flight_idl_seq
 START WITH     10
 INCREMENT BY   15
 NOCACHE
 NOCYCLE;

INSERT INTO flight_dim
(flight_key, flight_id, comany_name, depature_date, arraival_date)
SELECT flight_seq.NEXTVAL, HR.DEPARTMENTS.department_id, HR.DEPARTMENTS.department_name, hr.employees.hire_date, ADD_MONTHS(hr.employees.hire_date,2)
FROM hr.employees JOIN HR.DEPARTMENTS
ON hr.employees.department_id = HR.DEPARTMENTS.department_id;


DECLARE

    f NUMBER :=128;

BEGIN

    FOR i in 107 .. 212
    LOOP
    
        UPDATE flight_dim
        SET flight_id = flight_idl_seq.NEXTVAL
        WHERE flight_key = i;
        
        UPDATE flight_dim
        SET actual_price = (SELECT salary FROM HR.EMPLOYEES WHERE employee_id = f)
        WHERE flight_key = i;
        f :=f+1;
        
    END LOOP;
        
    FOR i in 186 .. 212
    LOOP
        UPDATE flight_dim
        SET actual_price = (SELECT salary FROM HR.EMPLOYEES WHERE employee_id = f)
        WHERE flight_key = i;
        f :=f+1;
          
    END LOOP;
    
END;


-- Insert Data into Hotel Dimension

CREATE SEQUENCE hotel_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

INSERT INTO hotel_dim
(hotel_key, hotel_id, hotel_name, hotel_location)
SELECT hotel_seq.NEXTVAL, LOCATION_ID, STATE_PROVINCE, STREET_ADDRESS
FROM HR.LOCATIONS;

-- Insert Data into Passenger Dimension

DECLARE

    f NUMBER :=1000;

BEGIN

    FOR i in 236 .. 321
    LOOP
        UPDATE passenger_dim
        SET address = (SELECT street_address FROM HR.LOCATIONS WHERE location_id = f)
        WHERE passenger_key = i;
        f :=f+100;
        
    END LOOP;
    
    FOR i in 259 .. 321
    LOOP
        UPDATE passenger_dim
        SET address = (SELECT street_address FROM HR.LOCATIONS WHERE location_id = f)
        WHERE passenger_key = i;
        f :=f+100;
        
    END LOOP;
    
    FOR i in 282 .. 321
    LOOP
        UPDATE passenger_dim
        SET address = (SELECT street_address FROM HR.LOCATIONS WHERE location_id = f)
        WHERE passenger_key = i;
        f :=f+100;
    END LOOP;
    
    FOR i in 305 .. 321
    LOOP
        UPDATE passenger_dim
        SET address = (SELECT street_address FROM HR.LOCATIONS WHERE location_id = f)
        WHERE passenger_key = i;
        f :=f+100;
    END LOOP;
    
    FOR i in 216 .. 321
    LOOP
        UPDATE passenger_dim
        SET total_miles = dbms_random.value(2500,100000)
        WHERE passenger_key = i;

    END LOOP;
    
    FOR i in 216 .. 321
    LOOP
        UPDATE passenger_dim
        SET sub_stat =  (CASE round(dbms_random.value(1,3)) 
            WHEN 1 THEN 'gold' 
            WHEN 2 THEN 'titanium' 
            WHEN 3 THEN 'platinum'
       END)
       
        WHERE passenger_key = i;

    END LOOP;

END;

-- Insert Data into Flight Dimension

DECLARE

    f NUMBER :=1000;

BEGIN

    FOR i in 107 .. 212
    LOOP
        UPDATE flight_dim
        SET total_passenger_count = TRUNC(dbms_random.value(50,300),0)
        WHERE flight_key = i;
        
        UPDATE flight_dim
        SET flight_miles = dbms_random.value(1500,10000)
        WHERE flight_key = i;
        
        UPDATE flight_dim
        SET DEPATURE_AIRPORT = (SELECT city FROM HR.LOCATIONS WHERE location_id = f)
        WHERE flight_key = i;
        f :=f+100;

    END LOOP;
    
    FOR i in 130 .. 212
    LOOP
        UPDATE flight_dim
        SET DEPATURE_AIRPORT = (SELECT city FROM HR.LOCATIONS WHERE location_id = f)
        WHERE flight_key = i;
        f :=f+100;
    END LOOP;
    
    FOR i in 153 .. 212
    LOOP
        UPDATE flight_dim
        SET DEPATURE_AIRPORT = (SELECT city FROM HR.LOCATIONS WHERE location_id = f)
        WHERE flight_key = i;
        f :=f+100;
    END LOOP;
    
    FOR i in 176 .. 212
    LOOP
        UPDATE flight_dim
        SET DEPATURE_AIRPORT = (SELECT city FROM HR.LOCATIONS WHERE location_id = f)
        WHERE flight_key = i;
        f :=f+100;
    END LOOP;
    
    FOR i in 199 .. 212
    LOOP
        UPDATE flight_dim
        SET DEPATURE_AIRPORT = (SELECT city FROM HR.LOCATIONS WHERE location_id = f)
        WHERE flight_key = i;
        f :=f+100;
    END LOOP;
    
    UPDATE flight_dim
    SET comany_name = 'Aegean Airlines' 
    WHERE comany_name = 'Administration';
    
    UPDATE flight_dim
    SET comany_name = 'Hawaiian Airlines' 
    WHERE comany_name = 'Marketing';
    
    UPDATE flight_dim
    SET comany_name = 'American Airlines' 
    WHERE comany_name = 'Purchasing';
    
    UPDATE flight_dim
    SET comany_name = 'Emirates' 
    WHERE comany_name = 'Human Resources';

    UPDATE flight_dim
    SET comany_name = 'Transavia Airlines' 
    WHERE comany_name = 'IT';

    UPDATE flight_dim
    SET comany_name = 'Lion Airlines' 
    WHERE comany_name = 'Public Relations';

    UPDATE flight_dim
    SET comany_name = 'Sunclass Airlines' 
    WHERE comany_name = 'Sales';

    UPDATE flight_dim
    SET comany_name = 'tigerair Australia' 
    WHERE comany_name = 'Executive';

    UPDATE flight_dim
    SET comany_name = 'Japan Airlines'
    WHERE comany_name = 'Finance';

    UPDATE flight_dim
    SET comany_name = 'Nordwind Airlines'
    WHERE comany_name = 'Accounting';

END;

-- insert Data into Customer Services Dimension

CREATE SEQUENCE emp_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

INSERT INTO CUTOMER_SERVICES_DIM 
(employee_key,employee_id, employee_name, office_number)
SELECT emp_seq.NEXTVAL,employee_id, last_name, job_id
FROM HR.EMPLOYEES;


-- insert Data into Interaction Dimension

CREATE SEQUENCE inter_seq
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

INSERT INTO INTERATION_DIM
(INTERACTION_KEY,INTERACTION_ID)
SELECT inter_seq.NEXTVAL,DEPARTMENT_ID
FROM HR.DEPARTMENTS;

DECLARE

BEGIN

    FOR i in 1 .. 27
    LOOP
        UPDATE INTERATION_DIM
        SET INTERACTION_TIME =  (CASE round(dbms_random.value(1,3)) 
            WHEN 1 THEN 'before flight' 
            WHEN 2 THEN 'within flight' 
            WHEN 3 THEN 'after flight'
                                                END)
       
        WHERE INTERACTION_KEY = i;
        
        UPDATE INTERATION_DIM
        SET INTERACTION_TYPE =  (CASE round(dbms_random.value(1,3)) 
            WHEN 1 THEN 'feedback' 
            WHEN 2 THEN 'complaint' 
            WHEN 3 THEN 'inquiry'
                                                  END)
       
        WHERE INTERACTION_KEY = i;
        
        UPDATE INTERATION_DIM
        SET DISCRIPTION = DBMS_RANDOM.string('a',35)
        WHERE INTERACTION_KEY = i;

    END LOOP;

END;

-- Insert Date into Reservation Fact

CREATE SEQUENCE reserv_seq
 START WITH     1001
 INCREMENT BY   100
 NOCACHE
 NOCYCLE;

INSERT INTO RESERVATION_FACT
(RESERVATION_KEY, PASSENGER_KEY)
SELECT reserv_seq.NEXTVAL, passenger_key
FROM passenger_dim


DECLARE

    f NUMBER :=107;
    v_sub VARCHAR(250);
    v_price NUMBER;
    v_discount NUMBER;

    CURSOR Cur IS
       SELECT RESERVATION_KEY, PASSENGER_KEY, DISCOUNT
        from RESERVATION_FACT
        FOR UPDATE OF DISCOUNT;
        
    CURSOR Cur2 IS
       SELECT RESERVATION_KEY, flight_key , total_price, discount
        from RESERVATION_FACT
        FOR UPDATE OF total_price;
    
    CURSOR Cur3 IS
       SELECT flight_key , total_price, seat_number
        from RESERVATION_FACT
        FOR UPDATE OF seat_number;
        


BEGIN

    FOR i in 216 .. 321
    LOOP
        UPDATE RESERVATION_FACT
        SET FLIGHT_KEY = (SELECT flight_key
                                    FROM flight_dim
                                    WHERE flight_key = f)
       WHERE PASSENGER_KEY = i;
       
       f := f+1;
       
       UPDATE RESERVATION_FACT
       SET RESERVATION_CHANNEL_KEY = TRUNC(dbms_random.value(1,9),0);
       
       UPDATE RESERVATION_FACT
       SET class_key = TRUNC(dbms_random.value(1,3),0);
       
       UPDATE RESERVATION_FACT
       SET FARE_BASE_KEY = TRUNC(dbms_random.value(1,6),0);
       
       UPDATE RESERVATION_FACT
       SET date_key = TRUNC(dbms_random.value(1,107),0);
       
    END LOOP;
    
    FOR Rec IN Cur
    LOOP
        SELECT sub_stat
        INTO v_sub
        FROM passenger_dim
        WHERE passenger_key = Rec.passenger_key;
        
        IF(v_sub = 'gold') THEN
            UPDATE RESERVATION_FACT
            SET discount = 0.10
            WHERE CURRENT OF Cur;
            
        ELSIF(v_sub = 'platinum') THEN
            UPDATE RESERVATION_FACT
            SET discount = 0.15
            WHERE CURRENT OF Cur;
            
        ELSIF(v_sub = 'titanium') THEN
            UPDATE RESERVATION_FACT
            SET discount = 0.25
            WHERE CURRENT OF Cur;
            
        END IF;
            
    END LOOP;  
    
    FOR Rec IN Cur2
    
    LOOP
    
        SELECT actual_price
        INTO v_price
        FROM flight_dim
        WHERE flight_key = Rec.flight_key;
        
        UPDATE RESERVATION_FACT
        SET total_price = v_price - (v_price*Rec.discount)
        WHERE CURRENT OF Cur2;
        
    END LOOP;
    
    FOR Rec IN Cur3
    
    LOOP
    
        IF (Rec.flight_key IS IN (SELECT flight_key
                                           FROM flight_dim))
        THEN
        
            UPDATE RESERVATION_FACT
            SET seat_number = TRUNC(dbms_random.value(1,300),0)
            WHERE CURRENT OF Cur3;
            
        END IF;
                 
    END LOOP;                 
                              
END;

-- Insert Data into Customer Care Fact

CREATE SEQUENCE case_seq
 START WITH     1000
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

INSERT INTO CUSTOMER_CARE_FACT
(CASE_KEY, PASSENGER_KEY)
SELECT case_seq.NEXTVAL, passenger_key
FROM passenger_dim;

DECLARE

    v_f NUMBER :=107;
    v_i NUMBER :=1;
    v_e NUMBER :=1;
    
    v_type VARCHAR(250);
    v_time VARCHAR(250);
    
    CURSOR Cur IS
       SELECT CASE_KEY ,PROBLEM_SEVERITY, INTERACTION_KEY
        from CUSTOMER_CARE_FACT
        FOR UPDATE OF PROBLEM_SEVERITY;

BEGIN

    FOR i in 1000 .. 1211
    LOOP
    
        UPDATE CUSTOMER_CARE_FACT
        SET FLIGHT_KEY = (SELECT flight_key FROM flight_dim WHERE flight_key = v_f)
        WHERE CASE_KEY = i;
        
        UPDATE CUSTOMER_CARE_FACT
        SET HOTEL_KEY = TRUNC(dbms_random.value(2,25),0)
        WHERE CASE_KEY = i;
        
        UPDATE CUSTOMER_CARE_FACT
        SET date_key = TRUNC(dbms_random.value(1,107),0)
        WHERE CASE_KEY = i;
        
        UPDATE CUSTOMER_CARE_FACT
        SET interaction_key = (SELECT INTERACTION_KEY FROM INTERATION_DIM WHERE INTERACTION_KEY = v_i)
        WHERE CASE_KEY = i;
        
        UPDATE CUSTOMER_CARE_FACT
        SET employee_key = (SELECT EMPLOYEE_KEY FROM CUTOMER_SERVICES_DIM WHERE EMPLOYEE_KEY = v_e)
        WHERE CASE_KEY = i;
        
        v_f := v_f+1;
        v_i := v_i+1;
        v_e := v_e+1;
        
    END LOOP;  
    
    FOR i in 1000 .. 1026
    LOOP

        UPDATE CUSTOMER_CARE_FACT
        SET employee_key = TRUNC(dbms_random.value(1,107),0)
        WHERE CASE_KEY = i;

    END LOOP;  
    
    FOR Rec IN Cur
    
    LOOP
    
        SELECT INTERACTION_TIME, INTERACTION_TYPE
        INTO v_time, v_type
        FROM INTERATION_DIM
        WHERE INTERACTION_KEY = Rec.INTERACTION_KEY;
    

        IF (v_time = 'within flight' AND v_type = 'complaint')
        THEN
        
            UPDATE CUSTOMER_CARE_FACT
            SET PROBLEM_SEVERITY = 1
            WHERE CURRENT OF Cur;
            
        ELSIF (v_time = 'before flight' AND v_type = 'complaint')
        THEN
            UPDATE CUSTOMER_CARE_FACT
            SET PROBLEM_SEVERITY = 2
            WHERE CURRENT OF Cur;
        
        ELSIF (v_time = 'after flight' AND v_type = 'complaint')
        THEN
            UPDATE CUSTOMER_CARE_FACT
            SET PROBLEM_SEVERITY = 3
            WHERE CURRENT OF Cur;
               
        ELSIF (v_time = 'within flight' AND v_type = 'inquiry')
        THEN
            UPDATE CUSTOMER_CARE_FACT
            SET PROBLEM_SEVERITY = 4
            WHERE CURRENT OF Cur;
           
        ELSIF (v_time = 'within flight' AND v_type = 'feedback')
        THEN
            UPDATE CUSTOMER_CARE_FACT
            SET PROBLEM_SEVERITY = 5
            WHERE CURRENT OF Cur;
            
            
        ELSIF (v_time = 'before flight' AND v_type = 'inquiry')
        THEN
            UPDATE CUSTOMER_CARE_FACT
            SET PROBLEM_SEVERITY = 6
            WHERE CURRENT OF Cur;
             
        ELSIF (v_time = 'before flight' AND v_type = 'feedback')
        THEN
            UPDATE CUSTOMER_CARE_FACT
            SET PROBLEM_SEVERITY = 7
            WHERE CURRENT OF Cur;
             
        ELSIF (v_time = 'after flight' AND v_type = 'feedback')
        THEN
            UPDATE CUSTOMER_CARE_FACT
            SET PROBLEM_SEVERITY = 8
            WHERE CURRENT OF Cur;

        ELSIF (v_time = 'after flight' AND v_type = 'inquiry')
        THEN
            UPDATE CUSTOMER_CARE_FACT
            SET PROBLEM_SEVERITY = 9
            WHERE CURRENT OF Cur;

        END IF;
                 
    END LOOP;
                           
END;

-- Insert Data into Transit Hotel Fact

INSERT INTO TRANSIT_HOTEL_FACT
(FLIGHT_KEY)
SELECT flight_key FROM flight_dim;

DECLARE

    v_f NUMBER :=216;
    v_date DATE;
    
    CURSOR Cur IS
       SELECT FLIGHT_KEY ,NUMBER_OF_NIGHTS
        from TRANSIT_HOTEL_FACT
        FOR UPDATE OF NUMBER_OF_NIGHTS;
    
    

BEGIN

    FOR i in 107 .. 212
    LOOP
    
        UPDATE TRANSIT_HOTEL_FACT
        SET PASSENGER_KEY = (SELECT passenger_key FROM passenger_dim WHERE passenger_key = v_f)
        WHERE flight_key = i;
        
        UPDATE TRANSIT_HOTEL_FACT
        SET RESERVATION_CHANNEL_KEY = TRUNC(dbms_random.value(1,9),0)
        WHERE flight_key = i;
        
        UPDATE TRANSIT_HOTEL_FACT
        SET HOTEL_KEY = TRUNC(dbms_random.value(2,25),0)
        WHERE flight_key = i;
        
        UPDATE TRANSIT_HOTEL_FACT
        SET date_key = TRUNC(dbms_random.value(1,107),0)
        WHERE flight_key = i;
        
        UPDATE TRANSIT_HOTEL_FACT
        SET TICKET_NUMBER = TRUNC(dbms_random.value(20000,90000),0)
        WHERE flight_key = i;

        v_f := v_f+1;

    END LOOP;   
    
    FOR Rec IN Cur
    
    LOOP
    
        SELECT arraival_date
        INTO v_date
        FROM flight_dim
        WHERE flight_key = Rec.flight_key;

            UPDATE TRANSIT_HOTEL_FACT
            SET NUMBER_OF_NIGHTS = TRUNC(SYSDATE - v_date ,0)
            WHERE CURRENT OF Cur;
    
    END LOOP;                
                              
END;
