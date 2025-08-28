Return-Path: <linux-spi+bounces-9688-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5621B3994C
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 12:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 711047B4C3F
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 10:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2D03090E5;
	Thu, 28 Aug 2025 10:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uarylZE7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEB328C5DE
	for <linux-spi@vger.kernel.org>; Thu, 28 Aug 2025 10:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376129; cv=none; b=X2uHhv5P3o8La0ue/lntuW5gkwVdNK8ikkfDOsxNI2oZjyqHUjZzdt5YjLdOBFVnSV8634dp4I7PEn+DtRUnYqSK3iWEH1jgKsyvBgSaggmyAsG5MUtRdsHYoQ48iIIXtfk54QQ/1vxIgcAprXNQiQkyITcipeqKukolg+zZm8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376129; c=relaxed/simple;
	bh=xyKYNfQ/SYdt2+/QXl/uiVJkm+ZD9FCpFhATvHlCaY4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QQqHQQYY8C7/1QxbXwtr+CnQOV0SxEQGf3g/kmk2mrOFfGBiZAtFzPkIUYPVkUb/If2acZ+ngGjV2PwV8a3cOx8IcmOS6lxZlW6Ya2NYHjaqs6B+P891pj8UuRu/5/inHZwF3dOqZljaJMn2VZez7eREBHqo1MkuGaf+fLvE/cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uarylZE7; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45b4d892175so4232265e9.2
        for <linux-spi@vger.kernel.org>; Thu, 28 Aug 2025 03:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756376125; x=1756980925; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GF7goOQZfjJy/n1Nlvaz/a0ipflIe4W5tqv+WNMdl/E=;
        b=uarylZE7asKDXui7KS0hpucZJh0M7GliwSvhiLCeDH1zXNj3rdHbLA8rHXjaTbcQVr
         96rl3XNCNh9Bx5nZBIHcqrnWgHNxDN2Xf3ed16D1SaT1GxD3uUnzEGpn0VkTqgGHlvud
         WR2Hu42VQN12B0oRdYwG28IdN7jSsqJtvFIDclyj+vCqiJlkrIqFEpBxiyG45mS+yuSZ
         fSPMBhHEpt9Gizq4hJulRNa3Xd2p2Yuf/wrhwQULYcj1qVENi8cY8wrFFkl0br/rVgcH
         f1mrswZpSycZfmt9XbmetwkwjgSvX1bJqVVmIo4/t5yK5178uhjxe9piEdJ2xB5ZG5CY
         wo0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376125; x=1756980925;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GF7goOQZfjJy/n1Nlvaz/a0ipflIe4W5tqv+WNMdl/E=;
        b=YzaQuzC/sDqTIDdHzjPB0UH01WFsDKlEtwjNxY4Rvwkem25fXRmc0v4ORuioL9XA1V
         pJxS3PjPFFr8xerengCp09tkMTHt1mXubaob8NcuDf/yUa5ZPBvnKlNoEqfldOmUGQSn
         kSwjO3uQ6iRS8iYL4wPWR1+2J3UaNsYubm+c1UvdBhz+JAxvdZ6GpVRJlw/w3gieOpFP
         hL7N+jp/A/6tQHzthoChK4DP4lCuU4o+gxqOH8NnqLSELFxTBNHqEFaTU0+PcYsnOhLk
         vXNTzBk0ggw4m5Ttw3qDnG67GBkT+SA49PoaHbOFz8SJtmPO1u/ZqPtI1kFehgjkbmkZ
         h8Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWJg6RAIHgSOTw72IIFZy0q8IdDZXOri4QiMiTNEeWxL4iPOpi/ldaA4z5V0wLclJIz6K4O5s5Eq5k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE0h/dGgBfcz+ZLaIJqSMgl1ATVy3YCGFC4ppJ81sV5OXgj7St
	QrHoYUreqW1TkDLSl523UvkGXVDGU+vnJADzJC08mef8woBeROnw7k0RSsWeo0mAMhE=
X-Gm-Gg: ASbGncvoHO0r7UoJSNB7Npx5DkjRU5PJrpU6GsroCRRuh4Ggx5CC2NSstbOH4c0yB1s
	puOFGEnoakYm9GQqJZrj2/v6+Zu+wKGF3dSVgZZggCu7270gKO3MHvk2KLuqUCgndNbwzp8Fp7s
	bfUv5cVQm1uPJuqo3t36xxfOAikke/CAmvP4bVZ1B8D/HyMy6dvXtIO8M0tokA43swRUorWz+oZ
	I7LpBZguJrGv26IrBijNBTwYkRqE9FdFRYFny1jLDvlx2XFlwN8u4JwzcKrloiTE/ZnYeGaIZfJ
	yPOtb6uw6J4KfcPT4xHVU0cu4/m2xECG1I00PYo9PtwpkCiMsUmgE2sTGv1Vw0vR29TXSWleJFO
	eWbKeMjK37o5aC0oatRnEdAnrC+D+m0MPJqAQj4U29Q==
X-Google-Smtp-Source: AGHT+IGEnzU63OfzICnb/K9gMn/j3/S0WtT5qqEXBUUstBaHlJHuR/FdnvKe65O/hXpHlmO922euyg==
X-Received: by 2002:a05:600c:1c17:b0:45b:72a6:4861 with SMTP id 5b1f17b1804b1-45b72a64b3dmr50996335e9.24.1756376125382;
        Thu, 28 Aug 2025 03:15:25 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b66f2041fsm49976305e9.5.2025.08.28.03.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 03:15:25 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 28 Aug 2025 11:14:40 +0100
Subject: [PATCH v2 1/9] spi: spi-fsl-lpspi: Fix transmissions when using
 CONT
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-james-nxp-lpspi-v2-1-6262b9aa9be4@linaro.org>
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

From: Larisa Grigore <larisa.grigore@nxp.com>

Commit 6a130448498c ("spi: lpspi: Fix wrong transmission when don't use
CONT") breaks transmissions when CONT is used. The TDIE interrupt should
not be disabled in all cases. If CONT is used and the TX transfer is not
yet completed yet, but the interrupt handler is called because there are
characters to be received, TDIE is replaced with FCIE. When the transfer
is finally completed, SR_TDF is set but the interrupt handler isn't
called again.

Fixes: 6a130448498c ("spi: lpspi: Fix wrong transmission when don't use CONT")
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-lpspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 313e444a34f3..eaa6bade61a6 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -3,7 +3,7 @@
 // Freescale i.MX7ULP LPSPI driver
 //
 // Copyright 2016 Freescale Semiconductor, Inc.
-// Copyright 2018 NXP Semiconductors
+// Copyright 2018, 2023, 2025 NXP
 
 #include <linux/clk.h>
 #include <linux/completion.h>
@@ -785,7 +785,7 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
 	if (temp_SR & SR_MBF ||
 	    readl(fsl_lpspi->base + IMX7ULP_FSR) & FSR_TXCOUNT) {
 		writel(SR_FCF, fsl_lpspi->base + IMX7ULP_SR);
-		fsl_lpspi_intctrl(fsl_lpspi, IER_FCIE);
+		fsl_lpspi_intctrl(fsl_lpspi, IER_FCIE | (temp_IER & IER_TDIE));
 		return IRQ_HANDLED;
 	}
 

-- 
2.34.1


