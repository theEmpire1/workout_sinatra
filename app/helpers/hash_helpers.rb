module HashHelpers
  def required_params(params, *expected_params)
    params = ActiveSupport::HashWithIndifferentAccess.new(params)
    expected_params.each_with_object({}) do |param, result|
      fail ArgumentError, "Missing required parameter '#{param}'" if params[param].nil?
      result[param] = params[param]
    end
  end
end
