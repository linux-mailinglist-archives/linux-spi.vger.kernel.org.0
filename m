Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 365C91F8CD6
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 06:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725648AbgFOEGI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 00:06:08 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:50528 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgFOEGG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 00:06:06 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id F168D891B4;
        Mon, 15 Jun 2020 16:05:57 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1592193957;
        bh=14TIDfQM4sjvxFhCbCg35NzSBMoiXfw8Vj4bejq5yIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=l0Gx52Eec/kBwQTSjVGM1xUEVTnOBPvth+mR/mmHeqzS2g0bsS7raeSlSODiYpT7V
         W4ws/XLQ8vQ9ewAcH7jdo0ADllaXeioz1Q5nh3QQ1MttwRxS4n+NFMv+J4VluNhGT2
         cLJWS9knrdkCjO6ggsZ18jzofmykcZT98rgm+ZtiY3B+qPrvEmq+SgQuj5+eGnwchT
         +IRNrRDKwUO21kSMGf4KmfH5A5iFZxCIO6HY7Xj94lZKfP4mj62LWexSiHldtQCipY
         dOXKrnJGjKTXg8dXnzZJQqTv8uS5TwQR7kOZmJFoO+qIxmt5zGilQ3kUM5NRb9sNma
         74UeLuJR5tYXw==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5ee6f3a50003>; Mon, 15 Jun 2020 16:05:57 +1200
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.25])
        by smtp (Postfix) with ESMTP id AAFB113EDE4;
        Mon, 15 Jun 2020 16:05:56 +1200 (NZST)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
        id 5B313341283; Mon, 15 Jun 2020 16:05:57 +1200 (NZST)
From:   Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To:     broonie@kernel.org, kdasu.kdev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Subject: [PATCH 5/5] spi: bcm-qspi: Improve interrupt handling
Date:   Mon, 15 Jun 2020 16:05:57 +1200
Message-Id: <20200615040557.2011-6-mark.tomlinson@alliedtelesis.co.nz>
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

Acknowledge interrupts correctly and add support for fifo-full
interrupt, distinguishing it from the done interrupt.

Reviewed-by: Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
---
 drivers/spi/spi-bcm-qspi.c | 11 ++++++-----
 drivers/spi/spi-bcm-qspi.h |  5 ++++-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 0cc51bcda300..3753eff8a154 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -1123,6 +1123,8 @@ static irqreturn_t bcm_qspi_bspi_lr_l2_isr(int irq,=
 void *dev_id)
 		if (qspi->bspi_rf_op_len =3D=3D 0) {
 			qspi->bspi_rf_op =3D NULL;
 			if (qspi->soc_intc) {
+				/* Ack BSPI done interrupt */
+				soc_intc->bcm_qspi_int_ack(soc_intc, BSPI_DONE);
 				/* disable soc BSPI interrupt */
 				soc_intc->bcm_qspi_int_set(soc_intc, BSPI_DONE,
 							   false);
@@ -1134,11 +1136,10 @@ static irqreturn_t bcm_qspi_bspi_lr_l2_isr(int ir=
q, void *dev_id)
 				bcm_qspi_bspi_lr_clear(qspi);
 			else
 				bcm_qspi_bspi_flush_prefetch_buffers(qspi);
-		}
-
-		if (qspi->soc_intc)
-			/* clear soc BSPI interrupt */
-			soc_intc->bcm_qspi_int_ack(soc_intc, BSPI_DONE);
+		} else  if (qspi->soc_intc)
+			/* Ack FIFO full interrupt */
+			soc_intc->bcm_qspi_int_ack(soc_intc,
+						   BSPI_FIFO_FULL);
 	}
=20
 	status &=3D INTR_BSPI_LR_SESSION_DONE_MASK;
diff --git a/drivers/spi/spi-bcm-qspi.h b/drivers/spi/spi-bcm-qspi.h
index 01aec6460108..b68e275bc721 100644
--- a/drivers/spi/spi-bcm-qspi.h
+++ b/drivers/spi/spi-bcm-qspi.h
@@ -48,7 +48,8 @@ enum {
 	MSPI_DONE =3D 0x1,
 	BSPI_DONE =3D 0x2,
 	BSPI_ERR =3D 0x4,
-	MSPI_BSPI_DONE =3D 0x7
+	MSPI_BSPI_DONE =3D 0x7,
+	BSPI_FIFO_FULL =3D 0x8
 };
=20
 struct bcm_qspi_soc_intc {
@@ -84,6 +85,8 @@ static inline u32 get_qspi_mask(int type)
 		return INTR_MSPI_DONE_MASK;
 	case BSPI_DONE:
 		return BSPI_LR_INTERRUPTS_ALL;
+	case BSPI_FIFO_FULL:
+		return INTR_BSPI_LR_FULLNESS_REACHED_MASK;
 	case MSPI_BSPI_DONE:
 		return QSPI_INTERRUPTS_ALL;
 	case BSPI_ERR:
--=20
2.27.0

