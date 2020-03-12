Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3620A182F3E
	for <lists+linux-spi@lfdr.de>; Thu, 12 Mar 2020 12:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgCLLbz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Mar 2020 07:31:55 -0400
Received: from mga09.intel.com ([134.134.136.24]:28073 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgCLLbz (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 12 Mar 2020 07:31:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 04:31:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,544,1574150400"; 
   d="scan'208";a="389575880"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga004.jf.intel.com with ESMTP; 12 Mar 2020 04:31:53 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH 4/7] dt-bindings: spi: dw-apb-ssi: Add compatible string for DesignWare DWC_ssi
Date:   Thu, 12 Mar 2020 19:31:26 +0800
Message-Id: <20200312113129.8198-5-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200312113129.8198-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200312113129.8198-1-wan.ahmad.zainie.wan.mohamad@intel.com>
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
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index 57a789f5d9f3..36371654ea95 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -23,6 +23,8 @@ properties:
           - const: amazon,alpine-dw-apb-ssi
       - items:
           - const: snps,dw-apb-ssi
+      - items:
+          - const: snps,dwc-ssi-1.01a
 
   reg:
     minItems: 1
-- 
2.17.1

