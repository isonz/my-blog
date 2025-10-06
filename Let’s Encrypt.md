1. 使用 Certbot 获取证书
如果你还没安装过证书，可以用 Certbot 一键申请。
以 Nginx 为例（Apache、Standalone 也类似）：


        sudo apt update
        sudo apt install certbot python3-certbot-nginx -y
    
        # 自动申请并配置到 Nginx
        sudo certbot --nginx -d yourdomain.com -d www.yourdomain.com
  
申请成功后，证书会放在：

      /etc/letsencrypt/live/yourdomain.com/fullchain.pem
      /etc/letsencrypt/live/yourdomain.com/privkey.pem

  
2. 手动续签命令
如果你只想手动续签，可以直接运行：

        sudo certbot renew
   
Certbot 会检查所有证书，如果快过期（一般小于 30 天），就自动续签。

3.自动续签（推荐） 
添加 cron 定时任务，每天检查一次，快到期就自动续签。

    sudo crontab -e
    15 3 * * * certbot renew --quiet --post-hook "systemctl reload nginx"
    
解释：
- certbot renew --quiet → 静默模式检查和续签   
- --post-hook "systemctl reload nginx" → 续签后重载 Nginx，让新证书生效   
- 15 3 * * * → 每天凌晨 3:15 执行  

4. 验证自动续签是否生效
   可以模拟续签：

       sudo certbot renew --dry-run

如果输出 Congratulations, all renewals succeeded 就说明自动续签没问题。   
✅ 这样配置好后，你的 Let’s Encrypt 证书就会 永久免费、自动续签，完全不用手动操作了。
