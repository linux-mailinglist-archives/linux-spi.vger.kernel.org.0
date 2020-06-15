Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4E71F90E8
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 10:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbgFOIDO (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 04:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728386AbgFOIDN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 04:03:13 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719A5C05BD43;
        Mon, 15 Jun 2020 01:03:13 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e1so16060163wrt.5;
        Mon, 15 Jun 2020 01:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NNdjIWpqOIzd0m8ttGrmgbfjsjDdO4jG01Ng0RZ57Yk=;
        b=up1WuBMwGRcvmOXYMRqouxeXOkJd2O/E8BLE+kbVXTkkODXYZWAPVAt1O3quhdfszR
         74kQKXRnYRikyNh6kE63AUijJ2vj/RSe05UTC6WIvc9OZJPEXFqP+RuYg0n1IVHPcLz8
         okU0do5NxuhAVm3YVIUur12LMzc4S24BbpD/oPgbaa0X6trDyrXfxf6MA5+nh8KzZem/
         72FTMablLMbz2NirPdcOyOLbc1czKcW+tI5iUGmL6A0RUg1Sr10l/YIghBvdWFSwqcKN
         +0gSmjenHZvX6dPeOSWJ0mtA6m0AdG928bMW09S4rsOpMCsoLSkxshtZpbE+FvIlmJCR
         vt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NNdjIWpqOIzd0m8ttGrmgbfjsjDdO4jG01Ng0RZ57Yk=;
        b=B62W4JhqQsOzHy/X2APmC/yO8cFDDHEiFRn8xaKMqszR7jAOA4ma8HEwfD6TaKpGYV
         TZ0Vu0zES4j9746HWRfafRRn5PIFo7gkbB1fqwhPBUJdWVWCdzQLo3yuPXitPyIZsN1v
         w5TRsT1ugArsiPtgGsInWGi2Xk4xslBCwUwkG09+B31uqEEoRFRtHT7R/MC94X3ei+vP
         +oM4J84snWQZVXN0MVh4OpSZhuxx7xlUNdt53UBB1KIwGHEQS+KfmL+QzWJSbO2WN4qx
         XNIUiM0/Sx4RZGZV+a5fkHT7RDXt5I/3tOdwgghwmYktYWMOYMWTg+vim4Hwgoxod0GR
         CRlQ==
X-Gm-Message-State: AOAM532oX6eWE2TfqcfQa3lSXkztnWaQ9q/Prlm6bzU7EFBxSRtq2Vrc
        H89RIO5ehfjB2yr+cSecdqPBrynASEQ=
X-Google-Smtp-Source: ABdhPJzete+uWJ/dRfkMk2DZxKBP3AjJL4ZDB4Hd3SecqASFs6WOH7JWnG/Kwn/bpOzCryfomdgelQ==
X-Received: by 2002:a5d:6b81:: with SMTP id n1mr27100208wrx.411.1592208192034;
        Mon, 15 Jun 2020 01:03:12 -0700 (PDT)
Received: from skynet.lan (168.red-88-20-188.staticip.rima-tde.net. [88.20.188.168])
        by smtp.gmail.com with ESMTPSA id d9sm23107054wre.28.2020.06.15.01.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 01:03:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     broonie@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 1/4] spi: bcm63xx-spi: add reset support
Date:   Mon, 15 Jun 2020 10:03:06 +0200
Message-Id: <20200615080309.2897694-2-noltari@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615080309.2897694-1-noltari@gmail.com>
References: <20200615080309.2897694-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

bcm63xx arch resets the SPI controller at early boot. However, bmips arch
needs to perform a reset when probing the driver.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/spi/spi-bcm63xx.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 0f1b10a4ef0c..8ab04affaf7b 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -18,6 +18,7 @@
 #include <linux/err.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
+#include <linux/reset.h>
 
 /* BCM 6338/6348 SPI core */
 #define SPI_6348_RSET_SIZE		64
@@ -493,6 +494,7 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 	struct bcm63xx_spi *bs;
 	int ret;
 	u32 num_cs = BCM63XX_SPI_MAX_CS;
+	struct reset_control *reset;
 
 	if (dev->of_node) {
 		const struct of_device_id *match;
@@ -529,6 +531,15 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 		return PTR_ERR(clk);
 	}
 
+	reset = devm_reset_control_get(dev, NULL);
+	if (IS_ERR(reset)) {
+		ret = PTR_ERR(reset);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev,
+				"failed to get reset controller: %d\n", ret);
+		return ret;
+	}
+
 	master = spi_alloc_master(dev, sizeof(*bs));
 	if (!master) {
 		dev_err(dev, "out of memory\n");
@@ -579,6 +590,12 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_err;
 
+	ret = reset_control_reset(reset);
+	if (ret) {
+		dev_err(dev, "unable to reset device: %d\n", ret);
+		goto out_clk_disable;
+	}
+
 	bcm_spi_writeb(bs, SPI_INTR_CLEAR_ALL, SPI_INT_STATUS);
 
 	/* register and we are done */
-- 
2.27.0

