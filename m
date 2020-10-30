Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30C829FD53
	for <lists+linux-spi@lfdr.de>; Fri, 30 Oct 2020 06:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbgJ3Fc1 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 30 Oct 2020 01:32:27 -0400
Received: from mga04.intel.com ([192.55.52.120]:61859 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbgJ3Fc0 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 30 Oct 2020 01:32:26 -0400
IronPort-SDR: 42WMw8LFRHiPQ70wWu7pa5VQDUA8wB29/YECtIGGbBRe3pDrdT3FydBstnZzfXoqFQQR7Zapzp
 TOp1evjn2yRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9789"; a="165976188"
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="165976188"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 22:32:25 -0700
IronPort-SDR: NWs9Q8VmVpxIheP/Tu38N6u4ZktSaauS4I6q7gAyFXiEKZ5Qx8eIXeFAxZ8vLmUNLSzmwDVzuJ
 WSNXFVTcvHWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,432,1596524400"; 
   d="scan'208";a="395395123"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga001.jf.intel.com with ESMTP; 29 Oct 2020 22:32:21 -0700
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
Subject: [PATCH v6 6/6] dt-bindings: spi: Add compatible for Intel LGM SoC
Date:   Fri, 30 Oct 2020 13:31:53 +0800
Message-Id: <20201030053153.5319-7-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201030053153.5319-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20201030053153.5319-1-vadivel.muruganx.ramuthevar@linux.intel.com>
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
index ec22b040d804..58ecdab939df 100644
--- a/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
+++ b/Documentation/devicetree/bindings/spi/cadence-quadspi.yaml
@@ -19,6 +19,7 @@ properties:
           - enum:
               - ti,k2g-qspi
               - ti,am654-ospi
+              - intel,lgm-qspi
           - const: cdns,qspi-nor
 
   reg:
-- 
2.11.0

