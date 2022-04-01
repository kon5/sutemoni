class MonitorsController < ApplicationController
  before_action :group_kakunin, only: [:show, :show_member]

  def index
    @groups = current_user.groups.recent
  end

  def show
    @group_users = GroupUser.where(group_id: params[:group_id])

    if @group_users.nil?
      redirect_to groups_path
    elsif @group_users.find_by(user_id: current_user.id).nil?
      redirect_to groups_path unless current_user.admin?
    end

    @states = []
    @group_users.each do |group_user|
      state = group_user.user.states.last || State.new(user_id: current_user.id, status: "(状態が登録されていません)", created_at: Time.zone.now, updated_at: Time.zone.now)
      time = state&.created_at
      @states << [time, state]
    end

    @states = @states.sort.reverse
  end

  def show_member
    @member = User.find_by(id: params[:member_id])

    if @member.nil? || @group.group_users.find_by(user_id: params[:member_id]).nil?
      redirect_to groups_path
    else
      @states = @member.states.recent
    end
  end

  private

  def group_kakunin
    @group = Group.find_by(id: params[:group_id])

    if @group.nil?
      redirect_to groups_path
    elsif @group.group_users.find_by(user_id: current_user.id).nil?
      redirect_to groups_path unless current_user.admin?
    end
  end
end
