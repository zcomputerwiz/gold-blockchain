from typing import Generator, KeysView

SERVICES_FOR_GROUP = {
    "all": "gold_harvester gold_timelord_launcher gold_timelord gold_farmer gold_full_node gold_wallet".split(),
    "node": "gold_full_node".split(),
    "harvester": "gold_harvester".split(),
    "farmer": "gold_harvester gold_farmer gold_full_node gold_wallet".split(),
    "farmer-no-wallet": "gold_harvester gold_farmer gold_full_node".split(),
    "farmer-only": "gold_farmer".split(),
    "timelord": "gold_timelord_launcher gold_timelord gold_full_node".split(),
    "timelord-only": "gold_timelord".split(),
    "timelord-launcher-only": "gold_timelord_launcher".split(),
    "wallet": "gold_wallet gold_full_node".split(),
    "wallet-only": "gold_wallet".split(),
    "introducer": "gold_introducer".split(),
    "simulator": "gold_full_node_simulator".split(),
}


def all_groups() -> KeysView[str]:
    return SERVICES_FOR_GROUP.keys()


def services_for_groups(groups) -> Generator[str, None, None]:
    for group in groups:
        for service in SERVICES_FOR_GROUP[group]:
            yield service


def validate_service(service: str) -> bool:
    return any(service in _ for _ in SERVICES_FOR_GROUP.values())
