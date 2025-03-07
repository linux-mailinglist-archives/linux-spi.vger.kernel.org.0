Return-Path: <linux-spi+bounces-7076-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4697A568F6
	for <lists+linux-spi@lfdr.de>; Fri,  7 Mar 2025 14:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6A5189B393
	for <lists+linux-spi@lfdr.de>; Fri,  7 Mar 2025 13:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE6F21A945;
	Fri,  7 Mar 2025 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TohN6aRC"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC3521A44D;
	Fri,  7 Mar 2025 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741354139; cv=fail; b=Glng2gUJ+EtJ+8AZnQvM2cUiaaaUAJjWxcXvP3jTpYCOYd/snX8yc3cjHP/qdZUA3MjKLE8Yu+KYLzquxdGDLFsDVUKDP/Jj57mQHvsyI/UvA/GbYg7dE2Ca/ClPvHyZjt5k/JVrZ0/cZ9SkkgWONggRkQAQealo/yrdfMtSFQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741354139; c=relaxed/simple;
	bh=zHXkZb/fz2igccEBJpLvlR9OmKt81TmErYk58OAOJxs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aFX3+JrEWC+/w233aJGDDL/AXxKjVBBqeq+w0UBtZRsSuHznouFmtuwHNwAsC2aSOwFwPQZFyG85Rs+yazWexccXR9T4Fz85crCW7zc515+hkvFwshtNyjkApVkLzoTWUV6m+s75krXu3iCwgtxAeTfmMsjxFL6TsoniasbalYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TohN6aRC; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmpJdnLGYm7tTx4CEOus3QygYx+3MDz9/lz9+SkcqxJWu05nJ0RClYFBWuqX19Lt3QirqSPwvU0jrEis7SbswbXKAlyjHvT4pJu6MJqWPyxU0Rvb8k4ge/lLB5ZcfNQ7jr7YXEst39D3RxaLJuPxNHgATb93974o6MwUpaguzWLexkQ0Onk5vSCVmNmFAuseQURww+/N179Su+AVY9/zjItfnwrVH74qzFfUUmBzIF+BcDwByXqAhQ0naCmsEpLWgHE2XETQ2LzE+K9MwkZc6778IQ9D063EFcqJCxdiYa2YxuvG3zKp+SOO2KeNHj3pkgtzkOOyjb7UV4YkFrE7Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqbKquMIzmsVYY10VmGrPwRzjFueGDPmcvJc9VIfIv8=;
 b=PztFy0+J5UnevgkLhvKZJSTpnHPdyfKaAbWPCd3FnOt5H6dgS77GpZ4k2sCqZGrEDzjjjOigFU5l5CG3Lgy6n7TpAa/cblK1zC9ABC8OcIehUFbf4asGHr17QkUNcFveO7Po8sEzJRfpdZRNCkTPdITyUfo3urfkV6SzPrAoIol4PyUj4xqeuwmqFVCh1wVhZzQNKs9qiB59hK5PSj5dctnZIZX4M5xhAV4+1JazHrY8/MCNHaFRNOTChHD1xCbrJ+VpDjju2bWFJnCn9YGcZgFx+CoJYLwPB3cBJ1h9tHOlU8k18EdTsqQ6L/taQmTbbBRPORkcfcvGUfO7hoNusA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqbKquMIzmsVYY10VmGrPwRzjFueGDPmcvJc9VIfIv8=;
 b=TohN6aRCInPAIGosUhhI8KVSDAHhtpVlOkN5wxUxYeTmiEEOZ398dSdqjBrUbdu1Wo+9GiA7k0Px7QhRJrsDCbMPtUCir9I92iWia/CoiXblVvUjj66Z1vPWYNTOVp6An0Zvn+E5nU+8ptcrIYrq6oBAOssNzRdMbZxnGgzRU5fz/eXj1N0CNItuMZYjAmEpQh0ymsxSaUxDl1E0jhsUSHtTi6N2djdwckRDjsGdiDjF07kPRe7nv92MblguZIWNIaL52YKdukI3CZL6xIZ2zPWZmzn2OsOY8w71LVoL0e9J9YCsUDLGUzTE1P14KMyV95yP/ghHmywN04xwvcHm1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by SJ0PR12MB6926.namprd12.prod.outlook.com (2603:10b6:a03:485::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 13:28:53 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 13:28:53 +0000
Message-ID: <b10fb7e0-200a-4d2f-9ded-146841657a8f@nvidia.com>
Date: Fri, 7 Mar 2025 13:28:48 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 1/6] arm64: tegra: Configure QSPI clocks and add DMA
To: Vishwaroop A <va@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Sowjanya Komatineni <skomatineni@nvidia.com>,
 Laxman Dewangan <ldewangan@nvidia.com>,
 "broonie@kernel.org" <broonie@kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Krishna Yarlagadda <kyarlagadda@nvidia.com>,
 Suresh Mangipudi <smangipudi@nvidia.com>
