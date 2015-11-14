require_relative '../spec_helper'

describe Workout do
  it 'raises error on inappropriate attributes' do
    expect do
      Workout.new(foo: 'bar')
    end.to raise_error(NoMethodError)
  end

  it 'sets valid attributes' do
    workout = Workout.new(name: 'Shoulder Press', description: 'Push the weight UP!')
    expect(workout.name).to eq('Shoulder Press')
    expect(workout.description).to eq('Push the weight UP!')
  end

  it 'creates a workout' do
    Workout.create(name: 'Bench Press', description: 'Again, push the weight UP!')
    workout = Workout.find_by(name: 'Bench Press')
    expect(workout.name).to eq('Bench Press')
    expect(workout.id).not_to be_nil
  end
end
