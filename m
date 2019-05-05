Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACC0E141C8
	for <lists+linux-spi@lfdr.de>; Sun,  5 May 2019 20:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfEESOw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 5 May 2019 14:14:52 -0400
Received: from mail-sender220.upb.ro ([141.85.13.220]:43770 "EHLO mx.upb.ro"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727628AbfEESOo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Sun, 5 May 2019 14:14:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by mx.upb.ro (Postfix) with ESMTP id 670D3B561907;
        Sun,  5 May 2019 21:09:09 +0300 (EEST)
Received: from mx.upb.ro ([127.0.0.1])
        by localhost (mx.upb.ro [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id nxcrwICMlK8C; Sun,  5 May 2019 21:09:07 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by mx.upb.ro (Postfix) with ESMTP id 85AD7B561905;
        Sun,  5 May 2019 21:09:07 +0300 (EEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.upb.ro 85AD7B561905
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=upb.ro;
        s=96342B8A-77E4-11E5-BA93-D93D0963A2DF; t=1557079747;
        bh=41JtH8Jj+flgBl1Ace2G9ACZKkR6R2qzxrWS7tbCzkI=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=gxNrrnDyGxRCJYo3F4IeNmnQITIvgNxRP/eNeirCG5vTK+48UTG5d7k/IyOK/KG0f
         K/yUty3ppo8QwqyhSvq1VhfVtSN6FFcNn2nIvYuOm1Egtok9HdpeTHgypraw+7tACV
         NXlrouPWvqXmy5qqSZ52WbrxDZY+W/nUHFFwDi/A=
X-Virus-Scanned: amavisd-new at upb.ro
Received: from mx.upb.ro ([127.0.0.1])
        by localhost (mx.upb.ro [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id q7M68MvjV5-S; Sun,  5 May 2019 21:09:07 +0300 (EEST)
Received: from localhost.localdomain (unknown [188.25.87.154])
        by mx.upb.ro (Postfix) with ESMTPSA id 5D3BDB5618E0;
        Sun,  5 May 2019 21:09:07 +0300 (EEST)
From:   Radu Pirea <radu_nicolae.pirea@upb.ro>
To:     Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Richard Genoud <richard.genoud@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/2] dt-bindings: mfd: atmel-usart: add DMA bindings for USART in SPI mode
Date:   Sun,  5 May 2019 21:06:45 +0300
Message-Id: <20190505180646.1442-2-radu_nicolae.pirea@upb.ro>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190505180646.1442-1-radu_nicolae.pirea@upb.ro>
References: <20190505180646.1442-1-radu_nicolae.pirea@upb.ro>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The bindings for DMA are now common for both drivers of the USART
IP.

The node given as an example for USART in SPI mode has been updated in
order to include DMA bindings.

Signed-off-by: Radu Pirea <radu_nicolae.pirea@upb.ro>
---
 .../devicetree/bindings/mfd/atmel-usart.txt   | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/atmel-usart.txt b/Docu=
mentation/devicetree/bindings/mfd/atmel-usart.txt
index 7f0cd72f47d2..699fd3c9ace8 100644
--- a/Documentation/devicetree/bindings/mfd/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
@@ -17,17 +17,24 @@ Required properties for USART in SPI mode:
 - cs-gpios: chipselects (internal cs not supported)
 - atmel,usart-mode : Must be <AT91_USART_MODE_SPI> (found in dt-bindings=
/mfd/at91-usart.h)
=20
+Optional properties in serial and SPI mode:
+- dma bindings for dma transfer:
+	- dmas: DMA specifier, consisting of a phandle to DMA controller node,
+		memory peripheral interface and USART DMA channel ID, FIFO configurati=
on.
+		The order of DMA channels is fixed. The first DMA channel must be TX
+		associated channel and the second one must be RX associated channel.
+		Refer to dma.txt and atmel-dma.txt for details.
+	- dma-names: "tx" for TX channel.
+		     "rx" for RX channel.
+		     The order of dma-names is also fixed. The first name must be "tx"
+		     and the second one must be "rx" as in the examples below.
+
 Optional properties in serial mode:
 - atmel,use-dma-rx: use of PDC or DMA for receiving data
 - atmel,use-dma-tx: use of PDC or DMA for transmitting data
 - {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI=
/DCD line respectively.
   It will use specified PIO instead of the peripheral function pin for t=
he USART feature.
   If unsure, don't specify this property.
-- add dma bindings for dma transfer:
-	- dmas: DMA specifier, consisting of a phandle to DMA controller node,
-		memory peripheral interface and USART DMA channel ID, FIFO configurati=
on.
-		Refer to dma.txt and atmel-dma.txt for details.
-	- dma-names: "rx" for RX channel, "tx" for TX channel.
 - atmel,fifo-size: maximum number of data the RX and TX FIFOs can store =
for FIFO
   capable USARTs.
 - rs485-rts-delay, rs485-rx-during-tx, linux,rs485-enabled-at-boot-time:=
 see rs485.txt
@@ -81,5 +88,8 @@ Example:
 		interrupts =3D <12 IRQ_TYPE_LEVEL_HIGH 5>;
 		clocks =3D <&usart0_clk>;
 		clock-names =3D "usart";
+		dmas =3D <&dma0 2 AT91_DMA_CFG_PER_ID(3)>,
+		       <&dma0 2 (AT91_DMA_CFG_PER_ID(4) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
+		dma-names =3D "tx", "rx";
 		cs-gpios =3D <&pioB 3 0>;
 	};
--=20
2.21.0

