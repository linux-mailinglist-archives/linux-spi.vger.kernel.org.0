Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDD12ED314
	for <lists+linux-spi@lfdr.de>; Thu,  7 Jan 2021 15:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbhAGOzH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Jan 2021 09:55:07 -0500
Received: from relmlor1.renesas.com ([210.160.252.171]:34261 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726151AbhAGOzH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Jan 2021 09:55:07 -0500
X-IronPort-AV: E=Sophos;i="5.79,329,1602514800"; 
   d="scan'208";a="68320324"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 07 Jan 2021 23:54:15 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id B8DF54010916;
        Thu,  7 Jan 2021 23:54:13 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Pavel Machek <pavel@denx.de>, Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] spi: rpc-if: Gaurd .pm assignment with CONFIG_PM_SLEEP #ifdef check
Date:   Thu,  7 Jan 2021 14:53:29 +0000
Message-Id: <20210107145329.27966-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

With CONFIG_PM_SLEEP disabled the rpcif_spi_pm_ops variable is still
referenced and thus increasing the size of kernel.

Fix this issue by adding CONFIG_PM_SLEEP #ifdef check around the .pm
assignment (image size is critical on RZ/A SoC's where the SRAM sizes
range 4~5 MiB).

Fixes: 9584fc95cadc0 ("spi: rpc-if: Remove CONFIG_PM_SLEEP ifdefery")
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Suggested-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/spi/spi-rpc-if.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index c313dbe6185c..c53138ce0030 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -197,7 +197,9 @@ static struct platform_driver rpcif_spi_driver = {
 	.remove	= rpcif_spi_remove,
 	.driver = {
 		.name	= "rpc-if-spi",
+#ifdef CONFIG_PM_SLEEP
 		.pm	= &rpcif_spi_pm_ops,
+#endif
 	},
 };
 module_platform_driver(rpcif_spi_driver);
-- 
2.17.1

