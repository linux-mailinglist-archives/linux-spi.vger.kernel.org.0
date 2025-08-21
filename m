Return-Path: <linux-spi+bounces-9584-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F78DB2F7DD
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 14:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31286603ADB
	for <lists+linux-spi@lfdr.de>; Thu, 21 Aug 2025 12:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18C12E11D7;
	Thu, 21 Aug 2025 12:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="AXOwZklX"
X-Original-To: linux-spi@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023117.outbound.protection.outlook.com [40.107.159.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E082E0916;
	Thu, 21 Aug 2025 12:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755779081; cv=fail; b=O87Qiv1qBtiPm9j4OOIUIS+NL5AIXWbJOk+sLv3Fcy8q4Vu/19InXTNvGElY+7GdNJAgeBIzwALbmtizVgZ0juSaviZZBbhxEWQUV3hd1Hwfr0eJMekVu/Eki7l5ULefNFZjwBA/e5lQ3uiKF0+PVbUC9XB2f3GITVFFr5YM0gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755779081; c=relaxed/simple;
	bh=mkyTvOea/hs2n8i645OHeeTu257e0z2bAQuu4pZmWBQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BBcbNjCjsdW9+bgM/rLxGvpc2B+wwEV2if3vOK5HmQDPOqGKvH3406+5AfbwqPIE5fnYudyglfjrqG3PSeRi9rCdQaVlPGzM6A0kl6t+pBFL/feurxeKwjWGaOD9jSdFsN7X5qgsqBu04e2yiIh6eapBeCfHG8YBKPWy/pV8sJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=AXOwZklX; arc=fail smtp.client-ip=40.107.159.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EMYN+K5jhdD1GmEkagXo6vNfU1qRGevT6dHBVmgR5NS+DjaSVK9jEya5zXWTEo1RoRj28H2KgVK6r6Ji/c8KfZQtlTYrHZf1cClWdkLF0EalCjUEBJhxsyPiF12vG87fRAxW9Fd1iAmYLXFmZjBHPo5cW75O0siKsilvFtDc+RswKGqxSFughG2t/zcYH+bx5JP1+o/kyKgr970iPrOL0cUfwwHqLTcm2rAav45jWi706175C3hsxkh+ImGcOfMCZCxS0vgfwcnVotd0rr6qIK4Kx9St4H80ZV5Y96Nioqy04jinKtR5C6nvqEoPQBxxUlUtPNge/1hYMMej0SVSiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlgaev1FlUxKVQQRQfeXXtabeWMBFjWFcnpkiXP/Osw=;
 b=du2BxON4JfIkpjQJ9SaJnjfmxKpyVUXCO2gye77cOMCe7biy48M/iJ9mcnpgYKcRfjT8y/UTin3aVzKDzMMjZ5IVeT3A+KDKuKIh9mymOIbDCsyB7hudMmkg76hO30RD5eOAq6kVjSmlDcIwYRtjhxFmt119kNhTKC+n1SZHE861XD6XiurgiL/WiFE3/oODv/+iixhWYXlOnVBwAtbjNM/mY9d2dfemSOWiL2C4E3rXFw5gQoFShiFttRuTeM9oSwBE5dAckvvNbAdJjN0Eq+4lKvV8961rDZxw+JYqhFnV0Ea8DEA9lOKRDVRP2ZRsSRVnk8rdkvNSXslICZWH+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlgaev1FlUxKVQQRQfeXXtabeWMBFjWFcnpkiXP/Osw=;
 b=AXOwZklX0r45ihqb7wX/kIu2BcHgMw4WGSskoPbDwmMVQv0l2yl2hkVSc0kBHQljtXFhqL1meXpzHia3W7kKrmLSs29BIZ5N77iHMcvjdLUVMJJNlD+Naa7ExHUGm6z1/RJkShx9hx4GrdhFdIIsJlQ1ULFfRVX89D+HTw46v9A28YWd92C7jXpMM++16YBhT7+wGPMsK+yD1iaAXFyfyXbJ5UMTgGzQ0pWOHIvbecubVmFKua4ADmACCOl+CxAK2ztzAKXMo4KbrMLS4cmVotaWNoat3TnVceLPcX9MUpk1DEowmt8ec9E5dcpBy96W/p4CDK5LiMZkCem0ODwYuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB8PR08MB5467.eurprd08.prod.outlook.com (2603:10a6:10:11b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 12:24:36 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Thu, 21 Aug 2025
 12:24:35 +0000
Message-ID: <f846056f-b6d7-4503-b23f-672039fc3fc4@iopsys.eu>
Date: Thu, 21 Aug 2025 15:24:33 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/14] spi: airoha: driver fixes & improvements
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ray Liu <ray.liu@airoha.com>, Mark Brown <broonie@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Frieder Schrempf <frieder.schrempf@kontron.de>
References: <20250820123317.728148-1-mikhail.kshevetskiy@iopsys.eu>
 <aKbDjIZhJuWo3yFu@lore-rh-laptop>
 <7bca8089-09ad-4550-93d1-35a365bcd167@iopsys.eu>
 <aKcEYn_hX0ZIusne@lore-rh-laptop>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <aKcEYn_hX0ZIusne@lore-rh-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0088.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB8PR08MB5467:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b4b0dca-3c05-423f-0d94-08dde0adb0b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0pJR2dNNTZJeVBYczhBdzlINmowbSt6RUJySUVRRFZBeGdQQkxKRXlEbk8x?=
 =?utf-8?B?NkpGcFkwWUpyYlk5VlpvOEVmU3hlUTIyRXdGSk5Eay9pRGxXU00yTW15VWhT?=
 =?utf-8?B?S0VhaEtyWTFZNTJKdUE3Q1RkRlI1bnUxNjhjWnE0RzBWZy9OczA2OCtrdHJG?=
 =?utf-8?B?dXc1SS9ZODlMT0lGbktyZkxuR1BrUW53Tk0zQnE3UEY2eHQ4OGNWcGNPR2hy?=
 =?utf-8?B?L09ycng4N0UzVzY2TTVOTFZmemdJLzBNNEo0Wlp0SnRJQWphY29HWW9WdXZD?=
 =?utf-8?B?aDBGSDhIdTBRbW5MMUF5bjh6OHEzaUwreFRNVGcrMmI3V0oyaXcycU1kbk5y?=
 =?utf-8?B?cmYwYVB3ckFRdWx2VGx0UWtPRER5aG51YVRNNW9OSHlLTXEvb29weDllRlBu?=
 =?utf-8?B?blIzVzFXUnJtVHViNUtMNkY5U1N5a1haL0RBY1hZT2pEalM1NTRsZ1VQem5X?=
 =?utf-8?B?cUFkWUNiMVBIL002Sk42bTFiMTFrNjhmU3RLVWkwQVlFdUJuOTVMekZKNkRh?=
 =?utf-8?B?V0Z0YmZqbXlnNUNBWFZoQnJoTm4ycC9kY3NwSHFDRGpSdXdJZ1BKdjNXSUJU?=
 =?utf-8?B?MlVFVTh4citESG9zUTNnSy82QkwrYTRZQ1c4azVkTFVsWFFiMkJYV2VVT2Q1?=
 =?utf-8?B?eTV6Wm96NERvY0l6dDJ1bG9EL2RiY0U1UnNmK1JDcU1HY1NZYm1RZXllN2Ny?=
 =?utf-8?B?dC9kNktETStaUGlWejlYOFNDT1N1VWdIRE9wbWRrMXdwZ1gwN24xUVQ1WW12?=
 =?utf-8?B?aWk2YklkQUpROXh4Q0NObUUzdGxpQXgxd2lRMEFmOG1uMC9BakxPYW5ZSzVr?=
 =?utf-8?B?RlFmU29nUklFZkE2eXpsejVJMzdMYTJpeENMYmZHQVBWSkIrNjhqdEEzVzVC?=
 =?utf-8?B?ZWk4S0tBcHIxKzFiZlBuMEVGWUFGeC9TQWpqcDJiRFJXZmRFSlJmdmErM0hQ?=
 =?utf-8?B?akliRWUrei9KeHM2Wk5qcnhUSkN5ZGlaMHFKalJ1UFhaTUpGTTFuUXRybzM5?=
 =?utf-8?B?MUo2RUFVNEtUR2Fxc2hUQ1JvSlJ3cVBuWVdnTTB4Wlg0NjJvcFM3OXVnUHhk?=
 =?utf-8?B?ekZqbjU2U21MbmkyK2p0bTJBTU5kbENmdHlxWmhoWXNsVjd5aHZndXFwbTN4?=
 =?utf-8?B?U0VCREZFM2hzWHhhdENqVnpnTjdPT3hsUzRQbHVqSG9aV25BcFRaMzJPekZI?=
 =?utf-8?B?dWRVK1BzSWRxNzFTd3RUSkMxYXd3Ym1ZcWM3TkVRTGlPbHJCUHpqTi93ekxk?=
 =?utf-8?B?b0NXeWdGNUNPb3R6NjEzRm5jUisvZk1oQktDdnFIMklORzlJQjNIOHBMNEhn?=
 =?utf-8?B?SFpJSTFoejJTNmdlU3ZzNThUK2c0QUhiZWEvR0pEcW4yRnZPYkJ1Q2VWL25Z?=
 =?utf-8?B?eGJUNjAyOXpSS3RSSGF6ZkNRU09SZkRpNnZQVjJ2dWpIYlpxZkE2cGRZT2cr?=
 =?utf-8?B?aG9SbjJaQTZ1SG15eHB6b2YxZFk5YnllTW93TUw0LzNrV1g1YWdaK1RRTVZM?=
 =?utf-8?B?TFI2MTJvUDhwUnRIbjlJSHFxYzVsS1liZ1ZVUlBoaW1QR0Mxck9JZjR5NXRx?=
 =?utf-8?B?Rm9BZy9rT25iQ3AwYzdKcEFibW1kRjZCWElJZUZnZWNGdnZ6Mm1Cd1VzZ0VP?=
 =?utf-8?B?VGJabVNpS2pTQnpFQytJZC92aDZwL05pMHZzVXFCZDlYbnFHeGlxVTh3ZWlw?=
 =?utf-8?B?Uk03NDZKVThtbnlwUkllVDQ0dDlJYXBsNUNSNGNWYUxxWlYvTVBTSytEMlRn?=
 =?utf-8?B?S05OQm0zKzd0NjJlRWJ3aXB2aHNkZGZYUWR3WDcxbzJpS3V5L09kWVVHRTg5?=
 =?utf-8?B?MTZTYzVWQzhtb0psdmk3ODNTTjhnWHBQZlhpdDA3Z2E1ME5JTXl6UU5iUUQx?=
 =?utf-8?B?K3NmY1hSdDFHeU5iZzdBNS9hT0FnS1BieS9xaGxTRHBtMjRMTTlEN2svcElp?=
 =?utf-8?Q?8apjqdf1HFg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnV4UUtBOElvMGlJREJFRkkxbGFYVzdCeVV3c1lSTTN6ZkRhUEsvM2pPak5s?=
 =?utf-8?B?UGJXOTFKV2d2Z0dlbEo5NVVhTEhLVVpPc3ZNY0dpWmc3U1RJWjRCRFZqSStj?=
 =?utf-8?B?eXI4RG11UTJYQXZkdlB5cGVRR0dMTVVDUlVoWHZKejR0TUg3eGVWaHhMK0Y4?=
 =?utf-8?B?NkV2OXRkNElCOFd5RDFnUU1udnBIVXh3UVpFUU5DM2NKalBjR0dJT2NKa3J4?=
 =?utf-8?B?VHdoRVVHRE1HZHV1VFBFN0ZYWTZPQUlERU5ONkx6a2dLcmlpbXR0c1RJbnNw?=
 =?utf-8?B?SWgwYnFaSG1aZGxPVmsxZ3JQQXBMZDUzL3JRRnpaTGlxL01ObU0yek1pNjBC?=
 =?utf-8?B?aGxDZEFPMEFrWjlMVk54RHZtZjVpcVJLNTJIOWxzZ29uMEdURW42NUdQdHdL?=
 =?utf-8?B?MjNZZTgrL0lWUFQ4NmtwUDJlK0RSNWpWWWdnRHM4TTAyR2xrdmdjR1FBU2o5?=
 =?utf-8?B?QzRTZ3M3ZkFJODRQZE04RUI1S3EyWjBSNUkzeVVMazh3SjJaTUhiY1VRdllu?=
 =?utf-8?B?djRjazR5L2NLQ0YyZ1NqVHJMVUFSVXlLZjVPb1ExM2h4UW9TYzEzUzV5Rmgw?=
 =?utf-8?B?YXh3OFB5M0VsNmlidGZYb3kwRlFma2RQaHJHTlZxWlluM0JoQzQzMUcvdXc3?=
 =?utf-8?B?VHY2QWpXYUdjVGhhdnJzNW5HZ2RFZm5pWTFpLzZtSFZPT3pCUXhnM1dDSHlF?=
 =?utf-8?B?TjgxT09CRmc5ZTkyTEwvTEdodTA3d2R1VWZVK2xHbFd5dExFVlNTT21CUWFj?=
 =?utf-8?B?Zk41YTRxZmd5anJBOG02clFUVGYxRW13SDJaa1p6dE54MFJRaWtjQitmVWNm?=
 =?utf-8?B?VEgyVnpKZ2dYZ0hEcW5VeDYyTkNxenRZRUZsU2Z4ai9TNStobXhMUnROYTdQ?=
 =?utf-8?B?QWNrWXRrMDBGc1NuRGVFRXpFTWRWY0pobWJseDl6ZzFaeWpHR09xTXlNdE9I?=
 =?utf-8?B?cHNJZElWNml0c3VZYXFuV3JCT3NXQ3d3VHZQTWNsZklzZ01oQ0IzZGtRVGVH?=
 =?utf-8?B?Z014UXRYR1puUnUrMXBFWHpjeDExVGZHVHZ0dkRyVWZuRWFUSDNXTnpILzhT?=
 =?utf-8?B?MXJoVHRONlo4TlJOckplcVh2NWcyMUcvWlZUU3N0Q09xL2xNWVhIRTQrTUcy?=
 =?utf-8?B?bTlTOXNSbnJMVzdJbkJqREc1dDA3VWxpUDV3NWtVTlFzQmVFYXJLRTFWM050?=
 =?utf-8?B?SUNIcVd1VU5ncUVTTWFDQ0dRNEh5UzZEd24wRXE5S1pkc1FDa1g3YW1HaUYw?=
 =?utf-8?B?YVlzV0FYZFpaMHdCRHI0R2NiY3pyckcwdUtDaXBpVzczMTNhVjFDbUMxU1Az?=
 =?utf-8?B?VS9iYXJtN3ZMQXN2cDVpVUNNcmYyZFNFYm9jaXllZ29SdUkzcEM0Wno0TCth?=
 =?utf-8?B?UzkvRU1seEFSNGdTWU82c0wvaCtJcTJYYTRBNVFXR1AyalRvdEhHRndpUGJm?=
 =?utf-8?B?NndkcEp2bC8yQnBWMWJWNEw1Y3B0VFJwa0J6ZXdJNXFGM2dOL1VMSDdocm5v?=
 =?utf-8?B?cXplWWlMSU9sUllLejBmSTROb2VCRmFJbGpCcFB5MEx1cUp1RTJMQkwwR2hv?=
 =?utf-8?B?QkxYUW5oOHUrVkVmWThqU2w5ZjR3cE9YZDRldUR0U3M5YmpXRy9tOStGdFJZ?=
 =?utf-8?B?SnVodmdDOWMxeUJqS200WDN6Wk4yRjh1UE45THFBSU9SQzduSEtIem1GTmwr?=
 =?utf-8?B?YlBLTGJpamJQclI1c1ZMaU5HRmVlbjZGQUhvNVFIMUhNUlBLNmVjTk9ScjdG?=
 =?utf-8?B?MTB3N2NMVEI3dVhaaWZvdzhlUlFERW5Na216Nkd5Y3JQeW4rSGNvemlmZlNt?=
 =?utf-8?B?WmlMN0YvdTRnMk9CQk1wVmFKdnVvTG9sY09hdGpua2FRMGlVNmRiWTNxUDBR?=
 =?utf-8?B?WnF1eStHcjd4N1M3SlBmRWppdWVVQ1UvOThaUEpWYzl3cUtjNHVod3RKeUZi?=
 =?utf-8?B?QU1Ga1ExNEdMSFNnNG5nREtYUElmRzVWVEgxa290OExnN1JsVG9KSnVDNnZK?=
 =?utf-8?B?Q0laL2I5c1lsQ2hFaWtJY0dqZFNmZFg1QjR2cXBrekxnWTFoQzFoWUpnUFVB?=
 =?utf-8?B?aG1WbitMY2lndlc1U1dCcmladWRSekRYSGZqRzVCaGpGbVdSU1diWmptSG5v?=
 =?utf-8?B?QVdPUXcvWDRmNWhFVEdrOTk4Nk41SFZ2TzlZNldIV2pmTTRybDU2bUZEaGRS?=
 =?utf-8?Q?lYP+40UfhY3thOmqrN//Ens=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4b0dca-3c05-423f-0d94-08dde0adb0b7
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 12:24:35.7816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i/q6qI+l9F8ZdmKqoVkvCo33mqVI8U3aod0YLHSzlI8SQpK7MEQxEBt/CTFj5V+nLdIoOqZeih5eNFHsqnG41GOOZI48AFFDr6CH7ANL57Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5467


On 21.08.2025 14:34, Lorenzo Bianconi wrote:
>> On 21.08.2025 09:58, Lorenzo Bianconi wrote:
>>>> This patch series greatly improve airoha snfi driver and fix a
>>>> number of serious bug.
>>>>
>>>> Fixed bugs:
>>>>  * Fix reading/writing of flashes with more than one plane per lun
>>>>  * Fix inability to read/write oob area
>>>>  * Fill the buffer with 0xff before writing
>>>>  * Fix reading of flashes supporting continuous reading mode
>>>>  * Fix error paths
>>>>
>>>> Improvements:
>>>>  * Add support of dual/quad wires spi modes in exec_op().
>>>>  * Support of dualio/quadio flash reading commands
>>>>  * Remove dirty hack that reads flash page settings from SNFI registers
>>>>    during driver startup
>>>>
>>>> Unfortunately I am unable to test the driver with linux at the moment,
>>>> so only the following testing was done:
>>> It seems to me this is quite an important rework of the driver. I would prefer
>>> to have some test results for this series. Are you able to run mtd_test kernel
>>> module for testing?
>> I'll try to build latest openwrt with this patches  and mtd_test kernel
>> module and try it on one of our boards.
> what board are you using for testing? If it is based on Airoha-7581 you could
> use the following repo for testing.
>
> https://github.com/Ansuel/openwrt/tree/openwrt-24.10-airoha-an7581-stable
>
> Regards,
> Lorenzo
>
yes, it's based on Airoha-7581

>> Actually patches can be divided on to parts:
>> * fixes of current driver (patches 1-10)
>> * change of behavior to avoid reading flash page settings from SNFI
>> registers during driver startup (patches 11-14)
>>
>> The changes are based on the code we are using for more than 3 years. I
>> adapt it to latest linux/u-boot code.
>>
>> Up to now the only known issue appears on en7523 chips only. Here a
>> corresponding patch description (not added to this series)
>> ====================================================== spi: airoha:
>> en7523: workaround flash damaging if UART_TXD was short to GND We found
>> that some serial console may pull TX line to GROUND during board boot
>> time. Airoha uses TX line as one of it's BOOT pins. This will lead to
>> booting in RESERVED boot mode. It was found that some flashes operates
>> incorrectly in RESERVED mode. Micron and Skyhigh flashes are definitely
>> affected by the issue, Winbond flashes are NOT affected. Details:
>> -------- DMA reading of odd pages on affected flashes operates
>> incorrectly. Page reading offset (start of the page) on hardware level
>> is replaced by 0x10. Thus results in incorrect data reading. Usage of
>> UBI make things even worse. Any attempt to access UBI leads to ubi
>> damaging. As result OS loading becomes impossible. Non-DMA reading is
>> OK. =======================================================
>>
>> Regards,
>> Mikhail
>>
>>
>>> Regards,
>>> Lorenzo
>>>
>>>>  * Driver compiles without error.
>>>>  * All changes were tested with corresponding u-boot driver. U-Boot
>>>>    SpiNAND driver was modified as well to match linux-6.17-rc2 with
>>>>    additional fixes for continuous mode.
>>>>
>>>> Changes v2:
>>>>  * minor fix
>>>>  * add comments to code
>>>>
>>>> Changes v3:
>>>>  * add patch to prevent continuous reading
>>>>
>>>> Mikhail Kshevetskiy (14):
>>>>   spi: airoha: return an error for continuous mode dirmap creation cases
>>>>   spi: airoha: remove unnecessary restriction length
>>>>   spi: airoha: add support of dual/quad wires spi modes
>>>>   spi: airoha: remove unnecessary switch to non-dma mode
>>>>   spi: airoha: unify dirmap read/write code
>>>>   spi: airoha: switch back to non-dma mode in the case of error
>>>>   spi: airoha: fix reading/writing of flashes with more than one plane
>>>>     per lun
>>>>   spi: airoha: support of dualio/quadio flash reading commands
>>>>   spi: airoha: allow reading/writing of oob area
>>>>   spi: airoha: buffer must be 0xff-ed before writing
>>>>   spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
>>>>   spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and
>>>>     REG_SPI_NFI_SECCUS_SIZE registers
>>>>   spi: airoha: set custom sector size equal to flash page size
>>>>   spi: airoha: avoid reading flash page settings from SNFI registers
>>>>     during driver startup
>>>>
>>>>  drivers/spi/spi-airoha-snfi.c | 508 +++++++++++++++++-----------------
>>>>  1 file changed, 260 insertions(+), 248 deletions(-)
>>>>
>>>> -- 
>>>> 2.50.1
>>>>

