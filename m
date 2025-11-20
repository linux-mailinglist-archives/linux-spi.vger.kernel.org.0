Return-Path: <linux-spi+bounces-11442-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B6AC765A2
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 22:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1CA6735257B
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 21:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C792F83BE;
	Thu, 20 Nov 2025 21:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="A1vV/pzQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D59308F14
	for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 21:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763673231; cv=none; b=Gudd6AYp/dADBJNOCsN7/Wo4gGhpG01YNhSEyJ9bljXs5GMO8WPAWBXEEaM2XDR2clB+6O1hv4e/OTiuMGiXT9JCPDK/xykIhHoXKGO+SmaA9r9LRyQ0g+LleTP6YHKdZQ/E0SS7RCLG7NTGPQ6jR1c2G7+nIJ3J6re8PDFJjsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763673231; c=relaxed/simple;
	bh=VnDw0zvv3GogQgXhxGuqkFEbxhLcCxNhOQ3NhXqX+6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xa1BiEgWYfpwGHo5NCbWexVam9qnSei0RlX0ds0mmfg83AXrDHilp2jnrRavhS/8V9bR2Qlmq8YfPDz9rEz35zeHRRPKYzcC+lTjCj1bAllcHfMEqAsKIzI1exd3jgH8NdxW7DN9sOViaXpIqsYcyJqVscEikMUoxA8tt2ayZjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=A1vV/pzQ; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8b0f54370ecso115340485a.2
        for <linux-spi@vger.kernel.org>; Thu, 20 Nov 2025 13:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1763673229; x=1764278029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCl3US01BHeY7ipE4Tn2LpS35TI5yu+VHTAF1Nv080k=;
        b=A1vV/pzQXZfAGpJKZZDCgvkGJK2DLTxmAlBU5hXmDC4YxSU+dDGQ7QqCTCg4dt5KL3
         xnBj3G2E9KipxNO0iacyyW+BekIG2GyylnpBDaFMtm3ooJCoerju0+9Z8FjHHC4Q0Raq
         cK/sYeuP+arMi3AW32+diYL1OlL9driUetCUI1wocNU6VHm4jnn7BBfviqjPhvXIaf4I
         yMadcX5tb/Pbjt/YAUUpeE/oTqDfuGV2iEg5Mp8JCFUEpMePmiAF4bHg320Nn7tvWzkO
         OAimJFZvOt7rKLqlTT0dpovrdNcX5cHRklrn2fL2szi+I3J0DM1Xp8w/YYUUfupuAMU/
         fdAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763673229; x=1764278029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GCl3US01BHeY7ipE4Tn2LpS35TI5yu+VHTAF1Nv080k=;
        b=eOU08G+UtMiZnqBEbm6jL0GkLcG8GNCHkHP0W6GA5i3wwGOIs1IUcikkgnCxDDTqoB
         ikdvX17wLIL2iPQL9KhEQdUtgHmJIca1SE1TuEIzKx7PSiZBVlpifWh89rk3JkrML8N5
         uHt7FaKtDfWOjMIetOgh7angLz67iX1goWvWTlMb6ZJZQscVcaE2PY7KKVvoUgu2xz3v
         PZimwLC4san3YFyd/Gf/skIkRq/9yRq2/PrDht2Oqpq0//LSatMQaCwXIyR3W/Vap1uo
         N5irYm5AGTHQuzV3Iou1s5s4KO7vLz771kdagiCQnHLbsOOdSW/Z2jCiqWY4cZMPA7so
         Czvw==
X-Forwarded-Encrypted: i=1; AJvYcCU7YdZLl9lPMBIAUFXB4++DBhS3sjWaMuEDxh+Xw/TAl9kYVKmm33snVEWTIaWPg88r3gIJWzIMW4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2gkCC3pUk5is9ozpvZekKvDv2utawxWVxdrQhI3S3YSLIQHX2
	n+705a7BLgJcZLXXkRmwpkWgzthPnNm1x6Il34OztMBXyzcryo8m+rQ2j3yy2e/gjEk=
X-Gm-Gg: ASbGncuyf2dQMFTkKMh+U+7rNFsMwrNVgzpOjZ6Qs6lqIr+hPbIoIfJI1DLEsvXnP3G
	hqzHu2Zx7VOadk+zGZ4rCxK1Sr+sQ0m+TbXNvpL+ITNMVG1ZZtKXU9ew22Ng6uW+cuR/fpBRjvU
	1yEZExWr7ckWYEQQzj1KYTzCfT74DTbhoIQP/30FORDK4fW65T4gkf4/wwN+TY7k1fD+dW/lWTX
	brvlddR7LqJTA6Tn1SpHqcPw/lKawE+19zKtcArQ9/DPpJvj4J3SPDl46KLa21L5X5JHAQ/sjWl
	ug+0XNpj4NB4VpIng3YSoqbLc5hadl4qRUaD6cjp6qe4XNUpJoADZkec+1++m7bJsNHnn66vEse
	faasMN251g6+J27JHVf/pzKRUchY+LEgX898+EHCoo3LaSylKz5ReAHbmB8nCI5mHUT0mrZP4/d
	pwoRyxvS1N2uGIxwZsEG1Ruasmlnx5F9VH45ZCj575dcxN3GISZ9LUXAJuyRRsQsKESA==
