Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C0E54C3C5
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jun 2022 10:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346276AbiFOIld (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jun 2022 04:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346325AbiFOIlE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jun 2022 04:41:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919124AE28
        for <linux-spi@vger.kernel.org>; Wed, 15 Jun 2022 01:41:03 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25F7137M000848;
        Wed, 15 Jun 2022 08:41:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=3CqiTN77iXZ5b7q8ObpbOfk17izcLsym/ahii/C9Id8=;
 b=qT2C3B2f2oRbQ8Em5UUWd/dmBeg+XxJmIIRErJN7t+qUJVznqNxTRvzjwqPqYEZLO7Ww
 OG+OxVCJBwxHcL+UXuPL8DuK7xU4WQGw+ab7GrWfRwkKPo343G1HYN6R4IwUJpW2T4lf
 ZzxJZsHn3zURxRw7tCVs3BjM1aH9lY3axUPpfckmlvCpCfjnXJJFpuaTCheNoewV43QF
 f1I4wXEPfgXXNv4ppzKz39Cr3Jt2tSYzku8ytkeQFOxKU6tzgVUzbbqX92qNjv56VJKO
 8PlSTn2d7ds8vjbaCHNRf2kRmWKkvCnDj4Dj1LfLFjWEJebkPaDO1E8GZRAzseQMOUzQ nQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjx9fteb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 08:41:02 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25F8UBKP013069;
        Wed, 15 Jun 2022 08:41:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpqq13erx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 08:41:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ad7zpwk7KFhO3nzJgANQyHX/ACEMrGFalCmPFSmoXfsehDRGAG3Cp48ol0b1o1wb/Z9BIMDLYj3wvrYflX5oQCFa6jeTll+4IVqyjX7yJ9ysWPrF320QHNd5h6LcRqlnCboTGPm0uTWV7vkQdQKRJ0+t7RPdvlLTSpXymWT4lEoB+eD8RUiiq2TiLT+Ge0o9M/E6rNATNTIt8LLZEHhICXbN2JdFt9xKLLmIoxDNKmljfh54fDaJyl7ey5peNYYeS40P8u80wl3U4qa6Z6bavSFzD9P6K2SI3YhAB09pTdC5GsupCW09OFmSa7h/Hikwz+70LZcrZ4eShIhNLlmS8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3CqiTN77iXZ5b7q8ObpbOfk17izcLsym/ahii/C9Id8=;
 b=E8a+aWBlS3fkOvzPPzDQVHnzH1xWl0Xz1GYm55+V4A+I2twDzZdYs9LhaUTli1J4f5yuieoKVBVunDDXJ7H+QE5sN1tSkaHRULFZsT2GBQMnwP2G1KEpnIuAXAy5H2wlfaUMbPp8r2PidSlu5gOGwJqLIoOMPyXkMFu8qGBY3ExuBlAKmsLfbl/IHkjTSr811ijxLwx8jgmApWz2llaJadKTWzXbkzIdAr8xwsHDJkAoTcLv8iUqQDBq3ni57fDZwJ47AOgSXX/3ZpJvy3RT9DfPq1JmCqq8Aosu3Di4OC5FgFM3f0g1IdlF+DsbQpNz+u+5otmX/vMRaK0bJNqT9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CqiTN77iXZ5b7q8ObpbOfk17izcLsym/ahii/C9Id8=;
 b=gk6hPXHGUqfKTxSkvIsHwLRkxbINt2nPdmB/5XkjGsAP1P2xbcU2yJjdS1QVCAIOG705tFDudfteJVWSD/ZxpBsEOKShbHu/+PazECPrL5roMn8CTtnElKsEbxEc0IWRLemAZ0VRYydnkkZk8gcVWCyJZNi5CHVlHY/HOZm6bm8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SA2PR10MB4683.namprd10.prod.outlook.com
 (2603:10b6:806:112::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Wed, 15 Jun
 2022 08:41:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5332.020; Wed, 15 Jun 2022
 08:40:59 +0000
Date:   Wed, 15 Jun 2022 11:40:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Conor.Dooley@microchip.com
Cc:     linux-spi@vger.kernel.org
Subject: Re: [bug report] spi: add support for microchip fpga spi controllers
Message-ID: <20220615084042.GH2168@kadam>
References: <YqmTuWEPKkIH7cBs@kili>
 <70502137-6c04-4206-382d-2731a2205875@microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70502137-6c04-4206-382d-2731a2205875@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0032.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::9)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72a94efc-36f1-4080-22e8-08da4eaac5ce
X-MS-TrafficTypeDiagnostic: SA2PR10MB4683:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB468376E980C434E63E1361C98EAD9@SA2PR10MB4683.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0PAyeQ3GZwUM4ZeTe0rMGl80Ctc8q0UxbPkbNRrFEG2unH4l50F9IdlT4GhAt82NQ3nNJfgoZs000dgPKnJC+9rKTVlTI7F33Jtb1jgwL2HK0ws8eofBD25geaVFxrrQaGFy/HvhLrXwpandOmwiXnxbW+RBfMnmEDsFJeRNAFIMhkf96MQktIdFlrUViRyjvu5YCcGAM/RQJRMGLwZIRrQiuBvoortBoD5ZkZRXxDc2o0hz/v12LPR/ojBbIUoqlp9MMvMkwTUbR35lfSo+Ntdv9pwMS2tBak0kHLFHTF5WBE9ZhGtf+V4Ztzt8YRDHr47hHDN0eVxZuZXH6IbB3NCxjdyaePLocVTarOjzMepsHqsGpTzKMNtzFL1SRMGpI/3iSxt7MWunTGJOtbyUXcSQzyhs1+Nbl9o0I++qu95LrJ5EvByat1Zhoi4eOtB5BeLML8896FiGxx2LKXcT8MfyNH4M7XjPc6pADdpcFP4fMOTm5/J9QHSsq7SCIb3sAO/DrZMKYivBzuvLy/LARN42y55lubgwik8OxyQ3K2v/z5HjGxfpbz2QEjr1Vptmp1poEqMJOAhb1M9rKFsLzOslUskz3DlE+bq+YCkdPomDzzn/pf6cEhSYqtTV/Rtu/Wk36adtto9l0Pmavh7m3hb/4riA1uMsre8ZrO/1PP0ZwcUiHx93TFmB5a/DJNt7XXeDmgDipFyRR+iYQw/MtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(316002)(6486002)(44832011)(6512007)(52116002)(508600001)(6916009)(26005)(9686003)(5660300002)(33656002)(8936002)(4326008)(2906002)(66476007)(66556008)(8676002)(66946007)(1076003)(186003)(6506007)(6666004)(38100700002)(38350700002)(83380400001)(86362001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?786kK3Cl+9hI7knaycTJyJN1VDQuUkgLq3AghMNL7pezH/OxafPiZKxPTmex?=
 =?us-ascii?Q?XMXESVbFI5vA8oA04SaB5reFGckHK0UkHHB3oQ6rvp8dNMilS+jDPDUFhwnY?=
 =?us-ascii?Q?Jfq1wr90FcYfxKquLtA6vkvQK+X2SeOctrHW3h2CAbA4n1Ef2vYLYWYdX3us?=
 =?us-ascii?Q?HeE6l+kcPYAhMs6/eBPeae89SEwk/ZIo1F+XE5lz/MKj5VYVmwMlcy13nQ//?=
 =?us-ascii?Q?CJ9vdSMLHpmNbiLNU8n7DJcP8gZ1S+Zr5wc+4ths2qcgjcTgW/I6JrHF3D+C?=
 =?us-ascii?Q?3NaY1IIUnxWwfIQ+VtewhCBS2doVAuaxH3UE7IT+nnzQmLsIEA/o6yMx7NoN?=
 =?us-ascii?Q?o6ZL+4kgGR59xV98n5ZenqmSPsl3wzEl5phXsLE1P03Ye2Hmm/d9PDW36+qr?=
 =?us-ascii?Q?QVNMvWDR9NGr6uFnj2ERFqIZ31rnPOsBLT/UUTZPpd52cn8WEiRmR/Jplx17?=
 =?us-ascii?Q?lR8A7MfRxKZjyfN9LgAV/hQfiSSBC+Py0HwtRPIc0yuHe+ygkJ5Ybk7aybNz?=
 =?us-ascii?Q?LorDxI2lOZZgDnzzf+4A4ah/FSR4BHDykBFHBWTsUGYwuxJJrYjlP2UZRbIZ?=
 =?us-ascii?Q?3OqpY0h3DNlroBNS3TRF0QEZp2WRtBH6RcolfEkx6W94Rq85g73ZMtXYHrWS?=
 =?us-ascii?Q?9lYvBW8Zkaa6B8wqI467e23b6d6STM3Fe2B1xUgKB98Xvg6kP/N5EjMbGrh7?=
 =?us-ascii?Q?Y2FaE6PVPGyNOSORM0Ti0WjWNPUNm8cNTyQGCFjnuCnv/8CvBZyYkUtFCB03?=
 =?us-ascii?Q?A1ylPHXDcHVoYYBeBU5LofZOtAfLmOE1mio2251r+S51zPgLZxbZIg+wZgvV?=
 =?us-ascii?Q?TvToPNCSwOq1Cnc9mVcijyXFJrkofuF+Kzl+W31A5PFJEeaO+EfBsY91UAne?=
 =?us-ascii?Q?4HOCeVYoNI+mBMZbXY00u0OOicQNfQzBXYqQE/EGCZ8zGewkiK3MiXovouGI?=
 =?us-ascii?Q?bABHndQYvtFoh0OnbBorffpxYDxxJqclbKgf2/+lYBh8jX3jZ3moQwnIhpQb?=
 =?us-ascii?Q?n1s7aBBpzsLX3dmWZAFCULThvJKOyewLFgVOFD3o338JC8RmMDnMolIyR1cb?=
 =?us-ascii?Q?ONhYodAvtb7686jZI0nK8f0i9Fa6ebE3sMkNFGM4jeU9fnC3Eex//a+fmRZo?=
 =?us-ascii?Q?9RCVzAyE3c7mfTql4RAa4g+QPIhU3ioSV9aZVdK74Rpbm0eefNDJqteOhfgg?=
 =?us-ascii?Q?BUJfYzVp7jkGSGXVehycsob9c5BxQljtx58Qu0/fNpl3Z9gVS5bPQz78debd?=
 =?us-ascii?Q?ecP3Q/QPk1o4GEPbGbzJKH1zENYVZ+8CFeKJhu+1dzF2EiGPa5jFDMb6TFP2?=
 =?us-ascii?Q?mHAbwoujOOaqGNILyP65T1YMluxP00gVOkE4UygPGzefoC0gGM0zep/wqXE6?=
 =?us-ascii?Q?qm79x4V/HsKXlci10oHVekpgia2kpqA8bS7Cg00kEJFD2LeGvQN9DrQC4Nqu?=
 =?us-ascii?Q?pwcWCbbpPNySejacj5ZBSWus1moc1igGmyZNzMCn8S6EBDsXjj8y82y0yyTh?=
 =?us-ascii?Q?ZuS/clUGkDgRZhYvbeqolIUXaAl2wQ1mWlLibPkGd7jkuww5wFtAqLl2IlUW?=
 =?us-ascii?Q?ZCVKcHZwYRd3IpMAik/nPvF21XMbcYYPLO+6rw1F3+nS04MwyLoXxZOLbBEO?=
 =?us-ascii?Q?PbqpthIFgm6KCvyEdocp6JDfT+SGkd1G4e697YDT8JDEPQEYGx3qFrpvQdQz?=
 =?us-ascii?Q?iO/fUeYAq/HaTESKTw5QF/4h1D8d3bHAMD9e68Osxsiz6YeoJTqmCKoR02a6?=
 =?us-ascii?Q?NCk7sfkiX16H2hJhQHE9Xg+vSpzS8PM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a94efc-36f1-4080-22e8-08da4eaac5ce
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 08:40:59.7467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VutZcQW1w+vbmD+HfQCPFheAzVM2kL0bsGikx5ybFvr+zlvBkGq6upjBgAL7abEYYUrZ5xx3R9GF7a3HcXDQCiaHBf5pi2ogOKxUwxPawKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4683
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_03:2022-06-13,2022-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=603
 bulkscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206150031
X-Proofpoint-ORIG-GUID: aCAWpK15oAx4FYWu3GUXLmOJ0d2N30Ba
X-Proofpoint-GUID: aCAWpK15oAx4FYWu3GUXLmOJ0d2N30Ba
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jun 15, 2022 at 08:33:35AM +0000, Conor.Dooley@microchip.com wrote:
> >      541         spi->irq = platform_get_irq(pdev, 0);
> >      542         if (spi->irq <= 0) {
> >      543                 dev_err(&pdev->dev, "invalid IRQ %d for SPI controller\n", spi->irq);
> >      544                 ret = spi->irq;
> >      545                 goto error_release_master;
> >      546         }
> >      547
> >      548         ret = devm_request_irq(&pdev->dev, spi->irq, mchp_corespi_interrupt,
> >      549                                IRQF_SHARED, dev_name(&pdev->dev), master);
> >      550         if (ret) {
> >      551                 dev_err(&pdev->dev, "could not request irq: %d\n", ret);
> >      552                 goto error_release_master;
> >      553         }
> >      554
> >      555         spi->clk = devm_clk_get(&pdev->dev, NULL);
> >      556         if (!spi->clk || IS_ERR(spi->clk)) {
> >                       ^^^^^^^^
> > NULL
> > 
> > --> 557                 ret = PTR_ERR(spi->clk);
> > 
> > ret is 0/success.
> > 
> > Normally when functions like this return NULL, you're supposed to just
> > accept the NULL and add tests for it to avoid NULL related bugs.  In
> > this driver if spi->clk is NULL then it leads to spi_hz == 0 which leads
> > to a divide by zero bug.  So it's not clear which way to go on this?
> > Fix the error code or add more checks for NULL?
> 
> Am I being dumb here, or should the null check just be removed like
> every other driver? As in, devm_clk_get will only return a valid
> clk or an IS_ERR() condition.

It can return NULL if CONFIG_HAVE_CLK is disabled.  I don't know the
hardware or if that CONFIG_ is essential for booting.

> 
> The correct solution seems to me to be remove the !spi->clk check?

That's the normal solution, yes.  But if you do that, then please add a
check to prevent the divide by zero:
`grep -w clk drivers/spi/spi-microchip-core.c`

regards,
dan carpenter

