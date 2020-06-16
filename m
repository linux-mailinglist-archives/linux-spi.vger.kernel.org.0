Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADEF61FA967
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 09:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgFPHCe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 03:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgFPHCc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Jun 2020 03:02:32 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE83BC03E96A;
        Tue, 16 Jun 2020 00:02:31 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h5so19555150wrc.7;
        Tue, 16 Jun 2020 00:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pk+BVPAFs3HZDk7vo9cGngkaw64SHz8Pd/OXNI1lr+0=;
        b=C+HvmqxTo8kyxFjHP2roUq3Qhu/w2Sn9iKkXF5vp1PkF7GbmPNr5BmB8EkfpDDMxac
         kdmT6qSYiaWA3K/hNkrgidPcZ6LuiPC0DLbbmToRDyesIED5lrjotym1kkf2ziAPFiXy
         5+dJ0nxRD0KsYrzoLPRT9zLqPcuf5o+tsWQDYebZCEEqyxwxoKb6AE7lUI8BoaEkXf2+
         lTqUPGHBsmBpSfmbuay1zzlge1jeN5tZt+kEH+cMY8WhyGOVfLxOQs8XfRxP+1pBE7A4
         fTv9lg3hdkyU6Jemj9/exNbEWgE9T74u4CqWzTegS1SA0Zo1QwquJNGl0gz0DJV4DCD3
         Oq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pk+BVPAFs3HZDk7vo9cGngkaw64SHz8Pd/OXNI1lr+0=;
        b=oPNHqExOwRzYPE0l3CZki9egGe1fDDW62g/rD+o/we/KkczMcA7JGePN2RA+4V1pbk
         BPdgGR8Hu2MJnDIzDiYZhYfr/dxkBit+Bhwm7AW0JwJmUl8Ox6jC9575kbV8ga7xFKse
         /hDxIEV33k6fAhCpCePKSBNnscdtKd/7ogDsTagZUXcGads+jdCoaGrxt3MzkDi9yrLl
         UPkIFOFZEFK/W4AazixhkQjVwtbTMmFXMzwvRZ3OJMkoFMB245d4gTIvzjcFdvsvRlmT
         eCEUiJutXGWNXpNCW8U3nUBTAA3dbyEEac/0ZB6v9J0gRfCdEyOaJURd1RokWw1VmVjB
         8U1g==
X-Gm-Message-State: AOAM533Z1yX86x7j2LSiTElUWHWYs0zebG2m3ckjGMuyqbWFzyqUA/JP
        +4eRkb0tRt/jhAAxJWT4JBs=
X-Google-Smtp-Source: ABdhPJxPpnpfojRlFQlz8MK0ih4ZorQrUXviNO2k8RuX8mrpkbqs+uk/jw5/vvKOelKtPiAuBDPhZQ==
X-Received: by 2002:a5d:68cb:: with SMTP id p11mr1354863wrw.379.1592290950376;
        Tue, 16 Jun 2020 00:02:30 -0700 (PDT)
Received: from skynet.lan (90.red-88-20-62.staticip.rima-tde.net. [88.20.62.90])
        by smtp.gmail.com with ESMTPSA id a81sm2792897wmd.25.2020.06.16.00.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 00:02:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     broonie@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v3 3/4] spi: bcm63xx-hsspi: add reset support
Date:   Tue, 16 Jun 2020 09:02:22 +0200
Message-Id: <20200616070223.3401282-4-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616070223.3401282-1-noltari@gmail.com>
References: <20200616070223.3401282-1-noltari@gmail.com>
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
 v3: use devm_reset_control_get_optional_exclusive
 v2: use devm_reset_control_get_exclusive

 drivers/spi/spi-bcm63xx-hsspi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 6c235306c0e4..45e2b0942e64 100644
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
 
+	reset = devm_reset_control_get_optional_exclusive(dev, NULL);
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

