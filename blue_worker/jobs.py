from abcli.plugins import tags
import abcli.logging
import logging

logger = logging.getLogger(__name__)


def flow(tag, operation="", html=True):
    _operation = f"_{operation}" if operation else ""
    return (
        "".join(
            [
                f'<a href="/tag/{tag},~started{_operation},~completed{_operation}">'
                if html
                else "",
                str(tags.count(f"{tag},~started{_operation},~completed{_operation}")),
                "</a>" if html else "",
            ]
        )
        + "-"
        + "".join(
            [
                f'<a href="/tag/{tag},started{_operation}">' if html else "",
                str(tags.count(f"{tag},started{_operation}")),
                "</a>" if html else "",
            ]
        )
        + "->"
        + "".join(
            [
                f'<a href="/tag/{tag},completed{_operation}">' if html else "",
                str(tags.count(f"{tag},completed{_operation}")),
                "</a>" if html else "",
            ]
        )
    )


def state(tag, html=True):
    return "".join(
        [
            f'<a href="/tag/{tag}">' if html else "",
            str(tags.count(tag)),
            "</a>" if html else "",
        ]
    )
