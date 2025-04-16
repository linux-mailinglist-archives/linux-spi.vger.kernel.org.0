Return-Path: <linux-spi+bounces-7625-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 792A1A9060F
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 16:20:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F178E46F4
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 14:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CD51B3955;
	Wed, 16 Apr 2025 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HW/9vdR0"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7596155C82;
	Wed, 16 Apr 2025 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744812698; cv=fail; b=L121SJn8bRgZd68/6Gkls/Fkc3BxoYkVHqmADgn6qVhQQBIInfHmySxry7eYUM96eUvSMKF4hQhE+ZIE83K4rGBfuBkT7dbGuIynHVfA/K5/iaEfVx8hwkiQ3g9G7AnEgb1QxyBCSkoYhQPiOtRveQzFMJ6MleNJMGCkKakxhxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744812698; c=relaxed/simple;
	bh=FD2syU9o7JxWTlOlEimC1aeSeB4oRnz4Rt+J66JxCwQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gc1KANgRlobWTMG4TthIRhYu9FxKfQc0wk6oNPi/G0IWR+2yOc1p47sEy69AdVxsrAzCSfSIinzEvlkTFxiLBU+p7hdMlJ/SZN3u+z9lBktWkmrRx8EyMSRTKHwdFWvJI+Y1KYAdwEQCHL/VFwuoN3nmgh7oEqpj5epkUWWZa4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HW/9vdR0; arc=fail smtp.client-ip=40.107.102.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k2naSzGJs5MQcM+jNpyLySo9tNRCle6GnaXC0CPlcZC/S/J8X2YJ6hxudS3fm6eO4/4J0HAvtm3pUChSswoRbeX2oYEmRuWnDUp3h4EkGOter2n/Qf+riDIW4GwMZPFJddgdq3SdQH2vzfu7DYlN2wgXb5GcBKKe6FMbI1CcmaQDfRGxb/Eky04qzvTAbLPn+G2cuyN8jQm3Qb1uRkSHHRnBh9SWqOl7485Kc6lHSCyGsnq1Thu7qC5mXQqW8hcobPptGs9shBUfEg69cyDFTMd2wB4quRptpqty4PXhxuDPQBv695Ia/w22YPrckyY3VWcABPzrFShWMLC2TGhiRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzfVtqD58qTC90UAk+XXZfJ/qWHmQdcLcDLBVxR+ClM=;
 b=PF3hYxWvwM9bI4h16QliXs+MTejw6kBc5UQM12fI87negBJ66388Oahy+d6mgjiHT2gPneyvszyU1xdNGrJj9/KWLMIr5mohfZn3NgXNv/M7iqdGBxhKkLi8OWFxRYt6XfKPObI7UwWuhogg8baCSK0iEGQj0HIUZiRkZAM4u3N93hKYgTGaQjmGMUpu3l61yLpE9jz/IvseP5ubdBp6nVEYxmbODOAiZ7M2tgs9SD5QxJVaksGeal6qFBJpUZXWdLcW7mai68riCLTSnn5LD0J+Z7p3mh4inFAeVFPoikyO18GLqj5hEYYH2ulNShEaHhSkaQQf794iZjFl2z4aaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzfVtqD58qTC90UAk+XXZfJ/qWHmQdcLcDLBVxR+ClM=;
 b=HW/9vdR00/L+G6Hi7hfLACe4hCTekN8sPIeZJxyR/aW2w6e2bPetxqnqx+VrUkI8blxIa4dxe13vlZkYwq0HwYrTRCgLhsHYDAMzCVuveDRmWjP2jFGUPXf1gsg59sXNIgk/v8M6O90G0tPuuiZvthseUlRnbX8xcLcjcI7s8vFqmmxdzS9Q8aIGtrwPo+V3u5d8SxBtwtY/7VpxKpLQ7XHVDatDVw04pQc0DD9L8BW+4hJ8pXi/l7RofLkSQclvZpK6vRpRA3LvO2MTkpIPlrE1ud/c53BA8ubHV/UvAJM0StLZzdIHqhEzTnXgjPh7w9CeHMlvriISzF1pSOraFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by MW6PR12MB8914.namprd12.prod.outlook.com (2603:10b6:303:244::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Wed, 16 Apr
 2025 14:11:34 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8655.022; Wed, 16 Apr 2025
 14:11:33 +0000
Message-ID: <a71d147c-ea95-41e6-b631-f889a18888d4@nvidia.com>
Date: Wed, 16 Apr 2025 15:11:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] arm64: tegra: Configure QSPI clocks and add DMA
To: Vishwaroop A <va@nvidia.com>, thierry.reding@gmail.com,
 skomatineni@nvidia.com, ldewangan@nvidia.com, broonie@kernel.org,
 linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, kyarlagadda@nvidia.com, smangipudi@nvidia.com
