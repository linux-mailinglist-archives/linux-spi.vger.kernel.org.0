Return-Path: <linux-spi+bounces-8025-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EC7AB11AF
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 13:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1F7AA213C0
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 11:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B8E292095;
	Fri,  9 May 2025 11:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HEQ49tpH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0832918F0
	for <linux-spi@vger.kernel.org>; Fri,  9 May 2025 11:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788836; cv=none; b=QCJ+I1kfqHQ9yp5A3e0X7oIty+h8e4aowdlj+lbomBdaavDYU1FKIztkEOXSW8xhhmDf0dPNufyPqTy7N8QWZRh7O1VPXXWZjPVVa6c9FiK8N2ASkgoxOLuiZhwtSn9sM04+gXgkXtlBo1AkoyoUDT2OcpLQWfBTvKvwWIcVxY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788836; c=relaxed/simple;
	bh=/1WgmjiUPsgAyXKXEEwEXpR87Eos0KeMZvFNpmziqFU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WHJ5x5ur1hM58Vv7jzihhTykb6zJZd35Ho0mw51sQOvqrzBu0JYdv5cncLAQeHcY1EAuU2i5Cag9zzwPycQSObr9RzhffDUUms9QLWA+DCrF86H6jpS20SA79GllJzMm4p8uxW8x/bkqv9eiHBXQQoQtf/kNkxSPUUtde+lr7xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HEQ49tpH; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso12312135e9.0
        for <linux-spi@vger.kernel.org>; Fri, 09 May 2025 04:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746788833; x=1747393633; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RMuvm3u0FO0tHSMEJjZ+2DIuKHjMVjXj0UsWrbU1Pz0=;
        b=HEQ49tpHF/8MWJJvzi7xzrZVF1gUvVVz/Nc1uMt7YwNgI6rZV4HvgzzdvJfm8QwpKc
         ISYkH/NazjU9KtE4ZSEnRSoGhzkKyceM09XjdHQFDopwbTWPIAeNDysqPw7zrX99ntrQ
         U4+r/aehnPNg6rXyPXtB4WjZbITPoOR3x8qFTDeK4ba0eLoszsSlkjwjgDyUFlJuskMf
         awRNwOmRgbQDaU/peWwEUD4WAy7Jo7us8MuIiV3iKGtTN84UzQaOyOH7kcPQTf+nGAWE
         pysvi3kZRHsgbhL2GxeAGM3uo0mtPVJVO6ltBEk3Av9JibJ7ODV28h9rNbCAnj7d4g3E
         aN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746788833; x=1747393633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RMuvm3u0FO0tHSMEJjZ+2DIuKHjMVjXj0UsWrbU1Pz0=;
        b=riavHsq1kEBaSnxxCXs3NlRIKcMr+kldi/UU1CHug9nF/ugqDecv/tlveitE2cftUa
         uV975ACAw5gHwKW49ECBqnRXjJ1BLxo+fme1mC4jEzNYcliaq0E9Hwse6J2DXvwFLm7X
         89pxRQl8AhNq/ZiXSaHZ+KmQvI+9PAXNZSeurFeS+1gGeS28FizRtlu+9SqA/UvSqHCB
         NY7Ycfe19fGJM0u7d2RYQeRA+1BfqsTLp97tBKJ59K2tevPnYl59vx2S5T2u+eAhvBUw
         Oik0m4wVJWqKPhasY47HjEtYs5cu/d1gxg22nJOTKbpzNY+H4izinzOskT5FVG1ytjx4
         e3Mw==
X-Gm-Message-State: AOJu0YxETmvvQeIrEMWGK4PzuzTIG1/eWMiXcfCIE2jHyTGkT+FRoxKq
	JfABlXxOcE9+7T0aBaip5J3GLD7IZYvpPS8EOL8n2vp1MgmQ+C79bPRsoHUPWx8=
