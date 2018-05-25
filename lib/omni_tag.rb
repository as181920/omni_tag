require "omni_tag/engine"

module OmniTag
  extend ActiveSupport::Concern

  included do
    has_many :taggings, as: :taggable, dependent: :destroy, class_name: "::OmniTag::Tagging"
    has_many :tags, through: :taggings, class_name: "::OmniTag::Tag" do
      def by_context(context)
        merge(::OmniTag::Tagging.by_context(context))
      end
    end
  end

  class_methods do
    def tagged_with(name, options={}) # TODO: support match_all, any, exclude options with chainable
      context_scope = options.has_key?(:context) ? joins(:tags).merge(::OmniTag::Tagging.by_context(options[:context])) : joins(:tags)
      context_scope.merge(::OmniTag::Tag.where(name: Array(name)))
    end
  end

  def tag_names(options={})
    context_scope = options.has_key?(:context) ?  tags.by_context(options[:context]) : tags
    context_scope.map(&:name).uniq
  end

  def add_tags(names, options={})
    Array[options[:context]].each do |context|
      Array(names).compact.uniq.each { |name| taggings.find_or_create_by(tag: tag_instance(name), context: context) }
    end

    self.tag_names(options)
  end
  alias_method :add_tag, :add_tags

  def remove_tags(names, options={})
    context_scope = options.has_key?(:context) ? taggings.where(context: Array[options[:context]]) : taggings
    context_scope.where(tag: tag_instances(names)).destroy_all

    self.tag_names(options)
  end
  alias_method :remove_tag, :remove_tags

  def set_tags(names, options={})
    target_names = Array(names).compact.uniq
    remove_tags((tag_names(options) - target_names), options)
    Array[options[:context]].each { |cxt| add_tags((target_names - tag_names(context: cxt)), context: cxt) }

    self.tag_names(options)
  end

  private
    def tag_instance(name)
      ::OmniTag::Tag.find_or_create_by(name: name)
    end

    def tag_instances(names)
      ::OmniTag::Tag.where(name: Array(names))
    end
end
