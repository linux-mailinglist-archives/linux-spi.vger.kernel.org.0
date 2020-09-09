Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D64C263907
	for <lists+linux-spi@lfdr.de>; Thu, 10 Sep 2020 00:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgIIW3g (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Sep 2020 18:29:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64572 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729251AbgIIW3K (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Sep 2020 18:29:10 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 089M3I76048530;
        Wed, 9 Sep 2020 18:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Jbzy47k15Gl7iTqrNjk/B3jp2eOGezuGMDVGQqgJAmw=;
 b=AXLyVirPqbXAVxpqsUxX75VzgvV33gVzCl3gjc4dgKPko8vHzFwxem8TSUXAhDCYEPR1
 EZh/Ew2qzYyBNxPVxMSWhb7/gPkMDT46h2mb5mFUzjXZVZNSpUOs1SmP5VeUVZmR3Tdk
 hRW9ai9rD7MGDh/QTiqYyN3cM7yq/tIHXDuoyfUdmC0tziVyo6ifHKHirF21uHvrRC1j
 9YQ8pC56Ck/0WRbWkuwcJCoOwrs8zCL0gwr4kq1Woz/u5FNuo7gxlAusOK6OiLXZGteL
 FGgEXhnm3QCYCJvJu0baewY/3XgCZupxxJnTk5hWmpsq0aNgrdmxNwy9YynFIqB/T2Zf XQ== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33f5nnutpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 18:29:03 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 089MRXX7027618;
        Wed, 9 Sep 2020 22:29:02 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04wdc.us.ibm.com with ESMTP id 33c2a92qxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Sep 2020 22:29:02 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 089MSwHO30212480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Sep 2020 22:28:58 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F333136053;
        Wed,  9 Sep 2020 22:29:01 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3109F13604F;
        Wed,  9 Sep 2020 22:29:01 +0000 (GMT)
Received: from SHADE6A.ibmuc.com (unknown [9.163.76.239])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  9 Sep 2020 22:29:01 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        joel@jms.id.au, broonie@kernel.org, bradleyb@fuzziesquirrel.com,
        robh+dt@kernel.org, arnd@arndb.de, eajames@linux.ibm.com
Subject: [PATCH v2 5/6] spi: fsi: Implement restricted size for certain controllers
Date:   Wed,  9 Sep 2020 17:28:56 -0500
Message-Id: <20200909222857.28653-6-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909222857.28653-1-eajames@linux.ibm.com>
References: <20200909222857.28653-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_17:2020-09-09,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 mlxscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=1 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090192
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Some of the FSI-attached SPI controllers cannot use the loop command in
programming the sequencer due to security requirements. Check the
devicetree compatibility that indicates this condition and restrict the
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
index c31a852b6a3e..a702e9d7d68c 100644
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
 
+		if (of_device_is_compatible(np, "ibm,fsi2spi-restricted")) {
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

