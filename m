Return-Path: <linux-spi+bounces-7624-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 436E3A90607
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 16:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8644D8A2D7E
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 14:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE02209F42;
	Wed, 16 Apr 2025 14:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m6qr66/L"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E662B207DEE;
	Wed, 16 Apr 2025 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744812508; cv=fail; b=pdrW2BhmZh4iXOy+KjOT/7VkjqfcyzxDbybBXzH/CXaC7FfAGr5LaNJLCNMVoTd/7w8yJu8TwDszpqu5uJQVgvGmt8A49u4XLDnM7bQPkkaU9ZvuwDa1vW+n7EnV8KcRZ0pilglCQmZupy1N4m8Ukp9u6Xy+uYp38DLjWlhdC5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744812508; c=relaxed/simple;
	bh=cEgw+u1+jV6BdxCSVwvbbvrsqW2fftZaGbN2ltmyNE4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tlbYVEOqDFOrEPvHZ5BQycRiUsfx4EyZIF37nA9Z2oFRvLRDFlra38IGZWrisA1kFz/lJLKJueOzpfxttm98TyR7ySppyaw+h2kVdnSCO5NkI2oAmSpGBn/DOlpLVZRy9afTKydznJrpnc8HSMraXReG1IWEQc5DOO7asiT7OeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m6qr66/L; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YF4b9S1QRrdwYDB0KrsKE88PB4o7jQ1nwjICBcLAdalP2cwbWtzvbHJqcgbgX/ITQdbJdWI6DexsLYzPN4qptMYnxu0gJTqnYIlthNkw9TeLzVlBPuwrfsc43c0bGbXpFdty38DTDHL2sZn6mI2whyds2xHFyvHoDa3Zw2Ez40C59APowzPpnyqLwTUWLwX2FgySfOQBk3ujUAFDpuTEQ+gmK2py0ViQ4ErpjpKua5/UYDDKGtrMRhc7Ug/FUHVYcNUmyegLV3VKZN5CHTOFm60nO9V7y3dtj4/LsW6u5ElM2AJdWjJdwK9GYtzYU765P8wLkyYhxmTN5iLiivixpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7THzq6SDOLDeo3RWsYmNYOFCEncEn2WKRgNRJWty0M=;
 b=EHYNIhoEi/DU/0CQpoVzBrt9KvaqPh+0SbxnKG/4HIJXYbd99iXkf2H8jKrVmXp4RXT9XEtXVmIi3qvsuQ5KGlmHi6a/2ASQv/Xq/RuAF/sWzMlh/tAvqfepdhgMABLntiWnbZk2MQSLHtI0TBkcsLJKP4OuwOlOdNxetQtwub+nJedwCG1tOceFn9LDsGHbT7qSWGTwk5WzuLZ8JbOcvH2vvXikne9HHRv9zX/xgQTB8FT2jpQfg+7oFXzW2bBu7f5Fh822ZApYwVJbAdb5L4W7tCXuVuu9jRX0uJpnYpf1kk435aQFVKdT0U6nqZdyvyLHfOjy65wLBbqQWHGhMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7THzq6SDOLDeo3RWsYmNYOFCEncEn2WKRgNRJWty0M=;
 b=m6qr66/L11VJhRWLBrTRIssIOEXC4faje/iQvnvkQa27tYEYsG21OXbpIxqoCSOAissoBhotXJnPqSlQALMHRhGw7YGRmD3zV8PU/neSi2NY9DhqpKGN97nSQtfw1nOGaQb4M8ZNQvuefyYzJScUD07WsIvvzsHq39Bu1Bqd3pTzLOsLVQl38K+D2/gHI4ZzkOK4izKxoRXXx8DZ18VryP+JZpMB1wUYJlEQaMaaSf7j7MmkqlwnsfEufpeU4MwZfqdET7ljhm2DPk25gn+IQt78HW45/oCEAVlR5Fa2wgEypoJNgWCoxuzEEB2o1K5maq6urG+HFo02gBj6NJudrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by PH7PR12MB6665.namprd12.prod.outlook.com (2603:10b6:510:1a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Wed, 16 Apr
 2025 14:08:23 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8655.022; Wed, 16 Apr 2025
 14:08:23 +0000
Message-ID: <05e4997c-631f-4906-9422-5af257c153e8@nvidia.com>
Date: Wed, 16 Apr 2025 15:08:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] spi: tegra210-quad: Add support for internal DMA
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
 Vishwaroop A <va@nvidia.com>, thierry.reding@gmail.com,
 skomatineni@nvidia.com, ldewangan@nvidia.com, broonie@kernel.org,
 linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, kyarlagadda@nvidia.com, smangipudi@nvidia.com
