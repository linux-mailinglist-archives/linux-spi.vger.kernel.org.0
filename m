Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E17A629E70
	for <lists+linux-spi@lfdr.de>; Tue, 15 Nov 2022 17:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiKOQFM (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Nov 2022 11:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiKOQFL (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Nov 2022 11:05:11 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2098.outbound.protection.outlook.com [40.107.22.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7B762F7
        for <linux-spi@vger.kernel.org>; Tue, 15 Nov 2022 08:05:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rvi+tXhAVUHppYldkMg67M1RdWahHDJZfZ0d8q5wqSNLP2vvt2BePtpWoBLEEg8PDoClIO7f9prC7PBPDP38nSnngEvFG2nD/4uo1vLjz8IU4MrduEfB8I8oUe/cIJAyDYpdni91QRz0fB1bDrFf6OK9bRJmQhxn9MQXYo3LguFVxoAZqnYw9WzgE3TX7FyGxIuX/C7Gu1u9gl+/hSbxMgQ0xWzWkdbNXRH3JOyeS2ad9TrQypA/1Q4ImHY/UezNkppAznCHDVrc0J0cAPpLRvJspvEFgWqf8SU6AMykl/ksw97l1QjSxLpC9gbIylMo5yEAEC7GzYcO+OQT7PXr3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C7tmfsPNASdQABc7LCHDKqi8zCSFFKarBSy58zHXTI8=;
 b=ZfDnR8WyfMYsfLSms1MQ802GoNj+B+SfdQLTkihN0wcbiXTcfnnikLL6WNdU5kXrOCEtHiB1t1muTrGNh6gGv46IYypeMHHo4PpN/PvTOWi5UJI9Rq++Nfq47Hn8PWCjg+66tIbjnHKsK09a/xG8smq8V7JFb54gxiabIQU0eByPTnPFDf1aggoB7KAERlgwiS1SJMVslFJv+kx76H9tyoMMGOvl51gKnATyNimIVmfF+i5YLgOnnmz2NEZ+rwtlHnmM3oB1FoIE5XtKfBOWy979MQRqHniyfxOhGRENNcq5YJwjaXL3pOCauuu9c2kWoIf8qN2M27y7cshI/FoKzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C7tmfsPNASdQABc7LCHDKqi8zCSFFKarBSy58zHXTI8=;
 b=QcZetZ2xeaeZFuAMmJ4EXoGmrc7K+MA7QypXfN0yrl0TiItwls133OYXoVy7Xxb1HOBtd2ykJm4FsnlWsGQIwbcZJBVDQ1XolHqQgqKZQ+tUiDTwIlLa3Zhc3iWDFlW3/lkUFr5HI8UqdJ+YXeHkIGxRVr+f7E5Ztl49PerqKpI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PAWPR10MB7789.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:365::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 16:05:07 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f209:bc86:3574:2ae6]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f209:bc86:3574:2ae6%5]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 16:05:07 +0000
Message-ID: <df5522ec-7e7c-7f8b-2aed-6728d8dd3cf8@kontron.de>
Date:   Tue, 15 Nov 2022 17:05:03 +0100
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
 <20221115154655.sdvjczlivt33kezp@pengutronix.de>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20221115154655.sdvjczlivt33kezp@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BEXP281CA0007.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::17)
 To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PAWPR10MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: 23549bd5-5830-42db-e2db-08dac7232a10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IlJDmGfebm4BUqywHIpdlEOt4A29q3DwStgEEgIECCqoL4TNMGRG9c5tgDpJDb6gRCuCs+22essZFtVsv5KDZeCxzvPmz8WFKOgmG2qffAk3XoSQ5Kw7p+3le02qp8iiqe+ASrkVNzn/wwpE+MRCjD8xGlED72poYRNKqcorqcMHUJEe9oOp4MGJ8O+ns2Cz3ssI7/dXArLsYs5jxFCyBNuVQI/9Nu//IvigIbwe48FGab0SSOG33fMxhtUJR6x4Figh7DeVjkqIKX/QQgha/M/4QMycWQbEEnNxOBbKObkTsDRpOtp675V693KV6unmWiKt14XuXpO3kUahSwUOyzXRnafp/MZCTHRtEX0xhDj7paCOyaWTz2Hnj9dYg0YkOqM2ixxMPS23brj3/1UZ6YsMsgGwuJEaGkY7H5lVNX1Ydtgw7J/x1UO18ivU54/H6NqyNDImIyOblWIrNo8L2aXFlRMebdcHVcZBtBaJSfApc2A2h9/13uIhr+V+1E+gfHO/CpdQTM25KXJ8/7yAhi77/yceLJYjnMYXvc5Qrkz0EldRDV4vqQGVLvGeLeq/6ClYuazYHifWVAOErYgYg9y9p9PCIXihJJQS/XYCn4xZ2Rr4gRlOoaatroHjUT8RJ9uzU5gDE8uznUZA5BaD5sssObehqZ/ntTb0w2b8j4PPGJiGyPJKX8txomp1OBSVifN13mxRO5nm+kqQFXjyOHxjo+YPbba/DUIkNKRkv1XEGgZiq0/GScbp8Q34MeQ0C/jUvLLeTYUUf8pTnFd9e9wpgAfIZv2tdBhu81lTiF/CrOvF8LyOAAF4gJk8nV6HYJCpF8JmcD3ovAPJEtl8Vw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199015)(31686004)(86362001)(31696002)(36756003)(2906002)(38100700002)(44832011)(8936002)(83380400001)(2616005)(478600001)(186003)(6916009)(54906003)(316002)(5660300002)(966005)(6486002)(53546011)(66946007)(41300700001)(4326008)(8676002)(6666004)(66556008)(6506007)(6512007)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WSs5R0NMbFhBK1BkSk1QZUNPY3JKY3BmSEpGRm1lSzAwOTFwNTJ5L09JOGJj?=
 =?utf-8?B?MjluU3RhTVFTTnNBNHJJYUNIVzN2cVZJTStOVldoMDk1Smd0dUhkbzBVZnBo?=
 =?utf-8?B?c0VYTXNqbGlHenBsYVBkaHY4bXNDM3hpa05MZHkyK3A1eFFWQXo5L1pHVUtK?=
 =?utf-8?B?VHlBQjFUU2dYZG5OMURUbm05OFhCNlUzQjh0L1oyN1MrS3JDa0hnZGNuNHd6?=
 =?utf-8?B?UFVwRW5nMkVLczc5YXJiQlp3VTQvV3M1Mm0rUkhmSExVV3JMSmJiKzMrdVhu?=
 =?utf-8?B?cnVOY1Y3T2F5d096MzQzbXZJK3RaNWJDdzYyWEdzZzJIdnB0MnFBaERSTVdw?=
 =?utf-8?B?SGpqRmpHWEUxSW81ZVgySHRkRWU4Rnd1UHpEU0QwNjJxcnlzOVhyK1VZVWpC?=
 =?utf-8?B?VVRHeDJaM09wNTFPQjZydGZHa285dmhCZkFTeEJFVmtMQXJqcmI5cjBueVNo?=
 =?utf-8?B?MEp4VHMxc1FRUVY4OEttYk1iU1ZCVUVoblFISnIzNGlIOFMwZWNnTWhrUCty?=
 =?utf-8?B?ek55MEFjWnFGWmJ0cGtKYm9nKzJidkMxaFVIWEdCeTVvOHQvbXIxR2pmZVBt?=
 =?utf-8?B?MmFScGFObjJVUng2MWl6emFlWEl5bWpLMXBEMnBDeXp1N0RWUDBWUU5pMVJW?=
 =?utf-8?B?RzgxWm8zTFhpRGhDVE1hamVnM01PdWRsZ3hieWJ6SFVyMWdBVy9PVkZtOXdK?=
 =?utf-8?B?VkJOekVjUEZ0SFVLK2diQ21NVnY0S1oweElKbnhCQlVCczgxMDlVY2c2VDVV?=
 =?utf-8?B?dTBTejJaU3VPK1VFL3hRWS9rV0JJb2JlOVkvUllFQktQRmpwdzdsY3dwVGYy?=
 =?utf-8?B?QXNOU0wvN2p3WUlJc05iUnFONjkyNVhrVGxXTzF6YnZjWFhCZWhrK2huUmFt?=
 =?utf-8?B?dU9JSmRtZU9yYWVJeUlQSElQbnhBS04zOEtGZVU0bjYvV2I4WXA0a2MrVzB4?=
 =?utf-8?B?M2l4UGtTYlJmMHRFZWR2TXlZQUxKVGlsQzlQYXcyV0xhNUVGQldjVnk3NGti?=
 =?utf-8?B?bWI4UTBzclpFb2t5YWFJdDFtUUI0SmJmYWdUQkhVdnFTUFFsNDFsOTBQbmVM?=
 =?utf-8?B?NnNkYzZreW55K29BUmIvRXBqMzVIMkxUSkg4aFJKRmtsb2JJblQ2bVpPTjVH?=
 =?utf-8?B?dWV3TUJVVXNrbWt5WW8xZ1lORkdVM00zNTNScE1hMHVKcWtHRW44bGpBcDBG?=
 =?utf-8?B?SjIwTU80SG9SNUxQT29qQjFhbmpWa01DSkQyTVFJVmh3SDBTSiswVWpIbTEx?=
 =?utf-8?B?YmlZZ3gyc055WTg2dTBhRGdPbXhBeTROUmFtWmg1R1E5MG44OC95U2FYdEtZ?=
 =?utf-8?B?Y29rZXQ5T2VBU3owTHp6OC9UNHB4c3F1ZFVXRkFlblVyQWxnNjFKVmM4SU9P?=
 =?utf-8?B?UDRXMFowKzNrMmpFNGFQRm15L1VuZzVJZmE4UG9kWVhRWnc0S2YyTHNRcVI3?=
 =?utf-8?B?Zi9SR0ptY2JpeWc1SUxDYmozbTQyYlRGZ1NzTmhaWW15cW9NOXNtMlljWkxY?=
 =?utf-8?B?NHVJOVR3ZmdjSDRKdnM3eVY3N203MWNleWNpRElIejNiYjRHckpPNWRQdXNn?=
 =?utf-8?B?WkVsc1JXKy9uc1pFZ2dtS2N4UkFXa3lid203UWdmcHVQYkhadDJqV1pIQllj?=
 =?utf-8?B?ZGlkZDhBaWNWZ3lhSkVvaFdVNnNyeFVmRWg5d1hNTlRwdXF4R25SaWVlTXpr?=
 =?utf-8?B?eExWbm9iZ2VXbFd6S2t0WXRqQkNZM0lsMHh0M1h5TE5XYktrWFVscGVJUjg3?=
 =?utf-8?B?bFNsZWdqRFRXem1pVWg1N0UvT00wNFBnMFlBenRHMDg5eUFEcEgveWg5Tkcv?=
 =?utf-8?B?UTFlR3VCUUFpbFJKMjNOVTRQWE1BYTBGejhaSUV0RmJMQWdXT2FKUU1DSDVw?=
 =?utf-8?B?dG1RY0hGK29iOFJnN25IVHFoZzlSWkRsV1huTHdQMm03ajZjKytBQURpM3JE?=
 =?utf-8?B?Z3c0QVdqWnBiOTVFUk5WbHBoVlQ5S2RJR05BNjJWd1AxS1oyaTNKWXliemc4?=
 =?utf-8?B?NWgwa3VuNHJQL05kRnM5QlBTOGYrWHBkSkxjNjV3UGp2Z1hFNE9kSjEzME8y?=
 =?utf-8?B?R2hTcXhTdHQxTHFxNW5mMDBTajhnaWYwTThUMDFzQm5aZ0lPV2loaDFndXhK?=
 =?utf-8?B?OUlvR2NnOEhNSzRQRk1RK1VBS2toSVlEbFBSVjZ3U0lFNUxOdEdnY0h4SGxP?=
 =?utf-8?Q?q4lgFT9z5b9zCojSpPiebZfz9VWtdxbGYaWVoZ3ttI+S?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 23549bd5-5830-42db-e2db-08dac7232a10
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 16:05:07.1128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTUD0BHt7bnGujKnInK7CN3xjCTl2I0K3jtHDWLMedtKiBhwiLB1vZbmxpYjD0Bj9eZoC+vQQYZK+VDCMUUAGJ8GuRS9S6rhbYUW9gH++w4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7789
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 15.11.22 16:46, Marc Kleine-Budde wrote:
> On 15.11.2022 15:46:28, Frieder Schrempf wrote:
>> Hi Marc,
>>
>> On 15.11.22 13:55, Marc Kleine-Budde wrote:
>>> On 15.11.2022 11:51:53, Frieder Schrempf wrote:
>>>> On 14.11.22 12:29, Mark Brown wrote:
>>>>> On Mon, Nov 14, 2022 at 09:30:26AM +0100, Frieder Schrempf wrote:
>>>>>
>>>>>> As far as I know Fabio also discovered that disabling SDMA also fixes
>>>>>> the problem.
>>>>>
>>>>>> I guess I will try to repeat some tests on latest master and see if
>>>>>> there is anything that makes things work again without reducing the
>>>>>> clock. If anyone has some more ideas of how to fix this properly, please
>>>>>> let me know. If nothing else helps we could also reduce the SPI clock.
>>>>>
>>>>> It sounds like the commit can stay and that everyone is happy
>>>>> that the issue is that the the commit made things run faster and
>>>>> exposed some other misconfiguration for these systems?
>>>>
>>>> Honestly I'm not really sure how to proceed.
>>>>
>>>> My first impression was to keep the PIO polling support with its
>>>> benefits if there's just this single issue with the SPI NOR on our board
>>>> and assuming that the performance improvements uncovered a bug somewhere
>>>> else. But at the moment I'm not quite sure this is really the case.
>>>>
>>>> I did another test on v6.1-rc5 and disabling either PIO polling
>>>> (spi-imx.polling_limit_us=0) or DMA (spi-imx.use_dma=0), or both of them
>>>> makes reading the SPI NOR work again.
>>>
>>> That was a good hint, I think I've found something.
>>>
>>> Can you check if this fixes your problem? Just a quick hack to, a proper
>>> solution needs some more love.
>>>
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
>>
>> In my case on i.MX8MM the SPI is fed by a 50 MHz peripheral clock.
>> Requesting 80 MHz for the SPI NOR triggers the fspi > fin condition in
>> mx51_ecspi_clkdiv() [1] which in turn leaves *fres uninitialized causing
>> spi_imx->spi_bus_clk to be set to an arbitrary/random value in
>> mx51_ecspi_prepare_transfer() [2].
>>
>> This in turn messes up the calculation for the PIO polling byte limit.
>> In my case the limit was usually somewhere around 8000 bytes, so the
>> 4096 byte SPI NOR messages get transferred via PIO polling.
>>
>> Having large and inefficient polling transfers shouldn't be a problem
>> and lead to corrupted data, but I suspect that it doesn't work because
>> the transfer size exceeds the FIFO size in this case.
> 
> no - exceeding the FIFO size it not a problem. If you limit polling to
> FIFO size you effectively disable it for your use case.
> 
>> If my conclusions are correct there are two fixes required (though for
>> my use case each one of the alone is enough to make things work):
>>
>> 1. Make sure spi_bus_clk is correct even if the requested bus clock
>> exceeds the input clock.
> 
> With a proper clock rate, and the default 30µs limit results in no
> polling for you.
> 
>> 2. Limit byte_limit for PIO polling calculation to a maximum of
>> fifo_size, so we don't try to poll for transfers that don't fit into the
>> FIFO.
> 
> One of the performance benefits of polling is that you don't get all the
> IRQs needed for refilling the FIFO, please keep this as is.
> 
>> Both fixes are quite simple (see diff below) and if you agree I will
>> send them as formal patches.
> 
> Please just the first one. But let's fix polling support, too. I'll send
> a patch.

In the meantime I already found out that the second point and my fix is
wrong. Thanks for clarifying.

> 
>>
>> Thanks
>> Frieder
>>
>> [1]
>> https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi-imx.c#L447
>> [2]
>> https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi-imx.c#L650
>>
>> --- a/drivers/spi/spi-imx.c
>> +++ b/drivers/spi/spi-imx.c
>> @@ -445,7 +445,7 @@ static unsigned int mx51_ecspi_clkdiv(struct
>> spi_imx_data *spi_imx,
>>         unsigned int fin = spi_imx->spi_clk;
>>
>>         if (unlikely(fspi > fin))
>> -               return 0;
>> +               fspi = fin;
> 
> This should equal:
> fspi = min(fspi, fin);

Of course!

> 
> Good catch! Please make this a separate patch and send it upstream!

Will do.

> Can you enable debugging and post the output of the dev_dbg() in that
> function.

Without the fix there's no output as the dev_dbg() is skipped, with the
fix there is this in my case:

spi_imx 30820000.spi: mx51_ecspi_clkdiv: fin: 50000000, fspi: 50000000,
post: 0, pre: 0

