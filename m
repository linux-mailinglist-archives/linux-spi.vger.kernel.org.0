Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58D76277B6
	for <lists+linux-spi@lfdr.de>; Mon, 14 Nov 2022 09:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbiKNIal (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 14 Nov 2022 03:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236438AbiKNIac (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Nov 2022 03:30:32 -0500
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20099.outbound.protection.outlook.com [40.107.2.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020F71AF38
        for <linux-spi@vger.kernel.org>; Mon, 14 Nov 2022 00:30:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=De5hn+6bwIf40hQKMr2rTuRpM7sIAzMVROoCDOXbKQNT/I+CFtVl/8qzCpEHvlEPXFOssKLtRF2wN/YM51qv1rYNT7salnwC3Q4tWWAIuIZShXTtWFD5C45eDBlel8fa2b8GBEGrmu+koffrSBjKPEttCUGFHWqno+zOzqlCYtwY+sD8liG04Xak8dpYN4u7VXO5lyRmyQa0bRZ8xUNFrF9vUxkvoq2YGF0WLYZyNRX4XuFG8fPtviuepGF7AkLm3HiGaPulPKI/7GDLbyw4pnfKnxdL7Q9McV0EKKT0NA2WlJaiPmfdn5QVI6tp4tVgvSU2IPhkd/XxQ0bYRi875Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NcBjDq6Rq+aUQ4tHyM7dU6/5bJ4s2MQJjq/9ECpexk=;
 b=hry+/NZXerqoo8I+VT2hldhHmKmKhj+SGisuH9RBvD6jwDoiPGGinvaKAHZTCI3fOPeP41wHQKA9qpVuMP8acn8M1CafSg5ZmFMuuaS26DiS/YfDmMoe0UvmuYXfY61HfOzGqo0D8T0tEGhK87X6R1YtjPoc8I8pjKDmo9MVHN/2LxGiRD9n0qeqY3+gkJ+v3Bn2aF4XIdYKvMVPgNl/kx23ivswDEWoKfWK0ezlXRi3gKI4mAJV8JfExYz7usYvtD3dQnPFFa1TLMpV8r02OvSIcPtTai79ADyjS0vf6SnIzKBolwvQYEUiKbxRkK1xP5CwnyHj7EB+hILcSj/EXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NcBjDq6Rq+aUQ4tHyM7dU6/5bJ4s2MQJjq/9ECpexk=;
 b=JbVYNOOIIGr1i49fwfqqOg2PeBZT7pE6DzKldyzSYFmq5KbjARrVU+vLsqqtwWGHKHwl4UoS2mBbhe/5p7xRxBvdACF8f+FJeWLEGy54KfgnByxRnSS8opTGBpWThy59k/RtLRgnheX+m/V1bQtrWZYzd6qbTl7x6BOKp2X2xIw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by GV2PR10MB6959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 08:30:27 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f209:bc86:3574:2ae6]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f209:bc86:3574:2ae6%5]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 08:30:27 +0000
Message-ID: <1c70bfd1-38f6-3a30-9e36-a0f780f82571@kontron.de>
Date:   Mon, 14 Nov 2022 09:30:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] spi: spi-imx: Revert "spi: spi-imx: add PIO polling
 support"
Content-Language: en-US
To:     David Jander <david@protonic.nl>,
        Fabio Estevam <festevam@gmail.com>
Cc:     broonie@kernel.org, mkl@pengutronix.de, linux-spi@vger.kernel.org,
        stable@kernel.org
