Return-Path: <linux-spi+bounces-9425-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4727AB26BFA
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 18:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0703E1C238E4
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 16:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9D3253F1A;
	Thu, 14 Aug 2025 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vHJ2mU7G"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9686B2FE068
	for <linux-spi@vger.kernel.org>; Thu, 14 Aug 2025 16:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187635; cv=none; b=Fd7CodtqKSG9GeWrAehl2vfAQEX2szNc5zJxnj8Cb6TL2zumKcjI2OR/leRagW1cZMbtZUHL9MBxMO+gAhu8Nkbr/8nHzss4JERJo21rBgepTVK5cF8PuUgh/u0AowMf6ceNygb7nsE9cksiU35E20SvgEEzl+4ANAlXYNsQFBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187635; c=relaxed/simple;
	bh=ZiCKUtZKTqw9rKZf/7+lmX/pnv0/DEYvxI7bYI1KMjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oSp/ik+Vx0eDouBzwq4fEZurymct5vFEMkCmR/whm0WUb5IUoJfe5TY2X5AR/twQQonDAgjKTBbTiSG6HDMoVL+8sldWhKjAtuj8oJWk0Wk48YrjyjjczOju/6I8nRTskv9E5U2sZVUvncuSOtPxe4qx2bAG7mMt7T16hg3XFKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vHJ2mU7G; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b9e41669d6so920173f8f.2
        for <linux-spi@vger.kernel.org>; Thu, 14 Aug 2025 09:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755187631; x=1755792431; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V+xkEKCXMOBI9HGuIfKoOfST0QQ0+/qYTKxEDH2g02Q=;
        b=vHJ2mU7GwvoQlMlpsbPU6Vv6TNT4Y/lPihzUyFjol9FtByqq42MxA5ofW2rlNYGE4Y
         9pHF9x/P9kVPpe7GLCMaOUGW9UdT2T5DtXMPAvcUZ1lW4nMnNx2NHUrs48/bmsRM+eEE
         arRAA8y2gaoDzbUKWpA8jWNSffEpmjpfEACh+ezW9/2u8MaNhrppxI+qUkx2gWDyQnu6
         VIXHlxi60+UYxtczXWKtNDXRC0oY45kdUpJKh4dRHZvV6kmUEY+Ok2zuQnUCyT57OKYA
         hf3KFKpiLs5NeHZJ9hNypm8fB5y/Ga3myhx982E2ov/6W2SOzoxsSFZUP/Vp1iKqHAeA
         fcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755187631; x=1755792431;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+xkEKCXMOBI9HGuIfKoOfST0QQ0+/qYTKxEDH2g02Q=;
        b=QGBOdh5wNvx5MJBraCcdRAKFaKAcg/M8HEawn0VFnGApMvXM16Gub8eDuS0b+WhcwF
         MzXwcIf6U+gghA1mObuYUlURJvOwexZv1pbKuPAUxOVc0xxRlW3SALlRm4U3KtWNcRmW
         WpO7o1cY4YCgYFdkSbAqqTQijByiGDi482NVL4Kcucm3xgxocacUj4+lVZBYIsuMiJTN
         VQgEieWWRMUdmFN3onwU0NL+KzJlx0bFAKRZdoLFCIaqldzGpdUDIhkW7dOP08iGfBMW
         u7+efEeoSM1SO2GX2N6RXMFCRQmjttHaaW4jlnYHC4NbQ33o1Tp5iWwYJkfM/uAlAAe3
         3Ldg==
X-Forwarded-Encrypted: i=1; AJvYcCUh1FP7WEL/enPyvxcCPbDS3MFsOqGak7a9/fIFTYwF3azwQkuFmYLRTT2vEifcjhPbYKqlRPIJp8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGWSpTySybQuDiYGQ5vck0KlKEyHnHH267oE1egrHD6xdunN8e
	XcDiBMFYcqldeISx/GmKZfAsc0WHbqCcWGqBKRwhC/1F7aOrBLQPvrPmizLwkSxM44E=
