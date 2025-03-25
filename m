Return-Path: <linux-spi+bounces-7293-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7271A6EDD5
	for <lists+linux-spi@lfdr.de>; Tue, 25 Mar 2025 11:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C1C7162F0A
	for <lists+linux-spi@lfdr.de>; Tue, 25 Mar 2025 10:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F16F25484F;
	Tue, 25 Mar 2025 10:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ebo3esD2"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BFF9479;
	Tue, 25 Mar 2025 10:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742898999; cv=fail; b=XO9Yh4bvamklEFyhioQMNyY6O3zAmNx0f5hvcBehcuebbXdPzK2QP0Q0GP/ngXP5oKx1IgWPrLUx/80qJZp0DzUE6khtehxVuI37rJ1+2HayxHDHZE0PP5WBH0fK4i50VqKnrEI8SQbWnd0NqWjHWbe83cZ92xSsbhFtAO8ZZ8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742898999; c=relaxed/simple;
	bh=C0jBI5SPwPcIn+/IOw5izXGwzOx5kYAw8biy4IE9XnM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cuh/CCosMCKGmHE5KxhvlZPKJuNcDaNlv8JuBP7N61PiQEKLgS8T5mDwZhi0apfiWZkOekHFkIX9xmF34pFPEQerMVP20xpVIW0WV9/a26XmiZbmnljU+sMHgdTWxbgYI7R9IGOACyJctjzqOlVXS4DHNOv/XLwmqkA7jXjUHdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ebo3esD2; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o75zbhf1HZv8A5omFJLZct5nlfUa6j3XGR5bhgev6VkGHCh2eDiUvmXqEVlQK+Ax096FMcsqJhmEnoVEl5j3zXsGND12ptdpLA8n+jD9eNqU9VnRwq7hklZ6u8tTr20yhBqbu4dIC0+kLS9424fl+Ag4tF26wyXryDM5ZZTUczhUeeCMHR574IQF2BIIh/OrlUIDodPsYzsBNNvFu6CZu5jW0+t6WvzIIK2JSKI6KaljBwO8+zpd00TJ6MwN2lwkwN7ONJnjKrwfBiOC+uMdAoPJ4pQNBDQMHl6hlsynx3r/CIQiEO6l5cnQI59v5L86tASIBLpnHSF0qB86YeBbYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJdYq7dWfyjVCVCUlMw0DaIYYN1NlEG4YmkEmvrYjaM=;
 b=Jqex5LHDbvqWNcbgJKMrrsMEsjfAbqgCb7Sd49t1jZSLB3jX61DhkxOq1QFy1afOQgxTId/oia70MIyPY9nrffqR+bZzJnzZ4C+0H5lbzDvOhFu/C1aQSeZ1Bnl4JBsK5x5wDwxINZL06kq0KmFng4NUUY28X3ORK50La90qPHVW/cZy8ByC+CiFN5Mi05uGQsFoDQthbgDGEy3usdWzk1qRl7rvYcfKyWKRLJBUUJARo4vIML1GI6HqFceUdxVUUQ+aHR018NzXI1WSN2/OrGNkFFQptunYcNmhmN0Fa+stjz5nq9aQ64wPjV0UVSHgy4B9Xpszyzewtt6gYwm6pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJdYq7dWfyjVCVCUlMw0DaIYYN1NlEG4YmkEmvrYjaM=;
 b=ebo3esD2AbqWVKYQdPBjKf1D/P2x3nsEf6oeFQjBdD4irwHKYiU5MeA8YWhQqRAxHtCh0STD7/70dX+TF8b7wet/G53v0LOpPpVj1WQ1xvlweRk/4hf3u8dH0FLn8NpyGic3/fzWe1dCv5T5v8jp/YpZWF44Z8LwidOlFxNmvX62BKJPYvO4RSDFlq05DVu3a1UbwBUr74/K1bTCkHUqPLiawreCnpSKdU5fkoW6zW9Cgt6DVSqZAHQ1mRoVH6UuDseh7hgQ3nC7M2ogHg7iBgZkO713tGU0EbQxe6YnmrkPFdySd/J3jqMHziB/nYLtds8WNqxNf2zplCFzAI5YdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by MW4PR12MB7383.namprd12.prod.outlook.com (2603:10b6:303:219::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 10:36:34 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 10:36:34 +0000
Message-ID: <909f0c92-d110-4253-903e-5c81e21e12c9@nvidia.com>
Date: Tue, 25 Mar 2025 10:36:29 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: spi: Add DT schema for Tegra SPIDEV
 controller
To: Mark Brown <broonie@kernel.org>
Cc: Vishwaroop A <va@nvidia.com>, krzk+dt@kernel.org, robh@kernel.org,
 conor+dt@kernel.org, thierry.reding@gmail.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-spi@vger.kernel.org
References: <20241126134529.936451-1-va@nvidia.com>
 <20241126134529.936451-3-va@nvidia.com>
 <a1278046-038e-4825-b029-1b478f28cb7c@sirena.org.uk>
 <e95f870f-1309-4ac3-a16f-ce58b02dc817@nvidia.com>
 <59ec100f-1915-447b-98fb-3cbe2ca53a1f@sirena.org.uk>
 <925fe847-68b4-4689-832c-08f8de3dfeb1@nvidia.com>
 <48f9c8c0-5cac-4812-8d06-501193be731b@sirena.org.uk>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <48f9c8c0-5cac-4812-8d06-501193be731b@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0516.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::9) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|MW4PR12MB7383:EE_
