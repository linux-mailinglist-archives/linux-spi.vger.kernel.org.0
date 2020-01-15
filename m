Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63DA613BDFB
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jan 2020 12:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730037AbgAOLAL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jan 2020 06:00:11 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:41300 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbgAOLAK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jan 2020 06:00:10 -0500
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: MaOFfNFTs9alxrjycrqIYBAJp43q2qBcL/6RbTBRSV3ubw97WuXB60VNJnN+t2pVFQoH8h+IKZ
 X8/GuPj+RLsSUxROCE/40hiSGdDdWJRh6aM0xHlhFZMHMT7oos/GVlgj6tXxgVkMV6mvdzkVeV
 l3y7k0jPsSSpatfWLtGe944ommr9zqMOM9fYBell8CgeFU1F7qAjuLuBYaFc8P5mYwpruMRipE
 2tLD6Eu5o2N1JGQlnXgfZn42Ck155VqyWpLoxJRQ2fhDj1s5j8yaxgqUAvco/8hD4mGYuPkgJ7
 RaU=
X-IronPort-AV: E=Sophos;i="5.70,322,1574146800"; 
   d="scan'208";a="63325764"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jan 2020 04:00:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 15 Jan 2020 04:00:09 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 15 Jan 2020 04:00:04 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <richard.genoud@gmail.com>, <radu_nicolae.pirea@upb.ro>,
        <lee.jones@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <a.zummo@towertech.it>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rtc@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v4 2/5] dt-bindings: atmel-usart: remove wildcard
Date:   Wed, 15 Jan 2020 12:59:44 +0200
Message-ID: <1579085987-13976-3-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579085987-13976-1-git-send-email-claudiu.beznea@microchip.com>
References: <1579085987-13976-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Remove chip whildcard and introduce the list of compatibles instead.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/mfd/atmel-usart.txt | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/atmel-usart.txt b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
index 699fd3c9ace8..614a14b5d205 100644
--- a/Documentation/devicetree/bindings/mfd/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
@@ -1,10 +1,11 @@
 * Atmel Universal Synchronous Asynchronous Receiver/Transmitter (USART)
 
 Required properties for USART:
-- compatible: Should be "atmel,<chip>-usart" or "atmel,<chip>-dbgu"
-  The compatible <chip> indicated will be the first SoC to support an
-  additional mode or an USART new feature.
-  For the dbgu UART, use "atmel,<chip>-dbgu", "atmel,<chip>-usart"
+- compatible: Should be one of the following:
+	- "atmel,at91rm9200-usart"
+	- "atmel,at91sam9260-usart"
+	- "atmel,at91rm9200-dbgu", "atmel,at91rm9200-usart"
+	- "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart"
 - reg: Should contain registers location and length
 - interrupts: Should contain interrupt
 - clock-names: tuple listing input clock names.
-- 
2.7.4

