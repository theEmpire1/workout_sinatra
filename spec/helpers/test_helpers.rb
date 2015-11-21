class TestHelpers
  def self.invalid_user_id
    if !User.all.empty?
      User.all.order(:id).last.id + 1
    else
      1
    end
  end
end
