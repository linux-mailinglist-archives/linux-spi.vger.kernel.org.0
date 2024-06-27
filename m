Return-Path: <linux-spi+bounces-3627-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1455091ACBA
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 18:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B961F25C68
	for <lists+linux-spi@lfdr.de>; Thu, 27 Jun 2024 16:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76E31993B3;
	Thu, 27 Jun 2024 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="Byjyz6jW"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B5D199E96
	for <linux-spi@vger.kernel.org>; Thu, 27 Jun 2024 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719505735; cv=none; b=UpMVpnJ4b7VA9TZkschMBgpeXrW+S5cxVOuBssyFzQph62779Zd5hoWxJywhcZpyeXmutSKGMWw4c/1Te7tyZRvjWwoPH3yv4zCMVGINky+k+kFeaX4C4qxDr1eTpCqgwHlvuSwzkBqbTXO0Dwudg60oK7uXsQai6mcIpuF89H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719505735; c=relaxed/simple;
	bh=9/rpedcTTyGMwyn6LHb+RIA+j2zaGfGSP/fqzhrUXJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NEIoOWVzq1T4VfK0TGkHnx7y0EYUaJe61UKfjZkiAVVmX8oxLXdju3RAgkgwgTs5e4U0mpkKNcsZeIvBYStMH+vbeduExBN3MgOG/RisyO61DcdLfqdadbau+quCEP91OpTljezRy3i6JygbjDzMg0XR2hk3B1mcAvTi3wSnLRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=Byjyz6jW; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-721b0a32e3eso192697a12.3
        for <linux-spi@vger.kernel.org>; Thu, 27 Jun 2024 09:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1719505733; x=1720110533; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yhIZRHpA4qOumuO4k7pvHL8zVi+S/SE7cZamMyu7G80=;
        b=Byjyz6jW+xlTDYpC7efrFxu+CQtAkchNqCCYbKkjCl/6M7ssbDLjpgFvmOEvjYsVZ6
         YYv5PswSMKtdk9dsWMO803OHqZTCvHA4dlS9QfBEobMboKetIGx+kqZ+rnihdQmFV6EQ
         eGZ5DwxJh6Ak4eZQ3d6OxCHkfQLQLW7/5UgfWkQxjwqfRMMhWgSc8eC/J1lo8/EidUjk
         hT2n6IYglJF4fPram9dyOtBnL/8N7Rx6A9qavMshzWpDWegfz8Se85i1DlPi0l1wm5ve
         siLNC2EGr3jvw9AUVFem2AMTzduqX/E6GHEDkgmjdBCUCHJodDjt5GPmMnofOvxrUgif
         1iQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719505733; x=1720110533;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhIZRHpA4qOumuO4k7pvHL8zVi+S/SE7cZamMyu7G80=;
        b=v0iLbVNOCerCrsl3v0hCkf3U9DNF6EzHJUuhhvcJUoTVednMhhey2FjoBaDSN27DTL
         6gc1YPgPTeKs2nfRRuTaFAJ/1VxnqkJcWaFgaH6bAn5M2H4zaZvHNG9FHwyDwW4CY6Li
         DMhLlHn2Z2BTcHUh/rX5I7fe0vVmj4QVlNfCchDJoqp+YCZCnwfxbdRxGZwDG7CjRkVx
         6e7YrHh0vZ79fN6P5mXCB9IhxNzbCkZkcfI2/wL5D7WuuSglST9xwwJob7cnQeHn7GJM
         Nqc/3duYZ7+5A+qu0gjdjUE6KbI0m7xFPPNyHYu1PY0348xTCEI3Lp+5sQFzsPBsfAiQ
         TPxw==
X-Gm-Message-State: AOJu0Ywi7Vg6QMGoy5adBpxZSNhvwTroeagOasX8ChRZgkZ4nTIoeZDz
	NWWw7KUNDZJw0Z0isXHN4A4titdmCZDY2R0+eqWVydN0DPCnw6mjVOm2o9/wkA==
X-Google-Smtp-Source: AGHT+IGu7nfAht951dRK0GykxN4pyx/LO6pNHCPGWyCGEdRxWhNATyHi0HUE8qiqBodGwFGg0p2swQ==
X-Received: by 2002:a05:6a00:408b:b0:706:5c2c:e202 with SMTP id d2e1a72fcca58-70667bd82ccmr16038261b3a.0.1719505733221;
        Thu, 27 Jun 2024 09:28:53 -0700 (PDT)
