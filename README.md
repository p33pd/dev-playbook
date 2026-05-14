# Development ansible playbook

## Installation

```bash
git clone <repo-url> && cd dev-playbook
./setup.sh
```

`setup.sh` will:
1. Install system Python deps (`python3`, `python3-pip`, `python3-libdnf5`) via dnf
2. Create a project-local Python venv at `./.venv`
3. Install `ansible` and `ansible-lint` into the venv
4. Install Ansible Galaxy collections from `requirements.yml`
5. Lint the playbook
6. Run the playbook (will prompt for sudo password)
