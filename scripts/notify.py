#!/usr/bin/env python3
"""Avisa un hito al humano por Telegram (chat privado). Sin dependencias.

Uso:  NOTIFY_BOT_TOKEN=... NOTIFY_CHAT_ID=... python3 notify.py "✅ APRUEBA abc1234"
      echo "texto" | python3 notify.py
"""
import json, os, sys, urllib.parse, urllib.request


def send(text: str) -> int:
    token, chat = os.environ.get("NOTIFY_BOT_TOKEN", ""), os.environ.get("NOTIFY_CHAT_ID", "")
    if not token or not chat:
        sys.exit("Faltan NOTIFY_BOT_TOKEN y/o NOTIFY_CHAT_ID")
    if chat.startswith("-"):
        sys.exit("NOTIFY_CHAT_ID es un grupo; los hitos van solo a un chat privado")
    data = urllib.parse.urlencode({"chat_id": chat, "text": text[:4000]}).encode()
    url = f"https://api.telegram.org/bot{token}/sendMessage"
    with urllib.request.urlopen(url, data, timeout=20) as r:
        return json.load(r)["result"]["message_id"]


if __name__ == "__main__":
    msg = " ".join(sys.argv[1:]) or sys.stdin.read()
    if not msg.strip():
        sys.exit("Mensaje vacío")
    print("enviado, message_id", send(msg))
