Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E4149DDA8
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jan 2022 10:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbiA0JST (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Jan 2022 04:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbiA0JST (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Jan 2022 04:18:19 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BEFC061714
        for <linux-spi@vger.kernel.org>; Thu, 27 Jan 2022 01:18:18 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E059A10000A;
        Thu, 27 Jan 2022 09:18:15 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v10 03/13] spi: cadence-quadspi: Provide a capability structure
Date:   Thu, 27 Jan 2022 10:17:58 +0100
Message-Id: <20220127091808.1043392-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220127091808.1043392-1-miquel.raynal@bootlin.com>
References: <20220127091808.1043392-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This controller has DTR support, so advertize it with a capability now
that the spi-controller structure contains this new field. This will
later be used by the core to discriminate whether an operation is
supported or not, in a more generic way than having different helpers.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Link: https://lore.kernel.org/linux-mtd/20220104083631.40776-4-miquel.raynal@bootlin.com
---
 drivers/spi/spi-cadence-quadspi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index b808c94641fa..455b90d1feed 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1595,6 +1595,10 @@ static const struct spi_controller_mem_ops cqspi_mem_ops = {
 	.supports_op = cqspi_supports_mem_op,
 };
 
+static const struct spi_controller_mem_caps cqspi_mem_caps = {
+	.dtr = true,
+};
+
 static int cqspi_setup_flash(struct cqspi_st *cqspi)
 {
 	struct platform_device *pdev = cqspi->pdev;
@@ -1652,6 +1656,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	}
 	master->mode_bits = SPI_RX_QUAD | SPI_RX_DUAL;
 	master->mem_ops = &cqspi_mem_ops;
+	master->mem_caps = &cqspi_mem_caps;
 	master->dev.of_node = pdev->dev.of_node;
 
 	cqspi = spi_master_get_devdata(master);
-- 
2.27.0

