Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74931410AB2
	for <lists+linux-spi@lfdr.de>; Sun, 19 Sep 2021 10:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbhISIGk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 19 Sep 2021 04:06:40 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:14472 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236395AbhISIGk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 19 Sep 2021 04:06:40 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18INCawF032616;
        Sun, 19 Sep 2021 01:05:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=slmNvgiaHcMEMxZbaIQ/eWgQQd2XptqGXZiAW53C5rc=;
 b=Yo1v/s28qmaRrtkHovjS190wEc+MP3rK4AUyTjlgx6Hvb35nYGD79jFB+D3BEKJHvByO
 fUCOWOMrplY6yPGZbjRmsFtjiJJdWgHPtG4jmayrjrfYIp/VMsVvo63nIlZNF8bTu+/R
 T9yV24f7SAMxR7xuRMsh94bkBAjAJfnF6gr+coaI/5wCNNk2zzTrr0QXQo7MU5KWQZs4
 d8IJ7NNKkpcf79MCp0L+dSxwE9f5YFhfW9l88vNV/WlChScRijqYGpVzg/baYPisNprh
 jiK3EH0B2zIOfrtIxmSL8W/4sWD6FWAeOLsgQZ9XngeAw1QwklD2E91TJlq6V/IRh2FF +g== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3b5cnwa2ph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Sep 2021 01:05:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ra24dH9dRHko69VZEI8gKlUApxZuLM4brJbaYCKtq466JXTxfGezlWxmX5N0KMiFqtubtAdpr94jAiouDtm025wJR47bUZ+0wuI0foyaMQc+kO0o69MvBSZVUuwopSu9PAoF+/MJLW4Lxpfeg83/9Konto9x/AvTrVyr6XFLyrQuhlm6XivzijBNQ+fZmrU0RqT25t65Hku/xJRp5fl0kXa6t6RTlJEtc1w0QPoFd4TnJUFWt9j+i/UekRKGyNW6B29BNo0wsoo4WvFwtCEGK0FlQnpESwqGeXP+l/j/SFVVOrv3NMS3pHI65AhYekqKX7c334oYNKgiDhdpbJP4cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=slmNvgiaHcMEMxZbaIQ/eWgQQd2XptqGXZiAW53C5rc=;
 b=cpdAqlTm+Td5LQrfavnYNJhub5KmPUtwrtlv2xcreC2eaJBy4z4ab9xIgxc7r8DSvVAT+xm/jujisa/dRcc3HFFHOS2OYbTk4mt074S5GT7WihhD35rUSiaRHvJRIRApF72GJ7MNyAgiq9MsDIqI7OyyuRtMhXApP7R8EOuIzo3sl89q4yyYTXgdtBmTuPgtPyhDge19wcUwxE46ar2ksPnYvfAlj3c8SjGvT9OvDqrbKof3Xh7vkyFqxOMM87tIcP47r/tynGvQ/UEYfMuhwOVc10atLhnIgM/MQ2c3O7JOAyfnejkqA508L6xHVw8nGHfwNSfO+zz2iYZAcgJjmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slmNvgiaHcMEMxZbaIQ/eWgQQd2XptqGXZiAW53C5rc=;
 b=P3cnaLmF80E1rLo8IOESsL1e48CqxiDtf4bDiTFxgiGoiY65idO6tXfb9t25y5hPEEgewwRMwqUhgc2W1mO0r/2msSHjRR0Oh/PUyVNsJxAzc24SerEZ4g1Uje3qdKeV2FXzZu7gKgrm4JCnKKd4kRybFRwxmI4oLKY6Np5GZCI=
