#!/usr/bin/env bash
# Lab 4 in-class assignment - environment generator. Run once:  bash setup.sh
set -e
ROOT="$HOME/lab4/webserver"
rm -rf "$HOME/lab4"
mkdir -p "$ROOT"/{logs,data,reports}

# ---------- access log ----------
AL="$ROOT/logs/access.log"
: > "$AL"
add(){ echo "$1 $2 $3 $4 $5 $6 $7" >> "$AL"; }
# date time ip method path status bytes
add 2026-11-10 08:02:11 10.0.0.15 GET /index.html 200 5321
add 2026-11-10 08:05:43 10.0.0.15 GET /style.css 200 1204
add 2026-11-10 08:11:07 10.0.0.22 GET /index.html 200 5321
add 2026-11-10 08:19:55 10.0.0.91 GET /admin 403 142
add 2026-11-10 09:01:30 10.0.0.15 POST /login 200 318
add 2026-11-10 09:04:12 10.0.0.77 GET /missing.html 404 162
add 2026-11-10 09:07:48 10.0.0.22 GET /about.html 200 2890
add 2026-11-10 09:15:03 10.0.0.91 GET /admin 403 142
add 2026-11-10 09:22:19 10.0.0.15 GET /index.html 200 5321
add 2026-11-10 09:30:00 10.0.0.34 GET /index.html 200 5321
add 2026-11-10 10:02:44 10.0.0.77 GET /nothere.html 404 162
add 2026-11-10 10:14:21 10.0.0.91 POST /admin 403 142
add 2026-11-10 10:33:09 10.0.0.22 GET /style.css 200 1204
add 2026-11-10 10:41:57 10.0.0.15 GET /report.pdf 200 88210
add 2026-11-10 11:03:12 10.0.0.34 GET /about.html 200 2890
add 2026-11-10 11:17:40 10.0.0.91 GET /admin 403 142
add 2026-11-10 11:28:06 10.0.0.77 GET /index.html 200 5321
add 2026-11-10 11:44:33 10.0.0.15 GET /style.css 200 1204
add 2026-11-10 12:05:19 10.0.0.22 GET /index.html 200 5321
add 2026-11-10 12:31:58 10.0.0.91 GET /admin 403 142
add 2026-11-10 13:02:07 10.0.0.34 POST /login 500 94
add 2026-11-10 13:19:44 10.0.0.15 GET /index.html 200 5321
add 2026-11-10 13:47:11 10.0.0.77 GET /style.css 200 1204
add 2026-11-10 14:08:35 10.0.0.22 GET /report.pdf 200 88210
add 2026-11-10 14:22:50 10.0.0.34 GET /index.html 200 5321
add 2026-11-10 14:51:16 10.0.0.15 GET /about.html 200 2890
add 2026-11-10 15:10:03 10.0.0.91 GET /admin 403 142
add 2026-11-10 15:33:29 10.0.0.77 POST /login 200 318
add 2026-11-10 15:58:41 10.0.0.22 GET /index.html 200 5321
add 2026-11-10 16:12:08 10.0.0.34 GET /style.css 200 1204

# ---------- system log ----------
SL="$ROOT/logs/system.log"
cat > "$SL" << 'EOF'
2026-11-10 08:00:01 INFO server started
2026-11-10 08:30:12 INFO backup completed
2026-11-10 09:15:44 WARNING memory usage above 80 percent
2026-11-10 09:45:02 INFO cache cleared
2026-11-10 10:02:33 ERROR database connection timeout
2026-11-10 10:30:19 INFO retry succeeded
2026-11-10 11:11:11 WARNING disk usage above 75 percent
2026-11-10 12:00:00 INFO scheduled job started
2026-11-10 12:45:38 ERROR failed to write temp file
2026-11-10 13:02:07 CRITICAL service crashed
2026-11-10 13:05:22 INFO service restarted
2026-11-10 14:20:55 WARNING slow query detected
2026-11-10 15:30:41 ERROR database connection timeout
2026-11-10 16:00:00 INFO daily summary generated
EOF

# ---------- employees csv ----------
cat > "$ROOT/data/staff.csv" << 'EOF'
id,name,department,role
101,Ayse,engineering,developer
102,Bora,engineering,developer
103,Cem,finance,analyst
104,Deniz,engineering,manager
105,Ela,hr,recruiter
106,Furkan,finance,analyst
107,Gizem,engineering,developer
108,Hakan,hr,manager
109,Irem,finance,manager
110,Jale,engineering,tester
EOF

# ---------- a protected file for the permissions part ----------
echo "internal notes" > "$ROOT/reports/notes.txt"
chmod 644 "$ROOT/reports/notes.txt"

echo "Setup complete: $ROOT"
