Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F27766A87
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jul 2023 12:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbjG1K3O (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jul 2023 06:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbjG1K2x (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jul 2023 06:28:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50BB3C3C;
        Fri, 28 Jul 2023 03:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690540078; x=1722076078;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=p7AIHi1RFTLbAcGhYX039b6uV3j7YsXbjesnlpkDBZM=;
  b=1+QMwg34GnOl+IiCtHs85/1uF29kZdmA44sQ/hSoOOBKtplI0zEAAO/T
   nFfJDQTBWRL3jMt807sI40xBD9YFs1IjXncKxl3M8kuiuQnqQ6GKKHWtt
   hLX13p7n06Dp2aFXQlbgHb6w0wlZyzpgyfTVACVqfH/SwThq7RsRVH1Dd
   VJzpliN2O0G/MvXEE1JpcnQ/zAwUMnuBvi1U6ys95cliBlafODj0JshC2
   jFg9nH1/xRLjNirDaEeEVykDNtBPIzfMfTLdDqaIhJSH7rFuShR6TsQa4
   AOPnRsZhGh40oVAZeT7X4Xc1mqlSbT6e2ll6ggn096j3P3qFcM8GnQEbn
   A==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="238401551"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 03:27:39 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 03:27:39 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 28 Jul 2023 03:27:33 -0700
From:   Varshini Rajendran <varshini.rajendran@microchip.com>
To:     <richard.genoud@gmail.com>, <radu_nicolae.pirea@upb.ro>,
        <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <varshini.rajendran@microchip.com>
Subject: [PATCH v3 25/50] dt-bindings: serial: atmel,at91-usart: add compatible for sam9x7
Date:   Fri, 28 Jul 2023 15:57:30 +0530
Message-ID: <20230728102730.266557-1-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add sam9x7 compatible to DT bindings documentation.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 .../devicetree/bindings/serial/atmel,at91-usart.yaml     | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
index 30b2131b5860..42644d0f1104 100644
--- a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
+++ b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
@@ -17,6 +17,7 @@ properties:
           - atmel,at91rm9200-usart
           - atmel,at91sam9260-usart
           - microchip,sam9x60-usart
+          - microchip,sam9x7-usart
       - items:
           - const: atmel,at91rm9200-dbgu
           - const: atmel,at91rm9200-usart
@@ -28,6 +29,14 @@ properties:
           - const: microchip,sam9x60-usart
           - const: atmel,at91sam9260-dbgu
           - const: atmel,at91sam9260-usart
+      - items:
+          - const: microchip,sam9x7-usart
+          - const: atmel,at91sam9260-usart
+      - items:
+          - const: microchip,sam9x7-dbgu
+          - const: microchip,sam9x7-usart
+          - const: atmel,at91sam9260-dbgu
+          - const: atmel,at91sam9260-usart
 
   reg:
     maxItems: 1
-- 
2.25.1

