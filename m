Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC7B1F8CDA
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 06:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgFOEGJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 00:06:09 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:50533 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728201AbgFOEGH (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 00:06:07 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id EDF1D891B2;
        Mon, 15 Jun 2020 16:05:57 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1592193957;
        bh=aYu5nfgaWwoNizinGEq9qqfsv0a+/kTso+vvT11d+U8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=w+RKgGlSdShLQkZZbeKBgGpX4s4d7ddCTiZTugf+0vXSgzIknKngcZcY2lHlrX0t+
         6lGXdJN7xTavUK1H8py0tS3etkNRF2c0M5H3tIAjE9/rxk1CfOYcek2B3Fr4/LODTv
         edqfFJA+IcOebXZaRgUDKe/nG4WUdxZVpKxBV37DV46G50hXdUSb+fVsCSlz0fA+NG
         okDamSd2VdcugN0MX42gjqoHovX9reoYFoHVydhaHJNoOA68gmlCGh5V5fh2iL9OKb
         a2kHatZvW9YxWtEnfkdQdzlyyW5rFUZT44I4bLSHsVr3MD3HMb93YTIsiJzQ60/WiA
         5m3kYcRl3RdYQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5ee6f3a50004>; Mon, 15 Jun 2020 16:05:57 +1200
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.25])
        by smtp (Postfix) with ESMTP id A189F13EEBA;
        Mon, 15 Jun 2020 16:05:56 +1200 (NZST)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
        id 54E84341107; Mon, 15 Jun 2020 16:05:57 +1200 (NZST)
From:   Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To:     broonie@kernel.org, kdasu.kdev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Subject: [PATCH 3/5] spi: bcm-qspi: Do not split transfers into small chunks
Date:   Mon, 15 Jun 2020 16:05:55 +1200
Message-Id: <20200615040557.2011-4-mark.tomlinson@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200615040557.2011-1-mark.tomlinson@alliedtelesis.co.nz>
References: <20200615040557.2011-1-mark.tomlinson@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Instead of splitting transfers into smaller parts, just perform the
operation that the higher level asked for.

Reviewed-by: Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
---
 drivers/spi/spi-bcm-qspi.c | 69 +++++++++++++++-----------------------
 1 file changed, 27 insertions(+), 42 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 92e04d24359f..ce30ebf27f06 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -78,8 +78,6 @@
 #define BSPI_BPP_MODE_SELECT_MASK		BIT(8)
 #define BSPI_BPP_ADDR_SELECT_MASK		BIT(16)
=20
-#define BSPI_READ_LENGTH			256
-
 /* MSPI register offsets */
 #define MSPI_SPCR0_LSB				0x000
 #define MSPI_SPCR0_MSB				0x004
@@ -888,9 +886,9 @@ static int bcm_qspi_bspi_exec_mem_op(struct spi_devic=
e *spi,
 				     const struct spi_mem_op *op)
 {
 	struct bcm_qspi *qspi =3D spi_master_get_devdata(spi->master);
-	u32 addr =3D 0, len, rdlen, len_words, from =3D 0;
+	u32 addr =3D 0, len, len_words, from =3D 0;
 	int ret =3D 0;
-	unsigned long timeo =3D msecs_to_jiffies(100);
+	unsigned long timeo =3D msecs_to_jiffies(1500);
 	struct bcm_qspi_soc_intc *soc_intc =3D qspi->soc_intc;
=20
 	if (bcm_qspi_bspi_ver_three(qspi))
@@ -925,47 +923,34 @@ static int bcm_qspi_bspi_exec_mem_op(struct spi_dev=
ice *spi,
 	 * into RAF buffer read lengths
 	 */
 	len =3D op->data.nbytes;
+	reinit_completion(&qspi->bspi_done);
+	bcm_qspi_enable_bspi(qspi);
+	len_words =3D (len + 3) >> 2;
+	qspi->bspi_rf_op =3D op;
+	qspi->bspi_rf_op_status =3D 0;
 	qspi->bspi_rf_op_idx =3D 0;
+	qspi->bspi_rf_op_len =3D len;
+	dev_dbg(&qspi->pdev->dev, "bspi xfr addr 0x%x len 0x%x", addr, len);
=20
-	do {
-		if (len > BSPI_READ_LENGTH)
-			rdlen =3D BSPI_READ_LENGTH;
-		else
-			rdlen =3D len;
-
-		reinit_completion(&qspi->bspi_done);
-		bcm_qspi_enable_bspi(qspi);
-		len_words =3D (rdlen + 3) >> 2;
-		qspi->bspi_rf_op =3D op;
-		qspi->bspi_rf_op_status =3D 0;
-		qspi->bspi_rf_op_len =3D rdlen;
-		dev_dbg(&qspi->pdev->dev,
-			"bspi xfr addr 0x%x len 0x%x", addr, rdlen);
-		bcm_qspi_write(qspi, BSPI, BSPI_RAF_START_ADDR, addr);
-		bcm_qspi_write(qspi, BSPI, BSPI_RAF_NUM_WORDS, len_words);
-		bcm_qspi_write(qspi, BSPI, BSPI_RAF_WATERMARK, 0);
-		if (qspi->soc_intc) {
-			/*
-			 * clear soc MSPI and BSPI interrupts and enable
-			 * BSPI interrupts.
-			 */
-			soc_intc->bcm_qspi_int_ack(soc_intc, MSPI_BSPI_DONE);
-			soc_intc->bcm_qspi_int_set(soc_intc, BSPI_DONE, true);
-		}
-
-		/* Must flush previous writes before starting BSPI operation */
-		mb();
-		bcm_qspi_bspi_lr_start(qspi);
-		if (!wait_for_completion_timeout(&qspi->bspi_done, timeo)) {
-			dev_err(&qspi->pdev->dev, "timeout waiting for BSPI\n");
-			ret =3D -ETIMEDOUT;
-			break;
-		}
+	bcm_qspi_write(qspi, BSPI, BSPI_RAF_START_ADDR, addr);
+	bcm_qspi_write(qspi, BSPI, BSPI_RAF_NUM_WORDS, len_words);
+	bcm_qspi_write(qspi, BSPI, BSPI_RAF_WATERMARK, 0);
+	if (qspi->soc_intc) {
+		/*
+		 * clear soc MSPI and BSPI interrupts and enable
+		 * BSPI interrupts.
+		 */
+		soc_intc->bcm_qspi_int_ack(soc_intc, MSPI_BSPI_DONE);
+		soc_intc->bcm_qspi_int_set(soc_intc, BSPI_DONE, true);
+	}
=20
-		/* set msg return length */
-		addr +=3D rdlen;
-		len -=3D rdlen;
-	} while (len);
+	/* Must flush previous writes before starting BSPI operation */
+	mb();
+	bcm_qspi_bspi_lr_start(qspi);
+	if (!wait_for_completion_timeout(&qspi->bspi_done, timeo)) {
+		dev_err(&qspi->pdev->dev, "timeout waiting for BSPI\n");
+		ret =3D -ETIMEDOUT;
+	}
=20
 	return ret;
 }
--=20
2.27.0

