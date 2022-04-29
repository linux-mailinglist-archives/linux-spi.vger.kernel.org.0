Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF13515278
	for <lists+linux-spi@lfdr.de>; Fri, 29 Apr 2022 19:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379327AbiD2Rpl (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 29 Apr 2022 13:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357665AbiD2Rpk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 29 Apr 2022 13:45:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73EDA939A3;
        Fri, 29 Apr 2022 10:42:20 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23THPWqp018608;
        Fri, 29 Apr 2022 17:42:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=8x338saWQSdA1UydheMJ00f+qNZ6OWiVBPt8zZlM2yY=;
 b=t+z3m2j7dKEUeyNe6YfjKBGegqc7Mgwc3XTL+gReIrgpcNckPwBahlf8amLMlRaF7a30
 tIbSXKjuz5sFeE9RauzU8AXqMFIRXMLY0kBc5Jsyyucmbi9H4WU5tdd7P5Sd8kT+ud38
 eCtBcQlun3NMWWxmevoxGvIV0cJTZT5sBtJmBcCwvNCol6ep1uuNAli2bAErRRVzeJCr
 e9Nc595MHdMmQegP/PsXg4rXf2T47um/iYMK9vKSpTCs6ULDKbWDWK1LxPW9FhxOLH5F
 Wyd+nCdvVBdgIb1Mt+X+RlPLH5v+TGqW7nx8f8m5vO7QnRiZUUMo6dR+G7n7ylhf7cgz oA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5k7g2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 17:42:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23THafIu011824;
        Fri, 29 Apr 2022 17:42:10 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yqeg4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 17:42:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/zF7ZBuaTNGwDf5d36q5LvWTKHQnzjhLBZN9krSpRHrbJRdpcDPN4VAHe1042pw0qJ2n8J4zpk/mUu8StBpJhD4cnWb5uIUxlc9TWfwd7Gn0XayR0y4MEN8ssFRnhGAa4m/HmKkl/eLrvKz4JWogqiuDyNeEyc52sUps/dXLM8t/hJTvQ7JAPO7Km2lq5r5Dg+c472noHtNdGR3eCXGZMT1TmSc9QXWnOopi12///t0ZDYQXWyUtItygYWwIsogGXvVcBlJk7pkzqu6O9+OK4pWGNhGCvD+AOMBXbaNjyO2l+/4OXg67D/gjXo7cmk6wslCyne0WrMc73WR8RSKvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8x338saWQSdA1UydheMJ00f+qNZ6OWiVBPt8zZlM2yY=;
 b=dMTzI20LdmpJ4L4Xucrz9teydBOwWRfCcnfZR1sknRJYNUYDPhVMeEx6bNXG+sBzOi7piJVS7O70SAc0pjmSGhrvVsQG0GTXX4nMIXR1pDMrqFCcWFF5sa0Tp2VaUs0Of8DtSuJJfNJQFSDQukl8Hedh7mPPu2nsi33gmEcsVWwXh4llfDKz8NIhnznLVYPWk70U6+zXkG+wkE+DHRTrA2ELHehjM/J2ug2NMOb8wNxWAPYKNYOpcvU2wMrpla4hUOMenmmT0vdgHG1vzKjttBSnAUowBDeVHIslSM8y13BML/TcnF7HftWlp+LLIsEYa8SpWWYAIZ/hQcQ/ecxObQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8x338saWQSdA1UydheMJ00f+qNZ6OWiVBPt8zZlM2yY=;
 b=zvoIhHqmj3yki7xL319QsNif86VQEn1BVQSwZFeDP3dfozGfRnm398K1j6nribji/imWpr3RKLj6dYvxmv6D+jlxjURh1owdRocV9gNdTtqtnosoIfHjVgptOPU2oT7ZnJbkJz8SW7PgrLGb1F5fRMH7upVtQEifHGAG11tJ0z0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SA2PR10MB4537.namprd10.prod.outlook.com
 (2603:10b6:806:116::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 17:42:08 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b5d5:7b39:ca2d:1b87%5]) with mapi id 15.20.5164.025; Fri, 29 Apr 2022
 17:42:08 +0000
