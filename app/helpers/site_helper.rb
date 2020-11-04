module SiteHelper
  def member_or_guest
    if user_signed_in?
      render '/layouts/member_menu'
    else
      render '/layouts/guest_menu'
    end
  end

  def member_or_guest_action
    if user_signed_in?
      render '/layouts/member_action'
    else
      render '/layouts/guest_action'
    end
  end

  def flash_message(name)
    if name == 'notice'
      render 'layouts/notice'
    elsif name == 'alert'
      render 'layouts/alert'
    end
  end

  def welcome
    if user_signed_in?
      flash[:notice] = "You are successfully signen in #{current_user.name}"
      controller.redirect_to posts_path
    else
      render 'home/welcome'
    end
  end

  def render_event_actions(event)
    if user_signed_in? and event.creator == current_user
      render 'shared/creator_render', event: event
    else
      render 'shared/guest_render', event: event
    end
  end
end
