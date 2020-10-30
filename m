Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B291729FE62
	for <lists+linux-spi@lfdr.de>; Fri, 30 Oct 2020 08:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgJ3HZM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Oct 2020 03:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3HZL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 30 Oct 2020 03:25:11 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED71C0613D3;
        Fri, 30 Oct 2020 00:25:10 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t6so2527598plq.11;
        Fri, 30 Oct 2020 00:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hw/KvprqF2aWL/drMKTS7o6ufRsuBx5x5vRDgirN2WY=;
        b=mGOR8hd7i0ta5xeu/n+B2eq8da3ixbJY2wWNH+Sk0jHMDG5oUDnhDEhRuRw/rTFBN7
         LVPNhafi/GRSJJwI9lLrcEn2nYWJcXm2IbgsBayFQNobmyQ6rtQTVu0S3hEjkZB5P21W
         OhC6CkCW3Qbmor01eJpgXmRdyLlcudxhoqnbzQtmat4KMmL/3QOXW5Dm7cfWJaYPt1tl
         udqazUPqrtAfkKSR7ThsiU7qfRp9tERKA29pp/p64BFFGsU+wQzi5H2Fe62R4ZxnhSxd
         l2pjrxRtTcpCeQxAumJ6ZBDS6GwfII6gs/p5oGW/wI672SzKmhQhc/Ep+Qo/C832Eekd
         rSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hw/KvprqF2aWL/drMKTS7o6ufRsuBx5x5vRDgirN2WY=;
        b=g4siQ0W5wGF2q1uzUZk0CqYQXr0USYpA6Zr8EbHcaFYg+wTSyLUU12EFv45sGV44lA
         AJOI0goXfdW6ch8uTQf5/WovIIbSDXaUdnNVykWZp12UWn0WWTiGFF1dGC58HagB4hby
         ejy1ak4lfErmFCfX9daEMmrslVacEWpjzXRBiKoXsFwZEoiDnxJCRcIdc73QW+zZgEW2
         Fp326GHGwfoRhBkBJCpfW4N+pqK4ajlhLixgZ/9CB8itY021ABurMc67/URHJ1jB4+5V
         X0OSo52NtYv+0ATqSofFh6FQA4lVRZTrrpvempVo1jtZ5pepN6sJXrokqNR/XHJEI5xM
         3zPQ==
X-Gm-Message-State: AOAM532Toc+LMhqtrrP7gGQfEPYkUsRKcUuYZHVqhNtEflxKmseNKXiX
        JGgojHtCKvvb38KwU9i9VCE=
X-Google-Smtp-Source: ABdhPJwwSDxlAVPNV6R9bvmn4/zwrH64JjCCMrXyWhUNz/DKEn4/f4wt2kdJC6/9SHjhTLGsSKH/5A==
X-Received: by 2002:a17:902:bd03:b029:d6:89e2:5b5e with SMTP id p3-20020a170902bd03b02900d689e25b5emr6831929pls.70.1604042710013;
        Fri, 30 Oct 2020 00:25:10 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id h2sm2126510pjv.15.2020.10.30.00.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 00:25:09 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Bangzheng Liu <bangzheng.liu@unisoc.com>
Subject: [PATCH] spi: sprd: add runtime pm for transfer message
Date:   Fri, 30 Oct 2020 15:24:44 +0800
Message-Id: <20201030072444.22122-1-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Bangzheng Liu <bangzheng.liu@unisoc.com>

Before transfer one message, spi core would set chipselect, sprd spi
device should be resumed from runtime suspend, otherwise kernel would
crash once access spi registers. The sprd spi device can be suspended
until clearing chipselect which would be executed after transfer.

Fixes: e7d973a31c24 ("spi: sprd: Add SPI driver for Spreadtrum SC9860")
Signed-off-by: Bangzheng Liu <bangzheng.liu@unisoc.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/spi/spi-sprd.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index 635738f54c73..1733d10eb296 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -293,15 +293,25 @@ static void sprd_spi_chipselect(struct spi_device *sdev, bool cs)
 	struct spi_controller *sctlr = sdev->controller;
 	struct sprd_spi *ss = spi_controller_get_devdata(sctlr);
 	u32 val;
+	int ret;
 
-	val = readl_relaxed(ss->base + SPRD_SPI_CTL0);
 	/*  The SPI controller will pull down CS pin if cs is 0 */
 	if (!cs) {
-		val &= ~SPRD_SPI_CS0_VALID;
+		ret = pm_runtime_get_sync(ss->dev);
+		if (ret < 0) {
+			pm_runtime_put_noidle(ss->dev);
+			dev_err(ss->dev, "Failed to power device: %d\n", ret);
+			return;
+		}
+		val = readl_relaxed(ss->base + SPRD_SPI_CTL0);
+		val &= ~SPRD_SPI_CS0_VALID; /* set cs0 valid */
 		writel_relaxed(val, ss->base + SPRD_SPI_CTL0);
 	} else {
-		val |= SPRD_SPI_CSN_MASK;
+		val = readl_relaxed(ss->base + SPRD_SPI_CTL0);
+		val |= SPRD_SPI_CSN_MASK; /* set all cs invalid */
 		writel_relaxed(val, ss->base + SPRD_SPI_CTL0);
+		pm_runtime_mark_last_busy(ss->dev);
+		pm_runtime_put_autosuspend(ss->dev);
 	}
 }
 
-- 
2.20.1

