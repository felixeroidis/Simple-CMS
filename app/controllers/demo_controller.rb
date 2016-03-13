class DemoController < ApplicationController
  # Telling rails which javascript layout to use
  layout 'application'
  def index
  	#render('hello') #specifying which view to utilze
  end

  def hello
  end
  def other_hello
  	redirect_to(:controller => 'demo', :action =>'index')

  end

  def lynda
    redirect_to ('http://lynda.com')
  end

  def text_helpers
  end

  def escape_content
  end
end
