Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBAD33DB1E9
	for <lists+linux-spi@lfdr.de>; Fri, 30 Jul 2021 05:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbhG3DSj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 29 Jul 2021 23:18:39 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:61796 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235022AbhG3DSj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 29 Jul 2021 23:18:39 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16U33wKK025430;
        Fri, 30 Jul 2021 03:18:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=bFMi6/1RnUwrKZ1RaAKFYB8NEbjz27JwQHDRZjrjubg=;
 b=HyxiDA06QkU6+j5xvVM8dV4DickuJKqSDyP+zBe1geTP+lJ0rM+uVGMnIJuX0DIuzsMT
 o0s5RJ0YaTu5Xbd48Bn04S2K2uBOt8GIG5VjYxkE71gkO3PI0hv9s/yFgIZmAXJuYSA8
 wvZd25UnWRXsz+GqAPVHFdraHqjaaYPgssWwm8sA8LO4Y/jxLFv9TtU6trj+T0Re/SYL
 DrmrBbiIjpK3F/pc5tfq4Tb8SRxVfFRn2I//7dFmKiItPfeZK2xQGuab6eTy6Gnb+RI2
 Tb2jx38pCzrfR4m/r7WBLYDBN/HQy4T0gb4FxddO6x2l9Nve/KFm5jQq59rEQlS6V6Km UA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by mx0a-0064b401.pphosted.com with ESMTP id 3a420eraew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jul 2021 03:18:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c9GSJb9WCQzynI1nco8WBfuOpbwIoE294Jrn2CdsuKqxWfflzAKyR575oGDE/9SpCwAWHIT5CBNKok2Ww88O0FEjUM/Y5C5Y7aTFMGToJvR5brfK0LMdntPvUFVRmGb/qIkZ6r6sS/WPIXCs9yV9X2GkOwHRzVnagZm5IUwrpcF1CpD0nlkJZCTxl2MxEQssi3fd8b4JQBZnDpWb619jF8TK/Wy+yEeBnEm83O/YvMZPRJEFetBFiRc0xfJj/8IBoMrEodLiHSHs11URrzR7BJKwU71b5t1mY46ALMplqPucvY+itY2ckOP5gi6msSzS72kHCIviZ8ysCFkGrrJhyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bFMi6/1RnUwrKZ1RaAKFYB8NEbjz27JwQHDRZjrjubg=;
 b=jY5WnuwFuM7QGvt3Tz7RUo7OT8QOmd/0UnRSgxzlyqFuvLiBAId05CNi0eh5QbhZlo3hcGbJDeCw9qH92SQ7VgJ5E9K5688wOtKtfptW7HOkcYL5637FGCBGJfGlmoDBZtIV8qpfiUjgyt7nKZDqaHLiPpdbZrVs4KoMRE5YW9P9ejhiNcvyGSWWA7NXIrm3t4t+668Zgd/YGTFMXFyPJzZu1KOiAb52DvjgCL/vzUyxF8XIPeb4qZfcLlGespOMAwoouMaT7oOb1U6/CpSGH2402iEZOkXkaUCJge1+RntKd1DT8h3mCe57db/vnsE9O4RzGv5WSfeMmYESgZj+mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR1101MB2152.namprd11.prod.outlook.com (2603:10b6:910:23::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Fri, 30 Jul
 2021 03:18:25 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::def:cd0:ce93:8a7]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::def:cd0:ce93:8a7%7]) with mapi id 15.20.4352.031; Fri, 30 Jul 2021
 03:18:25 +0000
