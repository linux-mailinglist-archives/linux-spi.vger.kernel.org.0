Return-Path: <linux-spi+bounces-8731-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A8BAE617C
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 11:54:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1963A8859
	for <lists+linux-spi@lfdr.de>; Tue, 24 Jun 2025 09:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E92B279DC8;
	Tue, 24 Jun 2025 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="bYHJnNd9"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022111.outbound.protection.outlook.com [40.107.75.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BC327C872;
	Tue, 24 Jun 2025 09:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750758775; cv=fail; b=BOeg0gj1GHW5SkUCPNxt6JzuTymNGUA1hS6strBNM44XmxrfO/uOf0r8+lDanGJsAVtBv5ANuucAEKd/UrugRBSo4JNUJUI39yZ2iCzhXaAW12U62wz3waBCZomVb3ePtlCCqS6YXh6fdc1WQLyg61clVjFCy/SVSmvKH++SKuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750758775; c=relaxed/simple;
	bh=QDxWcSKQEhbfNY5AjEJ+ssadqupjiRGDJCVykaUm4JI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IFj6m8eibgbYtixQU3rnzOtxUs3fFgdQknRvlhz03mW2jDdWhXN94+80/6f0JDfKcl/A4NEYEjJixySGa0N0jk2fWH3TVRdPUmf7sN7jaclbze+Ntc16fSr3UQIc62Sw0ZoYctWJMf+86MRSwEWnVetUHkTCYzpMstsTQ9ryW0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=bYHJnNd9; arc=fail smtp.client-ip=40.107.75.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KBPgVwA5brMfM0xd/im4fqd0wHEsOty+HjdilgbBFx1K0hM94hrKDozj3Lpwf2xiPApBQiqXweY0wMVWzpchjhwWPmkzsTYnQdbYTTfnUHnOj9MEBX171jU1jtyHBORZXhNIjZBPwXkplE4Vkk9RtHAxYg+P4oH58/oD531qyvp3G+r0Ri/+GiWGHAh9f+nmGYmOJyp/pCPqB9Cv9jNRRY5nnBG6EOi62iTlwdqmX3DvmALyh6+2xBFuQK4CpuVFx4H4D79XUPDjJSruO3QgvFfS+vs0ppY20VxY0MxPBm81p6nF3qT37oZ+stGyU/RaKgIOHdtz2uOT7x+WOCH1Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwW8uf+BB4BZXI8vAlkZuTxklr4X8urRQOVNEDuBKGo=;
 b=srgVvL749PFrajK7v4k1cqWjeR9Zayk3Gn29rSUdIJF0X9PCmLLjr39ch8AmKlJxdQqsCy08xGkYANUa4AZlB5cOL+m+aeu/YAgQzRzjxDZ8ywBWlLGsNPtYQrNEvrsqqz+a7xS9WAnKgTo17cJp+MENs30WTonvursWkeSamnFvQzE9xqlcH9olvKJ0AJFMrYeKxiCinfjnr1CF6fbcfY8ot/1YBOdQ4/7SaKDi6Q+TgDSnMNXtjhPlzkfqpL0b+4qD/dVNoBkatwGCq6v+lntpPI3BOTlsF92PigZ0wHVOw9lvQZ8kGrEmal/mmeMj9c+eRQjApGEl3gDip+SUHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwW8uf+BB4BZXI8vAlkZuTxklr4X8urRQOVNEDuBKGo=;
 b=bYHJnNd9y0gYFhE8KHH/rr9PXT7zoCb/graonbt7x/jJXD9rm8f6vjrE0aKfe/2T3ujp29sLYKcmiQqJ2vqcH+8TrvnhbA3C3bUohNStlFq58Z7a2BoUpxet37Ciq0pbuPIGe9rVOUaQ/pNRYzBfyy+Hi1dRZR7lff6OBmrOkdDc8j4Ickx9u6qb1LPGnE94601hTM1JP1LMkcEER0+AAWQZKq9dStPjlO2dkKvp33nbIMI989kannkcrBD4IcVwr9PDaciAjiY9OBTOTwrmYAz2/UOV6XRtJUtem048I+3tO6cQwTEi4ORsVr9SIvEomldgXyYzH+Bbk+YWaOhVYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by JH0PR03MB8333.apcprd03.prod.outlook.com (2603:1096:990:4c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 09:52:49 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%2]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 09:52:48 +0000
Message-ID: <d7502989-dbfd-40d8-8a4e-8e194eefb523@amlogic.com>
Date: Tue, 24 Jun 2025 17:52:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] spi: Add Amlogic SPISG driver
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, Sunny Luo <sunny.luo@amlogic.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250623-spisg-v3-0-c731f57e289c@amlogic.com>
 <20250623-spisg-v3-2-c731f57e289c@amlogic.com>
 <682a48fc-8451-46e5-b3a8-5ad7c237588e@kernel.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <682a48fc-8451-46e5-b3a8-5ad7c237588e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYWPR01CA0023.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::10) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|JH0PR03MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: 447d6bc1-8b53-44dd-86f1-08ddb304e0a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHZydldPK0RaeVZlZFRQRk01dE4rYkpUL05JWVdjdmNreVNHSVc0LzF0RCty?=
 =?utf-8?B?b0Vna2tUKy9YVllVZEg5VWYrZ0NqT0R1WFUzNUZsbXpTZkFjOW5uaG5DekJH?=
 =?utf-8?B?R3cxbU9mVGdGbys2L2JoOHh1bk0yUHR2d3ZDZnF6RHlCZTZhSFpxMGxyNzZn?=
 =?utf-8?B?RTRhalJ3RlJSenozRERXcXJBODFEVjhOQUFhOE5HaXk4SkZ1MGM1Z1dpN1Vv?=
 =?utf-8?B?NGpXcTBmMzRWYUU1a3UzNTRSV2NQTGdmRlVwaDdGR21NT0QwUXd0MStpVExq?=
 =?utf-8?B?b2dCRUVIYVFYcTFLa3JHdG1hRFhSaCsyL1hRdmNjTlM2RmNsUnhwZXYyRFBW?=
 =?utf-8?B?Q01IbmZtMFBySlVHTGFMOGF0c3pTRmNNOTUwclBSM1FycW8xK0dJalcrMTRM?=
 =?utf-8?B?NGMraytZaVZwdFQxclVqWGcwaEFucDA2N2x2ZSswR25OazBoQnBiOWFZTWpj?=
 =?utf-8?B?cHB3QWlZQW5rMy9qL2hJNDc4UWU3L2lWM3lFN0x1ekpLSTErRmJoczA3d1FI?=
 =?utf-8?B?dFdtbytheXdZZ1d6cTljb3V6aUNEaWx6c0FPY0JvbmVON0FrWTdxMmlwYldU?=
 =?utf-8?B?dnNoazlLblNuYnFtbmpHR09SSnRWaXJ5em1nbDFJLzlaT3RsMWI2VWtrMzRZ?=
 =?utf-8?B?ZnF1ZDc1WVpJRCtuTzVXcVhJUTF5U1JSdmh4a29ZbE40NWNMT3J5SWpVajdD?=
 =?utf-8?B?eGk5cVhoYzdOZHhSQUFSem8xdmRsY3psNDdMK1JuQ21DbGJiYU54L0d5NzQz?=
 =?utf-8?B?dVd0MzRyZWk3akx5VjV5S0ZrUW9hN1h3d2F2ZjhPWGhaZUJFU1ppOXoydWN1?=
 =?utf-8?B?SVhwelIzdFpCSXJ5VCszMDd4YktQSXRjRHFGTjVMN2RCSWY5T1ZGVmxRQnRK?=
 =?utf-8?B?eUdJSGxLTWd2SzFhQ2kvZFV2RnBQWUxmYmRQTVNyU2tTSHU2dFl5MXFvOUty?=
 =?utf-8?B?OTNWWU5iVHhPMWVkNjBONmZCZklvc1YrWDZoYnh0WXFOcnhpTWFWeDJ3SFR2?=
 =?utf-8?B?ckJOdFF3aXpIYU9QQ2FIMGZnZTljYVJlRjgyWjFkb2dOSzN6bjMwNHpyUUJL?=
 =?utf-8?B?TnNvZldjNTdiWnhkRlV5U2dWUElKbWV5R0VxSlhrR2VFMGhQc0kzQUhhOFkr?=
 =?utf-8?B?clozbmg2endMbFMrOFlzbmh2Y3FveHBWK0xmQVpoUk1nOEdDVHJaN1hKNmpV?=
 =?utf-8?B?RUVvejRYYk82ZlNoc0VEWTdlVFdaKyt1cFllbnhDMmM0TkJYbUxIZVQvdDEr?=
 =?utf-8?B?d3QvWDVLMkJZdVVicHR5cEp0alVCUDFyWTFtZ3VpQ2llZG45VkEraUJBVDJ2?=
 =?utf-8?B?TWRtQVJ6VkpsTE45UWEyWDN3UStWYUMvV3RpU1BVZHozTE9UUVd1dVAxVVdQ?=
 =?utf-8?B?ZWlFZjNMK2hCcGxYc3dJcFBFajQrbnZ6dnE3L3JPRGVrZmhVZkhpZ1h3QnpW?=
 =?utf-8?B?aS9pVW9ERDczbFl0amVLQUZXOHlEbmZaL0VBWEJ6K2xKeE5ZTUxRTi96clBQ?=
 =?utf-8?B?cng2MEU3a3ZVeHQrWnhEc2lSNDhEN2lwS1BiZlhEdmxqSXkxL25qT2dsdzZ1?=
 =?utf-8?B?RDV1ZVlRNUNOOTM4NTU1UGNtTzVRVzJ0ekJBMzB2YUNZcENhbCtsVkpnRDM4?=
 =?utf-8?B?eDNhMnhXdDNTWE9NMGhVRlNDcHhyR3I1NG9ZK0k2VkpTbzZxbUxrVUFPOU5Y?=
 =?utf-8?B?VUpabExxdUo3R2srVWZsZGVobzMvZjhaQ1AvR0E2REJIN3Y3NFZjQUh6NVow?=
 =?utf-8?B?RjhIUkp5SEpCRWVvUFBUQTh4ckt4M1hyK3E0WXpQYXFxRHY2TU56OFA3UFcw?=
 =?utf-8?B?elpVd1BmbzlsMjB3TkFvMlFFeGhCUDIrNG05VTJiUnRVV2N4NU5BVHlzd1Q4?=
 =?utf-8?B?MzN0NUxXZC9mR3hDWThXcFM5Vkc5VHdVNmVCQlRkMk4rb293dU5FWXdGaDZn?=
 =?utf-8?Q?6NrUiJxe+1E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTlHcUtvaklVOXdVRGtaUmFoY3hxQWF1TktrTHN4R3Y2WnhJZHhXQ3cyMXRZ?=
 =?utf-8?B?aDZiNktmUmZmdmlNRENoNG93U09qTnpuTEp1UWk5cE5DUnNNVkphM0Z3U2FK?=
 =?utf-8?B?YWJ4NUI2RmVtVXNvZGJoRHRFYUM3RmR5a0pTbTJTN000WGNPMWRpVk9yM2hH?=
 =?utf-8?B?a25ZTS9qQS9jTnZ5NXV2NTNMRitGZmxRcHFhMFBDRlJJTEx4UGxTOTRWVXJr?=
 =?utf-8?B?cTA5T3VTOXhycVdoWWVtaG56aHMyczhGdU5CM3dkV3JIVDdHMFVhYWxDU1JQ?=
 =?utf-8?B?RVArOVN4cU1ySGFxejh1R243Nk9iTktUUmovdXZhVGlvUkdXOHprWlpzSCtS?=
 =?utf-8?B?WWVMQ2VScEl0R3paVThHcXhIV3NkcHRwK1U2cHpjWmZzTnRwUEJ5cEN3SHBQ?=
 =?utf-8?B?K3JBTFFObEc4VXYvZ2d4eS9meHFUR0lSdHkzeXVWUkJSSmNIWGVDS1pnVHdj?=
 =?utf-8?B?Q08rYy9vV3R6amNrUkpmdGUycS9HZHZjQ3d5QUNORjVnLzhVM3R3WjZReEpZ?=
 =?utf-8?B?akJTTjV6eWdQTnU1MnJwS2VQUlY1YVNFL1pwUk1FRWg0SzNoZWdpT1BxVWNt?=
 =?utf-8?B?azBiRW1rV0tCdzlLVUY2Wm1uQ014eDRGUE1Lakw2Z0VyN1R0bUpiT21tajcw?=
 =?utf-8?B?czJRek4vdjYwMS9vZ1VPQWE1Ums5cENpYzM3Z2ZOZFAyVnRBTGhZRHkxUjJn?=
 =?utf-8?B?RlNQOFE1aUgvdDVXMEk3VjV4aXM4ci90WXRqRWVDOEdLbGVrRGkvaHJvYmV6?=
 =?utf-8?B?aUdMTHFFSjNTZUl2SDFnTll6QlVEN1d3dUd0U0lVeHN4OG5nUzJjZGFrcVA1?=
 =?utf-8?B?QmZ0T1kyczdTRno4YnNMT09aWWhCYTlpUWpQVWdmbzZQenpXRnhheXpLMUQ4?=
 =?utf-8?B?S3Qxc0gzdHllalU0TThMVmRLaWJDek5Pbm5kaUtOT3E0UnExa0E1R3ZJWDBW?=
 =?utf-8?B?aTEvWkJWNEhtVlhkaCtlN0hERVV1UXNrQkwrNi9rVXRXQktpZ1BNNnRNNUpo?=
 =?utf-8?B?NDllRmE3ZnAzdkI2MkIyM1VGbkREa09VNVpkNTFtanF2cUl3Mjd1WTJIZXRy?=
 =?utf-8?B?MExpelBmN24rKzVGcFkwcTl2SWJYVHh0akhqU1gvZnpaeHhvSGI3YklJQ3Uz?=
 =?utf-8?B?U0NGN2NzVFpkK3NoNktNeUtXREV3bjREcDY1dThsNElmUDdScCtLc1ZRbnQ0?=
 =?utf-8?B?V2tncUpPdHRWM0w4Z0hGSlBmRjNnY3VNMURGUGxOblhnQ1BkMncxVksvcmI4?=
 =?utf-8?B?YjRoV0dDcUhRSXNON1puMWNRRzlsWWxlZE85aFB5Sm9ZUCtLaEIyOCtDT0tC?=
 =?utf-8?B?QU95QlRSU1pYL2o2N2xwZFZCM2phZ3VsanZ0WHhJWmcvZk1CenJRTGw3VE4v?=
 =?utf-8?B?UjJkc29EMHJHWmFFdXE3N0xHT0NNbEZSTkhVakF0N1IxTzZRaTZCZmhmbWtQ?=
 =?utf-8?B?TXdMYXB0bmo4MmMxZXIxTDRsenREUEZNd3ZNSHZWUTgxSzBxWUNIWlA3Qm5q?=
 =?utf-8?B?enVxbnlwZk5tOUQremFLL0xvYmhCODhjUVo5TS80OC96TWNiZktkREJjL3pX?=
 =?utf-8?B?U3hSTzdydUg5Tnd4K0RiaDBTclNqcm15UHhLd3ZNTmpoK2t4b25QRDVrVjRk?=
 =?utf-8?B?TkZkdHZJN2l5RDBtMUdUZUc4N2Fhd1YxRkJYalNPaGJIOFBTQ3FGUFp2RVZF?=
 =?utf-8?B?cTVsTXV1bTlqcHZwditsemIwd05QZTF1QjJ0dzNYc1VRNms3WWkzY3UzNUhy?=
 =?utf-8?B?RFFSNDI2RSt5ZmFFM2NBNXVobEgxMUVwUG5sUUtodEFqckZiNWNDak5CY3Mz?=
 =?utf-8?B?Y2ZjeWwyMmpxZkh4TktiRDl2VzdQdk9xamR3UFZCR3oxUTlsTjdDU25JTGU0?=
 =?utf-8?B?cjZmRGxOeUFzUGNGeW5yWlNOTENYa0MwMTdibWh1U3RIRDA0SGVBUGJSWkRh?=
 =?utf-8?B?ZmtpVXZhOUtYQWpIR2Y0OUs4ZFVsRkdGVk5DVTJ3QzJCRDNLUGpMVDRXQ1pH?=
 =?utf-8?B?bmZXOHdYdm81bGsyajIyYnl0eHRsUGRmYUhVbWZxNkRXc2N4RWg5UWdCVUxX?=
 =?utf-8?B?b1BnRDRCbGFHZkJ0NjJoL1VzU1I5QXVOREtZWFZ4ZVJWMTNkejFTVFd3Y1JS?=
 =?utf-8?B?N25mNkRBSzk0WUZlQWVtM2FIMW1GT1czTmtFSk5EbVVmdS9iZmlGR3lVZkVG?=
 =?utf-8?B?WEE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 447d6bc1-8b53-44dd-86f1-08ddb304e0a2
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 09:52:48.8651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zbZw5UlJZNi8v0yaT0Zm3SWDHGjf5eAcUzvW0bS0OBdrIsJUee+rzu4RLmFFc3Iz+xvBKNnIoiG4WW/ECdvkRHh7EABM/xUVQQKATf1chL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8333

