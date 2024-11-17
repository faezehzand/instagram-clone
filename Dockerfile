# Use the official Ruby image as the base image
FROM ruby:3.1

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set up the working directory
WORKDIR /app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile* /app/

# Install gems
RUN bundle install

# Copy the rest of the application code into the container
COPY . /app

# Precompile assets (if necessary)
RUN bundle exec rake assets:precompile

# Expose the application port
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
