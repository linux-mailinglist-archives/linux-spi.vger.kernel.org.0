Return-Path: <linux-spi+bounces-6450-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B5BA1B250
	for <lists+linux-spi@lfdr.de>; Fri, 24 Jan 2025 10:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697E0188EEA3
	for <lists+linux-spi@lfdr.de>; Fri, 24 Jan 2025 09:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2086219A94;
	Fri, 24 Jan 2025 09:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R31nnBBO"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B5B205AD8;
	Fri, 24 Jan 2025 09:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737709581; cv=fail; b=Bm6PvxlBsXvrqCll6Z4JebP9LbAtLXB19tTzE5nce/tzRS2voazKicqXDuCpX8XIQtAFM3xQwvyF26hYO3GQ0Xo5G+wia3MxbwM93FDdNB7yIDw4qqMhDlMzSRonu3NAs4HzZXG3JY0pQWDqtmEJEB5cvGMp3zPbD+EvebxGxLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737709581; c=relaxed/simple;
	bh=5oZgjT45Mg+nyRFH7s4uc76UeZhntk9XcdFYQdsESmk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UHUeVtedRJdZr4KwkEy0f0NEKwj4WCHkJbbWFSX4sCjo7z2RPBf1SApzAPNT2kYc8seCqyUE4ZJpZOKXSNeFemWgZ9cbqgkRRYOqFXI7mpfx/UF4g/GNVPJXAx/EXfexNNRtTC4IC4pzZoXUpfonsPC8XkjICo+UYVv2okhGll4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R31nnBBO; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSZ/OzBCzedeXCI4V0/BuECXa5bb/fij4uPetqE348OVuaRMP8aJ7GBNoJXcjvFoL6eg/TkBBkkKKvp1/uG0KCVhxIVqKjTO0Gl+xx/9TtfhxYbQHfTj0AcdtA3/gmXket9JGcamtJHh0lk/JFPe50z8CVhcb0ttXyU1BREau7ANT+t7Sem75+on3nIAfIpQaoinJF2hA8PkNBjc2qldb5PPcOnfM/NnNMKWHcOXoWQmtOsZcNICBxZCBqOO1sxENTcbDRR+vKINCjaMSR4AA57tFkP7M3EEPo0HaTp7CN/s9mBz94cwzloMVBQg9xqlx34KV4iaFzvoeKLD2glJhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WDux/RvCM9IJJxvbZxBpmuvcpu6R+Ut4ROWs6lR1xaE=;
 b=LGrvdtZveR3fNVR0RXcMREBd8iSDVepRlAX4Bpmu9s9KlBS63sU0UssAlxmglPkxW2djYWg1Iq/FQIJc53Nmobv0KvI0XmQUdAWXoNpK7vrKMykfF2bkLTlaAIwUT36X2OHaUvHdJoDCruWTkEc59LjS6wE54krO6wKqGl6x8Gd9RnzIGDH8GlnHTJDpsMFTZWofbSdVDrpo6uiUeHqS6z1O14NBo5fQBm9/ikZF2dMdQV2Uhmr9Kys50K/o0J6tsqdlPMP3ZFTt03Ge9aMSfeQb/Bk3dnyEx3UQv5tSW0yded9sh1z5KGvXumMqvUpV3KpvG6zmvW1FjetixoW+5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDux/RvCM9IJJxvbZxBpmuvcpu6R+Ut4ROWs6lR1xaE=;
 b=R31nnBBO6pKwJw+RvqS8JzmC72g4T3J994JT1sgLt2joHTMxOaZidfNqwANLk7fkAuQgYKZt45Zu+R1/J1pXrJgAA+fBt6kVaRnihcuvbsan4nycxZNeDpr8b97duz6meMV5JwHZ+6c7xPbhK3TPe5xWH4gjNFqat0Hb/qtblKs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB7691.namprd12.prod.outlook.com (2603:10b6:610:151::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Fri, 24 Jan
 2025 09:06:17 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8356.020; Fri, 24 Jan 2025
 09:06:17 +0000
Message-ID: <7fd0bd8b-f11e-474d-ba62-dff084a62656@amd.com>
Date: Fri, 24 Jan 2025 10:06:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] dt-bindings: spi: zynqmp-qspi: Add reset
To: Sean Anderson <sean.anderson@linux.dev>, Rob Herring <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jinjie Ruan <ruanjinjie@huawei.com>,
 linux-arm-kernel@lists.infradead.org,
 Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 devicetree@vger.kernel.org