References: <20250416110606.2737315-1-va@nvidia.com>
 <20250416110606.2737315-5-va@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250416110606.2737315-5-va@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0008.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::11) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|MW6PR12MB8914:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cf026c1-c112-4c92-75ef-08dd7cf097a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEhqNTU0aU9wamlEeEh4T29JSWR1S3EyWXZKcGE1WGxGbzN0bjZmODM1bW5N?=
 =?utf-8?B?UFdweWRya2FKMG95WGJkMXByWWJJSzA3b3ZXZGZJdHh0ZVBHaWtvZFkrQi9P?=
 =?utf-8?B?RlpJbi8xYmxpa2JlVjhjK3RZSGtDSHJaMHVYcnBqYVc3b1M3ejdsREx6SzRX?=
 =?utf-8?B?dVpOMXNKS0FLWWJYL1F2R3VNSG5XSFdrcXRKZ3dSd0ovRDBJMVVSbDRsWFFG?=
 =?utf-8?B?Z3ZRZ0NRVEgvR2VGZWtoV1oyY24vaXcwRkJoVFAyYStmOXg0YUhHKzkzY2RK?=
 =?utf-8?B?OW9xMmRQcC9OSWdWVnJxRXBiTEx4ek9oU3dPcUZ6aytBa2JYdVRYOS9xandV?=
 =?utf-8?B?dTNxKzZZUmpSclU1ZlgyeGZDZWM5cS96ZUhFUGZGdDA4bUsvQ1gxWWNmUllW?=
 =?utf-8?B?a1ZIY0R2UWMrRkE5SzhPb2ZSZWlVL2xwNUVIN3E2WFpDaVBDeVZIUjBHeEpM?=
 =?utf-8?B?d04wRitjanVCM2R3RUlmTjh6QTVId3lJZnpSODh3RGZnUzVzb01JcVhGTnNj?=
 =?utf-8?B?aG1LL0FDek14Qyt2Y0luazFNSkJRM0RVMlpkSENDQWNXN29DcWRpQWtSY2J2?=
 =?utf-8?B?RXlTYkxnbGV3c2RYcGltVlNvM3VwVThLamdpVWVWQ0c5R3lUZTZPTmNGMEM2?=
 =?utf-8?B?QjZSQWc3MW5IK0pKSjZyMnY3clRRMDVweU1tWGdlQ1lOblc1Y2NWRC81ZjEx?=
 =?utf-8?B?U0plSGJhcnhMNGtPMmd5QytUc1M2Q3BFR2s0dkpPMFd5a3hUc2VycTVsMUta?=
 =?utf-8?B?T1djSlpzNjRGR05nZ0ZlcU5BTlpNOHozU3VzaDdJSGwvdHA4Vjdsci9NcXN0?=
 =?utf-8?B?dmdXT0JYOXY5alhRdE1pdGREajlRWE5kOENGQTVBNzJwdGE1MlNNNU1USWQ3?=
 =?utf-8?B?a2xVUGtwZVkveGhqcXFhNUFtQWRQQnpVZmNhNHRERnFMc0JXQ3VkZ0MwUGd0?=
 =?utf-8?B?TGVjZVVZb0YwSm94SUVqd01Ec21PVzdVcUZVQm1VZk5MOXVwVE1VczdLeFha?=
 =?utf-8?B?WDdJK2NsVm5UNFN3eW9vejBwc0dhRXdlT2hmUmVLek1pSzNZM3p4TGp1TzE5?=
 =?utf-8?B?dGErT1AwSytZVXVqSDUxYzM0NW03eVRBbHF3SjV4bGhyejBmQkZlODRUTUxB?=
 =?utf-8?B?aXhGREpqdVEvejJGUkV4MEo5SVhPL1B6WXZXZG5Ta1F6RGxjZThCT3AzTmtk?=
 =?utf-8?B?RlgwZDNpaHVpeGpYcGNabnE2YTUySTJjSmxVcnY4UnFIbC9BaDZodzh5dHc0?=
 =?utf-8?B?SWcxQ3R1cVFzMVB4N29vSmNCNTU0ejMwMDZ6TklhWnVlNzhQcm1kYURFSDRC?=
 =?utf-8?B?VjZxeGdjMUNuU1lCS2hub09WNWVENkIya0w2cVlLNmxUcWp0Q1I2aUN4RWMy?=
 =?utf-8?B?L280WmZJeUI3WTdhaUVnT2FGOGl4OTVCOWRCM0FvakJVd2tIQWpvZ1NOR09T?=
 =?utf-8?B?RWswN05Uai9IMnJoSHJ4UFdvWXZDVFhCZXVLMS82c0dZRnp4Nzl5M1YveExP?=
 =?utf-8?B?ZDFRVG1jV1BDTkpwZG9abWwzRzdnTTEydUxEbnIzVzJNdm1wRkVGa29jSUpB?=
 =?utf-8?B?T0xNQWZmNnVVN2FnbUw4K1AzSzF3bzNLL1l1a3ViamlXU3Noc0dVenNFVE5C?=
 =?utf-8?B?SVFBN3pZRjU4Zkt6RXJYY0xlYVkvamFEY3N5UFN6WjJDaGQ2cUNKdGVxVmNm?=
 =?utf-8?B?OFhEVWlJdlVFN0cxR1A4TGhQYmY0YnAvQ0lWZWJMd1NlNTJheTJocC9BVmtj?=
 =?utf-8?B?MFNZRTg2OEpUaXJja3hJYXN5eE9HUmZOWWlRY3BMTy9tYUU4Y2tUR3BaMFhP?=
 =?utf-8?B?N1d5U0M3UGFhODFGcEk5TXBzWEpLN0VDdnNiejV1elFQQ3RBS015QWI3SGpH?=
 =?utf-8?B?eXA5bEVaTzR2TmpIL3czSWNnVzF5WFZaRmR6M1NMY3ZVdExzcStsRmtzNmta?=
 =?utf-8?B?RWVkazVIOUw5UGFpbk9zSVNWQ3VRc0NYMTA3eWVVNlozdDYrMVVRNmVwM1RD?=
 =?utf-8?B?N25uU0RSWEZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3Z2aGtIc21lZUNuQTFYYTE5Tm9wWkFwT3RrYU9SeEZGOTRuSW16U2s4QjNH?=
 =?utf-8?B?d1FRczd0VWhhZU53cE4zbjV3emFSM1J4VFF2SzNxL3dBbHQ5V0xIQjI1bGxW?=
 =?utf-8?B?MmR2WUxZN20rVUdDT2ppLzJTam9KRHVqd3kxeEhkRGlHeVFDbWZhUHFEamc0?=
 =?utf-8?B?NEdwSGQ0MWlSMmNIa3dDRVVSNUdaTzAwR3A5NkN1Wk5Eb3NpeUdkUmdPSG14?=
 =?utf-8?B?TXg0bzF2aURPSkdhYTJyM2lSaVJoWHAxQXJOUlV3OGJVMElJaExEQXp0V0tm?=
 =?utf-8?B?TitGZ0tnUlRCaUZBQ1VpK3ExcHAxcFR2cjZNTnpOMmIrNHpodEUxcTVoUEZi?=
 =?utf-8?B?UllTcm51N2xsS2I4VGd5aTlGWlJxZENyeGZZY004YVc1bFpCbFlyM2l6WGYz?=
 =?utf-8?B?aGJDL0dWeUZGTk5hK2NNcWxHYi82cWloVTIxeFl3TVlNY3RiRWJJVWRmL29o?=
 =?utf-8?B?WXg0SXN5dEtFeksrbTVFaEhmUDlCYTA5NW44TGFRSkRBNi9mdjBaSm96RU5C?=
 =?utf-8?B?OU8vV0pDckpiYWVGaVZKWlFXeHc4OTZUQytWU1liZmNYODdLaTNqc012M1Zm?=
 =?utf-8?B?TzVPU1JCNWc4a0R0UlJNeEhTeHJ3bGpnSFZqd3VmZlFPVWV1Q3g2RGd4eThX?=
 =?utf-8?B?emV4R3o3eEpicmJXdGpuVEhlcE9NMTZZME5jQm1hbC9vS1JhVHIyakV3WUZO?=
 =?utf-8?B?c24va1ZEMFdicWc0c1hueEYrbXNqdkNlNFBzUDNVMCtJeDBqQ3RFQU5nZVdJ?=
 =?utf-8?B?bzdrNC9aZnZtU1NSam9FMTFsWGY1cWlTY0c5QW9teTlQaVZtMGNqd1Fnemkx?=
 =?utf-8?B?WU1oTVBzeDhGWThESUNNMkQyeVNTTmIrck1LZUl1bmdaeGUySVRtSHZERFNl?=
 =?utf-8?B?TUlwZ1Y5eEJyS1VLTFZtMkpZSHlpb1Rsdy9MSFFmNnl6bXlnazh6MVlyREMw?=
 =?utf-8?B?bW8zSFJjeEYyYUlQbFRDZmZCbDlHM0FXMEVReWhGeUhDNktwelAwY0l6elFv?=
 =?utf-8?B?MktYWUttY29DU0hFZWdYb0I4Y2U0b1RpaG5SNTJkWFp3YThPOGhlYnhzSkhv?=
 =?utf-8?B?RmRzMFp4ekdIeFhkZTdsWnBtYU1QMnJ0cmRsWS9ZWFIxWjlKZnRJMDg4cmFV?=
 =?utf-8?B?bTl6bXFOTjdFbHNpVngycHoxY0J1WTBoQ0VrMnJMbjA3cm96b2ZpMldkTnJZ?=
 =?utf-8?B?cWV1TmV6WXBGSWtGL1N2R1JqWWpnNVJVbGIrdURQSmxKdDJ4R0FvY0VSTHBI?=
 =?utf-8?B?c201cGV6WTIvVVpPdnBtTXE3QlFISUlYSTRiUk5WNTducmJ6K09uMlh1VzVI?=
 =?utf-8?B?QUZVNnU3ME1NU0JjL2tNV2l4eTFuZm5ZcXZPTGplSVRBd0NScXI2TXB3WkUx?=
 =?utf-8?B?MER3UFlIUDNlYTUvVEY2ak0vU21zSkJ3SmZuZ0hKZytmNWtQVlhYRkdTakhJ?=
 =?utf-8?B?MWU1MGRCZkdwQWlFK1pGbmg2ZSs4bXZWczdoa2hMVDlmUlE1WlRIMHlmdkpT?=
 =?utf-8?B?aEhaVUljaUx4TFdZUU9JNW1lQVZKMkxFQWx0ditsd1JvWGFYQVYzR0h4TWdW?=
 =?utf-8?B?eGZQckRDVkZzQ3ZWeWhSOHRaNU9RSDVUL0F3ZEtLMTIzbWpwR1BmdEtBV1Fa?=
 =?utf-8?B?TnFFRWVGM2RmMUlPUEdYNisrbEMvbDYvK291S0ZGSFd6NE9Yd1ZJR0ZiQTE4?=
 =?utf-8?B?UUtWMkFYZEhuQjdlQlExalBIN3ZJWG1pSHNxSk9XRlBGTkxSNEQxblBZdSt4?=
 =?utf-8?B?ZndOQWp0dytUVHBJZWlxQWxWTFZVT3d0Rm1JcGhkSktLWGxBL1FiSjlIM0Vi?=
 =?utf-8?B?TW1qUzRXTXJSc2FiaDIzQVhmaXdsRk5oYXdCMmVFaGYzWXBxWEhCcWVPenRh?=
 =?utf-8?B?R0IyVk9oNkJja1J1SHNHdDF3YldjTWkyMExlVXJXNW5scnFFYUk1YndyUEgx?=
 =?utf-8?B?ekFUT2VqaUw2TEFBam1SOGtITHNHK29ncm9INnR3Z3pTNi9NcGFiWnd4eDRH?=
 =?utf-8?B?Nk50a2tsTmkxWUZpYjFhcGllNFpjdCtBUmlQK3NlTFdaL0pYZGtMMEFWYnU0?=
 =?utf-8?B?a0dIdEtoOTB6UzFiUFRSWUR1R3pnNXFmdzQvdzNJT2xUVGhoNGFVUm5md2Fl?=
 =?utf-8?B?aWMwb2wrNkQydHBKUWJkVVBKbm5JTHpRTnZ4V1FJY2N4OWF2TzAxb2NPRStj?=
 =?utf-8?B?WHE3cWlDcmtJb1RFU1FtRlgyODFMQmdFd2VXakNiWi9FZVpZb2N3UEY4VWw4?=
 =?utf-8?B?ZEl4VVZxT3pUQWJuek1LaFFObVNBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf026c1-c112-4c92-75ef-08dd7cf097a7
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 14:11:33.7846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rnspYJml9xUgXV3M9dOuTlXHmXmSEtkozb4pTU0JIFBoMuRh91gCXQhj/gz9f3G0oZjQKJfMCw2eW6FIDSuIBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8914


