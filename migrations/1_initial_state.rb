Sequel.migration do
  change do
    create_table(:diffs) do
      primary_key :id, type: Bignum
      String :filename, null: false, index: true
      String :contents, null: false, text: true
      DateTime :date_received
      String :status
    end
  end
end
