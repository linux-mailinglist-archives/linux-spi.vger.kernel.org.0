Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0195DA408
	for <lists+linux-spi@lfdr.de>; Thu, 17 Oct 2019 04:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392014AbfJQCvK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Oct 2019 22:51:10 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37941 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387605AbfJQCvJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Oct 2019 22:51:09 -0400
Received: by mail-pf1-f196.google.com with SMTP id h195so631691pfe.5;
        Wed, 16 Oct 2019 19:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cORw/M2PPp+G7rfLzx7vrbHpIQU4gk/+aw+cEPBwgBE=;
        b=jrel5m/j9YYL8XOd6Xr8q9NmzTehtbTTdMqdGRHxdtRsYMBnhkDhv5LrfkTCXuvQD3
         zrHnNFFX1lZ4euDIoHgnqyGJwMgJSzSVyBKObtskju4sMZtvDrgXz7RexHwNPyzfxTnF
         zHbuPp+QOQz1BshXp2joY6vJfGaDX4q0FFsWjUG4vFMag7VFtc8CRrmWG3Mas9KsmI7c
         SlzATMivqx7PCUhJqu/yMwHNQusEvNdS2HYqwo4VNOhZ78m6PiIBRwWunZv5yzhvDqNX
         bWK6CF5rZouXsk4jeTWWSUTnRg5+caJcC4bxgjGQusjFi1+kQp5oKF9Rab/4iSxALM8A
         Glmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cORw/M2PPp+G7rfLzx7vrbHpIQU4gk/+aw+cEPBwgBE=;
        b=o23NkNkcYIqX0iY7VVwIJLEuIibOJ/8Wqshpw86aB8SraFFW3h1/Mq4kkij17qXQwh
         fFFcOaTAODfkfebLy8tToc8LfN5scgYum3kLge7JSMqx2Tcho0FSEMQA2K9qSedMC3aY
         OHLT6ow0Sbx8zP8RTBm+oCqM5nb/pl9uoHEQx8w2/j0QDSirDJoTWGqT34BroraRXtZD
         HJWinkUNQ6i1MLvHSMa38yZ3Fah27uYeocMI8OnEbsYHEPjQ1V6AzRZGwukVh1Ad9ZfI
         1kiw9foVxau6M/dohm6AKFw17Kcj+GS0Gdh5FCWZendZ2SzGcXdKPAfr6OWOmH8QqsKC
         GYnQ==
X-Gm-Message-State: APjAAAW8WYrrwCrYIStAvmUMpGwgxFEDzrNr0YEW9rZ9QvqG4P91E3pS
        EMFLSU2msdg2jrkJ+Lf6XfM=
X-Google-Smtp-Source: APXvYqzEbs4jwr7g2mmEteoXN2Odjtn7PvD5Fn29n0LJ5zjtrDt5FDJmgMvZZEnW/+K7NTgnLeP62w==
X-Received: by 2002:a17:90a:17c4:: with SMTP id q62mr1348383pja.83.1571280669181;
        Wed, 16 Oct 2019 19:51:09 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id a17sm467374pfi.178.2019.10.16.19.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 19:51:08 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] spi: pxa2xx: Add missed security checks
Date:   Thu, 17 Oct 2019 10:50:58 +0800
Message-Id: <20191017025058.31528-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

pxa2xx_spi_init_pdata misses checks for devm_clk_get and
platform_get_irq.
Add checks for them to fix the bugs.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/spi/spi-pxa2xx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index bb6a14d1ab0f..2e73d75a6ac5 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1565,7 +1565,13 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 #endif
 
 	ssp->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(ssp->clk))
+		return NULL;
+
 	ssp->irq = platform_get_irq(pdev, 0);
+	if (ssp->irq < 0)
+		return NULL;
+
 	ssp->type = type;
 	ssp->pdev = pdev;
 	ssp->port_id = pxa2xx_spi_get_port_id(adev);
-- 
2.20.1

