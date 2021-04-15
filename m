Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2349A360428
	for <lists+linux-spi@lfdr.de>; Thu, 15 Apr 2021 10:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhDOIU5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 15 Apr 2021 04:20:57 -0400
Received: from mail-mw2nam12on2081.outbound.protection.outlook.com ([40.107.244.81]:35297
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231518AbhDOIU4 (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 15 Apr 2021 04:20:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5FhEkhrOwCLHdPWK2S+DYEn5PpP4N51bPA4usrOmeU08P5lnGGHEoNVlF7/nNGhU8X3eTdCRt6xPeGwhhHk6Y5Vh/B48eG1lnh/M+KTCvh91IdeEDr1IEDBJP7RQKn5uXykqPozrgrQy9GR1AaoysIfWC4GOV14nUhgbedyUWakKaAXsOqNm+nRDiBqg2tFLOK1SK9b2kt9+fHnCvwzpOpCJnZoGkvuZW+Cp+Q1hNCv2AACTld/LOMJ07QwnKbZJ7Jd+RlCfN8b3ice73twLd8GJ8Y8OrdfGowN+QUIdIFDojbHloqB6nOgybykkbFrPurCY4QpYp8qcLmj3nkS4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biiP+f8iKsYkPECa+JeQzboeGU7/0CaFI0x4H007pqA=;
 b=LNx0Dz3t8f/ofJxG2fOYofDrv0VSPlMG4QoYhsrXluXk4qt/dbL3nlTX0s6s0O/NzCddVUqNLjSqzwhPf1C3Yn6dv1s3i7Fz9AtIzQ0cYjAd1JJQa1fiumIM44nq4BocQI86Kh+pQLQKV182bS3pkSEpy4htIy7shVVoI0kWF+EXgADtz4vXmn4mkgba8jCb245RgcQk5Iwn6xNvOSeJjhrLwdoWNwX+uh5Qn9fFM5OwYqSW7+JkZuwjxd2l8VapOHdaA5pEqsShV4TKgU2+1rMl6UYrLTpBfKFAyOf1PQ6hSvQVHgkfluImICkngbH/lKnzGCdqmMkeOk2Zuu4Vqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biiP+f8iKsYkPECa+JeQzboeGU7/0CaFI0x4H007pqA=;
 b=Up4VMacvkR4KFG1SkJtbPU8IJ6sgGE8OH3PhpW0SU0uW5AiAEMwcEura9O1bsraPzZL3LktXp9ctIdwIce29Y8AUk30rsj6UzxEpvrGlobE+w9tgGkH9s69Pc1HFh0HQDayU3N8JXE5/p6uJlqDqm2dnjyzutOjuMh0RVSWuvUc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR1101MB2149.namprd11.prod.outlook.com (2603:10b6:910:1a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Thu, 15 Apr
 2021 08:20:31 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::f45f:e820:49f5:3725%6]) with mapi id 15.20.3999.037; Thu, 15 Apr 2021
 08:20:31 +0000
Subject: Re: [PATCH] [v4] spi: spi-zynqmp-gqspi: Fix runtime PM imbalance in
 zynqmp_qspi_probe
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc:     Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210415074644.24646-1-dinghao.liu@zju.edu.cn>
From:   "quanyang.wang" <quanyang.wang@windriver.com>
Message-ID: <59f9e657-37e8-a91a-08a9-d2bdb734d9cd@windriver.com>
Date:   Thu, 15 Apr 2021 16:19:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210415074644.24646-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR06CA0006.apcprd06.prod.outlook.com
 (2603:1096:202:2e::18) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.199] (60.247.85.82) by HK2PR06CA0006.apcprd06.prod.outlook.com (2603:1096:202:2e::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Thu, 15 Apr 2021 08:20:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1474b319-4085-4217-4fff-08d8ffe755a6
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2149:
X-Microsoft-Antispam-PRVS: <CY4PR1101MB214997F5A3982471380F6CFDF04D9@CY4PR1101MB2149.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ADlGFt/hUazj2wGbDxRJC5MHoYiiKNNrLQP0oBBucA32/uvcQ2vGUthIpcnEBHnUgBlUOguiZ2mNTQsyQ4RBL6vkCMowzSfGOunkG3svqVVjLGOIlf8XQc95qhf2tdTH3L/6FS1kfiVPKFZok6n5kEqVUofZgcPQl73hqGBc55NgTLyKDuOsIU2+X1LMLvl+nZ7pxr69dk1s1024RgMR6e2Wea9qJ3OxmFXY12sr0iPupyy1GRLtm4SA5mQuZkUFTZHRgtiIdOZuHwXey7l3lr87CNkD5gqZ2vxuLg1KbU/H42L+OOPUk/sbKkxPq3DNIm3koYvWj0cRDKqancjrjzTeCp0u2JfXAPLqXaqSEc3IFhJWuLIHa9ihXhhgZoR2H1tkT+AOvE9FPYKuHw0rMmDSHCcbED7F24Czb5C+QtXOlEKhah/Bym/ZnI18VS5zfSXBVAELkqwWGfJBOwc/m2UWTvYo47C8QiC0yqKBA3D8VzQTjc5e6tDUCPp5KaPvfc8QvZ46U2tzW82JtmquJX5biv+uG6HG6QgJHy13UQH/0eM4dgqYAxD8jFDBbjaNNqvdbvB24BBSfhYagJ1rHagPSNIe6+t3PeWbBnmUPZj3S+C3zIHcgA2lEuPEZVnzvzljpJnXv3jHDtG4qiH7WPuErHNszSdoJOGJs6M2tp2fdmPDhnNolUAAQtKsK9VDraBF5LUzftggWX+6zUVRIMFqLyy5fQCz3RwEVVGFYHhTirBrRNF67RIpWvmbi5Bq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(39850400004)(376002)(396003)(136003)(53546011)(4326008)(6486002)(66476007)(36756003)(8676002)(26005)(66556008)(31686004)(186003)(66946007)(5660300002)(16576012)(86362001)(316002)(16526019)(31696002)(54906003)(6706004)(52116002)(956004)(2616005)(2906002)(38100700002)(83380400001)(38350700002)(8936002)(478600001)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WXRrOGdCMGJ5Y2dWOXVxUkRRTzhsQndqOW4ySEJoLzNjMmZpVU1PMXBYTk0w?=
 =?utf-8?B?Rjk1UmdtRnVza2pyRGlGNitQOEd3c3dLdkhTZC92c2w2ejRONlpSZU8rY1Qx?=
 =?utf-8?B?SHpwOHgvMWI4RDNZcmlpbmhhMXFxWHJiVXpsZ3cvT2ZOK1BtM2dENFg4aDF2?=
 =?utf-8?B?TUVON0dOcDBpQlRHQllxRjM4eUFQeFd5OFZNajhIei9DNzhMSW9vTFFpaFFk?=
 =?utf-8?B?U0FBNHhMN0xqQ0E0dDhSSjd0bzZSaE1yVU05VUVUQktJQkdVYVlHQktieVN0?=
 =?utf-8?B?SmVYaVJacXVQQWxlR2wxeDAyWXdMb2Y4NVNCSzR3VDIvRmsydUVEOHFQQkUv?=
 =?utf-8?B?OCtnUDl6ZTJYdkhSUHVLR054ZnVFYnVEV0ppWk03MnJuS1dOOURpSHE4Q0Jt?=
 =?utf-8?B?WXg0ZlpZL2pqRHhWaGZMcFdyUXY4NTAxeDNFa2paSWl2VitFM1JKelhjcEE3?=
 =?utf-8?B?TERpakw0S0VxL0xVZHlGVGhDdlZGSHV2WnVHeTdBdGgwK3lFcVl1cmJkOFpW?=
 =?utf-8?B?OERYVTZDK0VleU05OGJOL0d4d1BXWHVVZk9kNEVPMGd1bzR0eTIzd3FCZWhp?=
 =?utf-8?B?RkRXc0MvTHduS0VlZ3U3RC9Qc3dvM1dsVHpqRlJvUzVPNnROKzVIbk1UbmVu?=
 =?utf-8?B?Z2gvVTdDOEdZMWw1NmpPNnhnZXJmWVZ3UGVYcDV3MUV0V1AvV0VjWThvcVBk?=
 =?utf-8?B?YlptRjFvNzcrZm5yeS9GK3JHellGZjVOcHh0VUdIb2h3eW5CZW05bzhPV1kv?=
 =?utf-8?B?NWxKZy8vYXNRZVJVZ2plTEgzVVFrVlhPakQ0Ymt3MDZHdW1GVzFFb0Fma1Ja?=
 =?utf-8?B?QzZwQ3JRdkpHRzRBNkxTQ2xDamlxc3hDVVB2cEZsYzlwV3JYSUorZWh2R29E?=
 =?utf-8?B?WHNtaEJKM3h4d3EvSnN4SmhFN25UR2taVzd6T1pCQXZ6N0U0bThiZnN0c0dK?=
 =?utf-8?B?bGlwV1FhM1NmK2tTc1hCalJlQ3dyRFRHY3lBVG9ZK0NnZmVFdjlvQWlpVHFZ?=
 =?utf-8?B?YVFkZjJ6Vk9OWkcySnIyWERKbkdTdyt4Y3RiL0ZVYTFXU0l3c0VxbGRtekZL?=
 =?utf-8?B?MS9QeFNicWhjMk51YXNmeFQ1NFBacUM4dGlyRFFtU0labGdMWWZXOFJVOXFK?=
 =?utf-8?B?VnM3U0ZRbmdRV3dIMFNqNmRnc2t5NjRPQU1YNkdZeDAwVnZYT0FXSDNzUFpX?=
 =?utf-8?B?NEFPUzZ5K3kyZkJKK3Z0a0d3LzlqelcyVHYvaURrWTZnTHVMWjVMS25iLzFD?=
 =?utf-8?B?K1BhSVpoYlJha2NoL1V6MTBnbzVWbkdwUWM5V3BTMGZqbWE5YzZaTksrQ3lL?=
 =?utf-8?B?VE1WY2dPdjR6V2dYd3NjTTBqV1UwQUxybHJRWGRWV0dnN0JJUEpRdUlPRlM2?=
 =?utf-8?B?aTFpM0JwT1lZN3VxSWFSd2pPS2JKQUluSVFxZG5pSkx1aXMxd056bE9hWmpw?=
 =?utf-8?B?bEoraXNsOW82TXUzbmlmUURCT1RNQmtGRW90eGhycnVYNkVuZzJTSC9Sc05x?=
 =?utf-8?B?TGhCMGQzSmNLM2FMcnp5YWo1RXJmZVE3TWloZ3dDd2UwN0ViQ1EvcTdNWVBn?=
 =?utf-8?B?TEtrNkNJTDNEZUlYR3JtZFNxMStmLzQ5NXFpc3RVaFBwa0FxdEIwT2NCODVs?=
 =?utf-8?B?dnVUTFR3OVZiV1RPT0crZWg2Z0J1R0dmOE9ZSW1OclkycUFGWnFnK2pKRXJE?=
 =?utf-8?B?c2lyOUJoNzNabUQ1VGgzbEFMVzhhd2dtaU92VDI0dEl6YXJhRWVvTW5rd3V4?=
 =?utf-8?Q?faTMBzrmufCvAbq53+ZaBlC2lalY0o6h50eXWqi?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1474b319-4085-4217-4fff-08d8ffe755a6
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 08:20:31.5304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQnwdl3Uc1FX5xsYG2dPcmDjc5mi2gCVOvLNDaY+zMN7Yvfq7ntROdKrlYqvDGxWZST3o2K1a21Vsz7aBNqMZNtVrgD1dM0DkNmYStUeATU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2149
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


On 4/15/21 3:46 PM, Dinghao Liu wrote:
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
>
> v4: - Add error message on failure of pm_runtime_get_sync().
> ---
>   drivers/spi/spi-zynqmp-gqspi.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
> index c8fa6ee18ae7..38f3ddd3ea7c 100644
> --- a/drivers/spi/spi-zynqmp-gqspi.c
> +++ b/drivers/spi/spi-zynqmp-gqspi.c
> @@ -1160,11 +1160,16 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
>   	pm_runtime_set_autosuspend_delay(&pdev->dev, SPI_AUTOSUSPEND_TIMEOUT);
>   	pm_runtime_set_active(&pdev->dev);
>   	pm_runtime_enable(&pdev->dev);
> +
> +	ret = pm_runtime_get_sync(&pdev->dev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "Failed to pm_runtime_get_sync: %d\n", ret);
> +		goto clk_dis_all;
> +	}
> +
>   	/* QSPI controller initializations */
>   	zynqmp_qspi_init_hw(xqspi);
>   
> -	pm_runtime_mark_last_busy(&pdev->dev);
> -	pm_runtime_put_autosuspend(&pdev->dev);
>   	xqspi->irq = platform_get_irq(pdev, 0);
>   	if (xqspi->irq <= 0) {
>   		ret = -ENXIO;
> @@ -1187,6 +1192,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
>   	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
>   			    SPI_TX_DUAL | SPI_TX_QUAD;
>   	ctlr->dev.of_node = np;
> +	ctlr->auto_runtime_pm = true;
>   
>   	ret = devm_spi_register_controller(&pdev->dev, ctlr);
>   	if (ret) {
> @@ -1194,9 +1200,13 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
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

Test this patch at zcu102 board:

root@xilinx-zynqmp:~# dmesg | grep domain2
[    0.905407] zynqmp_gpd_attach_dev() ff0f0000.spi attached to domain2 
domain
[    0.912390] zynqmp_gpd_power_on() Powered on domain2 domain
[    4.350331] zynqmp_gpd_power_off() Powered off domain2 domain
root@xilinx-zynqmp:~# flash_erase /dev/mtd3 0 0
Erasing 4 Kibyte @ 0 --  0 % complete [  153.125894] 
zynqmp_gpd_power_on() Powered on domain2 domain
Erasing 4 Kibyte @ 2e8000 -- 49 % complete [  156.134884] 
zynqmp_gpd_power_off() Powered off domain2 domain
[  156.142648] zynqmp_gpd_power_on() Powered on domain2 domain
Erasing 4 Kibyte @ 5d5000 -- 99 % complete [  159.148329] 
zynqmp_gpd_power_off() Powered off domain2 domain
[  159.154579] zynqmp_gpd_power_on() Powered on domain2 domain
Erasing 4 Kibyte @ 5df000 -- 100 % complete
root@xilinx-zynqmp:~# [  162.910329] zynqmp_gpd_power_off() Powered off 
domain2 domain

pm_runtime works now. So

Tested-by: Quanyang Wang <quanyang.wang@windriver.com>

Regards,

Quanyang