From:   quanyang.wang@windriver.com
To:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Quanyang Wang <quanyang.wang@windriver.com>
Subject: [PATCH] spi: spi-zynq-qspi: use wait_for_completion_timeout to make zynq_qspi_exec_mem_op not interruptible
Date:   Fri, 30 Jul 2021 11:17:53 +0800
Message-Id: <20210730031753.1317917-1-quanyang.wang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::13) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qwang2-d1.wrs.com (60.247.85.82) by HK2P15301CA0003.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.2 via Frontend Transport; Fri, 30 Jul 2021 03:18:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f536a04b-2181-4c35-f910-08d95308b128
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2152:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1101MB2152922382BEF41C10CF0304F0EC9@CY4PR1101MB2152.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B3KCWL/Ep++cgbDpuTlj1+xAoU93CmP7SMejqjCJQt9vRQ/+r8DOz2ceSQ1h3xQK8gLWIYP2FQ1DtMLnUBDfooCVAq3DRXXlBaZkAjOBTDlNtZ6ZnZxpVaykJtLaOjDIC5g4WAd3f86yBp29U4WP2vkjagyEwWyhzTOBM+ZTVoPUiVSBhQpO+dHMVcZ5Bk48EG7V3WRS/L4h69zq/nGVvjAHFTE4tdVVL8pzUuSyuUGTZGsHfrt0/xKyIhjqjB9aUpjVjY7sTp4E6jL72GWtivEiPBB5wZJOAEzaFRq649k4lCBb4wQAS4Vo4GuhhzGFza3kbSVq9CAxp7qHX9EHW8j3QP5zfZH8IAJsRTsVhHK/zHzrtYHnr/PdkHsbK5HxrE2hirDirYIaqYJf1Tp/i0W15xVSOgkWzorNHu54UUX6kof/kjVCabMj30Gz3CjTrjp7eWCCDrmBoc7fHKLvWZeQJU4WuzCp5LLSLxbjvs4SzHFAg17NzWZqnE3t7+Akn8THdzOY9XpWbWyjWEp8J1wQtS+Mp/k28UidUfYy3TO1sXw//Gl+XBNnQwUBgQbvyxImYpiXtXTI/oClok4xzmPZkeE2WbcJdmyibiJJ8etXTMJOXjomitQuHFBVf6Z+FxtY6VwKvZmpiNqfNsqpmGF0H80iBoi/g6WvkEF2QcFqmWBO8aE3phLqp79EAqe7WLIjztJPJdIJf3mrMHjKZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(396003)(346002)(136003)(366004)(376002)(107886003)(8936002)(26005)(83380400001)(52116002)(110136005)(38100700002)(4326008)(2906002)(36756003)(6486002)(38350700002)(86362001)(1076003)(478600001)(186003)(66556008)(316002)(956004)(66946007)(2616005)(8676002)(6666004)(66476007)(6512007)(5660300002)(6506007)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MTN2f7iazvL4ENdFTn6nmNBsd4j89LCSgZkkonADRXBmTX+xdW4ukyOdpFJ9?=
 =?us-ascii?Q?z3azXpEr0dBk29NgrfuDiIcjf5NdjFp5NafIa3YTJcgtuJ3RemGOf1nwkpyk?=
 =?us-ascii?Q?ti/FyhjGumAyATV8XCR22hFYbegonat9WEiGK0gFBZ6i5aPeLlaJuRwb89Qo?=
 =?us-ascii?Q?ViZ6RsB6f0v/n5kwLkHpCqHotf8lYAyu+bew6nCewpmPAMvJ3t4zxrBAo+NT?=
 =?us-ascii?Q?yLEv73Xzwplz3gGIpvdifVCXfsbWSlmt/rkv/JNHewuANNmgtSQpg8PSItmV?=
 =?us-ascii?Q?sPmLDp7tvQ9TukOdtS8Xt478mz8VC9H7iF5HpGWOCs6pM8l98vXuCIn9FXU6?=
 =?us-ascii?Q?z7FLJi0yccSihwjfqaJBkvoC2uvS+3ZfiAsA6ECtcBt7Z3G7uoQe6K7Ymqvj?=
 =?us-ascii?Q?vTJmW6DNuJGOLJN2veDTJnA6YCxWBuFBQOnrYsWG/xXxVnwlDJrRRBBUqVb8?=
 =?us-ascii?Q?9DdCWiK+XfeKLB4f40z/CPiTzVNQlAmYZQ64vvPbSqEP6k/ZdIszbAusg03J?=
 =?us-ascii?Q?XRQpNLBIaZwtBLGeQd6y0hBdeFEokZiK8UCIqkILrelJKYNz273g73F3E0YI?=
 =?us-ascii?Q?fB3y+t5nC0QEQ7ZI9dP1z/Yw4ekOGJOTonP0YPKXs8YicGhfWLRn/1vWrxV5?=
 =?us-ascii?Q?CdXVcaZtqbY9cG07p6FB12vHMLIu81OEl6ua6TzKJKLIsIPggd4ZsAabpDQq?=
 =?us-ascii?Q?1JZkNBJ/xd+Vpkihl0+4WnqMVtk//jvI8qTX0WOFk2oHu2hDTJ8iuzGHHqu0?=
 =?us-ascii?Q?p4/YfIpWYKGOhSWdmBwmALx2Q2IkLR0oRwQcMBi8wu0GF8CPtqhR0ePqROt+?=
 =?us-ascii?Q?AKM/8Yviv/5o5ikmGHA7e1oYwPkGEBgZSWcMfsuf+iiiVrcbxEie/em0wj0r?=
 =?us-ascii?Q?p8MkgyuPirfnx+Zgh2WPnSd9wzYZrKl1MAAhFWski+7ROPVPHl7fmPW6OUb6?=
 =?us-ascii?Q?o7duBxF8oS7oKHihtKpXpb+GwAuWLaUiJNFPgwhNPB/4l7ZIc2MgVo0T11VZ?=
 =?us-ascii?Q?crCKurLqn9FJpKbHlERG86kb3wLBonS0/0fnD181hVT0aIPr7Dqsv0kYzAHW?=
 =?us-ascii?Q?Jv1zMAJzbMSysgPoUrc9qexJC7XL4u3cWIygbttIgxnaeecXGX/JiZWrjC5o?=
 =?us-ascii?Q?uwsd5KrGFUstCyL0jniELv7U0Of27tLmtcGzKfFP/3fjQXjyqqFJuTUN21zu?=
 =?us-ascii?Q?mAq9Ub5WlLzst7UIGwcdI4AJitbt9MI0eq0h4M7lzW+2yRDUJL/wnRoWlBsq?=
 =?us-ascii?Q?mkgvl4qWdrEkgII5yLBDa8etFIF85qhBY0HkYgChB/zAkfmdSRubKXmNVgZ5?=
 =?us-ascii?Q?OGBRLQ5XECD23IArW/lcGVxr?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f536a04b-2181-4c35-f910-08d95308b128
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2021 03:18:24.8750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WVedTjJUhn+HdhOo29oOoBA2/Fmhy+1HSYlySrosy4bNMnwQ9cNDPG+3GUpdnAK5kaXyzmxv2zGju34gpvdSZPQzM5G+BBn+i4L6NfcnclQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2152
X-Proofpoint-ORIG-GUID: ljPzSQXVy6ysv6HI1gkHXn_YqfDSITQs
X-Proofpoint-GUID: ljPzSQXVy6ysv6HI1gkHXn_YqfDSITQs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-07-30_03,2021-07-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107300018
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

