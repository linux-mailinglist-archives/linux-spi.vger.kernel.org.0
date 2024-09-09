Return-Path: <linux-spi+bounces-4731-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED54A9713D4
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 11:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DE131F26CAF
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 09:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E491B6528;
	Mon,  9 Sep 2024 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ruEGfhSK"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8005C1B3F3F;
	Mon,  9 Sep 2024 09:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874306; cv=none; b=fVF1jz5YHEoVBfEbAYkeo8c+CjZU8TsR6boIsZPya/nJSJBn6sxKqmEDTM9SUtvmubEWm6yFyWHfw4I4WrnO8w5vsKgSGaDAx1GoMzOwWqioeylxPR5JIFqumu0Lfk2am5zQxZIrKC8mcTmORHU/Cm6DSpTKmUz2DL38nXBifA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874306; c=relaxed/simple;
	bh=JBQxaz6m5wmzMH1d/i1n26LjHJRtQ0HiuHCUsMBW7GM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rS0Y487KTAHoGmLJpic5xE38t1PRcpFvp2dmb7qodYdp3pkTQhM4/KtAooKsB8gbF60F68qU1BoaT/tZ8iqOTHtaXDOq81FvkUTl4TtucQ0T5V2LChJ0aHSupPMXr6zeKJMERkON3xLL45XsSkt4vmAeBl/dCA2/0C72Vl0iggI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ruEGfhSK; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4898ibX7029097;
	Mon, 9 Sep 2024 05:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=XSDF2
	j6ywhliufuTOGY/QLPl9fOa3c+VOd7K+1aP1mU=; b=ruEGfhSKAYNx/CGXulKNU
	AQFR0Cq3JDO2GJxwCcX/vcCyK3aLBH/PyAR1yizRfqnVUF9L18rgIppnEJK28YTU
	5rVcYHVuS1cnwwZLfOWZoiAkoIlEVQKTAU26QTEwDMZaDsviZBrAG/SbP+Qh5+0L
	vou7esVO6dYxnDKkEf9g54M8RxpN6gSQN29tRVKsFqjUzr6ow7XTHguZIOygTfRR
	IW1hFU80hF8Z0iYsi3I0ipju6I43r7Ksq/APm85xuV3Cxikd6imrWKqtiuo8zHaT
	ypOHGpiSjqUd6aaC1ITM2A/8amYRP12HR7O//e1C6JcUFNXormlFIxueZCgSKq/0
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 41h55cbp0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 05:31:41 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4899VdhG004604
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Sep 2024 05:31:39 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 9 Sep 2024
 05:31:39 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 9 Sep 2024 05:31:39 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.165])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4899V8G2019340;
	Mon, 9 Sep 2024 05:31:33 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Mark
 Brown <broonie@kernel.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH v3 3/3] dt-bindings: touchscreen: ad7877: add bindings
Date: Mon, 9 Sep 2024 12:30:13 +0300
Message-ID: <20240909093101.14113-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240909093101.14113-1-antoniu.miclaus@analog.com>
References: <20240909093101.14113-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Ej1WZRudw5-1tBLa3JWKBoi7YYV5XQW5
X-Proofpoint-ORIG-GUID: Ej1WZRudw5-1tBLa3JWKBoi7YYV5XQW5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 suspectscore=0
 impostorscore=0 bulkscore=1 adultscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409090075

Add device tree bindings for the ad7877 driver.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v3:
 - use strings for polarity.
 - use unit siffix where applies.
 - add defaults where applies.
 - add complete example.
 .../input/touchscreen/adi,ad7877.yaml         | 109 ++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/adi,ad7877.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/adi,ad7877.yaml b/Documentation/devicetree/bindings/input/touchscreen/adi,ad7877.yaml
new file mode 100644
index 000000000000..7603ce63af7e
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/adi,ad7877.yaml
@@ -0,0 +1,109 @@
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
+
+  adi,first-conv-delay-ns:
+    description: Delay in ns before the first conversion.
+    enum: [500, 128000, 1000000, 8000000]
+
+  adi,pen-down-acc-interval:
+    description: Enable the ADC to repeatedly perform conversions.
+                  0 = convert once
+                  1 = every 0.5 ms
+                  2 = every 1 ms
+                  3 = every 8 ms
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+    default: 0
+
+  adi,acquisition-time-us:
+    description: Select acquisition times in us for the ADC.
+    enum: [2, 4, 8, 16]
+
+  adi,vref-delay-us:
+    description: Delay required for the SPI transfers depending on the VREF used.
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
+        adi,pen-down-acc-interval = <0>;
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


