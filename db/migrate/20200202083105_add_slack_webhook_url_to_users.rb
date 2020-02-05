class AddSlackWebhookUrlToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :slack_webhook_url, :string
  end
end
