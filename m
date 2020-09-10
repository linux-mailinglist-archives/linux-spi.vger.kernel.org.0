Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867F1264611
	for <lists+linux-spi@lfdr.de>; Thu, 10 Sep 2020 14:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbgIJMbw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Sep 2020 08:31:52 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42372 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730520AbgIJM1H (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 10 Sep 2020 08:27:07 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08ACQo4g021584;
        Thu, 10 Sep 2020 07:26:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599740810;
        bh=aSRRKgMiRYB3BUkLsakdjF41LClHJbgT9tc8NKlD2lI=;
        h=From:To:CC:Subject:Date;
        b=wDduFtR1B/RiVlS+/8as01OdH913gKeAYyj2jdDuNgcxbVxC6Uz8uVMfrXiEfUXSb
         qP0PsWgFnyiAjtYY5sb2Y9uHMAJ8Vk0EfyKnmyklkq6pZFtYHtQ3uOWjl81Cv5CCzd
         I7fUDO7tbjj90eQXsovRSJdcY/7ioWGiXwixR3Cc=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08ACQoCf090907
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Sep 2020 07:26:50 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 10
 Sep 2020 07:26:50 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 10 Sep 2020 07:26:50 -0500
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08ACQlC9035892;
        Thu, 10 Sep 2020 07:26:48 -0500
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Aswath Govindraju <a-govindraju@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Mark Brown <broonie@kernel.org>,
        Vignesh R <vigneshr@ti.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] Revert "spi: omap2-mcspi: Switch to readl_poll_timeout()"
Date:   Thu, 10 Sep 2020 17:56:24 +0530
Message-ID: <20200910122624.8769-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This reverts commit 13d515c796adc49a49b0cd2212ccd7f43a37fc5a.

The amount of time spent polling for the MCSPI_CHSTAT bits to be set on
AM335x-icev2 platform is less than 1us (about 0.6us) in most cases, with
or without using DMA. So, in most cases the function need not sleep.
Also, setting the sleep_usecs to zero would not be optimal here because
ktime_add_us() used in readl_poll_timeout() is slower compared to the
direct addition used after the revert. So, it is sub-optimal to use
readl_poll_timeout in this case. 

When DMA is not enabled, this revert results in an increase of about 27%
in throughput and decrease of about 20% in CPU usage. However, the CPU
usage and throughput are almost the same when used with DMA. 

Therefore, fix this by reverting the commit which switched to using
readl_poll_timeout().

Fixes: 13d515c796ad ("spi: omap2-mcspi: Switch to readl_poll_timeout()")
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---

 drivers/spi/spi-omap2-mcspi.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 1c9478e6e5d9..d4c9510af393 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -24,7 +24,6 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/gcd.h>
-#include <linux/iopoll.h>
 
 #include <linux/spi/spi.h>
 
@@ -348,9 +347,19 @@ static void omap2_mcspi_set_fifo(const struct spi_device *spi,
 
 static int mcspi_wait_for_reg_bit(void __iomem *reg, unsigned long bit)
 {
-	u32 val;
-
-	return readl_poll_timeout(reg, val, val & bit, 1, MSEC_PER_SEC);
+	unsigned long timeout;
+
+	timeout = jiffies + msecs_to_jiffies(1000);
+	while (!(readl_relaxed(reg) & bit)) {
+		if (time_after(jiffies, timeout)) {
+			if (!(readl_relaxed(reg) & bit))
+				return -ETIMEDOUT;
+			else
+				return 0;
+		}
+		cpu_relax();
+	}
+	return 0;
 }
 
 static int mcspi_wait_for_completion(struct  omap2_mcspi *mcspi,

base-commit: dff9f829e5b0181d4ed9d35aa62d695292399b54
-- 
2.17.1

