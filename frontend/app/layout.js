import "./globals.css";

export const metadata = {
  title: "Smart Meeting Assistant",
  description: "Video meetings, live captions, and a meeting-aware voice assistant.",
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