Hi Krzysztof,
    Thanks for your reply.

On 2025/6/23 17:17, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 23/06/2025 10:53, Xianwei Zhao via B4 Relay wrote:
>> From: Sunny Luo <sunny.luo@amlogic.com>
>>
>> Introduced support for the new SPI IP (SPISG) driver. The SPISG is
>> a communication-oriented SPI controller from Amlogic,supporting
>> three operation modes: PIO, block DMA, and scatter-gather DMA.
>>
>> Signed-off-by: Sunny Luo <sunny.luo@amlogic.com>
>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> ---
>>   drivers/spi/Kconfig             |   9 +
>>   drivers/spi/Makefile            |   1 +
>>   drivers/spi/spi-amlogic-spisg.c | 876 ++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 886 insertions(+)
>>
>> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
>> index c51da3fc3604..e11341df2ecf 100644
>> --- a/drivers/spi/Kconfig
>> +++ b/drivers/spi/Kconfig
>> @@ -99,6 +99,15 @@ config SPI_AMLOGIC_SPIFC_A1
>>          This enables master mode support for the SPIFC (SPI flash
>>          controller) available in Amlogic A1 (A113L SoC).
>>
>> +config SPI_AMLOGIC_SPISG
>> +     tristate "Amlogic SPISG controller"
>> +     depends on COMMON_CLK
>> +     depends on ARCH_MESON || COMPILE_TEST
>> +     help
>> +       This enables master mode support for the SPISG (SPI scatter-gather
>> +       communication controller), which is available on platforms such as
>> +       Amlogic A4 SoCs.
>> +
>>   config SPI_APPLE
>>        tristate "Apple SoC SPI Controller platform driver"
>>        depends on ARCH_APPLE || COMPILE_TEST
>> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
>> index 4ea89f6fc531..b74e3104d71f 100644
>> --- a/drivers/spi/Makefile
>> +++ b/drivers/spi/Makefile
>> @@ -20,6 +20,7 @@ obj-$(CONFIG_SPI_ALTERA)            += spi-altera-platform.o
>>   obj-$(CONFIG_SPI_ALTERA_CORE)                += spi-altera-core.o
>>   obj-$(CONFIG_SPI_ALTERA_DFL)         += spi-altera-dfl.o
>>   obj-$(CONFIG_SPI_AMLOGIC_SPIFC_A1)   += spi-amlogic-spifc-a1.o
>> +obj-$(CONFIG_SPI_AMLOGIC_SPISG)              += spi-amlogic-spisg.o
>>   obj-$(CONFIG_SPI_APPLE)                      += spi-apple.o
>>   obj-$(CONFIG_SPI_AR934X)             += spi-ar934x.o
>>   obj-$(CONFIG_SPI_ARMADA_3700)                += spi-armada-3700.o
>> diff --git a/drivers/spi/spi-amlogic-spisg.c b/drivers/spi/spi-amlogic-spisg.c
>> new file mode 100644
>> index 000000000000..2f2982154d49
>> --- /dev/null
>> +++ b/drivers/spi/spi-amlogic-spisg.c
>> @@ -0,0 +1,876 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Driver for Amlogic SPI communication Scatter-Gather Controller
>> + *
>> + * Copyright (C) 2025 Amlogic, Inc. All rights reserved
>> + *
>> + * Author: Sunny Luo <sunny.luo@amlogic.com>
>> + * Author: Xianwei Zhao <xianwei.zhao@amlogic.com>
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/clk.h>
>> +#include <linux/device.h>
>> +#include <linux/io.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/pm_domain.h>
> 
> cacheflush
> 
>> +#include <linux/platform_device.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/types.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/reset.h>
> 
> So this you take to reset device... but your device does not have any
> resets! Just look at your binding.
> 

