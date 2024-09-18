Return-Path: <linux-spi+bounces-4842-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C974A97B954
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 10:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D4BB1F2157E
	for <lists+linux-spi@lfdr.de>; Wed, 18 Sep 2024 08:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A286172BD6;
	Wed, 18 Sep 2024 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="BSM3cBMi"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55BE132105;
	Wed, 18 Sep 2024 08:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726648081; cv=none; b=EbgVLA9cx09vQ6ify6+AqlZulZ4e7NWiR7YORGfeF4W8NA8RpFvl52uihFsToHi5QQLOFvr7aLE3IXU202qrw9N3/XuS7aGhRQOdktWevbflE0c5McUQ11rM7RsPxgtuIadBPNlu/RtvTIPh9OmOkGMLvQwtaO0q6Eu734euUqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726648081; c=relaxed/simple;
	bh=YKSV0qswyKNmDD0SYFxL/hOHhkG87I15zl+nDKiOGys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Deoq/bj+0KYuzELkxoy5KarNtOZ+3x3jd4TBAghllB+fHoBLA6QMU0r5L48i4JWHx9LzES4fWcusHRBns0APuSVB/wubFNdPSRenMJOWC656Mo0G7sEu0pOY/4r1lhr2DR/OrImNT6OQziMe1ipi4hTcdhPIeR1CmMV87pWK7Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=BSM3cBMi; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 176621489929;
	Wed, 18 Sep 2024 10:27:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1726648071; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=pDXpXaegpKO5X3zQrD+t/zmtDNYbjkoQfmdIzd6/8JQ=;
	b=BSM3cBMiUjsPpzVfdToqqaltViOeVW8dbHHUscPQ4wWHOXXpyIOUw2mPX3e2KSu8xx5I0z
	CtqlKNxjPhquZf6kynj//g9uqZw7/8vjmj8OlOKgz11sfdfD7UheSigFlZsDGiANm/2vtO
	9pLukICPBHFxXrd7iHrrckOwE+dDuM+IX3LezcOQN3KBojOwoXD7z3t9RTZoOVEaYs8F2E
	RIej78z81eOZOxDfNCGS3zzCuAz0l+zCLYWT2TTKwWQ9G+NqwVd85y1kyMOCGUG4zJaKNj
	X0uGwtIIr2WsfjEWWQ+dcewnncPFOcwrKXFhRYYZuTUIzCXc0B8UCpXck/WUnA==
From: Alexander Dahl <ada@thorsis.com>
To: Mark Brown <broonie@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] spi: atmel-quadspi: Avoid overwriting delay register settings
Date: Wed, 18 Sep 2024 10:27:43 +0200
Message-Id: <20240918082744.379610-2-ada@thorsis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240918082744.379610-1-ada@thorsis.com>
References: <20240918082744.379610-1-ada@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Previously the MR and SCR registers were just set with the supposedly
required values, from cached register values (cached reg content
initialized to zero).

All parts fixed here did not consider the current register (cache)
content, which would make future support of cs_setup, cs_hold, and
cs_inactive impossible.

Setting SCBR in atmel_qspi_setup() erases a possible DLYBS setting from
atmel_qspi_set_cs_timing().  The DLYBS setting is applied by ORing over
the current setting, without resetting the bits first.  All writes to MR
did not consider possible settings of DLYCS and DLYBCT.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
Fixes: f732646d0ccd ("spi: atmel-quadspi: Add support for configuring CS timing")
---
 drivers/spi/atmel-quadspi.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 5aaff3bee1b7..fcd57cf1f2cf 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -375,9 +375,9 @@ static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
 	 * If the QSPI controller is set in regular SPI mode, set it in
 	 * Serial Memory Mode (SMM).
 	 */
-	if (aq->mr != QSPI_MR_SMM) {
-		atmel_qspi_write(QSPI_MR_SMM, aq, QSPI_MR);
-		aq->mr = QSPI_MR_SMM;
+	if (!(aq->mr & QSPI_MR_SMM)) {
+		aq->mr |= QSPI_MR_SMM;
+		atmel_qspi_write(aq->scr, aq, QSPI_MR);
 	}
 
 	/* Clear pending interrupts */
@@ -501,7 +501,8 @@ static int atmel_qspi_setup(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
-	aq->scr = QSPI_SCR_SCBR(scbr);
+	aq->scr &= ~QSPI_SCR_SCBR_MASK;
+	aq->scr |= QSPI_SCR_SCBR(scbr);
 	atmel_qspi_write(aq->scr, aq, QSPI_SCR);
 
 	pm_runtime_mark_last_busy(ctrl->dev.parent);
@@ -534,6 +535,7 @@ static int atmel_qspi_set_cs_timing(struct spi_device *spi)
 	if (ret < 0)
 		return ret;
 
+	aq->scr &= ~QSPI_SCR_DLYBS_MASK;
 	aq->scr |= QSPI_SCR_DLYBS(cs_setup);
 	atmel_qspi_write(aq->scr, aq, QSPI_SCR);
 
@@ -549,8 +551,8 @@ static void atmel_qspi_init(struct atmel_qspi *aq)
 	atmel_qspi_write(QSPI_CR_SWRST, aq, QSPI_CR);
 
 	/* Set the QSPI controller by default in Serial Memory Mode */
-	atmel_qspi_write(QSPI_MR_SMM, aq, QSPI_MR);
-	aq->mr = QSPI_MR_SMM;
+	aq->mr |= QSPI_MR_SMM;
+	atmel_qspi_write(aq->mr, aq, QSPI_MR);
 
 	/* Enable the QSPI controller */
 	atmel_qspi_write(QSPI_CR_QSPIEN, aq, QSPI_CR);
-- 
2.39.5


