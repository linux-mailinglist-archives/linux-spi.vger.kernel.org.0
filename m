Return-Path: <linux-spi+bounces-110-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035517FFCEF
	for <lists+linux-spi@lfdr.de>; Thu, 30 Nov 2023 21:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A511C21268
	for <lists+linux-spi@lfdr.de>; Thu, 30 Nov 2023 20:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B0A55C28;
	Thu, 30 Nov 2023 20:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grpleg.onmicrosoft.com header.i=@grpleg.onmicrosoft.com header.b="wdNBK61O"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2134.outbound.protection.outlook.com [40.107.8.134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678B4D48;
	Thu, 30 Nov 2023 12:43:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KV3ibL2wgs5VoJ43E23uVyUOCQ7TKdPWnPai4xG+MLB36dU8gfshaFoyDoa95Vn0G3NCSQdYfTG2pfmBNyXgYAlCDRJlnQljyaEhMwxwMJS/LkZYxfrQEOI/KYcmbFBxgc/ZcvOS6Pwrik17vqEPvB6NhhZPYCzuprPPTkfEeakULJiqjfBajCNPwjbscqO40Rb/6QmCMwDvKkN+lYefYhAz1C7zi+xBcsBk0Ca7pY9b+3D8s/h1c7r1ogmXmUSLg7Hio40kpaK3j2SnStqSLw6/NDkAwkbNz4FqG1GWAhmqBaOVpr+95Tz3wpR4lo+/utVGd3NiYhbU9QusaRwTDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54XgMTVMyb8bI1HPYxDhKjUrd5NgWVRBJs7VNqnTywM=;
 b=Hbb31IYGPpK+O5OCQcAE7yWCo+OzfHCOZ+U+mRgKG2IBni1HhRt2/VaPVw2SuDrVdxL6KNgZpR3aj8FQb9QwMePgekLPq+q2EMNF3/JdYukRuU9bMOIRDY8rPlNKxGKp9t+vrBVqeRzvKWnGpPWLUe49qRUJdHjuRTJcKQ+NJHGSw9cdtnzdXsdzct4BszGP0GQlfSTOPLHyW4Goi72Dhz0pRb0UYozQ+MRHQetbh2dewF40utFJSeiHgXsB4M8pQYyMZOfaMpdWG8t97o0ItWsoq56KrV6n17w/2RiNJgqcGaiQ2caJRd6nNxkc6HYL8vQMWp5Yc9tPQuDAnwZ5qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=raritan.com; dmarc=pass action=none header.from=raritan.com;
 dkim=pass header.d=raritan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grpleg.onmicrosoft.com; s=selector1-grpleg-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54XgMTVMyb8bI1HPYxDhKjUrd5NgWVRBJs7VNqnTywM=;
 b=wdNBK61O3nbUyXhbtAkC7n+f/dE2v8wS00BKv6EdJK9qCNVq0icyT1/6IZruFmVLe3oFyq5cSa01vWfB5BntPXUjriZRKIt3r53UVcXLipWhPZ5SBnuXYkUAAerRI0gdIaewNn6YoPkLRc5wK1yA4/vTuZxOUjh533Jc5TtK+v4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=raritan.com;
Received: from DB8PR06MB6539.eurprd06.prod.outlook.com (2603:10a6:10:12f::23)
 by PAWPR06MB8882.eurprd06.prod.outlook.com (2603:10a6:102:38f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.26; Thu, 30 Nov
 2023 20:43:34 +0000
Received: from DB8PR06MB6539.eurprd06.prod.outlook.com
 ([fe80::98dd:e9db:b7d8:9001]) by DB8PR06MB6539.eurprd06.prod.outlook.com
 ([fe80::98dd:e9db:b7d8:9001%3]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 20:43:34 +0000
Message-ID: <d4ffca97-bb5d-4c42-a025-69b308c24f82@raritan.com>
Date: Thu, 30 Nov 2023 21:43:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] spi: atmel: Do not cancel a transfer upon any signal
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>,
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
From: Ronald Wahl <ronald.wahl@raritan.com>
In-Reply-To: <20231130211543.2801a55b@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::17) To DB8PR06MB6539.eurprd06.prod.outlook.com
 (2603:10a6:10:12f::23)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR06MB6539:EE_|PAWPR06MB8882:EE_
X-MS-Office365-Filtering-Correlation-Id: 60e37bff-1242-472e-2f14-08dbf1e5056e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3FKWVy40kJSlTBTepIiQ3UAfUbSTqkj/0K8iOcbFMRpcwwyfHfzSbppuHZesbsv1XNU6NXdYW9CMtUk4a5EM645Cp6iaC54+5YhYTT3qjUq+Bavb8vNlyv9FtKrDuTxvWMpTGB4H2LKmh+Gz9efHFQPHFf2p1ZSuASMgkbTgXuLpKIj5O7NeMQzfkgnNedQzrqjg6jGl0NEdM0ZrJ9vCutX8q7cGh0+SGdWVaDAuQGZZ4yJWjPS9VECcFY/14/aQ/98Nh2j9HT1wIH0GRXLnalhIGKKTOXdCUMmWLPvGSH9J6HGY9ol0jNxXwsU8XI5nNWHwu7WJAteecsnpi/2Uad3DTmlYmjg1MT2JzuKxHbePWEbw6HZ9W3Yk8E5nH2hQFpshG0HAov0Wx4LjjtvfBMViUTd7umy4XR/kUVCC64WQcVE82Y6GsLRSyyhS5pauDAgSQwOahTYHSNwTYo9rlMrrf8JURyfYdon6bT0AQicVHoZO57T3qRGXb4Mhqh5gsplJiwvUq8kymK5pojdgjs0aGKMDwvzy00TaQB8KG+rnIwU1//rUEDkjGsy/xHYKWb2r1/WypTpkotq3nLTi532MUOOQhG3gSs093qd3yY/CpeK4u7CzyyAYceYOMzpEaNuJIEhvl9xPojyWQG1n6g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR06MB6539.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(366004)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(2616005)(6512007)(26005)(66574015)(83380400001)(53546011)(6506007)(478600001)(41300700001)(44832011)(5660300002)(6486002)(110136005)(316002)(54906003)(66476007)(66556008)(66946007)(8676002)(8936002)(4326008)(31696002)(86362001)(2906002)(36756003)(38100700002)(31686004)(66899024)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEN2SFR5WlVsaGxoK3BjUVpVczRyMlpJY0hQTks5YzNlVHJxdncva3dpUGxp?=
 =?utf-8?B?M3FVbGJpL3pZT0NOWWk1am1uaFRIcXJRYUN2MVV5SUhmU2xjNGxac25mUGIv?=
 =?utf-8?B?ZzAzSGRobiszMlJ0OWpSNENnekhIWVRBd2dzVHliS000L1Zna0RnL0c0Tk9n?=
 =?utf-8?B?ci9CWTFTeUlUZFE5WGhoWEN0SW9DUy8wSTN6VGdGaFFVRkF2eUw4OXZYeVdV?=
 =?utf-8?B?am15QjVVeStVb2ZSNFRaUWE2dW8rVEFpZ1FKaUxEM0NQcGhkQjVhMGZqVks3?=
 =?utf-8?B?N05Gc0tnS1J2RzF2YTd0a3h6WlQ4NVIwUVBFNUFUNDE2VE9RTEwyUi9HVmRW?=
 =?utf-8?B?Yzh0L3JKSlJFcm8wRWtsOE9QaStLTkFBYVgyZmxuVEhwalZKWk53SGlVMTA0?=
 =?utf-8?B?eVZPL3JDTE1GRCtUb3hjV01mQXE1eHdsM1c0b0ozeGsyODExUXYyWHJpWWZj?=
 =?utf-8?B?ZDRTZUpBNzdBUWZYc2VYY3RnWjNtS0psTEV0Q2paSzdwb2prUzBJMXR3WWx6?=
 =?utf-8?B?aVlES0g4cDQ0cCs2WGtDMW0rSnpsZ2dOL3c0K0VKcFFpaUh4M1ZUUU5aclQz?=
 =?utf-8?B?WDNlMXVQbTJkRy9GMjBEYXBTdU56dmU1V0RSOTRNeEFOMk9CSTRYVE1Cclo2?=
 =?utf-8?B?a1c1a0JpU3hsSjNOTDFqZGxIaEMrWTFWUzlwRE8xY2lubkNGMVNFYWt6Y0pK?=
 =?utf-8?B?VkxYVXFmWEpoYzVMQnc4cExsTnE2WlpCZkFiNTVTaitGczJvSW0xcmpmS3RV?=
 =?utf-8?B?enB0VE13UG85TGNvQ1FmRTFwYzFrWVBKc2l0aXdvdXFYdm9najlJSjRzb1Ex?=
 =?utf-8?B?UTRPdEhjZGYxVXJNdEtnTXE1NjJEbG0waXhFZFdzR0tqdWU2b1lrUm5uS0JK?=
 =?utf-8?B?R1BQa09hYVdEMjZmUXRnV2laQjB2Mlp0Y1FDRGZtVUNCcm1zNEorNDRSZVJ0?=
 =?utf-8?B?TGhpOSsrd2VFWm1oT2hvajUybXFHOFFlVVJTQmNxTXdhZVliQWsrejJWTXZR?=
 =?utf-8?B?bkpITWk0RGhDZ0tHbUdtR1RDbHArVGU5NmwweExoRk1YYTF0QldRbzhFV1lo?=
 =?utf-8?B?eXVpSSsyWHpZck1DcG82bC9NOE1CK0cyU3pnVFZVMUNzTjB3SFAvYTE2YlBr?=
 =?utf-8?B?SkhDRW5oSWY5aCtoOEsyVWs4QnhQT0xnL3IvQW5XeXV5bjNNT2M3dFFjOXMr?=
 =?utf-8?B?cDQraHRPRDMySTVzYU9VM2NETXBhWkhNRk0yc1oxL28wZTVUbjlLK2pFTzlK?=
 =?utf-8?B?bGtJclpaMXFIc0wxTjcyTmRjRkJMVUhlQklRTzQ4Tjc4UmlBakY0RGhLTktm?=
 =?utf-8?B?N3JYOEN5Y0hZMHdTOU1YWGJlZGMwSDYydVBxUG5hWFk0Z3Fnak5tblNYTU5C?=
 =?utf-8?B?Uk52YTZLcXRuMGMvV3YzeEZSdkFHSWtvZUtxejBuSjB1KzZTTlBIekg0dFN0?=
 =?utf-8?B?SXlrckhPODY3NGNvOVRvTmgwVGhSNDh3OUFRLzVIRm9QTVd0UUtwNHYxMExN?=
 =?utf-8?B?V2ZNcGJRY2ltMm9jNXlvTUYrT2lraC84a1RJWFkwTkJZS3NXVTZ2Z1lGa3Fn?=
 =?utf-8?B?cituQzgzK2liZHFMRDZhajRUTURmSlFIU0t1VURxZFBEbGFPcXFlNmlvbm9m?=
 =?utf-8?B?bDlFZTJ3MzZKTEYzRkNPRUlkY29zNXU3cFExTE9XQk5Pc2dFR0ZldzZmYkdQ?=
 =?utf-8?B?Q25TQ0hRYW8yRG1MUmpwZFZXdEx6WW15dmtwSXlmYW9WTTlkOVBUYXA4L1dF?=
 =?utf-8?B?eGZUM3hCV1R1SW9tY2N2MEthOFI4dld1ODVVQ3o2elZ5dkhhWEp1RURrTGxR?=
 =?utf-8?B?Z2J2NTZiMXpyaDVyWVpZYnNHMDIxOTkxdGY4d1JtKzFod3hPT2hSaUdwSGNS?=
 =?utf-8?B?TXZLREo1VWNPUmdkQjV5UmFJZzlzdjFSN0NUbFhKTTNrTForNFJCcGZzZVJx?=
 =?utf-8?B?L29SVzZZV2VEZndkN0NOQ1RqQUVwRlhrNnJNemU2ak1pdmg1ZjRXT0UyYkJE?=
 =?utf-8?B?RGJXVkU5QWl4K2VGMWpxOEk0ekxveU5RdHFYVG9icVVFQkhFRGcxMUtYeHFX?=
 =?utf-8?B?UXdyK3pTMlg2ZzRpQ1hTYUc2UkRveHpmRnNNakFnR1JrZG1Oc3dERFF6K1c4?=
 =?utf-8?B?UHl0VGMxcG03YlVRdTI2TExKTmJ4VjJFaG55K0cvTVRhSldYMUxWMXdIYkRt?=
 =?utf-8?B?M0E9PQ==?=
X-OriginatorOrg: raritan.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e37bff-1242-472e-2f14-08dbf1e5056e
X-MS-Exchange-CrossTenant-AuthSource: DB8PR06MB6539.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 20:43:34.5407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 199686b5-bef4-4960-8786-7a6b1888fee3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aT23SgiCcA1iZ1FbKF9w5/2KT6DREcRFl0xYAeN6vqnhLuLAbvkP71GII1oxegyLyakHBfOMjdy4r8x7IoYLkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR06MB8882

On 30.11.23 21:15, Miquel Raynal wrote:
> Hi Richard,
>
> richard@nod.at wrote on Thu, 30 Nov 2023 19:26:07 +0100 (CET):
>
>> ----- Urspr=C3=BCngliche Mail -----
>>> Von: "richard" <richard@nod.at>
>>> An: "Miquel Raynal" <miquel.raynal@bootlin.com>
>>> CC: "Ronald Wahl" <ronald.wahl@raritan.com>, "Mark Brown" <broonie@kern=
el.org>, "linux-spi" <linux-spi@vger.kernel.org>,
>>> "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Ryan Wanner" <ryan.=
wanner@microchip.com>, "stable"
>>> <stable@vger.kernel.org>, "Richard Weinberger" <richard.weinberger@gmai=
l.com>
>>> Gesendet: Donnerstag, 30. November 2023 13:46:14
>>> Betreff: Re: [PATCH 1/2] spi: atmel: Do not cancel a transfer upon any =
signal
>>
>>> ----- Urspr=C3=BCngliche Mail -----
>>>> Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
>>>> + Richard, my dear jffs2 expert ;)
>>>
>>> :-S
>>>
>>>>
>>>> ronald.wahl@raritan.com wrote on Mon, 27 Nov 2023 18:54:40 +0100:
>>>>
>>>>> On 27.11.23 16:10, Ronald Wahl wrote:
>>>>>> On 27.11.23 10:58, Miquel Raynal wrote:
>>>>>>> The intended move from wait_for_completion_*() to
>>>>>>> wait_for_completion_interruptible_*() was to allow (very) long spi =
memor
>>>>> y
>>>>>>> transfers to be stopped upon user request instead of freezing the
>>>>>>> machine forever as the timeout value could now be significantly big=
ger.
>>>>>>>
>>>>>>> However, depending on the user logic, applications can receive many
>>>>>>> signals for their own "internal" purpose and have nothing to do wit=
h the
>>>>>>> requested kernel operations, hence interrupting spi transfers upon =
any
>>>>>>> signal is probably not a wise choice. Instead, let's switch to
>>>>>>> wait_for_completion_killable_*() to only catch the "important"
>>>>>>> signals. This was likely the intended behavior anyway.
>>>>>>
>>>>>> Actually this seems to work. But aborting a process that has a SPI
>>>>>> transfer running causes ugly messages from kernel. This is somehow
>>>>>> unexpected:
>>>>>>
>>>>>> # dd if=3D/dev/urandom of=3D/flashdisk/testfile bs=3D1024 count=3D51=
2
>>>>>> ^C[=C2=A0 380.726760] spi-nor spi0.0: spi transfer canceled
>>>>>> [=C2=A0 380.731688] spi-nor spi0.0: SPI transfer failed: -512
>>>>>> [=C2=A0 380.737141] spi_master spi0: failed to transfer one message =
from queue
>>>>>> [=C2=A0 380.746495] spi-nor spi0.0: spi transfer canceled
>>>>>> [=C2=A0 380.751549] spi-nor spi0.0: SPI transfer failed: -512
>>>>>> [=C2=A0 380.756844] spi_master spi0: failed to transfer one message =
from queue
>>>>>>
>>>>>> JFFS2 also logs an informational message which is less visible but a=
lso
>>>>>> may rise eyebrows:
>>>>>> [=C2=A0 380.743904] jffs2: Write of 4164 bytes at 0x0016a47c failed.=
 retu
