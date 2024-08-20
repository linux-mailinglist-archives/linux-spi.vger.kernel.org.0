Return-Path: <linux-spi+bounces-4240-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA579584F1
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 12:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1DB21F25689
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2024 10:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E652018E037;
	Tue, 20 Aug 2024 10:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j8Hn1UuI"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9FA18DF95;
	Tue, 20 Aug 2024 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724150614; cv=none; b=ddAfpbgZuMSl18WLjxN3bWKkWqRhiN/HuHP1hGaRgL2uljTGkeTUoDdvZFK/WLp/bi8N60HghET1FeLWsYzK/PtVb2FOw92R4Nu5o1KL010hfsKIwG/kfy3kj1G1F2qjckNP9BnxkmvfwcNSWU/qsrg+6x7aQ/ATxTYl07pPBqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724150614; c=relaxed/simple;
	bh=2LFmC3MxV+USmRwOHgHRY84PNfH3uFPBTOrlnlYgozk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mKp/PydM+dqcgHij9wYNn4Ay3k/pUCwMsZheMUhfTO0no+Ak5trAYmGrPjq+DtpzFmm2UUTopOAH5ADzctyOwj00gsQA5SYWTJ4vP4JsbSMAomZ1SzJbU5Tmi3gUkxXsvGGY7CrXPEOsKgjPID0cKRrWRGv9BmLzATWrb2u9wXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j8Hn1UuI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47K72llS024403;
	Tue, 20 Aug 2024 10:43:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vTD2aaHJUOz4SzpvqXoCNIDE+uBrdh0pY8GAY6wWNUU=; b=j8Hn1UuI7utwlIDt
	REV+lBOOiw/8zIxW1icNERYqUTpmO5b6mNOjtcFY776n9pS6UIa71YpomDy0b4M2
	mlfp7K1dcvB2ltLbFCkBmxy3uqL49W/80fhkPA9dCfOwABlmCFVGs+iyn6+aColQ
	fn5q0Ni0JrOPE+w12dZsuUdn6zEEbNSRhB5qgjCqAV0bra9S9D+3I48Y/VRXd6g3
	PR0T39yBohlMlmi81sFGCxLeVsgfQh4P5ONj4sqq/ALm+MffTwxxfPoJvvsH5c+F
	3uyZUbAItSvMMvbcRZYWaPWA06lRT0ibNdZdInEiAJ8KvQPxZnZdfdOhRsSjyFyR
	HPnXiQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 414pdmrp6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 10:43:04 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47KAh2tk007148
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 10:43:02 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 20 Aug 2024 03:42:58 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <manivannan.sadhasivam@linaro.org>, <esben@geanix.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v8 1/8] spi: dt-bindings: Introduce qcom,spi-qpic-snand
Date: Tue, 20 Aug 2024 16:12:32 +0530
Message-ID: <20240820104239.1774600-2-quic_mdalam@quicinc.com>
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
X-Proofpoint-ORIG-GUID: UNGYPJMQtF0CmlJ1S6oAPG7RfZwryQBc
X-Proofpoint-GUID: UNGYPJMQtF0CmlJ1S6oAPG7RfZwryQBc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-20_09,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408200079

Document the QPIC-SPI-NAND flash controller present in the IPQ SoCs.
It can work both in serial and parallel mode and supports typical
SPI-NAND page cache operations.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


