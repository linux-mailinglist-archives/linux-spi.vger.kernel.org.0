Return-Path: <linux-spi+bounces-9429-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BC9B26C2E
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 18:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE4A716B97B
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 16:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAA4305E29;
	Thu, 14 Aug 2025 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IjbXN+IY"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEF22566E9
	for <linux-spi@vger.kernel.org>; Thu, 14 Aug 2025 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187639; cv=none; b=SihYNhlQ3doXxJu85ns0konG+T1JHNKPeG6EUZs9VEnFKlqr98Kq0mB6cfKpgBBBGC33O4JuvHOiciPLYSmyRHUpvQglhxve7ncH429bkactRUvGvERYV+Z6YAe93Pjfp7WfEWsbbZ9cdjj9cpR7T6k6C9KTOqVgcqfIQ8k6F0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187639; c=relaxed/simple;
	bh=+rq+9BGDr8wJ7iR/RwIfiOewQa5sKFiC9C2659q5u04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VNo5wmRIzQ3AqSEBpu7mawuI4yceJLUeGIT0uVks/+QbaFELEJapwp+PlLHknGzmZ+CKpvVlybkIKA/h1vUfVP9mKQPUeXKXX0iN8ci4CalHgkLjHIP4GWFSJMkKRpCNLP5IuZ77TzyCGD8Els73Fm5XrsSwI9HwyCSYtZ1ulIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IjbXN+IY; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1b004954so7939205e9.0
        for <linux-spi@vger.kernel.org>; Thu, 14 Aug 2025 09:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755187636; x=1755792436; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DdsFgMvzLev3pjfqMcBF4MpZ0JDQWqKgzuICi66wU9g=;
        b=IjbXN+IYqeYBNZdqhxXrQUSAT7XYY/KjSN25ICMHW/uBv8+Pr9s1+oW8bw+iqj27BU
         4ntem6jamDJNDSPdvsoheJavAOW+4Pw3nJr2wPtQ5rqtzXkH82Gyk6Hxn3yfzY+0KHUq
         LxQeHWl5DlcKg5wCm2PCZq8a7nIeIXvBjKCr202c0jBp/JxaLTeJzEBBSMKYPwiF+rC8
         54RL7T2ilR6jSKkUnTACIB1V2KbdwtVNAFHKLymWqa3Ra2ZFRP8q926O/m/CPFj3VuG1
         3dhw3dA5Q3dpOh/eyaUFYy5a7WxVg2GDQP7NMYAa25L5Z8JDIG16LdfuSHsyLqg/Rb+r
         rA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755187636; x=1755792436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdsFgMvzLev3pjfqMcBF4MpZ0JDQWqKgzuICi66wU9g=;
        b=rkUIzpmR5R35gmuZLIj8QVbBVSlpkQkOF/X2TgzKGsUC6JBuMgcUKWpMjY0x622yXT
         WN0GFkSuXnJq+miiL/wdn/aOvhtXzzq8+eTiVNrCpiIsv+wWZO8oGGl0MODxeYYSGwim
         SjQq72q1aN0E9SzIlosCZU1O3Kt5DcNwB7rYHpPMTazDYb+ptsvdVKbRQXQQmQoUeMmS
         F6mRlpUXEaEMkZU9MnRw6b053K4bl1oPUuB3YEJdRXiESVSRj9hxkPyHdzdNGTTNZmjM
         L0y6M1/lHyBftUgqPp1V6772W5oqckF9Q+EnrSkIrwFIgZIFfrRgwso8adOupX9fbVw8
         dcqw==
X-Forwarded-Encrypted: i=1; AJvYcCUNofr5eno+/CbcZwFQg9E1FfpxxXlNQya6furJ15xYw92ytKz881DoIr3H5BMeHBHVycXwzTt18LU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzndrGlBAuVmwxvK4vmnA2cWzYXNQJmVZi3VGf42aaBRJO4NgN/
	QGtOAOsNt8ryiKwfVPNG8GDPSiXNFegaYc9vF6yfAAN2ZY96NIQv2YmyO8owpOhq0Ps7A86InSs
	eh3IE
X-Gm-Gg: ASbGncu/qhd74M7aupPi5jn4GG2sjVO1eHyPXFidl/v1ltg2r5LeBKhuaOjo0yKKmjn
	C6gOV9GPoZpWIn38KdDCPtCC2k9DyfpqBFMiz4tsuxhJVH5KNxTvfHCUVtMmt/zk/JZfjFUf1rl
	qJYrVKDZl8sw+e73xyxXEj5dOKwlDXShK0RGIXjsRUYlOHxJNMZRp1Va4aEsDyev/C3jQTX8kAd
	6sZFvECCETjVBPNfIzh0BGOgRkdW6Dz5oeT4j9m2ZDS8R8m2SsJrQ91cGxyGRwkAw5Zf/xDKrKF
	LH3P7dSWkAnOfZ1uPloCURA96rT6nVs7+54fV9IPUZzrPmVHCIMcv21gPnhk//EZ9GaRfFEvJX1
	a9BkavkK2r71G9SOrGhwE+fR2idd86P0=
X-Google-Smtp-Source: AGHT+IHYk5C7hCYyM8ADnaIqffGtiumP8f9Dmz3RPTAWKY3pFIZH3LXw+Mpypp1GBsMLsBv+UgnJRA==
X-Received: by 2002:a05:600c:8b4b:b0:456:1006:5418 with SMTP id 5b1f17b1804b1-45a1b61eaf8mr35450955e9.13.1755187635781;
        Thu, 14 Aug 2025 09:07:15 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bd172sm28363495e9.6.2025.08.14.09.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:07:15 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 17:06:52 +0100
Subject: [PATCH 12/13] dt-bindings: lpspi: Document nxp,lpspi-pincfg
 property
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-nxp-lpspi-v1-12-9586d7815d14@linaro.org>
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

Document the two valid pincfg values and the defaults.

Although the hardware supports two more values for half-duplex modes,
the driver doesn't support them so don't document them.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
index ce7bd44ee17e..3f8833911807 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
@@ -70,6 +70,19 @@ properties:
   power-domains:
     maxItems: 1
 
+  nxp,pincfg:
+    description:
+      'Pin configuration value for CFGR1.PINCFG.
+        - "sin-in-sout-out": SIN is used for input data and SOUT is used for
+                             output data
+        - "sout-in-sin-out": SOUT is used for input data and SIN is used for
+                             output data
+      If no value is specified then the default is "sin-in-sout-out" for host
+      mode and "sout-in-sin-out" for target mode.'
+    enum:
+      - sin-in-sout-out
+      - sout-in-sin-out
+
 required:
   - compatible
   - reg
@@ -95,4 +108,5 @@ examples:
         spi-slave;
         fsl,spi-only-use-cs1-sel;
         num-cs = <2>;
+        nxp,pincfg = "sout-in-sin-out";
     };

-- 
2.34.1


