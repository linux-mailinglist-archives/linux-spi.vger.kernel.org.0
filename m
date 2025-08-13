Return-Path: <linux-spi+bounces-9379-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8D6B24137
	for <lists+linux-spi@lfdr.de>; Wed, 13 Aug 2025 08:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC02118963C4
	for <lists+linux-spi@lfdr.de>; Wed, 13 Aug 2025 06:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A97F2C08DB;
	Wed, 13 Aug 2025 06:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="iyin1ifl"
X-Original-To: linux-spi@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023094.outbound.protection.outlook.com [40.107.44.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1582BEFF9;
	Wed, 13 Aug 2025 06:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755065617; cv=fail; b=cqVVV6dy0nLQfphlrLp2qLIGSMotpt9kaHXihjWwiD8E25DXoDfx44qxlEWDWwx/OQhJ12H55V3EmhyoVi+g2yjQCrn6FlVXXZ7lHWGQkLaAqGT6wycfZa17JPT2QvFMC+EmjPeZMQiLnOpiNqg4dPIPU/EWv5AGGBF2i6wHoYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755065617; c=relaxed/simple;
	bh=iLktWcbs7qzoen3Es+YNUly3JN8/9QV0nir+VhmtyBo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NUwXWJkA5FYcjn2f2hwiuAuctWmuUbhj+1C7omzTBYUVInS/0kIC7NhI2i+z6OGth0TL+YaHEa7QT2OOleXFfRg+DJWbewzRNlc0Xoi3SxXaCWNywYUMXI0NPC8/v11MQEI/VZ/UK6xQ2kFKO9o9lnd5UWtjbnh3QrUc3ANoWSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=iyin1ifl; arc=fail smtp.client-ip=40.107.44.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f91SjOEa4yLR0TfUg108JTIQCIDoP9+CF+It5Fbb+YCN/LYMxlN/B5+wHduCfVA2wtGvkqya7+n7MKYPEPQQsMaEbANjPk0rrf/o8tbn7sQIkLEGnyg8rvknwW2e0FINaCf2zqE5rFEFLVvxxU5QUBKt7f9IuOGoIjCsTjoUpAE5LbbTbvNYAuJvmJxBT1twY9hn4hAB5QBgltOSrlp4XSEyXE9n5wBX8lj1NmUIBFIHWSm+ml1xyWHCq7PZx2sQosKXMpJX2HPzJk1vFz7KXMQh7gM1mnx1dIKI4F47Co2HUkFyjh8zWPehZ0Pf9eG2wCJk2yVCh6I0AeoVe1UZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lq51Ehqu/1M9kOw1rZJ18E935Ni7OOrSviWCuiXeiT4=;
 b=EGlpw8J2Im6MV1+qUwAU2Yx/a3eydNQv4wET6wE9cuuWRyOnv6Cbo2frkLx9zrkFzzK2yFiK3vSVWrTlKqbpjJyrRdR8VVgAWQFoXZSChotnOTa3531t9JkR4dqfcvoJZyW9zR+xmMiiZ3b56RGKJDmRq5KzkI9LweTvKHQxQYaW1Y7LJkwgPzXnmOrKw6NQn9aUG+UcXc/R7P2wG8t78rtOvCGHTmPyUF0xfbmzqvtl0L2xo3JG8ExPDaiTLaa2eBmlO7l8lCxgUwPXzdHw+SUfBb8HJ6mVuFH54iZjdsf9ie+xzzJBnkwJSm4MORl4IgJ4YN4UChZLuwD90FfnrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lq51Ehqu/1M9kOw1rZJ18E935Ni7OOrSviWCuiXeiT4=;
 b=iyin1iflpx3UVobs2z53KxOkU2m83DIXU5wYub1hlPCdVHHa9UjPzFMWsdTdTFU59w0s6spax2U0NKjuXfUwJL+lHFYrNK1Eb6hNpTO1eb557bBfviJKx16RVC9qbkwBT27z2fw0p/W8kqYFU1x+W3hK2xB1OB9ySI72eo9kZ29yVGV1bJzYcEgapl6c4D98/PHfqYpqcIwvMLi3FZRafOd0vbf/D8Xv9oDo0WZ+CnOcsf2qv+ad8TTBN4ZwBzPnw35hNuILsV85A/XpmyLBuWghulxo4kYBfc9/yBYwUPPa+8fg2IdkD9EiIoZhZVygG2QLSs0HVDBCflHPwUSuJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TY1PPFDFA95AE62.apcprd03.prod.outlook.com (2603:1096:408::a70) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Wed, 13 Aug
 2025 06:13:30 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%4]) with mapi id 15.20.9009.021; Wed, 13 Aug 2025
 06:13:30 +0000
