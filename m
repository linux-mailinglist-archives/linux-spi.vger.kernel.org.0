Return-Path: <linux-spi+bounces-3629-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F13E491ACC3
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 18:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6BFD283382
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 16:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E977199E93;
	Thu, 27 Jun 2024 16:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="sVyKVlVJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CD3199E8E
	for <linux-spi@vger.kernel.org>; Thu, 27 Jun 2024 16:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505748; cv=none; b=ExmknJ9PliT9a1tA2FfM9F6N3Pk8+YnOmfifkMe6SwvWMsI1eRgKURhQcUwS7jFvHncogf9QIB2egnNOT4kF04qylaaHh4Fy0AxcmT44Zu7EB5i9ZaUGiZyB7+hcdM/bTymbevMk1mwJ6yoAGgCnXhn0Q6vrp16jjEyEZvzokpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505748; c=relaxed/simple;
	bh=+2qvP/Xn1mfOZRYqvXqWL+bWU40Wws67RBaWRqRKWkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IAfm12rNFirwacN8Y2zYdaKycOOE7iLU1sbk3uhKl6qOFxYHPtZD7X9zehkp0wcDq+DsKvYzVaF89vV0BFaUzJqo6zotleLUDCYCD2xgEOAqSXRok01O/0JUMIFx5AN7xzmi4+OCLfhm3gQSWcZQIVveMFYZm9tjCh7+mlo9jKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=sVyKVlVJ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-70675c617e7so249688b3a.0
        for <linux-spi@vger.kernel.org>; Thu, 27 Jun 2024 09:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1719505746; x=1720110546; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZygMn7uvC7jOC5Dk/T17fUNW5zArlioCIEC7mvrSJII=;
        b=sVyKVlVJOOVfjTxiN7v2uYdztofe5sx5tb3JNIv7Yls0t2pfLgmuaUccsgFXMgH5R5
         fgIxJR0rXYiojvs4skEK6Kn4gbAQejM3IC512VVbzBVSuJ+3TkzI9IN8gcb5LW9J67iC
         9BYksBqMoMngyWX4+fPlrF2D81e7qXy4LhEzhznmU+pazEvUSEMAC7D2hNQVa9u0uGo5
         ySrbjLPKjA0s99MzAua0PDKbThORIkQxE1OuszNl+bySRHTMVJ5Zys0WN7n9Se1WbvJj
         o8KQNHTUvsaeWRzd2rzuyXE/9yu0npgU538NyooMCqslKY4iLSp2Z5m1k9b6sowIZmG9
         TQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719505746; x=1720110546;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZygMn7uvC7jOC5Dk/T17fUNW5zArlioCIEC7mvrSJII=;
        b=oldEWKZwrhy/kz3QYLhH5Bc0Zu2glWuHQSmQ9iOCbstkhrWi7tzEFBVdoBAlvs9tna
         YDibK6mEVa7gBngcwbrnG15ZQKyRT7Ww8042dvIMt4iU+0yDCSdG4lblxLQl8L3BfuiK
         c4+eHPM4qot2w6lrPNBOc/wGHk0T197ODd1d0gTMKGpA9liNI28K8qmwKt4sE3KM6fF1
         rhOGH3N0tAV0ctZbPosEIcPtxfyKNO0uPxbQHl17SMyIQtzikktHx1drm1b89OlLpDzK
         eJ0bjyFU600jefZYzGoFc6uuCO+SlVx9OuFjg4W+jMnskgyeiW3SZrxGVJAA5oW+ri5B
         dfqw==
X-Gm-Message-State: AOJu0YwB3YAzVLDQL5zevGRIG/IShSyCjYugCSOh631JZzGn72EriN1f
	aYaCrPXwM49HnpecTRxEar3hz8wMhocqi1jNSUXWi8nBvujkpqGzjfLpWXE9SQ==
X-Google-Smtp-Source: AGHT+IHqbrEn/MzWqlaJoSGgZcxw7gHGkyhYPxfsB/waXYDQqYHNQq7LUMFy4l2KHYm4bXB3Fy1SLQ==
X-Received: by 2002:a05:6a21:789a:b0:1be:d529:68b2 with SMTP id adf61e73a8af0-1bed529702amr1901349637.1.1719505745910;
        Thu, 27 Jun 2024 09:29:05 -0700 (PDT)
