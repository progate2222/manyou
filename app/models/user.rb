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
        if User.all.where(admin: true).count == 1
            errors.add(:base, '管理者権限を持つアカウントが0件になるため更新できません')
            throw(:abort) unless self.admin
        end
    end

    def admin_exit_before_destroy?
        if User.all.where(admin: true).count == 1 && self.admin
            errors.add(:base, '管理者権限を持つアカウントが0件になるため削除できません')
            throw(:abort)
        end
    end

end
