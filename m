Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC58610F605
	for <lists+linux-spi@lfdr.de>; Tue,  3 Dec 2019 05:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfLCECV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 2 Dec 2019 23:02:21 -0500
Received: from pbmsgap02.intersil.com ([192.157.179.202]:52988 "EHLO
        pbmsgap02.intersil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfLCECU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 2 Dec 2019 23:02:20 -0500
X-Greylist: delayed 971 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Dec 2019 23:02:20 EST
Received: from pps.filterd (pbmsgap02.intersil.com [127.0.0.1])
        by pbmsgap02.intersil.com (8.16.0.27/8.16.0.27) with SMTP id xB33j4fw008837;
        Mon, 2 Dec 2019 22:46:17 -0500
Received: from pbmxdp03.intersil.corp (pbmxdp03.pb.intersil.com [132.158.200.224])
        by pbmsgap02.intersil.com with ESMTP id 2wkkffj004-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 02 Dec 2019 22:46:17 -0500
Received: from pbmxdp01.intersil.corp (132.158.200.222) by
 pbmxdp03.intersil.corp (132.158.200.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.1531.3; Mon, 2 Dec 2019 22:46:15 -0500
Received: from localhost.localdomain (132.158.202.109) by
 pbmxdp01.intersil.corp (132.158.200.222) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Mon, 2 Dec 2019 22:46:14 -0500
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
Subject: [PATCH 2/6] ARM: dts: r7s72100: Add SPIBSC clocks
Date:   Mon, 2 Dec 2019 22:45:15 -0500
Message-ID: <20191203034519.5640-3-chris.brandt@renesas.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191203034519.5640-1-chris.brandt@renesas.com>
References: <20191203034519.5640-1-chris.brandt@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-02_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=junk_notspam policy=junk score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=785
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911200000 definitions=main-1912030031
X-Proofpoint-Spam-Reason: mlx
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The SPIBSC-0 clock is marked as critical because for XIP systems, this
is the SPI flash controller it will boot from and the kernel will also
be running from so it cannot be turned off.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 arch/arm/boot/dts/r7s72100.dtsi | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index d03dcd919d6f..a422bbe872bc 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -101,6 +101,26 @@
 		#size-cells = <1>;
 		ranges;
 
+		spibsc0: spi@3fefa000 {
+			compatible = "renesas,r7s72100-spibsc", "renesas,spibsc";
+			reg = <0x3fefa000 0x100>, <0x18000000 0x4000000>;
+			clocks = <&mstp9_clks R7S72100_CLK_SPIBSC0>;
+			power-domains = <&cpg_clocks>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		spibsc1: spi@3fefb000 {
+			compatible = "renesas,r7s72100-spibsc", "renesas,spibsc";
+			reg = <0x3fefb000 0x100>, <0x1c000000 0x4000000>;
+			clocks = <&mstp9_clks R7S72100_CLK_SPIBSC1>;
+			power-domains = <&cpg_clocks>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		L2: cache-controller@3ffff000 {
 			compatible = "arm,pl310-cache";
 			reg = <0x3ffff000 0x1000>;
@@ -467,11 +487,13 @@
 			#clock-cells = <1>;
 			compatible = "renesas,r7s72100-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0xfcfe0438 4>;
-			clocks = <&p0_clk>, <&p0_clk>, <&p0_clk>, <&p0_clk>;
+			clocks = <&p0_clk>, <&p0_clk>, <&p0_clk>, <&p0_clk>, <&b_clk>, <&b_clk>;
 			clock-indices = <
 				R7S72100_CLK_I2C0 R7S72100_CLK_I2C1 R7S72100_CLK_I2C2 R7S72100_CLK_I2C3
+				R7S72100_CLK_SPIBSC0 R7S72100_CLK_SPIBSC1
 			>;
-			clock-output-names = "i2c0", "i2c1", "i2c2", "i2c3";
+			clock-output-names = "i2c0", "i2c1", "i2c2", "i2c3", "spibsc0", "spibsc1";
+			clock-critical = <4>; /* spibsc0 */
 		};
 
 		mstp10_clks: mstp10_clks@fcfe043c {
-- 
2.23.0

