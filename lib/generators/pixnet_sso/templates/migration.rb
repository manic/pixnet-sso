class Create<%= user_model %>s < ActiveRecord::Migration
  def self.up
    create_table :<%= user_model.tableize %> do |t|
      t.string :login, :limit => 32
      t.timestamps
    end

    add_index :<%= user_model.tableize %>, [:login], :unique => true
  end

  def self.down
    drop_table :<%= user_model.tableize %>
  end
end

