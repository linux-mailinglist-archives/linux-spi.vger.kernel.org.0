Return-Path: <linux-spi+bounces-9419-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 548FBB26C02
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 18:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19166176516
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 16:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7BC2571DF;
	Thu, 14 Aug 2025 16:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BfNbBkm+"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773D024EA8D
	for <linux-spi@vger.kernel.org>; Thu, 14 Aug 2025 16:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187627; cv=none; b=tbdkVP8+ZdKyu36d/KO4EuJRv9KQvbdBbn/47wGi+JbCxydq+0qyN83kwVNVYJSiqLbeG2lx3yGxAQRaUvgO4himimQjjAZd/Z2wMCMwlvLv68wN536U2WBDxqHtEWEBKAuUyzsDd3eKGXPxVarPr/BLDVYks6pwjM9wdnUBbsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187627; c=relaxed/simple;
	bh=CLq0x//RJ1+g8/wsiBtMX89qchTr6zzzAuw6KnvXyPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G4AvOjhtFskpNxigWLdQTkB/45nTddZ2XMgBx7tn5YITR0bNUSqUyXmS/xL/mARpcRENwVSCcsN8d72/xbXvHidaFuJWFnxlcIkHu6V+SxpWpm7ReYxT+es1Zc9avpft5TbBXPA9EoAjFdzDiT6D+pp//WsV3Qyfid+0JYbRUvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BfNbBkm+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a1b00e4a1so7447635e9.0
        for <linux-spi@vger.kernel.org>; Thu, 14 Aug 2025 09:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755187624; x=1755792424; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G4vuRjFCf3vC4nZa1AB/3PAeoOAW0nxzKRYHE4PiFcg=;
        b=BfNbBkm+/qP+o+hsycsZUgAJKmo1n5950rHNgCZoNG7Bxm0swDxb296pqAzlQib5/v
         G0QBZ5Vk8qXutb5tAHpQTwv8aYYj1XdWK+3POUzsPBCGLbC6SrTp8Jnzj/JjYQ6ySsmD
         9rFXPONjArHuPbpAAA+q6bLhSQd9h7VYmDIupH50jfZRNSE+hJNrSJWNdhsTCHXWOY/j
         Of4K6SJl+FKCx1yXwVT0dyH9fpTFmwS4Kr/HnsxZOLWdzjNaXSKr+YeIuMSkClhklofA
         ICxgdbJfIrbBMUiPzfoOu3ePUC08itzVNBZfvrk6HA5jRhEGEU2MzzemXv0q+q81+6CC
         pTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755187624; x=1755792424;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4vuRjFCf3vC4nZa1AB/3PAeoOAW0nxzKRYHE4PiFcg=;
        b=klisxH5s787oY5rNvk2v8gqb89dFZ+K/tuU4FypByo60n3vZqr0iWRa18KKgyz2HpA
         yeRo7XZRHx+o3+0cJo+h4GREfeVPMDB70CbVnVXaX/4GKwlvCT1rWfAAfRCUrRE54qI1
         fRKSS0JFIXbYn6RhlUr3gM6FqrA6UlahLxdcPcVzeD7duKvZAUzsDS+Lz+UkfuYkeQdo
         PQ5ar0pBnxAu6imeIURajk4qwymdSzsXkBVf5LMie+VWvm36GuJlPUXdGW11fCDYtTFE
         vBnqDDTihZNfqJjVtGMexGZoI5809MUBV4pvF29rlkhGSV5YNmTdEHGFmvUef7XN1HPO
         K75A==
X-Forwarded-Encrypted: i=1; AJvYcCUBWtqdj5P9XckWfw9f4m5RdAJm1WDP5SnFAr/rIY4V+GMPlqGqLWsalqAbKDUc/7WHaG0TOt8GRZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKNoLW8Vg+2l5WMDQ5+5W58QxyDHE7n3wtKVa0qTs3PSGVIJyk
	abE9QWOtDrDNOkus0IGbM6truMxDRR4u1uCcWO27Zs2nQWsRWC5RDVj0pGarXVqYqYU=
X-Gm-Gg: ASbGnctoKEpCxVXcCzfGizFCtpjnIySg07qI1PiIjpjTg5cofOqDKMmBnJjlWMT8od4
	Djtx1G/UXHuvB2//9w7JwvNmYtNEp9dpffTUiCsTb+W4Z2BMRrVMFtjaCSX/7lVEEzjgES4iqRE
	r3JZvAjp34mfcAtl0r9rTog5CetxD6iV/whPTHV2iW3Y0OOPropVVxhA+YXskPxWVF0sv1F+QC+
	otb+13qhHv4gNKobPsCwAjWF0QxurhylpScj7umjspO8u1fUSYSUvKTG0iWPPkDl+uGUb+6yavn
	/rAe/0AXVnNWLPhHrBCu4CTv+KCJH0d1hNaiLhIoQ8GZccObpf2Jf0V60q5J4d0fccrWoqktS1q
	IRPfM0nBNa+7JjZZmWaDvhBsMgHSn9fk=
X-Google-Smtp-Source: AGHT+IH/+4jZEpKRE7MfihNgsJ2kDCK+C5ucKz6591vTGYsk5Mbo7reqdiCgmL0v7c+F3KACTVzlYA==
X-Received: by 2002:a05:600c:1c97:b0:459:ddd6:1cc7 with SMTP id 5b1f17b1804b1-45a1b597881mr34789795e9.0.1755187623699;
        Thu, 14 Aug 2025 09:07:03 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bd172sm28363495e9.6.2025.08.14.09.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:07:03 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 17:06:42 +0100
Subject: [PATCH 02/13] spi: spi-fsl-lpspi: Set correct chip-select polarity
 bit
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-nxp-lpspi-v1-2-9586d7815d14@linaro.org>
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

From: Larisa Grigore <larisa.grigore@nxp.com>

The driver currently supports multiple chip-selects, but only sets the
polarity for the first one (CS 0). Fix it by setting the PCSPOL bit for
the desired chip-select.

Fixes: 5314987de5e5 ("spi: imx: add lpspi bus driver")
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-lpspi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index d44a23f7d6c1..c65eb6d31ee7 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -70,7 +70,7 @@
 #define DER_TDDE	BIT(0)
 #define CFGR1_PCSCFG	BIT(27)
 #define CFGR1_PINCFG	(BIT(24)|BIT(25))
-#define CFGR1_PCSPOL	BIT(8)
+#define CFGR1_PCSPOL_MASK	GENMASK(11, 8)
 #define CFGR1_NOSTALL	BIT(3)
 #define CFGR1_HOST	BIT(0)
 #define FSR_TXCOUNT	(0xFF)
@@ -425,7 +425,9 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
 	else
 		temp = CFGR1_PINCFG;
 	if (fsl_lpspi->config.mode & SPI_CS_HIGH)
-		temp |= CFGR1_PCSPOL;
+		temp |= FIELD_PREP(CFGR1_PCSPOL_MASK,
+				   BIT(fsl_lpspi->config.chip_select));
+
 	writel(temp, fsl_lpspi->base + IMX7ULP_CFGR1);
 
 	temp = readl(fsl_lpspi->base + IMX7ULP_CR);

-- 
2.34.1


