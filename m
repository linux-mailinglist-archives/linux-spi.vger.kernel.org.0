Return-Path: <linux-spi+bounces-8022-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AA2AB11A4
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 13:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75DC017BB68
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 11:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9545A291897;
	Fri,  9 May 2025 11:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VB1fY+Be"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E26291866
	for <linux-spi@vger.kernel.org>; Fri,  9 May 2025 11:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788832; cv=none; b=MR1ez3447SCKG99PcGdGwfx+v1nZcomY5EJgoJbPmHFYX53kNQcziTPLw0PfqmDu0xIx60EAWEvJfQZo7VdsUoOvMXFHyCNFVMVEE7C0sqJG+UZI117d9m+4onqExRqXQHJWDlYGAfQVmAQcwPc0gqt0cTDYmNeOcptLxa5aqHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788832; c=relaxed/simple;
	bh=ENxx1z1sql8wM5uppwdV1BWLNPS2y3yHteg1vsYEf18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PKMwHD/zAd27tIGP4nxln1g6MPoWLt/TDV0KsXcqREFSgtO7TBJmXF1rbDUllHDSWHqiwdoxbCeXIEZUOvAxhBBzEkQVrYmtzso2bDi4wAyeteP03UIvfnm4nYDRQZLzNrlzjrSBCJHu9YLg6YVwsffjjF45fVmovOaSa12JI7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VB1fY+Be; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a0b9af89f2so1154865f8f.3
        for <linux-spi@vger.kernel.org>; Fri, 09 May 2025 04:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746788829; x=1747393629; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qkUQ+DSZxqBk+Ct1g7deBrSh7xiTRYDOYQ8ekYGl/Lc=;
        b=VB1fY+BeVeZTf3wkFDtFnDR18aP2N1B3xlhx2cq/NEH5DpxdZ95xcsuBCblQTMqwqq
         2XeArt+yOVQnMIZj/U8wD7twLFky6pmNJ/R2dIzvOG/RLCVpp+P6qj7HRsxHBgStq/M9
         yL9ACnegF7HuzBaUJVVgnOTHP2NmeKxcHMYcpWQrTLoQ59bD4ou7NlwYRs2T7yvjqmzX
         pPwax9MEHih4SDE0w+ZRBjOZrP1snIgK48yDDk7TNRvjjj8MBgmcA2qfMPYeoNf5+Om4
         X983pWtW9at4rV4X0u252LFVQEb+uN2gl6pQ5cB+K7BKBFr+JcOmwb6YwWnbidJGmmdH
         lwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746788829; x=1747393629;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qkUQ+DSZxqBk+Ct1g7deBrSh7xiTRYDOYQ8ekYGl/Lc=;
        b=J0t40dvkZ6SgvwFuptWHKpwUyAuc3pkTyik8CTA9Mdy4zB1zio7tg3cQdT1qYDyugt
         Ut2GX3fzrTL+4u9H0CD3r/LGhIAKG/NZOgbutDss6FLlfKpSeHoy/BmsRP4cJaJ7+PNc
         za3KT7QzhZ5Lwva5RuyZQo20zI5ePcK3sjF2f52XluqGnUD/8VZK1LHFYSlhjXZn7iWB
         KVIG0wwMWnwjE1K+o9qQGOW8F3gwc4j3RssX1afg4xMhnGR8jjNZWzJzF/S+YOAk68lC
         CKZsfAiTfVg3HNBAZOdJprkkYGiYKDh9ZDhEcmsxleX45faCqokJ0yu4+i4kgxShv8Nz
         CK8g==
X-Gm-Message-State: AOJu0YwTBVnfrN8oHDUo8TBLzEH89plWqyVUsc2s+hSIc2e2IYnNMYZG
	SzaNaa3yqsLSQy/gbnndCuN5poHvO4nhMP5iVMPcO81d9DvWsUzGYa6JMmbKxI4=
X-Gm-Gg: ASbGncvz/v/ryA4leMTKynFsqLnMQLMYXdR5d1YxCkBsV+CWUU/fMcQ6obG5h0qkcOG
	jpGZxRYsjSF8TFs4GQlCZPt+SYJU5Xq+0gurN62DYy9PDGenW/DRsHmW1nP9juAQ58tsGjhJmb/
	o3zgryJoVohXKLnJISYOmG7DMz6k/OVlaCdnszM2rlm9kUW0JMyYzQiwKazbA1MdcTFgr1Y2vDX
	XafdPhpEzfn0Pvk3BiMSyvoaDIJQCL5Pw/+MtscGXrYNuWrmaUTkaoiJMtaIVpq6PgVZLENWu3D
	LCFmwtfb9GFjxNzO8H41LCcH+dbLAHQPX01/xAW3KMFaukEH9EfhXWloAQ==
X-Google-Smtp-Source: AGHT+IHMGiWT8oT8oip5II6TERPV8HSSBR3AVz0wr78GflY0E9YVDL5RBtpoaYK37Au/6LAl5XIwnA==
X-Received: by 2002:a5d:64cd:0:b0:3a0:b5ec:f076 with SMTP id ffacd0b85a97d-3a1f643106amr2707885f8f.18.1746788828530;
        Fri, 09 May 2025 04:07:08 -0700 (PDT)
Received: from ho-tower-lan.lan ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ecadfsm2914797f8f.22.2025.05.09.04.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 04:07:08 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 09 May 2025 12:05:57 +0100
Subject: [PATCH 10/14] spi: spi-fsl-dspi: Enable modified transfer protocol
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-james-nxp-spi-v1-10-32bfcd2fea11@linaro.org>
References: <20250509-james-nxp-spi-v1-0-32bfcd2fea11@linaro.org>
In-Reply-To: <20250509-james-nxp-spi-v1-0-32bfcd2fea11@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, larisa.grigore@nxp.com, arnd@linaro.org, 
 andrei.stefanescu@nxp.com, dan.carpenter@linaro.org
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Andra-Teodora Ilie <andra.ilie@nxp.com>, 
 Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

