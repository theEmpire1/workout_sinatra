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
end
