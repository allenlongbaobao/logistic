request-send-info-schema =
  type: 'object'
  additional-properties: false
  properties:
    location:
      description: '扫描时的地理位置'
      type: 'object'
      required: true
      properties:
        latitude:
          type: 'number'
          required: true
        longitude:
          type: 'number'
          required: true
        altitude:
          type: 'number'
          required: true
    goods:
      description: '货物信息'
      type: 'object'
      required: true
      properties:
        gid:
          type: 'string'
          required: true
        name:
          type: 'string'
          required: true
    date:
      description: '扫描时的时间'
      type: ''
      required: true
    courier:
      description: '快递员信息'
      required: true
      properties:
        name:
          description: '快递员姓名'
          required: true
