module ActsAsTaggableOn
  class Tag < ::ActiveRecord::Base
    def self.issues
      joins(:taggings).where('context LIKE ?', "issues").select(:name).uniq
    end
  end
end