References: <20250103060407.1064107-1-va@nvidia.com>
 <20250103060407.1064107-2-va@nvidia.com>
 <s355cib7g6e3gmsy2663pnzx46swhfudpofv2s5tcaytjq4yuj@xqtvoa5p477n>
 <SN7PR12MB67687FB2A524ED45AEEF6C17BFFC2@SN7PR12MB6768.namprd12.prod.outlook.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <SN7PR12MB67687FB2A524ED45AEEF6C17BFFC2@SN7PR12MB6768.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0361.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::6) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|SJ0PR12MB6926:EE_
X-MS-Office365-Filtering-Correlation-Id: b9617840-0570-46a2-8fde-08dd5d7c00ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTN5cUcvS0cyMVIvU0hyY1Q0S2RUbWxwV285SmdzbWZFYmF5SDFaU3FZYnJG?=
 =?utf-8?B?MlFPWkpsZ1FHRmdQNXpnZW9yNm9jbXhtM2h4Z3lSb1VBcXdLZVhhRVAzYkVS?=
 =?utf-8?B?amJrOU1DbFJ1Zk9oOVBDTEhVaHNDYzE0MlJTeFcxSnkrQjFmRnpBdVZmeXlo?=
 =?utf-8?B?MjA4OU5CVk5DOEdnMitqRDVuUmo4TDFyU2RjbEVidE9yeXFTMGQ3R2VjWkJq?=
 =?utf-8?B?SWR5NU9jNmx3SU8yNTJVeUN4TmVMcUw0QUhDNlFPb2I4TnRjOXp4Szc5Q3dv?=
 =?utf-8?B?Y2R0RlNUVHhyQ1JrYW1SV2xHYXZSb2pKMXR0Y2hCcEkxRVlQcDROYzc4cmZ5?=
 =?utf-8?B?WTMreHFRY2N6VGxaQVY0bEtjK0VuY1QrV1BrSlIwcnM4aEZpS0h3dEhIeXJz?=
 =?utf-8?B?a3hxaEZUYUJwSmVYSVZ2czdYZ2xhTE5tbjVaZmVXUTZNbDdMT2NOQ2ZoM3Iz?=
 =?utf-8?B?M2tkc2JLRjZ2T295cGNIeUYwTkluY2xsUHBadmpDN2ZOdkpsaUJvMVdyZHJy?=
 =?utf-8?B?QjBjcE14Q1FudnFiY3BNNCtLVmE2bFM4NCt3dnFZc202YVhiT3JHVXZxNzht?=
 =?utf-8?B?dnV4dVZMN3Nhb2dONUFNcUZDK0Y1U1hveFQyck56RTI4YzJFbmVvaHJ6MzVj?=
 =?utf-8?B?SE5hR1lhdTFMQXBlOEtvWXRZVEhUSEVoeEtwL0dSZDd4eU5CTGk1c25ydkFD?=
 =?utf-8?B?VEJZNFNTNUFmOWFHTU9hWjQvUFRmSmIya3NnWXZzaVg0N3d3bmE1ZUJHZ1lk?=
 =?utf-8?B?RVdRU3FTZDdrc3dQclh4SUtuOUlTY0QzUFVacUI5eDVCUytRa2UwdmVOUnhL?=
 =?utf-8?B?THRnSHFCbldpakQ5ZmkwWjJ6bE5hWVJEV3lOdEdvK0xoUldaTFBLb3cyT25Z?=
 =?utf-8?B?N2pIQXRpNVJFeTQwUXhjOHplNk9oeTk5NDJjN3RLS2JhckRDV3JKd3V5cGsz?=
 =?utf-8?B?TjBPNjJoZUI1ZnNEbFpIRStOTTJHbHNld2d6SWt2QUMrZXJ5V1hIcG9XY2kx?=
 =?utf-8?B?MUVKRmFSTEQwdnhLeG11Z243K1NDTjYwY2pqYmUycnZBaVJQZ0FlRnpBV2l1?=
 =?utf-8?B?MDV5UlV0Z0R3KzlpMDlYNFZOalVJRHhKQnpadEprR1dFaHFsZmhROEZXWDBI?=
 =?utf-8?B?UW5mUjJ1Nk5sbytNWUlTalYraE5EWmhHRXdSL1djekx5Q0JRNG55ZkNFcEJ1?=
 =?utf-8?B?NTNOOVRZdEJSL0VyU0xCZnN0K2VCemIyN3FzYko2cEZDa1Z3SlRZYVJneVV0?=
 =?utf-8?B?Q1cwNXFXNXcyKzJlL0JPYU9UdWxCdUt6VTNJMnJpNW9aVVNLZnFEdGwrYjl1?=
 =?utf-8?B?UGczR004SHZ2ZUo4c2hZQ3hrR0N1eVFhZCtjT1o3dTZHTjRkcFJ6eEdqbDEx?=
 =?utf-8?B?VGJONWYwNDhlSXl2VHllM1lOK2ZwVCtZNjJWazN6K3VCamtYSFVuTE93MTVC?=
 =?utf-8?B?Q1libkpNaDY1R1QwWGJVTjZ0Sko4QnlZL2FzWGUyYXhRQjdhWVZ5NHdTOHZt?=
 =?utf-8?B?V1VKZGJXYkVYeEt5QUVWUGdxRCs0bXRJWHJQVEpXN00rN2NKQmt2YmNONDR2?=
 =?utf-8?B?MnNWV1JJZGFTUUIrVEZmMnFseGcvd0V0WmtUNTl4QjlJRTVyeTdEQTJFSEJp?=
 =?utf-8?B?RVpDN29vMmlDQ1lHRGZ6em1XSmRlRWViSC8xdkhEbmlpajdtamc4bTEvUkQ5?=
 =?utf-8?B?Ti82VndBQTR6dmVnZmc0Zkw2dFNBRzlzOU9CSEthTEJQTG12OE1DRTJ3cU8x?=
 =?utf-8?B?NTNSeHFidWN5ME1xQzl1UkZMS2Y2MG9KR2lOR2Y1cXVheGczZ0VrQjZmd2tD?=
 =?utf-8?B?elFNaTYrTWVnandIbmtzQUNnZlNZeWd3WGx4QXpKVzhEcG84MndqeUkzd1dx?=
 =?utf-8?Q?krr6eJwg31z7Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTFsS1pjNE5yNVVxOGpBRGRGU3dhdStkVk9Ga3JxRVdvRGdzRE01UmYvMW9Y?=
 =?utf-8?B?NUVOcHNIQ3lrMWNaQ0JTMXhQTzdwajl3dVpFZWZmcFVyWFVYM09sSTZJM0Jh?=
 =?utf-8?B?VStRM3VKdkdTOTVHM0Q2UVlWUVpEemFOQkJsdm9KWkxERGNycE5INFVhS0Vv?=
 =?utf-8?B?dERHS2J3NUNsM1U2MHhBQzVHaUxjOFEvSHEzN0xhMnVlbTF0eDdXTWVoMU01?=
 =?utf-8?B?L3o3dEhJNWpSd3d6VEZweVcrR1ZiMys0eUxidVRKNkM4MTVybDVSYUhYTzhN?=
 =?utf-8?B?K3doQVQ5MXhpcGNJd1hWNWFCKy95VjJHbWJDVzVjR3BvZjZMVC9FZWgyeU9q?=
 =?utf-8?B?TWwwTEYvTlRhME9iNm9UWUJrU3VwYkNRYTJOSkxLTFFoRmF1RUVIUW1FZmVn?=
 =?utf-8?B?WWtRWXJ1TGlPWEd1YlVldmdMdUxlK2cvd1h1WHZQZW5MUHZwOXB2V0tWdEFs?=
 =?utf-8?B?VlhUUHBsazNITlJCV2FIMnp6T1dPbHRkdEFxWHA2YWZrZ3ZtZ3dXREltQnZl?=
 =?utf-8?B?ZTdydGszNEFjd2tMY0NNYkh3dm1sbUx6VUdkK1IrK1ZMZDdRM3p5Q0Vnc25s?=
 =?utf-8?B?MkhnVWhNK3FOd3FhdFRvQitkZmNxWS9NYWFIMWo2WWhSNWl1cWhkQ3dpcVZG?=
 =?utf-8?B?N0RNMk5uRE5aOUhwcmRYZlMySFhTR2R2YmVMcVIwQnp6aGwvenlreFVBZU1I?=
 =?utf-8?B?RU5zUXVsOHJxQ20rN2NzSkIwVmxUWThNNnpIaW5ZVVhWclpkRUg4RjhMWVdV?=
 =?utf-8?B?bzk4U3VRU1pwU0UrTnhJTEMrdW1TSGNkUTZYUjY2SjN0RVJSU1hCZERaQ2F0?=
 =?utf-8?B?UTFnNG8xUDRza1A4U1QvdUphTVlVWkt5TlBMa0U3VTNzdEI0UnpVRjY5ZS9J?=
 =?utf-8?B?SkFOcnVVZys5RHJRODBrODd1RWl2VHU2MDFSaXZjUWRWZi8yU3FITENDR0ZN?=
 =?utf-8?B?aVFKOGhvVUpDT2l4c0tFVlN3dGx3bDdYTUNjbVdBRFkrWFdZV1JaMWpUTUpK?=
 =?utf-8?B?Q0ZndlVrOEVwSFZGZnFtN2xNMUl1MkJ1K2VoS05BTWQ4SHJSQ1JZS1U2c2ta?=
 =?utf-8?B?VWhMOGtOYkM0MWVXNmROTXRIVHVuc2NsTFRVa21sa3U5YktZNC9aZWNKY25s?=
 =?utf-8?B?R3hRamRKU2UyMHBiYW12dVFpUHVtb0FHZUQ1MWp2ZW1BN1pzZHhPazhjbW5P?=
 =?utf-8?B?SDAycWRTUW1yVHorU3p0OVdCMVJuV0hmZWxNK0dUVjJFMitBL0tDamJFUnpD?=
 =?utf-8?B?QXBSREQxTExaUXdHMk9pZHhjTU5WS2tGYkxyUXB3OVlPT0xXRVFrMExEcjdt?=
 =?utf-8?B?S3VrdHdLdWZiSkszTlNmOENCYjVkKzUxdk81RGlWc1dTTmtzdHMwNDBnR2x6?=
 =?utf-8?B?amlrSmp6d3V0SGVsMHJqRzlQUlFrSnlablJweEIzTUp5VHA5azJ6V0dQbnBG?=
 =?utf-8?B?T2R3WDNxSEJiUVBWOEtHUTBpZ1U0QmRCaVpiR1lyY1hRcUFaaDRtTVdiZHR0?=
 =?utf-8?B?T2xuMTBCbzJkOFQwb1MvYzNQWVVVdmhRbzhKR1BPTjZyU0NqNVlHUDV0RGNh?=
 =?utf-8?B?b1BsdFRIMHJlRDBVdHhVMjhZSWNSQzN3aHZ3QlJXYVpOamNEVWIzRlM3UG5V?=
 =?utf-8?B?OHpKdk5HV2Rjd3JRb3NyNkVnS0NRdG43TEdVNVdsaFR6N3VXYjRBcDFseThy?=
 =?utf-8?B?WTZWenRyUkt2MEJwVVBSbGh5dUdSeGFldlFkYlhzZTlhUTgzQllZVUdTdXp3?=
 =?utf-8?B?b2p5c0tUVTR1Y1ZsTkNOWGsrUnltRUUwK29sZHc2Z0RONXhUSENKRExXVmc2?=
 =?utf-8?B?Qk1QTVprdmFwNjdvbXBuayt6N0ljanZwZ0FwVDhwM2NsbUFuMGxpbjJJejcw?=
 =?utf-8?B?SFhLY1UxU3ZXeW14OFdkRnpiejVzYTBQRU9oYkdobFE0cUhUdG5tZWZDZjFy?=
 =?utf-8?B?VFpiTDlwZlNtMGNDb3JGYWZkM3lxb28xYlBieDQrQWxHSC9EaTl0YS83RVFl?=
 =?utf-8?B?ZWhncklzQzFLc1NSSnBVTWRTTmFFYW1ma0trM2Zsa2hjbDFDclFRZFJBeEJI?=
 =?utf-8?B?cEk0Z01SeGNYb05BeDlpeURFRFNUOXJWTCttNktJcisyUEpkbkRWTXhLaVNF?=
 =?utf-8?B?Tm1PT1VjTndhZzlnYkZqTUZZQ3VqandjWjJrYlBubGFzdkxFMkVvbGlXMzQz?=
 =?utf-8?Q?TjTSaQybcQaT/387H5MBxnr/xoHqJW83opLoloV66qZk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9617840-0570-46a2-8fde-08dd5d7c00ee
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 13:28:53.2522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHmnji5GiRG2mqwc70VEwQZ930/yAvGRIWgba9MfxpJD/lWEQ3U6ubjk07ii9ZuxGyZdhiPz+uH+BzHeybA/MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6926


