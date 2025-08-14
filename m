Return-Path: <linux-spi+bounces-9416-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B108B26B1F
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 17:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E501C84BFF
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 15:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5361A32142A;
	Thu, 14 Aug 2025 15:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="ogtF7fPe"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020133.outbound.protection.outlook.com [52.101.84.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385481862;
	Thu, 14 Aug 2025 15:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755185613; cv=fail; b=tHpFshfB+X+Y3gOBUue9lvU95Hj1i+e58gJdSwjdIaijoTkNUffBRWRxkobMCdOIBA3i8F3GsV93ka46mELYgYSNGg5ykPyHCHnc7Dv5NceKZ2Z4rux5i1PSaDpBY04TZuu+o/dO7AHcaernNvWsv6lZ1ovead0ceNfHMPSBPO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755185613; c=relaxed/simple;
	bh=JUFttkSSsKxELq4jcZ12/4m1lWhZ6BeTVCmGUagwXw4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cSqx2g83jHhBshMNMzuMxEvYzIZ65rHApDZbH126Mxkyku89DTbodz/j2AFpEMdhwTsaMwd1KMHWerCg6vy8DrSlgY6zflTH64baYA4TPcE5oj734hKdTFThzZLHgAo56dUxiqaI2IssF5PAUMhWg9INJMmYJlhJlGX76ZBMp7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=ogtF7fPe; arc=fail smtp.client-ip=52.101.84.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CbB4EPJVMMOzOBAq8Bl8oa9wpUFRZ4nACm2aAXaLKy2Wq+xT1Sfl/2sN3pp5dntMYS7VPXzNUGBTTjCYreUlV6jSPrcRWOVVShrW9xtc527oBfxIPKR5ajga6SEoapj4dDeUG1VythAGhu4yTNoYSJYnirqTNlxpW21qAYo6E+IKfR2LjSAWc+PAB+i0eRADtT6dodmHNj8YtnsvuRHMGsF+fhpfwCwa7fp1FtXr1DBiJbolWHgFVoKV57KVPIQ6wYq/6o65Q2gOhh5jtSPpXYJZn53meiBQvfpLB494HtRfmwINQPBcU3WehWBBCjOkxt6/rRHQL/4g4mh6UGGYtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUFttkSSsKxELq4jcZ12/4m1lWhZ6BeTVCmGUagwXw4=;
 b=Kfv9tOvh5WGHok9qfmbdhmmg/ZJIo2c3/Ge4WzDj6IdmkkBzVvNhxYKVNPPlJwYb3OaHccpBs4LFNW8iUd9rKW/w9NJJUHNXC6Y/Rbmxy0QJLPjSiam+wUa4Icu6SpUXV7LLAJlcx/ExEkbNuy0KEt3NKdkDA6Zwk2hrGbnpm/AE1k9i14L1m/vfnIQsZjB4tOVBR123l45/jvVmOg7ia/nZcI991S5p5DSv2lpqzkbB665IyE0Dsnw/IA23PnuaeUbWxtxgT20ZF+ZdevZsCwZEnPNnFiP29Eec4fz7pY8f3vSqPNcqexz1EPNGGTDmPwg/qoTXXKQ2qKEqJiXixA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUFttkSSsKxELq4jcZ12/4m1lWhZ6BeTVCmGUagwXw4=;
 b=ogtF7fPerLr2wMtQbrVA/LFRfDHje+GESD2SYCVodyJUIHR8Z9lS/se9zWU1yWksEHVe1WPHUeEsS/XCwn6FIHnQjoTJYDmfrhnj1iLhP4In3yNUrjtgfi4MuA4Gc8KhUwQIGaSnngexGro5KbNH6t5RVacKYcpzdq3mG3b+pa1B8JP0TtPPpZ8xxaph9F8QUfE60lUKSMpCqq32Jy+KGbsH8x6dXCjRbOuR6FITgTgT3KujS41QdY7txoOxfYoJ1rQUzEr/OgAxJE9aSmI59zJkGqBLkyvjfGVqa2UpMrPI4yIrBcI10NuNSheUecS788Lj4fwOrMIET5vhywmGzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB9947.eurprd08.prod.outlook.com (2603:10a6:10:3d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Thu, 14 Aug
 2025 15:33:27 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Thu, 14 Aug 2025
 15:33:27 +0000
Message-ID: <e8f77b06-b47c-456e-8671-ac8ae573af64@iopsys.eu>
Date: Thu, 14 Aug 2025 18:33:25 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 4/4] spi: spi-airoha-snfi: return an error for
 continuous mode dirmap creation cases
To: Mark Brown <broonie@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
References: <20250814065423.3980305-1-mikhail.kshevetskiy@iopsys.eu>
 <20250814065423.3980305-5-mikhail.kshevetskiy@iopsys.eu>
 <78542bbe-1def-4aca-8424-cc26542d9762@sirena.org.uk>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <78542bbe-1def-4aca-8424-cc26542d9762@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0147.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::11) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB9947:EE_
