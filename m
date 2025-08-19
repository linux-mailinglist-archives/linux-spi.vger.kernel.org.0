Return-Path: <linux-spi+bounces-9520-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF86B2B8AF
	for <lists+linux-spi@lfdr.de>; Tue, 19 Aug 2025 07:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 277EA3BB571
	for <lists+linux-spi@lfdr.de>; Tue, 19 Aug 2025 05:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D490F20C461;
	Tue, 19 Aug 2025 05:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="pXExG7Py"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022133.outbound.protection.outlook.com [52.101.126.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB4E1D86DC;
	Tue, 19 Aug 2025 05:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755581543; cv=fail; b=Tsl6F0sUSpNs7qCw6VNHKSo7q4M9bFlY+jGD927U39ZRl0UGhI8LEfpF4cU2Wl9qCAq+ZllfsX5btz22PErfSO9t/3kJsfi3yfetpB9PNUzOcVXfwct7LKEjVsxAgeG4X+kDWQjLiXjk+j3PhSC3vyjAu8PPDm+d3mgIcdAMeqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755581543; c=relaxed/simple;
	bh=UglaPIb6fdhy+qKXNPUoC1ZgkUSkCDnlIkNLsPjx81g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kn67IW/tIGIeFS6fClldtYOFCYkLPvgeZmqH+OdwFbk4PemJjpOm24GC6gWJAVOfaYbUa0twu8uhzaAHKfI/7XU2eKrAbMbVzhyzECcXVrtByuWSSN/l1UtldyHQ84QA6JGivy3Lb/Z+3OTRNUq68GsjTlFS/7Buknser+kmxYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=pXExG7Py; arc=fail smtp.client-ip=52.101.126.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFhLD4iQse4ej1+Ve74VPzP7t0FxPfGe3JHPKtI6HpYZRbjQlfbF/wsjRS/skPY5rj6YGDhjEHi9Z2gFtJp515UYJuKjEs93wy4/laAxhot/rJE6OIhtAks/l6cwH+C8gve1sdVJyZrpbopHvz+ZIjlZ9VFVR6TW7t9I/uZ4RmYdWECmqqEF6h4m0MnZKh/xQ4CJVrYvfvUzN0xwrUjkWbnbqp49zHHlX+lkhOtCbw3/023uMENjA0LwgAe21QeYG5q7c8gvIxRy2AHO3/Zkr49kYwZqo/BwVhkh1z8DDtoc8TsCm834Ji7EKejdzwjYjNxc+YI9LGqAEXOHn7d/Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/c/WRek7Zi62AKqRnvGvXVH1MnkdcIXxh1qXWWRbWG4=;
 b=yPjj0ALrEnGbd6PKxGGaqzL1IJ0Wwpbp0XQX3NiLqJj6LQMd/BMEALJvw1jOgYrqnub6hROYkIpd/LZpoRXANHSsNzwu0fh2lDI3Bm7hCI1gFFEIwQbVH6dl9jcQ9Me9XU/eAmOJJBt27VcNEhSVhotQ3yPHtOUfILm4CtmroU8caUxHII62mFmmjOnmW0Wvn2HqEGBKxH7EksIK0nfSirmMegk3TQk9KLf+5vHZ8tlXNhS11Tm1kPeBM7uRJR49ub37LilZuAo0P52A+krQECV+xO2T3RhBtNRo72VyFwe5+Fo3zEDbuUVcMkPEQEhjMH7fBE/1dF6aIfEhE1JWbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/c/WRek7Zi62AKqRnvGvXVH1MnkdcIXxh1qXWWRbWG4=;
 b=pXExG7Pygfx/tTnfBrz3JgMJ2vbcgpHO1HgV/rwvPrQE6CGAmpe/qycCSUYeeMCwqXDRuUuU0FWbvNxbccqUmk91K6DK5+tO1UJvCDZIOMNw3TtaC1raf4utm+Ddq5UOimL7DeZ1N243/53wuslb/pixDjeglMLIukaRPap80LRnXmLNoYNCJUCX0viasAoeR0HFAmRxG/xf7klGHgHJzuaUlj6l54k/C+yC+zDMNbqt4M5AzrejUNE88LKCiUsmjFkhL3ptiHa8jv+mHdzO+nJ2VDDVBBsxBrLGGbYAhpLQ8qaYcZWXUsvHraNgRuYuJxj8lGCrOaSB3DERPx4qfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by KL1PR03MB8286.apcprd03.prod.outlook.com (2603:1096:820:108::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 05:32:18 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%4]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 05:32:17 +0000
Message-ID: <76a1f892-2fc8-4ff9-b466-9961d629fa22@amlogic.com>
Date: Tue, 19 Aug 2025 13:32:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] spi: dt-bindings: add doc for Amlogic A113L2 SFC
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liang Yang <liang.yang@amlogic.com>,
 Feng Chen <feng.chen@amlogic.com>, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org
