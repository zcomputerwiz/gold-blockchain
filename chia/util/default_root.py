import os
from pathlib import Path

DEFAULT_ROOT_PATH = Path(os.path.expanduser(os.getenv("GOLD_ROOT", "~/.gold/mainnet"))).resolve()

DEFAULT_KEYS_ROOT_PATH = Path(os.path.expanduser(os.getenv("GOLD_KEYS_ROOT", "~/.gold_keys"))).resolve()
