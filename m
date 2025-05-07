Return-Path: <linux-spi+bounces-7982-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3961AAAE59A
	for <lists+linux-spi@lfdr.de>; Wed,  7 May 2025 17:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22C5C1BA0C64
	for <lists+linux-spi@lfdr.de>; Wed,  7 May 2025 15:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E27928BA9F;
	Wed,  7 May 2025 15:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="beM/8Crv"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5602028B7DB;
	Wed,  7 May 2025 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746633121; cv=fail; b=OGGKEgYmvJEOEXtHvX18ZfHikKKTW87cAEq5VV4xUcr7Jg+NySEHtc3SpsdKBQYqI0kpG3MvlRCXeG09vTrocfFee74aEsbzFy63bV7xaPd8gGLcYNN7S3NklnhQqSFh0XLLITVgnKggghaoHTdV+GfYscoHQe4Tb8ryvLAB5fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746633121; c=relaxed/simple;
	bh=ZfxXWiVHu6s6QwAL4z1lXhEAEDiWYKyeGx4p1xPR1KM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WL5sX84LQdp9xr46yLGGQw0jE2Sg129rAw4RLyOyFR1lS+qyWN9oJmZxCzeI7p7EntBhyGzIY86gCPRhUOICsoeetR5PheueAh1hgWXjYLOtmau6kGkmiauVNyffgRJPopQJPdgtsTO2dd8HRWx0qyirCLjRrpywyGHuMqdiddA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=beM/8Crv; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PuzeEHo8Avm8FOAVkW5llBAo4EqZe98uScylqNkYGJ/NgDrupJoBF9Hd4C+wheJsWP8Gkv5lVk7dTDTJ/jc8kPVHMRHwJGfJG7FkwI9pEziMWSJuLXROZx6bM2go4LiRrQ6vUtH8cFzR5Wg/JrY/ZpsG+Ov7M1iyYM/ipDjaFncGN9vw1BnzW25K+jbHpJDp/V2O+6YPhZE4Op/ZOWBBymWOSUwN/2HiEIz327mqYvSG0yCprvu6NKXDt/OXPhIKYfKI+NdCXs5NFBOfMYxzhUs0aJH21bY77Perr4IKHPQimXmbc4j4w0sseCU7z5mv6hG7h25ZtqsvsLFycwkRKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jGhiD6+IeCur9NvOfz73+UpOoUq0MvxfqP0ldpRvYVo=;
 b=wVgWDL1VTZHraI1Z1UsQKJ4n0edo4j2QVrpv+3w3R1EiObIPtjJhhG6MsmVVUg8KgHCOr6SJs21LfHMBw52T2q7gRkQDphK9BPHGdgdVjrWOmyKcpK86EL+pC7yqovECIpr40y9IYDLhTCoSlMAz43k6weDRaBsk40OXapXe21RuyQhVtSsiG2KNkC+UJ65kQoCyfQFwlEV//Dx/MC+OxYi4v71iy2Gi/Y17FMB4hTYcoUAzXIXXnwU4ULHXZuKo4BGXPNnup9xCHiMESVEcUWU/mTofyaXMsb+bL713EAnQ4I9Fc/f4KEXxzjiCVZYEuq8A0rlV3nmbyORMxug2BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGhiD6+IeCur9NvOfz73+UpOoUq0MvxfqP0ldpRvYVo=;
 b=beM/8CrvaJnFMh6wf+REapTHC9/nViuzNjB6hruopDlk+jtHEmsG2iDljH8g2BsxTzHbNZbG7Wt4ya+AHfl2Q9jiQlc3SPc1GXUm2yMYg07yW7XFaPO0st3wfcbqVcjfdNNy/OEW114UDUdGHRZ451bTJqZLuuVpUvkdIhbvfqwFO/2GBIFI9ImRKrxaL/C/e2WrAhjFn4hbGneyHRO/6QPBAXOtmUyC6e/oc+jS8xXr6tYrORNvV7IFDOLD6M01PqyqS02DPFGHUSDTzoSKBkGVqMq7bWFK4Q9fsm5YY6GVldnQJ+wE3rxXfi7XR9gSfIblJZNztIVrLf/MonR9BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DS0PR12MB6487.namprd12.prod.outlook.com (2603:10b6:8:c4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 7 May
 2025 15:51:56 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 15:51:56 +0000
Message-ID: <2015e3f3-cab4-447c-93ac-23d9af14977b@nvidia.com>
Date: Wed, 7 May 2025 16:51:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: tegra114: Use value to check for invalid delays
To: webgeek1234@gmail.com, Laxman Dewangan <ldewangan@nvidia.com>,
 Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250506-spi-tegra114-fixup-v1-1-136dc2f732f3@gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250506-spi-tegra114-fixup-v1-1-136dc2f732f3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0203.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::17) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DS0PR12MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: aaf63f2f-85f9-4aac-5d68-08dd8d7f1857
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjFxNG9QSlUyb0txQ1RrdGhIOW5udjc2QmJvT09wMXdVQ3JTM2xZeVN3Mk1L?=
 =?utf-8?B?ekFENUljOG5PYVk4NW5kRVVnZ1IxRHNSQzhMRE5GaUpET0lESWRPQ016bFpR?=
 =?utf-8?B?aHRuOUpjb3E0SUdnYU5mYXBKc1hiYjlUZmcrUlVyM2VUd2tSWDU5anBIV3dQ?=
 =?utf-8?B?YVlia1pvaXJySkRka0Q4RUZuNmNCSVJBVW9oTjVETWVuZjR1NnZsUUZOeXhZ?=
 =?utf-8?B?NzNFcUVTc2k1OHlOdzZmdUpaN2xCbmdHZ0hicEhheFlDeTYvZFlxeFpqaHB5?=
 =?utf-8?B?TUtudXdFSmFEUFRGc0pSSi9vazJZSXpTbDhqYzJBYlgxS1RiMHlERWYxWTVa?=
 =?utf-8?B?YmpMbUh6VHUvL2c3ajRSZFhSTnBpbktsMFhDb3NWKzd0bTQ1RDFkNGZyMkhq?=
 =?utf-8?B?anU3Ym5NTWJVNlN1S1FvOTREUzRUU29FRk1VSnUrREZjdmxKcDMycTJrVTl0?=
 =?utf-8?B?NHVCbUxnTksxc0J0dTUxQXltRHRIL3dQUnpZdFllaWV0V3pqT0ltTnFWVHlh?=
 =?utf-8?B?Vk1BTjFXVSs4Y0NHVHpWU0poRmJLK2REL3NsTEdSUitjQk8rbkNGR3duSGUx?=
 =?utf-8?B?NllFWUQ2ekkwOWY5ZGlncDQyZ2xnNHRmbWc0cGEzemhPQUlyQkFFK3Z5ZXQr?=
 =?utf-8?B?VGtzM3RsNjl6SWU0RnRLNmJVMmFhMEhuM0NlQ1AyZG1Ga25Eclh0NFVORU4z?=
 =?utf-8?B?aUFHbzBTOW1rMmJvQ2owZmlxaEZWcWRIKzBNMHlTZ21yMTNPUVV3Z0Irei9E?=
 =?utf-8?B?cW8xYU02YWY2eHNLR1NRYWg0UFUwdFlPbExYVk9BVXM0d2lEcitURHlLeDJu?=
 =?utf-8?B?RklIUzdBTzVCL0JvbEhkV2dWTCtMTmEybEZRVGFIZzArQUdnOHZ0d1Jzc1lj?=
 =?utf-8?B?WDNmMVA2V2dsNGJHOVhkWEx3c2VyQVNlMkxRRm9BWkJTS21zYnFRNDlISDhZ?=
 =?utf-8?B?OHlxdXl0SmVOMEloRTJPUUJtekhmUHYza0lBWFdIOUpxTXJvU25sT2orZ1Ex?=
 =?utf-8?B?b2p1WWJaS1ArY1lKbWVXZmdlVkFya3lNZmFQYnBrZ2l1dndRNTd1d2hPcGJJ?=
 =?utf-8?B?dnpSd3BrYi93cnVxdHhKcENxSGJHalMyeGswaDNndm1DL0JIN2lpZmlBRGk1?=
 =?utf-8?B?Qms5cGtTc05KekplME1DaXNvTThxS2tZSHNMbHRZNDJPSm5NUVF3N1NWUkIy?=
 =?utf-8?B?WUlDczNhL29FMmwwWmdJTndhOGw5U1ZZeDVKRmVsUEZVNFdOcyszMHpWM1Vx?=
 =?utf-8?B?NGZBbDBVQkUvMDNYak02Q1c3NzNXaXVJemg2RFpwUit6aVBOeWtacnY3aWRW?=
 =?utf-8?B?N2xUY08reEJPRGU2ZUxlRm8xMGJubjU5R3Y0dCtiZkFtM0tvQkptRVhWZHhS?=
 =?utf-8?B?QUdXMktiSS8zUFVXMlpoS2c0K2lpODdFM0JtbmQzUmM5M05hRmpNTU5UbG5s?=
 =?utf-8?B?M3hJRHYzY3R5YkVYNHFmdkliYzNkQnlHdXl0NWpJeFllTk9MMzhzb3JNOFNo?=
 =?utf-8?B?UUwxc0lMNXd5Z1JZZm5NODd3WEpBTG9EVzlIV0RzSi9hSWFDWWw1Zy9KTzFB?=
 =?utf-8?B?UUZrRjBON2hPdElhOFdyWjFQbDloaXJ1SFU3K2dmbGxiZU9DbDk1akZmMGI4?=
 =?utf-8?B?REYydklvWE4vTG1sZDJPOU5oRk9XTnJYVXZnNDVuUEtaT3l4Ymc3RGhiVHl5?=
 =?utf-8?B?WTRMbUp3TmdDTjJFZEk3RjQxcFVjTDNJWmRQcUJYNUF4U1MzNSsrZEdVVUo0?=
 =?utf-8?B?TytoQ0llV0FYd2cwRkxxYnBzMS9EUmZVakhlUnU1Vys0OHl5cFRPZXVLU2pT?=
 =?utf-8?B?MVlpT0lrb29XbldrOW5BUGM3Smk5YWhOS1puTFFNYnZsTlNCbzRiM212NHln?=
 =?utf-8?B?dERUVjhEbE43UGRZUWxUZnlHZWF6MVJsL1FHeU5uTjV2NDNiajd1SjBwRVhT?=
 =?utf-8?Q?/JvXYpCZXz0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGp6Z3VFVFIyaTJrVkZlbThScjJtR2x4QTJkMzA1Y0pNRzh6RDZzQk8ySUZ3?=
 =?utf-8?B?ZDhxY2JSbXJHazl6Q0k4QW8rNjBqdlBKK21FaFlDcGlmWmx0ZjE5eVpjUVdW?=
 =?utf-8?B?YU1XVFJ2SDI0dTdqd0JxR3M3c2lRVm1OekNZN25wdENjRlBIcUJDd0xwZjlv?=
 =?utf-8?B?SkJpeS9EdHVCMTdYT3VLbXN0NWQ2ZE00L2Eralp6d1preWMraS8xV05DM0xv?=
 =?utf-8?B?Z1Y1L0VjSHdubGdhenlYelFhREM4SzQzYnFOTENGQlVSUlBBaHNmdFBudUdx?=
 =?utf-8?B?WThnanpFUVd0bjdLdE16MDVXTmVVV2psTXlXUWxoRVpTc2owQi81QmNIcDVt?=
 =?utf-8?B?K1BzRmtlZmdiN0w0cUhiL1FWbWk2dEREQ1BMOUcxTUp4OVJqc2o1OGJWUEVM?=
 =?utf-8?B?Mkhla2h4QnQyUms4ZEkyb2h3TGE0Mlk4bUpaWDByeTZiV1dSNkVpWEltTllH?=
 =?utf-8?B?UE51MkJ0WWNIYUJRMUZETmFOMjlibmhOQmRRUndJTUhkTmZMa0VQdVh1TzYz?=
 =?utf-8?B?eXQ2YWhucityRi90ang2LzV2TE12aytrNkJFQ3U4ajZaWSt4OXhrTjZselB4?=
 =?utf-8?B?UmFxcUM0NE5mL3lNVHB3TmlGTlp2dlBMWWVWMDRiaFd4Nk9ycXBjaW9heUow?=
 =?utf-8?B?OFZJcUU4SnFNdHNBMUVzdXJVd0J0eVlzd21LVDAwcXVzWnVXUnZZMnJGbWVl?=
 =?utf-8?B?Um1YNzF0RjlMUk9PeG5CakN5bHdwSXZraGpkaEhoUjFsOUFmR0RQZ3ZvWVla?=
 =?utf-8?B?WnJpdGdtUEtvK3gyaXVNUVUxNWY1MUdkcWZUbS9yOG1NOXZsUzJCYWRqeXh4?=
 =?utf-8?B?VUI1S1pHcytTOHNYU21VRk5aQTMyVjNYVUg3R1c0ay9KUzlFMi9WRGNEVS9j?=
 =?utf-8?B?ODd1ckk4RXlaWnBIVEpDUUs2dHFiaWZoWldZUi9QSnVLazN4bzhwS2xuWG5S?=
 =?utf-8?B?UW1aT2hoSzhiUVJyTitoTlNWRXZaak1jN25lTVBHNjlxbk9sRyt0Y2RLNjZ3?=
 =?utf-8?B?Qm44Y2FqNUJjRHhSckhya2VDNHdnSDNGMlJQdUVWR0VncFhSOVlZK1BMUktj?=
 =?utf-8?B?QXpZWDNXOHJaMW9hKzNLYUFpRUNoZWh6NUlsVUx3MGFzNWk3ckNhSnJhYXVF?=
 =?utf-8?B?MitkUVVGRkJtRjFZTlNIVTlxczJSdldGUHBTc0x4VG9DbmJBRExvRXdLZnE5?=
 =?utf-8?B?SjVFdzJKbkVPdXdGWFF2RS9HS2F4T3l1NmZxSStQNHlra1J4NnZUWFRkZ2Y3?=
 =?utf-8?B?Tk8ramdSOFcxblNZbEZYV3pvY0Z3akxQWmJPN0dKUWh0WlJueDRlUXFxSjND?=
 =?utf-8?B?V0JlZHV4Y3RRdU5La25aNW42LzViUFJVNlFDT216MVNFdUhKa1dzL3o1MHI5?=
 =?utf-8?B?TGo2U3RLTW15cU80Vm9Ka0dLQVdNQVpScCs2MGMwT0JyTExpQ1NNdFRZSjdo?=
 =?utf-8?B?aVJlOHVSSHhRZEsvNUEwczdod1VMNHZpUW9Pb0F1OHZCWXdtT1F2bjl5MThX?=
 =?utf-8?B?MGJxKzZjUzJlQUNFN2FMQjRvdU1pVkFKOUZIcGVPbklzUFlhOGlyZTIrVjVk?=
 =?utf-8?B?OXFKdHg3ZFhOT1ZjbUdPQmhiZ1Roa1pMYml6NExJUTlBckVkYzZ1ZERIMUV3?=
 =?utf-8?B?VHBDVE1MdG5RUi9xeTlaVFdsUk1nMXdQTnVjZ0dSeGU0ZDgrM2JUNWhVckxt?=
 =?utf-8?B?b3Q2UjZ1ekdXL2dTYXBhUnVBS3Z2NGNwTmxubnlWWmN0TVFWNE9PVFJoSEIv?=
 =?utf-8?B?M3VuK2hDblR6U0VyVU9IQ3ZFUkNuaDNCc1QxWHc4bmc5aTZLRFVVQkFYYlV3?=
 =?utf-8?B?d21XYnpjbEQwWjBXVlJ1ZXg5U0gvOHlxWFNmREpvamRGbEFnQXYrVE1XUEpz?=
 =?utf-8?B?UXJxcy9oOWF3MHRDTHpBSENCUDBtTEhFWFd6VDNkREtnQjhzZlRwOE8vNmpG?=
 =?utf-8?B?YWd4VEhNZDVweTNzZDQ2RHo3K3M4dGRpVDhIa1V4UG1DT3pJSWVaa09sUFBH?=
 =?utf-8?B?QkZjRUFaZzB4SnhVK01Wb2lqT3EzWTY1VGtoemxvTE9JZ3NvaGJOSEJEU1pk?=
 =?utf-8?B?RmNYKzRray9MeGJDRXRFWkhJVnBaMmdzdlk3enYvZVlMQ3EyVkMxalF4TDFj?=
 =?utf-8?B?enc3eEx2T1lvYjVDQVVuekh4OFpOTm1VQ3ExYzJvYzRWQ01Bbit5QVlIT3hw?=
 =?utf-8?B?OE9CNExQbFNMVEc4cUE3QU9GZzdEenU0Z2o1STB3RmxtZXQ5MGFkaWljU1hP?=
 =?utf-8?B?bGM2d2g2d3lsM3FGbWJJNWVGaDdRPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaf63f2f-85f9-4aac-5d68-08dd8d7f1857
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:51:56.7820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezjemoYHIgKtwuKgjPpqWlpGhKb9l3fwfTkbawXFwjwp2oEwh7sqR4C+mnqJftJQJvrDvNGLHXFAAyehah+fVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6487


