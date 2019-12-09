Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 002ED1167E4
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2019 09:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfLIID1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Dec 2019 03:03:27 -0500
Received: from mga03.intel.com ([134.134.136.65]:36446 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbfLIID0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Dec 2019 03:03:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 00:03:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,294,1571727600"; 
   d="scan'208";a="210037587"
Received: from wwanmoha-ilbpg1.png.intel.com ([10.88.227.84])
  by fmsmga008.fm.intel.com with ESMTP; 09 Dec 2019 00:03:25 -0800
From:   wan.ahmad.zainie.wan.mohamad@intel.com
To:     linux-spi@vger.kernel.org
Cc:     wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH 1/6] dt-bindings: spi: Unify SPI DesignWare DT documents
Date:   Tue, 10 Dec 2019 00:03:58 +0800
Message-Id: <1575907443-26377-2-git-send-email-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1575907443-26377-1-git-send-email-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <1575907443-26377-1-git-send-email-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>

This patch will merge the content of the file spi-dw.txt into the file
snps,dw-apb-ssi.txt.

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
---
 .../devicetree/bindings/spi/snps,dw-apb-ssi.txt    | 23 ++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index 3ed08ee9feba..59904bdbef66 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -1,13 +1,21 @@
 Synopsys DesignWare AMBA 2.0 Synchronous Serial Interface.
 
 Required properties:
-- compatible : "snps,dw-apb-ssi" or "mscc,<soc>-spi", where soc is "ocelot" or
-  "jaguar2", or "amazon,alpine-dw-apb-ssi"
+
+- compatible : should be one of the following:
+  - "snps,dw-apb-ssi"
+  - "mscc,<soc>-spi", where soc is "ocelot" or "jaguar2"
+  - "amazon,alpine-dw-apb-ssi"
+
 - reg : The register base for the controller. For "mscc,<soc>-spi", a second
   register set is required (named ICPU_CFG:SPI_MST)
+
 - interrupts : One interrupt, used by the controller.
-- #address-cells : <1>, as required by generic SPI binding.
-- #size-cells : <0>, also as required by generic SPI binding.
+
+- #address-cells : <1>, as required by generic SPI binding. See spi-bus.txt.
+
+- #size-cells : <0>, also as required by generic SPI binding. See spi-bus.txt.
+
 - clocks : phandles for the clocks, see the description of clock-names below.
    The phandle for the "ssi_clk" is required. The phandle for the "pclk" clock
    is optional. If a single clock is specified but no clock-name, it is the
@@ -18,12 +26,15 @@ Optional properties:
     "ssi_clk", for the core clock used to generate the external SPI clock.
     "pclk", the interface clock, required for register access. If a clock domain
      used to enable this clock then it should be named "pclk_clkdomain".
+
 - cs-gpios : Specifies the gpio pins to be used for chipselects.
+
 - num-cs : The number of chipselects. If omitted, this will default to 4.
+
 - reg-io-width : The I/O register width (in bytes) implemented by this
-  device.  Supported values are 2 or 4 (the default).
+  device. Supported values are 2 or 4 (the default).
 
-Child nodes as per the generic SPI binding.
+Child nodes as per the generic SPI binding. See spi-bus.txt.
 
 Example:
 
-- 
1.9.1

