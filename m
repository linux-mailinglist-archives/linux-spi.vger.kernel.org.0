Return-Path: <linux-spi+bounces-5847-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 524AD9DAB1E
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2024 16:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF92016450A
	for <lists+linux-spi@lfdr.de>; Wed, 27 Nov 2024 15:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034BB200124;
	Wed, 27 Nov 2024 15:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cIXMO1LC"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A431200117;
	Wed, 27 Nov 2024 15:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732722903; cv=fail; b=uyG0jLMAJN1PdMMsOpfWfGbPYl7epI30s/8Bey1ZeV+W011m1bwIpGiPkEAVz2E/P+9nuBMnLZdH6f1VbhsuIhYOQBBSSD/r4VjlQjAoenwpxL0iVIOHmgw3ksUM45Bie33JqV6uyMovzXvZuGNUIjFRoBFeJH1tdvtTTbFXEAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732722903; c=relaxed/simple;
	bh=bedTBeDNuIdPW/g+6qV7jrl/G5kQAUOrmgIxn5FsBqo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kJhz75St6vbVEpug8fdFdsrL6njNv1YhXQp3/lO0evv62rJ5Aa9MADaVLmdCSIm7LcQPhGiq7DqIwFH2UWW8NYdFY9F91ACKAVzSThDkGxzBGh43aCI41KkiI6GE+3gt/gGJVoifBgVA4+3HOjWFc6IR6xMlgPxjPCsAepQSSTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cIXMO1LC; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G/PLf3EDdqLnUQJIfdXze7q+hwgGgGJ35no0E1usELn53VqwCzxEcSMqxW3ZfZtXAYG1gAB4g8y5eiM6oA40YrBNau/CJOgQgst1MO8xTSuYuaqBrq4STlnc5/fmI3aNKoYKVBftxmQ+/YHBT9w/abm+rk3V+o5eyc7vrjGOaSyoLlWDrXLPCV0ym591wollaiI5zVAlg5QgwDVG7MTMj0TZhYS7e2a49Q3GWqHYMneKWOfWmWnEEfHAAftOXIitrJ+v5LSg0OamWcd/J0+aD9IK/mYM1nGrB5aLG7EABEpaBfAkofcV8Op7mhHJt+uvnMqK8Upj9323316lqY/mCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWmwinlChVffaXzkviOnkskEazxN/lfsv6Tcvc7bbOM=;
 b=Sg5l/EVZjWB9fyQfwX5Ng5E2lvbBOkDk3iXU1PrjTyNGL6zG7rKzer2AvtFwuNPWKPZtwd+9QriEnBAvV5Dw7Et4O6R8WSoUWnMZpLu4RgTPxJIG2w+1es3rvXr3oQ0EbkUIjXiajT86vQdgpanNggmA+ZUFbuNwpQinobK5GaJKZ2uA0om3ptsekxNf2857QAFlUlWp1bCc2MRDD5AlXSMtP6s/JUflbcArz6noDBU8NMVoipA1YToJtREwZwXs6WzjG8+aBJm+gMbIpxYD58CeEjGqtDf+cLLH4TzSjtKY/iZdF+YnQbEAz1b0GmYpNqHmlN3WFSHwA+kukzIPxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWmwinlChVffaXzkviOnkskEazxN/lfsv6Tcvc7bbOM=;
 b=cIXMO1LCdVVVyf1TbFmwv9VChDDerpN+Q4il4q2sCZhwwSykFSymMXi80MJ82tSlj76BIwsfqpjUIA0pkxmxbVfEqofpuoOBLi0MaC8fB1sHayMWqUilw0weR9T87WlyMhCSvctXxzkbrEvFCSCL0g/HLPiLaXEH4uB2aylAiAE/DaWoqZ/i4qpH4AuhbhCPArwohZN0Cnm4VVP6ty/g15URLTYHkTO2JIMOS/nemmyXmJnwU+ubOL+MZG4DyRO2LOJmgEsUXVcUV8GFqneMwuiPYK3/6xggflUCMflNlfvlCdoU60H6FMyFltg7yNNN3UvLK6CXDKH54WepZsg2Qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SJ2PR12MB7941.namprd12.prod.outlook.com (2603:10b6:a03:4d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Wed, 27 Nov
 2024 15:54:57 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%2]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 15:54:57 +0000
Message-ID: <e95f870f-1309-4ac3-a16f-ce58b02dc817@nvidia.com>
Date: Wed, 27 Nov 2024 15:54:52 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: spi: Add DT schema for Tegra SPIDEV
 controller
To: Mark Brown <broonie@kernel.org>, Vishwaroop A <va@nvidia.com>,
 krzk+dt@kernel.org
