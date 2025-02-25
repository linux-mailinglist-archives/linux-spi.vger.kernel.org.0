Return-Path: <linux-spi+bounces-6903-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2F3A43203
	for <lists+linux-spi@lfdr.de>; Tue, 25 Feb 2025 01:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC17316E947
	for <lists+linux-spi@lfdr.de>; Tue, 25 Feb 2025 00:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37D51C27;
	Tue, 25 Feb 2025 00:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="t66Sjj5f"
X-Original-To: linux-spi@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011024.outbound.protection.outlook.com [52.103.68.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A86E4C6E;
	Tue, 25 Feb 2025 00:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740444256; cv=fail; b=lJ9VbcgNfcU/F3sT5AJHTwz7v2JGcyVNJnynIlAxZ3E+kt8sqPfeS5uF3N0ZnXXdi6nb3NAJDq5uQA7ohrUJ7rcvpnYLpwsFiTwTvdtBGh5ErveKUi0iuDwmebuRMm0j16RAZEVpcDZMLcqbb9ALfuU6reEuEJBRemDkM8qt+lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740444256; c=relaxed/simple;
	bh=CPFCF0CqcBeGEbB2WKnH7H5klIgzwwFIx9YIMRG7qpA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AkBnVo+pHVvEqya6/LR9SVguAdtWvgFQdX8fXfvn80z2KDpMK+IKJXbgjqe8cHV+jrzd4DD0OX3bbhNyYt4ukBe2fa/1dGA5PBLstfQAMg3QaP1PrjOZacjTHCbAzZGyBCLgYXc4EnOBG2wvNuxnG6MsRKs7gPbqpwmsLVvhgH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=t66Sjj5f; arc=fail smtp.client-ip=52.103.68.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8EEn5GnqrXp6d/MmQawgEAYiO0TzyrgOmMxmVem5iUP34VAOmLKj8ld4j4LFQOujNsPgiG0/Wf8AGj4Wd0Ft9E/Fq9JjYfw+dkEGzCc3VwT/1FhMHXpmib+mlR2DyXuRpD1jBfKaWtD0lHRaq6gjbm15KyQDsuYXeWldZ8pHO/3CeBzLVc+rFNG7zLDrV/7rQM6AhdLBArcZdqr9PmeSpZFQPl7GjTJTjdlk+5Mx0JtyQBSoQgOzZXuh3v/15uV6jBypWG9KZi9LLKzvnHUOg0drtyvSCOZWX760q+mXGCtsSWdf6MuV+5q3OmY2kBahjboFezwvkpHlqGbdB4BKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzuEI/28QrV/m3ZzYDpzeECMS/VA9nlI/FEe5XNWt2k=;
 b=EyQXJoSjJEQdAGQKKllMN+oLoY5GpgS2rf21e/Wo5hfcwn0/Q2KHYHMYTpP3Et8Wc2annDx51kYnDv5oNNNh8aCvTVZe+4FoXuhRRmqCVfnZv140YLRA7q1/HUDLLzhS7eU+2qnTCqqd2aeiPNV6JUpT4aNh9NDYsnF0FeswL76wvL2BdlOzu1U3iM3gCtfvPjIP9R+RYy028SzAyp84Ap6pae213MDMSywfppgm8oxiy8YM7CclE7Jz6oT8Xlra3JdLYvu1TBt3f5pC2X2k2MKsKk4LOA7V68bVfvfnBb4KAtz+IQ2OVSpqT9C2682Y5fE7OsYCyCWQyzyEF0O92g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzuEI/28QrV/m3ZzYDpzeECMS/VA9nlI/FEe5XNWt2k=;
 b=t66Sjj5fkEQoMo2ZCXqj7rZ3Wk50UMjLE2JVTgwGVukyrCBcEkkHuyGt26pl+EJ7Z6/yRktqojBV6ZQ1Yl+ypRwLaWqY7AF3sDzkGR8BRwJvtPsv5Nil+40VKjJgkB3kC0tBDtaofP6jLFSDeUtOmq1lo37KKUgpSwyruvHiwKWX3ySYI5VwWxemeFtS4BJpsbwhnGsygDrdCNWU1TjwZZSEDw6qBhOtMEoWakzpApRiEy3zkBRIgeqYM3T15l288t46e/IcrDL6UDR4bQ2LoIJlE3lYgOx6OSkboHSQvXacrLYO3LYbWpjghGHVpd3N0ponNiv5R8HLtEJKCH/BEQ==
Received: from MAZPR01MB9162.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:10a::5)
 by PN3PR01MB6628.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:88::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 00:44:08 +0000
