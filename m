Return-Path: <linux-spi+bounces-7921-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F6EAABF65
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 11:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBFD6164B4C
	for <lists+linux-spi@lfdr.de>; Tue,  6 May 2025 09:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495AE18C034;
	Tue,  6 May 2025 09:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ggNwCGg1"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984A513B7A3;
	Tue,  6 May 2025 09:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746523623; cv=fail; b=jiA0xVEI17uqGp7O6YbEWRltUvmV4j+JG1a8+DsXBuI/s+GZA0/1eGnMaLQUGUoHD/PzyPEgI++ep9RmMVqqYuPzZhitMgyArZi8leTRYEa1tYa7H/Xy0kLlayTpG+rpRcC6A+VxQ7ShQCAUEuGgQDN00tl/Qp7fP/fJiNJVX8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746523623; c=relaxed/simple;
	bh=cCrncfzkN0OGJYfFagHSAJWQyxWohTgxKFyPN19rneY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Huyq5m+Mp/5mrliF76vVSx+YQcQaSySkNXtYRDCq8qQZCmEuNV2m9eDzne0hVGBxUN+8UVLp8iEhc5l20FDIzQEa+va+YJKPJ6slYF8Ed/vOqzzDDeJhgrpinh3C5+c6FcLwOLBXnroDluL/10sEGEyADwhJ1kpNt+gjT9A1yLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ggNwCGg1; arc=fail smtp.client-ip=40.107.101.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLIvnnX+UgjC3sZaH/YVxcLmMSH9d3ribXzcT4eDu0mEI7s76RvA5m5qPaJJO9hgAal6E0yMmJjSxy7Z8cog7awo5NSvbWay05phGt6OeOgNUnx6OKhW2klznh1wrZMDmhV137A49riJr8jq/IMgfFvQgIBeHtiQTeGug48o4ZZfMTmK6eFE3nDBbDLgzcuGpWNoA170pbelJ2MH5YwzTqKrWgBKcgCETkYuHckaJSrQQG0hQHIQJ1hvwbTK1MCUYhhhSolLAlXcvdIyyc98acyQ4vXow+4m6VWt9Qj/3WEe1wBSnivgDtDWTJRj1I2kRzWKMJUJ5yE3mviQ/dFoQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AFvsy4fB1Cs+q1FU/2i1/ZTNnvniZAoicS24wbKyBPc=;
 b=LdOrept1zMex+JVkSwZQs3gtWTg5g2E4CuuyeSc/YJCEUODY6vXswKJCy496dw0GXmxl28n+OOSt5qIEi2ImR+4CWyIFGiJQeORoiNj3XPZRQFHvl6WFUunaA+TDhhvpiupFvcTPIHk6Fg+sA8NTUqEC7AICJxyLHHoNU0sORIQQlQfPiD4ENUe276dSddo68iJBApHRjy2wseM9AboW7OiobEyAo6AD8sSbM27YxRfkUMAiM2R2E3IC/Hxl+4cirKvuKae5cgbxS1feCCqXCJyVvXAmo0peACGhRrb1r2+UxELVXU/T2mw2bkDsnZ6cKCXvxsx3sNhMi2kBorgQ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AFvsy4fB1Cs+q1FU/2i1/ZTNnvniZAoicS24wbKyBPc=;
 b=ggNwCGg1S1I4azeLa3EfYNRferoQ+3u92zp5fDu5tDn0FLx84KaBJ5vhsfxUzdP3GGAiLQ+McThIpqDzapcx9/1ti1F33XBVpJ71DuE1s+ePxj40+IVyOnyari8nP0s+3rPr0udtVWGQpzww3b6NM9CizTvxVb8wAWloeTgUznjDn0z1mOm1r+k9Oqy/MIj11IwNNq0wf2uKkoQR+KwZkksGpPUyHQmI2Y5gZguBpRXehXs9UAVc8V20lZ+IPo08rKjqClEkDHWWx1Oivp3wlFF4Zm0Zrkb1dcNmQOHpxaP7bKTVCBQH7ZdCMaGErT+vTV7qUJmU4/LhlZ8kKEIxEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SJ2PR12MB9006.namprd12.prod.outlook.com (2603:10b6:a03:540::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Tue, 6 May
 2025 09:26:55 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 09:26:55 +0000
Message-ID: <00b119fb-1cbb-432d-a884-5b33696461e6@nvidia.com>
Date: Tue, 6 May 2025 10:26:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: tegra114: Don't fail set_cs_timing when delays are
 zero
To: webgeek1234@gmail.com, Laxman Dewangan <ldewangan@nvidia.com>,
 Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Mason Zhang <Mason.Zhang@mediatek.com>
Cc: linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250423-spi-tegra114-v1-1-2d608bcc12f9@gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250423-spi-tegra114-v1-1-2d608bcc12f9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0168.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::11) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SJ2PR12MB9006:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d7fa88-5ada-426f-fad5-08dd8c8023ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmhMZ2tpSnRqbTBCZTA5UUNnbW0yak5OSkg4YlR4WkZmRVFla3Zodzc2bVZk?=
 =?utf-8?B?RmpUYlBpRkFzK3ZFem1oelcrekplaEpjazlHMWE3NENKQ2hoRjdQU3hRa2dR?=
 =?utf-8?B?OHZMWGM2OVlLRk1TdWoyQkV3ek9hUjNOQlRxTUxNVnlqVTNOTUlZeW9mRGZu?=
 =?utf-8?B?MUU1SW5aellDS3Rpcm5YTDZmSWxqNHF4Nndjc3Vkb2U0anZmclVWVE1GS1lj?=
 =?utf-8?B?azFMTzFKQXVSeldDR2FvUVBWcmxYdXU2ZTFxa095RCtod1ZXQzJCcW9KaWtI?=
 =?utf-8?B?U3d4R1N2MEdJQjNmaUtHK0hQM3VjbVpBRUU3NU5JeUVOazZldzY0bmc2MzQ1?=
 =?utf-8?B?blpMQXVkVWJCK2VTNm0wL0dNOUFTejlDNUxWMWp0bDY5WVJKTEZkWVVTUHZk?=
 =?utf-8?B?aHB2TnA4cHpsYkRLaW1lT2E5MGZGVUpvZ0JhVWxTaU1sTFplR3AydzZDbzVN?=
 =?utf-8?B?dVJXaVpIQWtoYjZyaXVqMjdZSUN6L1ZkZ014bXcySkN6UE9oTFVYUTJyNGEx?=
 =?utf-8?B?SXJhZXI4UkNZQm1WUFM0UzhlZ0JLeHhLLzNRc1FjSjd1NW5QZFdWaEt5czgx?=
 =?utf-8?B?bjB4OFF2SUFxZkIzdEpFbGJRZndmZWxNT3JVcW5jdjBCMS92eWcxUVZpNytm?=
 =?utf-8?B?M2dHWDNJWGRLYjFKOHlHbFVkSlpuQ2ZSVmM5aTdWNGoyR243SUNoMEN3TlpU?=
 =?utf-8?B?N2ZJclAxYmo3Z0MwNE1tSHFDV3MvSzNpd05oUHFrQXM1NUt0bmh5aFlBWnIx?=
 =?utf-8?B?d1ZHYm5lRHZmaU1XYk5kVCtBUjJsaDdmUTlaZDZFMXNTUkh0MFV4VTJuNHdZ?=
 =?utf-8?B?UTEzbFNranEvcGpLNTRsNE5NUzQyU2pNNlQzZUdDbGM0aTlUZVN6YmxCZTdT?=
 =?utf-8?B?U2xXaFBBRHgzYlJLTTZacHRXc2ZJVXpPOTlpTTVZdFZLSVl1NHBmM1lpNlRZ?=
 =?utf-8?B?NFNBN3lUOG5NRVVKalRBOXVBQXVGWVZtN00zWEJMOEVUb0l4cG5oM2gwQUF2?=
 =?utf-8?B?T1dmSTN2TFVyNURrcU9DczRpeDZLOXlBZFhnMkVha2I2VSsva0JxbGpnQTgy?=
 =?utf-8?B?M0NtcWNmcW9obDMxcmUyOEQ1d1NSaFNKRG04K2V5VjBHaHhVYVJGcy94Wk1k?=
 =?utf-8?B?SlJhRUdVUGdVVVhwQ1hVVnZuV2Mxb0N5eENTVTFQN3JlUW8yQzh4N2V4WWJw?=
 =?utf-8?B?SHBqRm1XRlMxNklJOGw1ZlRPSDMxZjVmb3dzVUorN1ZWUGlDVWt1VHRNaTE2?=
 =?utf-8?B?bjRYSFVoUER3QXExMTQwS1B0b2lUdlpDamx6cFFlMGNaeW9MTUVzYi9oUnZv?=
 =?utf-8?B?UVJHUkcrZFduaDgzWmNJdDNqWVdwR3l2U3QxRFU4cmNBZU1Yd1lGaFR2NnRP?=
 =?utf-8?B?QXRJUkZEV1pPQjVkQUVkZzYrcnFCeGx1cCtLVzJ6c0FKYVM5VG5XVGhXdmFx?=
 =?utf-8?B?SjNsUlQ5RkgwM0NtcFpQVWZUVHl2TnBFRW9WU2hRNkRoWlNZTTNLQkl1Wncz?=
 =?utf-8?B?ZlF4UGRPM1ZtRVEzLzI5TnkyRnJLc1MwRDVtYUF3WS8vQ1VCMDB2RXg5K1Jh?=
 =?utf-8?B?eDFXWVl1UEJMRGdHSlcrNUp6N3lMT0hCRUdYWkQyN0x4QzFGdUxVaDdVNFU4?=
 =?utf-8?B?M1d5WThodnpPZW12ZTg4Ri9XRUZwend3M3BCS1RzLzdxN0JIcmJvdm0wQ3Jp?=
 =?utf-8?B?NEp3ZzFoZXNlVGFFTy9YWTh0ZkNvWEMxNnRWNkhuVll5UWd2NHFyaVN0cXM2?=
 =?utf-8?B?N0w3cE5EMXNseWlMaUNMd0phNmMwYUpDWXMwaHFqV3VmZjdwTHlsT1AydVNH?=
 =?utf-8?B?NXJKS2ZlY2FETjFsNnRKT2JlOFJMdDVKbEVoMXZkck9US21ybmlOaGdXN2NQ?=
 =?utf-8?B?OWlrZXBKazI0MDlFcDR4cHMyWk5kYW53QkZuaS9nUnErR0VWSjBqYWRLVWFw?=
 =?utf-8?Q?gBpMV+rabzM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QU5uNDdna3YvUng0WkFhMTBwS1Z4cjJsMjdJV3ZKZW45a0pnSVY5dTV4Y20x?=
 =?utf-8?B?OVAvM1NhWEVIeDFxc2MrUnV5Zm40WGdILzdnWUlXZERnM0QrQmppMHMxcnBG?=
 =?utf-8?B?c1ZBTlJ4dTArTlNHZHZNQ0R2YnNlYWRONFZOd0ViWkZDTU8vTTJzVzBSVWxU?=
 =?utf-8?B?T1IxYkcwZXAvdTZmaXhJZ3JIUC9uTE1Udzh4ZGVuTE9MMUFpUU83SXF3bVd4?=
 =?utf-8?B?cEc2ZDNHWGxvN2lhcEw1TnFFZFBKV2pqMC90RTJTa0FBcTUvS1lBTThzM3Vk?=
 =?utf-8?B?dFJ1b1F1R3FNQnA2RDlwZnpPY3ZZN0hOR2d5VkhCSFRpUm1LeDFKSGxMUksx?=
 =?utf-8?B?TVc1VVN0WnZjRGFYMWxsRTk5amh6c1hqbklqcUtiTUJRQTdUdi9nL3pHL0du?=
 =?utf-8?B?d0VySkk1ZnlYNWNjU1RGdVpxQ1BENWUvcmpXSm1vL0ZKU1VaUjFsd1dSSklQ?=
 =?utf-8?B?NCtMeWlkUnRBUjQ1QnZaTmdQejd5U0lUQ25RdURjMUhKVS93SXJ3d1RoNG9h?=
 =?utf-8?B?NGtpMUxPbkdMS2Vvek1vVThML0lCOFJqbVI0SFlhelFjUGVIOHZSTXFSVlI4?=
 =?utf-8?B?QVRrRS9DNUptZkV5cFlqci9pZXBuYW5DWCt1MnZoTWVLZjhLcVB2RFVuek1G?=
 =?utf-8?B?dmpxNEw3cHNvSVlXU0hGTzNVTHAwM1cvWTFjK2VhWmpPVWJnZWR6dlliQm9Y?=
 =?utf-8?B?U2JJcW5WYS9STFk2NG15dGlUdlZhRkFEMnVEMHhFYnR2YTV5NGpzRE5Ea2E4?=
 =?utf-8?B?TnhoOFFyNWFtZDFFSTNmUng4YXVsYlM3SDZkNDh1YmZqVElLUTViQ1ZXbWxo?=
 =?utf-8?B?dDhIUW4rbGhwVERMaVRaMWJxNFZ2NlVJVS9GYU1USFV4ZXJjOGdYaDZqVFFL?=
 =?utf-8?B?b0Q0YmJBamxzN0kxY3NubnRmbG93Y0lKZSt1NVE1VjJNcW1Tak9qY0tudTd5?=
 =?utf-8?B?b0pLR3AyMDZjbmtpaE0wWHozRE1RNkZsMFNtRUpQeGlsVVlhaWVabTRMaTZZ?=
 =?utf-8?B?eDJJNXMxVXV2YWdaM0NMcTZzRUkyR280WmFJQTNJREQ3NWdmV1lhbUZSNWJL?=
 =?utf-8?B?RWE1MHhtV1pqTzQvVDZJK09LclVpYU9DR3ZnYTVnTlU2UFVDbWJYeTRSdHh0?=
 =?utf-8?B?aTlPTG1EWWthWENCYnBUbk9lS09DelhtMDJTblB5VUhqUU9nNFhCczhaeGd1?=
 =?utf-8?B?aDR3TVR4anRwVWtmUzFBNFFXTU4xRGFKbUxtcXEzQnRSL1RjWUEwQ3BhTWk0?=
 =?utf-8?B?cXZ3eHhCUlZ3ZGIweFZJLy9leGJ3TTN6cmhpUG5HVHVOYysydlFqR0h6WjVM?=
 =?utf-8?B?N1dQZ3AyWmVLc20yc0lQclJsQkwxaThySHk4b1JzY21CSlVwOHBHVGN5TGo5?=
 =?utf-8?B?a0QvTi82UWdrVkZiSDNRL09nbW1meFJoS0JSNTNKU20zclBCME1oZmJuaWZr?=
 =?utf-8?B?SEROeHNIWU0xWDdna2RPZnp2dU9NWk1jRjdEVU9obkZMb2VOR1M0Y0VFN1Nr?=
 =?utf-8?B?L2JxQ0gweEdHdHNEaUsvSHhlYjZXT0JzbzNKcWwvSVF5WEo4ZktTYUhMTUlp?=
 =?utf-8?B?c0ZkWkgxZ0FLanhydmpBVk9vNXl2MkNKd2p6dTI4aHk0UTl5Nk13RlZCSk1F?=
 =?utf-8?B?WVUrc3lWR1M5VCtFOWpvUERxWFMyaGNGME5QdFZPS1c3Y3VaZG50VUJIL2Y4?=
 =?utf-8?B?U0RhNFRTbGZYYlY2Um1DSTJEb3pTNXgzQXBWN3c3TnovQ3hVOHlaZ2kzdDJU?=
 =?utf-8?B?S1AyWUZjN2xwUDF2UGdGc1YweExNS2EvQWdNR2t4RDNGcUZ2MTlIZ2FWcFQw?=
 =?utf-8?B?d2EwK1RLZG9Zb3ZMZTRjSmoycFRHYWt1bGpKMzYxRnpUTS9vUk9qaEdsL2h5?=
 =?utf-8?B?RnhoV1lXOTJlN0N1VzdtY2Znc1kwR1pxTENWZU8rVEl2MVNZQnQ3SVZGTk9z?=
 =?utf-8?B?THltWW1OaGwxUFYybmtMVFlnRXdYeWhxRUp1YStRbEpqaytuR29valRpcFcz?=
 =?utf-8?B?VnZaYkg5ZlF3YnVyeDJCQkNwYzBHbmx2VjZtUGVrK2FqQzRjWjJYbDh4N0ZJ?=
 =?utf-8?B?cno4cUh2aVpmbmVIMEVFS2drN1h1eEc5alV2SUw1YXZmUnBPMDV5emtMdnF5?=
 =?utf-8?B?RWUvYVFnSkVOTURsdGtyMHZGdnJKU2tsY3BDOU45bmFvMDJTdzBhSkQ2MGFG?=
 =?utf-8?Q?o/ZEEs7L1MoOFwLXe3nsXhtk4fu98dhoR+jnXcu8f1OD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d7fa88-5ada-426f-fad5-08dd8c8023ff
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:26:54.7185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HgnLFHNeTOwVBKYeU/i9FSo7ttv9dSLp7wzRPW9frnn/i7eLRCqL04m9/2HSos7MpyxoPxEaIll+m8QeK4mweQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9006


