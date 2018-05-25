module OmniTag
  class Tag < ApplicationRecord
    has_many :taggings, dependent: :destroy, class_name: "::OmniTag::Tagging"

    validates :name, presence: true, uniqueness: true

    def to_s
      name
    end
  end
end
