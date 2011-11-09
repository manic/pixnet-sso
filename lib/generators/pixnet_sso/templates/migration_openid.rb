class Create<%= openid_model %>s < ActiveRecord::Migration
  def self.up
    create_table :<%= openid_model.tableize %> do |t|
      t.string   "openid"
      t.string   "provider",   :limit => 32
      t.text     "extra"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_index :<%= openid_model.tableize %>, ["openid"], :unique => true
    add_index :<%= openid_model.tableize %>, ["provider"]
  end

  def self.down
    drop_table :<%= openid_model.tableize %>
  end
end

