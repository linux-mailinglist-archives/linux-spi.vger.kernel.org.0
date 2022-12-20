Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49EC651BFD
	for <lists+linux-spi@lfdr.de>; Tue, 20 Dec 2022 08:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbiLTHwP (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Dec 2022 02:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbiLTHwO (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 20 Dec 2022 02:52:14 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2098.outbound.protection.outlook.com [40.107.21.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E14F22
        for <linux-spi@vger.kernel.org>; Mon, 19 Dec 2022 23:52:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D++psuTJWn+1/7PgkbdFZsPqRqCNXj4yThaBUlnCi5fVvMDfm53m2uPqvBFgpw2INaleVfCy3hcdg+wUabqqT+oa01MRTVpac4+nZYhc5BfVqTvrPitQGea+YMMXWPRcWADEIqHO16htrhm8Ruy3yE4SH2uFc3KF2QRHSy6PW8e8lMwJWK2kq7MAQHG5UCzyrU/Xh5XKQEW6pqCbOma2teB9hvvVMPOxz4+8TLCt2Ejym1jLdcGsgdJZ4olEoH0ltIKnaCsTnooWQlCu2OyIQb0QszkDKgzgO839BnX8wTNkpJkWB8RzN23SFmoAy7UvXA3KQuP4h35zSq4YUEkhJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jg0rSrIF8iGCcpgEef1TX50MJyrJBS4K+gipZ95RgDk=;
 b=JPWj/aDeY5kfabcxqETpy30Y35mUTsHoxDiQVzB+s7wR440UviSxSkq2mjE23vs+M1kyVAfp2o5vWDKaiz0sH+3lPUoKokcPYZJwpvMrDt2UMZWWCJuqDeh/5MD7TIuCePkLCjCnHFWa08fIGXMwTtt+AeGrFu1UiCqcuTe13Cjlu/6hcyTT1P0Cp0HLKmm81qpNPBoYQXGALQzjy090WZf74Cd86JNBhEsR0L3ys0HyhP5+smSU8f2i8/KIsQFRu4a/3C08O0ujjQC+GfzAc2zjZnVKaNRuUlfMF1YqX6IZjVzWbyGUsQpR+869LaVzpTbJdXr3LYMPH0fqfaSCmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jg0rSrIF8iGCcpgEef1TX50MJyrJBS4K+gipZ95RgDk=;
 b=NOzau0AeSo0g830Q/yF+5KH2wp469+FVds7n/8KWrLNeeJWIYJv+Jqgli1wDYSvnKJ2JxQh3zj/VAgH3+JzCmB+37H1wLYFtEDDd3UcR/iHgJ6mx3P1K/C4BKk7thNBbimELfzbmNAc7NpBKo9hRmUZFYNnb5BLi/ptuV93hBJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by AS2PR10MB6447.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Tue, 20 Dec
 2022 07:52:09 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f209:bc86:3574:2ae6]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f209:bc86:3574:2ae6%5]) with mapi id 15.20.5924.016; Tue, 20 Dec 2022
 07:52:09 +0000
Message-ID: <cb0f5824-6f7e-d009-d09d-e242ea26a92c@kontron.de>
Date:   Tue, 20 Dec 2022 08:52:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: DMA support for FlexSPI driver
To:     Michael Walle <michael@walle.cc>, Han Xu <han.xu@nxp.com>,
        Boris Brezillon <bbrezillon@kernel.org>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Bough Chen <haibo.chen@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Adam Ford <aford173@gmail.com>
References: <CAOMZO5A5MxbKCnaoRo-ax+doTcEbu+S-bGoxcmYrA=eO5ExT4g@mail.gmail.com>
 <20221219200857.fckuqovt3xt5r352@umbrella>
 <7c42628489ab90b545a8d86ba2e46696@walle.cc>