References: <20221111003032.82371-1-festevam@gmail.com>
 <20221111105028.7d605632@erd992>
 <CAOMZO5CH9S_RYpLNZbRxChzSVkkZTAd+qpxz1Ycj2UUPROTXpw@mail.gmail.com>
 <20221111135919.63daed2d@erd992>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20221111135919.63daed2d@erd992>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR05CA0015.eurprd05.prod.outlook.com (2603:10a6:205::28)
 To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|GV2PR10MB6959:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e16b176-6376-4b0c-041c-08dac61a7b97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bEVT/wW0iE/GspiH8QKrMBK2K0lLRmuhXHlF2MHavLH4wKTOF/eTmjxpNdqQtT8NOwgbf64oi97xvD5jR1iuYAuOrHJezpPI7YyjLu9wvOUOV9KtmWsZR+T8aQBje2KnvjB9ODVcgzGCujsISTryTmef0/IpAyXeFMKptpITbQbhXgDLSE5i1lrY2dZy43esel3M0k1ydRUz0kIODSXjj7978RTzaN09U2pjrXKgmVwNFMuE9OfUvgw0Dhyg6SgIXy1hxTYQsXSvuFR3TRo6jRzGuU4bXh4HksJCs45EIwGv0itNTsALqTxoseA0ipG2JyOwyWM6Y63ENnyrxoKOwwuYmsLh+QdAnY9POv2LV3mE5pvM44QQGQ1uzHXXJPobudaFybE4jRaWSFkwk58wPaJ5AB/kD1HM2avdKCmDBrEKSd7jqz357rRYnBhB6u0kmvHrDrQpNe4rNCd5aTEltjPsScvptDv6e1zzEpT+E+p9uqstel9rTCPoQOTQ9uic+OGEOm0n8gAPKQ29rVkkvCDuq8UXky5kx6yujNQqFJyNuoKWkLCFszV6aSoWTx4Xc/uR4p7RHUv6ld1JvYJ2pzirnWJgdss8vAoWTJIKv7ulxiB20Twgtc4hurMggI3nwMxA7aH1S6zjSkYKOGHpMMrWdON98wL7YiH9HvTxImMkWh7wg66EcCUjP7V1yJEAtGXXD4DYqYHGbw7z4OkGC2VZblC1b9OK2SqnwN8Lr5G3yYe/jvSRRhds2/pG+FCRY1I1X7yihzILEN9YsqjJHHkX6+0X483oN46Zqs7TPLo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199015)(36756003)(6512007)(2616005)(83380400001)(26005)(38100700002)(44832011)(41300700001)(86362001)(8936002)(31696002)(5660300002)(2906002)(478600001)(6486002)(53546011)(31686004)(186003)(110136005)(4326008)(6506007)(8676002)(66476007)(66556008)(316002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkFQSTdyR2liQjA4R3dLT0NyOUQrR2lLbnhveTcwZWNSWjIrVGkwZERiYW53?=
 =?utf-8?B?ZUpXa3R2UGdtRTdINWlYdFVZcDR1U08zZTdFc29XV2hvUkJVejQ0M0VXK2Jo?=
 =?utf-8?B?ZnpFQm9TbHRTb2trT2FQUzUwdFkrYjgwZ1pTeHNISWFpMk1SVGRiUmhLNW5O?=
 =?utf-8?B?TGRhZWhpMUtST3hOUTc1TTZjVXZ5ekhrWkxmMkJpL2t1R2FocDRYNmtaRkVI?=
 =?utf-8?B?OXBJRlJjOVlZakpzM0VVdi9GTEhmRnZkUjZOam1lN0dhUXhWYmI3N1BabzR5?=
 =?utf-8?B?WGFDM1YyT0lMZ2prNlhQNW9kZkZrMmhtczlHZmFMVU82WXg4YzI0V25rZ1lu?=
 =?utf-8?B?cEZJZ01HNTF4S1VoaFU4RWtOS2VZeWtRUWlEeGZJZ08xbm5BYzJVWkd0a0R4?=
 =?utf-8?B?OW80bEtmLzdKa0czcm0vdXVRQnJ2VHVSaWlZZkFKQU5LNkVHWENuaDdIbmZv?=
 =?utf-8?B?eTJwM0tzajR6Um9aSmx1OHJuMUhQOUpUWSszQ1FCbFJYL2QrTnlqajNwZ2N4?=
 =?utf-8?B?bGMwYTlZSlFMOVFuMVRXN0d1SHFuMUxjZkJpQlh6RG9semM3eCtLUHNnS0Qy?=
 =?utf-8?B?azZDc1Vyb0hpc0VOQ3h0c3VFaUUvZVBvZk9BTWJRSXZEYzhTWkY3TXRWZ3lL?=
 =?utf-8?B?c2ZzU0I0TWpyMkROSHRyeXYzbU5LZmZVVW44a3VGcGp4WE0zTFBRYjJnTmRL?=
 =?utf-8?B?QzdqSnlVazJJOWEzcCtFR2JuRkVWQWxvZ3FEckJyZEIrcy9JMGRTNmN2aDJW?=
 =?utf-8?B?RjNidmtlZVUrekVSWWF2RTd4eVdRc1poZmVDYU5IOUFsZGYzcFdnRGtCcEFS?=
 =?utf-8?B?Qnk5WFExdFFvT0tyYlhJQUlQeHIzd1E0NFJMdURxclB2MVJsSnV2eS8rSmdM?=
 =?utf-8?B?c1UxREhrenlrckVYRzhZQzd4dGRmdjhKZDZjZ2FucDB3SmYxNWx3MlE0QmZR?=
 =?utf-8?B?WXZOVUdtQnAzNWhxUlZKck80NmJVMkJZaCttNnk4a1ZpaVhRVWRicHdpTlBO?=
 =?utf-8?B?WkZBOUJCbjBNeVhtRXZSdEFmd2liR3lxTXdsYlN2ZCs4SUNucitDS2xCdmVa?=
 =?utf-8?B?Z3VnYitBa2xGYmw2L29QSWQzRFhreGhPSDlSam1McU5UakNCMFdwbXVqdCs1?=
 =?utf-8?B?akl5RERFVlk2SUhBQ2MvaDlQUldMSFZ4WlpRbTcxLzNwQ3NhRlNFbTFUTnhM?=
 =?utf-8?B?TWtUa2tGUEtscEF2OGVMSy9VdHl6Smh5VmNSYisvTjRnR1RoSTdWRWtKYUZw?=
 =?utf-8?B?RFUwYklsUVpmRFNzQU5sdi9ZOWRsaUgwZ0tUUTc4QlY4b3FWZWQzU1RPTW8z?=
 =?utf-8?B?TmdWM0t0a3BqWWhrOGQ5YXNTRlpMWmF6WUo5bC91RlpzckVKaFJDSGVTS2Fa?=
 =?utf-8?B?bGNoaU1rV3ZmNjVha2JFZ1QvZ1hkaGw3alIrdmw3OWZ6Z0JTUjJHNnh0Z1Z6?=
 =?utf-8?B?S1hYYjR1d0dvZVVxZ1NwZlpUY2t6eXFPZ0d6azQwRkF1Y3E3L3Q4TnpvRjNM?=
 =?utf-8?B?VmZFek5nejRvWmg2aEJsUUJyVyt4Vkw1TDg2TUNBNXhyenZVUEhTdFhBTUNO?=
 =?utf-8?B?bHZYMVpFNDdjNmhtc1N4dkhvQ2xySlJNS0FOR3BXeHFuczJKMmhqYjBFTUtP?=
 =?utf-8?B?aTNkbDNuN3dwRVY1OUtDT0tnMG9HVDRJMTVtdERMU0J3R1ZGRFJoU3JhTkY5?=
 =?utf-8?B?K2VlRkk2RzdGL3RrS1pCaVBvMzg1NTN0NnBYbkJEUjlLTmNYaTBzOURNcjFs?=
 =?utf-8?B?OVBQRzNsN2szQWRXOFhkMFMwNG5GdnJOQzhMcWdoc3JGNFc3UXpzUHhYQlBB?=
 =?utf-8?B?b0FCWElrUGlvUzZTY25VZndkYmJ2cVRQRmZsSndXYlVjWldzRGR5M3F1eVlQ?=
 =?utf-8?B?UzNEZ2Zud2tjRXYyaDZ1bERUY2VicFVZYU9lajhBTWNxSHErWkVpVjlMN0Fy?=
 =?utf-8?B?ZnlQemxhTjVEbmlkeUJBdkJPdGVZUHora2d3UnNoSXl4Uk1KYkgzYThDZ01t?=
 =?utf-8?B?MnFLUEgyY0Q3UFRuelFEYnptWFMzSEtIR3BwbFloOEk4MmM4ZWxlczdHRXRw?=
 =?utf-8?B?ekZ4L2JJZHpndzM2TkpVMnYwOW1ZLzNNbUo1TGp5R0cxOFQ1U0pKMm9IaElB?=
 =?utf-8?B?eGp0NUxraEl5Mm1PekswMWJpMURMMGtpYzZ2cVhvOFFMU1B6UFFPTXlLY3dt?=
 =?utf-8?B?bUE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e16b176-6376-4b0c-041c-08dac61a7b97
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 08:30:27.2227
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lmjJ+H9B9VfE07FHhIb+D+y2mgvtmKk9N+oeYcCoz9NgeX6QotM547owaQ7HZR90L7pBvfQ02oN00RjV0fxmwthIuehziZA1X/oXL/uOGtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6959
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Fabio, hi David,

On 11.11.22 13:59, David Jander wrote:
> 
> Dear Fabio,
> 
> On Fri, 11 Nov 2022 08:33:03 -0300
> Fabio Estevam <festevam@gmail.com> wrote:
> 
>> Hi David,
>>
>> On Fri, Nov 11, 2022 at 6:50 AM David Jander <david@protonic.nl> wrote:
>>
>>> The effect of this patch is that it will cause short SPI transfers to have a
>>> lot less latency than without this patch, so could it be that we are looking
>>> at a timing related bug in the MTD driver, or some other timing issue?

This was also my first suspicion when I originally discovered a similar
(or probably the same) issue on 5.19 with wrong data being read from the
SPI NOR. Reducing the clock to 40 MHz fixed the read in my case.

>>> Your SPI clock is 80MHz, but the datasheet of the MACRONIX MX25R1635F
>>> specifies a maximum clock of 33MHz. Is your NOR flash chip capable of this
>>> clock-rate?  
>>
>> Thanks for your suggestions.
>>
>> I have tried passing spi-max-frequency = <33000000>, and I don't see
>> the failure anymore.
>>
>> Looking at the MX25R1635F datasheet the maximum SPI frequency is:
>>
>> 80MHz: when L/H bit is 1 - High Performance mode.
>> 33MHz: when L/H bit is 0 - Ultra Low Power mode.
>>
>> "L/H switch bit The Low Power / High Performance bit is a volatile bit.
>> User can change the value of L/H switch bit to keep Ultra Low Power
>> mode or High Performance mode.
>> Please check Ordering Information for the L/H Switch default support"
> 
> Oh, my bad, sorry. I didn't read far enough into the DS. I just wanted to point
> out that AFAIK, if you use a clock higher than 33MHz, you probably also need
> "m25p,fast-read" in the DT:

I already tried changing the pin configuration for the SPI pins (slew
rate, drive strength), setting spi-[rx/tx]-delay-us and enabling
m25p,fast-read. Unfortunately nothing of this worked.

According to our hardware department we are using the MX25R1635FZUIH0
which has "High Performance Mode" enabled by default and should be
capable of using a 80 MHz clock.

As far as I know Fabio also discovered that disabling SDMA also fixes
the problem.

I guess I will try to repeat some tests on latest master and see if
there is anything that makes things work again without reducing the
clock. If anyone has some more ideas of how to fix this properly, please
let me know. If nothing else helps we could also reduce the SPI clock.

Thanks
Frieder


