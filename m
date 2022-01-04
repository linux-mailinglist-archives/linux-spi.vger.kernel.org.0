Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E37483E3D
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jan 2022 09:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiADIgl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Jan 2022 03:36:41 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:37763 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiADIgl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Jan 2022 03:36:41 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id C5F091C000C;
        Tue,  4 Jan 2022 08:36:38 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>
Cc:     Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v9 03/13] spi: cadence-quadspi: Provide a capability structure
Date:   Tue,  4 Jan 2022 09:36:21 +0100
Message-Id: <20220104083631.40776-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220104083631.40776-1-miquel.raynal@bootlin.com>
References: <20220104083631.40776-1-miquel.raynal@bootlin.com>
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
---
 drivers/spi/spi-cadence-quadspi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 101cc71bffa7..6705bbca12a6 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1394,6 +1394,10 @@ static const struct spi_controller_mem_ops cqspi_mem_ops = {
 	.supports_op = cqspi_supports_mem_op,
 };
 
+static const struct spi_controller_mem_caps cqspi_mem_caps = {
+	.dtr = true,
+};
+
 static int cqspi_setup_flash(struct cqspi_st *cqspi)
 {
 	struct platform_device *pdev = cqspi->pdev;
@@ -1451,6 +1455,7 @@ static int cqspi_probe(struct platform_device *pdev)
 	}
 	master->mode_bits = SPI_RX_QUAD | SPI_RX_DUAL;
 	master->mem_ops = &cqspi_mem_ops;
+	master->mem_caps = &cqspi_mem_caps;
 	master->dev.of_node = pdev->dev.of_node;
 
 	cqspi = spi_master_get_devdata(master);
-- 
2.27.0

