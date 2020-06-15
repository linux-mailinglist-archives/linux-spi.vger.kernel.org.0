Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426BA1F92DE
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 11:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbgFOJJt (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 05:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729362AbgFOJJs (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 05:09:48 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD2DC05BD43;
        Mon, 15 Jun 2020 02:09:47 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r7so16284046wro.1;
        Mon, 15 Jun 2020 02:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EGL86Qz5KZIGBnwhew12v7obohA0kfmvJqpoIN9EEW0=;
        b=WAITJgDqa0Mr7UmDLieRkhFeaNDM9RdGqzkQpg98dTByQbQxHhO5GDAqLi80x9KJ+M
         8p2rXz3Tm6hca7m3KvCaRveud0ZdI99dv0dnTZp+M7ym4okpqcxFSiO3zTWK7AZ100d3
         AEFlhuZoPoFYezAz+mJ3CYt0owAKCVldxHlEaSQBmg1digtZeRrtKWCq9WL3G1yvfXCg
         2F7O8gbgGni7yMjVBLPJBtHD7TALfGZ1inkLi/eNWIHJPLzis2nmHdHLgtn1K0bRW957
         xq7ED0NOs286aiZbPXtXGQfneohcyCj7ndbYxmTyWS7ebZuZBuigwCI8gHlsm1x4ZH4c
         onMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EGL86Qz5KZIGBnwhew12v7obohA0kfmvJqpoIN9EEW0=;
        b=M8rJ9l164JgMAvayIOJfTnIU2aoxu3m9J9nZKpDp/gZwID+Wh7HB+YszAi8NKzG+yc
         oGTv/PGkMpIZ9b94qkPndBEhfXKSENzIiJhU+98ge4D69Y1z+yoArXK/5gWFaqC8ZUaJ
         aX/ZPVNs1ih9mbYxFKU43doXKjSRAma2U9iziKAgRscpRakrXmLAYBTlSexSt/JgKhcF
         KS5cR41h7PfsXILlkhiRKiWccM0UACnvPhsacWd5IBLmvm4ffckP3hkgjvpduqMebUjH
         0+u9LlkyPsFSa2wNP+dmXv48X4FS4oyTh84i2Ts61qYNBnYjPvP+daMRzd+moVj/BxB6
         dtqQ==
X-Gm-Message-State: AOAM533LwaS/UdyCW4mTsWAwg0EA8MiejTqoIfubcU+PLMXV/2VGcseW
        a0+bH82olRrOj6Qy8b4pYL0=
X-Google-Smtp-Source: ABdhPJwAVPLr37ywS95nBZNXVIXRJAnp7bp4NU7qrBz3bY36OnVE2Cz4rNmTo3yebYctmdTHnl5eyQ==
X-Received: by 2002:adf:ee47:: with SMTP id w7mr27142264wro.171.1592212186603;
        Mon, 15 Jun 2020 02:09:46 -0700 (PDT)
Received: from skynet.lan (168.red-88-20-188.staticip.rima-tde.net. [88.20.188.168])
        by smtp.gmail.com with ESMTPSA id z7sm23109370wrt.6.2020.06.15.02.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 02:09:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     broonie@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v2 1/4] spi: bcm63xx-spi: add reset support
Date:   Mon, 15 Jun 2020 11:09:40 +0200
Message-Id: <20200615090943.2936839-2-noltari@gmail.com>
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

bcm63xx arch resets the SPI controller at early boot. However, bmips arch
needs to perform a reset when probing the driver.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 v2: use devm_reset_control_get_exclusive

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
 
+	reset = devm_reset_control_get_exclusive(dev, NULL);
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

