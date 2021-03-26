class DeniedJti < ApplicationRecord
    scope :expired, -> { where("expiration < ?", Time.now.to_i) }
end
