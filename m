Return-Path: <linux-spi+bounces-10697-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6B4BE3C66
	for <lists+linux-spi@lfdr.de>; Thu, 16 Oct 2025 15:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 788335E008A
	for <lists+linux-spi@lfdr.de>; Thu, 16 Oct 2025 13:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F02339B31;
	Thu, 16 Oct 2025 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cnXyy8p5"
X-Original-To: linux-spi@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012066.outbound.protection.outlook.com [52.101.43.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CA818A6C4;
	Thu, 16 Oct 2025 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760622282; cv=fail; b=bIoNAwOSRks9hQdC6CgKsxO1uQy1XuW+YV/eL4cY7a3Z2npcLq8YgLxBWMgwnCTl+PMwkV8lGdCInPWpl/p+omBJEqPHyyR2Bw/bjy9wRWpcpC0nMjdEk+5iE0Hvkh8mZJyPeCqmuasqGoUVEeDz95bEn0AVlxpGIYASMwFDL2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760622282; c=relaxed/simple;
	bh=He4CzMKrFeR59b66jMNHxm2mojYJvpsEDtbAM3H9nZQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QfqmMzJeF1DenjIM6afdsBt4jBwjgaSa1cgwTDAJtzlCfdE2JCqa7xQex4j8J4jpW6dELFC4wqUOkzYQPIi42j5gpcFPCWGeDQTh85kY3BiXzDZClWTaFMue+ZvFE5CoiayzaGJ8c0Ki4WNBb6M5z+jaJNNbyuI/Mf0yj/lHSHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cnXyy8p5; arc=fail smtp.client-ip=52.101.43.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HBXgvy5EFP7/OoRa36IoLhY8hsRa6q5GJZc8pEPoo8Vh+TVuT71FY6k0EzI8viQsEgeCyKNUHwEBms3MYC4G8z3HN/g6WogLiyBe7VIvXfkXJA/sLkNChCDLZbcmGgHqIaDK/JNhc/MLU/nVz9vCZVZ9au3/G7vrngFAnxf1WLtQv1qmBnacLoXrG4AbjCd/QBc/TxHiBAQnq5YU5+Y53H8gdmuQGUVfyHyypccXIh3PYl4aVsUZqKGWnjdASYvDSuYafWVHQtUMu0Ypd+8Iebd45ok2SFNVnQ48sJXFaXoCOxOva2eVRQhxxu6Hssg3K8b7v8MJPlYXHRFeqTNQ5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJiIHkogORap2WTdZzLu5bTB8kOL/h6JFfUJrL6kv0Q=;
 b=WdvJt4ZpSS5ENjEZPQh8ciQIlvSoHsJTUezqb+NklMo7ZdYc/yHtHr2/qYtC93v+4Qs8rdLkAymSgbOtBmTMIfz3xsjjayaeQGHb6688SsLsWTmlXbmfCTAEEf0/govmLz27ICpsdhDtnanyNvHiA+h7VKtn/AuskQ9otPGtFN2EbWU96XHoanRB/CWS5su9OWsziJzD6ESzQJ3UeIr1pirqLyP18HU3zZWZym/jCcV1PiqXdfYdKw/xOuKFF/H6Lr7KrGgzooJXJdgvVxT+n6piy0zzIDKeA6qWx3hfJcOSu7tCPYlSQEzcJ/iBBNjbpHdAYtjve+tx1lSorUnkqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJiIHkogORap2WTdZzLu5bTB8kOL/h6JFfUJrL6kv0Q=;
 b=cnXyy8p5oROlEg+bN+NTxENCBA+kZmql9DCWSL0U1ELo/N1JX9UvQqsd1lb0NKchO2jc40ZnDPUo7yhIQSlt77wjOnbnUKoGtSZng6dIlsfZK2Qtjc4p1ZLB61bR5GSEFzZ19jEf+LG04QRmhlybhBzkkp7tUJ0LV4uy/doh8dtrGaovBWlgPa+xbEpcRfSvLcczXzaaOVNxPKI9UpygSBd+C549uEEndsDc9HUNXwNEhRnNbtUsa65u7wpJO2skop6tpHvH2gb84vDPbRGsgPVF2ZyYWuyXdtA1zyDYbPmHPJtLDIRn08oZIKPfTiXO6ezvfDouwZiwHmlAT3siSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 13:44:33 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%4]) with mapi id 15.20.9228.012; Thu, 16 Oct 2025
 13:44:33 +0000
