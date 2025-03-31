Return-Path: <linux-spi+bounces-7369-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3B8A7669E
	for <lists+linux-spi@lfdr.de>; Mon, 31 Mar 2025 15:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0E6188A8B0
	for <lists+linux-spi@lfdr.de>; Mon, 31 Mar 2025 13:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B6B2AE8D;
	Mon, 31 Mar 2025 13:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dUAcfDO+"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E335E1E5202;
	Mon, 31 Mar 2025 13:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743426709; cv=fail; b=Vw6zB5kAFMYPjv0+f4Ydre64q3td0zXj5EACf7IjCgTUmlh2TRJJnQBnG9PhmfuQKIeSy23qFqhbmHRvhRLpHTUSUBzjR5aKUgsT6JivaYMVwbXyOd5zSKOsSyUtNNAEx+3jw23k9gzxolUcOgowJNlpn5T7sYrZCtQcG4NiEhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743426709; c=relaxed/simple;
	bh=KZrw6hjO9S3eRtay6rZiyQBnrTQFO8xtwd1Vfp8sJ90=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sl5xpGXGTfZwD/WJ4wbMddZOWnKXfzQ5yBRtnYO7Rn6OsSra72K5yQpLU87SvRc3oKDW6hy0ssY2KDm26SNN80awSAEdR1Huong7ONWFHJe08Wq231kSlOwiptLQLS+lsG2Nqrca/aAUtMF1z9XQL/KCBYY0uIS/6Y0ElyB8pR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dUAcfDO+; arc=fail smtp.client-ip=40.107.243.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKuXiM3YgZvaRtvUlZmBQdqjmlqe+dt9UlZQnvBWSCJ1zh0HKvAUDgFt2W+kSWMvGt24OEkBVAARlV7P/k2tXIpcISbjMq6TuTRfQJf4vSTRhd4ARWckK7PSF9KubCutq5rAFUozQnKD9/piRS+eb9YFn+e1aSyWr0WCMzIF/tdn/AOtzl7W87aIjMPoEBssgdDBihUYuhCdP511HAmWmHpkHWufw2OS6yiyTqjyDT8H+BeYZJZFO2xvdsms0guSYbj4oJjKuP0OPqOxrQL7JQ3HIG96GEf7JjYchU4PtjxvPK/MtLxzP7RKH3q0gzpQz2Fjvj3PrHOSCW7ErSzOXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=awCeOJLdbR9ZtmkqC8JKjOR49kwACXkK6Hf31+57USM=;
 b=Qqc82f+/jkpNLvSgvqgiTjhudf2sUXVx2U7l1On8J0jbIlY38nGyFDG4iPpocvK1Ap4k+xFXy9UFyQMkvsRsxevFC7vYY5nWPIy5s3QLUMrxMqnN2Avz7Wd3n13ROF5IQ5h4mnZ8UQfuZ/jHetfFbwiNIZD/ORt6mXlYZsJQ5q95s35fxPutpM4nNAiJi+YOi89g4c52AKKZu84rWSDaZxL43CmBwR10zeDfaMncC/rB6XMptCNVuILNZlNevtDMHjC79y0UNJruKCkG8uKqdoVvUTHNRfXaH3+t6rCjIkonMRzRvzFns4QUaloYqfHpYfr6tVHw65BBt8azUk6nsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=awCeOJLdbR9ZtmkqC8JKjOR49kwACXkK6Hf31+57USM=;
 b=dUAcfDO+BUwBzOQmSeWfzfEs6PZLPnRkLQ0z2BRsGoezAJyzz60+lTG30LmKdrIeNX2npvKtlbFU+gamOO/oN/PGJqG99AB42BjdRefTqF3jQ0403UFiMESP0GmwU3fi4IcPkR/u7/xrqmBjy5meWkM9G/Py/jQ/IfxJrCzDA+Nca6YZ7vaKlka4S7Up1ojg4S9vESXrN8jGnLfR075YHvDTC/m2WjStQgDpY8fyjAFcTg8AatDFw4R7yyEvx1WFS8TkZbJXskC5P+GEaviHUTl57xwVZ5CQfV+X7URchQjg1CQrOI9aeaURSFS2UPTDVFkL+XOMK959wBVJMVDetA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by IA1PR12MB6041.namprd12.prod.outlook.com (2603:10b6:208:3d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.54; Mon, 31 Mar
 2025 13:11:41 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8534.043; Mon, 31 Mar 2025
 13:11:41 +0000
Message-ID: <c81d7e8b-bcce-46a8-8938-c1ead71a988d@nvidia.com>
Date: Mon, 31 Mar 2025 14:11:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: spi: Add DT schema for Tegra SPIDEV
 controller
To: Mark Brown <broonie@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Vishwaroop A <va@nvidia.com>,
 krzk+dt@kernel.org, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org
References: <909f0c92-d110-4253-903e-5c81e21e12c9@nvidia.com>
 <48248165-c800-484f-be62-7c48b3c6829b@sirena.org.uk>
 <4zic633abvwj377kfqem42zmc2yruflbwfmmqrpvjjgr6jae6h@jthoycb3vzzz>
 <ljxxml7z2k6xniamzzw4ssi7u75qqfpcvmidzy3ekr3imtoxau@eztnxovsjplg>
 <499703ae-dba1-49a6-869b-a60b44c2a85f@sirena.org.uk>
 <2oxhmcrhbwlwqgyqy62p77eoag6nkavhjwmwfjfizcrhunrkjv@eaxjy6uoxszq>
 <25857b7f-5c10-46ec-b0b7-9ff89ca5ab1e@sirena.org.uk>
 <63b87feb-32ee-423c-8d82-61445414c6f7@nvidia.com>
 <9760cd70-cbd6-4865-92b9-b48eb2cdea55@sirena.org.uk>
 <69aaba89-10c6-408e-b328-c3e31a1aeaf7@nvidia.com>
 <3b0f4fee-d46b-4086-9d63-f4093b52748e@sirena.org.uk>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <3b0f4fee-d46b-4086-9d63-f4093b52748e@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0210.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::13) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|IA1PR12MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: 30930adc-4864-4d9a-0da7-08dd705593bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2hCR2dYQ1pyUTFwaFBEdFpDK2FRNlZVWEUwakdjWlFSZWltRHRTOERjOWQ4?=
 =?utf-8?B?ZGZGNTNZUUtqNjFXUHFGaUNxaEtwLzhZSGRVaUV0Y3E0SUpuMkhPUVlYblRV?=
 =?utf-8?B?cEFUdmw1RDE4UG9VODhtcFNWUnZCLzZ4cXkvbkt4NjVsTE5vWkdXbkpaZE91?=
 =?utf-8?B?clNKWXhLTXBMdVJQSVF3NmVkTDRmQ1hpTXd4cExSYkJZZ1FxeHdWTTkwLy85?=
 =?utf-8?B?WUFwdmEwVUh4TVdwbmpKUFdUaEVRaFVTa1QzVUtGNmF6NVY0cmxGSnV4REpr?=
 =?utf-8?B?aFI0STFhSnI1WFNtK3JQei85K2M0RWlCZVJFdHd5K3hQbkp4d0lZTU5vQm15?=
 =?utf-8?B?VjRCZWlROTFkRTMrY29HbGFTNGVkLy9vT2VCOU9lSkxKbFZVUXE4b0xWM0Nt?=
 =?utf-8?B?Nk5IMEM3SzJnMmFPK2hEVlArQ1EzZFVlSXp6cm1pa01POTdrb3E2NllCSkdo?=
 =?utf-8?B?dFdrMUpGdTFWSVYyVlZDa1dLTC81TWNvNFZ3ZjFQbFJwZFpzL1kxTDJmaG0z?=
 =?utf-8?B?WldTWHNvL1dhVHQ4dnlNYnFjQWVZeTRNR3g3dytORUZDZlpkVnVYYUFRMk9M?=
 =?utf-8?B?dGxQbncwbnFIQ0g1czhnaUhVTkUyRmNZenhmUU5IRThFcW1aMDQyQXVLdjJl?=
 =?utf-8?B?ZHQ3bVhibDBmbWJ3N2FtY1A2Rllib3lTM0NvYnQvbkJDK01xY0hoTFJFRThY?=
 =?utf-8?B?YngydUdXTzBjVENoL3ZobHVCZk1rd0tXT29QcHpRWFIzOG53eU1lT1Y4NmMw?=
 =?utf-8?B?VnQ0akxUcG5HZ3lkM2o4UmZzSkJZT2E2ajNkSE9MNnlqb1NHY3NtczAyMFZl?=
 =?utf-8?B?WXVZQlBzRE5LSDk3aDlyZUdYRmhPbElCZmtkeVkrY0RTeWtTNGNtQWtOSTRX?=
 =?utf-8?B?aE8yWkRKWWF6cWJja0xLc3lqWVRTWDlFMytFT3Nvd3Q3S1JhUmZJZ3E5dmlJ?=
 =?utf-8?B?SFUxYVlIZHh2N3VUL3NaSHd6aDlaUlpKQ1d1bHB3L050YXl2K09Id0lPRmoz?=
 =?utf-8?B?ZG96dmJuY3ZETTlnbGRiYmIvbllsdkFGT01HN3krdU55UXc1TlhGdTIzT05a?=
 =?utf-8?B?NUQvV1BncGV2dVlBWFhQZ0lZanl0c0thSXhKeGx1Q2hWYmgvRTVjRzhqbnYr?=
 =?utf-8?B?Z0JoZ0FVMTNyVkxINndaTjJhSHZWeitJZ1dGT0MwNXhLOVFoNzJaUjc0aUcy?=
 =?utf-8?B?c3F2STR3c0JjWFJyQnRValVGd2M3NHZvYmxLOW5LZEdwdE9KSUc0SHRHb2tW?=
 =?utf-8?B?TFc3SkZKUEk4M0pMVk1mK2x3YytEZDlpRC9GS1p0VXhleUU4b2MrVSt3N3B4?=
 =?utf-8?B?WVFoUlNWYlgrbi84MjlqdHNVcUpJQ3pUWVlwZWxtRUpjOFdjWEdDNkVRdVM3?=
 =?utf-8?B?WTYxRVJzZkpWWVEzTlUzenVkMktpbUNKS3lCMFdrcWNvNUdidjZPdGRRcUpi?=
 =?utf-8?B?MTk2SitUVnNsQVk2b1hDQjJLOG5CY0pJb0hXbUp2a2R4MW5JdlpWMDJyd0I5?=
 =?utf-8?B?WDdzVGNURVZFK2NDcmRrc1JOSFNZT043bS9GYnFTOE9oak42OEhDYXBYdXF0?=
 =?utf-8?B?YW9hbTlieE1NQ0ZMTWd0ZWJOK2xlRWdlRFh0T1hHR1FGSzlMSEpjWFdEMGRS?=
 =?utf-8?B?TDVHY0hTdEprRDR1VG82dlpVSGtvTzZuTVBVSXpmbUZxSzFWNVlrZzlXVG1Z?=
 =?utf-8?B?Zi9QNEtIWDVzUXRWMEhjNnlWTU4vTENKMHphOE9zK0hPQTNibDd1WkZBZUZk?=
 =?utf-8?B?SFdXeEhqNjlXVkZRYlg0Q1JMaWo0dUVxS25FL3c4alpTMldxY1VwNmUxSjQ5?=
 =?utf-8?B?UEZPUHc4cHBqa1JhYkJ0TVJKSTRuWHBjRGxIVGdyWm9XMlM5YXlpaVFtUU40?=
 =?utf-8?Q?mlTggwA/nrR2T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUwvakw5V3c4WE5rWEVmMEU3QWNhQ3FrY1NZYk4zNHRJdUlicWZqTGhvcUd1?=
 =?utf-8?B?dzVFU25aTUFEUitWak56Szk2Z0Ura1NHYUFkeGxkZUkwQXJ4VzdPbTQ0eDRN?=
 =?utf-8?B?cG4reU1mSEVsYWVCQ3VyK0szTTJTSmF0elhKSUZITUl2Z21uWGNhNkpqU1Z6?=
 =?utf-8?B?WjB0YzdGQmRxNTQzRlROT3Fnbkl2NzRQaGJLb1dCMWFDK3hZMGRxa3JVYnkx?=
 =?utf-8?B?M1pOaytWR2o0MDc5ZjhOQmRwZ1FocXRnR05JNFd2K3pXQVdibG1idHdxaDRH?=
 =?utf-8?B?b29QQUtxNmtJVDB2VFJPVGQwbksvT1Q3cG8rWG5tK0NXUlBOejBaMU5Sek9X?=
 =?utf-8?B?eDh5MFBmNXJuY3lXTEdrTTlSRldHd3lmcEV2UE16RHQxbk9PRnpyRXl1UEV1?=
 =?utf-8?B?Y0JOSHIydTJ0RnFqL25meEFuUWxxdVZFdy9qWmxGMDBjWUlPZkc5SVQvMHpM?=
 =?utf-8?B?c2RDTXRFNSsxMzVsWFBUdkkzd1U3ZEdXT2FJOUoxZ3poVDRCZTBwaUNuWDQv?=
 =?utf-8?B?ZnFaTm9iejNZZFJtUGR5ZkJEZFViT25hWXdYY1RRZ09zTWNTemxBcGo1WllO?=
 =?utf-8?B?MlpqOW9mSThtOVpwekwwa2RPTTVIWEtHUzRCSWtCNlk4Wml0U0NPVUxDMUpn?=
 =?utf-8?B?R3NVb3E1Ykt3cER0K3RQbTg3Y2M3eE9rZlVpMTFnZlBVK3I1aUJZK0VDWWVV?=
 =?utf-8?B?MVJoS0x2L1hDRUxFUzVaVjJYZ3U2eUJlMUJkSFNmR1pGTks0VTBlb3JRNitW?=
 =?utf-8?B?NVh5ME5aV1JLL2JvakpBRDV4YU5SZEpkb0VNTzlPZzNKYUoxOGkyTGpHc0Zv?=
 =?utf-8?B?UGQ2Tyt4bHBlTE5kWU9PUVhiTFV6OU9rd0wwbFh5L0V0UlZrRVFrb0Z4R2NG?=
 =?utf-8?B?ZDd3VERkVVNTc09jMXVENmptZ0pzNXFoYzN5dVlRZ0tRVS9nSHp1bVRxdjhI?=
 =?utf-8?B?M0ltdnNKMWN3YW9zWHRqYnVUNlAyQnpzdDdLQmdLMjNlUldDMUZuZ1oySHpy?=
 =?utf-8?B?YkNudGJWUnBZWUtnZzBsWjF0YzJOby9GQXkrUW9mZEEzV2tvUEoxTFg0QmRB?=
 =?utf-8?B?aWIxaW5GMlF3QkdHL3hXU1VCY29VaVNHZ005aWg2dFBDbGJtakgrR003Z3ln?=
 =?utf-8?B?bjBzMUR6VVNWSTFxS2VHZWg0dHg0NlNtYnVsSVhDUTMxeTlmTG44bllVc0Vr?=
 =?utf-8?B?QVh0NUxLVFhqT1NGUGlORVFVV2JpUlB2MkhoaTdHSnpuLzlZeGhlRGYzMXg5?=
 =?utf-8?B?NkxyWWtic2JPZTBOWlRzeCsrU2VFMTFLa0xxNjBWRHpsTUxFSkRXaDY0Sm9n?=
 =?utf-8?B?Q3ZpUmx3VWZmTm5mTGoxL0ZiUHo2NnJ6Sldyc2RjTEdhM2FtRWpXV0d3MXdC?=
 =?utf-8?B?TlBock1vZTU1dExmNjQwTEdIaUlkS3JVMElrTUMzdDlFSDZNY09senZYQXk5?=
 =?utf-8?B?Q0pXTi9qOXFvSURaak1KbERGa25CL09BUXhoekZjVEVwbWxJWmZiS3hZS1Uw?=
 =?utf-8?B?OHdpVG9heURDV3VWZm1tUnVmMDYyMVN5QVRmbUFKcDdXWVp1L3RoZFpybjYr?=
 =?utf-8?B?Mm85V09mWmphU3lGcks1VEc3K1JxdC9vVzBCM2tMVlRxSXdnMFEwQjQrL2lH?=
 =?utf-8?B?R3RhdklWQ29KMWxBWDcyZHFFWTcybkJXd2xEcnZ4TlU2dHdQdVJETVQrdXF5?=
 =?utf-8?B?UzFVdkRvOUE5V2wzVkNYK1BwOW1FNTVmY09MVllhWXFPS1hJRjNXTFRCaDNn?=
 =?utf-8?B?UnpFZ3U5WlUrU2ZPejFlMWs5NmsyQXdhMmZkYnNkdlpkdFZ6SjEwZUlkbFZ6?=
 =?utf-8?B?azIwVHIzWmhBRk91aHl0dFlZbXV4N3ZoRWMramlsMHRRdXZwNnRnVnlHS3RD?=
 =?utf-8?B?eDVNUWc1K1lZMWtObVZHc3hIcTRyNlppQnBzSGhoNnU3bi82VUJLd1hWaXJM?=
 =?utf-8?B?SUNxZnQ2WVliMHpKalBIZkpkc3U0T2NZWVdDOWxXRmw4disxckpBY2xtV08z?=
 =?utf-8?B?NkdHaURJNVdpY2xtd1pGbkZrVWdPMGdQbWR1bHM1d29WM2lIMHRRWWV2bFF3?=
 =?utf-8?B?bTA2UmJhYURaSU9PMnQwRDd5YXdnVFhvQ3NsVHhXZG5qVGowOHpJL2QxYzI4?=
 =?utf-8?B?YlhlY2F5K3RPK0NEWUxkcHJTaTJKOHZYYit1RnBvYkpqS0N1dC95OURiR04r?=
 =?utf-8?Q?1CjPkqRgVVD1zQekk6n0Z4peciOBwntb0wdB9Nr1MiKZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30930adc-4864-4d9a-0da7-08dd705593bc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 13:11:41.2587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYN4H4TQuMIkrm6IS8tKXoLMP0BPguJNexyggztjp9r91X5Hxnudey/6UajnoGM84F96jmdANH3iGjU9MyiMww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6041


