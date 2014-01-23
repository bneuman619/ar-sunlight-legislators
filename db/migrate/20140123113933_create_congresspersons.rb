class CreateCongressPersons < ActiveRecord::Migration
  def change
    create_table :congress_persons do |t|
      t.string :name
      t.integer :phone
      t.integer :fax
      t.string :website
      t.string :email_form
      t.string :party
      t.string :gender
      t.datetime :birthdate
      t.string :twitter_id
      t.in_office :boolean

      t.timestamps
    end
  end
end
