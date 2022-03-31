class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def index
    if current_user.admin?
      @groups = Group.all
      @group_users = GroupUser.all
    else
      @groups = current_user.groups.recent
    end
  end

  def show
  end

  def new
    @group = Group.new
    #@group.group_users.build
  end

  def edit
  end

  def create
    @group = current_user.groups.new(group_params)
    @group.maker_id = current_user.id

    if @group.save
      @group.users << current_user
      redirect_to @group, notice: "グループ「#{@group.name}」を登録しました。"
    else
      render :new
    end
  end

  def update
  end

  def destroy
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end

  def set_group
    if current_user.admin?
      @group = Group.find_by(id: params[:id])
    else
      @group = current_user.groups.find_by(id: params[:id])
    end
    
    redirect_to groups_path unless @group
  end
end
