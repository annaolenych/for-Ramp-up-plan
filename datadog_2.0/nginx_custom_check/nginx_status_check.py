import requests
from datadog_checks.base import AgentCheck

class NginxStatusCheck(AgentCheck):
    def check(self, instance):
        url = instance.get('url', 'http://localhost')
        try:
            response = requests.get(url)
            
            status_code = response.status_code
            self.gauge('nginx.status_custom_code', status_code, tags=['url:{}'.format(url)])
        except requests.RequestException as e:
            self.log.error(f"Error checking Nginx status: {e}")
            self.gauge('nginx.status_custom_code', 0, tags=['url:{}'.format(url)])
