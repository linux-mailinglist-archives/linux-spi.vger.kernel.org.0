Return-Path: <linux-spi+bounces-8256-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D8EAC0EF6
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 16:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959F550243F
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 14:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FA828F525;
	Thu, 22 May 2025 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zdEcrcjL"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD7428ECDF
	for <linux-spi@vger.kernel.org>; Thu, 22 May 2025 14:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747925582; cv=none; b=X2eqld2CWlcIJ6HZB+p4VLcYcGXj0pbpFpnEBnAa292H5+UoNVzseErgvp8ISbJQjIoPT360qCeLAvM8RGe3iXDBFy3taWSLwGBS24EOX/ztz+KJ9dfg1rrd46UFmNAeUblQ16p3L0dnM/g/RZzAWHp5N2OL9eim4Od2w4qcKYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747925582; c=relaxed/simple;
	bh=6rY5jl63nY3/JfWeYRv5XBTxDAeF2jM1LlH7p8EvP6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Khf+H18vdfDisU4Qk1MSHoTiVcd0NceMKC120GGLeI58eoafkktVpEOi6N13g7SLDaJoHhIa68IbRPbC98hlTHhCFIFdsoSPAxcQgeAGIGhkt/7SjQ9kS/A/MPS4SPgUUB7QGIiWzQaR+JLPgLyDREQNQAFROpypw8inVL9LiMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zdEcrcjL; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so67878265e9.1
        for <linux-spi@vger.kernel.org>; Thu, 22 May 2025 07:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747925579; x=1748530379; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6fk8IPoQziwfYwbuUI7UFNnBkSt01Uwd7OzuOBIvOZw=;
        b=zdEcrcjLIDVb1q2E0q5SEvkG75uin9EpaxQffYUo1UvE6WszSXJnuyAilAS3F+PJW+
         D0ux3yqnMfWTQ94SXrWtOkqEx5XF0+0dSuMd2tUV/K7Xx72beIrJsJLp1cisWLP0sm4M
         GxUaXoHyBOTP+tSltvtXtbkvs7MuX5kco6zn2U7WkUvl8QULsBP9BDepDxGjalNcmXmZ
         AM2RGlIu4llm0FNl0GUsjm1j/o4jK9XzJ9CF8jEV44u3F5BSuqb73lUqlVIdwpooSfam
         yUw+OPFKhsARS1nv0feJ0EWcda7mh4aglWHS5jrSuS7yh7qD1g2h6Sw68Xu7gzlSE1BF
         vnzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747925579; x=1748530379;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fk8IPoQziwfYwbuUI7UFNnBkSt01Uwd7OzuOBIvOZw=;
        b=O5OnG5EP/FOJNisFgcUHLSs6qx75B4mde9Q1vYXBKtrYQTIGFsPFbiWZZgNMTFS9Hv
         icQSEoSiUlxo5rr6K6Pa/1oP7R+NavpSZlyt8AAH1ajrsDiU3vmfyUKzOhr09SZu23s/
         1DODcIF+uhelxC4IBDrup482FLRoHjd+p6Ku8qIBAc7ECgBfnvork/U+oARjtvZrMDH5
         Gru+nA5kDgmO8GbjH/bHwcUzdQrv5q5FUyEmGycsjItfcuAXBcPy4i8Hc+uws04cDo/y
         dhy4hxD2ysxw2pcLi8QpAeU9pB4xQ6pknshstFyTnsejRQ4RRlniX/HRWMW4OpuNyazM
         pElg==
X-Forwarded-Encrypted: i=1; AJvYcCUyKeY6MjqswDH53K0iHt/0CoqzPdWrKHTY20ehFOy/5yIb7G4RQ8TOBkzCRn0p40otZ2pxxSP8pco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsp2Z/P5kelbA4bjxDt87swcdaImCb/uLn38gn4R+NxCYI+uti
	SakbuMCfjQNpSS+fo6O4rn2s6ARgF9k7DQZksHItOLYCFoun0yWhsj4bwuj8tHu95ms=
X-Gm-Gg: ASbGncv0AdcRhUZR4FFut5POdb7/8BVlt+gTEkPmdPzQKP/TvTKNBmv+gHt2BNmGs1L
	7dpSgCiyhtsnwVa5kDBWWtdB1UVWaSR3OEP+64Cihl4D1KENJMVgN0x7RHojuOXXBT8Zw5UKeZi
	uvAMXgBoy5OD4qrQQCIMXehwJ1iSDAIgSf6lP5xXtnQPtMvtWW1R0d6lKRB247OUmsvtmuMg3JO
	mpZTAhpBQ6uoFCB4sjWU6BNjXg+p+r0ISfo8qA59rmq4sIw1+H392EodW/Ui9JW52kAFtg6ou0r
	7maj1Asuiu/Ss6dvoiOCGlHtMY+69FxeFjjmHOOaY0UzQENVcuEUOpRuMerg
X-Google-Smtp-Source: AGHT+IGFpmPzY89cA+sps7xchhXwbvS4hLuhbFCBxUqce+aMcHX4nBXLpUwuU9xg1nYZbcfMggR6Bw==
X-Received: by 2002:a05:600c:530c:b0:442:f4a3:8c5c with SMTP id 5b1f17b1804b1-442fd6272f8mr316774415e9.10.1747925578910;
        Thu, 22 May 2025 07:52:58 -0700 (PDT)
Received: from ho-tower-lan.lan ([37.18.136.128])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f78aeb56sm104965555e9.27.2025.05.22.07.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 07:52:58 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 22 May 2025 15:51:41 +0100
Subject: [PATCH v2 12/14] dt-bindings: spi: dspi: Add S32G support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-james-nxp-spi-v2-12-bea884630cfb@linaro.org>
References: <20250522-james-nxp-spi-v2-0-bea884630cfb@linaro.org>
In-Reply-To: <20250522-james-nxp-spi-v2-0-bea884630cfb@linaro.org>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Chester Lin <chester62515@gmail.com>, Matthias Brugger <mbrugger@suse.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Chao Fu <B44548@freescale.com>, 
 Xiubo Li <Li.Xiubo@freescale.com>, Lukasz Majewski <lukma@denx.de>, 
 linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Ciprian Marian Costea <ciprianmarian.costea@nxp.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Larisa Grigore <larisa.grigore@nxp.com>, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

From: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>

Document S32G compatible strings. 's32g2' and 's32g3' use the same
driver so 's32g2' must follow 's32g3'. The SPI controller supports
target mode when the "spi-slave" flag is used so add an example.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 Documentation/devicetree/bindings/spi/fsl,dspi.yaml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/fsl,dspi.yaml b/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
index 7ca8fceda717..63f4b779a255 100644
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
+    spi@401d4000 {
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


