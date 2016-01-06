#!/usr/bin/env python

# docs: http://github3py.readthedocs.org/en/latest/api.html

import os
from github3 import login

TT_GITHUB_TOKEN=os.environ.get('TT_GITHUB_TOKEN')

def _pre(condition, error_msg):
        if not condition:
            print 'precondition failed. ', error_msg
            exit(1)

def repositories(separator=' '):
    _pre(TT_GITHUB_TOKEN, '\nexport TT_GITHUB_TOKEN=""')

    gh = login(token=TT_GITHUB_TOKEN)
    org = gh.organization('paulsecret')
    repos = org.repositories(type='private')
    
    return separator.join([repo.name for repo in repos])

if __name__ == "__main__":
    print repositories('\n')

