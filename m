Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B781C3AD0
	for <lists+linux-spi@lfdr.de>; Mon,  4 May 2020 15:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgEDNEi (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 May 2020 09:04:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:6156 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726660AbgEDNEh (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 4 May 2020 09:04:37 -0400
IronPort-SDR: MMDZHUg+UlLhHvR6Y5PMY0sDozXHLXj9x85BLirYhWtWFeMXz9AYW7rsxRdjLVc+vVkZfqdZMV
 li0oGtiJn9vg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 06:04:00 -0700
IronPort-SDR: VfPxaO3d5Pta7yhcFCav7keMRILjwPMES74yCvUPuw/XU3NFkPd8cimQufimzVd9evQKXzIKfV
 ayvEVp2zQUgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,352,1583222400"; 
   d="scan'208";a="249169114"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by fmsmga007.fm.intel.com with ESMTP; 04 May 2020 06:03:59 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v4 4/7] dt-bindings: spi: dw-apb-ssi: Add compatible string for DesignWare DWC_ssi
Date:   Mon,  4 May 2020 21:02:43 +0800
Message-Id: <20200504130246.5135-5-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200504130246.5135-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200504130246.5135-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch adds compatible string "snps,dwc-ssi-1.01a" to the above DT
binding document, to provide support for DesignWare DWC_ssi IP [1].

Current driver supports DW_apb_ssi IP [2].

References:
[1] https://www.synopsys.com/dw/ipdir.php?c=dwc_ssi
[2] https://www.synopsys.com/dw/ipdir.php?c=DW_apb_ssi

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index 3ed08ee9feba..2ead46b633ea 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -2,7 +2,7 @@ Synopsys DesignWare AMBA 2.0 Synchronous Serial Interface.
 
 Required properties:
 - compatible : "snps,dw-apb-ssi" or "mscc,<soc>-spi", where soc is "ocelot" or
-  "jaguar2", or "amazon,alpine-dw-apb-ssi"
+  "jaguar2", or "amazon,alpine-dw-apb-ssi", or "snps,dwc-ssi-1.01a"
 - reg : The register base for the controller. For "mscc,<soc>-spi", a second
   register set is required (named ICPU_CFG:SPI_MST)
 - interrupts : One interrupt, used by the controller.
-- 
2.17.1

