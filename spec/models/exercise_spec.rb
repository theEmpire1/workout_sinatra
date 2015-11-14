require_relative '../spec_helper'

describe Exercise do
  it 'raises error on inappropriate attributes' do
    expect do
      Exercise.new(foo: 'bar')
    end.to raise_error(NoMethodError)
  end

  it 'sets valid attributes' do
    exercise = Exercise.new(name: 'Shoulder Press', description: 'Push the weight UP!')
    expect(exercise.name).to eq('Shoulder Press')
    expect(exercise.description).to eq('Push the weight UP!')
  end

  it 'creates an exercise' do
    Exercise.create(name: 'Bench Press', description: 'Again, push the weight UP!')
    exercise = Exercise.find_by(name: 'Bench Press')
    expect(exercise.name).to eq('Bench Press')
    expect(exercise.id).not_to be_nil
  end
end
