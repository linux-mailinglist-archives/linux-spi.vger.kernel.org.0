Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A0729A685
	for <lists+linux-spi@lfdr.de>; Tue, 27 Oct 2020 09:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394843AbgJ0IXm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 27 Oct 2020 04:23:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:47716 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394733AbgJ0IXl (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 27 Oct 2020 04:23:41 -0400
IronPort-SDR: iKqw6xzw29QGgeQFwodomNrBPzxjVpjZYBlNGfIyFB+Ohlgh7/yIa7x2n1Hplt5Cf/MMYwC8Sl
 /ElTPdRnKeEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="185783008"
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; 
   d="scan'208";a="185783008"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 01:23:39 -0700
IronPort-SDR: d169Tah80hbP35bP19jTi2696U2hcxkvOSyEBYDFUQjRxIB4ioF/nxvka9WCt4OkzRb7bsvdLW
 BWyEkq1seigg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,423,1596524400"; 
   d="scan'208";a="322844147"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga006.jf.intel.com with ESMTP; 27 Oct 2020 01:23:20 -0700
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     broonie@kernel.org, vigneshr@ti.com, tudor.ambarus@microchip.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, miquel.raynal@bootlin.com,
        simon.k.r.goldschmidt@gmail.com, dinguyen@kernel.org,
        richard@nod.at, cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v4 6/6] dt-bindings: spi: Add compatible for Intel LGM SoC
Date:   Tue, 27 Oct 2020 16:22:51 +0800
Message-Id: <20201027082251.30056-7-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201027082251.30056-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20201027082251.30056-1-vadivel.muruganx.ramuthevar@linux.intel.com>
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
index da11cb3bedeb..dfdf415e9d65 100644
--- a/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
+++ b/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
@@ -19,6 +19,7 @@ properties:
          - const: cdns,qspi-nor
          - const: ti,k2g-qspi, cdns,qspi-nor
          - const: ti,am654-ospi, cdns,qspi-nor
+         - const: intel,lgm-qspi, cdns,qspi-nor
 
   reg:
     items:
-- 
2.11.0

