Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CC51E82A4
	for <lists+linux-spi@lfdr.de>; Fri, 29 May 2020 17:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgE2P6O (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 May 2020 11:58:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbgE2P6O (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 29 May 2020 11:58:14 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 734DA2072D;
        Fri, 29 May 2020 15:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590767893;
        bh=DKe6k1X2sNZ70atW9Z+9GVwAyAKVYlyY5QzaAyE/cxg=;
        h=From:To:Cc:Subject:Date:From;
        b=h1fFz0g0JdXyYAUhlce+XjTpPSxI1Y3mpe62hzgpHexkdlnrBjJqZoWVco0nmaT1r
         t/ndMGO4dkMXBU37MvqKq+dfiijYoQ9Vn9vA+IjuHKu8JzQ9pHcnzZ8zKOqit6a59g
         gDZTmzi+bY9aNJF8iNAbUwsBxvWyGmcwr9P/OeSU=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     dinguyen@kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org, broonie@kernel.org, robh+dt@kernel.org,
        Sergey.Semin@baikalelectronics.ru, fancer.lancer@gmail.com,
        andriy.shevchenko@linux.intel.com, lars.povlsen@microchip.com,
        liang.j.jin@ericsson.com
Subject: [PATCHv4 1/2] spi: dw: add reset control
Date:   Fri, 29 May 2020 10:58:05 -0500
Message-Id: <20200529155806.16758-1-dinguyen@kernel.org>
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
v4: no change
v3: allow for other failures
    remove tab for rstc reset_control
v2: use _get_optional_exclusive
    put IP back into reset if there was an error in probe function
---
 drivers/spi/spi-dw-mmio.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-dw-mmio.c b/drivers/spi/spi-dw-mmio.c
index 0894b4c09496..a1b87d4606ba 100644
--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -19,6 +19,7 @@
 #include <linux/acpi.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 
 #include "spi-dw.h"
 
@@ -29,6 +30,7 @@ struct dw_spi_mmio {
 	struct clk     *clk;
 	struct clk     *pclk;
 	void           *priv;
+	struct reset_control *rstc;
 };
 
 #define MSCC_CPU_SYSTEM_CTRL_GENERAL_CTRL	0x24
@@ -224,6 +226,14 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_clk;
 
+	/* find an optional reset controller */
+	dwsmmio->rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, "spi");
+	if (IS_ERR(dwsmmio->rstc)) {
+		ret = PTR_ERR(dwsmmio->rstc);
+		goto out_clk;
+	}
+	reset_control_deassert(dwsmmio->rstc);
+
 	dws->bus_num = pdev->id;
 
 	dws->max_freq = clk_get_rate(dwsmmio->clk);
@@ -257,6 +267,8 @@ static int dw_spi_mmio_probe(struct platform_device *pdev)
 	clk_disable_unprepare(dwsmmio->pclk);
 out_clk:
 	clk_disable_unprepare(dwsmmio->clk);
+	reset_control_assert(dwsmmio->rstc);
+
 	return ret;
 }
 
@@ -268,6 +280,7 @@ static int dw_spi_mmio_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	clk_disable_unprepare(dwsmmio->pclk);
 	clk_disable_unprepare(dwsmmio->clk);
+	reset_control_assert(dwsmmio->rstc);
 
 	return 0;
 }
-- 
2.17.1

