Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732211F92DA
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 11:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729407AbgFOJJv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 05:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729390AbgFOJJu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 05:09:50 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC65C061A0E;
        Mon, 15 Jun 2020 02:09:49 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id b82so5311383wmb.1;
        Mon, 15 Jun 2020 02:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OR0nfmLMMmSCxHE1VSyFIHoRf43UAMOwWvzgX8Ue40s=;
        b=fb/uGGcqz2JqdS8hP7EbdWBdkEtZo+LduWSmJY4nm8p5GMGLRxR2QI3q8qrZ0YEoGC
         +Dj1nwtS/Rub1+UED2c9n5vZqs1w6GuYSlqYgujtHtWQ+pGhx335o9PZd6yqX4wOEn2Q
         22P9vS7X1d7SGFUrc3RDgZyu40wljofv1mbvakxKX5uLamsLR0+z6YCr6nqXMr6zC/GP
         21SzFQO+YC8xFavJL0zRA+C7wzOrwOmeGFnzz3l4uZKq+2PvHxJ0tWqr+vE2Gg6vLKcR
         2neqJcQ3papU9nAVd7lEb4DO1SpwxXeAYbtyvFofSLIFavDbRNi9dcCfzHGITc8wVfVA
         mk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OR0nfmLMMmSCxHE1VSyFIHoRf43UAMOwWvzgX8Ue40s=;
        b=NX0eIGPACGsYFPllkQRlGmxqoRcyN9tiq7KXaZc88bLUkkDLChOJsk58M2VE4n+XIB
         mmw/pQQViKQGXs2/Tts9PxPOo0+lbDn7J80VUJD6E7gJce3EaLw/O6iCx4uh3lxSsxsJ
         ii8F0GUBmG42oh9QQ+2RCZnt2jOtC5jrrmRbutq+A6uGVMPV/xUVwe1IWVOgdB/4I1vf
         SPbzDt1ZV+IxtF2pMFlmaB+SAia6XDCQ+jb8nfmAlAAd+FtiwzqHAu/N6ArLsYOMtozn
         q04y/ZdVSlirf5QOOwPE6zsgNVoDgWQxt11adPjtLEerSbXBkv97U8g7QyHij1q0pDFs
         5kvg==
X-Gm-Message-State: AOAM533Ohm+EOzzRdPyxNMwqAxQlEKSlqg2KRI2J6E3u9brniDwuAZ2X
        O/G5PwoWCQ2CmOX8U8iPoQg=
X-Google-Smtp-Source: ABdhPJw2zXcH4A8SO6eyjbtXwJhxo0qyi/290h8tJRwaAVkZtprf7P5eHNUGltZznlI97KF55bELww==
X-Received: by 2002:a1c:f608:: with SMTP id w8mr11762885wmc.78.1592212188418;
        Mon, 15 Jun 2020 02:09:48 -0700 (PDT)
Received: from skynet.lan (168.red-88-20-188.staticip.rima-tde.net. [88.20.188.168])
        by smtp.gmail.com with ESMTPSA id z7sm23109370wrt.6.2020.06.15.02.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 02:09:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     broonie@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v2 3/4] spi: bcm63xx-hsspi: add reset support
Date:   Mon, 15 Jun 2020 11:09:42 +0200
Message-Id: <20200615090943.2936839-4-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615090943.2936839-1-noltari@gmail.com>
References: <20200615080309.2897694-1-noltari@gmail.com>
 <20200615090943.2936839-1-noltari@gmail.com>
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
---
 v2: use devm_reset_control_get_exclusive

 drivers/spi/spi-bcm63xx-hsspi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 6c235306c0e4..a20a0b88c23a 100644
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
@@ -348,10 +350,25 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
+	reset = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(reset)) {
+		ret = PTR_ERR(reset);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev,
+				"failed to get reset controller: %d\n", ret);
+		return ret;
+	}
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

