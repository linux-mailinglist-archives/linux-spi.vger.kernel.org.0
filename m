Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509E5212513
	for <lists+linux-spi@lfdr.de>; Thu,  2 Jul 2020 15:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgGBNqr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 2 Jul 2020 09:46:47 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:40176 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbgGBNqr (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 2 Jul 2020 09:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593697607; x=1625233607;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=npTNr8twP/tyLNtM3PSd3ahFvXvXe/yaEybXuDL7ItU=;
  b=H7qg5TDCWJd4LCgSbz64hN631JCpsmHFHRqAJlPnJ3OwKCbGOd/hSAUZ
   e4klBvWqg9gKpohMvZQcOM/1H2QEWwmFfNmpufBV3OToCg72Fs0xq+nic
   Aptep0L35ZQQd/GCM9fhkElAxTqiwQXVcSJG1BNLDohNJAW05hsLjpBTq
   Wu/exJfMKVM66SdFr1/EOa0G0EoeaW1vslAqBuZ+WEjnWQPyLLYeryGmD
   1KZzZ9asrv9g+89F8uOja4f/6PwJ0o4T9U3/D78vCLRD7Vcy+AX2R5DCc
   0HE5/j2+UoHt8mkp8MUE/ljBcpylj5x+4FnWF/6FweR1yQz/ySXx5tTZL
   A==;
IronPort-SDR: OGNPd1Jr05acijLqDonYJw21klvbQUik4rG4Uo+B+UvaJ9paa1izCinxXA64RieVLRcf+RS61G
 qvsDcMBeQEulK8aHy8XRx+OZBOG7sfVu1t7xY/4GlVow410jmtbpI2x3JuVCXtOg33Xp6Jtb2a
 b7sUrKxb7lOeiMn1O+CGzBox9gy3wUnpzCDw4RyuFxERXIIsexEDn8aY67SeQ1KU7wNp/TFing
 J0MdUYaVsL6t3NQfwhXWit//au+7oWsmuVvGpzVKw4MxMybd3kd9WXFZLawDvqR/Jq3ThVDDcU
 ihM=
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="82397838"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Jul 2020 06:46:46 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 2 Jul 2020 06:46:46 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 2 Jul 2020 06:46:21 -0700
From:   <nicolas.ferre@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>, <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH] MAINTAINERS: Change Maintainer for some at91 drivers
Date:   Thu, 2 Jul 2020 15:42:24 +0200
Message-ID: <20200702134224.3750-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

I hand over the maintenance of these drivers to my colleagues. Claudiu,
Codrin and Tudor already have experience with these controllers and
sub-systems.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
Mark, Sebastian,

I kept these entries together as it may generate conflicts if handled
separately. I suggest that Mark take the chunk as maintainer of SPI and
Audio sub-systems.
Anyway, don't hesitate to tell me if I should handle this change
differently or at another time during the development cycle.

Best regards,
  Nicolas

 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 496fd4eafb68..1c1527a34d99 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11333,17 +11333,17 @@ F:	drivers/iio/adc/at91-sama5d2_adc.c
 F:	include/dt-bindings/iio/adc/at91-sama5d2_adc.h
 
 MICROCHIP SAMA5D2-COMPATIBLE SHUTDOWN CONTROLLER
-M:	Nicolas Ferre <nicolas.ferre@microchip.com>
+M:	Claudiu Beznea <claudiu.beznea@microchip.com>
 S:	Supported
 F:	drivers/power/reset/at91-sama5d2_shdwc.c
 
 MICROCHIP SPI DRIVER
-M:	Nicolas Ferre <nicolas.ferre@microchip.com>
+M:	Tudor Ambarus <tudor.ambarus@microchip.com>
 S:	Supported
 F:	drivers/spi/spi-atmel.*
 
 MICROCHIP SSC DRIVER
-M:	Nicolas Ferre <nicolas.ferre@microchip.com>
+M:	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	drivers/misc/atmel-ssc.c
-- 
2.27.0

