# LICHBORNE GEAR TRACKER — CHANGELOG

All entries: newest first.

---

## v1.77 — 2026-03-29

- **Discord feedback added** — Info box now shows Discord username (jared2219) under a "Feedback & Bug Reports" section, making it easier for users to report issues or share feedback
- **Logout Orphaned Bots — full button lockout** — All buttons (including Invite Raid, Invite Group, and Stop) are now disabled while orphaned bots are being logged out; previously the Invite Raid button remained clickable
- **+Add Target GS / +Add Target Spec — button lockout** — Clicking either button now disables all other buttons (including Stop, Invite Raid, and Invite Group) until the scan finishes, preventing conflicting operations
- **+Add Target GS / +Add Target Spec — guaranteed unlock** — Rewrote both buttons to use the same self-contained loop pattern as the group scan buttons. The loop that locks buttons also owns the unlock, so buttons always re-enable when the scan completes, fails, or hits the 15-second safety timeout
- **+Add Target GS — fixed permanent lock** — If item data fails to cache (common with bot characters), the scan now gives up after 5 retries (~7.5s) and uses whatever data is available instead of locking buttons forever
- **Version labels** — TOC, title bar, and info box aligned to `1.77`

> **Development note:** This release consolidates internal builds 1.77.1 through 1.77.8.
> Those iterations were all pre-release debugging work on the button lockout system
> and are not separately numbered public versions.

---

## v1.76 — prior session

- **Global variable audit** — Converted `activeTab`, four UI state vars, `RefreshRaidRows`, `RefreshAllRows`, `UpdateSummary`, and `RH2` from accidental globals to proper `local` declarations, eliminating addon conflict risk
- **Tier 0 color fix** — Tier 0 dropdown now correctly displays its silver-blue color instead of rendering white (key `18` lookup was previously resolving to `nil`)
- **Inspect timer bug fix** — `inspectWait` moved to module top so the GS scan timer resets correctly; previously the reset wrote to a different variable and the timer never actually cleared
- **Deduplicated `classMap`** — Three identical inline `classMap` tables replaced with a single module-level `CLASS_TOKEN_MAP` constant

---

## v1.75 — prior session

- **Minimap icon fix (improved)** — Fixed display issue on machines where bundled libs failed to load silently
- **Native fallback minimap button** — Activates automatically when LibDBIcon is unavailable (based on DBM implementation)
- **Updated libs** — Replaced bundled libs with DBM-compatible versions for wider client support
- **Load order fix** — Moved lib registration into ADDON_LOADED for correct initialization
- **Minimap icon updated** — Changed to book texture (INV_Misc_Book_11) for a cleaner look

---

## v1.74 and earlier

See repository commit history.