X-Gm-Gg: ASbGncvsVv6xKk/j0XMtzbXNBfkNoYuYksAeykOJEeodjBGFWR/KF3sjbiae1f21yv5
	Z/zCOVCDIkWr4VfoEihjEaNET/CYWht7s3LbVGkJSTOrbzFrNJKb1ZNDpPEOYGjnCxfL4xol3rh
	fFKm0bYeI7gfJ7rPVVGL43cSYtThWanKe0oHO0K6sFw5fyyDOGi0wOujcJ3iBeSNNVvAF4KS6wt
	SbH1AjyL8alwQ01lGqbsnjfl/CLIBTcZT3ZUjuELlCL4AuwG0lODqLf1XdcziQvUdU/VSHWHQGX
	KPjEEyjtP/Bqq68RJYHkTa653BxbnWtV2uW2AYLJI40UYNp7N5YcjI+Bx4sFhy4PDb3tPHE+LnL
	28Xl2r++dGrvBiR5JTomwjnMYNfK3580=
X-Google-Smtp-Source: AGHT+IHnPTemnQhlu4YOUH9ujk8ivLrojbab2xEKJpPhGixHfcJ0gQI64MgagrxrAFS1KKMyz+LVmw==
X-Received: by 2002:a05:6000:22c1:b0:3a4:bfda:1e9 with SMTP id ffacd0b85a97d-3b9edfe4a34mr3391077f8f.46.1755187630845;
        Thu, 14 Aug 2025 09:07:10 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bd172sm28363495e9.6.2025.08.14.09.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:07:10 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 17:06:48 +0100
Subject: [PATCH 08/13] spi: spi-fsl-lpspi: Make prescale erratum a bool
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-nxp-lpspi-v1-8-9586d7815d14@linaro.org>
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
In-Reply-To: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Clark Wang <xiaoning.wang@nxp.com>, Fugang Duan <B38611@freescale.com>, 
 Gao Pan <pandy.gao@nxp.com>, Fugang Duan <fugang.duan@nxp.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Larisa Grigore <larisa.grigore@oss.nxp.com>, 
 Larisa Grigore <larisa.grigore@nxp.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>, 
 Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com
Cc: James Clark <james.clark@linaro.org>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.0

This erratum only ever results in a max value of 1, otherwise the full 3
bits are available. To avoid repeating the same prescale values for
every new device's devdata, make it a bool.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-lpspi.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 332a852b746f..1013d5c994e9 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -96,7 +96,7 @@ static const char * const pincfgs[] = {
 };
 
 struct fsl_lpspi_devtype_data {
-	u8 prescale_max;
+	bool prescale_err : 1;
 };
 
 struct lpspi_config {
@@ -144,13 +144,16 @@ struct fsl_lpspi_data {
 /*
  * ERR051608 fixed or not:
  * https://www.nxp.com/docs/en/errata/i.MX93_1P87f.pdf
+ *
+ * Devices with ERR051608 have a max TCR_PRESCALE value of 1, otherwise the full
+ * 3 bits are available (0-7).
  */
 static const struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
-	.prescale_max = 1,
+	.prescale_err = true,
 };
 
 static const struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
-	.prescale_max = 7,
+	.prescale_err = false,
 };
 
 static const struct of_device_id fsl_lpspi_dt_ids[] = {
@@ -329,12 +332,11 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
 {
 	struct lpspi_config config = fsl_lpspi->config;
 	unsigned int perclk_rate, div;
-	u8 prescale_max;
+	u8 prescale_max = fsl_lpspi->devtype_data->prescale_err ? 1 : 7;
 	u8 prescale;
 	int scldiv;
 
 	perclk_rate = clk_get_rate(fsl_lpspi->clk_per);
-	prescale_max = fsl_lpspi->devtype_data->prescale_max;
 
 	if (!config.speed_hz) {
 		dev_err(fsl_lpspi->dev,

-- 
2.34.1


