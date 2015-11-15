require_relative '../spec_helper'

describe Workout do
  it 'raises error on inappropriate attributes' do
    expect do
      Workout.new(foo: 'bar')
    end.to raise_error(NoMethodError)
  end

  it 'returns the associated exercises' do
    workout = FactoryGirl.create(:workout_with_exercises)
    associated_exercises = workout.exercises
    expect(associated_exercises.count).to eq(3)
  end
end
