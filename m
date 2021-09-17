Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F0940FA2A
	for <lists+linux-spi@lfdr.de>; Fri, 17 Sep 2021 16:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242637AbhIQObS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 17 Sep 2021 10:31:18 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:45962 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242634AbhIQObR (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 17 Sep 2021 10:31:17 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18H9DUbU028881;
        Fri, 17 Sep 2021 07:29:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=slmNvgiaHcMEMxZbaIQ/eWgQQd2XptqGXZiAW53C5rc=;
 b=PULHJ+C/FoHuyIM9cOnjvgKMCh9h0C3raZPuzK5f0qIr/1XGUAb38vI01twg9o+0Xgch
 fiDs5G4QRikF+cH/9oVJ80oh8GP5QM2H+I0VgLAcC1lS1wEvMbQKgEuCHBhFzILad+qV
 87cn0bnip+5qz2HG3QBl+eqm71wpqW6yt4E7c2ng/FlKYaeoGyZuSGflTwMRYJEI7mn0
 6P8WjbaojK+hvhaCsfZIax8kGPsWU/THoAriLQwfwVLKZgum5irXD3K34TvowOwkqwgh
 DK7ztLR1xCjkbwoTZNy/OAb1/AfSC0ocXUjJnNQz7XGknTctdtIL1OYnMI93eBQC50GS ZA== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3b4jm3sugh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Sep 2021 07:29:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K42mCA5gd38Z6xvBjtRB4nVIOe0qBKCap7jac7Q4LZQ5gNF6MkfrZFaHkxOwJNlGVeBsfaQUOY89sCedtz3xmJGRNyP7G0YLzSG4im1bYPYOPEbTQtoGlFA9Rha6zIYyAW09EzeTkPAxQMQcRgX3NIQ8LF7DtwL/uMMMcZealdJPRW1d9k5vVxnJeRdlb41N0A2QSYjL5Wej1sfEnz07qk7mLamOAmh+bNCoaZeKpsVl1bRdDwwn7n2SD1ggq6Mh1a6AkyNFQJZAMHdSk3xE6wneNyJ6oIz6yoGPYDB2nvaDYIWaJv2IaDX07Qy3iWA4TCYNPcKkmu9ce2jV+gA1Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=slmNvgiaHcMEMxZbaIQ/eWgQQd2XptqGXZiAW53C5rc=;
 b=XEz1W67oiiKFTRMnWHiG/8ntoOjp5bSxXXM5yNilmSNm9MDwuYZt59baU5FUCeHtKFB+9y/sSweFAq72ypHgbd+GTfyQiJXsE0XGGwrEERcaHWCu6NX+RweNlo2uBQAbkaEow85ckJ6/UfR7tyMFwE9gkjz+WE2A9n3cRy4lhGvbwGpcXsILI3tcrzk+X/kysDmjHxNseUO5uMP4CBm4E0nwrCnJ0t+tpUSLQKQs9MaAe2q+a10KtDHTj3xsIG9naKqRp1WHRhJpK51pNMFcl9ggSpQyNsayBRfAc6PFsJ1SVLy4v8Aj9XH8dwO4N5LP17eSkqR8026jrGZ7mpeTJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slmNvgiaHcMEMxZbaIQ/eWgQQd2XptqGXZiAW53C5rc=;
 b=M7mtOf2z2UkRnoz1VlvT1lfd70zzOtE8peuRR0jcKAxJJez5ZynOhRekXGJcENmAdrr5FCY6CXgSvWMCKuyWGplEFBxkSpqwzROp3MC+WKXOsHMwjnZ2Am/GITpZfk23n0IzN/WB+Nk+YPEZPZGN55QQ8zkO9RofM7jIuVQyFIw=
Received: from CO2PR04CA0089.namprd04.prod.outlook.com (2603:10b6:104:6::15)
 by SJ0PR07MB9030.namprd07.prod.outlook.com (2603:10b6:a03:3f7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 14:29:50 +0000
Received: from MW2NAM12FT059.eop-nam12.prod.protection.outlook.com
 (2603:10b6:104:6:cafe::8e) by CO2PR04CA0089.outlook.office365.com
 (2603:10b6:104:6::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Fri, 17 Sep 2021 14:29:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 MW2NAM12FT059.mail.protection.outlook.com (10.13.180.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.6 via Frontend Transport; Fri, 17 Sep 2021 14:29:48 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 18HETk1E178644
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Fri, 17 Sep 2021 07:29:47 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 17 Sep 2021 16:29:41 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 17 Sep 2021 16:29:41 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 17 Sep 2021 16:29:40 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 18HETe7b017146;
        Fri, 17 Sep 2021 16:29:40 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 18HETePQ017145;
        Fri, 17 Sep 2021 16:29:40 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <broonie@kernel.org>, <lukas@wunner.de>, <p.yadav@ti.com>,
        <robh+dt@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <mparab@cadence.com>, Parshuram Thombare <pthombar@cadence.com>,
        Konrad Kociolek <konrad@cadence.com>
Subject: [PATCH v5 1/2] spi: cadence: add dt-bindings documentation for Cadence XSPI controller
Date:   Fri, 17 Sep 2021 16:29:35 +0200
Message-ID: <1631888975-17106-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1631888947-17058-1-git-send-email-pthombar@cadence.com>
References: <1631888947-17058-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66c0fdd9-e765-4117-84e6-08d979e79aac
X-MS-TrafficTypeDiagnostic: SJ0PR07MB9030:
X-Microsoft-Antispam-PRVS: <SJ0PR07MB903019C800DDE6CF549931FAC1DD9@SJ0PR07MB9030.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EXNyk2fkouNvNBGudYlSPYuVhf3xgc6oF5iaQg2iyyRqIpK4lQGlibEgAy4Wh0Rttiekc7yn+qHfltvknfjKTEValVR6NT8Gk9P43OcRzewIiLvaFVnZM2n+Sbx6YPC2N+DZBgSoPXawc11wv2cADHgywZ4jpsHtLAoB//GX3ZwvnFCBML5iozzd0LWngefImuuK4jNczwOJgSF1vQKW7VzV8G2KXH3yuQQmHrUOvoh1FKzLuXvCkp9DaU+GNuyEv3yHixryWVNd43sW0MNpAC2K/H9FcM6UUKTxuo/o22pLE5JyQVFl6qyqsuMSe0gqY83+hw0WImJ5beCiCt7S5uZcF6flDh4pY8fImG2YimrbOzDvDueWMKl2ZLo6m5J7oZ8kTOE/96w9fXuzf37qFNpJqZh2OLbfFR/FXqY0QnhNs2BMSTpSAClPA6s2DoNxmt4F5l70qswYB4hFD64KoQ/88eCDmEHa965TxnCIlDEBcIyylIkC8Q3BUQR2CPl0ig9LT96Yxesht7Anxlz0qyui7KKaDrpzO7ZNH2AdtqAfHR59Bw7p9EAh7EUuuZI4Y6G4BLkruqpcHHLeuY0uBW34Ivtuv3AqaikXctZwQJyKSaVG8vfiSEFOXH+zd1eRnxf4kiYyNbJIGffgOGkNHXpEB7XYXaOtVuwOy3BhzZE+LNNqhnf04yd90P4R8FZUCttBBB1vPAW5lNW3eFV0i09o+3YebUw3yC8EMsUjlfXy4BWGos8EUwvlrlmNeTdn62oi8bG13UW1bsR7r6WOEOuqThOa3gqJ/6hMaiv3c8F6fp6FhUlxwHDbEuhk5Fqs3CexGq+77q0rgPIf4yw3/bJNBBpwwbFUuVm04bYrROA6MyGXXAWbGKsh0c2iGXSK1LR30wu1AMq0bk45R7GN9w==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(36092001)(46966006)(36840700001)(4326008)(2906002)(36756003)(186003)(47076005)(70206006)(54906003)(8676002)(86362001)(83380400001)(5660300002)(8936002)(26005)(82310400003)(36860700001)(316002)(6666004)(336012)(42186006)(478600001)(82740400003)(70586007)(426003)(110136005)(81166007)(107886003)(2616005)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 14:29:48.8509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c0fdd9-e765-4117-84e6-08d979e79aac
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT059.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB9030
X-Proofpoint-GUID: dD7245b1XG963xNBaDPelXo7XU3dbozK
X-Proofpoint-ORIG-GUID: dD7245b1XG963xNBaDPelXo7XU3dbozK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-17_06,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 clxscore=1015
 spamscore=0 adultscore=0 mlxlogscore=996 suspectscore=0 lowpriorityscore=0
 mlxscore=0 bulkscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109170093
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
index 0000000..b8bb8a3
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
+      - const: io
+      - const: sdma
+      - const: aux
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
+            reg = <0x0 0xa0010000 0x0 0x1040>,
+                  <0x0 0xb0000000 0x0 0x1000>,
+                  <0x0 0xa0020000 0x0 0x100>;
+            reg-names = "io", "sdma", "aux";
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

