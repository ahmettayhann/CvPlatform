# CV Platform

CV Platform is a web application built with Ruby on Rails that allows users to create, manage, and share their CVs (Resumes) online.

## Features

- Custom user authentication system (without external gems like Devise)
- User profile management with avatar upload
- CV creation and management
- Dynamic CV listing and search functionality
- Responsive design with Tailwind CSS
- Rich text editing for CV descriptions
- API endpoints for CV listing and details
- School information management with nested forms

## Prerequisites

Before you begin, ensure you have the following installed:
- Ruby (version 2.7.0 or later)
- Rails (version 6.1.0 or later)
- Node.js (version 12.0.0 or later)
- Yarn (version 1.22.0 or later)
- PostgreSQL (version 12.0 or later)

## Installation

1. Clone the repository:
   ```
   git clone https://gitlab.com/ahmetayhan/cv_platform.git
   cd cv-platform
   ```

2. Install Ruby dependencies:
   ```
   bundle install
   ```

3. Install JavaScript dependencies:
   ```
   yarn install
   ```

4. Set up the database:
   ```
   rails db:create
   rails db:migrate
   rails db:seed
   ```

5. Set up Active Storage:
   ```
   rails active_storage:install
   rails db:migrate
   ```

## Running the application

1. Start the Rails server:
   ```
   rails server
   ```

2. In a separate terminal, start the Webpacker dev server:
   ```
   ./bin/webpack-dev-server
   ```

3. Visit `http://localhost:3000` in your web browser.

## Key Components

### User Model
- Fields: first_name, last_name, email, gsm (encrypted), country, password_digest, identity_number (encrypted)
- Custom authentication implementation

### Resume Model
- Fields: title, description (rich text), hobbies, active
- Associated with User and School models

### School Model
- Fields: name
- Many-to-many relationship with Resume

### Features
- Home page with CV listing and real-time search using Stimulus and Turbo Frames
- Profile management with avatar upload
- CV management with nested form for school information
- CV viewing page
- API endpoints for CV listing and details

## API Endpoints

1. CV List Endpoint:
   - Returns id, title, and full_name in JSON format
   - Supports search parameter for filtering by title

2. CV Detail Endpoint:
   - Returns all information for a specific CV by id

## API Documentation

## Base URL

All API requests should be made to: `http://your-api-domain.com/api/v1/`

## Authentication

### Sign Up

1. Make a POST request to `/api/v1/sign_up`
2. Include the user details in the request body:
   ```json
   {
     "user": {
       "first_name": "John",
       "last_name": "Doe",
       "email": "john@example.com",
       "password": "your_password",
       "password_confirmation": "your_password",
       "country": "USA",
       "gsm": "+1234567890",
       "identity_number": "1234567890"
     }
   }
   ```
3. The response will include an auth token and user data if registration is successful.

### Sign In

1. Make a POST request to `/api/v1/authenticate`
2. Include your credentials in the request body:
   ```json
   {
     "email": "your.email@example.com",
     "password": "your_password"
   }
   ```
3. The response will include an auth token and user data if authentication is successful.

### Authentication for Subsequent Requests

All subsequent API requests must include the auth token in the Authorization header:

```
Authorization: Bearer YOUR_JWT_TOKEN
```

### Sign Out

1. Make a DELETE request to `/api/v1/sign_out`
2. Include the auth token in the Authorization header
3. A successful sign out will return a 204 No Content status

## Resumes

### List Resumes

1. Make a GET request to `/api/v1/resumes`
2. Optionally, include a search parameter in the query string:
   `/api/v1/resumes?q[title_cont]=developer`
3. The response will include an array of resume objects

### Get Resume Details

1. Make a GET request to `/api/v1/resumes/:id`, replacing `:id` with the actual resume ID
2. The response will include detailed information about the specified resume

## Response Formats

### User Data
```json
{
  "id": 1,
  "first_name": "John",
  "last_name": "Doe",
  "email": "john@example.com",
  "country": "USA",
  "full_name": "John Doe"
}
```

### Resume List Item
```json
{
  "id": 1,
  "title": "Software Developer",
  "user": {
    "id": 1,
    "full_name": "John Doe"
  }
}
```

### Detailed Resume
```json
{
  "id": 1,
  "title": "Software Developer",
  "description": "Experienced developer...",
  "hobbies": "Coding, reading",
  "active": true,
  "user": {
    "id": 1,
    "first_name": "John",
    "last_name": "Doe",
    "email": "john@example.com",
    "country": "USA",
    "full_name": "John Doe"
  },
  "schools": [
    {
      "id": 1,
      "name": "University of Technology",
      "start_date": "2015-09-01",
      "end_date": "2019-06-30"
    }
  ]
}
```

## Error Handling

If an error occurs, the API will return an appropriate HTTP status code and a JSON object containing an error message. For example:

```json
{
  "error": "Resume not found"
}
```

Common status codes:
- 200: Successful request
- 201: Successful creation
- 204: Successful request with no content to return
- 401: Unauthorized
- 404: Resource not found
- 422: Unprocessable entity (validation errors)

## Running tests

To run the test suite (focused on authentication and session management):

```
bundle exec rspec
```

## Troubleshooting

### Assets not loading correctly

If you encounter issues with assets (like Tailwind CSS styles not applying), try:

1. Clearing the asset pipeline cache:
   ```
   rails tmp:clear
   ```

2. Recompiling assets:
   ```
   rails assets:precompile
   ```

3. Restart your Rails server.

### Avatar images not displaying

If user avatars are not showing up:

1. Ensure the `storage` directory exists in your project root:
   ```
   mkdir storage
   ```

2. Check that Active Storage is properly configured in `config/storage.yml` and your environment files.

3. If moving from one environment to another, manually copy the contents of the `storage` directory.