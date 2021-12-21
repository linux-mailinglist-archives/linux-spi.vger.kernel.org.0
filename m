Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F4547C552
	for <lists+linux-spi@lfdr.de>; Tue, 21 Dec 2021 18:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240574AbhLURs4 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Dec 2021 12:48:56 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:52427 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhLURsz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Dec 2021 12:48:55 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 78CD920000F;
        Tue, 21 Dec 2021 17:48:53 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>
Cc:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v8 04/14] spi: cadence-quadspi: Provide a capability structure
Date:   Tue, 21 Dec 2021 18:48:34 +0100
Message-Id: <20211221174844.56385-5-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211221174844.56385-1-miquel.raynal@bootlin.com>
References: <20211221174844.56385-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This controller has DTR support, so advertize it with a capability now
that the spi_controller_mem_ops structure contains this new field. This
will later be used by the core to discriminate whether an operation is
supported or not, in a more generic way than having different helpers.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 101cc71bffa7..98e0cc4236e3 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1388,10 +1388,15 @@ static const char *cqspi_get_name(struct spi_mem *mem)
 	return devm_kasprintf(dev, GFP_KERNEL, "%s.%d", dev_name(dev), mem->spi->chip_select);
 }
 
+static const struct spi_controller_mem_caps cqspi_mem_caps = {
+	.dtr = true,
+};
+
 static const struct spi_controller_mem_ops cqspi_mem_ops = {
 	.exec_op = cqspi_exec_mem_op,
 	.get_name = cqspi_get_name,
 	.supports_op = cqspi_supports_mem_op,
+	.caps = &cqspi_mem_caps,
 };
 
 static int cqspi_setup_flash(struct cqspi_st *cqspi)
-- 
2.27.0

