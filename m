Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548F64EAEF3
	for <lists+linux-spi@lfdr.de>; Tue, 29 Mar 2022 16:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237685AbiC2OCg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 29 Mar 2022 10:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237692AbiC2OCc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 29 Mar 2022 10:02:32 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A39B25718E
        for <linux-spi@vger.kernel.org>; Tue, 29 Mar 2022 07:00:46 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:d553:ff0a:6830:6bde])
        by baptiste.telenet-ops.be with bizsmtp
        id CE0h2701F49QC4401E0is4; Tue, 29 Mar 2022 16:00:44 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nZCOn-007HIU-Ab; Tue, 29 Mar 2022 16:00:41 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nZCOm-00CLAZ-Qe; Tue, 29 Mar 2022 16:00:40 +0200
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
Subject: [PATCH 2/2] spi: rpc-if: Fix RPM imbalance in probe error path
Date:   Tue, 29 Mar 2022 16:00:39 +0200
Message-Id: <1c78a1f447d019bb66b6e7787f520ae78821e2ae.1648562287.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <d196bb5849843993557a9b10f3bd28a752e5e8e0.1648562287.git.geert+renesas@glider.be>
References: <d196bb5849843993557a9b10f3bd28a752e5e8e0.1648562287.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

If rpcif_hw_init() fails, Runtime PM is left enabled.

Fixes: b04cc0d912eb80d3 ("memory: renesas-rpc-if: Add support for RZ/G2L")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
For the spi tree.

 drivers/spi/spi-rpc-if.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index fe82f3575df4f386..24ec1c83f379ceec 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -158,14 +158,18 @@ static int rpcif_spi_probe(struct platform_device *pdev)
 
 	error = rpcif_hw_init(rpc, false);
 	if (error)
-		return error;
+		goto out_disable_rpm;
 
 	error = spi_register_controller(ctlr);
 	if (error) {
 		dev_err(&pdev->dev, "spi_register_controller failed\n");
-		rpcif_disable_rpm(rpc);
+		goto out_disable_rpm;
 	}
 
+	return 0;
+
+out_disable_rpm:
+	rpcif_disable_rpm(rpc);
 	return error;
 }
 
-- 
2.25.1

