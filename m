Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9F613BDFF
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jan 2020 12:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbgAOLAP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jan 2020 06:00:15 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:52580 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbgAOLAP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jan 2020 06:00:15 -0500
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: rWUf1hTYLw75fP3RQE0fAvy7m4O0YK5adefawMX1AZxtMQVNazk9Z76Q6YTpT118IyqrhylAFL
 VaZCa+fsLobkmOaQZl9lHOiRUfpnCDS2PlxI0GN+koy3OORfeJR6KP/zwiNjpqLuO4Tb/PJxN3
 PaJScgk43s/wCz68fzhWF12htNScIJCzAU1BP+S5YnILv/GH2kKwP7RyjX2uWrL1us26g+eFo2
 EZ/V50h4rltqBtpOK+IE98ekcDs6qo6IM0cKtp1T4frKSSq89CvR0zvbrY0WMSQAnVt3730mWz
 L/g=
X-IronPort-AV: E=Sophos;i="5.70,322,1574146800"; 
   d="scan'208";a="61145018"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jan 2020 04:00:14 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 15 Jan 2020 04:00:13 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 15 Jan 2020 04:00:09 -0700
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
Subject: [PATCH v4 3/5] dt-bindings: atmel-usart: add microchip,sam9x60-{usart, dbgu}
Date:   Wed, 15 Jan 2020 12:59:45 +0200
Message-ID: <1579085987-13976-4-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579085987-13976-1-git-send-email-claudiu.beznea@microchip.com>
References: <1579085987-13976-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add microchip,sam9x60-usart and add microchip,sam9x60-dbgu to DT
bindings documentation.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/mfd/atmel-usart.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/atmel-usart.txt b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
index 614a14b5d205..a09133066aff 100644
--- a/Documentation/devicetree/bindings/mfd/atmel-usart.txt
+++ b/Documentation/devicetree/bindings/mfd/atmel-usart.txt
@@ -4,8 +4,10 @@ Required properties for USART:
 - compatible: Should be one of the following:
 	- "atmel,at91rm9200-usart"
 	- "atmel,at91sam9260-usart"
+	- "microchip,sam9x60-usart"
 	- "atmel,at91rm9200-dbgu", "atmel,at91rm9200-usart"
 	- "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart"
+	- "microchip,sam9x60-dbgu", "microchip,sam9x60-usart"
 - reg: Should contain registers location and length
 - interrupts: Should contain interrupt
 - clock-names: tuple listing input clock names.
-- 
2.7.4

