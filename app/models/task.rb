class Task < ApplicationRecord
    validates :name,  presence: true
    validates :detail, presence: true
    enum priority: { "高":0, "中":1, "低":2 }
    belongs_to :user

    scope :created_desc, -> (params){page(params).order(created_at: :desc).per(5)}
    # def self.created_desc(params)
    #     page(params).order(created_at: :desc).per(5)
    # end
    scope :deadline_desc, -> (params){page(params).order(deadline: :desc).per(5)}
    # def self.deadline_desc(params)
    #     page(params).order(deadline: :desc).per(5)
    # end
    scope :priority_asc, -> (params){page(params).order(priority: :asc).per(5)}

    scope :name_search, ->(params) {where('name LIKE ?', "%#{params}%")}
    scope :status_search, -> (params){where(status: params)}

end
