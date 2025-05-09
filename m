Return-Path: <linux-spi+bounces-8018-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADD8AB1194
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 13:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBF771BA20FF
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 11:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A37290BD9;
	Fri,  9 May 2025 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cR58UcSU"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF03D2900B3
	for <linux-spi@vger.kernel.org>; Fri,  9 May 2025 11:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788826; cv=none; b=Fgd2NVjvIO2oJ7ZmWBQ9zJDo3OCsvrafwG3AKt1oIFkg3pcTGV7Qq/TGXujgfPbAA+GhQcunYfTJblaxd+eIDoA+LgXmt8OAA8IZMmWK0f1sZbxIu/1365ysArsJv9CA6wWcx1+92aINI9i655Cl4nxsle16afl4UR73lutrW8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788826; c=relaxed/simple;
	bh=/FAuRPFC8ORDoN/VXflFQ2NEMxezE2lgdO50IWKPdAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qPvMMNCKHHz25OkqTZJzirIYpCMFV/sUkcCoFpc+UP98l8k0yb24w5g4TuqvCALZ15Q/yoQYxx/to9TwzjK8aa3Yk53MTI4lvbgDORUzFZBnu9s8ns+srTevZgLm6IGA1Yjy11c57tlIuq8gIqfTYm4i1u8oIU7GQJFV3EFPy8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cR58UcSU; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3995ff6b066so1099061f8f.3
        for <linux-spi@vger.kernel.org>; Fri, 09 May 2025 04:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746788823; x=1747393623; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z83P5zYL5aiqJ4xhC2aD1SNehmR83/wjYJwbnC4UTJU=;
        b=cR58UcSUp/4wAZsyJLhDxagPmAE4OvsGkoqXjnMSbinDq8D4c8pZmsgQu6aGouYWmY
         myOi28F6hyfSnjK8d+CLNeq1ndhgujIW57ZUfUm5nCWd3VC/FKEp+8b6MTXl7ea9S45t
         491OHUVYWn4h+qAFHZ+042p7OAszCPpuamaWjgb1GPztv0u+YcU09dk1CteHnFkxq53/
         qeb4T76lMakZpwpw+Ivundd8J1mbxs4f/o+FB/t5OQAYd+P7cZL6n3u3jl1rgGw2jyCr
         RW9YRy65kxmBLVK4YofjVT8RP2gD6rQZufo5a8a8V2qDFiwugzjONC3ydvmZBLb9k8Z/
         m0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746788823; x=1747393623;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z83P5zYL5aiqJ4xhC2aD1SNehmR83/wjYJwbnC4UTJU=;
        b=IU6DFuWrXEcVboo5jv0mBaIF67U2iCXFOscaIBU273OvZVrEvJSbug1/ZIRmh54OTp
         VfZPJ8tPGJVEtY3HJ0x55WPLwtYOHIjav77ZP2OztGgdFuWiNqcnOuJ0xkBwoJFP0hmy
         JciLtVuCmdsg60ayu59YO8yTTHk4BwuV1qbo/eHFmz0oiJ0w+viSx80xpbNZ2vvZ5NvM
         Ex5VXAD/qUOyvgdUonFQsjkRL3v4c/jq0aeJ0YUhkSeE8MElM3RoPqxAqJOE6NOYjyK8
         nELDeFgbJV3HwhKF4V+0hRypr7RMhowYve63tlK3XIJohJSq3BPXPt7IDJhXCP3YtTLK
         Wxow==
X-Gm-Message-State: AOJu0YzKMrRZOn3NkYzq7S4rdAga/0ssJkdMmcOPk2n/H1Zik4uVDJ5f
	KJBpHX1D8Jot26Ln0oW1JutmQCH46PxcIIL4LVlv67k5EkZZK/xD95rFMSfu4YI=
X-Gm-Gg: ASbGncsUcgaNf0hivmWoLNC0SbvADlv3/k0sYXzGpiYEVy+1aXGf6+LWaEPLEiMKDIU
	nXFioeHqoeUmVZnrieX8t2ZbYiWdOh/lzDiy5M/HtHyPf5miX6p9uZ0YYrvucSrcGNrjk82Ud2d
	KKLsTjGNiGTHMpWzwbHaZtGuQGNjXkTyxbyDzH12ZYr2dWM+Vc+LvFm8gyuE+5cBrHidJnBfX19
	BMkychB4Tkc9eYPoqdikr/mRCVRLV70UjIvatU4zB2RTHn26WvOh4+LFwyrK9sfhPDHW5aFIllc
	IGRiuHyUNQ7+JFLqSNNfO2IMvU0pi5H3+oCHLmRoHoaRhm8=
X-Google-Smtp-Source: AGHT+IEzZyvVmE0isCL1qd+GE70rpX9DLtjU5jOZ0ngvIzyhV3E/BibSqbyphaSiycReT9JsLKLk1g==
X-Received: by 2002:a05:6000:2cb:b0:3a0:b8b9:6b2e with SMTP id ffacd0b85a97d-3a1f64a430cmr2498885f8f.34.1746788822979;
        Fri, 09 May 2025 04:07:02 -0700 (PDT)
Received: from ho-tower-lan.lan ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ecadfsm2914797f8f.22.2025.05.09.04.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 04:07:02 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 09 May 2025 12:05:53 +0100
Subject: [PATCH 06/14] spi: spi-fsl-dspi: Avoid setup_accel logic for DMA
 transfers
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-james-nxp-spi-v1-6-32bfcd2fea11@linaro.org>
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
 linux-arm-kernel@lists.infradead.org, James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

From: Larisa Grigore <larisa.grigore@nxp.com>

DMA can't repack the buffer like the CPU can, so skip the accel path
which may change the word size and break DMA assumptions.

Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-dspi.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index f7f9425a19e1..902bf23d276a 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -849,8 +849,8 @@ static void dspi_setup_accel(struct fsl_dspi *dspi)
 	struct spi_transfer *xfer = dspi->cur_transfer;
 	bool odd = !!(dspi->len & 1);
 
-	/* No accel for frames not multiple of 8 bits at the moment */
-	if (xfer->bits_per_word % 8)
+	/* No accel for DMA transfers or frames not multiples of 8 bits at the moment */
+	if (dspi->devtype_data->trans_mode == DSPI_DMA_MODE || xfer->bits_per_word % 8)
 		goto no_accel;
 
 	if (!odd && dspi->len <= dspi->devtype_data->fifo_size * 2) {
@@ -859,10 +859,7 @@ static void dspi_setup_accel(struct fsl_dspi *dspi)
 		dspi->oper_bits_per_word = 8;
 	} else {
 		/* Start off with maximum supported by hardware */
-		if (dspi->devtype_data->trans_mode == DSPI_XSPI_MODE)
-			dspi->oper_bits_per_word = 32;
-		else
-			dspi->oper_bits_per_word = 16;
+		dspi->oper_bits_per_word = 32;
 
 		/*
 		 * And go down only if the buffer can't be sent with

-- 
2.34.1


