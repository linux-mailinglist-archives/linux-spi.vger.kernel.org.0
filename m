Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5A424C416
	for <lists+linux-spi@lfdr.de>; Thu, 20 Aug 2020 19:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbgHTRGo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Aug 2020 13:06:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729881AbgHTREc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Aug 2020 13:04:32 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07KH3auR158774;
        Thu, 20 Aug 2020 13:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Kuv6Z602OrDP7XL8CfwTaxRwKEzEbQZE7a88DsQJgMA=;
 b=isPq4NSuR9H/O1UzNxhuG6O9rXZWw7NGJKgPmEQNXZW4FxAjvd2tt5t6aR/X1+BGAa2L
 QOW7sBx+xLpitMMy6bQYERjxoPoMb4GYZPt+Vs6llgfMz1dGzcxH7zYyniiVzaFskzS8
 jR1Gs0/iGSc+mmh67xbhVSIAHE6FOd3/3UfiHo54BjWQhcQY4gCYPRY3vr2tU9QPGt+I
 xNIKliUywcc5F/Kb07IgtvxEd1yamwtXa9CLswQrwe4r3b3EnRv+2X8APv3b6Mo/wc5N
 aLs2adrJhEFGnXOKBFTYgAdFFnMchqXouAdm0D8tF4YkzaqBVQ2vUnu9tQg2EZ1ruL7q 4A== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3304rvg5xe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Aug 2020 13:04:14 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07KGjb9B029957;
        Thu, 20 Aug 2020 17:02:36 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02dal.us.ibm.com with ESMTP id 3304cd38xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Aug 2020 17:02:36 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07KH2Z2M53805558
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Aug 2020 17:02:36 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E27A4AE062;
        Thu, 20 Aug 2020 17:02:35 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 059B9AE066;
        Thu, 20 Aug 2020 17:02:35 +0000 (GMT)
Received: from SHADE6A.ibmuc.com (unknown [9.163.70.74])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 20 Aug 2020 17:02:34 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        eajames@linux.ibm.com, joel@jms.id.au, bradleyb@fuzziesquirrel.com,
        broonie@kernel.org, robh+dt@kernel.org, arnd@arndb.de
Subject: [PATCH 5/7] spi: fsi: Implement restricted size for certain controllers
Date:   Thu, 20 Aug 2020 12:02:26 -0500
Message-Id: <20200820170228.42053-6-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200820170228.42053-1-eajames@linux.ibm.com>
References: <20200820170228.42053-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-20_03:2020-08-19,2020-08-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 suspectscore=1 phishscore=0 spamscore=0
 impostorscore=0 adultscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008200135
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Some of the FSI-attached SPI controllers cannot use the loop command in
programming the sequencer due to security requirements. Add a boolean
devicetree property that describes this condition and restrict the
size for these controllers. Also, add more transfers directly in the
sequence up to the length of the sequence register.

Fixes: bbb6b2f9865b ("spi: Add FSI-attached SPI controller driver")
Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 drivers/spi/spi-fsi.c | 65 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 53 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-fsi.c b/drivers/spi/spi-fsi.c
index c31a852b6a3e..53cfa201e187 100644
--- a/drivers/spi/spi-fsi.c
+++ b/drivers/spi/spi-fsi.c
@@ -24,7 +24,8 @@
 
 #define SPI_FSI_BASE			0x70000
 #define SPI_FSI_INIT_TIMEOUT_MS		1000
-#define SPI_FSI_MAX_TRANSFER_SIZE	2048
+#define SPI_FSI_MAX_XFR_SIZE		2048
+#define SPI_FSI_MAX_XFR_SIZE_RESTRICTED	32
 
 #define SPI_FSI_ERROR			0x0
 #define SPI_FSI_COUNTER_CFG		0x1
@@ -74,6 +75,8 @@ struct fsi_spi {
 	struct device *dev;	/* SPI controller device */
 	struct fsi_device *fsi;	/* FSI2SPI CFAM engine device */
 	u32 base;
+	size_t max_xfr_size;
+	bool restricted;
 };
 
 struct fsi_spi_sequence {
@@ -209,8 +212,12 @@ static int fsi_spi_reset(struct fsi_spi *ctx)
 	if (rc)
 		return rc;
 
-	return fsi_spi_write_reg(ctx, SPI_FSI_CLOCK_CFG,
-				 SPI_FSI_CLOCK_CFG_RESET2);
+	rc = fsi_spi_write_reg(ctx, SPI_FSI_CLOCK_CFG,
+			       SPI_FSI_CLOCK_CFG_RESET2);
+	if (rc)
+		return rc;
+
+	return fsi_spi_write_reg(ctx, SPI_FSI_STATUS, 0ULL);
 }
 
 static int fsi_spi_sequence_add(struct fsi_spi_sequence *seq, u8 val)
@@ -218,8 +225,8 @@ static int fsi_spi_sequence_add(struct fsi_spi_sequence *seq, u8 val)
 	/*
 	 * Add the next byte of instruction to the 8-byte sequence register.
 	 * Then decrement the counter so that the next instruction will go in
-	 * the right place. Return the number of "slots" left in the sequence
-	 * register.
+	 * the right place. Return the index of the slot we just filled in the
+	 * sequence register.
 	 */
 	seq->data |= (u64)val << seq->bit;
 	seq->bit -= 8;
