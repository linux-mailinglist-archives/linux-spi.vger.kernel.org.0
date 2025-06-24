Return-Path: <linux-spi+bounces-8724-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0221CAE602B
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 11:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8225F4C0F8D
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 09:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81F6279DD4;
	Tue, 24 Jun 2025 09:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="mJ9nXdcY"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022085.outbound.protection.outlook.com [40.107.75.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A7B19CD01;
	Tue, 24 Jun 2025 09:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750755946; cv=fail; b=uETppu4DPNTqMv6VASBPDACCfDHktEqgvJgySrFPzgCybH/bEH+uK4nwBaz8YF4CCcuO9lX6bH1spqZ5h+KtA1CmZw+JjGvHn9QMPCRXpkqMSoEOOLyTZCw/MfYGtEpY/hKEijdN9R/102sx6bqc1/pqPEBBYfgV7XSIg/mCCL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750755946; c=relaxed/simple;
	bh=y8CNy3h0kmXmJhus1S0AE5j4v+Jq0LLQiX7QGrO7xW0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hFijxtBK61y1/R0a08m5Ohz6NNtMigeGiDpnysQV+BBUofekS2WSEz53fIjuOUd1BwE5Pz/anaW4a3xCbl3Zdyi+F8bxrk7lXEjauugGLZCt4gEeNVUrM0UeCf2XmZAlkM8JOBcJaSjCUEWNrfq55RKkNlXaTONwQKaIA0Q6ly8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=mJ9nXdcY; arc=fail smtp.client-ip=40.107.75.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIgqcAh50iffsbzbi/OHOjVg0IT3Mfs34y9R7Y15KLwdWS2JqMzQBPmQzLkaYHXmpofCElSAGI1bI/g0IwEBhe52GcclPfbgi5mchFE/uGCgGDjLwYvzbGB/ubqm4ZSyEKUvtrhGfXK5ymQdzapmHyp1fN3qDczRnc57+KSME+avy3FZ0vz3o96vQaI7NR3H6/hPaop1tQDkw7QyltU0/iybaLPmfa9MXTzs7j+TKMkirvEP1N3ND2C2lKzC5kuE4yfP0iNJADrJ01wmJ6ptlXzXs8H+9pa2X/puyfQAfbFrND+zU4rQry9Qh5iQiNkA0xFTM/gvO5AkfCCH8ioDjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEkXxx85UJjISfmCqJZGelx5WGso7azuSWCwVlu71LM=;
 b=XxL7RAB4sqiQhPiuCk6OBN79iPe0fJqzr3z+LIEl63EWh10+SIuF3ipSbCdSuEKKk0BlfaRG713tGFD6zHRZSZTmR7QwWec60Q54kdEEsUy8XUrnEzWb5JXXnnHM9i3Jc/6z9N8ITZQVKu9MVCY3psxQiuqBFk/OEJ6H4/Ig/tQF4Xrg9xbWUElyYngrg2Ch7i8OskVCBzKSg7j4gz0lpCqI5Uzw3oKtILioT5De3NpSEsxdvA197+GHiUlkOK1AwAYzsQ3l9Z7fn01pDr4wZtEHcZriN9Vk9tRv23+Cahe3kabTIjZr3KTQOnNgDisglkjbE1OXJZffg33Q8BFO0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEkXxx85UJjISfmCqJZGelx5WGso7azuSWCwVlu71LM=;
 b=mJ9nXdcYrsYkNfesKW/yJuys1JRr/3ski5v6orGg6zNhMd/mx4DC2bm2g0DcJvX/lO4LgccZI4u+K7I3uvvrNOcTSURO3/6E3VaprvQ0nev9p65dR7Ea6/mfRvoA67H2/59+Xr44meeHABwe4lQe8kiM42h987y8G09BxhmbkPAbLY2z8mgPT2gbyByw3aY8Ul00jppgwFBc71suAbLwj8vDXSFebKLHqA9FdKAHAfUAww5tYt6v9ZL1mOOtU1ZO1MzFU9HyufQniQ/yTljoZWT+uOnlqC4W9Rvv0f94t4QSiip7PNcPGkIC0h1qCmH2fuP6Ajy6UzYZHYfmhtiCLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TY1PPF346E03860.apcprd03.prod.outlook.com (2603:1096:408::a4d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 24 Jun
 2025 09:05:41 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%2]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 09:05:40 +0000
Message-ID: <aef4d4c8-3058-47c1-8d4a-28e2bfc2549e@amlogic.com>
Date: Tue, 24 Jun 2025 17:05:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] dt-bindings: spi: Add binding document of Amlogic
 SPISG controller
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, Sunny Luo <sunny.luo@amlogic.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Conor Dooley <conor.dooley@microchip.com>
References: <20250623-spisg-v3-0-c731f57e289c@amlogic.com>
 <20250623-spisg-v3-1-c731f57e289c@amlogic.com>
 <45514054-1bb0-450c-bff6-ffdf491417b1@kernel.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <45514054-1bb0-450c-bff6-ffdf491417b1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0226.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::22) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TY1PPF346E03860:EE_