References: <20250116225521.2688224-1-sean.anderson@linux.dev>
 <20250116225521.2688224-2-sean.anderson@linux.dev>
 <8a0d8789-7a0d-42b7-9aff-e867c14db3c9@amd.com>
 <b8e63009-13fb-493f-adf6-4d30adbe9b1b@linux.dev>
 <20250123224520.GA456390-robh@kernel.org>
 <34e84bd2-381b-4f3e-99e1-92f7a878ed15@linux.dev>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <34e84bd2-381b-4f3e-99e1-92f7a878ed15@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0186.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::11) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB7691:EE_
X-MS-Office365-Filtering-Correlation-Id: 22b19652-990a-481b-cc1e-08dd3c565c67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STE4YmxxZnV2ZzVqdEw5NDJlcFYzdjkwd05CRWRseFJSczJiSGY1aEFwdmcw?=
 =?utf-8?B?TUxVWXFmaVVxcGJWY1V3U25HYW15cmtabWJ3Y0ozb2xETFo3ZG5Ra3FiN2hy?=
 =?utf-8?B?dTBIdm9lMlRCcmJvWWNzYXlPSGhFd3dLWkZPZTZKVW1kcEZ2b2tlSkpFRWxs?=
 =?utf-8?B?ejhxeHBtOGxxNkxXYkJhejRFMzBqaVBjMmZxMUw5aGJLbXNhVTJwQ2Z6ckFv?=
 =?utf-8?B?VGM0eDdpTkV6cnErK0ZQUUJUcmVUNEdiNzFaanFxMXRwN3R5aG5aMGMvUGhU?=
 =?utf-8?B?TkVtTVNPS3JtWEFPQnFGZm1TRkVtcnlpaHBhcE1iN2p4c0ZDcnhYMWhnME1o?=
 =?utf-8?B?YlR0K2lHZmd0RFc0ODNQQjlPR3JuODE1YXM2aWRTYmdLT1crM3JManpodWJG?=
 =?utf-8?B?OXFMSG92YWtieU1JVE5XQ0xTVjg2MWdBSkd6dW1UaUVPV3JRY3F2dnNxTHpY?=
 =?utf-8?B?amtyaU4vbmlOWlR0bytlMmduOUs2cGhYZ2VQMGNHRFYwcXp3d3RQbWhwNzZQ?=
 =?utf-8?B?ZzEzYWxPSW1VMFlDTEZhelZUTVcycjZ5Wm1JMWxoTG5pK2pFNTBzeVorc0Nv?=
 =?utf-8?B?VXZIVlVFc2xHeGxsZ3hGMnFCQi95K1VucStPMERRa0N3K1d2VXMwS3F1MU9j?=
 =?utf-8?B?UE9CVVhUSjFvK3VNYkRMU3c3bUtzWENYa0RySmZuUXNiRnVnQUlpNVI0ZXJx?=
 =?utf-8?B?N0JmY0VLbVg3YndxaWkxcTI0ZzZGTDM5cFJoYXpWVHJzdWQ5Y0ltV0tjYUpD?=
 =?utf-8?B?UWpJRnRmQVc3ak8va1d4OGp5U0s1bVZrVXVRelV6MXkxN2V1eEo1UHoxMUti?=
 =?utf-8?B?bzV1NVZvU0hqUi9mWEYxU1A3SmJCRGxaVGF3amoxS00vVTBTQ2dBb2M1WUZL?=
 =?utf-8?B?NytjUTl2UXl0Z2lLSTVwc2VuR1V6RllyUzdEUitrNm9nZnI1YVk0aDZkNm0x?=
 =?utf-8?B?SU5HZENaa1ZsR2NCL2tlWkNlTFpxaHpGR294NC8vUTFsS2hsRFlENUpWcmhr?=
 =?utf-8?B?R3c1UUN0bU8yalRFeTBSc0ZlNjNUaHlIZXFvMGhSWlRPR2s0S0V1QWZIeE9X?=
 =?utf-8?B?YkFua21kcGZRVzZJMk9ONTNHL2FtVUs4TzVpSUFMbnVVek5QT3Y0ZkppVm1i?=
 =?utf-8?B?TEJ4enVUZDJBdjBlcjJ6ejA5RHhXUzZDa3c1MU9IYWpPTjEzNlozWkM4WXNj?=
 =?utf-8?B?MnBzZEJCc1R1dktSWmE3ZnA4R1krSEZhVHU3ZWVXVXZxcERmSllZQmRlQk1x?=
 =?utf-8?B?R3UvbVNZdksxZllnZGwrWnRPWGR4bldlVUNDYVV2cmh4MG9rbmdNMG1rY093?=
 =?utf-8?B?c1R2Tm80WnFrbGtRVnhTU1Y0MVlhWEp4aDFhUFkzRDNNc2dxcERSM3ZaQjRV?=
 =?utf-8?B?M29OOHFsZ2sxVFRoMDdHdk5jellwQjRjWG14amlJeEtTd1lxWURJaGZyTG5X?=
 =?utf-8?B?d0ZGTE1kRXlXdjh6eFFNZkt0RUsraUh3MmhzNVkwKzAwT1U4ZW8wQnA3VEtj?=
 =?utf-8?B?Vnd6T1BpbHNoRmZ2cjNKOFN1TERHbitkbEdsVUVmamVuTEpZR2xzM2FkY2Uv?=
 =?utf-8?B?VjRMUjBLTlJ4ejU3aHpOUEh5dnhsdlIzR1IvUzk1SnU3VDdHdWtkTlRoMEd6?=
 =?utf-8?B?SXBUV0RnTEV1V1pMSnBKbXRNT1pzUm5jUmlscFg3Wk1sTkplNnJzaWw5TUdY?=
 =?utf-8?B?d1BZQ2pLTHk1Z2d5WllJK3RWbHBqTmx4R3F6czVYWjMvMUlhZkJmemQxVWVI?=
 =?utf-8?B?UzVTSXlYN3NTbUZnNzhkTGkvdEpoZnBuRWdzV3IwUUJFMG9xOEJ4TFZSckN2?=
 =?utf-8?B?RklPTUYzQlUxRW9hNktNL1hXSkl2L25yaXJNbnRTWTVGcTRsTG9maHA0cGhX?=
 =?utf-8?Q?h6d0L66lr/77z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZC9vcHo5cEFnbDBBNmpRckJmWDEvR0FHTzBsUjVpQnk5alNjODZWZ0dZa0tY?=
 =?utf-8?B?TnJBMjFENFEwc3JHemhyZEJmN0xFbFNYMm4xV1N2ditHMTFZZGhUaFdRY1I0?=
 =?utf-8?B?ZDAyVmVWdHdwaFFTd1ZlVkg0N0V1MkQrQ015TTh0Y01xdENsSDZNWDlwUGRj?=
 =?utf-8?B?SEcwaEY2cjM1aTNUaG9yMTYwVFFpT1JxY21LbUtZckZtWVR0cXhBbTVSZXVI?=
 =?utf-8?B?Z1VudXhiV2ZxbndhUUtVYVhzbGF3U1FHcUN1czFjWFQ0emFCQnVwalM5K3hE?=
 =?utf-8?B?eU5CQ2xUakFOdCt1eW9lM1gvMm96Y0dpVXNJaDFNK3lVUi92OTBwZWJ0QkVT?=
 =?utf-8?B?bmg2L29DbTJOL3NMRDYyb245N3Zib2hXL2FwNS90VXlKUERVM1I0UGV2VXhs?=
 =?utf-8?B?WFFBWXUrek5ENTIxQ1BYM3NmQnQ1S1ArdkZ6dFhjSzZhazBQSXF3Y1lnbXFn?=
 =?utf-8?B?RUpxYThDUjIwZ0svb3Q3b3h3N0Vac3hMTGk4cENIMjhyRFNaWDh3VUF3YW1u?=
 =?utf-8?B?S0p4SWc4YzdrRm9xVThnTTd1TDZzVDlIUkdwNElhQXFOTzNnVXZtN1dEYXdO?=
 =?utf-8?B?TDdOOFJQekViMFZiWHV2Vy95cnBLWkpXeWhPUjROR3JlUDNZRWJkTXN6RVNq?=
 =?utf-8?B?VDkyZ2VFREdtbmxTNy9aUXZNMnRFZmNQZEdKZjZwUk40bkM4aU5mVzQ0OHlY?=
 =?utf-8?B?R2NhS2xyaWo4S1VDZHJGUWg0ZGlnMEE3a0NadmppYkhtc01KRE1WazRST1VB?=
 =?utf-8?B?SUFJU2Q5Q1lQaGQyWjgwYVdXWGZpNFR1S3JXYitnSGRhYzcvYXhTQkV5VFVz?=
 =?utf-8?B?UG9COTJxUURHMkFzOEtLSnZwdW85d1VDcGxxVm16ekFsVlRMQ2FVWko4cGZK?=
 =?utf-8?B?dXFpcjdvZExDYW4rZDErSlpxOUs0eUFNNHRyUjNXVGF3bW5xNW9aRGcxVTlp?=
 =?utf-8?B?ajBDQnBPN0NLT1FrcFBnRUl4RzdkN2lzYktwdlVyNEtMSWM1YXpIQkh2WEp5?=
 =?utf-8?B?d2FvdXgwcDFJSGtpcXlxRlBNTVdCdGpsZnJXTk9NaDZ4ZVNucDdKcWN3Z1lt?=
 =?utf-8?B?VlNiampaVjZUbmJFYzl3K3ZaalpxTXUrWStPcjI1a2dVRDk2TEtPWW5zK1hk?=
 =?utf-8?B?UU5PU29kaHQzbzdOR3ZyZzc1b0I3VE1hM1hqT213YVk0U2tYSktrLzArRmFn?=
 =?utf-8?B?cGZ6RmJBYWxIdXhZc2tyUE02TXJBbjNwb1RIMGZ3ZEtWbEtGWnN4WlBDTTVD?=
 =?utf-8?B?TFJYQ3k0MXc3eDl5dmR0V2RHWksvS0tlajVZa3ZmUUo1bzVobEJzZEpHWTBh?=
 =?utf-8?B?MDN4UjJ2M2loSjZaMUs3VUNVZGlUT1d2VElmdnRybjFnblVvVXNDNHN2dG1p?=
 =?utf-8?B?TzJ6Mk5pVHl3WkxUSzdvb3U2UGVDcFQweU1aZ1BTVnp3Rk9tVHJSNjB1cXZ0?=
 =?utf-8?B?d3ZwaGtTNWJXUXRQRnhWL2hsQ0NJRzM2OFhjL1YwUlFMU2MyenpqcW4rUE93?=
 =?utf-8?B?VzBQNmdpTlVYQnZRKzBmWTNyajlueXZILzhscUpCVVRDN3g4YkNVOGRqUDhv?=
 =?utf-8?B?dmN4MEUxTzNUYVdvU05STjZWS0d4Z3NlREZSTUY3WldCc2RCYVZtL2tmWkhq?=
 =?utf-8?B?M3hPQ3hQUTl1Vlp3d1R3c0FYaW1nc2dvUnNJakFrclhtRFRkTjg5RXRhV3BJ?=
 =?utf-8?B?NFFweWVXNGgvRDJHWnNKa1VLRkFLaGdDeU1sZ2FGbHdGUUlKSU40a2NMb0lO?=
 =?utf-8?B?aEtyZFE1MUJ4VWZTcGMwWUJGN0FhZnBVSDd4WEF6REdVeGVHRW9JYUFuM0pI?=
 =?utf-8?B?Q2REM0NuL09LZGtQZVg4RGtUaThER2w4QW9tcHlTUFlsZkVybHRTVnIwZytz?=
 =?utf-8?B?MFhNOEV3Q3BiMjMzWHJXbE1qSkV4bk5ka3RrODZBQUtqNjBBWDhEb1FBT2Mx?=
 =?utf-8?B?TExtU1FrMDJpdmtRdmVLdFptWG9xT3BVRWRwc3orYThKRFIrWHUxdFBjdjNv?=
 =?utf-8?B?QVNpeFZsUDQ5eDVEd2VhTlVtamhGMEd4NDE5Nk5ZTkpFamcvQTNnRmd1cWdn?=
 =?utf-8?B?Yk56K0x1VDVDYVV1aDlYYUw1cWt4S3ltNU5LbXVUZVRxWGJSM3IvUjcwQVFM?=
 =?utf-8?Q?wficJwHXyg6u858YEoBHkb6L4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22b19652-990a-481b-cc1e-08dd3c565c67
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2025 09:06:17.2805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eGPfQQOkkOiX8UMS09vJtWCWPJMwveHHmmAlbV2IjDRxPMT+W84oxdbxrG3PO2+9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7691



