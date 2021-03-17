class ContributionValidator < ActiveModel::Validator
    def validate(record)
        unless !Contribution.where( user_id: record.user_id, list_id: record.list_id).any?
            record.errors.add :redundant, "You are already a contributor to this list"
        end 

    end

end