References: <20250808-spifc-v1-0-ff4e30e26a6b@amlogic.com>
 <20250808-spifc-v1-1-ff4e30e26a6b@amlogic.com>
 <20250808-adamant-fat-raven-38c8b3@kuoka>
 <7fab19de-8ed1-4fe5-b2a4-a7e9c13d8424@amlogic.com>
 <5cc336bc-f071-41d2-b59a-af0df23af00b@kernel.org>
 <d872a711-7442-4e2e-bc59-0d6f4f656fde@amlogic.com>
 <017a4d15-286d-4e0a-89ff-f658009a6de6@kernel.org>
 <cf825229-7294-4fc5-b7dd-09dc1198db74@amlogic.com>
 <d8248069-c12e-4f72-a625-c4f68aa42f1f@kernel.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <d8248069-c12e-4f72-a625-c4f68aa42f1f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|KL1PR03MB8286:EE_
X-MS-Office365-Filtering-Correlation-Id: af3d8f25-f58a-48fc-7687-08dddee1c2ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDFVU29hOWZRQUV5NXVwYXpWSlJzeENzWHhDM1I3SnBWbFI1aUEza1F1bCtl?=
 =?utf-8?B?NUpwZFJwbUdDcjJZV1NCU1VFSFkyZGpTZ0dRT05nekZkQ0dRSithM0pPS2ZR?=
 =?utf-8?B?TlFDM1lFK0pNemJ2WkxvWFFRY3pDVlRZdXJlT1FaSjJUS2RQMXo2eVRsWHRq?=
 =?utf-8?B?MGtRV29GVHMwUTBUZ0JWUmpzenJHTUhWL0lFU3NTa09ndVdVVHFFdTUrSHJW?=
 =?utf-8?B?VG1lRmpIRmxHcjIxcS9BSEJOMk9VZXR6MkZVamhoYjFFeGN6VmVUQ2EzWDVH?=
 =?utf-8?B?Z1F0aTBWQkQyYXYycE1aMld1M0ZTdWw2VE13WmZFdlJYTUlvdkxobVBGaWN6?=
 =?utf-8?B?cEo5dHRlc2h6SmdEbFFsMGJ3ck5Nc1B0OHkzOHgrRGhLYU9Qek1LcFNuNC9a?=
 =?utf-8?B?NGRvLy9LV0dXTEcyOStnK25RTnRvRUkwbDgwb2I4UWxsS2Urc3dqVkZ5SHFW?=
 =?utf-8?B?R21TRy84eEU3ZmdmQ0JxUXc5QVVIalN5SEl5Y2hzRXBWNGJicDJXdDdQbXZJ?=
 =?utf-8?B?c3lHUnFmazdLVDlXT0lCc09UM1JycjZxbm1HaGtOMVpEVkNONFNqbjlXbmlD?=
 =?utf-8?B?aUpCMXJVNnpGdnpGNSs1b0JYbk5qNWtnOVRUYUFvVWo5eU1VY1hod29RSE1i?=
 =?utf-8?B?U3RmL056eTN5NUNlTDhsUTRaZzBTYUY5TVlnNWVZUk1RdVdzY1k2SzVHeS9p?=
 =?utf-8?B?RjNEaTZFU2J2N3V6ZHNkN0pPcngzNW1EM3Nua1RyUUswUXpOUTlFWWIrNnVL?=
 =?utf-8?B?L0FqSW13SU85ZXVVUk5tUnhNQ01JZFREQkFhQXlqV0I0M0FEV28vZ3ZuK2l1?=
 =?utf-8?B?OE9OU3lqRXJoTWpWaE8zdm1lT01CSkJLbjJ6SUx0WEdoOUZUYmtjZmNtN1po?=
 =?utf-8?B?alRJb2hnVzUyNjlldllEeUs1cnE3YUlRYW1NSW1DR2V1MDNabk5QOGh3T1hE?=
 =?utf-8?B?T0tvRCthT3dRRDVSbTJtVStpMlI0SmVsYWtXcXhZNnlVaUpRdkZ1U3FFcll5?=
 =?utf-8?B?aFVuNFdsSzE0L2dIaEZHa2ZNRUI4YVk3OXpQN3MwZDVveE41S2xQK0NoZnJj?=
 =?utf-8?B?Ry9SOWYrWW81Si9UaDg3QVlZSExOKzB1dXpQMld4VDBOeDBkY0dFbGozdEVJ?=
 =?utf-8?B?Z3U5cEQ4YnhJTzhRR29IWnJPdmV6V0d1RngxK2pvTWNhNTJQMXllRExDRlgy?=
 =?utf-8?B?WEg0ZERPZVh2eTROdzlRSnRsaVM1bC9Vd25VbDNxeFdqbTRoWHFuQWNJWGdP?=
 =?utf-8?B?dy9aNHJydXVjbGhBaXY3MmhBMHIxaHNtT25ub1QyMjdMaFlXM3NRSEFaanJ1?=
 =?utf-8?B?YzZCYWJ2bVByaXhIQnUzdVg0K3Y2anYvcXh5RGZ4WUVycUJmeE1lVnBpTmlN?=
 =?utf-8?B?aHFhWktVTmE4dnpocStsNkxiZ0RxZ0F4UmVTS0VOSU50TEJ0MDk3RCt1WHpD?=
 =?utf-8?B?VGFFMTh0eXVJT3pveTRGZlVwc0JUVWZRZGtKdGpqV2dxRjN3cElEWVdTREtq?=
 =?utf-8?B?YkY2TXRnQ1dVWGxOU2NtS0txWGpLSlVLRDZKN0tHb051MzlCTDhzTzl5T3lV?=
 =?utf-8?B?MDdBSDRJbFhMUEdhZy9EOVcwdHh5bEFxemdiODhtVjBDYmswam1RZVNNR0tj?=
 =?utf-8?B?Ny9Vc28yMXBGOHdrZ2VyYWhJSDUyODJRRWlWOXV4dmtOcTAvTUNrMW1RUmVm?=
 =?utf-8?B?Vjl2K2llakx1ZlFISVNaZlZQZ2NkVjFwZnhOU1JlbnVpNUVrWVB2RkRwSmRF?=
 =?utf-8?B?S0hNaU9VL0l4VlptK1l1Qk03eHVzdzFkRlZPRDNQWUZ6ZGlMVEJZY1I5YVlY?=
 =?utf-8?B?eW0zTHo1UjdVWmxHTkVldHl3R1l1N2QwdndJSE94aHA2OFRSRmRzZ3oxNXRa?=
 =?utf-8?B?SXMyWm5jZkxpYy8wa0VUdkZ4aDNvdWtXalpEZzh6K3JxVXVzcGZFdzh1UzdE?=
 =?utf-8?Q?tZkq+BKV7qI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1RTRTNJOVZhanFQOUlrQmlweEFPcHkzNkZrUDVUVjIraXcySzVpbk5iZXQw?=
 =?utf-8?B?OHFqM2Z4NzdtYTU4ODJpdzZWWWcxRDB5WFd6Wkd0MS9xdk5hcE1ZVVR6blJk?=
 =?utf-8?B?RmZISld4UTE0eW9oMzdsdTBZSFJlcXZLamVSOUJNdWNiK0gvR1RoUjFyS0t1?=
 =?utf-8?B?V2ZnR1NLRW9DSGlBd214aGxhVk1WeDFZS0hCVUV2SzF0Zm42cXMrcjR2eU9Z?=
 =?utf-8?B?amlwKzV4MXhUa0FtaWUzN3B3ZDQrWUpBQUxGTXJXdWVCdkJrNVJKcndxOTNk?=
 =?utf-8?B?ZSt0dWszdHRaM1lPemdta0tHRkhLRDMzaTNET1lNVHkxYWFHS2MrdzMva2tU?=
 =?utf-8?B?Yk85YjZNN3NScWRTT1ByejJHNWRCdmJzSkppZ2xndGpnTlZiK3NvRFNhOG5k?=
 =?utf-8?B?TXhhVENvR0lYdks3UWtrVEF3eFBqVU1pU056OEplMG5UamwwYXBPZ2xiYXlz?=
 =?utf-8?B?MlB5cnljNFp6VEthajI1M2RNSlhGUzdTc3ZIMkRKR2pIQlhzOS8xSlRhUDEr?=
 =?utf-8?B?MlphSUJxb0hCRWNaL0YxL3AxR3MzclRHYzI0RU0xYWVWcng2Y3lCcEYzbnN5?=
 =?utf-8?B?c0ptMlBTSEdJNFc3eTd3SVA3UWlISUhqT21CN3VPL2F2MTdwSDcwYTNZZy9M?=
 =?utf-8?B?Z2VjeGE0M0lhYXppS0V2Y09PY3phNmhuV3MxSnNqNmhDajBEakZ2QzJSUk56?=
 =?utf-8?B?MkR3dDlIQ3pKUlhNQzJwOVJKUmREQnZ4RzZMK2NqYjNGS0wxRUR2ajVsSmw5?=
 =?utf-8?B?bHRtOEUwejBGSmxucE8zR2VVcnFPckxISjloMi9BUmJuTTFRdytuSXN1RG5G?=
 =?utf-8?B?R2dyWExxV3FmMjBEY24xbW1Bbm82amIvSG1scm5NQ01IVzhaNCtjUXNSNXlz?=
 =?utf-8?B?cGhSVHRIUDJjek5XOHFoOTZjcDh3eVRCdTU1czlYblUreFgrRkxZcDVYeDVz?=
 =?utf-8?B?LzhOZGYrNDFkc2UxZlB6RGpsZTRGdU11SVdVL0pyNkdLNndBSEVOMktRTUoz?=
 =?utf-8?B?VUQrSE1maytVMndNMFNqcjMxeCt3VStPam9HdXBUYSt3dXFMVFloMDlub3hI?=
 =?utf-8?B?TTJYcEl2ZGJwK3E4VGtCbTBjUGliazljdm5FUVVnNUxmcnZSQmJsNFd2Qnds?=
 =?utf-8?B?UWNZWEtHT0lraXpleFhwMGJBT2lPY1JSSjZTZW1ncDdtbW5FRmN0SGs3Uzg1?=
 =?utf-8?B?V2p3T2RiTUh5OUJtTmtqdHdZVmNPazVpOVAyYjNKMG5PSHgvcmVTMHZRQm1y?=
 =?utf-8?B?eW1LYmFUazBIVkd2RlJVZjdGQUZtYmk3R3JoMEtNTHpSZGRNVHEzREoxdGVL?=
 =?utf-8?B?TnJPN2tTNjQzYUlUS21qbzMvanZXU0h6NXJzRkxGb0tuVEh3V2oxNTNybkFJ?=
 =?utf-8?B?TjNtK0xPREFhcXBWZkI4SUJSc3JtNkhaUWY5U2pQUGRPQ20vOVRQSTFnM29C?=
 =?utf-8?B?MFczMzZoMFpmY2JtT3BvNjlUVS9rWEFpVkNyVVZvV3dCc0RlRWRDUDNkVlJ4?=
 =?utf-8?B?WW9rUW8xSm0zdmpOWlJFWldQdHdFL2ppQkNySUI4d0JJMVY4N3V2NTE1Q09s?=
 =?utf-8?B?ZmFpdGNjU1lHRW5qSzBxUzZJQkhiSmlxNzhtd3MzRnM1TlVtM1dZT2ExM2xY?=
 =?utf-8?B?eUU0ZDFBRGs1dWZJZkdTNlMvcms0ODhBWEs4T1p0N0x1OW5ibThVTm9VZktm?=
 =?utf-8?B?Z2RFdWZyVFBsUlV1S01hQVdpbGNQOUVhMmVxVXo0NU1hL3grQWd3N2VUeUt3?=
 =?utf-8?B?VFhmQlM0SUZRZGMzRWdVWm1PK3pJS3BDS210SVMrdzNCaWJuWHZQV2N0NExa?=
 =?utf-8?B?VGlvanRxRVkvR1MzbGRvWFd0b3o1VEhoMVdiOEtnQXZQV3V2MlIybTIrRUF2?=
 =?utf-8?B?SzFWUGVkSmtHYndCYlRXYjEyYUhncVJzQzhmemZGRmowTUlReDZjbDd4cG11?=
 =?utf-8?B?WVc2QTVRYlpjT2pydCtCR1J2ajAvU05pWE9tUmpuTXVNL2pkNXc1UHRvZUFy?=
 =?utf-8?B?MHdZRlNpSXNpd2hwT0cvYW94OUY1eHJqbGFBSUwwN0NTRUVtYVlFQUdlK1c0?=
 =?utf-8?B?K3VxTFZIRHRSMUcxaHRkQjFzbDlEUjhQMUt1YkUrdk14bzRhMlpKNDlXNXFx?=
 =?utf-8?B?UmF6WjgxUk9SYVRzbTV3d3BDT1REdmVrQ1ZQNTFRYmdJQ1JDS0N3OTBhMnkz?=
 =?utf-8?B?RFE9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af3d8f25-f58a-48fc-7687-08dddee1c2ba
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 05:32:17.4123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GSpKaIMQ4keKFOkFPXLjOVIIPO3WQ7wTYCdU/kpOOh4WYf5CweBgNfRXtdZcx7gJN9V6vPouxxEsel4gIZSndyzlsUZTPrjK3BuISNQcFY0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8286

