Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30979629830
	for <lists+linux-spi@lfdr.de>; Tue, 15 Nov 2022 13:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbiKOMJP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Nov 2022 07:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiKOMJO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Nov 2022 07:09:14 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2128.outbound.protection.outlook.com [40.107.22.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83ECF205
        for <linux-spi@vger.kernel.org>; Tue, 15 Nov 2022 04:09:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwDh0ED7PsZeNL4ttxDUI1AyASfAisSMGvYEKse4GiNieaOgctdF0yTuOicDT5a0lR2lDxWWAW7zdKHDpNT8DRKhkrl6CtXeJbWzZptB2fpHe7BN8yF44JER621MG4OmEEImT8Cv7dmB2w8Q9B1OWl+tq68pym3nx76bqspchpbzFmOx8bg7LmSM40FfXCNIJsDGx8IUMdDk/V5PW4TpANKkwDc+2paVrxgrLkdMH6Ps/6t7PusY/H9cftkgMsPOy41oB+c5NKvCoWt1EHw1Q+eCFAv+ubjy0kSJRzNySdAmui+c6uyyC7e0wbtUikNfpgB4vutYvFZHyG5l9xEZyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/aInrwrVfjGU9WEjbpKlOsBBG611ygdVtqhoRFUfqE=;
 b=KFHqCiSKbJhugqIO3VDhfOTi4C0GnlDphDEnfFfuV2U422K8cP4xON8cqNyDy2LTf6nLHl8kn+9qiJ/Wc7hZ0uNyyPzzCK7vpIMg4n5Jc7iKw6RZht3oVp7TKqm/FgXJdFN5Or8udJiNZjR482fFE1zaAW6W5E/loeZ993kr2MHDLpnb4kepIleyEX2Pus2kHkYYM8fA8Ma9LNMgu3fmQB4lV9zmUwnlQvvXA+wKu1LLdU30QEKvf+IISXqWInMHml/XAWTRoyw7yiwmM+IkTKkY5p4neJP0sMeKRpe/qylgl3a4JohEeLFQDXieHgfxv/Bly3EQHDcCKvN08ZC+BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/aInrwrVfjGU9WEjbpKlOsBBG611ygdVtqhoRFUfqE=;
 b=H8W9jnxOKkzHJd+1KSABkGS1Za6+w/XZRloHnCDvqAf/i75BLmBO0VwcSxi6FWuIXMILHuzmLzMvMqFaBTtBDXriKdzZJtD95jGeWh5oKosg8SCpZ8fTQBeSRyauzbzzXGxEawacjgTfntYcSXPoZcSe6SfiuWb84L3c8PYD9SQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AM0PR10MB3555.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:157::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 12:09:11 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f209:bc86:3574:2ae6]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f209:bc86:3574:2ae6%5]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 12:09:11 +0000
Message-ID: <693c1671-80dc-7027-3cec-b4ecb17a4fd6@kontron.de>
Date:   Tue, 15 Nov 2022 13:09:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] spi: spi-imx: Revert "spi: spi-imx: add PIO polling
 support"
Content-Language: en-US
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
To:     Mark Brown <broonie@kernel.org>, mkl@pengutronix.de,
        David Jander <david@protonic.nl>
Cc:     Fabio Estevam <festevam@gmail.com>, linux-spi@vger.kernel.org,
        stable@kernel.org
References: <20221111003032.82371-1-festevam@gmail.com>
 <20221111105028.7d605632@erd992>
 <CAOMZO5CH9S_RYpLNZbRxChzSVkkZTAd+qpxz1Ycj2UUPROTXpw@mail.gmail.com>
 <20221111135919.63daed2d@erd992>
 <1c70bfd1-38f6-3a30-9e36-a0f780f82571@kontron.de>
 <Y3ImhoSzY1PYMp+9@sirena.org.uk>
 <46dc7280-545d-6b8c-ff7f-4bad13486292@kontron.de>