Message-ID: <21078f4e-cb55-42c3-b3bc-2bdf8ce38aa2@nvidia.com>
Date: Thu, 16 Oct 2025 14:44:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] spi: tegra210-quad: Fix timeout handling
To: Vishwaroop A <va@nvidia.com>, Mark Brown <broonie@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Laxman Dewangan <ldewangan@nvidia.com>, smangipudi@nvidia.com,
 kyarlagadda@nvidia.com
Cc: linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
References: <20251016132923.3577429-1-va@nvidia.com>
 <20251016132923.3577429-2-va@nvidia.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20251016132923.3577429-2-va@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0663.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::10) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DS7PR12MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: 594cca32-286d-4e42-bf68-08de0cba2336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWtFc0x1WHhuL0p5SjRJR3gxNHhXcE1SdDdYSjhaUjl0bTZLSHdSelZCcXB4?=
 =?utf-8?B?bWRUTnBFTkcvRm1ta0hvNlhlZkcxS0tUd2JkSnhGTTZGZmZ5ZlF1YVR2QWJD?=
 =?utf-8?B?RklGQ1VpTFdMbmdPTGV0SkNVR25WNFhMY0pwMjdMV2x0RFYzcnhKRG54U2F4?=
 =?utf-8?B?TFdFU0FOTjFYVi9RRVZPOWRLSm5YMG5hN3I5OHhVRG5HdTlHdHk2dnl3SG51?=
 =?utf-8?B?OUlxWit3TXRxSkI1Q0JyVEJFd0M0RGNxeTNKZmwva2JmU2RxYlFvS1VmbndW?=
 =?utf-8?B?SEtqcGtNRDZwNCtTb00rdDlmWkc3bXJtUS83NVY4bEpsbkxkSS9TcW10a1Rw?=
 =?utf-8?B?WnZZcW9GNTU4eFhPOWE0aWZNMTd0TkQzakx1NGhjVTBSQlBjUjZwMzFMTXZm?=
 =?utf-8?B?RGdWVVVmOXluVGlrV2U2TzF0ZjhTcDFDUHd0MXlvYlR0QTA0QlE5SFZtRUpE?=
 =?utf-8?B?MjFDdnB6aWFVdEdNTXJlM0FvbXR2YUFPYnBzTXZZU3B6YVl6WWVNWjZWaURm?=
 =?utf-8?B?VG9sV2piSyttNkZ4cGtGR05iRDVQVjM1UDgvTXFicFpibHJ4U0duVUlkSG9X?=
 =?utf-8?B?Wk1aS1FkcCt6c3FqeGcrUGp3L0NpZkdiYmtSWGlCQVJXcTJ0VkxUQVBPbUtS?=
 =?utf-8?B?MDZjbWsrVkFYVms4dXk1bDI5UVBWMDJpM2N3SGFIZVdHZVBndTZyeFdEOW1q?=
 =?utf-8?B?M002cUxoRUJqNnplTXNFb1RzYUN0VndtMjFkZ2J2djJBejZxb2NJMFJrMTJr?=
 =?utf-8?B?TWs4ditUdXJ3dWZySzJ3YTlFdzhFckV2V1ByenYzbS84aFEyNkI4RE9yV0RI?=
 =?utf-8?B?SitxRUl6czV5TkRmaHBFNVF4Sll2ejVmb2ZlYVVCOEszSm5VMkJDbnJUQ2VQ?=
 =?utf-8?B?azk3aE1zSTAvYnA1M3R2c0dySGtoUUFnbEs4RTBtcG92VXNoRlpwK24wNnc2?=
 =?utf-8?B?OEwyc1J0R2ZSdTh2YjRWdkZUREFVYUdPMm9Zc0tjR01DV2dwQ3BDdHpZUzAx?=
 =?utf-8?B?c3pSTk9MUWREVjJDelVvZU5ZdWFVaFViOVBra1RCcUdIUXhYUnBueHlIOTdt?=
 =?utf-8?B?QVV2Y3hsWHVnRWEyL1p3MXFHL29xMEJqdFpqbTV5SDgrOEhlYlBsWUdPS0V3?=
 =?utf-8?B?WHJvODRPT3JOMUxiY0Uyd09ZUzNDd0J3OHlONGZFZFhJQXNQb3NZdE9GQm01?=
 =?utf-8?B?L0Nxd0FUZWdQc3JEQlR3djc3L0JqV013NmhxWVFNRE1vOXNxQTM4N1VuZVg4?=
 =?utf-8?B?eTZ1ZHJwNWFqYS9UM3FXRjRtSXhveFlyZnc0dzkvZjFoVTZ0bEg5bXJMU2hF?=
 =?utf-8?B?b1Zqems1MjZUdVhtOW4ya2o4a3MyMmdqcHk4VW94QlhscW1QSEFsMWQxd0VL?=
 =?utf-8?B?RWdaUm5ENFlXeklUNUJPSXBEK2c5U2I5RzJvMWw2eU5Ra2txTFIzK1lxR0hB?=
 =?utf-8?B?QVBZVmttbVlrS05VRE9ISXNDWkx5TlMzUmppcU9peG1ybjJCWWMzSmNIUmwr?=
 =?utf-8?B?NkpVQUpPMnRXaS9LZWJEY1ZCc3NmUTRLM2xjeHhNQ1FneGRwdGdIdmxjNC9P?=
 =?utf-8?B?U1JqcTZ2S3VWcFFvbE1zQklQNVNZcXdWQXFEZmRFeVk2WjVEbWhRbzJiMDZK?=
 =?utf-8?B?eXR4dW9nTEZDS2drbzFwWTFnVTl3ajVmVFZEUy9jclU3L0Y1dXUwbndKdURz?=
 =?utf-8?B?b3pkSlVVakFWajdPUXpCSlpRZWpHc2Y4ck1reG4yUklDZ3BOTW9CY1JMbjJm?=
 =?utf-8?B?T0p4cm4wVndxTnFpTWJnSFFaMVJVcHJ5Q3Jkb0J3bVlBdFRYYm1lZjNHRnpN?=
 =?utf-8?B?Q0ZxMjYwUU9Ma2l6MzZCVmRXYTBLTFBkem1tR3FOVGJmK0l1eGR4MmM2aHY4?=
 =?utf-8?B?dlVTeittU1BudXJQYklzVVB3UW5ucm9LMExBUVR4Y2pybU9QMWNmQ0pTWjlz?=
 =?utf-8?Q?c9YVYZNhu0R9Ig4oaIW6SdS5+7PFismd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWkxTVRUUVdDa0lSd1Y5aUE3MFFwS1ozTmcxcTlQaFM3dER4emNuVVplZmEx?=
 =?utf-8?B?VFc5MEdOQnlSK2RuRGhsdWNocUdaVkUzK0d2SUNsdFhma1ZyWkJpODRQLzda?=
 =?utf-8?B?SjZORHYvMFVlNG0ySlpoSk8rZVZ5eWZKVngrVTgwOHRidHRNaUtPaXNsdGNP?=
 =?utf-8?B?RkJvQnFvVUdqVmNzRXJPRFJSYnhMajhkNmZUeUpzM0ttcVFQRXIyMDFaenJY?=
 =?utf-8?B?MWFuZE5ycXprUzdHTUJLN09pbjNTTURmUUJtVTNwYmVxSGp4ckE1eklWd05z?=
 =?utf-8?B?czVhT2V1cVpJbVB5YmpkZUtzMTg2Nm83RXBnbHlBcDN6NGRuWnlsbkV2SmNZ?=
 =?utf-8?B?dDJWK1lmSjQwRFdmemszeGs2UEJwOFcxSXpJT0FjTHhNb044Z2tMTVIvZGJz?=
 =?utf-8?B?bGpzUWZySzVWY0wvNTlrcy8rUnR2dEtvb0I4blZmV0E1L2diUTNWQi9SdFB3?=
 =?utf-8?B?anZOQzBFOVl6UXN0VW5hK0VSV0tGSU94dUlPMDRiWXRoWlpvV28rTWtqVkVQ?=
 =?utf-8?B?R0JuamF0RUpnVkRqUlhrYW1zV21Ta1F1Yk9KSWRIbjFnZisvR1VERlUxanF1?=
 =?utf-8?B?MXpwVWRrM1pDMURlYkIxaURBOEZ0VDRudlBqVjhBN25kNE5sN2k1azF2RHcv?=
 =?utf-8?B?c1VJL25CMHVCeXdOQXZxdWdsQStHOGd5aVZTUE5nT0Mrem9oQXZqUGt4TDZ1?=
 =?utf-8?B?SldYblNhbEp2VHdaU1JJaFNDaStwTnNCbnhlNnhPelVheUtEb2p0NHZXN1Zk?=
 =?utf-8?B?M1NoYmNpb0UxRXY3aEJEVkZvZHJpWEVLN3VUSHpJMjc5L0tpaGpGSFVsaXNk?=
 =?utf-8?B?NDZjejlaUUN5N0FKWEd5N3R6a3N2aWI0N3kxMGdSL1ZJYlhFRlpya0xITjRZ?=
 =?utf-8?B?akhLenpGdGlDalNOTzFFTGttUkF0YjJBL3pKY2h5K2xxUTdvWWhHT2VwZVYx?=
 =?utf-8?B?TVRRVW1ZRXpUUzdDcTVaQlBubVk0a3hPZXFhelRFUWtmVTdGS1VFbHpBRHZl?=
 =?utf-8?B?eHNaaUFvOVlKaFhKbENaaHgydkFWS3pSOTdzNm9GaGVJQ0o3UlQyVnBOcHM4?=
 =?utf-8?B?MG16QXhIZTREVW8zK0dVdVhldTlmcWZ4RllpeUNWNWQzV0xsbWF5d3dsYlk3?=
 =?utf-8?B?bTArdTJ1MWJDSFdrdjJwVXVyOVFkSHc0Qkoyd2pLelNXalcrMlZEQXpoK2Np?=
 =?utf-8?B?TTRXSGlFSkdBWENFekVTaDJLSzZhTC9vQlZmSzJKUHp5THo2eXNQSWZ1ckhH?=
 =?utf-8?B?TExJRWFOQW9zanEvSE1ZV2UwK0pVMCtnOVdPaDFUMVpDd2ZPMk9IeVplZ0xn?=
 =?utf-8?B?b2NnUThabmMrdGoxYVpCUWJWSVFhU2ZsTTNkdTluaGJHYk52YXdoeWpOY2RJ?=
 =?utf-8?B?UHFFZ2hRQ2lTNG1DQlJaR3lTN1BRM2dnSFhReVNtSXR0WXVqVUxnVDRsNTAw?=
 =?utf-8?B?aGxrYTRXWnhvVGl3c3UwOStCREt5dHpUbGdPQ2krM1Q4S2FINUJjeFZZcmJ1?=
 =?utf-8?B?cEtSVHR0MHZxbUt1MXRZVzFnSTVSd2xRSEcyb2xiVnEwQkRVWGRRY0xqR3Jv?=
 =?utf-8?B?R0dPYVcxRkZ5R0hpRVdNaUR4QXZxUkRNZ3VWZHM2TlZYalhXRThTY1EybHdV?=
 =?utf-8?B?dmpDajhvcGdMRCsvYWxLMWRsSHVJOUIzOTJKeGxnb2dIZEx5eUVJbFpUeDVp?=
 =?utf-8?B?Z0N6cW1BZU1iRGpVc2lrU01YUFJyOWpyRlJLL1kyMGk0L2J3TE1INGxnd0F4?=
 =?utf-8?B?UDdqUGJBTE5DMDExYTl5R0lhT280akRpbFNYWWU0QmNsZjN3WXNkYmFOWkla?=
 =?utf-8?B?bFhPaEg5Q2NpR25JZmlNNjlaVGg1dEFyL0RFNnhUYkVnM1NNQlQwK25VblNV?=
 =?utf-8?B?dDBQL0hmUWErS2s0dmh5T0FyRlIvN2VsTU5SQ3FKZnhQTE15UzhMRFFET3hu?=
 =?utf-8?B?Q1JwbU9LV2JIWnp3ZmdNeFJ5aFdyVkQyME1pWWxGVko0OHpQR2hEN2luZjha?=
 =?utf-8?B?cEExZU5IRTlYenpuVHM2cTMwaVBPcW0yWHRQNjhQTnlGQW1ZZ2V4K012M2Ur?=
 =?utf-8?B?VXN5b1Z5MnNKLzg4bk5HM3dsZHQrSXIyK3hKK1hoaThWbnJTMEpUKzM4M0Nv?=
 =?utf-8?Q?K7G/kRTOn7jcQpSb0IsF/teZI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 594cca32-286d-4e42-bf68-08de0cba2336
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 13:44:32.9268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3hiphbpHuayXaynGjIbkp2i/47hYaz2HanU51xWHdBw1aINQYiM6UAwht5YxWE1QHSlO54rM5MQmvUxbF6Vf5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5768


