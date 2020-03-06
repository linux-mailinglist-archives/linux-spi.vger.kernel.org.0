Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6385717C667
	for <lists+linux-spi@lfdr.de>; Fri,  6 Mar 2020 20:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCFTll (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 6 Mar 2020 14:41:41 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27840 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726185AbgCFTlk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 6 Mar 2020 14:41:40 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 026JKl9i011287;
        Fri, 6 Mar 2020 14:41:36 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ykgng3bwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Mar 2020 14:41:36 -0500
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 026JT1NC029971;
        Fri, 6 Mar 2020 14:41:36 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ykgng3bvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Mar 2020 14:41:35 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 026Jag0o014774;
        Fri, 6 Mar 2020 19:41:34 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma05wdc.us.ibm.com with ESMTP id 2yffk75vfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Mar 2020 19:41:34 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 026JfYkD61735412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Mar 2020 19:41:34 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00D5C78060;
        Fri,  6 Mar 2020 19:41:34 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CCB97805F;
        Fri,  6 Mar 2020 19:41:33 +0000 (GMT)
Received: from ghost4.ibm.com (unknown [9.163.78.144])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  6 Mar 2020 19:41:32 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, broonie@kernel.org, joel@jms.id.au,
        andrew@aj.id.au, andy.shevchenko@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH v3 1/2] dt-bindings: fsi: Add FSI2SPI bindings
Date:   Fri,  6 Mar 2020 13:41:17 -0600
Message-Id: <20200306194118.18581-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200306194118.18581-1-eajames@linux.ibm.com>
References: <20200306194118.18581-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_07:2020-03-06,2020-03-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=1 mlxlogscore=999 lowpriorityscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003060119
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add documentation for the FSI2SPI CFAM engine, which provides access to
a number of SPI controllers.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 .../devicetree/bindings/fsi/ibm,fsi2spi.yaml  | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml

diff --git a/Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml b/Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml
new file mode 100644
index 000000000000..893d81e54caa
--- /dev/null
+++ b/Documentation/devicetree/bindings/fsi/ibm,fsi2spi.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-or-later)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/fsi/ibm,fsi2spi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: IBM FSI-attached SPI controllers
+
+maintainers:
+ - Eddie James <eajames@linux.ibm.com>
+
+description: |
+  This binding describes an FSI CFAM engine called the FSI2SPI. Therefore this
+  node will always be a child of an FSI CFAM node; see fsi.txt for details on
+  FSI slave and CFAM nodes. This FSI2SPI engine provides access to a number of
+  SPI controllers.
+
+properties:
+  compatible:
+    enum:
+      - ibm,fsi2spi
+
+  reg:
+    items:
+      - description: FSI slave address
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    fsi2spi@1c00 {
+        compatible = "ibm,fsi2spi";
+        reg = <0x1c00 0x400>;
+    };
-- 
2.24.0

