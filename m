Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107E8420606
	for <lists+linux-spi@lfdr.de>; Mon,  4 Oct 2021 08:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbhJDGvf (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 4 Oct 2021 02:51:35 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:10344 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232876AbhJDGvd (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 4 Oct 2021 02:51:33 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1946LXYX026631;
        Mon, 4 Oct 2021 06:49:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=lq7ylzS2CH4IH2Ctm9+RPyRHvwQOSxZajrLB/XptLv8=;
 b=Y7ndQ4xdqox3yJCDSncmvC/UuXufhehhAJJS5VYcW6w/ENYTENre8wXnzMNAPwyE+zm4
 KzUuIFeZkUjHDzzNWPBL96W+zfW1OtDIGAXN1VywBre+Pc/7QusSS7mwnNPMxO51YCfu
 VZGEfcrexTxBL+g2AVMtedtmLIwK2NNPCtJ3HyFTzaQC2gOGhlqsSl+y+D4upCpClWrY
 KEhkWHXjSc7Ftj8FbKp9zHB0khl1vzCF8tAlBBRTj28nGN3HnwGv0fr9R3gJz2P0Uj53
 UL2oDBI5KpFz7GzKe6AT2hQpf7CB2TCgss/MuIuPkoxXg67j+guKkI+UmTToZ2ADjvk1 KA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bfaj221tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 06:49:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1946eaoT018194;
        Mon, 4 Oct 2021 06:49:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by userp3020.oracle.com with ESMTP id 3bf16qyee6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Oct 2021 06:49:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XkCzh1rbrIymFgYFh2rMBmimCiSdrTfuL0ZiY9m7GISiiKmg76lmyT0UQesMevQamB4VCve9I1M/zmK6wu/HFfH4EGp7FO7hMa1fny54UaLWAyHvkfiCTjzRoC8C5VltX1IYA2NUnZi14k7avUXuJ5DPB3cmjclSmRVtTbZTnjIZElKJAV2Y9S/oFCTOWdLgs05YExwdaT/h3rR1SybB8hp+Dhp2DVx4pMph7p5xUNDMkjAW+YhKvuDgPdoE0kpBV2cO2eTXsurFZFTzleUCMdQpfE9tLbeDFU6VHG/8EcqYATCofG/wAJ4YoCRhk5hsMWBERQmNvtxaUIRTzLG3og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lq7ylzS2CH4IH2Ctm9+RPyRHvwQOSxZajrLB/XptLv8=;
 b=kVbTbvbgPvSgdV0T/RQD4qP7PXRZkLYvxh3cRj7oB5jJSEwF4et4s/CZvYGyM1ESqc3tTeTEpo8YIU4Ntn01SD0xpvEt/pBQlQTHo9eNSt8vjwjnoilnLOEvTQHfZaIgACfoKV+yyrFGUWBpKPZ2539uLjoIwWZBW8oIIkdn6ap7GQLWwAHrduBbhMiqpmjWMt62S8mGw3TF58CzA+gYpYU4E5V0IUnQ+jcPsKvwgPLHgywIi+8dk9FNdR9MwgJ6KYgZoZMBUwoip+FHi15v+q/6Kjdd1qaoXU0mdUv2V8nIMnhFRcudH6oDQhfdLklAywN7V1taDPq7HDLqCLqB7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lq7ylzS2CH4IH2Ctm9+RPyRHvwQOSxZajrLB/XptLv8=;
 b=XW4cDjexowgzJsSVCBhmkNAVezoWvA/AvvNz/WmO4fnxRYpSmc1aYjTX4yP41J+JEZLovRsMPZm4cjKeih6q9eGj31Tmi6pos5LtT6VIjeo83Z/CveKHHsklLw/DxyGhpNLiAZKUHA82IzP/UWxda00vfryLQx8YDZRDEJy/03k=
Authentication-Results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1549.namprd10.prod.outlook.com
 (2603:10b6:300:26::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13; Mon, 4 Oct
 2021 06:49:38 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 06:49:38 +0000
Date:   Mon, 4 Oct 2021 09:49:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, jpawar@cadence.com,
        mparab@cadence.com
Subject: Re: [PATCH] spi: cadence: fix static checker warning
Message-ID: <20211004064920.GB2083@kadam>
References: <1633244658-14702-1-git-send-email-pthombar@cadence.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1633244658-14702-1-git-send-email-pthombar@cadence.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0063.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0063.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 06:49:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ee93499-b886-4419-b886-08d987032235
X-MS-TrafficTypeDiagnostic: MWHPR10MB1549:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB154949B962945BFC41F1D7438EAE9@MWHPR10MB1549.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7AfqXyLotgPcJ0EiQdIuO0QFvLPhVQFLbXDb9vLXS251RR84TCiLYqidB8xQq8awxqyfsfEp5+JAxnLEZjSyxf1P4OPwSKbF69QdWAVn/Y2V1vAgLaqSeKzpK8KT5fZa/+1iB3W0vCCbYkEy9vhRcF70zw+qy7FebNgcMwgv0KlNTP+RsqMRgwaD0svPOfLi3tSOe1Ke4I8kPLC3TjvZrKc/U7iOiSRCrzzGwYU52XKT2IaKmd0TnOQBexgTFCN4EhCaMGetU/2KITo4DlYp8qEQGgO8vuH7+LdvbDlhc2RSYf6EryMngh8Vmiw/mhRYdYL+CdIezgxtJidQFMC4d4Vvt/VhyTdrEuYBErR1WQPtV5p0Fe1Qk4UNHHK7IMNmuhl4tFAFro4ocoq9QT4gz975kW1YW3ECRgZHkyrXY39uTUqAu7s6JVGykUN9QpW7vD5Fm1JUlMAGaYptrUH/Dku+qYcbv1320X7gttBunazGWK3bXs8K2eulu/ofzpZSCn1RjsFXwqxgvdzRDp4Ed38sEPDQWDPoIsKZSTB0Mm0zm3z5u2hBteskbx6fLvx0Wnoo6wMPdaDVsxtdb06I2ONyI07ehRdNXugqgkAlm9/yu8lB9TV6Ol9vvlk0WW0LuwGJ1/gZWOZapgw2ge4lTU207kz1cu+icB6TOlEQTsKQP4Sjn+8ToW4Gkjaq0fxj9lULJdbYUVWIXdGpWsEUFfOKgYfRB/vEGwbf9GsOA14rO9IL8Jc2rxAhyW1fn7HMRQ+3tDhB9tTaa0FJMs/SCBk3r7tfb54B0kSerMLfQTA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(52116002)(55016002)(33656002)(6916009)(9576002)(8936002)(66556008)(66476007)(66946007)(1076003)(6496006)(6666004)(8676002)(86362001)(4744005)(33716001)(966005)(44832011)(316002)(508600001)(4326008)(9686003)(2906002)(186003)(956004)(83380400001)(26005)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ndwJF8RCT5ZXzwGzk4OX/rJu6Nuu6wNFuVUDjJ3OuO0t4oie0lKx57u0Cc6h?=
 =?us-ascii?Q?Pm8boShlX+9T/WDtfRNGVSGIBfl5w1iaK2ggpKAuxH6Uw7U3Ltn568zmYxzb?=
 =?us-ascii?Q?rIvoiXSLlylQr7F0KHf+bZW5M/mk7eNlv7aOY5qiLpidUm8u11fULlR1DzEJ?=
 =?us-ascii?Q?3bkQaOEhgXFrh5677CMWDyXp3l9y8yCq5n2IcG2LM9ezsn1COgha26BOkoyW?=
 =?us-ascii?Q?DQDwUk3+l0pFCZVg7FDVZ3ycM5TVA7qvYYTgcuG4L96aut/I5/SL/sp3g9kd?=
 =?us-ascii?Q?TWmDC1H5Gwu1hcJSE5ifhgIpsGg2R5EC1ZSd10Za9cOmerqr+mytPjgZ0MhZ?=
 =?us-ascii?Q?tF+smMfszFH4hqLtvaqq289ZQAXkBPXy94ygcv0iUVEX5vhQCljjD5jbbIOz?=
 =?us-ascii?Q?4MyYk6EjYhGcx4H0T0j8kHX1m92QBZfxCeSWgO8CYyFqcAhhnWhHfHdTPLXV?=
 =?us-ascii?Q?cosknlJF6IuNSBzt8M/ML/TfNXOIChKfXlYMYDG9LDJFZfPEkSZTfA4FGmZU?=
 =?us-ascii?Q?ObNQ0uPKVy7newt3OQI0kPa1oyr/vecrQaFFTUtDBT4dXw1jkPPbdkpMtBr8?=
 =?us-ascii?Q?6VdffE5vTnCNzd/zE3eAn1f9lRoeEVyiwE9OTZ25LuVAQV21Yu+Y4An4blxM?=
 =?us-ascii?Q?v+IY0SBAnrfr/3BE6OREE6LqG+oilGF4niKKJDfy/uvazmOJfAqhLoDF/xf+?=
 =?us-ascii?Q?4Z90V5bVQwcq/vwzVqr5ds6C2XivEWY2zgdau7XmhlQnG4hTg/sS7+0rzS2b?=
 =?us-ascii?Q?RQYYlW+uju+Adht7K0zp2H6/iT9Ur+nOk910cRZbX5V/EyFIUaYnE4miuUqx?=
 =?us-ascii?Q?idnAiriFag8zuZRfT7KDh5LqUiaknfmlO2EJ5ixapRAoZFDnJUihcoRogedJ?=
 =?us-ascii?Q?WhYs2gMSVy/fl/M9hvQgvFVywmwB/EJjP/sal51jIjS6B+Z7faqeMWhz/7UM?=
 =?us-ascii?Q?t1h/gMGH8csv6Aq0GdfQyE8TUfW3D9UxcTwCd2l4NPxwfGdeeaAEx83W7ZvU?=
 =?us-ascii?Q?oEcOD3X0XgijtVR1pw0G1Etq4zLU1JNpgdJjOFpDCIX32ijDEC+7WFr9fkv8?=
 =?us-ascii?Q?rLo0SERXuV2Jk2BTzZPCtZkXwKy91aAQZ9HTMsQU4GJPjzLwScql5BgxhKSO?=
 =?us-ascii?Q?s+783SeUHX5Bd22+gWg9BEBX5SpWUtzX6wdqJfG3cNxyhBx70dgeT8LLc+ZR?=
 =?us-ascii?Q?GIAVPTw34QpcFnTLJ3w/cJbf2bsjL1kQjjJN22w0uPUY15oO2Xd8Thv7quFW?=
 =?us-ascii?Q?q6irKXWNyPbZy5zVkgCr3qzc6KqWk8jHOXtI+38ySjEaQztD0LBXkfKaQILE?=
 =?us-ascii?Q?sI6t6BbiBE0DrvsIa8jNIGtY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee93499-b886-4419-b886-08d987032235
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 06:49:37.9452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OmZK6BMzdVkIutKoWbHWlFx7Ya28/QZ2Zea4AYJ13xVx4XC6cbsY3PkpHftGTBgWAbN1n8HeGoodKof4lDrfkbLD89fvN75Ui+xTZYmDzfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1549
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10126 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110040047
X-Proofpoint-GUID: ejCG1XVqOhtqh7mTRwGGAUHBv1exp4W2
X-Proofpoint-ORIG-GUID: ejCG1XVqOhtqh7mTRwGGAUHBv1exp4W2
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sun, Oct 03, 2021 at 09:04:18AM +0200, Parshuram Thombare wrote:
> This patch fixes Smatch static checker warning.
> CDNS_XSPI_CMD_REG_5 is used in ACMD mode and currently
> only STIG mode is enabled which doesn't use CDNS_XSPI_CMD_REG_5
> and hence everything was working in STIG mode.
> Since plan is to use same function cdns_xspi_trigger_command()
> in ACMD mode, increasing size of the array passed to it.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Link: https://lore.kernel.org/linux-spi/20210930134231.GA14363@kili/ 
> Signed-off-by: Parshuram Thombare <pthombar@cadence.com>

Thanks!  There are runtime tools which will detect this read overflow
so let's add a Fixes tag.

Fixes: a16cc8077627 ("spi: cadence: add support for Cadence XSPI controller")

regards,
dan carpenter

