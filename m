Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69ED2E7A1F
	for <lists+linux-spi@lfdr.de>; Wed, 30 Dec 2020 15:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgL3O6v (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Dec 2020 09:58:51 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:57220 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726161AbgL3O6v (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Dec 2020 09:58:51 -0500
X-IronPort-AV: E=Sophos;i="5.78,461,1599490800"; 
   d="scan'208";a="67489849"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 30 Dec 2020 23:57:59 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 627C4400CA1D;
        Wed, 30 Dec 2020 23:57:57 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Mark Brown <broonie@kernel.org>, Jiri Kosina <trivial@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Pavel Machek <pavel@denx.de>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/2] spi: rpc-if: Remove CONFIG_PM_SLEEP ifdefery
Date:   Wed, 30 Dec 2020 14:57:08 +0000
Message-Id: <20201230145708.28544-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201230145708.28544-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201230145708.28544-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use __maybe_unused for the suspend()/resume() hooks and get rid of
the CONFIG_PM_SLEEP ifdefery to improve the code.

Suggested-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/spi/spi-rpc-if.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index bf64da322e67..b600becd4691 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -176,15 +176,14 @@ static int rpcif_spi_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int rpcif_spi_suspend(struct device *dev)
+static int __maybe_unused rpcif_spi_suspend(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
 
 	return spi_controller_suspend(ctlr);
 }
 
-static int rpcif_spi_resume(struct device *dev)
+static int __maybe_unused rpcif_spi_resume(struct device *dev)
 {
 	struct spi_controller *ctlr = dev_get_drvdata(dev);
 
@@ -192,17 +191,13 @@ static int rpcif_spi_resume(struct device *dev)
 }
 
 static SIMPLE_DEV_PM_OPS(rpcif_spi_pm_ops, rpcif_spi_suspend, rpcif_spi_resume);
-#define DEV_PM_OPS	(&rpcif_spi_pm_ops)
-#else
-#define DEV_PM_OPS	NULL
-#endif
 
 static struct platform_driver rpcif_spi_driver = {
 	.probe	= rpcif_spi_probe,
 	.remove	= rpcif_spi_remove,
 	.driver = {
 		.name	= "rpc-if-spi",
-		.pm	= DEV_PM_OPS,
+		.pm	= &rpcif_spi_pm_ops,
 	},
 };
 module_platform_driver(rpcif_spi_driver);
-- 
2.17.1

