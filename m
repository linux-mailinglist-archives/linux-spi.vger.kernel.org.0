Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D12A3FDB4C
	for <lists+linux-spi@lfdr.de>; Wed,  1 Sep 2021 15:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345088AbhIAMko (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 1 Sep 2021 08:40:44 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:6470 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1344390AbhIAMiU (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 1 Sep 2021 08:38:20 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 181Ap6iq026026;
        Wed, 1 Sep 2021 05:37:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=y0iWmDRkobnLcGXfoAWHJ1P4kNflazBceW/waaKGBOg=;
 b=QHCzsiBQqW35/jHJsk0IPytxEHFZNYlWXKGLVhvc4Mn5yEugZ9ahBtQBnSPlB4lct1fL
 wZoHpqANw/AtwSImnN+pEJwdbTesR00k7lpKOntODbm6tRRmNdCjgHuVNqBcfxrDvkAh
 U10AzV6ehzk0V5hyJ0LVovfmjvh+b9UrAkwqaneyMPMyx+j4+5RaWdgR/TDTNylGVi/I
 KE184+SlBCIbvCYwPCo6FhT66sctuyg2Ir+Mi2yU3ssPe1YEO+6iBjYtCIywMzpfVosV
 xWY3zmRRgxMoBPemtaLGqGKtZhFcnePmCvkwsIyuqnZRtrwaGIMeoDkT2PeIvf7n3yLy cg== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3asd40nkux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 05:37:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UtHdDsulSUOmgnWvYl4KwaAhMytY9qdSTux+emRgGxJxmP9fqQ2Y6ciis/dxzKI2NFH+fZ5iDE5V/FYi5nncnSvJU3H0ZBFgcfJN72EPDlW8FPGYHhioelXgZuIKq7vCRpexmwK05H41U4h860cfzjdstBDldF6i5ks3/k29V4/k4yY+GJm4YmbJfTMrazPq622rjh5exm0b9NZNawCtNPBWBJS+tZ5zYRoRv84doxnPl/uQ/zW0xkAPYiZdmmQnqSsY6AC3Qt9/vAn+CAgvmPfz2cua8wuXXlT1zasFtdEzwgqOLH40z/2z8MPSx7H35DRNv5wEJpo8iFX4vpg7iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=y0iWmDRkobnLcGXfoAWHJ1P4kNflazBceW/waaKGBOg=;
 b=A2D2++xDaRij2in6sE1mxsXRFb1DisSJdWOlCtt1TgZ947Ub2jx3TSBYbM0H2w0fRbn8wDqX+qtlrBkhvHeaHHcT0xtR+QM5Ol+AGvwAzLnC4Go0hRNMVtFMFGPUh0u4AUh5Yo2tiQJxCj+IhoLEd5P6jW67Otrq83Pi/yHm+j9dvKb1kY86D4rSjBGLLysLcY6/16w0Ap0VLFlRe9Lkv1ui7m4CuXiSUiBnhXpjfirgtP1CY2pXo/HUSl8pw5OR9RGQeMlh3aPMtpdRfOeQEv0kAxh8/DWbP8rmdPhqibytz+343psN5umF5ZDwaaopZyIGeLsp7Dqudh0NdHyDag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0iWmDRkobnLcGXfoAWHJ1P4kNflazBceW/waaKGBOg=;
 b=FLnKeBxHMDnkdxE/Afyqrhef53XKCKASOjua8ku5bz8XEiAGMSF/sghdxZ01ptX/uuK6xt0CnY5YLwkucFk9PYPOg4b7iGE/j8GqPoS1MUgVg2wr7L5xDTZH1n942hcO86ixyvz1P1kpp5gBQPE60Y9EArxqinxML6sPPY4zccY=
Received: from MWHPR21CA0034.namprd21.prod.outlook.com (2603:10b6:300:129::20)
 by SN6PR07MB5184.namprd07.prod.outlook.com (2603:10b6:805:70::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Wed, 1 Sep
 2021 12:37:16 +0000
Received: from MW2NAM12FT036.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:129:cafe::23) by MWHPR21CA0034.outlook.office365.com
 (2603:10b6:300:129::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.1 via Frontend
 Transport; Wed, 1 Sep 2021 12:37:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 MW2NAM12FT036.mail.protection.outlook.com (10.13.180.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.8 via Frontend Transport; Wed, 1 Sep 2021 12:37:15 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 181CbCrM011291
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Sep 2021 05:37:13 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 1 Sep 2021 14:37:12 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 1 Sep 2021 05:37:11 -0700
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 1 Sep 2021 14:37:11 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 181CbBA7020096;
        Wed, 1 Sep 2021 14:37:11 +0200
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 181CbBi1020095;
        Wed, 1 Sep 2021 14:37:11 +0200
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <broonie@kernel.org>, <lukas@wunner.de>, <p.yadav@ti.com>,
        <robh+dt@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <mparab@cadence.com>, Parshuram Thombare <pthombar@cadence.com>,
        Konrad Kociolek <konrad@cadence.com>
Subject: [PATCH v3 1/2] spi: cadence: add dt-bindings documentation for Cadence XSPI controller
Date:   Wed, 1 Sep 2021 14:37:09 +0200
Message-ID: <1630499829-20059-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1630499755-18751-1-git-send-email-pthombar@cadence.com>
References: <1630499755-18751-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1e7534c-dfcb-459a-e3c1-08d96d453abb
X-MS-TrafficTypeDiagnostic: SN6PR07MB5184:
X-Microsoft-Antispam-PRVS: <SN6PR07MB5184E299857C7BCD6963F940C1CD9@SN6PR07MB5184.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uPhu86yTG7LHIpd9opzEdeTasr+dapqQybEUdxAXvgAQ1Vf6bbzxuJClbr3hkr62yWeWYanrP/l9yjw2TOBIerdsB2aZ/DZ68M+0N66PvQ9z12cNOwUWO4nBMGyYBNZX6dUoOakjWuUz4CULjueOfBj6Evz3ZicTgiGyOYe5haPKN2XbyU/UV8gh4/Oljs+d7b0MKWBZZzk0WCCWtyWxiVWSNZAekXHQ5x87v8oyw/8HBnjuCiOex5JrHlS7qyYjmahMGk1j7fni+FTC7j5PpXEXveW9Aogz9CwU7ZnZtzXXn4nu7WJl9k0ii11l/Xp5Wv4a3fK41VVpK56rrkSVPATWs4mEitj/Z96k4zcu4Pp7UTNUWjmSvB3RfAAU5+VZEcpY683MTPbNvWMtng+gZIjbl+3ZSaMxJ2lEu0AH2u3j16rr+jQOah8/kFLW8YiynCmHChxJqSxNKI7/t9jqdxq+pdMIKAlpZ9nDxUwRATV2sxz4zC5O6msY3PdOVSPAyeTYIXu75qtDs8VWX6PAFvt0X+tN8nv+s/RbXlFAJ5FmQ4veDRNCij68cpiN7HHwA+1ig1o7B+UbVSd6wTesX+K3KTv/suG7TqotoCJs74zkSfgnA2/+S8snw3QypN1ofkfL7W20jAinsl68BVQ3QNM+efJZwAzuU/86Xr24rKWDm16Rlp7efbtCyDNvi2LTidmCjb+yUioez9gTM7RFh64I2WAqNwCTn40CS038lhTs3jh4gPzSVZeFcywyOK74EzdUR5Udgh64f8A9Z9p3zfYaO8gddm5E+eUTPD+Dx7l6UyvOjLpjvLGjLrqx3zeY
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(39860400002)(36092001)(46966006)(36840700001)(316002)(36906005)(47076005)(26005)(86362001)(42186006)(107886003)(186003)(4326008)(36756003)(83380400001)(7636003)(36860700001)(82740400003)(82310400003)(8936002)(356005)(54906003)(110136005)(478600001)(426003)(2906002)(336012)(2616005)(8676002)(70206006)(5660300002)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 12:37:15.3517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e7534c-dfcb-459a-e3c1-08d96d453abb
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT036.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB5184
X-Proofpoint-ORIG-GUID: GH3A9ktdWWUUpbeS0eMpYKzSO5RKbBdl
X-Proofpoint-GUID: GH3A9ktdWWUUpbeS0eMpYKzSO5RKbBdl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-01_04,2021-09-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 mlxscore=0 spamscore=0 impostorscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2109010075
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Add DT binding for Cadence's XSPI controller driver.

Signed-off-by: Konrad Kociolek <konrad@cadence.com>
Signed-off-by: Jayshri Pawar <jpawar@cadence.com>
Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 .../devicetree/bindings/spi/cdns,xspi.yaml         | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/cdns,xspi.yaml

diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
new file mode 100644
index 0000000..e52d6fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
@@ -0,0 +1,66 @@
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
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    xspi: spi@a0010000 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        compatible = "cdns,xspi-nor";
+        reg = <0x0 0xa0010000 0x0 0x10000>,
+              <0x0 0xb0000000 0x0 0x10000>,
+              <0x0 0xa0020000 0x0 0x10000>;
+        reg-names = "xspi-iobase", "xspi-sdmabase", "xspi-auxbase";
+        interrupts = <0 90 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-parent = <&gic>;
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

