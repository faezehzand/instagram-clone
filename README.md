Instagram Clone Project

Overview:

This project is a web-based application inspired by Instagram, built using Ruby on Rails 7, Bootstrap 5, and Turbo Rails. The application allows users to: Create accounts and log in. Post images with captions. Like and comment on posts. Follow/unfollow other users. The project is containerized using Docker for seamless setup and deployment.

Features: User Authentication: Supports public/private user profiles. Post Management: Create, view, like, and comment on posts. User Interaction: Follow/unfollow users to personalize your feed. Responsive Design: Optimized for desktop and mobile devices. Real-Time Updates: Instant updates on likes, comments, and follows using Turbo Rails.

Technologies Used: Backend: Ruby on Rails 7 Frontend: Bootstrap 5 Database: PostgreSQL Real-Time Updates: Turbo Rails Containerization: Docker and Docker Compose

Setup Instructions:

Prerequisites: Ensure the following are installed on your system: Docker Docker Compose

Clone the Repository: Run the following commands in your terminal:
git clone https://github.com/faezehzand/instagram-clone.git 
cd instagram-clone

Configure Environment Variables: Create a .env file in the root directory with the following content: POSTGRES_USER=postgres 
POSTGRES_PASSWORD=password 
POSTGRES_DB=myapp_production 
POSTGRES_HOST=db RAILS_ENV=production

Build and Run the Application: Run the following command to set up and start the application: 
docker-compose up --build This will: Build Docker containers for the application. Start the PostgreSQL database and the Rails web server.

Database Setup: Open a separate terminal and run the following command to set up the database: 
docker-compose run web rake db:create db:migrate

Access the Application: Open your browser and visit: http://localhost:3000. Then you can make different user and test it.

Usage Instructions: Sign Up/Log In: Create an account or log in to an existing one. Create Posts: Upload photos with captions. Engage with Posts: Like and comment on posts. Follow/Unfollow: Personalize your feed by following/unfollowing other users.

Testing: To verify functionality: Start the application using docker-compose up. Test features, including: User registration and login. Creating, liking, and commenting on posts. Following/unfollowing users.

Lessons Learned:

Challenges: Managing database migrations in a Dockerized environment. Implementing seamless real-time updates with Turbo Rails. Solutions: Leveraged Docker Compose for consistent and portable development environments. Used environment variables for secure and flexible configuration.

Glossary:

Docker: A platform for creating and running containers. Docker Compose: A tool for managing multi-container Docker applications. PostgreSQL: An open-source relational database. Turbo Rails: A framework for enabling real-time updates in Rails applications.

Credits: This project was developed as part of a Software Engineering course.
