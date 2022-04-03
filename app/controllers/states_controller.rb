class StatesController < ApplicationController
  before_action :set_state, only: [:show, :edit, :update, :destroy]

  def index
    @states = current_user.states.recent
    @states_all = State.all.recent if current_user.admin?
  end

  def show
  end

  def new
    @state = State.new
    @preset_states = PresetState.all
  end

  alias new2 new

  def edit
  end

  def create
    @preset_state = PresetState.new(params.require(:state).permit(:state))
    @state = current_user.states.new(state_params)
    flag = true # save NGならfalseへ

    if @state.status == "" # 直接入力は無し
      if @preset_state.state == ""
        flash.now.notice = "状態データがありません"
        @preset_states = PresetState.all
        flag = false
      else
        @state = current_user.states.new(status: @preset_state.state)
      end
    end

    if flag && @state.save
      kakushi = params.require(:state).permit(:group_id)

      if kakushi[:group_id].nil? # 無ければ状態一覧に、有ればモニタにリダイレクト
        redirect_to states_path, notice: "状態「#{@state.status}」を登録しました。"
      else
        flash[:notice] = "状態「#{@state.status}」を登録しました。"
        redirect_to controller: :monitors, action: :show, group_id: kakushi[:group_id]
      end
    else
      render :new
    end
  end

  def update
    @state.update!(state_params)
    redirect_to states_url, notice: "状態「#{@state.status}」を更新しました。"
  end

  def destroy
    @state.destroy
    redirect_to states_url, notice: "状態「#{@state.status}」を削除しました。"
  end

  private

  def state_params
    params.require(:state).permit(:status, :private)
  end

  def set_state
    @state = current_user.states.find(params[:id])
  end
end
