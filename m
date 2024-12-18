Return-Path: <linux-spi+bounces-6107-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 899469F69DB
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 16:18:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20A931646C2
	for <lists+linux-spi@lfdr.de>; Wed, 18 Dec 2024 15:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450DB76410;
	Wed, 18 Dec 2024 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="j4pPMJ5c"
X-Original-To: linux-spi@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78EA13D518;
	Wed, 18 Dec 2024 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734535121; cv=none; b=ZiY+HGpkRFyIxg/EnjJogLZ+fgM8mKMYHEtf9jKuEt4zXN0EWDp3Imqw6ZVQwAlqMCMXUzgtmaVTk/TsIsxYcc+lbuXje0fSUQDyQ9UocpRuRbSpAPlmEDB1sIuqCSfwPxy5dwieNtTqk0JC2K0OatSlNa4WqxayFf6/pI/zPuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734535121; c=relaxed/simple;
	bh=iQJ5YXCUDouWhsgoSTKSiN7stHWlO7qTte7OpaJy2ss=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lonqjyyr6FYhzz52+jwdJtIVNwL1TtYk67muEtd0YsLWVfukF8GnbkQekBNh+ME7ffnEwOobnBA+A8MG9qEfMfGQy+FMYbfCFtY2HxxeyyEEHk4X9f99QzvIaTZrYILhuKUmJsYQsenDTsmKyJeKvtxtrwFlmielm3Q5cSwT+6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=j4pPMJ5c; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 7C5B0A036D;
	Wed, 18 Dec 2024 16:18:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mail; bh=35TdKF9xDxkqp6uln8CnmJYPKimTUINBXZjiZq/HaBI=; b=
	j4pPMJ5civtDA/9KeXa1DedmpdnUbqQxUC+3CHdutarAMqup3QOMG7dxQR7Au3X2
	wxiJaxqWXhQRA+NpIzrOti8Zi0CcZ04XQMQ9YsYp5eLdJauaFvMNumTi6o3QkCx7
	KeDzO6n29SmTG3EzvTRBvP8v8M6Wgm2ka32HChCX7qJA2SVuUiHKFsgoBB3WIzDV
	VhxpCbqjjY3lUcS9EXFJ8RxR38OUG8uchATLHv5K3GEybmoYvu6rD/hi96tjIuj5
	nwRO3bqx6rxzF2VlbBrQnJ8QV8V9PmIbOq8rQX0tzkoWndp/06obn/kyR1ljJoVW
	JG8tVbFdUSAV6c0HW1KKHdE+hBJOHKTjNe6HMQJzjkjVSRnozKNdf7r8TzGoMlEI
	fZTaKpgqh6z3YGSLX+VRyDrz5RTpyDt+hvejwSFgxHyQdNfP9VId1rKgBlZRdxwJ
	uZjn/sJFup+mvFN5lkAmDPtDsU7Fs1vNQ4J/J270JXbuAO1LCaE4L+cd/Ee5ZGb1
	1gRsx4OfcmMKMrg4BhRBiqwuOygHPaODf8MmJ8fW5Ln6K0S3+EJyHa2h54dspxOY
	IR26IqFT+kHp+gw9GQna3Jo+WFJIwMQknB6dLFwbrmW7EkzfNNqimkDEh16bktBa
	NlnQKfxC3Vokc4mAfaPoATxxVxiJ/15HfzGm5cmQ3EA=
From: =?UTF-8?q?Bence=20Cs=C3=B3k=C3=A1s?= <csokas.bence@prolan.hu>
To: Mark Brown <broonie@kernel.org>, =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?=
	<csokas.bence@prolan.hu>, Varshini Rajendran
	<varshini.rajendran@microchip.com>, Tudor Ambarus <tudor.ambarus@linaro.org>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Alexander Dahl <ada@thorsis.com>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>
Subject: [PATCH] spi: atmel-quadspi: Factor out switching to Serial Memory Mode to function
Date: Wed, 18 Dec 2024 16:17:54 +0100
Message-ID: <20241218151754.365519-1-csokas.bence@prolan.hu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1734535110;VERSION=7982;MC=1092138652;ID=87948;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D948556D7063

SAMA7G5 support (that was forward-ported from v6.1) re-introduced
a bug that was fixed in v6.12, thankfully only in the codepath of
the new SoC. But to prevent similar mistakes in the future, we
split out the offending code to a function, and use this, fixed
version everywhere.

To facilitate this, support function `atmel_qspi_update_config()`
also had to be moved upwards. For best viewing experience, use
`--color-moved-ws="allow-indentation-change" --color-moved`.

Fixes: 5af42209a4d2 ("spi: atmel-quadspi: Add support for sama7g5 QSPI")
Reported-by: Alexander Dahl <ada@thorsis.com>
Closes: https://lore.kernel.org/linux-spi/20241218-appliance-jaws-90773405977a@thorsis.com/
Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
---
 drivers/spi/atmel-quadspi.c | 101 +++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 48 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 73cf0c3f1477..f46da363574f 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -414,6 +414,28 @@ static void atmel_qspi_write(u32 value, struct atmel_qspi *aq, u32 offset)
 	writel_relaxed(value, aq->regs + offset);
 }
 
