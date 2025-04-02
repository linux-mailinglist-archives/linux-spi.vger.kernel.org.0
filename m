Return-Path: <linux-spi+bounces-7390-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0075DA78D65
	for <lists+linux-spi@lfdr.de>; Wed,  2 Apr 2025 13:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 233D63B3D8B
	for <lists+linux-spi@lfdr.de>; Wed,  2 Apr 2025 11:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC61239072;
	Wed,  2 Apr 2025 11:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XMTb7g3b"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192BF238D3A;
	Wed,  2 Apr 2025 11:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743594210; cv=fail; b=OIP8ifSVfID6wtnj/lTJVBzsbEy9KQlJi3X5EMXEVFI1q1nxp5Me/uER2oMVoAIsRfXhWFdaMhZMOf01d2TOCPYOK6Q0se3D81A9Pt+Su6CDtm0XblKia12h8b074SIMI2LDBcQMirM7neltR6Zlyt2LMzEyA8YNazVwcnmZ++0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743594210; c=relaxed/simple;
	bh=SlUPX3a4hI93bIdN26MYDvlnQOdTGgYx2f+1VEH+2hE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=janBfJ/mAuXZBEVvL70166vIrf1vTEDcU2uGwYjcOJUVGXnN4t+vOYFLG2094BJ0/KbCDeRev+o7qZUuUS3O/wYW8i9rW1anONFzswF7oJugN01pTsoW92KFBgp60SExvwDjucl63dLDlNAUoY+k7AGIO1RDHx2sqCpAKC3b90U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XMTb7g3b; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tikZ5C+YorQSYHcw4B52+tg9QUm3rN9oQGnNEiKbiHp0qXnEEJjRzniLv9xdPubEwh7j31L1qbTO30CPYkJChvazqB2/gpBhhxButZAntGa6+6mTcR0jSiftaUFR/Jv5GTikuhTIswpQq+mkuGfrP3ApcjA9okEfCfLPZaegCmYvFdpztWrUwB0mtzf77N0BH4gvCsc76Ve2+ETf+6wHyII8dbEHCKM7vRhU0fKRMq1ke/d6Qyl+gacZUdu5MRSeWauQi8QNTLaNfMm50qHtYKKDqmKGRPIA5kDPJs8sRDo4xoBcsududFu0S5Q6U13dc9TlGPC3Ez5Fh6LqcXVdwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIwMRahuJ+Wxe3r/qqinFZTFWLfo89Ns6jxXjeUOIhI=;
 b=wWRH2csPBIEoiSSPK8EuhMdWp7UpYnyDfqyusAkavePfHrdNT0RUo8JKV/FdO7PFfkEX0y4wgcx0JaqpDapFM0IucjV4bk4ecNgLjEnkcarH14XxwR+G0DqW3ujzDq7AqbS6Mzu839ha0AiAhe6ECvSKnkkUIjRItVS9gxrFbVo9iYzHDwTEo7oSn0V06Nf1uMQp2lvCchOLKdYKMoQe29QsoG2iVFW+8wea2TG6GMiJ3xFJGAacSqlc/w49GpDuZ6QtaSgVo4LB9BCwOBTk7eP81FKOyN12RMZHxR2+xVMlb5uqRYKAqKjQ+iDTBAToasop/K6OgNq6+b7sMBZhjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIwMRahuJ+Wxe3r/qqinFZTFWLfo89Ns6jxXjeUOIhI=;
 b=XMTb7g3bF9+wpgn+PB56usM0dejknM9HEwJHkPXW3TDQKGQAaunhj+WEWcnnSQqZLwWAfKTKdTMr4h5Blz0mYTUHAkzkptmiI/NhX31K3nZV8t+TeF0nJFOefyiUwNEp0kxRUY7+RgKB+3pGIGLz1hy74WNwZQCk8rbRzuMABoM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by CH3PR12MB7618.namprd12.prod.outlook.com (2603:10b6:610:14c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.47; Wed, 2 Apr
 2025 11:43:24 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%5]) with mapi id 15.20.8583.041; Wed, 2 Apr 2025
 11:43:24 +0000
