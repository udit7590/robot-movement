class Robot::PositionsController < ApplicationController
  before_action :find_robot

  def create
    @position = @robot.positions.build(position_params.merge(area: Area.first))
    if @position.save
      redirect_to root_path, notice: I18n.t('positions.success')
    else
      redirect_to root_path, alert: I18n.t('positions.invalid')
    end
  end

  private
  def position_params
    params.require(:position).permit(:x, :y, :face)
  end
end
