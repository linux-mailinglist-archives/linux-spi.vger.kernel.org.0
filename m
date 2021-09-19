Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6DBC410A8F
	for <lists+linux-spi@lfdr.de>; Sun, 19 Sep 2021 09:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbhISHlB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 19 Sep 2021 03:41:01 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:24736 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235960AbhISHk6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 19 Sep 2021 03:40:58 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18J0wSav013151;
        Sun, 19 Sep 2021 00:39:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=slmNvgiaHcMEMxZbaIQ/eWgQQd2XptqGXZiAW53C5rc=;
 b=Kpp5CT+VnPNAoJfqbM8P8O7I3So70cGah2IZVNsgFM1CKVNADMf0wcS3OXAY3lkGCCfF
 hWgv2O8AOUOvGQbZJcZ4ucwhsf8nY1kh+RD0RwIMrdsEDU+l07FMbZHvTmTR5kl6HJYK
 MDcS+hdGdgSsxo0/tf2A75N2hQoyo2WTQmf9PDhhAaMZCtqvBGCaj6aPK04NtfytDWRf
 J+1yeo2zosqnF09gIKTeIX1xyZFVWCM/dzhFMMgTm7DAWAxfsbza1layanWzrroBZYxa
 RR3VAEfcaoers8CvTMrEa6OkqhD1q5u+zFO6pKEMDC63OXc4wGlh4hMrROnAuHb5BiYk 2w== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3b5cnwa1ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Sep 2021 00:39:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y90FEHb9eR909WulSVIGR35DSbIqZsD0UrDHiJz88Glqy0WUdclOAUyi/nsYHgBC86mDKrvdLbdu0HdcRWhKBUd0XJoea9pVBjDSxKv3v6EGQ9IgSB4QuI/ZQcTRCruMxSCWhAxEAk4byHzzMQL4PaUMVUSD9shUVtaF1/xsthLXY74/ZnvWYmdI9IzWWZQG2pff+LEyRkfmiUQt+BrmmIv7Zif1QohnYl1r7mjwW9NWN/5RdQtn14+vnqPu3lMw6efX+mg+ott0/76zhHUhEj9B1GUKavCK4QY0YvfPP6IF4XXjLI9LLK1krs5XPWgImZHOwhE/8W5cxh6G2J2o/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=slmNvgiaHcMEMxZbaIQ/eWgQQd2XptqGXZiAW53C5rc=;
 b=WxqhCq0NlaJscU9Tdj75FcL60Auf5uKnNG1R1okpsEBzq+cVY81BubhQGBv9PUX98728PGo6FdjYyrTJiFAuPVrdhZo7Vu3o55oZA3vNa1Nc9LgygXs5XlrgN5fcybar1tTV2kJ7rkxqRL9PmCGkLJOkhA58nbeQwLMBIJMDLliVVwkd8HHQ+3jw9lAYL4wvRH5p59J1bHCnSH5S+BB1mo+ReCx/qKMIPShVagOWu8KDL39SJhJpz/71Nf5vk0O0eUprWsc3ZpBdXuoT5saeoNO9v8hTKpzRzNlMNQBC3W1jPCjM9Palk/GEnnoN67N9GWZ4Uk66HQzuioSisQplGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slmNvgiaHcMEMxZbaIQ/eWgQQd2XptqGXZiAW53C5rc=;
 b=ljwfE9l6XxUYm56DlqHspht2oNNe/sWPLTqOX9so0kU7ZXzpF638+Ce1y3SSR23qJhKjP+RKvDeRl0n5D6qb2YT/iW5RbFoCkzdoBmKEuqdqboPQybB19oox0Uv488L3W5r9O4J4HCWDb+zZjK/yM0Q4joROekFNwujE9CHh6ao=
