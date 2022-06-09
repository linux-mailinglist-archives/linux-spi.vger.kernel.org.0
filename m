Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10D2544640
	for <lists+linux-spi@lfdr.de>; Thu,  9 Jun 2022 10:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242046AbiFIInJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 9 Jun 2022 04:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242375AbiFIIlE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 9 Jun 2022 04:41:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7AF3F312;
        Thu,  9 Jun 2022 01:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654764028; x=1686300028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cQClDcPdQDw6er2oANNg2FH3H+GiDQz9mQhN/hbk1Wc=;
  b=C4WYZ6MC+2Cp2TduwDD1wZQw6BCYsDUbuEKM+LU7FWcZLcJCFY8TUquZ
   Ga+9ciIL4mvqRgjqCte5Ts3l6xi+83miFOD5LgKIdb+1YKgWPvoR5SbPs
   OeJTSmp33dORPLUIvUKVh1Oj5Y/Ue1Az7TJOD6bS8zIMrRD2c0aFU8ff/
   AN4MQzqKWJomlgHi/dMSyDfDd5O325hbTbwlicjduq9Lc7jjmKOJG5ElG
   5wCrTTCTtEoglsv6MaEhbz+MksTb2a8XD3ny4Jc4j3FYc9AUiOUMpQbxM
   DpXfXPBtlUd3lMcT96YPAFtzH6LcYApU7gmsWolWx4DSxw3MxUAKh6+QO
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="167405373"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2022 01:40:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Jun 2022 01:40:23 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 9 Jun 2022 01:40:21 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <broonie@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <tudor.ambarus@microchip.com>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/3] spi: atmel-quadspi: use pm_ptr()
Date:   Thu, 9 Jun 2022 11:42:45 +0300
Message-ID: <20220609084246.1795419-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220609084246.1795419-1-claudiu.beznea@microchip.com>
References: <20220609084246.1795419-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Use pm_ptr() for atmel_quadspi_pm_ops.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/spi/atmel-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 6a9327f3c5b4..dea8a0311aaa 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -786,7 +786,7 @@ static struct platform_driver atmel_qspi_driver = {
 	.driver = {
 		.name	= "atmel_qspi",
 		.of_match_table	= atmel_qspi_dt_ids,
-		.pm	= &atmel_qspi_pm_ops,
+		.pm	= pm_ptr(&atmel_qspi_pm_ops),
 	},
 	.probe		= atmel_qspi_probe,
 	.remove		= atmel_qspi_remove,
-- 
2.34.1

