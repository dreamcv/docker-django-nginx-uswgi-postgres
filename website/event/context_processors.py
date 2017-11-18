#!/usr/bin/env python
# encoding: utf-8


from django.conf import settings
from .utils import logger, cache


def seo_processor(requests):
    key = 'seo_processor'
    value = cache.get(key)
    if value:
        logger.info('get processor cache.')
        return value
    else:
        from .views import get_all_details, get_deled_history_datas
        logger.info('set processor cache.')
        value = {
            'SITE_NAME': settings.SITE_NAME,
            'SITE_KEYWORDS': settings.SITE_SEO_KEYWORDS,
            'SITE_BASE_URL': requests.scheme + '://' + requests.get_host() + '/',
            'all_events_not_del': len(get_all_details()["data"]),
            'hisory_del_sets': get_deled_history_datas
        }
        cache.set(key, value, 60 * 60 * 10)
        return value
