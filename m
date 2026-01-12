Return-Path: <linux-spi+bounces-12305-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB97D1488D
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jan 2026 18:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C6BF310BD47
	for <lists+linux-spi@lfdr.de>; Mon, 12 Jan 2026 17:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D0136AB6B;
	Mon, 12 Jan 2026 17:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OGPsEen7"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C23737E312
	for <linux-spi@vger.kernel.org>; Mon, 12 Jan 2026 17:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768240001; cv=none; b=jfhKtyLEs9px9eMWNSWao6RciwmdjElBwcAAOCgp0//HAGtcEtUnttrJEr8JPDlrrwzcmFQ2BQBr2UtnCCvjPgIZxzYQ5wSu/Yo9XJIAA5gUrjUqHJ6cwGo27QGCunQoVIxZEoOzx4zzouCmBe5FvNIi1pvFNIfgjhAK4nYW4gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768240001; c=relaxed/simple;
	bh=KlpbRpvD0BSmL1SYy0IyvDDu/2WAX2DYojcAy5Sk6+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mn+riN5svCrmqrBhLGTtqgwl45nkultsKrKSzjA1kYGHwd4JtkBVfWozyhgvphXVuP5u25MsZKEXuJSfQwl+JUvUMgIIQbcqt0vEY5aKtG64D58mH0fkPWLIQFmzVGv7TuumgY9RVG68yOTv9GNfMDMrdn/ncEPSV/7f6QeaFlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OGPsEen7; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-3fe3cc80bc3so3715231fac.0
        for <linux-spi@vger.kernel.org>; Mon, 12 Jan 2026 09:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768239996; x=1768844796; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mU6bnMq3EmI2XeZnFFH//hp7bqUfjnvQ/avju2H44Rw=;
        b=OGPsEen7nV4GBn6VqBGPEVVsdg/F8a+aukipfe0cujF8IIZMva+cXNxtV8BuSN7xwX
         QGqiTr5/MonkSUGJpq1Yd//ZR72GIrxzN2zbiv6BdBZOuiJhp3NXg7PlGVKbwjg5chGm
         9S4MqeNShB9h0cc9uFpqv/76rROI3epLlogoCdPsjFejyfKnnplCY2B8VC7CpQVweS7V
         B9Qu0CDhvogtenZlGSHFf9AfudIliGc4j2Rg/NKIEGfq/Lu5g17AjIZAjihvPJ8WrS7y
         GeIGqsrimCDwfJ4JLLKgY6uhve5N43YayMglGw4ArXluKc2lHFfrysYHRtnq1aOpKazs
         js/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768239996; x=1768844796;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mU6bnMq3EmI2XeZnFFH//hp7bqUfjnvQ/avju2H44Rw=;
        b=dyjuGWh8UFcoa+Zp1IbfodEHL6bq/9yKOXknHcZadgVIKhjzUzSHRuEE+tvYXAIiR8
         MOXlBxN7zE1ANW4qvZlzFz547TA8GrI6Hs7NMsIv00iYyukM4g5neBS+nJh53058XksG
         XJ+Sb9mvW3Vn+C8I6EsJ9yKISwKCk5rdCVnpR0mI9uisDX4BuzQtWt55LBgPSGN0O923
         mQsg4B6X/gKLcfQC9pC+RBS6OjISzG0xaX5b80MKHom2Bxzw46N7qp63bx5sUyXdgLF1
         Pn21B4nFNpUsM0eLze+v3GvJvkjoes6tvkLVxdlK5eUFK2ds0YkK1hHIsr3VYrKf7s9s
         CMLw==
X-Forwarded-Encrypted: i=1; AJvYcCUjMC+/kn3sGyC3rwE8zxGXIh5GpSYq322W8VBra+Bd1RkKNNdXuEaMTD7ok/cnVuApT4QaDABeSpc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp+O3mBKeYwNKc9szcOi9F+XqA/J4XsyxF0luT1BJgm3QZUSly
	e+n0GgBO5mfQjVFzFq5vt4TQybvp1KHi/dwvsWlVedFbHIVVQRNZaWXYUOPuqFkpGzo=
