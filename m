Return-Path: <linux-spi+bounces-9581-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4C2B2F416
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 11:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2DBA1BC1C29
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 09:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695FA2D9ED8;
	Thu, 21 Aug 2025 09:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="SYfsaFuW"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022106.outbound.protection.outlook.com [52.101.126.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3165023E35B;
	Thu, 21 Aug 2025 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769026; cv=fail; b=mqbOdOgp26TnqTLNQzR7auQy3iwQ/B2DP8VjtWvJhH79/DrnjHmMZiIDHLWp8ATFDSi1PBXnfJxQFKfatf68ydaQ/TKpsAXqO9DhYXCRnZSwbzaSbenKOlwOFZtmXN/ariSMk9R/QPpVwXdg2bqz7tzUdovcTC5DkQS/biOFh3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769026; c=relaxed/simple;
	bh=u47lR9JHXaR+wORtUekckiCe9aFPCTSAa9mV5HGNhdU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ebqYl3lN7phET9cysJjWz4swCl2EworJzCqwkJCOzJ0tHpT+HBLoHsFmVdt5i7WH1770g8rcQp0Zif/roWIAnozBCKEGZ4CD9I/cdtE6zaiCWc8Jm261V73hVMtlkpsXnYwcRWR1AuauMgQ1j2t0jmdGSXb/tDObwD69f0R6gLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=SYfsaFuW; arc=fail smtp.client-ip=52.101.126.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdp/Wmi5tkA4g1pnWUXxLF6o4GAGPUG2Y4nQV/DsdP39FATzDZAyXib0yz1KWLaDcNpjgjvFksDz2j08M3CTC9A3EOVIlAkNJLkGOZuMvEaxfdounCI8t34O8tJRi0s9rULL3QWCyLY433nhxE24BvqSQlGyVAB7TLttc4YgAKLentgoPWUAi1cqBV9B62SoGy8/GtnOo3ZQ+cv1k2Zz4l5pyhj7k/gQdlahOUnUOksniDyNYKV5n+usL/wAZ9o0YZGAsOGllPl802ebAAkiWLGnPu0CWDRV7bI4gfNAXaG9zNVSstbYdZrDT6/Zo7DwNQa6nfPc0et4QJN8/wXFKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KokQDpuMmN2bj+IekVtNvhlelQ+02ImEgeEK/lhv0TE=;
 b=CzkrdbpByqVQVrnRjiq4PXD7RWB+PMeY5yOdkx/L2eXWEw/1hr1/u1HLPXbQL8ucwd8OCXOBEeVUcbw5VpKcNH1+PyjF9wEHDo0jpDwkN0fNCTvO3JKKJI7tFr1JioHB2lKvDzk5qqwAAIRWkDkYNjBbDpW78jM1uxt43iE+0bFcKOffNGJKVuCnPupS/8cSBXIjhsfafRWqjzAJZwoUOqbvz8sayUYEEfv6g7yULrndxsSMFOycUXryAq+tcxmFnY0R1Pj4haSqZui1hVRbL5+GIPSSMdQFfdCECHSNwRbemGBXem3imu/VeMJ6GmIoz7MgRBSOdC8mHwf978d7Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KokQDpuMmN2bj+IekVtNvhlelQ+02ImEgeEK/lhv0TE=;
 b=SYfsaFuWyLvxytAm10UVMUhmmk57pwrSaUbb9gWmpLvhTKxQm0DHcUJPVSLyVgRCz6RpwQCqpvWnOYrUhhjGHt6MiYHGKJZFhv1DkeHfr4us7lGyJ/IfqcoiSTbU6T6kWGonkVugH9cHPYqZOgnlMKmQxhzNUOk39hQlR/kmE4m4KbgO1876Aec4nNORwutQ63igl0CoJeDHWLwXX2xrrgPm3Iss/7MvSnHyJiPOOK0mnPSdnue8n/oafmehqZA2L8aLMxqR/jV7bb7VeBEoubahK/N9kEp3hUxeASE0mtm51JP7STIxRPqRTG+dQVtapAh7N9/w4+KrEspb6+J3Cw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by PUZPR03MB7235.apcprd03.prod.outlook.com (2603:1096:301:11a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Thu, 21 Aug
 2025 09:36:58 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%4]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 09:36:57 +0000
Message-ID: <6ab6359a-a20a-49c3-9179-6c9571ca05d0@amlogic.com>
Date: Thu, 21 Aug 2025 17:36:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] spi: dt-bindings: add doc for Amlogic A113L2 SFC
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liang Yang <liang.yang@amlogic.com>,
 Feng Chen <feng.chen@amlogic.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