X-Gm-Gg: ASbGncvQG0eA2Uw3xkyfK3emi8MKVzlFE0B2qRNptJGob9UhJiR5bXrIi2/owlbr39e
	/u8s59kb3I5XG4ByO7LMUsomx6rJZUxu2WWauA1xDkwXVdhNI1sXGGEF6nHS0f+kDdf1RJTwGnQ
	xFQamDiEhfk0I5DJyXkIrBEkGsSPYSDzQ0QtdXxcM/UBoMOso+n+zNrIthlx6pUZO/JS/pvIvrp
	Vu1YRgNLuBtEdyuCqUtIZtgnVMoyA4ssLWVOF+2AkMTG9cGR951ySyr2hhbrUI7ekn3EzuS4/R2
	52m7aM3M3ftAdlfTvOLVqOaxZ5DBjKy4NaoEEJliK/Cj4k7dMXFFOlnfaQ==
X-Google-Smtp-Source: AGHT+IEI/21cAkCpKqtXo/RJBX5fMArAhVFuko7+5QHt2vTuixWOjpsB6oyJPSHitDVLWZA2KHt5xA==
X-Received: by 2002:a5d:64ce:0:b0:3a0:b8b0:441a with SMTP id ffacd0b85a97d-3a1f643ba6bmr2415644f8f.25.1746788832870;
        Fri, 09 May 2025 04:07:12 -0700 (PDT)
Received: from ho-tower-lan.lan ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ecadfsm2914797f8f.22.2025.05.09.04.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 04:07:12 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 09 May 2025 12:06:00 +0100
Subject: [PATCH 13/14] spi: spi-fsl-dspi: Enable support for S32G platforms
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-james-nxp-spi-v1-13-32bfcd2fea11@linaro.org>
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
 Ciprian Marian Costea <ciprianmarian.costea@nxp.com>, 
 Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>, Dan Nica <dan.nica@nxp.com>, 
 Larisa Grigore <Larisa.Grigore@nxp.com>, 
 Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

From: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>

Add compatible for S32G platforms, allowing DSPI to be used.

Add a depends for ARCH_NXP which can replace LAYERSCAPE and also
includes the new ARCH_S32 for S32G. Similarly, ARCH_MXC can replace
SOC_VF610 || SOC_LS1021A which should avoid updating this for every new
sub-platform in the future.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
Signed-off-by: Stoica Cosmin-Stefan <cosmin.stoica@nxp.com>
Signed-off-by: Dan Nica <dan.nica@nxp.com>
Signed-off-by: Larisa Grigore <Larisa.Grigore@nxp.com>
Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/Kconfig        | 4 ++--
 drivers/spi/spi-fsl-dspi.c | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index ed38f6d41f47..ff26be07226b 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -647,10 +647,10 @@ config SPI_FSL_SPI
 config SPI_FSL_DSPI
 	tristate "Freescale DSPI controller"
 	select REGMAP_MMIO
-	depends on SOC_VF610 || SOC_LS1021A || ARCH_LAYERSCAPE || M5441x || COMPILE_TEST
+	depends on ARCH_MXC || ARCH_NXP || M54541x || COMPILE_TEST
 	help
 	  This enables support for the Freescale DSPI controller in master
-	  mode. VF610, LS1021A and ColdFire platforms uses the controller.
+	  mode. S32, VF610, LS1021A and ColdFire platforms uses the controller.
 
 config SPI_FSL_ESPI
 	tristate "Freescale eSPI controller"
diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index db921ee6305f..0982f27a9b2a 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1311,6 +1311,9 @@ static const struct of_device_id fsl_dspi_dt_ids[] = {
 	}, {
 		.compatible = "fsl,lx2160a-dspi",
 		.data = &devtype_data[LX2160A],
+	}, {
+		.compatible = "nxp,s32g2-dspi",
+		.data = &devtype_data[S32G],
 	},
 	{ /* sentinel */ }
 };

-- 
2.34.1


