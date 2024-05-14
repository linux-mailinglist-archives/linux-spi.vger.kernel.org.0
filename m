Return-Path: <linux-spi+bounces-2852-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A987A8C5BAE
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2024 21:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCAEE1C21A49
	for <lists+linux-spi@lfdr.de>; Tue, 14 May 2024 19:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F367A181307;
	Tue, 14 May 2024 19:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ajz4KHEC"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7876E1802A1;
	Tue, 14 May 2024 19:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715714801; cv=none; b=Hx9x5zxMIv52I+NLAL9ePksyEiwk/uBphhtNChNtFS0eW6c259EGOakgd6yUWICcUxCEFU7TUdx46JZSQE/pEO31p3Yoayx91lR+Xf1lf47OzilIkG/dk9rzlGBq7SqFxCgdp8+xl79FGkaIJ96f3+UDVlCgJipAkXOl7+XWWA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715714801; c=relaxed/simple;
	bh=HdrW6TpOnmlSBEmxz3ThXhmRZsvj0qD4Y08+LUS+3KU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H6A0V3I8F5voIt1LPgkLErIGTYpUX+44upCfonV9ptVT0KsPFMjlo4VWM7g/0PApVl385xbo+xprXz+4WxFBmA6FzmgaMte8Ud1fvvoZlmVWdnc2C/SM3qv15BbsaaVoe64eIAAniZkahFFFj7uGFxA28ktRBQwg+/CJSU1Jmzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ajz4KHEC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44EH4MOj011005;
	Tue, 14 May 2024 19:26:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=4Xgs1ZzCYvuXqy2SUX4WGoMI2AHx/GyrrcDQa088Ve4=;
 b=Ajz4KHECHhMJ5oXUDUcK0moBXjA7Rmzew7RP6LGQwIbYlV+L+RqzMeyZDgUXMbK1lF7s
 eT/25fjEia9fyWsZPAXhCtqGo8bITFTJIVd2NC5TMmJ1/Q20lgjPaKHPn27g6n8FZ0iE
 BpVftk4ZI0IviTUbEPvlmmkgYt8y0CL0WlpVmEy2pRCMnpTTxZuAWnZodb65mc94muFj
 2Svls98pUWPZXaT22g3DpvJtwjxcH/k1NQM1av8T6XBpv/tGdKUdzd5C3fahO+H9zgG6
 9vlj8B6iJEoPfDQvCQtPlFkg8fRNmvRXfrP11IOqriZwyjNuGV9OTVxfWV/WSqMCHgdG kA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4bg40cj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 19:26:35 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44EHX1Tj020368;
	Tue, 14 May 2024 19:26:33 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2kcyycb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 19:26:33 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44EJQVj855837038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 19:26:33 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 119D058064;
	Tue, 14 May 2024 19:26:31 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D350358058;
	Tue, 14 May 2024 19:26:30 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.107.19])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 May 2024 19:26:30 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-spi@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, eajames@linux.ibm.com
Subject: [PATCH v5] spi: dt-bindings: Document the IBM FSI-attached SPI controller
Date: Tue, 14 May 2024 14:26:30 -0500
Message-Id: <20240514192630.152747-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JIRZ8mzxi8ATm0aI35CLjCRjD_Y0r_Fu
X-Proofpoint-ORIG-GUID: JIRZ8mzxi8ATm0aI35CLjCRjD_Y0r_Fu
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_11,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 clxscore=1011
 mlxlogscore=999 bulkscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2405010000 definitions=main-2405140138

IBM Power processors have a SPI controller that can be accessed
over FSI from a service processor. Document it.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
This patch was previously included in https://lore.kernel.org/all/20240429210131.373487-1-eajames@linux.ibm.com/

No changes since v3.

Changes since v2:
 - Change name from ibm,p10-spi to ibm,spi-fsi for two reasons. One, this
   matches the I2C controller binding (ibm,i2c-fsi), and two, this binding
   is specifically for the FSI-attached SPI controllers on the P10 but
   accessed from the service processor. P10 SPI controllers accessed from
   the P10 would have different bindings.
 - Fix warnings by using generic FSI parent node
 - Fix prefix

 .../devicetree/bindings/spi/ibm,spi-fsi.yaml  | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/ibm,spi-fsi.yaml

diff --git a/Documentation/devicetree/bindings/spi/ibm,spi-fsi.yaml b/Documentation/devicetree/bindings/spi/ibm,spi-fsi.yaml
new file mode 100644
index 0000000000000..d7fec4c3a8016
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/ibm,spi-fsi.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/ibm,spi-fsi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IBM FSI-attached SPI Controller
+
+maintainers:
+  - Eddie James <eajames@linux.ibm.com>
+
+description:
+  A SPI controller found on IBM Power processors, accessed over FSI from a
+  service processor. This node will always be a child node of an ibm,fsi2spi
+  node.
+
+properties:
+  compatible:
+    enum:
+      - ibm,spi-fsi
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    fsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        spi@0 {
+            compatible = "ibm,spi-fsi";
+            reg = <0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            eeprom@0 {
+                compatible = "atmel,at25";
+                reg = <0>;
+                size = <0x80000>;
+                address-width = <24>;
+                pagesize = <256>;
+                spi-max-frequency = <1000000>;
+            };
+        };
+    };
-- 
2.39.3