On 1/23/25 23:57, Sean Anderson wrote:
> On 1/23/25 17:45, Rob Herring wrote:
>> On Fri, Jan 17, 2025 at 11:12:15AM -0500, Sean Anderson wrote:
>>> On 1/17/25 02:14, Michal Simek wrote:
>>>>
>>>>
>>>> On 1/16/25 23:55, Sean Anderson wrote:
>>>>> Add a reset to help recover from cancelled operations.
>>>>>
>>>>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
>>>>> ---
>>>>>
>>>>>    Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml | 6 ++++++
>>>>>    1 file changed, 6 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
>>>>> index 04d4d3b4916d..901e15fcce2d 100644
>>>>> --- a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
>>>>> +++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
>>>>> @@ -36,12 +36,16 @@ properties:
>>>>>      power-domains:
>>>>>        maxItems: 1
>>>>>    +  resets:
>>>>> +    maxItems: 1
>>>>> +
>>>>>    required:
>>>>>      - compatible
>>>>>      - reg
>>>>>      - interrupts
>>>>>      - clock-names
>>>>>      - clocks
>>>>> +  - resets
>>>>
>>>> In 2/5 you are calling devm_reset_control_get_optional_exclusive() that's why I expect reset is not really required property.
>>>
>>> It's optional for the driver for backwards compatibility. But for the
>>> devicetree we make it mandatory since it should be included in all new
>>> devicetrees.
>>
>> Generally, we discourage new required properties as that's an ABI
>> change. The exception is really when optional was a mistake. That's
>> arguably the case here if the h/w always has a reset.
> 
> This device has a reset on ZynqMP and Versal.
> 
> The driver still considers this property optional, so it's not an ABI break.
> But I made it required in the schema to help out the folks at AMD when they
> get around to upstreaming the Versal devicetree :)

Pretty much every IP block has hardware reset wired. It is just user decision if 
that reset is going to be handled or if low level firmware allows to handle it.

The same logic applies to clocks too.

>> Unfortunately, there's not a way to distinguish 'required' from
>> 'required for new users'.
> 
> I will add a note to the commit message about this situation.

Again even new users don't need to have an access to this feature.
Not sure what's the right way to go here but in our arm64 based chip reset is 
provided via firmware interface and I have no issue to say we are expecting 
reset property to be present but it is up to firmware implementation if a reset 
is actually happening on HW level.

Thanks,
Michal


