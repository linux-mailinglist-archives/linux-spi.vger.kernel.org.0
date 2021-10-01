Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87C541ED50
	for <lists+linux-spi@lfdr.de>; Fri,  1 Oct 2021 14:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354351AbhJAM1D (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 1 Oct 2021 08:27:03 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:59106 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1354185AbhJAM07 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 1 Oct 2021 08:26:59 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 191BV2Xh010028;
        Fri, 1 Oct 2021 12:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=rZHo7qvF7HxoHLmqbqMLL/jAgSyoGkiqQkBZ7Q/ufn8=;
 b=ohAw+W415BkX2a35uKoTiB9d+dC+OaRo1BYfORwDIwLVAQbi6nasrv+m2k9E18ZfWncB
 zHC7ibLQV+CNHf1Swus6dtwO1s+9zlFlOTlog2AhShKFEfsC7ruXDBUp9nnaUQm4N1qd
 YSLBWmQQ171mTP5akPtrCEFtsZBUVwtEo7g/AUZhsQC0lxPr7hEWHfuzd324Hn0tH9m5
 H+d0YUcobApzVQ7emoWZ3U5uZOTPBvVZh4CLFWvW6578uEh1ANqv5pHhsrmkfyyCtns7
 LYC7M7Ni1t6Dej//6P9FE11igGO/3c6E+7wMzpVvPk0syvgSwpnoTMW6Nha0B1l2s4PI oQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bdb2drdx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 12:25:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 191CLIB8088839;
        Fri, 1 Oct 2021 12:25:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by aserp3030.oracle.com with ESMTP id 3bd5wckrct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Oct 2021 12:25:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DIvOj31qIx0+jQGa3uAdcRBEnz+bi8F8XJpqaU/f5OQq5K6ipC4sjCLt/PgbJfHqZkU25TyiaL9BxNwhLhYlw46rG+V5vkg+PUadPDjnVQx1ALqLohROnqw4MElnI/22hpEVWiIG9gRFmk+R+7bZmlM/F/y29FXiUv5kiKwXWMbeSCznWLAXvy8KJRkmPz7N+btDyl+QFysKlaW9csa16/o9/Nrtj8sEA9BuBhExiHKUQoWfLq3cw6cHBOUXS40NAxDN4YycA4Oz+iL97qbY6gRmMJuS/1KaeICQ0ZFHGugfh/WEt4PZ+N2WqYPMsdg0MJWoLXD/PCdC1PxtmlUo4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZHo7qvF7HxoHLmqbqMLL/jAgSyoGkiqQkBZ7Q/ufn8=;
 b=KU0W3ZQmv0yCTmyeT2Xgmy9zh0s8dBYXVV0nVqMfzmUMCi5y40YPnpCXtxyvatoC5st4FJQVuybdoad/yGViLOTEkcA4rwrZpiLwPYq3BspD5QKFUAlgTMTcApa7QhM4F1VWowXehUrjh8Njl8myloD+63zAar9st2TJFzARluJZ9kcN6+Vx1IAGTxK7qTGWSmP5yawNO7iyD/KbG9lasyLjOt4m+KOqTh+WgYZBeDhFkZEbO1VOlqcYBryVgJWYKhiS45/eeh4u7RzCHGV6v4t2bvJfTX62X7fyyWDhurVqZrjBe2/SBmeF6j3Ehb0mF8n7X5RUmEpu795zCLm+Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZHo7qvF7HxoHLmqbqMLL/jAgSyoGkiqQkBZ7Q/ufn8=;
 b=RzR8JwWiYG0unrAoWwOGi0hZzPeYOJho3lYmdnNZXHzSZhx/Q0uinTZR2NfNMpdobgjw4dYoRfrob9f8BbEUb/aoGtTnUJceBHW/RR2afUg60yzvuk0l+KX8Ik/hUV1hWJkEn1TY9mjpklW0BrgNSctFfkJIB/3hBUrJ6ICKmFg=
Authentication-Results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2319.namprd10.prod.outlook.com
 (2603:10b6:301:34::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Fri, 1 Oct
 2021 12:25:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4544.025; Fri, 1 Oct 2021
 12:25:11 +0000
Date:   Fri, 1 Oct 2021 15:25:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     pthombar@cadence.com
Cc:     linux-spi@vger.kernel.org
Subject: [bug report] spi: cadence: add support for Cadence XSPI controller
Message-ID: <20210930134231.GA14363@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0036.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::23) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (62.8.83.99) by ZR0P278CA0036.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Fri, 1 Oct 2021 12:25:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7313e79b-e370-49c7-2e8a-08d984d68327
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2319:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2319803F8E1945F81D0A713D8EAB9@MWHPR1001MB2319.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 24Ki+Dv4l3PFGGUWvsQPctRwiRgIFZOcuNzulhEq+eqU0UoT3YpfxF5h/Lyq3HgI7JZrNXVBwB7SmjRfqgt7cSaqc5aNHzMbHcj9WwgutAsS8BUAgeZd/S9ZAFtc6UrMFYqlF19nJTNvV4gOlYGhGlhY087mO6H1E6UZlwmPrOeRyzRG1+XD43YNa9s2US0iw4PwFV9JSToVIezwNYR8u2powGGV9q9CpHcxvU4efjPYQd6MAhIyaX2JrE1Chfy9+a+RdKkMtKzPQE9dEcJzkIO4Zt7WFQ95siwSLgWq1kre1iwLhHczMn+eSy/5CnRaK4A3tevhT9JGcU6p2NQRum+YPlD6Fm5RydWdvwJIwiw46NfkY4DuehqTdQXoyl/fw5C/ZpNg0BJwq7Dj89yYu2fbiLXvKxqDDmoA/4SXfMm+2RtfiyTzKU3mw2U8nEwHg5Gry/cH5KzSvJolyOIFpOM30K6fJDO0t52dragpChunN/uRH9zsxA5YqtvcXm3QzG98lm8MUQN++vfwZ7zNBWtWtx+WN/uFmTyPkUdx3Mub4EGseyKhcr/jtf0UmGOyt01pWgKV6uQUQN3vPmRpf9UpUUmzWk6n3lQcEIe5W8sF9b44bTjWP52CKcH+Yl82NCdf6T5O+RUU2RESpAw0i7aobbk0PX81ry/TaLt87M2TI5EtEA/FIPS+UD0svyVLhll6BuM9tqwJXwos+WDvNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(4744005)(9576002)(86362001)(26005)(6916009)(44832011)(1076003)(508600001)(83380400001)(956004)(2906002)(186003)(33656002)(55016002)(6496006)(316002)(9686003)(5660300002)(33716001)(8936002)(52116002)(66476007)(8676002)(38350700002)(38100700002)(66946007)(66556008)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hlzR5MsglWleSM1L13TllMYmJgJWbBDhu1rkcgtO6GOhGXEnGRGQ3sCt38dZ?=
 =?us-ascii?Q?+NLXC1kmGw8BA2KTz+PBvLRftf6mMPOYU8eoJAEMVbap90OpoUZpOa79BJXj?=
 =?us-ascii?Q?/eIh1YY/XgOAtYFblm2BpNxxa6oC3vKnUX0Gsl+T/ouS5PdGZ5w190bj/DWG?=
 =?us-ascii?Q?y2W77TDenP573mHmyJTxDJvF9BnvCi5gy/T6pRLsO3+Z7EL4Hh3P0PZdJkop?=
 =?us-ascii?Q?jACjYTaWsEQkSCgxr47pN109gJr2+3R6kvd36AfCs3jORn2DcAr9Zn7jJhIO?=
 =?us-ascii?Q?tgdXNRa9GxJU5X7MiBB8Ar6KjQqqdr8MO91i7DasFhgHwJLnUpmKJvM6Deq3?=
 =?us-ascii?Q?kDe9OmZ3WK4mIbd7HUNCi8x6IOZx6uJCbmeVW1L76jpDIFEPahRSsbllnm4x?=
 =?us-ascii?Q?T2KwtS+AgQ/R5Jh/7tpHMqF1knOKaUyYzmVX+nAvBOyFrwgwUDKGUtOyH9ya?=
 =?us-ascii?Q?9v8o9hW6rR7VZ60u83u53c1zcuqMMbY60conAiGPzVvtplahRtPVnr5RviKa?=
 =?us-ascii?Q?EjuqbzzGjzKs3/JtscpnPsMTBbHbzOlVmmfumHTC/E9S7ao7vAzgyYv07X02?=
 =?us-ascii?Q?X+vnvUBGerjHiG4vrNhbxAmVISXjaB0rVZ7vry+UE+JBEfxC6HYmHSfUwTfx?=
 =?us-ascii?Q?Spv/rP8MRTgkCCfGp3bFOuGZ4aaQS2Jyl/ZxZl3re8JcVxUC60kXO7OLdrCV?=
 =?us-ascii?Q?+w0Qu5EVwkqV09NjgzYmFR1/C7b9e7S+R9iXOqbHfeaHHy4HXqMLjb5GocpD?=
 =?us-ascii?Q?ba2WSaUKnC3KugXHmx1WBhnKndbi2iWc50Am1nhwB0kNqRveNbR82Y0TapFa?=
 =?us-ascii?Q?+P6HfQ+KiL+X53eFCLX9dJV/OeGjtBsskzfu5gnQy7ffATdivOcpUtUj4pTQ?=
 =?us-ascii?Q?urO+jQyrLnIQLQa7s5U8bOjwij3FHFm+HcCDMvTOyfELi/mUqEGjk7DM8/z2?=
 =?us-ascii?Q?dfIau67BYjK+RVEmBBo6eUhuOP8Fhr36oa6d92A9aDfEHnVpwgJT/lWm7YM8?=
 =?us-ascii?Q?/0j2ETphU+gXnpIj4T0DPeB8iz86Ly6ZYJyK99N3ndRJq5fF8eq+0tvVYSl0?=
 =?us-ascii?Q?QastZ+3mnTFKT6qO4iJBUF1H/qeVgJsaMaRNs+o6s4hnBd7eUwrRY7Cp9YVg?=
 =?us-ascii?Q?GoYUw+vQcsvL6Z5LOi7hxkVUGziDOeyk9FcNugowYnpx1DXwE2lUmDNsQrw/?=
 =?us-ascii?Q?P5e3O9TG9ib8hjcg8k26py4D3vVzns5AByxRZc2cumrDUDHVkctyL6cLBE9J?=
 =?us-ascii?Q?EyCJHeC95PUHFPkxuKbaomI3kZmTRnm9FDmgIaJLacT9Crf6C+Wy10SDRgmk?=
 =?us-ascii?Q?Vd10RzQY8MksxiiLK89uukO4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7313e79b-e370-49c7-2e8a-08d984d68327
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2021 12:25:10.9405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FGgaqPWZWxNWdOrzL1aE2hch3f0x9NoS9KsIAWccY6FLtwwb+cmba+RyzlJ76nx98mdOvC4/igU0kXIrqCc2nF4k4FPwDjBcxki3lPbhVGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2319
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10123 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=893 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110010081
X-Proofpoint-GUID: qaXVN7yoa7iLiPxH57QlietrYgSrc-Tr
X-Proofpoint-ORIG-GUID: qaXVN7yoa7iLiPxH57QlietrYgSrc-Tr
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello Parshuram Thombare,

The patch a16cc8077627: "spi: cadence: add support for Cadence XSPI
controller" from Sep 19, 2021, leads to the following
Smatch static checker warning:

	drivers/spi/spi-cadence-xspi.c:244 cdns_xspi_trigger_command()
	error: buffer overflow 'cmd_regs' 5 <= 5

drivers/spi/spi-cadence-xspi.c
    241 static void cdns_xspi_trigger_command(struct cdns_xspi_dev *cdns_xspi,
    242                                       u32 cmd_regs[5])
                                              ^^^^^^^^^^^^^^^

    243 {
--> 244         writel(cmd_regs[5], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_5);
                       ^^^^^^^^^^^
This is off by one.

    245         writel(cmd_regs[4], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_4);
    246         writel(cmd_regs[3], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_3);
    247         writel(cmd_regs[2], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_2);
    248         writel(cmd_regs[1], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_1);
    249         writel(cmd_regs[0], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_0);
    250 }

regards,
dan carpenter
