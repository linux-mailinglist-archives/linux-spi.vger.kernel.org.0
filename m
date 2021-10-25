Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60EC143A54A
	for <lists+linux-spi@lfdr.de>; Mon, 25 Oct 2021 22:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234859AbhJYU7h (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 25 Oct 2021 16:59:37 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:27422 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234955AbhJYU70 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 25 Oct 2021 16:59:26 -0400
X-IronPort-AV: E=Sophos;i="5.87,181,1631545200"; 
   d="scan'208";a="98142156"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 26 Oct 2021 05:57:02 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5D67C41003BB;
        Tue, 26 Oct 2021 05:56:59 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Mark Brown <broonie@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 6/7] memory: renesas-rpc-if: Drop usage of RPCIF_DIRMAP_SIZE macro
Date:   Mon, 25 Oct 2021 21:56:30 +0100
Message-Id: <20211025205631.21151-7-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211025205631.21151-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20211025205631.21151-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

RPCIF_DIRMAP_SIZE may differ on various SoC's. Instead of using
RPCIF_DIRMAP_SIZE macro use resource size to get dirmap size
which is already part of struct rpcif.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
v1->v2:
 * New patch (split from patch 5 of v1)
 * Included RB tags
---
 drivers/memory/renesas-rpc-if.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index ff8bcbccac63..0c56decc91f2 100644
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
@@ -588,8 +586,8 @@ static void memcpy_fromio_readw(void *to,
 
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

