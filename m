Return-Path: <linux-spi+bounces-4804-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627D6977A53
	for <lists+linux-spi@lfdr.de>; Fri, 13 Sep 2024 09:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EFF8280E0A
	for <lists+linux-spi@lfdr.de>; Fri, 13 Sep 2024 07:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869EE18E371;
	Fri, 13 Sep 2024 07:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="OUBeBmSh"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC65B29A2;
	Fri, 13 Sep 2024 07:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726214150; cv=none; b=WfZXlwOm36IMUa9aNA8IBc6uKFxU0aJMy8wZkRQzvgJOfy+4dPnqq5JEWBJikoF1pDLMj5DjQ3uPtYetqGKIWaLrL4AGCaG7zOygNl41IeDDJGzzL00/+a5VXL94Js1dnJHM/SvlTLOGPLYfjfKJAxtFMgi2eDiPet54+7VrZYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726214150; c=relaxed/simple;
	bh=hJf9Ys1YG+ZMdst/I33jqFnAlbkaksSFSliRW9NL8ew=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=minXt/tZbJqu3dhFQrOACeJFznnoltiAxfnreYU8b/VY5FJySh30C6nB6oSildk6aUh2wFzgaKJhaXhDdvttHpTrZ94NQoMNMm+2YUjlL1EcfEPITVcmgklcfhERyqkq5zZnW/mqX3ezbtAT8YrzOnEEXhsI74KEF4GFwnJA3UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=OUBeBmSh; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48D45ngR010019;
	Fri, 13 Sep 2024 03:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=IBqaE8N7QvuFOUx8HtZgxf+6wPi
	Z+MEl/NLbiYeErYg=; b=OUBeBmSh0AqRQmu1a1hNxPpzb0FSEIFwHEggkhRTdkg
	+Kwq4aj1HHpwhEiWkkBf9nJVCMMqnVWfVAcvk++eFSJXca3SW3lVQi7WE48jnp1Z
	SxlYLrJsgUXVWOvNLHO7+TZJKeFaWTjUp4KBb67vQX6/gfbYYA0VWWb8g7yv8H1F
	2OFJrcP3XZcakhN0HIIUJv9Jy/s4IhuTK5nTn3QIfiGyLuJce3BeitxRJbdxcMrZ
	IeB+XuJQrMmxeGyvYCZE0ewHGIj1Sm5mx+b7Rd/zZjyB5D6GjfSkBRdNBqN5R1Bs
	Xv9Thmx+80MybmRCV2U8h5dPA7VPYlFpiAD7z7iDdGw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 41kya1cm0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Sep 2024 03:55:44 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 48D7thTi018968
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Sep 2024 03:55:43 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 13 Sep 2024 03:55:43 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 13 Sep 2024 03:55:43 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 13 Sep 2024 03:55:43 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.165])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 48D7tW6n015289;
	Fri, 13 Sep 2024 03:55:34 -0400
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
Subject: [PATCH v4 1/2] dt-bindings: touchscreen: add ad7877 support
Date: Fri, 13 Sep 2024 10:52:29 +0300
Message-ID: <20240913075307.154435-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: s9XWRs5T7LUg_nM7hq48WGxmbdnIWctM
X-Proofpoint-GUID: s9XWRs5T7LUg_nM7hq48WGxmbdnIWctM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 bulkscore=1 priorityscore=1501 spamscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 lowpriorityscore=1 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409130054

Add device tree bindings for ad7877.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v4:
 - add bindings patch first
 - update commit title/body based on review.
 - add units for pen-down-acc-interval property.
 - add default value for adi,acquisition-time-us and adi,vref-delay-us property
 .../input/touchscreen/adi,ad7877.yaml         | 106 ++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/adi,ad7877.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/adi,ad7877.yaml b/Documentation/devicetree/bindings/input/touchscreen/adi,ad7877.yaml
new file mode 100644
index 000000000000..c472f50f7a59
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/adi,ad7877.yaml
@@ -0,0 +1,106 @@
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


