Return-Path: <linux-spi+bounces-7313-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 024EEA71656
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 13:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF23C188E877
	for <lists+linux-spi@lfdr.de>; Wed, 26 Mar 2025 12:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C0F1DFE12;
	Wed, 26 Mar 2025 12:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CD0gqEeO"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E013420311;
	Wed, 26 Mar 2025 12:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742991427; cv=fail; b=u7t+wJr49UkURpChHqLJsK/bH8W60TWKJP+aIElPq1B8ZhSvLRYjp06Q2FZ9H6fdUdU0On+az8OLvvLy2/RMSQozzcmBivO8Tco1cEMd+PYplxlw8Y5CfOwxbjNKK/lzQHLAcqez5u81lJnMfjK4l5CBWuDdUheHyfrpwU9AOho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742991427; c=relaxed/simple;
	bh=xLOEPjmwDnctpP9X8rmVlp/SQY4dNER5b8HrXvnpxlc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WWCFEOfB1Y0CMfiNBGCl4/CAvMkpvJtNI9zJtYN1w8AxMSw+bCHUqY626tHdhY71MvU4EuzFhvV4Ap/JEbygbuHzGHG6T9+SryZtH2BgRiOFOmEE5SOcZIUYMbhFqEmaDaY1PY6u/pqhRrVFV5TddjsDF1kWjOKwQuxh//M8Ax4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CD0gqEeO; arc=fail smtp.client-ip=40.107.236.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXlciUtp2aGHhtV+speIxXansljkLnzV21hGpsmVxyLcZztwgVFIimoQaDeSobRleqpvcpjDp4kLIScalX7iB6Kvwftts7HKZ3YxA80XVt34W0JklvmQLlWyHG4Hz/PBQSNtcLuaViHRoHQk05yiKdYoHk9HgfLHlXtRjJcsFHSwcmOLLTZpZC7V4ztqrYTlBdPUaSh281QrKph2OJkNbeTKTYdlt+u8EdSwj7ajLJlzAm0SHZ/fk8Y2F9xA+OXLCddBszC/7ZoSH5RRjzYgyYLlOFDJ6m9xVmexdOzeu59TA3b3azOdjDVtDicT1Ny6r9hPTJkX8Ug8US9BY/Lt5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2f9hgwxhV45xyYZPQkCgUFNZpAIGjKOvunTeHksK4+U=;
 b=djQ549vXLWfj1xvSXRX8i4qIvmpWfzvQKe40efepfiymF4PT8TSh2MRGN6X/ZbN8oxbZ7Z+fU3v4ibvwrarzsgTuVByBksXbabzoPYsb1Vu8/EoZtHMBIWC4Eu6NhHlxxbvL9CL3p+8jxs0yI6hELZM6UzL7v2sit2xTEmn6pdjUq/MhehQ72crZkRWmIyrcIJ1f380weEHXxPmb4oXYpvxyWdZlmBONSr4FfGl1YbueygJdUIt2mUqafU1EioZLs5xeBmsKjPSTYzP8+CcPzP6e7JCo1xgU4qop+nyArtuEatBazLwFlAy5bI+J3LvTlw3LVtFhLR/tqogn3obX5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2f9hgwxhV45xyYZPQkCgUFNZpAIGjKOvunTeHksK4+U=;
 b=CD0gqEeO0Twaoei38ckZPixhGHzIyn6hTaf/KvifoHYz6QiJACwTPktwDyBxYIvrEc6v92PjQF6YfVn5llXxlp2TuUF7YOuFEp18xjsCPKpgeCvaz6oKHlKVTfxV7OGM5K44fJPjwGsBrGI+bxo//yGDaUClsCgzGUaKzH+H3RbtbjYuTQkFpWeUMoSSAHy0WsAkNrQ6pnApz0MUWhxaTMGMoAG8r5JSZuEtoK7ZOFxgtq4cvveMofSUkMsqMXenlrwBq6skXbT6mx+WHdrlLrFBfC1mc8mbUCyouf7LhFCZnHEeXTcVIOGyeUGLOP1rBzl4h5vdxVDSQAnV9SnFEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by MN0PR12MB6318.namprd12.prod.outlook.com (2603:10b6:208:3c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 12:17:00 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%6]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 12:16:59 +0000