References: <20250821-spifc-v2-0-b119f64b5c09@amlogic.com>
 <20250821-spifc-v2-1-b119f64b5c09@amlogic.com>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <20250821-spifc-v2-1-b119f64b5c09@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0031.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::7)
 To TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|PUZPR03MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: 49514dda-2c7d-4491-f70a-08dde09645a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Unovdk0xaG5sc0l2T0t5cmFuN0o3VDR3WitpRVgxODBWMWNBTk1lV21TbnJS?=
 =?utf-8?B?ZjJ4enlZNEN5aU45aDNlZUtHcFFhb2ZhODc4dS9kcEZoUVdSQlJZZGpXd2tQ?=
 =?utf-8?B?anFGck1mT0FpWExYWDlab1cwSkVkeUJ3RUlwRnZCQ0xET2c5aGVkM1ZNZ2Y0?=
 =?utf-8?B?Y29CVE1RQmx6dW9ydEJwTEJ0a1IzaDdicy9JUlI1N2IxNXJHMVQrMnRLZFo4?=
 =?utf-8?B?MlY4K0l3SHp2eGRMeXFUdFhMaVdlTVZVbGwvQWtlZ1Y5TEJ6SDVNME5xWjIr?=
 =?utf-8?B?YTNnKy8wK0t1UHpWUnNTTnc2N0poclFtZ0pSU1BLRFo5MFE2T0JjQnNSR2tT?=
 =?utf-8?B?Um40Y2NvYmZITXhwSnFGSyt0ZHYwSEtwZDc3ZzRwT2hSMkxDMFdhanBQRnd4?=
 =?utf-8?B?SzVKZnZ6bUNYL3piUktBbk5JckUrN2JhazhqTDFUQURadmR4d00xekJZUWFR?=
 =?utf-8?B?QmRYVzl1TXF1RDArNEc4V2dNZ2o5Si9JaStqNEQxcENkbmZ6REdTeTBXSERK?=
 =?utf-8?B?ZkxsRUt3bmxGY1dtMjNmZ3huZlppUklOc3JjZi9WZXhMQnM1MGs4a3RJMEhJ?=
 =?utf-8?B?VDU3TWI2cWZoQmhObk83Wjc0ZnVyVmJ2WW9aRTFBbmZOMHo1SUtiQjV1NmN0?=
 =?utf-8?B?TG16cm4xejdrR0MzNk9yS05rRXp6c2w0RUNtNzJQeWdqVTB4aHd2b0IvdFZ6?=
 =?utf-8?B?bEpTSndLTW13NVJ4bHd2MFp6SEw2T2M0MWVsMzI3S1drQ3JWUFZoYWQ4Smhv?=
 =?utf-8?B?dElRYmhtby9hdGdyK0N1dU02dHBMc2RLZUxVa3pob0FWK1pMN1BsWjdiSHBV?=
 =?utf-8?B?cSs1dUNZZHJvV1RDYjllRnhPTXZkdHlUL0FheTVFRG1OMjZmV2FvVXNPV3R1?=
 =?utf-8?B?T1E5c1VFTnhma3AybWU5TU9WSjNQRkhwQTdlRjFMRkd5RUptWjEzcGw1Nzcz?=
 =?utf-8?B?WUtpMytrbzhzNFJaQythS0lpcHNqbGZKSjU0OEw2ejNRdkVJSnJibE5hTi9n?=
 =?utf-8?B?K0QvMGNGcHF2OWZsQ1E0Y0h3RGpoNnJSL0RDZkhmTEltR3hZK3lxTTdaZVNR?=
 =?utf-8?B?Zy8zeFVSZklVY3c1aFkrNHN5dlg1dENDRmszZko5Nlc0UGNxZTJ0NUgwR0ti?=
 =?utf-8?B?ajU1Y05MemFzWmZoaUE5bUE1cHdWUy9NTExsbmZSYnUzM3JxVTAyQ0VsTk91?=
 =?utf-8?B?S1duUFZtbzFZMXhXbFpZQzREcEE1ME1DMkxlS1pYZHk5N3NNUUxLbVM0c0VL?=
 =?utf-8?B?dVJMOVd0R0E4NVloUTllYzJYQ05uT094YTdVQkExVWEyVGpNQzBBcjJvYmJn?=
 =?utf-8?B?QXUyaGUwL1IxZVN0WjFBbzAyUkY1M0FTUEEvemlZaTgzVGY2T2g0Q2RwV2V6?=
 =?utf-8?B?SWd5cDZERVU5V0R5dGo2UEl5MmpKNlR1dWhZQ25jWkhhUTVXVzVXSDJsMlo0?=
 =?utf-8?B?dG1yOU5Kb2hXdy8zVlI2TUowaTFrNXNBRXR2NEJnSmg1YzhSNDlkR1pkc0NJ?=
 =?utf-8?B?ZThCU0o1bVI1UlIxZWI3bmp3MW1lVjY0cUE2cHlqT3h0Q2tDc3NrTW9nMHhI?=
 =?utf-8?B?UERnRXZvbjVjbmxMNXZjUjdidTNycEEvT28rYWpQNjhPK1VCaWs4UmN5Nm5K?=
 =?utf-8?B?dkl4UVhMeWNOdjBSTFNQV0EzUVlaTUY1bTZSeHlMZTQ3blc3aEx6dzFDaWEy?=
 =?utf-8?B?VVNsTHBPS2hJM1JnVXB5b3dabVhMWkNLYVlVVlRGOXhOaWFQQm5HVnJ6WTlT?=
 =?utf-8?B?RDFNbDlPSXFLUVJGRklCVEF2SWt1MzBsN2xLenRYaDl2bEp6YmtSRXVlVmpy?=
 =?utf-8?Q?8plgep3I3RfcPJpzYHs9Kd+nT6s0L3C8W3EgA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3NpZjl6THZ2aGdIVUtyT0ZtMWNJZFJUUUdPODVHY2RGRnVzWnRXNkpXTmI0?=
 =?utf-8?B?UlpxdjVxZG94WTVmakZNL05LR1RyUU81blpuL1pJYkxnNVBWc2Z3UmJibGxu?=
 =?utf-8?B?U0pLdEpxaUdnTGQ4ZmxnSlBHUngrOTRLNHpXSWtBWTZSNlByejF1YUp1MW1z?=
 =?utf-8?B?UDdMNUJ2cVRUWGRGVisxS2pidWc1dkFHZUoyeHhuR1poTjlBY3pKRFE0MWRx?=
 =?utf-8?B?SklSSkdEMk94RVVFRlJrZkovWTNXTnhhZ2RvOEZTT1ZqalJXWFYydFp6a2Vu?=
 =?utf-8?B?dnpUVXdzTEZHdkc3QlhmckQ5VUtRRVVEN0JCUmNSczdiNy9tUjdqRHRMenk4?=
 =?utf-8?B?b2JVQ0dMMTNza2d1Y2R1cVdDZEw1WUxXL1kvSmcrTXVVUXIvZC9tQjR3VHpq?=
 =?utf-8?B?SXhoRTVQM0RGTUVaYkowdWdYeXZSY0hFMDRRdWRvMjdNUzAyRmhGdDRYMDhM?=
 =?utf-8?B?ek9rb2l5ODJLc3REN3RMVkJOeDdJanVCQ0NDOUFsYlNzOTRYNjVlMjYzblF2?=
 =?utf-8?B?d0tBd1FmQUU2eDhrdytyd0xCU2tTK3lKQ3UxaUF0aW5mMDE5SC9QRkVCcTBy?=
 =?utf-8?B?THBCZzJIQmlqT3l6VzFHT1JrOXlUUHZnd1pGbTVoRmJoT2hWWlRjMHd5Wldx?=
 =?utf-8?B?eEdUU1psV1puT2lUSXFNY05ScnZmSHpxT3FOejlhTFZtc0hHY0MvYk5rTmE4?=
 =?utf-8?B?NXUrTSszSHRLaUJlaXNVRVAyVlZaOWo1TEJkRi84R0M2RWNHdGhYd0FaYmNG?=
 =?utf-8?B?YVVrTVFCNGJxd2VmcWVlZmYvSmZVaDlmZ2hheUVlUFBGalpEWHJITlBaNWJv?=
 =?utf-8?B?L3RtZGVRWXZNV0xGWnkwSHVtckp5bzJWdFA2dUxGcHU0MnZIUWdkZ2NHa1R0?=
 =?utf-8?B?dHJCUzVmdmxHQU5BNktHQU9udXFOUlI3ZnZza00rKzZENWRaSzEzZGxPS2pX?=
 =?utf-8?B?cU9LRktEKzZuUU9neFgrUkNSMnBGbTdod0FqSkRQTTR0OWljWC9TaGVKT0pB?=
 =?utf-8?B?NnVUUUZmcEJSL0FaTXdrQmlrdWNKN2R2Vk5ZSzhpTERVWG81NllOSkQzWWVm?=
 =?utf-8?B?dDhIb3FRM0tvbU1vTWVJMjRkbFVkVThyRTlkbCtCUjJPdDdnUDc2cVhQRk5k?=
 =?utf-8?B?OUVweFZrNENOcWpNZnNmbHM5dnVJeTA2andQQkNEK3FvMCthaSs4NTkyeWwr?=
 =?utf-8?B?YjFnS0RxMlFZV2c1WVdPZWRiWFVHOHk2dDlMaW9DZFBoMkZRV1NvM1QyTUg4?=
 =?utf-8?B?MGVZOGNaSGdDMWNlcVJwcFgwUDd6T0hMS05WY1JrYkQzTGtockk2bEVrZGo3?=
 =?utf-8?B?SlNjeTRMV1RMSTV6TE1lOFU4WEVYbEFPSWNaSllwbXk5dUlCVG1UV3RtSE5Y?=
 =?utf-8?B?czk0NG1LVGJTb3B0enlxdEJBK1JJUXVkMGdEUkE1WFlmWmhKR21vTTBRWUNi?=
 =?utf-8?B?MGNjdnpZV0R2WitYRjdMSHBNSS9JSWs2L2NlajNIUDRxT0NibHNRVFBMbmxh?=
 =?utf-8?B?T09VcUtGaWduV3lxb3JqbXZhTSs0eGt2OGYxWFBJcVdVV3drNWZxdjVva3Vl?=
 =?utf-8?B?RXIxTTZ6UDZPbWdLM3RFMlFVRkF6WGswcTN1S2pKdUJFeU1LYnJJVVZ0NjNF?=
 =?utf-8?B?dFZmdkN4VCtJTk5xVTVoRXpEa0svdG9QSTlHTFNUdkFXdldieGF5aWk0aXY2?=
 =?utf-8?B?L1pMM1J1YTJWalFrZUpuWEFBRW5NY2RSMjU1am10azdZVUdJdU5TQlpxenVK?=
 =?utf-8?B?NUd2V2dIUk12SWVONEM2Q08rZUxHWWgrdXhDMGtrL01WUVlMQmhvMTk5Y0xS?=
 =?utf-8?B?NDJJeSt4VGFyWnBWa1RiZnc4TUI4elhQb29pQ2R1M3RFOFhtdnM2aDA2cmdp?=
 =?utf-8?B?THlHcmE0U1ZpQ1RPOHBxYzM3MkdTUG8zekFIUEx6NzU5cnlsMUFaNGN0MGJu?=
 =?utf-8?B?bmdhbVR3bE1lNVFoVTZMRmN4a2tSeS9LeFdZOVdCZ25sZDJ6M0VOZWQrQ1JS?=
 =?utf-8?B?a3pSWWpzZDVQdW9zeExDYmRUNFp4cnMyZ2pqdEU2eUl3K0JQOVNVakE4ekRi?=
 =?utf-8?B?L0hrM0JQRjNqakc0SUtucWlSMDFMdHVzK2pocEFHRVJsa0VSUW8xalFMcHcr?=
 =?utf-8?B?NEVOK2FWSDNaQ09ZbHJ4ZFNwcUd4SFM2S09CUHFJazdLVzNMRVNmSnhhSldH?=
 =?utf-8?B?dnc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49514dda-2c7d-4491-f70a-08dde09645a1
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 09:36:57.7840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FT+r7sCZIbt5H6rmlPRND9U3KpWFSWmkyyWIWxlz/4mLCFaoGirTmc/QPgc3Gm004ylJRu9S7DDh+MLHAkTHe/YOTKdEeWnQEUOPnQkmD7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7235



