Return-Path: <linux-spi+bounces-6032-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 147019ED7C9
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 21:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 425CF280EBE
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 20:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68E5237FCD;
	Wed, 11 Dec 2024 20:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="hE7GtBCl"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D10238E10
	for <linux-spi@vger.kernel.org>; Wed, 11 Dec 2024 20:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733950523; cv=none; b=hxVniyhuBmeXSw3f4FOA/a5UuuAqtXJNsTU9AlPK+6XI9fu1rp0HgXc7agRWCj2e3Z5Pu4ex1v0E2Sqm+IM6OHSnMtz0zZcgxRtI1FA528POgsolC7GqpQl2Tt0LiqE73kNcabWYAcQ+si1zru0Um6ngMVy2WRHShpjFZo01SbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733950523; c=relaxed/simple;
	bh=PTJfYKdBGpwH9pcTz0bvWoTFNmHgjQKdz5cWv2rkdwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WXU3X3oACLpTw0Uwp34YiC/fQ9LE2jWVd8c94YsBlKVJxuU6n1l0SKOClZ5ViPId90NRhPUkRGx27MCRwRgbAkpvIkFQ40MZmTj/7yxnOGB8sC56UavKV/EaYeCQj4EtoISmauQ8rq161zxv9E6n5I+Mum6mhxbn4zug9Rb3Pu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=hE7GtBCl; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-71e0351311eso726242a34.1
        for <linux-spi@vger.kernel.org>; Wed, 11 Dec 2024 12:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733950521; x=1734555321; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/dUWQVk2bfRYwGLIDUzweNbNW5RzAk7U0S7NeccQg/Q=;
        b=hE7GtBClNq/kw+XuIX8ycI0KuWSRElaI+voBscq3k0dlbc4UBGv12gkFh6I/6vgi90
         VWeQs9iHMBgHG2aszAoriBSmSSBvW0DXUYuxNWeW19OBOvxem0yisIx2eBphiV3UTd2X
         vmuP7fu3Y9ukohy5xxAadfdJjaSAi1NsGr/kL5xhaljVEVE+jkz0qqxAqL05EX4YR6WH
         c6e6htLbdY6RchSLILGgQl3q3t6vPnfzufuIZhTizFh0jCzUrZQM2Iau6Pzkc1CScjDL
         wHC/qXysW2X2SIcVPKhrl7N/FWWdxF0tXOD+OnO5d3lHFWgt9gSrjIOvsRtD0vlXQsCX
         /0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733950521; x=1734555321;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dUWQVk2bfRYwGLIDUzweNbNW5RzAk7U0S7NeccQg/Q=;
        b=Oa0zWiMn5Ws/fvuci0woFJBE1HM/WB8wmRfT+oPJiCdMsaCCHFkHuRAahyyE87CGt4
         ug6xvqKI4h8+V5cW7sdggc2Z9eTjBQDtLQKJ6tzwmENS8yagWsuIX4reg0cyoZpj8PLI
         qpAH2K82n0Ikd7SwGxpQhwU+GgAlCgxeS280byPhXTj531J7bJH4D4nKepOGkbSKx/NA
         Ubgf/87cuwhFSchvbhBN31KCveyN/450IcKb6qVY5yPv+jkt1Q7HzN80PmHsPAomQ5MU
         JB0xkbbjgrz9cSo50s7NrAQDEEbT3CEmgaOwYwVj9W0aM2vmsRxFjnpQ97+ORoerbKyc
         Jlog==
X-Forwarded-Encrypted: i=1; AJvYcCWC7+vZzSr/5uNCUxE9JrjUDadg9kRCooQRpyPjh7MUm74O68nYHvivO/oUToG9PkAlwQFI61U0nnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrtIZLR4pojgyEi7/sgicjkBllfID/fL0Cjk+8LqBRqN4e20Oq
	8q5TDVHqRZRwqBZ32h4RY/DlnKK1adSDHvvyQZYtlLRmaUG1nGpGUWHjSQuoQAE=
