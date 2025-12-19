Return-Path: <linux-spi+bounces-12052-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0151BCD1FC1
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 22:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB1BB303E25C
	for <lists+linux-spi@lfdr.de>; Fri, 19 Dec 2025 21:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CD534844C;
	Fri, 19 Dec 2025 21:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ClUwTzIv"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBB834107F
	for <linux-spi@vger.kernel.org>; Fri, 19 Dec 2025 21:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766180020; cv=none; b=JhAqXCDOqANil7UCKfPOaOIy2uCv4z4zHHKyx+kUcVGYjFitrlD3tXWghJglhIh6aojvXZHCK9EPKPvmWiBNO+8/gphBGFvij4jVp2buwW9+zkENF6Trx+hTNWocafo/MnPEZux4Leu8U1HKu0b1g3nJaUsgA+B2f8hDMXJG61o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766180020; c=relaxed/simple;
	bh=VQOPaqQmoNwtfxLbCSXG6BhStJUeMtFzJ0prIuJB4JY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ampj0FMGTvOVlf9ycVYU+nXfjgm2nPjxG5XrlCEp8UrFFJ6Zo0gp25MrtYyX/HZzkYwPEW+eFJUCLlgzP8WwiYTv5I3CIKLK3kjmsd+qsqr7dIh3mt/6wXDU6bTCY/3+qJpr0nZs0LdUqsjZv7/C/PhvcoebGNdmg3qh4gZmtyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ClUwTzIv; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7c71cca8fc2so1369279a34.1
        for <linux-spi@vger.kernel.org>; Fri, 19 Dec 2025 13:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766180016; x=1766784816; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQ9bA5wAd5cOLSdkvDwsJ4KZGTUhg22dy+q+3KzYnqw=;
        b=ClUwTzIv7D5PMbxN5U2hCpoVmQmiheLK+Ejx49ksbUV4lrOdVCjjAKSIT8+IHQyPup
         DRc/RNMyPy+F7GWPXZp0G27Ln1n8gdnJT2F7mUfmaeUZx7jSG90FIYeyYzGuyptEKiZU
         xAg3NajpQ1u1NrfvwxoouNCJuxsMyYsn/gCdO20tP5DGSdemiv27clgl6bXv7gPpFbUq
         qoVPyJunXV88TM6awOyQ5WZUKS22Jt8J3BDVyNcI+gNzR//ihSkHqw76NDWQshYj8HZC
         xJnee4+DRXmrw93yFkX4VV3+AIxtbLgDZTk/tADKOz3TLOxL2l8lhjcXyqHvjPfeiNwl
         GPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766180016; x=1766784816;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dQ9bA5wAd5cOLSdkvDwsJ4KZGTUhg22dy+q+3KzYnqw=;
        b=mZsEfHs9kJpganK7THrEc0NhwhCyn0oJlC+jf7J2cSuOYp9j01oxRlZZ+/pusUX/gk
         CvT/oPDiAY1Ks3wiQ7xFeqYHT6ERUDGrukxDe+VvNZWlJPWzGvjGRLKL52uYyhcmv5MB
         yuR0ZmgWRb64Q/h3V7WP7e0fB7WbnRmarYYMCIRyPbAnDgwPv9DW32jsuW5ubHvbubtR
         3dovjigM7tN7LfgtivlDdUDfUHL824gbNSBWJFx07HKDnMeyhAccZFkLKTJWKCcmAOh6
         3eHDefG2V8gHp0M0JfzniewynRGDAg4tin3u/OGpzZJheYJ7Ism8hGVG7RnlJj2NYvZu
         ht/g==
X-Forwarded-Encrypted: i=1; AJvYcCUjD3gUYQup6qW47yKOzJ+F/+ZQ3trdXhTVDJWKtEn4GnotsOwbYgkRTWcbBh8W2R7xuLjS14jZAEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZv+IeQaZlPxaAC27cHSWJE5JQnguSFhdX7N5+T6wutHattipI
	KOQ5vgtEAbXCBBoahy4v1k0O9tIHdID+Cu/+TMtB52tbq76SMwqG0ICwkS/uPb4xMQg=
