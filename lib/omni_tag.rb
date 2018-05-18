require "omni_tag/engine"

module OmniTag
  extend ActiveSupport::Concern

  included do
    has_many :taggings, as: :taggable, dependent: :destroy, class_name: "::OmniTag::Tagging"
    has_many :tags, through: :taggings, class_name: "::OmniTag::Tag"
  end

  class_methods do
  end

  def tag_names(options={})
    if options.has_key?(:context)
      tags.by_context(options[:context]).map(&:name).uniq
    else
      tags.map(&:name).uniq
    end
  end
  alias_method :get_tag_names, :tag_names

  def add_tag_names(names, options={})
    Array[options[:context]].each do |context|
      Array(names).compact.uniq.each { |name| taggings.find_or_create_by(tag: ::OmniTag::Tag.find_or_create_by(name: name), context: context) }
    end

    self.tag_names(options)
  end
  alias_method :add_tag_name, :add_tag_names

  def remove_tag_names(names, options={})
    if options.has_key?(:context)
      taggings.where(context: Array[options[:context]]).where(tag: ::OmniTag::Tag.where(name: names)).destroy_all
    else
      taggings.where(tag: ::OmniTag::Tag.where(name: names)).destroy_all
    end

    self.tag_names(options)
  end
  alias_method :remove_tag_name, :remove_tag_names

  def set_tag_names(names, options={})
    # self.tags = Array(names).compact.uniq.map { |name| ::OmniTag::Tag.by_context(options[:context]).find_or_create_by(name: name) } # Not trigger after_destroy for taggings

    target_names = Array(names).compact.uniq
    remove_tag_names((tag_names(options) - target_names), options)
    Array[options[:context]].each { |cxt| add_tag_names((target_names - tag_names(context: cxt)), context: cxt) }

    self.tag_names(options)
  end
end
