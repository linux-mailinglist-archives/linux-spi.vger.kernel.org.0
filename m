Return-Path: <linux-spi+bounces-6011-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B08779ED2C7
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 17:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A654216201F
	for <lists+linux-spi@lfdr.de>; Wed, 11 Dec 2024 16:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A741DF754;
	Wed, 11 Dec 2024 16:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHXMZrq4"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A200C1DEFE9;
	Wed, 11 Dec 2024 16:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935898; cv=none; b=IBnxFBSIVwtHjbZK3nRC8BPsrvrpmONH8/eleLAbWuEjYVsHATrokUj25XLXYejR5J4IWkTRgkmLi4wqwl8N/91IaBr43HKg7OTm7ZQV2R1IrfP+/NFgWDrIKofDFKp5ilWZpsyjCYQQXfwQlqQ4INFryIip9yrEqINr7yQgdxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935898; c=relaxed/simple;
	bh=oXL1PWUG9X6mZ18eEANoN/9N4cIjnfpDgW2D9/ccU7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uSmpmcBV4keKfthXCoEkhqj1zAuBSRKfhZ2w21GZ78/t6jX8iLXFwpnN5abwljEWUpiv8fanPlaJwKd4QdsX+jnxgALpLu/uoSdtTtLgKg8igUFlempSVyDkHDvWt0Xa5GWLGeiB1tRTOBvPgBR927D+bXzFHe585vuQYkKft7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHXMZrq4; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-434e69857d9so5683415e9.0;
        Wed, 11 Dec 2024 08:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733935895; x=1734540695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=riqbhU/T/xicADAGQihGCjcOghkY+7bkr3p3RHDVWXw=;
        b=cHXMZrq4h7jq3Omho0Jeqc2inVCaFX2XVDo/7uVmTFu+icX1reveWu9B8OVWuVCJsk
         Q2he0tzQ0NuewygBdFcfzR1blgpqjWp5X7cnEVgMvSSt/arm+0OP9e1lHJYdQ/phpfYH
         rNereoPbupHXP/AJ+U1Fygm4I78GT2SwHoRE+5qNUBDtp310zx+efAVJs+M5983WUAhx
         hBrCGnJBVV/XCyYxfnjF6aNwi7HccU2ltSS5XGHNs54ZEBMQ3MyxIrJDpzMdKYsZWZYo
         hbCssWCS9UKSAcMerTAmnVcLC4QmtHL2JGk3StbEDVWV9zJ7aMDgKoFuoAaiizn33ANH
         fiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733935895; x=1734540695;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=riqbhU/T/xicADAGQihGCjcOghkY+7bkr3p3RHDVWXw=;
        b=MG/TQSIIFcdT1wc4enHP4ZED38hFtHnUGwIFMme6QdqZMHvPggptZOAGu4QoTVlbzI
         26uK3qTFMO9CzD/zFYGcOuZx9UmEpfsQUnb6lqrTPAdy6//f81V+GSNU3t2ukHYdysl2
         ZzlBj7eh03/JaLeqUHKMw0uW71o/TyhHqb0ZGsQucMcjzwnywLzNNDR5PsV9NFI+x0vw
         VB/9UTTEUTwy/WzS+fWK6w8m6mSdZGpZOXmswQxNgs87dmzNnB8tMqJJFkrBaAWZXkhb
         c7beB+knuPaVaGGDDFZ6YHzRAnnII8UppSaMKjKqSjHjj2CTciQSZGCeZMkVJlu8sG4g
         a/Kw==
X-Forwarded-Encrypted: i=1; AJvYcCVuEHvS2u0owPfjep6mZCGOQNLy0KYSXE4IyGdQf446K9FVjjlaDjzJlNtBzBNBXAdlCyNrsg6a085F@vger.kernel.org, AJvYcCWY8moJZIwq17mAzweUvrzhnmBMt35E1FWXv3Vuc2Jm4RJ1Ulkit7DxbZoU9pa5eqsZpVO3qBXTUTGx@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhtt0RZ4iZsj/+YJ2OYH7xCIMeSRVjh7DlK4tPDHqt9oJIQckH
	LAlOzRcaO8Oe+PLJ/Ql6vHe/ftdLd1DfchhdEmPS0qLEII64UVZWcA298w==
X-Gm-Gg: ASbGnctmQ96emNoVh8CP+OnvHyn0jfEyInchgJ+2SjgLZxx/i/gAKbJCIGjoAzr4DOH
	SSiwBXcf90kB4UzuKvq4jmPMLM9x2tTJkYqMzla4rNcNiKH+cb8sQGzP7JPUu3Dvy9ZYWdQR/Ia
	A5qw+1rDOHgue9spz3hSHTNt6JpFsUpiCsH8B9dhwXzFVlve/Dgs7eQdLMPdcv9IGNpCDIJ212i
	ZDYf0FKUqDEKhnq5j0/BlpTg1LzEX+39nxbzi6ro6FXzCbOjOxpV30mB4i1GSui1Q==
X-Google-Smtp-Source: AGHT+IGtfvB77SCgcHe/Vm+Rv03zyGp/puTRO2gwPi1EWGXTkzx87jMwRMoY0a4cwH7aecfOhmiPOQ==
X-Received: by 2002:a05:600c:1f18:b0:434:fb8b:deee with SMTP id 5b1f17b1804b1-4361d0b0ad0mr25036325e9.16.1733935894628;
        Wed, 11 Dec 2024 08:51:34 -0800 (PST)
Received: from fedora.redhat.com ([67.218.245.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824a4d19sm1678100f8f.32.2024.12.11.08.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 08:51:34 -0800 (PST)
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
Subject: [PATCH v2] dt-bindings: devicetree: explain how to get CS active-high
Date: Wed, 11 Dec 2024 17:50:50 +0100
Message-ID: <20241211165054.254164-1-ikerpedrosam@gmail.com>
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
 .../bindings/spi/spi-controller.yaml          | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 093150c0cb87..960d60e653d9 100644
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
+            compatible = "sitronix,st7920";
+            spi-max-frequency = <600000>;
+            reg = <0>;
+            spi-cs-high;
+        };
+    };
-- 
2.47.1


