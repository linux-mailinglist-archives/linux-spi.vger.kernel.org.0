Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F334142B53
	for <lists+linux-spi@lfdr.de>; Mon, 20 Jan 2020 13:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgATMzW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 20 Jan 2020 07:55:22 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:40602 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726589AbgATMzV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 20 Jan 2020 07:55:21 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00KCsp7w019358;
        Mon, 20 Jan 2020 04:55:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=ymXwPV7N0z8pWiJF4OVAbpIsarqquKFT9NB3l2rrrFg=;
 b=cEgdlDajTIeolO/rt7p0QEKnRZRZFD70RbiSadNYcEUVDODlhwIHnImk0IrGWK8Wb0UZ
 bGtGC6+ThCPZdE/yMrmx3sLEAzLb+YHJ89UrcRS4aJ8XVduyGNAlQBSHGZnlm0VECmnc
 WhSbL0LByEtkW0Qo5gFjOx/IixjFvpModkTIsv/LlyaTe4+eJKvhJX12PogmHq5xLBoS
 Xe+OiYkwuIqSXPkWPdnipa2shkhh9Qc4/6b4MD0AI/e7ASu2uEvkO2JR1VbP/CsFxOxs
 KuQj3cqPxaPSC9Jox8xll9moHCLemR/sdRJtIBG8kSeQm1pFMufcJt0bmk4k2O8Y6QDg Zw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2xkxg3njmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jan 2020 04:55:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWBQ2+6F1EfS26d2HMQC+CGy/0hfUnYr6Cswqeif7CdI6vrhzAjKdO/32ILp8m8X63R+55pURFQSLkIHcaJSSr6j6IEP/p0/y6JKI6nYGfXNXpz0xWSYERzqQPFHzNJBxxVBFo0axQmfcWLp/EJ4SN2lQongy+onittoMtc2EkCtoftJQR4z1LT2+5k8RROr0QmsUVhgAzYK2UZ2ZDqbxUCcYZEZKoLOisqXezr/Z4yqt/KyMolGUDQ1EAfWpAZcehjIxZ3qwGRDj/BcEB30yFXxDXPlyckQBAHjCoiv98BxGRdLSCTtQ1+hjZGIg2ezAPyOX/6cEfZuvU8SRa7rBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymXwPV7N0z8pWiJF4OVAbpIsarqquKFT9NB3l2rrrFg=;
 b=X66QRMxiWbF6BHdkY2ZImQRcaVmFXUW7YGk/H5wNpUJakB+c0nYpROJaxR1+TSOzpel8RWQlG7WlFk4523JvvfJIRQPcRV6kcn1vUNDRsPuHkMXyv0sqtwlNWHeNmsqQl4/mpyyXmynd8Ct03clycd9l7GO6kuYUNH5/F35qoUDu4oo9ey1SanAb8byTSpaBCoIthqifTm13blhCREi91DufcZtL9FopWfe825v7fd4UroehMB97ez6iiYmhqHOAyPsIqGvZs9tF8gGYTEy4A1P9SnxaQQF+Qfj7izR9XyJNYm0poZ5GiVelsrm7/RXwvZvdad9a3gxf/ZTRuh2Z5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.28) smtp.rcpttodomain=arm.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ymXwPV7N0z8pWiJF4OVAbpIsarqquKFT9NB3l2rrrFg=;
 b=Uens8dFxXEPBKXxaxaA0Wiw3sBkzxrKYCRK6J0htNBRQXx8XLHOzUa8+jThcJ5ekr0fDWjDRT8xU9VCKt+wz9/bveYQj6P0HYPG6ayyAMZ9uzDjoWJn2GYU8MZuRE352uSaR0pae2jPN/ttqmO9ks56DDbB0DAr39bEqyhG3czk=
