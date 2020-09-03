ActiveAdmin.register Tweet do

  permit_params :tweet, :tweet_id, :user_id

  index do
    selectable_column
    id_column
    column :content
    column :user_id

    actions
  end
  
end