X-MS-Office365-Filtering-Correlation-Id: 224497a6-a933-4186-81b3-08dd6b88ea19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVNIT2xlbGJMRjVvdnVTZy80ck5kQWlaZFFYRG4wMFlGUWlTNEJuWENocDcz?=
 =?utf-8?B?NHVtSlBjT3lDK3czQURReWxIRTdsK0ZQNWZYQ3J6QlZ1WElrQ250cDJldGt4?=
 =?utf-8?B?WjI1MEkxTkRiTUx3Sk5PRVBXWDRhRDlYTTVGMXR3VlNwc1NWNlErMURNZDFq?=
 =?utf-8?B?TmtpaCtxYWpxWGNvOHdHM2s3a3FvWUJBa29uK3haeHdnTGNmVFM3RG9WK284?=
 =?utf-8?B?QnAvVHJXdmltbTVSZHAyQWZJSHhQbC9QUE9Yaml2NzlPK2xnbENGOWJWcUtx?=
 =?utf-8?B?K0ZXYjExbTRYV2hNVFY5MEI3cTdPWmg0bGt0clVKQ1lUWDNOcnNKWHRYZEZt?=
 =?utf-8?B?TXhwVWJ0bGx2UGpLUTE4SWNmVVFrLzQrTUlJeHJzRW5wMEtsNDFiNUN1QmFw?=
 =?utf-8?B?Q2ZSSmpiK1YwdVpzNXEzSEhrbEdvNjhPaVBiajgyY1k4NnA3cVUrYUJUcFpv?=
 =?utf-8?B?SytKYm1YZjQyMHZ2TSs1Sy9VcHhZbENiejhyWTNvdUJlSURsRW1aY2ViTkpq?=
 =?utf-8?B?SlFMQUxWRE1ES20zbGdmcklUV21NOWh5TGZ2a2dlL1ZnZmFjSm9OanE1VXRB?=
 =?utf-8?B?citMMGFKWnEzNVFGVVBaSFdsQTlhT2VPTkg0QzhpekV0ejNNRGhHRkN5Wndl?=
 =?utf-8?B?YWNVNVlJWERFaWpqVmlRZC9QN3ViWkJSbkdxSCtYS1VUVWowSjVLenFUblJQ?=
 =?utf-8?B?K0lHN01Vd0RzQ2xDQ3M3MlRsbkp4TWMwV0xudzBCekhLSDVtOC95QS9YNWlE?=
 =?utf-8?B?LzAwczVoQ2luU3hJemh5UkUrSmZhUnVzVVF2MWJPNXpScmVPa1RRZ2x4Wlpk?=
 =?utf-8?B?Q1Z2a0ZLTktiUHE5eXJybldHTzN1UmhoQS9DcmUwZytCQjFjaXdOalZub1JF?=
 =?utf-8?B?N1B4WUh5Zm0wemsvUCtCVEZDZVdiUUM2c0FUNzBWaUw3MlBHTW9YVTR3UkdL?=
 =?utf-8?B?Mytjck1WWEJVc3lHU25SQUJINkFjTmRCTGhqaC9sMy9paG9YUnprZkl3ejRq?=
 =?utf-8?B?Uy9mejNOSWE2c2o4VUFhTHUwTVhOTnJ1M05LVjVISVdzaWIrb2RBWG8wV3ZR?=
 =?utf-8?B?aGtudHNNVjZNcURiMnQweE16eDNYSk5udUx6Wjd6VWMzbVY4THdVcDhLS2RE?=
 =?utf-8?B?YVRnbW1kYkRzczA2Z3ZSRWVlcTdWOEMrVE43R0pkMWpXY2taVjNkbnNseTFH?=
 =?utf-8?B?Q2JiNnNTM2NVOWtQQ1A2aEcya1RWK29hS2VHdlJyQU9QSnd4QldSdkNJL0d5?=
 =?utf-8?B?aUxlMG92NWRTSjdqZEMrQXpTL3Y0N29keVA1bzNuN3YyS0VTQ0EzRHhteit1?=
 =?utf-8?B?bHdaU2xlUzJOM3VFRFpwNVh0bnkxSnBNTHhCRDVyaWwwZk1yNGl4VXFmZGdJ?=
 =?utf-8?B?WG5sckpYeUkvcmMzMVNWMlZTVmlUcDlFS0dKVEJhN1JUUlZtYzBvWTBoemxG?=
 =?utf-8?B?RkVoUkJxOXF1QmJraVp6REd3VHkybVNlcFdrMVY5ZlVpSzlrbUFFSVYwYjlL?=
 =?utf-8?B?bG45NG1XRmdENWZlU3hPaHpsK0g2dXBlNnpoVGF3c3FzVis1aXhYbGVvYzgx?=
 =?utf-8?B?bm5hTDVFSTAxc2p0Q3B1YnRwSFVTcFl2QzhaaEcvdU9xYzhiV2xKalZXcTFj?=
 =?utf-8?B?M1pHZUNlZ21DS0Fsb1QwVm55aG9rV0NrclZjenhGdnFzRVdlRnhnYXg4Zndl?=
 =?utf-8?B?VkNnZG9pN0ZXZ1NZTE9ITGRlQlhody9RNGIwbkMwNXl4eXI5YmMwd051UFRq?=
 =?utf-8?B?WjE4TTU2T2dyTGRQZzIzY1g3YjlLcWxjb3J0ejFYRmpxTm9UNk93NlRnVUl0?=
 =?utf-8?B?eVg5ZDlrdnRFQVhHcFI1WC9aV3hKMHVyMmxkcUwySUlQUE04QnV0ZG5sZXRJ?=
 =?utf-8?Q?+Yw+R+dKjApF+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVpZL2xvR3JjYysxOGlJT2ZvWVYyMTlRcjJ0akQ3R1c2b3J5SWVUSGlYeG11?=
 =?utf-8?B?NVZJcHdPOER3OTd4ZFE1NDU4c3hCc3ZFdWdMdFYybG0vcXlIK2dXTVE1Tzc4?=
 =?utf-8?B?dEpmRmJnbm41TzR3TGlSSXBMc1doanNobjhDUm50RzBabThpWDhYK2MxVE9J?=
 =?utf-8?B?ckN3Tmk3dDR2ZVFQL1JFbHdPRHZ6QUpUNG5HTVRZbU9qRDE2ZFNRWnNaeC92?=
 =?utf-8?B?b2xEeHhlV0hWYUw1T0xRL01kWUZGTUgyNmtjbEtmT0dXb3Z4aWxWTzU1Nnov?=
 =?utf-8?B?YktPdlJMSXJjY1l3MlVhbU9zeGxFMC8waUVYUnBEYlhiVlV3TFg3dzdkRnBI?=
 =?utf-8?B?a1hiM3J4TElnMVI4NElTeHNEQWVrQzZmVjgxYkJkczFjeVdrVkFqU3pUS3lS?=
 =?utf-8?B?dm9CaE0rZ282WWZWckdZaVVJS1IyMlZmQ3pPeEhZWVVkeXN3QUVkQ0piWWhw?=
 =?utf-8?B?YWlkdVZTK1Z4Rm9PTGovdHlucmZqT0hUYjRxbUorVXpHcmI3V0RYcGJVYzRO?=
 =?utf-8?B?T1A5ZmdpVUc1cEdlOFkrRTdpMTdoSTZ4Nnd3eTVEYXJYYkZxSXp0UmdJTWhr?=
 =?utf-8?B?TkZETyt1eEsvZWNTaFVkeTJlSFFZTmNDRkhhVzVxOWcySTVKeTdoeFRoRDFh?=
 =?utf-8?B?QWE2NlpkNUNuTktCMEU5NmUwN2xLZVp0dXZ5cVI4dzVmRHBwcEVFTVpnanlo?=
 =?utf-8?B?SDdxUEQrcEpmZ0trWDI5MmpXTTNpNmE1ZkFSZitLUGpWQkk2WVhxeUd1RElM?=
 =?utf-8?B?T0lrWjg1Y3A1WFpEMWlaQy9XWG15cFVoUCtVYVZndi90ZlpVSnhEZjdGNUJK?=
 =?utf-8?B?REVydDBZbXc0cGZCL1l0M2V4YSttNitzalRETjVlVGJ6SmttSzR5L000VEhy?=
 =?utf-8?B?d0pVdTJGQjhZVDdZbGRzTU9lcEtVOUFPV1JkN25KUkVFZDQ4N0VCdHl4QzdG?=
 =?utf-8?B?alE1NEZvWFJTTkZaRzAxT1FLWjFkUytFTjQzTnlMUGd0bmJMVTBvdmxDMVRK?=
 =?utf-8?B?eWVlWlBzdCszQTcxZ3p0SVE3eVZ1bldmS0RBYSttM1VsUTh0SzJJUzdkdkRz?=
 =?utf-8?B?dXEwSnhaRGhoemorYkdNbkZSV1FvRGwyWnZKcWhUbUhXMUs5YTZ6cXIxMktS?=
 =?utf-8?B?aENuMTN2UmlnMmJwNzlvRS9YWTMxTWp0WHlwbDkwRGFYZCtXVXBnaDZCdkln?=
 =?utf-8?B?S01LN0NGTEthZ292SHBYeVk2THNxYnUwVmw5aTI1SGVWenBFK1ltM2VLMmJP?=
 =?utf-8?B?Q0YzcVkybVhsSlZ3c0RkSENBYVJOeXNoTnpQR3hidHlaMFROMTVZOStNaElH?=
 =?utf-8?B?azVGNFpGR2dieEgvUWs2cldlWlA2T3lyUTBHY08wcUV6MmI4ZGRDOTVvSWdO?=
 =?utf-8?B?QTNFU0tUMzZ4aXJ0bXcwSWs0MzduMmlQbWRvMUtHMXFGMEZhUHMyYm1IcGRC?=
 =?utf-8?B?VTN0aVI0Zm54TVMvSTdna3lFcjNQNmdNcUlCeHc2UkdKOTMvVFh1SXAyS25s?=
 =?utf-8?B?UlB5ci9wdFhRRnRncG12VnpmeThnWGdvYWNSalIxd09wdGJBTE5rUW53SEp3?=
 =?utf-8?B?cjAvMm5IejBGY2Z1TUVRVVVyNGwxSjg5OGJVYy9mTDlheHNlQ2VvQ2lsUlF5?=
 =?utf-8?B?VG90TGlaaW43VzJpdWkzd0k0OHhtdUdwcU8rSjFHS0l2OGM5NHNYNGN6Vm84?=
 =?utf-8?B?Mi9hTnpMNTd4WHhkMUZJY1pnNmZoUExCUThFYUFjUStFUytHNVozcG5pM2hF?=
 =?utf-8?B?Z2pLUEl5VWlLdDljNDlPUEU2cklPcWlhMDRHVkwwejZqUno2eXYwU3VQVHdT?=
 =?utf-8?B?MEcrT1FvSGhER1hCOERvY2hHMWp1aEhvWEMvRnQ0SWxyYU5GVnhYQVc4dlQx?=
 =?utf-8?B?YWZJSWdIem1ZRDd1eUV2R0Fsc21VOWtoSnlMeVpFUmlRSWlQVjlVVnV4UnBG?=
 =?utf-8?B?Mm1FSGJYVWxmU2VIUlZqeHRvaElmZm1JRmJhd2RJYlVZS2FKNXo5b1d6VktZ?=
 =?utf-8?B?LzFtRFFVR2hzZThGYjNycUgvdDR5N1dRaytEa0RLamhOT1ErYUJKai9RMjhz?=
 =?utf-8?B?NCtRTWFIbVVQV0lkTmJvaVRjb1czNVFvRERyYzNFV0tQaWNUSmlsSUhpRlpL?=
 =?utf-8?B?RFAydDVkZ1NxZlR1VkhOaGM1SUYrSSszbVpRekN4Um5NZ3I4dTFqRjFESlU1?=
 =?utf-8?B?QXc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 224497a6-a933-4186-81b3-08dd6b88ea19
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 10:36:34.6395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dDnSWl/Gw1ClHKidlpDR1pLvLPepQgYvjZQI7cqZ6towODdKHLMd1MFkUOrxbeVoTKofYmjQzBHOCNhyMb95jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7383