References: <20250416110606.2737315-1-va@nvidia.com>
 <20250416110606.2737315-7-va@nvidia.com>
 <1484e250-bbb6-4d1e-9285-2ccf1b8215fd@quicinc.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <1484e250-bbb6-4d1e-9285-2ccf1b8215fd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0153.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::16) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|PH7PR12MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: 23ba469a-27b0-4666-f867-08dd7cf02611
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bk00bXdVRkRMVWZmakQ4VUJFSXl1NzVpdHRuQ1p6SUFmUjJ3Q2Q4UjFtN1dq?=
 =?utf-8?B?OUhQZXdTZTM1aXZ6Y2VJU3dCQTA2Y0x5eWJBWFA2Y2kvYWRqN25jM3JrMzFP?=
 =?utf-8?B?bmZwamdVUlYxdzVZY3dDZm1JVURRMGpvR2hKbUhPTW9JRm9Ra0h4UVU4eWFD?=
 =?utf-8?B?bFJtN0J2R2FBRDhkYVdqeERlbk9jUjNPdldIeTl4dTQwYUsrQXFRcVZmaGRM?=
 =?utf-8?B?VkxsaUdSMXFwRU0rWlRHUzNDNUtLN0o0cnpzUWo4OUxBaTNDNTcwQ1BKRlNI?=
 =?utf-8?B?WDZCb2FmdUZ0cEpJdENzSzFlQVBwOWhQTk12MTdpRllQU0hxSHRRaXRDYi8z?=
 =?utf-8?B?N015NnVRWFBUL0JSTG5VZ1dtMkpCOUVwOVdjVEpFZ1djd0pOUnZ0L0lNc2Rn?=
 =?utf-8?B?aDhlQk9PQ21vdFdKcUN2OU4zVXBRMEE4ZFBOUnprWFJwMlVQVVQ1bWdxNXUv?=
 =?utf-8?B?Y2crZE5LNVRNNGlGRXRsTG9TOERvYTFnMDdEUkZ5aVBZb1dheU84SWh5WC9k?=
 =?utf-8?B?T2JTaHY5cURDR0lyc09EQ215SzVmWk16Ym9TUTVqd24xV1ZsWG53dmhtQjh1?=
 =?utf-8?B?aHRIdXBvWmlMNmx6R2J4ckZvV1R2MXdRVno5eEd2WFVmbmJaakt6T0ppRVdt?=
 =?utf-8?B?ZndkR3UrcFVOUHVyM2tDRjIxbTZ3S0lIY21IVXphZ0FSeXBaRzJoMmdtaW9V?=
 =?utf-8?B?ajdic2EzZzRwakFsZmtYa3ZSUkNaaXdzZ3JzWngxY0MzWFZLZi9KZGZSdUFX?=
 =?utf-8?B?alJ2WXNGcDhLY1F5Um1VRkQ0Y0ZEOERwa1VjSzFMQXVnTnNiZjJpUDVudHN3?=
 =?utf-8?B?ZVk3MUQxdHFNZWdyaVFlaWprSUVsUU9xb05OY1o3eThhMXVqbWZrVGZiaDFD?=
 =?utf-8?B?dGo3OFRSbmtBOGQ1SitzTllxcWloNFZKMkZkQUR2azBzeHdBazhJR2pnQWMy?=
 =?utf-8?B?WjE1Vis3MWhYR1dac1NyTVljVVB6UVNkRDZwRHF0R0J6dGllbHZjM0xKMWVU?=
 =?utf-8?B?Q0RQNEVqQnloSk04TUE1VjY0TTEvUFRaSU83aGJaNWEwWWtsL3EzSEoxOUps?=
 =?utf-8?B?dHVuMlM0K0FPbXJaMHZGUUJjMXJ3TURYNUFWN3VXdXdaOTlKNXhBelFyWVc2?=
 =?utf-8?B?RHdxMi84T2tyc1R2b2FvK2hBQi9TSHVTdUY1UHdoRHhOOWdSSDh0RTk4cTk1?=
 =?utf-8?B?QU9wWWhMM2JoZ1RFZDROQlhWaEFTTU9XVG1sclNhSUFYOFZkQXAxRk5DMXVi?=
 =?utf-8?B?REpQYXZpa2xQeENQS0lXN0wvRzlWa2ZjV0U1VE5BRklaWkRBQzhoUEp5QURy?=
 =?utf-8?B?Tkt2a3RtUW1XMzQrYWlPa1lzT2Mrd2s1RVQzQzNVQmxDa29hTnJEdlNZcVZT?=
 =?utf-8?B?cG0rQnN3MldiT3dMaWNLb1F6dFhGY0dpTStpMWxQeHBsVmw0VUxSMlZOQ3FC?=
 =?utf-8?B?WlduTUNzM3lHTXQwYkk5eUhDcEFlcG9uc3RaZDNSZHJLUmlnajUxbWRlM2Rv?=
 =?utf-8?B?dkNDQldUWnlhRTk5eUFwZm9NZnMxdVNsdnM1WEEvbzExNUxSWkJtQTlWaW9q?=
 =?utf-8?B?VEtLZnMxSUZoUExQbTVESVBNcnB3bkpMaEM4N0VKZVhUNVNtbUNLRW45TUFt?=
 =?utf-8?B?NmRRU052SUNpUy9tNXFpQnpPRkpLdnp3eU0wSVRKUmQ5ZGYwaGNOQkdFMzR4?=
 =?utf-8?B?TGg3cjBnZzZybkdrY1U3Nk9Dd3phMDJGRkdmM2FIaTRITE9lZDd3UHd2bDJm?=
 =?utf-8?B?blIxSm9USlM5VGI1QUswU25sVGF5OGJrcUhxQk1rVjVWd2JET1U5TG9JYTRa?=
 =?utf-8?B?ejNiOWJNUFFpSTdCZnlueEltUUJ6Vnlad3BGTFZENnBaUlBJbjFjTmsybWR1?=
 =?utf-8?B?bFZVVCtCOGdMZXhqclBXRDVJbERiTTdvUDEwZGkycWFJRHVKNkdoVU5NaUlR?=
 =?utf-8?B?VWcxNW9HV1g5VWJCOTlXWU1nZ2JsK29Td2pvZUVETk0rY29Gc0h0Umw2SVlE?=
 =?utf-8?B?bjdaWXhmOTNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjJIdFZ1U0FtS2ozS08zb2d4YnpwZnU5YTY4dzZpbXZ4Z2d5aWJtZ0NTcjFT?=
 =?utf-8?B?MCtoaEJjc3lMYThGT3ZKNWdrU05MbDgzQU83UjBLcTdEdnBKaXFFNU84Yzha?=
 =?utf-8?B?QkFGWXFMaTRFSmVFcjhsV2grazNhNUEyVWZRdlJtNTVXVy9QZHMxaWpVUXpj?=
 =?utf-8?B?ek5teEdOVE1wNW1WNEk3VEI4M3p2Z1lQeWhyczV1aW00Z3NWdFlURzQ3THJU?=
 =?utf-8?B?Vk05MTM1ZzJmd0FFOTlhU0ZqSHBLYzcyYmdKSUhmcnIya3o0eXdyUDZUWjdn?=
 =?utf-8?B?UVFsMkpSZXlSVXdGM2JNcndGZUhKNGM1S1RoQjhVd3lRRG5DWXNqRnFmNTRO?=
 =?utf-8?B?c054K2Zac2haWkRRZnR0dVc1WFpJRGczeDRzNlo3NmQ2Wm5QLzdXSHRWNzFF?=
 =?utf-8?B?OHA0Y01JQXJXc3REcG9pckQ3Z2VzQzk5WWxUNndVbVBSL3F4UUFrSWFmVDZF?=
 =?utf-8?B?Rzk1OEdnUFptZXgySDlrYWFDNWpmTUM5MGtnUUFrRXhHTFIrNXNuZEdKK25z?=
 =?utf-8?B?bTl0V1ZsM0dyWDZHMUxjR2I5V1gyRlZlVTJWcXpSYUxvREg0VElFbG15OXhP?=
 =?utf-8?B?U2MxdGpjMnpuVFQ2c0tMaHJFbnE4dFN2dkFzMmRFbmEzL0xmN3lBcERHc3RX?=
 =?utf-8?B?TXE0aDEyVVlIdUJScUFnc0t1eUlQckx0MjJxWCs2d3A4aUVjMWJrK3U3em1Y?=
 =?utf-8?B?TGwxMUxyei9pQ085TXZYUGlpOW9HKzRXWUs4ZlhrS2VJRHl3dS9hTnhyOEMz?=
 =?utf-8?B?M3hDMlZReFVlMU93Rk00ZDVoOXlrMUpydit3ZEZxclVSNmJMR2NmdGdlcWI2?=
 =?utf-8?B?TVhkbHIzd3FlMW1kR1N4c2wwbkxEdTRWSmdXUURMZmlDNm9ydzgyYUpkcXBa?=
 =?utf-8?B?SGpQM2FIaUZxWDQzOG5yZnpWVmNJZmVwVWRMVlNseDN5eTBQNzd0ZUttMXRs?=
 =?utf-8?B?bkFrUVJxRDJnRXlVdzFQUmF5WWZsU3JOSUtNRCs4NHVPYzZJNkF4Z1p3eVVn?=
 =?utf-8?B?bHlxNzJjb3M5ZWQzVWRBUVNvQms3T2xCTW5ISGxhMzVUL1R4S0VBWXVtSUxs?=
 =?utf-8?B?Q0w2bm91SzZxUjNXNlRaS2lRYmJIaVROWElqUUVTQU1TUDMyNlV4NjlPQXNw?=
 =?utf-8?B?N2RSTUhiRnVlS1FPbC92aGVYNXJRbXcxYWtQMGRxc21Ic0p1U050YzhxeWxE?=
 =?utf-8?B?TEtld0JCUS9Ha2dXc242L29BMVB0akZUSEVoMVVVWThOWXl1aVAwQXJhdnYz?=
 =?utf-8?B?Qm83RWVydzg0ck1FeVlkVVh5cmFsR3ptT2NZdHQvQytXcWFsTzdoVnAxU1VX?=
 =?utf-8?B?b2diY0RqOEFPc0RsVjYrTEIwdFB3WUhFYzBEcUNJdWlxUXMwYUZWTnV4OVNm?=
 =?utf-8?B?ejdHQU1hZXF1MHVyVWlTTGM4dERoN3JiWnJaZitybi9oRVJaTFdnMU90MUdB?=
 =?utf-8?B?dGlBSEsrNXF4SHNiRTJ2bWRpOGNnZXlUVlA2bGlGeHdrenpaQUx2eHNlR2s4?=
 =?utf-8?B?ZHVpZkZaWVJhQ2h0ZlNXZWlneTFrcTExSEtId1pWN1NhOFhOVlpRcHRoek9N?=
 =?utf-8?B?NnN5N0tjWllKVmp1dzQ0eURtYWZtNUdPa3ZlTmVjYWNUcXE4NzBXdmI3YlA1?=
 =?utf-8?B?U1ZURCtJWEI3MW5kSmFSNHZvcmx2Rlg0bG4raFhPSHNRbWpOMmI2U1hTQ281?=
 =?utf-8?B?RHVUR213VlhBdVh5bWc5Q2daTHFIYzhzdTlRUU9zQVFNYjFOakZ4OEZxZ0tS?=
 =?utf-8?B?eEd0UWdKWWJqeEJ5YlVFM2pUcEdhTDFMRTFyMVpFSjN4ZXhVU0VQbTM5c1Fn?=
 =?utf-8?B?WmFEdnYydXFYb0JwZ2xNUEZ0U0kvMCt0ODF2Q09pempSQk5WNUpndVluMmJG?=
 =?utf-8?B?bVRlejgvYURQdDc1d1VNLzBjdFRzcm5TZ1I3azQ0b3NtMkpOM3Vmd1Vjc3F4?=
 =?utf-8?B?MzRCRzR4KzZleHJyNGVVdTRjaDdTdVFjY28xdnBoeHU0ZFQ1UXMrQTdjWnFU?=
 =?utf-8?B?TGlLU3I0MG5qZFhyRlhSbXREWmNZVXZTMGU5dWQrTGNFbFBpYU5xK05kaFlB?=
 =?utf-8?B?WFlsWncreWVvdFp2d04zZTdBay9HSnd5UDJNTHZNQWhqbW4wdXI2NEZ6Y0hI?=
 =?utf-8?B?K2RLanlGRXAvR1N4eDE3K09vREVzVzhxTDFIVFc0RHFZL2hGdDN1WXBPZzZF?=
 =?utf-8?B?aU8wMG9WVExleTJpVFBBQ2N0UEYyNmZuMFFCOVEzdnY5S3F0a01tMnZ3eG5l?=
 =?utf-8?B?eDFUUDlSUUZBTzU0cm9rWjlHbUd3PT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ba469a-27b0-4666-f867-08dd7cf02611
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 14:08:23.2981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0i65mTXsj3hjCOzUcvuUjRpf43BvVMTb3GTzkeBfqfYN2Xp8wyGTy3+ALmqdMJnfe0EksB+jv5KjkqdyJRrtDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6665


