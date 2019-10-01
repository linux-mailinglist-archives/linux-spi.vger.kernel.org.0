Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40375C2F67
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2019 10:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfJAI7c (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 1 Oct 2019 04:59:32 -0400
Received: from inva020.nxp.com ([92.121.34.13]:49236 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729031AbfJAI7c (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 1 Oct 2019 04:59:32 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 1D0501A001A;
        Tue,  1 Oct 2019 10:59:30 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E328B1A091F;
        Tue,  1 Oct 2019 10:59:26 +0200 (CEST)
Received: from lsv03124.swis.in-blr01.nxp.com (lsv03124.swis.in-blr01.nxp.com [92.120.146.121])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E31954029A;
        Tue,  1 Oct 2019 16:59:22 +0800 (SGT)
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     han.xu@nxp.com, broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kuldeep Singh <kuldeep.singh@nxp.com>,
        Suresh Gupta <suresh.gupta@nxp.com>
Subject: [PATCH] spi: spi-fsl-qspi: Introduce variable to fix different invalid master Id
Date:   Tue,  1 Oct 2019 14:29:16 +0530
Message-Id: <1569920356-8953-1-git-send-email-kuldeep.singh@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Different platforms have different Master with different SourceID on
AHB bus. The 0X0E Master ID is used by cluster 3 in case of LS2088A.
So, patch introduce an invalid master id variable to fix invalid
mastered on different platforms.

Signed-off-by: Suresh Gupta <suresh.gupta@nxp.com>
Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
---
 drivers/spi/spi-fsl-qspi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index c02e24c..51385b0 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -63,6 +63,11 @@
 #define QUADSPI_IPCR			0x08
 #define QUADSPI_IPCR_SEQID(x)		((x) << 24)
 
+#define QUADSPI_BUF0CR                  0x10
+#define QUADSPI_BUF1CR                  0x14
+#define QUADSPI_BUF2CR                  0x18
+#define QUADSPI_BUFXCR_INVALID_MSTRID   0xe
+
 #define QUADSPI_BUF3CR			0x1c
 #define QUADSPI_BUF3CR_ALLMST_MASK	BIT(31)
 #define QUADSPI_BUF3CR_ADATSZ(x)	((x) << 8)
@@ -184,6 +189,7 @@
 struct fsl_qspi_devtype_data {
 	unsigned int rxfifo;
 	unsigned int txfifo;
+	int invalid_mstrid;
 	unsigned int ahb_buf_size;
 	unsigned int quirks;
 	bool little_endian;
@@ -192,6 +198,7 @@ struct fsl_qspi_devtype_data {
 static const struct fsl_qspi_devtype_data vybrid_data = {
 	.rxfifo = SZ_128,
 	.txfifo = SZ_64,
+	.invalid_mstrid = QUADSPI_BUFXCR_INVALID_MSTRID,
 	.ahb_buf_size = SZ_1K,
 	.quirks = QUADSPI_QUIRK_SWAP_ENDIAN,
 	.little_endian = true,
@@ -200,6 +207,7 @@ static const struct fsl_qspi_devtype_data vybrid_data = {
 static const struct fsl_qspi_devtype_data imx6sx_data = {
 	.rxfifo = SZ_128,
 	.txfifo = SZ_512,
+	.invalid_mstrid = QUADSPI_BUFXCR_INVALID_MSTRID,
 	.ahb_buf_size = SZ_1K,
 	.quirks = QUADSPI_QUIRK_4X_INT_CLK | QUADSPI_QUIRK_TKT245618,
 	.little_endian = true,
@@ -208,6 +216,7 @@ static const struct fsl_qspi_devtype_data imx6sx_data = {
 static const struct fsl_qspi_devtype_data imx7d_data = {
 	.rxfifo = SZ_128,
 	.txfifo = SZ_512,
+	.invalid_mstrid = QUADSPI_BUFXCR_INVALID_MSTRID,
 	.ahb_buf_size = SZ_1K,
 	.quirks = QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_4X_INT_CLK,
 	.little_endian = true,
@@ -216,6 +225,7 @@ static const struct fsl_qspi_devtype_data imx7d_data = {
 static const struct fsl_qspi_devtype_data imx6ul_data = {
 	.rxfifo = SZ_128,
 	.txfifo = SZ_512,
+	.invalid_mstrid = QUADSPI_BUFXCR_INVALID_MSTRID,
 	.ahb_buf_size = SZ_1K,
 	.quirks = QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_4X_INT_CLK,
 	.little_endian = true,
@@ -224,6 +234,7 @@ static const struct fsl_qspi_devtype_data imx6ul_data = {
 static const struct fsl_qspi_devtype_data ls1021a_data = {
 	.rxfifo = SZ_128,
 	.txfifo = SZ_64,
+	.invalid_mstrid = QUADSPI_BUFXCR_INVALID_MSTRID,
 	.ahb_buf_size = SZ_1K,
 	.quirks = 0,
 	.little_endian = false,
@@ -233,6 +244,7 @@ static const struct fsl_qspi_devtype_data ls2080a_data = {
 	.rxfifo = SZ_128,
 	.txfifo = SZ_64,
 	.ahb_buf_size = SZ_1K,
+	.invalid_mstrid = 0x0,
 	.quirks = QUADSPI_QUIRK_TKT253890 | QUADSPI_QUIRK_BASE_INTERNAL,
 	.little_endian = true,
 };
@@ -615,6 +627,7 @@ static int fsl_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	void __iomem *base = q->iobase;
 	u32 addr_offset = 0;
 	int err = 0;
+	int invalid_mstrid = q->devtype_data->invalid_mstrid;
 
 	mutex_lock(&q->lock);
 
@@ -638,6 +651,10 @@ static int fsl_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	qspi_writel(q, QUADSPI_SPTRCLR_BFPTRC | QUADSPI_SPTRCLR_IPPTRC,
 		    base + QUADSPI_SPTRCLR);
 
+	qspi_writel(q, invalid_mstrid, base + QUADSPI_BUF0CR);
+	qspi_writel(q, invalid_mstrid, base + QUADSPI_BUF1CR);
+	qspi_writel(q, invalid_mstrid, base + QUADSPI_BUF2CR);
+
 	fsl_qspi_prepare_lut(q, op);
 
 	/*
-- 
2.7.4

