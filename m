Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC68517D24
	for <lists+linux-spi@lfdr.de>; Tue,  3 May 2022 08:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiECGLN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 3 May 2022 02:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiECGLK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 3 May 2022 02:11:10 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E1535DC6;
        Mon,  2 May 2022 23:07:25 -0700 (PDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by gandalf.ozlabs.org (Postfix) with ESMTP id 4KsqHb5kSYz4ySs;
        Tue,  3 May 2022 16:07:23 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KsqHV3MYjz4xbw;
        Tue,  3 May 2022 16:07:18 +1000 (AEST)
From:   =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To:     linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Tao Ren <rentao.bupt@gmail.com>,
        Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Subject: [PATCH v6 06/11] spi: aspeed: Workaround AST2500 limitations
Date:   Tue,  3 May 2022 08:06:29 +0200
Message-Id: <20220503060634.122722-7-clg@kaod.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503060634.122722-1-clg@kaod.org>
References: <20220503060634.122722-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

It is not possible to configure a full 128MB window for a chip of the
same size on the AST2500 SPI controller. For this case, the maximum
window size is restricted to 120MB for CE0.

Reviewed-by: Joel Stanley <joel@jms.id.au>
Tested-by: Joel Stanley <joel@jms.id.au>
Tested-by: Tao Ren <rentao.bupt@gmail.com>
Tested-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 drivers/spi/spi-aspeed-smc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 0aff42e20b8d..d2b3342c133e 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -451,6 +451,8 @@ static int aspeed_spi_set_window(struct aspeed_spi *aspi,
  * - ioremap each window, not strictly necessary since the overall window
  *   is correct.
  */
+static const struct aspeed_spi_data ast2500_spi_data;
+
 static int aspeed_spi_chip_adjust_window(struct aspeed_spi_chip *chip,
 					 u32 local_offset, u32 size)
 {
@@ -459,6 +461,16 @@ static int aspeed_spi_chip_adjust_window(struct aspeed_spi_chip *chip,
 	struct aspeed_spi_window *win = &windows[chip->cs];
 	int ret;
 
+	/*
+	 * Due to an HW issue on the AST2500 SPI controller, the CE0
+	 * window size should be smaller than the maximum 128MB.
+	 */
+	if (aspi->data == &ast2500_spi_data && chip->cs == 0 && size == SZ_128M) {
+		size = 120 << 20;
+		dev_info(aspi->dev, "CE%d window resized to %dMB (AST2500 HW quirk)",
+			 chip->cs, size >> 20);
+	}
+
 	aspeed_spi_get_windows(aspi, windows);
 
 	/* Adjust this chip window */
-- 
2.35.1

