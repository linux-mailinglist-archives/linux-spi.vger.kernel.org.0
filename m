Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E003E408AAE
	for <lists+linux-spi@lfdr.de>; Mon, 13 Sep 2021 14:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239813AbhIMMG2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 13 Sep 2021 08:06:28 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:33230 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236405AbhIMMGX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 13 Sep 2021 08:06:23 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18D9wFvA028735;
        Mon, 13 Sep 2021 05:05:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=A7HG93yzh5ciNOR7CTZmj6Ndd9NcyfozcOdYROabXPo=;
 b=tP5RI35vX8osk5IFIqnPaggp7Yx5WA92+FkJMVYXHnla9n/yMCZ8clM30YES55pWWSgT
 N3jw/Lf0INyMdApiEl+XXNENKIkE9g12JSXV082C9kJ4XDoKFBNbmljfPKF/YYMMGhFC
 jBQVLALl6T8GNhe+j5z7lANdkUTZDNsxTnSYgkusM/7aTL3zRnR0YTaz9tHkh3fmmo4f
 YlKPi8qC5C5D1ze0GzJJfowVJAlGARUn7RjVos8qMdx2Tpbyi+kfcFzYXJNs9ltvKt8W
 OMK+P3V4KmLuzTfOczMyfcJ6YB0UkcGyAEk8AxTsucmrYkTBf+mwus54ZhnMUZeeO5EV jg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3b1hnetd7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Sep 2021 05:05:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmxnYvDEdKlQ/Wh0cQhUpbWHLPJxMylcYyJzOhFQ5d0ZK6fux1W//t7LrX6o0ObgImgTNQ7HjTy3ljqkEnXffi82C64YWkXKbUEIqIsicyXQRMsmuN08Jzu1niw0vFPEtlW0MZBvfDxgcnhnU8Kd6YGEgqMRbGHE4uqtZprQv8HSlQEDLRVzCwvjewdA/E3DUq+y1d2t7QlMeKN20MZ0QKq2141eNuKCOjVtXwNtvEG7I3cUSiVZTNMQfwipBLEHhohCAvuK+NbacYVP92o4YrghafkPy4UjR16hcrrxtuYeiAi/9kF+dgUQdiIoy24qLV7zSYZXGS/LM6Uskq2WSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=A7HG93yzh5ciNOR7CTZmj6Ndd9NcyfozcOdYROabXPo=;
 b=C2PYr6uCkAgu+j0HwtO7FmUZem5nvxIfB1z1fwFWMaD9B/InnUI9/ad3MksXo5+QLKnsum+7wnkWHOD+7DyEXJXlLUfY3TzfD+1BHbe6ApX7IBHTUttkfgPD7hf17RLCvABOocAi50T2TQaztw9D3wnOG+tncqFGHmfu5NBqxzzqUwe0lohRXECzoQxEFjTynHyBOk02+9c+RpdPZvg02rySMjT6PsdxzFy6D7y2gKPJ7uxH6emDZ//9Ekrzhs9FP5QtvP7udPn3OR/M+DP80GDODGmjuTnN7O7RvgFg0Vjpz0jv0E4/7IzXCPG7/fFilc8J4CMe5ua3qmz8WinMDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7HG93yzh5ciNOR7CTZmj6Ndd9NcyfozcOdYROabXPo=;
 b=mRZrAyvsEQoTMlKghLoR1mPhRyP3KtYx2tbh2FCgppOCXfpdwdWkhckuRUSbHQ5jZjYl2HB8QkyRP4Ow/gfLkBujxKs6k16tkml9PqEEpIC71hk9CwBqbBQlNBTVhqBDb60V7yPZOMVtPGf3Yo6eax177ieCKIuzGCxVapzjzmI=
