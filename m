Return-Path: <linux-spi+bounces-2838-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 514D28C4C88
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2024 09:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0823D282538
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2024 07:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAC0F9E8;
	Tue, 14 May 2024 07:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYsOUl5S"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B4AE545;
	Tue, 14 May 2024 07:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715670079; cv=none; b=l9ugeZbceYdzEu5sEoD3WsUNgBUN5PNgpsEKreNY/4hFlkfWHXg9j9XEik+p5j9Y/7B6eLA5pPmmMvg80Af4obhPdxxHjqNJ/xyQ1LbqK6fAYOaFeLSmNwvOns/Jy6KHprss9kDuN0KhFh/n8dAzYo8exFgTiUTq+/xholZB+8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715670079; c=relaxed/simple;
	bh=BKqXlZK7XF1UJpzIlE4H+vLXVZQDJHc91wlqO8+Qta4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uhBm9Wwq3JMGSUmiHspF4HUoLR1T5EZ7URa/ne9ImGCl1oiBivtVQCP0loiSXjGC9XOBCow8L23dZgmTyLsbuwK+GAs29JWkakH7IXeJ0b9lOOeJhyynnz7wPZ5QikVz60n+YdmtzKQGj6qHmlies3ZuIGBpJry5HuBFcwiIGas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYsOUl5S; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f447260f9dso4137220b3a.0;
        Tue, 14 May 2024 00:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715670077; x=1716274877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=forXuWPFy2XsVfocDJuDgmCjaOGTlPxEs7gWnYosGQU=;
        b=NYsOUl5SKlH5mvBNspD5y2ei0mi2JKjUhUaEc3kYlYNmMZ7DejKdB0udhJGrRy+UFL
         4t2+rbP9DNIW40yR+7D311Iiz344LQNO1i3NCCxDcH6Eo01TFCL2gHXTZ4vJ2goJO903
         dztK/H9vb++BU0rYyKCcuQBwWwJwuYJ369z650Q6nhJvJORvKGNqIuzM6iTYhBy6z51y
         T4oP52x3v/bafcvk8SrGiFx/3QmoausddPTKmSk9+hEZvNzE3S6/N646rkFnaM4QIdmd
         +IA/OsMqEIZg5qGMiyTfKuJSu3xgBSorK8Ul72Y+UQ5+oICBzjMdDZI8ZrFsxa+jocvy
         OTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715670077; x=1716274877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=forXuWPFy2XsVfocDJuDgmCjaOGTlPxEs7gWnYosGQU=;
        b=Aj2qfpdy3ESs0KFeCysP79L4518EkoQm0XrP/jebDCt5e169+0dzSSbaubaRL1Y7Rx
         0c/sOAPocI3KNU46BhVn/zFleMl13I7Sh/pEqmL8/CwAdU20LLutuMz45nyHeLq1qsSl
         KvY00K7amPRy1O0nPBjFTkEts/xa7JwsdcqFrboD3Lcy6P1hmav8SBpZPdyRj9yG4Vz/
         eN4HrqhdQFw8EwgnIBi2iwxebuzT0o6blyFs016UtMNs2UGDAsRXQwhsgnghZg/J3JBh
         UNJyEYTRmLMHnRnLcmRmOkLipGBFfAWKbeoTxrMr/5wgDpOpGlUnPUzkI9eIcCAXbJGE
         nmGg==
X-Forwarded-Encrypted: i=1; AJvYcCW08XBPuhxXsCifQs5ybFORYnrcAusFHys6A5ZnRe/agUF+JHIY/Jj19f2a472uGvwkQyEpX812e7TvTNh5vvC/68jC+4nS8KLsOGHg6p5ErbUnC+s2howy62kYgEDO6qrG2MRgYQp40NzMQmKBBKPG63BCSCPR6HiHwi6iiinSYXG6ig==
X-Gm-Message-State: AOJu0YyTifdiZaZn8e31I5m1w/BlhsITmdQnswJbztBkzm9NbHuhrxFd
	6hCq34Nd1keH6A+lCWfcMlU07nwe83nmxM4nSB3o5gWyKZ3fwuhh
