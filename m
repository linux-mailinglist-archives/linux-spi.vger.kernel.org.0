Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AAD2746CF
	for <lists+linux-spi@lfdr.de>; Tue, 22 Sep 2020 18:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgIVQkc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Sep 2020 12:40:32 -0400
Received: from mail-co1nam11on2051.outbound.protection.outlook.com ([40.107.220.51]:8161
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726558AbgIVQka (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 22 Sep 2020 12:40:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOo4HeAgQwPp55sColpEQjpWxGJiaYFQdwZi0ggXzQcAQL7OhkF7fJDx4zGzlT39VhTL02Rk3VsILgean2rZNLo87r9PY3cHiI1yRGXT3bMcIpHPilFDhbA+RH+h6vorAAFG/3QdmxdnuCMzZhTcvLXtaNRXgyS24S+b42I0yU5XJmYP4xWQhJOvpw1tPDZ4Lv+fF3YBIbPN6SGQAydA9twBXTQwCaRlfucgWyxsoc4F4Y9aib9UfKkEWzl+Sb6h129rInXkTMjRe6XJkMDaVv4m2rSEPehfmC4nT18gK5n2IaDiD5zCN0f3As85/JDlu8FnFYxL4RqimOWytA5kqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53xqQI4gVNlEmyACiKZFx5Y9b7S5zYZhP15jAjbay5M=;
 b=kb+1ZhpxrAGXAmpnNo+q0eiz+fElNS+7CjtcPb6LujrRxsJmE0sv6O5Wi5+iznzBrdoa2FNEgU3uvg6Tgq1+kp/3LOOK5119sPBQjA1QLG8gwf7xCR6INQ/4ul11B3tRNtXIiAFigxnLnXcTQgasISztnIV7aZLVlcVx7/M/NI8TOA3hylUr274KkhusWKgZmMixouFl6tcSDXNvESsiwOjOv+3C0QqjtFDZUB3lySy/byd6Qw6Hv1UZrlFs+0xtj97B8JCm4DBMchTQMK55sZ12uErRrxKjRfeIlSI0CKpNugwyXgMbWO6g9OblBDi5II9gQSpzS+VgTFzY7YDyJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53xqQI4gVNlEmyACiKZFx5Y9b7S5zYZhP15jAjbay5M=;
 b=joyafhSKVfrdfi2G7cUIqA5Gj0wK8X+eYyIMFL3Ok0JL3nxhjdWiGue1skx/SNCveqpEpWTHssBkyBUI/EMuIxRtNcruYTvLCKd58myqrcOlcXFHqN1ZBvLW7v+0AEOMgDPM2CU9yUZJVcsQWU3OG8eXE98XRCk/RdP9fJb70C0=
Received: from MN2PR01CA0039.prod.exchangelabs.com (2603:10b6:208:23f::8) by
 BYAPR02MB4392.namprd02.prod.outlook.com (2603:10b6:a03:57::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14; Tue, 22 Sep 2020 16:40:27 +0000
Received: from BL2NAM02FT053.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:23f:cafe::e4) by MN2PR01CA0039.outlook.office365.com
 (2603:10b6:208:23f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend
 Transport; Tue, 22 Sep 2020 16:40:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT053.mail.protection.outlook.com (10.152.76.225) with Microsoft SMTP
 Server id 15.20.3391.15 via Frontend Transport; Tue, 22 Sep 2020 16:40:27
 +0000
Received: from [149.199.38.66] (port=57035 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1kKlKu-0003Z7-Cu; Tue, 22 Sep 2020 09:40:12 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1kKlL8-0005BJ-UA; Tue, 22 Sep 2020 09:40:26 -0700
Received: from [10.140.6.25] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1kKlL2-00050B-PD; Tue, 22 Sep 2020 09:40:21 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        git@xilinx.com,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [RESEND PATCH 0/3]spi: spi-zynqmp-gqspi: Update driver to use spi-mem framework
Date:   Tue, 22 Sep 2020 10:40:13 -0600
Message-Id: <20200922164016.30979-1-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8daea09c-7b2f-4c18-7780-08d85f1635ff
X-MS-TrafficTypeDiagnostic: BYAPR02MB4392:
X-Microsoft-Antispam-PRVS: <BYAPR02MB43920A34C2B397FB71035B7BBA3B0@BYAPR02MB4392.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pHKZ5Muoc6dsuZXW3yJy0tZmzzpRkymvSaZF+b/cSFubDNI5eJ1bh0L8JhIdUUciXdUSVQPSbrJ9xAtMF8ZDyfKCMRYq2DMPTjXJnLD4a4DD+PXe2IlAGtFRft6FKcULo0YCVMRGlgukb98WTreWkNjIvZc+0k+wIyEbeO65lOLCNyFFtHb2+++zgczUVbvAMOfqRz4b1Ag9chw+7KpKGzkNwF3Y0IsFvlIi2Jr91Z7Z6N4wCb+uLIzAGzK4Jmc9ZUPx/r4phi+Tdb6t25s9cVnY/t0XAjOzqWElviLssILHxBTlTFnp03jpTsR6lo3KBHX9Yo/S8oX5LrjYsU9SljRPEU9ydYkl6yTSYZFdK/Tcm3UHuOULYSLRRMpMf/K3XkE0tlxylCqJjhZ91ub1VA==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(136003)(396003)(376002)(39860400002)(346002)(46966005)(107886003)(2616005)(5660300002)(186003)(15650500001)(83380400001)(336012)(1076003)(4326008)(8936002)(26005)(7696005)(9786002)(36756003)(6916009)(82740400003)(2906002)(81166007)(426003)(70586007)(316002)(6666004)(82310400003)(8676002)(356005)(47076004)(478600001)(4744005)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2020 16:40:27.2729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8daea09c-7b2f-4c18-7780-08d85f1635ff
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT053.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4392
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch series:
 - Fixes kernel-doc warnings in ZynqMP qspi controller driver file.
 - Updates the ZynqMP qspi controller driver to use spi-mem framework.
 - Fixes incorrect indentation in ZynqMP qspi controller driver file.
---
Tested: flashcp and mtd_utils
Branch: for-5.10
---

Amit Kumar Mahapatra (3):
  spi: spi-zynqmp-gqspi: Fix kernel-doc warnings
  spi: spi-zynqmp-gqspi: Update driver to use spi-mem framework
  spi: spi-zynqmp-gqspi: Fix incorrect indentation

 drivers/spi/spi-zynqmp-gqspi.c | 720 +++++++++++++++++++--------------
 1 file changed, 407 insertions(+), 313 deletions(-)

--
2.17.1

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
