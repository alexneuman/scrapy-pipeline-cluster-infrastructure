



load('ext://helm_resource', 'helm_resource', 'helm_repo')

# k8s_yaml(kustomize('k8s/overlays/dev'))

# Ingress Nginx

update_settings(
    k8s_upsert_timeout_secs=300,
)


helm_resource(
    name='ingress-nginx-controller',
    chart='ingress-nginx/ingress-nginx',
    namespace='ingress-nginx',
    flags=[
        '--create-namespace',

        ],
)
# create the namespace inline


# k8s_namespace('ingress-nginx')
# yaml = helm('./k8s/charts/ingress-nginx/', name='ingress-nginx', namespace='ingress-nginx', values='./k8s/charts/ingress-nginx/values.yaml', )
# k8s_yaml(yaml)

# k8s_resource('ingress-nginx-controller',
#              # map one or more local ports to ports on your Pod
#              port_forwards=['8082:80', '8443:443'],
#              # change whether the resource is started by default
#              auto_init=False,
#              # control whether the resource automatically updates
#              trigger_mode=TRIGGER_MODE_AUTO,
#             #  resource_deps=['cert-manager'],
# )

# k8s_yaml(kustomize('k8s/common/backend'))


# # Load Kubernetes YAML

# k8s_resource('backend',
#              # map one or more local ports to ports on your Pod
#              port_forwards=['8000:8000', "5678:5678"],
#              # change whether the resource is started by default
#              auto_init=True,
#              # control whether the resource automatically updates
#              trigger_mode=TRIGGER_MODE_AUTO,
#              # alter envs
#             #  resource_deps=['ingress-nginx-controller', 'cert-manager'],
            
# )

# k8s_yaml(kustomize('k8s/common/database'))

# k8s_resource(
#     'database',
#     port_forwards=['5432:5432'],
#     auto_init=True,
#     trigger_mode=TRIGGER_MODE_AUTO
# )



# istio_injection_namespaces = [
#     'database',
#     'backend',
#     'default',
#     'redis',
#     'camoufox'
# ]

# settings = {}
# settings.update(read_json('tilt-config.json'))
# profiles = settings['profiles']

# dockerfile = 'Dockerfile'
# dev_spider_name = 'mock-server'


# spider_cluster_settings = {
#     'SPIDER_REPLICAS': 1,
# }



# if settings['istio']['istio_enabled']:
#     local_resource('metrics-server', 'kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml')
#     helm_resource('istio-base', 'istio/base', namespace='istio-system', flags=["--create-namespace"])
#     helm_resource('istiod', 'istio/istiod', namespace='istio-system', flags=[
#         "--create-namespace", ])
#     k8s_yaml(kustomize('k8s/common/istio'))
#     # helm_resource('kiali', 'kiali/kiali-operator', namespace="istio-system", flags=[
#     #     "-f", "k8s/common/istio/values.yaml",
#     #     # port_forward=[

#     #     # ]
#     # ])
#     k8s_resource('kiali', 
#         port_forwards=["20001:20001"]
#     )

# spider_cluster_settings.update(settings['spider_cluster_settings'])

# scrapy_build_args = {
#     'PLAYWRIGHT_HEADLESS': 'False',
#     'PLAYWRIGHT_BROWSER': 'chromium',
#     'PLAYWRIGHT_ENABLED': 'False',
#     'SPIDER_NAME': '',
#     'PROXY_ENABLED': 'False',
#     'PROXY_URL': '',
#     'DUPEFILTER_ENABLED': 'True',
#     'CONCURRENCY_PER_SPIDER': "12",
#     'CAMOUFOX_ENABLED': 'False',
#     'CAMOUFOX_API_URL': '',
#     'HTTPCACHE_ENABLED': 'True',
#     'COOKIES_ENABLED': 'False',
#     'REDIS_HOST': 'redis.redis.svc.cluster.local',
#     'DEBUGGER_ENABLED': 'true',
#     'DOWNLOAD_DELAY': "0",
#     'LOG_LEVEL': 'WARNING'
# }
# dockerfile = "Dockerfile"

# if 'camoufox-dev' in profiles:
#     istio_injection_namespaces.append('camoufox')
   
#     scrapy_build_args['HTTPCACHE_ENABLED'] = 'true'

