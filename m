Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3A63A2898
	for <lists+linux-spi@lfdr.de>; Thu, 10 Jun 2021 11:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhFJJog (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 10 Jun 2021 05:44:36 -0400
Received: from inva020.nxp.com ([92.121.34.13]:39380 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229910AbhFJJog (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 10 Jun 2021 05:44:36 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 91B6E1A2D18;
        Thu, 10 Jun 2021 11:42:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva020.eu-rdc02.nxp.com 91B6E1A2D18
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com;
        s=nselector3; t=1623318159;
        bh=3w1sfa3CO9Xj2jrcPfz4ysg+zKaZWDRvwT2y0auMxHU=;
        h=From:To:Cc:Subject:Date:From;
        b=d7H8MlfZnMyPzVk5FfDaYa3EoEtK2/Iqh9oo3trAQSqXjgah6WzqkQoLaxdCSRpLU
         Myzp9Qp6ciK2kDWNLJHDK4+JOv2Utv/glObaefnSXmtlvSRgpPwtiNCh/BT02u0jsK
         /0Bi5ANocBUxChtuvSy9qCUYYS42Ell4ix2VqDxMfePU+tY1ypJ7YaWbTBvQYB/esh
         IeQYu+4aYoiQXgDkdbcnarT6hb3lI5Wu6LUuOczsNSGeUlhIxEk7SUNOxUJDP9dSx+
         rxLO6gnooK+GJDvtQ0054Mzd5d7MzU0Vl4wvTC+gy/+H/7lu0R9bikr6gxdrhjU19Z
         l2xO6Ed+ijStg==
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 31DD21A15A6;
        Thu, 10 Jun 2021 11:42:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva020.eu-rdc02.nxp.com 31DD21A15A6
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id A6352402CF;
        Thu, 10 Jun 2021 17:42:31 +0800 (+08)
From:   haibo.chen@nxp.com
To:     ashish.kumar@nxp.com, ran.wang_1@nxp.com, broonie@kernel.org
Cc:     yogeshgaur.83@gmail.com, linux-spi@vger.kernel.org,
        linux-imx@nxp.com, han.xu@nxp.com, haibo.chen@nxp.com
Subject: [PATCH] spi: spi-nxp-fspi: move the register operation after the clock enable
Date:   Thu, 10 Jun 2021 17:24:33 +0800
Message-Id: <1623317073-25158-1-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

Move the register operation after the clock enable, otherwise system
will stuck when this driver probe.

Fixes: 71d80563b076 ("spi: spi-nxp-fspi: fix fspi panic by unexpected interrupts")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 6e6c2403944d..a66fa97046ee 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1124,12 +1124,6 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 		goto err_put_ctrl;
 	}
 
-	/* Clear potential interrupts */
-	reg = fspi_readl(f, f->iobase + FSPI_INTR);
-	if (reg)
-		fspi_writel(f, reg, f->iobase + FSPI_INTR);
-
-
 	/* find the resources - controller memory mapped space */
 	if (is_acpi_node(f->dev->fwnode))
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
@@ -1167,6 +1161,11 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 		}
 	}
 
+	/* Clear potential interrupts */
+	reg = fspi_readl(f, f->iobase + FSPI_INTR);
+	if (reg)
+		fspi_writel(f, reg, f->iobase + FSPI_INTR);
+
 	/* find the irq */
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
-- 
2.17.1

