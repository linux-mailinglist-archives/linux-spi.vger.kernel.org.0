Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DF849FB1F
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jan 2022 14:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiA1N42 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 28 Jan 2022 08:56:28 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49788 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231741AbiA1N42 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 28 Jan 2022 08:56:28 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SCx02E023376;
        Fri, 28 Jan 2022 13:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=x38mMzmZiIroGm8C9GOfdh8bYjGEUG0Cn67il0pssZI=;
 b=sMpONPIfhNsXQg0T5iHizWrwPkIcc95YKvoe5tTP9+muhbltr9u/YQKwTKWzVWJwheuR
 OCf1Of7IHXF+YiN20IwVBKCe8xfCzw0iAApV4d+o4Cw33p1S3uVOMLvci36Uftfm064t
 VfJHZUUmXgCmwDoXd5lJHm8ejIK6Tc+IjNIP+fhxxidxtE35AZ8E2nWygGWqHOMztECd
 u9YZEUbOq1cnksIjAO2dAc6JJ7aIUjJGn9Fl7uDYQbx5aD5QOk4X45pqDPFHftJb4GDM
 0y3SUz+9AcCgsfVzwZ/jVmi2oZWpo/YUvuRkHDolmDdR1FOD0b9vjwf6ZbwAakrC3MAE Xg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duvquucaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 13:56:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20SDtoTJ182802;
        Fri, 28 Jan 2022 13:56:24 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by userp3020.oracle.com with ESMTP id 3dv6e4vgfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 13:56:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0tTfSoNrq4eqJ204AuStHQ1D5a/2RgRftsSXhOdsPd3e1ONRFH9ufk3jCa1Yw37VoSSvIo7N++J0uKmrSBLLmMRekR6LgwBCVmpsB2p7wGus72m16cho618yLkmMNDF4BIEaihpguvAHpyrQ4XpVJPkeMRBoXdUBhc5iWFdJDE3xdpjOcYsNsaLDrCQfqVayEw9KIaJJL/fACBpbO07WnixlM7yRcn3/IFmiB2SG5Q8DRWAixulWdBCNOAoWwLWOiWYVG/BE3NsyfVIQQJwI0OOiC39Y8T9753RiZvw8+u+l0XKl60Csmfgp4G79oT16d27HqejPnYaTq8wjzpvKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x38mMzmZiIroGm8C9GOfdh8bYjGEUG0Cn67il0pssZI=;
 b=bvkn2RbzRuAzb0YE3oPhg5qhCDvDfn4QezCYk8RCW9r+7GpnJn3kdWjzwz6vCKheB7ET611eDRl1vV1HLMgKhT7SvCNTONoskBK1Aa69RX8ygQ6+3HElfYgmQqnurCiQCM/SPr5Qb1VVElt1PpJgV2H2rKIM7pygh45PTXaANI0Hgl505oaawa8OODWmQqSIClWVrOTKzXZHEYLEOn8akLLr82GBxWrWgQnddgmM8hdbq2b+mrAMvqJZepEj9vStfIfvnoQs85UuKCoauTBEtuhhwSSmDwtHRXToMFJbJZXH/0vXwDttGjZf2I/VPiK85eV3LQhcM4BCF9wp66KjoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x38mMzmZiIroGm8C9GOfdh8bYjGEUG0Cn67il0pssZI=;
 b=G7KV1PsbTpHNIjpLzVcmYe8ijjbgWmU8dYEPEVgaYolSWsseiwl4mtsFnNm48FmsBdVB/zykLfSSfjpzPqscx43n6DjCZ3/KQFs8sCfBm5YC2kjp9jO0OGK5Zl/l1uEutke93Sst3F2RtVKGvMTIgxKMK+QTkx5NsQezhxoEIPo=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BYAPR10MB3736.namprd10.prod.outlook.com
 (2603:10b6:a03:121::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 13:56:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 13:56:22 +0000
Date:   Fri, 28 Jan 2022 16:56:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Li-hao Kuo <lhjeff911@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] spi: sunplus-sp7021: Unlock on error path
Message-ID: <20220128135611.GA29554@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0042.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::11) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2ebdb92-b74a-4679-b278-08d9e265f74e
X-MS-TrafficTypeDiagnostic: BYAPR10MB3736:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB37362D404645BAB1A3249F258E229@BYAPR10MB3736.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SCgYj3A+lUVuuzECysLTuzeXTxw6hQC8ss2BM+hqpeAhru5/f/MdlUZ9COJz7ah4mRLH4AQXtLT5X2tJy2XPShkpDkqbAnnhn790+rBcCmvc99y0gquaDdoxcxX7AuY26D9TEvbhFYO3X5Bh6qpf3tnFaXYJEvCfn/RwyrVLI4Nss6AXuGH6m5nqV1v80r/tmND9nPHIbAh8YF3LE3Yzi4MJqIecVFop2A0JBbQAESyZ5igM26KhzzVwol6lc8cMun82qRQLT7C9SDhu8Zn7O8WWFyrG0BZgDHG4rBli1O7S8BwfOxgrH0ZGBxbCAU+3JcPM0sSX3PTEU2CPljH6/xfolitORynnGUULGTkq82gLaXwZlo+JCODe7NUJcUu8em/7+2lsu8/8z342D2mR4z/TbzoPgceoWKKhp5oFKIXBgjNzZHmUMN40Ak47ZzmWKEr9GxywoC12fmIBAh66puBERG2E2Y99egx/Uv6+ZUobwsBkGgrM9CydWhra/Ajtkrco56npztH+C2FFCAUtakbY255JsYQePaDGOmD7r/2eQokYpcZt6UbnoqjwUuKTJZbO8TZq9A/Aj81a2Zchclt38OZHoxHr8MvnjkxSSjG21nIxI28+4gOwUxV0uSJGDbEfOAteKoMoRItFckTi5+CBWuGPPmPgA8P2pWpoBd+OybWqvvhC8jynDSpnYzbBTOaG0hcMZ3BchoprS15pmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66556008)(6486002)(66476007)(508600001)(5660300002)(9686003)(8676002)(6512007)(66946007)(52116002)(4326008)(6506007)(8936002)(6666004)(44832011)(4744005)(33716001)(6916009)(33656002)(83380400001)(38100700002)(86362001)(38350700002)(2906002)(26005)(186003)(1076003)(316002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UkydgMuhy7vTGcYoQ0Mdk3CK3ph+zsx3nOCKweoMfJ40COEFN4tPY+QZJeei?=
 =?us-ascii?Q?moOb/f/gft3HtQxKjVBeN0+2aqdNNctO9jvZJpML98JJGZ8VHsim0L1j6yc6?=
 =?us-ascii?Q?r4d0EYUsP/Tmy9E7vHT/Oe9pz/Pf4dpCDo0gkphG1rh5aYCdziuLw90vRdBh?=
 =?us-ascii?Q?uGKik33hp7nW4FBeOiuHw2jX+ljUL2a5mKSk2K8JFv13uCfIzwbmmsN/dtMp?=
 =?us-ascii?Q?QSXOyRs5rYPIGzXjO6NEKaqSdZgp3mkoD/Fr/Y0WE15LuuEg6GPmvTQOLCvF?=
 =?us-ascii?Q?6Gd56+CxwEpxqTIVcEkIKFRm0BkSpadaVcz1vIc1y+3JGzGqU/AhUAVKBBjd?=
 =?us-ascii?Q?NbLaNKoRHubkBibvmItzaHCC5UZZO+dDTwREfhHiPu18iAS4eH6h/+tJAE5w?=
 =?us-ascii?Q?Y/O1+/ivuIa+CPBXZAajv7IM7hYxN5HxkhcPeq5kNXLCAkp/BeDCrkDUC7QU?=
 =?us-ascii?Q?UxnCEU2HFd4dbkrlxWVaiGaw77a2Fq70D1fjVNnzbeJDWMynd+9DTQaDpJG4?=
 =?us-ascii?Q?7vCZfFz/NISyqXcLeULlCDAOCzXM/HXmPG31/9injMYESyFIf29yu+Dgltto?=
 =?us-ascii?Q?lD2pdwmcTEESVhLJ0FW7LJKsUKfdGfmGG+vUHifxl8zrBPPaQVce+YuVGwA8?=
 =?us-ascii?Q?5bK0oxCTbjq6UOCsbHms9OV1sgh3UXNyCNyw0vlJO2mtApRW3TJsITAySmXN?=
 =?us-ascii?Q?BQNc2xsg/N2z6ghCVFqAbYcsLlKa3Fm0FrGLkihrdGS2NOpVpu+QANE/Dgll?=
 =?us-ascii?Q?DKBUqDvEMHNNBFs4YKMBD63ZotipaTLc2VT3UnnDLNMyxmzWDh/ZM+rn7N06?=
 =?us-ascii?Q?SVaporPV6ndMMpQ3QV38xpgyJnseV0VvJVmSvbR0h7uqLvrJDdEvs/kQNyNS?=
 =?us-ascii?Q?8bo5Y9E6dO7eXmBUrvlK3EMT6MigtzfdaZ/J5N4EW3gn2CGEv1Elqw0jn7ei?=
 =?us-ascii?Q?XfJ23j4i8cVsDC4jNfvurEUFYuU+2auWe7OFdvWn+9zVM7Z8K6ggTdTiWOAB?=
 =?us-ascii?Q?bm4BGQDfQhkXzFSZIxgHJcQyXfZcPi/IR2Jn3GcoFHFGKERb8S830VjoD9if?=
 =?us-ascii?Q?J3MwH/0IHe072Rb0ECwZSIIMcr0kIIYKlLaq4s21kiHgp2y75phHro1GsufG?=
 =?us-ascii?Q?EGU5xfkYdlqYvQg6d60axXrfi+/NX32fSOc4RrFlJ1C7Dkz4GXCEUPeP3vKx?=
 =?us-ascii?Q?2Rrvztom+zg8zGl95el258bEPHAEnBDMZnPrfPmT04Qrs8w+ohKFcofo7gip?=
 =?us-ascii?Q?uWrQ4Le43W+aRhowdRePod1JxXCN/KD7+2I6QiMRh+maINaCrfnycVJCzwsB?=
 =?us-ascii?Q?8qIOl8YRm5v6/8i1nKDbkc81C6N3z8OGncg7dFg8HSlTMSk7acfYTC8swun0?=
 =?us-ascii?Q?Te7fUADxpmFCBAaY8noNHVFsLvjEsexInAaPr2HLvxdC+VZQq8DoEGab3wv9?=
 =?us-ascii?Q?PwGZaCBPIBXFTM0FI6I6vkWNImdO9IdpRzp25xENtYflAddWIQdKI+54UuDV?=
 =?us-ascii?Q?LVQbuW3I1z+qLpVHFEztX+v63gA1f4pwnrMF1m1XGU6Obvgnu9mpV5DLaQN+?=
 =?us-ascii?Q?X0pJJhzcEFH90Bz/8ogD/WREXjiHs6ATUqby8hJBYBF+sQED9Cpn8ggQ0ELJ?=
 =?us-ascii?Q?cllIg+Oht8rw3k1ErOqrXFy7QtzlzNNLtnqYQnXymb+xCyONQL4lr9l4Jvtt?=
 =?us-ascii?Q?O9MBq5R2IakEwPo7oGSeH94fdTk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ebdb92-b74a-4679-b278-08d9e265f74e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 13:56:21.9589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VRIAwrUrffcNWz39twXinnHiyvD93nIU5yBM7XXRCn99YjTED/h/Y18hucUTqHgo96PYWWiBQ3HJIsZ4RqaVgywa7ljQhB/SfYHGZ7XASEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3736
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10240 signatures=669575
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280089
X-Proofpoint-GUID: 7KwvOpHgHfU4NlZd5VCV-MA8BGquI_M9
X-Proofpoint-ORIG-GUID: 7KwvOpHgHfU4NlZd5VCV-MA8BGquI_M9
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Drop the "pspim->buf_lock" before returning on this error path.

Fixes: f62ca4e2a863 ("spi: Add spi driver for Sunplus SP7021")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/spi/spi-sunplus-sp7021.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-sunplus-sp7021.c b/drivers/spi/spi-sunplus-sp7021.c
index 627b9c3024e9..cbbb1664017e 100644
--- a/drivers/spi/spi-sunplus-sp7021.c
+++ b/drivers/spi/spi-sunplus-sp7021.c
@@ -351,6 +351,7 @@ static int sp7021_spi_master_transfer_one(struct spi_controller *ctlr, struct sp
 
 		if (!wait_for_completion_interruptible_timeout(&pspim->isr_done, timeout)) {
 			dev_err(&spi->dev, "wait_for_completion err\n");
+			mutex_unlock(&pspim->buf_lock);
 			return -ETIMEDOUT;
 		}
 
-- 
2.20.1