#     scrapy_build_args['REDIS_ENABLED'] = 'true'
#     scrapy_build_args['PLAYWRIGHT_ENABLED'] = 'False'
#     scrapy_build_args['CAMOUFOX_ENABLED'] = 'True'
#     scrapy_build_args['CAMOUFOX_HOST'] = 'camoufox.camoufox.svc.cluster.local'
#     # scrapy_build_args['CAMOUFOX_HOST'] = 'localhost'
#     scrapy_build_args['CAMOUFOX_PORT'] = '59001'
#     scrapy_build_args['CAMOUFOX_PATH'] = '/'
#     scrapy_build_args['CAMOUFOX_ROTATOR_CHANGE_AFTER'] = '50'
#     scrapy_build_args['CAMOUFOX_SUCCESS_XPATH_TIMEOUT'] = '10000'
#     scrapy_build_args['CAMOUFOX_ROTATE_AFTER_SCRAPY_REQUEST_FAILURE'] = 'True'
#     scrapy_build_args['CAMOUFOX_WAIT_AFTER_REFRESH_FAILURE_SECONDS'] = '60'
#     scrapy_build_args['CAMOUFOX_KILL_SPIDER_AFTER_EXHAUST_REFRESH_ATTEMPTS'] = 'True'
#     scrapy_build_args['CAMOUFOX_REFRESH_ATTEMPTS'] = '5'

#     scrapy_build_args['CAMOUFOX_SUCCESS_XPATH'] = '//li[contains(@class, "PageNumberLi")]'
#     scrapy_build_args['CAMOUFOX_REFRESH_URL'] = 'https://www.realestate.com.au/buy/in-tarneit,+vic+3029/list-1'

#     # dev_spider_name = 'mock-server'


#     # k8s_yaml([
#     #     'k8s/camoufox/deployment.yaml',
#     #     'k8s/camoufox/service.yaml',
#     # ])

    






# if 'dev' in settings['profiles']:
#     scrapy_build_args['SPIDER_NAME'] = dev_spider_name
#     scrapy_build_args['DUPEFILTER_ENABLED'] = 'True'
#     scrapy_build_args['CONCURRENCY_PER_SPIDER'] = "1"
#     scrapy_build_args['REDIS_ENABLED'] = 'true'
    
    



# if 'playwright-dev' in profiles:
#     scrapy_build_args['SPIDER_NAME'] = dev_spider_name
#     scrapy_build_args['DUPEFILTER_ENABLED'] = 'True'
#     scrapy_build_args['CONCURRENCY_PER_SPIDER'] = "1"
#     scrapy_build_args['PLAYWRIGHT_ENABLED']= "true"
#     scrapy_build_args['PLAYWRIGHT_CONNECT_URL'] = 'ws://camoufox.default.svc.cluster.local:59001/'
#     scrapy_build_args['PLAYWRIGHT_BROWSER'] = 'firefox'
#     scrapy_build_args['PLAYWRIGHT_DEFAULT_NAVIGATION_TIMEOUT'] = "30000"
#     scrapy_build_args['PLAYWRIGHT_MAX_CONTEXTS'] = "10000"
#     scrapy_build_args['PLAYWRIGHT_MAX_PAGES_PER_CONTEXT'] = "1"
#     scrapy_build_args['PLAYWRIGHT_PAGE_WAIT_UNTIL'] = "domcontentloaded"

#     scrapy_build_args['PLAYWRIGHT_USE_STATEFULSET'] = "true"

    

#     k8s_yaml(kustomize('k8s/common/camoufox'))

#     helm_resource(
#         'keda', 'kedacore/keda', namespace='keda', flags=['--create-namespace']
#     )
#     k8s_yaml(kustomize('k8s/common/keda'))

#     k8s_resource(
#     'camoufox',
#     port_forwards=[
#         '59001:59001',
#         '6080:6080'
#         ],
#     auto_init=True,
#     trigger_mode=TRIGGER_MODE_AUTO
# )

# # for ns in istio_injection_namespaces:
# #     local("kubectl label namespace {} istio-injection=enabled --overwrite=true".format(ns))
# #     # pods must be restarted - this runs only once
# #     local_resource('restart-namespace-pods-{}'.format(ns), 'kubectl delete po --all -n {}'.format(ns))

# docker_build_with_restart(
#     'scrapy-job',
# context='.',
# dockerfile=dockerfile,
# build_args=scrapy_build_args,
# live_update=[
#     sync('./generic', '/generic'),
#     run('pip install --no-cache-dir -r requirements.txt', trigger=['requirements.txt']),
# ],
# entrypoint='./entrypoint.sh'
# )

# print(settings, scrapy_build_args, spider_cluster_settings)

# # docker_build(
# #     'scrapy-job',
# #     context='.',
# #     dockerfile=dockerfile,
# #     build_args=scrapy_build_args,
# #     live_update=[
# #         sync('./generic', '/generic'),
# #         run('pip install --no-cache-dir -r requirements.txt', trigger=['requirements.txt']),
# #         # restart_container()
# #     ],
# #     ignore=['generic/.scrapy'],

# # )

# k8s_resource(
#     'redis',
#     port_forwards=['6379:6379'],
#     auto_init=True,
#     trigger_mode=TRIGGER_MODE_AUTO
# )

# k8s_resource(
#     'redis-commander',
#     port_forwards=['8081:8081'],
#     auto_init=True,
#     trigger_mode=TRIGGER_MODE_AUTO
# )

