module SnippetsHelper
  def fetch_snippets
   snippets = $redis.get("snippets")
    if snippets.nil?
      snippets = Snippet.all.to_json
      $redis.set('snippets', snippets)
      $redis.expire('snippets', 15.minute.to_i)
    end
    @snippets = JSON.load snippets
  end
end
