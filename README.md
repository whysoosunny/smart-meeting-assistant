# Smart Meeting Assistant — Sunny's setup copy

Prepared from the uploaded piyush-eon/Smart-Meeting-Assistant repository.
Original source: https://github.com/piyush-eon/Smart-Meeting-Assistant
This is an adapted setup copy, not a claim of original authorship. No license was included in the uploaded archive; confirm permission or applicable terms before redistributing it.

## What it does
- Browser video meetings using Stream Video.
- A live caption panel using Stream closed-caption events.
- A Python Vision Agents bot that joins the same call and uses Gemini Realtime.
- Voice questions beginning with “Hey Assistant”, answered using meeting context.
- A terminal transcript at shutdown. This is not persistent database storage or a structured AI summary.

## Windows setup
1. Extract this ZIP to a folder such as C:\Projects\Smart-Meeting-Assistant-Sunny.
2. Install Node.js 22 LTS or newer and Python 3.13 with its Windows launcher.
3. Double-click setup-windows.cmd. Internet access is required to install packages.
4. Create a Stream application at https://getstream.io/ with Video and Chat enabled. Obtain its API key and secret. Enable captions/transcription for the default call type and ensure user roles have the needed call and channel permissions.
5. Get a Gemini API key at https://aistudio.google.com/ with access to the realtime model supported by the installed Vision Agents plugin.
6. Open frontend/.env.local in Notepad. Replace the Stream key in BOTH key fields and add the Stream secret.
7. Open backend/.env. Add the SAME Stream key and secret, plus your Gemini key in GOOGLE_API_KEY.
8. Keep NEXT_PUBLIC_CALL_ID and CALL_ID identical: sunny-meeting.
9. Double-click start-frontend.cmd. Open http://localhost:3000, enter your name and join. Allow microphone and camera access.
10. Double-click start-assistant.cmd. Wait for the bot to join. Speak normally, then try “Hey Assistant, what did we discuss?”
11. Stop the assistant with Ctrl+C. Stop the frontend terminal with Ctrl+C.

Do not paste API secrets into chat or commit actual .env files. Provider accounts, enabled features, quotas and billing are controlled by the providers.

## Troubleshooting
- Missing API credentials: edit frontend/.env.local and restart the frontend.
- Assistant missing credentials: edit backend/.env, then restart it.
- Different rooms: ensure both call ID variables match, then restart both processes.
- Loading forever or denied permissions: check browser console, Stream dashboard permissions, and that Video and Chat belong to the same application.
- Captions unavailable: check the Stream call type caption settings and role permissions. Captions and Gemini transcription are separate paths.
- Python installation fails: use Python 3.13; the supplied project requests >=3.13. Native media dependencies may require a supported environment or WSL2.
- Gemini model errors: confirm model availability and compatibility of the installed vision-agents version. The original frontend lockfile and Python dependency declarations are retained; upgrades may require SDK changes.

## Changes in this copy
Added environment templates and Windows setup/start scripts; aligned default meeting IDs; used unique participant IDs so matching display names do not collide; validated token user IDs; changed issued participants from admin to user; surfaced token errors; used the active call ID for transcript channels; added a backend credential check.

## Verification and limits
Python syntax and project/configuration consistency were checked locally. Frontend dependency installation was attempted offline but failed because packages were not cached. The setup script uses --legacy-peer-deps for the supplied React peer dependency conflict. Production build, calls, captions and Gemini audio were not verified here because external package/provider access and credentials were unavailable. This is a prepared source package, not a verified live deployment.

The original sample has no real login and issues tokens to submitted IDs. Keep this as a local development demo; implement authentication, server-side identity checks, authorized room membership and token rate limits before public deployment. The bot's silence/wake phrase behavior relies on model instructions and is not a hard audio gate.

## Interview explanation
“The project uses a Next.js frontend for video meetings and a Python assistant for meeting-aware voice questions. Stream handles video, chat and captions; Gemini handles the AI conversation. The two processes use the same meeting ID. I worked on setting up and adapting an existing project.”
