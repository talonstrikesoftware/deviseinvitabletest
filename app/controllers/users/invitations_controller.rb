class Users::InvitationsController < Devise::InvitationsController
  
  def update
    # if this
      # redirect_to root_path
    # else
      # super
    # end
    puts "update called"
    super
  end
   
  def edit 
    # set_minimum_password_length if respond_to? :set_minimum_password_length
    # resource.invitation_token = params[:invitation_token]
    # render :edit
    super
    #render component: 'InviteSignUpView', props: { invitation_token: params['invitation_token'], email: "myemail.com" }, tag: 'span', class: 'authrow'
  end
  
  private 
  def accept_resource 
    puts "accept_resource called with params: #{update_resource_params}"
    resource = resource_class.accept_invitation!(update_resource_params)
    resource
  end
end