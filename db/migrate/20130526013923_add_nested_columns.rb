class AddNestedColumns < ActiveRecord::Migration
  def up
    change_table :posts do |t|
      t.integer :lft
      t.integer :rgt
    end
  end

  def down
    change_table :posts do |t|
      t.remove :lft,:rgt
    end
  end
end
