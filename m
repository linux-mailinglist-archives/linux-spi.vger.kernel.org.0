Return-Path: <linux-spi+bounces-11702-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B0AC99DD3
	for <lists+linux-spi@lfdr.de>; Tue, 02 Dec 2025 03:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A7C3A3FDA
	for <lists+linux-spi@lfdr.de>; Tue,  2 Dec 2025 02:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B328B265630;
	Tue,  2 Dec 2025 02:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CzR7rdiG"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AF8257849
	for <linux-spi@vger.kernel.org>; Tue,  2 Dec 2025 02:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764642107; cv=none; b=JRkkPBc3I15n9l5DEXEl9QmDGL9cvHR6/6sULcN36oClKHr35KailfNGA7HR/D7sqQpKsVEQVB6/RjMX2O5u4dj3NbqODcfr/ixGd5sJ2FukR4Ru+nAwIeXxykCwVVr1JT0QG8ZRzVjV8UjgzqnwviukJyKkhrG/OGOhv7BdU7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764642107; c=relaxed/simple;
	bh=AnxiC0zO5K09VBpX+09fR5q29Hz10qkKK6qI+NOzrk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=evWXIEoYMc+U4z52ZPAAU2/LNqTxvJaP2GXs3LBOdluNDZqeRcBbNR++SY3V9FcEsLYKy99msKDWHwIPTwYVUObAonRdZLmaP8ibLS0RqgWOHdIVkcnfLUjnB/7H+m1y9FOtCOWlghT4OPff8zSwYkYhqUusnVTFCWyndvQaANU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CzR7rdiG; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7c765f41346so1923584a34.3
        for <linux-spi@vger.kernel.org>; Mon, 01 Dec 2025 18:21:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1764642104; x=1765246904; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WRHkx2PbvA6tRTdEjw0DBe64KKDCFqGi51pEElTa7xI=;
        b=CzR7rdiGM8Y+JiODR3zHR851ZEP33nK2mvHLi0Wb122YxDzzDF/qCcQFGvTk4Svu1+
         Ma5HMY9fkS7/6kkf4ik1f6A/FfwvHFzvfUSK2DxRNZ4azJ5jrOj72juGbuHhL7ziRu1D
         QJlgwSk6x1oE8HDgo9OLCdKRyv+SnKgw9+VheTECUgt1FaohPaQj3mcMG0FJQtGW635I
         LdGDY/bNCXHDMQSgcuU0HZdd24Cl2jeN0Fxklm98WUE3kwsKISbHXyqW3AziQtVD7nsL
         /yoe5Wurx1G+AvorJzGHu9zx3rKg7GGdvtg9SdkafmNwdnXRzlofruqU+pVi7kKjN0ZM
         H+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764642104; x=1765246904;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WRHkx2PbvA6tRTdEjw0DBe64KKDCFqGi51pEElTa7xI=;
        b=EApuhd+iZpxm2zn84eFIIHS1ni3oZ42Mv5SEtpSMSNdWrnTKoe4dg4HxdfznvG5FDo
         IFYvtPAh/p9dNXldZNh//ni+Gh5v9YRKk5f6Fy1kjBrw7LEGKey338ZlnTVs+eQ6eAzg
         MLjW+JP7feD06tiY9BSTTBHJWcVfG6ZI1bbneyEmSZbyOOAZJ6hGWl29FuOf9A6GqP9p
         xGUTc7F8D3FLOqp/bh1QnkRCm4eYjU8tFF4kKnAExdX4c0rEELF8NUl9YkMyNb5uhN0l
         xjvDpjYZ0H2nWp+2+lPsSuNdFIJjLVg2kysZMuU1KAtBy/6LcQdFMq/BlB3Cq2L2hWCW
         4EmA==
X-Forwarded-Encrypted: i=1; AJvYcCWOxFVyeLqnR2fnCM/IG0Bz45ySApIiPpYXDudRfTqUWJVgdXPaFEy0dNd4nIwA401GSwvzQ1Tlr9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvs8I3SAfGj5Dm15QaAYVpaqEvB86e6QsibGR0VJFssN1hfdtC
	gNRYrVlYnLVNKYhJ8G8jLQhTcOAu+067qKmsDF527WBBHpHOqTRRBT8SYRGoyrED+/w=