Message-ID: <7fab19de-8ed1-4fe5-b2a4-a7e9c13d8424@amlogic.com>
Date: Wed, 13 Aug 2025 14:13:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] spi: dt-bindings: add doc for Amlogic A113L2 SFC
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liang Yang <liang.yang@amlogic.com>,
 Feng Chen <feng.chen@amlogic.com>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org
References: <20250808-spifc-v1-0-ff4e30e26a6b@amlogic.com>
 <20250808-spifc-v1-1-ff4e30e26a6b@amlogic.com>
 <20250808-adamant-fat-raven-38c8b3@kuoka>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <20250808-adamant-fat-raven-38c8b3@kuoka>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TY1PPFDFA95AE62:EE_
X-MS-Office365-Filtering-Correlation-Id: bf9a058f-3bd9-4941-a696-08ddda308665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUpnZWV4NHdqaklZbXlpam5LLzA0dVcrYm9oNDVnUWR4UVk2S3FKdU5RTkx6?=
 =?utf-8?B?dlZ4TkR1TGJ2TmttVnJoTU1Db1hqOVpycXJrOVpzRGhWcHlYZkoybEh1WGU0?=
 =?utf-8?B?NnBWTmhGanNpUDloZFN1dFB6S0lVTUlYd0UzbUdncjU5WFB5WFptZlk0THZV?=
 =?utf-8?B?MUpxYllMYzRlekxtL0xmaERjSGYvNGF0WDlJTzMvZG5SMmlTNjlRYmxLZ0Ji?=
 =?utf-8?B?dU8rNHh1TnhNN3hrZlRaYzhMK1JXdnEybFFVcWN0Nk9GOUFrVlRNbTZXOVF5?=
 =?utf-8?B?OWNHQ0VjcWpKU3NQOUhobVYyYUFmVHNQT3RJN1duUTQ3Q3N1dmVacC9jQzBz?=
 =?utf-8?B?dWgxeXE2R2F2Y3hBWWMxbUxBN0FUSFNPb2hUMk5oLzRDQjc4OVloTHcrZG1X?=
 =?utf-8?B?Y3oxb25PeDlUMVBXSlZiczBZRXd0Qm1pL01oRjNaZXFTeEpVc0REb1h2a09j?=
 =?utf-8?B?T2s5cTZzaWtxa25FZzJwcnFBWkZZMlBTMmVIekllY2FyVnFVa3BjQWk0S2Mz?=
 =?utf-8?B?RFRYMzdEbFE4RVo1emd4bFYyQ3JwWXZQMXprNFMyVjVOSEtmTEZZVjdTbXdT?=
 =?utf-8?B?UjNjTHJUNmV5Q285SEFoN1QyeHA0bUZsSllwZ0p6NnR3Ukp5aG80Q015Mmta?=
 =?utf-8?B?K0pvMFUraEcxSEgwVUZwYmRwL0RSdXFQNkoxRkM2d2dDQm9aL1ZBMkpmQ2pM?=
 =?utf-8?B?QUZvV1E3Q2RRTUUwV1ZWK3Y1MEZQRlJKV1pMS1h6aHg5QS9kNU5pRzEveHVZ?=
 =?utf-8?B?RjlQbkhmVHRrVzZKbzkvWDBJbGh3Tmxla0phd25Kb2lSNWdnMjNmbFAzdlpB?=
 =?utf-8?B?RjFPNXMrMWNnNlM3NE9QQzR4NkczWXZwa1BBZk5DWFlUVnk2TTRDOEhEQjRF?=
 =?utf-8?B?WTg2dEF1bGdPSElheDNwa2pWeiswbEk1Tk1uYVFWL3hTeTFsVno4bVFnM0wz?=
 =?utf-8?B?UmtPVGlTZkhpRFB5QVVZU0N3bHlBL2xyUVNMZTFBU1diYm9EZmlrVHdPL1dT?=
 =?utf-8?B?cGl4MFdCL3RKRmpmZzhrK0lBQW9SWTFiaktrejdBWkE0S1VBV2ZZT0Nvd0dR?=
 =?utf-8?B?YXlUVk9DY2Y4Z3BNeTI1eEI4MUZYSVA0NEhjeERyUzUwbmVicUdUNkc2Um5p?=
 =?utf-8?B?V1QzWU1IemFGUFZEdUU1Y3I5T1ZXUkM4WUJCUXA2V1pEVmJlcVdZV0VONlIw?=
 =?utf-8?B?ajdLRWJ2dFNaMi9PWEM2ejFuZ1QyMkJtZXZXZWJQaGxLMW5sb0NpQWpUdWFh?=
 =?utf-8?B?MW9aL1hkUEErMmM5RHVLZUNIM0dKeStMcTRqT1dZZ3BibXJSb3FMU2lpeStk?=
 =?utf-8?B?UFVydUQwcjNoTVd4WW4xQWErMjJlU1NDcVBBNnpRREUrYmQzSFdaUCtXRU9s?=
 =?utf-8?B?MlNWMC9xTW5jRnFOUXlMWTAyY1VFcGpCZWNNRklwd2dFNVk3TThrakFtalF5?=
 =?utf-8?B?WUppdnkzRnJyblM4WkIzdXVUMFEwcmptSnpIMVlqNzVYYVZXTThvSWxBRlQv?=
 =?utf-8?B?OHpBdzZJSWhPU1QzSnk4VXlMQkcrMEdUS2lvdXJXUm9ia2R3OC94K1luV1VT?=
 =?utf-8?B?Y1BUM0kyNVczZzNvTGxRcnNqYWJVZkNObnUxSzdIRjdOVUVTV0pQTlMzdTRW?=
 =?utf-8?B?Z0crdllHdHMrR1phVDdRYmFiQi9PODh1N1Y4cWpINitTVnR1R3A5ZHg2UWpk?=
 =?utf-8?B?U1hBL3kxbnlQSXJpd2c5dXI2SjRqd0Z5SEc1aVl3VC81SnJsYTg0VzluM3l1?=
 =?utf-8?B?N3k5Wng4UmxvYnhhd2ppdEIwNXRyTk5PZGFlUGZBWE5QV0h4S1N2UHk3ekpp?=
 =?utf-8?Q?eMnjDjsWn9bJZDp+Xv5AcSiRsRyFX9mCGy2ow=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnE3VGZnNVJOcVlqOHFpeE5FZkVJYnl2MWVNSTNxWHhNTzNiRFJLYW5rUWdz?=
 =?utf-8?B?b2NNNTZTM2gyTWhnRkFOVkpnR0dBRzMxNnB3NDFKK1dhVC8xVjZVclY0dEFQ?=
 =?utf-8?B?Qm5aZWlLQjdob2xZd0dkZ2hEM3lvbmFjVk41UzFpenJXSHZncnM1QTdZRUFR?=
 =?utf-8?B?MUN1bnlwbHN4dmlrRE5jVUVPektHQUpxUlRFNnVmSmxQaDlUazQ5bUhLTXQ3?=
 =?utf-8?B?d3RXcWpIdzlkMnVuZnJ1U0g3Z2cyUUFBa1IxVEZPMnUvOG9DLzcxdHp2VHFW?=
 =?utf-8?B?UUZUNnZvMGxFcGlSTUx4Mi9naTZaUkNJMjN0SEFKUTVwVVVrVnpod3hZV2xj?=
 =?utf-8?B?YlczK0J4Vm1TeEFEUkNzQkdXclRRYUV6TFRRTXREdDZOaks0U3VFSWk0bkNC?=
 =?utf-8?B?M3NlNmYrNnhPYzd6YlBqMEpqMTk4dHl6V0dXZ1J3Yy9xOWgyanNmMHppalVn?=
 =?utf-8?B?VmVmMTB2bEs4SEVrYXFWWWxLVGVCQTE3OE55QzVvYllMMk8yeWhJZEZiV1Jj?=
 =?utf-8?B?bUVRSmdncDQ0emJJTnhJZGtlSWJkeDNmTE1OZTJZQkNCYm8xblRHRzJzaEZt?=
 =?utf-8?B?N1draHRra1pHL0crMWRpRlhuZ0Y2V0UvMCt2cTNkM21tZDZKM1V4cG93czRG?=
 =?utf-8?B?YmJlK0diR1BFVndhL3JoSTlkS3VqajNXUlhydXM0UjgvNE9RV0Z4ajBHMVRP?=
 =?utf-8?B?WVJoRDZsZkMwbTk1SHAzazdxRXFuWTNnNWwzTFdFY1dtVVVDdllrUlV1TFdC?=
 =?utf-8?B?UytJTXBlcko3dG9TOWRpb0JWaDNmSWdSakNnbTZnU3hRU2piQlhodGpIdVBF?=
 =?utf-8?B?U0xad0F1ZUtaRXZ3SCtoUDNZN1M5M0NBby9XRm5BQWMxYWNnNUJ6cGtzMk9Y?=
 =?utf-8?B?d2tNb21sdUpMaTJXaVArNHQ4SXUwVTdyaThxT3c2VEF1OHRxMmh6T1V3Ukp0?=
 =?utf-8?B?dE5TeDRrOUdpcWc2cnZGaGRaMitmREl2cFZCZktzb2dseUpGVVBQcEFNbXBX?=
 =?utf-8?B?VnFLaU9lSXgwK1RPcVVkalgyWkIwY2RJN1BFQ2JiSVUzMVZPSDZrdlptcmVH?=
 =?utf-8?B?Y0NOQTNrcHpMUUVlZ3kxRWd4MHU0L3VramljeHNrYnZobWZma1c0MThqVlY3?=
 =?utf-8?B?TkhGYWIrSHJaSDJmdEtSais2R0xQS3RraU9rdjZtTVBxSWl0eGVhMU54b1lr?=
 =?utf-8?B?bWZ6WUwxVUJTWE1Ub2JFZXpsM291R1BxYUlURTZkTVpyMFVNL1dNd3ZEY0M3?=
 =?utf-8?B?UUNWU0E5eHZwN0RGTFNBR1ZJYk5uUnZwaElwQmZSemVYNG5aVkhLSUpTV2Zk?=
 =?utf-8?B?WVpMM2JndlZibU9NVkdPaUNWZlhHdENZT3FMZ3QzRlVaNmFoZTkvMG1iTnd1?=
 =?utf-8?B?d2ZienQwa1dLVHExUFVDY0lSSWR4d0FkeVBEMjI2cjJLT3VZUm1Ic1ZMZms2?=
 =?utf-8?B?QmZOKzJpSGJNOXhvb3p6ZG1kY0QzNzdNR0taNXpuNVBUT3dMazdMdi9yUnlq?=
 =?utf-8?B?cStJeXNBZVlWWW5pR1lYQjhabXhRT3hVSnh6aFlKQmZUTi9DMkxFZ2l5TmxP?=
 =?utf-8?B?M2lLR3hYKytCQXNQZys4T0orWFlTbkJybzVVTXA0WkV6aVlYMTBNdFNNd0Jr?=
 =?utf-8?B?THJHMExBWnRzc2xHaFZLeStMNE0wYTU4NnRPOHZqMHRqTW1HK0NuRVY2N1Fq?=
 =?utf-8?B?c0ZWNkZnZWxqQ3RsMzBwdXVzZWw1RmYrUGd1SXJFSVNLTDJuVS9EWGdna0Fn?=
 =?utf-8?B?OUE0YjRXL2x3SEU2MEVFSVFkeWhQK3FVWjVyMCtFZWxLTU1SWDVXa2RINCtY?=
 =?utf-8?B?MVhnSkJaN0g1YTZZcUI5dyttS0lhOUFza3VkT1BGYjNxWUM5RVJXdkxMZGRT?=
 =?utf-8?B?bnkzTHRJcUsvOVZ2TGxWNzZnZWhLSFkxOFE4c1RWSDZ5ZHV4VmtkYy9hU1BU?=
 =?utf-8?B?dHZ6UkhCaTZhK1U5c01TbHI3Nm1rZjZvYVJxQkJpR2JCd0JobnFsRXQxUHYx?=
 =?utf-8?B?WHJkaTNjKzRCTzBvN3NyeGNCeDM4N043cVlJdnJoeStSTHE3YklUQkIzZHhk?=
 =?utf-8?B?UWczemF5bHVqVStkZDNJZWFXcitKNEhSTGltQmE2RllvK1lGcjZkZWk4THBJ?=
 =?utf-8?B?cFNHdVNBSmNlNGJERXNvN3NlM1lIU01aRU12SE92SDYyd1FGV3ZjUUNiNmE5?=
 =?utf-8?B?N0E9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9a058f-3bd9-4941-a696-08ddda308665
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 06:13:30.6456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wbRWFWodEq5AegMs29VLyOQB8ePHerGD0t+XI+W2LcvMm0OhRF+rvXkokJBbF6xr1J+GlvPaqFE7VFA8UAPpm1jGERY6Ok9JK2IsoLyUXNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFDFA95AE62

