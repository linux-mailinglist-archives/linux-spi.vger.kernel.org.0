Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FCF2989A2
	for <lists+linux-spi@lfdr.de>; Mon, 26 Oct 2020 10:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1768307AbgJZJpy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Oct 2020 05:45:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:4797 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1768282AbgJZJpx (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 26 Oct 2020 05:45:53 -0400
IronPort-SDR: fmHk5fMQA5os4DbZWAIPiOIU8T2AZNymLo9fDMXnOay5xcmGn+VDI8joJALf2BZKZUzHutTEae
 Uaa7hORBI3Gw==
X-IronPort-AV: E=McAfee;i="6000,8403,9785"; a="185622741"
X-IronPort-AV: E=Sophos;i="5.77,417,1596524400"; 
   d="scan'208";a="185622741"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 02:45:52 -0700
IronPort-SDR: Xw4R43w1s0z4lg6BoZKWc3MOWpfDCCiZqels9+iA7shHhLV+ot1t3RzakqvSVDey47az00RKQi
 q0CM2g9tMvfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,417,1596524400"; 
   d="scan'208";a="360934112"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga007.jf.intel.com with ESMTP; 26 Oct 2020 02:45:48 -0700
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
Subject: [PATCH v3 6/6] dt-bindings: spi: Add compatible for Intel LGM SoC
Date:   Mon, 26 Oct 2020 17:45:19 +0800
Message-Id: <20201026094519.56083-7-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201026094519.56083-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20201026094519.56083-1-vadivel.muruganx.ramuthevar@linux.intel.com>
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
index b1b3d3ce0cc2..2b862190b552 100644
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

