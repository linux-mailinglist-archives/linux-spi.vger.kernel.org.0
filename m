Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A10745D614
	for <lists+linux-spi@lfdr.de>; Thu, 25 Nov 2021 09:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347057AbhKYI0o (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 25 Nov 2021 03:26:44 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:2096 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348975AbhKYIYo (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 25 Nov 2021 03:24:44 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AP8CqQb028327;
        Thu, 25 Nov 2021 08:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=owrrT8jDM4IcMMBVIbAYAbg3n+0rL1U74Sw4tV/Oobo=;
 b=XdV51UdGasep7R/Jt4t7g3pKxuV/W6KOTSW4scmsdm/lJE7tm6MZkgQvhgE6Ywv7XJ9D
 M7mwks0OkKkyNa2qtXbfnxgL3SdXZ27Rv3LDs0Yp5H/wlACE3BQHCHJ8TrFjEhYuyCyC
 p0kRgTzoLFSTYMpMRowXDh4myD+Zhvv0XnefBR9x6nZEtlOQELsRS5loOJuCwClA59pi
 4Mth1KQL8OrO6/WaVy27Woj5qLrTa7rLV0hxdsdkVnfhAWmZMjZxDTCbWmW3p4MgpEEI
 cVT1buboF1RcNHqsw9vVELCMwcqITOFb6+vwOaKcqI1Kibz5ZP/BV3RwP9NzDB7aB/9j GQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3chj7g64ry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Nov 2021 08:21:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AP8BKVe121665;
        Thu, 25 Nov 2021 08:21:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by userp3020.oracle.com with ESMTP id 3chtx7f5cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Nov 2021 08:21:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnBlxN4WmzYPcIBJFNlWIw4rNfubCLTYXbO6LUUdAISA2DGHCqbNMB3wtdVwJ0/6LxBJXOujG5uZvY3Q0gjTpounxox1cOZh7nX29IT75jOfDyOvFe/CLKCumhy55YhyTUjoGY1nEDdwtVs6bbDAqemeomEWZ1qZqcj9tFSaBqwNYq2UxUiHT+sZmXU9utB7t8W4KDQU8tUd0ATV1pcoAplNAXj4yWnwhKSiVu1bDZ3cCl9yFSUF6gnYX3cW9WOAabUAgm5TU0CCdjfgcZwjIdonQFI6xvqxOmLhZpcVQrfZNC4C7wOZ4zLRoSfSou3Mz38dxKDBX46iXZJdoetsdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owrrT8jDM4IcMMBVIbAYAbg3n+0rL1U74Sw4tV/Oobo=;
 b=ROZqU9iU8UTMD8Aw57MI17HGXKASqBaeOn2wRJ6H2nQsdhqHk1QUScfoTuT4chUv5baWIM331+rhFrYx8cGQ37c3Dec0rbCq5TfQPmTNoRmd4Iz5WTWGh7u5qvkgdocgOz5x3Jsinlr40roPQsZN9y3wDgmscEDAOiLbQrNxy1hVs3ZSJsGoLfOwtm9qTpZZZ7wSsWiQXJYWfSlunxhHzP0jy6XYDzgHz1AKcu1vpuz0nVmM9AQcZhEAh+F0Aq/iD4P7MXvQ7GBKdXsQWqrOsAsXMz567xcdv2vejZiudaFvkISL8vCRqGcSx3org5pdSIhJ3SYD3gnPqSHzUZXOJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owrrT8jDM4IcMMBVIbAYAbg3n+0rL1U74Sw4tV/Oobo=;
 b=uigF/R6KHoL6Oe7cL2LoAMad2QKq4N3NKaEj8XRSW5JmZREm4Sd99IVpgpaNKRBVlc7Pp/ECxdoJsOOAUgBJ+JtmqL061q2HQuvInpArsCbpKUupHjh0W5UACAjoVMFKvoOO4J3/v1wJ5Cj5z21qsT43ZcLcrPEHP/2lBQw/qwY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1885.namprd10.prod.outlook.com
 (2603:10b6:300:10a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 25 Nov
 2021 08:21:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.022; Thu, 25 Nov 2021
 08:21:22 +0000
Date:   Thu, 25 Nov 2021 11:21:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     xiaoning.wang@nxp.com
Cc:     linux-spi@vger.kernel.org
Subject: [bug report] spi: imx: add a check for speed_hz before calculating
 the clock
Message-ID: <20211125082105.GA5023@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0186.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::7) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by ZR0P278CA0186.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:44::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 08:21:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 810eb63c-1a25-4af4-f9aa-08d9afec9084
X-MS-TrafficTypeDiagnostic: MWHPR10MB1885:
X-Microsoft-Antispam-PRVS: <MWHPR10MB188504B7110D872961D3D76B8E629@MWHPR10MB1885.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X+jKPnrDAPALK4uDuinSZjHatNd17IJ3ZJEuGesMkAIGEoLXRIOJeNAjxLGmKwXEfs11sUjoOOz3F4Mp+ZP7WFTB0CH9W6Xqqx6LLE87C76zBSIbK7TZai5UGYvHhF6YNhxDc9KThpUEBCEv7UZHmHHwIja6ppPPpcwR7KF91kJOsw5XE0zpskGPfwjBzRMdVPeZoro2TopMpablq9vrC25KrqbgDH1iIC2xTj/YaCDPmIc6mi1W/Z/hM4meR7CyhJXGzR/aJdLDe5iCHunHVflvN5vkUDo3KuvTcBAdJgZgFJ/5Vm2henCsSMg9MAkdjyMd7DreDghUosjOoizsyow8QyNCXyi+DmC3tzFxQC6J8NZYammy3OAh2jKs0+fuVxWDpCZulfQC3I2Mwh7SMLUnink+fR+Oa1CffTn5ldLq4O/oHhi8e2PSNZoSaEfcww5TvGSrIO9puISgd8/7nIpFhKY9m/QihjdVmR4hnusEHuqTPuG9VZpseuXAthTTliEnf83FVNmTKTqaq94VLPWTWRf9zUdxyCz4qFl4iSvP3aIZjNVQLgihSjMrpntP123EtxUVdTkvSeEBGlNbD8PKBP0dfgbSXdbQqbLJzjJgX6MZWqIWY39pAD3A6Ib1+PDVBMuc/1SVUbePtos0vPZw7u5chMF2vopnUT4yIgg1WcPvQ6/TOibHlBgCYEcPXb2F3aFTojTovP99Fypl0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(6666004)(9686003)(316002)(186003)(38350700002)(44832011)(83380400001)(6496006)(86362001)(55016003)(9576002)(4326008)(66946007)(26005)(33656002)(1076003)(66556008)(66476007)(52116002)(8936002)(508600001)(33716001)(38100700002)(956004)(5660300002)(2906002)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?udoOOc/gdBqs3czvzfF7CXtC3SOYw7x02h2qwe8NeDKTEEDtmYGI/cMBOQRu?=
 =?us-ascii?Q?TvB+Nqr5xuOoVDCtEUiIi+yrs5x5UtY0ur3U1q1PKMcnd3G5STjL3G5kJCmJ?=
 =?us-ascii?Q?liZYtPk268x958npdM87AcE0cue+zDjZtOgG4DTt1tl1ATLP72F/EUdk51Hg?=
 =?us-ascii?Q?i87n7w3Bto3CwY8fvwiDFCYsXr1AU4tM8QZStH8RPRkOunUWXPpZ0auo6X7F?=
 =?us-ascii?Q?3Ghfi5R5qsI8l6IhUp2b9p+yeLTd+oD7DP8gcy+9TpchxOVaWUvfMizTEkBY?=
 =?us-ascii?Q?PbaJzqxe7BDXFrw5jBh9CGuOOXjAPxLJkHFTdFrPsQhNG1/ZIkQ97dPhqQOP?=
 =?us-ascii?Q?Nn1RohbHYmioS3nJ/kpYpS0l2NMqJggpDupmWNzJ3BocHCv59DIst6Y2OKAn?=
 =?us-ascii?Q?pb+BirUZTKS/wAUPeUtJmabEkvysLFHIY+ojV0lwxxyWFcHaV/FtF+fOXN3e?=
 =?us-ascii?Q?B46phvP/XNa3dLBt+qubhM4ZrF6y+3q9e1/kj7ZyQiIdjWgI1nqyHT3Uk7Va?=
 =?us-ascii?Q?oqH6RRS4i5t74DQmqJHt27xOqOaYxYMiq1bbICMvlUcbV7ODLuxSSW42tbaN?=
 =?us-ascii?Q?3zL+kvk7sUv+AG4vRrSwqA7CUI3h/sAN7Cv4Gqf6kQsbZc5rpVnp3zvG1dsh?=
 =?us-ascii?Q?PAg6rC8OL+PhcuMdknlhQQtXBDbUKmSgzR9jT1CBwgxoRESsjrGhl7Sl7+Dr?=
 =?us-ascii?Q?LFxs+GDCb0e/J5YAgMdRff7eiM9cUuvi/In+GyPpXGpj8q3w1n6Phk+vl01G?=
 =?us-ascii?Q?yeV6fqMfbBW1HH71QZAgayWPwFJvb+fYBB9sEFR6JQWrRb4IXjfUrPKpP7Us?=
 =?us-ascii?Q?FgU2s67mtCuf0ptdKU7LhD3ea05Tt3H6LdcxLPF5kRrNGMCt53ksZqdi6do4?=
 =?us-ascii?Q?NGg58OtOZFssVUiVMLX9CvNiCIV2eWeeeJZV9xAM5zTtMbv0O8g72p2VvMS4?=
 =?us-ascii?Q?87y/NdrZ+X+UzrvqTSSGfSiFfQB7exWOn2dSod7097irGmMTrl+MdvLIPCUk?=
 =?us-ascii?Q?1xXnOHOkDknm/hoA1egrT+G3LBgq6BVJjwN3F2fvd1VAPHttfdwEWcINxUKb?=
 =?us-ascii?Q?zU8cgKZvPU7FuG5aAcYqCR0ZqDYhEk1qnKlEUEr6JMFODksg3CazC8Vh3okg?=
 =?us-ascii?Q?VGXI+QP8jiZD4VU0cHEr6eDVpyIaUmwgd5Q+vpedbxJUfBVD/PrQ2pgdv05h?=
 =?us-ascii?Q?necLcMgcybi1UTfqFKEtEFEWd9NA0jgr3g/JVwOxLK13Ib4y2uLJcC9frR+W?=
 =?us-ascii?Q?tnaB7x8jPY06jpiB5wCdWrj/sNUGpXHo6FhZFYuMF8F9NvjtVtxApdAEh4q8?=
 =?us-ascii?Q?59KooRHaCM/uPvRIEiSmZ7EzLiuRWkbaeczgvuG48GuGH+dovzh035NK0Zcf?=
 =?us-ascii?Q?ganq+OnA2Bfu7F6Q8sa3C2TQCjgCaVSmYxt7j1pBMZhWENq91aXVMIP4sASY?=
 =?us-ascii?Q?KH3EcDup9HpFqsZzNZv4xeCzTumf5zMIUNkk3YDfBdL5av79VTqEJb5dpY03?=
 =?us-ascii?Q?nQVdwABRZEjXxPUEwp/Bhu20gLZWSt2bl03nXJb9JBjaWOWClw6iHKiQswWZ?=
 =?us-ascii?Q?nPjrCuX0mKBWYGRopuubx1lViALnS96boGtK7KIWLyP6PjShC1cnurg7teqB?=
 =?us-ascii?Q?qd79vd0J4tIgHlNMDbaeZQIY/NZsUQeIhIbCsM7UJxSFHW160Lr96FrKbpYa?=
 =?us-ascii?Q?XyYNxnWJCOrUHgDjL8jjoRJ4x5o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 810eb63c-1a25-4af4-f9aa-08d9afec9084
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 08:21:22.4760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4L7NziPi7Ja3+q4LlAMio3PRK1hhSNJ5MKQ6pHO+4+tnvutj3qiw1vBc7AcZInXxApdBJVBls4v+kf7u8JmICFFaqIIquVLmaQg572fDZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1885
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10178 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=849 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111250044
X-Proofpoint-ORIG-GUID: ufePWnp_xcB-xma6pl6t8Y9rhe_aSvIC
X-Proofpoint-GUID: ufePWnp_xcB-xma6pl6t8Y9rhe_aSvIC
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Clark Wang,

The patch 4df2f5e1372e: "spi: imx: add a check for speed_hz before
calculating the clock" from Apr 8, 2021, leads to the following
Smatch static checker warning:

	drivers/spi/spi-imx.c:628 mx51_ecspi_prepare_transfer()
	error: uninitialized symbol 'clk'.

drivers/spi/spi-imx.c
    609 static int mx51_ecspi_prepare_transfer(struct spi_imx_data *spi_imx,
    610                                        struct spi_device *spi)
    611 {
    612         u32 ctrl = readl(spi_imx->base + MX51_ECSPI_CTRL);
    613         u32 clk;
                ^^^^^^^^
This use to be "clk = t->speed_hz"

    614 
    615         /* Clear BL field and set the right value */
    616         ctrl &= ~MX51_ECSPI_CTRL_BL_MASK;
    617         if (spi_imx->slave_mode && is_imx53_ecspi(spi_imx))
    618                 ctrl |= (spi_imx->slave_burst * 8 - 1)
    619                         << MX51_ECSPI_CTRL_BL_OFFSET;
    620         else
    621                 ctrl |= (spi_imx->bits_per_word - 1)
    622                         << MX51_ECSPI_CTRL_BL_OFFSET;
    623 
    624         /* set clock speed */
    625         ctrl &= ~(0xf << MX51_ECSPI_CTRL_POSTDIV_OFFSET |
    626                   0xf << MX51_ECSPI_CTRL_PREDIV_OFFSET);
    627         ctrl |= mx51_ecspi_clkdiv(spi_imx, spi_imx->spi_bus_clk, &clk);
                                                                         ^^^^
And then fixed here on the success path

--> 628         spi_imx->spi_bus_clk = clk;

Now if mx51_ecspi_clkdiv() fails it's uninitialized

    629 
    630         /*
    631          * ERR009165: work in XHC mode instead of SMC as PIO on the chips
    632          * before i.mx6ul.
    633          */
    634         if (spi_imx->usedma && spi_imx->devtype_data->tx_glitch_fixed)
    635                 ctrl |= MX51_ECSPI_CTRL_SMC;
    636         else
    637                 ctrl &= ~MX51_ECSPI_CTRL_SMC;
    638 
    639         writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
    640 
    641         return 0;
    642 }

regards,
dan carpenter
