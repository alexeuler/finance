fb_root = null
fb_events_bound = false

$ ->
  loadFacebookSDK()
  bindFacebookEvents() unless fb_events_bound

bindFacebookEvents = ->
  $(document)
  .on('page:fetch', saveFacebookRoot)
  .on('page:change', restoreFacebookRoot)
  .on('page:load', ->
    FB?.XFBML.parse()
  )
  fb_events_bound = true

saveFacebookRoot = ->
  fb_root = $('#fb-root').detach()

restoreFacebookRoot = ->
  if $('#fb-root').length > 0
    $('#fb-root').replaceWith fb_root
  else
    $('body').append fb_root

loadFacebookSDK = ->
  window.fbAsyncInit = initializeFacebookSDK
  locale = if $('#i18n').data('locale') == 'ru' then "ru_RU" else "en_US"
  $.getScript("//connect.facebook.net/#{locale}/all.js#xfbml=1")

initializeFacebookSDK = ->
  appId=$('#fb-root').data('id')
  FB.init
#    appId     : appId
#    channelUrl: '//WWW.YOUR_DOMAIN.COM/channel.html'
    status    : true
    cookie    : true
    xfbml     : true