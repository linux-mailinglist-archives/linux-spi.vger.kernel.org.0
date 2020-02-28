Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC4E2172FE9
	for <lists+linux-spi@lfdr.de>; Fri, 28 Feb 2020 05:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbgB1EjM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 27 Feb 2020 23:39:12 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46865 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730802AbgB1EjM (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 27 Feb 2020 23:39:12 -0500
Received: by mail-pf1-f193.google.com with SMTP id o24so1028660pfp.13;
        Thu, 27 Feb 2020 20:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uF8mAHKuVrBMGB/o7w8S6JooN7hmaPGPaRRfbIuRXNQ=;
        b=EswBM+L5uO9lt08OsOVjEALPl9n2xaPJU0Jos91e8cKEj52knpHB6sSN+GvWfvuFPK
         B9deXez3/sspraDtYg+4Wgwbgj7ZMSC4ovJwGmv63HPyG+Rx6UWHIrTiG4YINTMMFvmI
         5BRMbpq42tTEIdIwyvGYm+XLX88oJYSJ6mUSpveiA6neWIRY1CSnadOThY481rw4k7uH
         dHKTA9ziiDsZegJPcMptruU+nc7Iey4k1cTq3A5jVq4ZTw123pomXXXtlSAMhrREfqQo
         dq1nbUUJsU1dhUeiCCCX+/Ys8KkAlh6EVrY2Zw0ZIm2uu1ZmGZ/dkkdYmghtDMlsvd73
         OIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uF8mAHKuVrBMGB/o7w8S6JooN7hmaPGPaRRfbIuRXNQ=;
        b=iJyPxmGayz60SoTkMV/I+W2mz4Gj6e4qrakF7HxcE8yTCpjTQUiEeVjhh1zdK+y8D7
         pWUCY7AIx8EQJQSVB/frZiODJ99Sxtk1HaDbdGbS2GOv0WjLUUbav3v8LSG9KssY8Jie
         FoFk8pPtRbEZApyDmUXKe7tRDmdQvqMWaF1Dl/1GR/vg1SCcMR6yulsM5PRFeIv10Ukv
         /hKM0MKNi7UdBTCWEtdzIr3ekJH7QJPXdZ/gnCL0cdV/kRDMOBPOq3G0yQVXBZrZF86A
         hj0hzJ05yR2seNVHE82+/oehE1fd7qJAHRTfQ2wfY+ePVBgEQ2X6zzpT210Y2hiJn31L
         cTrQ==
X-Gm-Message-State: APjAAAXzPvEY6kzr1bsIdgvISYNNNOsFZiBnWggi9zHV1hqlfZEZxRE7
        q6aOAghtOT4Pna0eTXx4iqk=
X-Google-Smtp-Source: APXvYqwLnm8ZWgco6AvNyOSQTTaYimGi7aF9mQhbEFhn4oFvft6Cb2wnkGLtkrsLqx05v2yNPHNkYQ==
X-Received: by 2002:a62:7681:: with SMTP id r123mr2518129pfc.169.1582864750963;
        Thu, 27 Feb 2020 20:39:10 -0800 (PST)
Received: from localhost.localdomain ([240e:379:962:6595:7b84:9990:1a82:371c])
        by smtp.gmail.com with ESMTPSA id 196sm9069047pfy.86.2020.02.27.20.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 20:39:10 -0800 (PST)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/4] dt-bindings: convert mtk-quadspi binding doc for spi-mtk-nor
Date:   Fri, 28 Feb 2020 12:36:35 +0800
Message-Id: <20200228043636.559915-4-gch981213@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200228043636.559915-1-gch981213@gmail.com>
References: <20200228043636.559915-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

spi-mtk-nor is a driver to replace mtk-quadspi and they have almost
the same device-tree bindings. Reuse this binding documentation and
convert it for new driver:

1. "Mediatek SoCs" -> "Mediatek ARM SoCs" because MTK MIPS SoCs
   use different controllers.
2. document "interrupts" as a required property because it's
   available on all SoCs with this controller and new driver takes
   advantages of it. It's implemented as optional only to maintain
   backward compatibility.
3. replace binding example with a mt7629 one because this is the
   only one I know the interrupt assignment.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
Change since v1:
 none

 .../mtk-quadspi.txt => spi/spi-mtk-nor.txt}   | 34 ++++++++-----------
 1 file changed, 15 insertions(+), 19 deletions(-)
 rename Documentation/devicetree/bindings/{mtd/mtk-quadspi.txt => spi/spi-mtk-nor.txt} (62%)

diff --git a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt b/Documentation/devicetree/bindings/spi/spi-mtk-nor.txt
similarity index 62%
rename from Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
rename to Documentation/devicetree/bindings/spi/spi-mtk-nor.txt
index a12e3b5c495d..829da480b9a9 100644
--- a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-mtk-nor.txt
@@ -1,4 +1,4 @@
-* Serial NOR flash controller for MediaTek SoCs
+* SPI NOR flash controller for MediaTek ARM SoCs
 
 Required properties:
 - compatible: 	  For mt8173, compatible should be "mediatek,mt8173-nor",
@@ -13,6 +13,7 @@ Required properties:
 		  "mediatek,mt7629-nor", "mediatek,mt8173-nor"
 		  "mediatek,mt8173-nor"
 - reg: 		  physical base address and length of the controller's register
+- interrupts:	  Interrupt number used by the controller.
 - clocks: 	  the phandle of the clocks needed by the nor controller
 - clock-names: 	  the names of the clocks
 		  the clocks should be named "spi" and "sf". "spi" is used for spi bus,
@@ -22,29 +23,24 @@ Required properties:
 - #address-cells: should be <1>
 - #size-cells:	  should be <0>
 
-The SPI flash must be a child of the nor_flash node and must have a
-compatible property. Also see jedec,spi-nor.txt.
-
-Required properties:
-- compatible:	  May include a device-specific string consisting of the manufacturer
-		  and name of the chip. Must also include "jedec,spi-nor" for any
-		  SPI NOR flash that can be identified by the JEDEC READ ID opcode (0x9F).
-- reg :		  Chip-Select number
+There should be only one spi slave device following generic spi bindings.
+It's not recommended to use this controller for devices other than SPI NOR
+flash due to limited transfer capability of this controller.
 
 Example:
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/mt7629-clk.h>
 
-nor_flash: spi@1100d000 {
-	compatible = "mediatek,mt8173-nor";
-	reg = <0 0x1100d000 0 0xe0>;
-	clocks = <&pericfg CLK_PERI_SPI>,
-		 <&topckgen CLK_TOP_SPINFI_IFR_SEL>;
+spi_nor: spi@11014000 {
+	compatible = "mediatek,mt7629-nor",
+		     "mediatek,mt8173-nor";
+	reg = <0x11014000 0xe0>;
+	interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_LOW>;
+	clocks = <&pericfg CLK_PERI_FLASH_PD>,
+		 <&topckgen CLK_TOP_FLASH_SEL>;
 	clock-names = "spi", "sf";
 	#address-cells = <1>;
 	#size-cells = <0>;
-
-	flash@0 {
-		compatible = "jedec,spi-nor";
-		reg = <0>;
-	};
 };
 
-- 
2.24.1

