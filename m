Return-Path: <linux-spi+bounces-7974-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0628AAD7D5
	for <lists+linux-spi@lfdr.de>; Wed,  7 May 2025 09:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C339806D4
	for <lists+linux-spi@lfdr.de>; Wed,  7 May 2025 07:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE47221290;
	Wed,  7 May 2025 07:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bernerfachhochschule.onmicrosoft.com header.i=@bernerfachhochschule.onmicrosoft.com header.b="SaVGr7yH"
X-Original-To: linux-spi@vger.kernel.org
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazon11020094.outbound.protection.outlook.com [52.101.186.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28459221284;
	Wed,  7 May 2025 07:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.186.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602322; cv=fail; b=f3ai2GAC5OgRpFxTqwWUo81bqtNICRwyztdpBM9kzR0g2qRHVAkc1rRqLSoDKzFRrnSv3ZudHv7eNFgz2E5hsINXWNHazt3SF365F1xJ6/99/4PcWtGMjorrUnYYNKgHhviRKZvGdAOx1w+e5/UJQMIdGya/ij/tXhXA86AQLJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602322; c=relaxed/simple;
	bh=H/Gf02lBQ3OTz/nCr+PLp3f0hUIVTeDoLvwwjpTKumU=;
	h=Message-ID:Date:From:Subject:To:Cc:Content-Type:MIME-Version; b=YSSb5rQ1B21AcqbPUyGMe3B172L4lMUGpl+0P2yDgSpNvHonnV+UGdxTK8srKiNngRqyYJx3b+CGjB/AUlzme08qLjnbpX82dt8iBg1+kQzPi1nVPcNeMGF1aZLjNa74iOZ6ghY+mD2cLL2KE9KQ5ITXHW5IkZCHqnV/YQ7QH4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bfh.ch; spf=pass smtp.mailfrom=bfh.ch; dkim=pass (1024-bit key) header.d=bernerfachhochschule.onmicrosoft.com header.i=@bernerfachhochschule.onmicrosoft.com header.b=SaVGr7yH; arc=fail smtp.client-ip=52.101.186.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bfh.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bfh.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GuxEtu6AlGJRSLgYbtFsOmtrsGYfEo6KpQzpOFzLBwp85bQMlqz684U29zXtSvwiF4++KOAR0i0L/YisIlYA7aSvilL+ccEEZmVhQqynoHMR9gsSuYJb6BiaEl4Nil0LoiB+leIHsDaPRbeDzO/jDol9psIsKmr6O5pRyso35U/XH1i0pMxwIWIcc1CP7NWEuI4Q7yUXfku4zoQxxMW3RngcJh9+qrTbJ5dBUpnkvaY/jzcjJKH5JaiTbApMFce+SoAWcv0heoDPisxFTYQcxkspDKY1Ua3VL0cjxxXFn94UG9QbsegsDDXdcGwQCz6KsgUgMJk85zWJM0ymQvgY9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/Gf02lBQ3OTz/nCr+PLp3f0hUIVTeDoLvwwjpTKumU=;
 b=CRkrn+qcysa17MM+bbIgkd5RRlnvRtOTxuuuGcNTMUX+jgOJuMRdnPZof/y5YSZoo7AZxFc5RukhYHg/x2faX2tFgc/cDyytXyxCJ40emXOIPN6Jrfplot+OcZDIGbXPz298KV8ZAGBuTbHia3++9qAnUyMJu2ZuMNBlqNry62dg2byUXo6oa2LkMs3TF5C34Dk2brYK3SlxmDnJb0ePn5EwE2SwXslbujSLr7Q9MuqCkNVysn4KweaKX6WBgEW9601EQh+54d4+ZgJJhYWH6DM2tGGoCwUGq/WTm2fnM8jXmox2NS8/U6v6t0tu4JkEqxtkYFx2vXDKRXSMaA27EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bfh.ch; dmarc=pass action=none header.from=bfh.ch; dkim=pass
 header.d=bfh.ch; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bernerfachhochschule.onmicrosoft.com;
 s=selector1-bernerfachhochschule-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/Gf02lBQ3OTz/nCr+PLp3f0hUIVTeDoLvwwjpTKumU=;
 b=SaVGr7yHM/1YrdlUrIzkHXYbll0s1PZK0fUWd4+AuBCFHKaCR+l15XPpD9qJwt317D4zilYUuRvaCFVJgRlIJO2rLOEWfQSivlTY5Ojy2L/CFxn/6ub/dtCL5pQaTRNlLKsFGfeOGelqpswGrd516yimMboGptmrzTENKYWOsyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bfh.ch;
Received: from ZR2P278MB1033.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:60::5) by
 ZR2P278MB1110.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:60::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.12; Wed, 7 May 2025 07:18:34 +0000
