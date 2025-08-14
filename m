Return-Path: <linux-spi+bounces-9426-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E170BB26BFC
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 18:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83091188AC03
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 16:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF80A3019C0;
	Thu, 14 Aug 2025 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OpxXIH6W"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EAB2FDC23
	for <linux-spi@vger.kernel.org>; Thu, 14 Aug 2025 16:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187635; cv=none; b=YM8AbEQA+9M3c/dY2gVSDybw+2532KpxeerNMEoNDNapXEZRnRShKsTLepDAA1Ruf58jrd7F9/kvtzT67UYrZcAyuZc5YJFo7JNTSdf5quLLWNOtK4ncp8KZzbdFX/v1E5LV9wARIrTHRfKtU/+nhMQe8SDRpyazdls+L91XKls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187635; c=relaxed/simple;
	bh=nLKgSvSgI7gDUsnC9ALIo8slGJAiPfy5nla9VR+CXBY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Le9TUCc7694wes4gXdYPZnoimA+tSNl+oDAdAvKoeFWNOw1xKYXqijSrBOAVigPJDMIoi6JFTt7te/c8RkIqPJFVph/Y7R6VfLmttg/vYbMsYrkKsz/YIu0OqkknwxeUZKiVlDQPeQLg0JUd8pR9NK5h8W7AXGq/p+dVa68qQ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OpxXIH6W; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b05d252so6931045e9.1
        for <linux-spi@vger.kernel.org>; Thu, 14 Aug 2025 09:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755187632; x=1755792432; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4uUiAWgIv/rr4bdczjmXB0zM0zB+f4UfZqA/MDFkyEc=;
        b=OpxXIH6WnOgr9w2Rx+EIqSUiQTFtBf17ypM/jrVrZLCfamNvsf5mLZB9E3i9bGkUXy
         FZU97LRnAnJ6DbtOjjqW+hjq1D8a1qlCJStxsngTISkQJboYcY6lYoMOfVBi0dMVrR/o
         dYFXU+LNZMBDf7RH2F5ZjjLiGVyg3YWLgnEejCaG1Ewa1Y0cK18I34Jml5r5kXVISgTp
         v6kXwt6l64/2l5zilVq5nADsP1yR8BES5Ch027v+j+r7dgrvv+uDckfvSXBrWp1xM/RY
         Ido3qNvhqJrpbRcug3VZPm2kYV4Sbta6c7c/kCGPWqK8Zmmk6q+bIhuS1KUmoTCaVRji
         E8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755187632; x=1755792432;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uUiAWgIv/rr4bdczjmXB0zM0zB+f4UfZqA/MDFkyEc=;
        b=ww1/czM0e3y/ewdIF0SmKogImprcR/1Tbm2oYmmnZoMc4wxLCiW2gk8yNd0+VId0gm
         JbEsNeT2dqslR6qoeBa0K6DV2nAIaPbeDrMzVOjmHCxEBFIMTuF4zguJ9UXCDpSA+Tn/
         dkaUEsjE91Zju3AeRpO89VMjweYaK7pvsYVQEPUbLwDGx4S4cKCCT1Djqt/v8mQL53ip
         dA8/Y3l3CGZEgVgiWTG0w2XP+FsnWk21q85XDtwjyTtt+kdJBSeB0wt6qUjEgxua1Wsb
         vZ9dz3TVLrGkcdD22vW6mqphzTWH3Q0IjStxarynKYXM/q91yY6y6v1zuyKK9mTOdK5v
         dAdA==
X-Forwarded-Encrypted: i=1; AJvYcCUfarTJxMAqL8XtdWPNk5TBjxiG+qp2Zp/h6eimlEjOb2T8T6GD837/M61sr1UNWx+o8AArVjFbNa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwCMfFueBLYHY0kkaE3h8UinQ06exAC3U3ewMwPZ8zlPL7PCtb
	RRKOmOYNYQMa8LWV8g6VjXvDI1SytwKI/18Ni4/OCo1A490IHCVYdHbD7rTO8c/+D7E=
X-Gm-Gg: ASbGnctFXJc5EOpuiOg//+DOcqX/ropEYzcnuUaRQ5b5l1fnbwAFTlzaGa8X/rih8L0
	UsH0s/QIDwjgy7iYT642+l5CPzIJ+F5ek5uXPwiBBh+qh9FnlB9NkJYVSeGwIBnchgNZjmP0gzb
	cq/diI2XCmnz+UdWornNG/9B93t16YzxL/ijyB8kEcpf7VTakFA27Xq8vdwqLTpXTy40Yoz1SIO
	L++oZg6WTtZRKubWk408zxIImnij3suwYDr+m5opKiZJ7fooB7ZaJQ8LTB4WZqxps1pRaNVjzV4
	y0B2y+7T2SK2mjFR5i2XmOlFdxdyoNZorAy3ikuCu3yZMdZHVziQCKXw5VjyRnJqDruvfF6mM/2
	Ns9nTqlBVnEccxcPzOE4Rw/YGOwS6jMk=
X-Google-Smtp-Source: AGHT+IFZZ/SClwkyS/5PD0FX0+0seHog/otwGwC9/uLDftMPrJiGWVG1n+A33cLiR0ff/m9sgu3Qog==
X-Received: by 2002:a05:600c:35d3:b0:459:da76:d7aa with SMTP id 5b1f17b1804b1-45a1b6758a4mr27865565e9.25.1755187631973;
        Thu, 14 Aug 2025 09:07:11 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bd172sm28363495e9.6.2025.08.14.09.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:07:11 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 17:06:49 +0100
Subject: [PATCH 09/13] spi: spi-fsl-lpspi: Parameterize reading num-cs from
 hardware
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-nxp-lpspi-v1-9-9586d7815d14@linaro.org>
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

To avoid adding more string matching here for every new device, move
this property into devtype data.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-lpspi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 1013d5c994e9..6d0138b27785 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -97,6 +97,7 @@ static const char * const pincfgs[] = {
 
 struct fsl_lpspi_devtype_data {
 	bool prescale_err : 1;
+	bool query_hw_for_num_cs : 1;
 };
 
 struct lpspi_config {
@@ -150,10 +151,12 @@ struct fsl_lpspi_data {
  */
 static const struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
 	.prescale_err = true,
+	.query_hw_for_num_cs = true,
 };
 
 static const struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
 	.prescale_err = false,
+	.query_hw_for_num_cs = false,
 };
 
 static const struct of_device_id fsl_lpspi_dt_ids[] = {
@@ -960,7 +963,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	fsl_lpspi->rxfifosize = 1 << ((temp >> 8) & 0x0f);
 	if (of_property_read_u32((&pdev->dev)->of_node, "num-cs",
 				 &num_cs)) {
-		if (of_device_is_compatible(pdev->dev.of_node, "fsl,imx93-spi"))
+		if (devtype_data->query_hw_for_num_cs)
 			num_cs = ((temp >> 16) & 0xf);
 		else
 			num_cs = 1;

-- 
2.34.1


