class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  after_invitation_accepted :add_friend
  
  has_many :invitations, :class_name => 'User', :as => :invited_by
  
  has_many :friend_relationships
  has_many :friends, through: :friend_relationships

  has_many :posts

  def add_friend
#    puts "local_variables: #{local_variables}"
#    puts "instance_variables: #{instance_variables}"
    # instance_variables.each do |v|
      # puts eval(v)
    # end
    # puts "global_variables: #{global_variables}"
    # puts "Params are: #{user}"
    # new_user = User.find_by email: user[:email]
    friend_id = self.invited_by_id
    puts "Invited by id: #{friend_id}"
    if (friend_id != nil)
      friend = User.find(friend_id)
      puts "friend is: #{friend}"
      if (friend != nil) 
        self.friend_relationships.create(:friend => friend)
        friend.friend_relationships.create(:friend => self)
      end
    end
  end
end
