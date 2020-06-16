Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4786C1FBD0A
	for <lists+linux-spi@lfdr.de>; Tue, 16 Jun 2020 19:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbgFPRcn (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Jun 2020 13:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbgFPRcl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Jun 2020 13:32:41 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E096C061573;
        Tue, 16 Jun 2020 10:32:41 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c3so21601904wru.12;
        Tue, 16 Jun 2020 10:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M4FwC0tS2PEwWfH1L/1mjQoscnZK9tIH6DB/QnDAvYw=;
        b=UPCcaccHoC730cubgO602KTX+ru6qHNRcUXjlQasKj/h4dn9MQb8yDIsBVziiPPCfA
         g5Tb+2i3K/2byUrVysBNmSUWuWmMepzJ7yqh5LqqsZB7R8o5uPXpAYNL8y6qhX/auMa0
         iysdD3VU7/CX24psf0PwUQ243V3bzB9m4857g7bvO4f85HK1YFgfpfHCirSOdLI45Htw
         VtIZxRiMdnCabRwQb/6bONXHXwgRleq6oncLPLemh9s8ya9i3Aa4us7lLXse92/6rqs0
         fdhRdgAqCSHQSqtOLA8mmb9uCrQ5eLc0T+brtmz+adUyJTGLPUAIUu/Rp9VhniDOZc42
         Ix2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M4FwC0tS2PEwWfH1L/1mjQoscnZK9tIH6DB/QnDAvYw=;
        b=ZbqAlUVWaKILQkxX1V6tKJxIJEQhbsKM3v0o+LsgZbsAkwUbgYTKai9JSFj/EMnW+A
         IQzyYJnFUmdW2hKorxU+3jtAU4e1lCrvhZtKV2Di2iOU1ybEmHJtPYmnFE5iuHYpSjcC
         R91KMvatUnQq5oxtRtjgYV90R8rthOFrSUKkhUfdKGpFPOEGIr94qyaKYZk8n+VCt59h
         vDkI+AELhug0z8rFg0nwXTlreUy/rxN/MSHumfk5RGTMeruSlIoDDdqPLhWAVZj4YCqs
         Foo2Sm/+cvvhgObcfOaRZRVN1CQmqG6sH0gXbgSaWqCMjeKaaHxiZyeZFxj685qcWM/t
         dlXA==
X-Gm-Message-State: AOAM530BCJPHAgleWu9ru9Q7f1VKwr8rGwCmDMTn1I94koad4kKW0K+q
        Ipc8t5RKv5xlndd0ePW4Zfo=
X-Google-Smtp-Source: ABdhPJxvTnhoOvZGU81shEIy5Tfm8z+l9F2YHek8X7iqGR8tqtNnL5yw4dUJ8+qy1TgfWOogqSm7dQ==
X-Received: by 2002:a5d:4d4d:: with SMTP id a13mr4238758wru.252.1592328759836;
        Tue, 16 Jun 2020 10:32:39 -0700 (PDT)
Received: from skynet.lan (90.red-88-20-62.staticip.rima-tde.net. [88.20.62.90])
        by smtp.gmail.com with ESMTPSA id f16sm5014402wmh.27.2020.06.16.10.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 10:32:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     broonie@kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, p.zabel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v4 1/2] spi: bcm63xx-spi: add reset support
Date:   Tue, 16 Jun 2020 19:32:34 +0200
Message-Id: <20200616173235.3473149-2-noltari@gmail.com>
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

bcm63xx arch resets the SPI controller at early boot. However, bmips arch
needs to perform a reset when probing the driver.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---
 v4: simplify devm_reset_control_get_optional_exclusive return handling
 v3: use devm_reset_control_get_optional_exclusive
 v2: use devm_reset_control_get_exclusive

 drivers/spi/spi-bcm63xx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 0f1b10a4ef0c..96d075e633f4 100644
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
@@ -529,6 +531,10 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 		return PTR_ERR(clk);
 	}
 
+	reset = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(reset))
+		return PTR_ERR(reset);
+
 	master = spi_alloc_master(dev, sizeof(*bs));
 	if (!master) {
 		dev_err(dev, "out of memory\n");
@@ -579,6 +585,12 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
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