Received: from BYAPR07CA0029.namprd07.prod.outlook.com (2603:10b6:a02:bc::42)
 by DM5PR07MB4117.namprd07.prod.outlook.com (2603:10b6:4:b5::38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20; Mon, 20 Jan
 2020 12:55:13 +0000
Received: from DM6NAM12FT055.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe59::204) by BYAPR07CA0029.outlook.office365.com
 (2603:10b6:a02:bc::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Mon, 20 Jan 2020 12:55:13 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.28; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM6NAM12FT055.mail.protection.outlook.com (10.13.179.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.6 via Frontend Transport; Mon, 20 Jan 2020 12:55:13 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 00KCtAjV001817
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 20 Jan 2020 07:55:11 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 20 Jan 2020 13:55:09 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 20 Jan 2020 13:55:09 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 00KCt9cu010418;
        Mon, 20 Jan 2020 13:55:09 +0100
Received: (from konrad@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 00KCt9mw010414;
        Mon, 20 Jan 2020 13:55:09 +0100
From:   Konrad Kociolek <konrad@cadence.com>
CC:     Konrad Kociolek <konrad@cadence.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] spi: Add dt-bindings schema for Cadence XSPI controller driver
Date:   Mon, 20 Jan 2020 13:54:31 +0100
Message-ID: <20200120125443.9523-1-konrad@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(39860400002)(376002)(36092001)(199004)(189003)(1076003)(8676002)(426003)(109986005)(86362001)(2616005)(5660300002)(316002)(54906003)(36756003)(42186006)(336012)(6666004)(81156014)(356004)(81166006)(4326008)(26826003)(186003)(8936002)(2906002)(70586007)(70206006)(478600001)(26005)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB4117;H:rmmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a8c335e-08ac-4855-ee29-08d79da7fd4f
X-MS-TrafficTypeDiagnostic: DM5PR07MB4117:
X-Microsoft-Antispam-PRVS: <DM5PR07MB4117D8061E5DFF622B6A362FC3320@DM5PR07MB4117.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0288CD37D9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OjW30zX1McxqLpQmuJ2pHQVdkhC0/ZiVaRDfmxczmJpG+rQpeJBM93J2WDdiBRWCEL/+g5uytGrLCoecgVMl1jNcmNoM5TwWCOAiXBt7F5f/3Q6LjNFO0+fxecg0wY42doKH4TNSNRQs4Yv1l2h1mjJUBmws9Z2Eug8W1N7G2eH2XVShY6LhFd21wiOWXrpn48J4hi9xgryuxvkBi/EQVuAzVLP3I8uDjWlVYEBVcPsAtzeNoROS/psYNxT5LLIY+3itdzXg8h9ANYxZx1hb1DRLA1pmorKHk6SuSsZjO5FOcVCfjyGlFqQIS2CNO3v0WpseAu63xVlMXDVFbFZ/P2iX7x5OSeyqWfA9GFa7ilZ6/ZtC0j2Hl+0mPODfC2aSkAxc5enqt9PS4MAfXqGfbXJupH5avmLFbU2yNB0s+kOvxhyyZnDk4TZkaTUJDU44mZiMjmDJlNLLEoxei9jk4Lxk78lbwlkfiL2pT1iBoWTCGFXdBUs2g3JSsfS5vBDlQjfTjqDi0RutHOPIFkalsfjUZPPjP7vWrzRIgxyNEbLSThTVEkMP9BU93U7aNLpNS5A9kwrkQNZyudy2XSpK6g==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2020 12:55:13.0538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8c335e-08ac-4855-ee29-08d79da7fd4f
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB4117
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-20_02:2020-01-20,2020-01-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 clxscore=1011 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001200111
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add dt-bindings documentation for Cadence XSPI controller to support
SPI based flash memories.

Signed-off-by: Konrad Kociolek <konrad@cadence.com>
---
 .../devicetree/bindings/spi/cdns,xspi.yaml         | 164 +++++++++++++++++++++
 1 file changed, 164 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/cdns,xspi.yaml

diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
new file mode 100644
index 0000000..2d6a362
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
@@ -0,0 +1,164 @@
+# SPDX-License-Identifier: (GPL-2.0)
+# Copyright 2020 Cadence
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/spi/cadence,xspi.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Cadence XSPI Controller
+
+maintainers:
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
+    maxItems: 3
+    description: |
+      Contains three entries, each of which is a tuple consisting of a
+      physical address and length. The first entry is the address and
+      length of the controller register set. The second entry is the
+      address and length of the Slave DMA data port. The third entry is
+      the address and length of auxiliary registers.
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
+        mt35xu512@0 {
+            compatible = "spi-nor", "micron,mt35xu512";
+            spi-max-frequency = <75000000>;
+            reg = <0>;
+        };
+        mt35xu512@1 {
+            compatible = "spi-nor", "micron,mt35xu512";
+            spi-max-frequency = <75000000>;
+            reg = <1>;
+        };
+    };
-- 
2.7.4

