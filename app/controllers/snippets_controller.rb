def create
  @snippet = Snippet.new(params[:snippet])
  if @snippet.save
    #uri = URI.parse("http://ex.com")
    #request = Net::HTTP.post_form(uri, lang: @snippet.language, code: @snippet.plain_code)
    #@snippet.update_attribute(:highlighted_code, request.body)
     PygmentsWorker.perform_async(@snippet.id)
     redirect_to @snippet
  else
    render :new
  end
end

