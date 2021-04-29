Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7BD236E486
	for <lists+linux-spi@lfdr.de>; Thu, 29 Apr 2021 07:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbhD2FjL (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Apr 2021 01:39:11 -0400
Received: from mail-dm6nam10on2087.outbound.protection.outlook.com ([40.107.93.87]:33537
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229814AbhD2FjJ (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 29 Apr 2021 01:39:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSSqtdSGytUgQwEVYkeMxIsNKL5Yg7C+WT1uwXQwDS7i89niuzEQ+nKR5QJXAkZ7HUbPPsALakihlnrk9bW+FAMTeqmVR74F68hm+qEI8pAlEiDywwzLQ2dhT4YKcTLuWZsS68UhEzuEEafh2wtxueM2+sxqnlx3xg2ae/BqqGvje3fAQjZ/zbotsSgJUuub0W666w97M+1fvoQmnQcSCW4LMebPhlWGYP6DnGj/eGe0NgnWWnuSI0jVcY+91/3BJDxNGggB3D13oMcWnAS4rs61RB3C7gMahHepPMqz8VxkYlwweaLSqmEXYZxtRDgNgyL3QINTD6TvWgI42zp4CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MIM6D1SCI/4FlJygVdpmHaYdzWwNqAkOiswEPfEX94=;
 b=enLv3VJ+LyvUg8KpDH2GK9zLi1s6aVmJ9973OavsQB6rBEiEZx0q3wuUTDTZKxL26W9gnZ5ZGicckm08nu1bt44RllzSE2lAKszE5bq4hmES69YYq7g1bQaIsYattu1hzx4RSGF9pomGSrEWxoKMK3F8PuIEScPGbjUHVnjZQI9JtHDJ6fYZofBCc1oIlCT/IigyO+VarHajtOsI8PbKrZL2SYxaKJozC6tOLCyWcLOAyWJHnRvNbboV6DWpieL1AaqWDtC9SZqxixWbMp3UkCvFgZl70AhjB6MYUowbdxHRMP/uwfs5vXZL9QoPgYu/WWWOTZJsuTIfOX7YShl/Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MIM6D1SCI/4FlJygVdpmHaYdzWwNqAkOiswEPfEX94=;
 b=D5c3J2oZhTrI0TIuZc4lN8/tSf8UNZCmaGIzCanZYMXR0uRUG+4VUZNaXmD8fcxKwEJVo4SFRGFnuE21jUbEBK9JiWC5v7QGbcE0RuhBiNXzGLjQWfkOu5oZXVAgMs0YO+qz1UUCPZuC+7GYsAkzoEAlluQUm1r55l+cWLeoVd0=
Received: from SN4PR0501CA0128.namprd05.prod.outlook.com
 (2603:10b6:803:42::45) by BL0PR02MB5394.namprd02.prod.outlook.com
 (2603:10b6:208:37::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Thu, 29 Apr
 2021 05:38:22 +0000
Received: from SN1NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:42:cafe::3e) by SN4PR0501CA0128.outlook.office365.com
 (2603:10b6:803:42::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend
 Transport; Thu, 29 Apr 2021 05:38:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT061.mail.protection.outlook.com (10.152.72.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Thu, 29 Apr 2021 05:38:21 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Apr 2021 22:38:09 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 28 Apr 2021 22:38:09 -0700
Envelope-to: git@xilinx.com,
 broonie@kernel.org,
 linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.25] (port=50950 helo=xhdnagasure40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1lbzNI-0000R3-Is; Wed, 28 Apr 2021 22:38:09 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Subject: [RESEND 1/2] spi: spi-zynq-qspi: Fix kernel-doc warning
Date:   Wed, 28 Apr 2021 23:38:01 -0600
Message-ID: <20210429053802.17650-2-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429053802.17650-1-amit.kumar-mahapatra@xilinx.com>
References: <20210429053802.17650-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e521ae7-08b8-46df-57de-08d90ad1004b
X-MS-TrafficTypeDiagnostic: BL0PR02MB5394:
X-Microsoft-Antispam-PRVS: <BL0PR02MB5394234D59BE400379351BFEBA5F9@BL0PR02MB5394.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RS2w9mi8EefGpxi+EJfgaEOkjQnW4HVED0tIIzWPm4tZ8BJrQ39BI52JjyMLFt4cj5ygOE3KqZFnllpXJbmvGnXPlb+FGdToCmLfe8lfIgsqwEBGFytQf3NUqEWlpnqhjjIl5E6uBHNCqlemrGjaTNsxhkCLeXRcm++Cj0WIbszYOv8n9zChoEekfSrXZ5CawWZC0pZr2YScDTg+c0KoogmqJz+zu0yKuOVjAImLAew3BMP0NQy1yW7flFcQzAz9ivV1TIIrJTkaXIJAj022RqYJmOU9t5w+RWh3wA83kUN5XWvgDkeyLSNLeuK/7/J/t67fKOPM7kaqMmnnH91rgb+X9xMHCLCwTbFPL47rMF/k8p3btDrEiciQmzlsd+uXAkxtQ5RKjR05uUgJx+4162XD/mLjRBkSefDIoTJRzTo6XLYqhejwGsBLM6UZUJuww/JbEZUAGThVL3MjDs8nh/jaFxiP8ttE/8b5iswsPOqA4DD3xwgQFC4G/+4Cqob81pOP7t3I22bc1N89pYjyi8OVH5n/Vdyu66XRvzabzDuR9x5ZsqqUarXwo4+l1Laz/x4snzuuz+MBbqCByfSVgkHp+IgL10DObxeIwoVzUcINsJtSPkXCY+21Hv2LEICsA6S2r860zIDbho2g9HNx0ihdisPFBOcjvc14bsy1uhFsBMPh3gH5X6OovzbjoGI2
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(36840700001)(46966006)(5660300002)(82740400003)(36906005)(70586007)(70206006)(356005)(54906003)(316002)(2906002)(4744005)(36756003)(107886003)(6916009)(8676002)(7696005)(4326008)(82310400003)(9786002)(6666004)(8936002)(336012)(426003)(1076003)(7636003)(2616005)(26005)(36860700001)(186003)(47076005)(478600001)(83380400001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 05:38:21.8216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e521ae7-08b8-46df-57de-08d90ad1004b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT061.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5394
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
@@ -367,7 +367,7 @@ static int zynq_qspi_config_op(struct zynq_qspi *xqspi, struct spi_device *spi)
 }
 
 /**
- * zynq_qspi_setup - Configure the QSPI controller
+ * zynq_qspi_setup_op - Configure the QSPI controller
  * @spi:	Pointer to the spi_device structure
  *
  * Sets the operational mode of QSPI controller for the next QSPI transfer, baud
-- 
2.17.1

