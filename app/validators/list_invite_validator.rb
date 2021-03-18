class ListInviteValidator < ActiveModel::Validator
    def validate(record)
        user = record.pending_contributor
        if ListInvite.where(pending_contributor: user, list: record.list).any?
            record.errors.add :existing_record, "#{user.name} is already invited to #{record.list.name}"
        elsif user.lists.include?(record.list)
            record.errors.add :existing_record, "#{user.name} is already a contributor to #{record.list.name}"
        end
    end
end