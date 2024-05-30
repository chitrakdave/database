Data Scraping/Data Import:

For mock data insert into the database, we used an online tool for data generator
https://www.mockaroo.com/ which will generate data based on parameters we provide such
as numeric range, date range, custom list, random address/phone, and custom query
function, etc.

Create Table:

Create tables in the database run the create.sql file .

Data Import:

1. mockaroo.com generates a .csv file, download this file.
2. Import each of the above .csv files using pgadmin’s Data import functionality
3. Enable the header option from the pgadmin Data import UI as mockaroo also includes 
headers in the csv file.
4. Import the data in the same order as stated in the create.sql file to ensure that 
no constraints are violated.
5. While importing data to the table please make sure that you have ticked that header 
button and select data seperator as a comma.

Data Cleaning Queries:

Update Events
	set start_date = end_date,
		end_date = start_date 
where start_date >= end_date

Update Event_shows
	set available_seats = total_seats,
	total_seats = available_seats 
where available_seats >= total_seats

Update Event_shows S
	set show_date = E.start_date
	FROM Events E
where S.show_date < E.start_date and E.event_id = S.event_id

Update Event_shows S
 	set available_seats = total_seats - (select SUM(seats) from Bookings where S.show_id=show_id)
	


