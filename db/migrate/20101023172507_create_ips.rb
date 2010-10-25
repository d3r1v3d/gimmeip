class CreateIps < ActiveRecord::Migration
    def self.up
        create_table :ips do |t|
            t.string :address
            t.string :name
            t.text   :description

            t.timestamps
        end
    end

    def self.down
        drop_table :ips
    end
end