Will add resets prop in binding.

>> +#include <linux/pinctrl/consumer.h>
>> +#include <linux/delay.h>
>> +#include <linux/cacheflush.h>
> 
> Where do you use it?
> 
Will remove it.
>> +#include <linux/regmap.h>
> 
> Actually several other headers looks unused. I am not going to keep
> checking one by one - you should check and do not include irrelevant
> headers.
> 

Will do.

>> +
>> +static int aml_spisg_probe(struct platform_device *pdev)
>> +{
>> +     struct spi_controller *ctlr;
>> +     struct spisg_device *spisg;
>> +     struct device *dev = &pdev->dev;
>> +     void __iomem *base;
>> +     int ret, irq;
>> +
>> +     const struct regmap_config aml_regmap_config = {
>> +             .reg_bits = 32,
>> +             .val_bits = 32,
>> +             .reg_stride = 4,
>> +             .max_register = SPISG_MAX_REG,
>> +     };
>> +
>> +     if (of_property_read_bool(dev->of_node, "slave"))
> 
> "slave" is not a bool. You want to check for child presence, don't you?
> You need to use appropriate API for that otherwise you just add one of
> the issues which was being fixed recently.
> 

The correct property name  should be "spi-salve". I will fix it.

>> +             ctlr = spi_alloc_target(dev, sizeof(*spisg));
>> +     else
>> +             ctlr = spi_alloc_host(dev, sizeof(*spisg));
>> +     if (!ctlr)
>> +             return dev_err_probe(dev, -ENOMEM, "controller allocation failed\n");
>> +
> 
> 
> 
>> +
>> +static struct platform_driver amlogic_spisg_driver = {
>> +     .probe = aml_spisg_probe,
>> +     .remove = aml_spisg_remove,
>> +     .driver  = {
>> +             .name = "amlogic-spisg",
>> +             .of_match_table = of_match_ptr(amlogic_spisg_of_match),
> 
> So now you will have warnings... drop of_match_ptr.
> 

Will drop it.

> Both suggest you send us some old code, instead of working on something
> recent.
> 

The following is the link of my first version:
https://lore.kernel.org/all/20250604-spisg-v1-0-5893dbe9d953@amlogic.com/

>> +             .pm = &amlogic_spisg_pm_ops,
>> +     },
>> +};
>> +
>> +module_platform_driver(amlogic_spisg_driver);
>> +
>> +MODULE_DESCRIPTION("Amlogic SPI Scatter-Gather Controller driver");
>> +MODULE_AUTHOR("Sunny Luo <sunny.luo@amlogic.com>");
>> +MODULE_LICENSE("GPL");
>>
> 
> 
> Best regards,
> Krzysztof