Message-ID: <63b87feb-32ee-423c-8d82-61445414c6f7@nvidia.com>
Date: Wed, 26 Mar 2025 12:16:53 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: spi: Add DT schema for Tegra SPIDEV
 controller
To: Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Vishwaroop A <va@nvidia.com>, krzk+dt@kernel.org, robh@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-spi@vger.kernel.org
References: <e95f870f-1309-4ac3-a16f-ce58b02dc817@nvidia.com>
 <59ec100f-1915-447b-98fb-3cbe2ca53a1f@sirena.org.uk>
 <925fe847-68b4-4689-832c-08f8de3dfeb1@nvidia.com>
 <48f9c8c0-5cac-4812-8d06-501193be731b@sirena.org.uk>
 <909f0c92-d110-4253-903e-5c81e21e12c9@nvidia.com>
 <48248165-c800-484f-be62-7c48b3c6829b@sirena.org.uk>
 <4zic633abvwj377kfqem42zmc2yruflbwfmmqrpvjjgr6jae6h@jthoycb3vzzz>
 <ljxxml7z2k6xniamzzw4ssi7u75qqfpcvmidzy3ekr3imtoxau@eztnxovsjplg>
 <499703ae-dba1-49a6-869b-a60b44c2a85f@sirena.org.uk>
 <2oxhmcrhbwlwqgyqy62p77eoag6nkavhjwmwfjfizcrhunrkjv@eaxjy6uoxszq>
 <25857b7f-5c10-46ec-b0b7-9ff89ca5ab1e@sirena.org.uk>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <25857b7f-5c10-46ec-b0b7-9ff89ca5ab1e@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CWLP123CA0135.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:401:87::27) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|MN0PR12MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: abb08a9a-f7ba-49fd-a4ff-08dd6c601bb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUM4Ri9Nd0J1OEtYRTRPbXJSbmxEUnhLanU5Vm9PNkJGdWhUUWZHaGYvVHdF?=
 =?utf-8?B?QmN4TUViWVhpd3ZNTzJUTzJsdyt3bWp2azQrdUVuaUtqTVk1d1RRTFVKUms2?=
 =?utf-8?B?c2UrWVovTGJGMUtBMFZ1aElyZU4wRkt2cnZXZzRFNGdPeUtsTzdPaUtKRlU4?=
 =?utf-8?B?dnpjQWJWZUwwcDRvVUF3RUQyRmsvcVdoSE15SE1CYngvekNVRlpHdDVNMnZa?=
 =?utf-8?B?L01NMmlSMlowNmp4TXc3dm5DTVdwTDczWnJEY2poaTBNaVkyQVM5SEVRb0E3?=
 =?utf-8?B?V1ovQnkxRDMveGUrNUg1ZzRzNU9KTjFhajBMRUQwQ2NKVk51bndnbFBvM0pG?=
 =?utf-8?B?UUthc2pJaVJhVWhlTWtobXRlY2YwYW91ejlGQVY5NFJVZzh2QU1VYkdSZTVE?=
 =?utf-8?B?UU05c0VaZEFYTUd0U3cvNFBFeWk2R0VmUXNPMXZyNHhxdHVhTTRkeFk1UFpI?=
 =?utf-8?B?UEIzU0JDSW13YnhkQ2Y1V01oOHFpZG1kcXZNY3pkNGR4eFpHUWtRbGVpRFZH?=
 =?utf-8?B?Tk5TdU5XMDFvMncxajR2VjE2SjlXcVdQSE4rUURjVndLWC9sNnRmdHNCRFla?=
 =?utf-8?B?ZVJXcDh3L0J2N0pramJWb09KVnVZeHJEeS9TOC9oMGZPMjZNYTl4WHRCY3Vk?=
 =?utf-8?B?QkYvdmlQNzE5dUR4eC9sUDAzYldCQk5yU2xjd2xDNlBPSU50WWpnbjQ4Ky8x?=
 =?utf-8?B?eXo0YkJtUXdZaHFNSEw4STN5MDBqRysvWGlPU3lqZ1JkN2JiM01MUUtHL2RM?=
 =?utf-8?B?R25SZis0RW9nbVBjRzRsWncvRy9pTTQxNjhxemtpQVBkdW5WQzFYb3I4bHJY?=
 =?utf-8?B?UDBFcExOMFZYTU9lMkpRemo2bW5NZytUM285OU5HUUFPTGZxMmJsc2dUNFRC?=
 =?utf-8?B?dXFFQTEwK3JpUnRNS3RDNVhJSDFsSnN6T1lHb1hEdnBqS29lUGxIbENORVNn?=
 =?utf-8?B?ZHpsWmkvRXU4SG96YU1CSDdxYWhiZ3Y4RnV3S3B1bEhEaXRURU9MSnQvSVpy?=
 =?utf-8?B?bzlxa1lWM29xVEQwS3ZTRG5iVUNTUFNaUndSVTZoNk1ybmpBV1pMVngrQXB6?=
 =?utf-8?B?Znp5SlFBUnVldVRCZVQwenVpVk1ZeUY2c0VlYzYxK2dYdFdxMiswd2oxdHlB?=
 =?utf-8?B?cTUvL1c1ckpsci8rTkR1aThxWVNyeUtQTVR6R1J5Z2RKNGpJaEg1Y3RJLzh0?=
 =?utf-8?B?VnFPdU52WVNnWTBrUFBFMk5WWDJIZVhIeFBmY2t1bjMzNmN6T1dMSWIwcm5C?=
 =?utf-8?B?MkgxYUg1am13a0lrenh1MGtpQ2VESmNEUVBMNDR2alhwYmdHcDRBR1N0RHAv?=
 =?utf-8?B?bFZOWVdzMlZ2VmkxWktyYW9qbUdGVXNuMDk0ZmkzcEFYckZkTk81dmpLblF0?=
 =?utf-8?B?S2hUY1hrWURxVURNcGs1SkQxRW1vKzhUd0FWaVpQbkl4SW84OGV0SHh6OGRD?=
 =?utf-8?B?ajJyWEl5QUt6NXZhV3p3Z2FpSCtSOVd5d3dDUjBTbHRUL0FmUkFLYW1XSHRG?=
 =?utf-8?B?TCtheStnZVBjMVJzUDVsRmVaSGtWc0NZZDdpUVlKc1VOM0dUUTZ3SkswSk1X?=
 =?utf-8?B?SHFZODBIOXMzTU5xQjk5VjNGNVZDWHpQelNvcnhBZGJPVHNoSkQ1bjBrVGVP?=
 =?utf-8?B?TjY2dzlBRTlXMUo0ZEFtYWc4UGo4NWdKN3Y0SDcxN1E0K1J2K2w1a3lnZTlD?=
 =?utf-8?B?cEZPK0hUSjNrZ2kzSndGa01FUTJaYUJSOTZXRm9yOHY3QXQrMXRLaHA0VFBG?=
 =?utf-8?B?L1h2eWg5RFVBd3JUM3o0NzBYbXl5MkhnYWs4UzBjZ2U4d296T3J3Q0xGN1NY?=
 =?utf-8?B?U2FSTzMxeFNtVDBCM1hvRW15WklnMmgwNDA3d3R6M2w5WmphQnczdVNlb21y?=
 =?utf-8?Q?D3knHwfZ/Uawg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHA0cVhCOE1QcDEzT0RsN21PcVpzZ3M3eUh0VGJHKzlJeXkxd3V4REV0WWFC?=
 =?utf-8?B?Nk5zNWJLT1ZHeUlBR0dFa2VBcVFXeDFjc0loZk5XOWRqeFd4RWhpUHR0bElP?=
 =?utf-8?B?NWloT2VGRmRTWkVHUnpCOHFMVGhYNHp4UmFUUTZhOC9zb3lMd2gvdG9BUHpY?=
 =?utf-8?B?WE5kQ2NPWTlGTzNiSlo0Q1VWZldld2tRTjJjM0N4cXR5VTY4RkF6NmxNVkNp?=
 =?utf-8?B?QUVUK2F3ajlEVnVFVWVDcDlYck9CMUJCWC90a3VWTHRvVWRpZzRpUm5TRktZ?=
 =?utf-8?B?NFpiaW9IRjVRZlprYVphWUo1emFWTlJZU3pCMmJ2QmRaZnA5SDVnQTFmdTRu?=
 =?utf-8?B?K1orZFJGczBEWUJmQWhSSjIxTEpmam1xYXJKa0JOWHQ1V08wWXg0cHprdXVq?=
 =?utf-8?B?RU9qQzNaR1JiaU02YnJjbUNwTm1LRFNmSTZuN3JyeUxoZ3ZwRXprUjNkM0kr?=
 =?utf-8?B?TEdtTzR2L1lmU0xJUTcyUCtUYTdUTzJQYk5BektyY1EyZ0RUaUt3YUFMTU1D?=
 =?utf-8?B?Vjg3K3NiZjdsaDZKTWxCRE1HSFBNa09KQ0VkQWp1SDRoa0NEWGVDL0VnWXVi?=
 =?utf-8?B?Z0FHMGpUQTB3TFloVEl3WmtLVWVJOHJnVFNUTDNjcmE1R1RRdGxRQTVVSjdi?=
 =?utf-8?B?NkNvTnVuQTl1MUU0QjhFdUp1T2hZQktIMTh2TGh1aEI2UEdHS3hINHVtdHY5?=
 =?utf-8?B?SmFwRkZMSTIzYWFUaFk2K0hiakZpTVJERTdMUlZaZi9ETEl5Y3lnM1o0elBS?=
 =?utf-8?B?a2hHdWVvdUxaNlVLemhnVjZhd1NJa2ZkUmhiQ2krUEFmTFJnbjFBVmlhR2VS?=
 =?utf-8?B?ODZrU2RvZFVtRSt6QXlWMEY2R3N2VlhuNUNHQkhTQ0dPZy9NQ0Z6aU9NWGxx?=
 =?utf-8?B?ZEJqTm54eTlJZ3VqRmpCUGhpQ25PSnNEWW54ZGg5aHFwdDBENms5NE5oRTYr?=
 =?utf-8?B?QnR4eWRJUDJBeDZwRzQ2MnBDLzdMSXE1LzB3S0NiWnRYMDNyaHNxdmlrd09i?=
 =?utf-8?B?bE5MeElzV09RMGRDY3ZzR0VvaysxUS9QRXRaam1jQ3RWdlk3YTVQRkxFdEVs?=
 =?utf-8?B?c1RZbW5nYVQxZkJVblJXdlRlQ1BtQmNWbTRkVHlUcFVWU1diTlNnWGZJWHR3?=
 =?utf-8?B?dzIxcmQyTnRTRS9HQjJpNlh3WWd4RGJlRk9DbXlWMk5rUUZ2Uk1VdFdtVFFq?=
 =?utf-8?B?dFh3VVRJRS9ndXMyM01JUzhNNXNwK2hJWnQ2V1plQ3FDeVZnVHgxWnhONlJP?=
 =?utf-8?B?ZGM5OUlFNjdCVWplYWd1V1B3aXVzbm9hZUZOZ3VTVHBrY0treWVJLzNsc0w5?=
 =?utf-8?B?TG53U2hLNjVCV0lxMjJwTEJCNjN2M3h5aWREWnFJU3V4bzByYUtiSFVBK2dk?=
 =?utf-8?B?Y2lPUUxwZTVqeDlqdnQ1a0dqZWhpcHdGbUtsWVkveFhnaU5RQ0RxT0pEdW9V?=
 =?utf-8?B?Z29mQVU0VzllRm9SR0hsSGM0anlxQy9HN1c2YkZybWZSSnB4UWFmbExmeHNT?=
 =?utf-8?B?SUJ2eVZUM251azhoUDc2SUNiWG4yVkJmZU5PUkVWQUk5VmRMYml6Ny9vaXBN?=
 =?utf-8?B?WmFaQ25XRzZ2aHRqa0FqTmtJL01BNEVDSnZick1KVTVKQm5iUUlHQkkxREFS?=
 =?utf-8?B?NWpnNVFva0hwaHBqalo0OG12VlZqMDlqTFpDb005ZlVsMk9pQXdudGZEUExJ?=
 =?utf-8?B?Z2RRdUFKYkZBTmtuNk1RUEJ5TUhmcnJVUjduK2oxWW1idlZJOEhaQUxxK0VN?=
 =?utf-8?B?VUEwOEhKRGIzSFFhbTF0eTQ3TjFERGhUZjlRaUFlcVU2MldtQTR4MTZ4dVZq?=
 =?utf-8?B?d3lUSXNVUXdsb2VLSWNCZFJDek00d0dab2JzYnU1dEd1akwrQnNqb2IyMVJY?=
 =?utf-8?B?YzJReSttNCt5QUJmVmljaVlWRFNGelJLOW15c01Ndk1KV0g0Wnp2a1hLdGIz?=
 =?utf-8?B?b1NsT3pUS1E4b1hNKy9zRkl1Q3M1Qk5ZMGdBZzhNZldvK3JJTHBrY3JBaGJE?=
 =?utf-8?B?NlY3V1JLS0ZiSmFPekRhek03OWlCcTVyMTBBVVNEaTJSZEV5QzZFVmNMY2Ju?=
 =?utf-8?B?dUNjNGFwSHFqZnA5em9hVVdnQndtai8rZmZxRE9PTmtjRTBhSlB1YjF1ZlRV?=
 =?utf-8?B?QzRRWkg1NFY2dy9hS3ZhSTZHQlZxRTM4dFpUaHF0Szdwb21SWWNvUlE5b3I2?=
 =?utf-8?Q?q2BM+/wGyjhJdkXZ6vxuJOB6Xel5GwYfMlBzgeTdWdz0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb08a9a-f7ba-49fd-a4ff-08dd6c601bb0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 12:16:59.6793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U9rzxwozvXcDPWmPxLmg3QR9LpUZcjj3Wp/IW4TZNGGKBzy2zEcBCOyDfXDPEOaxLt/F0WDgER/GtXrbSRzyDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6318


On 25/03/2025 17:05, Mark Brown wrote:

...

>> The way I imagine it, exporting would involve writing a chip-select to a
>> specific SPI controller's "export" sysfs attribute to have a SPI device
>> created for that particular chip-select and bind it to spidev.
> 
> My general feeling with those is that if you're building for them you're
> probably either already modifiying your kernel or easily able to cope
> with doing so.


That's definitely what we do today, modify the kernel directly to 
achieve what we need. I am trying to avoid carrying too many out of tree 
patches for stuff like this and have something in the kernel that works 
by default. This is even more important for 3rd party Linux distros that 
will not accept non-upstream code.

Our devkits, very much like Raspberry PI, allow users to connect various 
hardware for development and so having an easy way to connect a SPI 
device is useful. For any production systems, users will definitely want 
a proper device and device-tree bindings. So I am just trying to explore 
what would be acceptable. If it is acceptable to have a sysfs interface 
for creating a SPI device at runtime, then we can look into that.

Cheers!
Jon

-- 
nvpublic


