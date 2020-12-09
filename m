Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CB22D3C9E
	for <lists+linux-spi@lfdr.de>; Wed,  9 Dec 2020 09:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgLIH7m (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Dec 2020 02:59:42 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:26598 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725942AbgLIH7e (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Dec 2020 02:59:34 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B97vKFW029164;
        Tue, 8 Dec 2020 23:58:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=CcKoZZC0H2BicCm8jchAVhSeJ9kntWhPsZ57IjMQfzc=;
 b=Au2PAgvpjPEsCcxNvAgdFRHYPtkLMqUAxDsyLmhlbdPl0O++emsFjn/1lgd1xPtYoC+Z
 EMs94/AZDabp0aXpixqkv3ZzNbrgI5gusZgGE/1YCgwm3sY+DN5ueSGvduyRtCVONFXw
 xkR1W40cxHQEvzLqqynG9NKBIW9XVyAJdEtOPvt8jTH7JVIPhVAWNC3bRZZUWbLfJj2E
 WMIeStDAF1WKgZFDVl7oW0L/+l545Bgkef3SJr+IYmxeaV3DagHiyZX7Fhth9xP+gQfk
 R6m2/Yk8RCynnK7T9u9ItZXhZ3rp+FKvluGa+08KxbDOMlDbrbgJGrKoWQYhBTagNL5G MA== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2051.outbound.protection.outlook.com [104.47.44.51])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3587n2v169-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 23:58:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QiM7zbK+HMy7bJYWbzND4IsQpWivoaTL7zmhDL2ijWn7hkkzZjPor7oZ/dZ548Hfu02nc2wm1VisWAMkWSvkEWm+JrAiv5FHxYto+gOiLonFL3ibfAwXxpiL5v6kRY5DQUBrS/tmWmdm1VYNt/LBp8H6bXayEqh4YB04xiORfJB+JYkWODNmb7HHRexOc1gWOl/rh8NnAF+Ad4dLYkYBuiSy9UykDgyQlxKIBhNpSvtgpljvMwZqBTvnxwVotwOUbnkxGQ/DqcAYNNYK+9v5+xUndU1HBHPuuJRuoxZQDPa0m5I3MBdgpExl16bmExxOh17IIDP2Hjdqr0sRs3mjDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcKoZZC0H2BicCm8jchAVhSeJ9kntWhPsZ57IjMQfzc=;
 b=USZQgZiu6pNmIgpAisM2obdvMUWu31YBjSgVhVCziGgiAahDldZqmw3CP/BTBkop2j5kMiIrtC3nZcrY4KTZ67aSlBiIju+9Sc+k1Gbctzkfnps8JqLnQAuGKab7BA7O+lQPMfq0wzYhPOsxl0MAlEGkLoFkle12i8sCqRImHPTIrfkeJYlEVPG0oPDdjxJVg2X6t3bLTor+QX/lWiTE6XXPoTdk3AcQ0yma/Bo36SAzDhLUqIRsT0EXBOkOyqXBgu+s/JE5wIcjjNgSf2CQ2KfqVcpHv3YrFHyvfId7YdkjxCx/3+RYzwI4eavemdqxwT69/soNoK0ZQUzztaMMrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcKoZZC0H2BicCm8jchAVhSeJ9kntWhPsZ57IjMQfzc=;
 b=TfSo8H6+xMxyi2TMnexhCgyPA6R+KLsYx6F1CJhetCReynEquQJz7VqpR3UKTdLhTP7YL4cZub94w2Q0uyPaMS0Ts44mcBugpe60XAb5kA2bY1cs9DCWkDkp6bnYW/2OlCM18j9vuwmgma7m3KOsMVFn8tQPYXl1V4cNpG+2G3k=
Received: from BN7PR02CA0032.namprd02.prod.outlook.com (2603:10b6:408:20::45)
 by BL0PR07MB4081.namprd07.prod.outlook.com (2603:10b6:207:49::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Wed, 9 Dec
 2020 07:58:21 +0000
Received: from BN8NAM12FT041.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::3d) by BN7PR02CA0032.outlook.office365.com
 (2603:10b6:408:20::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12 via Frontend
 Transport; Wed, 9 Dec 2020 07:58:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT041.mail.protection.outlook.com (10.13.182.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.10 via Frontend Transport; Wed, 9 Dec 2020 07:58:20 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 0B97wFQ9002826
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 8 Dec 2020 23:58:19 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 9 Dec 2020 08:58:15 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 9 Dec 2020 08:58:15 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0B97wFYg024505;
        Wed, 9 Dec 2020 08:58:15 +0100
Received: (from jpawar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0B97wFxb024504;
        Wed, 9 Dec 2020 08:58:15 +0100
From:   Jayshri Pawar <jpawar@cadence.com>
To:     <linux-spi@vger.kernel.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <dkangude@cadence.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>, <jpawar@cadence.com>,
        Konrad Kociolek <konrad@cadence.com>
Subject: [PATCH 2/2] Add dt-bindings documentation for Cadence XSPI controller
Date:   Wed, 9 Dec 2020 08:57:58 +0100
Message-ID: <1607500678-23862-3-git-send-email-jpawar@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1607500678-23862-1-git-send-email-jpawar@cadence.com>
References: <1607500678-23862-1-git-send-email-jpawar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19e1a3f1-b0d8-4704-0982-08d89c183259
X-MS-TrafficTypeDiagnostic: BL0PR07MB4081:
X-Microsoft-Antispam-PRVS: <BL0PR07MB40816F2D99DA45008B31DB85C1CC0@BL0PR07MB4081.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vemRNknMEWPc79fC6FL7DKOf4a0gWAaUSSTwbgD3iM+FwH8J2j1rb1ZSID6kKHjC7yTWhNYFXnMU6evVUPg8Xn0eTMilMzq9L36QIbHo96ueeAWLn7D58gwWHtEFCJc4daiGCeeB9X7bOSLlnh8rSRIk0iOGUqaWBER3pX2rgpNO1+pJb8K3W5dcmbx3FAuO927fx/I/eoxZB+pnOwmQs5EndOWHalEMO6kRfztKd++0+VHTZuwlKFt9pCSMzS9KC7Wog/eZ8DA/nLPoW0lLc60DgNzYTDNalAB3lfGkPdr5pZu/PLUUVqf2M+WSOnle2s7jJICb2SA9OofnCObAz8EWoQjdbOIjW6/I53/YqITVbySXYcLjsgipil8EEeQ8QFVUoX9j7pJe/pO4a87d7XY9Q2Xj5jIJMSgaEil1jFfPMbN86z1YlxxQfIi6iPMBlGqC/++BKqpdQ4CpOPbMw+DYGcQklWVMpi+t+P6ZZGEaoCYM5M01PUkJyTio1UIeY6k5WdpIL7YYrR2kzIVECg==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(36092001)(46966005)(86362001)(82310400003)(426003)(36756003)(42186006)(83380400001)(70586007)(34020700004)(8676002)(508600001)(356005)(36906005)(70206006)(4326008)(54906003)(7636003)(2906002)(107886003)(47076004)(6666004)(336012)(26005)(2616005)(8936002)(6916009)(186003)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2020 07:58:20.9480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e1a3f1-b0d8-4704-0982-08d89c183259
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT041.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB4081
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-09_07:2020-12-08,2020-12-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 clxscore=1011 phishscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=1 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012090056
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add dt-bindings documentation for Cadence XSPI controller
to support SPI based flash memories.

Signed-off-by: Jayshri Pawar <jpawar@cadence.com>
Signed-off-by: Konrad Kociolek <konrad@cadence.com>
---
 .../devicetree/bindings/spi/cdns,xspi.yaml         | 164 +++++++++++++++++++++
 1 file changed, 164 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/cdns,xspi.yaml

diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
new file mode 100644
index 0000000..a7d95b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
@@ -0,0 +1,164 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2020 Cadence
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/spi/cdns,xspi.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Cadence XSPI Controller
+
+maintainers:
+  - Jayshri Pawar <jpawar@cadence.com>
+  - Konrad Kociolek <konrad@cadence.com>
+
+description: |
+  The XSPI controller allows SPI protocol communication in
+  single, dual, quad or octal wire transmission modes for
+  read/write access to slaves such as SPI-NOR flash.
+
+properties:
+  compatible:
+    const: cdns,xspi-nor-fpga
+
+  reg:
+    items:
+      - description: address and lentgh of the controller register set
+      - description: address and lentgh of the Slave DMA data port
+      - description: address and lentgh of the auxiliary registers
+
+  interrupts:
+    maxItems: 1
+
+  cdns,dqs-last-data-drop:
+    type: boolean
+    description: |
+      This parameter should be set when the Flash Device being used
+      issues data on negative edge of Flash clock and returns them with
+      DQS and the PHY is configured to sample data in DQS mode.
+      If this param is set the controller internally requests this redundant
+      data at the end of the transfer cleaning up the PHY FIFO.
+
+  cdns,phy-data-select-oe-start:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Adjusts the starting point of the DQ pad output enable window.
+      Lower numbers pull the rising edge earlier in time and larger
+      numbers cause the rising edge to be delayed. Each bit changes
+      the output enable time by a 1/2 cycle resolution.
+
+  cdns,phy-data-select-oe-end:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Adjusts the ending point of the DQ pad output enable window.
+      Lower numbers pull the falling edge earlier in time and larger
+      numbers cause the falling edge to be delayed. Each bit changes
+      the output enable time by a 1/2 cycle resolution.
+
+  cdns,phy-dqs-select-oe-start:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Adjusts the starting point of the DQS pad output enable window.
+      Lower numbers pull the rising edge earlier in time and larger
+      numbers cause the rising edge to be delayed. Each bit changes
+      the output enable time by a 1/2 cycle resolution.
+
+  cdns,phy-dqs-select-oe-end:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Adjusts the ending point of the DQS pad output enable window.
+      Lower numbers pull the falling edge earlier in time and larger
+      numbers cause the falling edge to be delayed. Each bit changes
+      the output enable time by a 1/2 cycle resolution.
+
+  cdns,phy-gate-cfg-close:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Normally the gate is closing then all bits of dfi_cebar are high
+      or when dfi_rd_pre_post_amble and rebar_dfi are high. This parameter
+      allows to extend the closing of the DQS gate. Recommended zero.
+
+  cdns,phy-gate-cfg:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Coarse adjust of gate open time. This value is the number of cycles
+      to delay the dfi_rddata_en signal prior to opening the gate in
+      full cycle increments. Decreasing this value pulls the gate earlier
+      in time. This field should be programmed such that the gate signal
+      lands in the valid DQS gate window.
+
+  cdns,phy-rd-del-select:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Defines the read data delay. Holds the number of cycles to delay
+      the dfi_rddata_en signal prior to enabling the read FIFO.
+      After this delay, the read pointers begin incrementing the read FIFO.
+
+  cdns,phy-clk-wr-delay:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Controls the clk_wr delay line which adjusts the write DQ bit
+      timing in 1/256th steps of the clock period in normal DLL
+      locked mode. In bypass mode this field directly programs
+      the number of delay elements.
+
+  cdns,phy-use-lpbk-dqs:
+    type: boolean
+    description: |
+      This parameter chooses lpbk_dqs to capture data for reads.
+      Instead memory DQS will be used.
+
+  cdns,phy-use-ext-lpbk-dqs:
+    type: boolean
+    description: |
+      This parameter chooses external lpbk_dqs for data capture
+      (lpbk_dqs connected to the lpbk_dqs_IO pad). When not used
+      mem_rebar_pad is used for data read capture.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - cdns,phy-data-select-oe-start
+  - cdns,phy-data-select-oe-end
+  - cdns,phy-dqs-select-oe-start
+  - cdns,phy-dqs-select-oe-end
+  - cdns,phy-gate-cfg-close
+  - cdns,phy-gate-cfg
+  - cdns,phy-rd-del-select
+  - cdns,phy-clk-wr-delay
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    xspi: spi@a0010000 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "cdns,xspi-nor-fpga";
+        reg = <0x0 0xa0010000 0x0 0x10000>,
+              <0x0 0xb0000000 0x0 0x10000>,
+              <0x0 0xa0020000 0x0 0x10000>;
+        interrupts = <0 90 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-parent = <&gic>;
+        cdns,dqs-last-data-drop;
+        cdns,phy-data-select-oe-start = <0>;
+        cdns,phy-data-select-oe-end = <4>;
+        cdns,phy-dqs-select-oe-start = <0>;
+        cdns,phy-dqs-select-oe-end = <1>;
+        cdns,phy-gate-cfg-close = <3>;
+        cdns,phy-gate-cfg = <0>;
+        cdns,phy-rd-del-select = <5>;
+        cdns,phy-clk-wr-delay = <64>;
+        cdns,phy-use-lpbk-dqs;
+        cdns,phy-use-ext-lpbk-dqs;
+        flash@0 {
+            compatible = "spi-nor", "micron,mt35xu512";
+            spi-max-frequency = <75000000>;
+            reg = <0>;
+        };
+        flash@1 {
+            compatible = "spi-nor", "micron,mt35xu512";
+            spi-max-frequency = <75000000>;
+            reg = <1>;
+        };
+    };
-- 
2.7.4

