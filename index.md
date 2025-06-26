---
layout: home
title: 欢迎来到我的博客
subtitle: 研究生学习笔记与技术分享
---

<div class="home">
  <h1>👋 你好，我是丽华</h1>
  <p>欢迎来到我的个人博客！我是一名计算机科学研究生，专注于人工智能、机器学习和软件开发。在这里，我会分享我的学习心得、技术见解和项目经验。</p>
  
  <div class="featured-content">
    <h2>🚀 最新文章</h2>
    <p>探索我最近发布的技术文章和学习笔记，涵盖机器学习、Web开发、算法研究等领域。</p>
  </div>
  
  <div class="about-me">
    <h2>💡 关于我</h2>
    <p>作为一名研究生，我致力于在计算机科学领域深耕。通过这个博客，我希望能够：</p>
    <ul>
      <li>📚 记录学习过程和研究成果</li>
      <li>🔬 分享技术探索和实验心得</li>
      <li>🤝 与志同道合的技术爱好者交流</li>
      <li>🌱 持续学习和知识传播</li>
    </ul>
  </div>
  
  <div class="contact-info">
    <h2>📧 联系我</h2>
    <p>如果你对我的文章有任何想法或建议，或者想要技术交流，欢迎通过以下方式联系我：</p>
    <div class="social-links">
      <a href="https://github.com/AliLan" class="social-link">GitHub</a>
      <a href="mailto:your-email@example.com" class="social-link">Email</a>
    </div>
  </div>
</div>

<style>
.featured-content, .about-me, .contact-info {
  margin: 2rem 0;
  padding: 2.5rem;
  background: var(--card-background);
  border-radius: 20px;
  box-shadow: var(--shadow);
  border: 1px solid var(--border-color);
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  position: relative;
  overflow: hidden;
}

.featured-content:hover, .about-me:hover, .contact-info:hover {
  box-shadow: var(--shadow-hover);
  transform: translateY(-4px);
}

.featured-content::before, .about-me::before, .contact-info::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 4px;
  background: var(--gradient-primary);
}

.featured-content h2, .about-me h2, .contact-info h2 {
  color: var(--primary-color);
  margin-bottom: 1.5rem;
  font-size: 1.8rem;
  font-weight: 700;
  letter-spacing: -0.5px;
}

.about-me ul {
  text-align: left;
  max-width: 600px;
  margin: 0 auto;
  list-style: none;
  padding: 0;
}

.about-me li {
  margin: 1rem 0;
  padding: 1rem 1.5rem;
  background: var(--light-background);
  border-radius: 12px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.04);
  transition: all 0.3s ease;
  border-left: 4px solid var(--secondary-color);
}

.about-me li:hover {
  background: var(--background);
  transform: translateX(4px);
  box-shadow: 0 4px 12px rgba(0,0,0,0.08);
}

.social-links {
  display: flex;
  justify-content: center;
  gap: 1.5rem;
  margin-top: 2rem;
  flex-wrap: wrap;
}

.social-link {
  display: inline-block;
  padding: 1rem 2rem;
  background: var(--gradient-primary);
  color: white;
  border-radius: 16px;
  text-decoration: none;
  font-weight: 600;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  box-shadow: var(--shadow);
  position: relative;
  overflow: hidden;
}

.social-link::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: var(--gradient-secondary);
  transition: left 0.3s ease;
  z-index: -1;
}

.social-link:hover {
  transform: translateY(-3px);
  box-shadow: var(--shadow-hover);
}

.social-link:hover::before {
  left: 0;
}
</style>
