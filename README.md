# README

# Festify Backend

## Abstract
The backend of Festify provides the data and APIs necessary for the frontend to function. It serves festival schedules, show details, and attendee information through RESTful endpoints.

## Contributor
Danielle Cardona - [LinkedIn](https://www.linkedin.com/in/danielle-cardona-se/), [GitHub](https://github.com/dcardona23)

## Planning/Wireframing
![Back End MVP](images/beMVP.png)
![BE schema and endpoints](images/schema.png)

## Setup Instructions

1. Clone the repository locally

2. Navigate to the project directory
    - cd festify

3. Install dependencies 
    - bundle install

4. Set up the database
    - rails db:{drop,create,migrate,seed}

5. Start the server
    - rails s -p 5000

6. Access the API at http:localhost:5000/api/v1

## Summary of Technologies
- Ruby on Rails: Backend framework for building the API.
- PostgreSQL: Database for storing festival schedules and related data.
- Rspec: Testing framework for unit and integration tests.
- Faker and FactoryBot: For generating seed data.
- JSON: Data format for API responses.

## API Endpoints
- GET /api/v1/schedules: Retrieve all festival schedules.
- GET /api/v1/schedules/:id: Retrieve details of a specific schedule.
- GET /api/v1/attendees: Retrieve all attendees
- GET /api/v1/attendees/:attendee_id/schedules: Retrieve a specific attendee's schedule
- DELETE /api/v1/schedules/:schedule_id/shows/:show_id: Delete a show from a schedule

## Sample Requests/Responses

### GET /api/v1/schedules
```json
{
    "data": [
        {
            "id": 84,
            "type": "schedule",
            "attributes": {
                "name": "Global Rock",
                "description": "Experience the best of ballads with unforgettable performances.",
                "shows": [
                    {
                        "id": "331",
                        "artist_name": "Ed Sheeran",
                        "genre": "Hip Hop",
                        "location": "VIP Lounge",
                        "start_time": "2025-03-15T19:30:00.000Z",
                        "end_time": "2025-03-15T20:30:00.000Z"
                    },
                    {
                        "id": "340",
                        "artist_name": "Chris Isaak",
                        "genre": "Latin",
                        "location": "Amphitheater Stage",
                        "start_time": "2025-03-17T02:00:00.000Z",
                        "end_time": "2025-03-17T03:00:00.000Z"
                    }
                ]
            },
            "other_schedule_attendees": [
                {
                    "attendee_id": 416,
                    "attendee_name": "Avery Heaney",
                    "attendee_email": "abe.streich@grady-keebler.example"
                },
                {
                    "attendee_id": 425,
                    "attendee_name": "Yelena Ledner",
                    "attendee_email": "kam@jenkins-reynolds.test"
                },
            ]
        },
    ]
}
```
### DELETE api/v1/schedules/:schedule_id/shows/show_id
```json
{
    "data": {
        "id": 88,
        "type": "schedule",
        "attributes": {
            "name": "Acoustic Bliss",
            "description": "Experience the best of EDM with unforgettable performances.",
            "shows": [
                {
                    "id": "340",
                    "artist_name": "Chris Isaak",
                    "genre": "Latin",
                    "location": "Amphitheater Stage",
                    "start_time": "2025-03-17T02:00:00.000Z",
                    "end_time": "2025-03-17T03:00:00.000Z"
                },
                {
                    "id": "341",
                    "artist_name": "George Michael",
                    "genre": "Soul",
                    "location": "VIP Lounge",
                    "start_time": "2025-03-16T04:30:00.000Z",
                    "end_time": "2025-03-16T05:00:00.000Z"
                },
                {
                    "id": "344",
                    "artist_name": "Pulp",
                    "genre": "Latin",
                    "location": "VIP Lounge",
                    "start_time": "2025-03-16T20:00:00.000Z",
                    "end_time": "2025-03-16T21:30:00.000Z"
                }
            ]
        },
        "other_schedule_attendees": [
            {
                "attendee_id": 414,
                "attendee_name": "Mariela Jenkins",
                "attendee_email": "shelli@hodkiewicz-padberg.example"
            },
        ]
    }
}
```

## Goals
- Store and manage schedules, shows, and attendees efficiently using a relational database.
- Provide endpoints to retrieve detailed information about schedules, shows, and attendees dynamically.
- Build a robust RESTful API to serve the frontend application with necessary data.
- Ensure all endpoints are well-documented and follow industry standards.
- Implement comprehensive error handling to provide meaningful feedback to the frontend in case of failures.

## Testing
This project uses RSpec for testing models and controllers and SimpleCov for test coverage. 

### Running Tests
- Ensure all dependencies are installed
- Run the test suite:
    - bundle exec rspec spec/
- View coverage report:
    - open coverage/index.html
