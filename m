Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4471C293333
	for <lists+linux-spi@lfdr.de>; Tue, 20 Oct 2020 04:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390692AbgJTCdG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 19 Oct 2020 22:33:06 -0400
Received: from mga12.intel.com ([192.55.52.136]:33260 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390691AbgJTCdF (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 19 Oct 2020 22:33:05 -0400
IronPort-SDR: aZa7yFDzafUmN8jGybYlqYU1y15lSusxGy0gxhLt6YbNAmbUVcqHyu9ti958A5/h7GGCirORXt
 xYTUNdnKIlhQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9779"; a="146436781"
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400"; 
   d="scan'208";a="146436781"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2020 19:33:05 -0700
IronPort-SDR: 8TD9ASnp9+MHdwC4DMe7HM3oKE9CarGV/gjV4cyU9sY5yDFXMkqZD/TgOTPSRQ1fj+fekw/7Fa
 Q1HG9r8XIfhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,395,1596524400"; 
   d="scan'208";a="522216081"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by fmsmga006.fm.intel.com with ESMTP; 19 Oct 2020 19:33:01 -0700
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
Subject: [RESENDPATCH v1 6/6] dt-bindings: spi: Add compatible for Intel LGM SoC
Date:   Tue, 20 Oct 2020 10:32:26 +0800
Message-Id: <20201020023226.33559-7-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201020023226.33559-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20201020023226.33559-1-vadivel.muruganx.ramuthevar@linux.intel.com>
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

