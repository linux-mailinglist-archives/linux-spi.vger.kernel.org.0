Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418F13D0A67
	for <lists+linux-spi@lfdr.de>; Wed, 21 Jul 2021 10:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbhGUHd2 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Jul 2021 03:33:28 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:59376 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235290AbhGUHdN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 21 Jul 2021 03:33:13 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16L88kKo000999;
        Wed, 21 Jul 2021 01:13:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=aCYCRSm4hSClhVqWQM7zcdC3JJs3/x/UPr8YVldrDD8=;
 b=j9gjtIDEPbXSJjfp2Uzb957Z2Gfnbl3uR5tXJf/5FZ8V0t0OX7NlkQvDTYGGkeK5LzrQ
 6yfemMw8Ew8iRwGP7Gok5V+ji5ni+sU6hxv/sT//fHI8jipwwxp4RMfHMykDvjsVLOod
 poB9pQe6isYQba/BW1/NN9XLL56ADggnnkEIOdKWR/A+x6ClUpFt5sIiLpO6PGtd0JaC
 07qw0siqwEMLKfL2BbZJ5Rs1YEbTdoNFUgYTmWz9o2Sqxn7UsA/eVcb0PnHJPhpW/8nh
 ymh2VmMmvyYY8EGoJML2exBuAgE0EFTTHwBtwKVlkXI9FwBlKqaBMhFKo64ubgYZ7t0i aw== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by mx0b-0014ca01.pphosted.com with ESMTP id 39wbkuxws0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 01:13:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EP2L5t+srLvRnGpH8/OtHUYyoS+UbM7ZVvXkSecodUK4d+7cT/QXlLy006zQgwegoaYdTQqWyzfmSCLCKdiah8Gat6LqV3tBfjSTal+ev07hTqMbKFDnFfuVOowGcdKhIj0i0u4TpM7OXo2854zLEuW2AY4nlKjCSbiVzGA2xPVvn5gRnPG8hKyLouMTuyRvMU+R+cetWEfyPXEJ/vb3ShM0uRypXQNkKqENKE5OcypJVvcOieb7LkTNNRJauPfYdc72pETzwVHRdaPgaI7HQlB9KuHYD2dRjc+SgLLi2NZiisGHzKovRjYT6iB/zwBt8pjdCaQVpkLfB7/xFBUJXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCYCRSm4hSClhVqWQM7zcdC3JJs3/x/UPr8YVldrDD8=;
 b=SKw3aeyR5zKyQAKwtOV04b607WIAdupcFyP0JtC+BNebvyikxvQogI7yDgk7aeMP2cI7ey7WaKHf3CiqzE2X/RBQtPxSZLQA6P1XFVXPGfsSVmt67f7V5D5hv46x1AURfpwrNcofVr+KtJhiO0X3NIEm33wHyBCe4bAKR1cTvQpo6V/+cYzm1W/428JjycfbuLIBetdkpc+nhFA9BcCbLCboGfSQedqxrbpA5h4zMbYHvvf+4ZqJVaRabPEarmN7VXbPopLKRpWudMrtkcNznkGRo7MVLG+hfLNbs6vxIrwmkwd+eLJxRCiKZS7E4v9wEoKkxTuhMtJpJyW6PR2D8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=bootlin.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCYCRSm4hSClhVqWQM7zcdC3JJs3/x/UPr8YVldrDD8=;
 b=05gDxQcHSxhGpJZ2AFwqno+/ikNC8atSu5aUq8UNNpehZWF/z0smbQJvN8s/nUPELrxARp/UtHEAw0A0vu5BAm1GSOCUvV+OgVjgF4EcS2pfRwN/1E6Sr0+KMWIh73+6yrKmGg4gJ6THnU+BDhWupkXQXNI7fuCkcBHJG9cgUBY=