X-MS-Office365-Filtering-Correlation-Id: c426ca1e-2ee7-4c58-901c-08ddb2fe4ade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjJiN3lSMnNNTGdKaWVtcjRWdzdNUG1SNGZ0Q1hOTXNna3I0UDl6REM2d0JY?=
 =?utf-8?B?Q3VVYUF1Vng5cjEvaFpZM1FrekI5dFJobGtqYnpRMG5TZGdKVGlONS9FMk9a?=
 =?utf-8?B?Wm83eFcxVDJpNDNveGQ5NVQwSXlHc3orNmovMVdOZGRxNmg3eUR3RzVLQkxr?=
 =?utf-8?B?cXBpb1NqdCtLNkdyQVBkRStlVWE2ZWw4NXB3d2dWNzdsYW8wd05SMG1MN0E0?=
 =?utf-8?B?Skx4L3NLZUEyQWxlbTRacFV2WlE2c1d3c0VrVzE4OExBY3EvL3VENDhBLy9G?=
 =?utf-8?B?SzRvellUc1FiYTRNVTg4c1A0NXVGUXZLNk9xcm1nZFZBYzR2VXEya21BeDlH?=
 =?utf-8?B?NVlTaHMzbDlpOHZJZTdXSmZ3a3BITFArT1BYZnNlWGxJclJpanRYN0RFQWx1?=
 =?utf-8?B?Q3lvdk9vQTB6V1Jmc2lPNnNvT292V2YrOFRlQVZoK0JoUWgxL3pEWU9JS3Jo?=
 =?utf-8?B?OVlLNDhCeUsrNVNZd3VnQWlMM3FpaG5BSTdHNmUvd0tQbzBJTmV0NGVaVk4r?=
 =?utf-8?B?RlFJUHUyTldpOW9wTFJ3a0U1SlhvdG5DWTRpQS9BUUlDMGErWnJqbG1WQ0VU?=
 =?utf-8?B?cDlnbXdmTS8ySzNpZHQxbW9HT2lZWWZBOWhQcTIzYjdyU2xndlBoWDJ0V0d5?=
 =?utf-8?B?aks2LzFwQVc0bHZmd25nWlozVGdzbWlBRFFIWk5BcGpja3hMTXNneURNT1hK?=
 =?utf-8?B?OHdmVVFtR1dkM1k1bmMwQkQ2MG8wWUtlU0dCdU82a0RrZmgxUnBUR3lrbzVJ?=
 =?utf-8?B?YmhEcVJCMlNuYVlFRlRlNGlzdnhpc2pRL3o3c2Z3YWFDOTFMZVlGbG1MY1c5?=
 =?utf-8?B?N0R5OW1RUzZ1WEdFZzNLNnpEWnJPejAxZVJDc0lzUXAxalAzK3JJL3BrOUh6?=
 =?utf-8?B?eFo4MnM4TU9NYkZvNnpWclNLZEdaeXFwYjVNR0tVYmxQdS9JeGxYN1ovdlB6?=
 =?utf-8?B?RkgvZk9UenFXNUtlTkZLL1NzKzEvNHA4OVhhbXlud3J0MmVKQ29vUUVtNGky?=
 =?utf-8?B?V2FRdS9heUdlL1pjVVE5Q0k3NjNzOEtrQ2tSZE40MlRhV29JRkV5RGxoWmpS?=
 =?utf-8?B?MEFpcTlsTEp4bG9kWlNIcytObm10eVczeTdQOU5Cc2FQL3pKcmsxUEhKOWhj?=
 =?utf-8?B?VVYxSzNma01pRmY4RWhYbTFMdlNJRk9mZ0FQeU5FUWtoZFkwVDgzaXFSKzFQ?=
 =?utf-8?B?Y0dsVDhUTDJQeWxKVmF2djJyOEFONFR4WThjaEI5aGduTkFWK2p2S0V4WUZl?=
 =?utf-8?B?MHVjNjFHbTJPckROeTVKTy9icWk1dWhlOGNaMmFGbDUwTW9mRHFaMlR1WURH?=
 =?utf-8?B?WkFIMis5QWo1WThXWktoaEpNMVpuNmhDY2FmSkJPWWtCbkRDUldBNWJSb3Iw?=
 =?utf-8?B?d3R1TGRHTWw2U3hKV3I4ZVVZeWJRaWFpeVVzdlIyTnlXeXExS0cwK1Y5dUFh?=
 =?utf-8?B?WkxnU2ZYOGpMV0o0NDRFQ2RXcHpUY20wWnNZSmpPTnhoMndzQ3RaWTU3bDl3?=
 =?utf-8?B?dmljMEZuWllsOFdYalFOeG5halBSVFJnU1RYRlpBVmk5OUs5V1VxRURla1o2?=
 =?utf-8?B?ZHlDOEdnUFNtVCtDNjdMTlpSOEdKNzNXNVZXU291YUpYMzVKb3ZIakVVSCtL?=
 =?utf-8?B?VlZ4eWpNNFgyQ0N1ZUtFUEZtZ2NnaG5rOWdHcGpWSUM5aC81VzRFTXdTaDhj?=
 =?utf-8?B?T1FqNEkwODI5aURQY3NGRXRzaDBSUTlvOTFTQWJ4Z2NndlV2VDhIRzNVSDhI?=
 =?utf-8?B?aklpVTRDRitwM3BQaS9kNG5xa1RyNmMzYi9DRytPM1IwVTA0ZUg3eFVLaVRX?=
 =?utf-8?B?czlMYS9XeTlvUUVqYUphZ0p6QlBnUFhtWGJuM3RwMHhvajIwR0o0amdUYzVN?=
 =?utf-8?B?VWZrRUwvaW5ZT1RkYSs0dDB0VHpMOUdYcW5IbjVFOE14djN6aUw4b29YNVFh?=
 =?utf-8?Q?tAgCgqlRpLU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXJSVXBrV05zU21PQ084WXR3cEdsbHczV0FpTlFpUzEvb1dmWUJKbi9nK0Nj?=
 =?utf-8?B?bm10U1RpbzBVUnpkNGd5cThBdFFPclJTbUo3RjFYaWd5M0hQaVVNL1JvUTRD?=
 =?utf-8?B?VExwVnZhWkNDT25wcFJabTcvVEh6L0c5SVRVcWx1ZjQ3aVlSV2RacjNUSkJW?=
 =?utf-8?B?ZjhSZkVLbnF4WW94bmdZMzhFV1R3K1VXZlY0SGYrODl1MlJuV0pJNTN5KzBh?=
 =?utf-8?B?eis4NTBCRTNMWU9POHIzWHlTYS9vSVBydGwrb2JLUTRGeHE4aGZLN2RZUmVK?=
 =?utf-8?B?VWx6T252alh2RW05b1ZUM2lEVnowTytDdnA1cXpJUUEwWTJSVmJiZ3hnZXhP?=
 =?utf-8?B?NXdPanYwU2V3L3NwMllNRHNaWWV2T2ZCNzRTQmgyWXpjZm10ZEx4cDBRM2FS?=
 =?utf-8?B?RTdGYmdpTWE1U0NkZ2ljdXovV1FVeHdPdExwMEpWR3pEejhJUDBMZjltcjh4?=
 =?utf-8?B?b2IzQkVoSjhNTk5yOEpiTWFtRG1UQm1oZTNLS05ja3EzVGVOQzYvc2kybkly?=
 =?utf-8?B?S1dTK1NRdUJoRG9vSSttbG1uam04ZDVnam92RFQrbXF4Q2o1MXhNaHFzVXd1?=
 =?utf-8?B?d0djajNuVm9UT04yQm5KRHdEdFNKMm9xQ0FJQmYrVzU2UmprMUw1cjFQQlBJ?=
 =?utf-8?B?R29rRVhYR2tHRGRzZDRKeS9WeGUzeHVZaWkrQXFMOVNOZk9WTUJsQjFyN0JD?=
 =?utf-8?B?SS9rOUpLbkZyc1RJWEpLRzNmRmIxZkk4QmJlRlpGZm9ESXpVYXZnc2UxOVJi?=
 =?utf-8?B?QUxYOC9pbXAvSWQyd2ZNMmszSzhxb3hTclAvMWgxVDBSOXlXNWZ6dTNvTWlF?=
 =?utf-8?B?cmYxWU8raXY4T3Z0VUpZQ204bFpsY1E3YXVpMzU4SGpSY2RmTXE1V2phYUFn?=
 =?utf-8?B?VWRRT0NLeHZiQjdZS0NYRkV1UTgxNzFEZXkzWjV6Vlorc2Z3WkNTV0FKQ1Jn?=
 =?utf-8?B?K0ZqU1BhMVVpTFhERXphTDQzZnRkWmNhYmlZckdMc3hVUjIwSEt5eUtDdTZy?=
 =?utf-8?B?TzZCenZNQWJKSFdwWW9wMXdLWkVhUDdpYU91ZEpMTEs0cVEvMTA5YnEzV1JK?=
 =?utf-8?B?WnI5NGRsY3ByMStCUVFScllNak9XdGpzeXk1YU51OCsxdnNyd3UzVlkwNmsr?=
 =?utf-8?B?ZHZSWnJ1RXViM0s3ZTBKYkFINlQ1YjRSOGVCK1J3YkJkbnpBTVpwalVzVDdu?=
 =?utf-8?B?Y2RGM3ZNRFFxVGxSREk4WGV5N0JEcGdXcnc1bzV4YzBYczhwbXc1Wk9yTnZW?=
 =?utf-8?B?a1AxeWRmTVVTa1cwbURLd0ZLN1hubDBMSE5pOUpxelFpdG9tMUVjek5EUFYv?=
 =?utf-8?B?TFhUYStGR0JCbVBhMEs3UDhiUjQwKzBGK01XbWUxL2ZwUEppOXlKVnVFM280?=
 =?utf-8?B?MGsyTm9KZ1BqL2ltVTdYNzBzNkxVMmdNSnEyZ1FaME9yT3A0OXpLYThXVmph?=
 =?utf-8?B?R2JHODMyRm1zajlGMW9BL0ZaM2JZTDlobkJtdzI5eEUvWGZERFgyZXJEUHUw?=
 =?utf-8?B?eVMvRzI5UlYvZUdSMFVkQmF4UDRqQ0pCR0dpMW1JK3AxZVU5Zk9pZXF6RHNL?=
 =?utf-8?B?T09YQlVQSFJSZkVhN1JDS1dhV0RhRnkveDMzM0xyR1JyNjBzbTZmaTQyVGJK?=
 =?utf-8?B?ZGRyZ2FpYWdEWUk4cmZBWitEOVRhVmVBakpXNlU4ZUd5ZUZsNlI4UllneE9v?=
 =?utf-8?B?Z1NDa051TU5CeTdYUkUvMGN3K2I4bEdlUzFJTU1DT3M2ZExndDRPVm5Dd0dw?=
 =?utf-8?B?anpEaGo1SHl1UXp1UHViVWxNaVNUSjR6d2pDY2hVSnh2R0tzUWJFcTJDemlj?=
 =?utf-8?B?bjJCT2Y5dzBVQWYrdnpycWtoZ1l0MUw4aTV0Z0t2RXYyNmVxZEFqMUhSVU1X?=
 =?utf-8?B?RUVtWG9sNUREWVl3ZG9WMFR2UWhsWTNRNVRpK1hyRGw4L0JoVEcrNjU0OGRi?=
 =?utf-8?B?UW13RTA4OENVUGtKVTFQL1dLV3dHKzhsYks3elp1dWNBSzA2cElHMlVXeWhm?=
 =?utf-8?B?alZIV3ZBQUgrSHdFMDRLVi93TnZmNEoxNmFGRDR2cUFKWVBKU0FMbmFPQXBt?=
 =?utf-8?B?Y3VCTGNUc3JWTWttMHV0UGFKLzF5cjE0TVgrb3hJbnZ4QU9rSDc0ZGQ0MWY5?=
 =?utf-8?B?UnVZdkZGV0hVb1ZVbTY3VWlvdUM2bFNEVXhDKzAzbjkrZVZrSTVuZk13RlVp?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c426ca1e-2ee7-4c58-901c-08ddb2fe4ade
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 09:05:40.7547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pNpAs7cWGVQno0x5zIjr8Cs/b09oL4qfS3bNLJALfUaJivEML/DTcQYuMvc29qAR61tCuxT25LMcuj3NSGFXOQbVRdh0sgBbu04zrM9oP/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF346E03860

Hi Krzysztof,
    Thanks for your reply.

On 2025/6/23 17:15, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 23/06/2025 10:53, Xianwei Zhao via B4 Relay wrote:
> 
> Please use subject prefixes matching the subsystem. You can get them for
> example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
> 

Will fix subjects "spi: dt-bindings: Add binding document of Amlogic 
SPISG controller"

>> +properties:
>> +  compatible:
>> +    const: amlogic,a4-spisg
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    minItems: 2
> 
> Nope, maxItems. Look at other bindings.
> 

Will do.

>> +
>> +  clock-names:
>> +    items:
>> +      - const: core
>> +      - const: pclk
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +  - clock-names
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    spi@50000 {
>> +        compatible = "amlogic,a4-spisg";
>> +        reg = <0x50000 0x38>;
>> +        interrupts = <0 183 4>;
> 
> Use proper defines
> 
Will modify "interrupts = <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>;"
> 
> 
> Best regards,
> Krzysztof

