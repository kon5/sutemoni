class GrMembersController < ApplicationController
  before_action :group_kakunin

  def index
    @group_users = GroupUser.where(group_id: @group.id)



  end

  def show
  end

  def new
  end

  def edit
    @user = User.new
    @group_user = GroupUser.new
  end

  def update
    id = User.find_by(email: params[:email])&.id || 0
    @group_user = GroupUser.new(user_id: id, group_id: @group.id)

    if @group_user.save
      redirect_to @group, notice: "グループに「#{params[:email]}」を登録しました。"
    else
      flash.now.notice = "入力Email「#{params[:email]}」がエラーになりました。"
      render :edit
    end
  end

  def destroy
    #@user = User.find(params[:id])
    #@user.destroy
    #redirect_to admin_users_url, notice: "ユーザ「#{@user.name}」を削除しました。"
  end

  private

  def group_kakunin
    @group = Group.find_by(id: params[:group_id])
    @group_maker_id = @group&.maker_id || 0

    #redirect_to groups_path unless @group_maker_id == current_user.id
    if !(current_user.admin?)
      redirect_to groups_path unless @group.group_users.find_by(user_id: current_user.id).present?
    end
  end

  def group_user_params
    params.require(:group_user).permit(:user_id, :group_id)
  end

  def set_gr_member
    @group = current_user.groups.find(params[:id])
  end
end
