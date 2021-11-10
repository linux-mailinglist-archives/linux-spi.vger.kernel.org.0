Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8C844BC34
	for <lists+linux-spi@lfdr.de>; Wed, 10 Nov 2021 08:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbhKJHm7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 10 Nov 2021 02:42:59 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:45698 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229567AbhKJHm6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 10 Nov 2021 02:42:58 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AA6Ba53017928;
        Wed, 10 Nov 2021 07:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=xn0nJ6WFWjsQdSBXEr5Qq1C/ARMMZOCIJnNkIDjhnP0=;
 b=TTAJ2KPVfSKY3w2DXJFkPOkPIYodmI3sr3NzAdSTqCfs8/78LjvxbHn67CchcAR7t6On
 fLQdJkGFJu9H0wvtQP7xahaGtYgpvv5NwhEOPL7eeNxgkIh0G2hyASrhz31QvNa1csRc
 FVGNVjEUW3oX4FVGtWfZ5hYlKEQKvAeW1QlxT8lF4lsQ9LEjoMm3x8kOyYdR7Lyxg8op
 YpQd759k7+4+uoRXrV4BBRawYvpCb6z4t5g/VoCoq34gm7gVcyq9kBJ29YgXjRGqD4Yn
 hesE7K3BlepUSeVZDL7xR4e5LmutRFrW+kG1WTytEvNJrKUNwo2z3HDEBkMsHGJk0fT9 hA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c7yq7b1mj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 07:40:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AA7e3lc021922;
        Wed, 10 Nov 2021 07:40:09 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by aserp3030.oracle.com with ESMTP id 3c5frf7cb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 07:40:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciYGsDaqu1LfaG6VgNwrG6ovgmu4AXz6kqF0j4olS2Ab9asS0626gkirdBCHA5i6kpRfQ/NJGEbqT/nPU7i33L8AN6xIQC8tbNquHazqYROpGOEqIIetOrtv2k6deE02kbq4icg65GhgSRsLXmSEewvSRFGlHBRsqEaz2M3G/Jqm5F28AFS/1neZZV+kY6UEQjXR4aLsUKnPMBDV9Lmg2MXIxAE+8fI2Yi7mPj5dfn9bfVSVH0FMNdruH2O1Mo8eWTPWlSu1a3/foK8XDlzCfBh6doyEeWdGIWgs2PHWi3uSqRrSaUw1ndqCYF/rkNTa6yuGolEdW+GJv6P/h8NKAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xn0nJ6WFWjsQdSBXEr5Qq1C/ARMMZOCIJnNkIDjhnP0=;
 b=XwNyFDMck/2e0Z0WD8haF7/JFa4tEO4KTN6DLgXfjamlv12XU06s73n/VAs0yxsbeQV/vm3ueZSWBjq4S/tWGmMnPPeoPWem7XXNeFefkZVP9ga8pdCYOSdiYBz0rL2OfiSbXpbs+Qcb8kK4wPea6TwcMB7SSp33UNK2PfjvSacytlXoq9xGyWT6lHVPto/JgYol9opAFffRRI+UGOH+F1l6/6nte1vCKv/gJ46w8x+5VRm+n7MIIB2wcRhfHHmcUHS8UnecY4wnvSfS6qZAFUuT8XL+eCDE9psKsfgq0Ff/kmnPHMIJhVjzh3yuQIt+UNmDGvCq5SZd0acDqPisjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xn0nJ6WFWjsQdSBXEr5Qq1C/ARMMZOCIJnNkIDjhnP0=;
 b=gB6CUhtg8voHA+yXh5xUUBrE6RpFtW7IFJFx5w7lR6Zu2McHECmgWaRNzXbsazxA8Da4dq9yezfFOjjDcuA6HT11//SUxnCSt5xN7/S2WZXMCeKcDMdREDe3Xb5Gp2kUYkl404OhnAQOrdbsCFhZbDoEjE5MKiyT4vDgezNlI5k=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4547.namprd10.prod.outlook.com
 (2603:10b6:303:96::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Wed, 10 Nov
 2021 07:40:07 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.016; Wed, 10 Nov 2021
 07:40:07 +0000
Date:   Wed, 10 Nov 2021 10:39:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] spi: spi-geni-qcom: fix error handling in
 spi_geni_grab_gpi_chan()