Received: from [127.0.0.1] ([2401:4900:1f3e:18b0:e4e6:ed1:4c03:dcec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b4a58dbdsm1560739b3a.198.2024.06.27.09.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 09:29:05 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Date: Thu, 27 Jun 2024 21:56:13 +0530
Subject: [PATCH v5 3/7] dt-bindings: mikrobus: Add mikrobus-spi binding
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-mikrobus-scratch-spi-v5-3-9e6c148bf5f0@beagleboard.org>
References: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
In-Reply-To: <20240627-mikrobus-scratch-spi-v5-0-9e6c148bf5f0@beagleboard.org>
To: Mark Brown <broonie@kernel.org>, 
 Vaishnav M A <vaishnav@beagleboard.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Derek Kiernan <derek.kiernan@amd.com>, 
 Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Michael Walle <mwalle@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 jkridner@beagleboard.org, robertcnelson@beagleboard.org
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Ayush Singh <ayush@beagleboard.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2720; i=ayush@beagleboard.org;
 h=from:subject:message-id; bh=+2qvP/Xn1mfOZRYqvXqWL+bWU40Wws67RBaWRqRKWkU=;
 b=owEBbQKS/ZANAwAIAQXO9ceJ5Vp0AcsmYgBmfZM3lAJFqmuXf/9R/f6QUc8jAUwTWHL8sDm0n
 zaRT+IOnhOJAjMEAAEIAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCZn2TNwAKCRAFzvXHieVa
 dJtBEACq2bspM0xQ/MgwNhecatTUWuwJLDXryVNpVzGUeFH+1x/wPJJ7+RwikDxrwJ2rqzJgON6
 MCCuZRlaDcV3VHyX9qXnrbIdrNj8Es55Ba33exrTiAdo2cIkqAaedFjk5+h27QQfvj5bP4n318v
 Rfg9I/VZ9Xe72YNbgGRIe/eZpODaJbXpMR/OUxREq46ezOEA0/rFbmYAyU5fFuGX+vBumR5YNXu
 4k/jCNRXAHt2lH2D3s0RHsRwFSypPQQvLAVpRPJ34G+VBGtKAsShNsEpPA/9PcitKjIaK29eSaa
 baiWHbwt6iwiH5S15Q3JonCGg+smHQeziw/KqEjYWiV7B75fSCVrAxiO1uyYqtBuGmSugXHglIq
 LCKjcOhF688TYgxJCiW2O2yACllsekClGYyKv1L0zSkevJGxxDXwG8gf4bxEO4KArlAqkbcNmIo
 9onNy87vJVOZ3sGg1FLP1X4OM8u8o+Bm8KBiMhV/PsMn3Cgw3nSY0ExnwRatjG17j5eCdqZC174
 fF5Q5OCpVZJjXKnlofn0CB2FQkkDdLAEdNFWMx1UeVPexUfJX8vZo9O1LlZxj2Il5WDiQ4k15Q4
 GDouJAvzTP3PucDdWiobFtWFvkEnW5jDy8NuBXZuoaOqUkUFCyfTSr8vjU/F86NmFsoBPpcobta
 6HgDaZthkCq2Ieg==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

Add bindings for MikroBUS boards using SPI interface.

Almost all of the properties that are valid for SPI devices can be used
except reg. Since the goal is to allow use of the same MikroBUS board
across different connectors, config needs to be independent of the actual
SPI controller in mikroBUS port(s), it is not possible to define the
chipselect by number in advance. Thus, `spi-cs-apply` property is used to
specify the chipselect(s) by name.

Another important fact is that while there is a CS pin in the mikroBUS
connector, some boards (eg SPI Extend Click) use additional pins as
chipselect. Thus we need a way to specify the CS pin(s) in terms of
mikcrobus-connector which can then handle bindings the actual CS pin(s).

Link: https://www.mikroe.com/spi-extend-click SPI Extend Click

Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
 .../devicetree/bindings/mikrobus/mikrobus-spi.yaml | 37 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/mikrobus/mikrobus-spi.yaml b/Documentation/devicetree/bindings/mikrobus/mikrobus-spi.yaml
new file mode 100644
index 000000000000..35ca2cce3b03
--- /dev/null
+++ b/Documentation/devicetree/bindings/mikrobus/mikrobus-spi.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mikrobus/mikrobus-spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: mikroBUS add-on board using SPI
+
+maintainers:
+  - Ayush Singh <ayush@beagleboard.org>
+
+allOf:
+  - $ref: /schemas/mikrobus/mikrobus-board.yaml#
+
+properties:
+  compatible:
+    const: mikrobus-spi
+
+  spi-cs-apply:
+    minItems: 1
+    maxItems: 12
+    items:
+      enum: [default, pwm, int, rx, tx, scl, sda, an, rst, sck, cipo, copi]
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    thermo-click {
+      compatible = "maxim,max31855k", "mikrobus,spi";
+      spi-max-frequency = <1000000>;
+      pinctrl-apply = "default", "spi_default";
+      spi-cs-apply = "default";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 14eba18832d5..88f2b3adc824 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15114,6 +15114,7 @@ M:	Vaishnav M A <vaishnav@beagleboard.org>
 S:	Maintained
 F:	Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
 F:	Documentation/devicetree/bindings/mikrobus/mikrobus-board.yaml
+F:	Documentation/devicetree/bindings/mikrobus/mikrobus-spi.yaml
 
 MIKROTIK CRS3XX 98DX3236 BOARD SUPPORT
 M:	Luka Kovacic <luka.kovacic@sartura.hr>

-- 
2.45.2


