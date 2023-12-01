Return-Path: <linux-spi+bounces-114-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 615FC800C4E
	for <lists+linux-spi@lfdr.de>; Fri,  1 Dec 2023 14:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180D9281B3D
	for <lists+linux-spi@lfdr.de>; Fri,  1 Dec 2023 13:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA9138DD4;
	Fri,  1 Dec 2023 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grpleg.onmicrosoft.com header.i=@grpleg.onmicrosoft.com header.b="HwJ5abZn"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2111.outbound.protection.outlook.com [40.107.8.111])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21E3193;
	Fri,  1 Dec 2023 05:38:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bY/UI2R9aBJax8RgsZ8xlkGN0PoBnA5RLb1ELwMfvBZSQm9mpcOuvXJ1zRFCMvnb12UH321+CbJYy4pbEyRueoPJoHFjeiw0akn12JPxQs5Zxw1l7cm/1vtylsu2cNJvUkyS8xzN42gJ70LeU8XEg85C9LPgGT4EUMi4idBos8hvi+ZLYAK/dL/GPcbW4GTtKFjMQrv6q9xmJXxZjjIHHgb7KIuaNOihX44S3L9AsqFh45V+/7ck+1w8iNrm/LQOcIIY+hcQxtaLK75xGyszL8RwCzj+BSyYjLDLFVeoTuJzz0ED2JaV6c2HrfINq/SBF3UEobd81pnZd7ucVnZnSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uC1AZnGJXYMGlCOTTDn4ZMkODopnFSgQYqKOkRhJyxs=;
 b=WSqi3zoXMxmih+4u8hVOzfAWdikvkZ48Z+ioc4YDpUEwq7N0VZDmwI4eHWz+S20xRGI0KbjDWPCXlYpaanq24gQ51mfLh4n14NeKbhWOtNL8+fyVMFGSMn0hiqNgxTHKlBgoOlIIijDvVS4FiP2J47CIvhE1xeUVTJ6EPrlqEcRjaeNtG+TAB24yEuCalLump35E3fQUJou4SKXAAY3onduVC29Tib8spbBGiWH80GaO7Mvt/4psS1T1xQOJYSd3dkLsEiDsgq0fErYi/grZZL02sbg2GthLjF5Z4hsnd5bfHY4w+TRu+hzcImQuHs1P8jsR00XfbLieYbA+5KeU7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=raritan.com; dmarc=pass action=none header.from=raritan.com;
 dkim=pass header.d=raritan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grpleg.onmicrosoft.com; s=selector1-grpleg-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uC1AZnGJXYMGlCOTTDn4ZMkODopnFSgQYqKOkRhJyxs=;
 b=HwJ5abZnwnEcJcsyC+0wrNPOoqm8dKok9cJ82upbPs/e3/XHc5/2BGVYdowonYTwhQM6e9jvVrhNeArbNMy1hLRf4F2GaYccF1erYbGogN8vlUGWDSccqgqtMDoZVfQ5WWTv2ZzVVp1tso9gOOAqXX4sYHTynTsh7ghyxHy3wmQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=raritan.com;
