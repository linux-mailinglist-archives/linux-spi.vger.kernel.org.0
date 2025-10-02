Return-Path: <linux-spi+bounces-10423-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74424BB2938
	for <lists+linux-spi@lfdr.de>; Thu, 02 Oct 2025 08:05:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AB1A3B98E7
	for <lists+linux-spi@lfdr.de>; Thu,  2 Oct 2025 06:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C9F246795;
	Thu,  2 Oct 2025 06:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w8GCR+6o"
X-Original-To: linux-spi@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012041.outbound.protection.outlook.com [52.101.43.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB11632;
	Thu,  2 Oct 2025 06:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759385142; cv=fail; b=Z3ujJvu/a1vKkQCTjsjTWsDS61fzwKmxE+nKE8ls3oN8oSS0GtMq3dMwLTTHQXw1UUORcTB8dbk66aBJCMPKOvDJBEv4hlnJ2NL2qq9ZDUHoUz1LtBwxoTaog1Q0BvmU4QyMTQQFPLzC09UPd5kiXDzN+A68Oc3fE3xeLmbgxdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759385142; c=relaxed/simple;
	bh=nLjkKYUcwHvJsDwojhBnT//98dBK7nKsw+dOcW9dDak=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GLPd2iM/1RsDDuzONtF6800KDzllwMiuDhDiBNGweR7YeproBTI+POEVjTfqxlnyLyvQtraTtv2c2kMqnjkI0t/dMz9M1902juOFrQOz2PycVo8ArSZJT4JIMuOJeN4VQKJ4tMAsTb0HMpS0bkk+fZFMGUN9qcsJz4n1I5wULzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w8GCR+6o; arc=fail smtp.client-ip=52.101.43.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mofdqhrk7JJFEQXNniEeN+Bp4uRicKcw9XZQNjiFI7YUUGpdXjPCDeL78fG7GdchN7PSAbHPR37ZGCXs8219gaEPhRh4m2IfOU7FPa9G1cITbJMRLta7kEdeajTQNiOLKxX5OO3epnlrs9yC6X2U5o2e5t53L89GPopcWrD33cFX+79253yMyaL6Q5z9l1KFe7L/INAHbKOPF2rY0vmKeY4YSMLJMOPueoIcbMJ9mnqGBAefZO04qyGGNdA8oDfOBmZ8VbIvHstd3zF4+hyxeZ+BuO7kI9bRL1pwspDsT6I2o9Em253KfZkQ/ch24PahYIQkGcTYv+oFFU7QbdWazg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HUrcAcrI24KJRO3q2mY8/SQpHlRnbWlh9r84/MK//E=;
 b=JmsV3tdIMxC3v0KfCF/EYi+rPAqzucId6uJUkePVum/lADg9z+dc+7h63/mQWNQVnq9qrWsel/cDNckiGPxA5au3BHZM12XYb8CijSaaZwelvWuWNfDCrn3M9i4D9GwtUFIA8ITyO8rlBerUVoOj1dP9xg9Tnc5B0xHXFv2x+qo2ACJfaCaziDYOyPcJWtROT2LNBOF+bcZ9aGgfRgsQ3dCrxyLDEs7uAoU+sIjZyVOGZnXSP8OJ0SD/wbVyUJStGGBXAAKgUjLcc970lXm2D+piRKih2ukV/e5+lE0xWSopwgN8g7H86TZjkTS+yMuhW2PJWP3FG8NH6JHQ6yKYKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HUrcAcrI24KJRO3q2mY8/SQpHlRnbWlh9r84/MK//E=;
 b=w8GCR+6ofk1LedPq6oUVkqZZ7Ovnz+ixbimg2w4IemXt9td4usY/lfTYVmpfs3vJKcGoeR+7iKvzVkCnky+Jkb0nky1joWkwRuPVH60Rf96TA9GePmeoB+uSYngTPp0A7sm9xBy3EIILTGfGUO2n9UivxOkSkuzO1ChZc2GqbPc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV8PR12MB9181.namprd12.prod.outlook.com (2603:10b6:408:18d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 06:05:38 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9160.008; Thu, 2 Oct 2025
 06:05:38 +0000
Message-ID: <1a46a515-d85a-40c5-8cd6-f4d0330fa4aa@amd.com>
Date: Thu, 2 Oct 2025 08:05:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] spi: dt-bindings: cadence: add soc-specific
 compatible strings for zynqmp and versal-net
To: Conor Dooley <conor@kernel.org>, linux-spi@vger.kernel.org
Cc: Conor Dooley <conor.dooley@microchip.com>, Jun Guo <Jun.Guo@cixtech.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20251001-basics-grafting-a1a214ef65ac@spud>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20251001-basics-grafting-a1a214ef65ac@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8P221CA0060.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::9) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV8PR12MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: 25a31dda-f628-467e-fa28-08de0179b573
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGx0OFpWWjMzOU5oTmFiNTRqcXBTYmVZc21mSmZmRTc2TXdCZGlYb3V6YnVz?=
 =?utf-8?B?bHRwZmQwYWwxVTlhL25YdFpQS0htM0RTMktNUGhzUGplVWVURC9sUXpldTVp?=
 =?utf-8?B?L0FZbTdlZzl1QXYxVjFTTjluZDhsUEZIK3Z5K085RFRpdmlja1JObDBJaUlD?=
 =?utf-8?B?ZUhPVCtSMHFEUWprY0NrTTVLSlhVU3BvbkptdnNDbytzQzIrTEREYmlMQ3Iv?=
 =?utf-8?B?UXo4MzFEM1JSQWFBRUNPSEloWUFjQjB3alFqNmtUcGphWnFlZVZRMUN4RE4w?=
 =?utf-8?B?dGdGcGVTMjBFODlad2NDSEhzV1NWMkh3c1YvUys2VWNYRkRGMWVzOFR0RlZJ?=
 =?utf-8?B?VmcyV1E5Q2pyRXEvNVBmQVBDa2VFc3JPQUhaTjB1NzBXTG5Rd1h2dzZxanF0?=
 =?utf-8?B?Zk1RanRGZGZxR0ZtYUVnSkJ2dDh0YUs1bHFrVTZaSURHUDFUWTFWWVNuTlA3?=
 =?utf-8?B?YnRoUWdUU0lCYVRJQlVEdk0rcXlvRzRlZ1J4UE5IUi85cTh6UlF5MVZmTUJx?=
 =?utf-8?B?MUpEbGY4aXpCL0J5QVFVZnVKTFVxVDBBM3J3VGpJaFRNR282bXc1K3NEVUs1?=
 =?utf-8?B?REh0dzZMSmdGT3diMlBtMU9qUmEwZmI1ZTV6VG9GSWptRHlBVVBncXNJb0lx?=
 =?utf-8?B?ZDYvSTBwMWQ0MEE2SjF4L2dSTm9Yd0F4M2NEZkxiVm8rS2pPVVVRWGlWSGxY?=
 =?utf-8?B?aXV4SGhJWXVEU0J4VGpvTUgxeUk3Z25vMXNUMlZPNjFWUkZrc0hTZmUxVWJM?=
 =?utf-8?B?RFZsS0RoSllFTHJVVXFTSWhRRnlCMFZnekx6ZFVzTzJtT1N1L0x1OE5OcTNh?=
 =?utf-8?B?Mk5mNXgvRjBEazU0MklsT2ZVbnh6NGlXZkJhUE4rSnNGQ0t1bE53bDFNVzlT?=
 =?utf-8?B?SzYvd2xvWE45N2R5UVR2bmRhUENLSk5ML3lsTEUxNGdKb2FldDYvMENWSHZj?=
 =?utf-8?B?ZU4wbk9iOFgvRzgvQTk1MTBHUVVpT0pzby9vRVN6MnNTWFRqZlJEblJnTmRv?=
 =?utf-8?B?M0dYODl1ZUpUYnludTR1b2V1M2FXVGU1VFFuQWhGMTA5OHcrT0ZmUDFXd0k4?=
 =?utf-8?B?UEliaEVBN0ZPWDFUWFNLNGVzOWdJNklXRDRiL09KM002QU43aWI2NE9YRzRL?=
 =?utf-8?B?WXFUUXlnZU5uc29xb3FTaURmakpaWmo0L29mbXNQWkRxWG9jTHFpTXBseW1z?=
 =?utf-8?B?Y2c1Z0lCOEZISXZUN2RFVTIzWUZPczZIOFI1OFltMEsrcm5tTFdjQ3M5ejVH?=
 =?utf-8?B?aGQ5U2VFczNMa1haZ0swakxvakl4M1FQcWVVeXJJRzYyMU9QMzUxbVV5dzJZ?=
 =?utf-8?B?aktBY2JxbHgwbDRFWndIbEhsbkU5bWtMTkJ0bzRYTHdvQStFbjltMS91NTlr?=
 =?utf-8?B?b2x5WVlDT2ZXYmtNSWlqVWJJYWRZemh3bzdGRkdnRTBJdUEwMVJ6WWhIbE9h?=
 =?utf-8?B?K3VvcERFeGhIVUl1N090QU9JZ2FNRmR2ZnB0aURiMEN4VWFTK1FjTWoxaHRW?=
 =?utf-8?B?QU9jbTNDbWxSVUNQMFQ3Q1kxcllFakhjeWVJU2FHSyt3cC9QVStvS0R4YzJT?=
 =?utf-8?B?UzZDa2FMc0tKNDczRGpFWFV5NExhOTc5L0tYRjFKOFQvYWpLSWhCK0xQWXZF?=
 =?utf-8?B?TER0c2JKK2RPV29DQmJKVmptWG1xVG5zbUZHcWtqRTFldlc2b3NJTXkyd1RD?=
 =?utf-8?B?OG1ELzVvWlJtNzZkQnZYalVVZHNrK3R6ZkRHMEE5WVI5czkwcCt2K044bEts?=
 =?utf-8?B?YU5XVXFCdWFEcFZEU2VscDllNU41TCtJTFcvWGFPUXZqa1R6U0ZTeS9CK3Fi?=
 =?utf-8?B?YWVXQU5YeEZ4VXNQR2MxWHRBQXhaNmdjYkpCUTdHZG1lOHBhcHRmUHZzRGxW?=
 =?utf-8?B?QzZEekg0TTRmZGRwdnYxZXh0Nis2Skpoak9DaWRPM0tPS29lcGxYOElENXU2?=
 =?utf-8?Q?WVg5sxHmD9rSmxmhX9ZULFWConP6GzsI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1IzcURHVG51dGw1Z01OK0hwSGk2c2JvVHhrZ0NUdmNFcUh6a1FJMVFMUXlU?=
 =?utf-8?B?TlBrY3BDWUN3ZDQ0b3ZGSEUwdkFiMG1DZ3YyeHR5dmZ4LzRGK3JLVVk0RFBq?=
 =?utf-8?B?NnMzaDFKNXVnbXV5ZVpRVTlab1dHb0Jab0ZXZ0Y3bkxiZ1QzdzNWRVl4Wnor?=
 =?utf-8?B?TmptWkQ1bWZObW9lUDRIRTYxbFVYcVUzSVcvcmxtTW84THJoUmpOVy9jVmta?=
 =?utf-8?B?VmJ4T2FZdDFEVVBjUlFmNkNKWWM1WGJWZzdQZEo0VTYyREpVWGFBbENqTnZQ?=
 =?utf-8?B?cjVJeUQwQVBrOTBYZ3d2eFJNOWZ3amltN0hEREdvTFR3T1VlZXpDdXg3Uzds?=
 =?utf-8?B?OG91Vk1kK2paeDBlYm9WLy9PbHJGaGludlJ1M0ZtOEUzd2RaLy9ncGVzTzNv?=
 =?utf-8?B?cGQyTHBTSDVwZk43OFhzNUZCMGZEczlJWGMwT0lmUWpKTDBCVG4zTHkvZDFY?=
 =?utf-8?B?K2RQSFJBSGhTTmhLWEU5WENWc3dYZTl3cUpBRjVJZ1RFNHlBTVRuRkhGVUUz?=
 =?utf-8?B?SWtWZ00zYllYcGdLem50Wmg1R3JaaFVYdldrNXk0WnNqRXY0WWZUVVJZMklP?=
 =?utf-8?B?K3ZjcEN2RTlWL1FWV2VQLzZIbHdzZ0hvd2NCc3JNa3RNbXJKcjFua3VsNGhS?=
 =?utf-8?B?MHVSS1g3cnBPZlQvMnFZSHZiVjhscmRvaDVDYkF0ckpwUnRCalFYa2tqZ0F0?=
 =?utf-8?B?N2I3NnpYUEtSNlk3UUNUYytLUkoyK2JGUTR1N0tJeUIvZm05Ty8yenhaWERz?=
 =?utf-8?B?T3ZCMDhJRks3MTRSaGlHdWRxM0NhV2UxMDJoa0JMOEJrTWx0R0VyaTZsbWRr?=
 =?utf-8?B?dGhCbXJ4NnBReWJqQ2hMY24rY0hNWDd0S2VENTVWdGI3T0cwMkxLK3RlUURE?=
 =?utf-8?B?MkZwUDEwN2RmTjZhbFRiS2lxb1d1cklyelIzZHdUbmZ2K25QR3VIWnRSeThN?=
 =?utf-8?B?aTgvQVlQajZtZTNYa0p5OXhZeDFxaXBCWmluNjEwMStzbGRtYzI3TThwS0Zs?=
 =?utf-8?B?TkVxVnBKWHJjMW5IejFKSnJSL0dZZDE2SnNiazAxeGg1TmZmSEpiaWpJd3lk?=
 =?utf-8?B?YXVJUmpOc0paS0Z2TGlmQmlxS3IwS00yUkJCOElKRGU0SlF3TUdWOVk0Zlhs?=
 =?utf-8?B?VUgvRzJ2Zm1keGtlMUZ2V2puaHpWbDc4d2NqcDgvVWd6ejNjdVpWN0xtYnM2?=
 =?utf-8?B?SW8yQlpoU2NOckF0UTg5RFFaR1I4SElHejJKYWVFaFcrcDNhbzNzVGp5VWYv?=
 =?utf-8?B?bXFtelZIYzliaTBmTVZSbUxRczFWdS9VOVFJWVBOREtHbVl4aThVQ08rNytt?=
 =?utf-8?B?VUxlRlVTcFk0Rk9lZERZNFJHanpWVEdYVFEyazNYWnNiNHVXenR4Q25ZSEtK?=
 =?utf-8?B?L2dyMkpIM3ZKY25kWExWL2NzUFlMWjZ1K0s4Yi96OUxFZFExU2pZaTRJb2VQ?=
 =?utf-8?B?eWg0cXNicU5xWjd6MWgvUVBraGN6UjRFdWlVYk9ndTVId3BVZjBNK2ZmQlR6?=
 =?utf-8?B?TkdvVzMwejNzeTVqV3JvQWZ0YmREdytmdmE5bWU3MlR6ZGtsY1BVL0pBTDJ5?=
 =?utf-8?B?bEpQMzBYOXB5ZU1ZTVphVkZhd0RqYVRKa1BJT3JsMnhFT2lGc2JJQXk2c3Ba?=
 =?utf-8?B?MlBMNXI3cHBXTU1TVGNqckZzUWdjTEZqNzcxUnF2NjU5QnBXRnVhODViZGJk?=
 =?utf-8?B?Qk51TitiTXd2cmRCNmJXUDIwKzJacGc1WHd6dEViZHNCeU9ZOS82OXQ5aDNR?=
 =?utf-8?B?ZHg5ck8xMFpTQ3d0U0RuMkRXK0lGbmxFTnBqRlplcWNNakhjVk1NV0xRUlUx?=
 =?utf-8?B?N3grNDhjZ1RRbmdxK3FHQitUSzJkYWpsM1A2aEJKSnJ6Vm9pRnJOR2U4emZp?=
 =?utf-8?B?S25iaXZYYjFDbGc0VkJqZHVVWVJFam5EY3JTall0VFA5L1NWbVF6R1JCdVNJ?=
 =?utf-8?B?ZDEyalo5Q0pqRU51Y0N1bjNkTjNQeW5yZXRwT29Tc3M2R2duTVRVWnF2K2k0?=
 =?utf-8?B?YTJDU0I4U3RhdU9MZVdhdGVHSGRvUExpdSsvSmdIR0xBNEtSbSs0RWF1dVN6?=
 =?utf-8?B?RTYwZ1IxanZMT0JLMTFhMlU4SnRwdzJVeWUwVEZQS21HdFRYeGhzaDIrOVY2?=
 =?utf-8?Q?CTO2Iwe129GsbUxYb+FWgoGYk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a31dda-f628-467e-fa28-08de0179b573
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 06:05:38.1758
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8E3uNurWM7RZGo8fTE7m4hdl41nlZ8xDi3K/QQRHr/LiDY4nVxkOaTVEzdl285Jy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9181



