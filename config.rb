# Globals
config[:api_host]           = 'https://api.zoom.us/v2/'
config[:deveoper_portal]    = 'https://zoom.us/developer'
config[:ex_api_key]         = 'your_api_key'
config[:ex_api_secret]      = 'your_api_secret'
config[:ex_meeting_number]  = '123456789'
config[:ex_meeting_topic]   = 'Meeting Topic'
config[:ex_email]           = 'user@company.com'
config[:ex_password]        = 'P@55w0rd'
config[:ex_uuid]            = 'unique_id'
config[:ex_first_name]      = 'Zoomie'
config[:ex_last_name]       = 'Userton'
config[:ex_node_init]       = 'var Zoom = require("zoomus")({
    key : "your_api_key",
    secret : "your_api_secret"
});'
config[:ex_node_res]        = 'function(res){
    if(res.error){
      //handle error
    } else {
      console.log(res);
    }
}'

# Unique header generation
require './lib/unique_head.rb'

# Markdown
set :markdown_engine, :redcarpet
set :markdown,
    fenced_code_blocks: true,
    smartypants: true,
    disable_indented_code_blocks: true,
    prettify: true,
    strikethrough: true,
    tables: true,
    with_toc_data: true,
    no_intra_emphasis: true,
    renderer: UniqueHeadCounter

# Assets
set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :fonts_dir, 'fonts'

# Activate the syntax highlighter
activate :syntax
ready do
  require './lib/monokai_sublime_slate.rb'
  require './lib/multilang.rb'
end

activate :sprockets

activate :autoprefixer do |config|
  config.browsers = ['last 2 version', 'Firefox ESR']
  config.cascade  = false
  config.inline   = true
end

# Github pages require relative links
activate :relative_assets
set :relative_links, true

# Build Configuration
configure :build do
  # We do want to hash woff and woff2 as there's a bug where woff2 will use
  # woff asset hash which breaks things. Trying to use a combination of ignore and
  # rewrite_ignore does not work as it conflicts weirdly with relative_assets. Disabling
  # the .woff2 extension only does not work as .woff will still activate it so have to
  # have both. See https://github.com/slatedocs/slate/issues/1171 for more details.
  activate :asset_hash, :exts => app.config[:asset_extensions] - %w[.woff .woff2]
  # If you're having trouble with Middleman hanging, commenting
  # out the following two lines has been known to help
  activate :minify_css
  activate :minify_javascript
  # activate :gzip
end
activate :directory_indexes
# Deploy Configuration
# If you want Middleman to listen on a different port, you can set that below
set :port, 4567

helpers do
  require './lib/toc_data.rb'
end