On 16/10/2025 14:29, Vishwaroop A wrote:
> When the CPU that the QSPI interrupt handler runs on (typically CPU 0)
> is excessively busy, it can lead to rare cases of the IRQ thread not
> running before the transfer timeout is reached.
> 
> While handling the timeouts, any pending transfers are cleaned up and
> the message that they correspond to is marked as failed, which leaves
> the curr_xfer field pointing at stale memory.
> 
> To avoid this, clear curr_xfer to NULL upon timeout and check for this
> condition when the IRQ thread is finally run.
> 
> While at it, also make sure to clear interrupts on failure so that new
> interrupts can be run.
> 
> A better, more involved, fix would move the interrupt clearing into a
> hard IRQ handler. Ideally we would also want to signal that the IRQ
> thread no longer needs to be run after the timeout is hit to avoid the
> extra check for a valid transfer.
> 
> Fixes: 921fc1838fb0 ("spi: tegra210-quad: Add support for Tegra210 QSPI controller")
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Vishwaroop A <va@nvidia.com>
> ---
>   drivers/spi/spi-tegra210-quad.c | 23 ++++++++++++++++++++---
>   1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
> index 3be7499db21e..10e56d8ef678 100644
> --- a/drivers/spi/spi-tegra210-quad.c
> +++ b/drivers/spi/spi-tegra210-quad.c
> @@ -1024,8 +1024,10 @@ static void tegra_qspi_handle_error(struct tegra_qspi *tqspi)
>   	dev_err(tqspi->dev, "error in transfer, fifo status 0x%08x\n", tqspi->status_reg);
>   	tegra_qspi_dump_regs(tqspi);
>   	tegra_qspi_flush_fifos(tqspi, true);
> -	if (device_reset(tqspi->dev) < 0)
> +	if (device_reset(tqspi->dev) < 0) {
>   		dev_warn_once(tqspi->dev, "device reset failed\n");
> +		tegra_qspi_mask_clear_irq(tqspi);
> +	}
>   }
>   
>   static void tegra_qspi_transfer_end(struct spi_device *spi)
> @@ -1173,12 +1175,14 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
>   					dma_ctl &= ~QSPI_DMA_EN;
>   					tegra_qspi_writel(tqspi, dma_ctl,
>   							  QSPI_DMA_CTL);
> -				}
> +			}

The above does not look correct.

Jon

-- 
nvpublic


