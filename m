Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BA25BF79C
	for <lists+linux-spi@lfdr.de>; Wed, 21 Sep 2022 09:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiIUHZZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 21 Sep 2022 03:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiIUHZT (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 21 Sep 2022 03:25:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D516D4BA7C;
        Wed, 21 Sep 2022 00:25:18 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28L3mfWs019171;
        Wed, 21 Sep 2022 07:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=fJ+IKR7kuRh3HJuEvTHM/9T7EBaL1L6rNTuRPrrwiw4=;
 b=196SocYCG7eGiBqc5OI39atR1cctk6mUCqBrcb1ly2NEqn9BAC+y99VHxadYu0xSt2ZJ
 0AcD9WXTUqZrY5nePnkbBc+a1JPEOLDZMOjm803e03MIdmz1/nKCkohcEX0iPi/EiyP8
 XKSDf5R+vc5n10ARzfTu9P4EleQbH/1m2jlFplDfhMx5f+mpcj8ZmUFJFsT3pBr/NHpR
 d1sfrfGp1Py3jeNKV8q27YwUoNZo9IbgZnvspIoffL95FOg9JISWUOXoSLNhekKl5EHj
 34bAkw7AUHPs+DKqyC/V70FnKuc79d6sgUJV4lWx4HuNVuGwv9ZFBfrEsW7BPD6vv3G3 +g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn6sthj1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Sep 2022 07:25:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28L6ZKjK022969;
        Wed, 21 Sep 2022 07:25:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39rbwxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Sep 2022 07:25:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqK+Mzg7+n91MQhLj2gxzHLD1Q1P3MWmWiOTdJP9Vky+FQQRT9prapcqNjeCBCigdO9aR7Np7H2WX1TUqzjuj1DAzYESYXIEpQg3BV1hetClxU5c9K5kC21NiKc7mbBmGmovIlqr+kUU3sSl0YVLlvvhu8hQJKY73DX7B+aiZbDIL2uwWi1jG1jWHkhY0bzyVBMmnUhrGQeREpva11A3w+3ed70P28X6MztUiWi9vr29SZyQgipK6N3eM0vBIaCIMddeqfkk1PPnZ16Hetfi4HpVePWOfPCXX4GZtTFyFI6JX5+tIpAuH1s26jx0UpCRwB625TXLyEdG9qBeCcunMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJ+IKR7kuRh3HJuEvTHM/9T7EBaL1L6rNTuRPrrwiw4=;
 b=jaunnaNk6zE6Ol8zrpO5EIbcjh8UPcuyAMmI0ilkORJMDN0gPWRD3iW1KzZmkNM7WQGfwu0fh7oCtQro+dhpymf+w/xagZN0lqt4CED+a0c+Oc/RJ1VbYqvXSiZgwDDa7TnnIKpdYfEa0UQUqlox05JbjFbWWHhDIRUNWNVkg3RuQB2uzweynoXGLq6RwStZ/1JXxctMimPhlleP/ebaimVYVaNgvUR8CUYEvBB6mx+7sh/OT8BCzgo6rOSrDS/sdwkfk7ajQ2Sp3EDeDSdw3RG4FY85HlUxOtxu3cBY+fHM9RH+Er5FQOl9fTBAUK5SSfqggpcmN8FkVWzssRKFAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJ+IKR7kuRh3HJuEvTHM/9T7EBaL1L6rNTuRPrrwiw4=;
 b=RnGSrlaK80bos3k/j7flcUa6HJqGj+e1aX5Xhrtka/3WdI4mnhs+FJ5FqkjMwiFybVvz4oPM0PE0k1H3uNTmlCreYPrkEUNIgfD1AiW4QWHC/yI2lhnq7BqG/2NlRoDdCwePzEV064SeTUpbPKwb7nfiMwj2QFFN7KL9aAHQcwc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS0PR10MB6149.namprd10.prod.outlook.com
 (2603:10b6:8:c7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Wed, 21 Sep
 2022 07:25:08 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5654.017; Wed, 21 Sep 2022
 07:25:08 +0000
Date:   Wed, 21 Sep 2022 10:24:51 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mark Brown <broonie@kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] spi: omap2-mcspi: Fix probe so driver works again
Message-ID: <Yyq8Q/kd301wVzg8@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: ZR0P278CA0193.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|DS0PR10MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: 214e31a1-da3e-4307-fa6c-08da9ba2694f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MMdJXyNYI1jGo6bHNntK9DbgCppZQVIIB9ghG50i7vbz1DBPZA5OOjzsU3FY2xz8g4OmWf6iEZQKqPGiXA6hcCB13mcGZsB4eySMuXYulaQ05Aw91HntRDhXFp3Ph7cAZWsKT66kUFtfy47y4odd50XEE1s2VQDHzV3USNid00B7CKfmEKOsddB81dxr7M9BZ6UQXaTfVHMm7lzYb/aKcuOwflOEmL09pRf5ZNNAAV+VfsI6JXW71ArtUheEyZQ+GQjHRKWyDWYp4WFRmPw13Ji4w8L+jxPG4v8YCgtAVW1MmH2cCdrWjDtDbGSMubtoR6+9btjDpqjIdm0kqGd14dJ6POW9i8WdIY5ht4x1AQSPjaD4R0Ruo5UaR5J+s+lIh141JAyJmoH5QRSk52uJCLc5JU7kBBS3jpJzFvheH6PMk2ImV57Ja5MYChyVP5HmHvFHtO46hR8OEIVzwk34ctrSxwSe2tSzx70GRG9Fm2YlB282Hs0UokNWE4O/kYwAPIi7gauEcQPHNQ6ZWmQ2Yf03sh9az0EOnk9ijhELV9waoGXrLVms/FJTkD3kjhsRdDKpflTdKHcEo3wicIRzJglCH6fP39kNfVCUC877gIyT5UyhH0KBSzw9JM1fkVECPTq87OehDjFrj8JJEjLWBHz/s7T2JB/KHlmbsGOc8Z+PtKoOVettb4DCKbiMJogapN8RjyRE4fRI1ozdVVpN1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199015)(6486002)(110136005)(6666004)(41300700001)(478600001)(44832011)(8676002)(66946007)(4326008)(5660300002)(86362001)(8936002)(33716001)(66476007)(2906002)(38100700002)(316002)(66556008)(186003)(6512007)(9686003)(26005)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EhsPx1jTk2Z/I7lj6fNOm/xlks5wjhsgTr0r0Lz5QdcQlX6C5r70bssus2sN?=
 =?us-ascii?Q?dIAedZtEYjstcEcXniXbg6MAPhYsKXLW7yPFjd3jKc0Y/+IqdriY3eUApSTF?=
 =?us-ascii?Q?mtOXJyj9VE+HmRAxOiyWrQvfou+PVxzlir+ZWrEMBDjeW5VA20YProvyyHHA?=
 =?us-ascii?Q?hgL79lmqmceSjII/E8AUtiCGqM5hITufOXQF67ugCegfZBxDwTeswzLsVYnN?=
 =?us-ascii?Q?Dl83eMpp8jVJwzIFZRPuhcfhGgm47PMRmfyiLX7lZSbpvu9uLnjZK/OaNUSN?=
 =?us-ascii?Q?X0c5N3eOo74RGeNAyVDPiBPceLLucfyglNqYIc247eWUKZnmT3JQqyDlUznQ?=
 =?us-ascii?Q?68YIXH6ViJKj586Jnj0fi+ki0NMQMAR57GYOrcPCoXO1P9V2wkcoUODErUit?=
 =?us-ascii?Q?rmLb14EeWlv9ijt2Y2gX4H46uFAxIlmVXUiKzbngIdZHjoBBmgzGq4Gnd4xf?=
 =?us-ascii?Q?bzsxolMuxPubc6MISnxTmeBbJD5v7T6aSshuJ5Ig8JEtEl0mIAq9f7u/ONYs?=
 =?us-ascii?Q?b9Cwi8db/3kQhwBYMQUr57y+I213HJ8bvO2RIfA5gBaMHW4rBwSRAQ0i3dBN?=
 =?us-ascii?Q?/Thym2ADq2i0RePOWC+p9FKeIfndI502jkrj0n2iNTnaJnY90zqANnvPsXHH?=
 =?us-ascii?Q?LJbhRf+jwqVKCW0LWLyWomKaSWT4aE+Jj7QIrVQ6mK+yWdI2ubbcuC6M99gB?=
 =?us-ascii?Q?6doQc6Fghhy+tbo5OMs2QX58NCFyhv5EP7/9/S1fcXQ731/MNjTK2fnNQDZm?=
 =?us-ascii?Q?oNO3F+knJ7cJNkTEv9Da1nSC/Y4cn9PsDstqvLf3BqUmmNcR5XL+RZGa0WhO?=
 =?us-ascii?Q?MaKItK3VV39ykvzUhmNmZinYx1ooZHtIBUVDiFEkw94a5Ks7lAhaT9cNx5YA?=
 =?us-ascii?Q?KGZBl5MXJ/qjs1QvFuYbq8mbaq7NBz3ehbgQa9vNUs5nO3qLe/wohYA16A6z?=
 =?us-ascii?Q?5qKXb0b3M5WcmfDg7blrsXbD9ta8/CLls5KJaKaVq1Qp5kaPf0tTY8wfashG?=
 =?us-ascii?Q?0kUsPwsTv0yNFH2bZ3WPxam8WWkulYLcOFlRRLpR/tm9n0gwZom8J3uqy+AE?=
 =?us-ascii?Q?fwgkmq90w81FAsxGGyGCcBEYVf5JHDwHgIvFm1uUiOAkrArlqpL1ACHUJnGN?=
 =?us-ascii?Q?m4c1FCnQAl7pGeDK+azaguEMfViAEEJmcfP/vbjV44odIV0QsMbK/iIGvs3z?=
 =?us-ascii?Q?uAnyCvaEggCqVW7owX58EwnIKF0vyZYIv7Fp7HVD9xdJHDWsf8glWodGyIZH?=
 =?us-ascii?Q?8H8Yd19YN1ebfk6Lh5qQZ0lkQpfYt72NUkwvk5ZFSqlyIrItlckxQvjzwbjp?=
 =?us-ascii?Q?3ff8z8iLXXr9E77EptY/vwmu7emLxpV9Ght7opjoJb7vbPUNyFAzmQU6/DNk?=
 =?us-ascii?Q?VgqTPvGfrvYkFFmkZCqTMDY2pUNuVfG2EQeQ5G8xOp808VJQ0Uebf6Sm4kmv?=
 =?us-ascii?Q?CY15jjadadiN6QiHQp/zWq4+8TM9gSpm9OLbgAwXN/Ajvm6wegTRcUEFkKN+?=
 =?us-ascii?Q?a0uBOfxEDL7yG0LsA4ZnECh9pyp3cKCThtYSPNZFHo7K41fVmUDR4Hg+9U/P?=
 =?us-ascii?Q?/kX/WMPGolsUl7SAxg+Wq1pjMtUtLQuOOIGNEA2e?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214e31a1-da3e-4307-fa6c-08da9ba2694f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2022 07:25:08.7233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +D5eVv3V3lhASqHeSFRJtVpKWgt/84NNYzeppXw3Ue29Y2y1xZr4FJe7Nj6JJC5xOURYakE2GHGYpdPD1JRX7cM89fK/imMYnSdDtN9LWnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6149
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-21_04,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209210048
X-Proofpoint-GUID: 3qOnbp1ppLNINQWy9AaGibLQcuR8QTgr
X-Proofpoint-ORIG-GUID: 3qOnbp1ppLNINQWy9AaGibLQcuR8QTgr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This condition was accidentally changed from "if (status < 0)" to
"if (status)".  The platform_get_irq() function returns non-zero
positive values on success so, unfortunately, the driver could not be
used.  Change the condition back to how it was.

Fixes: f4ca8c88c2c7 ("spi: omap2-mcspi: Switch to use dev_err_probe() helper")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Sorry, if you recieve this twice.  There is a bug in the msmtp program
so the first email I send every day is lost and I think this was my
first email.  Resending.

 drivers/spi/spi-omap2-mcspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 80e79f3aa0c4..6ba9b0d7710b 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1509,7 +1509,7 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 	}
 
 	status = platform_get_irq(pdev, 0);
-	if (status) {
+	if (status < 0) {
 		dev_err_probe(&pdev->dev, status, "no irq resource found\n");
 		goto free_master;
 	}
-- 
2.35.1

