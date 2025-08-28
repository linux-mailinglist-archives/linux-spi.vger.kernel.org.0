Return-Path: <linux-spi+bounces-9692-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7FBB39965
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 12:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 513647B8B06
	for <lists+linux-spi@lfdr.de>; Thu, 28 Aug 2025 10:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D25A30BF59;
	Thu, 28 Aug 2025 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RXSFrqG6"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F7930AD07
	for <linux-spi@vger.kernel.org>; Thu, 28 Aug 2025 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376136; cv=none; b=lraXM7E9nXA8htgvLKtzigyY/bDQrrgQn0MdY/IiuuMRnUUMiMaLtuwTbeDOYv96P2kjegqF6FiAvvVg+xKBs3CO1bIxHOFaLm3XDyWRGQDWAdS7goa8hfp3/34XGfDBZuPw+KyuC6hzbOukPw9mevAISWvGjNZBElOw/hMWkOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376136; c=relaxed/simple;
	bh=7zIHfbYuxqEFfC5pFIBPbouxdTNkb8pQDDivm5vTvI8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LZViIxzVAB2PqQvS75sXPjIhLo8xbIbgEzUiooDdwHy+ZGP6CiEsaTYvRC5hdEHY1so0oJPOBp7DzbjNjA8hbTpAJ+20M+XVM30cyg32Sf5CcX93CkjEE5dQcVYmGDrzH7imUesqtYhh59FXKx5jaCMI0p3OLVeCmEfetDd6pWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RXSFrqG6; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1b0c82eeso6241455e9.3
        for <linux-spi@vger.kernel.org>; Thu, 28 Aug 2025 03:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756376132; x=1756980932; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RXANAbHwVPpe4jvCbblWLvMrGtujuwItYgIeQizTWw0=;
        b=RXSFrqG63v0tW5+XFFP93cFaQyBkCapRgzRiloOe110h1qjdJtJqwJ7scAhdN/7XjW
         At2rum7GpouDErbmuhyiQC0fpXqQ+04uSOvvSLxQpQkGo2KNsrEfPMDslxSIC84cxm4c
         SMcuT5mOjiZWpTlgOjMeQfWGXFww1Mag2hzEBoK08ZYdenIJGL+QwahMRi0sA6b5VN1H
         zEJfuBDa9PS9qg3u1kEKuV4+kKZEeOp/pHrB9GWcdPGPC7zf/vQNPL+bZbZJ4tIO9daj
         TBBd1lbJAn9NOMT3zSzjOTLmf3n47Rkwl+LXgtlCobK/l4GAqzPjmIuhhzOBG7GPfuVT
         f9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376133; x=1756980933;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXANAbHwVPpe4jvCbblWLvMrGtujuwItYgIeQizTWw0=;
        b=BJ0ncRGAMqMr3cAmd/VongPIx9In1+r68MgAKRspglutamFvwhuOMRbVxjVhIuG4EB
         XceZTlmA480h7HoPYTlmnk7x0Y7GLXaQJ140qfMGsbiQ3Rz+ddHAflnDQr984iP+kASX
         l0L0NKj7m/vzwSbh5H6K6OSoNDhWP7kNGHtaElZVsJc666kVsGB3jbtbo2mgi/m5WmvT
         r/zPTTHKInMthRLlJUKAfVbgiwA0PHQdfvfNw2Hsxy+lTWUYz766emMBIoaKiGnJyM5c
         44odNzoYz9wiiwJPKplLYqtf8SfdD6/rlDdUoMnFFlHodE/RquQnpk5vzHEpWoth8RnW
         sjig==
X-Forwarded-Encrypted: i=1; AJvYcCU0z20QMgBW96eVHDUAgtrmkIB+hrXsHmRWLBM0rR20nW9Ya+UCVIx2l0MxjfGfcBdw6U0IRNoWeCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZW76u/jbL3/d2h3UXH3ysuAznWO4uPUW4Wlv/eQE5+n8DCV+n
	utOdPhc7AIyv3HsfQVcLP6jimkY343k3YhbGJ0R/5CF5NbobRZdgMYrlFyrJ2hUnUcs=
X-Gm-Gg: ASbGnctFnyBNuqEoEsGBpsFRlh384MVdCt0XnyLR2xXVw3Zl14ajjxlr17/n5wICGth
	t/3cbIr0khtE9Tg/IQbbO4rCqfUopjexU2WRO/1htOL1BF2GnIi9V5baVCLrHi579E5a3HKSsl0
	aQQDOtbOZiFnHs1imqYFlGm7n5T2bbEXadpMT0HOsSufJ2AlMh2YGmV2HXhH0nT9gOWogcm1538
	XX9qqkin1YHpHRwr96tHECYiQ27iG3QetDhKTkQpYhDVAlgz4cbumetSyIzvhXTHeZHKSShQS34
	qRFYxRpUj7hh2Q2R2glIjaOM5KTlCc1H6F24PxjuX46o1y1u4OuErs6CxLd1LyWrw6BtNh9uHP4
	KRCYW+D8GC6V0/CqhP3BmP5WH50HKC/M=
X-Google-Smtp-Source: AGHT+IEPuV+SVBjgix8/NEPnZ8nglpuTYsTPM2vPoIioxa72GpCO8DZr4EiqG2j2YOqQDR084wp4Tg==
X-Received: by 2002:a05:6000:18ad:b0:3b7:948a:1361 with SMTP id ffacd0b85a97d-3c5da741330mr16413826f8f.6.1756376132441;
        Thu, 28 Aug 2025 03:15:32 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b66f2041fsm49976305e9.5.2025.08.28.03.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 03:15:31 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 28 Aug 2025 11:14:44 +0100
Subject: [PATCH v2 5/9] dt-bindings: lpspi: Document support for S32G
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-james-nxp-lpspi-v2-5-6262b9aa9be4@linaro.org>
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

Add compatible strings 'nxp,s32g2-lpspi' and 'nxp,s32g3-lpspi' for S32G2
and S32G3. Require nxp,s32g3-lpspi to fallback to nxp,s32g2-lpspi since
they are currently compatible.

Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
index a65a42ccaafe..a82360bed188 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
@@ -20,6 +20,7 @@ properties:
       - enum:
           - fsl,imx7ulp-spi
           - fsl,imx8qxp-spi
+          - nxp,s32g2-lpspi
       - items:
           - enum:
               - fsl,imx8ulp-spi
@@ -27,6 +28,10 @@ properties:
               - fsl,imx94-spi
               - fsl,imx95-spi
           - const: fsl,imx7ulp-spi
+      - items:
+          - const: nxp,s32g3-lpspi
+          - const: nxp,s32g2-lpspi
+
   reg:
     maxItems: 1
 

-- 
2.34.1


