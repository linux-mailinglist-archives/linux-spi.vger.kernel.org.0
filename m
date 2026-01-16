Return-Path: <linux-spi+bounces-12428-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B5CD2D8BE
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 08:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D97230700DF
	for <lists+linux-spi@lfdr.de>; Fri, 16 Jan 2026 07:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98FC2C11F3;
	Fri, 16 Jan 2026 07:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="huAsl/a7"
X-Original-To: linux-spi@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010048.outbound.protection.outlook.com [52.101.85.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C7F1C84B8;
	Fri, 16 Jan 2026 07:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768549869; cv=fail; b=JeF8XrQ5aHa+7wvts27rh5M2mKsv+Dr+x3MfOoiKrG1zRnc8JC4I58iXG72WBUed45uOF1rVzoe1wJZDmNOtl98QlqoinZmuTwgj0hGicP3WMrAGD8HDVR9kv8HCMyNGiQes64AQxHlojSNRTXUGlNIozRD/+9/MMm7rcXyZbVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768549869; c=relaxed/simple;
	bh=oN3ERpiB3soIVd81E5u9RURgSOVCHLjFOcDj7RS/wCo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o/SGFHoNfD2w99iiZN4EOohJXQLDmoudi8PKSvDBvXrp3e06Kuvxw1JjTa9JMr/J339zmlq3ydbDnc+hdQG8Wlw50Wgv7Bl7Wu8ARTnoik+sweqvjgFBzFZnkDxjxE2SOgjwEoLbm5cNrcuRsbQNSt3YYB/rveQMwbt2Ml6FWh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=huAsl/a7; arc=fail smtp.client-ip=52.101.85.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXFu2Yj3G8qqRDJPdK1buxQ3CbseQQuKMHmCWo1g4egnt5ho+c7RuWhjkKt/z0qXqvN99Exhky4d0Ftco0mhYrWIUTyb4acUTkZ2jQcQe7IjZ2GXpoFn9Tw4xy2t2C7RH6NTtYutITP/P6pv+YukDm+MnoWLV4ZEG+7ShecCCMfMwVT7vyV2mfZNospypWELyV5fLh12BdkpKvCZE/5qdKHKVSnJ44AMg6KJ+JrtBHoenGsJWdPwZ4qBqc/r/mG6I8hLRLfaLrVF0eK5Snl/IEC3T0dxsQSDGAKhz4BmRg4XZgRjPig6wwOB/DydVHa3iky1iAbbE7MLuDcKPqBhbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Adx6ZoSOqnHWaceoQme/w9qxlXNsEw9KL3Z0pzn4L7I=;
 b=i5lBjXTncV5DVAcQcIchHwQdBIOVgI/LDjEbpboIUZO3wMrGBWyJScPNP9C0ZBq8S35T2TizeZiPIeS8P079BWbttk3PsMwk+9zwmAGyyFpLsjCcFWdYbn96pOdcFb2lQN5y56bca3ZonADyJWE9A/u4FXgu6DfLSC95PSGJpi6XHIcSd9mTkJ5cAXP7EbW/sBEbL8yUAS3tnjuOtHhF4mr0wE/dg73Yfb2x4euOzSzEe4Z3r559v0oTKBxifZUAcxSwVh0QLXMa5xOzFVv/+8cIByEK7JUWifiqFhT9xuPXCCKJ0kzu0rARPEIiRIeDF7uD5SpcAZKDXxaukkqX2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Adx6ZoSOqnHWaceoQme/w9qxlXNsEw9KL3Z0pzn4L7I=;
 b=huAsl/a7LXqyLYNj+Y2yyaznwcGuPftMChppaLgly2dbyTCOxeIjmS9JkkcGmQpfYssucq7H7nvhspMAs8e0v7nLK1CdLBVHfTQnVPtvBvyLU675OuYwxHLkr0Hcg2yZDEpZlHQ0ObweSjhUHluTBUcw//HrK2WU+T9ixnuHGRM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB6209.namprd12.prod.outlook.com (2603:10b6:208:3e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Fri, 16 Jan
 2026 07:51:04 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 07:51:04 +0000
Message-ID: <b3c81793-32f8-4b2c-a32d-bc90024580ca@amd.com>
Date: Fri, 16 Jan 2026 08:51:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: xilinx: use device property accessors.
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>,
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260115003328.26095-1-abdurrahman@nexthop.ai>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260115003328.26095-1-abdurrahman@nexthop.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0194.namprd04.prod.outlook.com
 (2603:10b6:303:86::19) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c952609-0453-42d6-3b74-08de54d40034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmk1bXkzMlRBVWN3bDFzUzhwSkNGc09Id2EwdFg3TEhiWGNFR2ZEeGx5WG9N?=
 =?utf-8?B?eGNRbDdGbUtnOUJhMzlUNFBiQWozbEc0WTFIM3M1U1ZvRE9zd3BPV1l1bDlj?=
 =?utf-8?B?RmtMUzhVejVKTVBtbEFULzI5TllsaFdTR1JKUnlLRXRHbXZ3S0g0VTdtREtD?=
 =?utf-8?B?Nmk0RXdHTEtoUlpwVHhrcG9wekFyR3lZSGpJVmtpZFNKZHVNMU9qeW5xejhF?=
 =?utf-8?B?QjRpU0E1ZEN4VkNRclRYWkMvckxPMmNvWUo5NlRHWnUxOU9MV055V0pacXp3?=
 =?utf-8?B?SVBRa0oyZEdXOGdBTzJSRGNVUGU5RjhLSjNJV3V4TlkwWWEwOU0yK2Z4TXIw?=
 =?utf-8?B?Y01KUjhMS3RqVXk3Qm92ZGpScXQ3S0tQVkZJb2NCN1N0bDFqdlNxc0s1VW5I?=
 =?utf-8?B?WEVkeVhtbnptWFBZSHlHbElxSnRZYlErbEROVTJ5M2oxYTl4Y2dERm5GbGU3?=
 =?utf-8?B?Z3BjUWJ0dEphcndXZlhuQXhUWXpFRE1BL2ZQNENZSjVvWHc3NEZRTXpscHlD?=
 =?utf-8?B?bHlpNFRiSUVpSk5FYUxXTkpHamtORjFJVkhxRXFuU21DZlR4RDdEdnNrR3R1?=
 =?utf-8?B?VllzZDFNMkVLelpaaHBKZ21NRHk1b0hTcnk1YTB2WWRuTk9lRVc5Y1Y3WGJo?=
 =?utf-8?B?U3pjVm45TjEvTWVpc2JPWFF0Vjc4VkNTRW9rRnl6UG52bWxQek55NDkxNDBx?=
 =?utf-8?B?dXVoVzJscGRJcXE4QnFWZzJ2MnpRQmRKSEh6VzBidHZjTElTMDUzT25sbjUz?=
 =?utf-8?B?NEZPNURHVkJLZ0N1SlhHUCtrV25ZSkNDY0x2NHpoS0V1d0ZJeWpFQjMydlo3?=
 =?utf-8?B?ZG1ndFpFUzVoc2NNMkdKMC8waVI4ZVpJLzM2d2drZisyUGlWRGlmbTVjUkdH?=
 =?utf-8?B?QkRDVUVPbjhRUEltcDFPV090QU51aGZqenk1bnFLL0tHTi9KSnRCVWg0anRq?=
 =?utf-8?B?UGt6UVJTaC9aL0hPRnROSFU5cWpMQW0xQWRVVlY4VkpBZWxOdXAwK2taRXNi?=
 =?utf-8?B?VTBST2VKWU9GUThnWGc3cVc0bjQvRlBsMEZGT0s0ZTRVRDUvb25qK3BkYStl?=
 =?utf-8?B?Z2ZDbTdROXd5cCtEOStqZ2VSaWJyb2toUGg2SHhpWllseVVtRkdaVjdWZ1VS?=
 =?utf-8?B?V2wyMjVjV0QzZHEvRVdYQjZJalJMcmhFTmg2SFVsTnhqM0l5dEZyRTZpRUNT?=
 =?utf-8?B?dlNENlNYMWEvR0hEUjIxR0VtUllua2ZrTGRwbEJlVlEzMUlRdzZOQW8wUVBZ?=
 =?utf-8?B?Qko1RHBNN29yYUY0bnlrbitYeDF5QlFBR3AzMVMwakJCeXh0a0tndHk4ejlC?=
 =?utf-8?B?L09BRlUzUGsvR250RVJJc1p1RjhPT3NiajA4dVRUaUdWQVRFY1g0NWxMbXBi?=
 =?utf-8?B?QmhUZFBlTlRNQ3VrVitZSjVYeXduRHIxNWUzZ1phd1lpZ0pTYXFaMmRzZGFj?=
 =?utf-8?B?VU44SzZLdmcrdXdRaWVrQlN3V2ZjbDl5b0QzZ1lOalVpcGxwZ014QmZ3VDh0?=
 =?utf-8?B?cEhyQnA2aG4wVHNNbFA1eXhvRHgzMHBhNHg1WU0zM1QxOVBLZ0lKTHpCKzI2?=
 =?utf-8?B?R2RoMnE4b2o1N3RydFI0OHFIaXdrOUtFMGRLaXpYM0UzRytlTWNYWk45VnpX?=
 =?utf-8?B?MTQ2cm9SZWZXMERVSmxodDJBRUVpcWZwQVBWeDhjdGJiMUVrM0Q4SDByeVAw?=
 =?utf-8?B?WVRjYVZxREhxTlhRN1VURkZkM3FKYVE2aWVyVTdEQWZMRlFTSVBydlRNN1Vo?=
 =?utf-8?B?QVA4TUgyc3ZtM2JBMHJSYit6WDNadHU0czh1V0d6SEVYNjRlYWpKRlZ2SnR1?=
 =?utf-8?B?dTVGYWxJMmxPbnU5WUhNY0hpamRRaVJOVkZjdURaamxpTkM1cmFwdXFrNFl1?=
 =?utf-8?B?TnZXVUF4bDlkRUFMU0ZOMmhPNlk0N3lscmdrVnJKTVdMK3Z1c0x5QTEzeGlZ?=
 =?utf-8?B?dTdzWTlkK2Erc0N6b0lCSERlcW9rdXAxaC9nWWpzM2NqNC82UUQxbFNBd1JW?=
 =?utf-8?B?L1U2MDVDUTdCYXNIMmVYZGh5Y1EvTHZObWRHMnE0dnlqcytXQ1pZSUFnSVZt?=
 =?utf-8?B?Tm4rRUw2RlFDSXJNRkJKTGRSZG1OY21KUlZ3ejQxRmJ4a2U4MGhmaXlEMHdV?=
 =?utf-8?Q?fkVY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3YydGdsWVJNMVc4cytDUDhPU0RpTjliN0V5cXBMaTlwSXBHRWVJSG8rcFAv?=
 =?utf-8?B?ZGt4WnFsTkxXeWV3bExsREcwNDd3aUYyN3R6V1BOUHhwd29uRzFUaGkzc3k5?=
 =?utf-8?B?eHZBYURPS2xLMGNjMGpKVTNFYzkzb1FHazUvekc0ZzhmYzF0SnFzTnpCR1JK?=
 =?utf-8?B?anBRNlpNdlN0dC9oWjd2dXRKZnFXcGZ3aTc5U2lHUDZmZGZoMGtoNWdzcUxp?=
 =?utf-8?B?Yk9mc2JtOE50NE05Uk9FdmZsa2wreWNMN2J0VmlrYmlXVjljdVhaOWZyWEpr?=
 =?utf-8?B?cFY5aUNjcWJJcnRvRUVDUnkwUFNOM0oyVXp4eXp6bG5DQkdzTHBESGFjMWVm?=
 =?utf-8?B?TlVQKzdEZlI1amd6U2t0OENZRmlheWQvWmVKS1lpN0JxWm5FMUNsTkdBRDhG?=
 =?utf-8?B?NVJsZG9BSnlRTUFMcEp5cUdoWUZLUk1JODBibVJRRUF0c0kwUTVPNmZ2VUEw?=
 =?utf-8?B?TGk5cVQ4aTd5KzlFWERyemllMVN1YXhoQnZReEo2bGp0TThEcHhOY3JLcExH?=
 =?utf-8?B?S04rcEJPd0d5RzQzQmE4RFZRRXl2bEV3U2syaklCSERTYnpkSWxiT0dpVk1l?=
 =?utf-8?B?TzlhcmRSTURXbDc0SEt4ZkJxMlRKOTNzY0JPSjNTNTltdWFFdk1CS2dhQXdo?=
 =?utf-8?B?eFd6L1ZPVjlwSVR3U1RPZnN1REhGUDFjNTdDcDFVVTNwWEtFTVBpdjliZk9i?=
 =?utf-8?B?ZHFkd3crK0FiYUl1OStRcVJ1VHR1QTJSa3BkVEdBM1Y5OFczaC9UeWxhcE9z?=
 =?utf-8?B?TUg3YkgycHc1M05rc2dEN0ZiS3VNS2FyUUQyQmFqb0t4QUlDZ1hoZzRDb1Jy?=
 =?utf-8?B?dEN1YkZmQUtCNjB0VEhaQzF4ajd6ZmltNmRPNmZXQ29ZalVpL3ZyemlJdHhJ?=
 =?utf-8?B?VTNlTisvK08rWHlLd3M2OWJ2MGRxZlVaSEwyUGVPSTFMMUtvK2lIWmNHRy83?=
 =?utf-8?B?WSt3eDNOZmV2Tk81OFFlanFUL3p2Z2xDMVVPaDVTRlA5SUN0L0svNHdTcmF2?=
 =?utf-8?B?WGo0dXpERG4xYU4rNVR6Q08wSHpsVUJRUlQ5dFM0OGN4Z2hqYXNLRis5bUp5?=
 =?utf-8?B?UzVha2xsVGRNdzVRd0NPcDNXMStPWmp5c1FLTUs5L2wrbHlYVlZsQ0NNSnZM?=
 =?utf-8?B?aW5DVW4rVi9iY1dTbjlsWjRDbDkvcTZ1SEw3K1B6dTU0dnRzTk9RSS9LSzcz?=
 =?utf-8?B?bGpNT2Nla1F2a3F4a3BXTDdKVlFPb1FsUlpVQVNjMXlsWDBqQTVKWXZZaGFB?=
 =?utf-8?B?TWtTcldRWkVFQldSS3BSbHpzYjV5NnhDQ1Nta04xQWozKzJEZlRGc1pOZWdO?=
 =?utf-8?B?eStJc2NkV3hEWDNZUGRhL1NucndkeUoyZ01tUkl6MExHaGxLMGtkbUx3bmU0?=
 =?utf-8?B?aUxYN0hjMWhMaUdOTHd3UkI0K1ZjU09QWnJYbnppVCt3UXp3Z2xrdXpia2E5?=
 =?utf-8?B?OFQrcC9lMnJ5WVlwRTR3UDRGdU9VLzBzdXZUQ3NYa20rWlRvSis3dEsxdVMv?=
 =?utf-8?B?NzRvVG40VVNxV3k5VFdLU0h4eWc5NXhOSzdOcnJmOGQrUWVrSWMwZUdWaDhE?=
 =?utf-8?B?UnlqVEcyeEkxSVhTdjM2RmlBaGFIQjc4dGo1VWNRYUQzblQyNHo1eGpvVmp1?=
 =?utf-8?B?L2U5S2ovd1BoUXhZV05JdHNEVTlsbW03dVB3MWF0c2JKMWNxNzhkZVNOcWdD?=
 =?utf-8?B?TEhGeFhMbytPaHFheGhBVzcvVmZDUjJmdDdEdVpmNExZbWQ2ZmJMMVJmR0k5?=
 =?utf-8?B?WnVlUE1Vd3VyRlRNNUZFaDdQNnBSUmZLSGxyR0JQK2hGRVcrQzdGb3hTOGk5?=
 =?utf-8?B?MXBBK2NNNC8vYThKOXVTcEZ6OFErNDUrYk16SkdLWkRtYTJhdCtTYUNzTGpz?=
 =?utf-8?B?bm5qTjhWdjdzY0dUQU5hUlVueGdEcjF3U1pWaHh4RndVRFhvUW81TEVUMEp3?=
 =?utf-8?B?aFVsRU91ZG11Qk45WnlnWWhJbmI2RXl4dkVwdjg3WnNaUURhSzVTQ2RrV25D?=
 =?utf-8?B?OW5hQUk5cEJFR1pvRm9QemlUKzJPRDJ2QTVNemdUQXpHN1djd1ovK1duQm51?=
 =?utf-8?B?U2NxZ0RMQlZsWWJ0dnRYYXpRdFcvQzdNY0dXYXMyVm0wY1JsT0lMQ2REZFpp?=
 =?utf-8?B?WFVHMFhjUVp3ZzRxWGZoNU0waW83L2xNMXo5a1FsdW1HczVmNDF5M05LTVFU?=
 =?utf-8?B?M0hUZUwzUndnSlUxZWovdWlwUUliVC9KS0RneGJaQ2xrbURRZk9JRHhvVTNR?=
 =?utf-8?B?em9waHZwdkcrS2VUUnprV2NmMldPZ3ljM3E4UXMvZEVMQW9sTnB6T3pGb09s?=
 =?utf-8?B?NHFVQ1VjN3Z4R3pOSGdLK0NmZkxTcDE3S2JzRG9SQVN1ZWVwRUUyZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c952609-0453-42d6-3b74-08de54d40034
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 07:51:04.7599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfvZYaljAVmKdTkYb/uvUp6/mxo+GNPX/wUN+qj2j2BBVaF9vvnE95p7xw+LF6rq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6209



On 1/15/26 01:33, Abdurrahman Hussain wrote:
> This makes the driver work on non-OF platforms.
> Also, make irq optional, since the driver can already work in
> polling mode.
> 
> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> ---
>   drivers/spi/spi-xilinx.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
> index c86dc56f38b4..9fb1da2fcce4 100644
> --- a/drivers/spi/spi-xilinx.c
> +++ b/drivers/spi/spi-xilinx.c
> @@ -405,11 +405,11 @@ static int xilinx_spi_probe(struct platform_device *pdev)
>   		bits_per_word = pdata->bits_per_word;
>   		force_irq = pdata->force_irq;
>   	} else {
> -		of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-bits",
> -					  &num_cs);
> -		ret = of_property_read_u32(pdev->dev.of_node,
> -					   "xlnx,num-transfer-bits",
> -					   &bits_per_word);
> +		device_property_read_u32(&pdev->dev, "xlnx,num-ss-bits",
> +					 &num_cs);
> +		ret = device_property_read_u32(&pdev->dev,
> +					       "xlnx,num-transfer-bits",
> +					       &bits_per_word);
>   		if (ret)
>   			bits_per_word = 8;
>   	}
> @@ -471,7 +471,7 @@ static int xilinx_spi_probe(struct platform_device *pdev)
>   	xspi->bytes_per_word = bits_per_word / 8;
>   	xspi->buffer_size = xilinx_spi_find_buffer_size(xspi);
>   
> -	xspi->irq = platform_get_irq(pdev, 0);
> +	xspi->irq = platform_get_irq_optional(pdev, 0);
>   	if (xspi->irq < 0 && xspi->irq != -ENXIO) {
>   		return xspi->irq;
>   	} else if (xspi->irq >= 0) {


I expect this is another IP which you are using on systems with ACPI.
Can you share ASL fragment you use for testing?

Thanks,
Michal

