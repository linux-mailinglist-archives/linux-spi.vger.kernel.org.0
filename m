Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 712571FA964
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 09:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgFPHCa (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 03:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgFPHC3 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Jun 2020 03:02:29 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ED6C05BD43;
        Tue, 16 Jun 2020 00:02:29 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j10so19517861wrw.8;
        Tue, 16 Jun 2020 00:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UD0BzEH0M8YZp//omQOWTqvshKj+X7/NNaB98DCZXBo=;
        b=kBXcv5RyDkAUziAF8On2RRAtLdxkf+PQ7mctnBuYI1ulgkFh/EmWKQjx53fhn0ldHk
         LesW1oDVYJTh6OGiYAqOI3xOXkPU27Z04FpPBJVhWOSs1dGMO40bH7OhT2KvUzLngmZT
         WEIC3zlK6d5Ht8onBNAN+EaApUSuDyovAyFRZHsp6dAqISO3b+n4ekdEH2wZ/0fuBHo8
         ekvuEpK1L5M+cWd2smMn81pC2K1+gAXCOkRSw8wpQoH6hNbVDo/FPlZ0Q0ivpVgrnmJk
         2+OXaDk/mfKfWzPLnEY+UhXm/0El39dLT1CnYwnZ9j91NSdklJKxe/nUeJVuQJvdT64U
         Y0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UD0BzEH0M8YZp//omQOWTqvshKj+X7/NNaB98DCZXBo=;
        b=rq9b/hxQEYmf5JbC+tfzC2sF6ObSTpHyvh6Afo3cdPF7jr8+wnyJrmNzQjeYaZjJgG
         Ua0oSCLWOeaSwfwiA/o2JCeghxpKMfQShHjTGwFMmKY8Ic8CNA96Lq5Jujv8eQcXNsW6
         DdAfLuhsPyfuzHo0IZRcd+4q7GNOyG0a+HN0udLAdJRyH9LFUlrPaaFK4Dmy5V0LjF5I
         cD+eBvyyLkmd1J5pC5Ew1zfX4IL2fzxfdmkoAz/ZRFlPCJk61bB1BPMePb1ivanXHbnZ
         XOukeXfVqy7AuVUURsnwVJN3N6KA5jZj1L7sPHHaH57TPEhPVoVVJUk+LnXrwr1T33bd
         Zcxw==
X-Gm-Message-State: AOAM531wafBoT40cRN+CDUL8e/K2xTAzPEE/Wzbp+Z0vaSymB/Z+LUXD
        wUDy5xJWO4k2+gr6uKRZreE=
X-Google-Smtp-Source: ABdhPJxJocaEAJDjXYgrdusUF1X6ahSw5QoOUewPSOXVR9vtcDbBiuhLEL6qn82QSv28cJKE+g2//Q==
X-Received: by 2002:adf:fc0c:: with SMTP id i12mr1403233wrr.365.1592290947713;
        Tue, 16 Jun 2020 00:02:27 -0700 (PDT)
Received: from skynet.lan (90.red-88-20-62.staticip.rima-tde.net. [88.20.62.90])
        by smtp.gmail.com with ESMTPSA id a81sm2792897wmd.25.2020.06.16.00.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 00:02:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     broonie@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v3 1/4] spi: bcm63xx-spi: add reset support
Date:   Tue, 16 Jun 2020 09:02:20 +0200
Message-Id: <20200616070223.3401282-2-noltari@gmail.com>
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

bcm63xx arch resets the SPI controller at early boot. However, bmips arch
needs to perform a reset when probing the driver.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 v3: use devm_reset_control_get_optional_exclusive
 v2: use devm_reset_control_get_exclusive

 drivers/spi/spi-bcm63xx.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 0f1b10a4ef0c..92e88901189c 100644
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
 
+	reset = devm_reset_control_get_optional_exclusive(dev, NULL);
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