X-MS-Office365-Filtering-Correlation-Id: ae23c154-cae6-4389-a7cb-08dddb47ea0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VCs3YmUxTHhNbnhZL2RoME5YYVRjWXZCMjRxYnk3S01HUFdSMHpVSFBKR29H?=
 =?utf-8?B?SG9ldjhQclJtbS9DVHpzWWxnT2M1R21jNzFWTU52ajRtVjZJd2M2UkMra1RD?=
 =?utf-8?B?TlFySCtOd2RhM3RyZDlwaEk1SmppRDVGZnR5aTI2Y2lheFMzNmZ6ZFM5RVg2?=
 =?utf-8?B?QjdnUTh2a21HZ1B2cjRDVXR1N3d4QTRIUFhubGxxbHBRSTNWck45MkVaUzdo?=
 =?utf-8?B?VmEzVzM1SXQ0QUtxMVE4aUM2bzQ4VkNhakllWjF0bkQ0eXVUSVRsdkpEMnBO?=
 =?utf-8?B?SEhxa1ZpNmtYRnVHOFd2OW9hR2VpeXpmWjZCVVkwWmliTU1NdkRWV2pidnN0?=
 =?utf-8?B?eXRjd0lEcUtuc2hUdmRWYkZocTBFQ2tubFlqT2M0eXZIR0plSGxZQldYbFBm?=
 =?utf-8?B?dGZSTVVmS2JZRzU5bzNXMG9nODIwT296MEx5aWowSUlZQVBSdzlGd1RoNVN4?=
 =?utf-8?B?Wmo0NU4zOHdRZE9oRzdWRG5TY2FlTkZsdGQ1MTVKMU45RHRGbVlocktnMUpt?=
 =?utf-8?B?RCtsYXM5Qm9qQ2MyOGtRTENMVU82QXlQOStRTXVtUDNyU0tKUXdkeXNNcGxM?=
 =?utf-8?B?SDRuUlptK2k0ellPQzVLNHNiTmNNWEsremhJb0l6RGFaYUhLTy9hRko5YWY2?=
 =?utf-8?B?STNHSk4yU3crNE1wa1VLMG13ZW94L2E5WklqVzlkbnRRVit6bjMwTEpSNDV3?=
 =?utf-8?B?N0lWT0QweTdwS2QyWWxJS3EwWk42MjVUVWZMOGlZcFRWR0RQZHgyVGFrRnJs?=
 =?utf-8?B?UlBydjBKVndyRllBelRYWHg0eVlLTW1KVGRyc1hsRUdXUGx4cUdxek9uUTd1?=
 =?utf-8?B?RWJKMWhjbTVWRFl3aU10b3BNNU1mQWQ4UXl1NlN5WFU3VFM1K245Vi9CN25l?=
 =?utf-8?B?YUNsRHU1TnN1di9tZm9LSGkxUm5KSHRLd2ZnV0JXbWIwbkI0QlcwQ0JlVFpv?=
 =?utf-8?B?K3p5eFRJN25UOVZrZlBnSVhyYU4xWWlZN1ArOGJVcDJQYXpKZkZDenoxMjRD?=
 =?utf-8?B?RWZYcFUyVVgvMDZCb0Nqb1NvSzNIdzNKb21pcmRzNW0zc3VZbmxxdnN2L1dl?=
 =?utf-8?B?WWFxZGpSWFBCSS85aW1qZjdjNS90VFF3b3NVZDl4ZWszRXVIQXJxaDRhSm55?=
 =?utf-8?B?dkRIOXZTWFllR1Z0Uk5yc0tCZWg1WHNjY2w1UUhaaUV6VkhURkg3ZlZ1MkZF?=
 =?utf-8?B?YVg2ZHdYMmQ3bkRxMGpnN2NGcDBWeVZjTm9YMm5nMzcrVktsOG5mVmxMUEN6?=
 =?utf-8?B?OFhuSUZ5VGRNSjNoRkJtMmFxUHZFU3o5bm90Q3ZVbG9OUGZhZGx5M3lPMnEz?=
 =?utf-8?B?a0VEUWE5Uk1xZ3JqRjFlZUFWbXJBa3BjZ0RIVHM3SGRPQjkxYW9RQ1g2Q0Uw?=
 =?utf-8?B?ZkFuazE3anAvRW1raGdWYVF6SW96ak03UmI1QmMyWGJ5ZmNydUZuRVZsTGcz?=
 =?utf-8?B?S2kwRjhpUUR4Vmh3aFBlUTVCTE1wZWRZTFFtMUJRWUJDTmhXWVBiYXYwTVMw?=
 =?utf-8?B?UkhXckpKWSt1WnFldW5EVUsrblRKMVM0d1FqSUtKZFRNdkFLMkFneHZJdWRy?=
 =?utf-8?B?N0h3Q0N6ZDlNd3p1cEk1dFdiR1FxdGpDQmJFb2gwckdra3o5dGZ5S1BhTDY2?=
 =?utf-8?B?Wks0NSs1RXBJWWtabHVrV1plbnBVYVNiNG02SVY2cWFQSFNhcVcySE9BMTdi?=
 =?utf-8?B?c254Unlic3llemZqRjJVaXpyM25LOThaL2RPaWRvOXNldFYvN0w0ei94anNE?=
 =?utf-8?B?NjZqRTlxQTJJSFdQQUdUZFkwZkN0SkZJSjVIdjJ2YmtuUVZlbmEyL1VWZDd5?=
 =?utf-8?B?ajVrejFIUS9uZEZ0SkRhWUxRb1RrTXArRUVoaDlhYUZSRSs5MDJLQU5GMmp2?=
 =?utf-8?B?WDFyN2JHRE5udGQ1SVZNTlVNK1U1QVJBTHM0WHRHSmZxV21VeDF4c1dORnVB?=
 =?utf-8?Q?78BcOkJbg+o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDBqZ0k2T3dEWTRKRnlrb0JlTGJaZ3JmUDhGaDZUY3RGZDBxVVl6NWNvN2E3?=
 =?utf-8?B?UkFPcWwzb0VaOW5VaXZXZmpaUWloTkd5NVNFdTVYNE9MSTV4cFBFTGxBdkk3?=
 =?utf-8?B?RVJwLzB0ckI2K3BiN3h5TENvbXp2SzFkZjRMZ2xIWEJkeE01aGF2azgvUG1C?=
 =?utf-8?B?QVJqdDNmcmtJKzBQZ29sK1Q4RzRhSWhVcVBieUViMjArTFBmRG5kRWhQeWxB?=
 =?utf-8?B?Tm4venJYYXhLZHEvbGxyN01CYmdGbUtQTkFBaVZvRXVmK1VjZUZ0aGt5WHJr?=
 =?utf-8?B?SDFFUkJhazNhNlZyUCtTZWZVYkFCRmYyVUVwOGRhc1BJZUIybVVYVnQ0cEZP?=
 =?utf-8?B?VWtxN2FkOFlzS1lEd3B3bVRtK0E2cGo4Q1RJZzZ5N3ptZ3F1eDdCYXgwMFY0?=
 =?utf-8?B?YnF3MzZqS0JrRmwwZmZ2cnhvYUZYZUlPdGMzeGJ5YlFudVNFWEt6OEF3RWRZ?=
 =?utf-8?B?TGN1M1F4aHVja1E1d3oyZTlVQzlET0QyZzllcVFxaEppUGgrcHQyejZxRDh4?=
 =?utf-8?B?d1dtVldEU2xaQmtSaHI2TVpXNmZpZU5UNXVXNml5S3FnVnpvRzRiRkh6NXR3?=
 =?utf-8?B?U2xQT0cvbWVUR3V2RDVpc0NXUVBKRmxIenM5UVV3NDVCSEd6R2ZxMHo1Z0VP?=
 =?utf-8?B?Yzl4UEZQZllHRUVJV2c4T2VuOG5FT21NSDNjV2U0MDFBcU5nYWQ2cDVyWEU4?=
 =?utf-8?B?UTJONUtISUlsRUhvcUdPQzRXcTd5ZndhN0NzL09sR0VMSUxXWTc4cW9wMTcw?=
 =?utf-8?B?U2lFYWtlWjIyMGtUSk54R1pxQ0dUOXpWdnN6bkd5K0tDSjEyQ0NEcWIxRXBW?=
 =?utf-8?B?T2ZjY1RpdmFLSUZ0bmhlbHZoQzd0ZGlQOVQrL012Tm84Q25BdUtQMlp3SDVT?=
 =?utf-8?B?L2doNGk1SU1XUkVLU1BGRlN2aXpkMVgwTStrMFRUNForY2NnZ0tUTDFHZjUv?=
 =?utf-8?B?aFZDRE1xTFhBNDVSMElhNjdXeSsyNWVoN3lubThtRERoT3k5L1dvQ1lnQUo4?=
 =?utf-8?B?M2RYekZNcm9JNkVTcnRzZGtMcHhDbUtSYmRHZlpDeGZKTHhsZ1dKQ0FCZ1JK?=
 =?utf-8?B?V2d0QTdiSVJJT0UxWDM5Mm9weDlvVzZZeFRxMTRWY20xWlR3K1VnYzc5d2JV?=
 =?utf-8?B?ODY4MGlmeXUyU1M0Z21SSjJMVVQ5SE43dmZLclR1c2l1dk9xVmNSNE5XWU1q?=
 =?utf-8?B?ZFlHNVNON1F3c2hROUttSUhmQ1JpNFJ2YzcrcFJzOGhoNnZ4T1Nla25jWWU1?=
 =?utf-8?B?T2ZNMnNjcVZ4VTQyTHh4dlZ0dW0ya1hBRE1wanBtQkR5eEg2WU5xZkpicUJM?=
 =?utf-8?B?VXlrZ0V4aU9RT3h3dGt0Q0VPRTNkckYwWUQyMjZDWmE2VHBCMVhDeGNvY0gx?=
 =?utf-8?B?YUVYUk5HSzRNbjZqT2NybjFMWkFOVkJqby8vREhoVVFHTVdPeTdyZFg4Sjd1?=
 =?utf-8?B?WE96RVNaOS82TWdOYnJEUkpQbFFxRDBTTGFUbS81YUhlNE40cHNtejJCUS8y?=
 =?utf-8?B?d0g3bGRvSm53QjV6SGJiVkM5T2hKYUNOOVRJSU9xMmhTUlNvbkhyMnFWQlpu?=
 =?utf-8?B?T2ZTRVpvUjVjV0NTTlI1RHZEcEdIL2dXTVMrSjdoNGVhcUpmZkQzb1NLd3Qw?=
 =?utf-8?B?aXJMUlRNdkFrYkk1Ni9qT29NYWorWE1rZ25zLzJhZi9IUXZOK05qNEp5Ukp3?=
 =?utf-8?B?cFhkOHlwK09VQVQwUVNtaHdOaXJVQXBKYmY4VUJ1Nm10WkpMaWNwN0NLcW9G?=
 =?utf-8?B?VkJFRFptM3JlTTlKZkloUE01UEpNUFRjQTJVdDNjcldhYytFU29ySDFvRnV2?=
 =?utf-8?B?NUYzZ2xHK3ZnNUVRV2UwNkV1NVNHVTlwckJZWjVhTEVPNStGVEk2SlJNZHN3?=
 =?utf-8?B?a2dyVmVVLzQ2elhQeTFyNnJnU3RuTnFVbUxKMnJuVGN5VGdqTWxOSCt3Y2x1?=
 =?utf-8?B?bW5CUHk3SkplOWpuQk41ZkJyUUtMWk9PTjVrcTEyVGQ3d21Mb0hMSXdOVXdT?=
 =?utf-8?B?U3BSOGpoeHN3WG85QWJBWlRIMW9wVXdqYThOeW9VdzZlZkRmejEvRHJRYVNM?=
 =?utf-8?B?cUgwM1FJSVdMRmJvUzdzNGl4N3Z5ZmxqdldEVnhPbUdML2Nkb1Yvd3BOdTMw?=
 =?utf-8?B?MzhiNktVZTdhMGJLaGlsNjRwcVZmc1BGcnRHQUtncWk4ajgyUXZNd3JTNkRO?=
 =?utf-8?B?Wmc9PQ==?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ae23c154-cae6-4389-a7cb-08dddb47ea0f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 15:33:27.4262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dj93FjNtDwLiLUWbfejwQxs8MYEYydcSqhkV03CXdVKOxbBnAQSBLfZBn4m7kJ0Syb6+l7sPUybSQQfy+bB/sc5XMd470Kd2M5jHBqLaHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9947


On 14.08.2025 18:29, Mark Brown wrote:
> On Thu, Aug 14, 2025 at 09:54:23AM +0300, Mikhail Kshevetskiy wrote:
>> This driver can accelerate single page operations only, thus
>> continuous reading mode should not be used.
>>
>> Continuous reading will use sizes up to the size of one erase block.
>> This size is much larger than the size of single flash page. Use this
>> difference to identify continuous reading and return an error.
> This seems like it just applies anyway regardless of the rest of the
> series?

Could you provide a link? I do not see this in upstream linux repo.

Mikhail Kshevetskiy


