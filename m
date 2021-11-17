Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E570C453D75
	for <lists+linux-spi@lfdr.de>; Wed, 17 Nov 2021 02:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhKQBIl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 16 Nov 2021 20:08:41 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:15400 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229543AbhKQBIl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 16 Nov 2021 20:08:41 -0500
X-IronPort-AV: E=Sophos;i="5.87,239,1631545200"; 
   d="scan'208";a="100509789"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Nov 2021 10:05:42 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 94F53400F4FA;
        Wed, 17 Nov 2021 10:05:40 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-spi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/3] spi: spi-rspi: Add support to deassert/assert reset line
Date:   Wed, 17 Nov 2021 01:05:26 +0000
Message-Id: <20211117010527.27365-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211117010527.27365-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211117010527.27365-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On RZ/G2L SoC we need to explicitly deassert the reset line
for the device to work, use this opportunity to deassert/assert
reset line in spi-rspi driver.

This patch adds support to read the "resets" property (if available)
from DT and perform deassert/assert when required.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/spi/spi-rspi.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index d16ed88802d3..592682d96562 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -21,6 +21,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/of_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <linux/sh_dma.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/rspi.h>
@@ -1225,8 +1226,14 @@ static const struct of_device_id rspi_of_match[] = {
 
 MODULE_DEVICE_TABLE(of, rspi_of_match);
 
+static void rspi_reset_control_assert(void *data)
+{
+	reset_control_assert(data);
+}
+
 static int rspi_parse_dt(struct device *dev, struct spi_controller *ctlr)
 {
+	struct reset_control *rstc;
 	u32 num_cs;
 	int error;
 
@@ -1238,6 +1245,24 @@ static int rspi_parse_dt(struct device *dev, struct spi_controller *ctlr)
 	}
 
 	ctlr->num_chipselect = num_cs;
+
+	rstc = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(rstc))
+		return dev_err_probe(dev, PTR_ERR(rstc),
+					     "failed to get reset ctrl\n");
+
+	error = reset_control_deassert(rstc);
+	if (error) {
+		dev_err(dev, "failed to deassert reset %d\n", error);
+		return error;
+	}
+
+	error = devm_add_action_or_reset(dev, rspi_reset_control_assert, rstc);
+	if (error) {
+		dev_err(dev, "failed to register assert devm action, %d\n", error);
+		return error;
+	}
+
 	return 0;
 }
 #else
-- 
2.17.1

