fb_root = null
fb_events_bound = false
twttr_events_bound = false
vk_events_bound = false

$ ->
  loadFacebookSDK()
  bindFacebookEvents() unless fb_events_bound
  loadTwitterSDK()
  bindTwitterEventHandlers() unless twttr_events_bound
  renderVkButton()
  bindVkEventHandlers() unless vk_events_bound


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
  $.getScript "//connect.facebook.net/#{locale}/all.js#xfbml=1", ->
    FB.Event.subscribe 'xfbml.render', ->
      alert 'yo'
      $('.fb-like').each ->
        button = $(this)
        button.css('vertical-align', 'bottom')
        button.css('transform', 'scale(1.5)')
        button.css('transform-origin', 'bottom left')

initializeFacebookSDK = ->
  appId=$('#service').data('fb-app-id')
  FB.init
    appId     : appId
#    channelUrl: '//WWW.YOUR_DOMAIN.COM/channel.html'
    status    : true
    cookie    : true
    xfbml     : true

bindTwitterEventHandlers = ->
  $(document).on 'page:load', renderTweetButtons
  twttr_events_bound = true

renderTweetButtons = ->
  $('.twitter-share-button').each ->
    button = $(this)
    button.attr('data-url', document.location.href) unless button.data('url')?
    button.attr('data-text', document.title) unless button.data('text')?

  twttr.widgets.load()

loadTwitterSDK = ->
  $.getScript "//platform.twitter.com/widgets.js", ->
    twttr.events.bind 'rendered', ->
      $('.twitter-share-button').each ->
        button = $(this)
        button.css('vertical-align', 'bottom')
        button.css('transform', 'scale(1.5)')
        button.css('transform-origin', 'bottom left')

renderVkButton = ->
  title = $('.vk-share-button').data('title')
  description = $('.vk-share-button').data('description')
  image = $('.vk-share-button').data('image')
  $('.vk-share-button').html VK.Share.button({
    title: title,
    description: description,
    image: image,
    url: document.location.href
    noparse: true
  }, {
    text: $('#i18n').data('share')
    type: "link"
  })
  $('.vk-share-button').find('span').css('font-size', '15px')
  $('.vk-share-button').find('td').css('padding', '5px')
  $('.vk-share-button').find('table').css('background-image', 'linear-gradient(rgb(253, 253, 253), rgb(232, 232, 232) 60%, rgb(224, 224, 224))')
  $('.vk-share-button').find('table').css('box-shadow', '0px 0px 2px gray')
  $('.vk-share-button').find('table').css('margin-top', '10px')


bindVkEventHandlers = ->
  $(document).on 'page:load', ->
    renderVkButton()
  vk_events_bound = true
