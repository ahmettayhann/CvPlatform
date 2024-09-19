class CreateResumeSchools < ActiveRecord::Migration[6.1]
  def change
    create_table :resume_schools do |t|
      t.references :resume, null: false, foreign_key: true
      t.references :school, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
