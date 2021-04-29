Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9DFF36E488
	for <lists+linux-spi@lfdr.de>; Thu, 29 Apr 2021 07:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238381AbhD2FjN (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Apr 2021 01:39:13 -0400
Received: from mail-dm6nam10on2061.outbound.protection.outlook.com ([40.107.93.61]:55584
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230103AbhD2FjL (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 29 Apr 2021 01:39:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fz7akkpGfFC5PFjIrNv76XCYx+hXHR0i6jwLwSUidwOQtJ4sHfR1fxNC+3ElVCzHjLeuZL3yIWWDuPzwxCLlWXpX+ahVJbfIG8248dxCSDZmd8h2N3An3QNE0w3rI5aqh144K+xq1EM02gN4ymHNZuW1O6ebOjxiifdIi2aQXZCbKcTmZi7ordM25oa8WS2VgXgEL/CkrnDO6HXXycGrDcGJ3AtBuLqpFvaAEnOl6qJK4gTCFDCtAmi6e4N8OZS6VkytXMrZ7A2b1Ve2h3Vsw4TH69t77S7tdOXOAC9CkVyKJ335qeuPZLv55m+VOaD0oFeEupd8Zh+gkqn5LElDcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7e/HVwdePZqUHXhGpTXJkAEt6SddIo4Owlrd4CPEOec=;
 b=QzegnVXWTYA/Y2F122VIMJb1+jXis5kc4IZka384PUuX2kfvzxLMOK2xhIMrlAnEtWo5YweABVae/AXrxSk0esRoMk8ZsfEdBfhx785tQBgBM3cJ+UJj3TQuEU75QBp7xqA/5MhhgsFK7yzP9QEsWjqUoji5OymfACLjgNr0wucClxK9Ra7zH6yOjjMLZX2QWZMXkrPpNORUP/W4kI5Z3j/G7m5BTVrFWcb5fGwqo855kKuakXN3g7NDOFAg3NKM/1SWvf74b2dZIFbrojkBjSP3aPxnz/i8WAXU3Qcuro++RJfmET06RsV0ZKHv5wRemLFIBiZR19DijdbQEAzxig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7e/HVwdePZqUHXhGpTXJkAEt6SddIo4Owlrd4CPEOec=;
 b=SdxHSO6O0l7I1FtpSoaVdqH3TVHXnEbi7Yi/DNYXKL5zQSiS/0RC+RxcJMbpKItB1DOYKvXMApJWYNOYGKH+ADl0LvETp96RfBm436peMJr0TJMRcdlw5vqTAJqkAPLXngr7Iv2oagvzs6qe8hcC0N9g+GkdrtIfPyP9xCUsXGM=
Received: from SN4PR0501CA0108.namprd05.prod.outlook.com
 (2603:10b6:803:42::25) by BN7PR02MB4098.namprd02.prod.outlook.com
 (2603:10b6:406:fd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Thu, 29 Apr
 2021 05:38:23 +0000
Received: from SN1NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:42:cafe::e0) by SN4PR0501CA0108.outlook.office365.com
 (2603:10b6:803:42::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend
 Transport; Thu, 29 Apr 2021 05:38:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT061.mail.protection.outlook.com (10.152.72.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Thu, 29 Apr 2021 05:38:23 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 28 Apr 2021 22:38:12 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 28 Apr 2021 22:38:12 -0700
Envelope-to: git@xilinx.com,
 broonie@kernel.org,
 linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 karen.dombroski@marsbioimaging.com
Received: from [10.140.6.25] (port=50950 helo=xhdnagasure40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <amit.kumar-mahapatra@xilinx.com>)
        id 1lbzNK-0000R3-NQ; Wed, 28 Apr 2021 22:38:11 -0700
From:   Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
To:     <broonie@kernel.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <git@xilinx.com>,
        Karen Dombroski <karen.dombroski@marsbioimaging.com>,
        "Amit Kumar Mahapatra" <amit.kumar-mahapatra@xilinx.com>
Subject: [RESEND 2/2] spi: spi-zynq-qspi: Fix stack violation bug
Date:   Wed, 28 Apr 2021 23:38:02 -0600
Message-ID: <20210429053802.17650-3-amit.kumar-mahapatra@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429053802.17650-1-amit.kumar-mahapatra@xilinx.com>
References: <20210429053802.17650-1-amit.kumar-mahapatra@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a76e55c6-6598-43e6-d111-08d90ad1010b
X-MS-TrafficTypeDiagnostic: BN7PR02MB4098:
X-Microsoft-Antispam-PRVS: <BN7PR02MB4098708F1E6F25FDA13531E5BA5F9@BN7PR02MB4098.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nBPEzR1KiTFxn0xDlwH8xgyBpk/HfKdYj4eN4frDTVBNZlqKjZRtijB6CzQn44uM3tctDVGK78AzYvt0XXc04DXqxX6CKlNtdaCStDr6m+AesCwn0DaGEuQ2n7nmMFJwnm4sT/MvcOS0qPGANtmjhOteL6YnLiEFP5Pm1xwCR8+j2aTojE+ogLqcRqsACToXxBVxGblospwov9XXdX1G+bE58BussJObTDeC9qpKLdWHMnUFQbcj5NuUPkRJvFktzz9Z+BKjFzX0SwOmzV2TkwA9Y9z2AdmyoQszKGT4YWo9wesSQZ8mduTeOcTPfqM+Pxq1UOzL+pYM3f99i1cne8ufypDr8HGz5AqCVl5xaqrLAm5cHudK7S7SwsgrQNMM0iS3TeapTj8TkgDzfQ2kmI2yad8/entGfT+xNCY+1kgYo+srUxzRtaPZIEYUHlfhgoyKarzRGUn7fh1WAd86yCtAcDYCsmatr8AiXFEzcQZyTtlVY5uUlm4w5t7GG38+owwPqacOIJrvhfzFwss7JebdwJtGZsPBnlwgIBgyGDLg9qgNexUgcomrGnXxK/5gLpEZ2h+Lk28rlJ51NOogqLCqxQGymxP36TO/tfu0Q5McvvzMSYt7PhbGgydcnlrbsgBALwbkcurcTAULjrFZjtnBcuLMpZuI+h79pW9e1N3Pof5nfBq7hYHVu866a7yL
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(346002)(39850400004)(46966006)(36840700001)(9786002)(5660300002)(83380400001)(426003)(1076003)(356005)(2616005)(70586007)(70206006)(2906002)(82740400003)(8676002)(478600001)(82310400003)(7696005)(107886003)(6666004)(36860700001)(6916009)(36756003)(4326008)(8936002)(336012)(316002)(186003)(36906005)(54906003)(47076005)(7636003)(26005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 05:38:23.0820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a76e55c6-6598-43e6-d111-08d90ad1010b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT061.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB4098
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Karen Dombroski <karen.dombroski@marsbioimaging.com>

When the number of bytes for the op is greater than one, the read could
run off the end of the function stack and cause a crash.

This patch restores the behaviour of safely reading out of the original
opcode location.

Signed-off-by: Karen Dombroski <karen.dombroski@marsbioimaging.com>
Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/spi/spi-zynq-qspi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 1acde9e24973..5a3d81c31d04 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -528,18 +528,17 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
 	struct zynq_qspi *xqspi = spi_controller_get_devdata(mem->spi->master);
 	int err = 0, i;
 	u8 *tmpbuf;
-	u8 opcode = op->cmd.opcode;
 
 	dev_dbg(xqspi->dev, "cmd:%#x mode:%d.%d.%d.%d\n",
-		opcode, op->cmd.buswidth, op->addr.buswidth,
+		op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
 		op->dummy.buswidth, op->data.buswidth);
 
 	zynq_qspi_chipselect(mem->spi, true);
 	zynq_qspi_config_op(xqspi, mem->spi);
 
-	if (op->cmd.nbytes) {
+	if (op->cmd.opcode) {
 		reinit_completion(&xqspi->data_completion);
-		xqspi->txbuf = &opcode;
+		xqspi->txbuf = (u8 *)&op->cmd.opcode;
 		xqspi->rxbuf = NULL;
 		xqspi->tx_bytes = op->cmd.nbytes;
 		xqspi->rx_bytes = op->cmd.nbytes;
-- 
2.17.1

