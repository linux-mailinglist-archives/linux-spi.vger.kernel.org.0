Return-Path: <linux-spi+bounces-10406-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AD5BB1F46
	for <lists+linux-spi@lfdr.de>; Thu, 02 Oct 2025 00:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D3BC19C3EC8
	for <lists+linux-spi@lfdr.de>; Wed,  1 Oct 2025 22:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C482D94B4;
	Wed,  1 Oct 2025 22:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="CSvg/EUO"
X-Original-To: linux-spi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023079.outbound.protection.outlook.com [52.101.83.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A735D35977;
	Wed,  1 Oct 2025 22:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759356799; cv=fail; b=mIXtzCzqiptN16mTrqh+dIlK6CuYNnwQ2pMV141z3Ffa4wUCqW4OMwxlK/UcT5AMaZQ4jh9bHVkrzXHfHx/XOzBtd9f+R6mXxMxvmFHDmFidkpn3316gImenuMCWIduQARef0YbeOWKrG10Esh4VtNY65JBvdBlwBmktEK9blro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759356799; c=relaxed/simple;
	bh=lng5ZWAu1tTtOyOBY0O9+bkjcm+9fd1uqDBWy8m+gRI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YVtZ1VZkQ1z/NzWnaOt4Ae8I/203NatjaioiGMvwq7/821xt7OAZRsUELMLroP0ov5FAOxbp1+86A4WZd3O4WbwO9hTgegi3N5RZOZEOCnGnXQIf7tO+kWnXoOfJjoYuVr+LVQ5QrpKn31bY3f7nB2AMhHkYr4Mhtt6vsF09i9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=CSvg/EUO; arc=fail smtp.client-ip=52.101.83.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpDm5klBt8A+RhvcdHSXk1HkI4iVUGOxL5jdisRWIqhaX+erdpgmnOszL0XTOnIZhcIy+nZLutxrGRq9k+WBJHFeJGL548RjZoM/PF+JoFmURSOyVEdPJJazdPDi2sPGdYpA+h1EohQPXVEwbJU3+ar93EMfVu3G0eo9JDfvVgD9Qsa10PtCdUPuIsqAry9fp/RPfVPLiNkzmVXlwjJu177NPniGySL2BaM2nipp85/wWN+uMZ6VzKdVZ1w2acaPdlJgvHCY8za7VoUCXxU6NDVUcndSdIYQFXrXEebd9c3kEN0hsfxVSEwzCYy2sxvi7OWZE+tBPghQ1QEGqg7NgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lng5ZWAu1tTtOyOBY0O9+bkjcm+9fd1uqDBWy8m+gRI=;
 b=n5QAyZRz5azb0zAHe5UUglA0R09p2seWA5ivzL7LQiIenQHFl1Na+tmW+2WEr3qKUfa4fJ0nNkhWoBd4qUPMoXTVems1OxcHR8+BkvI4zjxmg249AbeuHWUYmLwJaOJ1z9wvyH3Jynxg6EWCceaz0s7ALHeKLfjsGR1/R7Mqd4K7Y7gE1kYR+RO3BzbtcmmphVrBD25T0CvVNKbNHL8p4qoAQwYQ0axapMSkH8XMUElhzXt5KN8CzE+HUw8diIvVEN9pwzTvX/UDBH0f1ALPN81zIiDBaAK9tAiYO3Hv5Dwbc37rsaZaqDxIPmt5ws9qWFL7l4qF2LWca0fLeqta2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lng5ZWAu1tTtOyOBY0O9+bkjcm+9fd1uqDBWy8m+gRI=;
 b=CSvg/EUO4yff0S0i2NCYyzzrQlfrQeEcOMmhs5sI+2VwBLTqkbR23MBa8sLioGwpzDl2orHLhhw2Y77/18eo0wbBQObYnqTaaEmrow6Msa9J0FcmHh3lvz3RwxW5FEL82byzLdLVUnzfRFl+WUxufc8eNYPJgDY0TxSW5YRGVYWDPPzHw5VZ/GrOKV5Up56j+8rf1LvMUMmNIkSsfUyrlwVLzjma6u2jF2IVa6B3SWgjimGhRijLjY+WCbvHS3bMmpivw05i9Fb+SbXhfmrBBzxHW/An1odf6DTsi4QpsQw+48MShd0c//WgueQZEbbalhnOC4d7eMWRJGLq2kAAFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB10720.eurprd08.prod.outlook.com (2603:10a6:150:16d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 22:13:10 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9160.017; Wed, 1 Oct 2025
 22:13:09 +0000
Message-ID: <d13c09b5-5e9e-4d79-b94b-f3464831fefc@iopsys.eu>
Date: Thu, 2 Oct 2025 01:13:06 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 13/13] spi: airoha: buffer must be 0xff-ed
 before writing
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
 Mark Brown <broonie@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Andreas Gnau <andreas.gnau@iopsys.eu>
