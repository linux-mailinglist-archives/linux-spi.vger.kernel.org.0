Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F30D1C565C
	for <lists+linux-spi@lfdr.de>; Tue,  5 May 2020 15:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgEENHj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 5 May 2020 09:07:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:12710 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbgEENHj (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 5 May 2020 09:07:39 -0400
IronPort-SDR: JazBSQvQYmb6ptndYUFbmK8b/lh64wTqUgFIdIPQtSc/spXHRE0e97Mo17r8j+1owaGRcAXOdM
 rY5sclzAd6kw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 06:07:38 -0700
IronPort-SDR: 9GzR8BnnzfwCNABNZsjmiAx65g00H6Bf+zvo2c5DgVp+L/ChpvO9W0CZzdMRs7wbkKXVVqYRVm
 gVPx/Ob5GOqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,355,1583222400"; 
   d="scan'208";a="277868887"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga002.jf.intel.com with ESMTP; 05 May 2020 06:07:36 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v5 6/7] dt-bindings: spi: dw-apb-ssi: Add Intel Keem Bay support
Date:   Tue,  5 May 2020 21:06:17 +0800
Message-Id: <20200505130618.554-7-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200505130618.554-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200505130618.554-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Document Intel Keem Bay SPI controller DT bindings.

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index 2ead46b633ea..7a4702edf896 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -2,7 +2,8 @@ Synopsys DesignWare AMBA 2.0 Synchronous Serial Interface.
 
 Required properties:
 - compatible : "snps,dw-apb-ssi" or "mscc,<soc>-spi", where soc is "ocelot" or
-  "jaguar2", or "amazon,alpine-dw-apb-ssi", or "snps,dwc-ssi-1.01a"
+  "jaguar2", or "amazon,alpine-dw-apb-ssi", or "snps,dwc-ssi-1.01a" or
+  "intel,keembay-ssi"
 - reg : The register base for the controller. For "mscc,<soc>-spi", a second
   register set is required (named ICPU_CFG:SPI_MST)
 - interrupts : One interrupt, used by the controller.
-- 
2.17.1

