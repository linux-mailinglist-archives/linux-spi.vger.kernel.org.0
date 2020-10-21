Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BFF294698
	for <lists+linux-spi@lfdr.de>; Wed, 21 Oct 2020 04:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440042AbgJUChH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Oct 2020 22:37:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:14302 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440054AbgJUChF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 20 Oct 2020 22:37:05 -0400
IronPort-SDR: 606L1Wpn/K/DZ67z9kSGtHGTCj+vGMaWrhMZKH2LMD0/x9Th4/lVnTi0YvhUXiL9kzCARqzXGD
 tVjTNSMQAqmw==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="167395827"
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="167395827"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 19:37:04 -0700
IronPort-SDR: gQ5bqsgNx7IY8bGzK7gwoQmzOL4CX0VAketd4FlRxl12uqdxjwo4fKGuRHtND+6onwrMafJ5B5
 XTHiKroRpKbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="353530132"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga002.fm.intel.com with ESMTP; 20 Oct 2020 19:37:01 -0700
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
Subject: [PATCH v2 6/6] dt-bindings: spi: Add compatible for Intel LGM SoC
Date:   Wed, 21 Oct 2020 10:36:15 +0800
Message-Id: <20201021023615.48982-7-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201021023615.48982-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20201021023615.48982-1-vadivel.muruganx.ramuthevar@linux.intel.com>
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
index 57be1a730e7b..44378d2d2b9e 100644
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

