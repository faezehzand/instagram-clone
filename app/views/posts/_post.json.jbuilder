# This line extracts specified attributes from the post object
json.extract! post,
  :id,                     # Unique identifier for the post
  :caption,                # The text caption of the post
  :longitude,              # Longitude of the post's location
  :latitude,               # Latitude of the post's location
  :user_id,                # ID of the user who created the post
  :allow_comments,         # Boolean indicating if comments are allowed on the post
  :show_likes_count,       # Boolean indicating if likes count should be shown
  :created_at,             # Timestamp of when the post was created
  :updated_at              # Timestamp of when the post was last updated

# This line adds the URL for the post with the desired format (JSON) to the JSON response
json.url post_url(post, format: :json)
