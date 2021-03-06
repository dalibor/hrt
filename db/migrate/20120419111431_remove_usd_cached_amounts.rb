class RemoveUsdCachedAmounts < ActiveRecord::Migration
  def self.up
    remove_column :activities, :budget_in_usd
    remove_column :activities, :spend_in_usd
    remove_column :funding_flows, :budget_in_usd
    remove_column :funding_flows, :spend_in_usd
    remove_column :code_assignments, :cached_amount_in_usd
  end

  def self.down
    add_column :activities, :budget_in_usd, :decimal, :default => 0
    add_column :activities, :spend_in_usd, :decimal, :default => 0
    add_column :funding_flows, :budget_in_usd, :decimal, :default => 0
    add_column :funding_flows, :spend_in_usd, :decimal, :default => 0
    add_column :code_assignments, :cached_amount_in_usdcached_amount_in_usd, :decimal, :default => 0
  end
end