Date:   Fri, 29 Apr 2022 20:41:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mark Brown <broonie@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chuanhong Guo <gch981213@gmail.com>, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] spi: mtk-snfi: preserve dma_mapping_error() error codes
Message-ID: <YmwjUcTKyQNrrn2g@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0143.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::22) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32708fe6-39a6-4dee-ca70-08da2a0794dc
X-MS-TrafficTypeDiagnostic: SA2PR10MB4537:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB45379F8A36184910DCC512C88EFC9@SA2PR10MB4537.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kuhCLFo3nJGxPw57QAhbUksKKR9JhrjyuzGqwK+0tNSBkjT3Lp9srl/eGtCyeAVuZ/KQINv/U1qiGGmXK6w+dATmk8CTxs6GzJQmK92+9oyyYXwC1y2mrVPZJbyP80OsB5IeDGhRr04r4JscJNl6w+n9IVL6JEN6zh6A1oGZ9un22qS5Wf7N/zEy3o9PUeCaCFF91JIRo3TkI8hAy0Ll8qDFb5IHEwrCY/8STaGueFObkw2j5c/2IzEVyJqQ3ZdiNRTr5LqaQOaKwiLclxIMZAzs2J02pY56QneSa1opVPOaUyNUqabiwZgGK9K8pEkO0c0nwrU3C2BXHreGZl3HKRYLUwMZ+Lg3NUh9iV1rQGHTG0ALx0V0HIi5yrtadHSoFZknmM3f/Ylw1RAPKD/uwIJTKJqaHNxQHw8aJDK+YnsDRWjUZjy2Rnuo9RypYxwZH7Q774ZwaHUu7WNdrP3JAOEHLcQAkySko6P3rBMKT2hORz3yb8ucMKySv0Bc1OrlEjmbOi4n9988QU3LXrt3r/hovLEVwjo/9B1XJIzCg2Z5StP2tqSNr/HGPJG9yfbVCHcmMCVEc3jgkt+qRPHxwdgCYgwz84o2VZ5/k4Th9AOecV63HaAdusjEUrfCek72s8e0lhPc/vd1j8d57+h1iuk7cqL9jowNOWHkhu464zCYnpX0j8snT9c/MWV5e/xrSXC5deHawxoH9VaKcfYpkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(186003)(5660300002)(52116002)(66946007)(66556008)(33716001)(316002)(66476007)(44832011)(2906002)(83380400001)(8676002)(4326008)(8936002)(110136005)(54906003)(6486002)(86362001)(508600001)(38350700002)(38100700002)(6666004)(9686003)(6512007)(26005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PdEKLIusnP3T5sAH4g48ZlrkMSyjICkC3O/CRtvybQrmJe/uHogKTx2AoJ2A?=
 =?us-ascii?Q?mYh1RBxukqXZ9YIF36ehvQqcqN42Lj9q9DD2LkCJSyTneSiAekVh+tpZxvKy?=
 =?us-ascii?Q?aOzO3B9m8sx5QOotnwSNW/Yo6VUJref4aUHDLWIcO8JoAVZtwXWlhK9gZiEh?=
 =?us-ascii?Q?ueS+sZPN6pUEvcalrd55rxPiphiFm6gethhFMOhb+aHImDsa8gaskWzMTcAJ?=
 =?us-ascii?Q?kgv1lgdkhEhMP3itp2815YR4tWBgVQ8rL5388vNr/8iZj8IZfX0tMJUxSdAm?=
 =?us-ascii?Q?IZXrmuQIavBg0ctCrrrlXGDC1UPYVa4ij1qJX4XizL0Msu+XbfRJROU9wxkR?=
 =?us-ascii?Q?qP9XIPe57xCditnvZXw7FrPIMLZrmlwS0ug1Q1bJPRD1Tw3KYQs01GI0tHf+?=
 =?us-ascii?Q?HtW6wvVAOafH3k7LPEqwi/7QRu4rS3yzutEbgYa2/hH8WDPG/DN+QgoRirqk?=
 =?us-ascii?Q?vpL41BsFxg8nJoL0GVlD9ajE42kUTqB25fA7yvCupCws9F/T5MQ2FMO67V1q?=
 =?us-ascii?Q?WXtVNv7mX7mJf474vY6tikd9g9gOkOdTtKnittqhnVykFicmglyzUyxLMUeB?=
 =?us-ascii?Q?hYqhGxVu5/tdfu2nue50H/J510NfgqMaGbq15Dus0rJie94wuvBusMea6IIE?=
 =?us-ascii?Q?x6bV0IYdEE03+uip6kbKtGBtD5rpENASAyYcthnGZDqSzKBHo+7hCQGDB4yw?=
 =?us-ascii?Q?+9LxIfC9gu4L86kVirJHFxupvZsVaKAs4VMocPv6efh4zcjhS3g/M0ArUKI5?=
 =?us-ascii?Q?JAiGk15jMpDdgAVG8nhGNFeZQLsjbg5bnAE8GBaGGWihlvgzPhhBUuQiaRu+?=
 =?us-ascii?Q?t89dC34EU/J09WWXiW3JVc+U2sdqos0dOB/Jjm5mUA91q+jLxHQ6D/zLClxy?=
 =?us-ascii?Q?X/FD1RZ0uuou+bCrstaHRwGBfdKJqgYWYD+ixlbWSwHOFdUHng1f2UAix64L?=
 =?us-ascii?Q?OHQyC8eqZsloNrXW/i66HUVDTntRcZ6aM9RdDFTY5eJ1ZSCUzoVvXic5U/YB?=
 =?us-ascii?Q?dIzw/dd48y3DlkTX/z0/1lhE/Bkkmj1Vi7CU/LNT20ok42gDhAUWdK3yQVZ6?=
 =?us-ascii?Q?j6lubfmDuoBF3ZDwYVDHCl7vjTM0y1AbZ8nTLoMRJkS3DJZGae7TPKxUYjkh?=
 =?us-ascii?Q?LC+9gxEpzEH02myUzgNncyXXD0sFg+nNHz3EvKIuu6qfRaAOGzUNxwnkaT3G?=
 =?us-ascii?Q?IGkHzDGoV6vbMUV92GnJ4c9MUO8eIYUDAWQhXYrAyG667S+BpuxEk7bOFg09?=
 =?us-ascii?Q?TIuzaDE3zE8o6eGJMDurWVvW3Li9JXBbDg17MT6nhHWiysSPypbTAPkM2w+1?=
 =?us-ascii?Q?Hk+IckjTAspEnPDfEGaCVGHuxlI7bzRkMOSc1oSv3wZjQHY0IryLLXoVHDCQ?=
 =?us-ascii?Q?yvgctBcxQg4LHIleFDfkcYWt9d3q0iXG21TaOSmWn9E3Rty93QVM17yVuta1?=
 =?us-ascii?Q?xOrSrHdIX9Bvcfqk6knPPdqxTqRxqRqTeihJ6he+ewqd9nl2ha0l5ab90BL+?=
 =?us-ascii?Q?TMCnlPn+uaTvNh+zjEEj8gQIw4poH1pAnNh66f2/alXGDqBdVrd0jv33ZVTE?=
 =?us-ascii?Q?fIjZ0PhqAaueXX5caSPsXQWxqs91/KfV0gqzXzk5FUu28WpkJ7vUzhW3Q6JX?=
 =?us-ascii?Q?iSCqQzsq7yd5gFyNAK0F2/VrVAUEKNpgivrhuTsQ0dPlWdK+FZrVwkPq6MHc?=
 =?us-ascii?Q?v65snYzJ+Sse3DpdzJj9zkjolOBTpy3y4AN3553nRED58+f+aennEvLVtDSU?=
 =?us-ascii?Q?epy9b4LyFYX+OzvSzCuyylBAilBzKM8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32708fe6-39a6-4dee-ca70-08da2a0794dc
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:42:08.2762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GFdPIZte4d521ted9jE7x0qktzokNLZ2Pf6fu1QbNG+oTeCBNgjnnlA0MBUvIy5QOhUDqHd+9rF9v++7y607199Rg3/c1wwmVOx6NtTnrSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4537
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-29_06:2022-04-28,2022-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204290088
X-Proofpoint-GUID: DtzalwjGD2wQjqjluj1rxwUnY-uObKzZ
X-Proofpoint-ORIG-GUID: DtzalwjGD2wQjqjluj1rxwUnY-uObKzZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Return -ENOMEM of there is a dma mapping error.  Do not return success.

Fixes: 764f1b748164 ("spi: add driver for MTK SPI NAND Flash Interface")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/spi/spi-mtk-snfi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mtk-snfi.c b/drivers/spi/spi-mtk-snfi.c
index 2c556e304673..d66bf9762557 100644
--- a/drivers/spi/spi-mtk-snfi.c
+++ b/drivers/spi/spi-mtk-snfi.c
@@ -903,7 +903,8 @@ static int mtk_snand_read_page_cache(struct mtk_snand *snf,
 	nfi_write32(snf, NFI_CON, (snf->nfi_cfg.nsectors << CON_SEC_NUM_S));
 
 	buf_dma = dma_map_single(snf->dev, buf, dma_len, DMA_FROM_DEVICE);
-	if (dma_mapping_error(snf->dev, buf_dma)) {
+	ret = dma_mapping_error(snf->dev, buf_dma);
+	if (ret) {
 		dev_err(snf->dev, "DMA mapping failed.\n");
 		goto cleanup;
 	}
@@ -1092,7 +1093,8 @@ static int mtk_snand_write_page_cache(struct mtk_snand *snf,
 
 	nfi_write32(snf, NFI_CON, (snf->nfi_cfg.nsectors << CON_SEC_NUM_S));
 	buf_dma = dma_map_single(snf->dev, snf->buf, dma_len, DMA_TO_DEVICE);
-	if (dma_mapping_error(snf->dev, buf_dma)) {
+	ret = dma_mapping_error(snf->dev, buf_dma);
+	if (ret) {
 		dev_err(snf->dev, "DMA mapping failed.\n");
 		goto cleanup;
 	}
-- 
2.35.1

