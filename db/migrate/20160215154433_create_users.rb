class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      #mysql -u simple_cms -p simple_cms_development
      # id column is automatically added by rails
      #if you do not want id added, you will need to specify it by:
      #create_table :users, {:id => flase} do |t|
      t.column "first_name", :string, :limit => 25  #long way
      t.string "last_name", :limit => 50
      t.string "email", :default => "", :null => false
      t.string "password", :limit => 40
      #t.datetime "created_at"
      #t.datetime "updated_at"  #timestamps automatically add these 2 fields
      t.timestamps
    end
  end

  def down
     drop_table :users
  end
end
