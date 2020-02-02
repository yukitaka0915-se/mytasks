class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
 
  has_many :groups, dependent: :destroy
  # has_many :groups, dependent: :restrict_with_error
  has_many :tasks, dependent: :destroy

  after_create :create_initial_group



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

end
