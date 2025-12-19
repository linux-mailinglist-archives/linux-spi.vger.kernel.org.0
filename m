Return-Path: <linux-spi+bounces-12033-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D59CD19CD
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 20:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9DBAF30EDB68
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 19:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118BF340A57;
	Fri, 19 Dec 2025 19:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YMGC1ruJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3706233F8C2
	for <linux-spi@vger.kernel.org>; Fri, 19 Dec 2025 19:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766172199; cv=none; b=qWtwbBwygXxBRinpz9kp1v/kO7gJUqUHVzSMR6lSWZFN4jlRJG7jTznkWb9T/NaH2I6PXdjxBAw028QR51yZyBvB8S6+CVq7HnwwGww+NAMYuEJEkZ9ahQiGoZafLgq3lPejIPtPLYBaj9K5ciL7KQyqc85e48qKx47VhTEqOnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766172199; c=relaxed/simple;
	bh=AMJ2DGj8AFafe0OktmuvJSX724ZJU8PVhDK8lMGtHfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TxC6VvBWnAk69tm4Yi1GD+hlNYr+h736VxRS/2ODdg1EAGB7kRqHvhZE7CLEhlsqcowMLK3p7Pv0ZPb0un/Ic0HyIqHf7W4DMB/YoiG158XtcWByxSJDusTnCViNCP5Hhyi1AryOx92S4ftCcDonQPoCwLr7p6BN7/Tdg+0dmjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YMGC1ruJ; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id F2E86C1B211;
	Fri, 19 Dec 2025 19:22:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B0F436071D;
	Fri, 19 Dec 2025 19:23:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 503EB10AA9820;
	Fri, 19 Dec 2025 20:23:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1766172194; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=6wPdvixvmMf2wMfqEuafLPsvUy/hsce/40XpaNYa+yw=;
	b=YMGC1ruJXSXW5aNMHL9hjnLUnVFq9xpqUVtGFGB9NDQ6ePJaZPCMVBL6Qwgx1ITvt+UPwg
	NVybz4IDboerJ3yZYt6wQIEeeeqR+eV4Uw5ugcDSJGBi3K574JGuvAM1UZbWJcaLRWbAqQ
	VYo5BMPrFVayUTJB/a+Zhac1cgOiV7OQDUdSfG28M/oVgRlD+ESJ93np74lbo3FLiPpB7C
	scz6XnGMebys+nJkoTgvDpXLcPSkxEhBlVbrPeppDr21RWNIB40Z1n5xlEF7KTwrUStr/d
	Edtj7SS954mc35PSbupxEExcWWqMKmn510S4upn+OAZ96Ha2KfLHlUUIYkmVVA==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Fri, 19 Dec 2025 20:22:06 +0100
Subject: [PATCH 04/13] spi: cadence-qspi: Fix ORing style and alignments
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-schneider-6-19-rc1-qspi-v1-4-8ad505173e44@bootlin.com>
References: <20251219-schneider-6-19-rc1-qspi-v1-0-8ad505173e44@bootlin.com>
In-Reply-To: <20251219-schneider-6-19-rc1-qspi-v1-0-8ad505173e44@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Vaishnav Achath <vaishnav.a@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Pascal Eberhard <pascal.eberhard@se.com>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

These definitions do not follow the standard patterns. Alignments are
incoherent and the logical OR symbols '|' are misplaced. Reorganize
these definitions.

There is no functional change.

Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 90387757fb6b..143904514736 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -2134,26 +2134,23 @@ static const struct cqspi_driver_platdata intel_lgm_qspi = {
 };
 
 static const struct cqspi_driver_platdata socfpga_qspi = {
-	.quirks = CQSPI_DISABLE_DAC_MODE
-			| CQSPI_NO_SUPPORT_WR_COMPLETION
-			| CQSPI_SLOW_SRAM
-			| CQSPI_DISABLE_STIG_MODE
-			| CQSPI_DISABLE_RUNTIME_PM,
+	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_NO_SUPPORT_WR_COMPLETION |
+		  CQSPI_SLOW_SRAM | CQSPI_DISABLE_STIG_MODE |
+		  CQSPI_DISABLE_RUNTIME_PM,
 };
 
 static const struct cqspi_driver_platdata versal_ospi = {
 	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL,
-	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_SUPPORT_EXTERNAL_DMA
-			| CQSPI_DMA_SET_MASK,
+	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_SUPPORT_EXTERNAL_DMA |
+		  CQSPI_DMA_SET_MASK,
 	.indirect_read_dma = cqspi_versal_indirect_read_dma,
 	.get_dma_status = cqspi_get_versal_dma_status,
 };
 
 static const struct cqspi_driver_platdata versal2_ospi = {
 	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL,
-	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_SUPPORT_EXTERNAL_DMA
-			| CQSPI_DMA_SET_MASK
-			| CQSPI_SUPPORT_DEVICE_RESET,
+	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_SUPPORT_EXTERNAL_DMA |
+		  CQSPI_DMA_SET_MASK | CQSPI_SUPPORT_DEVICE_RESET,
 	.indirect_read_dma = cqspi_versal_indirect_read_dma,
 	.get_dma_status = cqspi_get_versal_dma_status,
 };
@@ -2170,7 +2167,7 @@ static const struct cqspi_driver_platdata pensando_cdns_qspi = {
 static const struct cqspi_driver_platdata mobileye_eyeq5_ospi = {
 	.hwcaps_mask = CQSPI_SUPPORTS_OCTAL,
 	.quirks = CQSPI_DISABLE_DAC_MODE | CQSPI_NO_SUPPORT_WR_COMPLETION |
-			CQSPI_RD_NO_IRQ,
+		  CQSPI_RD_NO_IRQ,
 };
 
 static const struct of_device_id cqspi_dt_ids[] = {

-- 
2.51.1