Received: from DB8PR06MB6539.eurprd06.prod.outlook.com (2603:10a6:10:12f::23)
 by AS8PR06MB7672.eurprd06.prod.outlook.com (2603:10a6:20b:33f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 13:38:23 +0000
Received: from DB8PR06MB6539.eurprd06.prod.outlook.com
 ([fe80::98dd:e9db:b7d8:9001]) by DB8PR06MB6539.eurprd06.prod.outlook.com
 ([fe80::98dd:e9db:b7d8:9001%3]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 13:38:23 +0000
Message-ID: <c7980bbf-04aa-4c52-9c6c-f3a1169e90f9@raritan.com>
Date: Fri, 1 Dec 2023 14:38:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] spi: atmel: Do not cancel a transfer upon any signal
Content-Language: en-US
To: David Laight <David.Laight@ACULAB.COM>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>
Cc: Mark Brown <broonie@kernel.org>, linux-spi <linux-spi@vger.kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ryan Wanner <ryan.wanner@microchip.com>, stable <stable@vger.kernel.org>,
 Richard Weinberger <richard.weinberger@gmail.com>,
 David Woodhouse <dwmw2@infradead.org>
References: <20231127095842.389631-1-miquel.raynal@bootlin.com>
 <a90feacc-adb0-4d7d-b0a4-f777be8d3677@raritan.com>
 <0ce4c673-5c0b-4181-9d8b-53bcb0521f3e@raritan.com>
 <20231129094932.2639ca49@xps-13>
 <723263313.45007.1701348374765.JavaMail.zimbra@nod.at>
 <1192504136.46091.1701368767836.JavaMail.zimbra@nod.at>
 <20231130211543.2801a55b@xps-13>
 <d4ffca97-bb5d-4c42-a025-69b308c24f82@raritan.com>
 <4642281ef2e749a3b69bbea5474ecdf1@AcuMS.aculab.com>
From: Ronald Wahl <ronald.wahl@raritan.com>
In-Reply-To: <4642281ef2e749a3b69bbea5474ecdf1@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0448.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:81::6) To DB8PR06MB6539.eurprd06.prod.outlook.com
 (2603:10a6:10:12f::23)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR06MB6539:EE_|AS8PR06MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f0e9f1f-e542-4d0f-4413-08dbf272c9be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aTLAgdnR2luZNmBYkaS6/04byAn7xDS8Sgdrr5oxE6ZNNwdMbtVyPwAu6x7Z0iKIdPwvTb8U5qmnXsC526wDmsCDdvdaGCPcxsk6PjhS08p3XU/XNKKFadf1Ft51tLfRqEvDdtzvwibr6YAS61GofukPrpUQ9gDOInfcJwAtkzVfh7ErC9AtrjGWXCUFjDcM4SRSrbZ5mp6FmGxNGwm+4Wz0ALlAPgvvAEtB8M5S3EMcGYeloZ87YK41lSUwZuDZzbuHRBNjbGaozOz2n6QYzkIJVFnf/p9uV6Pr8knPp3J7mW4gvXZ2/rhARIAhfR8vGWju6IN8XahDaJiVeIYewzPeoIZ2W2od4FN5F5DiUz504mTld60u43pIP6u1N9nOO7ja0nrZ94yYCDWlSNdmeEzyJxXyPTd4T8LLD2xj+zWqfWsliq9qLJ8Wc1zXLCLem+UdSwTL6KZv/16qGn9I+ag3MEJIhHhDKPfimY5xqumjI7322oeFPSvdEo/cTOwXVCBYoMy5Yjh7NCj7R1jdxlNI+dmUXvkX5590HDxruED/ZFji68MvMQwnlKhuWFo6SGehyHTboA4RD0z1sbn5+W6soVgwXy/r5RPXbPy9kdysDOrmFwnrEp2e7EXvk3ozb41HVrU+2KF72VvJuwZEuQ2mo5LDmg5M8Q7SQEhK9aEGw4PfI3G+7obhd068AQI04xDquHgH1IPqkt1uEAfJwqS8j95TWVgPieFD1LcqamQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR06MB6539.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(39860400002)(346002)(230273577357003)(230922051799003)(230473577357003)(230373577357003)(230173577357003)(186009)(1800799012)(451199024)(64100799003)(7416002)(110136005)(54906003)(66476007)(66556008)(316002)(86362001)(6512007)(66946007)(41300700001)(2906002)(5660300002)(31686004)(38100700002)(83380400001)(66574015)(44832011)(31696002)(26005)(966005)(6486002)(2616005)(36756003)(66899024)(478600001)(6506007)(53546011)(8936002)(8676002)(6666004)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OFQ3d2ltMm5CRHVnbHFZc0FKK3lhQ1lFMEJUdDB0WFh6OHRZa3lQR20rU1pu?=
 =?utf-8?B?eldsVkI0cWE5WUJISkVXN25ZMGw5ZE4wRGxOalBQbERudVQ4cVc4eUFBMzVn?=
 =?utf-8?B?M3VSeE9ROUpwOGplcitMcERaMWZxL2M0Nm1ZU3IvMUZuSmI1UjJ6a3VvaXFy?=
 =?utf-8?B?bVdtK1dTZGxENEQwdEVtVEpNdVlvelpVSy83TWQyUXJ5VFY0TnJDd0w1YXhs?=
 =?utf-8?B?NVFTajNVZ0JzN0cyNVpVWS9BUkdkL1VSVVlvSERkaHdvN1c1S2wralQvb3g0?=
 =?utf-8?B?UzluYkQ0ZFJMalczS2Z2RUNHWjJKWW5qbVZtTjZVaTREbU45YXZiZ2xJY1Bm?=
 =?utf-8?B?UTB3MHgrNVhCUkJ0S2JJbXJWUUFBN1JPaGZ0ZmwwWHJvdC9KanZnS2dyb05K?=
 =?utf-8?B?bjRHK0RiajlYdmFmRnJzdXpSa3lHeENJbkM5bVNHYUtEdzFRWWVMZGZIWWs1?=
 =?utf-8?B?ZDFHYlJlZ2Uvams2TG5sV2FJcW1EaXcyUVM4ejhZdWRFdkI2empHTmkweXBU?=
 =?utf-8?B?NVhnM3JueVkyd2ZnVVpEcHg3T2dGREIyeURhTktrOEpFRjlBaS9JOXUyNitC?=
 =?utf-8?B?aWZvU2xxQWMrWElCQlBvTXhqcDJIT1JXd2tPOXA0UUVXR0FCYm9URmZ3NkU4?=
 =?utf-8?B?RHFsT2NHSVc1b3haRFRnVkJEZlZHNnN0Rm5FamVQQkN6WTBvSlMzRXdySEh3?=
 =?utf-8?B?MktqWGZBZG9BUnBBL2tKMDN6M2xXYk1UeGhBR3FWdHpTTitaVk5HVEM5YjRm?=
 =?utf-8?B?eU5XTXVGaVA1dHI0SGszMTAwOE1mTlZ5ang2a091QldFNjFLQkVCVDk2QWhW?=
 =?utf-8?B?dE4ramF0dVFJR0lFdlJydHQrUVBqV2hGNE9FRHJFcDRIUHdabjVSZmJjbDlv?=
 =?utf-8?B?NmU0OGpiekZDaUt0a1QrZWZ3WStBUUs1bE83dW52Y1hrS2hkWXBPb080KzNV?=
 =?utf-8?B?dHRTcFh4YXlhQWo2TWRJUXRRcXJWSFFDc1NUQ2p4UTVPOEEwcGlUcnpPOGM2?=
 =?utf-8?B?ZTNsODdub21pNVZzek1NVnhDM1YvNUdQTlhha3lqYlZ3bEpkMHl4a25PR2J0?=
 =?utf-8?B?SUdZenZTVThGM0pVU2krREgrb0VjYXMrT1NoenlyRGp3ZG9IbXZLV1lidGxp?=
 =?utf-8?B?TXJ6eVJOdDNKWHF2VDlSaGlGTEluQ0h2TlllSE0yeW8wSVIrUmZocVJ2emFT?=
 =?utf-8?B?V2cvRURJY2tJV2NDVDk2bzh0eGxiWGxXWjU1ckZsNzRQaVRFY3B5dWQrOHQw?=
 =?utf-8?B?VXdyc2JiWFN3QzVmRGZlc3dyKyt4Y1BZRXE3RzBqajFTNTJtLzBINkxoSGd3?=
 =?utf-8?B?RHFXdmI2TXdyaE0xRGtST2FVWktZaXFMSHBFT0hldDlnMHJBU3UvS1lOTWZm?=
 =?utf-8?B?Z1RUaC9odlUrQzNWSXVUOW15dUczdlRTdyswR09Cd3NyeEc1NERrTnlLaUJF?=
 =?utf-8?B?SDhML3d4R0F1THhFZVZLcmdlTnM4SkJ6RktCaHFSd05BMlNMZktIaVc1YmEy?=
 =?utf-8?B?dHJQMGlteXB3TngzRVE4NDhFeDkvSklYM1dwMXROVFJiNXpSdE0wb21ZS2ZU?=
 =?utf-8?B?UkRBaVQrZGxVZVBpNHpHZ1hPVTkwNWtyaGh2YXoxak9YSGNhK0JKQ2pzYy84?=
 =?utf-8?B?L0JyTXR0UHRXR3BkV0dVYVI3aFFKL0toeXBJa2dZN1JsWjFpUVVzdEVzU3gr?=
 =?utf-8?B?K0ZrS3hKK1RWVmlCUnR4Q1RRejF0NDhXYUpyam9DK001RmRzYW16KzVLVCtT?=
 =?utf-8?B?V1NwaE9GOVZWSjR6eUZhMlM0MWtyQWloaURuc2pkS2J5TWFoazExN3ppRnhE?=
 =?utf-8?B?WUcrS203UGl3SGxvczcyM1NLSys4T2cvbnBJTmg4K29zYnlRd0p1K2c3UmpH?=
 =?utf-8?B?RlpadEg1Szg5dVhnWVlqeDR2UlpFbUxkREswRnFiZkJ4VVMrZ01OLy9rbWt3?=
 =?utf-8?B?Vk1RcUZTUGZHZllYcERyWnVMSEFoOFd4a3N1OWk3cWRyeithNHRaSnRTVTNl?=
 =?utf-8?B?TStDWDhlUUtBaXBkVmdUeGp5dTNEQm02OTFmNXdyRlljNzVJNDVQVzdQRVpz?=
 =?utf-8?B?Ym45Q3F4cE5KeWttQUcvMzZIRWw3RTRrMXQxL3Z6QW9sMU80dHFmZkYwTDBj?=
 =?utf-8?B?VFhxUWNQZUl6MldaSzZiZHk1a1VJZmttMmhXcnFHUVpVZXdHVklzU3RKeUk1?=
 =?utf-8?B?OHc9PQ==?=