Received: from [127.0.0.1] ([2401:4900:1f3e:18b0:e4e6:ed1:4c03:dcec])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b4a58dbdsm1560739b3a.198.2024.06.27.09.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 09:28:53 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Date: Thu, 27 Jun 2024 21:56:11 +0530
Subject: [PATCH v5 1/7] dt-bindings: connector: Add mikrobus-connector
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240627-mikrobus-scratch-spi-v5-1-9e6c148bf5f0@beagleboard.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6830; i=ayush@beagleboard.org;
 h=from:subject:message-id; bh=9/rpedcTTyGMwyn6LHb+RIA+j2zaGfGSP/fqzhrUXJo=;
 b=owEBbQKS/ZANAwAIAQXO9ceJ5Vp0AcsmYgBmfZM3CjLemMfmgtRjyAG+QFAnKzW5YgCMcFF4n
 thEWPBvvdCJAjMEAAEIAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCZn2TNwAKCRAFzvXHieVa
 dMDYD/4qz46wFWZWzewi7xIKhBYFSdUuNPu3Z/RnnoAeeEPwArGJMiHZAgbjUWU+Ss7Cizf8eyR
 Ghzs5yQcnk7cZ0bYK1EBrmvgQW2mAAvni1UHQrUo+4QmgKdt5r8h8F1btWDqxXDBBnAWsSFK9dp
 eYEe631gu90oesxwkH8j2bqEYw5p1AIAzjbsB6D+d35TOuaQsTasS/CNRmD978KM9+2usW9bu34
 82hFjsGAaRdvWAZqKoD5lgFjyajIZXUOxdCguTssgsnTqUU8KtKNJew+0h3iKaOqtKS30fXPdSg
 cGLrTs2vWrnZh5TCoCv5XjOp//vicjb3aoyQlKMIIweGS+AjgieyrMyRkPakGchUStJmsAxGkDs
 eo2RBvog3OT9WtWy41N5rMiYIfrW3YA+fBsQylUGKM9/AGDMHwJG+aB08E8yHoqHoPcseHbspUy
 CmjNihxQt3+nGfq6KC36pCJ7EnInom62np4vafwCvqRvW6aIupMw46jBu+YMKHXD3Xf2kXwoto/
 qGfPDTQeco5wFTt1AtEJb/cfESmGI7XLJtLFFahpRq62X+KScegeTDRCQi9nsI8XLB9HYFUAsVf
 yMbONuFSltU+KjMk/PzoMcJ4iVt+AZswu6UPVplECqGyrbA4352882O7JqRQrWoB2pDzKL3OIBN
 4TT4yCa5LCVqZ7A==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

Add DT bindings for mikroBUS interface. MikroBUS is an open standard
developed by MikroElektronika for connecting add-on boards to
microcontrollers or microprocessors.

mikroBUS is a connector and does not have a controller. Instead the
software is responsible for identification of board and setting up uart,
spi, i2c, pwm and other buses. Additionally, some new mikroBUS boards
contain 1-wire EEPROM that contains a manifest to describe the addon
board to provide plug and play capabilities.

A mikroBUS addon board is free to leave some of the pins unused which
are marked as NC or Not Connected.

Some of the pins might need to be configured as GPIOs deviating from their
reserved purposes Eg: SHT15 Click where the SCL and SDA Pins need to be
configured as GPIOs for the driver (drivers/hwmon/sht15.c) to work.

For some add-on boards the driver may not take care of some additional
signals like reset/wake-up/other. Eg: ENC28J60 click where the reset line
(RST pin on the mikrobus port) needs to be pulled high.

Some SPI addon boards use other pins like RST, AN etc as chipselect (eg.
SPI Extend Click). Thus, `spi-cs` and `spi-cs-names` property is added
to allow mikroBUS addon board to specify chipselect by name.

Here's the list of pins in mikroBUS connector:
AN - Analog
RST - Reset
CS - SPI Chip Select
SCK - SPI Clock
MISO - SPI Master Input Slave Output
MOSI - SPI Master Output Slave Input
+3.3V - VCC-3.3V power
GND - Reference Ground
PWM - PWM output
INT - Hardware Interrupt
RX - UART Receive
TX - UART Transmit
SCL - I2C Clock
SDA - I2C Data
+5V - VCC-5V power
GND - Reference Ground

Link: https://www.mikroe.com/mikrobus
Link:
https://download.mikroe.com/documents/standards/mikrobus/mikrobus-standard-specification-v200.pdf
mikroBUS specification
Link: https://www.mikroe.com/sht1x-click SHT15 Click
Link: https://www.mikroe.com/eth-click ENC28J60 Click
Link: https://www.mikroe.com/spi-extend-click SPI Extend Click

Co-developed-by: Vaishnav M A <vaishnav@beagleboard.org>
Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
 .../bindings/connector/mikrobus-connector.yaml     | 107 +++++++++++++++++++++
 MAINTAINERS                                        |   6 ++
 2 files changed, 113 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/mikrobus-connector.yaml b/Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
