class CsrfProtection
  def incoming(contact, request, callback)
    session_token = request.session['_csrf_token']
    contact_token = contact['ext'] && contact['ext'].delete('csrfToken')

    unless session_token == message_token
      message['error'] = '401::Access denied'
    end
    callback.call(message)
  end
end