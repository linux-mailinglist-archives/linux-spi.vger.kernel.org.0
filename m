Return-Path: <linux-spi+bounces-10856-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC0DC0E0FE
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 14:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 131754F9687
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 13:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EEB1FECB0;
	Mon, 27 Oct 2025 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="tPiPBn7X"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231891FBC91
	for <linux-spi@vger.kernel.org>; Mon, 27 Oct 2025 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761571825; cv=none; b=mIEuNt9q6hpXVo8wMtdozuBh3E4vvPsrffo6bHQbgcgsvNNUO4BH8gZIKsISpPYajqx4uY2meKSGnsE1vhj56L5d4gct33S05yAOg6Xhrh9vSYLiQJzdPu23NIReJBMF3Tf5mL9lIqLWUjNyXHoQhDq1nVxFJGcID1kHYwEwwiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761571825; c=relaxed/simple;
	bh=irpydtjBnNGkoYUkduEdVKqR1Dq2M0mmWm+e59RVSDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lBLxc+AszJ6uxkM6JW0XdL/EzZPlVS1r0wZB9M+MTu8/TAJ/PXhXca1+vBYPdftMKQOiqcFJ7W8dGkoXDppKBDDF1OjWOdwEYR+VBS4Cqi/pg/FibQlu4ePwucSgy1M8sq/FOWC5VjlEr4BheH6vqKIkIKJqglUJnWsfAQJwgqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=tPiPBn7X; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-945a4bfd8c6so141047939f.0
        for <linux-spi@vger.kernel.org>; Mon, 27 Oct 2025 06:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761571822; x=1762176622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WwBrji1LVVqX5QLhYIQg8MHPDU19g5B0S1hpvpp4hEc=;
        b=tPiPBn7X2yd1/B/lsF2mH6Jef2O2lF11qrqQoQ0OX4KrDNRUEAWqK5lHqlWZpakjwq
         hxcR4DwnEqPqK6TBCNCHUe12tTVhoBB4f/X4u2uJzFaL2fsBCoGEPhAqqRC7cASZoE8s
         53of9LLSbmPxEz5CQ8aRNfxx9vDK/brH4xTPV7UCmlqCINzJs6gUJlHM+pb2JefDhsdp
         2Id+lN2aRrayfXuYhtcm1UI3r03iLP5zKmesZbXrnVjn4Od9SHW7YtjjlEvjFw+LeFEu
         WfrR0LSxDXdwOE5nMFkwiZSz5+jcj7Htz4DCnk+ZWiH9+uNx+25VaqXF/VWxZUeirHSO
         hnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761571822; x=1762176622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WwBrji1LVVqX5QLhYIQg8MHPDU19g5B0S1hpvpp4hEc=;
        b=wZb5i0rEcDFdv63KJMjFc0Z8WWVDmX1xdtOMmt7SX1Y8lCpTtQVw6k8iWDHvnzOcYb
         pAwNmU4rCduQLRqhRtZgHWzoOWCrpF37NstTzwObJE+f9IfQn9/pbEXmHPQfjR+97yOq
         Die2/iKjSD33ChauYFbOW/oGEH0xnKnJ6N+Eapk7aJExcEQWauiTdRpo7ThxFOhEuHrf
         Jtm0nzsKegMNIlXzD8bXHXAkBtb5/N7TdtGB0SwsuZOB46a58SopuIFhIO349jKGhLnp
         bnbdg2XqiJTt+BU4b7TT8arD0bR9y1jdyTbjftSAkAWc+H4T5AjpcbrXxStYsSg0SAPn
         ULnA==
X-Forwarded-Encrypted: i=1; AJvYcCWkSqlv2x6rRyS57Q4ZXvDA1Yk2gpkiDnXqR3X4LWi8KafsHoLq/LwyzE8CUynmSoxwNctmS6RUL1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY/eZRDf89NQi00aypNueIZGJykrOKvu54cY5NQVfSozTPkOeM
	7gtYjn26BDapKkxbR23hKMxYnQmbRHWKl6UravmurqcCfkNfcTODHlRfGNwFKGmf56M=
X-Gm-Gg: ASbGnctc2xwTrXAvz3WOSepqeLrSYWi18Hitp0BUE+rR5VzgfFBcXl9uNl1NZkjqMoC
	c9Cw1sEctkklgOdR05UKuxThbKfWuQKFFrzAEiqHUEfRfZY0imQ/TNLqRX6Db9gkVkss19GtIF8
	0fS50DrzC18CKQVRBKxyrUD8S2bvd91UgFxZI4wROerNyVEmhJee/aCkYxXxSTXTTzR7aR/KXW2
	Shp/OKGmC+yjgdIYOkRvqZr4aa6O6jKPaB8uhyEv3ZWBFX1+X+RWSi+useyT4Mu3rFPP7NTpRrh
	2FSONK4Bj1+5fMsG9RylHEfTQxd+7UDSyub+9GoHcZNp+P0/nOgPumSEqPrqFxLwpu2aICIJxTK
	vRrr45olYMxHWtSWTQ0o34EOuihkZsfsPOLZQbfnDbJ27Sdkj55GzOhM73Xne9OULNGGlMUwy2+
	SHtXcshMqFTGWN69GyV9ZKDoBafna5s/0c1MbQ9a49BhTxYMXxVIM1E+Dn/yTBrEKJ
X-Google-Smtp-Source: AGHT+IEea/t006sDIUwyJirb8lhRy1y9vqvFLUYDpT5bn8joxV7TPLkwITOKKA0xlex/9Fj770b8Lw==
X-Received: by 2002:a05:6602:1687:b0:93e:8c1e:cc5d with SMTP id ca18e2360f4ac-945b819d91amr15227739f.5.1761571821923;
        Mon, 27 Oct 2025 06:30:21 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea78e2fd4sm3093057173.26.2025.10.27.06.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 06:30:21 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: han.xu@nxp.com,
	broonie@kernel.org
Cc: dlan@gentoo.org,
	Frank.li@nxp.com,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 5/9] spi: fsl-qspi: add a clock disable quirk
Date: Mon, 27 Oct 2025 08:30:03 -0500
Message-ID: <20251027133008.360237-6-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251027133008.360237-1-elder@riscstar.com>
References: <20251027133008.360237-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SpacemiT K1 SoC QSPI implementation needs to avoid shutting off the
clock when changing its rate.  Add a new quirk to indicate that disabling
and enabling the clock should be skipped when changing its rate.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
v4: - Added Frank Li's Reviewed-by

 drivers/spi/spi-fsl-qspi.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 1944e63169d36..2c030dd6facc7 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -197,6 +197,11 @@
  */
 #define QUADSPI_QUIRK_USE_TDH_SETTING	BIT(5)
 
+/*
+ * Do not disable the "qspi" clock when changing its rate.
+ */
+#define QUADSPI_QUIRK_SKIP_CLK_DISABLE	BIT(6)
+
 struct fsl_qspi_devtype_data {
 	unsigned int rxfifo;
 	unsigned int txfifo;
@@ -306,6 +311,11 @@ static bool needs_tdh_setting(struct fsl_qspi *q)
 	return !!(q->devtype_data->quirks & QUADSPI_QUIRK_USE_TDH_SETTING);
 }
 
+static bool needs_clk_disable(struct fsl_qspi *q)
+{
+	return !(q->devtype_data->quirks & QUADSPI_QUIRK_SKIP_CLK_DISABLE);
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