X-Gm-Gg: AY/fxX4vjAICNAdYpRhyHz4+brKpar3kkmhjPaTVq2sCc6BiAARTlUr45c0gzzO7HFl
	LTv3Qe8oTvm0DVSQN5pOK/suDiHUxYB3F4+9yXWvMVR+05UuPw/HHb/L2OcgB3f4r/LExMQkCjw
	2Soc7OmqZW/B0Y+FCCFkmSoCe6wNpzF9I8fXVRUMti6UC0/egt6n9pkJyIA165LiXpqarJrL6uS
	lQhmPgeA4H+0lvU04aBeIajsRNKL9PaEWOpWGUbdF5hHamprJXhu2zWS/tUP+p+hxk9tPAHba/L
	2drsPtgXHMwd9bnUmGeIZsYlZVhjtazreEbY7qhRHLRzMyiqou9Ij83q4S+6pSXcckBQvSa+Zxb
	7ct8CPvZX+iwQRMXPDlgVsg4/AZVAH4I4hk8LdzZiEl3iPH2W3GaEpY43BFONO2t5A9C25jSiaT
	LjHLXak2uou+HnYQ==
X-Google-Smtp-Source: AGHT+IHGyipb98La7XJE4vZ3dHFAmyXLQw9XZJ4q2W59l2gO7JhuowVl43/w0hKUEnQvJoe8SceFQQ==
X-Received: by 2002:a05:6830:43a4:b0:7c7:6da2:6d67 with SMTP id 46e09a7af769-7cc6689d9a3mr2725997a34.3.1766180016063;
        Fri, 19 Dec 2025 13:33:36 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:9b20:bac4:9680:435])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc667563ffsm2485045a34.13.2025.12.19.13.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 13:33:35 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 19 Dec 2025 15:32:16 -0600
Subject: [PATCH v4 8/9] dt-bindings: iio: adc: adi,ad7380: add
 spi-rx-bus-width property
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251219-spi-add-multi-bus-support-v4-8-145dc5204cd8@baylibre.com>
References: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
In-Reply-To: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
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
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1994; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=VQOPaqQmoNwtfxLbCSXG6BhStJUeMtFzJ0prIuJB4JY=;
 b=owGbwMvMwMV46IwC43/G/gOMp9WSGDJdj8x4ylQ589TTfacs62zckqz2Ftiw2V77mJYWu/bgq
 w/+tYsyOhmNWRgYuRhkxRRZ3kjcnJfE13xtzo2MGTCDWJlApjBwcQrARJLt2f8nbY/dJ2r7o6ss
 aqLRboWsvRb9e99U77iS53ubY6mUBEOPqVcD02a3roS3N24zbC+ujhMqz5Jh/MkjxiJtcfnHlMk
 zTOdLLM6qrZzkWxf4b/7TiybBBQnTNrrILXS64F8a21++6a3oztkttS/P/PJa9mmt3ZJ7go9YGK
 QVH94TKUhMU21pEvn486BYRmiamG8kC/MrkZNrG34mu8/cmdIjn9nhFxlsvYL3yaz8pgk1N60zY
 ybYTUq7ZKXyVyug/ORLXquoxnCWU45HtvyU9NpcrtZutTmYpzHfwDhxwaWc/KrX8828t6Q+6d7x
 v+xx81Xus4eS252a1PkYrZYU7GRx23vIbk+pn92SNOXlAA==
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add spi-rx-bus-width property to describe how many SDO lines are wired
up on the ADC. These chips are simultaneous sampling ADCs and have one
SDO line per channel, either 2 or 4 total depending on the part number.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v4 changes:
* Change to use spi-rx-bus-width property instead of spi-lanes.

v3 changes:
* Renamed "buses" to "lanes" to reflect devicetree property name change.
---
 .../devicetree/bindings/iio/adc/adi,ad7380.yaml    | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
index b91bfb16ed6b..396e1a1aa805 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7380.yaml
@@ -62,6 +62,11 @@ properties:
   spi-cpol: true
   spi-cpha: true
 
+  spi-rx-bus-width:
+    maxItems: 4
+    items:
+      maximum: 1
+
   vcc-supply:
     description: A 3V to 3.6V supply that powers the chip.
 
@@ -160,6 +165,23 @@ patternProperties:
 unevaluatedProperties: false
 
 allOf:
+  # 2-channel chips only have two SDO lines
+  - if:
+      properties:
+        compatible:
+          enum:
+            - adi,ad7380
+            - adi,ad7381
+            - adi,ad7383
+            - adi,ad7384
+            - adi,ad7386
+            - adi,ad7387
+            - adi,ad7388
+    then:
+      properties:
+        spi-rx-bus-width:
+          maxItems: 2
+
   # pseudo-differential chips require common mode voltage supplies,
   # true differential chips don't use them
   - if:
@@ -284,6 +306,7 @@ examples:
             spi-cpol;
             spi-cpha;
             spi-max-frequency = <80000000>;
+            spi-rx-bus-width = <1>, <1>, <1>, <1>;
 
             interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
             interrupt-parent = <&gpio0>;

-- 
2.43.0