Message-ID: <20211110073935.GA5176@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0094.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::9) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by ZR0P278CA0094.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:23::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Wed, 10 Nov 2021 07:39:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b611d75-4c5c-4d92-f790-08d9a41d5103
X-MS-TrafficTypeDiagnostic: CO1PR10MB4547:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4547E2FF1302F55E5C47BAD58E939@CO1PR10MB4547.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1O8mkjD3Mv7E0uGGMXiTU4mDX7ChR2gz7he+0KD4VREEvT1HtrKk7JtQkg2jZvYMGsIFtijtoXkoCEnV8o16IAISpqU5IlUIRhkaQw8Rs0sgzvCJ35XlAIwN0ui5yHoJQjEdoBei77zdveNca3UnaZcHm+JlC/tubLwpxyau0vZCURdtophSbQqNB0aq8tWjImskhrnMWrcdYaVhHvgCqlkOepk8l7mf8BiOCBXxqrMDR5kss6Fla5GKVNKoeoUolu65xxRJMtWnHArwSyc9vJXHzZbkEIhdEZiGdrNaMxDcrggWd9oQNk80BA4VdL8nTBiOkxEy3hjIaDQ7FUXn4bLaPHntrifS+b5TXDYuusEYv3cA0CtxIjNSQpMQem4XfXWnwm6W/GIl6ahG5Ivnc+/1lbsp1t/+Qp71WkorsloGMS5t+PKemvE67N0hZbbglFgRiDdnaOBkBAAAFi1M6oRmPIun59uJP1X5eNO3OPdfTq4yPBuSh8rN91fchQS6ckQVajCRAOrSzVKaAJZbpbpboOp3VbsA3LXg5g6/r/ARxJH8l6eKeoDV0LNSJtqkgHfeKUX57jWDk6ZCnSksMfv3YwzNuK+eeLk592F1R7x+b8Z1DbAbOiuuV+lGW08e7LQlk8ewbm2i8RDjyYA9HFyLPjTLbxs5of/KkC+yE3AnqH1Nf3eubipX8UQbwfXqY+9f3YZ1/gSvPFylXs5YvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(1076003)(66946007)(54906003)(508600001)(44832011)(38100700002)(186003)(4326008)(38350700002)(33716001)(2906002)(8936002)(9686003)(66556008)(66476007)(316002)(86362001)(26005)(83380400001)(9576002)(55016002)(6666004)(8676002)(956004)(52116002)(6496006)(5660300002)(33656002)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LR3UMwGbiVAdke4LBtUSVwcHRO+E7hlocNEIjBAB4L81GPVBt2dY1vQs5CMK?=
 =?us-ascii?Q?t+IFt4rXROLO1kse0M/BGh26uil8T//kZXCaKX+sweO6JyeSsB93x0L5TPi5?=
 =?us-ascii?Q?U/Fw3Ya2ErW2BkMkWZRM2GPq3Rd03Ikvxv11zJLgZ5jg5DvzYnSN9HqQ12lE?=
 =?us-ascii?Q?X39vjIWb3sfKuyxDtuda/pmWkp5tgia130CshR8RqVp3dWYWbOmN5RxyQZq+?=
 =?us-ascii?Q?Q8xqzhMhRridHD4PlB+pBD/Hd30IIhaTG1J8KDGOWBG1jXWFks4mD6Zz50yT?=
 =?us-ascii?Q?RJyNcHzaQdgashkLXyyKjTB4MuJldmoBleGrbF6qo8RQ7RA113XFyIjPR95n?=
 =?us-ascii?Q?LN88Bhpq0/7orA/OBq8yqOd/0HmyZiSc8qoqwALFAkYkQsHOmVU3+HV0HS5u?=
 =?us-ascii?Q?FLr0MH8nA76vlj9yxFYzqJKagliKs3K48EfNDA38qYy13uL7frACNcii+rTQ?=
 =?us-ascii?Q?ZFzxzF8wUv2JSrvB21LZlUj5/XbIU9kCwaJ5/XCiOEnGVOEADTPp43wjjHwk?=
 =?us-ascii?Q?QpWuM9U7EopmxLNay1xKm0PJaZOxc3OspB3eQN7CMc5jaJeM6z6n6u1UY757?=
 =?us-ascii?Q?7zMsbvQ/NYjChGmgAN6bR9yguktRIxzVSUVPPk3U9CyclqKiQLLSXK69voJ9?=
 =?us-ascii?Q?5Zjjcs91sTC0BmmcLCGzhJaD4HB1coHn3VNYmLpGAFbelTApkU49bBFMBVkw?=
 =?us-ascii?Q?fwD9iWmUkgj2/wGNCXehIsZoSmKoZhlnSs+lHnfxeANRDO+HLpZpC0MItyvc?=
 =?us-ascii?Q?T2xh9G6m+wzXigsB7R8nFPAVICmhaTGfcYJAbuuF7AVwHc9gppxXa0yls4M7?=
 =?us-ascii?Q?fQode2/Ex3yEh456gba7tLzcIj3JdYb17QBxFGjiDZyc4SH6OVI98+Nm4WDZ?=
 =?us-ascii?Q?oYGryso+97ZrQqqvHokOMxBBXU+IWF7n2kgaqF3TyNrStDLjPLbq22TkyBP9?=
 =?us-ascii?Q?c6lutLSJKZt5zsLEdm+MPBecw0RLjttKhBuYLalLSNlNklVxVm2mzFoU+snx?=
 =?us-ascii?Q?HT+PCL1Z8DSu+KXAqUCCW6xD9CGbQetKglqVuB6GnUW0CIQI0XZu71qMLBfL?=
 =?us-ascii?Q?KcpzyUdFZ9ovPLefsz46fTfA5bGO4XqLE08BVsQyP1FgWeGpzGnYOBhZ1crV?=
 =?us-ascii?Q?WR8XVVXn7PQPXcLdkEd6gFQ2K2RK3+Pm4mvV84PJqXduB3C1LSPHD3eNMH7n?=
 =?us-ascii?Q?vqbFQfOZotMpAY9jCEabT/Wl4q+dHH28Q+5L1QHpF4MSjwQp3PfIPBoNwpDb?=
 =?us-ascii?Q?Cv2ZhCSFjMDBLhB8GjMrTjFWhISidw6qT71ndz/Oti/EphNRM33FOpq8iNCd?=
 =?us-ascii?Q?jJrRK//I4Nh1HD7A2YDXsQwEWOYys2Wc4DEmpy5BzYSKbfGKttCG4qXvn5KO?=
 =?us-ascii?Q?yMVoTeHl0lF1S66IIKrk4h/s0dCliqIq22hdHzqWGDBS2ZzVhsSgCrAofRAY?=
 =?us-ascii?Q?7OvS/X6NjhAgPzRhZzxWGadn3JQVS8z1F+f8AZXI1FsNbKlOOQkQZxqba6fp?=
 =?us-ascii?Q?CgujNUEwgfG9o/GD7lcbbRFJ/pZPfNmWSHXZf25Y4i2IPOwKfT0Pl9HaTVVn?=
 =?us-ascii?Q?4iFLGJudrkP8TmiA4K5xyZTSXeiGnt+S8EQ1I8FzgdVydNBX10AaA/zpDLzx?=
 =?us-ascii?Q?xMyYDSoriXchJTpIkU69qtdRvVMwMmVbOR7XMTtPtQRW73LxiYuWSQxBQlsR?=
 =?us-ascii?Q?RdgrnQTvMxpgwUZWzJvRy09KDBk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b611d75-4c5c-4d92-f790-08d9a41d5103
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 07:40:07.3784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +kILZdQh4slhdNtdrQuUx0HRQfHZ8oAw0P25BGBg5JiHD3hSbzKRR+Ip8os3bWW37XwUfUxl2RpCBlzRRzbZ488NcZxm6rmMVxxpUEnVqVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4547
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10163 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111100040
X-Proofpoint-GUID: XWCzqVli_jdQriWmXQu_nYU1bZNT2tLz
X-Proofpoint-ORIG-GUID: XWCzqVli_jdQriWmXQu_nYU1bZNT2tLz
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This code has several issues:
1) It passes IS_ERR() to dev_err_probe() instead of PTR_ERR().
2) It always prints an error message, even when it succeeds.
3) The "if (ret < 0) {" conditions are never true.
4) If requesting "mas->tx" fails then it sets "mas->rx" to NULL but the
   intention was to set "mas->tx" to NULL.