new file mode 100644
index 000000000000..033479f8604f
--- /dev/null
+++ b/Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/connector/mikrobus-connector.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: mikroBUS add-on board connector
+
+maintainers:
+  - Ayush Singh <ayush@beagleboard.org>
+
+properties:
+  compatible:
+    const: mikrobus-connector
+
+  pinctrl-0: true
+  pinctrl-1: true
+  pinctrl-2: true
+  pinctrl-3: true
+  pinctrl-4: true
+  pinctrl-5: true
+  pinctrl-6: true
+  pinctrl-7: true
+  pinctrl-8: true
+
+  pinctrl-names:
+    minItems: 1
+    maxItems: 9
+    items:
+      enum: [default, pwm_default, pwm_gpio, uart_default, uart_gpio, i2c_default, i2c_gpio, spi_default,
+             spi_gpio]
+
+  spi-controller:
+    description: spi-controller of mikroBUS SPI pins along with cs pins.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  spi-cs:
+    description: spi chip-select corresponding to the chip-selects on the mikrobus socket.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  spi-cs-names:
+    minItems: 1
+    maxItems: 12
+    items:
+      enum: [default, pwm, int, rx, tx, scl, sda, an, rst, sck, cipo, copi]
+
+  i2c-controller:
+    description: i2c controller attached to the mikrobus socket.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  uart-controller:
+    description: uart controller attached to the mikrobus socket
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  pwms:
+    description: the pwm-controller corresponding to the mikroBUS PWM pin.
+    maxItems: 1
+
+  mikrobus-gpios:
+    minItems: 1
+    maxItems: 12
+
+  mikrobus-gpio-names:
+    minItems: 1
+    maxItems: 12
+    items:
+      enum: [pwm, int, rx, tx, scl, sda, an, rst, cs, sck, cipo, copi]
+
+  board:
+    description: board attached to mikrobus connector
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
+required:
+  - compatible
+  - pinctrl-0
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    mikrobus {
+      compatible = "mikrobus-connector";
+      pinctrl-names = "default", "pwm_default", "pwm_gpio","uart_default", "uart_gpio", "i2c_default",
+                      "i2c_gpio", "spi_default", "spi_gpio";
+      pinctrl-0 = <&P2_03_gpio_input_pin &P1_04_gpio_pin &P1_02_gpio_pin>;
+      pinctrl-1 = <&P2_01_pwm_pin>;
+      pinctrl-2 = <&P2_01_gpio_pin>;
+      pinctrl-3 = <&P2_05_uart_pin &P2_07_uart_pin>;
+      pinctrl-4 = <&P2_05_gpio_pin &P2_07_gpio_pin>;
+      pinctrl-5 = <&P2_09_i2c_pin &P2_11_i2c_pin>;
+      pinctrl-6 = <&P2_09_gpio_pin &P2_11_gpio_pin>;
+      pinctrl-7 = <&P1_12_spi_pin &P1_10_spi_pin &P1_08_spi_sclk_pin &P1_06_spi_cs_pin>;
+      pinctrl-8 = <&P1_12_gpio_pin &P1_10_gpio_pin &P1_08_gpio_pin &P1_06_gpio_pin>;
+      pwms = <&ehrpwm1 0 500000 0>;
+      i2c-controller = <&i2c1>;
+      uart-controller = <&uart1>;
+      spi-controller = <&spi1>;
+      spi-cs = <0 1>;
+      spi-cs-names = "default", "rst";
+      mikrobus-gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>, <&gpio0 23 GPIO_ACTIVE_HIGH>,
+                       <&gpio0 30 GPIO_ACTIVE_HIGH>, <&gpio0 31 GPIO_ACTIVE_HIGH>,
+                       <&gpio0 15 GPIO_ACTIVE_HIGH>, <&gpio0 14 GPIO_ACTIVE_HIGH>,
+                       <&gpio0 4 GPIO_ACTIVE_HIGH>, <&gpio0 3 GPIO_ACTIVE_HIGH>,
+                       <&gpio0 2 GPIO_ACTIVE_HIGH>, <&gpio0 5 GPIO_ACTIVE_HIGH>,
+                       <&gpio2 25 GPIO_ACTIVE_HIGH>, <&gpio2 3 GPIO_ACTIVE_HIGH>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 807feae089c4..8e4115e93aeb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15108,6 +15108,12 @@ M:	Oliver Neukum <oliver@neukum.org>
 S:	Maintained
 F:	drivers/usb/image/microtek.*
 
+MIKROBUS
+M:	Ayush Singh <ayush@beagleboard.org>
+M:	Vaishnav M A <vaishnav@beagleboard.org>
+S:	Maintained
+F:	Documentation/devicetree/bindings/connector/mikrobus-connector.yaml
+
 MIKROTIK CRS3XX 98DX3236 BOARD SUPPORT
 M:	Luka Kovacic <luka.kovacic@sartura.hr>
 M:	Luka Perkov <luka.perkov@sartura.hr>

-- 
2.45.2