On 12/02/2025 14:39, Vishwaroop A wrote:
> 
> 
> ________________________________________
> From: Thierry Reding
> Sent: Thursday, January 09, 2025 16:10
> To: Vishwaroop A
> Cc: Jon Hunter; Sowjanya Komatineni; Laxman Dewangan; broonie@kernel.org; linux-spi@vger.kernel.org; linux-tegra@vger.kernel.org; linux-kernel@vger.kernel.org; Krishna Yarlagadda; Suresh Mangipudi
> Subject: Re: [PATCH V1 1/6] arm64: tegra: Configure QSPI clocks and add DMA
> 
> On Fri, Jan 03, 2025 at 06:04:02AM +0000, Vishwaroop A wrote:
>> Set QSPI0_2X_PM to 199.99 MHz and QSPI0_PM to 99.99 MHz using
>> PLLC as the parent clock. These frequencies allow Quad IO DT
>> reads up to 99.99 MHz, which is the fastest that can be
>> achieved considering various PLL and clock divider constraints.
>>
>> Populate the DMA and IOMMU properties for the Tegra234 QSPI devices to
>> enable DMA support.
>>
>> Change-Id: I1dded904aa8e0f278c89998481e829f1ce474e8c
>> Signed-off-by: Vishwaroop A <va@nvidia.com>
>> ---
>>   arch/arm64/boot/dts/nvidia/tegra234.dtsi | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
>> index 984c85eab41a..96d0f13390ae 100644
>> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
>> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
>> @@ -2948,6 +2948,13 @@
>>                                 <&bpmp TEGRA234_CLK_QSPI0_PM>;
>>                        clock-names = "qspi", "qspi_out";
>>                        resets = <&bpmp TEGRA234_RESET_QSPI0>;
>> +                     assigned-clocks = <&bpmp TEGRA234_CLK_QSPI0_2X_PM>,
>> +                                       <&bpmp TEGRA234_CLK_QSPI0_PM>;
>> +                     assigned-clock-rates = <199999999 99999999>;
>> +                     assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLC>;
>> +                     dma-names = "rx", "tx";
>> +                     dma-coherent;
>> +                     iommus = <&smmu_niso1 TEGRA234_SID_QSPI0>;
>>                        status = "disabled";
>>                };
>>
>> @@ -3031,6 +3038,13 @@
>>                                 <&bpmp TEGRA234_CLK_QSPI1_PM>;
>>                        clock-names = "qspi", "qspi_out";
>>                        resets = <&bpmp TEGRA234_RESET_QSPI1>;
>> +                     assigned-clocks = <&bpmp TEGRA234_CLK_QSPI1_2X_PM>,
>> +                                       <&bpmp TEGRA234_CLK_QSPI1_PM>;
>> +                     assigned-clock-rates = <199999999 99999999>;
>> +                     assigned-clock-parents = <&bpmp TEGRA234_CLK_PLLC>;
>> +                     dma-names = "rx", "tx";
>> +                     dma-coherent;
>> +                     iommus = <&smmu_niso1 TEGRA234_SID_QSPI1>;
>>                        status = "disabled";
>>                };
>>
> 
>>> It looks like these are missing the "dmas" properties that go along with "dma-names".
> [Vishwaroop A] dmas property is not required as QSPI uses native dma engine. dmas property is used for assigning  the dma channels. In case of QSPI it has own native DMA engine.


OK so that means we don't need the 'dma-names' here either. Please 
remove this.

Jon

-- 
nvpublic


