Return-Path: <linux-spi+bounces-11704-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D259CC99DC4
	for <lists+linux-spi@lfdr.de>; Tue, 02 Dec 2025 03:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEED24E2214
	for <lists+linux-spi@lfdr.de>; Tue,  2 Dec 2025 02:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5864827146B;
	Tue,  2 Dec 2025 02:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="kS/1vXcV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2782C262D0C
	for <linux-spi@vger.kernel.org>; Tue,  2 Dec 2025 02:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764642109; cv=none; b=aVFowhkfCn1tYzuxmNmm53fv1xXNfqSxj3wUx0kywNq4CAQBUXfbKx0gzgbDLLSICXJZU2NWE7P4IYI1atMLbPhbXI8PWyrhVszKacznBsEaMjYWMU06XtGNvdRDS3Sz5CIKO88uHIVuVMaw6esAdYC1DJTQiuCiZKCaNPJMj68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764642109; c=relaxed/simple;
	bh=27Dp9Eo/5bYs6ZpgMcoa3VFqU+ecGM/2yaho9ilRZUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H6aQf/55nXe+v5f5AWurzWj0t3JdKLwozghICnL/p3+bF46e6JDuDDI2UXqZWn28DclCGvCpBRsraeO41bPZNMYoJ4j4iqko2ywCrDextJMVllq1pVfy7A7/qXD/9bkY3R89toBp7EnqMx0ssmzqeyER6NdGWR4oWCofNtR5VG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=kS/1vXcV; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3e3dac349easo3583771fac.2
        for <linux-spi@vger.kernel.org>; Mon, 01 Dec 2025 18:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764642106; x=1765246906; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPykPTKA5daJRF8sWGIwc7I2B3AYq5LCnkOdVykOFbY=;
        b=kS/1vXcVObHLAprxcrhpM6pgiVNaLZ4v+x48EikJ5qkBO6KB3uSIjD2KDSbaYHJUMl
         aER9COUqk02Ee9ElgBjvzLnkU7ERyyCSCsM2cQDOYD4ZUJfdxF3vjWZmJm7ZY/ybBTaL
         2qFb7IXzphZQK6+xoSXTS2L+3lKadj9NGAcmzSlkirL7nl5U8LA6yp00N3tbbwNprZ47
         jH1CkUtckehx0qPrDl+VEttEru3dYXaOH9NKmE45/7SebRkA1PLLO4Fv0DLol0wit5ak
         fMpLtnBhmYH+FRz9L4QtUb0g30IovEiGJHlrI9O7zrywu396z+50PDHEf4Youa+U0YOo
         pqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764642106; x=1765246906;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CPykPTKA5daJRF8sWGIwc7I2B3AYq5LCnkOdVykOFbY=;
        b=qroFOYiOv2fbswxwTHUD1fziR17wUIe6c0TQGRozd54ZD3ZTpjbA+d3Kfq+a7izSEb
         RuHKgqn34yyAx2Q83JiMYAzEQJBPwopq/mMWXwtUwR4Jzy6N/UqHqAKWeLrc7Ez5kB1a
         tcK6S/8tE8c1qO/y7CJMeSMMVObkzTmmHClNvHWsiseQQoEO1/rpczW640sMVs0971tV
         ozbSeX3MJbBxZUSIZVM+AQFu7YEgL3Al7SN3dtb6RqRSvyXzD86vCKpMhZw/cdLpNcw3
         to++DRO1cdB28LNaG7LuojMDiHTHm3vtm9e8ckhNmfp+dDuX1+4LgiEa27mPjMm4yjai
         ylOg==
X-Forwarded-Encrypted: i=1; AJvYcCXYEh9izdiiw+3gG4b6rBL84tl0bRoKhWU9uzfRtQ6VuAyE1bIN1Avb2FA9DN7AsZ+ZB/a7Md/OyhU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEmf7mDebp0WHFX3BfQa3pNFh1N2Bxt8wfGjpoI8AP43Fl10uR
	3betY0lVH5Otdzm9ApkFEaWl+5NDkv6POhnTqV2LQPsKOWRELgU65OM8TN43FzW6idU=
X-Gm-Gg: ASbGnctiLaKm1VhnmKy+TICYH9PLcgykTIDeFcL05JOoVRh63eg0l37vyg7LzW9CI/R
	guxuSfah0qvlUVF0FUChxUwA7YFWwu7Mqx6ocjPEt5/7bBi5galPgU9Kirv7fZD00495Ly012/D
	gx00+FEpZqvU/ub0cyWCxiORSuFxiwQV93F8u7y55Qop0R5GcFMreYNljp5WddJUDzcIay0+7NK
	kiSUaexUEzen5k9EewWAnM0US7vkOquTAkqyVIDcs8vvk9B1LyuilVV7vvH50wZuxdIWGJSXMA8
	OpwhYG9lswjiK4ROwW+nJ8bmIGpTP+69+vf4LAF2VrdhNHZg0EudHoVDcRrfzVD7FFJnisfXE0g
	liNw7nTtOhi5GWvJRo0LiCEEvcD3KzqLq+1bPmg+IfVhOg6kkXu9e5Cmi724TdSnkIyO8afUn5Q
	1BH2THi2pC0VTIKA==
