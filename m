Return-Path: <linux-spi+bounces-12010-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9224DCCB741
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 11:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E73C304E1E5
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 10:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A33332EDC;
	Thu, 18 Dec 2025 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="re9RX8g4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703F9215077;
	Thu, 18 Dec 2025 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766054692; cv=none; b=Y73eDbn3zJksWPG+v0y8e35f/INjE21lRx3BCWg+BIwrMM5fRq+XHManW76NIUCFXfps4cCg+XGJ6TSF6a4OMyKU9daFu2TKo9e+65FrDHH9h3WBz2w/M55P6G1bUQ2lo76fZqU8sZgEAGor1QVH9ayc6IDESLQB1kc39TbjC2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766054692; c=relaxed/simple;
	bh=QqPUNX80znWltE6Dtum0rx6o3k9hMWlACKh57DDCGPI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sy0/l4/g4am51UF4DlzouRt0cze4wDpo/MzCC9SEVb2iXCnKzgbt6mQFYeyRg1hXL/xCbxU/31a/Nxkpi9ldA1V0uirUvhvDgJBuQrS0TD21DqLUH+zgSxQmdJVyq0N3TdxsjDf1SFU9Ui1TI8CyB9eoTXYFaVZ90rieB/h9BGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=re9RX8g4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BDE7C19422;
	Thu, 18 Dec 2025 10:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766054692;
	bh=QqPUNX80znWltE6Dtum0rx6o3k9hMWlACKh57DDCGPI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=re9RX8g4YA6T9R60nYXu4+aNZZkHkUY16WujbafdkKty0iFBLYM5C4gS8/l9oltJD
	 IXBL1mNX3RR+cha/h/KUIYX766ZcO6ZOqPM2Lf7Z1j6m5wiPONBhnIszDIkehJt7Ml
	 s2o7f1S2iovsDGM9Les1GZtcZDNAOq72jILjglPtR9VCaPUpT28aZrULvlCjrCJd5V
	 tV69eQVrvENHY7InGxqMZuMFGTqvVU+NTsnIX68fMwUZ8+qEZ0a5SrqRk1NCMtxHAv
	 nzup8VlA0iZuh1Siq4ii81EPmzuvxq8iRguqUhgb5KJVV1n7Ll1FyD5aCxESX6B9Ro
	 HKC751mDowX1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCC5D6ACE4;
	Thu, 18 Dec 2025 10:44:52 +0000 (UTC)
From: Mateusz Litwin via B4 Relay <devnull+mateusz.litwin.nokia.com@kernel.org>
Date: Thu, 18 Dec 2025 11:44:32 +0100
Subject: [PATCH 2/2] spi: cadence-quadspi: Improve CQSPI_SLOW_SRAM quirk if
 flash is slow
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-cqspi_indirect_read_improve-v1-2-0ccb17c62f67@nokia.com>
References: <20251218-cqspi_indirect_read_improve-v1-0-0ccb17c62f67@nokia.com>
In-Reply-To: <20251218-cqspi_indirect_read_improve-v1-0-0ccb17c62f67@nokia.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mateusz Litwin <mateusz.litwin@nokia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766054690; l=3194;
 i=mateusz.litwin@nokia.com; s=20251217; h=from:subject:message-id;
 bh=64fsEe9CKhGD7IXFtLt/KPssSVKK7Ivwn7fKzR5jue4=;
 b=oPTenotgmwHCfwVrrTA8q/qneRSqZdXgm6cG/en8p1Mv0AsbxreiFwVhkWWVoK3aq3stLUpXh
 ogKlrPE3GGSAMHqml/ZHrqArMHpFQ0jsWMWCek1A2g3WBhIPpvjzmvv
X-Developer-Key: i=mateusz.litwin@nokia.com; a=ed25519;
 pk=9NV76cwWrtwYUektOrK/ht9GTzmhtkqSvghr3Td4hM4=
X-Endpoint-Received: by B4 Relay for mateusz.litwin@nokia.com/20251217 with
 auth_id=579
X-Original-From: Mateusz Litwin <mateusz.litwin@nokia.com>
Reply-To: mateusz.litwin@nokia.com

