Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8422901EC
	for <lists+linux-spi@lfdr.de>; Fri, 16 Oct 2020 11:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405632AbgJPJcF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Oct 2020 05:32:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:15842 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405578AbgJPJcF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Oct 2020 05:32:05 -0400
IronPort-SDR: eqNAZnWdn4jNonbMS20/OGJxJLKu3PVyffdvGLOUiMerA4dUsrmVJb3Ko2onpHjRDiIqDLWec/
 ZfsIwxriyjmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="228222250"
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="228222250"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 02:32:02 -0700
IronPort-SDR: N6+x7GqTHdWw/hR2rXfmbPOtsdY/3f8IxoDk1fq5+m7DU0HsqAE0aie8wxNeG5xbX4aYggY1+C
 J0GVmTDYCqaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="357326277"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Oct 2020 02:31:56 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     vigneshr@ti.com, tudor.ambarus@microchip.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, miquel.raynal@bootlin.com,
        simon.k.r.goldschmidt@gmail.com, dinguyen@kernel.org,
        richard@nod.at, cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v1 3/6] dt-bindings: spi: Add compatible for Intel LGM SoC
Date:   Fri, 16 Oct 2020 17:31:35 +0800
Message-Id: <20201016093138.28871-4-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201016093138.28871-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20201016093138.28871-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Add compatible string for Intel LGM SoC.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 Documentation/devicetree/bindings/spi/cadence-quadspi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml b/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
index 6ed8122a1326..8b1e01159d2d 100644
--- a/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
+++ b/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
@@ -18,6 +18,7 @@ properties:
       - const: cdns,qspi-nor
       - const: ti,k2g-qspi, cdns,qspi-nor
       - const: ti,am654-ospi, cdns,qspi-nor
+      - const: intel,lgm-qspi, cdns,qspi-nor
 
     description:
       Should be one of the above supported compatible strings.
-- 
2.11.0

