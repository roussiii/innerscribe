class CreateCounselorInteractions < ActiveRecord::Migration[7.0]
  def change
    create_table :counselor_interactions do |t|
      t.references :user, null: false, foreign_key: true
      t.text :input
      t.text :response

      t.timestamps
    end
  end
end
