class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def record_age
    (Time.now - self.created_at).truncate()
  end
end