Received: from CO2PR04CA0123.namprd04.prod.outlook.com (2603:10b6:104:7::25)
 by MN2PR07MB6927.namprd07.prod.outlook.com (2603:10b6:208:1a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Mon, 13 Sep
 2021 12:05:01 +0000
Received: from MW2NAM12FT045.eop-nam12.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::7e) by CO2PR04CA0123.outlook.office365.com
 (2603:10b6:104:7::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Mon, 13 Sep 2021 12:05:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 MW2NAM12FT045.mail.protection.outlook.com (10.13.181.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4523.8 via Frontend Transport; Mon, 13 Sep 2021 12:05:01 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 18DC4wA9006934
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 08:04:59 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 13 Sep 2021 14:04:58 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 13 Sep 2021 14:04:45 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 13 Sep 2021 14:04:45 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 18DC4j9L008309;
        Mon, 13 Sep 2021 14:04:45 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 18DC4jcL008308;
        Mon, 13 Sep 2021 14:04:45 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <broonie@kernel.org>, <lukas@wunner.de>, <p.yadav@ti.com>,
        <robh+dt@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <mparab@cadence.com>, Parshuram Thombare <pthombar@cadence.com>,
        Konrad Kociolek <konrad@cadence.com>
Subject: [PATCH v4 1/2] spi: cadence: add dt-bindings documentation for Cadence XSPI controller
Date:   Mon, 13 Sep 2021 14:04:44 +0200
Message-ID: <1631534684-8273-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1631534558-8102-1-git-send-email-pthombar@cadence.com>
References: <1631534558-8102-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c71bceb7-ffd3-46a1-51fd-08d976aeb6ce
X-MS-TrafficTypeDiagnostic: MN2PR07MB6927:
X-Microsoft-Antispam-PRVS: <MN2PR07MB6927E4AD7EE1AE9D7233ABB7C1D99@MN2PR07MB6927.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6eQeLR39fmYUx6D0z4oHqSBkBqnglByM6DKrvHmtGoxObLXNeoJfJ8okykwNxQtLX2eJsQO7jWah0jbPH8BMyuc6R69zR5shfxP/SEGhlaPcwg0AkNNbzgJcNsW+f0SwJGRYkhR3FKwyRqSjVlFp48GKeN06BBS1HrCgNbDwvFabGA1xK7V2Nlc9wuoGiGYNSvNjqPa+vvh9KbeJoJsFThTuFvDOYQmawOP1NVBDU2+b0jYkA0RcsZ+J6yJZC1q/Mi5MSjKaBCZodKh1OAhU6vV+u2IDH3G0e4qotjJK6pLOxJYOGb/ntnMrVMXHkMLPUJBl/p9Pb3yKFiT26DzVjcyzEaQ56PHdag2RsXgIxTSYgJwiEAK5n26xF1bI9XxqptPC0VO5F6/3+eNMI/kY/IzdBHpaTLoFQS+Fmw7rF8MGszl4kAj9nOjZZQYBdncb4VCkLpDCuFSAhZ1QJ3poIE+Mx0/ChQBvi/u4esdg6RsWoutylhW9YM7Us7z/tQ0HwNuyvec09fj5V0H/NJ0PPB4pa66Et//pHcv8+IkkkGbd24dVyRH0iU1peD8l54ShO0kwYpnSXpMB5waCS2RpazYaKnskfcz0KvfqVhyPXIr2lJQvApPjxv5t05SzNKUewufzuPYccNoie8bpyH/kLStcLnG04HpxlhIVGcZSn0LxI6Q6q1wTkNXR+MJ9FExs2eUOWf43qCdBpJ+VXZO2N5Kyv6jR6bL5pBy5VNe3eRpgEfiKUfLMxfUC2D7viNzDAJ3U+6nZhwM/Yxbbt4PjBXUw0Gmcdihq8GP51lvvJPbfwuONhpnX/RdSmTsLS5kJMPa8UqpkSlOhS4P/tlFvNvpzuNVla22pNMHNDdTfsc8=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(36092001)(46966006)(36840700001)(70206006)(316002)(54906003)(70586007)(5660300002)(336012)(36906005)(36860700001)(81166007)(426003)(42186006)(2906002)(4326008)(356005)(82740400003)(2616005)(82310400003)(86362001)(36756003)(47076005)(107886003)(26005)(8676002)(83380400001)(186003)(8936002)(110136005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 12:05:01.1528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c71bceb7-ffd3-46a1-51fd-08d976aeb6ce
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT045.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6927
X-Proofpoint-GUID: Hw89rjU1IQl6seV8DIR1cybwy6ByR16h
X-Proofpoint-ORIG-GUID: Hw89rjU1IQl6seV8DIR1cybwy6ByR16h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-13_04,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 clxscore=1015
 mlxscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=984 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109130081
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add DT binding for Cadence's XSPI controller driver.

Signed-off-by: Konrad Kociolek <konrad@cadence.com>
Signed-off-by: Jayshri Pawar <jpawar@cadence.com>
Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 .../devicetree/bindings/spi/cdns,xspi.yaml         | 77 ++++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/cdns,xspi.yaml

diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
new file mode 100644
index 0000000..5ebede1
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2020-21 Cadence
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/spi/cdns,xspi.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Cadence XSPI Controller
+
+maintainers:
+  - Parshuram Thombare <pthombar@cadence.com>
+
+description: |
+  The XSPI controller allows SPI protocol communication in
+  single, dual, quad or octal wire transmission modes for
+  read/write access to slaves such as SPI-NOR flash.
+
+allOf:
+  - $ref: "spi-controller.yaml#"
+
+properties:
+  compatible:
+    const: cdns,xspi-nor
+
+  reg:
+    items:
+      - description: address and length of the controller register set
+      - description: address and length of the Slave DMA data port
+      - description: address and length of the auxiliary registers
+
+  reg-names:
+    items:
+      - const: xspi-iobase
+      - const: xspi-sdmabase
+      - const: xspi-auxbase
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        xspi: spi@a0010000 {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            compatible = "cdns,xspi-nor";
+            reg = <0x0 0xa0010000 0x0 0x10000>,
+                  <0x0 0xb0000000 0x0 0x10000>,
+                  <0x0 0xa0020000 0x0 0x10000>;
+            reg-names = "xspi-iobase", "xspi-sdmabase", "xspi-auxbase";
+            interrupts = <0 90 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-parent = <&gic>;
+
+            flash@0 {
+                compatible = "jedec,spi-nor";
+                spi-max-frequency = <75000000>;
+                reg = <0>;
+            };
+
+            flash@1 {
+                compatible = "jedec,spi-nor";
+                spi-max-frequency = <75000000>;
+                reg = <1>;
+            };
+        };
+    };
-- 
2.7.4