Received: from ZR2P278MB1033.CHEP278.PROD.OUTLOOK.COM
 ([fe80::b47e:1592:3ea2:2d5a]) by ZR2P278MB1033.CHEP278.PROD.OUTLOOK.COM
 ([fe80::b47e:1592:3ea2:2d5a%4]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 07:18:34 +0000
Message-ID: <4dada48a-c5dd-4c30-9c85-5b03b0aa01f0@bfh.ch>
Date: Wed, 7 May 2025 09:18:33 +0200
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Berkel_J=C3=B6rg?= <joerg.berkel@bfh.ch>
Subject: [REGRESSION] applespi from 6.12 onwards
To: linux-input@vger.kernel.org
Content-Language: de-CH
Cc: dmitry.torokhov@gmail.com, stable@vger.kernel.org,
 regressions@lists.linux.dev, linux-spi@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-ClientProxiedBy: ZR0P278CA0058.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::9) To ZR2P278MB1033.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:60::5)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR2P278MB1033:EE_|ZR2P278MB1110:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c1cdc0a-01c1-4bc4-d1ba-08dd8d376094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHJCVFdES0VLWU11azQzZW0rdXVsRHpLR2M2RG9vRVRLUjJxNUc1ZktmbHBF?=
 =?utf-8?B?MHVaNExBQlY5dTBCTm41WWhubVJLV0JtT3ZBb2tyN0Z0eHB5K1F6aTRIc1ZT?=
 =?utf-8?B?TWxMV1hJS3JKMmg3YUVUOEt6SThNU0JzWmhSTnZvZW5HemhaQ3QxZEo0RnBC?=
 =?utf-8?B?c25JdHlKRnk0OEtTb2RqUnd0Wm5seXozc3M0MEdYc0FUaTNpS0ptTXVROFN2?=
 =?utf-8?B?MW1rVFNtTytPOENtWUFTdGZkVUczUzV1TmVlcFFKcnZuelB1RjM0UWFpVEhG?=
 =?utf-8?B?UWZOcFNjbThQOTEvZjZkdUVRWlFsZ0NTN1pUODJrYmVwYmRyNlBIbndyaERB?=
 =?utf-8?B?UGxrL3o4eUFCbVpxRlFSWFA1Qi95KzFxT1VRNlE2M2EwVkQ4cGpNMG96ZTRj?=
 =?utf-8?B?WUZpWHZPWHJBbTBDakRaNS9ZSXpHejV4UEF2Yno5VEhtbUJqanJwZllXUWpX?=
 =?utf-8?B?cHNXOEVMZVRiSitUSmlIL1JYVkJjQVBST3ExMzhsQVJSODhBTUF1NWJBSmNp?=
 =?utf-8?B?STVHeHEvNnd3a1Bkc01kLzl2YVNleFp3TVFkeVV2QUdDVXdRV1hnaUZyNmZM?=
 =?utf-8?B?S2N0NTNCNzRQRndNZ25FU0dVUXdPakJrbi9JalRmL3lxbVhJWHZDSUo2OTJF?=
 =?utf-8?B?c0VIeXJ4Zk9IWnJ4M1Q3a3ptZEpreDVlQ1NuenAzVitzbERyNEN0Z0dML21N?=
 =?utf-8?B?ZU0rbzJTL0VobTROeHgrRE4zbWM1V0R4TE1uamtpbGZNcURkR2VGSUxWTUZ5?=
 =?utf-8?B?RXpCNnhVSk01bnQ3Z25hMzNDZWZOR2l6MUZiaFhjd2duWkVOYW56RGFGekxB?=
 =?utf-8?B?akE1cDVZcnliYmhGMjE1TEg0REw5emNZVXlBMTYvOGdGaERsbTZmQ3p1V2kv?=
 =?utf-8?B?Y3VzektENEQ1U2ZwS0ZOZlhQRXk3MmI5WkJobitUVzM2MUVPaHNwMmZ1NWlh?=
 =?utf-8?B?MWswMW1JTjVHdGhURFpjOUFnc3B0S0dCQk9xKzBUcU1kUFJCYXViOEMrSU9S?=
 =?utf-8?B?eHBEMDRmdnVBSi85UE5oMXMrUHlpcGczYit6aGV2a0l1eWpXNVRRMUwrOXBS?=
 =?utf-8?B?bno1RkRLbFpRZm9zaVlwVER3andCS2poa2E3WkthYXhWYU1ja3N3R1h1UENz?=
 =?utf-8?B?OS9VZlpIdjRrT2dXMFRPZ0pGb05PVzc1dU1lbmJWWDRVRzc5dXQyd0IwZU1i?=
 =?utf-8?B?VER3SXNXTXFFeFF6a1M0cGxsSkRxU05XUGpZdGM1VHR0bENlRUZPMERXdVY0?=
 =?utf-8?B?VU9DT1BHUjZlTnpsUWpyT0dKWlpSOS9Wb0Nhb2hXOElVcXZlSlJ0MzdSOTk3?=
 =?utf-8?B?ejhQYStOVTdDT21ObVE1VXltZGFkbzBKNUgzcHgrWVJHN2orOTFrbDNBd0FM?=
 =?utf-8?B?RjNIYkdVRjFsNUg3cmprckZBMzdSeHBCdUlGcVBEZ2Q3Sit1dUVXb2JSMkxE?=
 =?utf-8?B?TEVvUWxsVmdzTHlxVnl6eGJaaHhNN1g0bFdKZk4yV1pTdHU5NEJtSXo3eEl6?=
 =?utf-8?B?Q2liclZqV0ZQOWZRQ3ZJeThvMWczSklzazZPTmxXZldwOTB3NTM1QnZtSUwx?=
 =?utf-8?B?RzBDc3hYclIrSXo4UU9CSTlGQldmNEd0b0F1VFdLVlBJYzRoV01tRDBISkNO?=
 =?utf-8?B?YTI1aEZFa1loRWFVVklacWYzalluUkI2NmVmNGo4OVA1MHA3b3htL1RENGNU?=
 =?utf-8?B?UytqeXA5RXViSldiTjVWUTJLWDZxbXVReUJ3RWZ6TlRaTjd5TFJ1b1c0ZWgz?=
 =?utf-8?B?UkZrbEp5RjFtUytvOWFlUXRrWWlkbVI1Rk8zRzNmVjNJQUpITkYyS1hqd3dR?=
 =?utf-8?B?Q3J3QVpjb3ZHbjBjTUZ5TnJWbVU3M0JkdzBHVUMvUmRkYUdvSGFreC94aldu?=
 =?utf-8?B?cUw1bG5UOFlXaEJqWkQxSGp2UVl6WTEyeVpkejNESWd1eGlSdjZwMXJCbXJL?=
 =?utf-8?Q?5yolbydff/Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR2P278MB1033.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1JXS2NrV1d0S1FFT2hxTnZFb0NPbWhiMDYvd3V5VDRwL09EOWdaQWZyQ3h4?=
 =?utf-8?B?ZGtVSjZQbldoV0owR2QrWUt2V0cxeVE5cE5UV3hvWC9GcXhRMmtjNHlNdyt4?=
 =?utf-8?B?alg4cWR5RzU5Tzh2SVo3cnMyUUJKYjZsMUhFSjVJRWlxTzAxb2tqcEhUZWl6?=
 =?utf-8?B?SkJRWkNwSy9kbVRsdTE1Sm1RT05CYlhzV3dEZ05aWDBFdmx6TE9rSDdRNyta?=
 =?utf-8?B?QS9IaUtVZ3lqQ1ZrelQrL2M4SWZYZFhpL2RYZUtRRllZdUsxVHZSN1Nad1ll?=
 =?utf-8?B?WXFMbUpzV2lxeVVyMVgySGt1cjZrWmZXS3M1Y1R0TUNFKzc0RXdGTWlQRHlJ?=
 =?utf-8?B?a2FSS1EvbHlzcm0xRTd1NXZ1TExGa0liTjBYMW9JSG1CcC9FdjlDb3FTZnVH?=
 =?utf-8?B?MkFIampORUFLcmpsTG1CZGVLeVQ4UThTN1dqb3IrMFUzLzRFYUcrQWplZTZP?=
 =?utf-8?B?bkdmcW9pSGQ0QkVvN1ZFZHlObEhtTm1OS1JnMmNJdkYyMFpmeTV3OXcxNHdN?=
 =?utf-8?B?amlvS1lEMUxDMUZISnRGRXRhNGN3TDlLWSs1Wm5ueFZ5ek5hQklPSUVOK2pY?=
 =?utf-8?B?bVFFM1M2MWNEL0ZIazAwQ0I0YTh5MHVsd3V0czlQS3dZMHRQa3BUeitGbjJo?=
 =?utf-8?B?dE10cnRycml0dW9aWkIrTzF2SUJ4VVRlNTh4VU1LSXkxMTdvOTA5b29WNmp6?=
 =?utf-8?B?SjBzajY4OGV2WGt0V00xak1iMDZ4eHJUa0YwR0g5RGpOTXRqOTR2blFFNW14?=
 =?utf-8?B?cG1tQTRqMzhCdThGYnZrY1dFTm5MN2V4bG9PekFlU2hSQ09kU2xia2Y2YXlK?=
 =?utf-8?B?Y3ZydGF1NHJuTWZPYSs5Q1VHUDFaSElXcUVlT1MrZEJ0VENaQ0Z0di82T3Nt?=
 =?utf-8?B?cUFOeEhQK1RjS1VjOTA1KzI5Y3VHNkpxL2xKdlNvZm5jNkprdGg3ckJra0ZB?=
 =?utf-8?B?RXdKS3h0dGpwcUIrMHdvMTlCZ0lZYVJjM3IyQXJEbkxJZ1F6MFBnTkM2Q2R4?=
 =?utf-8?B?MEhSZjJ5MU1mQUU1RFNFV0F0NEtTVTFBcW5uRVpHSlp3UVF0V3lISStMek1p?=
 =?utf-8?B?ZUJid0cwT3ROVEZpYUtGR0kwampnRlJvWVBsd2NUc0crOUovRUNUUjNrYXpT?=
 =?utf-8?B?U3VEVzZFTkQ5YVFvb1VzSTZZbkN6RFpvVkd3aGF5YisyS1RyTFlyck92WVU0?=
 =?utf-8?B?UWZzZVB0Uys0T0U1a09JWHgxMmFqTVJ1TGN4eXpEVkNhOWxIWHpPSnh3UG1B?=
 =?utf-8?B?aU5YaEpYRUhSMUpBWVV2bkFodVBtcWMvYjVPQ3FuejE1Vnc0N2trOUZUejlx?=
 =?utf-8?B?Rk9sREliTDhiVnNZUXpKM1NOQ1h0cmI1RTB3QUJ0WlhPREFtMGExNTh1UnFp?=
 =?utf-8?B?MmcxVEtRcHI3ZGp5WDd0YTBrc1VtclcyMTVpTUtTMEVmTjl1TXBEa040N1hV?=
 =?utf-8?B?cTlaaGNLbGozNjArd2NJWXVNR0plSjVJc0FTN2NSVmFKVjFTMms5QlQxMGFT?=
 =?utf-8?B?aitrcUgyWXhaWlV6T1pPRHJNWGxobFBJNUpFMm1DU0FtVDBUZTZSdm5kZzlj?=
 =?utf-8?B?MkdyMGs4SjYvZnRPNVgxUmJwSGdLbjBVNEI0aTkzT0doQjdkOHhaalEzUWlx?=
 =?utf-8?B?MG5uR0dkR2xxRm1uN2YrTjJzNVU4cndPTWNvMTJ5ZWZWdDhLQzBxdVpPdklC?=
 =?utf-8?B?dVM5NUZWWkpwbWJiYXp5dHlXU3djeTRoZGowTGVXbGR4eHpSbE1YWTh1U011?=
 =?utf-8?B?VEpPdzBNVTh3cXVBaUM2OWRYZ2pUaGo5dzBtbWE2RHpiNzRtOElDdVluUzF4?=
 =?utf-8?B?VzlHRytMaWREQ08yd0VTdlZFRlIxS3R5ZGR1RjlBZlQ0czg0NDZPeFljb0lO?=
 =?utf-8?B?ekFZN1gwRllvQ3FYVk5BNHdiM2lva3FoZXFxTHdvTzlXMkhZbExocVJuSUJ1?=
 =?utf-8?B?R2RSTHl1QTRlRWZPOEh3VTdIVlo2eENHaXNSL2pZaXlmbTlaZjRmd2x4UW1T?=
 =?utf-8?B?dUpqL01iTnV6cmNvYUNKWGlBSW0xcjA3QU55TThnNE5WT0tzVFhBOU5zWFU4?=
 =?utf-8?B?VHdhU2g2T0xFc0hqVEk2VG9kdzNQZC9XNXJOZkUyNVNZSytKcVo2UDlXSFR3?=
 =?utf-8?B?Y0hWOWpjdWpybUF6Q0o2eDk2NHJFazhpUVlSZVRmazVLZExFQk9tcVdFYlpM?=
 =?utf-8?Q?3s2HW2/jxmF8hY1LvKM3dIw=3D?=