@@ -237,9 +244,11 @@ static int fsi_spi_sequence_transfer(struct fsi_spi *ctx,
 				     struct fsi_spi_sequence *seq,
 				     struct spi_transfer *transfer)
 {
+	bool docfg = false;
 	int loops;
 	int idx;
 	int rc;
+	u8 val = 0;
 	u8 len = min(transfer->len, 8U);
 	u8 rem = transfer->len % len;
 	u64 cfg = 0ULL;
@@ -247,22 +256,42 @@ static int fsi_spi_sequence_transfer(struct fsi_spi *ctx,
 	loops = transfer->len / len;
 
 	if (transfer->tx_buf) {
-		idx = fsi_spi_sequence_add(seq,
-					   SPI_FSI_SEQUENCE_SHIFT_OUT(len));
+		val = SPI_FSI_SEQUENCE_SHIFT_OUT(len);
+		idx = fsi_spi_sequence_add(seq, val);
+
 		if (rem)
 			rem = SPI_FSI_SEQUENCE_SHIFT_OUT(rem);
 	} else if (transfer->rx_buf) {
-		idx = fsi_spi_sequence_add(seq,
-					   SPI_FSI_SEQUENCE_SHIFT_IN(len));
+		val = SPI_FSI_SEQUENCE_SHIFT_IN(len);
+		idx = fsi_spi_sequence_add(seq, val);
+
 		if (rem)
 			rem = SPI_FSI_SEQUENCE_SHIFT_IN(rem);
 	} else {
 		return -EINVAL;
 	}
 
+	if (ctx->restricted) {
+		const int eidx = rem ? 5 : 6;
+
+		while (loops > 1 && idx <= eidx) {
+			idx = fsi_spi_sequence_add(seq, val);
+			loops--;
+			docfg = true;
+		}
+
+		if (loops > 1) {
+			dev_warn(ctx->dev, "No sequencer slots; aborting.\n");
+			return -EINVAL;
+		}
+	}
+
 	if (loops > 1) {
 		fsi_spi_sequence_add(seq, SPI_FSI_SEQUENCE_BRANCH(idx));
+		docfg = true;
+	}
 
+	if (docfg) {
 		cfg = SPI_FSI_COUNTER_CFG_LOOPS(loops - 1);
 		if (transfer->rx_buf)
 			cfg |= SPI_FSI_COUNTER_CFG_N2_RX |
@@ -273,6 +302,8 @@ static int fsi_spi_sequence_transfer(struct fsi_spi *ctx,
 		rc = fsi_spi_write_reg(ctx, SPI_FSI_COUNTER_CFG, cfg);
 		if (rc)
 			return rc;
+	} else {
+		fsi_spi_write_reg(ctx, SPI_FSI_COUNTER_CFG, 0ULL);
 	}
 
 	if (rem)
@@ -429,7 +460,7 @@ static int fsi_spi_transfer_one_message(struct spi_controller *ctlr,
 
 		/* Sequencer must do shift out (tx) first. */
 		if (!transfer->tx_buf ||
-		    transfer->len > SPI_FSI_MAX_TRANSFER_SIZE) {
+		    transfer->len > (ctx->max_xfr_size + 8)) {
 			rc = -EINVAL;
 			goto error;
 		}
@@ -453,7 +484,7 @@ static int fsi_spi_transfer_one_message(struct spi_controller *ctlr,
 
 			/* Sequencer can only do shift in (rx) after tx. */
 			if (next->rx_buf) {
-				if (next->len > SPI_FSI_MAX_TRANSFER_SIZE) {
+				if (next->len > ctx->max_xfr_size) {
 					rc = -EINVAL;
 					goto error;
 				}
@@ -498,7 +529,9 @@ static int fsi_spi_transfer_one_message(struct spi_controller *ctlr,
 
 static size_t fsi_spi_max_transfer_size(struct spi_device *spi)
 {
-	return SPI_FSI_MAX_TRANSFER_SIZE;
+	struct fsi_spi *ctx = spi_controller_get_devdata(spi->controller);
+
+	return ctx->max_xfr_size;
 }
 
 static int fsi_spi_probe(struct device *dev)
@@ -546,6 +579,14 @@ static int fsi_spi_probe(struct device *dev)
 		ctx->fsi = fsi;
 		ctx->base = base + SPI_FSI_BASE;
 
+		if (of_property_read_bool(np, "fsi2spi,restricted")) {
+			ctx->restricted = true;
+			ctx->max_xfr_size = SPI_FSI_MAX_XFR_SIZE_RESTRICTED;
+		} else {
+			ctx->restricted = false;
+			ctx->max_xfr_size = SPI_FSI_MAX_XFR_SIZE;
+		}
+
 		rc = devm_spi_register_controller(dev, ctlr);
 		if (rc)
 			spi_controller_put(ctlr);
-- 
2.26.2

