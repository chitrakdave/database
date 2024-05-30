CREATE TYPE EVENT_TYPE AS ENUM ('Movie', 'Play', 'Concert', 'Stand-up');

CREATE TYPE GENDERS AS ENUM ('Male', 'Female', 'Other', 'Not to Mention');

CREATE TABLE zip_codes (
	zip_code NUMERIC(5, 0) PRIMARY KEY,
	city VARCHAR(50),
	state VARCHAR(50)
);

CREATE TABLE Company (
	company_id SERIAL PRIMARY KEY,
	company_name VARCHAR(50), 
	phone NUMERIC(10, 0),
	email VARCHAR(50) NOT NULL,
	hash_pass VARCHAR(36),
	address VARCHAR(100),
	zip_code NUMERIC(5, 0) REFERENCES zip_codes(zip_code)
);

CREATE TABLE Users (
	user_id SERIAL PRIMARY KEY,
	full_name VARCHAR(50), 
	phone NUMERIC(10, 0),
	email VARCHAR(50) NOT NULL,
	hash_pass VARCHAR(36),
	gender GENDERS,
	dob DATE NOT NULL
);

CREATE TABLE Event_Venues (
	venue_id SERIAL PRIMARY KEY,
	venue_name VARCHAR(50) NOT NULL, 
	address VARCHAR(50),
	zip_code NUMERIC(5, 0) REFERENCES zip_codes(zip_code),
	rating NUMERIC(2,1),
	company_id SERIAL REFERENCES Company(company_id)
);

CREATE TABLE Events (
	event_id SERIAL PRIMARY KEY,
	event_name VARCHAR(100),
	event_type EVENT_TYPE,
	duration INTEGER,
	start_date DATE,
	end_date DATE,
	event_creater SERIAL REFERENCES Users(user_id),
	rating NUMERIC(2,1)
);

CREATE TABLE Event_Shows (
	show_id SERIAL PRIMARY KEY,
	event_id SERIAL REFERENCES Events(event_id),
	event_venue_id  SERIAL REFERENCES Event_Venues(venue_id),
	show_date DATE NOT NULL,
	start_time TIME NOT NULL,
	price INTEGER,
	total_seats INTEGER NOT NULL,
	available_seats INTEGER,
	show_publicly BOOLEAN DEFAULT FALSE
);


CREATE TABLE Event_On_Rent (
	rent_id SERIAL PRIMARY KEY,
	event_id SERIAL REFERENCES Events(event_id),
	rent_price INTEGER,
	rent_duration INTEGER,
	available BOOLEAN DEFAULT FALSE
);

CREATE TABLE Purchase (
	purchase_id SERIAL PRIMARY KEY,
	rent_id SERIAL REFERENCES Event_On_Rent(rent_id),
	user_id SERIAL REFERENCES Users(user_id),
	purchase TIMESTAMP
);

CREATE TABLE Bookings (
	booking_id SERIAL PRIMARY KEY,
	user_id SERIAL REFERENCES Users(user_id),
	show_id SERIAL REFERENCES Event_shows(show_id),
	seats INTEGER
);

CREATE TABLE Event_organizer (
	user_id SERIAL REFERENCES Users(user_id),
	company_id SERIAL REFERENCES Company(company_id),
	show_id SERIAL REFERENCES Event_Shows(show_id)
);

CREATE TABLE Administrator (
	user_id SERIAL REFERENCES Users(user_id)
);