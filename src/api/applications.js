import request from '@/utils/request'

export function getApplications() {
  return request({
    url: '/appmgr/applications',
    method: 'get'
  })
}

export function getApplicationByName(appname) {
  return request({
    url: '/appmgr/app/'+appname,
    method: 'get'
  })
}

export function getAppLog(appname) {
  return request({
    url: `/appmgr/app/${appname}/output?keep_history=1`,
    method: 'get'
  })
}

export function registerApplication(appName, data) {
  return request({
    url: '/appmgr/app/' + appName,
    method: 'PUT',
    data: data
  })
}

export function registerShApp(appName, data) {
  return request({
    url: '/appmgr/app/sh/' + appName,
    method: 'PUT',
    data: data
  })
}

export function deleteApplication(appName) {
  return request({
    url: '/appmgr/app/' + appName,
    method: 'DELETE'
  })
}

export function enableApp(appName) {
  return request({
    url: '/appmgr/app/' + appName + '/enable',
    method: 'POST'
  })
}

export function disableApp(appName) {
  return request({
    url: '/appmgr/app/' + appName + '/disable',
    method: 'POST'
  })
}

export function runApp(timeout, sync, options) {
  return request({
    url: '/appmgr/app/' + (sync ? 'syncrun' : 'run') + '?timeout=' + timeout,
    method: 'POST',
    data: options
  })
}

export function getOutput(appName, pid) {
  return request({
    url: '/appmgr/app/' + appName + '/run/output?process_uuid='+pid,
    method: 'GET'
  })
}
