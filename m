Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD8F14B45D
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jan 2020 13:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgA1Mnc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 28 Jan 2020 07:43:32 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:28644 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725852AbgA1Mnc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 28 Jan 2020 07:43:32 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00SCeSZ1017772;
        Tue, 28 Jan 2020 04:43:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=7TH16w5/kGmAgaA4RxWzLdN/Lo4lQG3M9OZvMS11pew=;
 b=kn8X66poYQpw1RMIERtfpuVTrRikYhrVr00HqErAUfb77+MTtXEd5ekcOr4G/fp7mPGm
 glPqICrw+gF4jdM6QF0jenxCl65ixREC++QKDvnomFi0+IembuVw1T82fbbB2bX3rHe9
 RHi/9o+NP/C+AFSdiPq6OiJw6ZmTaTXrkpB4wHiWNCMFtrrT3X0KX912R9DRCozzmwcx
 w20G3CxnsbalLsWhhRTOCz0wkRCWNRCUrhSOYj+2cZ9Vm9Ny/0JSA8pJKAZLM2ma7XNf
 2qKoUsz5f+1p4gTUdJsl1/h/1O0r2YHasYEPnZPEfmlL1/9PFKvTWPxYs+6R0sLc4UMY qA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2xrj53b5ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jan 2020 04:43:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+23PX5bc7jo0c6DJbL1MmUeJLBAyviptcfqVBG4vS2kveAso904868ge0vzLpFMjYz62Cogx387bUdtFQ2NtUXkrNpnX+oHqG4Ln/kY3F1cyH2qWKLTEz73FzD9sPCSpTsaoNQHFaqxx9Yx1TlF97T02hjyN2ya8BGoEntIC3w1vffFibHqxnn8w4n+DtNRTfBmyKimGgCrPNl+rbxRY8Hi/yBM+cZiAJRvN7ObqhPTbIb7QO1KL61qkC+WJufPZMDznmbrgxjB2zb75SkfF04qLhK5IcFAxiS/u8u8F325BTY/AMtvlAZK8/uETuJQQxLM0ptmnJ9ytGMbkJP5Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TH16w5/kGmAgaA4RxWzLdN/Lo4lQG3M9OZvMS11pew=;
 b=SrHSeqFjFi4Tv5xkwfrZZCFj/fYa8XjUVQzPFjUUqxvEzI2bhovZaQuSspMkEHdEurz1kUo10bp4MQ6hEbmaqiYVBatDbv1PU04+clk2/0JhFibLvU2m3p073h/6g8kTL0guvXiKsBoHt5fvC6YvEbJ1o8uxOCejEc+JiJimA6VDifaw8PW2Ld9No3khrbPk8ZM11H0shRr/QqqCUofeaBPNrgwvY1LO1M8nYM/NW486QJHgjANGYH+ogt/gWcUUywNXQ5pZa9OaF8y6N1U0q5GSkUxH47yfWZ706WTUUNptPVybm4zzaqgoGePeazD/FE8YaLhgx54UYBJzbo7GfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.28) smtp.rcpttodomain=arm.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TH16w5/kGmAgaA4RxWzLdN/Lo4lQG3M9OZvMS11pew=;
 b=AkaKmWVv/RepgeRqv7+CwfFQ1jDDWtIs3A/49eVBgaDMuWToTSEsr3At8SmNdUdCbn+ZRauKrkz5jiiphSC+8J4aIOCnMTglk0kcF0uj5EU8Yck1tI7Zv6TgKB8kaszjk796TiFzNFxo1twwREwXF25LmlE3Bg/Jd/fH1qxHRu8=
