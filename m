Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F094F892C
	for <lists+linux-spi@lfdr.de>; Fri,  8 Apr 2022 00:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiDGVDq (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 7 Apr 2022 17:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiDGVDq (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 7 Apr 2022 17:03:46 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF1C16AA6B;
        Thu,  7 Apr 2022 14:01:44 -0700 (PDT)
Received: from tr.lan (ip-89-176-112-137.net.upcbroadband.cz [89.176.112.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5CC0D83C8E;
        Thu,  7 Apr 2022 23:01:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1649365303;
        bh=AOHlbhofFHJVmN7Sk4ICF9vJebLJmN3CTI+W2JwxY+s=;
        h=From:To:Cc:Subject:Date:From;
        b=g0dek7qVlEMl0Qs65rsfU8bE21HoWniu27GY0A4lHT7UAGzjXstLdd26en9fzH1DJ
         1PF5mKYYZIiRKIAPs36jgOdL4us5x9LoLZpI+frkfsJFIj9F9XD89xphJkBE5QzimW
         WBk3Ub2MQE7BeTssaGKR/BEffFSejga4Y+9aHwOw+TDEAprlbn5vPrqBZ9avk+qI1n
         H0i45rgN8f3gJjaPhfxzyXzD0xrnj/eE+tWE+7YYOfC4BOK9kdHak+zt+PAqIdig3P
         VMjS9d3XfhIjni4e/VqBPdMArazQPL3nJbBGPOvDz5cb0X4Z8RSbnBCTv7gkgrNcXO
         K03i8sqF5oJfQ==
From:   Marek Vasut <marex@denx.de>
To:     linux-spi@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>,
        Mark Brown <broonie@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH] dt-bindings: trivial-devices: Document CPLD on Menlo boards
Date:   Thu,  7 Apr 2022 23:01:31 +0200
Message-Id: <20220407210131.256045-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The CPLD on Menlo boards is used to operate custom hardware,
document the CPLD DT binding as trivial SPI device.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: NXP Linux Team <linux-imx@nxp.com>
To: linux-spi@vger.kernel.org
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index b2801b666078c..ac847043827d7 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -217,6 +217,8 @@ properties:
           - memsic,mxc6255
             # MEMSIC 3-axis accelerometer
           - memsic,mxc6655
+            # Menlo on-board CPLD trivial SPI device
+          - menlo,m53cpld
             # Microchip differential I2C ADC, 1 Channel, 18 bit
           - microchip,mcp3421
             # Microchip differential I2C ADC, 2 Channel, 18 bit
-- 
2.35.1

