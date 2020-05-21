Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E441DD614
	for <lists+linux-spi@lfdr.de>; Thu, 21 May 2020 20:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbgEUShQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 May 2020 14:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728240AbgEUShO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 May 2020 14:37:14 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37224C061A0E;
        Thu, 21 May 2020 11:37:14 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id n22so6258433qtv.12;
        Thu, 21 May 2020 11:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=advQoTRynMmr9siN3uMvuCx8gFVxn3M1aQbmG26FzBs=;
        b=eA5TvwBxJg7zyuVcyrOycfsM6CktaO8/RShOENAn10TcSXEt70KieIG6RARAdzdICj
         9CoVoj2UtkKq80Nwbn5gv/kmN9JGR6kYkAaw25ago0D1la+3SNhuezltrS++ycWsJKcU
         dwLOT+e+klu3l+HdlwSgHZE21hBr5yHIQOumle+sY29+5zakjWI87XPYk0oUq573Iklf
         wW1tPk4ZHC2WEV4WzSYC0cC2R0faSkabgpJrNO0sDFIgYwiz6je6lEXFr86ep6dBp9jx
         LBCMMsRaFWTAQOl/G+XP9zYocaG1beLRYSbU7HPApHt7I8RBhZIRXumyhGk0sQJZtYb7
         BRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=advQoTRynMmr9siN3uMvuCx8gFVxn3M1aQbmG26FzBs=;
        b=HYbmQkTiAdk0p5ozh0QbEZm6L4WInuoV86ztHLCVDKFoTvEvkNxh67MmsOUIFEXjLr
         b1GGKLK+3K43Ns6kaStGwpmaxOnQznxTYy2iT2RJ479NOHTgg14R+yUglH+IGPKQVHW+
         aEdsQBtcVWbEKz5vIswiFyeoWvEnytd03KOt9Vmvq9kemClS/MLU0LmewsRx6abk0nF4
         l8Jonlb7IXEhqGVQiP1Ck0tHFIEj9qvbS1tt2PI0n4f3qAiPIyD6aZWjX6zOVWImz8Qq
         Xyg1+icm3HX8Nk/VIyzMPT4iVeU2IuPhPDBYJJ1v2/ZuM42EzKYlPgUPM88jGtpCRBtG
         uSmQ==
X-Gm-Message-State: AOAM530ZO/CnBUud3iT41zCHAInXdmstwL1HaLXLZRuXJZQlTvigKr+7
        wb7Q6GMMo2CTlXYdkFTeM8Q/aFuQ
X-Google-Smtp-Source: ABdhPJzYbL5bE9eWFMyaHiQ4d+tcD1GwK9ARROKNcpVmG1RyRaNOhb0fe1jbIA0i86ESp8lVpGxCdA==
X-Received: by 2002:aed:3286:: with SMTP id z6mr12477769qtd.144.1590086233453;
        Thu, 21 May 2020 11:37:13 -0700 (PDT)
Received: from lord-gnome.lan (pool-100-8-210-135.nwrknj.fios.verizon.net. [100.8.210.135])
        by smtp.gmail.com with ESMTPSA id z25sm5999723qtj.75.2020.05.21.11.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 11:37:13 -0700 (PDT)
From:   Christopher Hill <ch6574@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Christopher Hill <ch6574@gmail.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] spi: rb4xx: update driver to be device tree aware
Date:   Thu, 21 May 2020 14:36:30 -0400
Message-Id: <20200521183631.37806-2-ch6574@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200521183631.37806-1-ch6574@gmail.com>
References: <20200521183631.37806-1-ch6574@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch updates the spi driver spi-rb4xx.c to be device tree aware

Signed-off-by: Christopher Hill <ch6574@gmail.com>
---
 drivers/spi/spi-rb4xx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-rb4xx.c b/drivers/spi/spi-rb4xx.c
index 17e1a77dc132..8aa51beb4ff3 100644
--- a/drivers/spi/spi-rb4xx.c
+++ b/drivers/spi/spi-rb4xx.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/spi/spi.h>
+#include <linux/of.h>
 
 #include <asm/mach-ath79/ar71xx_regs.h>
 
@@ -150,6 +151,7 @@ static int rb4xx_spi_probe(struct platform_device *pdev)
 	if (IS_ERR(ahb_clk))
 		return PTR_ERR(ahb_clk);
 
+	master->dev.of_node = pdev->dev.of_node;
 	master->bus_num = 0;
 	master->num_chipselect = 3;
 	master->mode_bits = SPI_TX_DUAL;
@@ -188,11 +190,18 @@ static int rb4xx_spi_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id rb4xx_spi_dt_match[] = {
+	{ .compatible = "mikrotik,rb4xx-spi" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, rb4xx_spi_dt_match);
+
 static struct platform_driver rb4xx_spi_drv = {
 	.probe = rb4xx_spi_probe,
 	.remove = rb4xx_spi_remove,
 	.driver = {
 		.name = "rb4xx-spi",
+		.of_match_table = of_match_ptr(rb4xx_spi_dt_match),
 	},
 };
 
-- 
2.25.1