Received: from BN8PR07CA0034.namprd07.prod.outlook.com (2603:10b6:408:ac::47)
 by BYAPR07MB6038.namprd07.prod.outlook.com (2603:10b6:a03:138::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20; Tue, 28 Jan
 2020 12:43:24 +0000
Received: from BN8NAM12FT065.eop-nam12.prod.protection.outlook.com
 (2a01:111:f400:fe5b::200) by BN8PR07CA0034.outlook.office365.com
 (2603:10b6:408:ac::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.26 via Frontend
 Transport; Tue, 28 Jan 2020 12:43:23 +0000
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.28 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.28; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BN8NAM12FT065.mail.protection.outlook.com (10.13.182.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.12 via Frontend Transport; Tue, 28 Jan 2020 12:43:23 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 00SChIp8011308
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 28 Jan 2020 04:43:20 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 28 Jan 2020 13:43:18 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 28 Jan 2020 13:43:18 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 00SChIC1013058;
        Tue, 28 Jan 2020 13:43:18 +0100
Received: (from konrad@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 00SChI2w013057;
        Tue, 28 Jan 2020 13:43:18 +0100
From:   Konrad Kociolek <konrad@cadence.com>
CC:     Konrad Kociolek <konrad@cadence.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] Add dt-bindings for Cadence XSPI controller
Date:   Tue, 28 Jan 2020 13:43:04 +0100
Message-ID: <20200128124313.12837-1-konrad@cadence.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(36092001)(189003)(199004)(70586007)(70206006)(186003)(336012)(26005)(426003)(36756003)(42186006)(316002)(54906003)(109986005)(5660300002)(4326008)(478600001)(26826003)(86362001)(7636002)(356004)(6666004)(1076003)(2906002)(2616005)(246002)(8936002)(8676002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB6038;H:sjmaillnx1.cadence.com;FPR:;SPF:Pass;LANG:en;PTR:corp.Cadence.COM;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1154af8e-18b2-4292-3229-08d7a3efa99e
X-MS-TrafficTypeDiagnostic: BYAPR07MB6038:
X-Microsoft-Antispam-PRVS: <BYAPR07MB60386CE3B8C1C967B8EFCE89C30A0@BYAPR07MB6038.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 029651C7A1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SRw+Jgs7T7BhbO4k0W1YkOg0nH756BFuLpBVxH2Jnb2j9p5fu92wvdRBFKjeQp9foTzDym3nLsP2LTrVRKaM3l6xhA87sutoVcFQkHEnQkysA8VGezNwJEqJ1wOSHi73j8kHh29H1xpnT8RSPE9+AjLxX3qaD8T7u8+17ndBd0qJ6JmrMX626iVoBW5jvrHlIcj62H/3SnAe84xFLqbEoNR6WPzvfKCeZFNECaIqj47itY+kef5AU0CjcW4EXerfLlXk+Fk1UxOcPwiNUuS+NjeEAdQZMDXzTv5406niqLkM/0UXxxMoZe+IXi9WarTyq4l9lyP8jvdSSrwI/8EzY6HJ5AkolU4GmX1bbjxFpKRvJX16I+BsXnP9bJoP95FiA20aTOFaud37nU4QulwI1w/hZg3plljm63+eRW6g9Zcq3l/z0FURJuhxn3CWoqLvWqNp1xiwciV/ed3TJ4181TxYgcWUBpcv/P00UYMJTX4SsH/6OOPGfYP+2ujkpYX3W8xQuKn1Qv9UNT0yX2zYM3MJO2z3PKSLlEMFHTn4V02P1LPvIPSQ2IPW8jYU+fz/2PgHRjlzzXPTm7iCPvebEw==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2020 12:43:23.3043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1154af8e-18b2-4292-3229-08d7a3efa99e
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB6038
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_03:2020-01-24,2020-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001280103
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add dt-bindings documentation for Cadence XSPI controller to support
SPI based flash memories.

Signed-off-by: Konrad Kociolek <konrad@cadence.com>
---
Changes between initial version and v2:
  - renamed yaml file
  - added missing include

 .../devicetree/bindings/spi/cdns,xspi.yaml         | 166 +++++++++++++++++++++
 1 file changed, 166 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/cdns,xspi.yaml

diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
new file mode 100644
index 000000000000..e8c43957fd90
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
@@ -0,0 +1,166 @@
+# SPDX-License-Identifier: (GPL-2.0)
+# Copyright 2020 Cadence
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/spi/cdns,xspi.yaml#"
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
2.15.0

