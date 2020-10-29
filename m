Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5880129E521
	for <lists+linux-spi@lfdr.de>; Thu, 29 Oct 2020 08:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgJ2HYr (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Oct 2020 03:24:47 -0400
Received: from mga09.intel.com ([134.134.136.24]:31205 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbgJ2HYi (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:38 -0400
IronPort-SDR: /xFnT0dn/QoWdynKxLn454lP+WeVopLweqbJxnjbc+4i7tYWv3VIf7HJ3t/7Zr+UBEtAUo7+76
 weNZjbpVRfBw==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="168516557"
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="168516557"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 23:20:44 -0700
IronPort-SDR: bCPjrRrKs1vuhBjxJf8O0WgEnLbZKO0aPs/TG2r3rrNVrxJaRMmA8t/uU429pv+Vy+wBFc2oyT
 GVS6tnYxTjoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="361383590"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Oct 2020 23:20:41 -0700
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
Subject: [PATCH v5 6/6] dt-bindings: spi: Add compatible for Intel LGM SoC
Date:   Thu, 29 Oct 2020 14:20:14 +0800
Message-Id: <20201029062014.27620-7-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201029062014.27620-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20201029062014.27620-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Add compatible for Intel LGM SoC.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 Documentation/devicetree/bindings/spi/cadence-quadspi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml b/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
index daf891ade577..637d82cd1cef 100644
--- a/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
+++ b/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
@@ -21,6 +21,7 @@ properties:
          - const: ti,am654-ospi
          - const: ti,k2g-qspi
          - const: ti,am654-ospi
+         - const: intel,lgm-qspi
 
   reg:
     items:
-- 
2.11.0

