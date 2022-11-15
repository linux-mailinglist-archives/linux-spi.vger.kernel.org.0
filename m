Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CABF629C83
	for <lists+linux-spi@lfdr.de>; Tue, 15 Nov 2022 15:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiKOOqg (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Nov 2022 09:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiKOOqf (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Nov 2022 09:46:35 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2102.outbound.protection.outlook.com [40.107.105.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28152D2DA
        for <linux-spi@vger.kernel.org>; Tue, 15 Nov 2022 06:46:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7Y1KI6DY9tLKuOltu7rZrIY47tvNs9x7kJeL7Kq1LT6yDvTSrxpfXDWLq3mLQIJVxRjR6AJkl3RIUqtuxKgcot05W3zZhTjUWiPa4gMm0w44nvBC5F/O/SU8i9PB77yZDyM/QIETB4SHo3zWbvxhRxgWlYTU7gM8XOMwEhmj2SwcFDdZ0FtiiB6NkatQwqO1og3OnxI/5wMW/bEMtcNm4vgWlxGB4+1o3g/ZVLQ55fnojGlWekc7EqpbADk1Z8PmhlVc3tV77ygkSexqy4UWbK9eKxaFG4JQCAoM4JuPQ794S9wUcHAShBuq/QwN4dTTtLdUrhQJbKtj7fu7VzEHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vE+vuZ/1ddyDLQM8Bw+BAyveYuqxzbos5xx5ZqOlNMM=;
 b=RaSjEFKE2ucIBk9o5Yw1RBw/fNBqL+3yeU1eId6zDH7Kwo3J35xSezyHRGnxIKJ83xUX/iUK9auoqIT0//ERUAW3JqIGS49nUjkeSOuICXCCCWvuPdqOZRRX0x0fQWuZVsuKiUjLE6uzFsETfsMuNSkogY+NZkWEqL+ZbL16ZupNFJw0MM8iQD8Qsjd+vDxUTOILXcAX18PhgJkvio6foIyK7LF9OlQb+qkT0Ce7gULgq0wpH1e7Y3kxqPSb+fvVlfEhY+Ua03cYz3e/4D/vJAagjsG6GyQ6YW8Z2DZ542ZiDl8FCzIGn+OBO5mXjSUSdOZYpHL3+w47gvlPxp4j/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vE+vuZ/1ddyDLQM8Bw+BAyveYuqxzbos5xx5ZqOlNMM=;
 b=MS6w8hxeP4dxBRMoEl1erk9gbqM8YdHeIl6T/g09XDnYFtW6yv9J/3jIKul7E4tLxLgkol1pXzKw8wE4Dawro/If3uYz1n8YT4VsxLEEtv0u/BtiyN11mw96ERyUKNUMpPvxB2afkzRVZzjreduKWkRGK9dVr5+NgOXG+zxunlU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DB8PR10MB3322.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 14:46:30 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f209:bc86:3574:2ae6]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f209:bc86:3574:2ae6%5]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 14:46:30 +0000
Message-ID: <ff8c3ba5-fef6-cb9f-cccb-95e300892eba@kontron.de>
Date:   Tue, 15 Nov 2022 15:46:28 +0100
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
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20221115125549.iih75abpy7cppiss@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:15::8) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DB8PR10MB3322:EE_
X-MS-Office365-Filtering-Correlation-Id: a393a240-e96c-4f11-a369-08dac7182ee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oGSymHTVniq/NMzDe6iPH5wfxpHCAB7GbmSi6ZuppMv1CV0p6spw7dUZmWAjGvUoiE8ZAqwp/lSylEwAsnKzBnFuXpOavt0z7jiNhExCxHvFZQ74/K8zFGL2uE856wHRv7ryjH0M7Y/FKCOmm7r3xlrvXjvx6RAgEZbkFlaneS+K9hOLTVjjw97W5hQ9YCXEcCLfcrq17DRURAXkU6rU9G73wRpgK0W1nFFsjND5tscuDa5j6CtlU2Puwc2e/RbCD1MNaJ6F3ZMvXT+dM9lsYVXHu/tY0DLzSqE53AIU4qtnDsUv5nkKEJC/puSiYa1SOzD0HaxOLCUEHTcYi/1NINJC9ipVye82M7Q7Q1It3akUZGimUfu+FZckxmbuAjHpX2hpoS6MV64BhG5jWRPVWygVGbvdX6yYEX/ceEfqdj28x2X9j+rzzuErYQt1Q3bt50OQodrMVuyhQ9O8bILKH9B/PfybB94O8iMHapaWBylKZXO4m7twON9IlPoeqJ3oSORV9pnBCM4l1Q1cJndSXle9B233iKfBepK/1obclRo3uhNDL5kZgZ9M/4hWmFUKqaMbKz2dorZU6I03DcbTkXJnR5UoNuMVflc/qj9zkzFnYMudIpxiWkBj8qyKjlrJWOfCnWtBCeYdAt62G7K9CLVG2Nh4hkzdhZZD1oq6b03bt8U4AoCg7OcgAHS4Z54FlQ0MA+GQ7wVw8Q8LY6rEGtb+k9AD4vSc0UceClwCjR5Uy604KI7pfOK5caNJ22JCPlhx9HUaVpioj7dU5akvB6rIqVJbFGNJEeMZxcWhpBY0MzmpOQXjGvO7APS2gTUX5NLw+hOQ4rGvcXTHPlhbGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199015)(2906002)(31686004)(8676002)(41300700001)(83380400001)(4326008)(54906003)(6916009)(36756003)(66946007)(5660300002)(66556008)(66476007)(8936002)(86362001)(44832011)(966005)(478600001)(31696002)(6512007)(53546011)(6506007)(316002)(186003)(6486002)(2616005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2d3WjBWTm5pc2FvZFRyWitOZXlWcFRJMEtCSFRhZElMdXJhWllLODJXcWxG?=
 =?utf-8?B?NHIwQWRNcUFXWTliYk5JNHRUby9tVWJLY0tNams2RlZwZ21RRGVtZmNIeVQ3?=
 =?utf-8?B?bXAweGZPcEFCSmdpRWFUZVI4YXNxT3hGNUdHcFZTMUJVbGNQcGsweUVHWE1E?=
 =?utf-8?B?WGNNRWk4d0tSL3ZMSy9OZmlsTy8vc2ZLVzVhSklGOXpIUjJ0eHlVYkRUWStK?=
 =?utf-8?B?Nnl4SVVWYTJKVVNRYURuVVZXdXdGeHVtQ1FudTlWM0ZGeklCam5mM2dDWGF2?=
 =?utf-8?B?dDJ4WU4rOHZrNDhlY3FrcWw2L1p0UTNWVEs4WS9IVXB3QTMvV3lRMENvQVdK?=
 =?utf-8?B?U2gvQ1V2NHYxRElocFRMOVRXc29xQlhDNkY0RnI4VEhwVDh2WkZXZXY5dFN1?=
 =?utf-8?B?UG9HVUFxTjBPdjltUjVhdTRpdVBlM0UzV1lORUNqK3dSYTdLM1loTHhsTFpK?=
 =?utf-8?B?NFdkd1VWUTRCcE51TXNJZkRiY2piUFBxREcyVjdHTWh1OU51TjlkUlhtbm9U?=
 =?utf-8?B?eGV5Zm5xamxSS3RpV090anQ5dnA2dURucnZTeWJYLzdHc1hReWRWSDRob2g3?=
 =?utf-8?B?djRHa1FGZ1hUSFk2dmgwK2REUm5YS3hBeDFrRnRpeEwwclRqNlVRZnVudDBP?=
 =?utf-8?B?OVlxM3dTSi9TdlJVWnBrT0NOZnlXWlVETlJlYmhKQnIrT0hXay9PY3MrcXA5?=
 =?utf-8?B?R1AvSXNER1RrRW1PRjBVVjAxQVNDaHEyVlRsRytncHRCM0g5S2FWUkxUalpv?=
 =?utf-8?B?YTVaVmNXSUlobitZQ3F6ei9tVjM0cEIwWnJUampiMnIzMUFUa3lZd28vNHls?=
 =?utf-8?B?U0hSNitGNmF5SUJtbnhUVHlXcEF0MU9qNDBwWThoQlVaMm40dXh5V2J0N2E0?=
 =?utf-8?B?akZSbmJHc1R2c2Q1amdGSFN1UWwvTUdLbGZBTmlaRHVObDVEK3o3QnZSUm8y?=
 =?utf-8?B?bmJQYjFsTWp5RVFGWkhOV1pDMm93ajRvM0hlMk5mTnN4SCtCTzMyUTFETHdX?=
 =?utf-8?B?NmV1R3FiWnczQk8wdTBUNGhhV29LNTJBeDYxazFKNTZFVzIzWExJSHUxc2Zq?=
 =?utf-8?B?KzgweVNmZW1FemZzNjFUOE52UW53eHh6UHVsUTZnMlRlTTJGYkk0OHp5ZXN1?=
 =?utf-8?B?aGNWbHI4cUt5MElEWDU1cHp1MCtXeFlTRElncDVFOTBkODlNTWNIaElydE9J?=
 =?utf-8?B?aGNYS2VaN0gwU3JrV09ZUUtlRFJqNXlFQldSRW9tVHV6a2FKRHEyakhxbmxN?=
 =?utf-8?B?ZlFDWnVDNFU4NXQyN0gyMGxHK2lMQUFGc25VWDF6WDgrTEpoZm5SSGR5MWc3?=
 =?utf-8?B?YXdlVG9GdEN4dW5BR1JLZlhXU0ppQ2Q4cnR2TDZsUmJ5NGo5bmhRVStKZDFt?=
 =?utf-8?B?UDY5MWJNTkxXRWRQWXkwNm9vSzJmWjBPQnYzTmU4Zll2VDN6d0w3UkpaRnM0?=
 =?utf-8?B?S0Y2QlBnanpRMFhzaUQrRHhUUlo1K2RMNTl0Tm9rV3RDclhGVCtWQ3oyMCtB?=
 =?utf-8?B?YmFVNGpGeVNXYW5pWUwvQ05qSkJ1ekpHaDQ3d1AvZDdKVnFvbFdhRmpLNmVj?=
 =?utf-8?B?QUduUTM5cHRTQTlKQnFUbGFWYnQ0ZkltaEUvSHVqcGpYUkhVTDlDSmNKd1dK?=
 =?utf-8?B?ak1LS0tlL1FRZm0xZEg0Q1lsV0JDUjJMQWpLWVQybC8xcGdudzVQZ3VjbzFX?=
 =?utf-8?B?Q2NMMm5NVmRkcUd5dm5EYnJ4Smg0UWJVdW5ZVkRCZFhwNnFWMVBrVDZBSzVm?=
 =?utf-8?B?SDROeEtrcm1oTWRqeTcrSHgwSVRWWjBYa2JCbi92L2MwUnA3V1VnRDBlb0Z4?=
 =?utf-8?B?Z0toY2xkRmxJdWlMMjhOYUdyTDZHNzVYQS85bk1tbnU5U2xpTmw5UTdRK1dG?=
 =?utf-8?B?TXVQR3cyL095eTRhYnJnS2ZqOXRtM0pkL0tCTkt5VU5IWEdlcEQrQmhyNVZz?=
 =?utf-8?B?SnBFdG9NVzF6ZE5FSGpzeklBWFkzaTZtODRBL1A1bk1yRzQyWU1vK3Zab0ly?=
 =?utf-8?B?b3E4UjYyL3JDSEJsNDErMEhxbG9RN3o2RjZEWHNHbW9HSkVuTUZoazcyd0Z5?=
 =?utf-8?B?bkhibkQxOTRMRGlSY0t2TEpHaDNmM1paQ3NTaEdiQXVtYnZYMnFUcjFkeVhS?=
 =?utf-8?B?RzA3dFRtelhTdE9iemEzYmtCeGM0YWhCdUoweHRxMjNtTDJsQ3ZKUm5Zakww?=
 =?utf-8?Q?BPXCfL7XNYU9386rWWjyqYJYOIziL5iqiw/uuk+W9HZZ?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a393a240-e96c-4f11-a369-08dac7182ee1
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 14:46:30.7121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ptX2Mei1znJYA0KnCatqRtcoQTI5brtxdGONpuGLuOhh/40K+tkC+SoFwGVUlZCWOUvDj9AV+6e63WrjbnIkH5u+AaF/XF/yzhk3jQotXfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3322
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Marc,

On 15.11.22 13:55, Marc Kleine-Budde wrote:
> On 15.11.2022 11:51:53, Frieder Schrempf wrote:
>> On 14.11.22 12:29, Mark Brown wrote:
>>> On Mon, Nov 14, 2022 at 09:30:26AM +0100, Frieder Schrempf wrote:
>>>
>>>> As far as I know Fabio also discovered that disabling SDMA also fixes
>>>> the problem.
>>>
>>>> I guess I will try to repeat some tests on latest master and see if
>>>> there is anything that makes things work again without reducing the
>>>> clock. If anyone has some more ideas of how to fix this properly, please
>>>> let me know. If nothing else helps we could also reduce the SPI clock.
>>>
>>> It sounds like the commit can stay and that everyone is happy
>>> that the issue is that the the commit made things run faster and
>>> exposed some other misconfiguration for these systems?
>>
>> Honestly I'm not really sure how to proceed.
>>
>> My first impression was to keep the PIO polling support with its
>> benefits if there's just this single issue with the SPI NOR on our board
>> and assuming that the performance improvements uncovered a bug somewhere
>> else. But at the moment I'm not quite sure this is really the case.
>>
>> I did another test on v6.1-rc5 and disabling either PIO polling
>> (spi-imx.polling_limit_us=0) or DMA (spi-imx.use_dma=0), or both of them
>> makes reading the SPI NOR work again.
> 
> That was a good hint, I think I've found something.
> 
> Can you check if this fixes your problem? Just a quick hack to, a proper
> solution needs some more love.
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index 30d82cc7300b..76021b9bb445 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -1270,9 +1270,22 @@ static int spi_imx_setupxfer(struct spi_device *spi,
>                 spi_imx->dynamic_burst = 0;
>         }
>  
> -       if (spi_imx_can_dma(spi_imx->controller, spi, t))
> -               spi_imx->usedma = true;
> -       else
> +       if (spi_imx_can_dma(spi_imx->controller, spi, t)) {
> +               unsigned long hz_per_byte, byte_limit;
> +
> +               /*
> +                * Calculate the estimated time in us the transfer runs. Find
> +                * the number of Hz per byte per polling limit.
> +                */
> +               hz_per_byte = polling_limit_us ? ((8 + 4) * USEC_PER_SEC) / polling_limit_us : 0;
> +               byte_limit = hz_per_byte ? t->effective_speed_hz / hz_per_byte : 1;
> +
> +               /* run in polling mode for short transfers */
> +               if (t->len < byte_limit)
> +                       spi_imx->usedma = false;
> +               else
> +                       spi_imx->usedma = true;
> +       } else
>                 spi_imx->usedma = false;
>  
>         spi_imx->rx_only = ((t->tx_buf == NULL)
> @@ -1597,8 +1610,8 @@ static int spi_imx_transfer_one(struct spi_controller *controller,
>         struct spi_imx_data *spi_imx = spi_controller_get_devdata(spi->controller);
>         unsigned long hz_per_byte, byte_limit;
>  
> -       spi_imx_setupxfer(spi, transfer);
>         transfer->effective_speed_hz = spi_imx->spi_bus_clk;
> +       spi_imx_setupxfer(spi, transfer);
>  
>         /* flush rxfifo before transfer */
>         while (spi_imx->devtype_data->rx_available(spi_imx))
> 

Thanks for the patch, but unfortunately this doesn't help. I did some
more debugging and it looks like there are two problems.

In my case on i.MX8MM the SPI is fed by a 50 MHz peripheral clock.
Requesting 80 MHz for the SPI NOR triggers the fspi > fin condition in
mx51_ecspi_clkdiv() [1] which in turn leaves *fres uninitialized causing
spi_imx->spi_bus_clk to be set to an arbitrary/random value in
mx51_ecspi_prepare_transfer() [2].

This in turn messes up the calculation for the PIO polling byte limit.
In my case the limit was usually somewhere around 8000 bytes, so the
4096 byte SPI NOR messages get transferred via PIO polling.

Having large and inefficient polling transfers shouldn't be a problem
and lead to corrupted data, but I suspect that it doesn't work because
the transfer size exceeds the FIFO size in this case.

If my conclusions are correct there are two fixes required (though for
my use case each one of the alone is enough to make things work):

1. Make sure spi_bus_clk is correct even if the requested bus clock
exceeds the input clock.

2. Limit byte_limit for PIO polling calculation to a maximum of
fifo_size, so we don't try to poll for transfers that don't fit into the
FIFO.

Both fixes are quite simple (see diff below) and if you agree I will
send them as formal patches.

Thanks
Frieder

[1]
https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi-imx.c#L447
[2]
https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi-imx.c#L650

--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -445,7 +445,7 @@ static unsigned int mx51_ecspi_clkdiv(struct
spi_imx_data *spi_imx,
        unsigned int fin = spi_imx->spi_clk;

        if (unlikely(fspi > fin))
-               return 0;
+               fspi = fin;

        post = fls(fin) - fls(fspi);
        if (fin > fspi << post)
@@ -1613,6 +1613,7 @@ static int spi_imx_transfer_one(struct
spi_controller *controller,
         */
        hz_per_byte = polling_limit_us ? ((8 + 4) * USEC_PER_SEC) /
polling_limit_us : 0;
        byte_limit = hz_per_byte ? transfer->effective_speed_hz /
hz_per_byte : 1;
+       byte_limit = min(byte_limit, spi_imx->devtype_data->fifo_size);

        /* run in polling mode for short transfers */
        if (transfer->len < byte_limit)
