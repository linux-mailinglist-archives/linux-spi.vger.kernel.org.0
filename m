Return-Path: <linux-spi+bounces-10730-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D3FBF288E
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 18:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044F7460851
	for <lists+linux-spi@lfdr.de>; Mon, 20 Oct 2025 16:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7290D3314C3;
	Mon, 20 Oct 2025 16:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="ypQCze4x"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B5E32F76B
	for <linux-spi@vger.kernel.org>; Mon, 20 Oct 2025 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979125; cv=none; b=UNmzAvdG5U2xwVSHUC0de2nL3heKCZUlVSVBRhbYqbkkHaCi8OFruhS8piRAo9GXAzLez9acadhgJQbKM54pl+vTSeaKFv+e9LXU4+yGM34frmPiiqxVdIswhwUtIUoT3rClDGKGR9oClucB6PoIKq2BV3N/yDLBgNqTHj6kvT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979125; c=relaxed/simple;
	bh=uePi/hbf6hWUzA21sUbV+8rs4D8g62rLtBk48VZwAjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TM3sxTL1NKbd2SwWacQej67oUEy8/+76Nj7neYnFMp7v6j6qY0kXc39seSJ5heO1EyTnIMiTPYh52rBNug7NVwhZbxHWQsRJvi+DCxEN+gzeSm9F1VTnHBh9tO+jQX1tMuaNyLbcBKwAGXx4iTUBlYDnSReYDudXe4kMflKxoVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=ypQCze4x; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-430c52703b3so38398565ab.1
        for <linux-spi@vger.kernel.org>; Mon, 20 Oct 2025 09:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760979122; x=1761583922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQXVbISA4WvqnIZXTg13FJ7YaYjfMgMauMrkyToUbl4=;
        b=ypQCze4x5DCXx00AaRIUgbEp50LjIVoe/1NXkIV47o67NduiZhjYyMUFq7h1H4hB8E
         ftZFP83bxpkXHyIm8S5oy+cLQXvbrfY6egmWCR7u4nFXG4AdgEUOEO6RiosRF5HTPz2/
         td7vENeNnDmz+Wuso5v/dgCXPeE9AyXtxmWEhUSv5tdmC1KZVeShrq2D0DuPlsA5o977
         r3Y2DCzlWV1FFA++Tn2rulwQL3C8xk9oKVf5sr5ibroEOfxR7/g08SjZTIo++p78HpSI
         WXRfoa42UoDV8GpLmfavDvBit4UaIvr1KOu5PGjddKgwiMzyPKuW/qb1ELfhWl3+EdCM
         bH6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979122; x=1761583922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQXVbISA4WvqnIZXTg13FJ7YaYjfMgMauMrkyToUbl4=;
        b=Rvwi+5mNCq/uA/CLTDJykob433BBTXaX+FP2jhAe6csssXnNqiPEb/Ezs51CWTGOFc
         xDv/ZgANXR47eWy3Jcp9ZdSDYrXJ5DPb1Rr0Ckk3Tq5ixGUvDAZNOUygQz/m7E1cOAlL
         JdxVqLVAlZefhpDm9XKhry7JPExm1wVVKv8D9l4/iNEJFRrTZx/TiUSlR5bGo/0Ed+kH
         DInU/vu6NiI46o4RAm6qQS9UFBeA9Cvb2L481n5j22aw1xTg9ahWYx5txLVbZrNxJjI8
         icmy1mkV7SC5Q5HoPofACFENcxKXyu+VNQBDIwHMrhorgXCRF1aiN2yKMCGeZ+wyNA0X
         BDbg==
X-Forwarded-Encrypted: i=1; AJvYcCULQFKSm56vP/yZvBeQPM+6669ILXrWItRg7OxDlQV2JaCsVxDHWCo4oG9yBF+rYxJAc6KQ4JIrA5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2AdgRBUsqFZvqzGyEtZ9YcD1WG8SggyNEyeZKdq9jNJza8Q1O
	RdijvvGVqsxF5Fljvi5yRPheHfuAJ73Hg1r/ba07F8xYaDQpC9CezIHqWDlLYxFklNA=