X-Google-Smtp-Source: AGHT+IG5wzqOBVK3vrl6okMD0dC+FNrITjROwyOlVg2T7q+mkNnpWLMSaxVru01OWZXLEbp8azZpwQ==
X-Received: by 2002:a05:6a00:21c1:b0:6e6:ac71:8b38 with SMTP id d2e1a72fcca58-6f4e034858bmr11988580b3a.22.1715670076859;
        Tue, 14 May 2024 00:01:16 -0700 (PDT)
Received: from localhost.localdomain ([223.178.86.144])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-6f4f2cdedb7sm4830006b3a.52.2024.05.14.00.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 00:01:16 -0700 (PDT)
From: Kanak Shilledar <kanakshilledar@gmail.com>
X-Google-Original-From: Kanak Shilledar <kanakshilledar111@protonmail.com>
To: 
Cc: wahrenst@gmx.net,
	Kanak Shilledar <kanakshilledar@gmail.com>,
	Kanak Shilledar <kanakshilledar111@protonmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] dt-bindings: spi: brcm,bcm2835-spi: convert to dtschema
Date: Tue, 14 May 2024 12:30:47 +0530
Message-Id: <20240514070051.2959-1-kanakshilledar111@protonmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kanak Shilledar <kanakshilledar@gmail.com>

Convert the Broadcom BCM2835 SPI0 controller to newer DT
schema. Created DT schema based on the .txt file which had
`comaptible`, `reg`, `interrupts`, `clocks` as required
properties.
Added GPL-2.0 OR BSD-2-Clause License

Signed-off-by: Kanak Shilledar <kanakshilledar111@protonmail.com>
---
Changes in v3:
- Updated DCO email address
Changes in v2:
- Updated the maintainers
---
 .../bindings/spi/brcm,bcm2835-spi.txt         | 23 ---------
 .../bindings/spi/brcm,bcm2835-spi.yaml        | 50 +++++++++++++++++++
 2 files changed, 50 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.txt
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.yaml

diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.txt b/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.txt
deleted file mode 100644
index 3d55dd64b1be..000000000000
--- a/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Broadcom BCM2835 SPI0 controller
-
-The BCM2835 contains two forms of SPI master controller, one known simply as
-SPI0, and the other known as the "Universal SPI Master"; part of the
-auxiliary block. This binding applies to the SPI0 controller.
-
-Required properties:
-- compatible: Should be one of "brcm,bcm2835-spi" for BCM2835/2836/2837 or
-  "brcm,bcm2711-spi" for BCM2711 or "brcm,bcm7211-spi" for BCM7211.
-- reg: Should contain register location and length.
-- interrupts: Should contain interrupt.
-- clocks: The clock feeding the SPI controller.
-
-Example:
-
-spi@20204000 {
-	compatible = "brcm,bcm2835-spi";
-	reg = <0x7e204000 0x1000>;
-	interrupts = <2 22>;
-	clocks = <&clk_spi>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-};
diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.yaml b/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.yaml
new file mode 100644
index 000000000000..94da68792194
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/brcm,bcm2835-spi.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/brcm,bcm2835-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM2835 SPI0 controller
+
+maintainers:
+  - Florian Fainelli <florian.fainelli@broadcom.com>
+  - Kanak Shilledar <kanakshilledar111@protonmail.com>
+  - Stefan Wahren <wahrenst@gmx.net>
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - brcm,bcm2835-spi
+      - brcm,bcm2711-spi
+      - brcm,bcm7211-spi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi@20204000 {
+        compatible = "brcm,bcm2835-spi";
+        reg = <0x7e204000 0x1000>;
+        interrupts = <2 22>;
+        clocks = <&clk_spi>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+    };
-- 
2.34.1