References: <20250930022658.1485767-1-mikhail.kshevetskiy@iopsys.eu>
 <20250930022658.1485767-14-mikhail.kshevetskiy@iopsys.eu>
 <7909d937-aa93-44bf-a4d3-12849a14fdf4@collabora.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <7909d937-aa93-44bf-a4d3-12849a14fdf4@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVX0EPF00011B61.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:14) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB10720:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e028125-c212-4817-a48f-08de0137b40e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHBuV0F1aTJOSzg5K29NaTN5MDZNWTJ6cUFpaWVaVzZlUlJrcStmWmhXNGRX?=
 =?utf-8?B?TU9SdFM0RkRKZlhOTC9KTks1RjN4akxjUTFYL2FiNk1tM0w4bDNaNUlhVzE3?=
 =?utf-8?B?TmY0akI4VmU0bWpUdEFmL1FNdndVY3Q1cXdKTzhCV3JSRzlycXdtdjRLSVp5?=
 =?utf-8?B?QnNjUkVhRVFZWEtZUnNPQXBVWEZGTWcySmx4MzNvRHYyc3FTTjlBVDNVclRO?=
 =?utf-8?B?aGsrNXdyODlkRG5TeXdtMDhWQmNOQVZiZjdxdGZqeTBCVUZONU9QRi80bHR5?=
 =?utf-8?B?RjI5Ly9CMTNTNDRPS2RmWTcxODAyUEFrUFYxL2paTXhIKzBRMUp2K2Z0aEtG?=
 =?utf-8?B?Ung1Tml6ZFNRd2tVeWYvVlJJRnZ0TnNJVENucHhzMi9wLy9VV1hueWVaQnRV?=
 =?utf-8?B?WnIxcmptcVRzZXY1U2d0TnZlTDJFNFdRL28rVE5wQnd2ZFBRbVFnUHY3QnFY?=
 =?utf-8?B?aFZlNkR2aDFqdUdOY0d2cGdvaDhZbDNCM1VLYlJ5U2FZWVRSL281RlI1eC80?=
 =?utf-8?B?NUpQQUZDMmEwZWNsTC9OVFVrM3NTWW1aS3RiOUo0TStnQldOVkRoZStxbUdV?=
 =?utf-8?B?ZmQwd01VT2lsYVBzUnhoaE5NVEZwTkVXMmhxUmgxZUxvVUNNZmVqY2Z3akE2?=
 =?utf-8?B?dHhHWHRIbzJPUnJ4Szc0OC9nQnlsbkxpMTN6QkJvd1V3alJaTm1xblZ4Wllm?=
 =?utf-8?B?ZnBwN3hqUXFFUXVSZFVZQTFrM2Zva3d1b2h1QmNBd1REOEhGL1dEZmdtY3lX?=
 =?utf-8?B?SDN0Y0sxUHB2cHlEZjg3WEFCS0lkQWRLVjhZR1l5cHBudC9GSzBTR1hHcGRi?=
 =?utf-8?B?VXdmOXlpWFZqUVo2T0lscTJjZ1hpSU9hTVNGNEJYZmhZemwyRDhDSkk4MDAw?=
 =?utf-8?B?blZvWUd3UHNrZm9CbU9jcW1xa0l4R0NWUEtFdjBNQ2hWNlVBdjl4WU43K1JD?=
 =?utf-8?B?cDhPZG8xQXg4cm5wUFlzL1pTdmZacDAzY3lNakRnR2tBQU1TS3VBNWRXQWdq?=
 =?utf-8?B?bmVrWjNiZUJ4aWx3WnNLR0dic0J5K3djN1dHcHhiQXdPbm1NVEJzdGVpR2t6?=
 =?utf-8?B?a1AwRUdGeFVyQlFqR2c1Q0NOenUrZTI2SXNKT2JGOWVqdExJT25rRHlsYjVp?=
 =?utf-8?B?ZWpGbllTUU8zakhEYXpERUp3aFJCTFFPZTc1MFQxUVVlbVJFTWtXUmFVUjZM?=
 =?utf-8?B?OTRPWDMzeDJOQzBJQkRWbTZFTDY0Z1dqdEdkVkpTY2JndDBsQzlSck5DMG5y?=
 =?utf-8?B?UHo4VFVQcXJkUktoMTVUayt2bElRaXFDejdQZ3p2NERtOHFGRHI5bnJ1WHcx?=
 =?utf-8?B?VHZ1S1pKdGN3b2FHeHA1TlR0NjFpZ2VDdzBGaU9wYjNBSUpXV3dWQ3hPdFBp?=
 =?utf-8?B?NjF6Vk1hbHV6WWwra3dTOUVBSlhmbjlUazV5UjlrQlAzMm4vYW9qekh1Yld4?=
 =?utf-8?B?TXFRTDFNbDlMQkxjQUd1VFRoZ0xXbWJOdEZ0OE9XY0hoTyt6cVBSYzJxWHpr?=
 =?utf-8?B?R3YrL0ZNdVZvUlMxMU8wV3dpZitFdXlkN1Y0L1lMRk1TbFNxaDBaazFneEda?=
 =?utf-8?B?ODFjenN6b3V2eGpxTU9oM2I3YkJnWGpDMzlqeDRxWGloYWFBeUlpLzB1QTVL?=
 =?utf-8?B?cTF4VGtXdW1kdWdPcXE4Ymk0QVVjNldVNDdZZzRSU0g2ZS9OVnFzdGk2SXRN?=
 =?utf-8?B?MTZBczZ1cjFRSDlyK3c3UEk0UkFiZFVxd3hZQzRnMXNsc1YrQ1pjbXYyaVRi?=
 =?utf-8?B?Tll5NW1iVVVRbHNHdXlxMVJ6ZVdpWEl1UmpiNzg2Rzh2NWUyTVlsVVBWTm9r?=
 =?utf-8?B?UXV6M1N5T0NqODJCbndRSy9KZGlBZ0Z5bHZwdUhFWXdaOU5XUVJFU2NuY0Z2?=
 =?utf-8?B?U2lVcFlXMWdGZngxZGUxT3FlOG0ydVZBaU5XVXBvNnQ3a0tuUmhGS251RENN?=
 =?utf-8?Q?5F9+xmfiN2tIhXEE5dlUZyFOAVtvjovM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUsrWGJTbEVsOTUyV1d1M0dvdU8yL3pTWHJhVDJBY25Ycm8xUDZlVmdDdVds?=
 =?utf-8?B?Tk1GKy9SOVVRSkNLZGp3RktDWjg0dkUwUTlPRWhYTGp1NVdxb0VtdElvU0pz?=
 =?utf-8?B?SjNtaVUzRy9YS01oTzUyQ1N5MURacXFsN0k4a01xeUlpQVRETHRHR3dXOWht?=
 =?utf-8?B?cGdIUUpNT0d4eDZteEtHQ1YrbFZ3QW5JSzE3VlJrd3J6bWI1aHVFVXlGSlg4?=
 =?utf-8?B?ZzU0akFINmZybGpiR1FNL2QveGVVUDhtODRTWU5aeXk2c2dUZ3dWVlNPdHl4?=
 =?utf-8?B?YkFSeXdKeldabDRmVjZ4YlJOcFphU3pxQ3U0cHNzcUhCWnNGaWIrSXNQS3Ru?=
 =?utf-8?B?NGxkVlBQa0JGRGZGQjVVcHFUNVdESm5WcU5wNkZiOFIzNE9GNTNSMkxYT0FS?=
 =?utf-8?B?WXpPbFVuREhIWDM4Mm5rcTg2cHdGUXNvd05wYnNYUU5KY0lnKzVBK1ZZM0k0?=
 =?utf-8?B?dVlQcGE0d3dKK3dnR3RKWW9jMktKQkV2eDhyTUZPcHMxNzViOWx1Ulo2ZjVZ?=
 =?utf-8?B?ZjQ1M2NZUUpLVjY3Z1h5MnQ0Y3ZoVDQwZTdnYjJGUURpNC8wWHpISFh2MmdC?=
 =?utf-8?B?R2l1N0htcGJEOEJaMjNZTkpXakdKVmh0cjF5Qit2RUNkNU93WElLQlhBQWRt?=
 =?utf-8?B?L1FOQ3lFUUFXeVg2RFBvV3VvYjNmbXovaGNuZlVZVFlSSk5Oek83QkZ6TlZE?=
 =?utf-8?B?Y1h2U3R4ZVMyaVpwSWEyVGM1OCt3NHEyNjE2MWNBNUd0OE1aeXNQOEtuZlp6?=
 =?utf-8?B?RE9QU2RQYmY3d0dWNTBiK2dsbnEzY2crYU5BSlducjlSRGlGUmlKUGlNNTRp?=
 =?utf-8?B?UCtSZThpOGlUeEd1RGprR3RhQ2p4WXZZNUJCbFpjZXhodGUyS3ZzRVJodWNQ?=
 =?utf-8?B?L3NhNjNPNXNpbENFaWtHdnU3Y1FCdjd1aDY1am5ZbTZ5djJralRtbHdjQzRy?=
 =?utf-8?B?QnFtZ0tlZ2IwWWtTMklhUUM4VHlXS0xWaE5OTzZqMVFTZTJ4RE1xY0phVDJq?=
 =?utf-8?B?amF5QXNCRmJjdVdsblBaVGtFQ3h5aTdZdjh3b2F5cldZRXI2ZHRtVjdobFhk?=
 =?utf-8?B?TUc0VGhXYUNkVFdFbFpEY0ovSUczclRPUTY4bkxlc053WXRkMWdSdUxWaE5R?=
 =?utf-8?B?UXhMYU1zMUVhc2FWbmx3clJPd2J3ZWhtTnRxWnJtYmsvQkZxYk5oK3JvYXFj?=
 =?utf-8?B?MDhaL1k2K1JpeElQd3NHNXZwMkdyaURyZHRCMW1UelV0Z0ZZZk52dkdwOTFK?=
 =?utf-8?B?YWdwZ2NqWUR6d2ZHcDlkTnptT2FzcG51N1N3c2xveGxaS0VkUGpaMU56VStL?=
 =?utf-8?B?U1cyLzBKS0RlU3M5M1VTWS9ra2o3RUJZUDhBMkxKcU83dVA1bWpuSzFmcGow?=
 =?utf-8?B?SldUUDJUYkpVakxzU2dOMWZoVG1NNVpJdFhjQnRNdWwyc1JUeDd1MVFmbGVG?=
 =?utf-8?B?T3docDN1YzdpS3BOL3drK2hOWUUzLzM1aERTaDdYTXFBZmxkSys1U0FCRTRx?=
 =?utf-8?B?MWxrTzRyUnVSV3VGaUlnMFhMSHhsTUR0dC9qb1NYSUpOTUZ2UGRVbTVBek15?=
 =?utf-8?B?TndyWmRTenQxZHc3WDNhTHczQUQ5L05YcDlyWjVKdFF1S2JPQVRVZ0xFQWRu?=
 =?utf-8?B?ZVVLWTFNckk0ZGk3eTZPbjdPZGd6N3B0MjQ2c0M4b3VUVE1VeFRQRFdEaTlu?=
 =?utf-8?B?SVJBdUNZc0l5R05zVW80bFhvMXBnYzBVMEwreWVsazFxZE9OS2wxdDJ0dGFN?=
 =?utf-8?B?alhEUmRtZ3FqSlNweEQyVGZmUGFGd0tSOGhiRGhPdE12S1NPWldOSTU0Q2t5?=
 =?utf-8?B?Nkk1QzJESm5zdXJERkRJbDREM0pDVEdxRHlyTjNXWUoxNFZiQlppc1B6RHk1?=
 =?utf-8?B?R2JBV1g0Unp6VjVvbFVkNHVZWDVxNVVra3hPbndrVWcyd2Zva2Rzd2VMNCtV?=
 =?utf-8?B?T1pIbHd0bnl0L0FRbm1rM3NIdm9sNjM1QlV3K1BxSzh5Mmo0M2dGYmVBYTBz?=
 =?utf-8?B?djRSMWIrMDQ5Ykg3YjdZbVFNbGhJdTFYcUNreEJFUEFDQXNLdGlUSk03OWRt?=
 =?utf-8?B?UHZTNnVQVEhQSEY5clYzNFVFeU5uWndUSkEyczN4Y2NMOENGLzBqZHJDRmNH?=
 =?utf-8?B?c001Y2Vwc0syaGZHV3Zwa2tsNTA3WHJ3ZERuT3E2dzcrWW9QYUQxL0VGMnMv?=
 =?utf-8?Q?qsF28pfD536NB3FN2OUQ6Bc=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e028125-c212-4817-a48f-08de0137b40e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 22:13:09.2869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QtZ7LOgyWiyi9Z9AKX1JCJYq4BxiCZLJgvZlDitbGH1eOb2sZJRU0XHDP3HDoZ3VT6myvmJa2KDC8yJWPMLwNjAeOJQtPqf5Ln3E0GtnhpY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10720


