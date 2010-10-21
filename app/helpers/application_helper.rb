module ApplicationHelper
  def markdown text
    BlueCloth.new(text).to_html.html_safe
  end

  def current_friends
    ids = if current_user
      Rails.cache.fetch(current_user.fb_uid + '_fb_friends') do
        MiniFB.get(current_user.access_token, current_user.fb_uid,
          :type => 'friends').data
      end
    else
      []
    end

    User.where :fb_uid => ids.map(&:id)
  end
end
