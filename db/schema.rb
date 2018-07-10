ActiveRecord::Schema.define(version: 2018_06_25_212900) do
  enable_extension 'plpgsql'
  create_table 'categories', force: :cascade do |t|
    t.string 'name'
    t.string 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
  create_table 'comments', force: :cascade do |t|
    t.string 'content'
    t.bigint 'user_id'
    t.bigint 'post_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['post_id'], name: 'index_comments_on_post_id'
    t.index ['user_id'], name: 'index_comments_on_user_id'
  end
  create_table 'post_categories', force: :cascade do |t|
    t.integer 'category_id'
    t.integer 'post_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
  create_table 'posts', force: :cascade do |t|
    t.string 'title'
    t.bigint 'user_id'
    t.string 'keywords'
    t.string 'description'
    t.integer 'public', default: 0, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.text 'content'
    t.index ['user_id'], name: 'index_posts_on_user_id'
  end
  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'username', default: '', null: false
    t.string 'full_name', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.inet 'current_sign_in_ip'
    t.inet 'last_sign_in_ip'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'admin', default: 0, null: false
    t.integer 'author', default: 0, null: false
    t.string 'picture', default: 'default.png', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
    t.index ['username'], name: 'index_users_on_username', unique: true
  end
  add_foreign_key 'comments', 'posts'
  add_foreign_key 'comments', 'users'
  add_foreign_key 'posts', 'users'
end
