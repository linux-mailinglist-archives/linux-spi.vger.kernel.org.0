Return-Path: <linux-spi+bounces-5334-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A0A9AD5FE
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2024 23:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9C15B220EA
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2024 21:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AA61EF08A;
	Wed, 23 Oct 2024 20:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nCjgFh8k"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D361FDFA8
	for <linux-spi@vger.kernel.org>; Wed, 23 Oct 2024 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717170; cv=none; b=prC/XUS0Jdda1qStnsqySEtkmY2E/FBKjOxH5iyemiXGGFNVw2vd26n9VeB5nzYDLRDgIu7lQ/JnUwZd8qE3mhBamB20bNXgHlvUrBFMm5NGkIB0OZS4/hCywS3uChe9qlqGGSJrih8pGiEi+Yksr4ExtR29cOnpZ7CU1kNcnRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717170; c=relaxed/simple;
	bh=/mOovntT5Qe8sUMdAxO+EkWWA3dOzhaFJ1YaLc6k+Ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xql7mksnRAaJopK3rlPdS/AXP5OlP3V0pb9+h4K2+l4BT7rvaVpeSKBw3084RJzHbgGrnw/8D5RabQnKJcktv9q/IzqexVM1XkVCxsLkCv0UtHTEnEN/8WZEjDW1OKwjNv3diBxjNcPIZKRPTLiBdB1X3Ljj9ti7jhv80XoM8Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nCjgFh8k; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5ebc0c05e25so106587eaf.3
        for <linux-spi@vger.kernel.org>; Wed, 23 Oct 2024 13:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729717167; x=1730321967; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EyHtfkBXgcKy8Q9+oyQnrUM8I5ww1iitltHtg1jsJVA=;
        b=nCjgFh8kEL6BDxn42ubkAI+3BVP6ITgTB74JlBrDSsvNIrCLRuXiosxTpPKOYxq3vc
         lN21UZ6zLO3SPSpTgLTxYtrwxy1Cpv1Ak1sRCjVWTzFDONwB8AkwFcWhWWF6vK+DJZJs
         YubpURtheHWzm8ah+nekFdi2G3ttHHFYsYjgdeiPSxZ15TeJR8s3fe69bZolj18aRiNY
         /WPpC+hIYy4ZwSb/4FeKf6tZ+zIDRe71/gBcZiqKpBeRXtkz9pBj7gj/pQHQz7qtWtli
         JWQp3hNPYl0ZFboW0bf8WtAtuIohe8kNzqo+91wNv63fyH0CzRt9YueRj+Xirp2oT7pL
         tI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729717167; x=1730321967;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EyHtfkBXgcKy8Q9+oyQnrUM8I5ww1iitltHtg1jsJVA=;
        b=n+88zjBwnT+MXgzxqNVPNGFy3CxGm0B17dRdSy0qYAhRVUqgUYA7kpxCacAE2Iio+V
         0foPBGezrVc0I3DjmWAeIa8RltTYsF34qEHQd/KBRS1+Z6L6gQ0qtEPe8Y+9Vd8T4elZ
         43qkjSnxnQHI1bhNtQQf31cCi1vyOHRYjopFT4WG9zE/pZ4vU37nTfhA2F5daDk6yrpu
         UHQW9oCvQ54WJU+jWHpzYstLHzH6zPeRZo4zxn0jB38IoxfnVg7xoVcJ8bHZFLWUcECA
         S4HXfnlAYxjkKMa6UQ77mCgfdhTq/K4CDqtoO7gkw/fUt7b9QO2Ohx4dnxMXRceRIQYN
         BScw==
X-Forwarded-Encrypted: i=1; AJvYcCVKib8iOqLEQeaOuFS/naYSZK443CpP1zQbYgM5kQPlejNUPNp4c7HKPzL2ljIXiVcsJ0DnR843Qug=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL9RryOyMj9xXKHi4PQNL28OmXFEif8bo6CPt7VVS9QAVbdLQ9
	MU47a0dps/GZqe2sZ5ilBu3CgYXFc7LP1TNfCfJJ7MRQKFKUQWf2caGRkCswi7Q=
X-Google-Smtp-Source: AGHT+IHv8HCEhfnp0g05EVhJyJSYYG556S9c4IigSs3Y2hbEvK4bBM3BCxpVknjvtRLUcm1QtQH0QA==
X-Received: by 2002:a05:6820:60e:b0:5e7:caf5:ae1f with SMTP id 006d021491bc7-5ebee532b5emr3206665eaf.2.1729717167480;
        Wed, 23 Oct 2024 13:59:27 -0700 (PDT)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ec02c2c157sm52730eaf.44.2024.10.23.13.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 13:59:26 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 23 Oct 2024 15:59:11 -0500
Subject: [PATCH RFC v4 04/15] spi: dt-bindings: add trigger-source.yaml
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-dlech-mainline-spi-engine-offload-2-v4-4-f8125b99f5a1@baylibre.com>
References: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
In-Reply-To: <20241023-dlech-mainline-spi-engine-offload-2-v4-0-f8125b99f5a1@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, David Jander <david@protonic.nl>, 
 Martin Sperl <kernel@martin.sperl.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Add a new binding for SPI offload trigger sources.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v4 changes: new patch in v4.

FWIW, this is essentially identical to the leds trigger-source binding.
---
 .../devicetree/bindings/spi/trigger-source.yaml    | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/trigger-source.yaml b/Documentation/devicetree/bindings/spi/trigger-source.yaml
new file mode 100644
index 000000000000..d64367726af2
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/trigger-source.yaml
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/trigger-source.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Trigger source providers for SPI offloads
+
+maintainers:
+  - David Lechner <dlechner@baylibre.com>
+
+description:
+  Each trigger source provider should be represented by a device tree node. It
+  may be e.g. a SPI peripheral chip or a clock source.
+
+properties:
+  '#trigger-source-cells':
+    description:
+      Number of cells in a source trigger. Typically 0 for nodes of simple
+      trigger sources. For nodes with more than one output signal, the first
+      cell be used to specify which output signal to use. If the same signal is
+      available on more than one pin, the second cell can be used to specify
+      which pin to use.
+    enum: [ 0, 1, 2 ]
+
+additionalProperties: true
+
+...

-- 
2.43.0


