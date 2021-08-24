Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5683F6A1D
	for <lists+linux-spi@lfdr.de>; Tue, 24 Aug 2021 21:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhHXTuo (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 24 Aug 2021 15:50:44 -0400
Received: from mail-eopbgr60113.outbound.protection.outlook.com ([40.107.6.113]:4065
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231294AbhHXTuo (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 24 Aug 2021 15:50:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=et+UQ5wTcHK0H8TQxrsSnr2YdyJz91JIaru42ZseSulLavqzyGJUQ6a+VGEFAa0PV0r+5M4YzV7XpZ7EcOHdctgRYck1XFMMoP79xS4HrWzFiWH5nZhgdGX05NSKVaWNQc31bilWFmxeeH3EPmx9VNi1R4O0AWWR37CT1U9PSU7YjBkXX/ZzCl9z015oXwZCi8MAghgf9AVlOQJkzwUr6xXcTrgoX5DTtRhYUOLUGvIPcNYAjtMfZhFb01CYvobtjdhtnfuT47+yn8bMssiIy4MkBF7FXl7cBmTOEUte2Kf7OlhSedYdJFmRijdSscHiI5eopON4i59RNbD6Pf96uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lx0mi1QpV3Izm7gDag154mmXAaH6kdGgOiXdj0TknUo=;
 b=dZj6lEwCtRHnknAwtIvlbUSoeATX/i+Diye+vK4PE+/OO+DdkYFiLX7lIpL62i6RCo+z2kTXRBRXoBEF7WEihyvfcoi6vZdw1QDIcR2veLoi/VxdaAoF/ZWozig9Qa2CGzdDYqNUGOXwdnr5UzzsunHIVuz0jNYNm8xXR1VptA7tK+vNfe7mmGqgk1Tc5bZsolO0VTEzggBIBZjRFYbhTKNK9+Nr7CeahXJTVLcYwhPMXDTCsFHJVoaF7VZJLNCAhrUgkiv7AoxgTv5IugGzePCiGcxBaO+KTfB04YVlhYiR8eXTSdQEPjTq/lyj00k7s7gn2fzTpA2FZ9Ri4Xu+EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lx0mi1QpV3Izm7gDag154mmXAaH6kdGgOiXdj0TknUo=;
 b=u1s6dtT8y1Kyq/4wHIro1CLnNSZwHvrZaWYV071U9Yev0oUTcGKsWy1WjfaNzelTsUjX7SLHjCBbe8Sh8aUSLhkq/zQR71+gpXF+lVQgqk5lrWgQvQqC5jecSpAtxoI/V7Mdk1OqS37hVVbtp6IGUN/0g7Bgqoqc2BTuEyYs6sU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nokia.com;
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com (2603:10a6:208:6e::15)
 by AM0PR07MB4353.eurprd07.prod.outlook.com (2603:10a6:208:bb::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.8; Tue, 24 Aug
 2021 19:49:58 +0000
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::1547:7c34:364e:39a1]) by AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::1547:7c34:364e:39a1%6]) with mapi id 15.20.4457.014; Tue, 24 Aug 2021
 19:49:57 +0000
Subject: Re: [PATCH] spi: davinci: invoke chipselect callback
To:     Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        broonie@kernel.org, linux-spi@vger.kernel.org
References: <735fb7b0-82aa-5b9b-85e4-53f0c348cc0e@nokia.com>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <cf9df6a3-e6b2-4e18-5ac1-d5e8959d9fc5@nokia.com>
Date:   Tue, 24 Aug 2021 21:49:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <735fb7b0-82aa-5b9b-85e4-53f0c348cc0e@nokia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P192CA0007.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::12) To AM0PR07MB4531.eurprd07.prod.outlook.com
 (2603:10a6:208:6e::15)
