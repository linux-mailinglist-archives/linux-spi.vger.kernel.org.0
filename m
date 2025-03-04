Return-Path: <linux-spi+bounces-7019-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D7BA4DDDB
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 13:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7584C1782FF
	for <lists+linux-spi@lfdr.de>; Tue,  4 Mar 2025 12:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C25920298B;
	Tue,  4 Mar 2025 12:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="N3Zeubzc"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02olkn2018.outbound.protection.outlook.com [40.92.49.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE1078F4C;
	Tue,  4 Mar 2025 12:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.49.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741091162; cv=fail; b=hyIHfznpw5qtFjE8iQbQd6/VT5B5J6EZqEKppU/HG3t6YZuPVSOXyo2IGpe4lOIesCaqVmmwtAjmi+KaMnrTJxYwQH/Yzmk1+Quy3ENzG7RROtO9nUAYQuGoKEwGlvrbu941EdxPXAGstvtaHlcqhUw4bk6Qmjyd3xVrXOhwaV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741091162; c=relaxed/simple;
	bh=Eq2ZlTp4wLLC3yQkgRW0UxscQOJI3q3Sym90/WZ+DEw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s2DMVyo42xhgBA2Xp+He1gLzg/HOI9OJyJID93G/ihh4qgpJ4GdT6Lj6fPYZTaw26HoYtvh2RMQzoONOY7fNp06811pN5NVbygVNsAPx7lwzhdFn8SlVhs6/jNNyi/wPqbzX5y5kFT+aGO4Dn/0igUhRaftdwMPlgxIfLSug+gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=N3Zeubzc; arc=fail smtp.client-ip=40.92.49.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMwanRvgyuwlbmRZyToCi1Gwf/wZcyFqq3suD2q/iKl0U8kaSxU35RBZtCgx9P5S9URK8QLqa4OhPLU7kne5hDehQkuPhLqz0dVP3vB6oAdX5t+ooxY2aU2boSLf0U9DVYdl+sjSfSNZah0kLxIgOSwurVJwJaKDntaRClDNtZg4pdc2XjvwHZhGB2+kGYAy+j6Ue6ssJjEl3qelhC4IaadJeZ4T+SV60RnuWX+Hl7s3H2SpMnhBZnOixtsvPUX9UARd/JbwWQLGD7JBCsL85NpCwzjJUVGlUlFn1p4hZgH2LDzAtxycGm3Ebl6S4ca16bKBehvg7y/AEd0H3kljOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VQJ3PFQZZsvxALKrZxhZr+pJsLHBwdQQlCmRATu1yE=;
 b=LvpIb0Y/zkComf34u+rrFLIsVAN8CeK6UZlxl99dEAFrkEwyMCHkNbdpB+FQ2HN4nTju7En9pgA5YPUSALzzlCcfo52OgGjo8rR5qfkEsQ7/QuI5J3dNcJLo66A234lvwF64ezTkJpMTRfEhM0Ok3hkcNjoLEsN1O9DBWROi5/9e0uvfFlpQxHMHyBc790Do2TSDDf29XASPBYO8SKXqg671wwpdHbncO61TAGVecDkwf+8BzXlO6aEwfzdzGshJcmigjcxAdlA/lVZJ3Icheuudeh/QU6X+iPDTdlJ/toPiJnN5opBD7YGoJNRs7+kPuLh7YDmNHju9ieL1pOzAbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VQJ3PFQZZsvxALKrZxhZr+pJsLHBwdQQlCmRATu1yE=;
 b=N3ZeubzcQ03vJ6Pgg51UuNIgp6TeR/WqxAaTPQyOItkb7Q+XHsU0y0PtcRqfNHxLCd3yk2/AmiQzw+vgBJHkTuv3UH4JQ5dtvLXIIHfd/FIFNxdcM989nufAuvrFJnCoWWOurAPKlQgC/vQq/nwsjCZ8zsZa0BU1v2Db3WAudREUKVEVkAiCW3oGIeq3X/jb6AVJugT7wekE4t7/MLXam9EvdZOcrQKR0m3DM4o9rr5oyGjGUw8Y+WrAgtfO+CYh+xI0JZ9qg5rsbDOrzCMI/tWWMMoDvir5nhbD4xQ7gWbZmZUal8wjaSEKT2mCLnBtelbgZVsnxgApE6aQPAKrqA==
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:175::17)
 by AS8P189MB2579.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:63b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Tue, 4 Mar
 2025 12:25:56 +0000
