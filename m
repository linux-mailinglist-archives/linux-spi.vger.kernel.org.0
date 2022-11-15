Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1D962A003
	for <lists+linux-spi@lfdr.de>; Tue, 15 Nov 2022 18:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiKORLV (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Nov 2022 12:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiKORLN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Nov 2022 12:11:13 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2117.outbound.protection.outlook.com [40.107.21.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D1527911
        for <linux-spi@vger.kernel.org>; Tue, 15 Nov 2022 09:11:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOjdDu7APsMY+ySGX2HZTRYR0TyWD7EI1hGf2XyFb4gw+4EqFBJZNhGHa/r0yqULFN+HO/5zn5es6+GoWQMPdDFlMsHAe3Hs1MWE1kNeSR1RKoaEjHopHJ/AnTCfsM/Id/ssGcY9C7hS9YFYwYcWfi/UQXsDg7FEOrTYrZWZbyvk4GbwIlht5YsRT7ik984yT1o/J6uNfrcP4qCIdOtqgsceL3CZ5mQNKcm6Dg/pbwZYu4ipCxZBuawly48jTgFAlNMrYhFFsKbAJPsrh+++6y2QyDDegzJimA241kdFwXbEIEM4oy445arAIN6YAvpq0TyLm6ILPJyKMhQyQye0hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anL8ZYFpljFKUjOtIdJp0PQlbmu5/RwWEs1z/G/9RH4=;
 b=gtRxWdQ0ku3BM1TPNR1aXMEwaQhMjOQgk+GDUif5tSR1/2sgvKACIfD0lgTEs/sJSqowRXgZymqS3AOmMTWE55RfDhs2ry+AclGEi9dj7eTs0zXEYdqtghlI0G/bAvhXGtJM0CSBqdTv4aoCqQx6XZxH8rtLPS4bcS/jabMhrcSv3XPID9aD2V2zcHglJ6JFHElclhKtWK2GZOI9pLuUvR+nnsRrXJV4+6m5NjC4b/73hnJpIGjWRKHzbCdn/B/EAtgXYQttMEnJrYifahumBnUqQDZHNTdWQ0Miv+dnR+SnJrp46HwlqmFXvglYuYUDYa/A5hUOXNZ9vWJQjW+NnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anL8ZYFpljFKUjOtIdJp0PQlbmu5/RwWEs1z/G/9RH4=;
 b=jNnLkEK2aGNxc4ewshIHPZHtnmEPTuNYT3AgdKk0swIMIzsltY9l5qVPpGYqKPuYJrxXrQdiwUdpYdtpYdrbMkc0OAPPxV3cy+RGzYDB4G/usf8Ss4O1KGuk5Y4xFjyNPX2VWkMbOOQe4EGcgHw3kVeBEZxa0maMYhup+qEnnrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS8PR10MB6947.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:57e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 17:11:09 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f209:bc86:3574:2ae6]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f209:bc86:3574:2ae6%5]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 17:11:09 +0000
Message-ID: <9d21f364-9e6b-1502-f34a-ef486da91af6@kontron.de>
Date:   Tue, 15 Nov 2022 18:11:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] spi: spi-imx: Revert "spi: spi-imx: add PIO polling
 support"
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>, David Jander <david@protonic.nl>,
        Fabio Estevam <festevam@gmail.com>, linux-spi@vger.kernel.org,
        stable@kernel.org
References: <20221111003032.82371-1-festevam@gmail.com>
 <20221111105028.7d605632@erd992>
 <CAOMZO5CH9S_RYpLNZbRxChzSVkkZTAd+qpxz1Ycj2UUPROTXpw@mail.gmail.com>
 <20221111135919.63daed2d@erd992>
 <1c70bfd1-38f6-3a30-9e36-a0f780f82571@kontron.de>
 <Y3ImhoSzY1PYMp+9@sirena.org.uk>
 <46dc7280-545d-6b8c-ff7f-4bad13486292@kontron.de>
 <20221115125549.iih75abpy7cppiss@pengutronix.de>
 <ff8c3ba5-fef6-cb9f-cccb-95e300892eba@kontron.de>
 <20221115165214.p35rfdczz7pmjepe@pengutronix.de>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20221115165214.p35rfdczz7pmjepe@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE0P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::23) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS8PR10MB6947:EE_
