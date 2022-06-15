Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FF654C471
	for <lists+linux-spi@lfdr.de>; Wed, 15 Jun 2022 11:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbiFOJRB (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 15 Jun 2022 05:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345895AbiFOJRA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 15 Jun 2022 05:17:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B96A3EF39
        for <linux-spi@vger.kernel.org>; Wed, 15 Jun 2022 02:16:57 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25F6wcYF000856;
        Wed, 15 Jun 2022 09:16:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ICYyXVSAM416qKZTSiHllsgXogn99/rGPE0XjgEu9jM=;
 b=ufiYcY1iBTO0a7QVS8JnkbFmD65+OBQd9ZYlZ16B4GCZ+mghbQ+wBbTpAvlzcANNlRP1
 6/in8LjQ8SIsn89dW+/3U1jL/lLj4wtORYKKabCXgyDZ5ALqgNLfQjd8KeNiYiNl53Wk
 6GMJ+gnk3nr4dafwpKU2ZBp8U4tf9ydEjsBEearAy/upcUeNLbUqd+lr79R/UESaH8lj
 kKnU5qzlP8RF9oWDxv9wewcyXqo6rwtSwuHhjFz8MoIaJ5dEPQaAs2btf8OA2uXUQPv3
 ujy7IzG/aco91nDNiS3UG4/sEyogyIAraUlBaVGwCndKiHj3FysFEMkVyyMj6P/XRtMy Tw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmjx9fwsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 09:16:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25F9ADE7037116;
        Wed, 15 Jun 2022 09:16:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpr2a1pu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 09:16:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNcsXMwYQfno+pU2wN+vt2jYnpOz4rKXV9OhUZAii5qixhpM7shwwMMgiRTvX2jOOe06242JrIu8k1M9GC3/EdBYQMrUTdgy6/YrXgFNrRnlZce1utEwVJu9GntZBYlti4MdDo8P1ogOaNymkXrbbSKrDqXkzznK8Km9+GzbR8yB+V04OUFcvD50/9xdQ9Aup6PounXOF1TCOzil9oq/nKbohqjjzvdUntGzubB+CpWZmByo7Dt8iGn1ItqkwBiKDY+36M5AQHLPDR4195OpVsnj1+ltUkrMltWa6WNpUUTYrsMMTl2wLEgtI1dGibUkLIeHt+FHPx9O/KoGa5Vb3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICYyXVSAM416qKZTSiHllsgXogn99/rGPE0XjgEu9jM=;
 b=mzw2ic0eMuTlVlEUjQIpaEUUyb/7e68lAoMmb3/TQxacoGIWL2NOmxllLDxm+XsFV+duIoiruCoK9A3S1oGnMBV3VATTJnjYHaJSlU7T8rjIU6LQk3onKuUKqpx+7ErQCk5qcn/lNwOC9xdPAnD68ngjxoQgxmp91ZQCd0ZV8BwqkxnYntVQrM/QZgGnIZnpyj0cqW4ii2FUqJA5PnJpHU+f6rAys5dYEAjAeKJAuQu4t45H9qRJSkJDvAuXF70oep2hXIcbWGN6v0cvs+4pH/IwKtZfAUALtIT/+9FZqsFPRaAHQmbdPjlA+dCnr0NXxfATRfxOrCFMY8sX5jEK+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICYyXVSAM416qKZTSiHllsgXogn99/rGPE0XjgEu9jM=;
 b=tD52gEqrJ0k8j4TtzfFE7qDAsgX5QaOVOurSShApVAazkr/gN14wVydpFKxmz1UFGLrOsNwbyvv/IZIkcL01KNOFF6oSrhRVQpFgAc7vk5dzzSQEvWqj5LDgH+O5tds+mCiSVXzC3KCgb4vqwFFJ9SIZ2AJCXZhzFITW1twf9ck=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR1001MB2393.namprd10.prod.outlook.com
 (2603:10b6:4:2f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Wed, 15 Jun
 2022 09:16:50 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5332.020; Wed, 15 Jun 2022
 09:16:50 +0000
Date:   Wed, 15 Jun 2022 12:16:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Conor.Dooley@microchip.com
Cc:     linux-spi@vger.kernel.org
Subject: Re: [bug report] spi: add support for microchip fpga spi controllers
Message-ID: <20220615091633.GI2168@kadam>
References: <YqmTuWEPKkIH7cBs@kili>
 <70502137-6c04-4206-382d-2731a2205875@microchip.com>
 <20220615084042.GH2168@kadam>
 <f8829b05-12f0-58c0-80af-1e164f142324@microchip.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8829b05-12f0-58c0-80af-1e164f142324@microchip.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::31)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f442933e-56f3-4158-aa03-08da4eafc79a
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2393:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB2393C90EF58F52534281CF608EAD9@DM5PR1001MB2393.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fLDdOji0D62i84A7YjCJY6HBiqW9BbnVzTiJX2vzlP8D7iyysB40W6A2r/Fkd6vXg25/OVuK7HYsU/+1H9y+4kFgX3hUkZ6+ge0c0GS33LfzVEWHoi9yYDoSiEn7/yEnnnobV4XifdWYJc9Qxf0vwlw2P4A4G1WwKpizRDB3C0cvG3m3wzXsMWzfXD81aG0CJBJ8WVm2//r6pKw4Xd67GfSjZwl2QXn/0/NDZcJ+NSc2+CgulDTWcWeuqrgVOQ5UrlF224thh99oNuYOry+IoBJWjxcPyO56+aIlGeOGSYRy2ofLAVladUxF+vzsAoClGyTIK3M0XK2DXtqMoGsgLz8Hthv/sWFdhGVSgOh6HBOP9cBGXaGXOUWSQeR5xUPllRSAzIyqFw6K0RQxBiBQPpvH6T5Kni3b9MCf+dpOEpS8xhPacLyDQmKMXTgh6pcmWoSU1OnfOcMKb/xxkkhcSuzWFvs/DzKPStxExPryUqF6S9EC1kja83zOFNRGVHAa0mlKTXNUFU59zjob8Z4Jui9G1ABp7kgFXHXM5AlHqIIizf6BNctaG2XFML16LRAIecAN2jKunYaSpbj6WorBVXafmXTg0ENUEDLixZFB9Nt4yNr/0v8AGcnoGAfbkCTqUv5mHDV1hADH/UbG+HycWiDUDXAVbbf96bsZXKf5GL6R6ui2kCje2wthIw/Up00T3OAF6Ip4ZZonLyAziDv2fw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(366004)(6666004)(6512007)(26005)(38100700002)(2906002)(6506007)(8936002)(33656002)(6486002)(53546011)(52116002)(9686003)(38350700002)(86362001)(44832011)(508600001)(83380400001)(5660300002)(186003)(1076003)(6916009)(66946007)(66556008)(33716001)(66476007)(8676002)(316002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lnPbyXBVm2rrp+jvr5IKC9f7ERdB5qA4+CRF416O7RD3XKysolEzYK/B7jEd?=
 =?us-ascii?Q?A9lVracJS1ljIcPOqmtR6QW6ox83BJ8J67hdGxxOcW05wks+8q2KsmdbTgjo?=
 =?us-ascii?Q?Qp2v4psplKS0iG4g9SMeQ0eqF00U4L2YUoxHlvm5k+EuEFxxWWWT6xiWh/8Q?=
 =?us-ascii?Q?pAHQuyedWr/4uJzGLfRBrwPfSeOlNU7ThMmBg2W/KqBCL1cmo8b/ezmv8RUr?=
 =?us-ascii?Q?rPzcZxaTvCrFS2aoczEooFiN0eTdvG1RaVXXEcY9TAOMRp+PK6BaDpGqbENJ?=
 =?us-ascii?Q?lL49KXlkBbNSmvVEuIUHJlpZsMze5g8yETYPDrh7aZLvvHM69wtTuP6jyYm8?=
 =?us-ascii?Q?Ye5uaOwwo4sXWXY/AMcQWpzTsPcGqN6pIiksueSmUsgGAFjf2I6WX1LvEeu/?=
 =?us-ascii?Q?blbI2Gt5F+lq8oxVchBRz6ussdFMucH6K6fmR4xaCLBr74ncFFFZw9f1Ba9V?=
 =?us-ascii?Q?K5fDs6bOYaFXrUj60s8FzBr8+4H7a3VPboN3/jsxgh8Ab3rhxc6YMdPoOQwt?=
 =?us-ascii?Q?IamS1n58wGqGVhjhbUp9hi4PNweYNdE1cIWlxJLIPlb55ntYikrYlORZUV/p?=
 =?us-ascii?Q?+WcYOmlJgjDZLlJ2V6K0LuG0wTdPuu04QTzsn1DfVaSvfcquSqlugXaDnYmw?=
 =?us-ascii?Q?n9kxMQQ+JVWJL20dJIQo8fZADUINJDeEvtzcPAnYf32iqz/UZCGXm2g5BZvK?=
 =?us-ascii?Q?z9Fw/BNVNbq23egl0ZpL0u+Z5FBCZn0RGnu/Xl85TtDwRsWsOlJPhOA97uE1?=
 =?us-ascii?Q?0HhpcGzuusiCc8ZxP0RDZa+sNTcn0KnmLfU8sR7ZTA65uy7kKNvBzF22eX8y?=
 =?us-ascii?Q?p8a840NRMV3eg5mXj+3uqIzQyVd1K8ihVAruTSuyNmUtSTSZxfNtcHq3J0PL?=
 =?us-ascii?Q?fH+9gFFunR7RbK0fS+OFLg8c6ZlG50fX84WJU+GkM8VfzdljAcnfF+QI8pj1?=
 =?us-ascii?Q?/b/C4xW5Ygti9eEYsP5tEAHZXC1DxFpfTvKrDTKX3fVcGomKe2LPgbZbqQmS?=
 =?us-ascii?Q?3zCWRwdszL148D6xW8PQgAouyn4U8ah8R2MzGqoNzPN0UKHunLNdx9E8tD/U?=
 =?us-ascii?Q?ADbqJ7yIiAtYDRrHMC+pBoxGjwDquFXkYpzX40dPDPsPUNmRIMYwtOGtFECS?=
 =?us-ascii?Q?MazRkwKB4s+pOwXPDQX5J8g7arVcrZYjIc8EMgxTwqztx28tYDa2JcbnTEO+?=
 =?us-ascii?Q?X28T91WZHOIVRJAzwIbhS4SCxSgE8TlaVRF9F4yBo/T+Gfo/rNG+Bvlj1s5q?=
 =?us-ascii?Q?dlMvH3XbJLkwVyG/CmcDxc4j9+bYgTY8KKWcDnPIs9AG6mfy0cWsNlqAcOWN?=
 =?us-ascii?Q?FvGgHkKg1/zJYVyw4I7oWn0vLeeAQT0cYFJe1sGfRN+Gie6IqYONwZ7/4u45?=
 =?us-ascii?Q?GyY9T2/ZOzl18Y+FPTznn0x6tvEUGkJngj6XwUJsx/TP3AQv1gFl30r5JYP8?=
 =?us-ascii?Q?LS7xFCV8b2vGDfNI5vfrUeGBnmViuHyWdv6CXQ9RQsud7P9mHnLlD6Nvwx88?=
 =?us-ascii?Q?gUWgiaXBBPcuas7Ik3QCVv2WirXKv3AXSgi3a8/bl6aL8h59cYUaMvdA2Mlw?=
 =?us-ascii?Q?c1mFy5rPDg9hSjAPBIuMx8Ey+HlZq+m8c8ftEoJAJxLg+aJFGo9+bHnP/igS?=
 =?us-ascii?Q?g0JY/I09eGi8GqCDvjP2xR0oVSLXTnUFObtrz2dXurIzqdJ7RxM8Qx7YSWQm?=
 =?us-ascii?Q?zk7z1aYJ14GajB2MhZaiHo+SndNAyT4UhkAE29I+0yTzhf6sr4KaLqA3FX7s?=
 =?us-ascii?Q?4nAtR2/vfUN5A9ytD6a37257xf2Wo0Y=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f442933e-56f3-4158-aa03-08da4eafc79a
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 09:16:50.2954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: milzLPYMWrrLkqww++4TYFiFtnfzyOH9N0rr0X+pWEycjDHi3Wqr8Qpv2M2Alwox5V/fodJjaUGnAfwqP6OY9w1PJGmclQpY4rIBEopHDD0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2393
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_03:2022-06-13,2022-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 mlxlogscore=668 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206150035
X-Proofpoint-ORIG-GUID: iJIr4ScEcZ4pvdJM55vHAzctT5VjdiLD
X-Proofpoint-GUID: iJIr4ScEcZ4pvdJM55vHAzctT5VjdiLD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jun 15, 2022 at 08:58:53AM +0000, Conor.Dooley@microchip.com wrote:
> On 15/06/2022 09:40, Dan Carpenter wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On Wed, Jun 15, 2022 at 08:33:35AM +0000, Conor.Dooley@microchip.com wrote:
> >>>       541         spi->irq = platform_get_irq(pdev, 0);
> >>>       542         if (spi->irq <= 0) {
> >>>       543                 dev_err(&pdev->dev, "invalid IRQ %d for SPI controller\n", spi->irq);
> >>>       544                 ret = spi->irq;
> >>>       545                 goto error_release_master;
> >>>       546         }
> >>>       547
> >>>       548         ret = devm_request_irq(&pdev->dev, spi->irq, mchp_corespi_interrupt,
> >>>       549                                IRQF_SHARED, dev_name(&pdev->dev), master);
> >>>       550         if (ret) {
> >>>       551                 dev_err(&pdev->dev, "could not request irq: %d\n", ret);
> >>>       552                 goto error_release_master;
> >>>       553         }
> >>>       554
> >>>       555         spi->clk = devm_clk_get(&pdev->dev, NULL);
> >>>       556         if (!spi->clk || IS_ERR(spi->clk)) {
> >>>                        ^^^^^^^^
> >>> NULL
> >>>
> >>> --> 557                 ret = PTR_ERR(spi->clk);
> >>>
> >>> ret is 0/success.
> >>>
> >>> Normally when functions like this return NULL, you're supposed to just
> >>> accept the NULL and add tests for it to avoid NULL related bugs.  In
> >>> this driver if spi->clk is NULL then it leads to spi_hz == 0 which leads
> >>> to a divide by zero bug.  So it's not clear which way to go on this?
> >>> Fix the error code or add more checks for NULL?
> >>
> >> Am I being dumb here, or should the null check just be removed like
> >> every other driver? As in, devm_clk_get will only return a valid
> >> clk or an IS_ERR() condition.
> > 
> > It can return NULL if CONFIG_HAVE_CLK is disabled.  I don't know the
> > hardware or if that CONFIG_ is essential for booting.
> 
> Ehh I guess it is /possible/ that CONFIG_HAVE_CLK could be off
> if someone is accessing the FPGA from another device.
> In that case, neither option really particularly appeals to me.
> Just return -ENODEV I guess?
> 

To be honest, I always prefer just accepting the NULL check and adding
the checks but also philosophical debates are kind of a waste of time.

Do whatever is easiest.  :)

regards,
dan carpenter