Received: from MWHPR13CA0026.namprd13.prod.outlook.com (2603:10b6:300:95::12)
 by MW4PR07MB8521.namprd07.prod.outlook.com (2603:10b6:303:be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Sun, 19 Sep
 2021 07:39:29 +0000
Received: from MW2NAM12FT012.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:95:cafe::fa) by MWHPR13CA0026.outlook.office365.com
 (2603:10b6:300:95::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.6 via Frontend
 Transport; Sun, 19 Sep 2021 07:39:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 MW2NAM12FT012.mail.protection.outlook.com (10.13.180.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.6 via Frontend Transport; Sun, 19 Sep 2021 07:39:28 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 18J7dQPI001625
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Sep 2021 03:39:26 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 19 Sep 2021 09:39:19 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sun, 19 Sep 2021 09:39:19 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Sun, 19 Sep 2021 09:39:19 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 18J7dJ1n021115;
        Sun, 19 Sep 2021 09:39:19 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 18J7dJsC021113;
        Sun, 19 Sep 2021 09:39:19 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <broonie@kernel.org>, <lukas@wunner.de>, <p.yadav@ti.com>,
        <robh+dt@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <mparab@cadence.com>, Parshuram Thombare <pthombar@cadence.com>,
        Konrad Kociolek <konrad@cadence.com>
Subject: [PATCH v6 1/2] spi: cadence: add dt-bindings documentation for Cadence XSPI controller
Date:   Sun, 19 Sep 2021 09:39:17 +0200
Message-ID: <1632037157-21075-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1632037121-21019-1-git-send-email-pthombar@cadence.com>
References: <1632037121-21019-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75cf7a58-1b6c-4ab7-ff0c-08d97b409ccf
X-MS-TrafficTypeDiagnostic: MW4PR07MB8521:
X-Microsoft-Antispam-PRVS: <MW4PR07MB8521024F2AFDCDD8E19121AAC1DF9@MW4PR07MB8521.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JGEPlmt52z/arTRQDM96a+f3pjtAZQ/meOtmrD3l82g4eqqEJDzgcxbtjSzg/faoBZGISk9x5MqSkKgk7VOB/1UvHEJ9cMII3VCBkrJUDYW+8sojgCH02ZA3jEtmlOyTlczzPoGHletjfLlG+SAF2+TXJDjLT/M/Xs2LKvq5GeHj/o1CO59ncgjaacV/knoqokuiAqxn9OrFKK25co3O/3PneB2pblA79PvoeXQQKhdDi944PpbTuGRfs7FOMpCLg/RazWoT3GYLxxaoqiPE9IjZ+nNuqjHhC1Gdlov8jMLMcuUTZbWYwlquekGF9DKFvjKu/BDROGLUfJlySw7W9HutRhFfTtsCdQP1G4vj9sV6uJnH0MJLQATllRkKS2HmB8rNW7olr8nRVreSg3GjaBuesWU9cZI/mjop4Ndy6OKwntPqa4au2TO5bhanQxOuemfQ43cyQqogLYEy0QUOU9gYhMt00ohz1jtCahhsxrVIWVKIG6jNTGnRthPdRDrF4KTapT6GciMRK8hy+Ktt/pIARx40be8jV5PozuUCWl49jeKwGiWh/HRMPQK9pLGZRBJLhRfUjU7NZJT/5dSuHt3Nkz7HT1RSXMDPCD+SWKbzF8Eoc/Z2UsCaz2n4y2JgD8ZKPiy3M7XyP8uJJUxxl3gNRGvgT6vogKR2uYgHuLrbI2/6PaCv+4XIK29HjJL6sSUIVTnYee94SGiMkQuYa76+iZgjX2R0dbcmi//IELyEx1i39YS4Ynpwt2/1pOC4HzZPzG5w42qfxgTdlR0gFVx1SODHnUmZDLHhEOIyTwDaYyHF1/GnA6QsuddAYBHxIvSqPln9ErP3ENyeYjdthf6ntNxTRW0bfx7WrRDOTTTkkFCIAJObtzR8TAv5zZ6UQKILhprC4jZfgSZiVv7byQ==
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39860400002)(136003)(36092001)(36840700001)(46966006)(36756003)(54906003)(42186006)(36906005)(70206006)(83380400001)(110136005)(336012)(81166007)(4326008)(186003)(5660300002)(36860700001)(316002)(478600001)(356005)(8676002)(426003)(8936002)(82310400003)(107886003)(70586007)(47076005)(26005)(2906002)(86362001)(2616005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2021 07:39:28.7157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cf7a58-1b6c-4ab7-ff0c-08d97b409ccf
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT012.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR07MB8521
X-Proofpoint-GUID: eYJKKuxPydjShWr38SlFqvAU2MH_jN4n
X-Proofpoint-ORIG-GUID: eYJKKuxPydjShWr38SlFqvAU2MH_jN4n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-19_02,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=995 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109190053
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

