module OmniTag
  class Tag < ApplicationRecord
    has_many :taggings, dependent: :destroy, class_name: "::OmniTag::Tagging"

    scope :by_context, ->(context) { (defined?(proxy_association) ? all : joins(:taggings)).merge(::OmniTag::Tagging.by_context(context)).distinct }

    validates :name, presence: true, uniqueness: true

    def to_s
      name
    end
  end
end
