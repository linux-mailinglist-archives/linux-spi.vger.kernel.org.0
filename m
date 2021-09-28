Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E79641B1AA
	for <lists+linux-spi@lfdr.de>; Tue, 28 Sep 2021 16:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241173AbhI1OJh (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Sep 2021 10:09:37 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:53552 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241202AbhI1OJc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Sep 2021 10:09:32 -0400
X-IronPort-AV: E=Sophos;i="5.85,329,1624287600"; 
   d="scan'208";a="95295300"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 28 Sep 2021 23:07:51 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 452A74007535;
        Tue, 28 Sep 2021 23:07:48 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5/6] memory: renesas-rpc-if: Drop usage of RPCIF_DIRMAP_SIZE macro
Date:   Tue, 28 Sep 2021 15:07:20 +0100
Message-Id: <20210928140721.8805-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210928140721.8805-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210928140721.8805-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

RPCIF_DIRMAP_SIZE may differ on various SoC's. Instead of using
RPCIF_DIRMAP_SIZE macro use resource size to get dirmap size
which is already part of struct rpcif.

Also make sure we return error in case devm_ioremap_resource()
fails for dirmap.

Fixes: ca7d8b980b67 ("memory: add Renesas RPC-IF driver")
Fixes: 59e27d7c94aa ("memory: renesas-rpc-if: fix possible NULL pointer dereference of resource")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 77a011d5ff8c..140cb4e2b789 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -147,8 +147,6 @@
 #define RPCIF_PHYINT		0x0088	/* R/W */
 #define RPCIF_PHYINT_WPVAL	BIT(1)
 
-#define RPCIF_DIRMAP_SIZE	0x4000000
-
 static const struct regmap_range rpcif_volatile_ranges[] = {
 	regmap_reg_range(RPCIF_SMRDR0, RPCIF_SMRDR1),
 	regmap_reg_range(RPCIF_SMWDR0, RPCIF_SMWDR1),
@@ -244,7 +242,7 @@ int rpcif_sw_init(struct rpcif *rpc, struct device *dev)
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dirmap");
 	rpc->dirmap = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(rpc->dirmap))
-		rpc->dirmap = NULL;
+		return PTR_ERR(rpc->dirmap);
 	rpc->size = resource_size(res);
 
 	rpc->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
@@ -547,8 +545,8 @@ EXPORT_SYMBOL(rpcif_manual_xfer);
 
 ssize_t rpcif_dirmap_read(struct rpcif *rpc, u64 offs, size_t len, void *buf)
 {
-	loff_t from = offs & (RPCIF_DIRMAP_SIZE - 1);
-	size_t size = RPCIF_DIRMAP_SIZE - from;
+	loff_t from = offs & (rpc->size - 1);
+	size_t size = rpc->size - from;
 
 	if (len > size)
 		len = size;
-- 
2.17.1

