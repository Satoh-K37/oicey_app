class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications
    # .page(params[:page]).per(20)
    @notifications.where(checked: false).each do |notification|
      # 未確認の通知レコードを確認したら確認済みにする
      notification.update_attributes(checked: true)
    end
  end
end
