class StaticPagesController < ApplicationController
  # TODO #1 #1: Investigate presenters/facades so the page titles aren't ivars
  def home
    @page_title = 'Home'
  end

  def help
    @page_title = 'Help'
  end

  def about
    @page_title = 'About'
  end
end
