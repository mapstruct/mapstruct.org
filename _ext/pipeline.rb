require 'bootstrap-sass'

Awestruct::Extensions::Pipeline.new do
  helper Awestruct::Extensions::GoogleAnalytics
  extension Awestruct::Extensions::Posts.new( '/news', :posts )
  extension Awestruct::Extensions::Paginator.new( :posts, '/news/index', :per_page=>5 )
  extension Awestruct::Extensions::Tagger.new( :posts, '/news/index', '/news/tags', :per_page=>5 )
  # extension Awestruct::Extensions::Indexifier.new
  # Indexifier *must* come before Atomizer
  extension Awestruct::Extensions::Atomizer.new( :posts, '/news.atom', :feed_title=>'MapStruct News' )
end
