class User < ApplicationRecord
    validates :name,  presence: true, length: { maximum: 30 }
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    before_validation { email.downcase! }
    has_secure_password
    validates :password, length: { minimum: 6 }
    has_many :tasks, dependent: :destroy
    before_update :admin_exit_before_update?
    before_destroy :admin_exit_before_destroy?

    def admin_exit_before_update?
        if User.where(admin: true).count("true")==1 && self.admin_change[1] == false && self.admin_change[0] == true
            throw(:abort)
        end
    end

    def admin_exit_before_destroy?
        if User.where(admin: true).count("true")==1 && self.admin == true
            throw(:abort)
            render :index
            flash[:notice] = '管理者が０人になってしまうので削除できません'
        end
    end

end
