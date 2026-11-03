# Lab 4 Assignment
## Incident Report: What Happened Yesterday?

**Time:** 90 minutes

**Submit:** Fill in `answers.md`, then please commit and push before the end of the session.

**Late Submission:** Late submissions: work pushed between 11:30 and 12:30 loses 20% of its mark. Work pushed after 12:30 and before 23:59 today, on Tuesday Nov 3rd, loses 50%. Unfortunately, nothing is accepted after that.

---

## The situation

You are the on-call administrator for a small web server.

Yesterday at around 1pm the service went down for a few minutes. Your manager wants
a short written incident report by the end of the day: what the traffic looked like,
whether anyone was poking at the system, and what the server itself said when it failed.

Nobody is going to read your terminal history. They are going to read the file you hand in.

**Set up your working copy of the logs:**

```
bash setup.sh
cd ~/lab4/webserver
```

```
logs/access.log     every request the server received
logs/system.log     what the server reported about itself
reports/            where your report goes
```

A line in `access.log` looks like this:

```
2026-11-10 08:02:11 10.0.0.15 GET /index.html 200 5321
   date     time       ip     method   path   status bytes
```

A line in `system.log` looks like this:

```
2026-11-10 09:15:44 WARNING memory usage above 80 percent
```

---

## Ground rules

Everything here can be done with what we covered in Labs 1-4:

`pwd` `ls` `cd` `cat` `echo` `touch` `chmod` `ps`
`head` `tail` `grep` `cut` `sort` `uniq` `wc` `tr` `tee`
`vim` / `nano`
`>` `>>` `2>` `&>` `/dev/null` `|` `<<EOF` `<<<`

> **Record the command you used for every question.** We are marking how you found
> the answer, not only the answer itself. An admin who can't show their working can't be trusted.

---

## Part A: Start the report

**A1.** Start the incident report. Create `reports/report.txt` **using a terminal editor**
(you may not have a GUI on a real server, this is why we learn these). It should open with:

```
SERVER REPORT
Prepared by: <your name>
```

Show that the file exists and contains what you intended.

**A2.** You want a section divider in the report:

```
---
TRAFFIC
---
```

Add all three lines **in a single command**, without opening the editor again and without
running `echo` three times.

**A3.** A colleague messages you the description they were given:
`the server crashed at one pm`. You need to know how many words it is, for a summary field
with a six-word limit. Count them **without creating a file**.

---

## Part B: Getting output where you want it

**B1.** Your manager's first question will be "how much traffic was there?".
Get the total number of requests into `reports/total.txt` so you don't have to recount later.

**B2.** You run `ls logs/ nosuchfolder/` and get a mix of results and a complaint on screen.
On a real server you often need these separated, results go in a report, complaints go in
a ticket.

   a) Capture **only the complaint** into `err.txt`, leaving the results on screen.
   b) Capture **everything, both kinds**, into `all.txt`.

Show both commands and what ended up in each file.

**B3.** A script you run every hour prints a harmless error you have already investigated
and don't want to see again. Demonstrate how to silence an error so it appears
**nowhere**, not on screen, not in a file. Name the mechanism you used.

**B4.** You want to read the end of the system log **and** keep a copy of exactly what you
read, to paste into the ticket later. Do both in **one** command, don't run it twice, and
don't open the file afterwards.

---

## Part C: The investigation

Answer each with **one pipeline**, and say what it tells you.

**C1.** How many **distinct clients** contacted the server yesterday?

**C2.** Was the traffic spread evenly, or is one client responsible for a disproportionate
share? Produce the ranking that answers this, and state who the heaviest client was.

**C3.** How healthy was the service overall? Break the requests down by response code,
most common first. Based on what you see, roughly what fraction of requests failed?

**C4.** Security has asked whether anyone was probing a restricted area. The `403` code
means "access denied". Find out whether these came from many clients or just one,
and name the client.

**C5.** Before you close the investigation, check the machine you are working on.
A colleague asks how many processes are currently running under your own user account.
Answer it with a pipeline rather than counting by eye.

---

## Part D: Hand in the report

Your findings are useless sitting in your terminal. Put them in the file.
`reports/report.txt` already has its header from Part A, **add to it, don't overwrite it.**

**D1.** Record the total request count in the report.

**D2.** Record the response-code breakdown from C3.

**D3.** Record the evidence for the security question: every denied request, followed by the
single most severe line in `system.log`, the one that explains the outage.

**D4.** Read the finished report back to check it. Then protect it: once a report is filed,
nobody should be able to edit it by accident. Show the permissions proving it is locked.

---

## Bonus (optional, +5 points)

Completely optional. If you'd like to challenge yourself, feel free to answer this section too.


**F1.** Your manager asks when the traffic peaked. Produce a count of requests per **hour**
of the day, in one pipeline.
*Hint: the time field is `HH:MM:SS` — `cut` can split on something other than a space.*

**F2.** If you ignore the suspicious client entirely, how many legitimate requests remain?

**F3.** Save the list of distinct clients to a file **and** report how many there were, in one
command.

**F4.** One failure in `system.log` happened more than once, which suggests a recurring
fault rather than a one-off. Identify it and say how often it occurred.

**F5.** HR wants to know which team to notify. `data/staff.csv` holds the staff list, with
commas between fields instead of spaces. Produce a headcount per department.
*Hint: the first line is a header and must not be counted, `tail -n +2` will skip it.*

**F6.** The ticketing system requires staff names in capitals. Produce them.
