# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "page:change", ->
  $('.comment-panel .comment-reply').on 'click', (e)->
    e.preventDefault()
    e.stopPropagation()
    target=$(e.currentTarget)
    parent_id=target.data('id')
    category=target.data('category')
    entity_id=target.data('entity-id')
    indent=target.data('indent')
    avatar=$('.profile-image').attr('src')
    name=$('.profile-name').data('name')
    ok_text=$('#i18n').data('ok')
    cancel_text=$('#i18n').data('cancel')
    template=JST['templates/comments/edit']
    el=template({
      indent: indent + 1,
      avatar:avatar,
      name:name,
      entity_id:entity_id,
      parent_id: parent_id,
      category:category,
      ok_text:ok_text,
      cancel_text:cancel_text})
    el=$(el)
    parent = $('#comment_'+parent_id)
    parent.after(el)
    el.on 'click', '#cancel_comment', (e)->
      el.remove()

