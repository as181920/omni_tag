class CreateOmniTagTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table :omni_tag_taggings do |t|
      t.references :tag, null: false, foreign_key: {to_table: :omni_tag_tags}, index: true
      t.references :taggable, polymorphic: true, index: true
      t.string :context

      t.datetime :created_at, null: false

      t.index [:tag_id, :taggable_id, :taggable_type, :context], name: "index_omni_tag_taggings_on_tag_and_taggable_and_context", unique: true
    end
  end
end
