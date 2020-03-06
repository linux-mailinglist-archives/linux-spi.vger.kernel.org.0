Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5021517B8AF
	for <lists+linux-spi@lfdr.de>; Fri,  6 Mar 2020 09:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCFIwK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Mar 2020 03:52:10 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39959 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgCFIwJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Mar 2020 03:52:09 -0500
Received: by mail-pj1-f67.google.com with SMTP id gv19so801842pjb.5;
        Fri, 06 Mar 2020 00:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nq881lgKOLIIpdSUyUsX80ryCzlcWplNblDWi6QrHjg=;
        b=NLl10i5AccNBdKIbIqt9pT8dMCuGSSYYS1LjbO1HjGQdwI8vKEKBO+mdXNc+uSSqS1
         fMwNRW7OznarQdPmMxyMIRupOhalSm9SpwPnxDIvT+2JfANmiiiTroAWHmPdyyt9szlq
         BwQO1H/6nwYj+ULyvsLiS2VAvJp6VB1Y70dvN0q7ttCf6BWK/x7niF4O8ohp0mTAjlh8
         k1R5sL5Py/P02wmsKtTepnVCinnVnODB2j4OeB/OUI5idLWfTLOSEngxzqxpSjO4QnAx
         9eQpVKJfBa/LgbQpntyEh7u2Qy8Fmu2wUxABiDcjUdOdsJDlJtUQJBZOeuG0Li1j6HR0
         zK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nq881lgKOLIIpdSUyUsX80ryCzlcWplNblDWi6QrHjg=;
        b=P1VMvHedv1VcyGLjUMhZnfgaIdCCe/sLzw6zv/MUc89oV9j/FYGu5Q8StOul0EhsTv
         dFc/8pMDzIVYOM0/SAwCGvaMNi4tl9dNYeNoaOZzM0R1aLTeIPdAHlkHEQvGo4u2aiWe
         ywo0rKPW0Fc+NVKYOeMF63PuJimCZ1wUfPyneQl97vrSsFTk6qTQdD0ipcEcqRrtneHy
         WR8tEJOZhBQkqnmQ/RhzWetMIGTw+93DQ0HLNzFkcxURdIUwzo/MlF3gcRemHWUlKOFK
         PT4NbR5mBuSgohZgHLOIgmoTAxsBAzV5OAy4ItVYkkxZfLCvQKelYFFzuDWeZqJTktIC
         0v/A==
X-Gm-Message-State: ANhLgQ39QiyXLaNVOCY2b/YfuYy/SOY1Yxv0MmDXViqycUfT1NXNSZyg
        tGOxm7ci9rvlfHpwd2A5Iuc=
X-Google-Smtp-Source: ADFU+vv+kojzyPXMVD6IMwmecLqebvvVDZoQGqL3IKEa5XIcftV7rogWjU8t9o5E5BSegtwRB+Xm0w==
X-Received: by 2002:a17:90a:5d97:: with SMTP id t23mr2571919pji.61.1583484728328;
        Fri, 06 Mar 2020 00:52:08 -0800 (PST)
Received: from guoguo-omen.lan ([240e:379:94a:b53:8200:7767:6b7e:4da3])
        by smtp.gmail.com with ESMTPSA id s23sm8527334pjp.28.2020.03.06.00.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 00:52:07 -0800 (PST)
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
Subject: [PATCH v3 3/4] dt-bindings: convert mtk-quadspi binding doc for spi-mtk-nor
Date:   Fri,  6 Mar 2020 16:50:51 +0800
Message-Id: <20200306085052.28258-4-gch981213@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200306085052.28258-1-gch981213@gmail.com>
References: <20200306085052.28258-1-gch981213@gmail.com>
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
3. add a dummy interrupt binding in example.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
Change since v2:
 revert binding example replacement and add a dummy irq binding

Change since v1:
 none

 .../{mtd/mtk-quadspi.txt => spi/spi-mtk-nor.txt}  | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)
 rename Documentation/devicetree/bindings/{mtd/mtk-quadspi.txt => spi/spi-mtk-nor.txt} (75%)

diff --git a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt b/Documentation/devicetree/bindings/spi/spi-mtk-nor.txt
similarity index 75%
rename from Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
rename to Documentation/devicetree/bindings/spi/spi-mtk-nor.txt
index a12e3b5c495d..984ae7fd4f94 100644
--- a/Documentation/devicetree/bindings/mtd/mtk-quadspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-mtk-nor.txt
@@ -1,4 +1,4 @@
-* Serial NOR flash controller for MediaTek SoCs
+* Serial NOR flash controller for MediaTek ARM SoCs
 
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
@@ -22,20 +23,16 @@ Required properties:
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
 
 nor_flash: spi@1100d000 {
 	compatible = "mediatek,mt8173-nor";
 	reg = <0 0x1100d000 0 0xe0>;
+	interrupts = <&spi_flash_irq>;
 	clocks = <&pericfg CLK_PERI_SPI>,
 		 <&topckgen CLK_TOP_SPINFI_IFR_SEL>;
 	clock-names = "spi", "sf";
-- 
2.24.1