X-MS-Office365-Filtering-Correlation-Id: aaf594ea-f2f9-42be-01e7-08dac72c63e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dqE8CtnmmQVXi+juppEXpLDaUuuokFzQZePCgYzOFhVHTFix2YdhOgoJdyHcnCUVBvEQrN7RuLSs/Vn+4e1xRG3QYpqeCN/kPWq7CHIbqVPxKsHDQnwBvJ4lPU35AYmcRrxFT4PVHJa4F6RLs78IWDf/YwI1DC9XdGbIc5BkRfx4ba5YYRGyNWiSKftNMi8cU43ZGCo7SbpA0lLUGPXg2DzOo0OItJuiSR8PapIpPNYUBpX/VjOK/eaeWNmshG/u8F4PFYFNjqe8JXuqD3+qVj6Pr4iqerYnT8+6UOxifIzwMLfdSESHW2oPmTqMlUPPa56swvdb9Bo3xAgSFoEyT4Br1VN63usd1CZ8+VNHmd38OGjOpYU51/+yJxAAGfOZS5vjguiJFukvF2SscEa5t0pPge14mr/p4q2yE9xXWAOvyzorj1aZLPzwKkCHrv+tFLoXiSJV4Gi633k33Wc1pmdje52BrdygdQc+QHoN5glxALJmzF4ZndxdIALszd7kxucKGBipKZVngWQmFjbrOKgPqkmOylovZKKNwEWCoFIovPVuWXmFm8g9bjwWXml/YkGCDrdQDrp0zFoP69x3AlSYu40RzgiNS+qp5QPNoMaG/m26sCbg1sLe8qHb0vZvqv+7sUarSzeKB5qvMJdE2h2PbVmsiV2EyGbgyTHeuKr1oWDSoWyVWSGsBU4BCZ7MkD52Pj/3trfqzo7iYqji10FYKsDpAisvawNhApnNAnZ9weFseTZN9+VoLF8PYWgGj40HlReHPNGcZVtBlmbqDqRrLEnMqIDKryrEQL6x8Vw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(451199015)(6512007)(6506007)(53546011)(86362001)(31696002)(478600001)(6916009)(54906003)(6486002)(36756003)(38100700002)(2616005)(186003)(316002)(83380400001)(8936002)(2906002)(41300700001)(31686004)(66556008)(66476007)(8676002)(66946007)(44832011)(5660300002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3FEb21TcldyZXhQenFMR04xUUpoMzByeHdQVnl5ajh3ck5SWlhteXY3K2Y4?=
 =?utf-8?B?Rk13M0UwTjk3djJjc1VHalhGQzAzRnhHZ0xUaVJkRS95KzZySU5GQ1E0aTNZ?=
 =?utf-8?B?WkMrMWgydkNFV2pOQmlybkdpOWZvVEQ4QTUvajZXenVxSzJoci91emxwaC92?=
 =?utf-8?B?enRaOWVzRDRzN0hKWnl4Zm5KclNQU1RBeENBZlBFL2Y1WUNXM3k3czU0UjUw?=
 =?utf-8?B?eFhxMjM1Z0RiMm9Kb0FranNvdnd4V24wRURGS0FpbnZmTW1DOW9pa1ZnR3hp?=
 =?utf-8?B?ZENPd2tuQ2VwSzduSmxRSVZSVjEzeFhRME9zSjR0cnowK1FoU2RMelFZQnRl?=
 =?utf-8?B?UThBdCtIWVdWTnB4VWRTTXJHSnM2K21RaklrSjdka1ZGaGVwT0FYWG5idmYv?=
 =?utf-8?B?ajZjaG9FNVprallyajRFNENJbHM2cFZiREFGRjlPd0l3MzRLakVzeUFMaGw3?=
 =?utf-8?B?dGE0eGVyTmN6bkhjU3p2UkhESjRIMXBnNzVCNzVDZE52b093SysraVQ1eGFm?=
 =?utf-8?B?eU9wci9wemlEUGZFUTl5dTBYeFYrVlJBcmlrNFp2TlhkVG1QRUJlNVFWT1c2?=
 =?utf-8?B?SXFOUGJBaThsTGlXVmV4cFlFN2VYQ09WbytXT0xBbFlxOWJ6dW5Gd0lid0NP?=
 =?utf-8?B?a2VNU3FGeDh4Vng3Y0lQU0dKS3RWNVI3bXg1MW9WYXVJcVVmZTIyQjNRS3Uz?=
 =?utf-8?B?UXZhdC9HK3RHRDMvOTJnTmQwSi9WMWtwVjhINjZEaVdIdHlxL2xiSnNMeFpw?=
 =?utf-8?B?VVhjRmt2M3NPQzVkNWRkVVNRM0xhWHdNVDdVYWszTzZYclUxblB0WldsQ0E0?=
 =?utf-8?B?SitqYzE4eWF1N0NieWlGd3lmeFg5WXFRQ2RjeXJMcSt5ZzcxejgvSXJvK0NU?=
 =?utf-8?B?RjlBbFdSSm5mZ0tzWloxRnZZeTJnKzRPb1IxQVVPOE8zOTRKdEhQVmZDazFB?=
 =?utf-8?B?dTJ2aDVEdWZjeExzZE1Idlo5dEduL3ZOeDBUbHNKTGNqYW1xSnZ5WkZjQ3l0?=
 =?utf-8?B?WjhqTHpuUlZPMXBTSWNJRGo2ZGE5anY1QnJ5ekx1QjVVQ0hPYldzVnZkVmk4?=
 =?utf-8?B?QldpMmgwdUNlOTY0N0h1VnEvK2duWTRPR2tFeUVZcWVkcnFTWFBUTmRDeGg5?=
 =?utf-8?B?eVFhMEdXMTN0RDZQU09qVEVWZmJHV2NSM3drMmpucXptWnZIYTFyN05DeHRx?=
 =?utf-8?B?L1lDcWdDbU90RXhFWmQvRS80QWR0dTkwZGE1a01oWlRWYjRNeEQwd2pHUzlO?=
 =?utf-8?B?MEkzS1JXeXFkdTROUEc1K1dGbGlRclJSS3RhK0pqZk9OcjJPRVhBRDdLU1Vx?=
 =?utf-8?B?TEdyZ2pRUHFIM2xSaU8vSHBUaWRIMnI0bHFpNlFIN0o2VCt6QnQ4OWN0US9o?=
 =?utf-8?B?R3ZDWnQ1UGdWSzJUektidGl6NG41akhvY3phT21scUh6Sm9wWlFacWdKVU14?=
 =?utf-8?B?MElRZGYzekJ6LzlrZWQ4QVF6M3VXZkhmUDJPSXByMVpsQnhab0I4SFRvc2dl?=
 =?utf-8?B?bmRBNDJFSFA2aEJmamw4blpsU0RoYUpDc2tmQ1BLOStpanNWbWw2eVk4KzlV?=
 =?utf-8?B?OStnK3diMjk2STdqVFNQOFRmSTMrOEdIVFRTRkgrNVM2NzlzaWg1Y0F6TjlC?=
 =?utf-8?B?aG8zZUNPalR0WVRJT09aWWwySHU2S2hacllwWnJ2ZkViMmJZMmpNOXk2RGM5?=
 =?utf-8?B?SHpyK0VwQjQwYVhwSkx1bkFZd0M4NVZpeVVlQVZzeEFTY2pETkJGS3A4NkpU?=
 =?utf-8?B?aUVSS0RldTZIaVhuY25PUjNBdXVhQkhzM2JiU2JCalhCcHBZakFuL2FYb21w?=
 =?utf-8?B?SWl2OUpOdVAzTUFwc0F2T3R1L3pjUHoxU0pTdDd0WmhIcVlmTDRTcHRNQ1Zv?=
 =?utf-8?B?Qll4VkhtUUlQNWNiMHArY1NUeUkzYTZQUTdSMVE1UDBWWFdjV1RJakcvRUxE?=
 =?utf-8?B?aGsvV2RlQjdTa1VTUm95NGhFWllYdG9VYTc5akM5UDVacjRnYWZlbVo1ZEhJ?=
 =?utf-8?B?T1hBcDBRSUFjcTBKdTRsUzB1SFZ2RmJaZjVnYXA0S0NWc29YTDlWV1BucEwv?=
 =?utf-8?B?bzA1bUsxYXprM0MwbmZONWJWQ1FielpGN2RFa1hveVFzb2RscFJDN3l6a0N5?=
 =?utf-8?B?N2JTODQzRUc1eVAvS2paQVVmZkZWQ05lZGs4L0hKc2ZPQW9QcUVmS1ZLV3k4?=
 =?utf-8?Q?nrW/ptLjNCfTQdeKNSkrXLK/D0moxWRJuG4vVSbQeKWC?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf594ea-f2f9-42be-01e7-08dac72c63e3
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 17:11:09.5906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OXX1ZldiyD2bmkOAuSI6JEBHKhKpBqjvd1DjaZmMo40mach3E0X7Wew5cwrVHC9kisHNO+MiFNpxHRnHNmX4vwHI6+0Z01TSM1Zjj/bfFVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6947
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 15.11.22 17:52, Marc Kleine-Budde wrote:
> On 15.11.2022 15:46:28, Frieder Schrempf wrote:
>>> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
>>> index 30d82cc7300b..76021b9bb445 100644
>>> --- a/drivers/spi/spi-imx.c
>>> +++ b/drivers/spi/spi-imx.c
>>> @@ -1270,9 +1270,22 @@ static int spi_imx_setupxfer(struct spi_device *spi,
>>>                 spi_imx->dynamic_burst = 0;
>>>         }
>>>  
>>> -       if (spi_imx_can_dma(spi_imx->controller, spi, t))
>>> -               spi_imx->usedma = true;
>>> -       else
>>> +       if (spi_imx_can_dma(spi_imx->controller, spi, t)) {
>>> +               unsigned long hz_per_byte, byte_limit;
>>> +
>>> +               /*
>>> +                * Calculate the estimated time in us the transfer runs. Find
>>> +                * the number of Hz per byte per polling limit.
>>> +                */
>>> +               hz_per_byte = polling_limit_us ? ((8 + 4) * USEC_PER_SEC) / polling_limit_us : 0;
>>> +               byte_limit = hz_per_byte ? t->effective_speed_hz / hz_per_byte : 1;
>>> +
>>> +               /* run in polling mode for short transfers */
>>> +               if (t->len < byte_limit)
>>> +                       spi_imx->usedma = false;
>>> +               else
>>> +                       spi_imx->usedma = true;
>>> +       } else
>>>                 spi_imx->usedma = false;
>>>  
>>>         spi_imx->rx_only = ((t->tx_buf == NULL)
>>> @@ -1597,8 +1610,8 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
>>>         struct spi_imx_data *spi_imx = spi_controller_get_devdata(spi->controller);
>>>         unsigned long hz_per_byte, byte_limit;
>>>  
>>> -       spi_imx_setupxfer(spi, transfer);
>>>         transfer->effective_speed_hz = spi_imx->spi_bus_clk;
>>> +       spi_imx_setupxfer(spi, transfer);
>>>  
>>>         /* flush rxfifo before transfer */
>>>         while (spi_imx->devtype_data->rx_available(spi_imx))
>>>
>>
>> Thanks for the patch, but unfortunately this doesn't help. I did some
>> more debugging and it looks like there are two problems.
> 
> Can you try this one?
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 30d82cc7300b..d45da1d0ac1d 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -1607,6 +1607,13 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
>         if (spi_imx->slave_mode)
>                 return spi_imx_pio_transfer_slave(spi, transfer);
>  
> +       /*
> +        * If we decided in spi_imx_can_dma() that we want to do a DMA
> +        * transfer, the message has already been mapped, so we have
> +        * to do the DMA transfer now.
> +        */
> +       if (spi_imx->usedma)
> +               return spi_imx_dma_transfer(spi_imx, transfer);
>         /*
>          * Calculate the estimated time in us the transfer runs. Find
>          * the number of Hz per byte per polling limit.
> @@ -1618,9 +1625,6 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
>         if (transfer->len < byte_limit)
>                 return spi_imx_poll_transfer(spi, transfer);
>  
> -       if (spi_imx->usedma)
> -               return spi_imx_dma_transfer(spi_imx, transfer);
> -
>         return spi_imx_pio_transfer(spi, transfer);
>  }
> 
> The problem is: we decide on DMA in spi_imx_can_dma() the SPI frameworks
> maps the message, and then calls spi_imx_transfer_one(). We cannot
> operate with the CPU in the memory mapped to the DMA engine.
> 
> This should fix the problem without any additional patches.

This does fix the issue. My previous patch had the same result, as
spi_imx_can_dma() returns false if transfer size is below fifo_size. But
of course this is the correct fix with the correct explanation.
