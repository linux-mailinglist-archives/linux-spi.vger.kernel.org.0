Return-Path: <linux-spi+bounces-121-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DBD98031C3
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 12:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 153DA280EF5
	for <lists+linux-spi@lfdr.de>; Mon,  4 Dec 2023 11:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D86C22F02;
	Mon,  4 Dec 2023 11:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grpleg.onmicrosoft.com header.i=@grpleg.onmicrosoft.com header.b="VTLz58v9"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2103.outbound.protection.outlook.com [40.107.241.103])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1185C4;
	Mon,  4 Dec 2023 03:54:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVpZtaQwHWojd8ZjEdTqMKTEnvx8BYVmBppEkQvYgQJTAW8qCO7oF8AmE2GA1uLPbx/eMP3GuKIxDVjTjLjXYGsz/K39UoP/PlHIEy5b6+wrCEBXHvuUXK3BN3BHeebVfQGchCeKdbtN2rfbX6nBMLd0NCb7t29Ko9p3k5m/VaXcF1GxgS2NSgzeceUOa27wis0E+QBVEPoJj9dSZCYVro9i/AfmEkus3Rfg6nv2CLnmi3Ntz8QibcZmd7tzy/aNYCi4SSr79kbjxjeRfX2x4/W+5DR3piF3Ad7V1jKmTbaBpeOOHTIJrhVb+ToROTgngmu9XMRtDzsfaBrgsp3gYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyTCgEFWXxevcwMRs0kM8NATWKTPQKSlpLdWGfS3Qh8=;
 b=Y+Fl79opoGZwuUaMGpA2VQrkapCAOGdYgYisYqereaHQKM6+qB1hBbBIPDCzzgodjPoAyHQgt48xojU9DCfVVZfjacYSnVPsa5X3yv8IdQ/m/RPes/9wi4QRPP5t6JWTFa8UX8egnR2Cn8CA1muRI8E/8BeKhLAjPBfKtSxBzpT7dr5w5fM8562/VB2op4UHlFD52dXXB+/vypsEeHqVRIg6kWEWTMQcPBAO65z6RE25X/WO7hRkHP9cX/PpEyJC0Fcip09hdu79Y2OMP85vT7sjHG9y2wdNd+NOr1Y9tYyOOwG6XXtVMfw17YjvjJohnku3+DWWChXRdVWhonrnDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=raritan.com; dmarc=pass action=none header.from=raritan.com;
 dkim=pass header.d=raritan.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grpleg.onmicrosoft.com; s=selector1-grpleg-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyTCgEFWXxevcwMRs0kM8NATWKTPQKSlpLdWGfS3Qh8=;
 b=VTLz58v9w+jWRy17bcoHJDQzwo35PHqhhUzsf4QTVBZnrJImubEts9nOvrNaUqoiCzrKafF4/1TL46T02T5hBZvtkDUlKDwluYQ98ZRQn+6VIpgqEjyvWudeVNo/IdXkLYb086sNbE5ZM9umZ1lmUAjEkOeXFa62J6IRQ1nklfI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=raritan.com;
Received: from DB8PR06MB6539.eurprd06.prod.outlook.com (2603:10a6:10:12f::23)
 by VI1PR06MB6414.eurprd06.prod.outlook.com (2603:10a6:800:12a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 11:54:52 +0000
Received: from DB8PR06MB6539.eurprd06.prod.outlook.com
 ([fe80::98dd:e9db:b7d8:9001]) by DB8PR06MB6539.eurprd06.prod.outlook.com
 ([fe80::98dd:e9db:b7d8:9001%3]) with mapi id 15.20.7046.028; Mon, 4 Dec 2023
 11:54:52 +0000
Message-ID: <6f603fdd-12dc-4929-98aa-bee1f533e8e2@raritan.com>
Date: Mon, 4 Dec 2023 12:54:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] spi: atmel: Do not cancel a transfer upon any signal
Content-Language: en-US
From: Ronald Wahl <ronald.wahl@raritan.com>
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
 <c7980bbf-04aa-4c52-9c6c-f3a1169e90f9@raritan.com>
