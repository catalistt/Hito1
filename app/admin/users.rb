ActiveAdmin.register User do
  permit_params :email, :name, :image_url, :tweets, :likes, :tweet_id, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at
  
  index do
    #información básica
    selectable_column
    id_column
    column :email
    column :name

    #Cantidad de usuarios seguidos
    column :following do |user|
      user.followings.count
    end
    #Cantidad de tweets posteados
    column :tweets do |user|
      user.tweets.count
    end
    #Cantidad de retweets hechos
    column :retweets do |user|
      user.retweets.count
    end
    #Cantidad de likes dados
    column :likes do |user|
      user.likes.count
    end
    #borrar, editar, visualizar
    actions
  end
  
end