Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC50360350
	for <lists+linux-spi@lfdr.de>; Thu, 15 Apr 2021 09:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhDOH3U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Apr 2021 03:29:20 -0400
Received: from mail-dm6nam10on2055.outbound.protection.outlook.com ([40.107.93.55]:8822
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231357AbhDOH3U (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Apr 2021 03:29:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iy+PS0ONbq8ocTcYUsLJsY0oceCLDf5eURXc+DCUE+wY9Ny5nQhYHLReL2PVJU7URepinLvPbFif24CYcszMla0PYoyw2um3TFsB+7Er+Qcgfw9C47Lyh67or5gzERICkAlsI1uIEhmYQBn7DyJE1UnPBATI1FC05xEVGShQIehrUs8/XKZnQ5oZGKjWMJJDOoT3tesHMkyp0kkhpFp1CDMfHTeTE15MmjgB8qXDZSBOOqscx/jkyAfO+85yMUGYs8V7BSHUzlAcXV56RlNxHU1y12vp4fBAr1W6ZAi1UrQleicVPp4VU+kcwtdZ06zIMVdds7cx3MsEeXnkewZk/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLW1e8+szr72DwNNR90s1FDjvtLW4h57bGfEwf0n0ts=;
 b=If4pJnJeEIZ6mPtiMKv6xC/zWqNBFntc1UfZqgiN2r+kOxxNIthbjhQ4B7/JZf3J4ybAvSKtV1HhEJw41gKKJNXMwwqq6TjBDjGRTA3yJcZ8DK0k6Yp7IIw76XiywVqZB7KMasDduc9SFZhRXvTCcPszTprTa+OlZ0BcQEALwhUBHjZJ4N3pipAspaAgSCHG4nkxglVEGMmIH36plstrLySYLtbb/cnyFNT3pHhdzvNsiwIb2NU2HxdJvGQtJOMkrVppKiHTgbexNVrmE28PY5JFjfg9uvWrA3yqGaC0xzyqB2n4wnOeT5zJCHBKWOFf6ds2/xtYAHwGOKEXwawoeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLW1e8+szr72DwNNR90s1FDjvtLW4h57bGfEwf0n0ts=;
 b=BYlTu78pCKOJ3R0hIwZJtVO7l4XyN1peict3+gVXMc6C8BufPeCAO9wmFDwxs7FpqHkWFYQvhF+Mjchea+f3X3xtPlHs99WaGcQ+MeNAY6J56jRfbsSq0DFjg8c6nawBcGeoOqgX4hkV/zkUbXe6/kSH6gScCHeTtedS2dLoIQk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1718.namprd11.prod.outlook.com (2603:10b6:903:2c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Thu, 15 Apr
 2021 07:28:56 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.3999.037; Thu, 15 Apr 2021
 07:28:55 +0000
Subject: Re: [PATCH] [v3] spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in
 zynqmp_qspi_probe
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210415071714.19334-1-dinghao.liu@zju.edu.cn>
From:   "quanyang.wang" <quanyang.wang@windriver.com>
Message-ID: <a9fd2d17-ff87-f4cb-e255-8023ff0bba8b@windriver.com>
Date:   Thu, 15 Apr 2021 15:27:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210415071714.19334-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK0PR01CA0063.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::27) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.199] (60.247.85.82) by HK0PR01CA0063.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Thu, 15 Apr 2021 07:28:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0554a69e-2652-456b-eb5c-08d8ffe02048
X-MS-TrafficTypeDiagnostic: CY4PR11MB1718:
X-Microsoft-Antispam-PRVS: <CY4PR11MB17185FCC5A1C0CAC41F1D114F04D9@CY4PR11MB1718.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZIo4uaaqY9efsb2fWWz81PwTPzFRek1bc4gduMedevpWJwvKVU7kuZxV1vS7Ams3Fv0ZDweIP7P9H39HhaeW/M8PTI6V3TJfNzqjcbQMNo0WJedYAJ4tWOFJVp32ii+u8LDFISFahsW3DEO14XMWOurCydb0HnyioOtRChXMQTXDY883te3utgiZSriS4fqmJjGnC01UO/CZuQxCtGgqbQ8ajyZMxztHc6TUnS1FVwbtbx20c43fsISRN6olQn63YrM1DW24YZ2RvqMgwgbiEWr8S7glUHb5O/6XGfNi84ODJxkMDvAv6YLmoAZufy1B5clCTHs/qmb9/iH0jgrT+mjAhi7bUxraJ2EI4LUtefJswMyktDiCE2FhSvyN9dpWikqviTp89kS6nshtW1BRD75YSqGeS+kHbspiAhAiOmm4DnkzdBYoF96I2QT42kw3EGEoPCiBDVcqLvvcsJuTaBfNakTQHRGSFADUKBTvnH14L6RsNONbJydydsPcwbt2ZUy70jsxpixxQV5pXntnTSBLLoJT3TinJXMLrXTXm19DrR4pjVJPP95xvFRlxL2dkNoHTXfuyv6O30Csu5L6BgKRRN9pB0+HC/ABTfAzSEDKkvO8AVbdTF8viOBP0n+VdDRqrINxhoiXKU+k1kIR1HbgN7OhzlvfqtL5k8OhijYD0u5uMVAX9eCMCplTh68EdoZk5oXUSJwjmuGFbLCN7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(396003)(136003)(366004)(346002)(956004)(478600001)(83380400001)(26005)(186003)(8676002)(36756003)(2616005)(16526019)(2906002)(6706004)(31686004)(52116002)(4326008)(8936002)(6486002)(31696002)(38100700002)(86362001)(38350700002)(5660300002)(16576012)(66556008)(66946007)(316002)(66476007)(53546011)(54906003)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WGtVOEh6c2xtVHRueFJ2ZXBUN1d3Vyt3YnovUHYvOEsza3lLMkZPaXZxaXQw?=
 =?utf-8?B?cUh3emZHc3lVcXhoRE10S1l2QlI4d0Y0T1NJWGZKUHRnZkZxYkU2OEhmaFJi?=
 =?utf-8?B?UEtFdGNoUEdDa1I1VmNmeUZ4Q2xmWkpCOFFMNnpqS3MwZzZzdExoM3drL1JK?=
 =?utf-8?B?R2RHdVdQdUdIZDc4aVl0cllFenRJd3o4aVRobnorQVhMZHBTOE9ITVZBTWc5?=
 =?utf-8?B?SXlxRWplaGttRmdTR0h1dnZCclQwZ2VCaWNPOTBlN2FOeXpCWmc5Z3lnU0RH?=
 =?utf-8?B?MVlrRmpJR0xVeW54aW5BZTlkMDFCR1hXbmcyYStxK2lkRTR0ZUdLK0h6NURm?=
 =?utf-8?B?WG92Vnc5aFBTY21TZnpoRVdkUFk2aHRrRmlLcW9wdSttTzF6ZitWdnl1T09M?=
 =?utf-8?B?elhLMld2bzExN2k4ZHJwRit4WUVuNFNubllFUUNMTy9yanBZaGJac3dKUUM4?=
 =?utf-8?B?RjdscG5xMEtkZUVRQlVVcUpzYUdCVXRnb2QrRXlvRlRxU2RTTzlDL3F4dzlK?=
 =?utf-8?B?dU1uV00zUkZEU1dEZFJYTkNxdkpRNUFaT0NBYTVwRDZDV1pEUnc1bTdSL3pn?=
 =?utf-8?B?cjFNUUVCc0dzc3BxejYvWHlMT2V4MEU0SVgycVlwSy9mNlozR1NBYmJwS2tX?=
 =?utf-8?B?SWdqYVN2SVNQWXRmK3RQekVhSjZ5UUsxZDVSanppSGMyT1haSWJDdmMwaUxl?=
 =?utf-8?B?ODdZZzJaODdzYU5MWWlHQlNjell2WUJvbUU2VHltWTVNT2FrS3JSSDd0M3No?=
 =?utf-8?B?OUl4bmxPS2ZrQjBoM09VT202UEhtK0dIZXpueTVGTXg4aGp4YThkdVp5cXJ5?=
 =?utf-8?B?Q3lrR0JYWnYyNFlPcHlacUJMdEYyQ3RaZXpoMWFTY3laY2lmTktsN1VWZDVh?=
 =?utf-8?B?NXY5b2lJMEFFRktGZW1aZTR1YUNTdGJjZGhlTTVnZi9xVVo1Z2d5bDY0WnBl?=
 =?utf-8?B?L3VxUFR0S0lVSjdFK2wrd01ZM284Tzloa1VxWWdRT05lTTZvS1hVRDBTaDhI?=
 =?utf-8?B?bWk4TUQzK29VbW0wOXl1dmMrU0VEWGhYaDFBQVVzUklZRFdUZXJuRHRoaXU0?=
 =?utf-8?B?S3l6TCt5a3U1dDdPQVUzRUtKMUoxSjZpK2VkMDJFdkNQWVpuemdkeVNPdUE2?=
 =?utf-8?B?aW1oVnBDK2JBaVJ6Z1YxWktRYnRHOThJZXF2YUhha1J0alBrWDVCTGpyajQx?=
 =?utf-8?B?KzN2OFhnL2xrd0ZIa0RGWXEwckdzQ2lJOUtZV0x6ZGgraUxEc3VBMHBIa1JD?=
 =?utf-8?B?R2lJbWgxQ2MrOTJnSk9oeDVSSndsT09mZXV0cFhyTkp0MEFGbzRSTytpRXR0?=
 =?utf-8?B?WVZqdldiaW1IT3FMT05NQnpvQS8yVDBHd21IeTJiWjF1UXpjd3p0Y0YzS2Ux?=
 =?utf-8?B?RDhFNXk1elQrVUVzUEhkaEVQS3RpejdVZ25ZK0cwT2hjK3Q0YzRNdUtEL2dM?=
 =?utf-8?B?ajlJRmR5RjNHQVBKSUJLRDJtaFBPUzlVMUtvcC9zdVBNZVU1cnZFUTNaL2Ns?=
 =?utf-8?B?ZE1DazRlSEdCZU14YzhZZkN1UnVKUEl1bTdnSGJGcnU5cXV4bzRnaWFHbjdK?=
 =?utf-8?B?dDR2eVlGTFppeDRrb3NHUnZET0pZQTZiaGFnSG55bkJ2WEhHa0dTYWlFb2FC?=
 =?utf-8?B?MUJQbytBL2hOUVBLM3JkUTdhcm5QdXU5eVBlUzBLUWpaR2pkejhvVFhIWTI2?=
 =?utf-8?B?cDE5aUlmVXZZNkZvd3Z4YlhzNFgxTVRPdEhXdXA4M1Y2K21KRUtLbFVCR1Vs?=
 =?utf-8?Q?47tDc1ImAWge4NGMDtesiXCQ7lAgKeHdLbOJBId?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0554a69e-2652-456b-eb5c-08d8ffe02048
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 07:28:55.3541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFS3F0WdPnliDyfZESbqq2f+6Y6xjIQmCZW/tDtvH9MJ3SX5BwfQVGWLbP5mFhjFpzdyMdomQVxe9oD+oM2hEZTs2ngWz9YcCS0rVd9sac8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1718
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Dinghao,

On 4/15/21 3:17 PM, Dinghao Liu wrote:
> There is a PM usage counter decrement after zynqmp_qspi_init_hw()
> without any refcount increment, which leads to refcount leak.Add
> a refcount increment to balance the refcount. Also set
> auto_runtime_pm to resume suspended spi controller.
>
> Fixes: 9e3a000362aec ("spi: zynqmp: Add pm runtime support")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>
> Changelog:
>
> v2: - Add a refcount increment to fix refcout leak instead of the
>        refcount decrement on error.
>        Set ctlr->auto_runtime_pm = true.
>
> v3: - Add fix tag.
>        Add a return value check against pm_runtime_get_sync().
>        Move pm_runtime_{mark_last_busy & put_autosuspend} to the
>        end of current function.
> ---
>   drivers/spi/spi-zynqmp-gqspi.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
> index c8fa6ee18ae7..781ef3fc76e2 100644
> --- a/drivers/spi/spi-zynqmp-gqspi.c
> +++ b/drivers/spi/spi-zynqmp-gqspi.c
> @@ -1160,11 +1160,14 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
>   	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
>   	pm_runtime_set_active(&pdev->dev);
>   	pm_runtime_enable(&pdev->dev);
> +
> +	ret = pm_runtime_get_sync(&pdev->dev);
> +	if (ret < 0)
> +		goto clk_dis_all;

Would you please add some error info output here? Just like:

+       if (ret < 0) {
+               dev_err(&pdev->dev, "failed to pm_runtime_get_sync: 
%d\n", ret);
+               goto clk_dis_all;
+       }
Because sometimes it is very helpful to analyse probe failure.

Thanks,

Quanyang

> +
>   	/* QSPI controller initializations */
>   	zynqmp_qspi_init_hw(xqspi);
>   
> -	pm_runtime_mark_last_busy(&pdev->dev);
> -	pm_runtime_put_autosuspend(&pdev->dev);
>   	xqspi->irq = platform_get_irq(pdev, 0);
>   	if (xqspi->irq <= 0) {
>   		ret = -ENXIO;
> @@ -1187,6 +1190,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
>   	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
>   			    SPI_TX_DUAL | SPI_TX_QUAD;
>   	ctlr->dev.of_node = np;
> +	ctlr->auto_runtime_pm = true;
>   
>   	ret = devm_spi_register_controller(&pdev->dev, ctlr);
>   	if (ret) {
> @@ -1194,9 +1198,13 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
>   		goto clk_dis_all;
>   	}
>   
> +	pm_runtime_mark_last_busy(&pdev->dev);
> +	pm_runtime_put_autosuspend(&pdev->dev);
> +
>   	return 0;
>   
>   clk_dis_all:
> +	pm_runtime_put_sync(&pdev->dev);
>   	pm_runtime_set_suspended(&pdev->dev);
>   	pm_runtime_disable(&pdev->dev);
>   	clk_disable_unprepare(xqspi->refclk);
