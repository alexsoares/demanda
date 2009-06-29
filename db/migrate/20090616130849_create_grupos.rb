class CreateGrupos < ActiveRecord::Migration
  def self.up
    create_table :grupos do |t|
      t.string :nome, :limit => 50

      t.timestamps
    end
    Grupo.create :nome => "B1"
    Grupo.create :nome => "B2"
    Grupo.create :nome => "B3"
    Grupo.create :nome => "M1"
    Grupo.create :nome => "M2"
  end

  def self.down
    drop_table :grupos
  end
end