Hi Krzysztof,
    Thanks for your reply.

On 2025/8/17 15:20, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 14/08/2025 08:38, Xianwei Zhao wrote:
>> Hi Krzysztof,
>>      Thanks for your reply.
>>
>> On 2025/8/14 00:19, Krzysztof Kozlowski wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> On 13/08/2025 11:34, Xianwei Zhao wrote:
>>>> Hi Krzysztof,
>>>>       Thanks  for your reply.
>>>>
>>>> On 2025/8/13 15:36, Krzysztof Kozlowski wrote:
>>>>> [ EXTERNAL EMAIL ]
>>>>>
>>>>> On 13/08/2025 08:13, Xianwei Zhao wrote:
>>>>>>>> +allOf:
>>>>>>>> +  - $ref: /schemas/spi/spi-controller.yaml#
>>>>>>>> +
>>>>>>>> +properties:
>>>>>>>> +  compatible:
>>>>>>>> +    const: amlogic,a4-spifc
>>>>>>>> +
>>>>>>>> +  reg:
>>>>>>>> +    items:
>>>>>>>> +      - description: core registers
>>>>>>>> +      - description: parent clk control registers
>>>>>>>
>>>>>>> Why are you poking to parent node or to clock registers? This looks like
>>>>>>> mixing up device address spaces.
>>>>>>>
>>>>>>
>>>>>> The SPIFC bus clock multiplexes EMMC modules, so the corresponding
>>>>>> frequency division register is also in EMMC module. The SPIFC and the
>>>>>> EMMC modules cannot be used simultaneously.
>>>>>
>>>>> Then obviously you cannot put here EMMC or parent registers.
>>>>>
>>>>> It looks really like you miss proper hardware representation.
>>>>>
>>>>
>>>> It does seem a bit unusual. However, in our hardware design, EMMC and
>>>> SFC modules are integrated, and they share common resources such as the
>>>> clock and I/O pins .They are mutually exclusive.
>>>>
>>>
>>> How did you express it in DT? This looks similar to serial engines and
>>> such are not implemented independently.
>>>
>>
>> The hardware design provides this clock for both modules — EMMC and
>> SPIFC. A control bit (bit 31: Cfg_NAND, where 0 = Port C only, 1 = NAND)
>> is used to determine which module uses the clock.
>>
>> It's not that NAND is using EMMC’s resources; rather, the configuration
>> register controlling this selection is located within the EMMC module,
>> which makes the setup appear somewhat unusual.
> 
> No, how did you express in DT that they are mutually exclusive?
> 

I will remove this part of the register description. The clock 
implementation will be placed in the common module. The SFC is only used 
as a consumer for the clock.

>>
>> In the device tree (DT), I'll just refer directly to the clock frequency
>> division control register.
> 
> This does not solve the exclusive usage...
> 
> 
> Best regards,
> Krzysztof

