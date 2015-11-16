require_relative 'spec_helper'

describe WorkoutApp do
  def app
    WorkoutApp
  end

  describe '/workouts' do
    it 'returns hello world' do
      get '/workouts'
      expect(last_response.body).to eq('Hello World!')
    end
  end

  describe '/exercises_for_workout' do
    it 'returns all exercises for a given workout' do
      workout = FactoryGirl.create(:workout_with_exercises)
      exercise_ids = workout.exercises.each_with_object([]) do |e, arr|
        arr << e.id
      end

      expected_exercise_response = {
        exercises_for_workout: [
          {
            id: exercise_ids[0],
            name: 'Bench Press',
            description: 'Default Exercise Factory Description'
          },
          {
            id: exercise_ids[1],
            name: 'Pushups',
            description: 'Default Exercise Factory Description'
          },
          {
            id: exercise_ids[2],
            name: 'DB Flys',
            description: 'Default Exercise Factory Description'
          }
        ]
      }

      get '/exercises_for_workout', workout_id: workout.id.to_int
      # expect(last_response.body.class).to eq(JSON)
      expect(JSON.parse(last_response.body)).to eq(JSON.parse(expected_exercise_response.to_json))
    end
  end
end