X-Gm-Gg: AY/fxX56Zbnst12NLms1onXL20v2Ku6fq1/+29juZp7x9eDNGodD0y0xtcsBBIezjeR
	6J89QrWy28lnsQXvIYDaAJZyQAFK9LyV5jkdazK6kfuBtNutRUAqXaW8cSefHqWbQbzfyPbw3tV
	Ov+YHn+tWAckcf1Te361Tu5cdPuCeu8xa9L9uhttZAYGMZ4k0UPZ1fkwI2ei+wvmmgpGt1SKrPQ
	3Zz2+KzgvY30f15L78TkisoVzeLN2Q+uIgNo8frttldCHDETsUr9h71csBVJw9nmOI2+XPkwYoM
	rnCnToQeQDct8RmYWa3mBem/yATlLzJpeKL+KGfQO8Xoi5Qk45D+7gLZCO1fKblEI4EROQFfqct
	z3b4L/RV3KhC4Jz9cE3rRnxZk87+MjOS2dbW95GpoQoleiE3TYjpxRP6WQNmMChs4pqld2JLJAt
	phArQDMDaZI+krSQc=
X-Google-Smtp-Source: AGHT+IEoDfvB28hK9nvIn7bly6V8L98WTUCLULaRDTDsMotN3hhYZkKeJoYlkt8txzlE5PHsMwnoEA==
X-Received: by 2002:a05:6870:d150:b0:3e8:970e:d4f7 with SMTP id 586e51a60fabf-3ffc095696dmr9253589fac.11.1768239996408;
        Mon, 12 Jan 2026 09:46:36 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:6b4b:49b3:cce5:b58f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3ffa4de40bfsm12126941fac.5.2026.01.12.09.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 09:46:36 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 12 Jan 2026 11:45:24 -0600
Subject: [PATCH v5 6/9] spi: dt-bindings: adi,axi-spi-engine: add
 multi-lane support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-spi-add-multi-bus-support-v5-6-295f4f09f6ba@baylibre.com>
References: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
In-Reply-To: <20260112-spi-add-multi-bus-support-v5-0-295f4f09f6ba@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1331; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=KlpbRpvD0BSmL1SYy0IyvDDu/2WAX2DYojcAy5Sk6+M=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpZTNYgNXHsHZkBPsP2wHJV6l7Q+Q4YK7WwSBEr
 xb1sQH57cSJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaWUzWAAKCRDCzCAB/wGP
 wJI2B/96Lv7i7q6RWevbLE8Rmrou7N4xap8Vn8Jff8Ps0Uvn3C4CAUrctWCdZcvNPsJEZqAjQ9S
 vh5wpwGsWM91OYZK7TgeBhfWxsQIp3EYma/HtpDjr79jp9hZg0j9WGH0KuRbCWbiYaXEpqMH1vM
 ogxcAKVXjr2l6YrbieImvZA8WFRiExDA6ZRff3wtnEIY7IJ0crxdZC1E6lC+CPa4t0HLO6D5+V0
 F6pl8zUWzk1wDZHJs5WeR9dVaXhRwQYWADcIWqcRX+1pS76NXbta819oX8NZGTOY57JuMWhrSlG
 +17xFPFU1CrQStpdhJXI5mtxkmWqMNwdIs0suUb+v0mU2Ara
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Extend the ADI AXI SPI engine binding for multiple data lanes. This SPI
controller has a capability to read multiple data words at the same
time (e.g. for use with simultaneous sampling ADCs). The current FPGA
implementation can support up to 8 data lanes at a time (depending on a
compile-time configuration option).

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v4 changes:
- Update to use spi-{tx,rx}-bus-width properties.
---
 .../devicetree/bindings/spi/adi,axi-spi-engine.yaml       | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
index 4b3828eda6cb..0f2448371f17 100644
--- a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
+++ b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
@@ -70,6 +70,21 @@ required:
 
 unevaluatedProperties: false
 
+patternProperties:
+  "^.*@[0-9a-f]+":
+    type: object
+
+    properties:
+      spi-rx-bus-width:
+        maxItems: 8
+        items:
+          enum: [0, 1]
+
+      spi-tx-bus-width:
+        maxItems: 8
+        items:
+          enum: [0, 1]
+
 examples:
   - |
     spi@44a00000 {

-- 
2.43.0


