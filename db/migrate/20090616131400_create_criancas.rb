class CreateCriancas < ActiveRecord::Migration
  def self.up
    create_table :criancas do |t|
      t.string :nome, :limit => 50
      t.string :mae, :limit => 50
      t.references :unidade
      t.references :regiao
      t.date :nascimento
      t.references :grupo
      t.string :endereco, :limit => 50
      t.string :numero, :limit => 10
      t.string :complemento, :limit => 30
      t.string :bairro, :limit => 30
      t.string :tel1
      t.string :tel2
      t.string :nomerecado, :limit => 50
      t.string :celular
      t.integer :responsavel
      t.string :nome_responsavel, :limit => 30
      t.string :parentesco, :default => 0
      t.boolean :trabalha
      t.string :local_trabalho
      t.string :fonetrabalho
      t.integer :option1, :default => 0
      t.integer :option2, :default => 0
      t.integer :option3, :default => 0
      t.integer :option4, :default => 0
      t.integer :matricula, :default => 0
      t.integer :unidade_matricula, :default => 0 
      t.integer :status, :default => 0
      t.integer :posicao, :default => 0
      t.timestamps
    end

  end

  def self.down
    drop_table :criancas
  end
end
