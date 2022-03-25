Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94064E70BB
	for <lists+linux-spi@lfdr.de>; Fri, 25 Mar 2022 11:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358717AbiCYKL3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Fri, 25 Mar 2022 06:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350171AbiCYKL1 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 25 Mar 2022 06:11:27 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2890657167;
        Fri, 25 Mar 2022 03:09:51 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22P811O2013207;
        Fri, 25 Mar 2022 10:09:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f0t26v3tm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 10:09:01 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 22P9nP0L017164;
        Fri, 25 Mar 2022 10:09:01 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f0t26v3sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 10:09:01 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22P9xhOm020608;
        Fri, 25 Mar 2022 10:08:58 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3ew6ej4ymx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 10:08:57 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22PA90a746793140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 10:09:00 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACE09A405B;
        Fri, 25 Mar 2022 10:08:55 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06F65A405C;
        Fri, 25 Mar 2022 10:08:55 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 25 Mar 2022 10:08:54 +0000 (GMT)
Received: from yukon.ibmuc.com (unknown [9.171.95.248])
        by smtp.tlslab.ibm.com (Postfix) with ESMTP id 63F2B220158;
        Fri, 25 Mar 2022 11:08:53 +0100 (CET)
From:   =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To:     linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v4 01/11] ARM: dts: aspeed: Adjust "reg" property of FMC/SPI controllers
Date:   Fri, 25 Mar 2022 11:08:39 +0100
Message-Id: <20220325100849.2019209-2-clg@kaod.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220325100849.2019209-1-clg@kaod.org>
References: <20220325100849.2019209-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 8eUxlfzMfIVYQLTeEB1bSNktTuUCQsWG
X-Proofpoint-GUID: q2wJ6HldRcGYRngrA0a7QkdBTRS-pv9R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-25_02,2022-03-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=638 suspectscore=0 phishscore=0 clxscore=1034 impostorscore=0
 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203250057
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This is compatible with the current driver and addresses issues when
running 'make dt_binding_check'.

Cc: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Tested-by: Joel Stanley <joel@jms.id.au>
Tested-by: Tao Ren <rentao.bupt@gmail.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 6 ++----
 arch/arm/boot/dts/aspeed-g5.dtsi | 9 +++------
 arch/arm/boot/dts/aspeed-g6.dtsi | 9 +++------
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index f14dace34c5a..9ae67e83cf60 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -54,8 +54,7 @@ ahb {
 		ranges;
 
 		fmc: spi@1e620000 {
-			reg = < 0x1e620000 0x94
-				0x20000000 0x10000000 >;
+			reg = <0x1e620000 0x94>, <0x20000000 0x10000000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "aspeed,ast2400-fmc";
@@ -91,8 +90,7 @@ flash@4 {
 		};
 
 		spi: spi@1e630000 {
-			reg = < 0x1e630000 0x18
-				0x30000000 0x10000000 >;
+			reg = <0x1e630000 0x18>, <0x30000000 0x10000000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "aspeed,ast2400-spi";
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 7495f93c5069..c3e0a8e13c8a 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -55,8 +55,7 @@ ahb {
 		ranges;
 
 		fmc: spi@1e620000 {
-			reg = < 0x1e620000 0xc4
-				0x20000000 0x10000000 >;
+			reg = <0x1e620000 0xc4>, <0x20000000 0x10000000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "aspeed,ast2500-fmc";
@@ -84,8 +83,7 @@ flash@2 {
 		};
 
 		spi1: spi@1e630000 {
-			reg = < 0x1e630000 0xc4
-				0x30000000 0x08000000 >;
+			reg = <0x1e630000 0xc4>, <0x30000000 0x08000000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "aspeed,ast2500-spi";
@@ -106,8 +104,7 @@ flash@1 {
 		};
 
 		spi2: spi@1e631000 {
-			reg = < 0x1e631000 0xc4
-				0x38000000 0x08000000 >;
+			reg = <0x1e631000 0xc4>, <0x38000000 0x08000000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "aspeed,ast2500-spi";
diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed-g6.dtsi
index c32e87fad4dc..1ad05dde19d2 100644
--- a/arch/arm/boot/dts/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed-g6.dtsi
@@ -95,8 +95,7 @@ gic: interrupt-controller@40461000 {
 			};
 
 		fmc: spi@1e620000 {
-			reg = < 0x1e620000 0xc4
-				0x20000000 0x10000000 >;
+			reg = <0x1e620000 0xc4>, <0x20000000 0x10000000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "aspeed,ast2600-fmc";
@@ -124,8 +123,7 @@ flash@2 {
 		};
 
 		spi1: spi@1e630000 {
-			reg = < 0x1e630000 0xc4
-				0x30000000 0x10000000 >;
+			reg = <0x1e630000 0xc4>, <0x30000000 0x10000000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "aspeed,ast2600-spi";
@@ -146,8 +144,7 @@ flash@1 {
 		};
 
 		spi2: spi@1e631000 {
-			reg = < 0x1e631000 0xc4
-				0x50000000 0x10000000 >;
+			reg = <0x1e631000 0xc4>, <0x50000000 0x10000000>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			compatible = "aspeed,ast2600-spi";
-- 
2.34.1

