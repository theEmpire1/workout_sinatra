json.exercises_for_workout do
  json.array! exercises.map do |exercise|
    json.id exercise.id
    json.name exercise.name
    json.description exercise.description
  end
end
