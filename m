Return-Path: <linux-spi+bounces-4466-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D4D96632E
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 15:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD41E1F21646
	for <lists+linux-spi@lfdr.de>; Fri, 30 Aug 2024 13:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCBA190472;
	Fri, 30 Aug 2024 13:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n7lSyCfA"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763A726ACB;
	Fri, 30 Aug 2024 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725025353; cv=fail; b=rYCVkssFrxFLPG2UJSHDvRZ8MRGV0efkejdQ/TvArCdSARBxl4mTux1r6j/ybwJZlLYS3I00h5gmuHTDwZm3JbPjPXDG4qDu//bDTkccbCZOi3SadtZfW5qrcFIl8ZASoU/+8VUM7axTKXKTAjTvcti9pqU/1O3TxonCNDaS5zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725025353; c=relaxed/simple;
	bh=uk2FZQblleSkNvvonu6PLsznspqlWRIDI1z0/ljX41g=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ioO2brZIzlBE3UTIRDe6oh/0o380twUggNK4wXACJBsuK70ewHCAEKeuemjqOgGowzWTYSezAiBsajhXv1/5GSvRWUQr4dqyQT63ssYX3LgbsL9m+6TI2bQ5J09Y+SEzdR7wXB3/7/gx4vIlNPgkt7WoijH3vTD8myz667xvXaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n7lSyCfA; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1vxVb8L+Ap+xJmP22phE6Aqz24xTJ36N4jobq0RH6bh3AL0DUlCWwR18tqEU052cxY0AFR/CaXZ/1FMklokFm3QNm84eVJS4gTgVrvphPh3SpXCq8ltFb9RTnTfEo7A6/ZthdychKYbjinAdA42wv6XyybEBERcbJbagKsA1w5mtKOW3lUkNPVzBNA0NhfsV/ehTxGqlpaf6v/xrEtaAifB2Dd3x9sHJSO9xeventlqm1H4QLNjvkHDhGxBcY9kuMVxP6Aol8g1jmHdg99oyA4izqJiEoibEXq/vw8W7apMi1QaFdb7SzF+cgVQDZrXDtKUEne75tvpdzZRvwG4pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EnF0WzuzZZpn+Q0FI+Eudv5r/b8Iz5cD/H/hoP3ZSVc=;
 b=GD7CrNgbm1CCSaU0HLuBsog24JmtJCTHTAuFklaJES9sTI+OGIhiLG1zXqWIsRyMNZ9Y0HfeyCF6u3ZwB+C5iihKsZGNQeXavx/yU33XXDQ+itn3hkkO5AwGL237T2cImOr6vyBZLI9woiCrfgS/Z84k4C5UhF+6aekfxAfPp7+9bbnolSIIzwDJMNcGlJn4lRedjjQR2pGmJnB3jbjj1mMfdwmjPkj6e+h5P9764m08o8VRG1WfiET/uYbqC48IFzOZI7woOTx3jeioqwnZes0CV13OtglhQnjGT/V99QtQx8O3u1bRAKWstRCS2xqFj1AxYCVT9RobYnWHcTt2Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EnF0WzuzZZpn+Q0FI+Eudv5r/b8Iz5cD/H/hoP3ZSVc=;
 b=n7lSyCfAooF/5gIp2wS+M0ewRw7LgGpMevHBPi4Ec85pP0B3/82Ozr83ORpYXBqH4JVJ5FcbZ7fb9dS8PPUeQRysJKbIvjSIVkpUjXJWB1pbmIPpgzmd7DbzoEDxAIVPl1bdR/yfWjibhvbA1HfKdUkopMEoPjYXya9UrjxIeL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY8PR12MB7538.namprd12.prod.outlook.com (2603:10b6:930:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 13:42:30 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 13:42:30 +0000
Message-ID: <8a8145da-0a95-4697-804c-92d829df84fe@amd.com>
Date: Fri, 30 Aug 2024 15:42:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 0/2] Use devm_spi_alloc_host() to simplfy code
To: Jinjie Ruan <ruanjinjie@huawei.com>, broonie@kernel.org,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240826121421.3384792-1-ruanjinjie@huawei.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240826121421.3384792-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0053.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::42) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY8PR12MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c742728-8aa0-424d-3b8c-08dcc8f99802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dm5uNnhzOFY3NmhMUG1Va0NRMWQzS01FcXN2K2JjOWo1QWJ3NXJzdzh1b3BT?=
 =?utf-8?B?SmNXQjZVMlpqN3BjTmJTN1c3Z0xUNTFNRUl2UE9iN0Zkc2JPNzVzNmNsQ1Yr?=
 =?utf-8?B?OUhXTUE4Wnh3N1Ura2kwZXFxSmhqaDRSNkxnZ1hwWWsvYmZnd3RQTnhxSE84?=
 =?utf-8?B?ZG11NlYxNk04NGFtVXNQb2hvUW51UEVBNDROazdldEdpVjRLd0gzMytZSDgw?=
 =?utf-8?B?VjJzYlFTV05ualJ4YzFKWk5oWjI3S2thNGg4TE9haW52K2ZDb1FGU2RISjR3?=
 =?utf-8?B?ekRYQ0FDbEt0b0R6Q2ZzZ2tnL0k4K2MzNlNYcHR1bmhRK0JtNGFEWnFkRnBF?=
 =?utf-8?B?aFduQkFULzVOVXM0NDZNbzVNM01TYlUrendFUnNnSlZqc1RKYXRtT0dmWkYy?=
 =?utf-8?B?RkQ0b1ZLM0VRenk1b3YreERoeHJ1N01hVDlTSkU0LzFjRlROVFhFem02MU1i?=
 =?utf-8?B?ZmN0eVFWRHBFK2Y1TjRQYi9BOUpJNDlTcWVSYk8vWjJlLzFtK3MxaHNYcTdG?=
 =?utf-8?B?RTMxdGwyM2Mzd0pzMTJZYVRjVEFOVEJFM1UycDJ3ZmZGL0dOK0ltS2ZwWHY0?=
 =?utf-8?B?MmgyTGdVZnRpb2lFeEo0RUtIdG5PUXJLTlQ4b05Rd0pobWZYUFVyWW51OFBL?=
 =?utf-8?B?c1J5aWRaQzVKdHp5bVNleDg3WEJQSHFRSklvSU5lN2xQWlJaL0ZtT0FUN2p0?=
 =?utf-8?B?YUpabVFmS0NhbHR0bHBwdGxOZUFJQ0V2bGdVV0lGNEcxbHJxeUNLR2IrMHZL?=
 =?utf-8?B?NTlob0puUzk5TVQvYWR2QVF0MUs4QWVkZUh5TWZzL2FYL1hxT1RUY2lRSUdQ?=
 =?utf-8?B?LzdCSzhFRHlCYlZxY09JUCthL1A3VmNPRkE5dWpOR2t3T20yaEt4RWhsYTlB?=
 =?utf-8?B?SWI4a0RicWUzK0Y5WForS0hwMnp6ZWptRHk2UkJqYVBMUlFIWUZGdGJ0UDMy?=
 =?utf-8?B?amMwRG90K0Y5clZtSHdVK01Mbm5OdlpZM0o0bjVHcndac1NoN2Q0SGVEZ3RY?=
 =?utf-8?B?YmY3LzgvOWVOdkJVMGN1TVhHSFBnUXVyUkgwK0xyVTFra054Q2RPcjd0V2Nz?=
 =?utf-8?B?Sy8vRWFiY01YalhiWUwyckdBTnhuRFk5M1dlakgvV05Ceis4Wm00RXFEQ0dK?=
 =?utf-8?B?N3hEZUNkZjFPbmdNVGRKRnNjQ3BndDIwU1BmNXNJOUhrcER3dHNNbUJPdHN6?=
 =?utf-8?B?cHdFSWZYTTNaK0Z2N01PQ0NCbnAvcHBpZkFDNy9xU3RUREF1ZVYvZys3REVG?=
 =?utf-8?B?allZOXJiamJtWU9rQisvOGdrQVlUNS9mVFBsWWlxQlcxSTU1RU9UNTJBUVcx?=
 =?utf-8?B?THdrMjJhbnU4WDQva0RuRC83YnBuUEtuUnJjcU83TCs4UkdJSzBZaW1UbFh2?=
 =?utf-8?B?QnpqRm0yVnJ4UkdrdXAwMVA0R0w0NW5iWk02bmlESnNWMXRvVExrY0JSMFZM?=
 =?utf-8?B?bnhPTzdmaVpwMFlydnc1K0dKQW5mbnBHeHVKWU1pS3JoN0JmeEVjVmVzamNQ?=
 =?utf-8?B?ZE4vai9DcHQ0SnhZOGh0R2I0ajdjU3Y1b2I1bExIL3UyYVBwTGZHUllGalhE?=
 =?utf-8?B?am5QY1ROYk9wNUt3L3JST1RlN0UxVFREN1EvNEVxMnNOdTRCU2JnbStGZDBT?=
 =?utf-8?B?RFoxd0N5NGJpdDgxU1JGbDBHbFh3U3hZcWlJNVV1Uk1ZcVlNOTAxWmgyMkto?=
 =?utf-8?B?RzNIbmFNY3FydnNQZFdVQ3RTaHpLejZyek0xRWF4OXZISkNXb2Q2Wm5NWnNa?=
 =?utf-8?B?NmRYTDY3b1Q5dkhGMTJPaTlrQXM4Q3RyKzBnZVVuc2JieGF3Q1JTdEFkU3R1?=
 =?utf-8?B?eDQybWhMaFdYYlptR3pPUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0xFNDVsMUs1UEMwd0dTdnhHYzYyVTg4VW1iUjNIaEt1SW1wMHhycTJkNjlj?=
 =?utf-8?B?bzRBdmhwT3dTaGpVRkZnVVMxVkRSN3JQSGwvU2hMaUlsUldPU2xRbEZ3Y1RL?=
 =?utf-8?B?QVgxZkhPN0NhOFM4MjlXNkN2RS9jNlYrdHR1MzFwQWNtVlF1SlJmczJaR3dD?=
 =?utf-8?B?NnhUUldpU1IzNWVoSTZJQUF2WlkxNXRDeDVVandyaENiZnhxQytqK2tieitl?=
 =?utf-8?B?WnZVS2Z1eVEyUGtTS05TSTZFeUFIMURUYXZTVmVOTVBhQXRLSHlod3ROT0lq?=
 =?utf-8?B?WU5ia3hTVmloRlYrcUswZTY2c0ZYaFQ5Z0M4TUZ0Wno5RWJucVNhZ0RjZTFW?=
 =?utf-8?B?MkFKcElnR3VxK2diK3FGbytKN25kYThjL1IrTmlkOXlrT0tVV25UQXdlV1Ru?=
 =?utf-8?B?ZktON1lXdGVNeXRmMlpUU1Yrc3Jyb1NmcFI5NUt5OHJKUlJTVkVlWU04Sm5z?=
 =?utf-8?B?dmtBYm1PMFYvQkpGRWtZakYxVjdtdGk3aitqSUtTeEdDVXB3MEwyRWRpYXpx?=
 =?utf-8?B?WmsrbktSQnZSMnRiOWpvT05DelFOZlZlMGJ3Rk1pMjl2bnppejRNSmo5RExE?=
 =?utf-8?B?MExlQ2tob3VRWXRPUi92d0tYakZRQklDWS9BRjE5SWliOTBLQ01ST044UTlh?=
 =?utf-8?B?OGxEeW9nN1N5M1JKUWgxSkxWMmtLditBL1VQN2dCWmZkc2hidnF4MVVuUU1P?=
 =?utf-8?B?Q29hU0dwMEZXMzdIdGJhS0pabllkNWhGaytNZ2hwVFdEOTF3YkRXWkFzTThG?=
 =?utf-8?B?U1VMUGdEVVgwdzdkYnMyWm9Ya1BEQ0JNOXpFNXJqbUpUdlpMMXRHdU9hZUw0?=
 =?utf-8?B?bmkyUkVtSUhsdG0xdVg0aEhHM3dmQUdTN1FHSnczbWdNWjFvUk8wRkZpZjB0?=
 =?utf-8?B?S3JwN3pFajBjTm93WEw5cnk1dm1PREYzRUQ2b2dmbVYvOVlZZGlQL09uTU4x?=
 =?utf-8?B?NjYzTkQzdGlPSlF0K3UwZEEzRWhiZEdObDUzcWVtRW1kQTRSTnc2VTNDUGY3?=
 =?utf-8?B?b1lzcUV2Yml0ZmRkMFFpRmF0L1RiUnVWcE4yK2wyWUI4RW9BRGVhUVNRN3dW?=
 =?utf-8?B?aXd4cGNvZDVwSHRKVU9Td3VrV1NjczM3d0RkdnlXWkRaNTIzdDAwbU5MY3BM?=
 =?utf-8?B?WjJyelFzUXlpYVJuUC9zR0ZVMHpXMUw1UEl0V2Nwdmw3TDR4ZDNSTzhYOWlp?=
 =?utf-8?B?UE1vK1dmeW9lUzcrMXprbWtNcVVpTlRoWjZjMVJBcHVMcEUwSmxmWS9PZnJr?=
 =?utf-8?B?bEk3bHJvMkFnZXRJdzNHcHN5cTdNNUNXTXFBRUVhYTZES29kN25jRk9ucnBE?=
 =?utf-8?B?MnFzcnQ4cDdWSm0rWW9XMWRUa2RCYlhXYm50RkpkUXNwU3l0c3luSDFpNWg3?=
 =?utf-8?B?c0ZORXh5bXZzdjNyOXEyU09HNklPTEJoWHRMVWZxWGZiT2JIYXphWjRzaWRD?=
 =?utf-8?B?eE1uQ3FTYlk3YUx2NWhFVkR6dFdTTGhlNVJXNE14VHdwS0M2N0poUnVxY1RZ?=
 =?utf-8?B?ZG53L0VSeGppZWIwU0pxRzFGVnJkSWtHNFdYclhCK2tOOVZ2VTNpOERCL0hD?=
 =?utf-8?B?d3hndVo4OGRpRGoyVGNTU2UvcnF1ajNDT3NMQVR5cjh5VVd2NEF3YVRmTURw?=
 =?utf-8?B?MlpQT2NzaC9VMVgwa1prTmJQTlg3KzM2aUNZeW5nWlc3bE5KSHBqY05sZzFT?=
 =?utf-8?B?dSsxaFpQa1BhTHkvYllQeW1LMWhjenZNRlQwOXBUNWFoSy9LVEt6ZXRydkd1?=
 =?utf-8?B?ci9vWjlkS2MwbloxNVJ2Zk9NeFAvaDNHUUhYRVVIaWdGQ1QyWHFjOUNTVzF1?=
 =?utf-8?B?NnJBT1dvNnVhTTEyOTJWdEdrTTBacnY1RVF1V0dxQjdabnJPV0hVVWs0TVdQ?=
 =?utf-8?B?S0ZueUNvVVNwZzBmOWl5cW40TmplOGJUa2QyUndYVHp6UlFxM2VHN1hTakxO?=
 =?utf-8?B?eHk5SFJtZ3BXNGFwaUNyeHhnWVFpanNlMkxNTzl0QTVsdjhENFpsQ28xMkU2?=
 =?utf-8?B?eG5BaERiSTF2bHA2VlJ1R3Q3RnhlbzYzSFVybnQ2Ui9yZFk1Yllrblc3NW43?=
 =?utf-8?B?bUVwNlhBK0xDL1VDZDNOOWY4TjNhYU8wYXA5QUF0VDN0Yy9hZHZTREhudytT?=
 =?utf-8?Q?UODJ48O2OnWbJmsz29lnyKXpq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c742728-8aa0-424d-3b8c-08dcc8f99802
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 13:42:30.4729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ep6GScp5hmK1YqLu/9J/JAmgkMeKNEH9f7qXyGQZl/eKKwW7Cm0SsRTIhW3NkvCW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7538



On 8/26/24 14:14, Jinjie Ruan wrote:
> Use devm_spi_alloc_host() and dev_err_probe() to simplfy code.
> 
> Jinjie Ruan (2):
>    spi: zynqmp-gqspi: Use devm_spi_alloc_host()
>    spi: zynqmp-gqspi: Simplify with dev_err_probe()
> 
>   drivers/spi/spi-zynqmp-gqspi.c | 32 +++++++++++---------------------
>   1 file changed, 11 insertions(+), 21 deletions(-)
> 

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

