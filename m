Return-Path: <linux-spi+bounces-10597-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 94574BD1B21
	for <lists+linux-spi@lfdr.de>; Mon, 13 Oct 2025 08:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F1A14E541C
	for <lists+linux-spi@lfdr.de>; Mon, 13 Oct 2025 06:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A1C2DEA7B;
	Mon, 13 Oct 2025 06:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nbCBVlu2"
X-Original-To: linux-spi@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011035.outbound.protection.outlook.com [52.101.62.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653DC34BA46;
	Mon, 13 Oct 2025 06:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760337423; cv=fail; b=NyBm7lmLPAP7h15b8W2Fb0W/ah303JKfnSb97v0k+J+AhkrE0FvIyhCXCrMEFCRePdd/lyJ9oRk5sjD/K1Zj5dw4BeA90MFpH5tJS6quP7nVbAnMlAaj5P4NPwKHLQHVQaoxIVoP0BbpRNqD4UBmCcnGjx4uvaKqMEjl4lMgjjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760337423; c=relaxed/simple;
	bh=ZZdMgBl/HHZY/2ko3PWF3WkR2Ffw/6+5v1W0pG6mFCc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t4J8d4JX2abTPVFARh1278aZJbXoZBMJojVYntTv0wkPGSQOP+4SAgFhVwGRKBdC+qoMfOT4QtIqaqsHqqdS4V6Z22OFaElKbiPIoyRBYlZyl1hGDsHnYMJItx4RU69m53QIQu5aTgjt4V4K3RO1ZSvwu5paUXLZ+j500RY2q5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nbCBVlu2; arc=fail smtp.client-ip=52.101.62.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P49PiIKQJXaFpTlasg8FQH7S9OSYLA4lUk+6UW2snxyrPw0FcN6E3JFZhjoGA/8sVVskOO6lBGrRcCmixVcfZ/7Eq7twyXz4oIdRLf2cio9AA9fLqzW5RYx8bS5ri2QYQtcb4Ta2sFTYS8W68n03FoAETszDw4RRUJyCLFlzdxmiv5wA3iGaoMwFRKYLMe109VMr+W1CGvCGHZsRw1mem+80CBOGHcHMLH7RHLxIUbHPXUGNfoYkA7xmZU1P9IKxOWObve6Fwh67UZTZSO9gJ1kxA/t9VkcQ4Q4mSCr9/tEezag1/ZK3AIPDh2wwS72ojJkeqauLE2kI3wtFWRt7hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t84KRgZ3UfH/ze1g5Qd3D7hGqT2VvLR04v+w0nPVncA=;
 b=NLYeofReKvsQlqzXjasTSb01d4WDkRW2Do38kb5EBdP4MB12OcySb4uUtFZAh3pYhBHfkhGL2xxsbq4qSTeA3N53d6ODpmzn9qmSNS4RJ/gfDX40xqm6RtDye7UrxHlVpwXKXZbfTTIYpUn7PoMjxyhAlPmiWPLESmPTyCEAj/aU92G630atfAhOP74UA3GaXzff5VFWvtoYBulgfygy/sQCxSE1GjpYTsN49bVDjqAmXTUDJvKwRSDHirZnQIZCmsFH5LZPgNwjxLuj7r7p75kV5n7fWM5zWX5CqcBzq9tgSv+NnRtKLj1dFgM0ZOZArma6Nfq0w/W0ZGsyomCO5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t84KRgZ3UfH/ze1g5Qd3D7hGqT2VvLR04v+w0nPVncA=;
 b=nbCBVlu2DrMYm/2VCne0dZLXCiYJbMxNFcufBvxPdasxX2k6xcPBb1R+7w64qm5h28p15DRBG3uq+IXfJk+hcxP43aa0DhdOzWXDX9sjT+vKOwwKctw5iyDbwatTEa2mAA/QYSct68OYQ3EiOTvNSZtx1S07aFypTomb/iED0lQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV8PR12MB9262.namprd12.prod.outlook.com (2603:10b6:408:1e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Mon, 13 Oct
 2025 06:36:58 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 06:36:58 +0000
Message-ID: <39e66166-32a1-43db-8d80-143fa288a71b@amd.com>
Date: Mon, 13 Oct 2025 08:36:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] arm64: dts: xilinx: add soc-specific spi
 compatibles for zynqmp/versal-net
To: Conor Dooley <conor@kernel.org>
Cc: linux-spi@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Jun Guo <Jun.Guo@cixtech.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20251001-basics-grafting-a1a214ef65ac@spud>
 <20251001-cheesy-shucking-c55431bbcae3@spud>
 <101a83ba-cd2b-4080-aaa3-630652c33786@amd.com>
 <20251002-unloving-unrobed-b35543f729f2@spud>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20251002-unloving-unrobed-b35543f729f2@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0068.eurprd03.prod.outlook.com
 (2603:10a6:803:50::39) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV8PR12MB9262:EE_
X-MS-Office365-Filtering-Correlation-Id: b88e8e04-7ca9-4f83-7360-08de0a22e8ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M1pULzExQUtOcmp4SDgwdHZKZnNkS0Q0V0NoK2ttNHVhYlFldG5sWERIZUkx?=
 =?utf-8?B?eERzNU9xWGt6U0dHY0t0ZEZzWXRReUM5c0JJbUNxMFdmYzk2VHFaTDNFQnFq?=
 =?utf-8?B?Vy9qa0NTSHk1aDh2WC9wVDl2Q1JCSHNPa0lNRTlVSE45WlpucS9UVE5PWkNu?=
 =?utf-8?B?Y2VJamZEL3d1WVVSV2JncEcxT1p2Q2lsRFA4MG9EQ3NuaE1rZndMRFdZd2tN?=
 =?utf-8?B?cnNTZlFLR0VBNTh6b3FyTjJ2dzZlVFNMK3JYS2lsR2ltcHJrdUI1RGVHL1cx?=
 =?utf-8?B?ZGovVy9YdUsrZWRHYWxGclpQcFJyOVZyc2RUUnR3SDdtcmFreE9xUFh0TE1y?=
 =?utf-8?B?R0MrTXNaWVFXcGlmanJRVGdvdlc0OFg2d2VYcTVteUJESDhlOWhXM1p0TDZN?=
 =?utf-8?B?TDJYeVk1dm5hOC9TcWg5YjVoZG42ZWZhaGx4ZllHV2hBQ0ZyZWU1SmVWa1hl?=
 =?utf-8?B?ZXVnTjlYZXdMYzBnTTN4RzFhYVhkcElKdEZjbjU2N1cxYnVwcFdGYS9XN0F5?=
 =?utf-8?B?VStLUDJpZXFxYUV2S2JBcHl0Z3Q4RlNaZ3hydlNieTRYdmw3cERaQStWMHZN?=
 =?utf-8?B?ZGxFY1ora2FCdlprcUQzM2NzU3JpRE5LSFpmNE05eVlpNEw5eWp3Z0NlMSti?=
 =?utf-8?B?N1RFbG5CMDFDdWpVTUtvUmE1T2YyQWYvcFVXeUZhcXFtdjk4ZEdwZGl4aHNa?=
 =?utf-8?B?Zm1YWGVUSEJHRVVmcWZDVFJ1c3VKbUdHR3hyN21OZXR5RGM3RUFwM0FPTkJY?=
 =?utf-8?B?VFVXMnQ4RnlQK3hZQ05FMWdNUEVnaHl5SDRheXZMMUs0S0xBRHFEZnViZ2ZK?=
 =?utf-8?B?UlliN2xvbTJiTk5zTDJjSEVTZkNXTjZ4dXcwQVRVZE5XYkFyRVdQK3JGdXIw?=
 =?utf-8?B?UXBRMnBGd3A3Q1VPeHNUUGR4OGVEWHNaWVZ4MTVzeUFtSCtMdzhLZkswc0NQ?=
 =?utf-8?B?ejQ4bWhyUlBxT2t1NlcrQVdWdUFCNmJTVVpJNncyVTJ2RGJuNzJOeGxVRktK?=
 =?utf-8?B?MEtvUjZVMElHVXRVWkpybEFuYUxJcVVGMmNTblJadkl0OGxMV1F5cnVsMUI3?=
 =?utf-8?B?ckQrQWhQWmt3OXltbkNVa1ZwTndMYnBlK3RzcW54SDR3eVZNRmhDa2ZhMVlJ?=
 =?utf-8?B?NUN2ak5ReW8vSG1GdzM5SkpIR2poeWpQRytERVUycGlGVUFSTElkR0JzOTZF?=
 =?utf-8?B?YXpGcEExNUQ5NDNkaGhyb0hRdS9CYXVTR2Z3K0pBTjh4RDFiaVUwSi9FVmgv?=
 =?utf-8?B?a0dQZStZR3NOQ0dxZEVYaGlXSlBCdm8wVVk0S0N4Skh4SHQ0M3RyVDE0Rkxo?=
 =?utf-8?B?Y1h1dEM2MHNrT2JQc0NQSktSYVdGU1h5bWMzT2FPM1gyUjBPcHo2c2ZrQjB1?=
 =?utf-8?B?NERBRjVEaFlyMDIvd0p5OFVkVWFZK29rUUdEaHpEYjF0STJEQjhEMWZYNXAz?=
 =?utf-8?B?UldEUWViVkVQTlVORkxMb0U2dTgwWllJNXZET1BXSStzcHdncWkrZ1dZdFM2?=
 =?utf-8?B?ZnZCVytBc2pkdHNHZ0MrTDBzNHIzREE2TnN2OTRxY0FjcWszdk56bU5IM21Z?=
 =?utf-8?B?d21xVDNZWkhoM0ZiWGY5SEZXMkppd1lINk5LKzZWc1dVNEdLR1R2Mll6dFJn?=
 =?utf-8?B?VTFZQmZLdnRpQmEreHlDQ255OWhjODNCN3pRdE11bmkvb3ZteHBubXQvNUZ1?=
 =?utf-8?B?MjkzbDVhcFhnZ1FiV1A0dWVQcE1YS1A1M2h6WW1NSFlyano3WmRrOXZ3RnQy?=
 =?utf-8?B?WVVBUlcrT3pTQ1ZaY2ZJRlA4b3hMYjZoMERQTzJ5Q3o3Q2xUZytVVEJ6VU5X?=
 =?utf-8?B?Sm5kVFVrUy8wSVI0bHQ2NjNrRkJjc2VyYklGMCtPYk5YTG5HWG1tWGd5Mm5t?=
 =?utf-8?B?Z2lNMHVFM203NWRrak1acDdzWWFtTXRBVEhpWEFBSGhxZnUxRFdmUEx5OW1G?=
 =?utf-8?Q?9mHoKzWWV3gQcsS2AFrtBBNLvcsRq7SS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVFEOG1FTVJjdFppRjhvL2xOeGQzQUtaRTViZ2VDVlRyTDc4cnRKWGVLMXhY?=
 =?utf-8?B?UmI3QWE1KzZ0cXdiMVg2dW1WQnp2QTlTZ3VaZUxSWG1PODN4WVI1dGh0YWZD?=
 =?utf-8?B?VzZQVEs2ZXhtRW80dTEzSUJSVUU4aGV1UzdydmFvZEJhV2kybm5OcFpycS9J?=
 =?utf-8?B?bkdZY2lpWHZFbTNzY0xPVE4wbTNlRHg3bjB0TjlKOTNkUzc4RGtkUjVuRmlR?=
 =?utf-8?B?QmpNZnhVTXlkVmp0THhaRzB3bWMrZlRuRTJzTTF6Qkc5UDU1NCtYWlF0d2Jh?=
 =?utf-8?B?V3gwaThyenF5Yk1CVTV5U1Iwa04wbGxmbmpoUTA5aXJmS0ZkMDdVVzFURGlr?=
 =?utf-8?B?dzRXVFRtYTNaaFdyRHBSVjVNSmFSL2xEMTN2YUVNTG9tdG9DdWVmVjBpa3JP?=
 =?utf-8?B?VWVFcW5ybTZveGFCVG52NVZmWHk0ZHlDV0NLUVFNSmM1M042NWRUOW42TkJW?=
 =?utf-8?B?YWVxTVFoUGlVdmRRYWZGcDNFVS9rODA1YmovMUtSaGtvRExodkhkVUlCbFpk?=
 =?utf-8?B?akdRTkFsbUdaRjRTYXljNytHZTMrVkxhdGxmSi9DektCR3JFeWtuUU4wNHcx?=
 =?utf-8?B?dGd5elZUV1ZnZzk3cGd5RjZSRWcxYUdNUmd5MFRWbGgvZjVXMVZKNzhlWHRC?=
 =?utf-8?B?YUFPaEk2QTVhNmorQ1RWZUdsQ3dxZUlhd2VhbU41N1Uyb2wzbTd4OURGUEJr?=
 =?utf-8?B?Ty9tSFFoVGFLdVBjdmRiL0dMS1Uvemo2UWVJSGdoc0ZFWFE5dWJBckdWWVBq?=
 =?utf-8?B?L2xVQjcwUDkySExBWGtaWFp1UWJ0RUJlbTZTWWtOQ0pZV2ZKbGFVOEdzUmZC?=
 =?utf-8?B?M1I2QWtTYW5veS9BalZiY05ISytXYkZCRWkwdU5rdW1uSGIzL09pb2xNaWtH?=
 =?utf-8?B?cnNRYlVpYTFGT2hDRmI3cjlhakRxWkpoejBWWVcydXdrN1BsV3dmRnMrbUZ6?=
 =?utf-8?B?SkxHUWFBUEd2ZWtQY2VNSVIyU25kcHRkQzh6bVY2Z0xIM0pxbjVDOUE5bDhY?=
 =?utf-8?B?SHZzcFFnbnJwMHRKekw5TnduRHNtaFNmbko1NlY5RGsveStNdlBOb3NndnZY?=
 =?utf-8?B?REdNSlV6OXg5MjBzcnU0ZHlMNGI0MXNBclRndkFBSXgvWjJMYnNQK0pOWkdk?=
 =?utf-8?B?ZFhvQWU3SXBwUWtsN3NHallXQzc5SllUT3BjZzI4Z0EwVTA5bnhkVWJaeGdP?=
 =?utf-8?B?d2kxSDgwY29ackNGSERIOExGazlUUlZ0OWxXOEE2U04yT1RkR3BkMmlsa2tl?=
 =?utf-8?B?YmNkTWl6R0ZlbmYrY2dTWitNSXdoN2hPNWc3MUZ5L2wrNDdPQzRvNFh3ZDNC?=
 =?utf-8?B?aUR1U2dpQ3VwOVluSGZldms1dWwzVU5kOUJGbTBEaUFGdTJ1WUlNcUlIUXpr?=
 =?utf-8?B?NWI4NVhraEVLSXhQaGJDbVRHa0lVUS9oakpFWENHU2YrWk80SEIycjM1S0th?=
 =?utf-8?B?U2MrTU9jQ1JsQ1crQW92MDhTeHA4Z0cwMUxLTUJXelNLMmJ0UFlpR3FrTkFq?=
 =?utf-8?B?VHNNV3VSc1dBaStaYjdFTTh6T0N4ZW4rRWR5b2FqLzVEOXVHMHlncStrejgv?=
 =?utf-8?B?TkQ2T240eW8wVThqL0YyelE5M1dkejVCQnRoTUY5OHVzb2RpdldHZkZwTUk3?=
 =?utf-8?B?bjFSc3FTU2xveldsNE41Z29BVVAxN0d4am5tcG1RaWhGL3BOOFVXUHBFb3dB?=
 =?utf-8?B?ckZwM0NoZ0pBd1FmWHhHakt2eHdadGlKNDJORlFGS2U2U1dBS0dOeFBLZG1H?=
 =?utf-8?B?Y3R4QnUzRU1UTVpYVVM0N2FIeGJSd0Z6cWZEYTRudmhHbUcwSFpObVQxY2hw?=
 =?utf-8?B?M2hPbzFqeW1OaTU1MEZBTk1CcnJIUTVEOVdocENWRks5SndESDEwS0x6Q2M0?=
 =?utf-8?B?dHBKUU9DUnVFV0N2SVphQVJuSnN0STkvVHNHdWZ2VmF0cU8zdjVCY3B2SzBL?=
 =?utf-8?B?VTM4MUdVUTB0bDl1VGFQRDk1RzA0YmJIOHZkNXFLamRETXg1RlhDZGxWRmRJ?=
 =?utf-8?B?dGpxWWhOenlvbi9yeWtyaXRRZG9BWGFVZkl3c3hWcFVKTTRlR0RydHpkZ0kr?=
 =?utf-8?B?SXRmd3dEbVV3SEtFNUlHM1BlMXREdDZyVHlSdUhybzdJbi9ESmNHZ05oeDFu?=
 =?utf-8?Q?WohE1jBNO5Rgn1jxQYqP79BlA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b88e8e04-7ca9-4f83-7360-08de0a22e8ad
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 06:36:58.5397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S6hF1rrjud+NQ+3FQ7Tk4iYYQoF2u8u5iLXjcTK/P2T4VgP5TaemA0sgKJUEinGI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9262



On 10/2/25 11:44, Conor Dooley wrote:
> On Thu, Oct 02, 2025 at 08:06:47AM +0200, Michal Simek wrote:
>> On 10/1/25 20:31, Conor Dooley wrote:
>>>    arch/arm64/boot/dts/xilinx/versal-net.dtsi | 4 ++--
>>>    arch/arm64/boot/dts/xilinx/zynqmp.dtsi     | 4 ++--
>>
>> Acked-by: Michal Simek <michal.simek@amd.com>
>>
>> Do you expect to go via SPI tree or via SOC tree?
> 
> Via SOC would be preferred, there's no functional change and I don't
> think the dtbs_check warnings are worth doing something abnormal, as
> long as what's in linux-next is clean.

2/2 applied to Xilinx SOC tree.

Thanks,
Michal

