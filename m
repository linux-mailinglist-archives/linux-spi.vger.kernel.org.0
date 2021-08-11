Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6183E8B62
	for <lists+linux-spi@lfdr.de>; Wed, 11 Aug 2021 10:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbhHKIBc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 11 Aug 2021 04:01:32 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:24040 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236167AbhHKIBJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 11 Aug 2021 04:01:09 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17B80ZsE024462;
        Wed, 11 Aug 2021 08:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=57j+zFCoeeGKDYqrEjk8lXoiBkaJ0T009EpqnstvlgM=;
 b=kS42ZPEXqicLUegJTBmDXDJktEZhU8hrhoBzWmuXjoJrNoAFqoGNkjmnh2hRCNhu0dab
 hKP/tZd5nHh4wLF7vqAy1KmVHZIlWaKFH3ny+4xwQ/ziMfe2PNXFZDNpPZlBGuGPxngB
 VjmRvRCr4Rr9tUZ46BuRNM+6irscXz7gzr88zjTqcu33EnAxvMrEG4V2u3+Vfivbm9G3
 esg7zlGjiugfsLiLSh2TFffl3lWsHdyQipbzBAzzdsi8iymWHnYKs1J9IaLAXTtKP32b
 V4AsjH2ieXjVCZDpsHhK6OoKTG3gqMgTb+YTO45IFjNR1oZBeKTDWD1GQD6feFtxwK8d VQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=57j+zFCoeeGKDYqrEjk8lXoiBkaJ0T009EpqnstvlgM=;
 b=kE5S6c23u1zMQLDY12eTpuMsPqXDY3tvASYODcPKXnyOdW1GHW6ekQ3yKSoqxmp6f7UF
 tSml9b+EWb/OxaOzcIwPdkDh9N4iXTBSNO+AVq+AGsiN3OVNFq541ydo63tWDC7sCDun
 1h7lrQz8z1cNIP4y4d/2+tY7MsszGrzIpfoI2FAJ4xbZoHER/opCbu3P67c4haEB1bfs
 HWRscFdEuQEl4UslVSO4cwstqANZxuFTFL1qeAJ6878eoxTrKnEa8is4DFtz2P1imSVT
 jLDAL1O3qSMJ5oGzaHFR2CbQDYVhtX4gl/AFgg0mm59Ubowy081YQTVfyekJ4CcZ2Uxw kg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3abt44a03g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 08:00:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17B80YKQ087853;
        Wed, 11 Aug 2021 08:00:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by aserp3030.oracle.com with ESMTP id 3abx3v9hwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Aug 2021 08:00:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cFgKT3//GLffgIFWrlpN9tNvzaWam3gDwhgEMGAT/fKoxUOTPYkyCio+jNapj1G+0FOvjn6lGeZqFRU/2PyJ3PB1OjubhT/4W00ttA4tb4EvHN+XRtQiwQQvcAtqbJSptjrz4B7xn1vpiLbiMlbyW5tsgirP1gTipSg9vz2j+PrnldFOnia8iFJzKxJH39Hbr44gB1fO33a17HIGZoJ1D2t3DdNfaVgnLRPmdh92nHH8N+gfmfyxZAPDX4VApaCi08A7Yp9ouiWVu3HyTP6VrEmzViQ54UCvkPAypexerXcNqT96vvXG7npykTYDyDmsn6Y+sT/TBky96191+Fup4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57j+zFCoeeGKDYqrEjk8lXoiBkaJ0T009EpqnstvlgM=;
 b=TBnQ/DmfOdFrwxjra/gVb7uLm9L5RoBiXGujN2HZaep7NzIhk1LoH4i8A+cpeu4YZPZ8JETYvZVZ9vg7lyAEpGxRjiQSEDftto5uy6miTn66iL1rGupM2vcp7w7K+qRiNuWGQfoZrRGQyfI9NxeWp+lUxoIfsffTh43hiaXQsUhbwD8z1haScex3YdTqIV11GpdPhRgpHvcW2sjv0c9Vy6ncStR43qV+mSto+K06lTPT8bdIXEdBFzbYZXZNTd1ZJUgiQ7Q7KcIAX0am3Lfv335jj7kIkITiyUYPrk4HEXywGutega4xEhnu8+D0mbu/f0Kg/19cV1zC+YHA5dmfjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57j+zFCoeeGKDYqrEjk8lXoiBkaJ0T009EpqnstvlgM=;
 b=vC+WjDOL3nEh80I0ejRfKwlNDMZZ2UZBq8/u2zM4IENBt6MMTDILfARLxCmbhnYYtuD1Nhemkk/4zfOVaeD2+PRb1cZEzqaPBMDM0rDAizvtqaVhU+axq9BiZSo6O6Qif6ihgyt5M1UOkwg+7mqVzJ71TpH1C7LIOY0I8UsCNUI=
