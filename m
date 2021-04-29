Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3AA436E487
	for <lists+linux-spi@lfdr.de>; Thu, 29 Apr 2021 07:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238345AbhD2FjM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Apr 2021 01:39:12 -0400
Received: from mail-mw2nam10on2048.outbound.protection.outlook.com ([40.107.94.48]:29889
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229792AbhD2FjJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 29 Apr 2021 01:39:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hkQ68B3u3olv4J9cYxRUXx4/mb5DnYkNJ4zd+vIWbJ5VpkdqPgGWzqzCB+jD14kAjKfAs8WQ/oIz9JkFZFrMMP33DP2FMtMb6K4olFNnZUnkz4VjJxAJo7mGalDBl4mzEaslAnUKzTFY6OW/UYsuq8qatKzUwEHbDzajEAmdUPEXCOjktgf68yxwoZkiJnAdxj6LljVcUFTRs73NMxzF5aTFVEZfwGgJcTifvo3K8s6XsgYFmSVHu6QVkoSo5rKKj4Vyla/5ws+7bfiBbPXZu2K1drnJiVKueASr6guB9D1k+piH9HW8eKZmFqximaRBw2b4f41CISAvZZebMiLaIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHTEL2i0OGkFRmEhw6NvJ7GhVBn0N5h4tG73vjYnJ3w=;
 b=cIM7ONFe/Fr5HooaSRdY+gWI/NNb+Gtl+TnZlPx8ZMThz9B/Tmw9Em8BbJVOHuF9sOOdX9LnRWiJkXyt9xU8b33I4yDmIaDTNsh9bfdy4qvq2ue41cudxJvP5fwdAoMxxwEk/LyEPli3mUgpZm6VGINmD66b/+MG6cRntwJI1L8pinbXaTXUxFjA7+7EqH58KUDnKPT8SE4099ktYtcHxdwmcJolG4EG6sMa9b0ZZtt5sAA5scZPfSjX/uHM4aZ8hv5g6yMhHWwqRPIgJ37YgWrLzYptLYhMsfpVf2QQvuHpY9Jwd2jbwlYWcBgJLZ7j4oz6VcksrtvSbOxwCGz6Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHTEL2i0OGkFRmEhw6NvJ7GhVBn0N5h4tG73vjYnJ3w=;
 b=dp5X80BSaYKCUvRZCvUGw3zZqv5IuxkuDATXiU/vIL/I0G8yXHH8zGedM+xww6uTb80cmnRnmUYEFy9HqoApjQHa34uGwn+GgCoY4ai7p0v8qL+I28rilsL4bK2ktrUtmLgo96Ax61UmKSotLjzhLYKT8lEO0GqO0q4Ik8caA1k=
Received: from SN4PR0501CA0100.namprd05.prod.outlook.com
 (2603:10b6:803:42::17) by BN6PR02MB2275.namprd02.prod.outlook.com
 (2603:10b6:404:32::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 29 Apr
 2021 05:38:20 +0000
Received: from SN1NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:42:cafe::f8) by SN4PR0501CA0100.outlook.office365.com
 (2603:10b6:803:42::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend
 Transport; Thu, 29 Apr 2021 05:38:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT061.mail.protection.outlook.com (10.152.72.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Thu, 29 Apr 2021 05:38:20 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Apr 2021 22:38:08 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 28 Apr 2021 22:38:07 -0700
Envelope-to: git@xilinx.com,
 broonie@kernel.org,
 linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.25] (port=50950 helo=xhdnagasure40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1lbzNG-0000R3-LF; Wed, 28 Apr 2021 22:38:07 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [RESEND 0/2]spi: spi-zynq-qspi: Fix stack violation bug
Date:   Wed, 28 Apr 2021 23:38:00 -0600
Message-ID: <20210429053802.17650-1-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c94db0b3-0d99-4dc0-9505-08d90ad0ff88
X-MS-TrafficTypeDiagnostic: BN6PR02MB2275:
X-Microsoft-Antispam-PRVS: <BN6PR02MB2275A5CDF31A0F91E7772E07BA5F9@BN6PR02MB2275.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S1ufjAS0YsDJiTV/0oEbXeXKWABUp4lGn7UhUtqEQmL1kW9u2y7lWkvTfO5Viilkd/l8wbx2HcvJfNj8Ov5zAcNi2kS81nmF8DyaRqdSJxqPv05oCi2KIV2kiR2JRAvMNQaKL4r0JWsXhUOvAlKlfIGC38xbNqKmmpF5pnFh2ISNOHNiGRzQ+g2KggIkOwz8Aydr71iMfO7wFGlTLjq2e3PaQjieB/2VQBv+unsMlE8IWkXFxmXHFH8/U5BO9OdHiIeGT6ckXjIv5AQOyt8kYq/ivKU1rLrKoxOxRquxAEcfVO5ue+i33pHh1SXpNq9m+ieqPkkcFXLlw+W33SsEAoudeOvA8CBy55CUvKZkP/8F5FsxlL2VBfaY7mEVJDnw5BlBzmrLGrUIPD1q+YAhcekT8wjf67JWbOaIeXI+DayrIsvRBB0I4BAn27+1Ks10Ki4jSXOZBySRv+T5V3Xo7GsARBKiyBOpCfHSe6juiRTQTvJ4myNBFwnAp6EMOoOoow4Xsp+xsj1foTlKUhs/8tImqSkfzgBvYi+gUUmolWEhMIL0lw5ngyMAyp6Sgq4+ZbuuVxgPnfoflk1OZDfFj+W6NHMCRTkneJ1QXB04aB19OWQCANxfkuhVRlmZ7ThmMMfpFq0oGUfiZTsA0gGx1FZliZNGNvRwW0t/5Cn3YsUD00OFAJC1RxWcKgzgir3w
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(36840700001)(46966006)(8676002)(316002)(26005)(36906005)(6916009)(4744005)(2616005)(1076003)(356005)(478600001)(5660300002)(54906003)(8936002)(9786002)(70206006)(7636003)(70586007)(83380400001)(82740400003)(82310400003)(107886003)(426003)(186003)(4326008)(7696005)(6666004)(36860700001)(2906002)(336012)(36756003)(47076005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 05:38:20.5422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c94db0b3-0d99-4dc0-9505-08d90ad0ff88
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT061.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2275
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch series fixes kernel-doc warnings and stack violation
issues in Zynq qspi driver.
---
Branch: for-next
---
Amit Kumar Mahapatra (1):
  spi: spi-zynq-qspi: Fix kernel-doc warning

Karen Dombroski (1):
  spi: spi-zynq-qspi: Fix stack violation bug

 drivers/spi/spi-zynq-qspi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

-- 
2.17.1