On 31/03/2025 13:44, Mark Brown wrote:
> On Mon, Mar 31, 2025 at 01:34:21PM +0100, Jon Hunter wrote:
>> On 27/03/2025 15:33, Mark Brown wrote:
>>> On Wed, Mar 26, 2025 at 12:16:53PM +0000, Jon Hunter wrote:
> 
>>>> That's definitely what we do today, modify the kernel directly to achieve
>>>> what we need. I am trying to avoid carrying too many out of tree patches for
>>>> stuff like this and have something in the kernel that works by default. This
>>>> is even more important for 3rd party Linux distros that will not accept
>>>> non-upstream code.
> 
>>> Overlays should work well for that case too!
> 
>> If you mean device-tree overlays, I don't see how that will work today.
>> Unless we are to use one of the existing compatible strings, but that feels
>> wrong because we are not using any of those devices and like I mentioned,
>> just using 'spidev' alone in device-tree does not work with the latest
>> kernels.
> 
> Why would you need to use a compatible string for anything?  I'd expect
> the overlay to add the entire new device, compatible and all.


We need a compatible string for the SPI device in device-tree. Sorry, 
but I am not sure how we can add a SPI device without one.

Can you confirm what you mean by 'overlay'? To me an overlay, is purely 
a device-tree overlay and even if we have a device-tree overlay, we are 
still missing the kernel driver part that matches the compatible string.

I could be completely missing your point here, but it is not obvious to 
me what you are suggesting?

Jon

-- 
nvpublic


