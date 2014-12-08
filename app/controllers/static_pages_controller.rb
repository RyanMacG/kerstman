class StaticPagesController < ApplicationController
  # TODO #1 Investigate presenters/facades so the page titles aren't ivars
  def home
    @page_title = 'Home'
    if signed_in?
      @group = current_user.groups.build
      @groups = current_user.groups.limit(5).order('updated_at DESC')
    end
  end

  def help
    @page_title = 'Help'
  end

  def about
    @page_title = 'About'
  end
end
