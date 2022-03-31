class SessionsController < ApplicationController
  skip_before_action :login_required

  def new
  end

  def create
    user = User.find_by(email: session_params[:email])

    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'ログインしました。'
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました。'
  end

  def guest
    session[:user_id] = Guest.first.user_id
    redirect_to root_path, notice: "ゲストとしてログインしました。"

    guest_states_clear
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

  def guest_states_clear
    @states = current_user.states
    ima = Time.current

    @states.each do |state|
      sai = ima - state.created_at
      state.destroy if sai > 10800 # 差異は秒単位 3 時間 = 3 * 60 * 60
    end
  end
end
