Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1C2F41700F
	for <lists+linux-spi@lfdr.de>; Fri, 24 Sep 2021 12:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245587AbhIXKLf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 24 Sep 2021 06:11:35 -0400
Received: from mail-bn7nam10on2069.outbound.protection.outlook.com ([40.107.92.69]:13793
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245488AbhIXKLe (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 24 Sep 2021 06:11:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LpFi5dy/KbF/nshoGT9IIC43mBOixLIAv0RNkKolw5FytmwY1Z6geeOPQ4/wv5tr8RF60nB8FpmZQJTmY50Xz2eguTxxBMCPOU9szEqYs5p6fXHeGloOdIu8x16IumdowLUQB+SGAq5qx0WMDU/Co89gLDhkdrdB3l06kixD7yEiX5UdU/jIbwLUPZoRY5yxCXv8daM+FpcTYxsETCixSfUWrUufmHaA1E0ClO6oPN4iwCcJzwJEbl9TX3OSl8lS/Gf4lnq470UX4x6ReeSyHcOv26MwGo2HJjfMETetxYdKPRBBIv8rw/sCdxQ4ktQhnSMC0fsbN3/E81nPv6kZoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4VAwDH5gYqf4VfKP7Zs5yYNE9MxiEvP5lqkcNsU/tls=;
 b=jQ16pAMQlJS1SfS8WmiWbHRqlyhpzwzIuQHOBt/gRD1/uU0sBCWH5Uvte6w+XNyoLiqyruopdm4F5lYIIUefRaIH/BJjmFzwNZu7M5qg8yyBTokLovVXOLTYpE5KnU1l/cnwoZBsfAjSdgiDHXCf8tXIeQucy8e/sxXWW4QUg3kyOej4LUAfcALRQxh4q4LCTKnjbNdT6T3i2ekBxH0sAdRSVf0PgweGJcuoqMcdMWjVdh3GnkMn4zCchGk4iYkL/DgmRelwe9R/XsvPc7QF9B47jEWm4Gi58LqYsL0WtOVn8f7jcHtqYZJCW8aB386UZvPRuks4ssH9kQc3ymu3Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=arndb.de smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VAwDH5gYqf4VfKP7Zs5yYNE9MxiEvP5lqkcNsU/tls=;
 b=YehBhCc26G70O9xQUyns6dawQMVo14RCWgk/MscCC0y+4svRX/eAscU023sZ0aCKof8PO6JB1L4pFrLS+IgcEZMEONXEpQo9HYKrD2N+v8Z40EFjiCsMGqhNuZSaVT8+nyUUPK910ZwUaOQHnl1JM/ehfQ4rc1ypoYqd/X4y8oc=
Received: from BN6PR13CA0017.namprd13.prod.outlook.com (2603:10b6:404:10a::27)
 by SA0PR02MB7274.namprd02.prod.outlook.com (2603:10b6:806:e8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Fri, 24 Sep
 2021 10:09:59 +0000
Received: from BN1NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:10a:cafe::2) by BN6PR13CA0017.outlook.office365.com
 (2603:10b6:404:10a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.8 via Frontend
 Transport; Fri, 24 Sep 2021 10:09:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT062.mail.protection.outlook.com (10.13.2.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 10:09:59 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 24 Sep 2021 03:09:44 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 24 Sep 2021 03:09:44 -0700
Envelope-to: git@xilinx.com,
 arnd@arndb.de,
 saikrishna12468@gmail.com,
 broonie@kernel.org,
 robh+dt@kernel.org,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 iwamatsu@nigauri.org,
 p.yadav@ti.com,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org
Received: from [172.23.63.68] (port=40686 helo=xhdvnc208.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lakshmi.sai.krishna.potthuri@xilinx.com>)
        id 1mTi9H-0003Zq-FL; Fri, 24 Sep 2021 03:09:43 -0700
Received: by xhdvnc208.xilinx.com (Postfix, from userid 14964)
        id 48318207A4; Fri, 24 Sep 2021 15:39:16 +0530 (IST)
From:   Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <git@xilinx.com>,
        <saikrishna12468@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: [PATCH 2/4] dt-bindings: spi: cadence-quadspi: Add support for Xilinx Versal OSPI
Date:   Fri, 24 Sep 2021 15:37:09 +0530
Message-ID: <1632478031-12242-3-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1632478031-12242-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
References: <1632478031-12242-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 650c71be-8b36-4da1-cd71-08d97f437763
X-MS-TrafficTypeDiagnostic: SA0PR02MB7274:
X-Microsoft-Antispam-PRVS: <SA0PR02MB7274CE8FE7EAA33A5AB78419BDA49@SA0PR02MB7274.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VIW9US/iGJO8h5KKQ8GZcRf8yImrup9zB19vd4cxF4oPr+J5cFVSxZhRgAPgLUZSvxSigQRv6PUzYp4QLLObzD2RJVfcXFihhjeyK4BklP8MZVIVKjBXefMqPXGl/qmoVEBJtTy8TRPceGilLa6LaIgnGw3+WkctfuKNcz1gOX08uBQJwjDK6qkYNK94Mc35APwOCuvRhaWbdnP1v+Wb194fZm563LOMm1ErX35kDs84RI1mNGhoBOgAyQaxycu7C3mVfi1ktgKdcczk+fxJkeXKnyHi9G4nUTvHCSAeKC3QOHrTTTexkbev9dWJxcIKY+d3rjx+Pu7bw1wBp2ZWjXbpgHVRy21LC2t4Oz5FkUDB4FMs52dBYFapuBzlCRMmOlOooUwJTikuFzqsmOBCqEQwsfSw7uNJTDG7NMfzHY65T+hl46s+fvw1bSXQ8OH9PiNupaO2cjvkTltfUplte+7WofMfvUQ18whLuwGQXrUj4dhh50FdUlqHGLVUGaUiPvvLekRo+VYBWdUduu/vDzyQzPNfz/17co0xPWlWpB0JKYyVE0d5UE7Ror2SKK6xMVNukcW/oirqHq1yrM2zYsilYCYsZX4WWi/eQJkF1KaQ40DNbjNHzJngKuEBSfV7XyvbhMc6rjFNtGWFkMc0m6UJIGrfZGJmc80X1IypUzd9ZWYUnck1OGiPaLkubxnkWbMcwGPFsh4jFXB0EWSmE7pqSekzI7aC8X3UYRI45oE=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(6666004)(2616005)(47076005)(26005)(8936002)(70586007)(70206006)(6266002)(36860700001)(5660300002)(2906002)(508600001)(7636003)(42186006)(316002)(36906005)(4326008)(8676002)(83380400001)(186003)(82310400003)(107886003)(54906003)(356005)(36756003)(336012)(7416002)(426003)(110136005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 10:09:59.0802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 650c71be-8b36-4da1-cd71-08d97f437763
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT062.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7274
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add new compatible to support Cadence Octal SPI(OSPI) controller on
Xilinx Versal SoCs, also add power-domains property to the properties
list and marked as required for Xilinx Versal OSPI compatible.

Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
---
 .../devicetree/bindings/spi/cdns,qspi-nor.yaml       | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
index 0e7087cc8bf9..ca155abbda7a 100644
--- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
+++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
@@ -11,6 +11,14 @@ maintainers:
 
 allOf:
   - $ref: spi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: xlnx,versal-ospi-1.0
+    then:
+      required:
+        - power-domains
 
 properties:
   compatible:
@@ -20,6 +28,7 @@ properties:
               - ti,k2g-qspi
               - ti,am654-ospi
               - intel,lgm-qspi
+              - xlnx,versal-ospi-1.0
           - const: cdns,qspi-nor
       - const: cdns,qspi-nor
 
@@ -65,6 +74,9 @@ properties:
       data rather than the QSPI clock. Make sure that QSPI return clock
       is populated on the board before using this property.
 
+  power-domains:
+    maxItems: 1
+
   resets:
     maxItems: 2
 
-- 
2.17.1

