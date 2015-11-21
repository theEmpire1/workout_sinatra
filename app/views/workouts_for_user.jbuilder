json.workouts_for_user do
  json.array! workouts.map do |workout|
    json.id workout.id
    json.name workout.name
    json.description workout.description
    json.rating workout.rating
    json.upvotes workout.upvotes
    json.downvotes workout.downvotes
    json.user_id workout.user_id
  end
end
