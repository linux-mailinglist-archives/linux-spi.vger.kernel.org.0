Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B7141B1A8
	for <lists+linux-spi@lfdr.de>; Tue, 28 Sep 2021 16:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241187AbhI1OJe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Sep 2021 10:09:34 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:51105 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241173AbhI1OJ2 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Sep 2021 10:09:28 -0400
X-IronPort-AV: E=Sophos;i="5.85,329,1624287600"; 
   d="scan'208";a="95295291"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 28 Sep 2021 23:07:47 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 59B9F4007535;
        Tue, 28 Sep 2021 23:07:44 +0900 (JST)
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
Subject: [PATCH 4/6] mtd: hyperbus: rpc-if: Check return value of rpcif_sw_init()
Date:   Tue, 28 Sep 2021 15:07:19 +0100
Message-Id: <20210928140721.8805-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210928140721.8805-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210928140721.8805-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

rpcif_sw_init() can fail so make sure we check the return value
of it and on error exit rpcif_hb_probe() callback with error code.

Fixes: 5de15b610f78 ("mtd: hyperbus: add Renesas RPC-IF driver")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mtd/hyperbus/rpc-if.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/hyperbus/rpc-if.c b/drivers/mtd/hyperbus/rpc-if.c
index ecb050ba95cd..367b0d72bf62 100644
--- a/drivers/mtd/hyperbus/rpc-if.c
+++ b/drivers/mtd/hyperbus/rpc-if.c
@@ -124,7 +124,9 @@ static int rpcif_hb_probe(struct platform_device *pdev)
 	if (!hyperbus)
 		return -ENOMEM;
 
-	rpcif_sw_init(&hyperbus->rpc, pdev->dev.parent);
+	error = rpcif_sw_init(&hyperbus->rpc, pdev->dev.parent);
+	if (error)
+		return error;
 
 	platform_set_drvdata(pdev, hyperbus);
 
-- 
2.17.1

