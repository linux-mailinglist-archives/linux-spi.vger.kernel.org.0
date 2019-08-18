Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07B3291897
	for <lists+linux-spi@lfdr.de>; Sun, 18 Aug 2019 20:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbfHRSB3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 18 Aug 2019 14:01:29 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55225 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfHRSB2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 18 Aug 2019 14:01:28 -0400
Received: by mail-wm1-f67.google.com with SMTP id p74so1075919wme.4
        for <linux-spi@vger.kernel.org>; Sun, 18 Aug 2019 11:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Euo2gGJ36o5+rHJ9NUXJ1y7LYDL7/8cPc/OAJJP972Y=;
        b=mWnNeoYkSlpizT0FwWUa5pCOZCw9ZPIdEQvX+f3+eE0LKL+Bcf4IbBgX4flI0olcE7
         2tWf/j4a6XwoOwdHDGto8ahSHuomFzcWMPNmXHVqAp8gezZYo3sLqoQs7/wk4xfMqPhA
         2ylH2mfgQASYr2xkmKyZ2XWF4lu9Di3M3fDTZsdokJZawUtVIYoWq2J3rPTBllITTvht
         9kcE7agqu8ZJHlfq9k8s93y3Ov2NSH8aKt9jXG6pefVohYyjRoKps5MyfjTIW0nCy+9p
         yez3lITwp2WJEQXSh0s+ZiuWbuAY5AJTDML33M7mjPunG0pXp8V9VDZsgYJ4w6eLS0jC
         02Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Euo2gGJ36o5+rHJ9NUXJ1y7LYDL7/8cPc/OAJJP972Y=;
        b=jka+3lapQRXs3mw+Bb8AhXSoo7vBznQJ3eXTkWlSmjn+hQesRmMgHsfbzgmUqQlw//
         KrOwkuu6QYhSyZdeMKNOsQen5/+7eiBKnbvX3fLIABQZ2R70evXNeUdBnMarlYGpz04s
         8+ym+upAKSTun0PoSWA4+4Idw/pdenRyf5SyaW78v0BVhUFeCttDdF+AyrLgcVrb2mZ/
         LZNNeTzHUYJsN4BSEb1iFcoMYPf8oDlY9X4w04t84j6Pp7FDp5FYmQxTJMoJZmX1hgo1
         4y9WLk3JBqoC2IcxP6EhOi54zEUFZqUA+KGyDQcpX8kyYluDAdFY2vcGwguHsU5Pgxwz
         RAOw==
X-Gm-Message-State: APjAAAUIB0eCxYWPnFk2LFRvjbReqOH8VXoL6AeA563MghWPe7hMlTOz
        8W8ySI2Ni4UBAG1hLYbEZjo=
X-Google-Smtp-Source: APXvYqwNH91n3mSaOg12D2Cya1Yzs/gooS0ZzE/TvpGgIB0VMy98fXmEeSdes3DaqYs35QMLAo7wtA==
X-Received: by 2002:a1c:f518:: with SMTP id t24mr7197455wmh.98.1566151286756;
        Sun, 18 Aug 2019 11:01:26 -0700 (PDT)
Received: from localhost.localdomain ([188.25.91.80])
        by smtp.gmail.com with ESMTPSA id x6sm9372246wmf.6.2019.08.18.11.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2019 11:01:26 -0700 (PDT)
From:   Vladimir Oltean <olteanv@gmail.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH spi for-5.4 07/14] spi: spi-fsl-dspi: Remove unused initialization of 'ret' in dspi_probe
Date:   Sun, 18 Aug 2019 21:01:08 +0300
Message-Id: <20190818180115.31114-8-olteanv@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190818180115.31114-1-olteanv@gmail.com>
References: <20190818180115.31114-1-olteanv@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

There is no code path for reaching 'return ret;' without it first being
assigned to an error code. Therefore the initialization with 0 is
pointless.

Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index c07525a9fd34..c5d99f4d5e3d 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -996,7 +996,7 @@ static int dspi_probe(struct platform_device *pdev)
 	const struct regmap_config *regmap_config;
 	void __iomem *base;
 	struct fsl_dspi_platform_data *pdata;
-	int ret = 0, cs_num, bus_num;
+	int ret, cs_num, bus_num;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(struct fsl_dspi));
 	if (!master)
-- 
2.17.1

