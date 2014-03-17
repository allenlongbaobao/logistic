request-login-schema =
  type: 'object'
  additional-properties: false
  properties:
    email:
      type: 'string'
      required: true
      #pattern: /^(\w)+(\.\w+)*@(\w)+((\.\w{2,3}){1,3})$/
    password:
      type: 'string'
      required: true
      minLength: 6
      maxLength: 12