In-Reply-To: <c7980bbf-04aa-4c52-9c6c-f3a1169e90f9@raritan.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::13) To DB8PR06MB6539.eurprd06.prod.outlook.com
 (2603:10a6:10:12f::23)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR06MB6539:EE_|VI1PR06MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: d90c198d-78d8-439c-a355-08dbf4bfd35a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WwA4vv48vPSoTtCcPcnu6bBwKIHBnvDGfwQkstKOCLEdo624obnQOexwr0ad22uk3JQM4vh/XbPkxkM7CYcYD1pAxrVfPkHd/6lkvFnisPdRVaD1Fo9AVzoiI69i9nH1zJGIB/uTIsQxnqR+yubMRUeYb9059BdKt/HqrePp4RpFlPR9q3/92BWK5q3hmNSW+BOwpgMrLYE9QAb5120U+r5pkYvzkSW2+k/oUqwASBDga9BDH2sku0awoElJn77dwlbDFZzY7KSDtlnHceWrQEuo4vdfdgeFV2q9yTsE7GajTbgLM5Sg9hw1FysZ6tqftepYlAhB4hxdPt6cgdkX2rew6hAgPnlHEmlSoQj+VjrexsA7CXRfPcE5j8dhs6hC+IzWYAk1EQ8doB1BYcAt3Zj6qlnCj7dE5iIeecmwdEX9/plnXLm8SXRaGKh3+OFJQLojLVBvNkg1DDLGIa7LbT6cNA7gVIt3ZcsjJRsKplQl/PDE23sYtXJ3jOBUdWsqBcYEGTVjf3GrpA8hoixo4GzMq1JjnIXDW4W1PduSikuVdPxc+S7emuCORl2Df3799wmrTjPY+sgzbqe01z5BARJaP7FEmDe1sReGa6N/it111thjW8h0mDksAzeA6snm8KPN/mUGJiTkIARJdvo8KaXWqJKwfVAtY/6xsaMANBlsMPcEBbN5LHMksNczQRByn7rqfWewcw51FUYLuATOFbosVbyLm2u2qL7NWW0fPBo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR06MB6539.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(396003)(376002)(230273577357003)(230473577357003)(230373577357003)(230922051799003)(230173577357003)(186009)(64100799003)(1800799012)(451199024)(478600001)(6512007)(2616005)(8936002)(8676002)(4326008)(38100700002)(66946007)(66476007)(66556008)(54906003)(110136005)(316002)(31686004)(26005)(83380400001)(6486002)(966005)(66574015)(6506007)(53546011)(44832011)(31696002)(86362001)(5660300002)(7416002)(2906002)(41300700001)(36756003)(66899024)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmQ5d2lzcjJtQm5pZHViVkJTbFU5bjBZcWUzZjJmQi9PU0VWN090dUlSdWM1?=
 =?utf-8?B?a0Zkb0dIS2s4d3VwZ3I3OGIrdUNiUi83SHlwam9RTHlxalFCRmdIN2FiWXhF?=
 =?utf-8?B?c2JJeFUvdmpqNnA2dkwzWS9TNUpWc2kycEFKNGZvMXV2QWt4QlJxdzEzMFpm?=
 =?utf-8?B?dDUvZ1AxZTlZVUlZc0NTcWVjMXBoTFE5MUorR2ZrdUg5SlFlYzdLRmlJRVFo?=
 =?utf-8?B?YUliSVFaMDE3aXNPU0VFMW5pU3Y4Wmo4NzRFS0czVzczVmlYWmZSWkMvU21P?=
 =?utf-8?B?TmR4L3dtN3pQdzR2eEM3c0F1cmhSOHVCR2htU2hMb25TcjhwM0x0QnJWWFdB?=
 =?utf-8?B?bkk3QU8yWnFiOVBnblJHMkRScjVsRDZ6T0JaMXpTRFh5RU9ta3lyN0hKUlJP?=
 =?utf-8?B?K0YyY3Zwcm85aGVTRWx0Tzg5Y29Scm5qTGxsdFVaYUZJM2ZvK2tjN25OYTc3?=
 =?utf-8?B?RDFqR2YwSmdBRnB1cy9yeEc1L2NtdEVJRVV2ZDhIRnV5amlYZ2pyL0NXZm1r?=
 =?utf-8?B?am1VU2JtRW5mbGxxN3BUYk5KdU9udzdSSzA3ZHE5QUowK1ZZU0YxSjdvOUV4?=
 =?utf-8?B?R2djeFRJQ0x4VEhRWE9ja1NtZWk2Wm1BNjZFRS9ETkRpd0FUcldrSlg1VWt4?=
 =?utf-8?B?aVJYeWV0NGg4bXNlbWZFMWtXRGlmT0trMkVCbEZ0dlpId2hMMERGL00rV0V0?=
 =?utf-8?B?bU1vVFpiaGpXemxtOGpPa3FteE53OTJsbW5ndUtjZURaSDZTY2Y5QStIUlVF?=
 =?utf-8?B?STlHbnVLZGJuYzVGb3JSb0YrZGlkZVRzcGZiSjNLM1dWTFM3djdTVHZQdG1s?=
 =?utf-8?B?bm9wZnB2dWQ5S0dGcmZlbjlaUGVMR3VFMG5nY1Nvc1hkaE9ocE5oMnZVc2s2?=
 =?utf-8?B?clNoSDlLNWx3SllHQlplWkx3eXRCcTA3RTc4Y3M1ZW8zYXZEdUNxVVpKSGpF?=
 =?utf-8?B?NWFzbVVHTXZ2SVhRYWdldG54aFdrNnduSnFKMWx1ZWkrUzllcEx2TXVUOUxF?=
 =?utf-8?B?R0dRcnJhZjg1UkVVR2d5V3JFbnU1ZlBiMDNueU9VdG1sQjNRdEsvOEZsMmVy?=
 =?utf-8?B?Rk5vYkNXcUF6Y3hiSVdjRDNWeXN5MXFRamNuN3F1bVhpNXlFcENUb2ZVYTdj?=
 =?utf-8?B?OHVmK3hVOWV3VW5VTWh5djZkRFM4U1M5bzc0SkN5eDRqUGhZejUrM3ZPaUVV?=
 =?utf-8?B?N3NrSElGelArbEphYkxJWmkzSnVqQjZLQkZQaGVWUGFnVTZQaUh2OTNlNUQ5?=
 =?utf-8?B?YVFCMUt2MVhzcm9lTHp2NUExVEkrL3ZROXZqdjV5VVE3aFF5a3o1a2x4dTdS?=
 =?utf-8?B?K2xlQlhlK0xZMWpYSlI5UEd2dHZKcEZDRVcxQldpa1lmeUtCN2x1aTVER3I3?=
 =?utf-8?B?d1ZLcUd6SGhJS0xoV0pRU1NDeUlIc3dzSkM2ajMrTTdmZVl5UEFJUTVGNjNr?=
 =?utf-8?B?YUNCeUpaQXV6aERKN2VEdDZiZDZvcE5RSWplMGpDRGYyQTlDajc3aGh6SlVm?=
 =?utf-8?B?NnIvZDBZaDhnY3BwazhncUxjbERZZnZOQzQyajF1cFBrMThIN2h1OVZPSUlQ?=
 =?utf-8?B?VzJ4blEzOEl6dTBGVlowWGNhYmpqTmdIaHN5K1FYOEpUNjI2eGc3VzIyNTQx?=
 =?utf-8?B?STdHRUJZTE5OSlBPUTJYVWFwbnN6UnhHWXR2UGRDK0ZNei9COVAzVlNqbnZh?=
 =?utf-8?B?Uk1KYXJ3YXY3d1IvSlhjWm5MbHlVdEJnQVVpeS8wQStzdTdhWWNra3NyTmI0?=
 =?utf-8?B?MXFWZFI2WHlDYktiT09FbUpRNFpHdVlhREhlRTBOdWRka3dUaG11NzhUNHVL?=
 =?utf-8?B?L2k3djV3c3FwVldRSGpmWXRPYkZsaEF0SDJHbW9DSzhEUEU1NlVMVGhrSGhI?=
 =?utf-8?B?c1NlVWIvSVYzbGNPQWhya3FldVJiQTNXYXljcDNuczh4dXdDMksxZkRsVG56?=
 =?utf-8?B?UmlTOWpuUnFzVXJCZjBQOVRjN0Y2QUlabW5lNmFzU3RteDNxME9Ja0IwcFFO?=
 =?utf-8?B?Q3lhZ0c1akx2eEM4VDB0MmZQNkszajhLdTZGZHJGbXRRei9NcjJaMDFjeER6?=
 =?utf-8?B?b3dPVXRHMWh4SmtBVHhDMFdyZ3NxVWtaWFJwWGJkUjFUazU3djg5cTF3WW4v?=
 =?utf-8?B?anYxbzcrYkMwa3ZwVEQ5eTJJcnhHaWJFcU5rekJCeVNTeXVvcHFWNStnTW5w?=
 =?utf-8?B?SVE9PQ==?=