On 01.10.2025 14:30, AngeloGioacchino Del Regno wrote:
> Il 30/09/25 04:26, Mikhail Kshevetskiy ha scritto:
>> During writing, the entire flash page (including OOB) will be updated
>> with the values from the temporary buffer, so we need to fill the
>> untouched areas of the buffer with 0xff value to prevent accidental
>> data overwriting.
>>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>   drivers/spi/spi-airoha-snfi.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/spi/spi-airoha-snfi.c
>> b/drivers/spi/spi-airoha-snfi.c
>> index 437ab6745b1a..57b1950e853f 100644
>> --- a/drivers/spi/spi-airoha-snfi.c
>> +++ b/drivers/spi/spi-airoha-snfi.c
>> @@ -776,6 +776,7 @@ static ssize_t airoha_snand_dirmap_write(struct
>> spi_mem_dirmap_desc *desc,
>>           return -EOPNOTSUPP;
>>       }
>>   +    memset(txrx_buf, 0xff, bytes);
>
> As you are refactoring this a bit, reading the function isn't
> straightforward
> without applying the series locally.
>
> It looks like you're filling the entire txrx_buf with 0xff.
>
> While that will work for sure, for the sake of performance you should
> change this
> to memset(0xff) only the portions of buffer that the next memcpy call
> will not
> overwrite, avoiding to effectively write twice to that buffer.
>
> Is there any reason why you didn't do just that?
>
> ...also because, your commit message really looks like saying what I'm
> proposing
> to do here.
>
In the worst case 2 memset() operations must be done:
1) memset() of buffer head with non-rounded size
2) memset() of buffer tail with unaligned beginning address and
non-rounded size

In summary it could be slower than a single memset() of buffer with
aligned boundaries.
But anyway the difference will be small.

Anyway, I fix this in next version.

Regards,
Mikhail

> Cheers,
> Angelo
>
>>       memcpy(txrx_buf + offs, buf, len);
>>         err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
>
>