Received: from AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::e9f1:a878:e797:ee1a]) by AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 ([fe80::e9f1:a878:e797:ee1a%2]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 12:25:56 +0000
Message-ID:
 <AM7P189MB1009299C0A6FADCC974F94D6E3C82@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
Date: Tue, 4 Mar 2025 13:25:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] spi: sophgo: add SG2044 SPI NOR controller driver
To: Mark Brown <broonie@kernel.org>
Cc: Longbin Li <looong.bin@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 sophgo@lists.linux.dev
References: <20250304083548.10101-1-looong.bin@gmail.com>
 <20250304083548.10101-3-looong.bin@gmail.com>
 <AM7P189MB100970D57C974DD7CC5DB156E3C82@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM>
 <74a0cbdf-d303-459e-977a-2be1a6c9d274@sirena.org.uk>
Content-Language: en-US
From: Maud Spierings <maud_spierings@hotmail.com>
In-Reply-To: <74a0cbdf-d303-459e-977a-2be1a6c9d274@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P192CA0008.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::6) To AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:175::17)
X-Microsoft-Original-Message-ID:
 <89920d63-5c17-4693-9be7-ebdc48d18f4f@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7P189MB1009:EE_|AS8P189MB2579:EE_
X-MS-Office365-Filtering-Correlation-Id: 3967892e-2eac-4368-0b79-08dd5b17b6a8
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|6090799003|5072599009|19110799003|8060799006|461199028|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2RMZlgyckFZL0lYTm1RSGdiWUtvczN1ekp5QmpDZUo0VHBOdGJqSHpySm1P?=
 =?utf-8?B?TGZHTVFza0dlLzVqUnRDa0lvaVdPbnRyRUt2S1ZSNjJIbEdwakxzRG1XdHNs?=
 =?utf-8?B?V1RUZjhvTDEraDVibld5eXlXc2RxdDBpSjJycFFLRVhjMUNzcFRFT3U1UVkv?=
 =?utf-8?B?eG55aG16OFgyZUxwa3ppb3JXQUZsUUZvZWdzc2ZkeVY4RWJJa3JvNHJpQ3RC?=
 =?utf-8?B?bnJPN2VFTFJKbGMzZTlXYWJBS3I1b2dqbC9TTWZPMWd6L0s1dlhiSE5JdkVr?=
 =?utf-8?B?YVBqdXgyUGJmNEtCdlZMd0YwZSsvQkJ1UXFReG9uaVRBdXZlenlLdTRoSUZF?=
 =?utf-8?B?NlRFMm5NZ0FVR1pmTmJsb1BpNEhDRUpMS3krcTJ3U3hvMUVwRnFKcVFtSnRW?=
 =?utf-8?B?cE4zdDZ0RjY3TlRzckdXejFEOEZGaEoyWk1lTGVPaUEwS2JQdXM2YnhuUUhx?=
 =?utf-8?B?ZjVyRnNWcytMSHVkYmxOUGJDY25oMk9TWFpiL3NyeUFTNkdyWVRYN0tXc3N3?=
 =?utf-8?B?RkcvbFIvMldKWVZqRTZJbDNyM2o4bW5UT243WkRvcTM1Q0JLLzZsQmxKWXNj?=
 =?utf-8?B?cE91NFZDa2lPa2dyZ3NyVXpmYlZ2UkxCSTNXVUNWRGt1MnEvWlFGM2JKM3cz?=
 =?utf-8?B?WEZtZUpqUEVnbjRGUnNrQnRPTnpCYXFaQTdBeTFQWGlOeDZnc0NHb3pOWnd6?=
 =?utf-8?B?OVhGZ1FwdkxIeHdhRWU3RWZKL2FGOEhmeEZ4NWI0elc5aTMyYVpoS1d0RWgx?=
 =?utf-8?B?dUdtSlZDTW5PRFo2SXlBci82d3FMOEJNdVJIaVRIbUdYZk1WaXBOa0JDWXRH?=
 =?utf-8?B?RjFDb0dJTUlaMVU0b1NZYk5UVXZHZUN6QU16OFoybnZ1K1JIQVlKM3NmTEZT?=
 =?utf-8?B?RzVZUmFUVEVCbmcxUXNqUTZRanUvQ1VQWDd3YTN2aXE4WVI3M0JHZy81TzFO?=
 =?utf-8?B?aG5GcUl1b21iakRPekFPSXRaN2k2ODlTMGhtbXN3cVQ1WVRkOElTWVo2dklE?=
 =?utf-8?B?QzJWTlpZTUJKL3QwS1IrSzlFMG9aQ3JoWVU0MmdUYzhXandacytlMUpXK1dV?=
 =?utf-8?B?Y0psZnY1Q3NKWmtZNGI0TnQ3VUI1NXhPZCtxVzJjS0pzeDZBSFRscU9IYnFF?=
 =?utf-8?B?TEhFS0QvOE90Vno3OTdhNDJvczdHUlVUSm9kOVlBS0M1VXNjNHFRQ0IvdUJi?=
 =?utf-8?B?cC9yVkNTbGxUem13QTVqRTVqa0treXN2QWVSeHZuMFpsZDdaUXYvTFRrL0ha?=
 =?utf-8?B?UkJOeHpybllEZEUyeXN1TzdMMjVhQWIzSHRVeWtsSXMzaThRYm9pcmFOb2hR?=
 =?utf-8?B?cXdDNzRIZUoxL2tPdkh0aSt1UlZWTE5vbHl5RHNCZUJqL3V2ZmxRc1l4WklF?=
 =?utf-8?B?MFdJVGV4ZTg0Tjl0SHJvMVFHT2R4Q01HVm1LZFhlZm9rMWxaYUtxekc4K0NG?=
 =?utf-8?B?QXpwQVpvZHNZVGk5eFp6bEpPKzhhTzRjZ3RXek93PT0=?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUJCSVdzS1VjRzJ2L1M4WW5uKzVDME1BdHdCT3hQMk1XREx4NzhZUEpsU01M?=
 =?utf-8?B?RTdrR21tRjFqNzBsSUpuYVQ1STRFR1RhNjg4Uytqb2Vnd1p2bDJET0NFODJ1?=
 =?utf-8?B?YWZBaVRmNUhteFYwd3BucGhRQ0NXalc1Nmhwd3AvcldmVU5SRTRVT1J3bm91?=
 =?utf-8?B?c0Vnc1NYendldGw5WkkybDJpTDV2OU55Z3lFRmdpZUxLeHVmYjJ2VTEvUzZw?=
 =?utf-8?B?RDVVanQySk5yRUZ0dFI1a2w0ZXd2NUZmT1hDbngwTUJhNTMwUVk3a1RaSFR3?=
 =?utf-8?B?bk1vWkMxbGRES293ZGRQK3dBMDFLNnk4ZkZKdVF6bEJXVmJVVUovbWt5bXJj?=
 =?utf-8?B?amxQL01qMkd3WjFMekVTcDZGUFNKUElMTEVDV01vZEY0ZHJlR2J3cVhHc21M?=
 =?utf-8?B?WU5rZGM3QUhDM2RjSjBqSUQxOGUrOU9SSHJMOWpTc2tWNjF0S0MzMmVCTFRU?=
 =?utf-8?B?Q0NvSk41clk5T2J5TEpoM0craG5EWlRISFBFRjR1bFZyNytGOXpJOVZEUWg1?=
 =?utf-8?B?K2tMUzAzSUJYUG54RE1TUWNSbHBFREpBTXBjMFZsamxjTDBLdjhrdE1aSkti?=
 =?utf-8?B?KzZKWDdhOVc2Q0tRSnJRL1YvbnNjRGpRTEF3cTlPaWVxaEpCbFdvSTJZQjVD?=
 =?utf-8?B?WUlTd2YzZ0JRNVVFNkNwUE1jR0xDczlISEU4UTkwQUpRSUFvaERMREt3STBq?=
 =?utf-8?B?T0s0T2NYcVJwVDk0LzhWQzRTWlJGMVlLRHRHOFNya1RZZS9Ybm1DVVE3S1ZT?=
 =?utf-8?B?d1Zzd3JXSXJ6VTdrZWE1bzRPaHNGRGhKcmd5S2ZYOXY1N1hiU3BtamZ1VEFx?=
 =?utf-8?B?Z1ZSbktQNEtvb1Q4akRRTVJHKzQ4QkhlbDl3MktZYWtvdEFvSFdydUJOV21v?=
 =?utf-8?B?YytqOVZONDhRbUY3WW5KZ0ptRTMwbUJQWWNWMFBnM3VBUHFYVlJTZkpWM2Q0?=
 =?utf-8?B?ZERXT1haRXo5bllHVHZTUklvVXU1ZU00WVZjYWhtKzZtVk9wMEg5NjZEQVl6?=
 =?utf-8?B?NVhvWGxEUHdEamRpUHl4WXpOR1l1SjQ4dXJ1VmxvNk5rYXhVTTkrZkV5ODIw?=
 =?utf-8?B?K0x0bDUzTlI4NWdrWnpFdlVoc2pYc3IycVlXMjI4VEpqdThGN0JTbTBmUHJ3?=
 =?utf-8?B?T3NIeHNmeE40RVp2VENwNU5GaCtqaHJVaGtqRm1LT2pFZE9PN1ViU3dpTXR6?=
 =?utf-8?B?YnI2RllCTVlkSlNFNStGdzBEZVJ6aHNMWWFzZC9YLzduT3RLNEdTZG5sRmNn?=
 =?utf-8?B?ZjhsVnpTR21za0RMblF0MU5YRVQyUHh4bENNUHFOOWVVTlozdXBaZlpIQklR?=
 =?utf-8?B?cGp2c2phSlVwSTZERkpkT1U0OE1pWlZkcWJxaVZOUWZEWE1tT1BsaWVPMFgz?=
 =?utf-8?B?b3hpT2Q5b0JRZDRpeldaRTBYaExDODYwTHlVNXVITUQ1bEZQQXFZQTh4V0xF?=
 =?utf-8?B?VzFSeWIvWmlsWDJTZ3VNRUxVNjRNTU40YTk5YzFyR1ZCWHlnRUNsNVZFV3l2?=
 =?utf-8?B?RGZYVHVraEJZY3M0T1VXU0NTd0ZsdjlHU1pKU3l6U1l1Y0d2czdLSy8vQ0VT?=
 =?utf-8?B?R2hGSHQ3ZUt4Mkp0WHFqaUdwbmtKWnVXd1Y5dG5PMjE4d0JsZHk4TWNQeUpG?=
 =?utf-8?B?ZXNncGtLYVRjeEFIeDczc1NlU3Q4dnJ2NmJORHc1eWhIVXNPNDd6SERHS2dw?=
 =?utf-8?B?blU5a2VrVktuaVF3Ry9UcHFrTXRiL25McmFGOGdrajN2cUNwL3JuZ003T2Ft?=
 =?utf-8?Q?PDLfrV17fBo4pdhyr8TRy0WBIVryGYeBKA3lRkJ?=
X-OriginatorOrg: sct-15-20-7719-19-msonline-outlook-3b3e0.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3967892e-2eac-4368-0b79-08dd5b17b6a8
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB1009.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 12:25:56.8638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB2579


On 3/4/25 1:20 PM, Mark Brown wrote:
> On Tue, Mar 04, 2025 at 10:14:14AM +0100, Maud Spierings wrote:
>> On 3/4/25 9:35 AM, Longbin Li wrote:
>>> Add support for SG2044 SPI NOR controller in Sophgo SoC.
>>>
>>> Signed-off-by: Longbin Li<looong.bin@gmail.com>
>>> ---
>>>    drivers/spi/Kconfig          |   9 +
>>>    drivers/spi/Makefile         |   1 +
> 
> Please delete unneeded context from mails when replying.  Doing this
> makes it much easier to find your reply in the message, helping ensure
> it won't be missed by people scrolling through the irrelevant quoted
> material.

Noted, terribly sorry.

Kind regards,
Maud


