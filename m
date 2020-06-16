Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAB11FBD0C
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 19:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbgFPRcr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 13:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730621AbgFPRcm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Jun 2020 13:32:42 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1653FC06174E;
        Tue, 16 Jun 2020 10:32:42 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q25so3971230wmj.0;
        Tue, 16 Jun 2020 10:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NXWT0XBDvfCeaNJqhvulIouNPW+S3KxeQ8adKa8xo70=;
        b=m8+w7OW6QX97DxbPYywNN319UsCFVqHFB1bt397I2B0wcYD7eJ7HYJ2TxQJb/L5Cv5
         SuYjVYu1zS6zR/DGUJYciirVFQnPgQr8zUkAqyq38AAYG9zN5t9jSyms3x7ZUqr8TBiq
         Eelzd+BkxzyMfK3fDVBATI8jfhTWUiXOxu+15RcQxy4Lw1k3AJCXZLTvZJDj11dj5B7z
         pJUlpl9YQK8q66FejtIoYv/9JjWXQEpNLUpB517v51sNqWnpFCBJLPCQInPfUBBFACp3
         0y7UeengdqAmizU2B/wSRhXRg6HMvnz9y4QBAfb9P8bcXI7OOfU9Lr2hQYCKMIpv0Ilg
         S8Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NXWT0XBDvfCeaNJqhvulIouNPW+S3KxeQ8adKa8xo70=;
        b=pQeFR68lLDSHx6jLX+ulVPKjxnmWXpMCka7PKNhlbzuXqiWDti140vzgmFP4+jUPGm
         Wzt9Gbsn+cSKZmx8KXMbXeQ0Naw0e/GZ8rPZIxyPgcJgQstaMxJbZaqo2LXcV0uKxs9J
         97mql2fYT36Kjjp9RICHTlQc8I5Zwt9NT13MR2gf1/HnFKoHbd3r0w9kP/D2L6RohlD+
         MUKOoznqUmcynCEykKobBb0wdg46sKh5v12IUsVc4U+BpoWKpN6tKUijLGQJkRs4sdqx
         TEWr5VBJTEu1oK20FF1Pos8VESY/mJvpaVaUXtl6EeXd3wp/+kERKcBQ99jDCM51Iisc
         eN7w==
X-Gm-Message-State: AOAM530+g9mLtd8D7hn4OLwRzEedQ72X1UhUyJNGhCCzHYS3c52aFGWs
        1rmvv6lICNSgUgmUuW2+4iw=
X-Google-Smtp-Source: ABdhPJyqQgCtDv/pypP89GRXyglSLvJdg+YyNDVE2UIgLYu/pYE+pkfKqRd/5TuXWFtvbYYz8RJaMw==
X-Received: by 2002:a1c:59c7:: with SMTP id n190mr4137654wmb.61.1592328760706;
        Tue, 16 Jun 2020 10:32:40 -0700 (PDT)
Received: from skynet.lan (90.red-88-20-62.staticip.rima-tde.net. [88.20.62.90])
        by smtp.gmail.com with ESMTPSA id f16sm5014402wmh.27.2020.06.16.10.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 10:32:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     broonie@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v4 2/2] spi: bcm63xx-hsspi: add reset support
Date:   Tue, 16 Jun 2020 19:32:35 +0200
Message-Id: <20200616173235.3473149-3-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616173235.3473149-1-noltari@gmail.com>
References: <20200616173235.3473149-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

bcm63xx arch resets the HSSPI controller at early boot. However, bmips arch
needs to perform a reset when probing the driver.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 v4: simplify devm_reset_control_get_optional_exclusive return handling
 v3: use devm_reset_control_get_optional_exclusive
 v2: use devm_reset_control_get_exclusive

 drivers/spi/spi-bcm63xx-hsspi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 6c235306c0e4..9909b18f3c5a 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -20,6 +20,7 @@
 #include <linux/spi/spi.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/reset.h>
 
 #define HSSPI_GLOBAL_CTRL_REG			0x0
 #define GLOBAL_CTRL_CS_POLARITY_SHIFT		0
@@ -334,6 +335,7 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	struct clk *clk, *pll_clk = NULL;
 	int irq, ret;
 	u32 reg, rate, num_cs = HSSPI_SPI_MAX_CS;
+	struct reset_control *reset;
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -348,10 +350,20 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
+	reset = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(reset))
+		return PTR_ERR(reset);
+
 	ret = clk_prepare_enable(clk);
 	if (ret)
 		return ret;
 
+	ret = reset_control_reset(reset);
+	if (ret) {
+		dev_err(dev, "unable to reset device: %d\n", ret);
+		goto out_disable_clk;
+	}
+
 	rate = clk_get_rate(clk);
 	if (!rate) {
 		pll_clk = devm_clk_get(dev, "pll");
-- 
2.27.0

