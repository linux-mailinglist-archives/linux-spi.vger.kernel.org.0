Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1878649DDA9
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jan 2022 10:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiA0JSU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Jan 2022 04:18:20 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:49377 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbiA0JSU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Jan 2022 04:18:20 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9857C100012;
        Thu, 27 Jan 2022 09:18:17 +0000 (UTC)
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
Subject: [PATCH v10 04/13] spi: mxic: Provide a capability structure
Date:   Thu, 27 Jan 2022 10:17:59 +0100
Message-Id: <20220127091808.1043392-5-miquel.raynal@bootlin.com>
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
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Link: https://lore.kernel.org/linux-mtd/20220104083631.40776-5-miquel.raynal@bootlin.com
---
 drivers/spi/spi-mxic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index 45889947afed..9952fcdf3627 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -448,6 +448,10 @@ static const struct spi_controller_mem_ops mxic_spi_mem_ops = {
 	.exec_op = mxic_spi_mem_exec_op,
 };
 
+static const struct spi_controller_mem_caps mxic_spi_mem_caps = {
+	.dtr = true,
+};
+
 static void mxic_spi_set_cs(struct spi_device *spi, bool lvl)
 {
 	struct mxic_spi *mxic = spi_master_get_devdata(spi->master);
@@ -580,6 +584,7 @@ static int mxic_spi_probe(struct platform_device *pdev)
 
 	master->num_chipselect = 1;
 	master->mem_ops = &mxic_spi_mem_ops;
+	master->mem_caps = &mxic_spi_mem_caps;
 
 	master->set_cs = mxic_spi_set_cs;
 	master->transfer_one = mxic_spi_transfer_one;
-- 
2.27.0

