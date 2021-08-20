Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CAF3F2818
	for <lists+linux-spi@lfdr.de>; Fri, 20 Aug 2021 10:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhHTIGy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 20 Aug 2021 04:06:54 -0400
Received: from inva020.nxp.com ([92.121.34.13]:42146 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230036AbhHTIGx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 20 Aug 2021 04:06:53 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A95451A2CFC;
        Fri, 20 Aug 2021 10:06:15 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7A0851A2CD7;
        Fri, 20 Aug 2021 10:06:15 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A3E27183AD0B;
        Fri, 20 Aug 2021 16:06:14 +0800 (+08)
From:   haibo.chen@nxp.com
To:     ashish.kumar@nxp.com, yogeshgaur.83@gmail.com, broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-imx@nxp.com, haibo.chen@nxp.com
Subject: [PATCH 3/4] spi: spi-nxp-fspi: add DDR mode support
Date:   Fri, 20 Aug 2021 15:44:02 +0800
Message-Id: <1629445443-10300-3-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629445443-10300-1-git-send-email-haibo.chen@nxp.com>
References: <1629445443-10300-1-git-send-email-haibo.chen@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

For LUT, add DDR command support.
Also use new API spi_mem_dtr_supports_op() to check the DTR mode.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index a764eb475aed..f7acad2cbe64 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -486,6 +486,9 @@ static bool nxp_fspi_supports_op(struct spi_mem *mem,
 	    op->data.nbytes > f->devtype_data->txfifo)
 		return false;
 
+	if (op->cmd.dtr && op->addr.dtr && op->dummy.dtr && op->data.dtr)
+		return spi_mem_dtr_supports_op(mem, op);
+
 	return spi_mem_default_supports_op(mem, op);
 }
 
@@ -534,12 +537,22 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
 	int lutidx = 1, i;
 
 	/* cmd */
-	lutval[0] |= LUT_DEF(0, LUT_CMD, LUT_PAD(op->cmd.buswidth),
-			     op->cmd.opcode);
+	if (op->cmd.dtr) {
+		lutval[0] |= LUT_DEF(0, LUT_CMD_DDR, LUT_PAD(op->cmd.buswidth),
+				     op->cmd.opcode >> 8);
+		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_CMD_DDR,
+					      LUT_PAD(op->cmd.buswidth),
+					      op->cmd.opcode & 0x00ff);
+		lutidx++;
+	} else {
+		lutval[0] |= LUT_DEF(0, LUT_CMD, LUT_PAD(op->cmd.buswidth),
+				     op->cmd.opcode);
+	}
 
 	/* addr bytes */
 	if (op->addr.nbytes) {
-		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_ADDR,
+		lutval[lutidx / 2] |= LUT_DEF(lutidx, op->addr.dtr ?
+					      LUT_ADDR_DDR : LUT_ADDR,
 					      LUT_PAD(op->addr.buswidth),
 					      op->addr.nbytes * 8);
 		lutidx++;
@@ -547,7 +560,8 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
 
 	/* dummy bytes, if needed */
 	if (op->dummy.nbytes) {
-		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_DUMMY,
+		lutval[lutidx / 2] |= LUT_DEF(lutidx, op->dummy.dtr ?
+					      LUT_DUMMY_DDR : LUT_DUMMY,
 		/*
 		 * Due to FlexSPI controller limitation number of PAD for dummy
 		 * buswidth needs to be programmed as equal to data buswidth.
@@ -562,7 +576,8 @@ static void nxp_fspi_prepare_lut(struct nxp_fspi *f,
 	if (op->data.nbytes) {
 		lutval[lutidx / 2] |= LUT_DEF(lutidx,
 					      op->data.dir == SPI_MEM_DATA_IN ?
-					      LUT_NXP_READ : LUT_NXP_WRITE,
+					      (op->data.dtr ? LUT_READ_DDR : LUT_NXP_READ) :
+					      (op->data.dtr ? LUT_WRITE_DDR : LUT_NXP_WRITE),
 					      LUT_PAD(op->data.buswidth),
 					      0);
 		lutidx++;
-- 
2.17.1

