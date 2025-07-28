Return-Path: <linux-spi+bounces-9195-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 137B4B132E9
	for <lists+linux-spi@lfdr.de>; Mon, 28 Jul 2025 04:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76665166781
	for <lists+linux-spi@lfdr.de>; Mon, 28 Jul 2025 02:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13101E521A;
	Mon, 28 Jul 2025 02:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="KMKZsAko"
X-Original-To: linux-spi@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023103.outbound.protection.outlook.com [40.107.44.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AB41CD1E4;
	Mon, 28 Jul 2025 02:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753668804; cv=fail; b=m/izLl3CoNEmF1vwSytT8oVEPRCD2lMS0SGDWL56FFCk+klPJeRMUbLeapZwAWnEZbz+yOqScZIp8Iy9vh+lj8HmP1h6ga90S13iFRQUlZW/iGE1/DnamJkMNyxrnZkD3ebQ0w9bR8z7xup1izeOtDNSkWrT9BmutNPkn8Z6yeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753668804; c=relaxed/simple;
	bh=Ah31C2L1EQ+axa63EMk/2jv+1c1URzqU3Vm1LWwIFNc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TdlAB+lvf28K3NI5Aw16CFC4xokifcTdAOXALnPtvZcXcoNWB7pdEc5PDXNyC9Aj9NH9Qots6+zWW7FT5Yy4IscJUK/DDo18V7laMyKhxiKMG8aHXX8R3Hus8fFPh6+EKAno5dZZDR4AG5fYSW6GVIHGyEHRHUZ/W4RaDFZj3/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=KMKZsAko; arc=fail smtp.client-ip=40.107.44.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwo6ZpCHZsZcx9x730qWMf+E/x0BZYcdNoUqNbKRxx7jf58lvf8ZKiIOOtQNe5zi2mA1tzX39WNhZpo9I8EHK0SAP36L4HoNGzmqdBfDlzb8gKOo9XoP2VFCdWhnbuJ0HXFnuhhbqfJUiguJ2X0PgPX/EzwCw3Olwc8yJMOypiI7qmp8E4BanjiZmHUGm+pkS2JhS9gJyV10eiHpjNS/ETgp7+JercnPS0aMtDL5Cljq7GrC9F800F+YIDGyIB8N9iBYErKrt0dPJIOvHnzZy7+fw2e3hkPfEZmWAdfbDPuyQvZJNVy7OBLgD+GvPV/3ubl/kraKOHjewOM+wPvCKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KTNO6bWRcO9uKNKhq2SdyEvsNywd+820W5SRgLmp8U=;
 b=nSI+6KWeam+e7hZ9yX6rJXfg6Hg5c81nz+EAx8ubaTzK2y5Kj63H966+UZ5+nDFayDItbkbnidIwbY6jEYVyZp5xFJfusMaedc284XMVe3Jy/vnxmF0DCA3NqQcicBjXQkSzgN3eCqi6IcpsPwadNoFwmc2kBQerK3dmiJoGIw4dzwAkH+fyRMyJVfb5m3pS8zYa7AQGkhrcXe19LDpHm+xntu5nDxxABSBP9uzHvtY96GfQQiqeaBO7IT7FXWjtat/b4ZMu4/0hQL0mlby+KPYoWo/HpKLs709xAAtbLOcYP0EC4Vzb47YXXh+Hmci02x7cK2R2aeYchYL743tvVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KTNO6bWRcO9uKNKhq2SdyEvsNywd+820W5SRgLmp8U=;
 b=KMKZsAkoyoHlMReb1tomS/iLfLNYY+4LX49xntLVEUFtcocF6q2HaHW9rX2iPYdfFY2XE6AruEgJe9z/1q5VZfOQjnCckmp7QodStO7bppVWebex3H5yE+Fnw+ftal3q5Z26L8hlwWGc8RCGQQtDCdhIyC2QV/3KOe6WH2cVzxpCiGtqjp41pjmvrpjCnYRv/KBOB4o7bv2uMQ8JUfgcWiKR1Jew7b+DFb+9451vwZYaI9NR/9WGeGZskvGvENeUCIewVHSPfb4Aq+tRVXsCgy6scWhgrA1LM86MpqKOIRSwVCb7bZWeuZ0988IRQhbjF5ArjJN7mplN3xaUA5CRIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from PUZPR03MB6888.apcprd03.prod.outlook.com (2603:1096:301:100::7)
 by SEZPR03MB8096.apcprd03.prod.outlook.com (2603:1096:101:17f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 02:13:17 +0000
Received: from PUZPR03MB6888.apcprd03.prod.outlook.com
 ([fe80::57d0:f9e6:1d9f:91f]) by PUZPR03MB6888.apcprd03.prod.outlook.com
 ([fe80::57d0:f9e6:1d9f:91f%6]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 02:13:16 +0000
Message-ID: <bd920227-5ec9-43dc-bbd1-03276e5edf7c@amlogic.com>
Date: Mon, 28 Jul 2025 10:13:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] spi: SPISG: Fix less than zero comparison on a u32
 variable
Content-Language: en-US
To: Colin Ian King <colin.i.king@gmail.com>, Sunny Luo
 <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>,
 linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250725171701.839927-1-colin.i.king@gmail.com>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <20250725171701.839927-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To PUZPR03MB6888.apcprd03.prod.outlook.com
 (2603:1096:301:100::7)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR03MB6888:EE_|SEZPR03MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: 22ca4177-dd88-466f-7fd6-08ddcd7c506c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3EvK2NDOHQxZ2UwVFBhdm1WL1JPeWpLOUk3bHVaeGhWZW4yQldEMXMxSkVh?=
 =?utf-8?B?UDI3eXZqNklvVE9LeWNFNCtkdElWcmFuTWtDRWhMZ1ZNQUJhS3NiQXNyU2Y2?=
 =?utf-8?B?dno5UWNVaGlvL0l5K3dLVjNZRWlXUVJwbktBZWZST3dCOHcyODZ6VFJmTlh3?=
 =?utf-8?B?akRRU0F4T2xtREswbEt3WURoU09LU2x3OU5TY2s0aVZkeGJGT0Izc2NtYXRs?=
 =?utf-8?B?WUkvT1dIQzVlMXFWa01zS3U4YmRPblJuTzZkRndQeDg4bGVJdUZxcFRlZWFp?=
 =?utf-8?B?ck5wWlZ0MVRqSzRMTjk3NUVWbkVwa0NoZEhpbTF0TFVFS1NXa1FReG9xYVRM?=
 =?utf-8?B?a2VVV05lbXJ5YlAyRjBCYk0vc1RmVjQ5a0lxS21MZXJnaVhTR0lNQXlCOGhO?=
 =?utf-8?B?THdVN3BkZTJNVzlvNUZVTHJoUTc1T1JpR3hLMTMxaTNZSGxmSTBnVVdUWmFs?=
 =?utf-8?B?bVNCWElFQS9LbDQzUmRORllta0syMVlHU3p6S0lTL1pZUDA4UnNpNmdBcHN4?=
 =?utf-8?B?TTdnME4ySVNZckFVNUYyOTY2cENldG9wM0FaR3M3emQ1WFpaK2NxSEQrazhi?=
 =?utf-8?B?T2dRWHAwUnQ5QytseSsrNEYxTkhZblFBalNCNnJXWFNCekhrMFkyWWJHWE9q?=
 =?utf-8?B?WTlYK3VCZ3l1VkRhZm1obUVCTllPSTFtV2NJWEYyU2tvSEtpTkRjRUVQbHM4?=
 =?utf-8?B?dnpKY0x1YmlwejhDWEcwTEM3TGdmTGVtYWRyQjZidGZVY0xzTytwUk1mdktC?=
 =?utf-8?B?OUJaWmhEN1BSUlZOZ1hKYXhoRzV5ZDJ3Kzk4ZjcyeGlHbXFhVHJJQTZCNnV4?=
 =?utf-8?B?QXgreVFCZGpLU0wwZGYyZzR3WHUrUGFLb3FEREpxVTVEakJkSTRLbUtPWTB1?=
 =?utf-8?B?NnNwYTlXTDFnOTByT2lNendiZnU0Ry9uRmp5ZFlBK003V0tjQkFUdStBM1BG?=
 =?utf-8?B?SHFmUmh6T2pEbWxDYk85WmQ0Rjcrdi9DTGdKTTNDK0pOdE1uN3pIaXJnVmhO?=
 =?utf-8?B?YVd6Yitpa3JSZ1ZML0dNRmVMS05HV2hhQVZZeFhBOTRXNHFMbDNsNWJxK0c0?=
 =?utf-8?B?SFBKOWNPWXBSTlhiQlpMcHE3eTVZY2lOdDFpejIwblczUGxSb0VpTjV0K21P?=
 =?utf-8?B?U0NDcGVWMFBMMmJ5TjNYandHRUJYbVBIeGU2bFg4N1c5VXp0bGNhSUg1ek9u?=
 =?utf-8?B?enI1akhoU2lRWG04V21LSnMvbVplZWtiTCtLdzNXSDNKcGdiaVF0WktuWjVC?=
 =?utf-8?B?a1I3R0dqTlhvRnZFUUQwTmVXVjE1N2tGMm5pM2QwWnF5d3VZZ1JYd1Vpb0dN?=
 =?utf-8?B?bkdPODBrcUVOK0MwQ1Q5RW5Qa2JUbTBEeDBQNVA2ZGpPeUNPTmlrK1JHNXVB?=
 =?utf-8?B?c2w5MjBRNnpqZ1RvY1hEdzRYV1VPb3JYTHBEUWJ3WUZmay9lTWVITXhLYzgv?=
 =?utf-8?B?UjE3aDlmNlUzdTArRC8ydVV0aFprRjhNN3pSL3JnRnZyQURNdGFVaEVUU3Vo?=
 =?utf-8?B?ODM2RlNtaXpTdzl2cUtObmlMdHB0SFd4T3V6c0tEM0wza1R1SWFUS2l0NjFG?=
 =?utf-8?B?N0g1cGN0TnM0VS9LSC96TmdEeS9FMytNNklobUk1cEJtWUpiWE1ldWFOald2?=
 =?utf-8?B?Z25hZ2cwbHpyU2lRbDRYcU8xT2VSSlJna3ZaK21XckU4VnBXZm4wMWdNTmxX?=
 =?utf-8?B?L1RqODhuOUQ1eTYvOURoUUVQR25SZjRSNzVjVDIzVDNiclJwbThjc2FSeE9V?=
 =?utf-8?B?eXFqWFpvbklpdzdyUE43MGYxbUZFUmN5WVJyWEx4dGh5OFFrZmsyNzllQ2V3?=
 =?utf-8?B?Qkk4QUpVei9BNFRQYllmYUUrQk81b2dldGJlUHhHWHJTeWwzTTVRUGN4b2N5?=
 =?utf-8?B?ZGRyMFU4ZUNmeFRKWXYrMjNSbHh3eFVKaVBnZzc0NzhzdDZMUWM5amt3OWZi?=
 =?utf-8?Q?hcICTaTX+vU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB6888.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cEF0aEQxT1oweE4xaWpjQmpnamJ0azdTMzZENlZoSVVxQk5nRlFNQ3pzL0o4?=
 =?utf-8?B?OEdhUTUyblF3d3AwTlMvSzdSR2NKQXJpYksvUUhiVkNBYWdKMmp1RU81RjZP?=
 =?utf-8?B?c250TXg5V1M0ei96c1NwRGZBcFRCdGtrdXQ5VFZLclFPN1Btdm4ydmJ4a1ds?=
 =?utf-8?B?bFFHSFVCdGUrT1RKRStzN0JMeSs0K1UzMlVISUpsajkwQXZnOXhkMzhGcWtn?=
 =?utf-8?B?cHRRbWM1U0lpcng4NnIxOGFYcm5CdWljNmdTZDFWU0l1NjVWbzRhd1VJMXNw?=
 =?utf-8?B?Z2ZHR1ZvejNDenB3cWZmTkl2V3ZGYVhVTDZRUjNxblp4bVBhSGFLVUVPaXZw?=
 =?utf-8?B?eGo1aGpqUitwQjVkQzczc2g5MlBPQm02VGovcmRyd0hzczQrbmRtaUF1Z21v?=
 =?utf-8?B?bmVpS0ppeUtqS043Z3k5VlgvSlFGNitFd3A2RkQ0WWtCVGJOcUxlSEJubUVi?=
 =?utf-8?B?NGdUaHBWTGluTjl1cFR6QUJvdlhaVlRsaWdpZEpTbFZ4dDVJc05tYUJvTzZy?=
 =?utf-8?B?NG9VYms1Rm1NTmFSeldsQW1idU5QQ2FGTXgvMXRna3RWb2FXcGFTQTBaMU8v?=
 =?utf-8?B?ZDd6ZS9NN1A5NkloVktmWXV6MlNkMGdzdHJiRWFoelhaN2lEbkJnWG9ZVVhZ?=
 =?utf-8?B?azJ1KzdWU1RoTWRVRUlXcnBpRHl2Vko0b2o4SkxVM3dVT1hEU1c2OTBxREd0?=
 =?utf-8?B?QVJFa3ZIcWVBakNaQ0RjbFl3SzBxaXhNdHUvMmx4VUowUmRPSVZ4cFM3NkpW?=
 =?utf-8?B?M0U3OW0ycUNGblhxZ0pwcThaTkFXOU5DUDFwT1hEL284MER5aStMU3hJQkY3?=
 =?utf-8?B?MUpIQjFUeWs1UjRzTEZpK3FiYkNBeHYxa0krc0xKN3Y4MTlrVEFpeFJjeDF1?=
 =?utf-8?B?OUNtU3Zjc3l3d0FlazZGOWlFNGtBbk0yM1d5eDVkU1h5TTV3TkRzTllaUUM0?=
 =?utf-8?B?WEdkOUNrQkM3MGQ2M1BEV3MvbnRGVVdJZXV4bFBVZHQwRlpVQk82dzhYVTBZ?=
 =?utf-8?B?ejRLanlhYklKS1lESmpTZmFJUVFpU21HR2dMWDNaaDZ4VnJ2UGc4ekxFbE9m?=
 =?utf-8?B?RnVHY0JlZnA3WTJHTHVjcjlWV3ZhQ28yYjJUV0FNM09NVE1PclNGM3FKZG82?=
 =?utf-8?B?TWRYTTRRSFNtUDBrMVcxdFVTdURMVXl5cHdQQ0U0S3djR1VtUXkyOWxjdlZ3?=
 =?utf-8?B?WnNiTUFxakoxUTlKS2V3VCtaVkUyTDU1TXV5MUFUN3cwSkh4Sk1ZRUFQWm96?=
 =?utf-8?B?dXd1YkRHcVpPRHZTS2l1cWRoNDBmcG9sS1hTZkhxZTFjeElPN1VZMXY2aStY?=
 =?utf-8?B?MDBMU2FxcnVrZUJVSzRZdkEzZ0VUQ0RQWUsvVlkxbUNYUTFrSUh1ekdTV1pl?=
 =?utf-8?B?K01LcjNyRkNyUnFvWFpjSVYvYUxYbjlZMUZZMS9yWCtmM0t1Q1kxK09wWUNU?=
 =?utf-8?B?cWJiOGxLVFZtNFh2eHpJOSsxejY5QzdhWEhITWl0SXBBQ3h4b0xBbEVleVBx?=
 =?utf-8?B?UmdrZTJrL3F0V2MxWTM5M3BPUUsrOEdLR282SE1PZVQzQ0tCd0JpMVhrWXBQ?=
 =?utf-8?B?dFN4dnJ6a0dHdk9QSjk2aUpoaTZyVU8yQWpQbEFrZjBqOHQ5UUZ6b0Jmc21S?=
 =?utf-8?B?Z2U5bWxIc1BiU1EyenNCWVE3dHJZbkxBTkxiWXU5b052QVcxbklMR0FuSmEr?=
 =?utf-8?B?RGFJcnhRc3E4Rit4bmtyUUlQRXV6UkNwZXR6VCtlUS81SFg0cS9kek1Jd0hv?=
 =?utf-8?B?NjJxdFZHQURXTWdvVVpaTC8zN1l6RWJndllKOW50dENDZTdZRDFlQUhTampS?=
 =?utf-8?B?b0xsTHZaL2RNVEUybkxBY0paei8zaDV5bTBmU1A2cnkvYS9qUFZna2N6RGov?=
 =?utf-8?B?RjgwbkVoODYrTlZZKytiWGVudmZuSW1sWUhYa2FRVCtXb09JbmZUaXlkQzd6?=
 =?utf-8?B?VWx2enAvTEdiOVM0Nm9lNndWQWowSGtwdHhRRlVBYUdaTFFjeUxUMUdteHZx?=
 =?utf-8?B?V0FScUFzTTBKTnZPQVRDR2lCVjJlQ0ZjcFlDNjFGZGZnODFReWdGZnNDMmhq?=
 =?utf-8?B?NzVUR29DeFhUemNCNDd1L1lCOFVJajJRV09JbDBGb2FVRE16NldpU0FQRUky?=
 =?utf-8?B?c0pMVGFKOHJlMXBCRDZaVElwalA3bU5yaUtnQUpVai9JM0d0dWJzKzZHRDhh?=
 =?utf-8?B?K1E9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ca4177-dd88-466f-7fd6-08ddcd7c506c
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB6888.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 02:13:16.8769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /UbkY5WMMMHKrYJ8d/9Jd6fNXH5gnUuWRn7896Pyyn0OCtO1SRJBfTtfs0K0EC1xiPElB7wuoHPmbjtxSkfb93FrcfOiSrxvzhB91xBGVR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8096


Reviewed-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
On 2025/7/26 01:17, Colin Ian King wrote:
> [Some people who received this message don't often get email from colin.i.king@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> [ EXTERNAL EMAIL ]
> 
> The check for ns < 0 is always false because variable ns is a u32 which
> is not a signed type. Fix this by making ns a s32 type.
> 
> Fixes: cef9991e04ae ("spi: Add Amlogic SPISG driver")
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/spi/spi-amlogic-spisg.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-amlogic-spisg.c b/drivers/spi/spi-amlogic-spisg.c
> index 48a5325b4db7..2ab8bdf2a676 100644
> --- a/drivers/spi/spi-amlogic-spisg.c
> +++ b/drivers/spi/spi-amlogic-spisg.c
> @@ -163,7 +163,7 @@ struct spisg_device {
> 
>   static int spi_delay_to_sclk(u32 slck_speed_hz, struct spi_delay *delay)
>   {
> -       u32 ns;
> +       s32 ns;
> 
>          if (!delay)
>                  return 0;
> --
> 2.50.0
> 

