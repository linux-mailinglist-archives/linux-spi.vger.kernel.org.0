Return-Path: <linux-spi+bounces-12024-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CE0CCDB44
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 22:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 295C630142EC
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 21:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4052F12D6;
	Thu, 18 Dec 2025 21:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvgq32XY"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD3D25B1C7;
	Thu, 18 Dec 2025 21:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766093708; cv=none; b=SUbGmHfrtLZ7CSRzNjvC/hUx+gjBG7AP4aHKGfCllGx7ut1Wx36cRffBunGPc3T4ApIJRrwCa8wfSmJ05Do5z5nrvMdhJSLCyNvenB55S7Dd17HSSRvPDNpzNMUVxmXwhWQAHUHO6uA6ufdq3MKlrxv63xdNe1HrXDC2YIO9RmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766093708; c=relaxed/simple;
	bh=txWkiyg3Z8eS/PIVrBrgfuE9ehKupN4/25/Ee8h+gjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qSWI7I3dsGa3WcYSIhXiXjO4TAwYej2kJGM1ke3VMF8MGQoalKPPsGC3p7hHGyVqzL6EY8noSTliFpfXOAPYRCGY/AmwvGdwmJbEn+XsderbmbcbGRARUvd4LPaoq2mt+4IeyrbowlgvUmHWHn61MJZVXihNg+kNOnlc3BbPaw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvgq32XY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A608C116D0;
	Thu, 18 Dec 2025 21:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766093708;
	bh=txWkiyg3Z8eS/PIVrBrgfuE9ehKupN4/25/Ee8h+gjk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mvgq32XYAs3h1lKHK7oa/WVJ2q2aD59UaglWFQte7NNvayvEl8QhWHz1AcmXFwzcX
	 EAXUKs/V6zLj8WLfWx1CxsqMLUo8TFmyEXP8LtVmnTKVCGdofmvbw4XX5hqMFf2fZm
	 /s9RhWyQzZuQbzJQIAPzbL+X5KMWxtzT0PTTBrUa2hmIWIIQ2aWrVKNBtfi+CEQacz
	 fX3qPWOJIBdHp5td45DNr7nd0ZCisQUTL+k9XnjdJDz2rX6zqMHXmtAEaeOCy6O3xD
	 VuqgkBNAyXhvhC1e42mdwimnTNPsgUlIH9aPkCqcyQVPYf62oFXeYeWjgWbzTW2lno
	 wHR1fT+HV2ECQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707F3D711C6;
	Thu, 18 Dec 2025 21:35:08 +0000 (UTC)
From: Mateusz Litwin via B4 Relay <devnull+mateusz.litwin.nokia.com@kernel.org>
Date: Thu, 18 Dec 2025 22:33:04 +0100
Subject: [PATCH v2 1/2] spi: cadence-quadspi: Prevent lost complete() call
 during indirect read
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-cqspi_indirect_read_improve-v2-1-396079972f2a@nokia.com>
References: <20251218-cqspi_indirect_read_improve-v2-0-396079972f2a@nokia.com>
In-Reply-To: <20251218-cqspi_indirect_read_improve-v2-0-396079972f2a@nokia.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mateusz Litwin <mateusz.litwin@nokia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766093707; l=2014;
 i=mateusz.litwin@nokia.com; s=20251217; h=from:subject:message-id;
 bh=idoBq4rF6Q69PiKVn5u/tYsDt9xIXPjO/l/HiqJtOWY=;
 b=6r95aUUM4dSqa65hhpy12h1ymd/dXj56QaT8LzPcDE1Rlq88MbJov48zh0UmGrsIGps1+x7PP
 6oPn3ZuSCluDSv0taiStN2nhtXj4gh3VA4E/4eb9OKXCrpdq055UGLn
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