X-Google-Smtp-Source: AGHT+IHuBplFI5V5Lb1dDPP3u7qdP7GhmlzsKYMVNTFhNncVoUA4QK3005YkGNWMWRXcdG28p7xdfg==
X-Received: by 2002:a05:620a:4506:b0:892:5b57:ea41 with SMTP id af79cd13be357-8b327310f9emr616076185a.4.1763673229090;
        Thu, 20 Nov 2025 13:13:49 -0800 (PST)
Received: from localhost.localdomain (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32953735dsm225958685a.24.2025.11.20.13.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 13:13:48 -0800 (PST)
From: Jonathan Marek <jonathan@marek.ca>
To: linux-arm-msm@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/5] spi-geni-qcom: rework setup_fifo_params
Date: Thu, 20 Nov 2025 16:12:02 -0500
Message-ID: <20251120211204.24078-5-jonathan@marek.ca>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120211204.24078-1-jonathan@marek.ca>
References: <20251120211204.24078-1-jonathan@marek.ca>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update each register only if it changes.

This also fixes the chipselect related registers not being changed when
chipselect changes but not the mode.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/spi/spi-geni-qcom.c | 48 ++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 53229150b86b5..5cca356cb673a 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -82,6 +82,7 @@ struct spi_geni_master {
 	u32 fifo_width_bits;
 	u32 tx_wm;
 	u32 last_mode;
+	u8 last_cs;
 	unsigned long cur_speed_hz;
 	unsigned long cur_sclk_hz;
 	unsigned int cur_bits_per_word;
@@ -350,34 +351,25 @@ static int setup_fifo_params(struct spi_device *spi_slv,
 {
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 	struct geni_se *se = &mas->se;
-	u32 loopback_cfg = 0, cpol = 0, cpha = 0, demux_output_inv = 0;
-	u32 demux_sel;
-
-	if (mas->last_mode != spi_slv->mode) {
-		if (spi_slv->mode & SPI_LOOP)
-			loopback_cfg = LOOPBACK_ENABLE;
-
-		if (spi_slv->mode & SPI_CPOL)
-			cpol = CPOL;
-
-		if (spi_slv->mode & SPI_CPHA)
-			cpha = CPHA;
-
-		if (spi_slv->mode & SPI_CS_HIGH)
-			demux_output_inv = BIT(spi_get_chipselect(spi_slv, 0));
-
-		demux_sel = spi_get_chipselect(spi_slv, 0);
-		mas->cur_bits_per_word = spi_slv->bits_per_word;
-
-		spi_setup_word_len(mas, spi_slv->mode, spi_slv->bits_per_word);
-		writel(loopback_cfg, se->base + SE_SPI_LOOPBACK);
-		writel(demux_sel, se->base + SE_SPI_DEMUX_SEL);
-		writel(cpha, se->base + SE_SPI_CPHA);
-		writel(cpol, se->base + SE_SPI_CPOL);
-		writel(demux_output_inv, se->base + SE_SPI_DEMUX_OUTPUT_INV);
-
-		mas->last_mode = spi_slv->mode;
-	}
+	u8 chipselect = spi_get_chipselect(spi_slv, 0);
+	bool cs_changed = (mas->last_cs != chipselect);
+	u32 mode_changed = mas->last_mode ^ spi_slv->mode;
+
+	mas->last_cs = chipselect;
+	mas->last_mode = spi_slv->mode;
+
+	if (mode_changed & SPI_LSB_FIRST)
+		mas->cur_bits_per_word = 0; /* force next setup_se_xfer to call spi_setup_word_len */
+	if (mode_changed & SPI_LOOP)
+		writel((spi_slv->mode & SPI_LOOP) ? LOOPBACK_ENABLE : 0, se->base + SE_SPI_LOOPBACK);
+	if (cs_changed)
+		writel(chipselect, se->base + SE_SPI_DEMUX_SEL);
+	if (mode_changed & SE_SPI_CPHA)
+		writel((spi_slv->mode & SPI_CPHA) ? CPHA : 0, se->base + SE_SPI_CPHA);
+	if (mode_changed & SE_SPI_CPOL)
+		writel((spi_slv->mode & SPI_CPOL) ? CPOL : 0, se->base + SE_SPI_CPOL);
+	if ((mode_changed & SPI_CS_HIGH) || (cs_changed && (spi_slv->mode & SPI_CS_HIGH)))
+		writel((spi_slv->mode & SPI_CS_HIGH) ? BIT(chipselect) : 0, se->base + SE_SPI_DEMUX_OUTPUT_INV);
 
 	return 0;
 }
-- 
2.51.0


