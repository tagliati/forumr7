class CreateBadwords < ActiveRecord::Migration
  def change
    create_table :badwords do |t|
      t.string :word

      t.timestamps
    end
  end
end