Hi Krzysztof,
    Thanks for your reply.

On 2025/8/8 16:03, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On Fri, Aug 08, 2025 at 10:00:34AM +0800, Xianwei Zhao wrote:
>> From: Feng Chen <feng.chen@amlogic.com>
>>
>> The Flash Controller is derived by adding an SPI path to the original
>> raw NAND controller. This controller supports two modes: raw mode and
>> SPI mode. The raw mode has already been implemented in the community,
>> and the SPI mode is described here.
>>
> 
> Subject: drop doc, so just "Add Amlogic foo ..."
> 

Will do.

>> Add bindings for Amlogic A113L2 SPI Flash Controller.
>>
>> Signed-off-by: Feng Chen <feng.chen@amlogic.com>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   .../devicetree/bindings/spi/amlogic,a4-spifc.yaml  | 104 +++++++++++++++++++++
>>   1 file changed, 104 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/amlogic,a4-spifc.yaml b/Documentation/devicetree/bindings/spi/amlogic,a4-spifc.yaml
>> new file mode 100644
>> index 000000000000..712a17a4b117
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/amlogic,a4-spifc.yaml
>> @@ -0,0 +1,104 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +# Copyright (C) 2025 Amlogic, Inc. All rights reserved
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/spi/amlogic,a4-spifc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: SPI flash controller for Amlogic ARM SoCs
>> +
>> +maintainers:
>> +  - Liang Yang <liang.yang@amlogic.com>
>> +  - Feng Chen <feng.chen@amlogic.com>
>> +  - Xianwei Zhao <xianwei.zhao@amlogic.com>
>> +
>> +description:
>> +  The Amlogic SPI flash controller is an extended version
>> +  of the Amlogic NAND flash controller. It supports SPI Nor
>> +  Flash and SPI NAND Flash(where the Host ECC HW engine could
>> +  be enabled).
> 
> Wrap at coding style, 80.
> 

