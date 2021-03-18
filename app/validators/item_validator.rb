class ItemValidator < ActiveModel::Validator
    def validate(record)
        if record.name.nil?
            record.errors.add :presence, "cannot save blank item"

        elsif Item.where(name: record.name, list: record.list).any?
            record.errors.add :uniqueness, "#{record.name} already in #{record.list.name}"

        elsif !record.list.contributors.include?(record.user)
            record.errors.add :contributor, "you are not a contributor"
        end
    end
end