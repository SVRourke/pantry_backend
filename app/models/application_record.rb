class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def record_age
    minutes = ((Time.now - self.created_at) / 60).truncate()
  end
end