Will do.

>> +
>> +allOf:
>> +  - $ref: /schemas/spi/spi-controller.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: amlogic,a4-spifc
>> +
>> +  reg:
>> +    items:
>> +      - description: core registers
>> +      - description: parent clk control registers
> 
> Why are you poking to parent node or to clock registers? This looks like
> mixing up device address spaces.
> 

The SPIFC bus clock multiplexes EMMC modules, so the corresponding 
frequency division register is also in EMMC module. The SPIFC and the 
EMMC modules cannot be used simultaneously.

>> +
>> +  reg-names:
>> +    items:
>> +      - const: core
>> +      - const: pclk
>> +
>> +  clocks:
>> +    items:
>> +      - description: clock gate
> 
> Are you sure this is separate clock input to this device?
> 

This clock is used by the APB interface to access the SPIFC registers.

>> +      - description: clock used for the controller
>> +      - description: clock used for the SPI bus
>> +
>> +  clock-names:
>> +    items:
>> +      - const: gate
>> +      - const: core
>> +      - const: device
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  amlogic,sfc-enable-random:
>> +    description: Enable data scrambling
> 
> Why would this be a property of the board?
> 
Will get rid of it.
>> +    type: boolean
>> +
>> +  amlogic,sfc-no-hwecc:
>> +    description: Disable ECC HW engine
> 
> Same question, why not having ECC always?
> 

Will get rid of it.

>> +    type: boolean
>> +
>> +  amlogic,rx-adj:
>> +    description:
>> +      Adjust sample timing for RX, Sampling time
>> +      move later by 1 bus clock.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [0, 1, 2, 3]
>> +    default: 0
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - reg-names
>> +  - clocks
>> +  - clock-names
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    sfc0: spi@fe08d000 {
>> +      compatible = "amlogic,a4-spifc";
>> +      reg = <0xfe08d000 0x800>, <0xfe08c000 0x4>;
> 
> One register for the parent clock? This really does not look like part
> of this device.
> 

EMMC bus clock modules were reused.

> Best regards,
> Krzysztof
> 

