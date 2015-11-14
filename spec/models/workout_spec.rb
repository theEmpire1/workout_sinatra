require_relative '../spec_helper'

describe Workout do
  it 'raises error on inappropriate attributes' do
    expect do
      Workout.new(foo: 'bar')
    end.to raise_error(NoMethodError)
  end
end
