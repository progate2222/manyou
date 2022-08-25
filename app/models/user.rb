class User < ApplicationRecord
    validates :name,  presence: true, length: { maximum: 30 }
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
      before_validation { email.downcase! }
      has_secure_password
      validates :password, length: { minimum: 6 }
      has_many :tasks, dependent: :destroy
      before_update :admin_exit?
      before_destroy :admin_exit?
 
     def admin_exit?
         redirect_to admin_users_path if User.count{|i| i.admin? === true} ==1
         flash.now[:danger] = '管理者が0人になってしまうため、処理を中断しました'
     end

end
