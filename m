Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA4692C1CA8
	for <lists+linux-spi@lfdr.de>; Tue, 24 Nov 2020 05:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgKXETH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 23 Nov 2020 23:19:07 -0500
Received: from mga11.intel.com ([192.55.52.93]:8580 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbgKXETH (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Mon, 23 Nov 2020 23:19:07 -0500
IronPort-SDR: smoHwPAto5GrdLrgTVY+EwTPXqoXdUXJ/KejIXEsLSrK2Zbb332MZ7BwaD4YcOpd4+0rdH21jx
 C6mmCS+bYeAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9814"; a="168378682"
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="168378682"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 20:19:06 -0800
IronPort-SDR: Ap4A08/c/032HNPRRtjG1PqASnlGzsy3DnNxUuOxpCr7oUn6v3h+PrKjSyu0BI/+DfNOC6NXjZ
 rAnQ6QAe01bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,365,1599548400"; 
   d="scan'208";a="343029901"
Received: from sgsxdev004.isng.phoenix.local (HELO localhost) ([10.226.81.179])
  by orsmga002.jf.intel.com with ESMTP; 23 Nov 2020 20:19:03 -0800
From:   "Ramuthevar,Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
To:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
Cc:     linux-mtd@lists.infradead.org, vigneshr@ti.com, p.yadav@ti.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: [PATCH v9 5/5] dt-bindings: spi: cadence-qspi: Add support for Intel lgm-qspi
Date:   Tue, 24 Nov 2020 12:18:40 +0800
Message-Id: <20201124041840.31066-6-vadivel.muruganx.ramuthevar@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201124041840.31066-1-vadivel.muruganx.ramuthevar@linux.intel.com>
References: <20201124041840.31066-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>

Add new vendor specific compatible string to check Intel's Lightning
Mountain(LGM) QSPI features enablement in cadence-quadspi driver.

Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/spi/cadence-quadspi.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/cadence-quadspi.txt b/Documentation/devicetree/bindings/spi/cadence-quadspi.txt
index 945be7d5b236..8ace832a2d80 100644
--- a/Documentation/devicetree/bindings/spi/cadence-quadspi.txt
+++ b/Documentation/devicetree/bindings/spi/cadence-quadspi.txt
@@ -5,6 +5,7 @@ Required properties:
 	Generic default - "cdns,qspi-nor".
 	For TI 66AK2G SoC - "ti,k2g-qspi", "cdns,qspi-nor".
 	For TI AM654 SoC  - "ti,am654-ospi", "cdns,qspi-nor".
+	For Intel LGM SoC - "intel,lgm-qspi", "cdns,qspi-nor".
 - reg : Contains two entries, each of which is a tuple consisting of a
 	physical address and length. The first entry is the address and
 	length of the controller register set. The second entry is the
-- 
2.11.0

