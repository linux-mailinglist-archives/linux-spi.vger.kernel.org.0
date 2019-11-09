Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12469F5E03
	for <lists+linux-spi@lfdr.de>; Sat,  9 Nov 2019 09:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfKIIJ5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sat, 9 Nov 2019 03:09:57 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44245 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfKIIJ5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 9 Nov 2019 03:09:57 -0500
Received: by mail-pf1-f196.google.com with SMTP id q26so6674487pfn.11;
        Sat, 09 Nov 2019 00:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c0AkCz+ons60KF3Basu+r9e0WFH/NQCt67/Tcitib7o=;
        b=EYdZbBZEJ6QnLJLTDb8UPk3rQWSaDm9RyNhSguPvwNe1l6TAepI2uWZPNPwH14R4gk
         nyxnEX6DOnUcklNh4uccNfH/usHsraepcOWcODbFXlk/mnpQZPKHrWAc3zjMOE/c9u58
         OQM+pI7NVIjT1c6V71+4OnvirdmEYTFeI9e04eR0zu01MSrc67c+Kgvi7RgDkmRmLfYR
         +btFjaml5jP0sXZxAh25xohZzvBfLIQzZJ47FbHEePPPxfTPGWaSLOKqpTapaDqRb66T
         THHTCwxKiPH15VncMsjTC/qs67fmXx0gJfNn6RD7tD7TSe6LkTD60xJFhJJdaVWDLtal
         N2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c0AkCz+ons60KF3Basu+r9e0WFH/NQCt67/Tcitib7o=;
        b=LSrux7DB0b1g7K/Nokx43L2djQC/s4jJ4pTMQCErg8srHQxwbFZVBQLm4yrTwVRrdN
         BIjY2ksuKxzUTV7WmqbN6/tlcDE1L3hb1EgBtIfymNjXDk55yH6A1rE2yF8yMQmKAOIj
         GFays9CVXq+YKVB94Jsq92n79x+2BHetmOoiayan9cw0hcbPUCfFCyFZqfBib8hqd5AX
         SuDNwVrr5ujEQiztkgwTspepw+/mc6SpAyfBqPog0+8mxUuGABa+N1/eyYIwuL8LTbrr
         w61lzr3HSwtbhpNZhHWDesn/pXdaAToN8CKU06w+8Re41jZYVvO1rrmN04KVGivYdduM
         ZBGQ==
X-Gm-Message-State: APjAAAXJgjVSqsaRYBuZCRS79dP2jHXxVgLwb1/rNcmIgfr3FmW5Cxxw
        GE6EbMu9yFiKI5aHr3xN0sEsKfVELHQ=
X-Google-Smtp-Source: APXvYqxzY/DL9rM6SfcD+4ow3nbBR4KyVY6j8DGNdrb345k8GNjqK6yfgTyA86TspPW77PvK3sXNmA==
X-Received: by 2002:a63:5c21:: with SMTP id q33mr17660246pgb.61.1573286996321;
        Sat, 09 Nov 2019 00:09:56 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id q13sm7799715pjq.0.2019.11.09.00.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2019 00:09:55 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] spi: pxa2xx: Add missed security checks
Date:   Sat,  9 Nov 2019 16:09:43 +0800
Message-Id: <20191109080943.30428-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.23.0
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

Since ssp->clk and ssp->irq are used in probe, they are mandatory here.
So we cannot use _optional() for devm_clk_get and platform_get_irq.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Modify commit message.

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
2.23.0

