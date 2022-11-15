Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD26B62966A
	for <lists+linux-spi@lfdr.de>; Tue, 15 Nov 2022 11:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiKOKy6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 15 Nov 2022 05:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237943AbiKOKwz (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 15 Nov 2022 05:52:55 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70132.outbound.protection.outlook.com [40.107.7.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A45275E4
        for <linux-spi@vger.kernel.org>; Tue, 15 Nov 2022 02:51:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dau8MZoXQVq90a1n0OWUQaMhT7gRqdSY41z8EMHLUnIX14FLCt6fKeryv7+7Ywm9otZwwG4b+Hxd6uFVM5Rehuwr9Jzk8rEPEOfQJkrHAgkQ7JSZ2bxMabW0klukv1SnI4eJ58XlLYPjqICfkRrlXvv6MbrCe/MzxJqBmBErV957+Op34iXUyaDEhC2oKzSXacUWCKhGgBGG2IpKuTIAv2q7TvLOMnPhKBFuymgVn8NF2tgbuTl3xCzqiy/059HzXYFw1Y06kJKRTgqxHQhxAiLDUrbUq4mRGj1vxDLdjhS+3zoyLMxFR0nkHwTJQt7QRiA9H6tU3yuKaTonBtIpPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HJPXyynhufAJHt2mTzetCotTTzGHy82ayRmfpGxSas=;
 b=Dv0k9BZGrXQdsPvYERu1opL3UKGp3CzvwZWqQZW9lt9RWXwQwZQ4IwDc8/cdmbdQSUHmcFuf0UhfEqlRqeDrCB0xC7Pg7vDDk1/9YYztjjWgS0iUTvjMCpgRL1S8K3splqFlRz9adiC6DJjp2H2gdIaVvELoy6KG/WIhYRpqdGw+J47pOJ4P4YFIi96SWkX7ksB8Yf82hl1OHjPTaBLWGyY5aQlDfRfX+mDJIZsGbGXbYMdkWiMOnyPKnPiqbJbDKNcPz1i9ZPiy+sGzuxFKMlvUJPgL/+IhfZrP1nBqTxvN4VDEpkjGwAOpIpYIlEQV3ZfU/j+baR4EHpgj5aHTNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HJPXyynhufAJHt2mTzetCotTTzGHy82ayRmfpGxSas=;
 b=FLGGa7ZEZwsdDwpSH6D1bzOJl46Y6clgXLIBpazbVpozbpPVQ5DGy/gz/GhyUt7UuGlUhi/vwhLMMu1qNPWm3hMqX+wMAWyZjX6C+I4eTNoV3XqP9TKhRrxLF83BovMKZv1CSjS1F2aKFpM1AiYlw+Cxqe1feLiv6uafujWCVSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PAVPR10MB6837.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:321::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 10:51:55 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f209:bc86:3574:2ae6]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f209:bc86:3574:2ae6%5]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 10:51:55 +0000
Message-ID: <46dc7280-545d-6b8c-ff7f-4bad13486292@kontron.de>
Date:   Tue, 15 Nov 2022 11:51:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] spi: spi-imx: Revert "spi: spi-imx: add PIO polling
 support"
