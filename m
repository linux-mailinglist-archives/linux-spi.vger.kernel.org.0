Return-Path: <linux-spi+bounces-12011-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DCFCCB78F
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 11:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13869307C6EA
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 10:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0CA6333426;
	Thu, 18 Dec 2025 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOx3MYVt"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A3B33067B;
	Thu, 18 Dec 2025 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766054692; cv=none; b=loRbBe6rsebHlSFncydq8OdJK6VPVX47qFwD1yRntIValzL5MXqfRv1ep39aKnkUVjT9i5qHQIrkMb4kBsYs1ZPwrNn1Hyv7QOAbWqXbAlzGaxVu9ChpA+r1ZEPW8onjs50m+XZ8qqZ89PpXxUBX1a40SgVBLtVu84sCWc0N3I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766054692; c=relaxed/simple;
	bh=txWkiyg3Z8eS/PIVrBrgfuE9ehKupN4/25/Ee8h+gjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LZnYi2dX5HCElHir4CfwZ7St+Uk5qUuc4pv2E8XQ33HQLKIFd0C8MK3DxcYRzXkoRDwajYiBg6yTKhbxY6Qs/7DyfDUaxVgx+KrsvQDUlpAPBOzVA3gWtFapgl7yjx2E2h3amT6x1lnJv2nW+6tOFRZeEfBThZD3h6ZOWjuhbhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOx3MYVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43FB2C116C6;
	Thu, 18 Dec 2025 10:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766054692;
	bh=txWkiyg3Z8eS/PIVrBrgfuE9ehKupN4/25/Ee8h+gjk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cOx3MYVtnZcgv8T6qqwZZKeJfLI+jkFSslu+j/gZkWtA95a4e2yEbNBxZ8g+wiERx
	 T1FNi5smZp4hvHT2lxPuxO3kKmt+33UBtq+U6PkjI+K6mFOs+Aba/yLIo1ZkqyAB4f
	 4aHcDTjNi/jeihLphkB5i0QftoFjzu77huTWEzuKot+wvAe88sO7MtUM0noiJ37seQ
	 ZKpivZ+IE2B3baxxm5JlHpodzcHeCZH5syBAaGFzIo+Uz/bKAJX23plVAQ1XWIuj8U
	 VUm3epiUhLNWwxu/q22E7A5s4rSWAd4L1duMr5XTdIMnB7zaJdNOIuYr7+k8XXb+hp
	 D6XNQ6lnjA71Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA8ED6ACE2;
	Thu, 18 Dec 2025 10:44:52 +0000 (UTC)
From: Mateusz Litwin via B4 Relay <devnull+mateusz.litwin.nokia.com@kernel.org>
Date: Thu, 18 Dec 2025 11:44:31 +0100
Subject: [PATCH 1/2] spi: cadence-quadspi: Prevent lost complete() call
 during indirect read
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-cqspi_indirect_read_improve-v1-1-0ccb17c62f67@nokia.com>
References: <20251218-cqspi_indirect_read_improve-v1-0-0ccb17c62f67@nokia.com>
In-Reply-To: <20251218-cqspi_indirect_read_improve-v1-0-0ccb17c62f67@nokia.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mateusz Litwin <mateusz.litwin@nokia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766054690; l=2014;
 i=mateusz.litwin@nokia.com; s=20251217; h=from:subject:message-id;
 bh=idoBq4rF6Q69PiKVn5u/tYsDt9xIXPjO/l/HiqJtOWY=;
 b=hwIVhv7gbeWGnZepTsMEKWKYDhj8gyawPodd09mtF1cF2UfMXXFHmgemSHuqxBP0tqbnG3mIO
 CyeL6LH3vLxCun0RwUdnv1gjdk/lESR1ct6/sKfGzWKiDG/py9J5WhS
X-Developer-Key: i=mateusz.litwin@nokia.com; a=ed25519;
 pk=9NV76cwWrtwYUektOrK/ht9GTzmhtkqSvghr3Td4hM4=
X-Endpoint-Received: by B4 Relay for mateusz.litwin@nokia.com/20251217 with
 auth_id=579
X-Original-From: Mateusz Litwin <mateusz.litwin@nokia.com>
Reply-To: mateusz.litwin@nokia.com

From: Mateusz Litwin <mateusz.litwin@nokia.com>

A race condition exists between the read loop and IRQ `complete()` call.
An interrupt could call the complete() between the inner loop and
reinit_completion(), potentially losing the completion event and causing
an unnecessary timeout. Moving reinit_completion() before the loop
prevents this. A premature signal will only result in a spurious wakeup
and another wait cycle, which is preferable to waiting for a timeout.

Signed-off-by: Mateusz Litwin <mateusz.litwin@nokia.com>
---
 drivers/spi/spi-cadence-quadspi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index a390b1815fde..02d1ff53e61d 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -769,6 +769,7 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 	readl(reg_base + CQSPI_REG_INDIRECTRD); /* Flush posted write. */
 
 	while (remaining > 0) {
+		ret = 0;
 		if (use_irq &&
 		    !wait_for_completion_timeout(&cqspi->transfer_complete,
 						 msecs_to_jiffies(CQSPI_READ_TIMEOUT_MS)))
@@ -781,6 +782,14 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 		if (cqspi->slow_sram)
 			writel(0x0, reg_base + CQSPI_REG_IRQMASK);
 
+		/*
+		 * Prevent lost interrupt and race condition by reinitializing early.
+		 * A spurious wakeup and another wait cycle can occur here,
+		 * which is preferable to waiting until timeout if interrupt is lost.
+		 */
+		if (use_irq)
+			reinit_completion(&cqspi->transfer_complete);
+
 		bytes_to_read = cqspi_get_rd_sram_level(cqspi);
 
 		if (ret && bytes_to_read == 0) {
@@ -813,7 +822,6 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 		}
 
 		if (use_irq && remaining > 0) {
-			reinit_completion(&cqspi->transfer_complete);
 			if (cqspi->slow_sram)
 				writel(CQSPI_REG_IRQ_WATERMARK, reg_base + CQSPI_REG_IRQMASK);
 		}

-- 
2.43.0