MIME-Version: 1.0
Received: from ulegcpsvhp1.emea.nsn-net.net (131.228.32.167) by PR3P192CA0007.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 19:49:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4dd4ff76-836c-4a9d-cf47-08d967385a20
X-MS-TrafficTypeDiagnostic: AM0PR07MB4353:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR07MB4353549B059717E7B58859F688C59@AM0PR07MB4353.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zw0pV+/lPyV7j4764Ke5fwUcdWN4ec6RW8G7l0y/4SnHOW5Mq07pWA56551GJE4XxnQfNijD93TNlk11rzMHiZoC4mjY7kWCp8ZhU/uNwpk9e/EZHqLKdreo1WF7GdwRM4Knpm+6toWziKRok3wBnUq0uXTF3Zd+sYeL5D6gVQBQAi00NA95ptfKT1jJxzaA7tw6P0nq3xgBL+DgoG2qzZ5r1OySBAFnU+Bblsvjzu8DBfNesGSqRKrHx0QShb1j3Xnnikvx2/iUMiz3l1XDMOJoRow81lvRp7gEUoMfKqRafEYyeZkTktGJH1eHKBWV/IfpnksJ/aT1Vc6bn+et0K0l6XF7d2k7B9t2kLIzqlkQThMQ+3g0Rcr37IsO9+kEw2A7P+a3X8bZMKZZ4f6zqEZwcdmMT5M+QpRXdhcNoPETYoVHl9WU1ZkO+mUJkwiTcKz/5JJtw4txTd6ql2DUPK5r4Qj/oFvThxvs7Ur/UBIW9+NDrC8rwBl8vmktwkZY2yPedmJAiQLJUhCdpXIXdgnAmrONR6CeZNTOWUwqZUIz3wu2gGWj3bpICUgo1+evStrXH+zsLb/aENGPtsjPepc7HCXhwh5M+tCeTsRxTFL+qXTv/KBm8/jNurNHcLy70lWS8qFingNAae5mJHjcmamIFKzmGCoFfkU89YGHQKgky8ShpxGDAF7TEnCkeIfrFmco7flYY+usMln3BO0RIoBj1CfcXWHLWL7s+gPLIcL88x2Aw8a64PBBBSsHph5Vjftqy45XKJkNq94ZBl0oFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4531.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(52116002)(6666004)(316002)(44832011)(83380400001)(478600001)(38100700002)(2906002)(6512007)(8676002)(53546011)(6506007)(66476007)(5660300002)(8936002)(36756003)(31696002)(31686004)(86362001)(26005)(2616005)(956004)(6486002)(186003)(66556008)(38350700002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDFuM29pSXBvc3VzNWJueURBeUFkMGJYd2gvbktGVnltSUxIMlhLMHJDQVlK?=
 =?utf-8?B?dDErN2svdWk5dzZFMlJ3SGc4MmNGaXR2aXFxSGQ5K3YwaFhqZHR4aVc0aXRF?=
 =?utf-8?B?T2ozelVnSHJRNDNROTJ0VXlSWXY4Zlp2dFJ0S1JFVVFXRW01YWxCWDNsM1FM?=
 =?utf-8?B?RWM2azU4c3FRWnNYS1lQTTZQR1JTSGlDNEJtN3lmeFJuS3lSYjJKb1Rmc3ZS?=
 =?utf-8?B?cW9wejNlM2o5bDNBSlMvRHNCSVVYV1NTei9rN1A2THB1cnVGL2VpaUVQMS9V?=
 =?utf-8?B?MXRQT1ErMXdMZkRFU3pwWTJ2QUJqc3M1MFJ4cmJIcmhlNkcxY0pOTlh4U0Fz?=
 =?utf-8?B?WVhBT1VqcGNvQkFIYXM0dTU0L3M3R1RhSHNqMVhtNzYxeGpOeE41Sm03dXVP?=
 =?utf-8?B?c1Q1VGNKTjJvV2ZqWUIyd1ZXcUQ3OTNSQUlNZWNsQnU4ZWVQbjRIYkVvQk53?=
 =?utf-8?B?U05aY3RuUUVnSklCdEZVRWNKM0NodXZqWFRMME8wcDZhY0ViOE1nZG50V1Ru?=
 =?utf-8?B?VWJYY1Yxc1Z6dCsvbmZGRUcwSC9VbHAvWTcrVGVibmZrSE9ObjdRNXZJTnB4?=
 =?utf-8?B?TmJoc1p3aHYvUjFIUnQycmtpTFl2TTB4ankzQmR4TWErQWdIMFJvdDhjRGlY?=
 =?utf-8?B?b3lHelZXb0JPVktSdk8yZmRpZzR2UXpDbDRPVVNHYUVodldpODFpWUs4cThE?=
 =?utf-8?B?eU9oV21iaGpLQlAvbFFENzB6KzE2eHVGb2lNY05ML0hydnpOUHFUTTdnSHYr?=
 =?utf-8?B?WkwzSFNjc3JRaVYybmdvejJ6eTZ1c2RIWU9tUXZiWTZnK2hWWU50RVV2VlYx?=
 =?utf-8?B?TmNrYjRvRGMwME10ZzZwa1BuVU1CeDBpZjVqSklTTW5OY29rclJHUzVMRHda?=
 =?utf-8?B?QmxDSHNpVlh5UzQ1aDVQSG5xdko0T3ZrT2kxZEMvYkpzcGwrU2xqVFJBaWNI?=
 =?utf-8?B?eE9udEdPUzI3VHZydHpwdmxBN3l3cnhRSnhoNEk4MWhnVGxvQ284YU92K0FH?=
 =?utf-8?B?VXZzZzVYTTZZcWlDczY2YTd4VlV3OW5lTk5XcW5UTkFFWlNjNS94bjh3Yytq?=
 =?utf-8?B?ZHB1N2FFdnBJSUVEaVVoMDRZNmxFcnR4bEtHT0MyeGZ5QkhkcjhJUmtHTFF0?=
 =?utf-8?B?NURTZ0gzcEJnSDFvTDRRTXd4OU1PbjBIWWw4VjM2TjRBOWM5Qk83aVFvWXNz?=
 =?utf-8?B?REZVNnlxdVZPYm1ibnZ0Z045ZkszSlBnWG1SeXhkT1dpUjNDcFMxdlpVY2lG?=
 =?utf-8?B?ZHZ3WHQvMVphN1JCdGVZdWVINkFMbXJzd1FDeXJiRHlxdkRQS2d4cURMRG9y?=
 =?utf-8?B?ZmFhcUpkbXlBdmVmSEpjRDl1a0c5cUNoVy9xaWdpSzM0UllobEpTMkd2ZW0z?=
 =?utf-8?B?OU5uRTF1RXN5cm8wMm1SMzBtaWV6aCtVSGdNM1JXWFYrazR6MW5ZNUxEM2lk?=
 =?utf-8?B?UzR6N3hhbmJoMVB4Wk9XVDZvaUEwSGNpKzkxSGxxL2xpQ1FIdVB2L3dCUmYy?=
 =?utf-8?B?RlV5VlRvL2xtU09nR2JWN3VrQWpMcHZiN2NFY3NJUEdsUHpQc1FGeDk3MTQv?=
 =?utf-8?B?bEM3NWxWbFF1dXo4QTl2VU5SYzhkUEl1RnRUZHR0ekRicWI2ZzhyYkNibnNV?=
 =?utf-8?B?S2x5N0NvSFdoWEcxZWI1NjUvN2QyVmRsYlhQUGtuS3BkeCtVSHRaQUpPMVBm?=
 =?utf-8?B?cTBJbGRJTW9sUjBRVDltMFprWGl5aUJHdXNuZGl0bXBqdmltVllEOHJsZmlV?=
 =?utf-8?Q?RoSkaoXQV3uzjBMrYBUEoWvQuGzaCKErkIzfieU?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd4ff76-836c-4a9d-cf47-08d967385a20
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4531.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 19:49:57.8934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+cy7tqteIkISDjEVS4zC8iLjIgi1CwFMCv/M5gix49qe5GE5pUPrahRNCphJCGL7tgdivGOFz+Bgq3aW/OZF9zrGwx7nz2iDVg3oiihwiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB4353
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi!

On 24/08/2021 11:25, Matija Glavinic Pecotic wrote:
> Davinci needs to configure chipselect on transfer.
> 
> Fixes: 4a07b8bcd503 ("spi: bitbang: Make chipselect callback optional")
> 
> Signed-off-by: Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

> ---
>  drivers/spi/spi-davinci.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
> index f71c497393a6..c3974d996cb8 100644
> --- a/drivers/spi/spi-davinci.c
> +++ b/drivers/spi/spi-davinci.c
> @@ -213,12 +213,6 @@ static void davinci_spi_chipselect(struct spi_device *spi, int value)
>  	 * line for the controller
>  	 */
>  	if (spi->cs_gpiod) {
> -		/*
> -		 * FIXME: is this code ever executed? This host does not
> -		 * set SPI_MASTER_GPIO_SS so this chipselect callback should
> -		 * not get called from the SPI core when we are using
> -		 * GPIOs for chip select.
> -		 */
>  		if (value == BITBANG_CS_ACTIVE)
>  			gpiod_set_value(spi->cs_gpiod, 1);
>  		else
> @@ -950,7 +944,7 @@ static int davinci_spi_probe(struct platform_device *pdev)
>  	master->bus_num = pdev->id;
>  	master->num_chipselect = pdata->num_chipselect;
>  	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(2, 16);
> -	master->flags = SPI_MASTER_MUST_RX;
> +	master->flags = SPI_MASTER_MUST_RX | SPI_MASTER_GPIO_SS;
>  	master->setup = davinci_spi_setup;
>  	master->cleanup = davinci_spi_cleanup;
>  	master->can_dma = davinci_spi_can_dma;

-- 
Best regards,
Alexander Sverdlin.
