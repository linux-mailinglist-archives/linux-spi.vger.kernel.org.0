Return-Path: <linux-spi+bounces-9695-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B29DCB3996D
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 12:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C1F27B9523
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 10:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D8230DD08;
	Thu, 28 Aug 2025 10:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tSyTYhid"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D9430C61A
	for <linux-spi@vger.kernel.org>; Thu, 28 Aug 2025 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376141; cv=none; b=hA/jzbdyL1IVUIyaNfmrKkCkrb1gHPNWL/JAReeBADuw773MXut645ZAZsBfDt5OQ0Tp/63TMyVzfoB1eLFszthnqDPmCDpf2RiZ8Ns6VchcpdUTZ/laYDoJiOsjTZrhWkP/c5MaEuSoRUn1fzN0bpFDqTUpODh7ThpT16I0iRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376141; c=relaxed/simple;
	bh=DUL2bJxMgqW72KZYcQEl8qxFnW9WLPKvK26PzfIBBY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oU6ign1460vi7aMMXflrT7FOb3pRjtd/SQlRRrJJCj754l9xdU93fbHhlO0Ysny3q327kqsCVOqavlQ+Cr1MpmWHl/RU0ZelF6pB16dGi02b0ouocN6RXPriXP80ZY8MgYOWoY8gpbUHw2BB92vfzdrrWEdab+0kX8kCQZNPwog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tSyTYhid; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b7d485204so885365e9.0
        for <linux-spi@vger.kernel.org>; Thu, 28 Aug 2025 03:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756376138; x=1756980938; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=twA1DevhQnABtZ7AE3O2A15G4iJ3iu3xsP8XB6FKzM0=;
        b=tSyTYhidMOzscF1BAM66qYXkPc90dpsBNNjpTd5TC4ZG2BD44fnC5EXUVS/k/aGAd6
         6NXxjo/C4wxVeWZBfzkDlfiAWDZrvtLiv37zagEBfOUsrbWjenH4Zm3C+Ojr80BJLejE
         BWdCjvrAsyE24iDOCzkwDd4j9DqYIHH55lK3UHQBEtb5txa8xSfiFYEzB1o8StDOtBVT
         TL+OX9lOiMtDOkWPCntnUJBvd0UrHe083Um90CpFKPAgBuIzrtUUbAbWXAg3JmSh8eLV
         nqsXu2qwUAGWlkZxwS+c6STFNl8TENruNVGX8LUwdiQGljQKxj43rKgfrCS8lY39E3+Y
         SGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376138; x=1756980938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twA1DevhQnABtZ7AE3O2A15G4iJ3iu3xsP8XB6FKzM0=;
        b=Ma/yqvTTtP/YzU0Rl+7Kg+5j4vdESgJNgvF9LszMCfGehirvDPSWJs667zD/u6y5KF
         Uvf8Gb+cZSrcajq9aS2RUenzDVVOaOIiu4VAka4iaOfJIEKHW1mABQr+O4ySMAGWv6A6
         oxhEpu3eUpuy7J9efkzwQQJzBvP+yWeSq/tbnLxjSdT7mpJ5OhjlaT0Q1TRXbXP+Ra5q
         3NhdxbmHZ45akhMwGvWiodCXGXSS7RpRIdrZtl/SgbUPDMfXfeXJLO5zipPUaauTKdqA
         9HG2/E0fft0IldhPR150gJzbbSRBFf2shOkmDLivwNkihOSeldT64c1eR3NJ6LpndhYc
         ma+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9PBFxDIHSjCsB5T/qcn33ALJc7xq4ke4InC7PXgaHNQmhejwRmEnZyILq3aYZvsyvrp70euMzzgg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU0aykYjdgWl5ii/QDGqDcZe4Z62tYL0eI04UesCYNsnEC/zKR
	RFicdM6V8LcdMiBPXfoSuhMNU4vdwaDbHarqvj1+d6VZpAt26Je84O8mJmXDR0NDnPA=
X-Gm-Gg: ASbGncv2UYdRij9Fy2R8qHYPxALEi8yNPNyC4Ue3VICVOxPg1Dv5vlVkrdWuE6LhrRo
	W8EQy337v4zGf3Z1JnPr781vS9R2lft8Vaf9syKowWuQ0nTG4h+jq1L4LhDxkTueTs/PriOG3ua
	uoo+j0Q1F00ifG36ZN1tpS3tS8K7rxQdfp4K+sVFElDPXix/q0Zz/6dhCdUpRWgO8/0VTlBhSd6
	KCZ4YQ+IROkx8CWioxL6ZIYvCk3fmg447QDDFVQ2ntInzSysi2nctpdR9Z+mYe8G9quocAwSsc9
	LLRjit5gnvfhlXcENBZbCz43rrYZkxYxXeguPLa909cnL6wRKcLeglzGyAp0mlKgk8LlsFGDAzg
	bLf0Tu9lIAscBU6TN7My0r/PS8S6Z/Zawyy/Dn0zz9Q==
X-Google-Smtp-Source: AGHT+IGnwrpzezgJXIVPIURZAHVNyOiUW87JNySJUaEe/V4TYWQ5vU2ILUn3A5NCE2JjHClrcg+0dA==
X-Received: by 2002:a05:600c:1389:b0:455:f59e:fd9b with SMTP id 5b1f17b1804b1-45b517c584cmr224745325e9.24.1756376137717;
        Thu, 28 Aug 2025 03:15:37 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b66f2041fsm49976305e9.5.2025.08.28.03.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 03:15:37 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 28 Aug 2025 11:14:47 +0100
Subject: [PATCH v2 8/9] spi: spi-fsl-lpspi: Parameterize reading num-cs
 from hardware
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-james-nxp-lpspi-v2-8-6262b9aa9be4@linaro.org>
References: <20250828-james-nxp-lpspi-v2-0-6262b9aa9be4@linaro.org>
In-Reply-To: <20250828-james-nxp-lpspi-v2-0-6262b9aa9be4@linaro.org>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Clark Wang <xiaoning.wang@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
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

Add query_hw_for_num_cs in devtype to avoid directly checking compatible
string "fsl,imx93-spi".

No functionality change.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-lpspi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index ea25e8dab0a4..ce347cdbb009 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -87,6 +87,7 @@
 
 struct fsl_lpspi_devtype_data {
 	u8 prescale_max : 3; /* 0 == no limit */
+	bool query_hw_for_num_cs : 1;
 };
 
 struct lpspi_config {
@@ -137,6 +138,7 @@ struct fsl_lpspi_data {
  */
 static const struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
 	.prescale_max = 1,
+	.query_hw_for_num_cs = true,
 };
 
 static const struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
@@ -932,7 +934,7 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
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


