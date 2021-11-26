Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D65045ED2D
	for <lists+linux-spi@lfdr.de>; Fri, 26 Nov 2021 12:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345594AbhKZMA0 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 26 Nov 2021 07:00:26 -0500
Received: from mslow1.mail.gandi.net ([217.70.178.240]:46551 "EHLO
        mslow1.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377063AbhKZL6V (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 26 Nov 2021 06:58:21 -0500
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id C4703C7A75;
        Fri, 26 Nov 2021 11:40:13 +0000 (UTC)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id D70B7FF81E;
        Fri, 26 Nov 2021 11:39:43 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        <linux-mtd@lists.infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        Xiangsheng Hou <Xiangsheng.Hou@mediatek.com>,
        Julien Su <juliensu@mxic.com.tw>,
        Jaime Liao <jaimeliao@mxic.com.tw>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 12/20] mtd: nand: Add a new helper to retrieve the ECC context
Date:   Fri, 26 Nov 2021 12:39:16 +0100
Message-Id: <20211126113924.310459-13-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211126113924.310459-1-miquel.raynal@bootlin.com>
References: <20211126113924.310459-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Introduce nand_to_ecc_ctx() which will allow to easily jump to the
private pointer of an ECC context given a NAND device. This is very
handy, from the prepare or finish ECC hook, to get the internal context
out of the NAND device object.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/linux/mtd/nand.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index e952f37d9aab..273bf699860f 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -990,6 +990,11 @@ int nanddev_markbad(struct nand_device *nand, const struct nand_pos *pos);
 int nanddev_ecc_engine_init(struct nand_device *nand);
 void nanddev_ecc_engine_cleanup(struct nand_device *nand);
 
+static inline void *nand_to_ecc_ctx(struct nand_device *nand)
+{
+	return nand->ecc.ctx.priv;
+}
+
 /* BBT related functions */
 enum nand_bbt_block_status {
 	NAND_BBT_BLOCK_STATUS_UNKNOWN,
-- 
2.27.0