X-OriginatorOrg: raritan.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f0e9f1f-e542-4d0f-4413-08dbf272c9be
X-MS-Exchange-CrossTenant-AuthSource: DB8PR06MB6539.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 13:38:22.9584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 199686b5-bef4-4960-8786-7a6b1888fee3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9e7MlFwqLhdmo2g/XmNOqgDWXjXVyftM/c9AOtEdSVUbKhwm7F0BRzmH2/H+MavcpeWrrJntafmbJbqV6BWb2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7672

On 01.12.23 12:13, David Laight wrote:
> [You don't often get email from david.laight@aculab.com. Learn why this i=
s important at https://aka.ms/LearnAboutSenderIdentification ]
>
> ...
>> Anyway, the whole issue started with commit e0205d6203c2 "spi: atmel:
>> Prevent
>> false timeouts on long transfers". Citing the commit message here:
>>       "spi: atmel: Prevent false timeouts on long transfers
>>
>>       A slow SPI bus clocks at ~20MHz, which means it would transfer abo=
ut
>>       2500 bytes per second with a single data line. Big transfers, like=
 when
>>       dealing with flashes can easily reach a few MiB. The current DMA
>> timeout
>>       is set to 1 second, which means any working transfer of about 4MiB=
 will
>>       always be cancelled.
>>
>>       With the above derivations, on a slow bus, we can assume every byt=
e
>> will
>>       take at most 0.4ms. Said otherwise, we could add 4ms to the 1-seco=
nd
>>       timeout delay every 10kiB. On a 4MiB transfer, it would bring the
>>       timeout delay up to 2.6s which still seems rather acceptable for a
>>       timeout.
>>
>>       The consequence of this is that long transfers might be allowed, w=
hich
>>       hence requires the need to interrupt the transfer if wanted by the
>>       user. We can hence switch to the _interruptible variant of
>>       wait_for_completion. This leads to a little bit more handling to a=
lso
>>       handle the interrupted case but looks really acceptable overall.
>>
>>       While at it, we drop the useless, noisy and redundant WARN_ON() ca=
ll."
>>
>> This calculation is actually wrong by factor 1000. A 20MHz SPI bus is no=
t
>> really slow and it will transfer ~2.5MB/s over a single lane.
>> The calculation would be right for 20kHz but I think this is a more
>> esoteric case, isn't it?
>
> Some of the sums are wrong, but the conclusion might be right.
> A 4MB transfer at 20MHz only has 5 clocks/byte - seems low if it
> is only using 1 data bit.

Can't really follow. Each data bit requires one clock on single wire
SPI. Adressing and the like may require a bit of overhead but that
should not be that much (12.5%?).

> The spi devices usually support 'nibble mode' for read/write that
> will speed things up - provided the data lines are connected.

We use SPI (single wire) in our devices with ~40MHz (older hat even just
12MHz) and we never had issues with transfers lasting to long. This is
because file systems transfer much smaller blocks in the multi kB range.

The speed is ~4-5 MB/s with ~40MHz - with 20MHz it would be half.

> OTOH a better fix is (probably) to do the transfer in sane sized chunks.
> The extra interrupt and code won't make much difference to something
> that takes that long.

Exactly. This is what file systems usually do.

- ron

________________________________

Ce message, ainsi que tous les fichiers joints =C3=A0 ce message, peuvent c=
ontenir des informations sensibles et/ ou confidentielles ne devant pas =C3=
=AAtre divulgu=C3=A9es. Si vous n'=C3=AAtes pas le destinataire de ce messa=
ge (ou que vous recevez ce message par erreur), nous vous remercions de le =
notifier imm=C3=A9diatement =C3=A0 son exp=C3=A9diteur, et de d=C3=A9truire=
 ce message. Toute copie, divulgation, modification, utilisation ou diffusi=
on, non autoris=C3=A9e, directe ou indirecte, de tout ou partie de ce messa=
ge, est strictement interdite.


This e-mail, and any document attached hereby, may contain confidential and=
/or privileged information. If you are not the intended recipient (or have =
received this e-mail in error) please notify the sender immediately and des=
troy this e-mail. Any unauthorized, direct or indirect, copying, disclosure=
, distribution or other use of the material or parts thereof is strictly fo=
rbidden.