On 16/04/2025 12:57, Mukesh Kumar Savaliya wrote:

...

>> @@ -1384,41 +1419,43 @@ static irqreturn_t 
>> handle_dma_based_xfer(struct tegra_qspi *tqspi)
>>       unsigned int total_fifo_words;
>>       unsigned long flags;
>>       long wait_status;
>> -    int err = 0;
>> +    int num_errors = 0;
>>       if (tqspi->cur_direction & DATA_DIR_TX) {
>>           if (tqspi->tx_status) {
>> -            dmaengine_terminate_all(tqspi->tx_dma_chan);
>> -            err += 1;
>> -        } else {
>> +            if (tqspi->tx_dma_chan)
>> +                dmaengine_terminate_all(tqspi->tx_dma_chan);
>> +            num_errors++;
>> +        } else if (tqspi->tx_dma_chan) {
>>               wait_status = wait_for_completion_interruptible_timeout(
>>                   &tqspi->tx_dma_complete, QSPI_DMA_TIMEOUT);
>>               if (wait_status <= 0) {
>>                   dmaengine_terminate_all(tqspi->tx_dma_chan);
>>                   dev_err(tqspi->dev, "failed TX DMA transfer\n");
>> -                err += 1;
>> +                num_errors++;
> what do you do with incrementing this local num_errors ?
> I don't see any post processing .
> Also all are are mutually exclusive due to if/else, not sequential. So 
> could not get any specific usage.

This is really legacy code and yes I am not too thrilled with it either. 
At the same time this change is simply making the variable name a bit 
more clear. It is not critical that this is changed as part of this 
patch, but does not hurt either. I don't have strong feelings on this.

Jon

-- 
nvpublic


