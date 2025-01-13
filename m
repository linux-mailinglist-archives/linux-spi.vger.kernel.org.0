Return-Path: <linux-spi+bounces-6335-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C806A0C2F2
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jan 2025 22:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052F23A835A
	for <lists+linux-spi@lfdr.de>; Mon, 13 Jan 2025 21:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E168B1E491B;
	Mon, 13 Jan 2025 21:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SiPmV/4m"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B3B1D5147
	for <linux-spi@vger.kernel.org>; Mon, 13 Jan 2025 21:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736802060; cv=none; b=B3rVWxTP47v54W/ETNWcHfY1P5KDIPgHMf5U7QleU+O3jgCe0j992Nv8a6W4SgBRPFsQTh7Bkl/5nREz8I+CJQR9faFtJZy5vuyGnjCvvcXVSt9r1pia6LXwEzs9KPEyvmCzbUWJQ7M2+2d6+kYHih7Fp3tLy+3w8xL+KH/AO6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736802060; c=relaxed/simple;
	bh=gtBu2ZZ2vrBTjdKMSPgACUJjxlR0+ZkwSs1X803qzt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PQ+JqEgsO89vlmNdThklEHC1gsVmh1lN/9S29bSQctl1FgvCMvlozn+CzOS2/tT5UrKYPhLcJ0R3i3lrqpXkQUU6Heq69j3q8lGYjdhWXYkryVn6CDmaxDmlWzNtK9ClwEOfXrKWVzbcf7WxfrJKVlMJgApJopJ1bQUhSAzx1VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SiPmV/4m; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-71ded02b779so2536222a34.2
        for <linux-spi@vger.kernel.org>; Mon, 13 Jan 2025 13:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736802056; x=1737406856; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f/I9rHcpYdM9fM6Q+0oD9VUcHEwQRmrH2Xbtl1OUhEI=;
        b=SiPmV/4mU5D/4l0K5yzW/B4rrvD7qkub1iyr8Y5fJQSMsWo+BNEWgiQRiR9QKvD+rB
         q8B3zCAr7rQXf6sGUH7YQz9gA66dbsEwylS0ia3t+bTQM3X/G0rJjEw74COM8px4xWPV
         wb3nLAqiKlNtzD9xKvcXyxQPMaFxM7Ws8tHBzTJHgwHYPMq9zp0lU70LOMtvBjkHV9EF
         0gJtt66k8eqrXL542aIuJZiST/zzG2PBsNKwWJj6LMUFOTmsleRjcrpS5wLezZuLKlCU
         oi2OVgInaD/DQDqDDSsGLcwvwY3flRVf6qeuEBNU2n+g/8LZCLExHEyv8b2Vm9/6btEz
         Omeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736802056; x=1737406856;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/I9rHcpYdM9fM6Q+0oD9VUcHEwQRmrH2Xbtl1OUhEI=;
        b=dAWsBvyoL+ieXOCpsM3aaRX8ssKgC27RvX67Jdt8CcUOOTY+uvaKJiXpBojn1y9iuD
         2IXLSlX+THhC1bZSgnOJzIJTs6uYnZG7/OEBfA5oI1lYbnXX1k1Ag/cJR9A+KVn96u4u
         iDWUofi7oLLvN6APXG+xUWt8rXGzxDUgWW2UEP5d0wAfqjj4lQ8HrkartbOx2+QOojWi
         wZzDgonZOFE4vO+yB4/XiOFInHTlDM7lg04u6TA74k7kWSxjkHlZLJEQv6F6C3fRCGs+
         ZnaqvJT56MfxsSaygXRx3wwhKYVQ2NmLryIs9NwTcnOi1g1rtWPJXSXstst7hC9kvitf
         rs7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+XyUYgqmq1386l+Gte2tBTvMRcu7mR7sPrUK6t8sduQWcllxssYJ6OqpXObdUyi7PQIbbi/YrjCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyv1s3v+ac5hpfArJ3oqGDL61hhgKln2uIEaOFWWQKwsLD620t
	hcCq14YXvRCoM1zGrcijiTlXLpjc5mEKx2QwNWrcMV8kznDuhMwN9ySG8VvB9ok=
