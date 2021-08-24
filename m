Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71073F5A4D
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 11:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbhHXJAw (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 05:00:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:21969 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234817AbhHXJAv (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 24 Aug 2021 05:00:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10085"; a="197517185"
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="scan'208";a="197517185"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 02:00:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,346,1620716400"; 
   d="scan'208";a="597515623"
Received: from ubuntu18.png.intel.com ([10.88.229.69])
  by fmsmga001.fm.intel.com with ESMTP; 24 Aug 2021 02:00:02 -0700
From:   nandhini.srikandan@intel.com
To:     fancer.lancer@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        rashmi.a@intel.com
Subject: [PATCH v2 1/2] dt-bindings: spi: Add bindings for Intel Thunder Bay SoC
Date:   Tue, 24 Aug 2021 16:58:55 +0800
Message-Id: <20210824085856.12714-2-nandhini.srikandan@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210824085856.12714-1-nandhini.srikandan@intel.com>
References: <20210824085856.12714-1-nandhini.srikandan@intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Nandhini Srikandan <nandhini.srikandan@intel.com>

Add documentation for SPI controller in Intel Thunder Bay SoC.

Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>
---
 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index ca91201a9926..88532bf8ba85 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -61,6 +61,8 @@ properties:
           - const: snps,dw-apb-ssi
       - description: Intel Keem Bay SPI Controller
         const: intel,keembay-ssi
+      - description: Intel Thunder Bay SPI Controller
+        const: intel,thunderbay-ssi
       - description: Baikal-T1 SPI Controller
         const: baikal,bt1-ssi
       - description: Baikal-T1 System Boot SPI Controller
-- 
2.17.1

