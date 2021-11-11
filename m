Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEB544D219
	for <lists+linux-spi@lfdr.de>; Thu, 11 Nov 2021 07:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhKKG5R (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 11 Nov 2021 01:57:17 -0500
Received: from mga11.intel.com ([192.55.52.93]:34073 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230400AbhKKG5Q (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 11 Nov 2021 01:57:16 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="230324727"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="230324727"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 22:54:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="642864895"
Received: from ubuntu18.png.intel.com ([10.88.229.69])
  by fmsmga001.fm.intel.com with ESMTP; 10 Nov 2021 22:54:23 -0800
From:   nandhini.srikandan@intel.com
To:     fancer.lancer@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        rashmi.a@intel.com
Subject: [PATCH v3 1/5] dt-bindings: spi: Add SSTE support for DWC SSI controller
Date:   Thu, 11 Nov 2021 14:51:57 +0800
Message-Id: <20211111065201.10249-2-nandhini.srikandan@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211111065201.10249-1-nandhini.srikandan@intel.com>
References: <20211111065201.10249-1-nandhini.srikandan@intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Nandhini Srikandan <nandhini.srikandan@intel.com>

Add Slave Select Toggle Enable(SSTE) support for DWC SSI controller.

Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index ca91201a9926..866416d01e94 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -149,6 +149,12 @@ patternProperties:
           is an optional feature of the designware controller, and the
           upper limit is also subject to controller configuration.
 
+      snps,sste:
+        description: Slave select line will toggle between consecutive
+          data frames, with the serial clock being held to its default
+          value while slave select line is high.
+        type: boolean
+
 unevaluatedProperties: false
 
 required:
-- 
2.17.1

