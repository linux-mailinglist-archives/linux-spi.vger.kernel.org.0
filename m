Return-Path: <linux-spi+bounces-3958-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C270693B0A5
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 13:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79D5D286BB9
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jul 2024 11:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8408C15A851;
	Wed, 24 Jul 2024 11:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="E+E/zIx9"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C160E158DDF;
	Wed, 24 Jul 2024 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721821388; cv=none; b=mqhu6PlfMi5L92cbl1BTdstx5DtDrQr4R98pJ5zUXpVXUErUcBpNNUogr9571JUWdu7ekqq78yJAkBiI5P0LKnu1ISJlTz9CfOJvXPRIl4wb2BBb4kY7UNidO4ZSEyB1WeHju3EfiO42+7xMUsEyLtCixWIQPU9LkhvPTiZQrIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721821388; c=relaxed/simple;
	bh=DU6og7pstsomHxS6yCO8Pvf/h+pSSvOgUXdA6f5uQwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j0+Tdu0FZ+xzf14K2UtwfZrh06KF6D+r//o7ulDqELkm3GyC8FIbqVpDNEQhevmBCqoiduDQRdMgdlLdsii616uhQC1sdUHA/JcSL468gUFG6cD09a7QeIEo+uTRKn9CdOlBY/D6dLRSAOPqOMx4H41kuxPPoRrTrczIjuBD9KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=E+E/zIx9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46OAZAcN014747;
	Wed, 24 Jul 2024 11:42:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=mg/4V+3arAQ
	ctJiEiOu5f1fKdcU2lqPsKOIdw9EhbQA=; b=E+E/zIx9lyvYkhp56B7p5unH1Hp
	vBidBKTRp2zYgszFRtwO2fDCa/hpY5ZcJ8NYY276Bs9B3FLPXs/L6LaBIYpU2dHi
	2FdIO+wQNixq8Q4srgqN357YU+Wl4uHr3pSuGr3+vkSH4A6TQ7ot23umeTbhjJiw
	ksKos5fHPxjELmuw9c7rZFlci99iWaIKrevMd5zKh814VXsIAfRALBmyBIq8y6UQ
	nzL9CPom6W6HVncCTohXY7JR9VbyidV10AMP0lST/ygxEyIkjP6lCzdeB9eD5LYg
	jIQaRa+oaO/OdroZTW8MXORGVd2CQsvq+Yfs3/wtQ1KUlIwbp5ZxnnTjajg==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g4jh1wve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 11:42:32 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTP id 46OBgSIq024844;
	Wed, 24 Jul 2024 11:42:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 40g6am4psk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 11:42:28 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46OBgSBU024804;
	Wed, 24 Jul 2024 11:42:28 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 46OBgSBQ024799
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 11:42:28 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
	id A47FC41179; Wed, 24 Jul 2024 17:12:27 +0530 (+0530)
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        manivannan.sadhasivam@linaro.org, esben@geanix.com,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc: quic_mdalam@quicinc.com, quic_varada@quicinc.com,
        quic_srichara@quicinc.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 1/8] spi: dt-bindings: Introduce qcom,spi-qpic-snand
Date: Wed, 24 Jul 2024 17:12:18 +0530
Message-Id: <20240724114225.2176448-2-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724114225.2176448-1-quic_mdalam@quicinc.com>
References: <20240724114225.2176448-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aT7sdhfxjh8-4SlddvoGaR9F_lGOD-ga
X-Proofpoint-GUID: aT7sdhfxjh8-4SlddvoGaR9F_lGOD-ga
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_09,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407240086

Document the QPIC-SPI-NAND flash controller present in the IPQ SoCs.
It can work both in serial and parallel mode and supports typical
SPI-NAND page cache operations.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
Change in [v7]

* No change

Change in [v6]

* No change

Change in [v5]

* No change

Change in [v4]

* Fix spelling mistake in HW description

* Added commit message

* Removed '|' from description

* Removed minItems in clock

* Added blank line

* Removed co-developed by

Change in [v3]

* Updated commit message, removed "dt-bindings" from commit
  message

* Updated compatible name as file name

* Added hardware description

* Documented clock-name

* Moved dma-names property to top

* Droped unused label "qpic_nand"

* Fixed indentation in example dt node

Change in [v2]

* Added initial support for dt-bindings

Change in [v1]

* This patch was not included in [v1]

 .../bindings/spi/qcom,spi-qpic-snand.yaml     | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
new file mode 100644
index 000000000000..f0d9f7643849
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/qcom,spi-qpic-snand.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QPIC NAND controller
+
+maintainers:
+  - Md sadre Alam <quic_mdalam@quicinc.com>
+
+description:
+  The QCOM QPIC-SPI-NAND flash controller is an extended version of
+  the QCOM QPIC NAND flash controller. It can work both in serial
+  and parallel mode. It supports typical SPI-NAND page cache
+  operations in single, dual or quad IO mode with pipelined ECC
+  encoding/decoding using the QPIC ECC HW engine.
+
+allOf:
+  - $ref: /schemas/spi/spi-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - qcom,spi-qpic-snand
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: core
+      - const: aon
+      - const: iom
+
+  dmas:
+    items:
+      - description: tx DMA channel
+      - description: rx DMA channel
+      - description: cmd DMA channel
+
+  dma-names:
+    items:
+      - const: tx
+      - const: rx
+      - const: cmd
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
+    spi@79b0000 {
+        compatible = "qcom,spi-qpic-snand";
+        reg = <0x1ac00000 0x800>;
+
+        clocks = <&gcc GCC_QPIC_CLK>,
+                 <&gcc GCC_QPIC_AHB_CLK>,
+                 <&gcc GCC_QPIC_IO_MACRO_CLK>;
+        clock-names = "core", "aon", "iom";
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        flash@0 {
+            compatible = "spi-nand";
+            reg = <0>;
+            #address-cells = <1>;
+            #size-cells = <1>;
+            nand-ecc-engine = <&qpic_nand>;
+            nand-ecc-strength = <4>;
+            nand-ecc-step-size = <512>;
+        };
+    };
-- 
2.34.1