Received: from DM5PR13CA0051.namprd13.prod.outlook.com (2603:10b6:3:117::13)
 by SN6PR07MB5038.namprd07.prod.outlook.com (2603:10b6:805:ad::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Sun, 19 Sep
 2021 08:05:10 +0000
Received: from DM6NAM12FT044.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:117:cafe::84) by DM5PR13CA0051.outlook.office365.com
 (2603:10b6:3:117::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.6 via Frontend
 Transport; Sun, 19 Sep 2021 08:05:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT044.mail.protection.outlook.com (10.13.178.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.6 via Frontend Transport; Sun, 19 Sep 2021 08:05:09 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 18J857J9003927
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Sep 2021 04:05:08 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 19 Sep 2021 10:05:07 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sun, 19 Sep 2021 10:05:06 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Sun, 19 Sep 2021 10:05:06 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 18J8560A023842;
        Sun, 19 Sep 2021 10:05:06 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 18J8565v023841;
        Sun, 19 Sep 2021 10:05:06 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <broonie@kernel.org>, <lukas@wunner.de>, <p.yadav@ti.com>,
        <robh+dt@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <mparab@cadence.com>, Parshuram Thombare <pthombar@cadence.com>,
        Konrad Kociolek <konrad@cadence.com>
Subject: [PATCH v6 1/2] spi: cadence: add dt-bindings documentation for Cadence XSPI controller
Date:   Sun, 19 Sep 2021 10:05:05 +0200
Message-ID: <1632038705-23805-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1632038668-23756-1-git-send-email-pthombar@cadence.com>
References: <1632038668-23756-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0995ac8-c5c7-4249-2b11-08d97b44334e
X-MS-TrafficTypeDiagnostic: SN6PR07MB5038:
X-Microsoft-Antispam-PRVS: <SN6PR07MB5038F20BBB7FF5B09861F7DDC1DF9@SN6PR07MB5038.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XnLBSSnMSv3VdqBf6kFhwNVheGNICJXoEEpLhe2OSbtlbyn7eL29hte0tRo3qJcwom4uyxq9A09DGniyKb3CyMMkJXQs7mB3SmZhroWedzmjjy8dP9tonbJ38WvrnxplCIUhVWr3ZS4KWxcywPSIwmIF3SRXMTi4LiT9SFVq+ZKExiH0v7UFsdaUjlSZPc8S8KIAurVqw4d4mx7lPsU5K+bz0eEVy0xceuJJ80pUfGsYs98lChG6ovYXlSIFS93VYomoIE8YICXF1iZapFRg9b/87YfsFz/zNF5N4LX4m/DZvMeANoXVK867teh3anOTZRkBsEdAydEE7aQVVWzS6q4OQaZ9B/LHHIm8A+boVPooyAvAaZ5CAwnWBEkoVUsuNoavsChIivjfJQdQwNBU69G+hWlE4z0apJGm7UBgMVD+yd24POXFWEItoC1tu32jd3bQemp6YOYZxNi1o3do6vy9XIcZDqQ7vFzmx/Clz2YbO0YzTwIpCdzR7WuuhIxRYGXQ5XIWm/zihx3A+a4nJ9Md4PeVIBR9p9dxK2gXGprIQ1X/Fbp/9juABygtQ9EtFf7snZhfU4gwLUmKML0VW2RVgPJ9i/wUClzWpp8fT6vi/S+OYJa59PhBP9w2FiWNXsEKG6b8IfrKG+ps5L07KugJ9J0yQDni/YCVqZLwDZqBfUFMG5laF3MzQgnh4bHifIZqHcWMcpTvvx26m6yucqTzxSzuHeFPokobt7xA8dIOzIN5w5ZurWov4sma0ASRjnKnXfs36gNbPQzVKBBbJ/5NYql/Z+hifh3dR+uCVKR4/YfVW1NYrLSwJ+iGUQAxtbPGO27ks3+qj/wE357KsK+eM882AIzbqLEXNiWzJz5/7nFe551CTGbIQ4W62XZyC8YtXgYgoMOnbx1l3O/Ukg==
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36092001)(36840700001)(46966006)(8936002)(426003)(83380400001)(336012)(8676002)(26005)(42186006)(86362001)(316002)(47076005)(508600001)(5660300002)(36756003)(186003)(110136005)(82310400003)(81166007)(4326008)(107886003)(36860700001)(54906003)(2616005)(356005)(2906002)(70206006)(70586007)(36906005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2021 08:05:09.7629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0995ac8-c5c7-4249-2b11-08d97b44334e
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT044.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5038
X-Proofpoint-GUID: SyVc3XKh_0Evn2LrnTDgKQfis-ZqJ5mG
X-Proofpoint-ORIG-GUID: SyVc3XKh_0Evn2LrnTDgKQfis-ZqJ5mG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-19_02,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=995 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109190057
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

