class CreateCongresspersons < ActiveRecord::Migration
  def change
    create_table :congress_people do |t|
      t.string :name
      t.integer :phone
      t.integer :fax
      t.string :website
      t.string :email_form
      t.string :party
      t.string :gender
      t.string :birthdate
      t.string :twitter_id
      t.boolean :in_office
      t.string :type

      t.timestamps
    end
  end
end