X-OriginatorOrg: raritan.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d90c198d-78d8-439c-a355-08dbf4bfd35a
X-MS-Exchange-CrossTenant-AuthSource: DB8PR06MB6539.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 11:54:52.6317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 199686b5-bef4-4960-8786-7a6b1888fee3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9uAIZR9JJSW2oBQsj8vPdryUWQ/JFum3RBC0fDwERsGeQTJ6XCdNdvfqs8z8NzL/KJm21mjc359k1IYfawnG7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6414

On 01.12.23 14:38, Ronald Wahl wrote:
> On 01.12.23 12:13, David Laight wrote:
>> [You don't often get email from david.laight@aculab.com. Learn why
>> this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>
>> ...
>>> Anyway, the whole issue started with commit e0205d6203c2 "spi: atmel:
>>> Prevent
>>> false timeouts on long transfers". Citing the commit message here:
>>>       "spi: atmel: Prevent false timeouts on long transfers
>>>
>>>       A slow SPI bus clocks at ~20MHz, which means it would transfer
>>> about
>>>       2500 bytes per second with a single data line. Big transfers,
>>> like when
>>>       dealing with flashes can easily reach a few MiB. The current DMA
>>> timeout
>>>       is set to 1 second, which means any working transfer of about
>>> 4MiB will
>>>       always be cancelled.
>>>
>>>       With the above derivations, on a slow bus, we can assume every
>>> byte
>>> will
>>>       take at most 0.4ms. Said otherwise, we could add 4ms to the
>>> 1-second
>>>       timeout delay every 10kiB. On a 4MiB transfer, it would bring the
>>>       timeout delay up to 2.6s which still seems rather acceptable for =
a
>>>       timeout.
>>>
>>>       The consequence of this is that long transfers might be
>>> allowed, which
>>>       hence requires the need to interrupt the transfer if wanted by th=
e
>>>       user. We can hence switch to the _interruptible variant of
>>>       wait_for_completion. This leads to a little bit more handling
>>> to also
>>>       handle the interrupted case but looks really acceptable overall.
>>>
>>>       While at it, we drop the useless, noisy and redundant WARN_ON()
>>> call."
>>>
>>> This calculation is actually wrong by factor 1000. A 20MHz SPI bus is
>>> not
>>> really slow and it will transfer ~2.5MB/s over a single lane.
>>> The calculation would be right for 20kHz but I think this is a more
>>> esoteric case, isn't it?
>>
>> Some of the sums are wrong, but the conclusion might be right.
>> A 4MB transfer at 20MHz only has 5 clocks/byte - seems low if it
>> is only using 1 data bit.
>
> Can't really follow. Each data bit requires one clock on single wire
> SPI. Adressing and the like may require a bit of overhead but that
> should not be that much (12.5%?).
>
>> The spi devices usually support 'nibble mode' for read/write that
>> will speed things up - provided the data lines are connected.
>
> We use SPI (single wire) in our devices with ~40MHz (older hat even just
> 12MHz) and we never had issues with transfers lasting to long. This is
> because file systems transfer much smaller blocks in the multi kB range.
>
> The speed is ~4-5 MB/s with ~40MHz - with 20MHz it would be half.
>
>> OTOH a better fix is (probably) to do the transfer in sane sized chunks.
>> The extra interrupt and code won't make much difference to something
>> that takes that long.
>
> Exactly. This is what file systems usually do.

Anyway, at the moment the code breaks at least two file systems
(JFFS2, UBIFS) and probably more. So I request the following:

Revert e0205d6203c2 "spi: atmel: Prevent false timeouts on long transfers"
and the two new patches that are already added to one or more devel trees
[1/2] spi: atmel: Do not cancel a transfer upon any signal
       commit: 595d2639451d3490c545c644ece726a0410ad39b
[2/2] spi: atmel: Drop unused defines
       commit: 28d8051efae17b6d83544f3c1cf06f6a71677e91

Any potential improvements can then be done without hurry.

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

