Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4183616EE
	for <lists+linux-spi@lfdr.de>; Fri, 16 Apr 2021 02:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237368AbhDPAtW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Apr 2021 20:49:22 -0400
Received: from mail-co1nam11on2046.outbound.protection.outlook.com ([40.107.220.46]:31328
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237138AbhDPAtV (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Apr 2021 20:49:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJfBZVeloZNdNnpoum55nuX1lz9xjEpHf0GkZohJmoMOIDwIzOOMC8Nc+MZ6RtIKdvm8NfopwL8kBKwF4mbaz/aixBVkR/9UDk2tu6kSVh3iDahtOFwK74oNBHpNm+cCo9QwSWc0THMtTYTv3HJz6JGYIkZNOiGEBaOwJ0muVZy2dAtpxS4/kgIB+6scc3q9NyCYQ8oDhEVEs8Yp6JR+Xcf0obm3aaJYkAHrFZSCnm+o1mu/80ZTzdp8GEqgh5TEIiFHH8nNpawkTai4YqCJ4DKfhZd2/mmkPhG9G86v2jFK8k05rmQhh6evRgs0BNGh/+VZteDxzmNCUGbpI+tkgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVeHIVxfOU2zWxC3itfsiUUrYYh5WErpvAYgwvn5gHs=;
 b=clduOjIkbcxKiemEr/bkWZ2r465uuP+/xl+chbYJ+Oo1O6EXiUKHuS56e7Nowt9KY8uT/rrA9IsPgRYcFoh65s+VyLPfTHrjy5NcDDUqtsu90pRY9NoP6iPojYvRUhFT2Byl6/BVsAr7STei0h8oeVYgIGAeXzAkOiT6GI2kkI5iRTgav5HY2KDbMeCJtCCsa0OaInSdJt27vDDpsYZ22EweYd07dJhnjsan4p0aT3lHoDjnBr2OmyWDD3N5gldmkam7tsyvQvGLbLYaRTibfKieebl2aF9vxbqwip9TBa7ZOXwPO0yc21QVHw5s7qI5b5NN/tTZ95+p4kSxAzxPhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVeHIVxfOU2zWxC3itfsiUUrYYh5WErpvAYgwvn5gHs=;
 b=gZJyxOCA34b3zzGgMNJ85bEGSzAE8OYgXfUEU9D/mreiPKQl4mcay07XXUMRC63lTduq6+Y9uRu+Z7Ri1HsIjywpG+QYs8RrFi227KQ8lG7OzkVCWrjKU8Nz53tdKxWHqpY3KZDcQFIam18+dPR2Cj/m2P2GXX1Bp7ZRmf4lBY8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1256.namprd11.prod.outlook.com (2603:10b6:903:25::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Fri, 16 Apr
 2021 00:48:57 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.3999.037; Fri, 16 Apr 2021
 00:48:57 +0000
From:   quanyang.wang@windriver.com
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [PATCH 4/5] spi: spi-zynqmp-gqspi: fix use-after-free in zynqmp_qspi_exec_op
Date:   Fri, 16 Apr 2021 08:46:51 +0800
Message-Id: <20210416004652.2975446-5-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210416004652.2975446-1-quanyang.wang@windriver.com>
References: <20210416004652.2975446-1-quanyang.wang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SJ0PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::31) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by SJ0PR13CA0026.namprd13.prod.outlook.com (2603:10b6:a03:2c0::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.8 via Frontend Transport; Fri, 16 Apr 2021 00:48:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78e26e40-7006-4ea6-89db-08d900716a8b
X-MS-TrafficTypeDiagnostic: CY4PR11MB1256:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR11MB125660FCDEF5DA55695B107AF04C9@CY4PR11MB1256.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iT/bDfwKvEfHfoQgj6CFUo524qRmDclqz3FPY8ZZwOFje08spqG3neOIR9dW3yL7cvpDg+Is5sk14ftADqwk9Y56TzRNQXwefdNmuo3Yd0UDHFYsl+Od30vNdxCtvET9tDAThAOIQPfzlEk2JY68bfMVZpyYYVX6UcKp6PRWQcCmso8zLoajhnpIW825/aEXJhLzI0Qv1d4AvPI191B6wOHgEv4zuks6OXBmi5+hVdNR8f6ecyQ7ZGnshwbVESvaCr2zd+Ncr1rxyZ4526SEgzEHDBZnx5SXZmozlpHt6yX0SVmD8SFQVwYy2w4+s9cSZOtqT8eVGAmN7z6FOABlPB5SwwKlJAgXhtuOKG7WODLfxfitQ/HI8ICgkAWexJtnzIHFMKq5365hi+9pZ5c7RS00SGOvGWAByTeaj2tFUwVOkZllbf1zCb44o6yAZfeR0BN7wHzu3yoZIASyLLwjKfjoNnKViZaqbNOeJrsRwWK0KI7YWT2nHIHg7FamXanz4jtz6SqVDHKv4FEvyIb+W5e+N3dj2nCaG9kUBPE/kh/koABTRn+ScDyWFIhkRqNwMxhktB1slvgZPrAbuUwqCHtLiL+2F+4J7MsK8UNLqKAwaZp967JmzWf81MeZUPS7vhTdpusvnjHIcwLW41AnX56UYy2DY2/VB48577VZtDk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(376002)(366004)(346002)(396003)(136003)(956004)(66476007)(2616005)(6666004)(66946007)(86362001)(83380400001)(4326008)(6506007)(66556008)(107886003)(5660300002)(52116002)(1076003)(6486002)(9686003)(2906002)(316002)(26005)(36756003)(8676002)(6512007)(38100700002)(110136005)(38350700002)(16526019)(478600001)(186003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?U7I0s5XQwmZlUp7QefFnNl+ZNWYK2i9xaWPgLtR74pxu7IoBc7iEhVVpPqNG?=
 =?us-ascii?Q?8rknf77cVxsUDc22Jeg6v6WoFHZ0p+SLNs1YXGhXCw/1YRUme5Nq6QXrOlyz?=
 =?us-ascii?Q?obbYTVyfOlHLhRcnwx+5l1RkT1b9ukp3MFW06tGlX3YXY6Ad5LtQKyPjgvm+?=
 =?us-ascii?Q?71XS+KpgeQFpmH82tcC2+45cRqcyf/shGdiJSI5z8U+jGEygf3IxgCm7dL1x?=
 =?us-ascii?Q?HJVIyR/QIoHKYtkX/4lo1VD259edyLRNKwUZKqm9CFu+HhMn6tjwU4Oq9q/w?=
 =?us-ascii?Q?Yx+qP5nuyYSrlS7T3ETfpOdN8iBLT8uOC6HkrWNHLo4gZ/8YSBX72YePN9yb?=
 =?us-ascii?Q?jXc/ueu+sEQF8I3y5b7i+7yjFtcO3pvgJLQiTcg93oTOyNa6BYaE0eCZHfA+?=
 =?us-ascii?Q?43oyR8sw4QP01N6SaafoBwewpDJHRObcraJ57gAFGOqB1VLLI1XdL8pmTL5S?=
 =?us-ascii?Q?7H5uJgtaq++TmxZAUeShVCvP9zkhudYBLP4w4/5w0TPAhmnTT/WXMJvBE6Rl?=
 =?us-ascii?Q?EalwPwV+Xtd7LOx14hY/2E2zy1OLOYGpC4aA4tIaTWUkuiCA+Isnyfe8I5n3?=
 =?us-ascii?Q?UMRIjKf77+S40Xsh4vQ1Mz8xSHD9xJnvnhyETx5FKCHMNQMHE1HduFbur2kl?=
 =?us-ascii?Q?OAMihJ4EYWtgQkfa4emsBNgIIKB140eA+7ZA60+wGD5uYzj1K9jZ6fLr1j7b?=
 =?us-ascii?Q?xNSqMU20W26bNniFdYpxGSU4sglpG36oE0X4O60ySDwnQ3jgxfIoaA7ds8sI?=
 =?us-ascii?Q?YzNLb3IaHkENSbD2E+tm81GUqxa7b1Cm4p47tFU8kXmBwldIbOnJkaaffVTW?=
 =?us-ascii?Q?/IGmFCfc124d02IRxphdHmVSQURaP7eIAaqLSkLz1u/Pq9yVpTdWxLDmyz1n?=
 =?us-ascii?Q?IrJeCUbr5THAP+D5N4ur601h/6vtv4ixSgTsSqPaZLIqEXWncSQgDo5rHo4X?=
 =?us-ascii?Q?NhcmoNU8q6J83CxWs3FN3Lm4XgDo9kaEdagmtE12c048HeEm7QHRqRt9U6fm?=
 =?us-ascii?Q?GiIwVA7gV8JBVN12y5QwzjL3QTR2UBT7Yr2qzn1fKfQ1VUOKGVdL4Zqr0XNu?=
 =?us-ascii?Q?WRZH18ACF5e4wmaRd/WdE03dvM5q/5OeVxhjXaw03QiP+nyvfjLuvlM3y9wI?=
 =?us-ascii?Q?DnVb4izBW9tMo/84TioxJmy+2hRBajwR480eXVdk3fAKRlMN7uTB/iiXbuYT?=
 =?us-ascii?Q?y+XqAmbwJ3Cq/CC7kiEWsEtHg+QgMxekgKuSA3SbF09sLW0FzX96J/R9W4MG?=
 =?us-ascii?Q?fYAeVE0BvCBzDP6cLJDNgJed84E0JCOwFo1tz9e9WDvhfIwS4hXR86RduzuT?=
 =?us-ascii?Q?QzyuxFA5wVY/K53UW1GIVs+d?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e26e40-7006-4ea6-89db-08d900716a8b
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 00:48:57.2187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9UN/nEcnQ2Dmd50Nr5MLTxYwVjzg6QxVZkJG21N9uoJ8nKLVtmMYEr+ntKYa+EitKvk0g7zl/WGHoxg3IEbfgiDeqOIAhEiRrwXgJ0Yz36E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1256
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

When handling op->addr, it is using the buffer "tmpbuf" which has been
freed. This will trigger a use-after-free KASAN warning. Let's use
temporary variables to store op->addr.val and op->cmd.opcode to fix
this issue.

Fixes: 1c26372e5aa9 ("spi: spi-zynqmp-gqspi: Update driver to use spi-mem framework")
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

