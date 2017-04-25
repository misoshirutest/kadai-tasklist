class AddUserToTasks < ActiveRecord::Migration[5.0]
  def change
    add_reference :tasks, :user, foreign_key: true
    # 外部キー制約：　テーブルの指定したカラムに格納できる値を他のテーブルに格納されている値だけに限定するものです
  end
end
