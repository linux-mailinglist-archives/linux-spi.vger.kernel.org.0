Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B7936221E
	for <lists+linux-spi@lfdr.de>; Fri, 16 Apr 2021 16:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244676AbhDPOWv (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 16 Apr 2021 10:22:51 -0400
Received: from mail-mw2nam12on2068.outbound.protection.outlook.com ([40.107.244.68]:56545
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229706AbhDPOWt (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 16 Apr 2021 10:22:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCMWyoiwqg10YWv1CzGA1Et2+76XXM7JohWrDNhHyo8R2wOka1XvDsrvIyt+giGGWBYKXsG+1YT44/J6kMeCAn2IUesmqFu0Omx2eJyRO3sbG1ySeVQssWmG1lF7rLFBQXEzWpTObjU6t+9R1G18/g16KmB71MVY7+Y8JyppiojBKhgGgZyVAG3VvRDE61DfdC+aPZMpjaauvwfcuflRe6azoRhFiMO6QTQqTpw7dhSGXf5zu6iCV992bwFVrm36Sj6WLv/jsW7xUuuZATW/EF47B/1PM7OXGzH/C/bCcBlGEZhOl8d6IwOBVbW8KrQG3KaLYc1GZJ1sBGdvB2RCkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zo9txHMoK5YhgrjEZmAchCVCugiRePlNVRloyfQWHPI=;
 b=e+iep/x8mEI0dKjDoHPB70xBqpOtM1B7pOZvCZqAHpfsM5TCssCkp/Q9Jwyz7BpcrLv1aJz42wi9Q4jiiB7/v93bv8AFmwJoyUJ4d4zWCyZMreBUr5GfgymWtqS8WNJXXQMTZV8JKt3tx0fvtWuml3bUdZnXTQAxjyaGrAKLLLGhYavirjiygEzEQ/icZ3/zB/11yiy5KInawGKN0AWw7xRhctWeHIQWdYKUfmIRtRx32yj6qB/IQlg3f4kDvnHfapKE5d14aUpug3nHHKkiuw2/9JfkQ04fHPi9s5zeYrWq0pCKSilTmwdDodruwuePEzc/epXPFR6jtyGn4B+J+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zo9txHMoK5YhgrjEZmAchCVCugiRePlNVRloyfQWHPI=;
 b=IZhSYKX3PRL3IEXSYsUPQd2Uo3jZ6n6ULEPQxVZHrSqX9ZfEQqU5dl0ZoI6F0wzO9TZfwSTaPtlhWXNg4vYtmdf21/16S7aaSYf1n3We3WRkXJvnXldy+EyZEOJqvKe7KHn3W/nc2j+aZohmC/DaUOFW9UdzFsu3LdO/wEHjFQ8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR1101MB2264.namprd11.prod.outlook.com (2603:10b6:910:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Fri, 16 Apr
 2021 14:22:23 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.3999.037; Fri, 16 Apr 2021
 14:22:23 +0000
From:   quanyang.wang@windriver.com
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [V2][PATCH 4/5] spi: spi-zynqmp-gqspi: fix use-after-free in zynqmp_qspi_exec_op
Date:   Fri, 16 Apr 2021 22:20:46 +0800
Message-Id: <20210416142047.6349-5-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210416142047.6349-1-quanyang.wang@windriver.com>
References: <20210416142047.6349-1-quanyang.wang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0147.apcprd02.prod.outlook.com
 (2603:1096:202:16::31) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by HK2PR02CA0147.apcprd02.prod.outlook.com (2603:1096:202:16::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 14:22:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b75fde8a-91aa-4546-f934-08d900e30d76
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2264:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1101MB22645A21C6B2404D0904B280F04C9@CY4PR1101MB2264.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2oYT1sa15t2KEomKpdkPlaDT+3js/A5ynYNk79+oYXT+uupE5UyeJUngw4rDf9uiQF3hVf0c+FudXo7yJHf1c2o0QmBz/TE/mu4040QoZj9rsIyZ9cUERnaiovxb9U/lIS1+3FCVdxPp/Iqj8h8ObPj+oFd2P8ita5SG3SnaFbB1VuaznxTIYOaqcVm3ijGG302LnDnYDO4WBHVu5RClgMtNACADrz1X4EB3wtnSnW3yfoXtnpO46zGHRYnNhK2r01h7OEQN2slNTqnbQBchQvotwSyfyYIUnHdyE6Dk2Y4uO06R9LcICsuO/DWemLlVr1ql5J4egbKaFzeeDhDuY+xfOSoRXU/1In467zIviTa4rl4OWhpoxUNor6F7xUndQLON5xxEjebqs9wppoVR6DVbZLqbL0u2nH3XgkT/oPrpCB2xlVN9VtcmdYe6Ys6/5A81aoCuZyynvtZau7QsVZxvuQUqXJPYh7cx8ZJk5jkiySvbq3dSComlr9yvzhAmVqYLL1PRuFdlFmWBe4Q6WAG2o4wfHZGHY3hg7Qo6ADelWztx9PVDu0kTi3bsnvfpysXZTiMLozZ6xT86WAMf/iaIlc8MN24bDEhCvdrnYC3HkN0/pmqahKJsMJdNVi4CXiBUKY7Rx1BY/abLTjPiew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(396003)(39850400004)(346002)(86362001)(186003)(2906002)(38350700002)(38100700002)(316002)(6506007)(9686003)(6486002)(83380400001)(66946007)(8676002)(66556008)(66476007)(478600001)(16526019)(5660300002)(4326008)(26005)(6512007)(1076003)(52116002)(110136005)(956004)(6666004)(8936002)(107886003)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0sOjiBr9NKM/9TCDQA7Q6oJt7uSlDoaLgre/PPY+vf+JQPgqyIolYqat+6xO?=
 =?us-ascii?Q?sLa1/0BHnfA86SkNxXdEX49nfr9q9EKUWMthKdRWZgAYJqpyKpz1UaQqx1BY?=
 =?us-ascii?Q?/qO1xsHd6I2xu+LLBqPw1CkQ8bemBCLqJjE/yvlx1MMnUaM126AK/nCdCQmm?=
 =?us-ascii?Q?fxk8wgyh3HBhWW823qGAsnMq5UUOZO8b9OE2ro5W9zIlQKaoWfB4rU8GVSHp?=
 =?us-ascii?Q?rMCw5JL/UIKWx03tC/u70KDSZ8NJaZZ3NXgnth4YV2KJju9a9JTKWKFQe4p7?=
 =?us-ascii?Q?vnpNWZ5gqq4v5nUnccKrv26o8g0maa3F4WDnkXATYz+RfimyqkYPECqzhExh?=
 =?us-ascii?Q?pJ7WaKBmtgAG4FtBguzrVgSUQqpaO9nvnd6lRXbsU2NcEuhwiuUcC0PfiG4u?=
 =?us-ascii?Q?nSgLSYtqZ0XYU/e0dzE53/3k0glR5aKPMnfkNolbsRNC0qlm0FwPmGAcLqI8?=
 =?us-ascii?Q?61/rfJIaw6dP3ATC1bG3v0n6lvPKYDyOxTAoLR3yt2jkvaCU8U24yx9UndK0?=
 =?us-ascii?Q?Pa0CTCBFV3xNInvYrKJX9imCfMa/6SW/3gSusv0comJDZrFcHTkrFcgaqarJ?=
 =?us-ascii?Q?8z+AnYyVNZMCR0gsqjWflw3zDP0k+9IVXjwjXdoZCRfoQbmbvk3eZk8oCXFf?=
 =?us-ascii?Q?SQPop/bHll3AyLFcaLGsaVMZig9WXC8MWctjrIevBb18aYdXXambnKAuC9n0?=
 =?us-ascii?Q?+hcnsK7h36O3LCkfZcjWVnNR3yOavLx4Z6wQbLh8/mvC14AADKlDthQpMpo7?=
 =?us-ascii?Q?10Uy06nR5WfjkSMX1VG8wtZ6oX74iIm/AEdReOYHIQVgc+gHcd/qNQ2cP5Rp?=
 =?us-ascii?Q?jcmOl+uJ0a3JLLboATe0hgQAW9tOag3Vihjoq4cNB8xG/KeC4ap1OpIhqSOg?=
 =?us-ascii?Q?7c3YUqj9NIw6wdKMFEEs6xpTiugnDLitXNVMtiemEUlXJavLux7AJNy3TOGT?=
 =?us-ascii?Q?hS9iLExugRTgNHi59qn3sblLIOh+ro5ZRKO84nKVF7SBYrOyUsyjgsRpMlBX?=
 =?us-ascii?Q?/rj316ZQTipwpXuqC2ca/te8AreA7ENxd2lyhDeHxkxpYAnAG0YpXJWxZjGl?=
 =?us-ascii?Q?OfeT/jf/u33T7nXyQbCFmxzhVuoQ6A+iz4YwI9KfEUudhOF0tBzIGpddlMTE?=
 =?us-ascii?Q?k2fNwNDWN4QyK0637EGPsY4bMd9K83U0UfVpILE5mXPDyxAvkl2vlzrQ8PTN?=
 =?us-ascii?Q?GRr2uL1JeJE7Zb7xZR/U39MGpcbLdm4AxIXkWE8QHGXBn9cqJgh54q0Pw1gd?=
 =?us-ascii?Q?Voz/EAAsQZvRAZnYJM/mJkoLCKxOgx9QhOOYdrjtGKtE3hP6HDaz3wpmyk/p?=
 =?us-ascii?Q?BBJo9Wghm99M12fn7oIypB4C?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75fde8a-91aa-4546-f934-08d900e30d76
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 14:22:23.5481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dmHlRdvHtWFuLHxnneOULwJyBROl9Zp30qGElwRYAZVsyXvrb84njWiC0kFQaR8StR1rxb/WIaPrZzcfIIVOA4QeDla5HePS8z0+c7HdMwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2264
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

When handling op->addr, it is using the buffer "tmpbuf" which has been
freed. This will trigger a use-after-free KASAN warning. Let's use
temporary variables to store op->addr.val and op->cmd.opcode to fix
this issue.

Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index 2e2607b5dee9..419bc1e6358b 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -928,8 +928,9 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 	struct zynqmp_qspi *xqspi = spi_controller_get_devdata
 				    (mem->spi->master);
 	int err = 0, i;
-	u8 *tmpbuf;
 	u32 genfifoentry = 0;
+	u16 opcode = op->cmd.opcode;
+	u64 opaddr;
 
 	dev_dbg(xqspi->dev, "cmd:%#x mode:%d.%d.%d.%d\n",
 		op->cmd.opcode, op->cmd.buswidth, op->addr.buswidth,
@@ -942,14 +943,8 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 	genfifoentry |= xqspi->genfifobus;
 
 	if (op->cmd.opcode) {
-		tmpbuf = kzalloc(op->cmd.nbytes, GFP_KERNEL | GFP_DMA);
-		if (!tmpbuf) {
-			mutex_unlock(&xqspi->op_lock);
-			return -ENOMEM;
-		}
-		tmpbuf[0] = op->cmd.opcode;
 		reinit_completion(&xqspi->data_completion);
-		xqspi->txbuf = tmpbuf;
+		xqspi->txbuf = &opcode;
 		xqspi->rxbuf = NULL;
 		xqspi->bytes_to_transfer = op->cmd.nbytes;
 		xqspi->bytes_to_receive = 0;
@@ -963,13 +958,12 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 		if (!wait_for_completion_timeout
 		    (&xqspi->data_completion, msecs_to_jiffies(1000))) {
 			err = -ETIMEDOUT;
-			kfree(tmpbuf);
 			goto return_err;
 		}
-		kfree(tmpbuf);
 	}
 
 	if (op->addr.nbytes) {
+		xqspi->txbuf = &opaddr;
 		for (i = 0; i < op->addr.nbytes; i++) {
 			*(((u8 *)xqspi->txbuf) + i) = op->addr.val >>
 					(8 * (op->addr.nbytes - i - 1));
-- 
2.25.1

