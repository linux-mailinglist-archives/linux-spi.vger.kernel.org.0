Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5831F8CD8
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 06:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgFOEGJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 00:06:09 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:50532 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbgFOEGG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 00:06:06 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id F09D6891B3;
        Mon, 15 Jun 2020 16:05:57 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1592193957;
        bh=fmOPOWqFEjhICH/CJcBM1aMmTfbp2ullBYimtm2xGqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=03XGX8VJM1bUCF8KCcqw8C79ZtdGD+vsEboW/rc9WTUmbFCf3npzpqFO0AIXyGfqA
         8u2en2GIffS7WDYF3OUlw5PnAequqHf8t4NEZuyWr4afpcc3ugm/4KbMBYR2kAJVCY
         hWx0UzrpJt4hSneHEI1B75df53C7saEA6232lc2qQ790256nSPjgwjIEW8e3Aw+UV1
         1RUQJwoPcemOtG4Ta4NOo2SKUCa3fUqBmYwL5iCOMLLN6tduBArORoPzxrP2eSNtmT
         mf4LkNJWQzYWXL6sU8o58gmFDX7jf86UKle0kFFPVu56tD9kfhtGpuHv7r+e3R0CV6
         ezmQTHS5gyiuQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5ee6f3a50005>; Mon, 15 Jun 2020 16:05:57 +1200
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.25])
        by smtp (Postfix) with ESMTP id A4EEF13EF9B;
        Mon, 15 Jun 2020 16:05:56 +1200 (NZST)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
        id 5845834125F; Mon, 15 Jun 2020 16:05:57 +1200 (NZST)
From:   Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To:     broonie@kernel.org, kdasu.kdev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Subject: [PATCH 4/5] spi: bcm-qspi: Make multiple data blocks interrupt-driven
Date:   Mon, 15 Jun 2020 16:05:56 +1200
Message-Id: <20200615040557.2011-5-mark.tomlinson@alliedtelesis.co.nz>
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

When needing to send/receive data in small chunks, make this interrupt
driven rather than waiting for a completion event for each small section
of data.

Reviewed-by: Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
---
 drivers/spi/spi-bcm-qspi.c | 44 ++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index ce30ebf27f06..0cc51bcda300 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -200,12 +200,14 @@ struct bcm_qspi_dev_id {
 struct qspi_trans {
 	struct spi_transfer *trans;
 	int byte;
+	int slots;
 	bool mspi_last_trans;
 };
=20
 struct bcm_qspi {
 	struct platform_device *pdev;
 	struct spi_master *master;
+	struct spi_device *spi_dev;
 	struct clk *clk;
 	u32 base_clk;
 	u32 max_speed_hz;
@@ -731,12 +733,14 @@ static inline u16 read_rxram_slot_u16(struct bcm_qs=
pi *qspi, int slot)
 		((bcm_qspi_read(qspi, MSPI, msb_offset) & 0xff) << 8);
 }
=20
-static void read_from_hw(struct bcm_qspi *qspi, int slots)
+static void read_from_hw(struct bcm_qspi *qspi)
 {
 	struct qspi_trans tp;
-	int slot;
+	int slot, slots;
=20
 	bcm_qspi_disable_bspi(qspi);
+	tp =3D qspi->trans_pos;
+	slots =3D tp.slots;
=20
 	if (slots > MSPI_NUM_CDRAM) {
 		/* should never happen */
@@ -744,8 +748,6 @@ static void read_from_hw(struct bcm_qspi *qspi, int s=
lots)
 		return;
 	}
=20
-	tp =3D qspi->trans_pos;
-
 	for (slot =3D 0; slot < slots; slot++) {
 		if (tp.trans->rx_buf) {
 			if (tp.trans->bits_per_word <=3D 8) {
@@ -803,11 +805,12 @@ static inline void write_cdram_slot(struct bcm_qspi=
 *qspi, int slot, u32 val)
 }
=20
 /* Return number of slots written */
-static int write_to_hw(struct bcm_qspi *qspi, struct spi_device *spi)
+static int write_to_hw(struct bcm_qspi *qspi)
 {
 	struct qspi_trans tp;
 	int slot =3D 0, tstatus =3D 0;
 	u32 mspi_cdram =3D 0;
+	struct spi_device *spi =3D qspi->spi_dev;
=20
 	bcm_qspi_disable_bspi(qspi);
 	tp =3D qspi->trans_pos;
@@ -846,6 +849,9 @@ static int write_to_hw(struct bcm_qspi *qspi, struct =
spi_device *spi)
 		slot++;
 	}
=20
+	/* save slot number for read_from_hw() */
+	qspi->trans_pos.slots =3D slot;
+
 	if (!slot) {
 		dev_err(&qspi->pdev->dev, "%s: no data to send?", __func__);
 		goto done;
@@ -960,24 +966,21 @@ static int bcm_qspi_transfer_one(struct spi_master =
*master,
 				 struct spi_transfer *trans)
 {
 	struct bcm_qspi *qspi =3D spi_master_get_devdata(master);
-	int slots;
-	unsigned long timeo =3D msecs_to_jiffies(100);
+	unsigned long timeo =3D msecs_to_jiffies(1000);
=20
 	if (!spi->cs_gpiod)
 		bcm_qspi_chip_select(qspi, spi->chip_select);
 	qspi->trans_pos.trans =3D trans;
 	qspi->trans_pos.byte =3D 0;
+	qspi->spi_dev =3D spi;
=20
-	while (qspi->trans_pos.byte < trans->len) {
-		reinit_completion(&qspi->mspi_done);
+	reinit_completion(&qspi->mspi_done);
=20
-		slots =3D write_to_hw(qspi, spi);
-		if (!wait_for_completion_timeout(&qspi->mspi_done, timeo)) {
-			dev_err(&qspi->pdev->dev, "timeout waiting for MSPI\n");
-			return -ETIMEDOUT;
-		}
+	write_to_hw(qspi);
=20
-		read_from_hw(qspi, slots);
+	if (!wait_for_completion_timeout(&qspi->mspi_done, timeo)) {
+		dev_err(&qspi->pdev->dev, "timeout waiting for MSPI\n");
+		return -ETIMEDOUT;
 	}
 	bcm_qspi_enable_bspi(qspi);
=20
@@ -1092,7 +1095,16 @@ static irqreturn_t bcm_qspi_mspi_l2_isr(int irq, v=
oid *dev_id)
 		bcm_qspi_write(qspi, MSPI, MSPI_MSPI_STATUS, status);
 		if (qspi->soc_intc)
 			soc_intc->bcm_qspi_int_ack(soc_intc, MSPI_DONE);
-		complete(&qspi->mspi_done);
+
+		read_from_hw(qspi);
+
+		if (qspi->trans_pos.trans) {
+			write_to_hw(qspi);
+		} else {
+			complete(&qspi->mspi_done);
+			spi_finalize_current_transfer(qspi->master);
+		}
+
 		return IRQ_HANDLED;
 	}
=20
--=20
2.27.0

