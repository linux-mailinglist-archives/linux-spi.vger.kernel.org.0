Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333F043E197
	for <lists+linux-spi@lfdr.de>; Thu, 28 Oct 2021 15:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhJ1NHc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 28 Oct 2021 09:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhJ1NHX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 28 Oct 2021 09:07:23 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1236C061745
        for <linux-spi@vger.kernel.org>; Thu, 28 Oct 2021 06:04:55 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 205so10540558ljf.9
        for <linux-spi@vger.kernel.org>; Thu, 28 Oct 2021 06:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rt-labs-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UaPfykYUBBZc6gPOflGHBuwr38OqGifVaFHNMtiuJh8=;
        b=k0OrNQzQd7hCR2/FeIIh5JA3xvT3WFjNfprcBTtB1ACuASqvrJ7T9uGK63CWI92MUE
         bM5kknMnJezDflzIQPuak9UbKKHTVsUehKFEhpRxx7aTXBJEBXvbuE42j6bexIHBROHL
         EGeafA1xVH7lsQkU7rRXY1ZJ4nKa5Iblkb8yfltOahGLPm7v3Yoe+YB9AedrE1t1mZ5l
         IKuJC20Jkvud5nmvcwwVmx+qY9f4/y0yEhqx9CDd0lOD12iV91alYwNA6dBglCM5JZl0
         gZT2a+ax3Tb07eVPF5Tut7SvpE2nXlGVVImng8WYmVlFzdIsj/dh0q6XdBSTTMV7P8/a
         5n7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UaPfykYUBBZc6gPOflGHBuwr38OqGifVaFHNMtiuJh8=;
        b=Cb8tmvr0CZac8j9OUvK2GTzf2s7DXUa3OrzdIgVV6oE4swVe1GrBwOASDk+06Po1r5
         69oxPE5qMoayZMdGwzZD9gvcMMJzZx2HPzQxaYckijWnrlr00xEjPivUDr7hmkvRbeNz
         ykkWCUVXD/dVmbjqkGai0bdqmLE4CmNsYke0yJEawd8LCGN3pdJGIGjKFe+JoIS6b27F
         3mMx3c2uuUAow/TEz/xnxloUh+jIxmSR3Kw9q5I+zRgV8sfNYXujLfkilrzdqSb6M54q
         x2AvTftRjxbCjkpMECa47FeeJLY1Ub3RS0mxen+BsrZA86Q05pG3IM15ceNA7ytwqmAE
         HTRA==
X-Gm-Message-State: AOAM5323imflNQcKCsftTuh1NqWvWWUUDVH7uAWeen7eXH+ZPNPP0rMI
        7Lm2Vug71tbFEBAsOjRNc9q2vXA2IaNfZZDNCQQ=
X-Google-Smtp-Source: ABdhPJwvW5eDxmq7+kKPDMbtDKo+Ob4KM7BNh706ChSrHP+VwKMa0Z8NlTiT3fkgmAFx6R2vi66qmg==
X-Received: by 2002:a2e:874b:: with SMTP id q11mr4563120ljj.369.1635426294017;
        Thu, 28 Oct 2021 06:04:54 -0700 (PDT)
Received: from RTLAP54.localdomain (h-213-136-33-86.NA.cust.bahnhof.se. [213.136.33.86])
        by smtp.gmail.com with ESMTPSA id f33sm307142lfv.255.2021.10.28.06.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 06:04:53 -0700 (PDT)
From:   Joakim Plate <joakim.plate@rt-labs.com>
To:     linux-spi@vger.kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        Joakim Plate <joakim.plate@rt-labs.com>
Subject: [PATCH] spi: imx: Respect delay_us
Date:   Thu, 28 Oct 2021 15:05:00 +0200
Message-Id: <20211028130500.6727-1-joakim.plate@rt-labs.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Make the driver respect the set delay between transfers. It will
pre-calculate the maximum delay for the set of requested transfers
and use that between each transfer. The reference manual is
unclear on what happens if you change the period registry
mid stream.

Signed-off-by: Joakim Plate <joakim.plate@rt-labs.com>
---
 drivers/spi/spi-imx.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index b2dd0a4d2446..03a2986c7246 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
@@ -97,6 +98,7 @@ struct spi_imx_data {
 	struct clk *clk_ipg;
 	unsigned long spi_clk;
 	unsigned int spi_bus_clk;
+	unsigned int delay_usecs;
 
 	unsigned int bits_per_word;
 	unsigned int spi_drctl;
@@ -283,6 +285,11 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 #define MX51_ECSPI_STAT		0x18
 #define MX51_ECSPI_STAT_RR		(1 <<  3)
 
+#define MX51_ECSPI_PERIODREG	0x1C
+#define MX51_ECSPI_PERIODREG_SAMPLEPERIOD(period)	((period) & 0x7FFF)
+#define MX51_ECSPI_PERIODREG_CSRC			BIT(15)
+#define MX51_ECSPI_PERIODREG_CSD(csd)			(((csd) & 0x3f) << 16)
+
 #define MX51_ECSPI_TESTREG	0x20
 #define MX51_ECSPI_TESTREG_LBC	BIT(31)
 
@@ -513,7 +520,7 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 	struct spi_transfer *xfer;
 	u32 ctrl = MX51_ECSPI_CTRL_ENABLE;
 	u32 min_speed_hz = ~0U;
-	u32 testreg, delay;
+	u32 testreg, delay, delay_usecs = 0;
 	u32 cfg = readl(spi_imx->base + MX51_ECSPI_CONFIG);
 
 	/* set Master or Slave mode */
@@ -574,6 +581,15 @@ static int mx51_ecspi_prepare_message(struct spi_imx_data *spi_imx,
 
 	writel(cfg, spi_imx->base + MX51_ECSPI_CONFIG);
 
+
+	/*
+	 * Store maximum transfers delay to avoid changing in burst
+	 */
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		if (xfer->delay_usecs > delay_usecs)
+			delay_usecs = xfer->delay_usecs;
+	}
+
 	/*
 	 * Wait until the changes in the configuration register CONFIGREG
 	 * propagate into the hardware. It takes exactly one tick of the
@@ -611,6 +627,9 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 {
 	u32 ctrl = readl(spi_imx->base + MX51_ECSPI_CTRL);
 	u32 clk;
+	u32 period = 0;
+	u64 ticks;
+
 
 	/* Clear BL field and set the right value */
 	ctrl &= ~MX51_ECSPI_CTRL_BL_MASK;
@@ -627,6 +646,17 @@ static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
 	ctrl |= mx51_ecspi_clkdiv(spi_imx, spi_imx->spi_bus_clk, &clk);
 	spi_imx->spi_bus_clk = clk;
 
+	/* set sample rate */
+	ticks = mul_u64_u32_div(spi_imx->delay_usecs, clk, 1000000);
+	if (ticks <= 0x7FFF) {
+		period |= MX51_ECSPI_PERIODREG_SAMPLEPERIOD(ticks);
+	} else {
+		ticks = mul_u64_u32_div(spi_imx->delay_usecs, 32768, 1000000);
+		period |= MX51_ECSPI_PERIODREG_SAMPLEPERIOD(ticks);
+		period |= MX51_ECSPI_PERIODREG_CSRC;
+	}
+	writel(period, spi_imx->base + MX51_ECSPI_PERIODREG);
+
 	/*
 	 * ERR009165: work in XHC mode instead of SMC as PIO on the chips
 	 * before i.mx6ul.
-- 
2.25.1

