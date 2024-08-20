Return-Path: <linux-spi+bounces-4245-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2956958502
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 12:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A54328BC59
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 10:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6685C18F2DA;
	Tue, 20 Aug 2024 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Pyt7KfPs"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB67618F2D2;
	Tue, 20 Aug 2024 10:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724150633; cv=none; b=SpE3j3uPxCtDncCASB3UdYYJmS+3is5nnIHnu3FPBLuelRezHgaumJezmmSxjqL495VQvP/5Fb/kvGfj8QSctkqFaKkKXCyFiz5OCghTD5kEaDSwDJL/jkV7F3fgmt2W4RP7oEAnba/YVzG8q3JTuPjSaoWnHqrpQRMyrTmW/As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724150633; c=relaxed/simple;
	bh=8PyRTqSRGKzM2tMWiTLwYg6JrakY91tjT2TlUFSIEEE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m5ExDHVmozpKHkRu7cNsLWbkGzLpYUywMLc7weu00yTtY7xzJx+zGhs2LynK/lsxmqYAnZDg7oTOgLh0jBVe7lqLLAiHpBMQCh0hIAT/+cMjfZ3Lld6v9iM02S4osPV5TE97lMdnub2VXN3NICFFqQDd4W6XtmJ5/+YgbnKByHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Pyt7KfPs; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47K73BoJ024824;
	Tue, 20 Aug 2024 10:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f5hQTAMj4DoTuFrfeoDoRkQbKzf34bHa5aPXEONWFq0=; b=Pyt7KfPsPHoDidpb
	5PPbKyfl0XlkVDJRjp3ZGdFIHMt+AB6lcCv16uGXpdCi9kkraSCm5kTY0FSiXbJv
	hS/anjT4iiwAH079bolXF/wY/sDx/sIZLvjxiRIAF4C3+nRpL7tI4RKD108fp4lu
	7ZH0H67Gd75DsakuK4EMGtj9Xsa6kHmN79us7umy1VPf4Zu7jJK6wRkpNCrNaKEs
	4oQ5lZxULa74rmj3NqQu9E1u4ezmfuytwbtfxJQPI/K3421G6w9HPrsXORkqPwEP
	SXf34KeSU4ugaSRpVvPAwRQln7O/QTEFTqDBcNiBtVuewvLAC3EeTVC+AbkzgOuR
	yn6PiQ==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 414pdmrp84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 10:43:31 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47KAhU8K025863
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 10:43:30 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 20 Aug 2024 03:43:26 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <esben@geanix.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
Subject: [PATCH v8 7/8] arm64: dts: qcom: ipq9574: Add SPI nand support
Date: Tue, 20 Aug 2024 16:12:38 +0530
Message-ID: <20240820104239.1774600-8-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820104239.1774600-1-quic_mdalam@quicinc.com>
References: <20240820104239.1774600-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 3Ji9BorMhdRG01WdTH2ZegQmdb8sry4L
X-Proofpoint-GUID: 3Ji9BorMhdRG01WdTH2ZegQmdb8sry4L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_09,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408200079

Add SPI NAND support for ipq9574 SoC.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
Change in [v8]

* No change

Change in [v7]

* No change

Change in [v6]

* No change

Change in [v5]

* No change

Change in [v4]

* No change

Change in [v3]

* Updated gpio number as per pin control driver

* Fixed alignment issue

Change in [v2]

* Added initial enablement for spi-nand 

Change in [v1]

* Posted as RFC patch for design review

 .../boot/dts/qcom/ipq9574-rdp-common.dtsi     | 43 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 27 ++++++++++++
 2 files changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi b/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
index 91e104b0f865..6429a6b3b903 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi
@@ -139,6 +139,49 @@ gpio_leds_default: gpio-leds-default-state {
 		drive-strength = <8>;
 		bias-pull-up;
 	};
+
+	qpic_snand_default_state: qpic-snand-default-state {
+		clock-pins {
+			pins = "gpio5";
+			function = "qspi_clk";
+			drive-strength = <8>;
+			bias-disable;
+		};
+
+		cs-pins {
+			pins = "gpio4";
+			function = "qspi_cs";
+			drive-strength = <8>;
+			bias-disable;
+		};
+
+		data-pins {
+			pins = "gpio0", "gpio1", "gpio2", "gpio3";
+			function = "qspi_data";
+			drive-strength = <8>;
+			bias-disable;
+		};
+	};
+};
+
+&qpic_bam {
+	status = "okay";
+};
+
+&qpic_nand {
+	pinctrl-0 = <&qpic_snand_default_state>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	flash@0 {
+		compatible = "spi-nand";
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		nand-ecc-engine = <&qpic_nand>;
+		nand-ecc-strength = <4>;
+		nand-ecc-step-size = <512>;
+	};
 };
 
 &usb_0_dwc3 {
diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 08a82a5cf667..65e70b33c587 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -330,6 +330,33 @@ tcsr: syscon@1937000 {
 			reg = <0x01937000 0x21000>;
 		};
 
+		qpic_bam: dma-controller@7984000 {
+			compatible = "qcom,bam-v1.7.0";
+			reg = <0x7984000 0x1c000>;
+			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_QPIC_AHB_CLK>;
+			clock-names = "bam_clk";
+			#dma-cells = <1>;
+			qcom,ee = <0>;
+			status = "disabled";
+		};
+
+		qpic_nand: spi@79b0000 {
+			compatible = "qcom,spi-qpic-snand";
+			reg = <0x79b0000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&gcc GCC_QPIC_CLK>,
+				 <&gcc GCC_QPIC_AHB_CLK>,
+				 <&gcc GCC_QPIC_IO_MACRO_CLK>;
+			clock-names = "core", "aon", "iom";
+			dmas = <&qpic_bam 0>,
+			       <&qpic_bam 1>,
+			       <&qpic_bam 2>;
+			dma-names = "tx", "rx", "cmd";
+			status = "disabled";
+		};
+
 		sdhc_1: mmc@7804000 {
 			compatible = "qcom,ipq9574-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x07804000 0x1000>,
-- 
2.34.1