From: Mateusz Litwin <mateusz.litwin@nokia.com>

CQSPI_SLOW_SRAM quirk on the Stratix10 platform causes fewer interrupts,
but also causes timeouts if a small block is used or if flash devices are
slower than or equal in speed to SRAM's read operations. Adding the
CQSPI_REG_IRQ_IND_COMP interrupt would resolve the problem for small
reads, and removing the disabling of interrupts would resolve the issue
with lost interrupts.
This marginally increases IRQ count. Tests show that this will cause only
a few percent more interrupts.

Test:
$ dd if=/dev/mtd0 of=/dev/null bs=1M count=64
Results from the Stratix10 platform with mt25qu02g flash.
FIFO size in all tests: 128

Serviced interrupt call counts:
Without CQSPI_SLOW_SRAM quirk: 16 668 850
With CQSPI_SLOW_SRAM quirk: 204 176
With CQSPI_SLOW_SRAM and this commit: 224 528

Signed-off-by: Mateusz Litwin <mateusz.litwin@nokia.com>
---
 drivers/spi/spi-cadence-quadspi.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 02d1ff53e61d..facd152bc639 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -300,6 +300,9 @@ struct cqspi_driver_platdata {
 					 CQSPI_REG_IRQ_IND_SRAM_FULL	| \
 					 CQSPI_REG_IRQ_IND_COMP)
 
+#define CQSPI_IRQ_MASK_RD_SLOW_SRAM	(CQSPI_REG_IRQ_WATERMARK	| \
+					 CQSPI_REG_IRQ_IND_COMP)
+
 #define CQSPI_IRQ_MASK_WR		(CQSPI_REG_IRQ_IND_COMP		| \
 					 CQSPI_REG_IRQ_WATERMARK	| \
 					 CQSPI_REG_IRQ_UNDERFLOW)
@@ -381,7 +384,7 @@ static irqreturn_t cqspi_irq_handler(int this_irq, void *dev)
 	else if (!cqspi->slow_sram)
 		irq_status &= CQSPI_IRQ_MASK_RD | CQSPI_IRQ_MASK_WR;
 	else
-		irq_status &= CQSPI_REG_IRQ_WATERMARK | CQSPI_IRQ_MASK_WR;
+		irq_status &= CQSPI_IRQ_MASK_RD_SLOW_SRAM | CQSPI_IRQ_MASK_WR;
 
 	if (irq_status)
 		complete(&cqspi->transfer_complete);
@@ -759,7 +762,7 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 	if (use_irq && cqspi->slow_sram)
 		writel(CQSPI_REG_IRQ_WATERMARK, reg_base + CQSPI_REG_IRQMASK);
 	else if (use_irq)
-		writel(CQSPI_IRQ_MASK_RD, reg_base + CQSPI_REG_IRQMASK);
+		writel(CQSPI_IRQ_MASK_RD_SLOW_SRAM, reg_base + CQSPI_REG_IRQMASK);
 	else
 		writel(0, reg_base + CQSPI_REG_IRQMASK);
 
@@ -775,13 +778,6 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 						 msecs_to_jiffies(CQSPI_READ_TIMEOUT_MS)))
 			ret = -ETIMEDOUT;
 
-		/*
-		 * Disable all read interrupts until
-		 * we are out of "bytes to read"
-		 */
-		if (cqspi->slow_sram)
-			writel(0x0, reg_base + CQSPI_REG_IRQMASK);
-
 		/*
 		 * Prevent lost interrupt and race condition by reinitializing early.
 		 * A spurious wakeup and another wait cycle can occur here,
@@ -820,11 +816,6 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 			remaining -= bytes_to_read;
 			bytes_to_read = cqspi_get_rd_sram_level(cqspi);
 		}
-
-		if (use_irq && remaining > 0) {
-			if (cqspi->slow_sram)
-				writel(CQSPI_REG_IRQ_WATERMARK, reg_base + CQSPI_REG_IRQMASK);
-		}
 	}
 
 	/* Check indirect done status */

-- 
2.43.0



