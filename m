Return-Path: <linux-spi+bounces-6962-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F05A47B8A
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2025 12:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D0B3AADC5
	for <lists+linux-spi@lfdr.de>; Thu, 27 Feb 2025 11:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3EC22B8B3;
	Thu, 27 Feb 2025 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U5gXhhj4"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD79222B5B5;
	Thu, 27 Feb 2025 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654610; cv=fail; b=DSrCv9x6F402nSaNN0deeaFYnbEMuxAPqQjxD6NbiAVyhCNj3qiebdetkuFE8Zy0bPRbpHV1N/2XwsWMi7y/hq+pI0qoaFXZCTrjI7bQmOy2ryO9NjuHlzJyzMR0fGch6cMyxREy0yI49GP+bLaAbxtiVj8GyswNVSwu81dXE+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654610; c=relaxed/simple;
	bh=gSNctqW1o8ED3n+SrCYR0XPL6SsMhIEroS3ye5j40XU=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VBwcYZfC4XpW0zrxuHRKi8HQMBVdpBp/pcTRtQY+PgTVvmAxEhUVosGkes4ojCmtEVPvaMEZl9dcVdNbfPQE3db+8+vWlHC7AgP/QiExAtf61n5Tuc46HM7K9DTkakQC+XPa6GPaZHosBL3W3MLlJOCrCi+hd9zjmJ2SgnFLW7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U5gXhhj4; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbIZsjytmD65GzZqMSlcb27hcdDvQhsDFSnDK8LfwjdoqauRZqK3uKQMxPxnZMkHsj88TIPi5lEiVtSPBro8GVZ/YM1wMfqC03frl2VjblJYeqLCCDfy0VYMj1b417hCFjqMoJceWOG/SMgCBz9Cd6R/CnqkTjB69Th3/l4gqyuOuPziV0LL+QAyc7Fg7KMefGdEzshVciRJbCWmWLDjynqfPZPhKM885U9t/lj/QJh5oY4MqJFWVgO2R9xOD6KReKWl/9MFdo3R3Nz3iFoifokx/KWgo6Ogs7Y83flUe6y2blf5AqJEDRvPsG/30J9NIUl0gtBxSNoQTOCPgHqipg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALDKPWRhoxk5+51rD2JBseWvX51jCOU6c4+0ayrX5Ec=;
 b=TEWUOAs0I0GWYeMR52uobpO1oeIhVgwTBNnoFu72cyaBsOYVUqFLfvwKUVP2v0s2CDM4+cOroRRg88ll7cN/OflGxbC1/815K3An51SEXz+i/K5YPsnznSxNhRFZNnqcmeWsKrd9d4s8WX3XHJSTJ33qlOknKN6+v/Hvf+bIMUKB9zfsjCjZOsZIEudAoz9Kwx5fLfAnNTRu0uzR/RbhXh2UednWtLIgTB50h+3MAbidn40wpoqSOAa7TR/28OXtojGOoZ6UbRjUbyNP5Nkoi2puoWQaYybh4Ch/ywCg6+qJadbWLceUj2oaCm1/Nef8QM1jI3Jqo7OFDlouei5IhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALDKPWRhoxk5+51rD2JBseWvX51jCOU6c4+0ayrX5Ec=;
 b=U5gXhhj4pzLfp9J+7f+MOiegHGKzvUgaJXyJqvkNXeaWuLiHn8Fu+Iv2ZR29NuJf4GRZoL+r0Tv48VL0NmoHG/wFJxqXytPNw8OjJAz7D2A4+6qnb4hVhblco6QJKZ9Rlr2174utU5y0Up+drI6val1WBzwpz5ncrHEhW3lNrSRnlooNqLscaXeq8+6WVTyAMhI4PbnoPR5bf10ZPZ7Q7xx3Fd9ffdbqrIdS9BPThSxiOH3hGS2Bev9BHEAI63BeZnF0socNxn5p1eWPDH7mvzgW5PhrL7PePpifDeU49+Pdm7OvKKFwFxtB5vV3cyRG5U9/LT3ZxBf0CC8h/xeA9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SN7PR12MB7372.namprd12.prod.outlook.com (2603:10b6:806:29b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 11:10:06 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 11:10:05 +0000
Message-ID: <ff1136de-c7cc-4ef9-b3cb-9260b21e4ceb@nvidia.com>
Date: Thu, 27 Feb 2025 11:09:57 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Configure Clocks, Add Native Dma support.
To: Vishwaroop A <va@nvidia.com>, thierry.reding@gmail.com,
 skomatineni@nvidia.com, ldewangan@nvidia.com, broonie@kernel.org,
 linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, kyarlagadda@nvidia.com, smangipudi@nvidia.com
References: <s355cib7g6e3gmsy2663pnzx46swhfudpofv2s5tcaytjq4yuj@xqtvoa5p477n>
 <20250212144651.2433086-1-va@nvidia.com>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20250212144651.2433086-1-va@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0180.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::11) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SN7PR12MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bf07d62-9b81-4f99-0d01-08dd571f49c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHBWdHBvMW5ORnBvUzU2djZaVWp2SGhwVkxWN3B2dmllTEZFZ0xvdzh5eEx3?=
 =?utf-8?B?dSt6NG9QeGtPMUUyMUVZMGxiTXFEVWJIQ2VwSkhHSEVTR2J2UjhxNHNZbHFX?=
 =?utf-8?B?NmR6T1UvUHZkRVZLWE4xbnJsdlVRQ3BqK1N1dWJCeHMyM0JmZnluS1A2UE0z?=
 =?utf-8?B?ZytjckhRTGVWT25UZ3ZsMVczb2hjem1sN2hJemYzeEFPTm5UMkJPc09ZUGpV?=
 =?utf-8?B?NkR1NUVqSDAzSXgxZWFyRGJweUVsUG4zVTgwbXB3d3BEVjFQUTRuWUVxUWtx?=
 =?utf-8?B?TElmWlhlMitNTmlGU1VPU2ptcTRyNVowU1pCTi8vVyt0UDhmcVJudzNVbFFs?=
 =?utf-8?B?UkFweGx6S0RDN1VydTZWd1NFZnl5WHlJM28xa2prNHRBeGh0Vjlzei91VUk4?=
 =?utf-8?B?bnRRQ1ZBWEVtTDNkdVpxd2p3RFZkTFRiaWNlc3dTYlAvZEx2NEduR3ZMcXJm?=
 =?utf-8?B?RktsVGkyaWFmVERmVzdFaGlZenJEYzRKMzNtYVNoUUFCbmFQejB1MDNRUksr?=
 =?utf-8?B?bm1hcmd5YllTRWQxOFJWaXN1b0dkQllhc3VJQldkY3MyWkZhb1plZDFuRHhk?=
 =?utf-8?B?RG9GdTRia2ZzeDJOQ0xhQkkwTXh3TGtadTN2Z1RJOEdQZXEzSCs4VUpMWmFS?=
 =?utf-8?B?Q2htN3FnUVNZMlRuSCtQelg4bWphMlVHMWVtaCtHUDdlQ29jSm9HOWhuVVFO?=
 =?utf-8?B?U3VFcVRnR2ZEUzdqTkNYZGJNak9Vd0ZDYlpKN3ZUckJGSExSODM5TXdIeDNF?=
 =?utf-8?B?c2xMYi95U2VtRU03RWRnK0dzNjRTc3E0S2lvbjUzTnlUQzRwWlZtTTgvb2RN?=
 =?utf-8?B?d0hKUHhCVTFudjJOSTdpSUN5eDhUdUJWL3J2KzVPbGpwKzNuQWNpVWJsZ0tx?=
 =?utf-8?B?UDZwUFQvZUxQemt1QjBjSHI1ZWt3TVZUSmJ4RXB1QWZhUzJyNWY5NUloZjZQ?=
 =?utf-8?B?eVl6cUVIcGpySjZFNndEdXZ1R0N1MGN1ZG5DUnpvMzJZRkxETUdVN2NMNS9h?=
 =?utf-8?B?Y0RMblB6MXozK09qUE00MXQ2MTNrNXRSZ1VIblM0VDVvczNZUGJzSlo3TmJx?=
 =?utf-8?B?R3luUnRDdVNFRDByeVZoV0NNMlFjS2NBWElWdGVPZHFXSVVPSXFlS2x2eW9B?=
 =?utf-8?B?L0RzQ2xmQmlYUlQ3dExuVzBGdkNLK2k1eFhVUWpQRXQrWXpZNmdEZHpaYWhJ?=
 =?utf-8?B?NDRHM3NLOVZRSkRMV1BsZHhza01oT0x6TnQ0aTc5WTBNcTVNb3lDSTd2QmNr?=
 =?utf-8?B?dDFyTmtDeTdINTBqUXMzUE5USHBpWklabG9nWUhvallGR0hLQ3l1dFZjQXlU?=
 =?utf-8?B?NW9BTXdDeVB5RS8wT2dJeHRtakxXaGJYV0FtZVJHeUpod2ljUE9SNEFRVHkv?=
 =?utf-8?B?WEdjWUVkU2EvS25HbkZjRnVVYzU1aUtBRlBBaHozUzJkbHBvZHlocnVyeElV?=
 =?utf-8?B?eG1MeGdtRGxiaGJKRlhubFErYUV1NGFpQUU2SGc2cko2WXFZc3BIalN1MGVJ?=
 =?utf-8?B?bmIrcUZJdUdiWlV0aTZ6TnlvSE51clAwRkdwNU16OGZ1YTdCS3FYenZBZ0VS?=
 =?utf-8?B?MzRKUnJsZ3NzVExwWkxuaVJYMkM2bWlYUEZwQ3Z4NnZJK2svNThmbFpxQ3JV?=
 =?utf-8?B?OEtQZCtqN3c2dDZjVWlFOGpCaFF4aUpDNUtkWlFPY091cWcyb1Z0SnZLRnZi?=
 =?utf-8?B?Rmg0aURhN1NWTUVpdEx3MlJlTFBLMThDRS9xOGJLL2pVb0hleWcrZ2VKMk45?=
 =?utf-8?B?UG5lNjh0TkIxdjhKL09rT2ZydWVGVzFROXRhQ0ZvczJCaWpKcERrSDZUYlZv?=
 =?utf-8?B?R2xYWkhmRzVLL1d3K1lYL2VSQmI1NjZjSFpndmxWUU5HSVNpTUVEcVpOTExp?=
 =?utf-8?B?SjlDZGt0N0JQNkk4enpEMG54Mzl5aVJnU241OE5LbzVWY2paOVZQMWNpcWxm?=
 =?utf-8?Q?OTmpeLi/sYA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVp4Ti82QlgyYjNFbGFwREpyejRyd0g5VmdRTkxWN0hTUFczZjB6ZkU0THJ3?=
 =?utf-8?B?cG8zN2sxT3VCYjBON2FYWHpwV3N2NSs0bCttVm9tVm4vZ3RMR2JidU1yZkVz?=
 =?utf-8?B?VlMvbFdUa2VBMk9vTjdidlkxcDdRemNVZzU2RzcxVmhpV0lzUjJaVG1WVmM5?=
 =?utf-8?B?TVJiY2hiQnNveWF1ZXJvSUdZR1c2S1F1ZHpUaGQrLzl6SmZDVmhSNGh6NFhC?=
 =?utf-8?B?VTBYWXhuUTdUZkpWeWRIU1lzeENPY285V055N0thbHJjc0xldkJKdWRVYVkx?=
 =?utf-8?B?Zmc2WC9wL2dKMzlIYk9lWjdKSEhxMEFyZHJ3d2xiMFB2bTRtRVZ6eFFRUU5B?=
 =?utf-8?B?Y0tSVnBtTVAyUnpScmlPUTErRjN5SGhWWjY2OFQyQlBxNWdHbnRzVkVqaGN2?=
 =?utf-8?B?M3F1UDJzWXVnbXZKUU1IejVhRmpabkE5cHNsbTRDZGl4SU5CUjkxQjNjaUIz?=
 =?utf-8?B?czRBL0R3SXB0NnUwYzNyOWxidm40Qks2bmR3SFZGWlhEajBYTXVsb3VYR1ly?=
 =?utf-8?B?bDE5SXdhRWRZUTJkODJNbGNlbTdjOG5SUjJTR0ZzZlBiUTAzblAramZZRE9O?=
 =?utf-8?B?S1ZXOHR4d2E4aERlajU3RlcvZGkycW9sVGdUbGpnak5DOS9EU0RJVjVOTk44?=
 =?utf-8?B?Vkswem9vLzlLZUhzRGltam4xV1QwUHJjTzB1djU3Z1k1TzQ5cy8veXNsM2VY?=
 =?utf-8?B?Qk1KYUJpWW9HbC8vRWgrSE13QXpqVEhSQTZOenlNQmhaZWMzdXJtSUcrVFRl?=
 =?utf-8?B?NFlwTy9rdm05U0F4WXltUVNTeEZtNktFVzBjVVU1LzdCTHlUeFRGMUNBc0tr?=
 =?utf-8?B?Nk1BTXYwSWZXSGthZ25waEllbW1WRjJiMCtTUEI1Z2hnZWNXM2hMTUE0dVdp?=
 =?utf-8?B?a0h4eGljYWpXRHVUU2p2WDVUa0ZneEJvVEhYVFJHZ2tHQVNwZTdoVHRGL0Vz?=
 =?utf-8?B?R0ZncGlKSThpWGJGMHpnNThobnJQRzNZSTZjdEJKVzRHWjJlQjdzelRwb241?=
 =?utf-8?B?ckdRM3lIdlVZZE13MmZoc0liREpodnV5VjI2by85NjVxWmNlT0RsNVRsVzBQ?=
 =?utf-8?B?Q1dlaElDVG15RGhzNENIVUpneEt3UkR2SEVVclA0RG9qN043ck5CVWJkZmds?=
 =?utf-8?B?Z2lxWkYxR3dZdUF5NTZhZzBFZXZTWkhqUlhxanBlelVMeTZ6dHBvbzBLdGVY?=
 =?utf-8?B?eTZXOE15OWxVTVZGVnZpa1k1MUM4VGlhV3YzeXc0b1Y0eW1ZSXY4RVh6YXNo?=
 =?utf-8?B?MG1VSkJIQkZLNVdSRUU2SngyU2JSaDYycXNWWEFrLzNUWE5lZlRKSFVlcFl6?=
 =?utf-8?B?aEs1cWpIY0tjN2sxL0w2R0N1S0VaUG1qNmNSV3pvYU9IdGkvM05WN2RhTTNK?=
 =?utf-8?B?LzNIS08zUGFHNTNSUlJRTHdqMXZmSUp5bXhkOGdSbWwyYUhndktwbnhNaXJI?=
 =?utf-8?B?SGJRU0pzNGVZN1hxbU5lR2U1dU5TcXY3NlZBVUROdWNla1JzTXdpL2VUT3FP?=
 =?utf-8?B?cUh2dnA4V3RocGxmYmFoRkxQWlcxZGtqNkoweVFwWEszTnBOYUxSb1RmNXRJ?=
 =?utf-8?B?T0loY0YvMlE0S1dVMnpFeU9JWko3VklvR3hMRER6d2hFQ3M2Zk4zZ2FHWTFR?=
 =?utf-8?B?Q3E0TjlEWXNLMjZxUm0ydkYwSlFrL3RlMDY5clZoVHk0QjVxSldjMHgzaFdN?=
 =?utf-8?B?a3BSZGlBd3BmdVRLaVRDRklISVdXdDYyMHdCZUNZSy84K2hlZnpnc3FwZ2Fq?=
 =?utf-8?B?cE83L2hXejJ2QitCOEhCbEtEUm52SVN0ZTdGa0dIWE1URDhYYzIxQ01rbExD?=
 =?utf-8?B?UnF1V0dlS2xZMjZvUFlmRi9vbXcxazVhN09HRXl1V0RHSEd6T3pqMVhzSFk3?=
 =?utf-8?B?Z2Zzd09QTEFydXBCSmU3bStpQTc0MUMzUDRSVWwrVml3TmJGSFZEV2ZaMndE?=
 =?utf-8?B?V09rM3FCdU41ZEo3U1gyQzhjR24xZDBMS0p4cTdXaGtBWTNJeEtITWgxRjUy?=
 =?utf-8?B?YWs3V1dGUmJxdXVyQlI4c2dYMUVVZzJ6OHNwRGt6akVBb3JGN2JhVUNRQjZQ?=
 =?utf-8?B?UHl6R2hEZW0yRXQrK3EzbUNXQ1ZTZjdjK2pHOHpZQUpiMXVva0s4eEJwdkdt?=
 =?utf-8?Q?VN5HMqCVkbAFhBLTwLvPwgyjg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf07d62-9b81-4f99-0d01-08dd571f49c8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 11:10:05.2752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7juELo279OzfqeBhjMV+HlEE+RRiYCu3DtWiyG85HbxRx9mjcNoa0k2+5d0Iv9HLxBhA10czhqZ3c26t2Vb/lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7372



On 12/02/2025 14:46, Vishwaroop A wrote:
> This patch series configures qspi clocks, fixes combined sequence
> programming and introduces native dma support.
> 
> Vishwaroop A (6):
>    arm64: tegra: Configure QSPI clocks and add DMA
>    spi: tegra210-quad: Update dummy sequence configuration
>    spi: tegra210-quad: Fix X1_X2_X4 encoding and support x4 transfers
>    spi: tegra210-quad: remove redundant error handling code
>    spi: tegra210-quad: modify chip select (CS) deactivation
>    spi: tegra210-quad: Introduce native DMA support

Can you re-order these so that all fixes are first and then new features 
are 2nd?

Thanks
Jon

-- 
nvpublic


