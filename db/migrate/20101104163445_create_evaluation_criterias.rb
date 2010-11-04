class CreateEvaluationCriterias < ActiveRecord::Migration
  def self.up
    create_table :evaluation_criterias do |t|
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :evaluation_criterias
  end
end
