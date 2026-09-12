<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>HealthFlow — Health Dashboard</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
  <style>
    :root{
      --bg:#f5f8fb;--card:#fff;--primary:#183b56;--primary-2:#245b7a;
      --accent:#2f80ed;--accent-soft:#eaf3ff;--green:#20a67a;--green-soft:#e8f8f2;
      --orange:#f2994a;--orange-soft:#fff3e8;--red:#eb5757;--red-soft:#ffeded;
      --text:#243746;--muted:#718096;--line:#e7edf3;--radius:18px;
      --shadow:0 8px 28px rgba(24,59,86,.07);
    }
    *{box-sizing:border-box;margin:0;padding:0}
    body{font-family:Inter,system-ui,sans-serif;background:var(--bg);color:var(--text);line-height:1.5}
    button,input{font:inherit} button{border:0;cursor:pointer} a{text-decoration:none;color:inherit}
    .app{display:flex;min-height:100vh}
    .sidebar{width:250px;background:#fff;border-right:1px solid var(--line);padding:24px 16px;position:fixed;inset:0 auto 0 0;z-index:20}
    .brand{display:flex;align-items:center;gap:10px;font-weight:800;font-size:21px;color:var(--primary);padding:4px 12px 28px}
    .brand i{color:var(--accent);font-size:24px}
    .brand span span{color:var(--accent)}
    .nav-title{font-size:11px;text-transform:uppercase;letter-spacing:1px;color:#a0aec0;padding:0 12px 10px}
    .nav{display:flex;flex-direction:column;gap:5px}
    .nav a{display:flex;align-items:center;gap:13px;padding:12px 13px;border-radius:12px;color:var(--muted);font-size:14px;font-weight:600;transition:.2s}
    .nav a i{width:20px;text-align:center}
    .nav a:hover,.nav a.active{background:var(--accent-soft);color:var(--accent)}
    .profile-mini{position:absolute;left:16px;right:16px;bottom:20px;border-top:1px solid var(--line);padding:18px 8px 0;display:flex;gap:10px;align-items:center}
    .avatar{width:40px;height:40px;border-radius:50%;background:linear-gradient(135deg,#dcecff,#b9dcff);display:grid;place-items:center;color:var(--primary);font-weight:800}
    .profile-mini strong{font-size:13px;display:block}.profile-mini small{color:var(--muted);font-size:11px}
    .main{margin-left:250px;flex:1;min-width:0}
    .topbar{height:76px;background:#fff;border-bottom:1px solid var(--line);display:flex;align-items:center;justify-content:space-between;padding:0 34px;position:sticky;top:0;z-index:10}
    .topbar h1{font-size:22px;color:var(--primary)} .topbar p{font-size:12px;color:var(--muted);margin-top:2px}
    .top-actions{display:flex;align-items:center;gap:10px}
    .search{background:var(--bg);border:1px solid var(--line);border-radius:12px;padding:9px 13px;display:flex;gap:8px;align-items:center}
    .search input{border:0;outline:0;background:transparent;width:180px;font-size:13px}
    .icon-btn{width:40px;height:40px;border-radius:12px;background:var(--bg);color:var(--muted);position:relative}
    .dot{position:absolute;width:7px;height:7px;border-radius:50%;background:var(--red);right:8px;top:7px;border:2px solid #fff}
    .content{padding:30px 34px 40px;max-width:1500px;margin:auto}
    .welcome{display:flex;justify-content:space-between;align-items:center;gap:20px;margin-bottom:24px}
    .welcome h2{font-size:27px;color:var(--primary)} .welcome p{color:var(--muted);font-size:13px;margin-top:4px}
    .btn{padding:11px 16px;border-radius:11px;font-weight:700;font-size:13px;display:inline-flex;gap:8px;align-items:center}
    .btn-primary{background:var(--accent);color:#fff}.btn-primary:hover{filter:brightness(.95)}
    .grid-stats{display:grid;grid-template-columns:repeat(4,1fr);gap:18px;margin-bottom:22px}
    .card{background:var(--card);border:1px solid var(--line);border-radius:var(--radius);box-shadow:var(--shadow)}
    .stat{padding:19px}.stat-head{display:flex;justify-content:space-between;align-items:center}
    .stat-label{font-size:12px;color:var(--muted);font-weight:600}.stat-icon{width:40px;height:40px;border-radius:12px;display:grid;place-items:center}
    .blue{background:var(--accent-soft);color:var(--accent)}.green{background:var(--green-soft);color:var(--green)}
    .orange{background:var(--orange-soft);color:var(--orange)}.red{background:var(--red-soft);color:var(--red)}
    .stat-value{font-size:25px;font-weight:800;color:var(--primary);margin-top:12px}.stat-value span{font-size:12px;font-weight:500;color:var(--muted)}
    .trend{font-size:11px;margin-top:5px;color:var(--green);font-weight:700}.trend.down{color:var(--red)}
    .main-grid{display:grid;grid-template-columns:1.65fr 1fr;gap:20px;margin-bottom:20px}
    .card-header{padding:19px 20px 0;display:flex;align-items:center;justify-content:space-between}
    .card-header h3{font-size:15px;color:var(--primary)}.card-header span{font-size:11px;color:var(--muted)}
    .chart-card{padding-bottom:18px}.chart-wrap{padding:10px 18px 0}
    .legend{display:flex;gap:18px;font-size:11px;color:var(--muted);margin:4px 4px 8px}
    .legend i{display:inline-block;width:8px;height:8px;border-radius:50%;margin-right:5px}
    .vitals{padding:0 20px 20px;display:grid;grid-template-columns:repeat(3,1fr);gap:12px}
    .vital{border:1px solid var(--line);border-radius:13px;padding:13px}.vital-top{display:flex;justify-content:space-between;color:var(--muted);font-size:11px}
    .vital strong{display:block;color:var(--primary);font-size:18px;margin-top:7px}.vital strong span{font-size:10px;color:var(--muted);font-weight:500}
    .progress{height:6px;background:#edf2f7;border-radius:99px;margin-top:9px;overflow:hidden}.progress b{display:block;height:100%;border-radius:99px;background:var(--accent)}
    .appointments{padding-bottom:16px}.appointment{display:flex;align-items:center;gap:12px;padding:14px 20px;border-top:1px solid var(--line)}
    .date-box{width:43px;height:48px;border-radius:11px;background:var(--accent-soft);color:var(--accent);display:grid;place-items:center;text-align:center;flex:none}
    .date-box b{font-size:16px;line-height:1}.date-box small{font-size:9px;text-transform:uppercase}
    .appointment-info{min-width:0;flex:1}.appointment-info strong{font-size:12px;display:block;color:var(--primary)}.appointment-info span{font-size:11px;color:var(--muted)}
    .status{font-size:10px;padding:5px 8px;border-radius:99px;font-weight:700}.confirmed{background:var(--green-soft);color:var(--green)}.pending{background:var(--orange-soft);color:var(--orange)}
    .bottom-grid{display:grid;grid-template-columns:1fr 1fr 1fr;gap:20px}
    .list{padding:8px 20px 18px}.list-row{display:flex;align-items:center;gap:11px;padding:12px 0;border-bottom:1px solid var(--line)}.list-row:last-child{border:0}
    .round-icon{width:34px;height:34px;border-radius:10px;display:grid;place-items:center;flex:none}.list-row .info{flex:1;min-width:0}.info strong{font-size:12px;display:block}.info span{font-size:10px;color:var(--muted)}
    .value{font-size:11px;font-weight:700;color:var(--primary);white-space:nowrap}
    .activity-ring{width:120px;height:120px;border-radius:50%;margin:17px auto 8px;display:grid;place-items:center;background:conic-gradient(var(--accent) 0 72%,#eaf0f5 72% 100%)}
    .activity-ring:after{content:"";width:91px;height:91px;border-radius:50%;background:#fff;position:absolute}
    .ring-inner{position:relative;z-index:1;text-align:center}.ring-inner strong{font-size:22px;color:var(--primary);display:block}.ring-inner span{font-size:10px;color:var(--muted)}
    .activity-foot{text-align:center;font-size:11px;color:var(--muted);padding-bottom:18px}
    .mobile-menu{display:none}.footer-note{text-align:center;color:#a0aec0;font-size:10px;margin-top:25px}
    @media(max-width:1100px){.grid-stats{grid-template-columns:repeat(2,1fr)}.bottom-grid{grid-template-columns:1fr 1fr}.main-grid{grid-template-columns:1fr}}
    @media(max-width:760px){.sidebar{transform:translateX(-100%);transition:.25s}.sidebar.open{transform:none}.main{margin-left:0}.mobile-menu{display:grid;width:40px;height:40px;border-radius:10px;background:var(--bg);color:var(--primary);place-items:center;margin-right:10px}.topbar{padding:0 16px}.topbar h1{font-size:18px}.search{display:none}.content{padding:22px 16px}.welcome{align-items:flex-start}.welcome h2{font-size:22px}.welcome .btn{display:none}.grid-stats{grid-template-columns:1fr 1fr;gap:12px}.stat{padding:15px}.stat-value{font-size:21px}.bottom-grid{grid-template-columns:1fr}.vitals{grid-template-columns:1fr 1fr}}
    @media(max-width:430px){.grid-stats{grid-template-columns:1fr}.vitals{grid-template-columns:1fr}.appointment .status{display:none}}
  </style>
</head>
<body>
<div class="app">
  <aside class="sidebar" id="sidebar">
    <div class="brand"><i class="fa-solid fa-heart-pulse"></i><span>Health<span>Flow</span></span></div>
    <div class="nav-title">Main Menu</div>
    <nav class="nav">
      <a class="active" href="#"><i class="fa-solid fa-chart-pie"></i> Dashboard</a>
      <a href="#appointments"><i class="fa-regular fa-calendar-check"></i> Appointments</a>
      <a href="#vitals"><i class="fa-solid fa-heart-pulse"></i> My Vitals</a>
      <a href="#medications"><i class="fa-solid fa-pills"></i> Medications</a>
      <a href="#activity"><i class="fa-solid fa-person-running"></i> Activity</a>
      <a href="#"><i class="fa-solid fa-file-medical"></i> Health Records</a>
    </nav>
    <div class="nav-title" style="margin-top:24px">Account</div>
    <nav class="nav">
      <a href="#"><i class="fa-solid fa-user"></i> Profile</a>
      <a href="#"><i class="fa-solid fa-gear"></i> Settings</a>
      <a href="#"><i class="fa-solid fa-right-from-bracket"></i> Sign Out</a>
    </nav>
    <div class="profile-mini">
      <div class="avatar">JD</div><div><strong>Jordan Davis</strong><small>Patient ID: HF-2048</small></div>
    </div>
  </aside>

  <main class="main">
    <header class="topbar">
      <div style="display:flex;align-items:center">
        <button class="mobile-menu" id="menuBtn"><i class="fa-solid fa-bars"></i></button>
        <div><h1>Health Dashboard</h1><p>Saturday, September 12, 2026</p></div>
      </div>
      <div class="top-actions">
        <div class="search"><i class="fa-solid fa-magnifying-glass"></i><input id="search" placeholder="Search health records..."></div>
        <button class="icon-btn" title="Notifications"><i class="fa-regular fa-bell"></i><span class="dot"></span></button>
        <button class="icon-btn" title="Profile"><i class="fa-regular fa-user"></i></button>
      </div>
    </header>

    <section class="content">
      <div class="welcome">
        <div><h2>Good evening, Jordan 👋</h2><p>Here is your health overview and today's wellness progress.</p></div>
        <button class="btn btn-primary" id="bookBtn"><i class="fa-solid fa-plus"></i> Book Appointment</button>
      </div>

      <div class="grid-stats">
        <div class="card stat"><div class="stat-head"><span class="stat-label">Heart Rate</span><span class="stat-icon red"><i class="fa-solid fa-heart-pulse"></i></span></div><div class="stat-value">72 <span>BPM</span></div><div class="trend"><i class="fa-solid fa-arrow-down"></i> 3% from yesterday</div></div>
        <div class="card stat"><div class="stat-head"><span class="stat-label">Blood Pressure</span><span class="stat-icon blue"><i class="fa-solid fa-droplet"></i></span></div><div class="stat-value">118/76 <span>mmHg</span></div><div class="trend"><i class="fa-solid fa-check"></i> Within normal range</div></div>
        <div class="card stat"><div class="stat-head"><span class="stat-label">Daily Steps</span><span class="stat-icon green"><i class="fa-solid fa-shoe-prints"></i></span></div><div class="stat-value">7,842</div><div class="trend"><i class="fa-solid fa-arrow-up"></i> 12% from yesterday</div></div>
        <div class="card stat"><div class="stat-head"><span class="stat-label">Sleep</span><span class="stat-icon orange"><i class="fa-solid fa-moon"></i></span></div><div class="stat-value">7h 42m</div><div class="trend"><i class="fa-solid fa-arrow-up"></i> 8% better than average</div></div>
      </div>

      <div class="main-grid">
        <div class="card chart-card">
          <div class="card-header"><h3>Heart Rate Overview</h3><span>Last 7 days</span></div>
          <div class="chart-wrap">
            <div class="legend"><span><i style="background:#2f80ed"></i>Average BPM</span><span><i style="background:#20a67a"></i>Resting BPM</span></div>
            <svg viewBox="0 0 760 250" width="100%" height="230" role="img" aria-label="Heart rate weekly chart">
              <g stroke="#edf1f5" stroke-width="1"><line x1="55" y1="30" x2="740" y2="30"/><line x1="55" y1="82" x2="740" y2="82"/><line x1="55" y1="134" x2="740" y2="134"/><line x1="55" y1="186" x2="740" y2="186"/></g>
              <g fill="#8a99a8" font-size="10"><text x="20" y="34">90</text><text x="20" y="86">80</text><text x="20" y="138">70</text><text x="20" y="190">60</text></g>
              <polyline fill="none" stroke="#2f80ed" stroke-width="4" stroke-linecap="round" stroke-linejoin="round" points="55,115 168,96 281,126 394,82 507,106 620,74 740,102"/>
              <polyline fill="none" stroke="#20a67a" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" points="55,156 168,146 281,161 394,139 507,150 620,134 740,143"/>
              <g fill="#2f80ed"><circle cx="55" cy="115" r="4"/><circle cx="168" cy="96" r="4"/><circle cx="281" cy="126" r="4"/><circle cx="394" cy="82" r="4"/><circle cx="507" cy="106" r="4"/><circle cx="620" cy="74" r="4"/><circle cx="740" cy="102" r="5"/></g>
              <g fill="#7b8794" font-size="10" text-anchor="middle"><text x="55" y="214">Sun</text><text x="168" y="214">Mon</text><text x="281" y="214">Tue</text><text x="394" y="214">Wed</text><text x="507" y="214">Thu</text><text x="620" y="214">Fri</text><text x="740" y="214">Sat</text></g>
            </svg>
          </div>
          <div class="vitals" id="vitals">
            <div class="vital"><div class="vital-top"><span>Oxygen Level</span><i class="fa-solid fa-lungs"></i></div><strong>98 <span>% SpO₂</span></strong><div class="progress"><b style="width:98%"></b></div></div>
            <div class="vital"><div class="vital-top"><span>Temperature</span><i class="fa-solid fa-temperature-half"></i></div><strong>98.4 <span>°F</span></strong><div class="progress"><b style="width:76%"></b></div></div>
            <div class="vital"><div class="vital-top"><span>Weight</span><i class="fa-solid fa-weight-scale"></i></div><strong>71.8 <span>kg</span></strong><div class="progress"><b style="width:68%"></b></div></div>
          </div>
        </div>

        <div class="card appointments" id="appointments">
          <div class="card-header"><h3>Upcoming Appointments</h3><span>View all</span></div>
          <div class="appointment"><div class="date-box"><b>14</b><small>Sep</small></div><div class="appointment-info"><strong>Dr. Emily Carter</strong><span>Cardiology · 10:30 AM</span></div><span class="status confirmed">Confirmed</span></div>
          <div class="appointment"><div class="date-box"><b>18</b><small>Sep</small></div><div class="appointment-info"><strong>Dr. Michael Lee</strong><span>General Checkup · 02:00 PM</span></div><span class="status pending">Pending</span></div>
          <div class="appointment"><div class="date-box"><b>25</b><small>Sep</small></div><div class="appointment-info"><strong>Dr. Sarah Wilson</strong><span>Nutrition · 11:15 AM</span></div><span class="status confirmed">Confirmed</span></div>
        </div>
      </div>

      <div class="bottom-grid">
        <div class="card" id="medications">
          <div class="card-header"><h3>Today's Medications</h3><span>3 doses</span></div>
          <div class="list">
            <div class="list-row"><div class="round-icon blue"><i class="fa-solid fa-capsules"></i></div><div class="info"><strong>Vitamin D3</strong><span>1 tablet · Morning</span></div><span class="status confirmed">Taken</span></div>
            <div class="list-row"><div class="round-icon green"><i class="fa-solid fa-pills"></i></div><div class="info"><strong>Omega-3</strong><span>1 capsule · Lunch</span></div><span class="status confirmed">Taken</span></div>
            <div class="list-row"><div class="round-icon orange"><i class="fa-solid fa-tablets"></i></div><div class="info"><strong>Daily Medication</strong><span>1 tablet · 8:00 PM</span></div><span class="status pending">Upcoming</span></div>
          </div>
        </div>

        <div class="card" id="activity">
          <div class="card-header"><h3>Daily Activity</h3><span>Today</span></div>
          <div class="activity-ring"><div class="ring-inner"><strong>72%</strong><span>Goal reached</span></div></div>
          <div class="activity-foot">5,040 / 7,000 active calories target<br><b style="color:var(--primary)">Keep moving — you're doing great!</b></div>
        </div>

        <div class="card">
          <div class="card-header"><h3>Health Insights</h3><span>This week</span></div>
          <div class="list">
            <div class="list-row"><div class="round-icon green"><i class="fa-solid fa-bed"></i></div><div class="info"><strong>Sleep improved</strong><span>Average increased by 42 minutes</span></div></div>
            <div class="list-row"><div class="round-icon blue"><i class="fa-solid fa-person-walking"></i></div><div class="info"><strong>Activity goal</strong><span>You've met it 5 days this week</span></div></div>
            <div class="list-row"><div class="round-icon orange"><i class="fa-solid fa-glass-water"></i></div><div class="info"><strong>Hydration</strong><span>2.1L of your 2.5L daily goal</span></div></div>
          </div>
        </div>
      </div>
      <div class="footer-note">HealthFlow dashboard demo · Sample data for UI demonstration only</div>
    </section>
  </main>
</div>
<script>
  const sidebar=document.getElementById('sidebar');
  document.getElementById('menuBtn').addEventListener('click',()=>sidebar.classList.toggle('open'));
  document.querySelectorAll('.nav a').forEach(a=>a.addEventListener('click',()=>sidebar.classList.remove('open')));
  document.getElementById('bookBtn').addEventListener('click',()=>alert('Appointment booking flow opened.'));
  document.getElementById('search').addEventListener('input',e=>{
    if(e.target.value.trim()) console.log('Searching health records for:',e.target.value);
  });
</script>
</body>
</html>
