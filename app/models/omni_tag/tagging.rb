module OmniTag
  class Tagging < ApplicationRecord
    belongs_to :tag, class_name: "::OmniTag::Tag", counter_cache: true
    belongs_to :taggable, polymorphic: true

    scope :by_context, ->(context) { where(context: Array[context]) }

    validates_uniqueness_of :tag_id, scope: [:taggable_type, :taggable_id, :context]

    after_destroy :remove_unused_tags

    private

      def remove_unused_tags
        tag.destroy if tag.reload.taggings_count.zero?
      end
  end
end