From: Quanyang Wang <quanyang.wang@windriver.com>

The function wait_for_completion_interruptible_timeout will return
-ERESTARTSYS immediately when receiving SIGKILL signal which is sent
by "jffs2_gcd_mtd" during umounting jffs2. This will break the SPI memory
operation because the data transmitting may begin before the command or
address transmitting completes. Use wait_for_completion_timeout to prevent
the process from being interruptible.

Fixes: 67dca5e580f1 ("spi: spi-mem: Add support for Zynq QSPI controller")
Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
---
 drivers/spi/spi-zynq-qspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
index 9262c6418463..cfa222c9bd5e 100644
--- a/drivers/spi/spi-zynq-qspi.c
+++ b/drivers/spi/spi-zynq-qspi.c
@@ -545,7 +545,7 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
 		zynq_qspi_write_op(xqspi, ZYNQ_QSPI_FIFO_DEPTH, true);
 		zynq_qspi_write(xqspi, ZYNQ_QSPI_IEN_OFFSET,
 				ZYNQ_QSPI_IXR_RXTX_MASK);
-		if (!wait_for_completion_interruptible_timeout(&xqspi->data_completion,
+		if (!wait_for_completion_timeout(&xqspi->data_completion,
 							       msecs_to_jiffies(1000)))
 			err = -ETIMEDOUT;
 	}
@@ -563,7 +563,7 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
 		zynq_qspi_write_op(xqspi, ZYNQ_QSPI_FIFO_DEPTH, true);
 		zynq_qspi_write(xqspi, ZYNQ_QSPI_IEN_OFFSET,
 				ZYNQ_QSPI_IXR_RXTX_MASK);
-		if (!wait_for_completion_interruptible_timeout(&xqspi->data_completion,
+		if (!wait_for_completion_timeout(&xqspi->data_completion,
 							       msecs_to_jiffies(1000)))
 			err = -ETIMEDOUT;
 	}
@@ -579,7 +579,7 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
 		zynq_qspi_write_op(xqspi, ZYNQ_QSPI_FIFO_DEPTH, true);
 		zynq_qspi_write(xqspi, ZYNQ_QSPI_IEN_OFFSET,
 				ZYNQ_QSPI_IXR_RXTX_MASK);
-		if (!wait_for_completion_interruptible_timeout(&xqspi->data_completion,
+		if (!wait_for_completion_timeout(&xqspi->data_completion,
 							       msecs_to_jiffies(1000)))
 			err = -ETIMEDOUT;
 
@@ -603,7 +603,7 @@ static int zynq_qspi_exec_mem_op(struct spi_mem *mem,
 		zynq_qspi_write_op(xqspi, ZYNQ_QSPI_FIFO_DEPTH, true);
 		zynq_qspi_write(xqspi, ZYNQ_QSPI_IEN_OFFSET,
 				ZYNQ_QSPI_IXR_RXTX_MASK);
-		if (!wait_for_completion_interruptible_timeout(&xqspi->data_completion,
+		if (!wait_for_completion_timeout(&xqspi->data_completion,
 							       msecs_to_jiffies(1000)))
 			err = -ETIMEDOUT;
 	}
-- 
2.25.1

