Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 128341151D2
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2019 15:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbfLFODT (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Dec 2019 09:03:19 -0500
Received: from pbmsgap02.intersil.com ([192.157.179.202]:49438 "EHLO
        pbmsgap02.intersil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfLFODT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Dec 2019 09:03:19 -0500
Received: from pps.filterd (pbmsgap02.intersil.com [127.0.0.1])
        by pbmsgap02.intersil.com (8.16.0.27/8.16.0.27) with SMTP id xB6Dh7bk000784;
        Fri, 6 Dec 2019 08:43:30 -0500
Received: from pbmxdp03.intersil.corp (pbmxdp03.pb.intersil.com [132.158.200.224])
        by pbmsgap02.intersil.com with ESMTP id 2wkkffmn5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 06 Dec 2019 08:43:30 -0500
Received: from pbmxdp02.intersil.corp (132.158.200.223) by
 pbmxdp03.intersil.corp (132.158.200.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.1531.3; Fri, 6 Dec 2019 08:43:29 -0500
Received: from localhost.localdomain (132.158.202.109) by
 pbmxdp02.intersil.corp (132.158.200.223) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Fri, 6 Dec 2019 08:43:28 -0500
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
Subject: [PATCH v2 5/6] ARM: dts: r7s9210: Add SPIBSC device
Date:   Fri, 6 Dec 2019 08:42:01 -0500
Message-ID: <20191206134202.18784-6-chris.brandt@renesas.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206134202.18784-1-chris.brandt@renesas.com>
References: <20191206134202.18784-1-chris.brandt@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-12-06_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=junk_notspam policy=junk score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911200000 definitions=main-1912060118
X-Proofpoint-Spam-Reason: mlx
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add SPIBSC Device support for RZ/A2.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
v2:
 * Changed reg range from 0x8c to 0x100
 * Added interrupts property
---
 arch/arm/boot/dts/r7s9210.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/r7s9210.dtsi b/arch/arm/boot/dts/r7s9210.dtsi
index 72b79770e336..05c310c57c11 100644
--- a/arch/arm/boot/dts/r7s9210.dtsi
+++ b/arch/arm/boot/dts/r7s9210.dtsi
@@ -68,6 +68,17 @@
 			cache-level = <2>;
 		};
 
+		spibsc: spi@1f800000 {
+			compatible = "renesas,r7s9210-spibsc", "renesas,spibsc";
+			reg = <0x1f800000 0x100>, <0x20000000 0x10000000>;
+			clocks = <&cpg CPG_MOD 83>;
+			power-domains = <&cpg>;
+			interrupts = <GIC_SPI 445 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		scif0: serial@e8007000 {
 			compatible = "renesas,scif-r7s9210";
 			reg = <0xe8007000 0x18>;
-- 
2.23.0

