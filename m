Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD1041DCF0
	for <lists+linux-spi@lfdr.de>; Thu, 30 Sep 2021 17:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238353AbhI3PFS (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 30 Sep 2021 11:05:18 -0400
Received: from mail-eopbgr00121.outbound.protection.outlook.com ([40.107.0.121]:35814
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233612AbhI3PFR (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 30 Sep 2021 11:05:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUJnv7b9DNXn3sxdFOE3kPldGymWkMv/tTkn4qkqlQ+hIKrLIIJzwEPHRhBLKe7WgdBSVMCy9mNhtGqAdYTUlTHvh/P/jJUvFz/wjtv1uEnL1XKKZtvl4nOfLWI/pugs0TbVNQN4gxWAcLipi9QGdFo8ylGxIkI5WTG6SwAHjUb2L5b1Bg4wpzXW5AOZ3XTYOWo4z02PEASjMXGN2qPLbSh69cMgjAcjm743myqaFlNZWn86zrzdSuwEyrSwiudTtSC0TDoQ84ARS85Jiou01eXmEyRTKF26bVqPqngbjZt7LwEG0nmZ+dGRfG1l1fw01r+5JRU+fMUPpABp9OP2ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24T86wJKP3dsgtlJGPmzYBc8nJpUby8Uv0ARQV06gWI=;
 b=jDp/koR0cwTllBBl5KpbreGEeM5b+VIYmNs6Dn/SCAnxmRZI4bHR4/2bS2CnHouVq+mHYHIzi+JV5CL2/JswDQRES59zFJ6+387+6sP3JxW3blmjEHVImcJTwlLjF0WbTFL7wBY7d/LYGsH+wbJmLxQKSv/BKbSBuPW2FzZ7T5WCJCvvc7iqF8q8rGtu53ccapYLcpqY7ukT3KhPmX+trgPHjOn0A6EfbW9Zdq2tx9zyYWPaRgylh0xw9RoOqJtesoB+gQABXJ8GiDVLJ5cT98vVwomivJYLNnIrAqryXBVCCTENDWqxycmbSDehs0j2sDpSsJPsu0N4soJc83vriQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24T86wJKP3dsgtlJGPmzYBc8nJpUby8Uv0ARQV06gWI=;
 b=WGKn2H4vkUGEV7HkI4mRqgVgLKtJEZsS2aIsoxEf5mGStuq6QMx7137aI7RvHEpMDTh7jiWycvslIXiJ7OrkxD4obhR3kkD3WL5Kf7loPJARs6evVkUoj0JCJh0/ZeNkICPR0JpENEh0/BEGngH0DyzBbvSFLms6HofFhNj9/ak=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nokia.com;
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com (2603:10a6:208:6e::15)
 by AM0PR07MB4036.eurprd07.prod.outlook.com (2603:10a6:208:50::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.10; Thu, 30 Sep
 2021 15:03:33 +0000
Received: from AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::91aa:4873:6782:4917]) by AM0PR07MB4531.eurprd07.prod.outlook.com
 ([fe80::91aa:4873:6782:4917%7]) with mapi id 15.20.4587.007; Thu, 30 Sep 2021
 15:03:33 +0000
Subject: Re: [PATCH 3/3] Documentation / MTD: Rename the intel-spi driver
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
References: <20210930100719.2176-1-mika.westerberg@linux.intel.com>
 <20210930100719.2176-4-mika.westerberg@linux.intel.com>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <7e898647-852d-e5f3-bda0-94fbcff88f40@nokia.com>
Date:   Thu, 30 Sep 2021 17:03:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210930100719.2176-4-mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0027.eurprd04.prod.outlook.com
 (2603:10a6:20b:310::32) To AM0PR07MB4531.eurprd07.prod.outlook.com
 (2603:10a6:208:6e::15)
MIME-Version: 1.0
Received: from ulegcpsvhp1.emea.nsn-net.net (131.228.32.168) by AS8PR04CA0027.eurprd04.prod.outlook.com (2603:10a6:20b:310::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15 via Frontend Transport; Thu, 30 Sep 2021 15:03:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a1fb229-43a2-4900-fca6-08d98423785d
X-MS-TrafficTypeDiagnostic: AM0PR07MB4036:
X-Microsoft-Antispam-PRVS: <AM0PR07MB4036149E6611D6F27E23C98988AA9@AM0PR07MB4036.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GVmOxA+kugpSXl+YGNXDIsmpbGHm5HM8DMvXEqX1o+5SBYCPjd1Bf37DCvzJpBjIxywIJmE+22ynik8Ie1i46FJXY0BJ0LTjf0f5BZX3kUWoMpLXpRc/RnDHANEo44igZz3+Q5ZR1DSVtNydhjV7v16qxSg8wLh2l6OpNSK8KnqpDHYbEoDWi8iUyNicGCX0OREfDcxxWqblr37BM77Xa8gXatiffohsEp7RV2b89JUYzJMJg9DCbWHEOntGQxElXpOTGpyh8MfCoXQoWG0cvxuIRz26H3XGMajFWFIczL6gnF22sDaY/tDvdTkwrdNJWgvZTjxXB7e+pC6yvsjGtmWgjUBC4zwsVlB3fAjOkuw8arl82x+q3MUaXtjQuLGaW/HBOoS4SlpCt6TGiBH+OJG1WHD5kZUm//Ybvp3dbhUYNWQHqzmwpFLqFBcKgB574r9ZBxksv9vAJ+97d6i47UdI2ixsiNGLc1Szr8B5DwtH1pfBcG1Hht2/dwBlpZbjYic2k36ztG3IICOY/vysCZJ/wo6Igsvgr4vyd47B3fMKJXZya7dtciR/9jwgf0KeDhyyY0J5CG2Uj2sPRFNyzUssP+taYlXJjhRcuf4WnWGXN/LIYhiSkDeqZXJImRg2r48xmn05IjsN05QzryjvKSZo+k8a3cOvFHWt1NTiBgPB9lQAv+vK6XOwKuUooh2VghA4tVdGjVjAs/pQ9UGGPiSI8Ddy5YpMfmTHnrgmEyQ2apk6Up9YQPP8LXaLykSkysW61p0XIQW/ukkcbOA/2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4531.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(6486002)(6512007)(110136005)(83380400001)(6666004)(2906002)(31696002)(8936002)(186003)(54906003)(31686004)(6506007)(53546011)(66476007)(52116002)(508600001)(8676002)(4744005)(26005)(38100700002)(38350700002)(4326008)(44832011)(316002)(5660300002)(36756003)(66946007)(2616005)(86362001)(7416002)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHlhU0xCaS84VW1GK0ZqeWdWOWhvTzFnbk0zQzVMR1JWbThxQU9sempJM0Zu?=
 =?utf-8?B?SDBGRGRVYzVxVFdHNCtSNGFUY1poRnJFVjk2N0ovaFBDbzROKzk0Rk5oNUNi?=
 =?utf-8?B?dStNSDgyZFVTYjgvTEtIZ1VGWnJpTC9xQXJzRDJEb3VKUkVZQmtDUFZjRUlW?=
 =?utf-8?B?LzA4aHhFWGF3NURJVDd0RGZvL21KZy80UWpJM1pLRy8xZVNDQVdQanR0eTB1?=
 =?utf-8?B?MTE2am5pTjZQZi9wY1FONFhuTi9hUWpVNjdCck8wY0cwdzAxNVJRMHZTLytw?=
 =?utf-8?B?aDNOZ1lYenp6Y2xSd0NodUlRMWxkbEQzanVvZktaOWJEMWVhRFdRRTdGWktY?=
 =?utf-8?B?OTQ3VUtVUWRudlJ0Wm1XSWE1SDhXTjNwR05TazlaVHdKRFdzVVJHOCtWUjBN?=
 =?utf-8?B?WmZXV2lSUUQvQnB1dnVrcXBCZDh2azR1Z0RNcGlwQVBrWnJqdFJqK1MyMGtO?=
 =?utf-8?B?NFgzcjdMMHJwdHgxMWhLUGpPNFNuaDdJRURCRGxyY1ZhWUhnMFBTdGNieEds?=
 =?utf-8?B?b3FxL2RxUFM0bWxkM1A4SnRNa0pxenZwWjc1UnR4TU1uSHhDWVN2M1UxalRT?=
 =?utf-8?B?NDE3SGg3TGcvSE1NQ0NkT090NnhieStiNmNBNkhXSXYwajU4bTJnRURXcWMr?=
 =?utf-8?B?eVM5VElaS3dwVmc5UHJCYitvS0tMUlFxSDJncWVHVFoxbDFaVnVYNlpwN1B0?=
 =?utf-8?B?Q0orK25zc3poVmIvbGhYbzBHNk4yZjVLRmdDRCsrekRYdTRTZ3RVckJwNmg5?=
 =?utf-8?B?S0pGd1dEam52SHdvZi9udXl3WmFIcTdENzlZYTdmeCtvN2x2RjVtbnpXV3J4?=
 =?utf-8?B?QU91YmNJQytvM1VWQndqUW9tZmpyUmc5ZzV0Y3cwbURvTVJuTTVNLzNhZkxB?=
 =?utf-8?B?ODN6RElPcFI5ZlBxU0Y3bkhDbWNXRXRvVzBZS1RHeWtsQmZLdUlFMEI1S3pM?=
 =?utf-8?B?WWV0YUhTUWs4T2JCeitxN2NETzVXTHVkUGUwczBtL0o5ei8yOVhMSEZBeThD?=
 =?utf-8?B?dkc3ZVRHN3NFQzc1VmhvNytXOHd0alNBeU1ZQTV3Ulcvc05OUlV6bktzZzZh?=
 =?utf-8?B?aS9oNGt2aXhOL2EwRjlhd0t2UW91c1JkTTBsekMxTGg2aGIvd3E3UFlIYlZm?=
 =?utf-8?B?aTF5ZFBiWGZMakJUS0JreERTMERaeXJaY01UbHRCU1ZodUthV2twR0luQzhM?=
 =?utf-8?B?QlIrV1I2R1d4OE95U1c5dFlGSXlBUVQ1QVdxNUU0RzR5THFnNi9aeFJIekp2?=
 =?utf-8?B?eE9iclBmbWk1TFFUakdlRTlxOHNtNjNRblQxNjhtRGR2RWNFMnZHbnhEYkRW?=
 =?utf-8?B?VjJYZnZXdVFTVWticFVrV09GUlZLa0FSUDI2SUoyRWFoam1qUjhRSUJIWTdo?=
 =?utf-8?B?c0MrdGNEMjNPbE9MWWE1ZGREUFNuU3RYNmd0Ym9XTnUyYVpFdDZMODBaSGNh?=
 =?utf-8?B?cG16U0dXaHdFbDdhcEwyS3JLajRjVVlzeFJqdFpYdmx4UWZSeGMrbSsxVU5F?=
 =?utf-8?B?czU2TWlzSldRUzZNVElwT000T3BCR1NjRUhVR0xCYzlsVzZnMll4eTJ4VUU0?=
 =?utf-8?B?V3F6U1FvZThiaWlraEJSK1pMSGo2SXhNSE9STitqeVpvTlJMeVk2eTZMQjV6?=
 =?utf-8?B?TDNaUVlwaG1HaGk1VDFGSXBYL2tMbkpLbFpaUDdRcGY4NS9hNXhIdEgvdTdY?=
 =?utf-8?B?aURCc2VQZGp6Qzc2QVlFY0Myb2RjdGRsOXdCRWVZS0tsUk9Hcithd2lTb3By?=
 =?utf-8?Q?0YGbkrq2we4Mu45o69W9QTd5Qxqnl09G4gEgvtW?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a1fb229-43a2-4900-fca6-08d98423785d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4531.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 15:03:32.9382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bSLUnALXYCFB35vNHnz63khvKZiKPwtAVKyTOwCz3369xK6X84fsc0jZuWqIbnfL2h0sorCE1AWZfyM1n8mQMJi7q23OZ7dWE0IiCuzWZ8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB4036
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi!

On 30/09/2021 12:07, Mika Westerberg wrote:
> Since the driver is renamed (and moved) update the BIOS upgrade guide
> accordingly from intel-spi to intel-spi. Keep the guide under MTD
                   ^^^^^^^^^^^^^^^^^^^^^^
Copy-paste error.

> documentation because this is pretty much still about MTD and SPI-NOR.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  Documentation/driver-api/mtd/index.rst                    | 2 +-
>  .../driver-api/mtd/{intel-spi.rst => spi-intel.rst}       | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>  rename Documentation/driver-api/mtd/{intel-spi.rst => spi-intel.rst} (94%)
> 
> diff --git a/Documentation/driver-api/mtd/index.rst b/Documentation/driver-api/mtd/index.rst
> index 436ba5a851d7..6a4278f409d7 100644
> --- a/Documentation/driver-api/mtd/index.rst
> +++ b/Documentation/driver-api/mtd/index.rst
> @@ -7,6 +7,6 @@ Memory Technology Device (MTD)
>  .. toctree::
>     :maxdepth: 1
>  
> -   intel-spi
> +   spi-intel

-- 
Best regards,
Alexander Sverdlin.
