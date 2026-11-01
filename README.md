# Smart Meeting Assistant

Video meetings with live captions and a meeting-aware AI voice assistant.

**Maintained by [Sunny Kumar](https://github.com/whysoosunny)** · Next.js · Python · Stream · Gemini

## Overview

Smart Meeting Assistant brings video calling, live captions, and contextual voice assistance into one meeting workflow. Participants join through a browser while a Python assistant connects to the same room and responds to questions introduced with **“Hey Assistant.”**

## Features

- Browser-based audio and video meetings with participant controls.
- Live caption panel powered by Stream closed-caption events.
- Meeting-aware voice responses through Gemini Realtime and Vision Agents.
- Shared meeting identifiers across the web application and assistant.
- Unique participant identities and server-side Stream token generation.
- In-memory transcript collection with terminal output when the assistant stops.
- Windows setup and launch scripts.

## Technology

| Layer | Technologies |
| --- | --- |
| Web application | Next.js App Router, React, Tailwind CSS |
| Video and captions | Stream Video |
| Messaging | Stream Chat |
| Assistant | Python, Vision Agents, Gemini Realtime |
| Configuration | Environment variables, python-dotenv |

## Repository layout

| Path | Purpose |
| --- | --- |
| `frontend/app/` | Join screen, meeting route, components, hooks, and token API |
| `frontend/public/` | Static assets |
| `backend/main.py` | Default meeting assistant entry point |
| `backend/main-alt.py` | Alternative assistant implementation |
| `setup-windows.cmd` | Install dependencies and initialize local configuration |
| `start-frontend.cmd` | Start the web application |
| `start-assistant.cmd` | Start the default assistant |

## Local setup on Windows

### Requirements

- Node.js 22 or newer and npm.
- Python 3.13 with the Windows Python launcher.
- A Stream application with Video and Chat enabled.
- A Google API key with access to a Gemini realtime model compatible with the installed Vision Agents plugin.

### 1. Get the repository

```bat
git clone https://github.com/whysoosunny/smart-meeting-assistant.git
cd smart-meeting-assistant
setup-windows.cmd
```

The setup script creates a Python virtual environment, installs dependencies, and initializes the local environment files. It uses `npm ci --legacy-peer-deps` for the current dependency set.

### 2. Configure services

Set the following values in `frontend/.env.local`:

```dotenv
NEXT_PUBLIC_STREAM_API_KEY=your_stream_api_key
STREAM_API_KEY=your_stream_api_key
STREAM_API_SECRET=your_stream_api_secret
NEXT_PUBLIC_CALL_ID=sunny-meeting
```

Set the following values in `backend/.env`:

```dotenv
STREAM_API_KEY=your_stream_api_key
STREAM_API_SECRET=your_stream_api_secret
GOOGLE_API_KEY=your_google_api_key
CALL_ID=sunny-meeting
```

Use the same Stream application and call ID in both files. Enable captions for the Stream default call type and configure the required user, call, and channel permissions. Keep actual environment files private; only the public Stream key belongs in a `NEXT_PUBLIC_` variable.

### 3. Start a meeting

```bat
start-frontend.cmd
```

Open [localhost:3000](http://localhost:3000), enter a display name, join the meeting, and allow microphone and camera access. Open a second terminal in the repository directory and run:

```bat
start-assistant.cmd
```

Once the assistant joins, try **“Hey Assistant, what have we discussed so far?”** Stop each process with `Ctrl+C`.

## How it works

1. The web app assigns a participant ID and requests a Stream token from its server route.
2. The browser joins the configured video room and displays caption events.
3. The Python assistant joins the matching room through Vision Agents.
4. Gemini processes the conversation and is instructed to answer questions addressed to the assistant.
5. The assistant retains transcript data in memory and prints it on shutdown.

## Development checks

```bat
cd frontend
npm run lint
npm run build
```

From the repository root, check Python syntax with:

```bat
py -3.13 -m compileall -q backend
```

These checks do not validate provider credentials or live meeting behavior. Verify calls, captions, and assistant audio with configured provider accounts.

## Current scope

The application is a local development demo. Persistent transcript storage, structured summary exports, account authentication, and authorized room membership are future improvements. The token endpoint currently accepts submitted participant IDs; authentication, identity validation, and rate limiting are needed before public deployment. The wake phrase is enforced through model instructions rather than a deterministic audio gate.

## Troubleshooting

| Issue | Check |
| --- | --- |
| Missing API credentials | Update the appropriate environment file and restart the process. |
| Assistant joins a different room | Match `CALL_ID` and `NEXT_PUBLIC_CALL_ID`. |
| Captions do not appear | Check Stream caption settings and role permissions. |
| Gemini connection fails | Check API access, quota, model availability, and SDK compatibility. |
| Python dependencies fail to install | Use Python 3.13; native media dependencies may require WSL2. |

## Maintenance

Maintainer: **[Sunny Kumar (@whysoosunny)](https://github.com/whysoosunny)**.

Report reproducible issues through [GitHub Issues](https://github.com/whysoosunny/smart-meeting-assistant/issues). Include setup steps and relevant errors, with credentials removed.
