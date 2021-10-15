Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F01542E962
	for <lists+linux-spi@lfdr.de>; Fri, 15 Oct 2021 08:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbhJOGxZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 15 Oct 2021 02:53:25 -0400
Received: from mail-eopbgr1310125.outbound.protection.outlook.com ([40.107.131.125]:11837
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234400AbhJOGxY (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Fri, 15 Oct 2021 02:53:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7JDQUTeHHRaz5Bc4AlXeRJbCo3Qaeg51VYvfdbpsXmSopoOrGuYWy1It5YBiS8ONqkt+mKNPMC8y/Aw/9BI0y07MBTYuBq6zPh17ZWZ8SyMBPkOezHNcwFVG8RTT8meH01or3nvRLHmCjRRRMC9jwpagmt+uHOahO0u4qqV13abUtjoG0QP5HUWmNpchDbgkV8RDXlou8RpeXBCIQMVWcUIczrVicTwBfxQQ/INXFZ7QMA9ZKhdNSAjJlcYC8hd0hdxO0DroTdRgsipH/2geNdc3XXaNZvhNnvPvljaurRP5etVYRpzrDTn/fHwOCxzWJrt56+xbV8hmiCJ5ByTSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UiB/JI4lN57LAreFbrXqNvi4GmmJW2W5Ih4wv07dYhM=;
 b=DJGmRxXE1QL2n3a3jpyDe7HpIUz2Pw1nKzzZdCoFyJVrEIHHGkl2d1SuD5Z6xohxLIdkcHAPOF3Cu2ETZwSC59tVxOrlvKBtVyPI+QEPqJ6PbrX9TtZggWv+kfXTZgP+QxO3b86hmengJjUZ56+p1clmi0Wn/VkxN3CxBwfjfANWoFHH6CbrErLOgkFj7NVCI2Xh9JxSjB9kAJ/4qAYWrIsGfeT+L7dAB7SXm5W1zDioKIFjbivkvhlGhpX2qveRBZcJlt3MYzrQe50AtTeevDQcOBtbDTkTPC12OSwo5qT/LqDA+6Plyyhd6qEMx3VllNPb6U9cXAMV+OgwGiBP7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UiB/JI4lN57LAreFbrXqNvi4GmmJW2W5Ih4wv07dYhM=;
 b=IT0GepYYKJ5/347r+PYn0Kmp8dK3RZ2d++4sg8z/6k5085BIam8Ndh+rErVtG+lTXkD5RiFunqBrp7xuQD5qy3Y7Df4ptm56RWqFg/jviKou/lkPArhSI7WkeDOjy9f0rcFiaf3A0Klu4Jma5jneXOPx7Ce8rkT6MH62gE4tCNQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3003.apcprd06.prod.outlook.com (2603:1096:100:33::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Fri, 15 Oct
 2021 06:51:16 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 06:51:16 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH] spi: replace snprintf in show functions with sysfs_emit
Date:   Thu, 14 Oct 2021 23:51:08 -0700
Message-Id: <1634280668-4954-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HKAPR03CA0008.apcprd03.prod.outlook.com
 (2603:1096:203:c8::13) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (218.213.202.189) by HKAPR03CA0008.apcprd03.prod.outlook.com (2603:1096:203:c8::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4628.10 via Frontend Transport; Fri, 15 Oct 2021 06:51:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7839a47-c257-43a8-e3a6-08d98fa82f6f
X-MS-TrafficTypeDiagnostic: SL2PR06MB3003:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB30033B34A497A53C31A4B28CBDB99@SL2PR06MB3003.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kdTJ8OJ+whBnmTAu5NifW3KBDE6V1LdqdtTEmBtz6bQhZ2YzABUFEdA7lsbK6aJpwcP8FMPs0bJxLchAcGVTUzl++iYB+Ll+EUjT3qgHyWhvxMdprccFPrYH39uZkePj35v64ID/4fVduKsdh1UGuhUsah6O49jBkkKVJD757G5gM1QTR+hoGoks8Qk2klLGAoh+HX8UXny4RRO41eRlgiat+YMh6SMlusBW5nDcHUpooRkhwe293aQpyOZnryoukYViJRWZbyh6JH1WZbWSHUbRrW4OB0AX6Xeep5qHDLqR8Etlc5UvJc2U92yA2TE9luw4c1UOppI+RPO+SCsMLHLRHlb7/4iU1bkIBzfRcYXlxdthgZPMoJ4jdZ+RAZtSXCUa+nyQFaWodEAx6dTKn8G/7sL9P47Ln/sXWBnP/Wjb6wEZZUp6JqBsJV7603ewBmU2GFnq0vmbOnzvK8ZXwqIQQNoqguH6fTBxBU3a4UcpYsIaKDyKGvZ2OM/HlxKwPnkyLRn99RurtKzQQpG3enTAoGpcunoc7ZNUJOi2OiEGI1cqNpzcolU4k1VUP8umDK+t7dhiTVY1LWpTfHXLe0it3Ka1NWnpzp9tGfTA/AJ0gN6sonLNzhEMtZtimsTRfYisn9TQadz9h78/7vO7XzAN3RcoDxdYJ+ZTWsdweUoeCmcbw0R8khzBzOS/NQVBeFQT8xKpIpC1lcE2DiIWnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(5660300002)(8936002)(66476007)(83380400001)(316002)(2906002)(4326008)(36756003)(6666004)(66946007)(86362001)(186003)(956004)(2616005)(107886003)(26005)(4744005)(6512007)(8676002)(508600001)(52116002)(38350700002)(6506007)(6486002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bUxot9Z15Gs9DhEY2fu4u8pfxEbo440NMGPwjxgYAWq7RHJvbpGXPsFMyHMe?=
 =?us-ascii?Q?BsUOtIZ+mlvMTrS+iN/oOVR2e1xdPqEzeqGiUpteQ3bl4L689FqxIDJpg50p?=
 =?us-ascii?Q?zTK3BmoozCHtwBwBC2tVZuGaJZgWBukUxtNFVidx307aj1NyeR55/YbwNGJy?=
 =?us-ascii?Q?8YxiSnueMg5Q4guKEqfAPJp5D6HZhNdcJFPXStvJoDZNaZULjQa5MVqhlEtz?=
 =?us-ascii?Q?Ez07ftYpQeNgJZXl44Zsl35dFpZ3+xxrVRYsYq6xd+zts4OLGqiCdS68i6S/?=
 =?us-ascii?Q?jGILtk+/hXGHwAMfjoZXaB/wyi9MkADZTUWQLRz2AxYhp5UUgYml1Xsb538a?=
 =?us-ascii?Q?KJx/yTD7fa3N12KqyhSszpGcEAoUDgTiIc1xw12Caf62ERFnWU6PF0hPGKyA?=
 =?us-ascii?Q?qU+gTvsqLmI5guXL/SXLMf9Txfdez3F7HQsIG1OElwxfSN+bzHQnL3DItOGR?=
 =?us-ascii?Q?zzara5vioFFT6p19HvsatEE7VSK7n4ZBrB0Nzxq9SDEQuEnIRIsEIj8eO45m?=
 =?us-ascii?Q?DiDH8Y820yi8Tm6s93OfMk4Rgq3EwP8B7FrpXvWHgMIoI/hg8qWbkt6Uj9+j?=
 =?us-ascii?Q?LIIugkrBShgJwNtHg71qb+yiNSYKzg6fDsAeT4dmWYcGRUwO+Dpkbw0Puptt?=
 =?us-ascii?Q?0q9/cdADGNTrKbB2mQQI10pqgNOztJj3MlcSGXt7kvfzDwhHsAA7YPoMAO7+?=
 =?us-ascii?Q?5hxmPML9fNml6RLMW/B3k+rjdIrrdQ55JMTj9xahCKB0RkiKC40Fs95xoL/2?=
 =?us-ascii?Q?8qw+1m9kZyICBgHfFXzkVO0QM2zoNY5vdbKniL9l4fToGHZ1Pju/mZRAlL5z?=
 =?us-ascii?Q?l0MUWdNlbGlmtZaQwjXsx+x/ge+Zg8XtrS2jL3H9ENfyDKgRwcWiq4nmR88w?=
 =?us-ascii?Q?UzZoQP9uEFA8yQybZkvLWCgLmJdteFQDyLfJvG1FQaIksLVxAI+oTrydaLkS?=
 =?us-ascii?Q?dzz+3GrbpkD1OGfVfoHXVk23Hg+np8b5hByDoRd1EK0M0m4HbMjqiTheI6y7?=
 =?us-ascii?Q?ZxI94OxDfAD7I5uWvjqAJfrIXUUl0xpXz11X13sq08AKJKxnLrkMlqc/Ufnq?=
 =?us-ascii?Q?n2XtZ49LDaVaTE3wnS7Q9RF7ZmPWydiUhB1wbSVQn54y2E043ypRNDxFQPNU?=
 =?us-ascii?Q?fgl5txvVE1oIdBaGfiI5P6B5OEO4KhSo1S3UwU6UUZYk+MGs29L7HnOGxLMZ?=
 =?us-ascii?Q?UJaPfg69fstNshO9bzUScsF5bQpDy7w5feZWiDSUV1FXBeGv8kKlcQW+GHnm?=
 =?us-ascii?Q?NuZC/RmPb8WLBFbwNNryHsqW3qnESEOIjcKp0lBj6hHcNHfuoD4qEoRMH/K6?=
 =?us-ascii?Q?dwaUyrV3ytudj0lVMcdtcKwF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7839a47-c257-43a8-e3a6-08d98fa82f6f
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 06:51:16.4384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CfUTkKCRUUyr/waFvOeg84FXu27dwRKfkqgrklhoy86qvMcgrY1R/XCI6LrNjAc83jgyxZ3BuLkwB/vrazxejQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3003
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

show() must not use snprintf() when formatting the value to be
returned to user space.

Fix the following coccicheck warning:
drivers/spi/spi-tle62x0.c:144: WARNING: use scnprintf or sprintf.

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Signed-off-by: Qing Wang <wangqing@vivo.com>
---
 drivers/spi/spi-tle62x0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-tle62x0.c b/drivers/spi/spi-tle62x0.c
index 60dc69a..f8ad070 100644
--- a/drivers/spi/spi-tle62x0.c
+++ b/drivers/spi/spi-tle62x0.c
@@ -141,7 +141,7 @@ static ssize_t tle62x0_gpio_show(struct device *dev,
 	value = (st->gpio_state >> gpio_num) & 1;
 	mutex_unlock(&st->lock);
 
-	return snprintf(buf, PAGE_SIZE, "%d", value);
+	return sysfs_emit(buf, "%d", value);
 }
 
 static ssize_t tle62x0_gpio_store(struct device *dev,
-- 
2.7.4