>>>>> rned
>>>>>> -512, retlen 68
>>>
>>> Ugly kernel messages are a normal consequence of killing an IO.
>>> Chances are good that we'll find bugs in the upper layers.
>>>
>>>>>> Killing a process is something to expect in certain cases and it sho=
uld
>>>>>> not cause such messages which may create some anxiety that something=
 bad
>>>>>> had happened. So maybe the "kill" case should be silent (e.g. level
>>>>>> "debug")
>>>>>> but without out hiding real errors. But even when hiding the message=
 in t
>>>>> he
>>>>>> SPI framework it may cause additional messages in upper layers like =
JFFS2
>>>>> .
>>>>>> I'm not sure whether all of this is a good idea. This is something o=
thers
>>>>>> have to decide.
>>>>>
>>>>> ... and now I just got a crash when unmounting and remounting jffs2:
>>>>>
>>>>> unmount:
>>>>> [ 8245.821105] spi-nor spi0.0: spi transfer canceled
>>>>> [ 8245.826288] spi-nor spi0.0: SPI transfer failed: -512
>>>>> [ 8245.831508] spi_master spi0: failed to transfer one message from q=
ueue
>>>>> [ 8245.838484] jffs2: Write of 1092 bytes at 0x00181458 failed. retur=
ned -5
>>>>> 12, retlen 68
>>>>> [ 8245.839786] spi-nor spi0.0: spi transfer canceled
>>>>> [ 8245.844759] spi-nor spi0.0: SPI transfer failed: -512
>>>>> [ 8245.850145] spi_master spi0: failed to transfer one message from q=
ueue
>>>>> [ 8245.856909] jffs2: Write of 1092 bytes at 0x0018189c failed. retur=
ned -5
>>>>> 12, retlen 0
>>>>> [ 8245.856942] jffs2: Not marking the space at 0x0018189c as dirty be=
cause the
>>>>> flash driver returned retlen zero
>>>
>>> jffs2 has a garbage collect thread which can be controlled using variou=
s
>>> signals.
>>> To terminate the thread, jffs2 sends SIGKILL upon umount.
>>> If the gc thread does IO while that, you gonna kill the IO too.
>>>
>>>>> mount:
>>>>> [ 8831.213456] jffs2: error: (1142) jffs2_link_node_ref: Adding new r=
ef 28b
>>>>> d9da7 at (0x000ad578-0x000ae5bc) not immediately after previous (0x00=
0ad578
>>>>> -0x000ad578)
>>>>> [ 8831.228212] Internal error: Oops - undefined instruction: 0 [#1] T=
HUMB2
>>>
>>>
>>> I fear this is a jffs2 (summary feature) bug. Chances are great that yo=
u're able
>>> to trigger the very same using a sudden loss of power.
>>>
>>>> It's not just spi-atmel, any spi-mem controller might be tempted to us=
e
>>>> interruptible^Wkillable transfers just because the timeout values can
>>>> be really big as the memory sizes increase.
>>>>
>>>> One solution is to change the completion helpers back to something
>>>> non-killable/non-interruptible, but the user experience will be
>>>> slightly degraded. The other would be to look into jffs2 (if it's the
>>>> only filesystem playing with signals during unmount, tbh I don't know)=
.
>>>> But maybe this signaling mechanism can't be hacked for compatibility
>>>> reasons. Handling this at the spi level would be a mix of layers, I'm
>>>> not ready for that.
>>>>
>>>> Richard, Mark, what's your opinion here?
>>>
>>> I *think* we can remove the signal handling code from jffs2 since it ma=
kes
>>> already use of the kthread_should_stop() API.
>>> That way we can keep the SPI transfer interruptible by signals.
>>> ...reading right now into the history to figure better.
>>
>> After a brief discussion with dwmw2 another question came up, if an spi =
transfer
>> is cancelled, *all* other IO do the filesystem has to stop too.
>> IO can happen concurrently, if only one IO path dies but the other ones =
can
>> make progress, the filesystem becomes inconsistent and all hope is lost.
>>
>> Miquel, is this guaranteed by your changes?
>
> Absolutely not, the changes are in a spi controller, there is nothing
> specific to the user there. If a filesystem transfer get interrupted,
> it's the filesystem responsibility to cancel the other IOs if that's
> relevant for its own consistency?

I think yes. But the only thing the FS can do is stop any writes from now
on which is not a useful consequence of killing a process.

Anyway, the whole issue started with commit e0205d6203c2 "spi: atmel:
Prevent
false timeouts on long transfers". Citing the commit message here:
     "spi: atmel: Prevent false timeouts on long transfers

     A slow SPI bus clocks at ~20MHz, which means it would transfer about
     2500 bytes per second with a single data line. Big transfers, like whe=
n
     dealing with flashes can easily reach a few MiB. The current DMA
timeout
     is set to 1 second, which means any working transfer of about 4MiB wil=
l
     always be cancelled.

     With the above derivations, on a slow bus, we can assume every byte
will
     take at most 0.4ms. Said otherwise, we could add 4ms to the 1-second
     timeout delay every 10kiB. On a 4MiB transfer, it would bring the
     timeout delay up to 2.6s which still seems rather acceptable for a
     timeout.

     The consequence of this is that long transfers might be allowed, which
     hence requires the need to interrupt the transfer if wanted by the
     user. We can hence switch to the _interruptible variant of
     wait_for_completion. This leads to a little bit more handling to also
     handle the interrupted case but looks really acceptable overall.

     While at it, we drop the useless, noisy and redundant WARN_ON() call."

This calculation is actually wrong by factor 1000. A 20MHz SPI bus is not
really slow and it will transfer ~2.5MB/s over a single lane.
The calculation would be right for 20kHz but I think this is a more
esoteric case, isn't it?

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

