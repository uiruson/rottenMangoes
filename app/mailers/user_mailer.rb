class UserMailer < ActionMailer::Base
 default from: 'wilson@gmail.com'
 
  def goodbye_email(user)
    @user = user
    puts "@user email = #{@user.email}"
    mail(to: @user.email,
         subject: 'Welcome to My Awesome Site') do |format|
      format.html { render 'goodbye_email' }
    end
  end

end
