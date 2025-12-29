Return-Path: <linux-spi+bounces-12152-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D134BCE7FD7
	for <lists+linux-spi@lfdr.de>; Mon, 29 Dec 2025 20:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 557633058A09
	for <lists+linux-spi@lfdr.de>; Mon, 29 Dec 2025 19:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A980E335BA1;
	Mon, 29 Dec 2025 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="IyrgbF6F"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D2A335569
	for <linux-spi@vger.kernel.org>; Mon, 29 Dec 2025 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033619; cv=none; b=fgyjMYrt1WeOePtrN/6uGT6awbwLlA823iIPVGj3N39x7IU/pb2i/lHQEJ/VhADc/34fI6JtZzNG5GTHMtMDTTM2QtDmZD5WyrnRGn705JLFmGIOzAwkudMIm4D5Zn7MQ5KPT5PbCb4UqaEnNyHLHkuWePBXTGPCH91HoPWbqKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033619; c=relaxed/simple;
	bh=dZfEjbKU/ouuTZTqPmjhpmJn3Qj+z3eYR6Bl3lD/xyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nXQaD7RNubFoKb+tadGzPtKG7O6AFI4gpmbcRX45MGFuJa69qJgbJIry3XCEz/ISm+dQ4aIeJelOXn1J5HZazILmcHIbZMYPFVOZ1SXIhb8GhE/CK3BlB0z7HxibagBXAbOZz641AsYkkwSlifoYPa9mg9f3Smm/luBpsObY1G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=IyrgbF6F; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-47755de027eso55374455e9.0
        for <linux-spi@vger.kernel.org>; Mon, 29 Dec 2025 10:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1767033615; x=1767638415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11UWr6vQeMvr9imUXUNdMnB+gxpMnYAq1afoJQH8nw8=;
        b=IyrgbF6F0u28a5QzqGi50ibLI5sXMnrNs9w2nKZbHvTdLOMtT7fV5tB3XSXxbBin+z
         +F7iemGAgQcoJ9Flf47KNjfQBnI/iqSFjhlwBxAY1TytmO/7e4JOQPrNinsFzbE1kobm
         iwp1El2nfozKqd0uOOOIZy4E7W7vs7yG0bwPi2nR/PX0eYqAfLaqKeMcAVOr1MSg30k8
         YcRIl3dZsgbyi6YROamI3AWybGB52crReQbGZAHW/Wz+ded6FK7NZnz6cmqe3OQd5D4p
         FxFHbwh7lCbyarJxYMPPv6EjTjI0yKAlsapfEw6F7Nul42Yk6T7qVGvrs+Mor4Cok3iG
         uIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767033615; x=1767638415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=11UWr6vQeMvr9imUXUNdMnB+gxpMnYAq1afoJQH8nw8=;
        b=M6qG2quedRVqFjtwkG4Udv5b2UPo10LaTIPiF82k/MwA+xNrCxov1bay5vrPVeZG/S
         A340pZGny2DFAwPcxzclr07qIVDR9RPkol+TdQ9x/dF855pE7zdCK+2X62z2oMMEQ8xj
         2U0r2QXSEkAJEtGhFmRLF4eNCT8jSurAzQ/nQOkdguPDXfCGXh4eekGB237tMn8bs7Ao
         SA0EpVUtz6k56w0ujTZa78MDnS+pHqzDmkkBYWr5VtmqglbT40kjuUchiNCUmH/jw+99
         xZadzS10tEWvnXL/9QPxuO2+MR8z3h4E6M+l1teGk/p3sUcg9qd3DDwd6CAxhpLYyEAT
         7+9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWX/KxinSV8B9t/kOmXtvuHcLhccAtjasHk0yiAdpLvn7tbRjjiqklLd7EZYWmEF1XQdMoAPrLBOmg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu5ZkEg2g302ySr1nbMUBjCUcPLtDL35cAh+LxIHimRyU8Kslz
	BtFNd6rxAUjCIvWaCTJKTrpRJE05Umj0qxZiI10LgklYdTbNggTt9oBRKsEaGNu2ZVM=
