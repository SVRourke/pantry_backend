class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def record_age
    minutes = (Time.now - self.created_at) / 60

    if minutes 
    case minutes
      when -Float::INFINITY...1
        "1 minute"
      when 1...59
        "#{mintues.truncate()} minutes"
      when 60...105
        "1 hour"
      when 105...1000
        "#{(minutes/60).truncate()} hours"
      when 1000...10080
        "#{((minutes/60)/24).truncate()} days"
      when 10081...131400
        "#{(((minutes/60)/24)/7).truncate()} days"
      else
        "#{((((minutes/60)/24)/7)/4).truncate()} months"
      end
    end
  end
end
