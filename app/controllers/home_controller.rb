# Controller for handling the homepage actions, such as displaying the user's feed and providing follow suggestions.
class HomeController < ApplicationController
  before_action :set_suggestions
  before_action :set_feeds

  # GET /home
  # Renders the home page view displaying feed posts and follow suggestions.
  def index
  end

  private

  # Sets the @feeds instance variable to hold the recent posts of the current user and their followings,
  # ordered by most recent first.
  def set_feeds
    @feeds = Post.where(user: [ current_user, *current_user.followings ]).order(created_at: :desc)
  end

  # Sets the @suggestions instance variable to provide suggested users for the current user to follow.
  # Builds a list based on the current user's followers and followings, adding some random users.
  # Limits suggestions to 5 unique users, excluding the current user and those they already follow.
  def set_suggestions
    # Collects initial suggestions based on followers and followings.
    @suggestions = [ current_user.followers ]

    # Adds followers and followings of each related user to broaden suggestions.
    [ current_user.followers, current_user.followings ].flatten.uniq.each do |f|
      @suggestions.append([ f.followers, f.followings ])
    end

    # Consolidates suggestions, includes random users, and excludes current user's followings and self.
    @suggestions = [ @suggestions, User.all.sample(10) ].flatten.uniq - [ *current_user.followings, current_user ]

    # Samples up to 5 unique users from the filtered list for final suggestions.
    @suggestions = @suggestions.sample(5)
  end
end