Cc: robh@kernel.org, conor+dt@kernel.org, thierry.reding@gmail.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org
References: <20241126134529.936451-1-va@nvidia.com>
 <20241126134529.936451-3-va@nvidia.com>
 <a1278046-038e-4825-b029-1b478f28cb7c@sirena.org.uk>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <a1278046-038e-4825-b029-1b478f28cb7c@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0051.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::15) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SJ2PR12MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: f32fee2e-d8cb-4677-6942-08dd0efbd77e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFZFdGRRQWd3K3JDZmswdXBBZktOMkFWVmNOZE1XQTdnU0x2ZEVramNQYXU2?=
 =?utf-8?B?Q1MxdVhXSUhjNUdwN2NDRnB6ZmNoN0JCVFZnTlJIV1pFa1k1SklqQUVnbXV2?=
 =?utf-8?B?Y0RoeTVqS1lVaEdWNmtidEdTR3QzaTltd0tGYlFFM2RudWU1dTZVTVdwQ3Bj?=
 =?utf-8?B?V0w3dkIrd2hvQktabVBOTk1rWGhBS1p2cVFtaVdyZm5kNDBnWGY1MllNc1lG?=
 =?utf-8?B?SnhtVThNTWVSTFpNeHZEaXhqZmdrTzZuVTdzMkFYYW9IcTR5TWE5RFdoY2xu?=
 =?utf-8?B?TDgzMjhyNzVIS3lxVWUrR0NHdHVJYlR6Sm5NNSsxVWF6Y0VQWFI0WjMxRXQ4?=
 =?utf-8?B?TGJPQVJDZXdrcnhkU2tyR2pjcUpmaXJsd1Uxd0RQRG56SVIwdTNWK1MrMFVj?=
 =?utf-8?B?UW5YNTFoYlhDT1FGeUFTWjA5MmtVRCtoVFFNVzFyR2ZHZlZ4am15MTRqZ2dj?=
 =?utf-8?B?Zk5ySTRJL2FXU093YlFXeWU5SWlwdi9YaEhHajNiUmlkSFg1WjRiNFp2VTJU?=
 =?utf-8?B?Rk80cDNlQWZaY1ZpUU1MMGxaNTF0QkFCU3g5ZkJ1eDZmUGZHNGtVbHU2cXZy?=
 =?utf-8?B?NVJoWk9yemd0VTZFYWhKQjllb09yTlhVM00rcm1Hd0IrQTVUMExMWXRPNmhN?=
 =?utf-8?B?K0xETGtLSUV6Q1BQTlNsdS9wQkNkWm4yV2NkOVd0SkkrY0lYMlBDRDBPUGtt?=
 =?utf-8?B?dGdsOUZLcEVYQ3VxRXR0OGxHZGF0SWxldkVvdlRVZGhPVTZZR2k2Tml4TUd3?=
 =?utf-8?B?TjJGRmNSZUtCUjBBQS84MzFlUVZTekV1MDVHczIyQStzdWs1VzE3dFdhQ3ZH?=
 =?utf-8?B?U3lvb0ZnNm15RlZhdGljQW50aDQzdEwwQ05wbXloQUE4K3k5Z0F1K2tXVTAr?=
 =?utf-8?B?L0RkN2oyblRaTW81bndrWWZxR0Z5S09GV1c5VWRGY3VCTGxCWkxNS1lPc2ZN?=
 =?utf-8?B?WkhYakZNU0VaNEFGUGlqdDhKcVRSOVBsTzFxNVBMcjQyTnhKclNkQU5KWUVR?=
 =?utf-8?B?bkwzYTR1TXQrZWVXZ0wrUlJCTWFHemdMNEpSeklLWEJWSDg3OHliZlV3K1lk?=
 =?utf-8?B?N1I0dkpKbW9sa0hDKzUrdkFGcFFQOW4xbERJWmR6UDR4TUJiTnhhZzlzNjRj?=
 =?utf-8?B?eTJOL3dXcktRTUQwZWp5Q2xzNjRSemVQNDNzbHVmTThEZndIZUluUHdtVThz?=
 =?utf-8?B?S2NIbSsxbkNNbGEzR2xSK2JyZWFscVdXdFliRFpkcHozQVpvUm9LaEpSU2xi?=
 =?utf-8?B?bUtKemQ2d2lmT1QwQ1VNd3h2Vis4RWNtWEJBSTNHTUdweG5nYXBWdkwyN3Vk?=
 =?utf-8?B?aCtkbEI2V3VPM3dtS1QySVhld3hLbGhwRlYveFZNRWx5TUxtRFhHeHd6ZFVM?=
 =?utf-8?B?REIzSWFIYjFCU3RzSi9KSEV1RzBWWjNnRGdOcXk2NjNHbmNpbDEzc25DTHVS?=
 =?utf-8?B?dzAvSFBvUFBGbnlQeFFSdkkxbnVNdEZLSU4zRVVDRE9UelFtOU1nbjhDcVU0?=
 =?utf-8?B?QzU5anpFNjdsTGo5QmkzckkrT3dFRUwvQzlPRTdXdk0yLys2a3lEbmtGQklK?=
 =?utf-8?B?UDlUM09mekpnaDl3R1hlTW5hcURJelFZb05kOUhkS2loY0xGWGdjVEl4NDFu?=
 =?utf-8?B?MlFBNEVDa3NObjZsTll6L3dUVDh3ZFJ4bWZkNTM3SW5RUXdwejJ5N1FBY0RZ?=
 =?utf-8?B?Q1ZHVklhMmRtWGg4Qjl0S0RzaENWYjRaQzFZVGQwbHJjM2Q1Yk9wZ3hZcnl2?=
 =?utf-8?B?RFpTNkxaNE9OdXdTY0JzZ09Ra3JKdUdTY2JaNmZtYk5ScWpKREZRQjF0b1c3?=
 =?utf-8?B?VFV1N0cvNFRUQlRaV2VyZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnlCTmpoemM1aGRydXpHekpPaFUwZWh5TUo3TmRXN0NIY09US1pLZmxWRXU3?=
 =?utf-8?B?d1ZmbmxBcDR5d3ZJV29zQmlHa2FoTGlBTmtoWHNqSkd6THFBbVBrdW5qcGVa?=
 =?utf-8?B?WVUyeVc2d2gyYmZXOFRmRnhud05IUUZ4eldMczJXem02RDY1SUUzMHFNSVZm?=
 =?utf-8?B?RExDd2JUQlU4b1ZUaVVPNlIxSnNWN1o5MXB2cnY3dFQvQWhhWVM4VUlrTWNO?=
 =?utf-8?B?WXlYc3o3WFZTRlY2bHN3ekpFR2tSYTZJZzc1N2pEM1hheEZIMlp5RXk3Wm5v?=
 =?utf-8?B?SXhLL0pOU0F1Q3RPd1lvMllRamhQRHdBNVFGOWZGRTk2S1RhZXIxdzZSNWg5?=
 =?utf-8?B?UG15UThmc3FjcmJBK2l6RzRMREQyYTlnNGdBc2ZxUXZnejVpblo2NnJtSjl0?=
 =?utf-8?B?THpDRnppWXJkMFBJRzEvVFRpa0NYMnhlZitrZWhNbzFPZDdydThSRFdDSnJr?=
 =?utf-8?B?WU94b3NORTh1N3VVMzVLUTZTSXY1YUNjUUk4bDRYT0xBcVlRQisyc29wWnhO?=
 =?utf-8?B?dmsyR0hua0NJNjNRcUlzN0JZQzdvZmZwWkFRU2xvS1NrWGtPVnQ2NzZUcjR3?=
 =?utf-8?B?ZFZvVE1Lay8zUXpxVkRhR2NILzlyblhuampFZ0ZFczZLOWZaeHVNdDliM1Vm?=
 =?utf-8?B?Q0xYSE1MUGtNUU16KzYyZjIxaUFKWHgzVi9rbDN5QU4xTkZBdUFKS0dhTlcy?=
 =?utf-8?B?VjJwM0IzWVJFMXhkc050TEVqRnlxaVZJSWJ4ZnJ6OEZ0K3VGdWFOM0FEVld5?=
 =?utf-8?B?bHpFN0lMSHFXdG1mY1lrYzJ6VmtBYVlPdWlUSnExWWhCYWxrVitycWtaTGE3?=
 =?utf-8?B?UFo5U1NxRkRQUGQzalNiVmVXa3o5eS9sV21GZmJ2MUQrVjladDZaQjV6T1RG?=
 =?utf-8?B?aVJlZTdRUnBaSW1TREN6ODdrZ3QrSUsxOTlKK0VVeUZWN3c5ZTRFSkdieE1l?=
 =?utf-8?B?OFBtQmhuWTNBQ1FxeVZweHN0MWZ0ZUxlRVRYWmQ4ZkJRc0JZUU1wSDlqTFBp?=
 =?utf-8?B?S1F4NktaNDdFQzF4ci9ZdnlKYmtwdTFDK09vZitZV0xqOWhCc0xIS2RQUXE4?=
 =?utf-8?B?Skx2bHVvR0ZyVkNWREVmL1ZSM2JDMXlTZW1td1VSRm8rdTJveUFJRGRuTHZ4?=
 =?utf-8?B?cVNjOFlSSDFhdHNiL0lOQkF0b2FvdVNlVVpiOTBQTHkxZ0E1OWtLSndVUUxC?=
 =?utf-8?B?azdrWjZ0MWl3UStJWEVnV09uemJwN3MvNlp1b3U0dUwyOW1icy9qMjFCM0tR?=
 =?utf-8?B?OHZCZ0R3cmRWTFh6WXRUNG9VYkN5d3JBNElycmY5eWhkWVZlb1drYk1MQkRR?=
 =?utf-8?B?OWg1bXZxc2NLelRzTlR2UTZQVHA3dWtJSG5xdXFwVVJ2TWw3dUFHTnVuVUN2?=
 =?utf-8?B?TDZmQU5vNnMyYWxSQnM1RHdDUzFXU3R6RVRhU25iMko2b0l1c1pWQ1llRnJT?=
 =?utf-8?B?bmNIbCtaaHlmamtuQjR5OUFHOW9TZUJXMC9zZ0ZLNkxwL09CZXVJRVRDa3lL?=
 =?utf-8?B?Qk5vM1J2RWZMNGErbzZjd2FQbkZxV1F2VFdEWnFlVVRlMmQybXFZWEhTTlgz?=
 =?utf-8?B?VkdYdExySlUyckpteFBlM1YyMEVhTU1sTFF2M09vUTR6NktwWHRjVnRydFlx?=
 =?utf-8?B?VWZQNUsza1hhRzc2NXBJRHBFMlhLVWRBREZ3MXBMV3craEYvZTRVTlRGVkVu?=
 =?utf-8?B?Nm5DN2h2RUN4RDM4NFo3dExtZ0IwRlBlU0lOcUFCekNJUGs5cXFXZTd5QzNz?=
 =?utf-8?B?WlFnZnlDNW05ZUQ5TWY1V2ltVzFmay9Sb0s1ck9QYnV3ekJ5cnRRRkMxMzFB?=
 =?utf-8?B?VnZxRE0zT05BUm9JZWJiVFZ1OUVsb29lWDczZlNMU2I5aGdocVBScXY1Ynkw?=
 =?utf-8?B?Y0NabzJ5eXdJQ0pTVjRHUkxUSHFpOWZuN2o1djIyV2w4WTZTMVM3d2JyZG5S?=
 =?utf-8?B?UEVTb0N5OFVWYXpGc25xNHN3S2s4NDBZa2JNcVVwcm4vUkxjUTVjOWFDZ0l2?=
 =?utf-8?B?b3VLR3U0N3B2dUJQSmxvSDR0ak9Gb0g1OUFzaGpjWEFXU0ptd3cwUEtqOFVE?=
 =?utf-8?B?enRhSFpFbnYwNkFKSGxNZFVWay8zL3hpSVhPaGZOT3lSbUMzdUtYUFc2N0tD?=
 =?utf-8?Q?zBfSX7ZmSBSX2l9Irb9Q3b0E4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f32fee2e-d8cb-4677-6942-08dd0efbd77e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 15:54:57.4153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJ5AYsyutY0jBxkMXTpv8E4AxfQwcuziqxmXeicKBUPk/3Ahn7YRr3FU6gQH8kMEdZ0oW3/XFuxiHdfrYMCnrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941

Hi Mark, Krzysztof,

On 26/11/2024 13:56, Mark Brown wrote:
> On Tue, Nov 26, 2024 at 01:45:28PM +0000, Vishwaroop A wrote:
> 
>> +            # NVIDIA Tegra SPIDEV Controller device
>> +          - nvidia,tegra-spidev
> 
> All the issues with having spidev nodes directly in the DT also apply if
> you add a prefix onto it.  Whatever is attached to the SPI controller
> needs to be described, not just a placeholder like this.


Chatting with Vishwaroop, what he is trying to accomplish with this 
patchset it to have a pseudo SPI device that we can control from userspace.

On the Tegra Jetson boards we have a 40-pin expansion header similar to 
what is found on boards like Raspberry Pi and allows users to connect 
various cards to. By having a pseudo device we can interact with 
different SPI devices.

Yes by default nothing is connected and so there is nothing to talk to. 
However, this does enable us to do SPI loopback testing for example.

So I am wondering if it would be acceptable to having some generic dummy 
device-tree compatible string for this? I guess it does not need to be 
Tegra specific.

Thanks
Jon

-- 
nvpublic