X-Gm-Gg: ASbGncsd4u/amK2THG3nwn3rmPUffIQY7hToJjvP7LE+OcbYX/trsUlAlrEWHCeJgEy
	d8hXuIrr11N1hiepTaowFRTxF0Mz5BaasOLfFcvMsrdsLX7d2sSIvNkMafDQ5iPxQX3gjugcr07
	YqTUrAKAIRHZKuQhjN60MD67H6PdLDkBNybjgr/iZWWr6nt9GZJ0ypOVVGY8GirLx7y13IKB2OI
	u+ktKPUS1Ov5mNqW0fRKJ/fVl7i88gifyPmRXlJVNU/s4uhtsFrSpcxos0Ngxu1s6VzDEtxrabt
	lkyT2db0qqF8lEW86xkXSRUl8PCcKTYB2jbHWyGqw2rW0Z6UxBOrJIkDtwqRAbG/9fDKbFP0DTS
	XpBaX6zbmmCvVyV/W+PchdfZMbzuTGuzLiJ11TNcziZSHZ6AydEGp2okvKPMyzI5fejE+HgDLZx
	bGrO5Cw0fdAxBlSEhTBEzvh5UEv0PpoK5EmfnGWn1p43lOJwoV4T6xMg==
X-Google-Smtp-Source: AGHT+IF2Mm9OQGidsZhPs2Ov77+yd0T2fLJcTJpQ1EVmkmzq5AdT/vC3cNejClhwLlxQGd1xeq/XeQ==
X-Received: by 2002:a92:c24f:0:b0:427:6e7f:89f8 with SMTP id e9e14a558f8ab-430c5263cfdmr219177275ab.10.1760979122272;
        Mon, 20 Oct 2025 09:52:02 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a9799428sm3116783173.63.2025.10.20.09.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:52:01 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: han.xu@nxp.com,
	broonie@kernel.org
Cc: dlan@gentoo.org,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] spi: fsl-qspi: add a clock disable quirk
Date: Mon, 20 Oct 2025 11:51:47 -0500
Message-ID: <20251020165152.666221-5-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251020165152.666221-1-elder@riscstar.com>
References: <20251020165152.666221-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SpacemiT K1 SoC QSPI implementation needs to avoid shutting
off the clock when changing its rate.  Add a new quirk to indicate
the clock should not be disabled/enabled when changing its rate
for operations.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/spi/spi-fsl-qspi.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 1e27647dd2a09..703a7df394c00 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -197,6 +197,11 @@
  */
 #define QUADSPI_QUIRK_USE_TDH_SETTING	BIT(5)
 
+/*
+ * Do not disable the "qspi" clock when changing its rate.
+ */
+#define QUADSPI_QUIRK_NO_CLK_DISABLE	BIT(6)
+
 struct fsl_qspi_devtype_data {
 	unsigned int rxfifo;
 	unsigned int txfifo;
@@ -306,6 +311,11 @@ static inline int needs_tdh_setting(struct fsl_qspi *q)
 	return q->devtype_data->quirks & QUADSPI_QUIRK_USE_TDH_SETTING;
 }
 
+static inline int needs_clk_disable(struct fsl_qspi *q)
+{
+	return !(q->devtype_data->quirks & QUADSPI_QUIRK_NO_CLK_DISABLE);
+}
+
 /*
  * An IC bug makes it necessary to rearrange the 32-bit data.
  * Later chips, such as IMX6SLX, have fixed this bug.
@@ -536,15 +546,18 @@ static void fsl_qspi_select_mem(struct fsl_qspi *q, struct spi_device *spi,
 	if (needs_4x_clock(q))
 		rate *= 4;
 
-	fsl_qspi_clk_disable_unprep(q);
+	if (needs_clk_disable(q))
+		fsl_qspi_clk_disable_unprep(q);
 
 	ret = clk_set_rate(q->clk, rate);
 	if (ret)
 		return;
 
-	ret = fsl_qspi_clk_prep_enable(q);
-	if (ret)
-		return;
+	if (needs_clk_disable(q)) {
+		ret = fsl_qspi_clk_prep_enable(q);
+		if (ret)
+			return;
+	}
 
 	q->selected = spi_get_chipselect(spi, 0);
 
-- 
2.48.1


