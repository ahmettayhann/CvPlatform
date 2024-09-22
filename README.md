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
   git clone https://github.com/yourusername/cv-platform.git
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