Received: from MAZPR01MB9162.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::207c:c76a:271:28b]) by MAZPR01MB9162.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::207c:c76a:271:28b%5]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 00:44:08 +0000
Message-ID:
 <MAZPR01MB9162FA24821C3E02472CF028FEC32@MAZPR01MB9162.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 25 Feb 2025 08:44:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] riscv: dts: sophgo: add Sophgo SPI NOR controller
 driver
To: Inochi Amaoto <inochiama@gmail.com>, Longbin Li <looong.bin@gmail.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>
References: <20250224101213.26003-1-looong.bin@gmail.com>
 <20250224101213.26003-4-looong.bin@gmail.com>
 <PN0PR01MB91662EB902D8B337A0526458FEC32@PN0PR01MB9166.INDPRD01.PROD.OUTLOOK.COM>
 <nni37727545uwmq5uizihptcyq435wopjurdjcqufsfvfq3lc3@aq4zpb2l3nw7>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <nni37727545uwmq5uizihptcyq435wopjurdjcqufsfvfq3lc3@aq4zpb2l3nw7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0122.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::8) To MAZPR01MB9162.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:10a::5)
X-Microsoft-Original-Message-ID:
 <d168eeb8-0075-46a0-af1a-f3dc11d7a1a3@outlook.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAZPR01MB9162:EE_|PN3PR01MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: b5615474-86fa-45d5-d732-08dd5535831e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|15080799006|7092599003|461199028|8060799006|6090799003|19110799003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bkIwbjZBVDl4Y1pZM0cwc0pIVk5lVXJDejVHTHI2WUpicGl6NjFkOHVwK2FJ?=
 =?utf-8?B?c3o1OTRJTThvZnhkSnN2VWEwL3JETDRKcTQyY0pSQWZVbFMwU1BlQm9jd21O?=
 =?utf-8?B?NFZoZXAycVhoRXNJSjFha1krVmZHOFgzUVRsSzVpdGF5Q0NqU1MwNmFVL2JW?=
 =?utf-8?B?ZWMwUUZWdk9FS25KS2dXTE5pd0tYZi9JZmd1dmhacThpV0d5V1RUM3p4TWZR?=
 =?utf-8?B?NkRhN0hReUttdm9BeEU1VUF4bjI2N09xS2VWc09nZmZtaUtoUTZvNmU2Lzhy?=
 =?utf-8?B?TE9FdU9NcHBLa1dlL0FtakJOaW93ZzQwYkVmeWRlMWVjbW9sYjVRT3l0OCtF?=
 =?utf-8?B?SVJZZFFhN2U4NFJya25GejRGSldzdzdZdEVoOVFYdjQyZ1k4ZTFBUnlKdE1L?=
 =?utf-8?B?ZzNKODJiUGJWenF4Z2VzeUZPK1RUbnIyWm9nM1ZWeXUrdFUza0NLaU5yR0Mv?=
 =?utf-8?B?Z1BmQkp4cXVBVlNRekp6T2hqVGJrYmxVZHhjZHNDQVdzM2V2NUhZdktWUUxn?=
 =?utf-8?B?Zy93aHoyVkVsWlZqSFgvVnNCSEhYeU1mK3MwekhIbHMwSm44Njl6RUUvOWd5?=
 =?utf-8?B?NVhFTC9UTkY0R3Q4dlQ1U1lSZENObXN5RktvUHJ4QUZnWVJSVjFIUHl3bDkv?=
 =?utf-8?B?K0dnUnMyS21sT2c5b2lybHJTS3lmZEpzYUJkK3NvVHU4TDNwNGE5a09aSkZq?=
 =?utf-8?B?aU9KYldiM0psbHNYTDhKSDRYNW1JQ3l0clJ5MFVNc0hCbUNhcVkrNCsrenc0?=
 =?utf-8?B?NDNrLzNrYXJUUWxWR1RWUFF2QWNtbFRiZG1SK1l6OUtLWUxSRDdUVTBjZFMw?=
 =?utf-8?B?VCsrV09jVTJJeW5WeWpNdTJzbng4NGhtOUpWQ3RDM2xDeFowdGh6ak4yaWI5?=
 =?utf-8?B?MlYzNnpFUWpHUFM0L1JERGdPdWpxTTdyYmNUeW0zK3VXbEdneitTTWcyTjBO?=
 =?utf-8?B?Tll4c3l3U3VzRVpXQ3ZqYWNNdll4Mk0wUU1hMHdlV3FjMTZCc2VDODFnQ3hq?=
 =?utf-8?B?VXovMWIra1lIdnFORWJyUVpOSGp5OHhzbEVZdWwxNjMwVjhRNmFTL0MvTmY5?=
 =?utf-8?B?ajVWemhJWWF3SUYwUStqWEFQRDVNR0NRcnZhOWxXTEdrdFVUMk51d0djb3I0?=
 =?utf-8?B?YnAzY3REU1dXZGNzM3ZNVFZJa1ZKemttbCs0STlGcnNhWjFQY1VWMTRzRnlN?=
 =?utf-8?B?SXY2OFhWTWNxbEk5YzRNNnBneE9MTmRYMXRaUGduWEUwcXNVMDdZc0pmc3VW?=
 =?utf-8?B?UXM0V1lMTi9uekQzWnNNYWxZOXhERWZ3ZFlhUHh0SC82ZEFjWGNPTzlFUG5k?=
 =?utf-8?B?OVBCQ1VZYzFIR0p3NEIwMCtxSGFyZVE1RTl2a0p4Ty82NzhWaHFkUENvUUJK?=
 =?utf-8?B?TGpCVE9kSlVOOWpZU0RnSmhBanNUaHBOOEZwcDJsa1hobXhzSXdBOTk0WUNm?=
 =?utf-8?B?dStJMjdOOWNjZUMxTmJCbERVOGVRRlhlM3VHNDNtb0xZVnQrS3JXQVppbVhD?=
 =?utf-8?Q?+zfGKw=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0VwUlFIdHo1MGZ4VGd2K25xR1ZXNytWVkhOdFl1elpIdTZWUnl0TWVIdmkv?=
 =?utf-8?B?bFVPUlBTZkF1OU8wRmFCZFVRdXd6djVIZ2Z1NllIMnNDUkVZdUM1dkt5TjRh?=
 =?utf-8?B?TUl1WmV2ZjMxWTNRMXAvWU92RWo5NGtHRUcwU3VIUlFrVDBJVnJQRzdIMXh4?=
 =?utf-8?B?UFdoUGRrcHRwdmNCV2RTY1pzQ1dxOElaK3NQSGVPaFhBT2RwSk4yaGdzVG5N?=
 =?utf-8?B?c1ZtMGlkV3ArNzBGUFM5ZEFUQXhzd25iM1hDdEd2ems2ZzFhWGh0U2xsMmFE?=
 =?utf-8?B?eVFjWXdCcFhwcjF3ZElsOE1tM0RLNG1iV0VSVmJ0a0dwTG5pRFI0OE9HN1ho?=
 =?utf-8?B?ZFBHcjl1Skw0OFNGd2dISFVoZ3ZCeEdwWHJ5b2V0Wk8vUHhPMVBiWDJhZEdF?=
 =?utf-8?B?eDl5QWhFZ1lOd0hSZ3VqNk40YWErTjllUk1JUE9vTjlNRG4rdG5oZzNQNERC?=
 =?utf-8?B?a2tzM1lUa3d5OFQ5SSsyRjh2bGZQdHlacmQ5ZjFaNGF1TDJsQXQvNy9RR0lR?=
 =?utf-8?B?MTJoNlJGRm9RNEIwL1Y4Si9mdzNkRzRVSGJiZGlvVUNoWWlnMWs3cW5rL0Jy?=
 =?utf-8?B?WGI3WUFrbU1XSVNFMHNmcm5vQnBlU3kzdXYzZjRLcjhOYzAzbzdxQWpBK2J2?=
 =?utf-8?B?NkV6dDE3b2RqNlZMQmxQYksxZTMzaU5lYTlqTFFkWnNDM0FFZFNyZ0YxTjFD?=
 =?utf-8?B?NGxiTWxIUDNiSXZMaytSV1p2TUtLVE8wTUtiYU0yWVBQYklNQi9PMDRXN2tk?=
 =?utf-8?B?SDZ5SEZ2MjF5WDYzZkhJU1UvN1l3dFFwdHV2UDZhclFZcW9zTVpOdlpPMjZR?=
 =?utf-8?B?YXJXWjc0SkVhSGptc2xaQ1Jxa0dwOXlFb01sMWRpdTRtSkVnOTBDcVRyeGlB?=
 =?utf-8?B?YVhrVlJJbnhJTTllUTVlRXdQZG9POVNKWTFlQU9Gc1UyVDZacmYrVURySGd0?=
 =?utf-8?B?L3E1SFVlM3g4TEZHYUwzUE5oSUFtd09Jb3huMzJKU3VPTFBvUHNRTmJiV3Rr?=
 =?utf-8?B?ZUpMbVJUeVR5dHRxdnNYc0syUjFGSzk3ZktiL0NXWnhMNnVVMFluZmVrbmE1?=
 =?utf-8?B?UFl5STVoNnpDN3AyVEtSRm5QZGROOUhJeEIzZGYvKy85NnlZc1N2ZTI3U3VS?=
 =?utf-8?B?UW8rTWhtZWFRQXgzRXp3aVJHbjBjV2hmMmJJeXdlR0g2R2xvMVo5akxDT0to?=
 =?utf-8?B?cjlrUk5vN0hGTi80N3JDYU9FWk40cnR3eFo0eFc5eVhFaHh6Skg4bU8vTWpH?=
 =?utf-8?B?cUVKVXJMUWJLYnpvMzI5L0JaUWwrUm00M21ocFIxQnlNNXcwV0RiRWRiZHVh?=
 =?utf-8?B?MUZTQ2hWaTZDSmFhWFR2aHRkeCtINXIrQno1R3UweUxzaldJSG4xYXVvZlY3?=
 =?utf-8?B?ZktjRCtnTllPdUtlQ1VieUEza3FzV3A5Y0xieWExeEVkaHNSMXdyL0NDYUVi?=
 =?utf-8?B?Nm5sU1pMcTdsK1hTby9Ka013cVZ6QzJaeEZpcUpMNzF1U0lWNXdCbmJjQ1VU?=
 =?utf-8?B?YkhsTy9XbmpiTFdWaVQ1ZzViQ1N3bjN1bXBTYmpMd3hqMjhwOS9sS3NrZm5j?=
 =?utf-8?B?WHMrWEJLUVJqYVd1bzltdzQwZFlPaDlsWEU2SklLc3VqeFhRTE95aXVnQ0VD?=
 =?utf-8?B?S21QSStUeFRpS3AraE5qWWNaaWMvQ2VWUlVHbVZNOGJwWUxnNGxoZHFhWnhG?=
 =?utf-8?B?YUVkT1FmV0prVXZ2S3RDSDhJaEFoUjloRkhScms5d0VCcWdjUUd2eVd3aTF2?=
 =?utf-8?Q?W5up+qz9elDxYN7ip/QPVhiUbq17RvUFCn1Idb8?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5615474-86fa-45d5-d732-08dd5535831e