X-Gm-Gg: AY/fxX5+3cEb+NE/TlVDfYNIYGXizy8ML6WZl9RbN8tmh4OIVuTFPwADZ4eUKQsiOYF
	BWFF/N7Y2HJIERgK1MxfbRJkMm2W8CodXkW6Rqoqx/NgMc1LbIAIJO6/LTqCMT8SxHWoN44Hzqs
	eXyDpCNWnQgjxgH1ICuN4dF/qFJA6NCCpTpqfoLRKtMm3BTxilWTZDdG8B7q7Cdjp4B/oCnxVgH
	i9FFqAS+9uoFJvr27IWaEITCnop/PA6e98mMTQIumFnQrqsjIDDc4Xp844B2TUogQbv/L9cy4qC
	h6grI5vwjQce09lRI+85/WP1djnlQhMiiStAiLcU2QuAzvIEJRNRAwkfQXGZ7Wj77SyjSdpMR1L
	UMETLDE9jzlZJE2tfjB5DYd0pFd5BdwI7krbtTSOboJnlTSMuLkZRJ8t81Fc1MuDU4JwtDvzkan
	xFjIGWLAs3vvTPitzQ3FHfxBMomtaXD60K9WvwDLibncpwjBphk1DcDYdNMgJUBNv8VVBJCZV+i
	ANEDmoH9UBOAv/3ReL1tFN+wxnHhN4yT1FdfXw=
X-Google-Smtp-Source: AGHT+IHLaRW54exoV7d2gj+gL+Rt0y3shCu9zPoBut21wi+sGprCRHwNncaVYYsnvBzR7kb1R2Xvfw==
X-Received: by 2002:a05:600c:1f84:b0:479:3a87:2093 with SMTP id 5b1f17b1804b1-47d338a6109mr230056155e9.37.1767033615044;
        Mon, 29 Dec 2025 10:40:15 -0800 (PST)
Received: from fedora (cpezg-94-253-146-116-cbl.xnet.hr. [94.253.146.116])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47be27b28a7sm604907455e9.12.2025.12.29.10.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 10:40:14 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	vkoul@kernel.org,
	andi.shyti@kernel.org,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linusw@kernel.org,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	olivia@selenic.com,
	radu_nicolae.pirea@upb.ro,
	richard.genoud@bootlin.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	broonie@kernel.org,
	lars.povlsen@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v4 01/15] dt-bindings: usb: Add Microchip LAN969x support
Date: Mon, 29 Dec 2025 19:37:42 +0100
Message-ID: <20251229184004.571837-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229184004.571837-1-robert.marko@sartura.hr>
References: <20251229184004.571837-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Microchip LAN969x has DWC3 compatible controller, though limited to 2.0(HS)
speed, so document it.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
* Fix example indentation

 .../bindings/usb/microchip,lan9691-dwc3.yaml  | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/microchip,lan9691-dwc3.yaml

diff --git a/Documentation/devicetree/bindings/usb/microchip,lan9691-dwc3.yaml b/Documentation/devicetree/bindings/usb/microchip,lan9691-dwc3.yaml
new file mode 100644
index 000000000000..08113eac74b8
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/microchip,lan9691-dwc3.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/microchip,lan9691-dwc3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip LAN969x SuperSpeed DWC3 USB SoC controller
+
+maintainers:
+  - Robert Marko <robert.marko@sartura.hr>
+
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - microchip,lan9691-dwc3
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - microchip,lan9691-dwc3
+      - const: snps,dwc3
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Gated USB DRD clock
+      - description: Controller reference clock
+
+  clock-names:
+    items:
+      - const: bus_early
+      - const: ref
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+allOf:
+  - $ref: snps,dwc3.yaml#
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    usb@300000 {
+        compatible = "microchip,lan9691-dwc3", "snps,dwc3";
+        reg = <0x300000 0x80000>;
+        interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks 12>, <&clks 11>;
+        clock-names = "bus_early", "ref";
+    };
-- 
2.52.0


