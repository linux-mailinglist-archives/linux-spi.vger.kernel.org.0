Return-Path: <linux-spi+bounces-3628-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E6591ACBF
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 18:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51D71C25004
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 16:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEEC199E81;
	Thu, 27 Jun 2024 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="xCrfPee2"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704C2199EB9
	for <linux-spi@vger.kernel.org>; Thu, 27 Jun 2024 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505741; cv=none; b=phawY1UmvzXBO1umb7dzCA0EjqMqVbxkSSXSkJtYuZVWwbRX/rpi0CQ1iZOSJnu1jiXYd7QT49ESTkDFY3LPoLd/lhyllzpJ9jg3+UGXakk5MLRvrs9Oy9m+3NMqZytpOg6zOLfZJM1T00iAhrUaWz/FRRNpkpRRktEzLqYf1qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505741; c=relaxed/simple;
	bh=Qx+Gj82f7/BC0AtS5BoDh2/utfcW2CADbnoJO4Ly0ms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hHD7MuOOg9zrHQrbQWJw+F7qxFEP8DJba2mvS9n9marugXB2bgQ2nfMsn/5cq5rY3TXV1a4BlCzom8hr3y0RXO5eI4mT6GKfbHB8gJsTw8X8eT4MeyTa7++pa8ftNxMEyF/VhuyBppjLuEVHj9Hz0iBSYfiHFmlG7NNmgdoXfjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=xCrfPee2; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7241292c26bso171311a12.2
        for <linux-spi@vger.kernel.org>; Thu, 27 Jun 2024 09:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1719505740; x=1720110540; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ccOqRF95rvK7M/qswICcqSLYl9oR0H6qjszvfV+fi4=;
        b=xCrfPee2lXYTjSHZjTc0ooYg8z+TJOcI2qQMWWj0snBl4Xe2/2JZQ5rYvcNDXKwutZ
         x0TbfNGth4ntbaTejprwam5KhiKcc4iLpbIZ8LPa7gJVEIkm70CR5aPo/1WDVufleWNh
         +Fds+L45Kdeu1c3U7ZxekYtGJjNBCwHl1b+E4iD2AjBJlNli88yE0Sb5SW7Tyi3TKrIZ
         mtk99wd6LZ+9Oho8Xu3FvNSl9SCLBdSJoc1/Oe4KuFc24tKXND6jV08YZQ8w1/1oj4y8
         wjaA6UzX9xWbV005mCRqOSFSpbf1A9/QsWBZBQhXPh7d4m7hIUXGHmdJJiY6cgA1kXsL
         Yj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719505740; x=1720110540;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ccOqRF95rvK7M/qswICcqSLYl9oR0H6qjszvfV+fi4=;
        b=Vm9968jeWB4xF67s6H3IfUSkOWUfEYi96bggjYTjrSQ1XTsoyIZTtzr/cFYEyMlFiv
         /6AtLpHhJvCwj3LkN9qRcHkKkoMiD0eBd6lktWC1mlEVdfFzrmA16GNS4t2icLwzSi65
         zVRPbVO0mcuT7FFVu9+m+jcqZOVSTQvXAVreqCh7XLJ+jRw+ZoMEP+zvog51b/EJjPPO
         L7oNXXDef84Hry7jggpYg2IehWBjh5mXeBuOvSoCwHPffIJX4vyr3EkGpW5AgZ7EuHE2
         Yf1Nsx+hBT4Cs12NxzC9gh/wNOVGniWSMD5kOkmLrCSufL3+Kog3hP4SG/RIrLjmR4MJ
         f7mg==
X-Gm-Message-State: AOJu0YxzBf5V2GPZJssyfmQGs74Gr4uIR7IhW629riPI3A40Zu2RhPMB
	CNACQwIuVNkAITWARF+KPYJOrmSSIw4OMnCschtTc95PY891kp7a1C1RNARqhQ==
X-Google-Smtp-Source: AGHT+IFk7HX+UKAgfs/mOuNh+uAKaBrAUQCaRjadcUs82yFBm92OurvtId01tZ+4k4Mj1CxjuWO1vw==
X-Received: by 2002:a05:6a00:6085:b0:705:d60f:e64e with SMTP id d2e1a72fcca58-70667e2b1cfmr16013801b3a.1.1719505739742;
        Thu, 27 Jun 2024 09:28:59 -0700 (PDT)
