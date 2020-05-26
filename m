Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5903A1E251A
	for <lists+linux-spi@lfdr.de>; Tue, 26 May 2020 17:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbgEZPMd (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 26 May 2020 11:12:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728442AbgEZPMd (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 26 May 2020 11:12:33 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE3392070A;
        Tue, 26 May 2020 15:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590505953;
        bh=a2UmATCEGkPccI7kZvMXYrJC+peopdphgNXcACi5eT8=;
        h=From:To:Cc:Subject:Date:From;
        b=Os3x/pdMeuvMGeLDe2z/CJvKVmSM9loLzmaswaVOzP8AM5JQvs1JfM1S0sEWUvqE7
         5YmUEYCWSy7vQz4evVmtiTZerm4hpO6I/Z8vngVD2S3rWLqR/0VMWJL4XLz83SUwea
         YL5Y4NJYxVoZt+E02QfS7I/zUheh7f0RwA3eIeQ8=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, devicetree@vger.kernel.org,
        broonie@kernel.org, robh+dt@kernel.org, linux-spi@vger.kernel.org,
        Sergey.Semin@baikalelectronics.ru, fancer.lancer@gmail.com,
        andriy.shevchenko@linux.intel.com, lars.povlsen@microchip.com,
        Liang Jin J <liang.j.jin@ericsson.com>
Subject: [PATCHv2 1/2] spi: dw: add reset control
Date:   Tue, 26 May 2020 10:12:17 -0500
Message-Id: <20200526151218.6186-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add mechanism to get the reset control and deassert it in order to bring
the IP out of reset.

Signed-off-by: Liang Jin J <liang.j.jin@ericsson.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v2: use _get_optional_exclusive
    put IP back into reset if there was an error in probe function
---
 drivers/spi/spi-dw-mmio.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 384a3ab6dc2d..07e015b6d03d 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -20,6 +20,7 @@
 #include <linux/acpi.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 
 #include "spi-dw.h"
 
@@ -30,6 +31,7 @@ struct dw_spi_mmio {
 	struct clk     *clk;
 	struct clk     *pclk;
 	void           *priv;
+	struct reset_control	*rstc;
 };
 
 #define MSCC_CPU_SYSTEM_CTRL_GENERAL_CTRL	0x24
@@ -175,6 +177,14 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_clk;
 
+	/* find an optional reset controller */
+	dwsmmio->rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, "spi");
+	if (IS_ERR(dwsmmio->rstc)) {
+		if (PTR_ERR(dwsmmio->rstc) == -EPROBE_DEFER)
+			return PTR_ERR(dwsmmio->rstc);
+	}
+	reset_control_deassert(dwsmmio->rstc);
+
 	dws->bus_num = pdev->id;
 
 	dws->max_freq = clk_get_rate(dwsmmio->clk);
@@ -208,6 +218,8 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	clk_disable_unprepare(dwsmmio->pclk);
 out_clk:
 	clk_disable_unprepare(dwsmmio->clk);
+	reset_control_assert(dwsmmio->rstc);
+
 	return ret;
 }
 
@@ -219,6 +231,7 @@ static int dw_spi_mmio_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(dwsmmio->pclk);
 	clk_disable_unprepare(dwsmmio->clk);
+	reset_control_assert(dwsmmio->rstc);
 
 	return 0;
 }
-- 
2.17.1