X-Gm-Gg: ASbGnctd7If45Qtp3qz44/Jgjj920FKSMMQPrSsfWGcrsDxQUZgQnHm94YYFSeiREqV
	LB1nRz4zGIlv9Szlg2GFyc+7NHHBtue4ekuVTmktNUiwSzSV8JIvwAxadl3+m66a3RdRS64xcNv
	8EiLLNmibLjvDCAMaOsdroJzc4HEywVATNtpNt56SZv5E2GA/b0BWr9YaFnBfm6A/nTTHULmerV
	0EKtPrialrA8mXfQprg2W+vbqQMEQxzHC2Cx3pryg4BuOSVEELYs5cl1DIkvqfNGsDb3jPO8k4y
	mINBOYPiCTEyzvAAUVGFDUDLLvmUJ/4TNRMM8Q49OLCE9Vb1OXeApZP0A2+qb6/TZA3Dk3+MY4k
	zekolryR7SKKKOhNKKF5BenaaebQox9rUtieep6z9fselSnEEorHutvvgudJIXAwP7xhQ93t+lv
	YY5SCtYXaSM/os4Q==
X-Google-Smtp-Source: AGHT+IHf1AYSHv/bjorwBdPChltXomNMV0bRwJydmGe803OYmbcfr1824zpTOqM1ydoI94iqWeJEkw==
X-Received: by 2002:a05:6830:7187:b0:7c3:e07f:567e with SMTP id 46e09a7af769-7c798ac95eamr19311914a34.1.1764642104294;
        Mon, 01 Dec 2025 18:21:44 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b67b:16c:f7ae:4908])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f0dca0475esm6651747fac.1.2025.12.01.18.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 18:21:43 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 01 Dec 2025 20:20:43 -0600
Subject: [PATCH v3 5/7] dt-bindings: iio: adc: adi,ad7380: add spi-lanes
 property
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251201-spi-add-multi-bus-support-v3-5-34e05791de83@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2131; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=AnxiC0zO5K09VBpX+09fR5q29Hz10qkKK6qI+NOzrk4=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpLk0dck/kNniAhUKO2tYEEaygog5xcSGiToIf2
 U+oPCeCf9iJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaS5NHQAKCRDCzCAB/wGP
 wJ8GCACDPO2zNUhu7i0vpRocN+avVZBXxF+hhTSGNihEEiZh4x7Ld3ZPfQjfby5/7bsAx29o7G9
 3PZGBa8blxymjKcx/ObFzP8thRtPILcpzanIP9J1L3SjG86yEKRxzp41TT8xJmNVt4y5WLk9sI2
 9qGwbyqs+SgzjfkB21Cbh7tyUw+S7kfU3QN+3j7Y761lQgbHdyg+pINBiC572bylfNgOnF1OLtE
 K7M6bMerryAL7RAXQTS+vI7SdIup/bo2RJ7q2ggVgZgEPY4PrVhLytTv4l5MRYT0NUGv4bm/bAn
 aXIj7E43Ko2l+cdq9rVEu4zI0YbfpMGfCx3j0fl8yHPY2Tlz
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add spi-lanes property to describe how many SDO lines are wired up on
the ADC. These chips are simultaneous sampling ADCs and have one SDO
line per channel, either 2 or 4 total depending on the part number.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v3 changes:
* Renamed "buses" to "lanes" to reflect devicetree property name change.
---
 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
index b91bfb16ed6bc6c605880f81050250d1ed9c307a..3d2de67d3c27548020337bb2fbd54f977657b034 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
@@ -62,6 +62,10 @@ properties:
   spi-cpol: true
   spi-cpha: true
 
+  data-lanes:
+    minItems: 1
+    maxItems: 4
+
   vcc-supply:
     description: A 3V to 3.6V supply that powers the chip.
 
@@ -245,6 +249,22 @@ allOf:
       patternProperties:
         "^channel@[0-3]$": false
 
+  # 2-channel chip can only have up to 2 buses
+  - if:
+      properties:
+        compatible:
+          enum:
+            - adi,ad7380
+            - adi,ad7381
+            - adi,ad7386
+            - adi,ad7387
+            - adi,ad7388
+            - adi,ad7389
+    then:
+      properties:
+        data-lanes:
+          maxItems: 2
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
@@ -260,6 +280,7 @@ examples:
             spi-cpol;
             spi-cpha;
             spi-max-frequency = <80000000>;
+            data-lanes = <0>, <1>;
 
             interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
             interrupt-parent = <&gpio0>;
@@ -284,6 +305,7 @@ examples:
             spi-cpol;
             spi-cpha;
             spi-max-frequency = <80000000>;
+            data-lanes = <0>, <1>, <2>, <3>;
 
             interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
             interrupt-parent = <&gpio0>;

-- 
2.43.0


