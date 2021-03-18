Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9DA340318
	for <lists+linux-spi@lfdr.de>; Thu, 18 Mar 2021 11:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbhCRKZj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 18 Mar 2021 06:25:39 -0400
Received: from mail-dm6nam11on2069.outbound.protection.outlook.com ([40.107.223.69]:30304
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230045AbhCRKZV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 18 Mar 2021 06:25:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeNmvvczKllSkJDmM9g26VWIx5yxtFWxG5q4+A7WZ3X34XSIHx2xuqBc9fEIAfQsOHBf7QqEB2sDkT9oz9Xa4Qz4ObDMaZAlbWRtdjD9y6DAsrIhuAFXiKCh8eSusmPXRLTwUoNzHhB9p5b2TqwTJgmoKhNkCEtwu7UtSkAznisdqp38OjLuK6vRHSQ2mc3DC1HOkz76LJbwSn0CFpGSqu66GUmnUJcglRhREaSBbTbY+nVNysz2OOqhi2wSHb8QGdIj2zk8/85z0UA3INuKhhs9C66CDexnPVQWzAcAmwmvs6KNT/wIFIu5Q2UUiLFZ3JfBijYqAEJ2FH8RiKP3Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiD8q6CSnN5HT+0GD1dl8xi9g9Gvbk/bslwo701uZCo=;
 b=OaZ8/jpKxh2E695aVMDLWd7UtAoZYvezjDyKLjtlw+ejrdm9yDNxrIA4zE/4b+1rTn/Hv/qSeJmQ+fnidgFpTeH7ybS7RjSXunY1ZXJpsZWoap8iXOdFsQMe/xiN2EA0+GX9BwouMVl2qCfVj2TqGLguWT7K4n6JIgdjqJT/ibmpffzMM+6VJKa4cJZfNeipTCXJxEXPvDkspo+jubD7j6wvYNE3Rpgj2ylyWqk9kVq8vtSgUgVncNpo92su6dbr8UoAN6mLoZj6Srnw6UU30S01d4W8uA3nvLIxRGrFdKLezaShWlnbpS0g8jo3ZRorYsOEfsUn3LdV1hTEDwnV9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiD8q6CSnN5HT+0GD1dl8xi9g9Gvbk/bslwo701uZCo=;
 b=PcPrmG4YJwVnt1wmV0r7EwXOUOf9u/heAmd1K2EsnuabQJkZ1SpQUgnTW7jUGnWQuZlJ2XmOBgurGMBwHgoa7Jk/L9TcjLylQPN0pQMV6Ffbgxs+tvn2DxLGvXzNqRYOQ6ATy+tfZXaltayrKfmNQoV2L6bjMCPSPsPCi3+q6bM=
Received: from DM6PR03CA0002.namprd03.prod.outlook.com (2603:10b6:5:40::15) by
 CY4PR02MB2741.namprd02.prod.outlook.com (2603:10b6:903:128::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 10:25:11 +0000
Received: from DM3NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::1) by DM6PR03CA0002.outlook.office365.com
 (2603:10b6:5:40::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Thu, 18 Mar 2021 10:25:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT019.mail.protection.outlook.com (10.13.4.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3933.32 via Frontend Transport; Thu, 18 Mar 2021 10:25:11 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 18 Mar 2021 03:24:53 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Thu, 18 Mar 2021 03:24:53 -0700
Envelope-to: git@xilinx.com,
 broonie@kernel.org,
 linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.25] (port=50704 helo=xhdnagasure40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1lMppj-0007CY-Rw; Thu, 18 Mar 2021 03:24:52 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [PATCH 1/2] spi: spi-zynq-qspi: Fix kernel-doc warning
Date:   Thu, 18 Mar 2021 04:24:45 -0600
Message-ID: <20210318102446.25142-2-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210318102446.25142-1-amit.kumar-mahapatra@xilinx.com>
References: <20210318102446.25142-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 667ab097-7cd2-408a-3734-08d8e9f81cd0
X-MS-TrafficTypeDiagnostic: CY4PR02MB2741:
X-Microsoft-Antispam-PRVS: <CY4PR02MB2741B20EBE1EFB2D65C18DEABA699@CY4PR02MB2741.namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kr7Ipdneg7AQ7Yesx4O5PYOnH6kLg/iEVngT9Z7hqeMVivx/1Xr4XWe3uMFAtu/GEq6Dda1uw5WgHUJaEcz5UHi2sTjHDk1K25EoocuLQFC4/XR/9l3OUXFjoVWaxvBgAisdq9iRzOH9upMlB5KnSzIrgJYaK60dwOoW6ijjmvZv0rA6HZYSbZ0Rq8xM41LBAvG3V2JVQqUiGpLESt4aqHbx/+9212oDMTrkKMnnaOVVNzN6IIKSgycQeHsuPkWtXI9UFhBOFqD1mspvjwhO0/rT7F/2b4xQCaTZRKMBWhAX0l5LZdFd4wc9t+brKTL6JaCQ+mTX0w/W2Q/63uB6ypskUTGe9cd9bZDr1kIlOtqDLcuNn9W51A1xRrJKEl3DyJCd6W7YVUMdXzf4BYeluGuPcxvbQ5OtCg2KpeEjkjWSgi8eeRHE95x7VW0IDP3UGsvVosML8hjMiUy38sq7KUxNbn/qzjdPDxiK+XDwfYghbg9RKNgNhL1ZJEjWSLOnNKvhM1HN1un7buHdCvvjKPc5MoLWYyk0DMApyc+SJsur8x3a11vEEkzslU7jnRJf+mBpJ0hPFPZek3uTBxduUoFGgSIVJ9m7drrBSeKnK526gg1e+cSlFpCrzzuqGv4Lk1ZYIQdJShaqLTvoEJxbDf29P7MhHrbNCfx/05JE8icnXRuLl0D1OpXltCOKJAIR
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(46966006)(36840700001)(36860700001)(426003)(47076005)(316002)(107886003)(2906002)(5660300002)(36756003)(7696005)(1076003)(9786002)(6916009)(70206006)(478600001)(70586007)(82740400003)(8936002)(2616005)(36906005)(356005)(26005)(336012)(8676002)(186003)(82310400003)(7636003)(6666004)(4326008)(83380400001)(54906003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 10:25:11.6594
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 667ab097-7cd2-408a-3734-08d8e9f81cd0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT019.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2741
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Fix kernel-doc warning.

Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/spi/spi-zynq-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 5d8a5ee62fa2..1acde9e24973 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -367,7 +367,7 @@ static int zynq_qspi_config_op(struct zynq_qspi *xqspi,=
 struct spi_device *spi)
 }

 /**
- * zynq_qspi_setup - Configure the QSPI controller
+ * zynq_qspi_setup_op - Configure the QSPI controller
  * @spi:       Pointer to the spi_device structure
  *
  * Sets the operational mode of QSPI controller for the next QSPI transfer=
, baud
--
2.17.1

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
