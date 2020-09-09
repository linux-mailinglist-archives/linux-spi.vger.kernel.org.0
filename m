Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF0926343A
	for <lists+linux-spi@lfdr.de>; Wed,  9 Sep 2020 19:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbgIIRQH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Sep 2020 13:16:07 -0400
Received: from mail-dm6nam12on2055.outbound.protection.outlook.com ([40.107.243.55]:6240
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730104AbgIIP2W (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 9 Sep 2020 11:28:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZtyXAIt6OyybJkr9nfs4+eCO6Byk3WkxuebvMvjmi2LVzv4baRQSNs7GRG0u54r5T6EFe+ot7rmzbGUV33XkTpoi00MHqn2M7tJz1Znfn3zDUI9cBQQwz6yVOzbegd+ZfjhRX6z5p/LDuOb3SpYfx2ooYcr0W3w+1oKvluA4BNiqQ2cBRtiFfM1vTBm2QnhxkZNAYyIEBDtsP9KqsOx7besePh0Z3qSKfWdRUADptkIE81TH5PA9A9wdv8GjEN2L5TYT8gY+iiaO98F9wFvIOSJyOws9w2b1XoMdedYjdbSkvDjOQx+aoMCIpiFmMo6nlYlb072UbUWSmDKHh0YdvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LIqqRRZFHpqrPav0tzguRT+BK+vaosDlAzX5ow/r+o=;
 b=MTuK4+97/z8/FAkrErJOJNnzI5F/wgNQLSVfoGJuSnjoKgKBKzQhSPKGLjZ5PTlv/HIeC+9p5HBGT0n/wltOFHSkZfaaY+NHhwX+XkbA/ODiS0pLGtW/cQIiIrmMntn9BvN/4oA8trRs+wLjsBAUENs1CewNLm2M67VB5vqpqBrPAwQpkNeLpGpQqwd64eP3pIVvEbPVvwELxqeXd/8Ldex4x/iEtapvhCik+3KmT9PmwaklRBRHyCGIRSpd3io7r2SHV8p5gjgHk0GpJE3vXm1OezlBoSfHtTKxBL7bfL0b1JX/TycvlCa3bjt0ibm+RenlWx1MZ4D1+yv4MFg7hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LIqqRRZFHpqrPav0tzguRT+BK+vaosDlAzX5ow/r+o=;
 b=Er4vt2RnPnKUahUHfLtTh30XkRad6E2ojhq5MxOEznOYr2jeJCNuY3j8Q8JYhU5s9JAopkobluboUqmIcVpTHYwNdVwdzfZg1uYTMVZbLMSHjnXE87B4GfhpB4dqTQT3ki1nPwNIMYzDX1PTR9/ySm/5DchbphY2E1m/fAnNKzQ=
Received: from MN2PR19CA0058.namprd19.prod.outlook.com (2603:10b6:208:19b::35)
 by BL0PR02MB6516.namprd02.prod.outlook.com (2603:10b6:208:1ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 15:27:17 +0000
Received: from BL2NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:19b:cafe::fc) by MN2PR19CA0058.outlook.office365.com
 (2603:10b6:208:19b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Wed, 9 Sep 2020 15:27:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT046.mail.protection.outlook.com (10.152.76.118) with Microsoft SMTP
 Server id 15.20.3348.17 via Frontend Transport; Wed, 9 Sep 2020 15:27:16
 +0000
Received: from [149.199.38.66] (port=45015 helo=smtp.xilinx.com)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1kG1zv-00055w-KW; Wed, 09 Sep 2020 08:26:59 -0700
Received: from [127.0.0.1] (helo=localhost)
        by smtp.xilinx.com with smtp (Exim 4.63)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1kG20B-00068i-Fh; Wed, 09 Sep 2020 08:27:15 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 089FRDVE024327;
        Wed, 9 Sep 2020 08:27:13 -0700
Received: from [10.140.6.25] (helo=xhdnagasure40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1kG208-00068K-Ll; Wed, 09 Sep 2020 08:27:13 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, sgoud@xilinx.com, nagasure@xilinx.com,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH 0/3]spi: spi-zynqmp-gqspi: Update driver to use spi-mem framework
Date:   Wed,  9 Sep 2020 09:27:05 -0600
Message-Id: <20200909152708.2767-1-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5fe18689-7f25-4e37-8921-08d854d4d5c1
X-MS-TrafficTypeDiagnostic: BL0PR02MB6516:
X-Microsoft-Antispam-PRVS: <BL0PR02MB6516A644B9AD6F44A10CD5B8BA260@BL0PR02MB6516.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UzL4jyiSb5TPjIEx52DBVuO2zxFtoLuDwAxCq8HFfTI4T2yuguxJapYAFczc9G9lxJsfORFpT5WruZ1kRkeGBCWhmpa5gk2PTxMNbZoCFURHZa5mdzm2yOtYD2DylfCBWDQ/LDs9UML4UDzBCYr8wYeXpv+HZTHxq4Nt92lsk6SUvfZOKnh3hkux+MJRZZUAfIo82QoCF2u+YGy+UV6hG5AijM9LjEK0O3qrzh8C49C+PvwHlBgnFJUE10iQ+dG+dnA3vtJq8Eq6p40K0+ZxG5/vcW0+KR25sfW7IIWYwPlzPIFauPVUuQcwrLgRayJYnzSXeApr7vST7y+H4fppTiJk5YwBS3/XNSgWG7hBe7jdKM8H+OXr2lkSfZJU3/nBfotwCrbCOiBfCCD/WTBvnw==
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFS:(396003)(39860400002)(376002)(346002)(136003)(46966005)(426003)(70206006)(70586007)(47076004)(9786002)(82740400003)(316002)(8936002)(6666004)(107886003)(5660300002)(2616005)(2906002)(36756003)(6916009)(26005)(1076003)(15650500001)(8676002)(186003)(336012)(82310400003)(4744005)(4326008)(356005)(81166007)(478600001)(83380400001)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 15:27:16.8735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe18689-7f25-4e37-8921-08d854d4d5c1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT046.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6516
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch series:
 - Fixes kernel-doc warnings in ZynqMP qspi controller driver file.
 - Updates the ZynqMP qspi controller driver to use spi-mem framework.
 - Fixes incorrect indentation in ZynqMP qspi controller driver file.
---
Tested: flashcp and mtd_utils
Branch: for-next
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