Received: from [127.0.0.1] ([2401:4900:1f3e:18b0:e4e6:ed1:4c03:dcec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b4a58dbdsm1560739b3a.198.2024.06.27.09.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 09:28:59 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Date: Thu, 27 Jun 2024 21:56:12 +0530
Subject: [PATCH v5 2/7] dt-bindings: mikrobus: Add mikrobus board base
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-mikrobus-scratch-spi-v5-2-9e6c148bf5f0@beagleboard.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1971; i=ayush@beagleboard.org;
 h=from:subject:message-id; bh=Qx+Gj82f7/BC0AtS5BoDh2/utfcW2CADbnoJO4Ly0ms=;
 b=owEBbQKS/ZANAwAIAQXO9ceJ5Vp0AcsmYgBmfZM386HpYhQNB0PpqxdYqTINwd7DNpxa1qpT3
 BXwROSootiJAjMEAAEIAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCZn2TNwAKCRAFzvXHieVa
 dI77EAContjZVyred1K/HQTl7UUY2WxuOSylfSAEp/dre8J2S0HEpt2NJE9MFdKzEVzBvp+0euk
 VpHNC/jIngtHlWsnOs+Hgy4VahO/Ohkxix1aM4YJhm6rXAi4I1E8mw3tVtro2+AAdqwh4ZzQ91Q
 J/bofN5cTWytbgd9BawV7HIE1aoi1q2jK7oE/uKCrLCi75zfUWRDwPcPj0T9DLrt36lnRRFwF39
 BefYCRZcgN60wjf/QDdDG4r5mueY3yUZiRe8VV7reVnA+mjft7r+HTOd/FDHokZSIJK8NGm0AlX
 elUbHGmlgGHCnUAY3zraeyy21giGTjAUL1S+F3yuYBGW06FK4Sh5xRXkcvve/MgjDADLqEaN1IB
 uL62G8on4ywN8I3bZznwBDTocmUots1B/MCFu6uftT2wgIFWjv66SkSHx1GNFDnD9Lx0f7JeovI
 nmTOrQ0aUtRBP6THY+5D4tMGbo0P9L/UPbP+nMtc2Bf9hzW10m03fbv0TNO8kPtAY/nfPOCg4vn
 L4aZ8c2zeLASNtG4osr4DTBRcJUHdpsSPA+oj+9qC+2MmDpBtP+V8neKEMIsNNqA/Ubbwgq/cf4
 4knrbpAh8IekyYZBmneWz4gxXGIrPu4UwaOjXPVklytAKWvlOtfJ/tllwAtaITp0qyMM/9TSU/i
 bQczVjt5RwcnSEA==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

Base dt bindings for mikrobus addon boards. Contains properties that are
part of all types of boards (SPI, I2C, etc).

Each pin in mikroBUS connector can either be used for it's original
purpose (UART, I2C, SPI, etc) or as a normal GPIO. Introducing
`pinctrl-apply` allows selecting the pin configuration by name.

Note: Some mikrobus-connectors might not support all valid pinctrl.

Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
 .../devicetree/bindings/mikrobus/mikrobus-board.yaml | 20 ++++++++++++++++++++
 MAINTAINERS                                          |  1 +
 2 files changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/mikrobus/mikrobus-board.yaml b/Documentation/devicetree/bindings/mikrobus/mikrobus-board.yaml
new file mode 100644
index 000000000000..42e2219c596f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mikrobus/mikrobus-board.yaml
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mikrobus/mikrobus-board.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: mikroBUS add-on board properties
+
+maintainers:
+  - Ayush Singh <ayush@beagleboard.org>
+
+properties:
+  pinctrl-apply:
+    minItems: 1
+    maxItems: 9
+    items:
+      enum: [default, pwm_default, pwm_gpio, uart_default, uart_gpio, i2c_default, i2c_gpio, spi_default,
+             spi_gpio]
+
+additionalProperties: false
diff --git a/MAINTAINERS b/MAINTAINERS
index 8e4115e93aeb..14eba18832d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15113,6 +15113,7 @@ M:	Ayush Singh <ayush@beagleboard.org>
 M:	Vaishnav M A <vaishnav@beagleboard.org>
 S:	Maintained
 F:	Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
+F:	Documentation/devicetree/bindings/mikrobus/mikrobus-board.yaml
 
 MIKROTIK CRS3XX 98DX3236 BOARD SUPPORT
 M:	Luka Kovacic <luka.kovacic@sartura.hr>

-- 
2.45.2


