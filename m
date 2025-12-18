Return-Path: <linux-spi+bounces-12023-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 542FBCCDB41
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 22:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED1BA3012BFC
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 21:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC162F12C1;
	Thu, 18 Dec 2025 21:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2cY2zQ9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC6E22FF22;
	Thu, 18 Dec 2025 21:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766093708; cv=none; b=pF1gc8Mb2V+v5czF1limD8Oo6nldICdYS1uuRhAFXoONuMnsuMoXEHt28Tu7slB0XWa76d0SokWzER/3PHkKttA1zvVlloL4b9BHfIEcIkQC6u6JsNbjzgpUFlZAC1grv0OmTtEoo2I6oWB0U1s4auu/dhdmg1vjGhmAtizEzkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766093708; c=relaxed/simple;
	bh=aNJKD+H4SDel+n3Ym+ayxndaXEysHiHcGbEbOfhibCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mvh2l1nW8F+QMmafWhHvpQJIylH2e5Pw4JLg9LuuBzlE1HLLziSIb+QWGHohMhz8jeaf+ai71TsI08reHe39k4rXhV9OugmBh1aGQy+od98tE7IQ1GfefU+zop5/TXtJrdCjBmwPkMzSADmeoymj8QHBGC+7M6oBOW19lF4dcz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2cY2zQ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9415EC16AAE;
	Thu, 18 Dec 2025 21:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766093708;
	bh=aNJKD+H4SDel+n3Ym+ayxndaXEysHiHcGbEbOfhibCY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=M2cY2zQ9sXE7XpUkVljpPu/TMbW8F6kH9mWmXZ9YIdmD86YTzBnpgkS8nv6sjL01C
	 R5NfCH8N1/22DheWxoV9mB9pVSX0gaA28EsfW+kaF+hkZlZugKL1wEnxHZAOX6en0W
	 x6ykOHZPezaSLcjAaqDdrhhSbYiELEY+FRn3z/iJqyQDswdNC36N/r9lQG6FFk6w1l
	 hPxdZF/gOlhS3vfzvilZ863oxfw+lC8dKt4ZygtuYYT++fbR9xd8VQ3M9AMCJoYg1U
	 SMcSQZsESNZVgj3nz8e89RjThviUN+gzldaGoChq1SCu9iYL7yuraWFf7NCYWpnDKS
	 FpgwpAMxExQHA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8155ED711C7;
	Thu, 18 Dec 2025 21:35:08 +0000 (UTC)
From: Mateusz Litwin via B4 Relay <devnull+mateusz.litwin.nokia.com@kernel.org>
Date: Thu, 18 Dec 2025 22:33:05 +0100
Subject: [PATCH v2 2/2] spi: cadence-quadspi: Improve CQSPI_SLOW_SRAM quirk
 if flash is slow
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-cqspi_indirect_read_improve-v2-2-396079972f2a@nokia.com>
References: <20251218-cqspi_indirect_read_improve-v2-0-396079972f2a@nokia.com>
In-Reply-To: <20251218-cqspi_indirect_read_improve-v2-0-396079972f2a@nokia.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mateusz Litwin <mateusz.litwin@nokia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766093707; l=3156;
 i=mateusz.litwin@nokia.com; s=20251217; h=from:subject:message-id;
 bh=wODUxc561XQK+ZcLXkwgTN2v7/VBU9osHmZCWSMuTWI=;
 b=kTLBLwJL1bPgEYaPRi1b7+gXIXL8+q8UpI3JXHdAEpYQgF3LToeISPaGKMku3x/g6xEBCWSNt
 P/pRtBdHieXC8/vzBIm885QNqZRwLORs4x7hmm5bY4C/n3MPJvvy/VW
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
index 02d1ff53e61d..958788e0dac0 100644
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
@@ -757,7 +760,7 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 	 */
 
 	if (use_irq && cqspi->slow_sram)
-		writel(CQSPI_REG_IRQ_WATERMARK, reg_base + CQSPI_REG_IRQMASK);
+		writel(CQSPI_IRQ_MASK_RD_SLOW_SRAM, reg_base + CQSPI_REG_IRQMASK);
 	else if (use_irq)
 		writel(CQSPI_IRQ_MASK_RD, reg_base + CQSPI_REG_IRQMASK);
 	else
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