Content-Language: en-US
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <7c42628489ab90b545a8d86ba2e46696@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR07CA0028.eurprd07.prod.outlook.com
 (2603:10a6:205:1::41) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|AS2PR10MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: ff69aee3-ed19-415f-ef32-08dae25f18b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gr0JyDlTES2ssMz86umeJtOivbwVjzbOC64o/h4akp3t3uGtiMJS+gbM9cfZLJbrXtMlGhba0AbQGG2Cmgtc0UXpZt/bTcliRtbmQFZZGYH6PLeBoMy+ukiGr8iaaZvVpwBA4YwOy8otQ84yRKuv/uBm82h+BvN8lCB68nQ9QyF+YcavKFzwsFiW9jF7xJ4LVM4Mdm8//HTJepO4UvAyCwLZjFjvJbq7gKbPCyAWgly57WTv3YzTpHo+/GgSskH5fsAH5+9pG8dc+QyOg+jdmLma8Zz5AI4uA46svLrNONA0DK8Hcg59Bsfj+TX/Oo99pTxgeNb2N1RWweQzpYK238tkm7Grw+vhonmLsc54pjAMSkD/PUIGIIQLDs3v2R3XmRI65moyerH17ui6TtEJOp4v/G5AXG4obathW+I9Aj0VvJaoqJJc8NZFiQ4mjWFVtH/PBdY0+FYRcr2yO46hB7Ea8V57kC58OexHTnPz+9Tb6F/MhHT15BSkPJa9fN6J5+2st3P3xK/DeP/uAytk/4/sj5AdvPajFCXKSiAwfe8zm+OgWmaOIqzCGrBic4oCXpJo9RZjPI9eqQtVnkdK1VG5gu2XzFG/cFUwjLRBliASPh3NtUeyKm9Nn89sRrkum/sV1Gddcmsw8A7SkIUCAIZCZ4bg83/H0lgmlCJlFrWXLQqgaYRVIVCbsLQKP0n68zzTygHKuKqkPyKAixCRVzazt/yn26NN2tFZvLs0ReU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199015)(4001150100001)(53546011)(478600001)(186003)(316002)(110136005)(36756003)(31686004)(54906003)(6512007)(6486002)(6506007)(83380400001)(5660300002)(38100700002)(86362001)(41300700001)(2906002)(66556008)(2616005)(4326008)(66946007)(66476007)(8676002)(44832011)(8936002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFRUdkpvVFpQSHE1NkZ2a0dSUkJjYlBmbWlGSkc2YmQ5UTZPL3Y0bGZyd1Vz?=
 =?utf-8?B?SlFYeGZUdGJNRGlJc0w3U0hjVzF4ejRLYVNrUmpkTjR5MDhGSURFZFREZFpW?=
 =?utf-8?B?RGJOdWQvNHkwWkh4Uno3TjJQbEdWWExrdEJGQWJIcTlOT0VvY25XbStzSXpE?=
 =?utf-8?B?RFJ6a3puUTBYVFFFRGFvclJWQjB5QVhnQkhNZmpSS3ZLSmFWVUVtR3NKSkRY?=
 =?utf-8?B?ZU5MTmVXeFJsS3Y3Q1JVRndqVmVxQ0orNkN4M0JEU0hzczdOaUZhdFhicEZP?=
 =?utf-8?B?aUxSanpuQnFwUG13cUZpQzZISHV6aHhENG1ra2l5Q2FaK2lxRHI2c1kxNWJB?=
 =?utf-8?B?RzlubGRnUlI4ZnJ3TzJLdUdXellJL0UzNk1WL2pUU0w2Ujk2WXNETkZlS2tB?=
 =?utf-8?B?b1BkMVVXM2ZSdGlTbmREQnNHQklPWHkwdWpacEdsditXTlBjOWxBS0FHUFRu?=
 =?utf-8?B?MVZBLzg2RUdxMjNZaGc1eFN5dUlybGpjWlB3TC83Q01XZC9wMS9zZjRvbDVB?=
 =?utf-8?B?cy8yamI4Y1p5WWJ1dWgyOGZiVSt4eWsxUUVLSXFmVkczbDFrNWFCVFlPb0dn?=
 =?utf-8?B?TmdqY290UVNqTmx3RnRRZlRqVzB3MVRSTjhuWDYzTEJ5dGxvdkxkdU04VUFM?=
 =?utf-8?B?Sm9oY2J6bU8rVTFMd3ZOY3MzMTB3UkJyV0pMUS9zV0NsQ2sxRklhejQ4bXVy?=
 =?utf-8?B?YTFWb3lYdjBzZVBlVHVMUjlFOUxaaW40Zm9LMnZ0WkQ5Tk9yNFJhSzF0RVBC?=
 =?utf-8?B?NE13R0o5d1lSVnRDMFNkSG9PK1JkbWlrZUVwU0pDRW1EeHBwYXRjT2lGY0du?=
 =?utf-8?B?NmU0UTdxQ0NRMmd1SEFmU2IxbW9iYWVkVlhGRnZSUVVLczl4MDF4Ny9XQnVV?=
 =?utf-8?B?TXZyMExqMHY5ZGV5ZjlwbWhZSlRZVmVDdjVhSzRvTDBob2xsWHhLMnd4Q3hQ?=
 =?utf-8?B?b2h6UHNlcGNOMnU0dWR2U0p5blIrNjdUZTFXK3B1ekFuWTNTenVKRUVuUUN5?=
 =?utf-8?B?MjV4cmlWbStMdTYvaTBJUWhiZ0gzcjRjeXlEMW5DSlRFcjRsY3JXcmpaU0Fs?=
 =?utf-8?B?MlBUWjk5RHZscUZzOUxNZVRyZXNha0Q5ZE55bXg5dzlDSDBtRjFwcHVLZnhF?=
 =?utf-8?B?b0YzT3hhUllKeXA5K2lDNVZtS1VzTlcwNUNIYm1RanhLTjN4T2wrSmZUQnVD?=
 =?utf-8?B?MWJEZWlBUnFzNGV3bVNaT1dGZkdRNnZsUTFJblRkdTYyLzNUdGtaeXpKSkV5?=
 =?utf-8?B?MTkvWkJSV3FIK1VmdG1wSkErRzRScUZzeis0R2Rzc3dLaG5GUUUwc0dHZHgr?=
 =?utf-8?B?RUxnWDN4SGhIaVpEMTZtdUpXczE5bFJZcnBndDZ3dXR3b1gyZFZNbGp3cUQv?=
 =?utf-8?B?cnd1ckFaaUY3VUtIdUc4WnMrYmYrVXlqYU5QUTV4L1FnN3FBbklnaEE0Rkc0?=
 =?utf-8?B?U0J1NzRSZWZabHl1VFZzQlcycEhsZE5uckZ3VE5kWEhxYnNQSE05Y2l6d1FK?=
 =?utf-8?B?ZDhUZjFBZmk5RzhiN2xEenIxVUhlWDRzdFZOSGRRZC9aYk91b09Oc0xFdVVr?=
 =?utf-8?B?RllPUXNyOTdjLy9nY0RtOGVsdGRzKzQyYnNBcWJTVjNsZ1pXSUVsMTlROW9H?=
 =?utf-8?B?Nm1DN20wN3Q3MXg0ZG5HU3RBdXZlem84VmVLaEcxT3R2VlE1a25TZzFJQkow?=
 =?utf-8?B?TW1jQVZvcy93Z09ETjg0amtLUXVYWExJamZRKzhBNFNvSkVyZmNPUWt3MTgw?=
 =?utf-8?B?N1NYclJmMWN0bWhPY0lvVXRrV2wzOG9BTTFmT1FVZWRidjFmWExNaG5weHFW?=
 =?utf-8?B?R2pYRU1RdEp5eDZmL3Q5WGlVcUJGazVkSnZkbVZ0UHZ0R0RhM0hXRk9OUWNt?=
 =?utf-8?B?TFdFa0xkZmlvSWhIanowNWtvRW5BRjhBTFU4TzJRZGladlFLZUpWZVJkeW5O?=
 =?utf-8?B?YVhPamY3SUs3Z1hKcDcySFNsU0VOREVwNnZpV2tHNFg4cVFGbC8rSjdDSklr?=
 =?utf-8?B?TFcxNFZCVy9oZklLdStSeXA3bWZpVUNoeTVqZjRTMmlObU42VDRUbW45eTRI?=
 =?utf-8?B?VUMycFBVVDNNZWRjZ1BUaFBHR0tjQlRtcW02aGhqTVlzcFJUbitCTnlBbU5v?=
 =?utf-8?B?MlNtcktHKzdwZ3Q5RUE4MmR1UU85ZW9NenByNUFSZFVSbXdoWHhsVWFHbzBC?=
 =?utf-8?Q?t6fgzcXzzKME1MMfdwP8b57Fj6tvTyDsNrlqlWU4yM8P?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ff69aee3-ed19-415f-ef32-08dae25f18b8
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2022 07:52:09.2139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwS/Hs3NcPn8HfpulQjTVnT7MbK9Z4KEWwALoymry3FyPIdk6+NjmDKREoMTDfB9Y0cPpjpg9KC1qI+iwZj8hjlAAvRb87dz1QHuMi84b2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6447
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 19.12.22 21:21, Michael Walle wrote:
> [+ Frieder and Boris]
> 
> Hi,
> 
> Am 2022-12-19 21:09, schrieb Han Xu:
>> On 22/12/19 02:08PM, Fabio Estevam wrote:
>>> Hi,
>>>
>>> Currently, there is no DMA support for the drivers/spi/spi-nxp-fspi.c
>>> driver.
>>>
>>> Is there a technical reason that prevents DMA to be used on this
>>> driver with the i.MX8MM?
>>>
>>> Also checked the NXP vendor driver, but DMA support is also missing.
>>>
>>> Does anyone know more about the reason for this?
> 
> flexspi is a copy of the spi-fsl-qspi driver and I'd say the
> latter just got the basic operations polled IO or the memory
> mapped access and nobody cared :)

The QSPI SPI MEM driver was derived from the original QSPI SPI NOR
driver and IIRC this didn't have DMA support either. And FSPI was
basically copied from QSPI as Michael already pointed out.

So yes, I guess the reason is nobody cared so far. I don't know of any
technical reasons for not having DMA support.

> 
>> We are working on that, both flexspi driver and sdma driver need to be
>> updated,
>> and will upstream all once done.
> 
> Are you also working on the DMA support for the layerscape
> architecture which is using eDMA?
> 
> -michael
