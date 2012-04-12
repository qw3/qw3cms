# -*- encoding : utf-8 -*-
class CreatePaginas < ActiveRecord::Migration
  def self.up
    create_table :paginas do |t|
      t.string :titulo_pagina
      t.string :titulo_artigo
      t.text :conteudo
      t.references :categoria_pagina
      t.text   :descricao
      t.text   :palavras_chave

      t.timestamps
    end
  end

  def self.down
    drop_table :paginas
  end
end