On 06/05/2025 19:36, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> A delay unit of 0 is a valid entry, thus it is not valid to check for
> unused delays. Instead, check the value field; if that is zero, the
> given delay is unset.
> 
> Fixes: 4426e6b4ecf6 ("spi: tegra114: Don't fail set_cs_timing when delays are zero")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>   drivers/spi/spi-tegra114.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
> index 2a8bb798e95b954fe573f1c50445ed2e7fcbfd78..795a8482c2c700c3768bd50bf59971256893a486 100644
> --- a/drivers/spi/spi-tegra114.c
> +++ b/drivers/spi/spi-tegra114.c
> @@ -728,9 +728,9 @@ static int tegra_spi_set_hw_cs_timing(struct spi_device *spi)
>   	u32 inactive_cycles;
>   	u8 cs_state;
>   
> -	if ((setup->unit && setup->unit != SPI_DELAY_UNIT_SCK) ||
> -	    (hold->unit && hold->unit != SPI_DELAY_UNIT_SCK) ||
> -	    (inactive->unit && inactive->unit != SPI_DELAY_UNIT_SCK)) {
> +	if ((setup->value && setup->unit != SPI_DELAY_UNIT_SCK) ||
> +	    (hold->value && hold->unit != SPI_DELAY_UNIT_SCK) ||
> +	    (inactive->value && inactive->unit != SPI_DELAY_UNIT_SCK)) {
>   		dev_err(&spi->dev,
>   			"Invalid delay unit %d, should be SPI_DELAY_UNIT_SCK\n",
>   			SPI_DELAY_UNIT_SCK);
> 
> ---
> base-commit: 0d8d44db295ccad20052d6301ef49ff01fb8ae2d
> change-id: 20250506-spi-tegra114-fixup-dbf6730db087


That looks better to me.

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks
Jon

-- 
nvpublic


