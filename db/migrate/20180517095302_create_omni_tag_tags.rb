class CreateOmniTagTags < ActiveRecord::Migration[5.2]
  def change
    create_table :omni_tag_tags do |t|
      t.string :name, null: false, index: {unique: true}
      t.integer :taggings_count, default: 0
    end
  end
end