X-Gm-Gg: ASbGnctZfztyt0U1iWHg+fm39JCOromZ/+bIfJztMN7uARLqru/YQ3H7BzocGcSoENN
	MQJoU3pRVjKkg1ck/6Z1Q/ne897ZH40Co3We3rgcAfgtcFiTfr1cYgKSDmmnSp6g972EePB05o3
	PVPhwgC6G1DX1SHEKsDIWtqd9ipobxB7LnYi3+tVo/ZeWdFqlrwh2uJZyIEbv5megdu/M+zMw9V
	8cx/kIkmd1nlA6hZoZ0oW0QuwB/teVJ8yAX91nUtwTBeTY6AEOYSM3m4RErFpZ+51SeAr/2eo6h
	PSDAep/yHqBs
X-Google-Smtp-Source: AGHT+IE5Ed8OwYQwhJFNwsZbrqUQnKLkmohNJHjjZuURDiFOp6pVRHrQad0b5pYWr5/TXjGlE8D9Jg==
X-Received: by 2002:a05:6830:610e:b0:71d:4fea:e800 with SMTP id 46e09a7af769-721e2e0823emr15877946a34.9.1736802056382;
        Mon, 13 Jan 2025 13:00:56 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7231855effasm3927744a34.33.2025.01.13.13.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 13:00:56 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 13 Jan 2025 15:00:08 -0600
Subject: [PATCH v7 03/17] dt-bindings: trigger-source: add generic PWM
 trigger source
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-dlech-mainline-spi-engine-offload-2-v7-3-e0860c81caae@baylibre.com>
References: <20250113-dlech-mainline-spi-engine-offload-2-v7-0-e0860c81caae@baylibre.com>
In-Reply-To: <20250113-dlech-mainline-spi-engine-offload-2-v7-0-e0860c81caae@baylibre.com>
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
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2

Add a new binding for using a PWM signal as a trigger source.

The idea here is similar to e.g. "pwm-clock" to allow a trigger source
consumer to use a PWM provider as a trigger source.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v7 changes: none

v6 changes:
* Moved file from bindings/spi/ to bindings/trigger-source/
* Updated description to not mention SPI
* Dropped $ref: /schemas/spi/trigger-source.yaml#
* Swapped order in name to be consistent with "pwm-clock"

v5 changes:
* Add MAINTAINERS entry

v4 changes: new patch in v4
---
 .../bindings/trigger-source/pwm-trigger.yaml       | 37 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 +++
 2 files changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml b/Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..1eac20031dc3cf921aafb8aa37f4e4eca1075835
--- /dev/null
+++ b/Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/trigger-source/pwm-trigger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic trigger source using PWM
+
+description: Remaps a PWM channel as a trigger source.
+
+maintainers:
+  - David Lechner <dlechner@baylibre.com>
+
+properties:
+  compatible:
+    const: pwm-trigger
+
+  '#trigger-source-cells':
+    const: 0
+
+  pwms:
+    maxItems: 1
+
+required:
+  - compatible
+  - '#trigger-source-cells'
+  - pwms
+
+additionalProperties: false
+
+examples:
+  - |
+    trigger {
+        compatible = "pwm-trigger";
+        #trigger-source-cells = <0>;
+        pwms = <&pwm 0 1000000 0>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 1ca16933d286bcf47b0a7f0fa531ec63d02a9167..00d80a1c680678f339a4c2ac584396edb2cbc405 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24023,6 +24023,11 @@ W:	https://github.com/srcres258/linux-doc
 T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
 F:	Documentation/translations/zh_TW/
 
+TRIGGER SOURCE - PWM
+M:	David Lechner <dlechner@baylibre.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
+
 TRUSTED SECURITY MODULE (TSM) ATTESTATION REPORTS
 M:	Dan Williams <dan.j.williams@intel.com>
 L:	linux-coco@lists.linux.dev

-- 
2.43.0