On 16/04/2025 12:06, Vishwaroop A wrote:
> For Tegra234 devices, set QSPI0_2X_PM to 199.99 MHz and QSPI0_PM to
> 99.99 MHz using PLLC as the parent clock. These frequencies enable
> Quad IO reads at up to 99.99 MHz, the maximum achievable given PLL
> and clock divider limitations.

No mention of adding the iommus property here.

> Signed-off-by: Vishwaroop A <va@nvidia.com>
> ---
>   arch/arm64/boot/dts/nvidia/tegra234.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> index 2601b43b2d8c..419dde2bfdf9 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
> @@ -2948,6 +2948,11 @@
>   				 <&bpmp TEGRA234_CLK_QSPI0_PM>;
>   			clock-names = "qspi", "qspi_out";
>   			resets = <&bpmp TEGRA234_RESET_QSPI0>;
> +			iommus = <&smmu_niso1 TEGRA234_SID_QSPI0>;
> +			assigned-clocks = <&bpmp TEGRA234_CLK_QSPI0_2X_PM>,
> +					  <&bpmp TEGRA234_CLK_QSPI0_PM>;
> +			assigned-clock-rates = <199999999 99999999>;
> +			assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLC>;
>   			status = "disabled";
>   		};
>   
> @@ -3031,6 +3036,11 @@
>   				 <&bpmp TEGRA234_CLK_QSPI1_PM>;
>   			clock-names = "qspi", "qspi_out";
>   			resets = <&bpmp TEGRA234_RESET_QSPI1>;
> +			assigned-clocks = <&bpmp TEGRA234_CLK_QSPI1_2X_PM>,
> +					  <&bpmp TEGRA234_CLK_QSPI1_PM>;
> +			assigned-clock-rates = <199999999 99999999>;
> +			assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLC>;
> +			iommus = <&smmu_niso1 TEGRA234_SID_QSPI1>;

Please be consistent with the ordering of properties.

>   			status = "disabled";
>   		};
>   

-- 
nvpublic