Received: from CO2PR04CA0113.namprd04.prod.outlook.com (2603:10b6:104:7::15)
 by DM6PR07MB5099.namprd07.prod.outlook.com (2603:10b6:5:4b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Wed, 21 Jul
 2021 08:13:26 +0000
Received: from MW2NAM12FT017.eop-nam12.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::ff) by CO2PR04CA0113.outlook.office365.com
 (2603:10b6:104:7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend
 Transport; Wed, 21 Jul 2021 08:13:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 MW2NAM12FT017.mail.protection.outlook.com (10.13.180.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.9 via Frontend Transport; Wed, 21 Jul 2021 08:13:25 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 16L8DM9V029623
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 01:13:24 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 21 Jul 2021 10:13:22 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 21 Jul 2021 10:13:22 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 16L8DMKb025489;
        Wed, 21 Jul 2021 10:13:22 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 16L8DMeU025488;
        Wed, 21 Jul 2021 10:13:22 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <lukas@wunner.de>, <linux-spi@vger.kernel.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <jpawar@cadence.com>, Parshuram Thombare <pthombar@cadence.com>,
        Konrad Kociolek <konrad@cadence.com>
Subject: [PATCH v2 1/2] spi: cadence: add dt-bindings documentation for Cadence XSPI controller
Date:   Wed, 21 Jul 2021 10:13:20 +0200
Message-ID: <1626855200-25451-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1626855118-25327-1-git-send-email-pthombar@cadence.com>
References: <1626855118-25327-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50169675-5d4b-4364-9a1e-08d94c1f6a13
X-MS-TrafficTypeDiagnostic: DM6PR07MB5099:
X-Microsoft-Antispam-PRVS: <DM6PR07MB50990A53E2CA2D41B61480FCC1E39@DM6PR07MB5099.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mAIExFrq4y9oiWbK2j9rA8vD+VORuQprv5e1F37kUYAyBEXOys2qgebJvis9/lW76g8hU5KoJNsq00OUOper3ySC0fR8DMw7mpDOlOqRxbBwGZNYwseID5P8Qi+vMvRoYp+bwg0WgkwhmLHbfJQ0lGlyGXOk8YGC2ZmvimsJdYD+ZbrZYzIwavnzLVkoS5UrMtFeekitGSl27B8481rM5ulJDTAzOO4Yo8ieejgoyUKFdHRbStfbhwI8Amu6G8ONQapxq5C4D8d4kMBUf+d2VJMyqDyx1UVAu01VZuiAgnpZSUrK2tRsnthB1bQzZ4pSf9FPiT8c5J2bWd1RvdI0O6LN7ffxhh1lT6zu1oqWaKGOwjmY9yuzy42iAS60+IOE8OcPJpl3lAg0cyQ3wRDle7VerAPHyicNfovxxkmOoIt57fuZOeCTmacxyNluMOFSWmCjpMovCoyS0U7mCTn90WVaYZkdekUlrPlEC37aPZekjw7McqrYs4FpFsDwUqrugMi9FhVvbrm8oJuNQRvoMuIJfkoTDXJRCrU8tYCpFD0wPWDQMzWdc8VquEsam/pc+BUVgMalZ3Djg//gMS6xqOKoBNP2VZ3CF3g7Kkvr0nuhtF9t/giMyfN4BbqT1d1CZ6lB0AY2YP1wbgJQ/iELDeJoAeqINzssa35Zwecv+vLsTBgq4jhhOjO1aM+v8++aTA5LISoIkurLToQoYKYr+xj5jnx13rAeXlWcRm3DjV/W3uh/E01Btztueqp2U98WYxO6kfFiwdvFS1j8hW6Ddk6bR/mrx66JW68CaTuCd9FPTTdeIpofC/HJ3HbwitibLkhUF+WdPTTQCxWhHYuysw==
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39860400002)(376002)(36092001)(46966006)(36840700001)(2616005)(42186006)(8936002)(4326008)(316002)(356005)(2906002)(54906003)(5660300002)(70206006)(70586007)(26005)(83380400001)(8676002)(82740400003)(110136005)(36860700001)(47076005)(86362001)(107886003)(36756003)(186003)(478600001)(426003)(336012)(82310400003)(7636003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 08:13:25.6432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50169675-5d4b-4364-9a1e-08d94c1f6a13
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT017.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5099
X-Proofpoint-GUID: Rn1rizqvIwMB_Jl0B_H_L1_mBF9e2J4a
X-Proofpoint-ORIG-GUID: Rn1rizqvIwMB_Jl0B_H_L1_mBF9e2J4a
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-21_04:2021-07-21,2021-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 spamscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2107210045
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add DT binding for Cadence's XSPI controller driver.

Signed-off-by: Konrad Kociolek <konrad@cadence.com>
Signed-off-by: Jayshri Pawar <jpawar@cadence.com>
Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 .../devicetree/bindings/spi/cdns,xspi.yaml         | 169 +++++++++++++++++++++
 1 file changed, 169 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/cdns,xspi.yaml

diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
new file mode 100644
index 0000000..46e94ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
@@ -0,0 +1,169 @@
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
+properties:
+  compatible:
+    const: cdns,xspi-nor-fpga
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