+static int atmel_qspi_reg_sync(struct atmel_qspi *aq)
+{
+	u32 val;
+	int ret;
+
+	ret = readl_poll_timeout(aq->regs + QSPI_SR2, val,
+				 !(val & QSPI_SR2_SYNCBSY), 40,
+				 ATMEL_QSPI_SYNC_TIMEOUT);
+	return ret;
+}
+
+static int atmel_qspi_update_config(struct atmel_qspi *aq)
+{
+	int ret;
+
+	ret = atmel_qspi_reg_sync(aq);
+	if (ret)
+		return ret;
+	atmel_qspi_write(QSPI_CR_UPDCFG, aq, QSPI_CR);
+	return atmel_qspi_reg_sync(aq);
+}
+
 static inline bool atmel_qspi_is_compatible(const struct spi_mem_op *op,
 					    const struct atmel_qspi_mode *mode)
 {
@@ -476,6 +498,25 @@ static bool atmel_qspi_supports_op(struct spi_mem *mem,
 	return true;
 }
 
+/*
+ * If the QSPI controller is set in regular SPI mode, set it in
+ * Serial Memory Mode (SMM).
+ */
+static int atmel_qspi_set_serial_memory_mode(struct atmel_qspi *aq)
+{
+	int ret = 0;
+
+	if (!(aq->mr & QSPI_MR_SMM)) {
+		aq->mr |= QSPI_MR_SMM;
+		atmel_qspi_write(aq->mr, aq, QSPI_MR);
+
+		if (aq->caps->has_gclk)
+			ret = atmel_qspi_update_config(aq);
+	}
+
+	return ret;
+}
+
 static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
 			      const struct spi_mem_op *op, u32 *offset)
 {
@@ -555,14 +596,9 @@ static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
 			ifr |= QSPI_IFR_TFRTYP_MEM;
 	}
 
-	/*
-	 * If the QSPI controller is set in regular SPI mode, set it in
-	 * Serial Memory Mode (SMM).
-	 */
-	if (!(aq->mr & QSPI_MR_SMM)) {
-		aq->mr |= QSPI_MR_SMM;
-		atmel_qspi_write(aq->mr, aq, QSPI_MR);
-	}
+	mode = atmel_qspi_set_serial_memory_mode(aq);
+	if (mode < 0)
+		return mode;
 
 	/* Clear pending interrupts */
 	(void)atmel_qspi_read(aq, QSPI_SR);
@@ -638,28 +674,6 @@ static int atmel_qspi_transfer(struct spi_mem *mem,
 	return atmel_qspi_wait_for_completion(aq, QSPI_SR_CMD_COMPLETED);
 }
 
-static int atmel_qspi_reg_sync(struct atmel_qspi *aq)
-{
-	u32 val;
-	int ret;
-
-	ret = readl_poll_timeout(aq->regs + QSPI_SR2, val,
-				 !(val & QSPI_SR2_SYNCBSY), 40,
-				 ATMEL_QSPI_SYNC_TIMEOUT);
-	return ret;
-}
-
-static int atmel_qspi_update_config(struct atmel_qspi *aq)
-{
-	int ret;
-
-	ret = atmel_qspi_reg_sync(aq);
-	if (ret)
-		return ret;
-	atmel_qspi_write(QSPI_CR_UPDCFG, aq, QSPI_CR);
-	return atmel_qspi_reg_sync(aq);
-}
-
 static int atmel_qspi_sama7g5_set_cfg(struct atmel_qspi *aq,
 				      const struct spi_mem_op *op, u32 *offset)
 {
@@ -713,18 +727,9 @@ static int atmel_qspi_sama7g5_set_cfg(struct atmel_qspi *aq,
 			ifr |= QSPI_IFR_TFRTYP_MEM;
 	}
 
-	/*
-	 * If the QSPI controller is set in regular SPI mode, set it in
-	 * Serial Memory Mode (SMM).
-	 */
-	if (aq->mr != QSPI_MR_SMM) {
-		atmel_qspi_write(QSPI_MR_SMM | QSPI_MR_DQSDLYEN, aq, QSPI_MR);
-		aq->mr = QSPI_MR_SMM;
-
-		ret = atmel_qspi_update_config(aq);
-		if (ret)
-			return ret;
-	}
+	ret = atmel_qspi_set_serial_memory_mode(aq);
+	if (ret < 0)
+		return ret;
 
 	/* Clear pending interrupts */
 	(void)atmel_qspi_read(aq, QSPI_SR);
@@ -1092,10 +1097,9 @@ static int atmel_qspi_sama7g5_init(struct atmel_qspi *aq)
 	}
 
 	/* Set the QSPI controller by default in Serial Memory Mode */
-	atmel_qspi_write(QSPI_MR_SMM | QSPI_MR_DQSDLYEN, aq, QSPI_MR);
-	aq->mr = QSPI_MR_SMM;
-	ret = atmel_qspi_update_config(aq);
-	if (ret)
+	aq->mr |= QSPI_MR_DQSDLYEN;
+	ret = atmel_qspi_set_serial_memory_mode(aq);
+	if (ret < 0)
 		return ret;
 
 	/* Enable the QSPI controller. */
@@ -1244,8 +1248,9 @@ static int atmel_qspi_init(struct atmel_qspi *aq)
 	atmel_qspi_write(QSPI_CR_SWRST, aq, QSPI_CR);
 
 	/* Set the QSPI controller by default in Serial Memory Mode */
-	aq->mr |= QSPI_MR_SMM;
-	atmel_qspi_write(aq->mr, aq, QSPI_MR);
+	ret = atmel_qspi_set_serial_memory_mode(aq);
+	if (ret < 0)
+		return ret;
 
 	/* Enable the QSPI controller */
 	atmel_qspi_write(QSPI_CR_QSPIEN, aq, QSPI_CR);
-- 
2.34.1