In-Reply-To: <46dc7280-545d-6b8c-ff7f-4bad13486292@kontron.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:26::13) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AM0PR10MB3555:EE_
X-MS-Office365-Filtering-Correlation-Id: dd17a962-0901-4ba2-28f4-08dac7023499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X01uQJZQZPu0Vobk/wFgBEWP2dA/y7f3HDbgnzyEjiYsL/c//YifZSOvVrVUwpz9PTsESec8MHBNCwMnOgTCVe8yE+YC1K6Dx8JOBSlgTa8rk1YQbU61kLWEbdCTkVtieGgumAf1HNenTuJRwWXDoXrBZp8thr7pfGTPk9EAICl5tsZsPotkY1cpdHs/65nan7jOhGD2+BLRPt4rF045AfvW1k6LRPUiPDKi24ek8FeqmA2EsU6aaWFf0JZVmTl1it+8x9kZBDW5MAGO25s8Bjn0qMuQQAy/gWm1Ewn3Vx0RyDKmS+ZhYVUXgVdcW0QUW0mEwwOgSlQLB/EcllXXlBjhfqdfKDFLfcjHvPjPtVfPlNcVncLy9zmCLOEX6nZb42GsfmJNoj3BnkmgK7QNSvavkyJFrounZZDHO1lzi593jbCrCs9qzkxH7uXTofKS0rR7gZGVR8MVJZCXVr3QDKOa0CB44WZA4c/cJIEnCSQr18zG/cSpwr+qjwpgTDlXWC1EkeCwWisZX4+Yg+jrQr3aSpsA7ibD9+LgfllVPRS4GXeN7v8kD0urYZAbQCbmTK8Jh6/YnXfpnIQ58VgH2xDUE4wzk+1b9baZ/VqIkibQhFzm7m4tDl6SVSjIG645/Sy1DJ6u9ykkDKooJmrBFaCoX0Ic+zMsSSyLhuBJM4EgAaZ9DE5jgvKYjZToqhlrmjMkMerUgwdhZr4/k+uFsZWaRy4C3gS+OtU92RyHzpTZ2dONMGajDfxsW9yqAGIRbQZMVged2MZWvudWrhTAJp53vk5QDl1txDHod3QYLG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(39860400002)(396003)(136003)(451199015)(478600001)(31686004)(36756003)(6486002)(5660300002)(8936002)(83380400001)(31696002)(86362001)(38100700002)(2906002)(186003)(2616005)(53546011)(6506007)(6512007)(316002)(110136005)(41300700001)(66946007)(66556008)(44832011)(4326008)(66476007)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFdKa3h6ZEc3Z09xeUo1clJKMm0zYW13bVlUdks4Z0pUY3hhdnRPZFJ6NEZs?=
 =?utf-8?B?N0tDL0duTzhuVHRwY1RnZWIzZUk3VXdpTGdQV1JEaGRhOU1LNjZaTDUweU5F?=
 =?utf-8?B?OTVOQ1RDbVFwS3ZUK1kxZ3NrL29vNEp0VExGbnl4TU1aendXbVFnNzRFTGJ3?=
 =?utf-8?B?ODc3dVBZaUJOS2dHMzFFMnY5QkdQeHY5WkhGQ24xcUVoNkMvK29NbDhJZGVr?=
 =?utf-8?B?UVpjaDBsSDBTOFpZbHhGSVZWMGQxdTF2MWpDV3pLRjY5QUZ6TkhHVExPSnR6?=
 =?utf-8?B?dnVJOVFxckwrSTRITkxnS3Bjd1QwTStwdDRpdlVHdlFxdi8zZUtHVFJjNExv?=
 =?utf-8?B?a2Q3dmRzV21YVm5WQUhKY2ZIenhUb0c5bWNManRvQjFCdU1hYnp5NjFDTDdh?=
 =?utf-8?B?REhxUkM2RXEzNDYrNTM5c3E3K0ZBTXpkOVhtU0ZEekViRHBYME1KaUFDWU5G?=
 =?utf-8?B?MWJEbWtBVGhWR0FYdVdnQkpyUlBaWUgxbHNQWHB5UWwxOTQ4K3l4WElXbVpz?=
 =?utf-8?B?M0pFSzBWOWZPMXlNd0R4MWpCRll5ejMySjdjOGtYVGFxUDU3N0xtdGVDa1A0?=
 =?utf-8?B?R213RWhqSUR0ZFcwQVVIWHFxU0ZubmZrekpNbi9KdTlVQi9ObHFjbE1OaWlH?=
 =?utf-8?B?R2xPSG54OWRERnV2d2lpMFBtSGxaekNPeGhPMHFyV2dvSHROc2JSUFVKYTdN?=
 =?utf-8?B?eDFpWWZIY1ZBZlR1bzJzRWsyV1c0bkU1NXJzM3diRVBUNExNY1BZdjlHeDA1?=
 =?utf-8?B?WWhkWXJXZHdxcUhTaTd6NU1kdkFJTEp5ZjJqQUlURzAycHpZWTN2eXhmUWdi?=
 =?utf-8?B?ald6Q05aNUFyVHl3dko5cUlJQWg2MnQwTTFlQ3hqOVRLcU1peTUvSDNKNlho?=
 =?utf-8?B?aVpXVS9McHRkZU9pK1p3Z01FREVvUE1HNUpKWnhMWTFROVd2OGEyYzdrK3JD?=
 =?utf-8?B?RXR6c0V6R0hnd0diNmp4TE5DWU14YVFQOGdwa2lFMjVmS2pEdy9kajlTQVRV?=
 =?utf-8?B?cURyUmxsemhQajRrNFV2bFNuVlBWZXBSeDEvODk2c3krMmM5NUgwdHBrcjNB?=
 =?utf-8?B?RWcvTm5zbjN1QldBdDQ4V1JFZ0MwUWVORDdVVG51MVkxZzlINUlyb28rRWNa?=
 =?utf-8?B?dGs1WXVzZXhqNVFNU3htYVNaU1VSeUt2Qld4NXh0Y2ZOZDN4VXNVdUkwV1E1?=
 =?utf-8?B?L0lFSTdrejkwNUZJNW03dW01SGd0aGZUYUJYQWEvM21janZ1dDBRU1FWUjAv?=
 =?utf-8?B?VTdrRnVzalZsTllQMzk2WnY2dW9Oc0xLY0RvZGhJdTIyY1ZQS0JSM1J5MmQw?=
 =?utf-8?B?c2tweWphSlVsRmhOVUFoaVgya3BTRGF3UnJON1BiNUp4bEE5QzMrVmdHbHF2?=
 =?utf-8?B?R05OdlBrN1NBNHJTMmVVWWVsajJaY0taSUpvN1lvUVBTMWlKeXpFRHpZT3Fq?=
 =?utf-8?B?emx2dERjb3FJL25CMi9yT1lrekhuemRXakJub1RzVzVaZnF5THREUVFFYUNn?=
 =?utf-8?B?T3ZrMlk4WjRpZW5ocnYwakJGYllpc09JOHNHc0xDc3lTSHgxUnRiREVXN0JR?=
 =?utf-8?B?M3lXZVFjMll3QzI5ZUwzY0JGTTIwK2tTRXFQemRtRmdzWDNCV2ZobnNBbXlG?=
 =?utf-8?B?YzB1WXo2R3p6cHR3Vm1DaEFORDExdlBrV0NGR2lJTzV4bndkWWIrNTM3V1FN?=
 =?utf-8?B?dkhhVDZNT1RYK3drUjFvOXZFQ3o2ZlA0WXpVSzRqUThQcTF4b2lMTzhUbzVw?=
 =?utf-8?B?dzAyR1Q2SVNZUzRyTEx4N0ZQcTNhdUpObk9OTml1TUZMREg4RTQ3bmozNk04?=
 =?utf-8?B?aC9CWVhvWDMxTktZQk9VWXRHWlhBcnFicjY2TzlFK2YweloxY0tadWZseUhU?=
 =?utf-8?B?WFJ2SEpEK2puNm1VaFJjOHBJdTdjY1pYQm5vTSsraThVUUhOUXlhbS91Myta?=
 =?utf-8?B?bndCbG45MlB5QXZVMFRpQjFrMHNzODFyRGhwSlZPdzVwUVBqM0d1NW9NR3ZP?=
 =?utf-8?B?L1pqQ2JzeG05R1Jyang5RmFCbUtVMU1rMGQ5aHMyZnc5U3lwN1dBT1M2ZHJy?=
 =?utf-8?B?YjFsNnRpQkF6Wk5PMXhINk0xS0d0YWpEUDkxcVBmZGpzVTl5MUFxZjVXN0NP?=
 =?utf-8?B?b0Qwb2hXNG9ZSzdzVDVCZlQwbUFFYXg3UXVJOUY2Z1VlK2w0L1VRNDlDdFo2?=
 =?utf-8?Q?oFDGf4NesidAH53bImGxDDgL07n1F7xFV+q2pMmIAQ02?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dd17a962-0901-4ba2-28f4-08dac7023499
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 12:09:11.3754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c8HTP6D3d58IoAu0ygJUwutCkD5alM8i19n89u+E4ToAfD7qmrbS61SlcW/vPx0fMh6VNqob/vZn7jfzIL66D5o61Pvs0yIIS6vcIox0SeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3555
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 15.11.22 11:51, Frieder Schrempf wrote:
> On 14.11.22 12:29, Mark Brown wrote:
>> On Mon, Nov 14, 2022 at 09:30:26AM +0100, Frieder Schrempf wrote:
>>
>>> As far as I know Fabio also discovered that disabling SDMA also fixes
>>> the problem.
>>
>>> I guess I will try to repeat some tests on latest master and see if
>>> there is anything that makes things work again without reducing the
>>> clock. If anyone has some more ideas of how to fix this properly, please
>>> let me know. If nothing else helps we could also reduce the SPI clock.
>>
>> It sounds like the commit can stay and that everyone is happy
>> that the issue is that the the commit made things run faster and
>> exposed some other misconfiguration for these systems?
> 
> Honestly I'm not really sure how to proceed.
> 
> My first impression was to keep the PIO polling support with its
> benefits if there's just this single issue with the SPI NOR on our board
> and assuming that the performance improvements uncovered a bug somewhere
> else. But at the moment I'm not quite sure this is really the case.
> 
> I did another test on v6.1-rc5 and disabling either PIO polling
> (spi-imx.polling_limit_us=0) or DMA (spi-imx.use_dma=0), or both of them
> makes reading the SPI NOR work again.
> 
> Looking at spi_imx_transfer_one() this means that doing PIO polling
> transfers for short messages combined with normal PIO transfers for
> longer messages works. The same for DMA transfers only (short and long
> messages).
> 
> The problematic case seems to be having PIO polling transfers for short
> messages and DMA transfers for long messages probably interleaved in
> some way. And this sounds more like a problem that is not really
> specific to our SPI NOR use case and as I said so far I didn't find a
> way to fix it other than reducing the SPI clock significantly.
> 
> David, Marc, do you have any idea if this could be a general problem
> with the PIO polling implementation?

Further debugging reveals, that for polling_limit_us=30 the calculated
byte_limit (8104) is well beyond the maximum size of the data transfers
from the SPI NOR (4096 bytes). So I don't see any DMA transfers being
triggered which makes it even more strange why disabling DMA resolves
the issue.
