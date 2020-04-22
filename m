Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 959531B46EC
	for <lists+linux-spi@lfdr.de>; Wed, 22 Apr 2020 16:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgDVOMr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Apr 2020 10:12:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:55662 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgDVOMr (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 22 Apr 2020 10:12:47 -0400
IronPort-SDR: wFEgjXgW1VZTtBDu927cKlY/fI1vUaMGkCN3/x4t1LKzytbgCFQKRYjgqjIqBK6X5Q3IB3aErr
 0D7K6WWKh9yg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 07:12:47 -0700
IronPort-SDR: KLKdE5Gvm1QKLjn2+SUX/DKq9mdjs3brJi3wI4tEJb9hMnMLseQJM9UJuo7dGbXJWKDzsPe+xf
 h4N+/8YMKSPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,414,1580803200"; 
   d="scan'208";a="402560772"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga004.jf.intel.com with ESMTP; 22 Apr 2020 07:12:45 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v2 4/7] dt-bindings: spi: dw-apb-ssi: Add compatible string for DesignWare DWC_ssi
Date:   Wed, 22 Apr 2020 22:11:39 +0800
Message-Id: <20200422141142.25591-5-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200422141142.25591-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200422141142.25591-1-wan.ahmad.zainie.wan.mohamad@intel.com>
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
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index f72bb0e6f630..f67852fb9d94 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -19,6 +19,7 @@ properties:
       - mscc,jaguar2-spi
       - amazon,alpine-dw-apb-ssi
       - snps,dw-apb-ssi
+      - snps,dwc-ssi-1.01a
 
   reg:
     minItems: 1
-- 
2.17.1

