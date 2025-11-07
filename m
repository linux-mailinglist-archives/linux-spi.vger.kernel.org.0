Return-Path: <linux-spi+bounces-11127-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C44BC41A55
	for <lists+linux-spi@lfdr.de>; Fri, 07 Nov 2025 21:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04044189B6B2
	for <lists+linux-spi@lfdr.de>; Fri,  7 Nov 2025 20:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C178633CE94;
	Fri,  7 Nov 2025 20:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="b3uialcH"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F8A337106
	for <linux-spi@vger.kernel.org>; Fri,  7 Nov 2025 20:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548832; cv=none; b=GS/nCX0znH/kscr8wDiMS+CVsPxH1qdxA3Dr7+eu7qh4VytLlXBRoZm/ybGBWBI27/slO1gKENyKvcY4ALckX3rYVTprB1F5wg5Um7incY3m4uiErq0gV5LQbL1ULUsAhGMxaU+i//KevCFkvX7ixJAzCy7fNHgnnFH2M8X6Vk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548832; c=relaxed/simple;
	bh=SSI0SDfdzuTFSZUxXbce1zwCpj2iLjVhwuT4WvAAlLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b98+0AKuVvXAFMNr3OX2P6fLrUwfyhmGWqRWwo1TLPhgULAIAM44pB31kkcacpXC0C2N0xQBy4I6Vpq3VpEj4GQBzp4hODyetP7KAuYmABbmSwm+lscKUd2CqY5bkIpSu7fUNrqSH1Bk0SMbSqHZpXrWkyZqdN/JxddIDjo6CK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=b3uialcH; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-656cb7b20ccso495298eaf.1
        for <linux-spi@vger.kernel.org>; Fri, 07 Nov 2025 12:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762548829; x=1763153629; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yEuLcTpBWY/VBsTt3a3S2ALMGGYfGqylnafUO+qzJ7Y=;
        b=b3uialcHuEW6SG2Haepgn2+t3fBgZMZQUPU7R4CwrD86NLuLszBMC1ozsZ7Rr1TT+F
         rlaCfWRRIvMlURL0utpPqSr2Rh7FLsChXP9+unaBj3bAKbMF36g9F9w+1g6N9891ymIC
         LYFT2oURfRot5bSmfC7UUnN+iN4Xtv3hqlHeCI4Qkf/DWH0A0tSIBI3weQLJxcIMdSI8
         HIYNXmY91lipFCerse+go4BLSUYGZRGHcphkGMhjz6LLgQHmcz1R0j/rSpAMXbvYwBZk
         JE/faySLnxgRCybIbkmSOgf7mo/w8RA7JBuIyWmC/B6oqhYxX2MLOq3YXTAhYhi2RpLT
         uYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762548829; x=1763153629;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yEuLcTpBWY/VBsTt3a3S2ALMGGYfGqylnafUO+qzJ7Y=;
        b=iSklQz8N2dMpmE/wHAaDVxqCam+lTCNgyl/ms49XpRaqIuCr7gc671oDw/2Ka9VoTi
         2tv5MsdXPhaExPYoSJJxXyJ6ympOUUg7lKhemYam9fMA+jeIW4LP+VpqxuFlNrGxbbyF
         ENIdygsEnZcucipgnBq25nhqhweb0KvE9eQOZVKDLgKu2zUMiDXQ/w4EXY6cRzSdnDm6
         uPXF0vlroelPAD5dVLZXzC+eM5LCD/Ix9KoXXTYIjywBzv329XexsrMzY7j+RUzlEaWk
         qxRnOJw5pewSs6NKij+vZl1Y8zs5qT1VO1eek/w4zNqyK1lRvK4R8dH1Xvn+58TtUi4N
         iBNA==
X-Forwarded-Encrypted: i=1; AJvYcCVW8qwMVpX6YG/az86biL6pogeDCM3Ndhe02jVZYDjchgwTpTB/apkBrt5/jtYa/zAoo4LGq2R6KaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVoVlFibmTMyVEK3MaZAcWpN2BD9TvXeU33vrams55B8OBSvHM
	Ew42ZvGalyEl8Cnguh6Gq84dco1HbESmXPJN/FBhO8vb191r/8qMs4DWgM2DQEDGYVY=
