Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC9E223494
	for <lists+linux-spi@lfdr.de>; Fri, 17 Jul 2020 08:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgGQGax (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Jul 2020 02:30:53 -0400
Received: from mga17.intel.com ([192.55.52.151]:14787 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbgGQGaw (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 17 Jul 2020 02:30:52 -0400
IronPort-SDR: uzS0TD6B21pV16xgw8Do8UrpqMuPUqMOuwGZPSml/ROs6qvZJE1rSC/uYQ6/6Ar1c05B+hFYZL
 wdh5qxelXM/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="129628442"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="129628442"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 23:30:52 -0700
IronPort-SDR: cXIFy7m6qxhxxvPuJ9gLngO1xOBoInB2sY2ldmdJEEVUx98aQgPx/e0X0wtihrQXlA22f74xlA
 wqCGwwcu9zyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="286724536"
Received: from sgsxdev004.isng.intel.com (HELO localhost) ([10.226.88.13])
  by orsmga006.jf.intel.com with ESMTP; 16 Jul 2020 23:30:48 -0700
From:   Dilip Kota <eswara.kota@linux.intel.com>
To:     broonie@kernel.org, robh@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, daniel.schwierzeck@gmail.com,
        hauke@hauke-m.de, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, Dilip Kota <eswara.kota@linux.intel.com>
Subject: [PATCH v2 7/8] dt-bindings: spi: Add support to Lightning Mountain SoC
Date:   Fri, 17 Jul 2020 14:27:56 +0800
Message-Id: <7d644e5d03ef534f719763e5c823c1673e53d1a5.1594957019.git.eswara.kota@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
References: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
In-Reply-To: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
References: <efb650b0faa49a00788c4e0ca8ef7196bdba851d.1594957019.git.eswara.kota@linux.intel.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add support to SPI controller on Intel Atom based Lightning Mountain
SoC which reuses the Lantiq SPI controller IP.

Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/spi/spi-lantiq-ssc.txt      | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-lantiq-ssc.txt b/Documentation/devicetree/bindings/spi/spi-lantiq-ssc.txt
index ce3230c8e28dc..76a3dd35f7960 100644
--- a/Documentation/devicetree/bindings/spi/spi-lantiq-ssc.txt
+++ b/Documentation/devicetree/bindings/spi/spi-lantiq-ssc.txt
@@ -1,11 +1,17 @@
 Lantiq Synchronous Serial Controller (SSC) SPI master driver
 
 Required properties:
-- compatible: "lantiq,ase-spi", "lantiq,falcon-spi", "lantiq,xrx100-spi"
+- compatible: "lantiq,ase-spi", "lantiq,falcon-spi", "lantiq,xrx100-spi",
+  "intel,lgm-spi"
 - #address-cells: see spi-bus.txt
 - #size-cells: see spi-bus.txt
 - reg: address and length of the spi master registers
-- interrupts: should contain the "spi_rx", "spi_tx" and "spi_err" interrupt.
+- interrupts:
+  For compatible "intel,lgm-ssc" - the common interrupt number for
+  all of tx rx & err interrupts.
+       or
+  For rest of the compatibles, should contain the "spi_rx", "spi_tx" and
+  "spi_err" interrupt.
 
 
 Optional properties:
@@ -27,3 +33,14 @@ spi: spi@e100800 {
 	num-cs = <6>;
 	base-cs = <1>;
 };
+
+ssc0: spi@e0800000 {
+	compatible = "intel,lgm-spi";
+	reg = <0xe0800000 0x400>;
+	interrupt-parent = <&ioapic1>;
+	interrupts = <35 1>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clocks = <&cgu0 LGM_CLK_NGI>, <&cgu0 LGM_GCLK_SSC0>;
+	clock-names = "freq", "gate";
+};
-- 
2.11.0