X-Google-Smtp-Source: AGHT+IFvD1zTn1ErmOjBKVWjKkG81o3I0u8+p2buGgYwdnhsp0hpGivL1sZfR516DJKRAAK4GAzmYA==
X-Received: by 2002:a05:6871:4b0c:b0:3e0:b4ef:8af with SMTP id 586e51a60fabf-3ecbe17be40mr21124177fac.2.1764642106231;
        Mon, 01 Dec 2025 18:21:46 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b67b:16c:f7ae:4908])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f0dca0475esm6651747fac.1.2025.12.01.18.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 18:21:45 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 01 Dec 2025 20:20:45 -0600
Subject: [PATCH v3 7/7] dt-bindings: iio: adc: adi,ad4030: add data-lanes
 property
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-spi-add-multi-bus-support-v3-7-34e05791de83@baylibre.com>
References: <20251201-spi-add-multi-bus-support-v3-0-34e05791de83@baylibre.com>
In-Reply-To: <20251201-spi-add-multi-bus-support-v3-0-34e05791de83@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3601; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=27Dp9Eo/5bYs6ZpgMcoa3VFqU+ecGM/2yaho9ilRZUw=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpLk0q1qmirQp45GTsbp3wnc6b4EfeWPDOtwrdD
 EyCmQTEpruJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaS5NKgAKCRDCzCAB/wGP
 wG22B/9ckntDaW+bEuGUVG7E647gXFThMKkJo6KE6i+MjjO4nmRkddLZQJX7lBhb7vTmnmto7Hx
 m6DB2P+9N47QXbEHGXNri+mdCQR6VCEu0vqfedEwsH/CmuYy0LoGdGg2X0Z7Uf4D8kiuxMuKfOy
 ri0/Cs3EVX9k3E545g96486EQ7X2f9sdOXUV49HzvHcMnL5tv/J4lV3fb14BNdlCQHG4RporknU
 u8aOSuGiAiORe8q9MMmH8IpJeCgOTxJGT087BunIu6PAfAvy/T5w20enWDXj+G/yB1GpyYbP7VV
 ujzxvZ29VtZVtSHAxeXZ3/o+3gZE7qlADJeNbQz7WRda9nCL
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add data-lanes property to specify the number of data lanes used on the
ad463x chips that support reading two samples at the same time using
two data lanes with a capable SPI controller.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v3 changes: new patch

I added this one to give a real-world use case where spi-rx-bus-width
was not sufficient to fully describe the hardware configuration.

spi-rx-bus-width = <4>; alone could be be interpreted as either:

+--------------+    +----------+
| SPI          |    | AD4630   |
| Controller   |    | ADC      |
|              |    |          |
|        SDIA0 |<---| SDOA0    |
|        SDIA1 |<---| SDOA1    |
|        SDIA2 |<---| SDOA2    |
|        SDIA3 |<---| SDOA3    |
|              |    |          |
|        SDIB0 |x   | SDOB0    |
|        SDIB1 |x   | SDOB1    |
|        SDIB2 |x   | SDOB2    |
|        SDIB3 |x   | SDOB3    |
|              |    |          |
+--------------+     +---------+

or

+--------------+    +----------+
| SPI          |    | AD4630   |
| Controller   |    | ADC      |
|              |    |          |
|        SDIA0 |<---| SDOA0    |
|        SDIA1 |<---| SDOA1    |
|        SDIA2 |x   | SDOA2    |
|        SDIA3 |x   | SDOA3    |
|              |    |          |
|        SDIB0 |<---| SDOB0    |
|        SDIB1 |<---| SDOB1    |
|        SDIB2 |x   | SDOB2    |
|        SDIB3 |x   | SDOB3    |
|              |    |          |
+--------------+     +---------+

Now, with data-lanes having a default value of [0] (inherited from
spi-peripheral-props.yaml), specifying:

    spi-rx-bus-width = <4>;

is unambiguously the first case and the example given in the binding
documentation is the second case:

    spi-rx-bus-width = <2>;
    data-lanes = <0>, <1>;
---
 .../devicetree/bindings/iio/adc/adi,ad4030.yaml    | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
index 54e7349317b77f032ecafde0102bf3a09f140f03..315ebcfbfa28888a4518073c1b286f0993f83673 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
@@ -39,6 +39,10 @@ properties:
   spi-rx-bus-width:
     enum: [1, 2, 4]
 
+  data-lanes:
+    minItems: 1
+    maxItems: 2
+
   vdd-5v-supply: true
   vdd-1v8-supply: true
   vio-supply: true
@@ -88,6 +92,17 @@ oneOf:
 
 unevaluatedProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          enum:
+            - adi,ad4030-24
+            - adi,ad4032-24
+    then:
+      properties:
+        data-lanes: false
+
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
@@ -108,3 +123,24 @@ examples:
             reset-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
         };
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "adi,ad4630-24";
+            reg = <0>;
+            spi-max-frequency = <80000000>;
+            spi-rx-bus-width = <2>;
+            data-lanes = <0>, <1>;
+            vdd-5v-supply = <&supply_5V>;
+            vdd-1v8-supply = <&supply_1_8V>;
+            vio-supply = <&supply_1_8V>;
+            ref-supply = <&supply_5V>;
+            cnv-gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>;
+            reset-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
+        };
+    };

-- 
2.43.0