On 2025/8/21 13:17, Xianwei Zhao via B4 Relay wrote:
> [ EXTERNAL EMAIL ]
> 
> From: Feng Chen <feng.chen@amlogic.com>
> 
> Add bindings for Amlogic A113L2 SPI Flash Controller.
> 

Here I misunderstood and missed the modification of Subject.I mistakenly 
deleted the description.
I'll send the next version right away to solve these problems.

> Signed-off-by: Feng Chen <feng.chen@amlogic.com>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   .../devicetree/bindings/spi/amlogic,a4-spifc.yaml  | 82 ++++++++++++++++++++++
>   1 file changed, 82 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/amlogic,a4-spifc.yaml b/Documentation/devicetree/bindings/spi/amlogic,a4-spifc.yaml
> new file mode 100644
> index 000000000000..80a89408a832
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/amlogic,a4-spifc.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2025 Amlogic, Inc. All rights reserved
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/amlogic,a4-spifc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SPI flash controller for Amlogic ARM SoCs
> +
> +maintainers:
> +  - Liang Yang <liang.yang@amlogic.com>
> +  - Feng Chen <feng.chen@amlogic.com>
> +  - Xianwei Zhao <xianwei.zhao@amlogic.com>
> +
> +description:
> +  The Amlogic SPI flash controller is an extended version of the Amlogic NAND
> +  flash controller. It supports SPI Nor Flash and SPI NAND Flash(where the Host
> +  ECC HW engine could be enabled).
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: amlogic,a4-spifc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: clock apb gate
> +      - description: clock used for the controller
> +
> +  clock-names:
> +    items:
> +      - const: gate
> +      - const: core
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  amlogic,rx-adj:
> +    description:
> +      Adjust sample timing for RX, Sampling time move later by 1 bus clock.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2, 3]
> +    default: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    sfc0: spi@fe08d000 {
> +      compatible = "amlogic,a4-spifc";
> +      reg = <0xfe08d000 0x800>;
> +      clocks = <&clkc_periphs 31>,
> +               <&clkc_periphs 102>;
> +      clock-names = "gate", "core";
> +
> +      pinctrl-0 = <&spiflash_default>;
> +      pinctrl-names = "default";
> +
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      flash@0 {
> +          compatible = "spi-nand";
> +          reg = <0>;
> +          #address-cells = <1>;
> +          #size-cells = <1>;
> +          nand-ecc-engine = <&sfc0>;
> +          nand-ecc-strength = <8>;
> +          nand-ecc-step-size = <512>;
> +      };
> +    };
> 
> --
> 2.37.1
> 
> 