X-MS-Exchange-CrossTenant-AuthSource: MAZPR01MB9162.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 00:44:08.3124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6628


On 2025/2/25 8:38, Inochi Amaoto wrote:
> On Tue, Feb 25, 2025 at 08:23:36AM +0800, Chen Wang wrote:
>> On 2025/2/24 18:12, Longbin Li wrote:
>>> Add SPI NOR device node for Sophgo.
>>>
>>> Signed-off-by: Longbin Li <looong.bin@gmail.com>
>>> ---
>>>    .../boot/dts/sophgo/sg2044-sophgo-sd3-10.dts  | 18 ++++++++++++++
>>>    arch/riscv/boot/dts/sophgo/sg2044.dtsi        | 24 +++++++++++++++++++
>>>    2 files changed, 42 insertions(+)
>>>
>>> diff --git a/arch/riscv/boot/dts/sophgo/sg2044-sophgo-sd3-10.dts b/arch/riscv/boot/dts/sophgo/sg2044-sophgo-sd3-10.dts
>>> index c50e61a50013..9c634920f37e 100644
>>> --- a/arch/riscv/boot/dts/sophgo/sg2044-sophgo-sd3-10.dts
>>> +++ b/arch/riscv/boot/dts/sophgo/sg2044-sophgo-sd3-10.dts
>>> @@ -80,6 +80,24 @@ &sd {
>>>    	status = "okay";
>>>    };
>>>
>>> +&spifmc0 {
>>> +	status = "okay";
>>> +
>>> +	flash@0 {
>>> +		compatible = "jedec,spi-nor";
>>> +		reg = <0>;
>>> +	};
>>> +};
>>> +
>>> +&spifmc1 {
>>> +	status = "okay";
>>> +
>>> +	flash@0 {
>>> +		compatible = "jedec,spi-nor";
>>> +		reg = <0>;
>>> +	};
>>> +};
>>> +
>>>    &uart1 {
>>>    	status = "okay";
>>>    };
>> What is your baseline? I can't see "sg2044-sophgo-sd3-10.dts " on the latest
>> mainline yet.
>>
> It seems like he forgot to remove this patch as the baseline is not
> submitted.
>
>> BTW,  the name "sg2044-sophgo-sd3-10" seems a bit redundant. Wouldn't
>> "sg2044-sd3-10" be better?
>>
> I do not think so. we want <soc-vendor-board> format. In this format.
> sophgo is a must.

All these dts* files are under "sophgo" folder, that's why I think 
"sophgo" is redundant for file name.

Anyway, if you do WANT the format, I won't object strongly.

>
> Regards,
> Inochi

