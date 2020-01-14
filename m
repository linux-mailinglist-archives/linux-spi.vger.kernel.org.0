Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9074813A753
	for <lists+linux-spi@lfdr.de>; Tue, 14 Jan 2020 11:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbgANKXo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 14 Jan 2020 05:23:44 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:50521 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729638AbgANKXm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 14 Jan 2020 05:23:42 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: UPBRsxwdg7cVboIF7Xz5TfzLjGwahOYqBxXCYicHf/tctOE84wQwVAe/7pUQOKCxh1krbuEtXi
 l43ufSX010+iVkt8/hlTu0QUrf8X6gfnGVbZ06iFzL1gIzFpbTTvNxV5M8CNa/Mjo4PeHEDqNv
 ZJVHQ7yTqxe1paB2i6RvQxs+Cna1kn8VNMtdhD59g0J/cH0jDtgjCGijzwaPcWOzjISCdsih2X
 kTuQoeZMjCX/7PLmk0Q9DdY19xUExdgDr5jNu6jfuF1Xh7YsAv90g+epKBDP5tqibQGxabXJNp
 T44=
X-IronPort-AV: E=Sophos;i="5.69,432,1571727600"; 
   d="scan'208";a="61849239"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jan 2020 03:23:42 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 14 Jan 2020 03:23:41 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.85.251) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Tue, 14 Jan 2020 03:23:37 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <lee.jones@linaro.org>,
        <mark.rutland@arm.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>,
        <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
        <a.zummo@towertech.it>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 3/7] dt-bindings: atmel,at91rm9200-rtc: add microchip,sam9x60-rtc
Date:   Tue, 14 Jan 2020 12:23:13 +0200
Message-ID: <1578997397-23165-4-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578997397-23165-1-git-send-email-claudiu.beznea@microchip.com>
References: <1578997397-23165-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add microchip,sam9x60-rtc to DT bindings documentation.

Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Rob Herring <robh@kernel.org>
---

Hi Alexandre,

I kept this patch as in v1 (same for patch
"dt-bindings: atmel-tcb: add microchip,sam9x60-tcb").
I'm waiting your response to this version and take an action aftewards.

Thank you,
Claudiu Beznea

 Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt
index 5d3791e789c6..35eab9138d0b 100644
--- a/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/atmel,at91rm9200-rtc.txt
@@ -1,7 +1,8 @@
 Atmel AT91RM9200 Real Time Clock
 
 Required properties:
-- compatible: should be: "atmel,at91rm9200-rtc" or "atmel,at91sam9x5-rtc"
+- compatible: should be: "atmel,at91rm9200-rtc", "atmel,at91sam9x5-rtc" or
+  "microchip,sam9x60-rtc"
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: rtc alarm/event interrupt
-- 
2.7.4