Message-ID: <c239f4ce-98d3-4896-989c-3f1e4e5ad0d1@amd.com>
Date: Wed, 2 Apr 2025 17:13:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] spi: Add driver to support AMD eSPI controller
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 krishnamoorthi.m@amd.com, akshata.mukundshetty@amd.com
References: <20250313183440.261872-1-Raju.Rangoju@amd.com>
 <e41947bb-7a2d-4b64-b680-d38dd9935a00@sirena.org.uk>
 <55ad37f1-0fbe-4a83-a998-80f2fd94a883@amd.com>
 <6a67247e-0b20-42fc-ac0b-7d4a8cef410c@sirena.org.uk>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <6a67247e-0b20-42fc-ac0b-7d4a8cef410c@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXP287CA0007.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::14) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|CH3PR12MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: f3cb6640-8500-4233-a9c3-08dd71db933b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QTZGYnZWMk15d2RLN1M0R1B4MGg3ZUFnVllSbUZKOFBoOU5lMDJKZkg5bi94?=
 =?utf-8?B?anhDOHJnV3k1TWh1aUI4N3RURnlPemJuYVpBVzh5enJlRG9YT1VtQWJCYzF4?=
 =?utf-8?B?VEV6M1U5Nm9UN1JRUE9SUHZpVE8ybXpka1RmK1VKcHlUUitzaVozeFVRbVhO?=
 =?utf-8?B?dndrOFVHdXEvWmMybHhyMlBuZFJZK0FDbXVNaTRmOEdOaG5DV0daUzNmLzB3?=
 =?utf-8?B?M1lxdm9TM2FnVlJxK3hzZW9qOERSck9tM2JNTExmRmV5VTByNU1uNU1WSnpl?=
 =?utf-8?B?cVhGa0RsZy92T0pqZFZ4MVJvenk5T090TzF0VWZGQVkvcHFGNVJEcGUrOXk4?=
 =?utf-8?B?UkVEY3JiT2I2M0dpMFRUdkxWTUwrdXIxNUtpNTBicGZ2bVJ3TDB2UnZBK1Ex?=
 =?utf-8?B?Vnd3czdaN0s4RE45TjJCUXV1RkNtVW1tWWI1TG0rNG1zb3RYZ0lmUVdZaXo5?=
 =?utf-8?B?VFdvV3FYRDdSSkVaNFNWek9UN21adCtNM1hBY3RoQmdaYjJza3NMVGxTTC9i?=
 =?utf-8?B?QW1sRkViUURIcTdHWnF5K1VBc2E0d1BLNnEyL0JSenA1MjRUakhoWmM3VzFI?=
 =?utf-8?B?Rng0VE5UVXpLVnp1WmVYeUswNWJ0V0Y2S0ZpRHdvUFlWVGZXZ0gxTWpTU1Iw?=
 =?utf-8?B?cGxqQkM3cWNOaHVxTW1qZDAzc0o1aTZGaWlDK084NzFNVTVyc3FSUlk0Vjlv?=
 =?utf-8?B?VkNvTGlJbmVkb0VCdDBRZHl3N3JyeXgvRFRUbEV6QzBqZGlTMzAwTW9TZlVM?=
 =?utf-8?B?dUJWVWpsSk9tMGRPSXM0RjN5NW9waWE5MmRIdTFyY0JMSXNhZW9QM1V0WndB?=
 =?utf-8?B?VWxjTDZKVjNObTdYNlRvTlNyWEJ5aWJ1M1ZhanR4Yk9JdnNPNW02dUJVRnRi?=
 =?utf-8?B?UmV0MksxbFVrR0tGVmRnVVZuRW1DcXFWUXhNMGswbWcwa2dycjlTNVloenJp?=
 =?utf-8?B?ZHAwMkk5ZVN6VXNLa0ZYMXpCWmRyNUJQcXc2UnBhQUEyYVBRSkxVRnhRMFB4?=
 =?utf-8?B?RCs2TldYTlZHZVdNYWlOaFY3WHp3SlNxR0hlbDRPN0E4RVBtZ2JIUWk0Nmdm?=
 =?utf-8?B?UzRnT01NVyt2dGE1cjFZTEErVmc5WGJYRFpLdCsrWHovcm5WSWhjdzBsSTZD?=
 =?utf-8?B?cmFpcEhuRmdYNy9KRFR4OWFEbUQ0bC9NUSthSHVKNnhCZ095eWplamVpYnFz?=
 =?utf-8?B?RHdVVzZHWUJwb0JVcVQvVGxBcUlPY252aTFRYzl2aDVDWE5qSVlXcEZnWktG?=
 =?utf-8?B?azFCL2l2aVBrR0krU3RmN2NuSmNBSUZRZGwwMjlJVVVRb1FuRGFtNzZadnUv?=
 =?utf-8?B?SVBGczdyaUJIQmpYTkR0bk9Udld4MjVZWm5abllOb1o0YXhrQkNxZkZnVSsv?=
 =?utf-8?B?QURhaTFTM2lIaEJpL2x2WnJSTmZYR1VtdHp2LzA1T3RDeXh5YktQcW1aOXhm?=
 =?utf-8?B?SXNMZmdXZzNSWnA0Wm5NcDh0K2RQdkFyT2ppeGUwNHJzODdERWxoVjg4MXQ4?=
 =?utf-8?B?dU1kRzZGTC9KS2VGN0FTWmF3UHhEMW5oREF3NTRkQTcvYXJhSnFGaXJrVW5V?=
 =?utf-8?B?dmRpU29pZHlRTFhTVkcxWXdyRHl0aStXNk0rM0Rhc2ZaSnNObUpZdmR1Ky9w?=
 =?utf-8?B?eEdXNUw0akJXWXhaVTQ3U0dKVi9Femp5R2NDOXp5ZDlHaGVyVCtTWFRVbVpL?=
 =?utf-8?B?cTEzV2EzbVZTUjZIUkEwSEJLM0xnb2ZKV0k4YnF6cDBEdWdDbUt0NmpIOGpS?=
 =?utf-8?B?THpTTitub1lRdkNkV0xDcnM2bGpFR1gyQTRxMXZTNGRwTlZBTmRneG9YVFBF?=
 =?utf-8?B?bThuaDllWVdFck9zWnVUai9tMmdIM0VFanF6eEJWaUdPeFRIaVpWa1I0NWQy?=
 =?utf-8?B?R2tUN1pXbjFzN3k0YUtkVldKSEZhdmRKUlU1eEhFTjUrR28rSkFOQlZlZEFB?=
 =?utf-8?Q?DboMSf8to8w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bURtRG9QOWZLRyswY2lDdmhOSFpDei96ZSszZldId054azJQaHRKSWt6blcz?=
 =?utf-8?B?RHhueFpnRi9lUFNqdWc4MWl2S3oyb1R6MzM5Y3RsUngzNFMveVd0Z0tvRThn?=
 =?utf-8?B?WmpvL0ZCeTJKV1FpdVBhWlgxOUlzL3RCTGdKVGIzVGdFMjg1OEJhTWZERTdJ?=
 =?utf-8?B?UG42N3ZXSmNSRFZlTWZiSWdpMEgyczJtMi9OazEvMm5VbktreG96LzA4QUlm?=
 =?utf-8?B?OUpBY09hTTlJK3hjTFVpK1hzTmdMZFhnQXpob2U4OVA3QlNUYTEvWU9pSm0r?=
 =?utf-8?B?aC94WE5OOWowdklpOStodmd1V0s3TnRRbFRvb29hVFhBNUZZSmdnWVRpVitM?=
 =?utf-8?B?WW1jRTF0aFI5cXo0SXltZlBkb1N6eEJrVlRtSDRNdmdQZkN2a2JGdjhtUmpL?=
 =?utf-8?B?ODA5TzJlOHBGYzdQWXVoWjV5WklOa3diWU1SYnFvNmJCMXAzeUhMSFkwNUo5?=
 =?utf-8?B?eDJPY1pDYmxqSTRsdEIrOXJRUlkyNmZUcDlWeWFIZzBhRHBQRy91T1hBdVp5?=
 =?utf-8?B?U3B4RzIxRVpwMjNRYkhhblpVRXRKam9XT2pVWms2VUUvVmpqcERLb2ltYXBh?=
 =?utf-8?B?UEFJdGE5Zlh5L24xai92TmptVFhjQ0lBT0VUMGxTck1qd1p2VGFRSEcxMGda?=
 =?utf-8?B?SEVjK1VPMHVabVo5VGtwTGlSeHFuaWdud1FqYVJPVjJraVFTdnptRVduUlZS?=
 =?utf-8?B?YjVDaEQ3d0RLYk5hSnpDQ3FIaitUMmQyRXJ3b1dHVW1oMmV6b0IvZEtOZFBX?=
 =?utf-8?B?RzBjSUt2YWJMNmxySmtNdEFQR1BzM3dNWjhtR29KZ0c3U1FSQzYySmQ5dW5U?=
 =?utf-8?B?Y29CL05ORC9IcE5GWkhQRlBZczNVVHJYK3VOYzZJNmp5MENZZkJPeGpiNVYv?=
 =?utf-8?B?MVZGcld5aTR5S2tUZUYyUk9td3YzV0FxWFpjYVk5cGJ4WUR4M29kSDd4dHZo?=
 =?utf-8?B?RVdPQy8zcGpXaUw2dnlYYW43VUIzRThEQTNvVUVHekhnSjFSZ1pOaUttazND?=
 =?utf-8?B?Wk16cWg0VlBwVENiQVBjMzVGaXkrOUhOcS9mQ3Zid1RBNWxOWnJNZTNLODBs?=
 =?utf-8?B?blVUc2ZES2cvSDBGYW5IRVRQamMzejhodkRKU1REMjkzaHNBMS9meWU5UlND?=
 =?utf-8?B?d24vWTVZb1dqSUVsMFcrNURQS2RuU21SR0R2Y1Y0K1RmTXlMWFVtU25FNDVR?=
 =?utf-8?B?N1ROejR6R3lZYmtJMHZUam5aakh6UElRNExLM2t2THlhVmZzY1o2Z0gyZ2oy?=
 =?utf-8?B?d3FWSUZGMkxreHY5cWZqcEZORDJMc0dEM2tQbnJqbFdVNjNaM1FHdUdIVkRK?=
 =?utf-8?B?dXFHWUdoY0NHZ3NrdmV2dmlKOG05bC85MkpuNmpTYnNvbTc4MC9YbmxrT1Iw?=
 =?utf-8?B?bzFrT2pGYVlaYmlQdGJtdG1YMHZsMHBnTjNwbVRGS1NIb1UxbmdBcWh5M2hR?=
 =?utf-8?B?TXFadjlyUTRwNzFQQTc5cU01dXBoeitQT2NEOENlVi9qN294emZXZEd2djZt?=
 =?utf-8?B?bXhLQWYrNElDeXBNZ1Z3clo0ZG9ZMzRsaGNaVlFFY2FlazIrU0xGNHdSdGlx?=
 =?utf-8?B?OXRuZ3VuT3RhWHMvS1BTSXhNWGJTQW5zc0xFWWFNMndkUlZSQlpoSW9QSmZt?=
 =?utf-8?B?UnZUa28vWXc2STNKK0duZFQ3ZTl2dG9zY0hvWHF1bDlxSmt6R04wbnhUOWhp?=
 =?utf-8?B?R2pkQ2lsZE1TVjlTL1NrbUUwNms4T3VZZmx0RGRFUVVjWllXcVVzQWxqZnFY?=
 =?utf-8?B?YXltbUszUzdIZmp5RDJheU4yOXZxcjVpMzdlb1cra09uakZ3aldjVlBDWll5?=
 =?utf-8?B?NUYvUU5JTEdSanNzb3ExeWNFQ3JZbWNZd3V2bTk0RzNPY2VsdnR5K2JIWGIx?=
 =?utf-8?B?WDlDTXpxeDRtb1dOYkF0UGRuc21mTVJKWnZ1VWNQK0Q3VUJxSG5oYXFTUkJ0?=
 =?utf-8?B?OHQvcjQ0MzhrUlNQMmdHU05ObXNHN3BCZDNCb0tUQ2ZlUjR3U21yM0I2a01y?=
 =?utf-8?B?a1JpMnZGdmJBbDNsUWFEYkFOU20zT3VrYVgrZXFlZ3Bvbm4xK1oyS1BBU3pL?=
 =?utf-8?B?cGtJQXZ6YTVmTlBTUVp5a3pEWmlFT1dPOFdXZTBmTS9wVFN3T2szS3Jma0ZG?=
 =?utf-8?Q?xt28g/u4lLPrynXiIWm5Mt8m+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3cb6640-8500-4233-a9c3-08dd71db933b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 11:43:24.3975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O00djw+dZczw3URIUtLEB+YLuYxmWmptfeMvuMheD/ftavpMfYVHkxYXP6Xg8Z/1pHP9Es7Ku2E5muBp9iSLDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7618



On 3/26/2025 4:35 PM, Mark Brown wrote:
> On Wed, Mar 26, 2025 at 03:25:21PM +0530, Rangoju, Raju wrote:
>> On 3/17/2025 7:44 PM, Mark Brown wrote:
> 
>>> I see nothing in this series that registers a SPI controller with the
>>> SPI core.  You need to use the standard frameworks the kernel offers to
>>> provide standard functionality.
> 
>> The AMD SPI controller hardware has only the chip select line enabled, which
>> is connected to the EC slave in AMD EMB platforms. Currently, there is no
>> support from the slave device to register as an SPI slave device with the
>> SPI framework and provide SPI communication.
> 
>> For this reason, the AMD eSPI driver is designed to handle device
>> initialization itself and provide a character device file as an interface
>> with user space for dynamic interaction and configurations.
> 
> If you want to ignore the SPI subsystem and just write a driver for your
> embedded controller then you should put the driver in the subsystem or
> subsystems for that embedded controller (possibly MFD if it does a bunch
> of things), not SPI.  Even if there is no flexibility you may still want
> to have the controller side in the SPI subsystem in order to help with
> reuse with different controller/EC combinations but if you're going that
> way you need to use the SPI subsystem.

Thanks for the suggestions Mark. We will rework on this.

