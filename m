Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 055164CA54
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2019 11:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731523AbfFTJIy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 20 Jun 2019 05:08:54 -0400
Received: from twhmllg3.macronix.com ([211.75.127.131]:25169 "EHLO
        TWHMLLG3.macronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731488AbfFTJIy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 20 Jun 2019 05:08:54 -0400
Received: from localhost.localdomain ([172.17.195.96])
        by TWHMLLG3.macronix.com with ESMTP id x5K985xF044197;
        Thu, 20 Jun 2019 17:08:07 +0800 (GMT-8)
        (envelope-from masonccyang@mxic.com.tw)
From:   Mason Yang <masonccyang@mxic.com.tw>
To:     broonie@kernel.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        lee.jones@linaro.org, sergei.shtylyov@cogentembedded.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        Mason Yang <masonccyang@mxic.com.tw>, miquel.raynal@bootlin.com
Subject: [PATCH v14 2/2] dt-bindings: spi: Document Renesas R-Car Gen3 RPC-IF controller bindings
Date:   Thu, 20 Jun 2019 17:30:46 +0800
Message-Id: <1561023046-20886-3-git-send-email-masonccyang@mxic.com.tw>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1561023046-20886-1-git-send-email-masonccyang@mxic.com.tw>
References: <1561023046-20886-1-git-send-email-masonccyang@mxic.com.tw>
X-MAIL: TWHMLLG3.macronix.com x5K985xF044197
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Dcument the bindings used by the Renesas R-Car Gen3 RPC-IF controller.

Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
---
 .../devicetree/bindings/spi/spi-renesas-rpc.txt    | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
new file mode 100644
index 0000000..e8edf99
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
@@ -0,0 +1,43 @@
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
+- power-domain: should contain the power domain phandle/secifier pair.
+- resets: should contain the reset controller phandle/specifier pair.
+- #address-cells: should be 1
+- #size-cells: should be 0
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