From: Andra-Teodora Ilie <andra.ilie@nxp.com>

Set MTFE bit in MCR register for frequencies higher than 25MHz.

Signed-off-by: Andra-Teodora Ilie <andra.ilie@nxp.com>
Signed-off-by: Bogdan-Gabriel Roman <bogdan-gabriel.roman@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 44 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 0613642d769d..31521dac1580 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -24,6 +24,7 @@
 
 #define SPI_MCR				0x00
 #define SPI_MCR_HOST			BIT(31)
+#define SPI_MCR_MTFE			BIT(26)
 #define SPI_MCR_PCSIS(x)		((x) << 16)
 #define SPI_MCR_CLR_TXF			BIT(11)
 #define SPI_MCR_CLR_RXF			BIT(10)
@@ -37,6 +38,7 @@
 
 #define SPI_CTAR(x)			(0x0c + (((x) & GENMASK(2, 0)) * 4))
 #define SPI_CTAR_FMSZ(x)		(((x) << 27) & GENMASK(30, 27))
+#define SPI_CTAR_DBR			BIT(31)
 #define SPI_CTAR_CPOL			BIT(26)
 #define SPI_CTAR_CPHA			BIT(25)
 #define SPI_CTAR_LSBFE			BIT(24)
@@ -110,6 +112,8 @@
 
 #define DMA_COMPLETION_TIMEOUT		msecs_to_jiffies(3000)
 
+#define SPI_25MHZ			25000000
+
 struct chip_data {
 	u32			ctar_val;
 };
@@ -345,6 +349,7 @@ struct fsl_dspi {
 	const void				*tx;
 	void					*rx;
 	u16					tx_cmd;
+	bool					mtf_enabled;
 	const struct fsl_dspi_devtype_data	*devtype_data;
 
 	struct completion			xfer_done;
@@ -721,7 +726,7 @@ static void dspi_release_dma(struct fsl_dspi *dspi)
 }
 
 static void hz_to_spi_baud(char *pbr, char *br, int speed_hz,
-			   unsigned long clkrate)
+			   unsigned long clkrate, bool mtf_enabled)
 {
 	/* Valid baud rate pre-scaler values */
 	int pbr_tbl[4] = {2, 3, 5, 7};
@@ -738,7 +743,13 @@ static void hz_to_spi_baud(char *pbr, char *br, int speed_hz,
 
 	for (i = 0; i < ARRAY_SIZE(brs); i++)
 		for (j = 0; j < ARRAY_SIZE(pbr_tbl); j++) {
-			scale = brs[i] * pbr_tbl[j];
+			if (mtf_enabled) {
+				/* In MTF mode DBR=1 so frequency is doubled */
+				scale = (brs[i] * pbr_tbl[j]) / 2;
+			} else {
+				scale = brs[i] * pbr_tbl[j];
+			}
+
 			if (scale >= scale_needed) {
 				if (scale < minscale) {
 					minscale = scale;
@@ -1120,6 +1131,20 @@ static int dspi_transfer_one_message(struct spi_controller *ctlr,
 	return status;
 }
 
+static int dspi_set_mtf(struct fsl_dspi *dspi)
+{
+	if (spi_controller_is_target(dspi->ctlr))
+		return 0;
+
+	if (dspi->mtf_enabled)
+		regmap_update_bits(dspi->regmap, SPI_MCR, SPI_MCR_MTFE,
+				   SPI_MCR_MTFE);
+	else
+		regmap_update_bits(dspi->regmap, SPI_MCR, SPI_MCR_MTFE, 0);
+
+	return 0;
+}
+
 static int dspi_setup(struct spi_device *spi)
 {
 	struct fsl_dspi *dspi = spi_controller_get_devdata(spi->controller);
@@ -1178,7 +1203,15 @@ static int dspi_setup(struct spi_device *spi)
 		cs_sck_delay, sck_cs_delay);
 
 	clkrate = clk_get_rate(dspi->clk);
-	hz_to_spi_baud(&pbr, &br, spi->max_speed_hz, clkrate);
+
+	if (is_s32g_dspi(dspi) && spi->max_speed_hz > SPI_25MHZ)
+		dspi->mtf_enabled = true;
+	else
+		dspi->mtf_enabled = false;
+
+	dspi_set_mtf(dspi);
+
+	hz_to_spi_baud(&pbr, &br, spi->max_speed_hz, clkrate, dspi->mtf_enabled);
 
 	/* Set PCS to SCK delay scale values */
 	ns_delay_scale(&pcssck, &cssck, cs_sck_delay, clkrate);
@@ -1200,6 +1233,9 @@ static int dspi_setup(struct spi_device *spi)
 				  SPI_CTAR_PBR(pbr) |
 				  SPI_CTAR_BR(br);
 
+		if (dspi->mtf_enabled)
+			chip->ctar_val |= SPI_CTAR_DBR;
+
 		if (spi->mode & SPI_LSB_FIRST)
 			chip->ctar_val |= SPI_CTAR_LSBFE;
 	}
@@ -1324,6 +1360,8 @@ static int dspi_resume(struct device *dev)
 		return ret;
 	}
 
+	dspi_set_mtf(dspi);
+
 	if (dspi->irq)
 		enable_irq(dspi->irq);
 

-- 
2.34.1


