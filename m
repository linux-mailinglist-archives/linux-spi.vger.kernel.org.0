Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D7F1F90EE
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 10:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgFOID3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 04:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbgFOIDP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 04:03:15 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21045C05BD43;
        Mon, 15 Jun 2020 01:03:15 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q11so16058951wrp.3;
        Mon, 15 Jun 2020 01:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yyxGbzg5FRRWYSJHpphoCM/7g3fdi4Cub/m4VF29fJ8=;
        b=aHrtiM4IgI231hsx5aGRUbfgOB/VAF55Jfu3aNyk3m+Wflrr1n9/1n5Bxze4ib0Twt
         HXF3rWSwGj5ULWJDTUHCAifQ3RwzcrJ6DTzQR2riuPsWiOcsxfs/qWIZEisZelML3wmJ
         LvcFKmx3ZM/vHUGPswD/og9g0aZ7yHhixoUXEoJzHooAho+sRfZ3sC+EbjUKkPb0BsQX
         lYuhVWc847T9ljikOITJBhvEXmeKNJihRFAt35HbiOr+9EPWBklwiODBwdZkQS+ML3GN
         9d5n4KeIwqySxKHYo8eYWLD3J2gqohgk54AfltJV3ymIV+T8tMGYBr2w4foLAa9pE57K
         ZvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yyxGbzg5FRRWYSJHpphoCM/7g3fdi4Cub/m4VF29fJ8=;
        b=Ku2rPUz292qweLXYpcMw9V1Tgm7+OwGqsHxihcGuoj/+IB4j+UvWj0LFz6BKKaxh9W
         AOLnk9VQBa+INSE3HaiAvuRUxRajruFzR9akED3yEmMxzLl611NU1cZ9+DDxIM6eVk3f
         s/jEUwLDHcUgNDePM5Hrn+hEpNJr8ChPC4Pu6rpFn0YZ++KeTEdu6s9JNc6gkbb3jSNw
         CkH4iCzy60oSWhK2uPd81xgkbBnUdMo2SRi0nF7MamQfxh1WSL6OqQaNioBTrDVxtyvd
         7q08wKq+/gly+VkQ7HwYnDPAGvs8S1dnXfAx0VaaQ/3bz7aRdUA/DV821BdQhqShcTMN
         hZ1g==
X-Gm-Message-State: AOAM53262FZkrxFGT5As9aXjIK+2Ls86yDrFm+SMFhJ03AMfTvA0VqPb
        4VZIY/NTKoyXpNaFXfshydo=
X-Google-Smtp-Source: ABdhPJyVfOfRWwPytyd/13wO0uW8sOuZZgWpictu6cZsZyACR5rnquhjY++l8vHSdSL1yyxVcvj/pg==
X-Received: by 2002:adf:fd49:: with SMTP id h9mr28169413wrs.67.1592208193774;
        Mon, 15 Jun 2020 01:03:13 -0700 (PDT)
Received: from skynet.lan (168.red-88-20-188.staticip.rima-tde.net. [88.20.188.168])
        by smtp.gmail.com with ESMTPSA id d9sm23107054wre.28.2020.06.15.01.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 01:03:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     broonie@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 3/4] spi: bcm63xx-hsspi: add reset support
Date:   Mon, 15 Jun 2020 10:03:08 +0200
Message-Id: <20200615080309.2897694-4-noltari@gmail.com>
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

bcm63xx arch resets the HSSPI controller at early boot. However, bmips arch
needs to perform a reset when probing the driver.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
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
 
+	reset = devm_reset_control_get(dev, NULL);
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

