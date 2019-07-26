Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8246975CDB
	for <lists+linux-spi@lfdr.de>; Fri, 26 Jul 2019 04:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbfGZCTS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Jul 2019 22:19:18 -0400
Received: from twhmllg4.macronix.com ([122.147.135.202]:60926 "EHLO
        TWHMLLG4.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfGZCTS (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 25 Jul 2019 22:19:18 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG4.macronix.com with ESMTP id x6Q2Iasl095779;
        Fri, 26 Jul 2019 10:18:38 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        lee.jones@linaro.org, sergei.shtylyov@cogentembedded.com,
        Mason Yang <masonccyang@mxic.com.tw>, marek.vasut@gmail.com,
        miquel.raynal@bootlin.com
Subject: [PATCH v15 2/2] dt-bindings: spi: Document Renesas R-Car Gen3 RPC-IF controller bindings
Date:   Fri, 26 Jul 2019 10:42:55 +0800
Message-Id: <1564108975-27423-3-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1564108975-27423-1-git-send-email-masonccyang@mxic.com.tw>
References: <1564108975-27423-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG4.macronix.com x6Q2Iasl095779
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Dcument the bindings used by the Renesas R-Car Gen3 RPC-IF controller.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/spi/spi-renesas-rpc.txt    | 46 ++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
new file mode 100644
index 0000000..d929850
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
@@ -0,0 +1,46 @@
+Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
+---------------------------------------------------------
+
+Required properties:
+- compatible: should be an SoC-specific compatible value, followed by
+		"renesas,rcar-gen3-rpc" as a fallback.
+		supported SoC-specific values are:
+		"renesas,r8a77980-rpc"	(R-Car V3H)
+		"renesas,r8a77995-rpc"	(R-Car D3)
+- reg: should contain three register areas:
+       first for the base address of RPC-IF registers,
+       second for the direct mapping read mode and
+       third for the write buffer area.
+- reg-names: should contain "regs", "dirmap" and "wbuf"
+- clocks: should contain the clock phandle/specifier pair for the module clock.
+- clock-names: should contain "rpc"
+- power-domains: should contain the power domain phandle/secifier pair.
+- resets: should contain the reset controller phandle/specifier pair.
+- #address-cells: should be 1
+- #size-cells: should be 0
+- flash: should be represented by a subnode of the RPC-IF node,
+	 which "compatible" property contains "jedec,spi-nor", it presents
+	 SPI is used.
+
+Example:
+
+	rpc: spi@ee200000 {
+		compatible = "renesas,r8a77995-rpc", "renesas,rcar-gen3-rpc";
+		reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 0x4000000>,
+		      <0 0xee208000 0 0x100>;
+		reg-names = "regs", "dirmap", "wbuf";
+		clocks = <&cpg CPG_MOD 917>;
+		clock-names = "rpc";
+		power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
+		resets = <&cpg 917>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		flash@0 {
+			compatible = "jedec,spi-nor";
+			reg = <0>;
+			spi-max-frequency = <40000000>;
+			spi-tx-bus-width = <1>;
+			spi-rx-bus-width = <1>;
+		};
+	};
-- 
1.9.1

