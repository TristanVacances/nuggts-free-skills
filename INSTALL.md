# Install a skill (2 minutes)

You need a Claude account with **code execution enabled** (Settings → Capabilities). Skills work on Free, Pro, Max, Team and Enterprise.

## Claude app (web, desktop, Cowork): no terminal
1. Download the skill's zip from the [Releases](../../releases) page (e.g. `kickoff.zip`).
2. In Claude, go to **Customize → Skills**.
3. Click **+**, then **Create skill**, then **Upload a skill**, and pick the zip.
4. Start a new chat and type `/kickoff`, or just describe what you want; the skill fires on its own when it's relevant.

Uploaded skills also sync to Claude Code when you're signed in with the same account (v2.1.273+).

## Claude Code (terminal)
```bash
git clone https://github.com/TristanVacances/nuggts-free-skills
cp -R nuggts-free-skills/skills/kickoff ~/.claude/skills/
```

## Troubleshooting
- **Upload fails:** the zip must contain a folder with the skill's exact name and `SKILL.md` inside. Use the zips from Releases as they are.
- **Skill doesn't fire:** start a fresh chat after installing, or call it by name (`/boil-the-ocean`).

---

# Installer un skill (2 minutes)

Il te faut un compte Claude avec **l'exécution de code activée** (Paramètres → Fonctionnalités). Ça marche sur Free, Pro, Max, Team et Enterprise.

## App Claude (web, desktop, Cowork) : sans terminal
1. Télécharge le zip du skill sur la page [Releases](../../releases) (ex. `kickoff.zip`).
2. Dans Claude : **Customize → Skills**.
3. **+**, puis **Create skill**, puis **Upload a skill**, et choisis le zip.
4. Ouvre une nouvelle conversation et tape `/kickoff`. Ou décris simplement ce que tu veux : le skill se déclenche tout seul quand il est utile.

Les menus peuvent être en anglais. Si l'upload échoue, vérifie que tu utilises bien le zip tel quel.