Fixes: b59c122484ec ("spi: spi-geni-qcom: Add support for GPI dma")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/spi/spi-geni-qcom.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 27a446faf143..e2affaee4e76 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -491,22 +491,26 @@ static int spi_geni_grab_gpi_chan(struct spi_geni_master *mas)
 	int ret;
 
 	mas->tx = dma_request_chan(mas->dev, "tx");
-	ret = dev_err_probe(mas->dev, IS_ERR(mas->tx), "Failed to get tx DMA ch\n");
-	if (ret < 0)
+	if (IS_ERR(mas->tx)) {
+		ret = dev_err_probe(mas->dev, PTR_ERR(mas->tx),
+				    "Failed to get tx DMA ch\n");
 		goto err_tx;
+	}
 
 	mas->rx = dma_request_chan(mas->dev, "rx");
-	ret = dev_err_probe(mas->dev, IS_ERR(mas->rx), "Failed to get rx DMA ch\n");
-	if (ret < 0)
+	if (IS_ERR(mas->rx)) {
+		ret = dev_err_probe(mas->dev, PTR_ERR(mas->rx),
+				    "Failed to get rx DMA ch\n");
 		goto err_rx;
+	}
 
 	return 0;
 
 err_rx:
+	mas->rx = NULL;
 	dma_release_channel(mas->tx);
-	mas->tx = NULL;
 err_tx:
-	mas->rx = NULL;
+	mas->tx = NULL;
 	return ret;
 }
 
-- 
2.20.1

