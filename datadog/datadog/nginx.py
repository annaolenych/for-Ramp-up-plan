import requests
from datadog_checks.base.checks import AgentCheck

class NginxCheck(AgentCheck):
    def check(self, instance):
        nginx_status_url = instance.get('nginx_status_url')
        tags = instance.get('tags', [])

        try:
            response = requests.get(nginx_status_url)
            response.raise_for_status()
            status_data = response.text.split('\n')
            active_connections = status_data[0].split()[2]
            self.gauge('nginx.active_connections', active_connections, tags=tags)
            self.log.info(f'Sent metric nginx.active_connections: {active_connections}')
        except requests.exceptions.RequestException as e:
            self.log.error(f'Error accessing Nginx status: {e}')
            self.service_check('nginx.can_connect', AgentCheck.CRITICAL, tags=tags, message=str(e))
        else:
            self.service_check('nginx.can_connect', AgentCheck.OK, tags=tags)
            self.log.info('Nginx status OK')
