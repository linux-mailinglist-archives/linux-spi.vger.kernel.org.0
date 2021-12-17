Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F65479142
	for <lists+linux-spi@lfdr.de>; Fri, 17 Dec 2021 17:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbhLQQRN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Dec 2021 11:17:13 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:57187 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhLQQRM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Dec 2021 11:17:12 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 0A88020000D;
        Fri, 17 Dec 2021 16:17:08 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>
Cc:     Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v7 05/14] spi: mxic: Provide a capability structure
Date:   Fri, 17 Dec 2021 17:16:45 +0100
Message-Id: <20211217161654.367782-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211217161654.367782-1-miquel.raynal@bootlin.com>
References: <20211217161654.367782-1-miquel.raynal@bootlin.com>
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
 drivers/spi/spi-mxic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index 45889947afed..e137b1ec85d4 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -443,9 +443,14 @@ static int mxic_spi_mem_exec_op(struct spi_mem *mem,
 	return ret;
 }
 
+static const struct spi_controller_mem_caps mxic_spi_mem_caps = {
+	.dtr = true,
+};
+
 static const struct spi_controller_mem_ops mxic_spi_mem_ops = {
 	.supports_op = mxic_spi_mem_supports_op,
 	.exec_op = mxic_spi_mem_exec_op,
+	.caps = &mxic_spi_mem_caps,
 };
 
 static void mxic_spi_set_cs(struct spi_device *spi, bool lvl)
-- 
2.27.0

