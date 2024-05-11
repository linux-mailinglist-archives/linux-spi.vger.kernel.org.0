Return-Path: <linux-spi+bounces-2823-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BAC8C2FCA
	for <lists+linux-spi@lfdr.de>; Sat, 11 May 2024 08:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90A001C21456
	for <lists+linux-spi@lfdr.de>; Sat, 11 May 2024 06:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1509D4D5B0;
	Sat, 11 May 2024 06:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSGut5CK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACD44F217;
	Sat, 11 May 2024 06:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715408129; cv=none; b=Wo7UtyhX0GnApSyG50WWf/4XeYoAB5zhdGK5dVEQtTKNGV3scPSa/Z3vykNjdzl2Wd5/I7+7K9zxFyE72q/CHkf7S1q7wBCR2zeg124eLst39/xTrytPEToM5sJc/vUqhdiyp5qO11SiR/1d64vzghb16z8li6Dm0LNRSBP6ICQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715408129; c=relaxed/simple;
	bh=T302qFdGYt9upY98yaaB7NGOiDO4dKh58ZsZOKVG+68=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XK2FP5usF82AcAi8lfHOfDKDwQuJQgfFfeqqgleVGjHjbBVyKy+BCyYqXtKFG9n/OBd0T3XLUFNY1bS9QWdGPKQgC98o3PInD+WOxn0zZ7F6KYCG0b7u/741tLvusIcnIjmHCub2uShajJx2ViuWXlCkGIJeyXqkEKBMxv0g5Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSGut5CK; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so25539585ad.1;
        Fri, 10 May 2024 23:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715408127; x=1716012927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mk1p9NsMzvwBrXgYJqVUrzqhtMjz3H+uq2RwIwI5Iro=;
        b=OSGut5CKt3B/CkLdVEt+ozOsmCxzVnUX7ZAy7+B5qzvwgmeCV0sFy5Wg6GUVQkyN+V
         beBS4Ejq0gywDqTJ8XnYc5UkrG8DWqYvMh2Brb752o0Gp4u0qFQeEjPWzIWP5sEs8JZG
         zI27JhYLAU+XI9ipZXhh7HQo6nJSg0QEre2Qgp42rIlHOrTy9HzTvaijB5mB9IpVvL08
         xXEoqdbMX331lrHOpJpzjWNOb2NtI4X56nJR1UNklC6zosgark56MuuZ9moQhlYv+TpO
         M9cYNC/twRt4d/dIOhQ1mytwsT/ljV40YkBjU6Sw/r1YkHFVGuLiCjiJ1kI5VXNHp5oC
         QQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715408127; x=1716012927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mk1p9NsMzvwBrXgYJqVUrzqhtMjz3H+uq2RwIwI5Iro=;
        b=Hw4daIh61ZyQaMYy1mlpIbgHoOfOLPgjp8v1f0dGuvGZoK38As7qd/l6DMYlMCOhyM
         o/+RNTvoGyeyizYiAAjmw3tqdHNX9pvNq07Mw9WL6W+E6L/kuoWtnunAnJJ792FhTWrI
         Xf0nr3o3EqVS8toUUCcRs2CbYuSMSQDZl33MHtDKMUEq6Ny+zn/pXm63o7wTf0JD1yHd
         BjGnftVtnYZwDZ4sCJPz/8O6oR1O1oSLxGDEBcHxMQyIUWMxrzRLONsjyqSuBeUFc5QM
         RzFplQwm6/hgwvTWtsF51q34oVgGHTUeh1sH4H8p3U+TkZHpzz7ZSSioZl3FtgCyJo1O
         Vrtw==
X-Forwarded-Encrypted: i=1; AJvYcCUgwjZ5oFeIUi/x7ynuR/rmPD+tWXR6+ma/jvWCff49n9G11FgYVUCAB8fgmzJ+UUFffUEa5dxYIAvp74AjmThdOa1i7JAgEUfhwoD+nzqIdghY0gxfylXPivy72TLee8OsAegi6GDavPg0eXHe+2yjQoVGGE46FFvtLF5GjTD/+zE3HQ==
X-Gm-Message-State: AOJu0Yx2es86olCz4uWILjrV9Yuw64uMAKTbuY47b8h0Lxbme/d4gFnI
	1navbpeek9ayyl6pTeOA5wF+fi4GgD0Xe6cUwaSWAVjeEAcTc5iZ
X-Google-Smtp-Source: AGHT+IE/5w+T17713VvVQvihpBps/gl8gaAUn7yc0SAhP030RjyD/9WHrSttR/cH4OahChBLKer4zA==
X-Received: by 2002:a17:902:7082:b0:1e2:1805:52c5 with SMTP id d9443c01a7336-1ef43d28349mr49186255ad.16.1715408126567;
        Fri, 10 May 2024 23:15:26 -0700 (PDT)
Received: from localhost.localdomain ([223.178.81.214])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ef0c15a8fcsm42249005ad.278.2024.05.10.23.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 23:15:26 -0700 (PDT)
From: Kanak Shilledar <kanakshilledar@gmail.com>
To: 
Cc: wahrenst@gmx.net,
	Kanak Shilledar <kanakshilledar@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Kanak Shilledar <kanakshilledar111@protonmail.com>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: spi: brcm,bcm2835-spi: convert to dtschema
Date: Sat, 11 May 2024 11:44:56 +0530
Message-Id: <20240511061457.8363-1-kanakshilledar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Broadcom BCM2835 SPI0 controller to newer DT
schema. Created DT schema based on the .txt file which had
`comaptible`, `reg`, `interrupts`, `clocks` as required
properties.
Added GPL-2.0 OR BSD-2-Clause License

Signed-off-by: Kanak Shilledar <kanakshilledar@gmail.com>
---
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


