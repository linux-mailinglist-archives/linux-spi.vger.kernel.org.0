Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7251167E5
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2019 09:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfLIID2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Dec 2019 03:03:28 -0500
Received: from mga03.intel.com ([134.134.136.65]:36446 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbfLIID1 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Dec 2019 03:03:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 00:03:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,294,1571727600"; 
   d="scan'208";a="210037593"
Received: from wwanmoha-ilbpg1.png.intel.com ([10.88.227.84])
  by fmsmga008.fm.intel.com with ESMTP; 09 Dec 2019 00:03:26 -0800
From:   wan.ahmad.zainie.wan.mohamad@intel.com
To:     linux-spi@vger.kernel.org
Cc:     wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH 2/6] dt-bindings: spi: Delete spi-dw.txt
Date:   Tue, 10 Dec 2019 00:03:59 +0800
Message-Id: <1575907443-26377-3-git-send-email-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1575907443-26377-1-git-send-email-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <1575907443-26377-1-git-send-email-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>

This patch will delete the file spi-dw.txt since compatible string
"snps,designware-spi" is not being used anywhere.

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
---
 Documentation/devicetree/bindings/spi/spi-dw.txt | 24 ------------------------
 1 file changed, 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/spi/spi-dw.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-dw.txt b/Documentation/devicetree/bindings/spi/spi-dw.txt
deleted file mode 100644
index 7b63ed601990..000000000000
--- a/Documentation/devicetree/bindings/spi/spi-dw.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-Synopsys DesignWare SPI master
-
-Required properties:
-- compatible: should be "snps,designware-spi"
-- #address-cells: see spi-bus.txt
-- #size-cells: see spi-bus.txt
-- reg: address and length of the spi master registers
-- interrupts: should contain one interrupt
-- clocks: spi clock phandle
-- num-cs: see spi-bus.txt
-
-Optional properties:
-- cs-gpios: see spi-bus.txt
-
-Example:
-
-spi: spi@4020a000 {
-	compatible = "snps,designware-spi";
-	interrupts = <11 1>;
-	reg = <0x4020a000 0x1000>;
-	clocks = <&pclk>;
-	num-cs = <2>;
-	cs-gpios = <&banka 0 0>;
-};
-- 
1.9.1