X-OriginatorOrg: bfh.ch
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1cdc0a-01c1-4bc4-d1ba-08dd8d376094
X-MS-Exchange-CrossTenant-AuthSource: ZR2P278MB1033.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 07:18:34.1221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d6a1cf8c-768e-4187-a738-b6e50c4deb4a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8L2ZoDocn/6AjJYC/F2Xh3Ne8gmXsSkhW66NYntBlUFx/74wwuY2S4rv8SnoYom6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR2P278MB1110

S2V5Ym9hcmQgYW5kIHRvdWNocGFkIHN0b3BwZWQgd29ya2luZyBvbiBzZXZlcmFsIEFwcGxlIE1h
Y2Jvb2tzIGZyb20gdGhlIA0KeWVhciAyMDE3IHVzaW5nIGtlcm5lbCA2LjEyLnh4IC4gVW50aWwg
bm93IEkgY291bGQgb25seSBmaW5kIHRoaXMgDQpkaXNjdXNzaW9uIGFmZmlybWluZyB0aGUgYnVn
IG9uIERlYmlhbiBhbmQgRmVkb3JhOiANCmh0dHBzOi8vZ2l0aHViLmNvbS9EdW5lZGFuL21icC0y
MDE2LWxpbnV4L2lzc3Vlcy8yMDINCg0KT24gc2lkdWN0aW9uIEkgYWxzbyB0cmllZCB0aGUgbW9y
ZSByZWNlbnQga2VybmVscyA2LjE0LjUgYW5kIG1haW5saW5lIA0KNi4xNS1yYzQgKGZyb20gVWJ1
bnR1KSBhbmQgdGhlIGlzc3VlIHBlcnNpc3RlZCB3aXRoIG15IHRlc3RkZXZpY2UgDQpNYWNCb29r
UHJvMTQsMSAtLSBzZWUgdGhlIHJlbGV2YW50IG91dHB1dDoNCg0Ka2VybmVsOiBwbGF0Zm9ybSBw
eGEyeHgtc3BpLjM6IEFkZGluZyB0byBpb21tdSBncm91cCAyMA0Ka2VybmVsOiBpbnB1dDogQXBw
bGUgU1BJIEtleWJvYXJkIGFzIA0KL2RldmljZXMvcGNpMDAwMDowMC8wMDAwOjAwOjFlLjMvcHhh
Mnh4LXNwaS4zL3NwaV9tYXN0ZXIvc3BpMi9zcGktQVBQMDAwRDowMC9pbnB1dC9pbnB1dDANCmtl
cm5lbDogRE1BUjogRFJIRDogaGFuZGxpbmcgZmF1bHQgc3RhdHVzIHJlZyAzDQprZXJuZWw6IERN
QVI6IFtETUEgUmVhZCBOT19QQVNJRF0gUmVxdWVzdCBkZXZpY2UgWzAwOjFlLjNdIGZhdWx0IGFk
ZHIgDQoweGZmZmZhMDAwIFtmYXVsdCByZWFzb24gMHgwNl0gUFRFIFJlYWQgYWNjZXNzIGlzIG5v
dCBzZXQNCmtlcm5lbDogRE1BUjogRFJIRDogaGFuZGxpbmcgZmF1bHQgc3RhdHVzIHJlZyAzDQpr
ZXJuZWw6IERNQVI6IFtETUEgUmVhZCBOT19QQVNJRF0gUmVxdWVzdCBkZXZpY2UgWzAwOjFlLjNd
IGZhdWx0IGFkZHIgDQoweGZmZmZhMDAwIFtmYXVsdCByZWFzb24gMHgwNl0gUFRFIFJlYWQgYWNj
ZXNzIGlzIG5vdCBzZXQNCmtlcm5lbDogYXBwbGVzcGkgc3BpLUFQUDAwMEQ6MDA6IEVycm9yIHdy
aXRpbmcgdG8gZGV2aWNlOiAwMSAwZSAwMCAwMA0Ka2VybmVsOiBETUFSOiBEUkhEOiBoYW5kbGlu
ZyBmYXVsdCBzdGF0dXMgcmVnIDMNCmtlcm5lbDogRE1BUjogW0RNQSBSZWFkIE5PX1BBU0lEXSBS
ZXF1ZXN0IGRldmljZSBbMDA6MWUuM10gZmF1bHQgYWRkciANCjB4ZmZmZmEwMDAgW2ZhdWx0IHJl
YXNvbiAweDA2XSBQVEUgUmVhZCBhY2Nlc3MgaXMgbm90IHNldA0Ka2VybmVsOiBETUFSOiBEUkhE
OiBoYW5kbGluZyBmYXVsdCBzdGF0dXMgcmVnIDMNCmtlcm5lbDogYXBwbGVzcGkgc3BpLUFQUDAw
MEQ6MDA6IEVycm9yIHdyaXRpbmcgdG8gZGV2aWNlOiAwMSAwZSAwMCAwMA0KDQpNYW55IHRoYW5r
cywNCg0KSsO2cmcgQmVya2VsDQo=

