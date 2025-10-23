Return-Path: <linux-spi+bounces-10790-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 316C5C02D1D
	for <lists+linux-spi@lfdr.de>; Thu, 23 Oct 2025 20:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 83B47354BB3
	for <lists+linux-spi@lfdr.de>; Thu, 23 Oct 2025 18:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B3534BA45;
	Thu, 23 Oct 2025 17:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="EKnnrikm"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE74934BA51
	for <linux-spi@vger.kernel.org>; Thu, 23 Oct 2025 17:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242373; cv=none; b=r/I5IG7eXmZSNEwK0WyFHVUU6RwldHAWV1tRaqdhj7Dc6tRhY+wKK2eGflq/IMK9VvRfO5lymG2Vz3nhGJ0WcbYlVVNqybA8tX53rELzsikTFmfNaHneNumJ7TmUzuyY8riNsvjYk1WmM/UJB8eGS/u44xyY3uoIY116mr62J40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242373; c=relaxed/simple;
	bh=EkU2Rug1mgYJi/cmODCWd1WGMqqUFjCxy//sYzWdjcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FqA8VRx4iS61w8ybCd8CpL2rw8HnLR4dMPW5pQovXQGjx1iyOANYwCQhZ1kmfE5hXd5r/hWPen6KiPmNPitwUIhT4fYJlDkeKj18kLEZB+W6QpW9kLGxh2Fc0+IGY+52Cpz1Imh+oVFf5yret2/sFxoIqTbqCQuMUI41+jEulqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=EKnnrikm; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-791c287c10dso849330b3a.1
        for <linux-spi@vger.kernel.org>; Thu, 23 Oct 2025 10:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761242371; x=1761847171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I05R5wxHah0tP+5XjRF9CvuJmtSK0+imsUvDjfvNbmE=;
        b=EKnnrikmaCfyPdqN2FPhE0tKhl+vsccU2FP79sXfUmkFjuD3zsbtrK+drwT47kaTeQ
         Gr7BAoBBnMTynM1+xqgsLFJDwt7LPKJvDSTinxBnaH9F/mRZj5jCfiUK1vZOxz/8njHW
         EdV/C8oD3bxV+DA7hWMiJmuh635Nng0fyPQcg4hpH1BmSqhC2cL/7+5dg3ngUygt+d+h
         sWAOw8NcK/LUfrrQa3n7/Tpzz6mz5W+I5qciiC3omGAszM+e6ioHG5rDVa+JvKXxaR7q
         5ptmnIiK5pPrP73hPNU7hu0yb3wkvoSP7/+G8MU1fgWykbK7bD9UzBsrn6dKmQb53NMD
         1z7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761242371; x=1761847171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I05R5wxHah0tP+5XjRF9CvuJmtSK0+imsUvDjfvNbmE=;
        b=Me1HTzbFneMhxTVpOc3mwhV7je+6RltNqjBREJZxUlOLEFJ9NiPjZf4zZsWzH9u9tj
         N1lpJqzwOvG3qIL1VCixYcSh5xPBq/XZYjrsIhkyu6ZSMbyIypL1GpDak/yw7CSqcNir
         2KK8xzS0WKtyP4OfQu+SYtyHov5fD3nnNW6i28u75w5L4KnTxIA6YuUzuINeJ/o3zV4v
         fCPMkKu2mOgkEptH7yWoBs2sKDdBdiWVu7cIA81vHtRCdR/j9RrM/fREgr/DSdGOuGS1
         0l4dfD1x6y4IFNrvCGWZRc81sgMW9PGY3Ga6+gt+Nt+j10LCqBz5omri2I9jMSCsEbut
         BoOg==
X-Forwarded-Encrypted: i=1; AJvYcCU+NDySTAV+LzMEgVe1o2L3057oatuVPXCZN8wQF1X98QB6ayFLz/HaDJeK02t+ygqYeNEuZjSb5Us=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRujFgG7UQ9BUJHSBmaaf1S6sbFgcbw8A2uP/KcOrVz4X0H08v
	gqgth63uMelj0s/jhK0fUg4icNTcXbfkAinMRa7DZ1FKMmDRkW2Uj1Yx+lH0zkmMB5w=
X-Gm-Gg: ASbGncseJcOz9eyovcj3LjZw+m/N9/S0SQ8VMQAFWIs5PEN4QGOwlZpA3XegfrcAbnL
	rnzJwhPmHMdmhf/0cP45XheHZDvhl8Bh/kKp/TPdPlq9jFWpyT1Z/dJF0rTr6RBHa74KXH6hy7T
	xUINLNzrQveQe7OzfP/6i/bKlPKXj1K2EMW/2fuN6eyt96Q7g/wZ8Z3Cw7gUIAgoqcINE17QCF7
	fai6fbU4mXZSilz+hMOwIHexT+sVdrj5kljIlZXJ+sN5KFxJXNQMHa1d73Gy8o217yHBKivpRYO
	4JD5ulqqoaN3t1LuVak6EG6sJTYTtaa5RXXd3OUFhY8rfDmT9fY99TAlp3Tv5CbrRqJwB4h5K08
	sXFYZnlG9Wfu4Ld2RKBuR6hHYZHy9AXzgaZLOE3wXQrSAx9XYfWm3MC/ICx3hMm4Al+8aIz4UoO
	WorqeRKGioQRisjmiHzy2Z4lY=
X-Google-Smtp-Source: AGHT+IGoCA5eG9vMTRsnrdRnkF5/ZgcCIYMlzlQVHh845VGO6X+2euBU7KRA6snytjs6NQ8wnUF2RQ==
X-Received: by 2002:a05:6a21:3086:b0:334:a250:5774 with SMTP id adf61e73a8af0-334a852285emr29903456637.11.1761242370937;
        Thu, 23 Oct 2025 10:59:30 -0700 (PDT)
Received: from zoltan.localdomain ([208.115.86.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223d1265sm6447431a91.3.2025.10.23.10.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 10:59:30 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/9] spi: fsl-qspi: add a clock disable quirk
Date: Thu, 23 Oct 2025 12:59:17 -0500
Message-ID: <20251023175922.528868-6-elder@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023175922.528868-1-elder@riscstar.com>
References: <20251023175922.528868-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SpacemiT K1 SoC QSPI implementation needs to avoid shutting off the
clock when changing its rate.  Add a new quirk to indicate that disabling
and enabling the clock should be skipped when changing its rate for
operations.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
v2: - The quirk flag is now named QUADSPI_QUIRK_SKIP_CLK_DISABLE
    - The predicate now returns bool and is not inline

 drivers/spi/spi-fsl-qspi.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index 1944e63169d36..c21e3804cb032 100644
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
 
+static inline bool needs_clk_disable(struct fsl_qspi *q)
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
2.43.0


