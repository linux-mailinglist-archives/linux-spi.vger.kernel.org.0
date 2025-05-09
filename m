Return-Path: <linux-spi+bounces-8024-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1ABAB11AB
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 13:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDC77A01521
	for <lists+linux-spi@lfdr.de>; Fri,  9 May 2025 11:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16F62918F7;
	Fri,  9 May 2025 11:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fHcu4fmR"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2909C2918C6
	for <linux-spi@vger.kernel.org>; Fri,  9 May 2025 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746788834; cv=none; b=tmQ6PLXTEUBUCfgfer11X8OCfc2eh/4u6kpUHrulFdCV3N39fiEWfuMyij0KHSOgfkBHsaUnmcTDwj9kQPonBLoT41g9YteEa3vjsCkztCraCTOcKXg14IvGtwCcg5IZJt8S+oPz9gJ6lTLQpUhH/TThoqxHl+HWFtDen8vkrV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746788834; c=relaxed/simple;
	bh=mx5u03b5TB/f2q1YQ3KCyV5h99vYZyaZPDhhfpjU5fc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XT5UiJzeUqw12YMS3buno0uJ9EhERxuDjql5t8erv2fiTILRgl+aIE+mAfXH1cJM3T2s7HRoRyEYE/0LmDcTYUvaEsfi3uNJky/137EEXqb+k/t7kOY1DsAvXZaDWcaKxjj/6CZbWA/c/CzqXHkUvaMwC7hzMQbRaLSf5kH0jUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fHcu4fmR; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a1d8c0966fso847409f8f.1
        for <linux-spi@vger.kernel.org>; Fri, 09 May 2025 04:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746788831; x=1747393631; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OjvkkMIUxErk/9CbtL8I8hETKTjq9Ni1Xdc4V8HrKQc=;
        b=fHcu4fmRqgAt/OAAqTExKWu9HZrsj8DvarkWF/BhT6M97ZW0V1BX7D69JGD7/I1nkl
         RNVL6qzK3ED43OHgytRW7mbMOSUjBgvY0Ire5N0kizQ1Bq2By9wZ6dHAamnNaS7wSPZe
         XuvemSQoz9jBqV16l3eLeMJznHtNwqxsormH0GC4qKnuC5E3AwBDefN9btpsIapYq2rW
         v+7DWGqrAzhIWaJkxYKQ6so4qjSgDrKNvlpV6LcCFxzCVkOs3DfNaUM5hAYuBrQc6UNF
         Z/EItATDoxhPLF+D/3EZbA+Pu8MWaU7cBHVZFmf8bLUuJ0kQVV84fH2LrRVW7gtS07Kh
         WHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746788831; x=1747393631;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjvkkMIUxErk/9CbtL8I8hETKTjq9Ni1Xdc4V8HrKQc=;
        b=L9uHry1pz+uFcYtfaXzKOM12J09qHVjgehOdEqKrH/e++F+Vkt4+IAxv6m5yvpoMAp
         MZVQTbJgkB657IGP5FwboS4Tu669PYzcQrJNqxOAG1h5jrAlH4AVIIk71lwL7C3mFIK+
         bb8UgUGU9k4QqU/sVgqJeNoqCSVhW3CRXHQoIYRZ44JDnD7TfubzL8doZ9Cmpn7tJ4zx
         /gUMjXBSwlcjUlZhqL9Dsz6CK77cY5jMpzWUJ1onj61PmB2x5o6wWpZuxBKl6vzHyNRT
         gBa1FkYvqg1SctkVcCZz32R41FglwWt8qKEcoZrT15P/OALF4DR68NwARn8SBmVpYiC3
         dUsQ==
X-Gm-Message-State: AOJu0YzLBW5ucWMvSCQImFyOEEY0gb+ZojkfusphlSaqXxpBR8n98WSU
	AZ1ndDYkCrVcT6PUrKDmP9ONOFtH6yHEmYcNm1rM/EkFqaHp/O5nGHoxgv0D7xA=
X-Gm-Gg: ASbGncsFoM4TJcE3QMW7jm0axKVI8zsvenh5PVMT47NSr9Rgb7NaANLfNlqul+ElPel
	xLcrYG7FCYeOj+uimicHF2c64SkYGLu3OiO9fSbP71HB9+JkQ9k7W9AMrY67+hW/lzkfjAKtQlW
	lfrVnRCaYd5g3O1WV+KthnABI9sa0hD6XvDHyqU1BtZHPPNSvLK9RWyzmHxLuFJ0DX7UiKJNZVs
	w3j5MBIQaA7BtsvjM6jgPJ7Rn7lCHANmYi/6SOyoqx7mwN0fze1BZCM9wx8Pyf/+7kiKg/N40iW
	GmNp1r+pxa488vGVeI+D2RfoFwj/qCZ71Tsq+n842w58mbA=
X-Google-Smtp-Source: AGHT+IGJvDt+LaY1QQLl2SlTRe/DojIZ4tpeJAXa/uWwNzG6xIzfPYcQgejyyHruKfc7448qtaeZfA==
X-Received: by 2002:a05:6000:228a:b0:3a0:b8ba:849f with SMTP id ffacd0b85a97d-3a1f6a0fc42mr2727736f8f.4.1746788831370;
        Fri, 09 May 2025 04:07:11 -0700 (PDT)
Received: from ho-tower-lan.lan ([77.81.75.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ecadfsm2914797f8f.22.2025.05.09.04.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 04:07:11 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Fri, 09 May 2025 12:05:59 +0100
Subject: [PATCH 12/14] dt-bindings: spi: dspi: Add S32G support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-james-nxp-spi-v1-12-32bfcd2fea11@linaro.org>
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
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

From: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>

Document S32G compatible strings. 's32g2' and 's32g3' use the same
driver so 's32g2' must follow 's32g3'.

The SPI controller node in dts can define both host and target pinctrl.
The selection between them will be done based on pinctrl-names. The
default pinctrl will be loaded first and will be used by the host. If
the controller is configured as target (spi-slave property is added in
the dts node), the driver will look for the "slave" pinctrl and apply it
if found.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 Documentation/devicetree/bindings/spi/fsl,dspi.yaml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/fsl,dspi.yaml b/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
index 7ca8fceda717..b5fac0bb142a 100644
--- a/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
+++ b/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
@@ -23,6 +23,7 @@ properties:
           - fsl,ls2080a-dspi
           - fsl,ls2085a-dspi
           - fsl,lx2160a-dspi
+          - nxp,s32g2-dspi
       - items:
           - enum:
               - fsl,ls1012a-dspi
@@ -37,6 +38,9 @@ properties:
       - items:
           - const: fsl,lx2160a-dspi
           - const: fsl,ls2085a-dspi
+      - items:
+          - const: nxp,s32g3-dspi
+          - const: nxp,s32g2-dspi
 
   reg:
     maxItems: 1
@@ -114,3 +118,17 @@ examples:
                 spi-cs-hold-delay-ns = <50>;
         };
     };
+  # S32G3 in target mode
+  - |
+    spi0: spi@401d4000 {
+        compatible = "nxp,s32g3-dspi", "nxp,s32g2-dspi";
+        reg = <0x401d4000 0x1000>;
+        interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks 26>;
+        clock-names = "dspi";
+        spi-num-chipselects = <8>;
+        bus-num = <0>;
+        dmas = <&edma0 0 7>, <&edma0 0 8>;
+        dma-names = "tx", "rx";
+        spi-slave;
+    };

-- 
2.34.1


