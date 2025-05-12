Return-Path: <linux-spi+bounces-8070-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF8BAB306D
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 09:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61CA73B5C0E
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 07:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985D9256C64;
	Mon, 12 May 2025 07:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f52l9mW9"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40F82561AD;
	Mon, 12 May 2025 07:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747034307; cv=fail; b=gFlPRTGWaBlUtEjF6Dv+U5Slmw+96rzV8v1cGG/zSsBleO2/Ifx6qNaz4XjtSpA3f7LBqR/PrBlOnFxvr5tAewuvh+N9mSKNWR248i1JS3AKq1DsLfQW3mVke00fWoNoex9AtV+pU9tizFnhKl9QvS8Wd1EzKxYS4SksDwFXLe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747034307; c=relaxed/simple;
	bh=o5EdAPaTRd5WlQKlvE7pbpg4OB6bd/iGSkqFlluDpSc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hds8UnJiEewPJqydpsbjcmyq3/9As8G70lbTld8r/6j1ldNXgwlCbKsCrR/5h3X6M8mzpEHqtd0P23OKiBrpoy1q3ZDM5eaI5d2NwFvaqyTqVxBeVMx9jCiU+OlawZi4VTlZ7+6PTWDhxnwBOhTynghnabLfoMbX/CAf9v2jebU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f52l9mW9; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGHsrbI/m2OXRXdCXSNhvcp4mddR1PsMwK6qZv2CQLdpvB7QMOELrWv0DlC89yl50pFWTsxzPtld74EaCyEsXsAorEQ05bXiNA/m7+g+gfi33jcgmN6L2jTrNu4ttw1NVNf6bss81Whgnp+GJ6cjHs8IeF8c/rp+6wqFmjMH6UD0JiPul7fBwlKXwki6d5NuRXC/AiN0/WDS76SqLo7qsi+NiAJ1O+KZC74NqH4iocgYDbdl8X8hNJN1+usEXR0g/5PMQ7En4/H5HvV22zgdhMQ8Rxgzm/vFn0CY063GMkPRhlwWOV+srJ0Zr6+sPAY3U67cDGXZt6z2Wi+wuStvjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z677cRatg8TtdT1SHoT/5cPjY43dRXWlqcI00vH1b/E=;
 b=AQZHvOaGaiX3tnHhV1jqcw/HTv5gWAQ1Z1wAKlVnObTVSzLHVNjfc4IvdiwNoy+64urGzPIvKu/0bKV9IMVeIAyTvXPs0ZrY2HOLBvUXBYKcpLNsXY6MF47gS9dy3O6lUGZseDcBgyGXMVOZUfJUu5DhEfNowAmTPyeyY13XR/bvPc7834btdxq+0EHUQhZSn+R0ZE5uSGrZLkQOQ9XHuGXO6zDJlMf2L0U1ir4UC8wGNI2K6LiQqqMd0hvnXwNyI/Een0rdnUcHXJWc4P5a6C09dxGHa/6MuDX1sA4ZLp8C2Z732qOSL9A6GglAQELDXbprDtmrhMSKdtGTuKfMoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z677cRatg8TtdT1SHoT/5cPjY43dRXWlqcI00vH1b/E=;
 b=f52l9mW9vNiCEXzrOr7MN0uvdqnVZ1v0MpevjBNLvXnZi0mUPtw3R7DAtE2Fzh82a9oVIKbHqj9FVIT8jQBQ9rsO2z64Z2D0Ospu1VIFBy9laDLdWQW98CGcxvAgKteraX+d8hJ8KnzzVQg4TnKrLtpZDX5uCmnyMwt7Jd4XJrA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by MW3PR12MB4489.namprd12.prod.outlook.com (2603:10b6:303:5e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 07:18:21 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%4]) with mapi id 15.20.8722.024; Mon, 12 May 2025
 07:18:18 +0000
Message-ID: <e84f5483-a203-4095-82cd-23fa94c87700@amd.com>
Date: Mon, 12 May 2025 12:48:11 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: spi_amd: Add HIDDMA basic write support
To: kernel test robot <lkp@intel.com>, broonie@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krishnamoorthi M <krishnamoorthi.m@amd.com>,
 Akshata MukundShetty <akshata.mukundshetty@amd.com>
