Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 796C010F610
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2019 05:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbfLCECz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Dec 2019 23:02:55 -0500
Received: from pbmsgap01.intersil.com ([192.157.179.201]:34770 "EHLO
        pbmsgap01.intersil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfLCECz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 Dec 2019 23:02:55 -0500
Received: from pps.filterd (pbmsgap01.intersil.com [127.0.0.1])
        by pbmsgap01.intersil.com (8.16.0.27/8.16.0.27) with SMTP id xB33hWLi032292;
        Mon, 2 Dec 2019 22:46:56 -0500
Received: from pbmxdp01.intersil.corp (pbmxdp01.pb.intersil.com [132.158.200.222])
        by pbmsgap01.intersil.com with ESMTP id 2wkmu327qh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 02 Dec 2019 22:46:56 -0500
Received: from pbmxdp01.intersil.corp (132.158.200.222) by
 pbmxdp01.intersil.corp (132.158.200.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.1531.3; Mon, 2 Dec 2019 22:46:54 -0500
Received: from localhost.localdomain (132.158.202.109) by
 pbmxdp01.intersil.corp (132.158.200.222) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Mon, 2 Dec 2019 22:46:53 -0500
From:   Chris Brandt <chris.brandt@renesas.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        Mason Yang <masonccyang@mxic.com.tw>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH 6/6] dt-bindings: spi: Document Renesas SPIBSC bindings
Date:   Mon, 2 Dec 2019 22:45:19 -0500
Message-ID: <20191203034519.5640-7-chris.brandt@renesas.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191203034519.5640-1-chris.brandt@renesas.com>
References: <20191203034519.5640-1-chris.brandt@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-02_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=junk_notspam policy=junk score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911200000 definitions=main-1912030031
X-Proofpoint-Spam-Reason: mlx
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Document the bindings used by the Renesas SPI bus space controller.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 .../bindings/spi/spi-renesas-spibsc.txt       | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-spibsc.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-spibsc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-spibsc.txt
new file mode 100644
index 000000000000..b5f7081d2d1e
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-renesas-spibsc.txt
@@ -0,0 +1,48 @@
+Renesas SPI Bus Space Controller (SPIBSC) Device Tree Bindings
+
+Otherwise referred to as the "SPI Multi I/O Bus Controller" in SoC hardware
+manuals. This controller was designed specifically for accessing SPI flash
+devices.
+
+Required properties:
+- compatible: should be an SoC-specific compatible value, followed by
+		"renesas,spibsc" as a fallback.
+		supported SoC-specific values are:
+		"renesas,r7s72100-spibsc"	(RZ/A1)
+		"renesas,r7s9210-spibsc"	(RZ/A2)
+- reg: should contain three register areas:
+       first for the base address of SPIBSC registers,
+       second for the direct mapping read mode
+- clocks: should contain the clock phandle/specifier pair for the module clock.
+- power-domains: should contain the power domain phandle/specifier pair.
+- #address-cells: should be 1
+- #size-cells: should be 0
+- flash: should be represented by a subnode of the SPIBSC node,
+	 its "compatible" property contains "jedec,spi-nor" if SPI is used.
+
+Example:
+
+	spibsc: spi@1f800000 {
+		compatible = "renesas,r7s9210-spibsc", "renesas,spibsc";
+		reg = <0x1f800000 0x8c>, <0x20000000 0x10000000 >;
+		clocks = <&cpg CPG_MOD 83>;
+		power-domains = <&cpg>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		flash@0 {
+			compatible = "jedec,spi-nor";
+			reg = <0>;
+			spi-max-frequency = <40000000>;
+
+			partitions {
+				compatible = "fixed-partitions";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				partition@0000000 {
+					label = "u-boot";
+					reg = <0x00000000 0x80000>;
+				};
+			};
+		};
-- 
2.23.0

