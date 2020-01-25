class User < ApplicationRecord
  after_create :create_initial_group
  after_update :update_initial_group

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
 
  has_many :groups, dependent: :destroy
  # has_many :groups, dependent: :restrict_with_error
  has_many :tasks, dependent: :destroy



  private

  # User作成直後に、タスクリスト「リマインダー」を作成する
  def create_initial_group
    group = Group.new(
      name: name + "のリマインダー",
      user_id: id,
      authority: true
    )
    group.save!
  end

  # User更新直後に、タスクリスト「リマインダー」の名前を変更する
  def update_initial_group
    group = groups.where(user_id: id).where(authority: true)
    group.update(
      name: name + "のリマインダー"
    )
  end

end