Hi Mark,

On 27/11/2024 17:31, Mark Brown wrote:
> On Wed, Nov 27, 2024 at 05:24:01PM +0000, Jon Hunter wrote:
>> On 27/11/2024 16:09, Mark Brown wrote:
> 
>>> I understand what he's trying to accomplish, it's the same thing as
>>> what everyone who wants to put a raw spidev compatible in their DT is
>>> trying to do.  The way to do this would be something like a DT overlay
>>> that describes whatever is actually connected, or just customise the DT
>>> locally.
> 
>> We could certainly use an overlay, but how do we handle the kernel side? My
>> understanding is that per patch 3/3 we need to reference a compatible string
>> the kernel is aware of. I guess we could use an existing one, but feels like
>> a massive hack. It would be nice if there is something generic we can use
>> for this like 'linux,spidev'.
> 
>> I see that ACPI has something and it does print a warning that this should
>> not be used in production systems.
> 
> You can put 'spidev' in as the compatible and get the warning, we don't
> require specific compatibles if the Linux device ID is good enough.  If
> you genuinely just have bare wires you're probably able to cope with the
> warning.  If something is actually connected you should use the
> compatible for whatever that is, if spidev makes sense for it then
> that'd be OK to add to spidev.


We finally got back to this. Looks like just having 'spidev' as the 
compatible does not work. Apparently, it use to work and yes you would 
get the warning, but that no longer seems to be the case. I see a few 
others have been doing similar things and hacking their device-trees in 
different ways [0].

I completely agree that ideally we would have a proper compatible string 
for this because after all device-tree describes the hardware. One 
use-case that we use is external loop back for verifying SPI by simply 
connecting MOSI to the MISO. Would it be acceptable to have a compatible 
string for external loopback connections?

Thanks
Jon

[0] 
https://stackoverflow.com/questions/53634892/linux-spidev-why-it-shouldnt-be-directly-in-devicetree

-- 
nvpublic