On 24/04/2025 03:03, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> The original code would skip null delay pointers, but when the pointers
> were converted to point within the spi_device struct, the check was not
> updated to skip delays of zero. Hence all spi devices that didn't set
> delays would fail to probe.
> 
> Fixes: 04e6bb0d6bb1 ("spi: modify set_cs_timing parameter")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>   drivers/spi/spi-tegra114.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
> index 3822d7c8d8edb9730e937df50d1c75e095dd18ec..2a8bb798e95b954fe573f1c50445ed2e7fcbfd78 100644
> --- a/drivers/spi/spi-tegra114.c
> +++ b/drivers/spi/spi-tegra114.c
> @@ -728,9 +728,9 @@ static int tegra_spi_set_hw_cs_timing(struct spi_device *spi)
>   	u32 inactive_cycles;
>   	u8 cs_state;
>   
> -	if (setup->unit != SPI_DELAY_UNIT_SCK ||
> -	    hold->unit != SPI_DELAY_UNIT_SCK ||
> -	    inactive->unit != SPI_DELAY_UNIT_SCK) {
> +	if ((setup->unit && setup->unit != SPI_DELAY_UNIT_SCK) ||
> +	    (hold->unit && hold->unit != SPI_DELAY_UNIT_SCK) ||
> +	    (inactive->unit && inactive->unit != SPI_DELAY_UNIT_SCK)) {

The above does not look correct to me. For example, if 'setup->unit' is 
0, this means that the unit is 'SPI_DELAY_UNIT_USECS' and does not 
indicate that the delay is 0.

Shouldn't the above be ...

  if ((setup && setup->unit != SPI_DELAY_UNIT_SCK) ||
      (hold && hold->unit != SPI_DELAY_UNIT_SCK) ||
      (inactive && inactive->unit != SPI_DELAY_UNIT_SCK)) {

Jon

-- 
nvpublic