X-Gm-Gg: ASbGncvn/Bl+pxM9Qi6hQAwgm+b9Pc6R4Ieq0HmRI+gS1+aCemN+WUP3eG9Zn2MSrTs
	hP6is4BNTVuEoIjR1L7Livg5o+S0SmTIW1mwn190JOFBnWXbqbi8HrcOTEdzgLEqSmOtrPXx+AI
	4dTKNkwbpiFgZ2hooHpRLm3jXA3O/97Qg8njE/7kKqhopSarLc536135lcuIJCLXsXGU06O01lQ
	47O1rsaeucSYIeCBcs7tyMmNkrkw0OJef5ij6jp5X86S00FW2slPPKf2n193FBSRTMXndYo2yKS
	3gzeEB8bWQ==
X-Google-Smtp-Source: AGHT+IFkwqE9NeuzPSJABYVR8sPjY32nx1fs0VxalgjIVAvgimK8wt5SxqxergECQMEez9To3l0WaA==
X-Received: by 2002:a05:6830:648e:b0:71d:f239:c0b7 with SMTP id 46e09a7af769-71e29bd5721mr568395a34.12.1733950520886;
        Wed, 11 Dec 2024 12:55:20 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71def651fb2sm1888288a34.27.2024.12.11.12.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 12:55:19 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 11 Dec 2024 14:54:50 -0600
Subject: [PATCH v6 13/17] dt-bindings: iio: adc: adi,ad4695: add SPI
 offload properties
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-dlech-mainline-spi-engine-offload-2-v6-13-88ee574d5d03@baylibre.com>
References: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
In-Reply-To: <20241211-dlech-mainline-spi-engine-offload-2-v6-0-88ee574d5d03@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Add a pwms property to the adi,ad4695 binding to specify an optional PWM
output connected to the CNV pin on the ADC.

Also add #trigger-source-cells property to allow the BUSY output to be
used as a SPI offload trigger source to indicate when a sample is ready
to be read.

Macros are added to adi,ad4695.h for the cell values to help with
readability since they are arbitrary values.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v6 changes:
* Drop $ref to trigger-source.yaml
* Add maxItems to pwms property

v5 changes:
* Added macros for cell values

v4 changes: new patch in v4
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml | 13 +++++++++++++
 include/dt-bindings/iio/adc/adi,ad4695.h                  |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
index 7d2229dee4441e20a7bafc9165fe309ac2e9eada..cbde7a0505d2b5df22c54ca4556878bf22e9b4b1 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml
@@ -84,6 +84,10 @@ properties:
     description: The Reset Input (RESET). Should be configured GPIO_ACTIVE_LOW.
     maxItems: 1
 
+  pwms:
+    description: PWM signal connected to the CNV pin.
+    maxItems: 1
+
   interrupts:
     minItems: 1
     items:
@@ -106,6 +110,15 @@ properties:
       The first cell is the GPn number: 0 to 3.
       The second cell takes standard GPIO flags.
 
+  '#trigger-source-cells':
+    description: |
+      First cell indicates the output signal: 0 = BUSY, 1 = ALERT.
+      Second cell indicates which GPn pin is used: 0, 2 or 3.
+
+      For convenience, macros for these values are available in
+      dt-bindings/iio/adc/adi,ad4695.h.
+    const: 2
+
   "#address-cells":
     const: 1
 
diff --git a/include/dt-bindings/iio/adc/adi,ad4695.h b/include/dt-bindings/iio/adc/adi,ad4695.h
index 9fbef542bf670015c5b34bfbe1336e7e295bf8ab..fea4525d2710cbf58cd4236d3276bad4cb318df9 100644
--- a/include/dt-bindings/iio/adc/adi,ad4695.h
+++ b/include/dt-bindings/iio/adc/adi,ad4695.h
@@ -6,4 +6,11 @@
 #define AD4695_COMMON_MODE_REFGND	0xFF
 #define AD4695_COMMON_MODE_COM		0xFE
 
+#define AD4695_TRIGGER_EVENT_BUSY	0
+#define AD4695_TRIGGER_EVENT_ALERT	1
+
+#define AD4695_TRIGGER_PIN_GP0		0
+#define AD4695_TRIGGER_PIN_GP2		2
+#define AD4695_TRIGGER_PIN_GP3		3
+
 #endif /* _DT_BINDINGS_ADI_AD4695_H */

-- 
2.43.0