Content-Language: en-US
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
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <Y3ImhoSzY1PYMp+9@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BEXP281CA0014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::24)
 To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PAVPR10MB6837:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e2cbbc3-8e52-4865-d77c-08dac6f7691e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EbfVbIGAXFlnDkfV7fJ5PCxk+zXOww6cMpnRJFdnRx+nRCpBBYdToJC8LvjLBYbUv73yQCRRtLUwWWkG+p1JLhWnpTHNKeA2pTv996vzVztwLn4DAkL8XXAJkLdhfLgS2ZujnYImFF26u1Yxbg46fH6ZfPvlj59wo/dtx5avRgOjjMTB/uNkMfSafBOo4dp0GBezm+SA4z2Lir1oQwlHPdt8+lTnKOoFkD9RgR5siAlOq0iXqOHhKUSSP55fx0iG3+y3R+lWeClBMTCNEpbbt2ULbhDEgfDQrdJLhQ7pELAzA4X3yoiSNe/BMnPZqLl4DqmPhngbVJERrsJHVt/sjvCycCDOv6+hi7vqXat1ouvqcAAIx1xqqpISK/qKhegU0QaXAC73toPqXvRCzsNjgWyYEoBrr+/sZ1r619wqmVMauVCTPKNAkbLEDa8Q0c75mEusMFFHt4BvtLMwPJkDXGuAp11M5ZRySl7EZk0Xto1dwXiQifCz7gQahbluNW16KXNMWr/4dasCTZgbTmMERu3braQy739419a3J/y8ttBRCboaTgsDw1cMMo/D0jEJYUg8ICgpLSAp5ijd+fBXNza/O+iJjXYcHz8dhrmC57hge2Bg5AhsWrXNMGIXJVQlMpPrKrZ2ZW9FqdwLn2u7u+7xsliX190IfGLUMbJOdMBc9s5GVGoV4Nv3AEBnAmkk0Jfy/+5zjHspYQpYK02pNoZQQfKIioonj1xMpCctOorRP7NuL4VCiwcddiZexQYS13Ij/y5glfAgmsM3eicWWfCpT1XHAjt3BAjRQyIB/Zw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(451199015)(6506007)(6512007)(53546011)(31696002)(6486002)(110136005)(316002)(38100700002)(478600001)(36756003)(86362001)(186003)(2906002)(2616005)(83380400001)(8936002)(31686004)(44832011)(66946007)(66476007)(8676002)(66556008)(41300700001)(4326008)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1FoR2pzQUZ1UzBENHVtK3l1c1QzVGsxcUt1SlNoUkVMZzcrNlcvOXlCcXpl?=
 =?utf-8?B?RmZUenZsa3N0WEpMUVRMRjc1MWpDSFRoY0Jrb0MyMTNxWUdGVS9MN0JLSE1F?=
 =?utf-8?B?aWxmbGJpQUo5NzJrcXpkcXNRQlA0MUJ0eWJNNFJpMWxITFIreVRIeDZRVGZT?=
 =?utf-8?B?Z2drSW5Pa2hMZnd0UnFNUk9QSXgwb3MyNUxURkEwaEJ3cWZQd2ZlZHYyUmN5?=
 =?utf-8?B?Rm5CR1Z0aDR6cXRITUpkcXUyeitsY0JSVjlJZ1hBZWY2YnoyaWdQTXJyUkN1?=
 =?utf-8?B?SjNjbnF0UldTOG9DbU5KUVowNUswWEdmV2VLUkVESy9LRTU4QjN6ZGdMelZR?=
 =?utf-8?B?b0FpSk5CclQwdFRBOUs0WngvYWdIZWNQYmFZSlZXVWtMa0lNdUVBZDQ5c2VC?=
 =?utf-8?B?WFN5VUpVenJ3UFZ4UmlIOEdLMExtbGx1MkZGTHI0TjF3R1ZFdzBhT2hmNE9U?=
 =?utf-8?B?RUlhM0RiRWZaM1Y2Z0h3dFVDckx3dWErejdEZnFUaGFlZm1UMXo5eFc4VTRJ?=
 =?utf-8?B?L2RudzZBelBRNlpXZ1FvLzlJS1gvNHBXRC9MUjdXa0Nrc29GUmZObWJZWks0?=
 =?utf-8?B?Vjd1NmpleXFsdFQxUGxScFNDT1NKTXhYK1VIU0pNY3lXNDA5azNENXRVazJY?=
 =?utf-8?B?UmRJbzdPVGhtZTdxZmdsZTlMK0M3aFk3YllqaFZiMFBYeXBtS2s1aXMxaDl0?=
 =?utf-8?B?TnpNWUhQSnc0Y2dMdkRadFl5Nlh6T1ZveTNGai9leHFseWxkWFpFTGFtUGRC?=
 =?utf-8?B?a1pzZDBjSWVkS1RLYldIQkJPaWhZaDNEY0sxb1gvNFJjSFh6eHQ4RW5lT3Br?=
 =?utf-8?B?R1dXeGE3SkpFd3JUTnhDeEtLUTFNZUFBWFQvb0VMWjlZRGtaK3hDWENUQnox?=
 =?utf-8?B?UWlzREZxZ1h2RHc5SzFrdjVFN05aN1dJd1lnRHhVVUpHc0J6Q09yNTBHUGZO?=
 =?utf-8?B?aDVqSzdIWHJ2OGdGaTF6SSthamtzRXBxazF2YlNxMWU3SUh5S3ByeERqOHFi?=
 =?utf-8?B?ZEdsdUJQUHhESnBiaVpTNUJUVSt4NE9Nb0RUWlFOaERBOTR5d1RZc3hoUXQw?=
 =?utf-8?B?UFB3aTZqejBTSmpwOHFqSmdUN0h0bnd6ZGExU1RtcDNqVFlsbFZrR1ZpWnhI?=
 =?utf-8?B?QUxwOEw1S0NONE1tNUJHdFlNWHN1RXJFZmgxUVk0NXR2enlGaXRjR3RJUVFF?=
 =?utf-8?B?WHJrTWlyRW91S1JZSUwrdWEwUzlOa2I2TDBTbXF1d1B6anFVdHNubzhQc3ZX?=
 =?utf-8?B?R3pwUTIzUE5idTd4Z1V0VnN1K254NHg1RVJsRnF6c0J6Vk9qamxMclpLMWZa?=
 =?utf-8?B?ZXB2dGZXVytsdmNtY2E0YmVZTC9uWXdCVGY2RkpwMTVSMFRYVmpJR2JNVitz?=
 =?utf-8?B?aGQ1dk1TVzdmOVNnRDE2SEhZS1VDNDBQaW55WFJaUFFkaXNsN1l4SDlqN1ZR?=
 =?utf-8?B?ZDdmV2JITHhrR21HN3hFTTNjSHNhYVEwK0Jhdy9SdCtUOG9QZDBtdFdpdWFr?=
 =?utf-8?B?cGxnOFZzVjFqUHZHSHNHWHdUZll1UGN4YkVQZWt5bDUvelE2OEpBbWlLREpa?=
 =?utf-8?B?WXBJWnQ3M3h2QlprVTkxaGRjZUxkV1Fxc2t0WFZzSGhWemxGRi9WLzQ2REdu?=
 =?utf-8?B?UEtKTVI0TW9EVGxkWG1VU3NQUThhREtPYjJHeFFsTm9TdGU0MHZzUU1sSnhq?=
 =?utf-8?B?eUhOR2FFblhpQUVoUmNsZlNHUTh5akZROUhrZjJoak84L1d2NVNoUW5vUDlU?=
 =?utf-8?B?S3pSMWpmc1I3SlRyOEpFdXAwMys5KzhIamZTSG9nWXR5Y0FJK2xwbDVpWUNC?=
 =?utf-8?B?a0c4VjhoVDFkY3dxaDNlMG81OWJZTTRyNENWYk84cVdpc0tObm5pUFF2K2V1?=
 =?utf-8?B?TE5IRXl5S3FGUVNWU0VySGRhSTRFT1NkOWFiTVNRbDBFdGRHRXhIaHl5TStR?=
 =?utf-8?B?UXFLSUp0TFdyNU1GZ3ovZm56Q3NuOVlSVUdrakl3VGUvK01MSmp1WHBXN20x?=
 =?utf-8?B?NjU2WTh0QUlHYW1GMkhSOGJCZXR3K3J0NlVoa2pwVmpmQ2ZTeTZLejJQUHNm?=
 =?utf-8?B?OVF2NkM2djhqRWFrWlk5MjVKVzdWOS9RNldUb2pWcFJMc3lGMzVCQXcveWtl?=
 =?utf-8?B?YXlGMjd6UFhzYVovZ2hqc3pldWZMNDl4MFF3QzNjd3BSYkxVSzNmSWxqOUhv?=
 =?utf-8?Q?WKMayNmhvAFeKKZe5z3PBfJiE1Y01CybmbcltCkgn0so?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e2cbbc3-8e52-4865-d77c-08dac6f7691e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 10:51:55.0446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lU8O7f03HU7+yR9bbtRjjaixCjsBRokxTBfgE8xClRxO+RvHFrHyVvFh3l02AByUQKpO6jwF17CDDeTC/0hhYJc/uivqZYnHqMvnTT/SgcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6837
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 14.11.22 12:29, Mark Brown wrote:
> On Mon, Nov 14, 2022 at 09:30:26AM +0100, Frieder Schrempf wrote:
> 
>> As far as I know Fabio also discovered that disabling SDMA also fixes
>> the problem.
> 
>> I guess I will try to repeat some tests on latest master and see if
>> there is anything that makes things work again without reducing the
>> clock. If anyone has some more ideas of how to fix this properly, please
>> let me know. If nothing else helps we could also reduce the SPI clock.
> 
> It sounds like the commit can stay and that everyone is happy
> that the issue is that the the commit made things run faster and
> exposed some other misconfiguration for these systems?

Honestly I'm not really sure how to proceed.

My first impression was to keep the PIO polling support with its
benefits if there's just this single issue with the SPI NOR on our board
and assuming that the performance improvements uncovered a bug somewhere
else. But at the moment I'm not quite sure this is really the case.

I did another test on v6.1-rc5 and disabling either PIO polling
(spi-imx.polling_limit_us=0) or DMA (spi-imx.use_dma=0), or both of them
makes reading the SPI NOR work again.

Looking at spi_imx_transfer_one() this means that doing PIO polling
transfers for short messages combined with normal PIO transfers for
longer messages works. The same for DMA transfers only (short and long
messages).

The problematic case seems to be having PIO polling transfers for short
messages and DMA transfers for long messages probably interleaved in
some way. And this sounds more like a problem that is not really
specific to our SPI NOR use case and as I said so far I didn't find a
way to fix it other than reducing the SPI clock significantly.

David, Marc, do you have any idea if this could be a general problem
with the PIO polling implementation?
