Return-Path: <linux-spi+bounces-4893-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4FC97D2BE
	for <lists+linux-spi@lfdr.de>; Fri, 20 Sep 2024 10:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3815F1F260DE
	for <lists+linux-spi@lfdr.de>; Fri, 20 Sep 2024 08:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558118174E;
	Fri, 20 Sep 2024 08:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="KnmMVOGi"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B817FBA2;
	Fri, 20 Sep 2024 08:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820926; cv=none; b=Cf0yemZKf9XkT6cCVRepIUsVsQffZ4gz5AYpooCt3pXQrWweB2ysS376FWGuhAOmesLnrTXzDQGxLBkwQMI/XY+8gQ7lSXkaGWErPj0TxNM3WOO5nB1pTli03N82CJFJjCkOTY1htkOXqrD8ix19qhDngd7nFmdDAlK2cG9VSRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820926; c=relaxed/simple;
	bh=2R1Ih8SXvEFDRHrl2dzmGr32CbJTfUkNx9k6fUfJRmA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YhUE+BsGvqTLzWh/v1IFb+waE4KipvR8+tXXrEE4+W3xUSZCBo9nMxJ21yJ1CjIRPIxnJjzwp4htTAq9fTquhQm6HqGT5b5zSMCrAGvAUTVCp5BSV9zk57lBf4gog9rs1FDiP1b0ltNDuVpLKMZ7YSH0BxjkzO8ebmrQpN35ZKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=KnmMVOGi; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48K6V0u1028371;
	Fri, 20 Sep 2024 04:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=o4KZcGa/zx5jVyvObTkpQwQSE59
	FbIkwVSL6FKx99h8=; b=KnmMVOGi3NHSjBrgJoMN0fWLgH2Vanj1Gu66ZBealoI
	rmfibrQUzJD8LGwOSwTDOluhmFwljQgvAOCZx/AJZzIK0vbNuiHcxadzAMGCAtsA
	03qS1Sa0dqmzbhXf39ZveZnJ1mNoWTfyfTZO8RQ82XZ1FAOS4k3YzrHuzuLjTEdu
	2ZrHsvxaOnWWqcZ1kWbjNWcpnrxw8NbHZRcd0VHjedMJTjgMNSwrue34OX2Z6dqq
	C3yKX5oiYQTcl4+PllOsB7jgQbSH4rYVGYGZtz9RywOCIF8RrQXziv8rG/GJa2HW
	cCPPWNsf8sxqo6mCzvktA7oewKCqWwu79w0nb5titpw==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 41n4c5jcsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 04:28:29 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 48K8SSCm050502
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Sep 2024 04:28:28 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 20 Sep 2024 04:28:28 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 20 Sep 2024 04:28:27 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 20 Sep 2024 04:28:27 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.165])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 48K8SHAP025925;
	Fri, 20 Sep 2024 04:28:19 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        "Mark Brown" <broonie@kernel.org>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v5 1/2] dt-bindings: touchscreen: add ad7877 support
Date: Fri, 20 Sep 2024 11:24:43 +0300
Message-ID: <20240920082520.10094-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: E6QAhWFJWQ_zsBl-fP3DwGEB1q845SMo
X-Proofpoint-ORIG-GUID: E6QAhWFJWQ_zsBl-fP3DwGEB1q845SMo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1011 mlxlogscore=999 priorityscore=1501 spamscore=0
 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409200059

Add device tree bindings for ad7877.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v5:
 - add missing defaults for first-conv-delay-ns and stopacq-polarity
 .../input/touchscreen/adi,ad7877.yaml         | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/adi,ad7877.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/adi,ad7877.yaml b/Documentation/devicetree/bindings/input/touchscreen/adi,ad7877.yaml
new file mode 100644
index 000000000000..be737cfbe471
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/adi,ad7877.yaml
@@ -0,0 +1,108 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/adi,ad7877.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD7877 Touch Screen Controller
+
+maintainers:
+  - Antoniu Miclaus <antoniu.miclaus@analog.com>
+
+description: |
+  Analog Devices Touch Screen Controller
+  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7877.pdf
+
+allOf:
+  - $ref: touchscreen.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    enum:
+      - adi,ad7877
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  spi-max-frequency:
+    description: AD7877 SPI bus clock frequency.
+    minimum: 10000
+    maximum: 20000000
+
+  adi,stopacq-polarity:
+    description: The polarity of the signal applied to the STOPACQ pin.
+    $ref: /schemas/types.yaml#/definitions/string
+    enum: [low, high]
+    default: low
+
+  adi,first-conv-delay-ns:
+    description: Delay in ns before the first conversion.
+    enum: [500, 128000, 1000000, 8000000]
+    default: 500
+
+  adi,pen-down-acc-interval-us:
+    description: Enable the ADC to repeatedly perform conversions.
+    enum: [0, 500, 1000, 8000]
+    default: 0
+
+  adi,acquisition-time-us:
+    description: Select acquisition times in us for the ADC.
+    enum: [2, 4, 8, 16]
+    default: 2
+
+  adi,vref-delay-us:
+    description: Delay required for the SPI transfers depending on the VREF used.
+    default: 100
+
+  touchscreen-average-samples:
+    enum: [1, 4, 8, 16]
+
+  touchscreen-x-plate-ohms:
+    default: 400
+
+  touchscreen-min-x: true
+  touchscreen-min-y: true
+  touchscreen-size-x: true
+  touchscreen-size-y: true
+  touchscreen-max-pressure: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - touchscreen-average-samples
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      touchscreen@0 {
+        compatible = "adi,ad7877";
+        reg = <0>;
+        spi-max-frequency = <20000000>;
+        interrupts = <21 IRQ_TYPE_EDGE_FALLING>;
+        interrupt-parent = <&gpio>;
+        adi,vref-delay-us = <100>;
+        adi,stopacq-polarity = "low";
+        adi,first-conv-delay-ns = <500>;
+        adi,pen-down-acc-interval-us = <0>;
+        adi,acquisition-time-us = <2>;
+        touchscreen-average-samples = <16>;
+        touchscreen-x-plate-ohms = <400>;
+        touchscreen-min-x = <0>;
+        touchscreen-min-y = <0>;
+        touchscreen-size-x = <800>;
+        touchscreen-size-y = <480>;
+        touchscreen-max-pressure = <4095>;
+      };
+    };
+...
-- 
2.46.0