On 10/1/25 20:31, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> When the binding for the Cadence spi controller was written, a dedicated
> compatible was added for the zynq device. Later when zynqmp and
> versal-net, which also use this spi controller IP, were added they did
> not receive soc-specific compatibles. Add them now, with a fallback to
> the existing compatible for the r1p6 version of the IP so that there
> will be no functional change. Retain the r1p6 in the string, to match
> what was done for zynq.
> 
> Disallow the cdns,spi-r1p6 compatible in isolation to "encourage" people
> to actually add soc-specific compatible strings in the future.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> CC: Jun Guo <Jun.Guo@cixtech.com>
> CC: Mark Brown <broonie@kernel.org>
> CC: Rob Herring <robh@kernel.org>
> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> CC: Conor Dooley <conor+dt@kernel.org>
> CC: Michal Simek <michal.simek@amd.com>
> CC: linux-spi@vger.kernel.org
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: linux-arm-kernel@lists.infradead.org
> ---
>   .../devicetree/bindings/spi/spi-cadence.yaml          | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-cadence.yaml b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
> index 8de96abe9da1..27414b78d61d 100644
> --- a/Documentation/devicetree/bindings/spi/spi-cadence.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-cadence.yaml
> @@ -14,9 +14,14 @@ allOf:
>   
>   properties:
>     compatible:
> -    enum:
> -      - cdns,spi-r1p6
> -      - xlnx,zynq-spi-r1p6
> +    oneOf:
> +      - enum:
> +          - xlnx,zynq-spi-r1p6
> +      - items:
> +          - enum:
> +              - xlnx,zynqmp-spi-r1p6
> +              - xlnx,versal-net-spi-r1p6
> +          - const: cdns,spi-r1p6
>   
>     reg:
>       maxItems: 1

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