References: <20250509181737.997167-1-Raju.Rangoju@amd.com>
 <202505110641.zLT16Dv7-lkp@intel.com>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <202505110641.zLT16Dv7-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0023.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::13) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|MW3PR12MB4489:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f7dd4e4-14b2-494f-7417-08dd91252b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTAxb2Y4c0ZBZ1BaWHMxRzlNYVI0VGVFMndNUCtTU3dNYzZFTXN0UkRrdUxD?=
 =?utf-8?B?MDBHSmlWdHNINklsNExIWUE4TEJ0STJzdHEyN2hJYmZoV2lMZ1pvYTN1K202?=
 =?utf-8?B?R2s0WTVxdnc1MU5zVXFuNTU3SlJucTBoNjBmbDBoejJrZHVCdkd1ekdMMDMw?=
 =?utf-8?B?Y1Zyc1lkbVZIZURSOHZDVmJSN2x3R2ZUdjdyQlYwT3VxdWwvSUxENFFVMENL?=
 =?utf-8?B?aDdIWFlBV2x3dVhVZWx2OWo0ZGJZc2I4MWhMTVVqRmxRQTNMTWgyM2Y5QlVp?=
 =?utf-8?B?NzM4amFSMkxoaE1FaFVlL0JTMTNtWjlQWWJwUWJ2dERNanZrK3hZcTY4OHlJ?=
 =?utf-8?B?Z2hxbFMxSStkWnRnUXNsZW5QZkNmWXEwcVRKWTZ0b3F6K2NobFl6Q25UVlYz?=
 =?utf-8?B?THBZOUEvNmxEbDJjSzFMTjRlcnpraTRXdU5XcG81YytJZmRLWmF0aTBRZURy?=
 =?utf-8?B?d2VvQlZKR0tTVE9OQzhxQzJhSWNNT0JZcFQ4TG5SWmUyYW82M1dwZEtybk9s?=
 =?utf-8?B?ZlZnbW81RmtUWWtMM29FOU5ra2RWSXFYdXNGNHdPL25aRlpzbmpqQ05NU1Y2?=
 =?utf-8?B?eFlGb2FQTWl0Y1RUL2loTUpXZGhmSDZmRjFERS9CWXJaUEZCS2o4T3hNOEs3?=
 =?utf-8?B?SG40NEhmSmpZZXk2a0U5NGVlSkRvNEw3SW1WN0hERnJyZGJ1NDRzcXVheUxt?=
 =?utf-8?B?ZnFMdVBTQnZsSkNmKzA5Y0pyRVNFWnhNVUJnVHErNkdFTTJ6SWo5cWtvL2Vo?=
 =?utf-8?B?VkJCZ2JmR2pmeVZ5SVdndGQvR3ByZTFXR1BVcEU4dFdEaEFTYmRwVnk1S0hO?=
 =?utf-8?B?RkxRL2NzWWk3ZlNNRWxudjQ1WEFuWEZackhrMDQ5K3lpMzNiaVNVR2RkN3FF?=
 =?utf-8?B?d0lpeVhoRlpQcnQ5cVdTK0h3K1N1YTI3RU1pOUU2KzNadGwwOE5BWXNGcTJy?=
 =?utf-8?B?YXQ4NnRPT3pKdXlZT3FMVlVzQW0xQVB4U2gySGdCWTNqU2o5OUlxU2RiZ2k5?=
 =?utf-8?B?VlZvZUdoTHAxOEh2Mk9BUWQ5bTFKRkFDZGhqRVB2RlBhUE9sQTBPaTNYOWht?=
 =?utf-8?B?bVhsSjM4UnBjL1ZJMGJxckZyT1VKVWdVN2FFemhaaHVzUGpldlY1WEZJamc4?=
 =?utf-8?B?eEFLYlBSdWFqeDVqZDFkVFdML3o1VnBSUmlFaXhCMlEzWDQ3UG9aZEx0enha?=
 =?utf-8?B?cmZKNlh6L2gweVJrMlZzYXFTbDJ2Yitwc21yeGROSk1FV3FNSHpKYnRPVTVJ?=
 =?utf-8?B?Wk00TU55VE1mT1Q3R2taTEdUOStOR0lSY0pDZXNGczFJUEJJRGJOMGtRNis1?=
 =?utf-8?B?NFNVM2hRdWFOSEl1THNMS0FkOUx2MW1ndlFqM1YxczhtOFNJblVGc280NWNk?=
 =?utf-8?B?KzhmWFhOM2sxMEI0aUc3RU8zN3ZnWERJZXQwUElBZTJSK0g2T1B3ZElJNkxT?=
 =?utf-8?B?Mkh4TitJejBGMit6eG5nTExHZCthengyb1NQY1oyVzVhNzFWSjNsa0pxOW5E?=
 =?utf-8?B?eStoWDJiVHZxdDFVaTBVZENkR1BjNWNwemNjdzR6RnhsckFLVG9YbldqMytr?=
 =?utf-8?B?QXo3SnV4MWRjZ2ltZHpjTUw0bUsyRUFQbnN3SzUxTVpCMkFRS2hGSjBQK3pG?=
 =?utf-8?B?TEsvT0hPUHZkU3hKUGJGYTJlTnV4N1lTVHROUTRkTExFWis2aUc3T0Vsck9T?=
 =?utf-8?B?WHFEeUd1Y3VmVHpXeXhmK1NoT1A3emtoeE5QMi9OMThmR2M1VlArYmhsTGZm?=
 =?utf-8?B?QnNscm52bFAzYXZjSkZNYXpJZHdReWJpUjBqamxpdStGbmVJQ2lTY2M0Ky9m?=
 =?utf-8?B?c1k4QWE4WXhzUHROV2hIU0VRNlhHTGxsUTBOSnlqeG1qS0ExeXA0VUpGd0g2?=
 =?utf-8?Q?VGblJwKUeiMv7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Si9FRHZtcWl5NEtqdEtZTWVic2N4akc5SzdabnNDbGdFcFFQblAwNXpOQ1J4?=
 =?utf-8?B?Y0tPVkJZK1lrL0xzQWw5VUtmYXd5M0FpZndhR25mTVB6b29oaFlySmM3ZDdC?=
 =?utf-8?B?YmxGU285N1pBQnZ4KzVDWGFGY2NGS3dZbDBpanIySmlZaG81S3ozZ240WklZ?=
 =?utf-8?B?SXN5ckh4VnM5clcrNTk4eUh0dm94czlPUEx4ZzNyUkdYL3dhRjFHWkMyZm5W?=
 =?utf-8?B?b01oMWNlTlNrVXd6Z0JSRjNMNE9HNnphMEl1dGhyUnFxbXJlVGw5YjczLzZi?=
 =?utf-8?B?a0hIYTZnVjVUcHRKWlpJanlkckIzcHVJK3dQK0x2KzlkV01hYTZhWlhLMFVx?=
 =?utf-8?B?TFp6R1QxamZ1REN2V2RWbk1jV210SENxaVhET1JUWWVBUWhVTHo1VmlLMThR?=
 =?utf-8?B?YWN3L0tLYldXaVR5WlJybm0vb0t2MnNKcHlHdEtRcHZhanpMMkczQlJmcXNU?=
 =?utf-8?B?Zy8wZTgraElQcGlPaFFSMHB0T2NJbXplcUgyQS9RVHZRd2dNRnBIeVJHNWFY?=
 =?utf-8?B?djFRRzJtNzZia3A3aUMvZlgrV1R5Wk5DNHJ4K01TczZ2Y1dnbi9iMHc3a1Rr?=
 =?utf-8?B?dHRnMXQwQmIzUGZYZkwwMGlYU1ozRjhzbElCRThDNmpaRWRFdklPcFBpS0NJ?=
 =?utf-8?B?VG9WZjhnajVpQ0tOdmhaSUprVW95TDBEb3N1Q2d0VkY4MEFJb212bGNQQTRu?=
 =?utf-8?B?dFFpTXAyWHgwZFJ5Q2tyVUpyMFdabXFTYkNZQVdhMFJPUCt5ai84QTRUcW5H?=
 =?utf-8?B?ZjlLQTA0QWpTZCtXTjUweEhVR2hrOFNXS0ErRCtvS1dFNUNxZDBsY2s1L05O?=
 =?utf-8?B?TFB0STlSeVRiejFUSTMvWTBmQ2JLbXlYeVJxYmJRd20ydTF2R1ZRNzVPdWRa?=
 =?utf-8?B?ekUzOXJ1YXJWdFJoc3k5Q1VWUkc2NThRVkw1R1VUUEZQODZNMXBhamgwWDRl?=
 =?utf-8?B?a0d6Z1dLU1lhRHFkWVIxWnRiaXoyUUI0Qm4zRSs2UlpLQkc5eW8vcTcwTVds?=
 =?utf-8?B?bW5iSWhDUkpDWVk4c3dhN29PekNVTnNTbEQrVENocm5laFdrYTVrWFlkcjhv?=
 =?utf-8?B?Um43SmkwQnM3SGZ2NFFqSlM0N3FxVXVXaTFDVW5NcmZJUTFHWE5Bd1ArdVFs?=
 =?utf-8?B?UkJ4TC9Za0FEQ2owNGg4ZXI3V1RiTnVEQTB1VEhFWkJpOWRHWXk2b2dVNFl3?=
 =?utf-8?B?ais2VUJlVGtyQzF2dHNHUkUvUG5SMzNqeDVmYitFMzFtL3JVVS84S0RERWFL?=
 =?utf-8?B?Ui8vUEZFR3AweE9GQ3NYVms0Y3NpYmpqVlllcDYyY0Q2YUxaUi9kWDEwYjFy?=
 =?utf-8?B?dnpuL3lhUy9PNTA1K09TVHo0NnhyQXQxdWRhNC9kdjZVSDZscEZtRTdsd1V1?=
 =?utf-8?B?Y3J0bHp6blJvUk83eEdxNWhZWHVFTHQra2dFU2xzMjJLNXlETUJneHRlYjg1?=
 =?utf-8?B?N1RQbG9qdVJHVU9UODJPNkhVZnlYTkpLamVNRTMvWkRtSDhHaUN1TUc2V2tE?=
 =?utf-8?B?Tk04ZVdaczZkeG94ajczVHhTVWtOQ3lEaFFEc2pMOUI1Uyt3Ukt4SWVqRnJ0?=
 =?utf-8?B?T2FIRlVoYTgxWU9UTDhZbkppa3VhREhWVjZNbDRsdGVFczFtM0RmRTU2NmJO?=
 =?utf-8?B?ZmVNNVJVTnFNWmFVY1czemZuSGpCaXVoQnRJSnp0Um1HTno4dWFDZG54WEFY?=
 =?utf-8?B?UDJ2a3FyZXlhTTMySEI5d0VxbE04NUNRbUdHbWYwLzF5STM4bXlRODI3M1hh?=
 =?utf-8?B?Q0FwRExnTDRkUVBmTmNBK0M3U0tYelVXNnJ3RGlVblFONzlwRkk2Ynl0NHZV?=
 =?utf-8?B?TkxXZHhWZmhGWUo3Y1BERXV1d2g4ZENvNFcyaHEyQmxnYnIxM2lwMVQxV29Q?=
 =?utf-8?B?QTFkbXNzd1RkamJJenYyODU1TUJYTkpoZzJrSjJrTHhtSE5DTzNEZDZob1BI?=
 =?utf-8?B?MXBaMUQ0elRSVmhnb1FuTWRSeXVjcmdFeWMydVA0ZTNMT3RXTnZWZVM5Qy93?=
 =?utf-8?B?QU1hb3JiTGxKcW9XMC9iZlZ4blRJQWdNYTc5dzlVNk13STdxdmxQUk5MekZF?=
 =?utf-8?B?YTFydHcwNjZtTDJ6WkRWWFExMUtVZ0RHdUtEbTBXbjA3SUZxTHdUam8rMFRj?=
 =?utf-8?Q?wh/eoz56u2DBY72gX4yUUVV3O?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7dd4e4-14b2-494f-7417-08dd91252b3d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 07:18:18.6434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2jTKfzhYjHGZMfB46G80QROrkWbh1/5XLyLSBeHQay17hWhqZU2ninwRWpeRu3xw1y3Q0k71YGNxo/di/ajAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4489



On 5/11/2025 3:51 AM, kernel test robot wrote:
> Hi Raju,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on v6.15-rc5]
> [also build test WARNING on linus/master]
> [cannot apply to broonie-spi/for-next next-20250509]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Raju-Rangoju/spi-spi_amd-Add-HIDDMA-basic-write-support/20250510-021954
> base:   v6.15-rc5
> patch link:    https://lore.kernel.org/r/20250509181737.997167-1-Raju.Rangoju%40amd.com
> patch subject: [PATCH] spi: spi_amd: Add HIDDMA basic write support
> config: m68k-randconfig-r111-20250511 (https://download.01.org/0day-ci/archive/20250511/202505110641.zLT16Dv7-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 14.2.0

Thanks for reporting this. We do not support m68k.
Will re-spin v2 with necessary changes in Kconfig.

> reproduce: (https://download.01.org/0day-ci/archive/20250511/202505110641.zLT16Dv7-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202505110641.zLT16Dv7-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
>>> drivers/spi/spi-amd.c:594:57: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>     drivers/spi/spi-amd.c:594:57: sparse:     expected void volatile [noderef] __iomem *addr
>     drivers/spi/spi-amd.c:594:57: sparse:     got void *