Authentication-Results: mxic.com.tw; dkim=none (message not signed)
 header.d=none;mxic.com.tw; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1904.namprd10.prod.outlook.com
 (2603:10b6:300:10a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Wed, 11 Aug
 2021 08:00:23 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4394.023; Wed, 11 Aug 2021
 08:00:23 +0000
Date:   Wed, 11 Aug 2021 11:00:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     zhengxunli@mxic.com.tw
Cc:     linux-spi@vger.kernel.org
Subject: [bug report] spi: mxic: patch for octal DTR mode support
Message-ID: <20210811080011.GA14773@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0130.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::9) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (102.222.70.252) by ZR0P278CA0130.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:40::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15 via Frontend Transport; Wed, 11 Aug 2021 08:00:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd73d6e9-7782-4d0f-e71d-08d95c9e1260
X-MS-TrafficTypeDiagnostic: MWHPR10MB1904:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1904599E945FE99FACD5E8298EF89@MWHPR10MB1904.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EQizCDww9zAfJzktQJcwBEzXzy9Mih3gmiRsEpEIVgtxwVe+I/qQM9GiyOPqyIf4LJbrCBHrK/Jr5M1GmPdGDgewlErWOC4DjNMawzKlhW3Gfy7fVQZEruDtlVykeRjksGn2q1lyKbwhpIPtqkzlLVIJtLOEkED+pcSOl8PWxToRQPwOLp43GZTdWBD5Ivvx1VrFSoQJp4UGJ/f+1ej7c5j6Ug+16i/1tTelME6MpwgOCXXx6lDKoXARePfEtGANh0RkjlUWHy4CXByaH2aN9Bur9hxpM1oJylYPKWeBu8/VQuZR6HSDXuyforxs8PowbQf22vZvFRYwI3h/0jy+5699JjZogEBcYPBndvn7C6+MmpE8k1qYOm0R7P6zBD57VoAZSfpTu+SQGxFCqpmpvq46CJRv6pc5/gKVKqxyiEXaBKGJomm2kMbHXPvvwwvzelOqoamn4LOn6XRsreT9F3mGUvONRc95RRa7jxf++y07yZ6D1Vvb4id6HHXbqQndtGW3LKfUdDPaLL0w5WZD4qyFUbBEWgY8ln7trMwaajB21J5pjsOSvKC4GBtLlt0voEeQo1zG7U+8M2/gQbcOFnCdRMfqJ0R7TsBNLDn/MNGw/slcLfLWszwIAqaScNcUkRPvU3unuanVPmnjM4Tq1vLDsHWYMsBM6iEF9u5B0MGhs4wYm5jhGYU7IAivuBw05B5xAr5yCqCLEDzxsU3VTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(376002)(366004)(39860400002)(346002)(6916009)(186003)(83380400001)(4744005)(478600001)(55016002)(8936002)(6666004)(9686003)(9576002)(1076003)(956004)(8676002)(33656002)(316002)(86362001)(26005)(38100700002)(38350700002)(44832011)(2906002)(4326008)(52116002)(6496006)(66476007)(66556008)(66946007)(5660300002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NbTCZdcnVOJf4Z2Y0Uj+U6ab6UXzReI9KwiRmTAf4qqfdgJY6eL9FYk/eeDE?=
 =?us-ascii?Q?5B6p3BNn+92pm5VgnF4P92RwyxRtSamotlgAO0Xy6ex4CwwEk6KvYwZgnyv0?=
 =?us-ascii?Q?Z+A1dVT4QOsc6Sqd8Amz9PADN6z5fU4nLkmM6F6IF2KYjVLfefAAi2q37hqP?=
 =?us-ascii?Q?eqdrymsnPczFCIlgdxRqCvhVRcgQ/+ihMgkhQ0YpeVJJ0d5zp78JwldyoulK?=
 =?us-ascii?Q?KTOxWGcXKIh0GdpedsbUtgO70Kuekll1CDxLgByIONjQLrWRMZStBhJeIvVG?=
 =?us-ascii?Q?rwYW+eB8CSaGGMS4H0wfwiIlmyewnhokV58bGJe45Dw56aWR4203azgUSNu4?=
 =?us-ascii?Q?97pR0jonCVTKYXBdsGLUhlExLUo0iy/Ev7lH0wLNMwJhqFeTzEWvDAcJgnqd?=
 =?us-ascii?Q?qxwwrjfpXlJF/bBwhkXMA3HUcdMQ0S2VjJYXafP6M2KJCdsPp4//ddh1PG9y?=
 =?us-ascii?Q?PTSGp1gMwi9l5ODeOXbEzd1HP9DL2Looosx1YrfTCd3Su6ROxjbJml+4Egoj?=
 =?us-ascii?Q?V8DMbOu8TKHo5FUBtt6W9AhDl8+6nDa6JoetRE7Z5f/YiLZdtf4pHjL7sM8r?=
 =?us-ascii?Q?0ZZ/g9NdRb/l+tgAsUQ6r9umxKvcRRoIohkETyXddI3UuW5lcHGkeID8MVe3?=
 =?us-ascii?Q?OBjMA7LWX0KR3lpGYeUw+QNAn2jnpl/E/8jfugwLkrtUBYsX/lHUt6qe9bM2?=
 =?us-ascii?Q?uOIj5gfwrZr+disjGb2SdzGD2VDb3tJj8SZH1D64cPG9H5K+EsN80dF0hLyy?=
 =?us-ascii?Q?p8qmotVBITj4L8KyNEpFxZb4o+akp7HwyU/tYYk4QQsRbL4EhvyoPiQICkyv?=
 =?us-ascii?Q?GTxlTM2ZpEmVe/xoNp7ZLKbHZJvIPbGq/802YucEzs7ZtkWQWq5DfHZdDz0P?=
 =?us-ascii?Q?GGGedtqUcYhxnV2bxNyOnr+8uxbt5Bt9XHoUXEZIrmccgpJVGXPdo/CKCw5W?=
 =?us-ascii?Q?l7rbhbo27yH92KqwL5qbsI3gRJQMGpO7PxST5pMCewXZ09ANAYe7M9iNI4i9?=
 =?us-ascii?Q?cSwEoqtIjTSy7BKMLGYAaLR0KgHe4bB7zgIooX6CFeV0MC7FkOpnwa5Jwm35?=
 =?us-ascii?Q?j1P6RaL6Qyt2+9NX4qNB5W0lkCZXUqXD3fJWcGv3BG1tX3CfPVTrseZz1AxO?=
 =?us-ascii?Q?JXPXU6UpDhdtfhuwT995VK1KWcuogI1tgXYYhJF/N/VE327KqAtiNd0X1BFl?=
 =?us-ascii?Q?brH1QbAZOULyTHR/ThNHDfyFY0Yl6gpoDiTwy24Xd74jxPl0tZSvWGLiNrhR?=
 =?us-ascii?Q?7TOGR9NTf/FDy1DvLkI6tcRT3dmkntrrv2wXsCvMsl6WFAxTO4YIQEPTdhoj?=
 =?us-ascii?Q?bJK23Q63ZPphj7xZXqWL/tt/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd73d6e9-7782-4d0f-e71d-08d95c9e1260
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 08:00:23.5362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJJtHt2zDAkeWGdDUg8vBEnYgxKvgrOVTfwn6VwZBqCsqUvUjDprGFU1ywEk9mI/28aZBJXS6Nf0u5QgkMEl3RJd2V1/g+SujksYypC5BKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1904
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10072 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxlogscore=740 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108110052
X-Proofpoint-ORIG-GUID: 8zPgki7tmAoaTjTNxZuFtfmOyfmTIg_h
X-Proofpoint-GUID: 8zPgki7tmAoaTjTNxZuFtfmOyfmTIg_h
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Zhengxun Li,

The patch d05aaa66ba3c: "spi: mxic: patch for octal DTR mode support"
from Aug 4, 2021, leads to the following
Smatch static checker warning:

	drivers/spi/spi-mxic.c:403 mxic_spi_mem_exec_op()
	warn: curly braces intended?

drivers/spi/spi-mxic.c
    390 	if (op->addr.nbytes)
    391 		ss_ctrl |= OP_ADDR_BYTES(op->addr.nbytes) |
    392 			   OP_ADDR_BUSW(fls(op->addr.buswidth) - 1) |
    393 			   (op->addr.dtr ? OP_ADDR_DDR : 0);
    394 
    395 	if (op->dummy.nbytes)
    396 		ss_ctrl |= OP_DUMMY_CYC(op->dummy.nbytes);
    397 
    398 	if (op->data.nbytes) {
    399 		ss_ctrl |= OP_DATA_BUSW(fls(op->data.buswidth) - 1) |
    400 			   (op->data.dtr ? OP_DATA_DDR : 0);
    401 		if (op->data.dir == SPI_MEM_DATA_IN)
    402 			ss_ctrl |= OP_READ;
--> 403 			if (op->data.dtr)
    404 				ss_ctrl |= OP_DQS_EN;

Probably you recieved or are about to recieve a bunc of static checker
warnings about curly braces or indenting here.  It's hard to know what
was intended.

    405 	}
    406 
    407 	writel(ss_ctrl, mxic->regs + SS_CTRL(mem->spi->chip_select));
    408 

regards,
dan carpenter
