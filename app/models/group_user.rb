class GroupUser < ApplicationRecord
  validate :validate_user_id_exist

  belongs_to :user
  belongs_to :group

  private

  def validate_user_id_exist
    if User.where(id: user_id).present?
      if GroupUser.where(user_id: user_id).where(group_id: group_id).present? # もしも、既にGR+userのペアが有るならNG
        errors.add(:email, ':このアドレスはグループ加入済みです。') 
      end
    else
      errors.add(:email, ':このアドレスは未登録です。ユーザ登録を行って下さい。') # 無いのはNG。ﾕｰｻﾞ登録が必要
    end
  end
end
