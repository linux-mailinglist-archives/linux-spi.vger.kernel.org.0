Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0C4F1167E6
	for <lists+linux-spi@lfdr.de>; Mon,  9 Dec 2019 09:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfLIID3 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 9 Dec 2019 03:03:29 -0500
Received: from mga03.intel.com ([134.134.136.65]:36446 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbfLIID2 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 9 Dec 2019 03:03:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Dec 2019 00:03:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,294,1571727600"; 
   d="scan'208";a="210037601"
Received: from wwanmoha-ilbpg1.png.intel.com ([10.88.227.84])
  by fmsmga008.fm.intel.com with ESMTP; 09 Dec 2019 00:03:27 -0800
From:   wan.ahmad.zainie.wan.mohamad@intel.com
To:     linux-spi@vger.kernel.org
Cc:     wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH 3/6] dt-bindings: snps,dw-apb-ssi: Add compatible string for DesignWare DWC_ssi
Date:   Tue, 10 Dec 2019 00:04:00 +0800
Message-Id: <1575907443-26377-4-git-send-email-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1575907443-26377-1-git-send-email-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <1575907443-26377-1-git-send-email-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>

This patch adds compatible string "snps,dwc-ssi-1.01a" to the above DT
binding document, to provide support for DesignWare DWC_ssi IP [1].

Current driver supports DW_apb_ssi IP [2].

References:
[1] https://www.synopsys.com/dw/ipdir.php?c=dwc_ssi
[2] https://www.synopsys.com/dw/ipdir.php?c=DW_apb_ssi

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
index 59904bdbef66..fccd4b0f91f5 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
@@ -6,6 +6,7 @@ Required properties:
   - "snps,dw-apb-ssi"
   - "mscc,<soc>-spi", where soc is "ocelot" or "jaguar2"
   - "amazon,alpine-dw-apb-ssi"
+  - "snps,dwc-ssi-1.01a"
 
 - reg : The register base for the controller. For "mscc,<soc>-spi", a second
   register set is required (named ICPU_CFG:SPI_MST)
-- 
1.9.1

