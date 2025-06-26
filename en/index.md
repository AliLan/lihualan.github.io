---
layout: default
title: Welcome to My Blog
subtitle: Recording my learning and growth
permalink: /en/
---

<!-- 语言选择弹窗 -->
<div id="languageModal" class="language-modal">
  <div class="language-modal-content">
    <div class="language-modal-header">
      <h2>🌍 选择语言 / Choose Language</h2>
    </div>
    <div class="language-modal-body">
      <p>请选择您偏好的语言 / Please select your preferred language:</p>
      <div class="language-buttons">
        <button class="language-btn chinese-btn" onclick="selectLanguage('chinese')">
          <span class="flag">🇨🇳</span>
          <span class="language-text">中文</span>
          <span class="language-sub">Chinese</span>
        </button>
        <button class="language-btn english-btn" onclick="selectLanguage('english')">
          <span class="flag">🇺🇸</span>
          <span class="language-text">English</span>
          <span class="language-sub">英语</span>
        </button>
      </div>
    </div>
  </div>
</div>

<div style="text-align:right; margin-top:1rem;">
  <a href="/">中文</a> | <b>English</b>
</div>

<div class="nature-bg">
  <div class="main-columns">
    <div class="main-left">
      <h1>👋 Hi, I'm Lihua</h1>
      <p class="lead">Welcome to my personal blog! Here I record my learning, tech explorations, and inspirations.</p>
      <div class="colorful-section gradient-pinkblue">
        <h2>🚀 Featured Topics</h2>
        <ul class="post-highlights">
          <li>🤖 <b>AI/Machine Learning</b>: Latest tech and hands-on experience</li>
          <li>💻 <b>Web Development</b>: Frontend, backend, and full-stack growth</li>
          <li>🧠 <b>Algorithms</b>: Coding practice and competition insights</li>
          <li>🌈 <b>Life</b>: Inspiration, essays, and growth stories</li>
        </ul>
      </div>
    </div>
    <div class="main-right">
      <div class="colorful-section gradient-bluegreen posts-list-section">
        <h2>📝 Latest Posts</h2>
        <ul class="posts-list">
          {% for post in site.posts limit:8 %}
          <li class="post-card">
            <a href="{{ post.url | relative_url }}" class="post-title">{{ post.title }}</a>
            <span class="post-date">{{ post.date | date: '%Y-%m-%d' }}</span>
            <p class="post-excerpt">{{ post.excerpt | strip_html | truncate: 60 }}</p>
          </li>
          {% endfor %}
        </ul>
      </div>
    </div>
  </div>

  <div class="bottom-sections">
    <div class="colorful-section gradient-bluegreen about-section">
      <h2>🌟 About Me</h2>
      <p>Graduate student in Computer Science, passionate about technology, design, and sharing. My goal is to make the world better with code and creativity.</p>
      <div class="about-icons">
        <span title="AI Enthusiast">🤖</span>
        <span title="Web Developer">💻</span>
        <span title="Designer">🎨</span>
        <span title="Lifelong Learner">📚</span>
      </div>
    </div>
    <div class="colorful-section gradient-yellowpink contact-section">
      <h2>📬 Contact Me</h2>
      <div class="social-links">
        <a href="https://github.com/AliLan" class="social-link">GitHub</a>
        <a href="mailto:your-email@example.com" class="social-link">Email</a>
      </div>
    </div>
  </div>
</div>

