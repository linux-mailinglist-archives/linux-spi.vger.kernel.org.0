Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF72357B01
	for <lists+linux-spi@lfdr.de>; Thu,  8 Apr 2021 06:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhDHEEB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 8 Apr 2021 00:04:01 -0400
Received: from mail-dm6nam11on2088.outbound.protection.outlook.com ([40.107.223.88]:17249
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229469AbhDHEEB (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 8 Apr 2021 00:04:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqCuckVC0QusA9CgPkiZfLCEz4q2mBksKCNyOceqa/PscAUAvOvEdXOSIUb6rhDjHiBdkqCzyclm9dTAYPjTaAXlm/yrn9Pd+NEr2YXFXw7ckDBv0pwzr+ID+TaQNoe6LPCmqeAWeb5ZInr0drXFJvlWD441vEak0eIENrkSbE+/FTaMhz8ksKujlU/ZuuvlFvbp+ObEk+LCfqz09/8LyXOZ7UzqXq+HUhaJIX+9ltgKdwNyMwZ8to4zbQ2F2EFoTqWs3BJW8fiBFLuM1bgByOdNYXwfF5vaIfcjGQfBrPQHcK1CSDNBYmDK6AP2UQaxg6AAusU7FKMCQX4zp1S8rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwKVEu19h84PYMaGoeAJmqZk5WCUUb0gxrs6pZZAL5o=;
 b=AZAlDUE7xMBT7cS3pAYXlcQNLRTKgCZaiI7IefhHaf6xEJ4h1z0pDfNijhvG1x8TZEPNOPWz1tNDr6i7Bg9A2ZfR5kzmhtTVA+huQx1hCs1QpecD6v+nVcuehrPkxKXkq0Z/syrL8JZht9XLzhh6PHJQvuaD9soqqUquCEKv5Lgfb9DaDmfrP7roD19gwj1LGFBwu+atEP7Psz2K34GrtO6xVCKhVx88rc7CLIaaj+TL2hzKPu80Kubg6VpBUOo3V+rlAX0jtx0JOG7jffzuXTJP/P/iJ6ETWWJJRHQXggFK28Hct0eP+7BAEWk4rQDY9fMo1oLq4kqPt1zDxLidWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwKVEu19h84PYMaGoeAJmqZk5WCUUb0gxrs6pZZAL5o=;
 b=PjdpO9jsHlOeACsESWIbOYq+NaIdBTryz9LM0Fjumcr5Qc2JrqhxBUujbSQTs+qxSW+7X1L3dcF8zomNMDs4Hbs9sgWG8IeP5fG4NZWbHtxx2DHFHJdJegwJticlwn9siqo9w0pQwbh23RxhfuIPSvz5nv3F8tufmI7Ji5mWT2A=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1351.namprd11.prod.outlook.com (2603:10b6:903:26::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Thu, 8 Apr
 2021 04:03:48 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.3999.032; Thu, 8 Apr 2021
 04:03:48 +0000
From:   quanyang.wang@windriver.com
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [PATCH 1/4] spi: spi-zynqmp-gqspi: use wait_for_completion_timeout to make zynqmp_qspi_exec_op not interruptible
Date:   Thu,  8 Apr 2021 12:02:20 +0800
Message-Id: <20210408040223.23134-2-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408040223.23134-1-quanyang.wang@windriver.com>
References: <20210408040223.23134-1-quanyang.wang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0138.apcprd02.prod.outlook.com
 (2603:1096:202:16::22) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by HK2PR02CA0138.apcprd02.prod.outlook.com (2603:1096:202:16::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 04:03:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39b9972e-0527-4429-62c2-08d8fa434fa8
X-MS-TrafficTypeDiagnostic: CY4PR11MB1351:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR11MB135173BE460E94ED6B62440DF0749@CY4PR11MB1351.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4tpTNY0ShAxUEAG78pWOTSxEZ8EHMReJnbHu3Dj784MHBAgGrSqKsLCJbjWfmJbcfzU3yP6V01DEdYnmKA/dsnwY4fsD7nl37M8SF0h7IqsHReSN1rK4PWbLXHJxjBhDZtWWXgZikNIaKSqMwSZRg8nmJVIrg/eCZPMpRo0fq1ARAp+AuAJGnQetI2V65Os4ta9QQkoV6C2APO03GA8Yow1r6uYcxkxsRb2GNfDav2gutdCYiY2LgS2n213aBUdNHuhMaX+ci1RY13OxXcHDrO5hPx3AQmW9eQr3Rcz6hx0YhXr5w6GE8QXJgqq+0gvnsHfPrIdK54v4H/DM5Zh9bcZJMNBiT2uP1PydsJmEEk/O5mxZ3MPMY0HZfjCwFuhYoK5Fo41wY7dWk/0HQtWd8qALvHQRbO7e7isqFYmDcc0kyL0VDrminAhdxLquWeKFjA1N3nGclJ/qkM78CR4lgI3ksxZXWatk2SIq9jpuP9mqWQHqUgugOy/RBQPQDUYUIsKsVDMwK+deg9Prs3t8pQ0lRfGiQDfKZv+G3rR4Xn0/YJrM8ThXNHr4rL3n9gJ6/EeWGHbB4Cg80Qg/QShK6YgZO4YwZYNLDthZiN+NBUuuviKdXKTxkFCoy/CZgjRMyHfdQr9a6GSXEHRzIpp8m1XL6RAduOKM6UsYk1EGwqJdJqtZLkI2HbxALr6dPpBX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(366004)(376002)(39850400004)(396003)(8936002)(478600001)(36756003)(38350700001)(6512007)(66476007)(2906002)(8676002)(83380400001)(26005)(186003)(16526019)(66556008)(9686003)(38100700001)(107886003)(6506007)(316002)(86362001)(52116002)(1076003)(6486002)(110136005)(5660300002)(956004)(66946007)(2616005)(4326008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?rKTCA2ullNijtEv44rndSTUnHAhTIFZWpJ0wjy09RNM/yuSrtddzduJB18Nw?=
 =?us-ascii?Q?WVvUY5bYGymh8jGmsVB+AXKMtQNBzQUCkEpSAM4d3QxxYqnaLNwvaBD5XTx6?=
 =?us-ascii?Q?lN6uot1ce74+GYu+QH3j3dVM6w1z1QPYt4RPRf5E/wRDngIgGslsjaJzManb?=
 =?us-ascii?Q?gu0v4x55y1izYdu5BJfTW2bAalsSMkyPO5DRZkQ4Trs1Gd85CZ8r0NYPjxlB?=
 =?us-ascii?Q?yApBZleJTGMrTLQwMXHD2k3ldAWyPOtvjWxVWiK4qbinxvUSvNLFOo4N/gPr?=
 =?us-ascii?Q?XT0B3MI5z2GtJ6a/RAZUUl8hxKDqroGxJ5GTL20XTJsW7h3gZOgURikQ1uRP?=
 =?us-ascii?Q?VkuzA4nqclKHuFQZwy6ZjoEwxqTu9l1q7IOoyWQQmiRFEdZL3Wp0sB+SmcNq?=
 =?us-ascii?Q?89EBnsNW3wTpAZmiYx3GPfryy5d2ScNjip8S9IXaBVmMywMakbZz48ePv8lb?=
 =?us-ascii?Q?Y+6AOFyQWMkY0g/NgyRQMXF6F3HpcDxhPU1E+dlYD99UO6qYLhzKN9Dwt44P?=
 =?us-ascii?Q?k9Ey/oELxl08NZnxg/Wht55w3tNqGW142BJSrs2mS5xXuRF9EtuJde+WytCJ?=
 =?us-ascii?Q?EGaqSjOQnCKjaioFySMyn8x/H3+i7DtBDonbAJrVUuYvG/RUBroLdC+e5VMK?=
 =?us-ascii?Q?efCNB1C39sLWB5UiKahZU/LUYCsgHRx5958Er9H00uojV6atLo3fvgg+/N8O?=
 =?us-ascii?Q?d6wH8nLPS1RUmJcm3vt6FouUaNH/OYXFhYOzEqGUbcDMNZgxEN9HZPyPIx2A?=
 =?us-ascii?Q?J2D723zobPFXyEihIstGHB5d/oDF/7WPIN5MW2KDvjGwo/Dc6Ncnmvu8Mp2S?=
 =?us-ascii?Q?2P9BkQfnAjzVBA01e+FuAB63K+1CPwKZQ4ZdIixl1YMYvl5BgGSIPliJKEUc?=
 =?us-ascii?Q?91RQccY/2I+CJkB0FGPWHzndzt3Lsjk9KgPfrN5UHTg2wyumt1dd1SYLr/9p?=
 =?us-ascii?Q?9qfC4GIdRThmppERv+URJ5XRkN37rFdRo3kX0pZuNdKgM7svIYEhxDyFIbof?=
 =?us-ascii?Q?1u4uHF5tBWCGl6eOdjs8qGyBM0UPs+TrixcaMEQiezYquRu7XvgTuVYeUFVQ?=
 =?us-ascii?Q?hxACK5xCFWaZRw9YzAFlJF0H0ApYwowVErgk3Kc4JUidc6xa7ClmEX+9ieq4?=
 =?us-ascii?Q?hZqNgv5ItK+jQBsMfoeok5YKuJnohME41IEUPlUqNE6ciun5r3nWoJmf4uSW?=
 =?us-ascii?Q?J7xW8iVbtOwD3toRMPFYtSZERF9RLHSCzcSCz/zNYjhm89xNIzbMErkT4hcx?=
 =?us-ascii?Q?zPH5enH/uCMga72FmGhddoeVZLlsI+VvV4w0lSv9pOn8d1Z0n5TTbFbUk7/E?=
 =?us-ascii?Q?vCynukJai9Ura6SWWqF+G6U8?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39b9972e-0527-4429-62c2-08d8fa434fa8
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 04:03:48.2841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGqemfY5+UwtbdxDu05nzbEDoA7B6taBfTUuM6GECjsRDNCzmvxx4Wqas42kVupMMcqCgMsTCsSQ0bkDyyxkX0+PAv4Yhs6FvjHw9vqnwt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1351
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

When Ctrl+C occurs during the process of zynqmp_qspi_exec_op, the function
wait_for_completion_interruptible_timeout will return a non-zero value
-ERESTARTSYS immediately. This will disrupt the SPI memory operation
because the data transmitting may begin before the command or address
transmitting completes. Use wait_for_completion_timeout to prevent
the process from being interruptible.

This patch fixes the error as below:
root@xilinx-zynqmp:~# flash_erase /dev/mtd3 0 0
Erasing 4 Kibyte @ 3d000 --  4 % complete
    (Press Ctrl+C)
[  169.581911] zynqmp-qspi ff0f0000.spi: Chip select timed out
[  170.585907] zynqmp-qspi ff0f0000.spi: Chip select timed out
[  171.589910] zynqmp-qspi ff0f0000.spi: Chip select timed out
[  172.593910] zynqmp-qspi ff0f0000.spi: Chip select timed out
[  173.597907] zynqmp-qspi ff0f0000.spi: Chip select timed out
[  173.603480] spi-nor spi0.0: Erase operation failed.
[  173.608368] spi-nor spi0.0: Attempted to modify a protected sector.

Fixes: 1c26372e5aa9 ("spi: spi-zynqmp-gqspi: Update driver to use spi-mem framework")
Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
Reviewed-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
---
 drivers/spi/spi-zynqmp-gqspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index c8fa6ee18ae7..d49ab6575553 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -973,7 +973,7 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 		zynqmp_gqspi_write(xqspi, GQSPI_IER_OFST,
 				   GQSPI_IER_GENFIFOEMPTY_MASK |
 				   GQSPI_IER_TXNOT_FULL_MASK);
-		if (!wait_for_completion_interruptible_timeout
+		if (!wait_for_completion_timeout
 		    (&xqspi->data_completion, msecs_to_jiffies(1000))) {
 			err = -ETIMEDOUT;
 			kfree(tmpbuf);
@@ -1001,7 +1001,7 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 				   GQSPI_IER_TXEMPTY_MASK |
 				   GQSPI_IER_GENFIFOEMPTY_MASK |
 				   GQSPI_IER_TXNOT_FULL_MASK);
-		if (!wait_for_completion_interruptible_timeout
+		if (!wait_for_completion_timeout
 		    (&xqspi->data_completion, msecs_to_jiffies(1000))) {
 			err = -ETIMEDOUT;
 			goto return_err;
@@ -1076,7 +1076,7 @@ static int zynqmp_qspi_exec_op(struct spi_mem *mem,
 						   GQSPI_IER_RXEMPTY_MASK);
 			}
 		}
-		if (!wait_for_completion_interruptible_timeout
+		if (!wait_for_completion_timeout
 		    (&xqspi->data_completion, msecs_to_jiffies(1000)))
 			err = -ETIMEDOUT;
 	}
-- 
2.25.1