X-Gm-Gg: ASbGncs4aGgS05NgLykxvdf1yCRFnWJEG+MfFglUUGPPBlSi0m9horXhuyHUOz48LWd
	Z24OxTqIhZOppCqPh6ATXw2yIfjgthY4DxXqHRZZm8l8NVR0L98otE2p7QpWlvT7VtSsMUWTv6J
	ODSapSVzSpuwh1ctlJ0T6MmkH26MQEQasm9wFzqypbIsBcVD8yILS3RoxwMw1fBhPX90ePSEkuP
	wEw6UR2ZBaCDonIzYHd8o4w39qJEceIvDCN5+XO/sOzbdFvdNbCxR86YHgAzPLHjyke0l5t39zr
	B/1VO9exk54ct3NNW/FVCSfG3giDeQlVbhvnYGqUKL60oFtbfvlpi364WgtKNtMXf8pq4OYVA8H
	xyopOAOQ3ETqRA25U5MjLYphpTr4hjPttjWdoinHW/9XQ0rN9AON1ypSni2y9fXZN42+eq5nfXP
	nTV4jgti+57VBQsek=
X-Google-Smtp-Source: AGHT+IELkzg/Of84t9nsWUqhdVT6cx3AtRHpbp9W/yhXXlclhMmomOmCFDfPyUuBjs5CBkNK0crRXA==
X-Received: by 2002:a05:6820:6706:b0:654:f200:1490 with SMTP id 006d021491bc7-656d1b95d83mr1523298eaf.1.1762548828588;
        Fri, 07 Nov 2025 12:53:48 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:7bb8:950b:327d:4ba4])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-656c57eae5esm2915601eaf.16.2025.11.07.12.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 12:53:48 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 07 Nov 2025 14:52:51 -0600
Subject: [PATCH v2 5/6] dt-bindings: iio: adc: adi,ad7380: add spi-buses
 property
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-spi-add-multi-bus-support-v2-5-8a92693314d9@baylibre.com>
References: <20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com>
In-Reply-To: <20251107-spi-add-multi-bus-support-v2-0-8a92693314d9@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2055; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=SSI0SDfdzuTFSZUxXbce1zwCpj2iLjVhwuT4WvAAlLU=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpDlxHSOYmvskhvEqT8odlqy/PkdbyYBsitZwDm
 oHuMNz9yqaJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaQ5cRwAKCRDCzCAB/wGP
 wIM0B/4yu2sr3jOslO693wsOVfFOZsHgNwoP8mw6JTqbQykHS4iGs29iabDb3AP2v7dEzPqrAV9
 Mo2/6DumSMFtRFIHwUz4C5jY6iFWs5E2tRn5G9afvp/Eppwah99OrHWLsGxT5KMRJi0nJUP4R2n
 loEXzwW3FL+tI+qXP70AjwEDPtjC5pWymgUW/6l+roajx6Kv8+RzOAOZvusc5uJtqND4+sUwatd
 imEB239jVE3keaghxkQ4qrAhM3PrbnGpWSfwwxH6xeLTXQMloUneZx9HD/TZlUS5fpM5QOHnxvd
 +Em532FK9mUGEoKWISea9IvwIJ7WrljKaoW48YpHpQFxxSI2
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add spi-buses property to describe how many SDO lines are wired up on
the ADC. These chips are simultaneous sampling ADCs and have one SDO
line per channel, either 2 or 4 total depending on the part number.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
index b91bfb16ed6bc6c605880f81050250d1ed9c307a..9ef46cdb047d45d088e0fbc345f58c5b09083385 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
@@ -62,6 +62,10 @@ properties:
   spi-cpol: true
   spi-cpha: true
 
+  spi-data-buses:
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
+        spi-data-buses:
+          maxItems: 2
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
@@ -260,6 +280,7 @@ examples:
             spi-cpol;
             spi-cpha;
             spi-max-frequency = <80000000>;
+            spi-data-buses = <0>, <1>;
 
             interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
             interrupt-parent = <&gpio0>;
@@ -284,6 +305,7 @@ examples:
             spi-cpol;
             spi-cpha;
             spi-max-frequency = <80000000>;
+            spi-data-buses = <0>, <1>, <2>, <3>;
 
             interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
             interrupt-parent = <&gpio0>;

-- 
2.43.0