<style>
.nature-bg {
  min-height: 100vh;
  background: linear-gradient(180deg, #8fd6ff 0%, #eaf6ff 70%, #eaf6ff 100%);
  position: relative;
  overflow: hidden;
  max-width: 1500px;
  margin: 0 auto;
}
.main-columns {
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: flex-start;
  gap: 2.5rem;
  max-width: 1500px;
  margin: 0 auto;
  padding-top: 90px;
  padding-bottom: 30px;
}
.main-left, .main-right {
  flex: 1 1 0;
  min-width: 320px;
  max-width: 520px;
}
.main-left {
  margin-right: 0.5rem;
}
.main-right {
  margin-left: 0.5rem;
}
.posts-list-section {
  min-height: 420px;
}
.posts-list {
  list-style: none;
  padding: 0;
  margin: 0;
}
.post-card {
  background: rgba(255,255,255,0.13);
  border-radius: 1.1rem;
  margin-bottom: 1.2rem;
  padding: 1.1rem 1.2rem 0.7rem 1.2rem;
  box-shadow: 0 2px 12px rgba(0,0,0,0.07);
  transition: box-shadow 0.2s, background 0.2s;
  position: relative;
}
.post-card:hover {
  background: rgba(255,255,255,0.22);
  box-shadow: 0 4px 24px rgba(90,200,250,0.13);
}
.post-title {
  font-size: 1.18rem;
  font-weight: 700;
  color: #fff;
  text-decoration: none;
  background: linear-gradient(90deg, #ff6b9d 30%, #5ac8fa 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}
.post-date {
  font-size: 0.98rem;
  color: #eaf6ff;
  margin-left: 0.7rem;
}
.post-excerpt {
  font-size: 1.02rem;
  color: #f5f5f7;
  margin: 0.3rem 0 0.1rem 0;
}
.bottom-sections {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
  max-width: 1500px;
  width: 100%;
  margin: 0 auto 40px auto;
}
.about-section, .contact-section {
  width: 100%;
  max-width: 1500px;
  min-width: 0;
  box-sizing: border-box;
  text-align: center;
}
.colorful-section {
  border-radius: 1.5rem;
  box-shadow: 0 4px 24px rgba(0,0,0,0.08);
  margin: 2.5rem auto;
  padding: 2.2rem 1.5rem 1.5rem 1.5rem;
  width: 100%;
  max-width: 1500px;
  color: #fff;
  position: relative;
  overflow: hidden;
  box-sizing: border-box;
}
.gradient-pinkblue {
  background: linear-gradient(120deg, #ff6b9d 0%, #5ac8fa 100%);
}
.gradient-bluegreen {
  background: linear-gradient(120deg, #5ac8fa 0%, #00c9a7 100%);
}
.gradient-yellowpink {
  background: linear-gradient(120deg, #ffe066 0%, #ff6b9d 100%);
}
.colorful-section h2 {
  font-size: 1.7rem;
  font-weight: 700;
  margin-bottom: 1rem;
  letter-spacing: -0.5px;
  color: #fff;
}
.colorful-section p {
  font-size: 1.1rem;
  margin-bottom: 1.2rem;
  color: #f5f5f7;
}
.post-highlights {
  list-style: none;
  padding: 0;
  margin: 0 0 0.5rem 0;
}
.post-highlights li {
  font-size: 1.08rem;
  margin: 0.5rem 0;
  padding-left: 0.5rem;
  color: #fff;
}
.about-icons {
  font-size: 2rem;
  margin-top: 1rem;
  display: flex;
  gap: 1.2rem;
  justify-content: center;
}
.social-links {
  display: flex;
  justify-content: center;
  gap: 1.2rem;
  margin-top: 1rem;
}
.social-link {
  display: inline-block;
  padding: 0.7rem 1.5rem;
  background: rgba(255,255,255,0.18);
  color: #fff;
  border-radius: 1.2rem;
  font-weight: 600;
  text-decoration: none;
  transition: background 0.2s, color 0.2s, box-shadow 0.2s;
  box-shadow: 0 2px 8px rgba(0,0,0,0.08);
}
.social-link:hover {
  background: #fff;
  color: #ff6b9d;
}

/* 语言选择弹窗样式 */
.language-modal {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.7);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 9999;
  backdrop-filter: blur(5px);
}

.language-modal-content {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border-radius: 20px;
  padding: 2.5rem;
  max-width: 500px;
  width: 90%;
  text-align: center;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
  animation: modalSlideIn 0.5s ease-out;
}

@keyframes modalSlideIn {
  from {
    opacity: 0;
    transform: translateY(-50px) scale(0.9);
  }
  to {
    opacity: 1;
    transform: translateY(0) scale(1);
  }
}

.language-modal-header h2 {
  color: white;
  font-size: 1.8rem;
  margin-bottom: 1rem;
  font-weight: 700;
}

.language-modal-body p {
  color: rgba(255, 255, 255, 0.9);
  font-size: 1.1rem;
  margin-bottom: 2rem;
}

.language-buttons {
  display: flex;
  gap: 1.5rem;
  justify-content: center;
  flex-wrap: wrap;
}

.language-btn {
  background: rgba(255, 255, 255, 0.15);
  border: 2px solid rgba(255, 255, 255, 0.3);
  border-radius: 15px;
  padding: 1.5rem 2rem;
  cursor: pointer;
  transition: all 0.3s ease;
  backdrop-filter: blur(10px);
  min-width: 140px;
}

.language-btn:hover {
  background: rgba(255, 255, 255, 0.25);
  border-color: rgba(255, 255, 255, 0.5);
  transform: translateY(-3px);
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
}

.language-btn:active {
  transform: translateY(-1px);
}

.flag {
  display: block;
  font-size: 2.5rem;
  margin-bottom: 0.5rem;
}

.language-text {
  display: block;
  color: white;
  font-size: 1.3rem;
  font-weight: 700;
  margin-bottom: 0.2rem;
}

.language-sub {
  display: block;
  color: rgba(255, 255, 255, 0.8);
  font-size: 0.9rem;
}

.chinese-btn:hover {
  background: linear-gradient(135deg, rgba(255, 107, 157, 0.3) 0%, rgba(90, 200, 250, 0.3) 100%);
}

.english-btn:hover {
  background: linear-gradient(135deg, rgba(90, 200, 250, 0.3) 0%, rgba(0, 201, 167, 0.3) 100%);
}

@media (max-width: 900px) {
  .main-columns, .bottom-sections {
    flex-direction: column;
    gap: 1.2rem;
    padding-top: 40px;
  }
  .main-left, .main-right, .about-section, .contact-section {
    max-width: 100%;
    min-width: 0;
  }
}

@media (max-width: 600px) {
  .home h1 { font-size: 2.1rem; }
  .colorful-section { padding: 1.2rem 0.5rem; }
  .nature-content { padding-top: 40px; }
  .cloud1 { width: 120px; }
  .cloud2 { width: 80px; }
  .tree1 { width: 40px; }
  .tree2 { width: 32px; }
  
  .language-modal-content {
    padding: 2rem 1.5rem;
  }
  
  .language-buttons {
    flex-direction: column;
    gap: 1rem;
  }
  
  .language-btn {
    min-width: auto;
    width: 100%;
  }
}
</style>

<script>
// 语言选择功能
function selectLanguage(language) {
  // 保存用户的语言选择到本地存储
  localStorage.setItem('preferredLanguage', language);
  
  // 隐藏弹窗
  document.getElementById('languageModal').style.display = 'none';
  
  // 根据选择跳转到相应页面
  if (language === 'chinese') {
    window.location.href = '/';
  }
  // 如果选择英文，保持在当前页面
}

// 页面加载时检查是否已经选择过语言
document.addEventListener('DOMContentLoaded', function() {
  const preferredLanguage = localStorage.getItem('preferredLanguage');
  
  // 如果用户已经选择过语言，隐藏弹窗
  if (preferredLanguage) {
    document.getElementById('languageModal').style.display = 'none';
  }
  
  // 如果用户直接访问中文页面，也隐藏弹窗
  if (window.location.pathname === '/') {
    document.getElementById('languageModal').style.display = 'none';
  }
});

// 添加键盘快捷键支持
document.addEventListener('keydown', function(event) {
  const modal = document.getElementById('languageModal');
  if (modal.style.display !== 'none') {
    if (event.key === '1' || event.key === 'c') {
      selectLanguage('chinese');
    } else if (event.key === '2' || event.key === 'e') {
      selectLanguage('english');
    } else if (event.key === 'Escape') {
      // ESC键选择中文（默认）
      selectLanguage('chinese');
    }
  }
});
</script> 