Return-Path: <linux-spi+bounces-3859-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EC39312D9
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jul 2024 13:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95DFB1F2393E
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jul 2024 11:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A61B189F51;
	Mon, 15 Jul 2024 11:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="11BXcyOs"
X-Original-To: linux-spi@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C48E1891B6;
	Mon, 15 Jul 2024 11:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042091; cv=none; b=Z/63/B/xRI9Y7uvpsQsMfayyRBk+/fX4jU/2a+3JVEz0cKBR5/JHToAUl/Y3b8dbLI9C2+nGBPe6zZwZgaS1Q/tmR1DquehW+ndC7zv/PZChqYvkIAGW+prvECsBcgT0y4nOyJHstQekAVoFrgl2cm6idycEC2dgIU71T/hG9fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042091; c=relaxed/simple;
	bh=QYPaiV4AUdkavRKOOgI2twOGG0RNUuOTkPazbJHqoyI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oj52jUS4XUC+Hz3ROl9erRsVJYDwO29j2uAJlq9GZdYn8iS3KACTBkjYv8jp+EBXbzmzR+nS//L1mEG1VhR2oTmhN9OqCZrO8UjQNK/2ULwBTk+u5sjZLA0DrCsoIU138fMln7c1kOLatcUP2U0v5hjO1TI7fFBjO6G9J+EMWX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=11BXcyOs; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1721042089; x=1752578089;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QYPaiV4AUdkavRKOOgI2twOGG0RNUuOTkPazbJHqoyI=;
  b=11BXcyOsdm+CGftuTNYQR6vwzR6sxb6ykX5nlcHLM643awLt6mzVMaOw
   jqq6w3bE1hcfDhtX9qVda7nXCwiKk2/UhkL7ihXOuP38/Ove3Q8Cakj+/
   4/SNyFngkQpoeZ8YD9zmVA98ccpN6eRRfIUXDc/Y3CncaCXsLRy3J8y0D
   aquzw1g4UhSqgZgcdyBVCfenpGRhMgSmiPLKBVkd+f6ii2Bs57ToV13X4
   35Sn1g5X+glj8F5cxRZ4XeXzP9H1TY8PKVgD8sf3BUGMboDxNbtzXOHzU
   UCI/LRR2bEGf9/j0is5N9EB3tB47TjSiBE9GwatGDvLhBnH10iOmEIt7Y
   Q==;
X-CSE-ConnectionGUID: M47IHorFQcORQBAq4muecw==
X-CSE-MsgGUID: oLGfu04sT+SVyD5sLknF5g==
X-IronPort-AV: E=Sophos;i="6.09,210,1716274800"; 
   d="scan'208";a="196643521"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jul 2024 04:14:46 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Jul 2024 04:14:38 -0700
Received: from wendy.microchip.com (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Mon, 15 Jul 2024 04:14:37 -0700
From: Conor Dooley <conor.dooley@microchip.com>
To: <linux-spi@vger.kernel.org>
CC: <conor@kernel.org>, <conor.dooley@microchip.com>, Steve Wilkins
	<steve.wilkins@raymarine.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	Mark Brown <broonie@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 4/6] spi: microchip-core: fix init function not setting the master and motorola modes
Date: Mon, 15 Jul 2024 12:13:55 +0100
Message-ID: <20240715-designing-thus-05f7c26e1da7@wendy>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240715-retail-magnolia-bbd49a657a89@wendy>
References: <20240715-retail-magnolia-bbd49a657a89@wendy>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2271; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=fV9/e84Wy2bPQ2z1Zvl6yoFE3tP7uIxrMZYq6qqhxQ0=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGlTWYpuFXi9zdm4/MXLKadX7lT6K/rk8//2xndXNEIZFeyY 4wq+dpSyMIhxMMiKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAiZY0M/wunPxJ2KBIu7gk3SJzAGl td7LX523ft3TFu/v7xLiydcgz/IzKq9NYaPFh2Pemy3IoZZ7jyXK5efTTv7z//Lu2y2JsS3AA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Steve Wilkins <steve.wilkins@raymarine.com>

mchp_corespi_init() reads the CONTROL register, sets the master and
motorola bits, but doesn't write the value back to the register. The
function also doesn't ensure the controller is disabled at the start,
which may present a problem if the controller was used by an
earlier boot stage as some settings (including the mode) can only be
modified while the controller is disabled.

Fixes: 9ac8d17694b6 ("spi: add support for microchip fpga spi controllers")
Signed-off-by: Steve Wilkins <steve.wilkins@raymarine.com>
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/spi/spi-microchip-core.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip-core.c
index 24a728bde8fda..3d17018cedb08 100644
--- a/drivers/spi/spi-microchip-core.c
+++ b/drivers/spi/spi-microchip-core.c
@@ -292,17 +292,13 @@ static void mchp_corespi_init(struct spi_controller *host, struct mchp_corespi *
 	unsigned long clk_hz;
 	u32 control = mchp_corespi_read(spi, REG_CONTROL);
 
-	control |= CONTROL_MASTER;
+	control &= ~CONTROL_ENABLE;
+	mchp_corespi_write(spi, REG_CONTROL, control);
 
+	control |= CONTROL_MASTER;
 	control &= ~CONTROL_MODE_MASK;
 	control |= MOTOROLA_MODE;
 
-	mchp_corespi_set_framesize(spi, DEFAULT_FRAMESIZE);
-
-	/* max. possible spi clock rate is the apb clock rate */
-	clk_hz = clk_get_rate(spi->clk);
-	host->max_speed_hz = clk_hz;
-
 	/*
 	 * The controller must be configured so that it doesn't remove Chip
 	 * Select until the entire message has been transferred, even if at
@@ -311,11 +307,16 @@ static void mchp_corespi_init(struct spi_controller *host, struct mchp_corespi *
 	 * BIGFIFO mode is also enabled, which sets the fifo depth to 32 frames
 	 * for the 8 bit transfers that this driver uses.
 	 */
-	control = mchp_corespi_read(spi, REG_CONTROL);
 	control |= CONTROL_SPS | CONTROL_BIGFIFO;
 
 	mchp_corespi_write(spi, REG_CONTROL, control);
 
+	mchp_corespi_set_framesize(spi, DEFAULT_FRAMESIZE);
+
+	/* max. possible spi clock rate is the apb clock rate */
+	clk_hz = clk_get_rate(spi->clk);
+	host->max_speed_hz = clk_hz;
+
 	mchp_corespi_enable_ints(spi);
 
 	/*
-- 
2.43.2


