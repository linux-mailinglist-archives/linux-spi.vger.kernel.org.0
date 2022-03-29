Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EF94EAEF1
	for <lists+linux-spi@lfdr.de>; Tue, 29 Mar 2022 16:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237684AbiC2OCe (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Mar 2022 10:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237685AbiC2OCc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Mar 2022 10:02:32 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FAF255AA2
        for <linux-spi@vger.kernel.org>; Tue, 29 Mar 2022 07:00:46 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:d553:ff0a:6830:6bde])
        by baptiste.telenet-ops.be with bizsmtp
        id CE0i2700M49QC4401E0is9; Tue, 29 Mar 2022 16:00:44 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nZCOn-007HIT-Rx; Tue, 29 Mar 2022 16:00:41 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nZCOm-00CLAV-PA; Tue, 29 Mar 2022 16:00:40 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] mtd: hyperbus: rpc-if: Fix RPM imbalance in probe error path
Date:   Tue, 29 Mar 2022 16:00:38 +0200
Message-Id: <d196bb5849843993557a9b10f3bd28a752e5e8e0.1648562287.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If rpcif_hw_init() fails, Runtime PM is left enabled.

Fixes: b04cc0d912eb80d3 ("memory: renesas-rpc-if: Add support for RZ/G2L")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
For the mtd tree.

 drivers/mtd/hyperbus/rpc-if.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/hyperbus/rpc-if.c b/drivers/mtd/hyperbus/rpc-if.c
index 6e08ec1d4f098c80..b70d259e48a7c728 100644
--- a/drivers/mtd/hyperbus/rpc-if.c
+++ b/drivers/mtd/hyperbus/rpc-if.c
@@ -134,7 +134,7 @@ static int rpcif_hb_probe(struct platform_device *pdev)
 
 	error = rpcif_hw_init(&hyperbus->rpc, true);
 	if (error)
-		return error;
+		goto out_disable_rpm;
 
 	hyperbus->hbdev.map.size = hyperbus->rpc.size;
 	hyperbus->hbdev.map.virt = hyperbus->rpc.dirmap;
@@ -145,8 +145,12 @@ static int rpcif_hb_probe(struct platform_device *pdev)
 	hyperbus->hbdev.np = of_get_next_child(pdev->dev.parent->of_node, NULL);
 	error = hyperbus_register_device(&hyperbus->hbdev);
 	if (error)
-		rpcif_disable_rpm(&hyperbus->rpc);
+		goto out_disable_rpm;
+
+	return 0;
 
+out_disable_rpm:
+	rpcif_disable_rpm(&hyperbus->rpc);
 	return error;
 }
 
-- 
2.25.1

