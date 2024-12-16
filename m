Return-Path: <linux-spi+bounces-6064-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE2C9F2D8F
	for <lists+linux-spi@lfdr.de>; Mon, 16 Dec 2024 10:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75ADE1887D5D
	for <lists+linux-spi@lfdr.de>; Mon, 16 Dec 2024 09:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3678B202C26;
	Mon, 16 Dec 2024 09:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jr/r6CgQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6225E1B21AD;
	Mon, 16 Dec 2024 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734343118; cv=none; b=bygEAjDCih/7cJMz6cLJNGiTQqSnTKjsIg9nZg8+os6UU+NPzm2iAXSHs2H73EtBJhuW3OyQq76IPzZwdNoJHJs8RDGejFSDJnFdRr4HV4gFWg/cA/52Un3rJ7NnX4F0HzHgvhL6DGnZRMcGKP+5F+HeG3295hQwyLWf9eJxNzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734343118; c=relaxed/simple;
	bh=myFBHZeecaUEN+7YXzD9HPEtAFFygM0cCcgut9FY0n8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TvNZVG94VULwxfNt2njJLC6vNGrLeck76TdN9eUBBWT3nH7owofDH/d6s4BpQYx7X8gFdilOqCJeJG+B4Zkirdr9n24ExMsA4aanXZUjPTkqSoD6Rfxo7kh8pxGx1OXDIIaJG02Fqas+ZYNws7FUxp0LIzuT7afGkK9kcugvq4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jr/r6CgQ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso26044855e9.0;
        Mon, 16 Dec 2024 01:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734343114; x=1734947914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+imjwObLYrCtT9iVdWaRvQYsePwzOfwbts/TF+6Qi9w=;
        b=jr/r6CgQMbFgZyuxin+Qy2ktcox7eYGQ8W8hAxLNwEctjPIAsfh6QdTdHHocyDU8K6
         BCuZHAuGWuJEJaZ6PeKcVTxRSZTmjISrOQgpk97MKpzt9TkZW1MUHY88xKRKkV8jXe9p
         85fqQcRnUkyaBGOpagWRrz8nmK+HcomjMkRanKJQ7n4tnWiieuXi4hcOfb0OTKEGDYy0
         BPl4+SF0peQs7YQVTmpLUyRGvuXWglLRSzubUdYszbGyms/bkNscNaMV5q+Hu2qflXiV
         jDujWH+fIgGy0jxVOq96ldGlKocowu8/+yRlNthr2hhpfjSRN5Ie56dTs2lqUXeo8UV8
         cBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734343114; x=1734947914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+imjwObLYrCtT9iVdWaRvQYsePwzOfwbts/TF+6Qi9w=;
        b=bl1QVg32AwAvAxmdvuTRsQFTljJbQVpAjSAOrEfOPvqwOlbnW8MbKTiUep5Cuwkc9o
         Oot6a/O/gpmbdZwAJ6ucttCLoAUFAaoqICizynFST/fk04xHgXRoovE1btT9hxoVk4J3
         yPI9+/TjGxt615zIs8OWghEZi8aCu0wAiptV17zqeDAhbOOAxHzm3Ox3g0+bgYI//r6K
         bFdGxgAAkv0cns0vThGvQMkoEGIQHGC6IMKTPI9u1iA0tzhxrR8+P2xTdTEftFsdTIao
         QYMEurdEWpgLUqHL2uljdXofdQjf6EGkoCY9a8nCW3CLBBTeO5By64cu8uRXwhm0VxNE
         +QpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUisyg9/OAvOe9GDW/7MutRbJE8dD+k8Lcjd95SkajKgUuwLxQefRjH5hgu75JbykZlGQKEXOlRbSdC@vger.kernel.org, AJvYcCXCnV+ZT8aXn/tlFcdoSH7FAvAh4imS5wuKcuPMUpu7bUCgfhZgKlTRIV9nkTACTNST5ivq+M136yS9@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4a34oZ+HWChfDi8E36/4PsL+Nt4dwwGkB2VD86994iB25q44X
	3CVeZFAarPLvRj086+hogfNs3/rl2uxYvgtqBCxTyNSuV66IKuw1oS1q7w==
X-Gm-Gg: ASbGnctrWBjUiGbtYwgbyhIvqZ6BZvsCX/kHf19X33W+zh9KywqhdGpU2osNxYSqXlZ
	ds1IYT7r7DZzXZWOP+7oFS5kPqxmj5Vsu96V86/3UCy0y6BVfAwAVldQx5m/nRO4B8RsmpO2IRw
	JbEeaJwMIasRCdlq9T+1yPjOhIipRmaDKTXcbz6H+gNQskLeExpB93sjmr50NhG5sZtTV5NXsOY
	wmHXhm2PDxRWgwinoAvvGVvahgB0Mbju2f6OvZvPenWyempRdwYtSZ+8ohtULRzXw/7
X-Google-Smtp-Source: AGHT+IEiKmLJT8nHF70IuN7ZJKTVZRAS/TEMF/OuFIoXqDiykq8/XYMzATE9z85pCcZG6+R/XYTw7Q==
X-Received: by 2002:a05:6000:2a6:b0:385:fb34:d59f with SMTP id ffacd0b85a97d-38880af1508mr9279153f8f.11.1734343114291;
        Mon, 16 Dec 2024 01:58:34 -0800 (PST)
Received: from fedora.redhat.com ([67.218.245.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801ac68sm7628564f8f.51.2024.12.16.01.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 01:58:33 -0800 (PST)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Iker Pedrosa <ikerpedrosam@gmail.com>,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	javierm@redhat.com
Subject: [PATCH v3] spi: dt-bindings: Document CS active-high
Date: Mon, 16 Dec 2024 10:57:33 +0100
Message-ID: <20241216095739.27320-1-ikerpedrosam@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current documentation does not clearly explain how to invert the SPI
CS signal to make it active-high. This makes it very difficult to
understand.

This patch adds a simple explanation on how to set the CS line in
active-high and adds an example to make it easier for users who need
that setup for their SPI peripherals.

Link: https://forums.raspberrypi.com/viewtopic.php?t=378222
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---

Changes in v3:
- Use subject line reflecting the style of the subsystem (Mark Brown)
- Change compatible display to an existing one and adapt SPI MAX frequency (Rob
  Herring)

Changes in v2:
- Include header for GPIO_ACTIVE_HIGH (Rob Herring)

 .../bindings/spi/spi-controller.yaml          | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 093150c0cb87..82d051f7bd6e 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -69,6 +69,11 @@ properties:
          Should be generally avoided and be replaced by
          spi-cs-high + ACTIVE_HIGH.
 
+      The simplest way to obtain an active-high CS signal is to configure the
+      controller's cs-gpio property with the ACTIVE_HIGH flag and set the
+      peripheral's spi-cs-high property. See example below for a better
+      understanding.
+
   fifo-depth:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
@@ -189,3 +194,23 @@ examples:
             stacked-memories = /bits/ 64 <0x10000000 0x10000000>;
         };
     };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi@20204000 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "brcm,bcm2835-spi";
+        reg = <0x7e204000 0x1000>;
+        interrupts = <2 22>;
+        clocks = <&clk_spi>;
+        cs-gpios = <&gpio 8 GPIO_ACTIVE_HIGH>;
+
+        display@0 {
+            compatible = "lg,lg4573";
+            spi-max-frequency = <1000000>;
+            reg = <0>;
+            spi-cs-high;
+        };
+    };
-- 
2.47.1


