Return-Path: <linux-spi+bounces-3510-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0521910DD4
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 18:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60D40B23014
	for <lists+linux-spi@lfdr.de>; Thu, 20 Jun 2024 16:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335D71B373E;
	Thu, 20 Jun 2024 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="El9noXW9"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B07B1B372F;
	Thu, 20 Jun 2024 16:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902732; cv=fail; b=aHVLAQ43za8UAC7ZfrJQFzRsjJfynbtf84HhNXo0YWwp7/K6yoOyQV6jd7/qFkuZHe1s6WuFPDmwaRUrtaBhYZgwpPFgDeX1GsFX2hR6b4otMOu7Vy39mTVrhkwSyNEtleNKT458e3dPp5T2GSxIC5eBa2ujj8Q/+OxIS/ylcOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902732; c=relaxed/simple;
	bh=1ZOLTYd9nKz3dWoCJmAdaERqxG9Ou/5gY0RXA9AdHIo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=m8DdsiHdMY+bsANKqHFn4w7cbDGvDsTNdZ9W+bUOFVUWcKdQieX6ftmmzcKCY756rLZYVNcagQmZ+AyfPaX0S6/RW3DOaJSqNspSbsk+2vU4O/Eq4w8nA4yGURxb45/VASEyTksaDcmVM3vgztBJZVBbwBiGBHsNJh00eBjl0dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=El9noXW9; arc=fail smtp.client-ip=40.107.21.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPZ2lZnfPN5seqtQ2ukIA51gYfGkiB4FIv58G8VKpgUfP6LqX3UlAhkBQ5aHqmAGbK0L85FfnwjiPvbsVh6uWSnpx1j0FKWqvMlFSiVYWZ7SRvfsJKRLt+izTcPfnm0rEfzsRb6EEaQ7oRIx2+snySzcvP8oOpwPKop8/0l/CdVakeEcWTVSxTcYSU7scAsTvTQbSkasXPSmrZ9gYnsXudqv/lkSJ93aibffKFT2SVvHpKY2kv/K8uwzkEqkZm2GVzWwCgdRlNCoSaSzBAwrJo3JNHYfXM4sjD71KSHv2jWsTN1JZvzJ5uXQCFVZ3BdozWxGcbBzic7S2KEorbUgJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUAB24xN6kjPK5ovZyDhtowkdtlZKMCF4c5Y7a2oS+g=;
 b=AO19doavik5Oy8HzrtGKVgr9JBb2NXZJq9hA4kNwdRRg06ZadTtVT8zSRq/rpFtaBeyAHLmvrefoBWUNLfviapzroczZDqBI7tNIxR1838SmlEozO6lbNB5pHy/P6uZUwfM8ZnstlBS54O7E0/Yf47zc70Ccke2MVs7gmZjJBViXv+uGSfjB4TPL2lpSQKoqbCI85ya4wUszuHf0Cb9zQOk343XiymxYXMWDsW2+7bjmnEYH2VcU2hxvxIeLKM8yJ9Xj0LR0GNl61j40JaDdTzYFLwFPZbutk0ifR4NCxr8Q/QWHUZ3Btt8BI+6AFwaltzCN6uwJS1pMkI8qOnE3Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUAB24xN6kjPK5ovZyDhtowkdtlZKMCF4c5Y7a2oS+g=;
 b=El9noXW9I/EHGvVJnpV1meyUDlVOkivcn3XmgJjnfZUOLC4Q6YpGSqaTb1DJg/fdmenCgeuzd+mxNbkSu6ttuDpfGbvRxHjv2E6eHkrv17u/S1KnmvZYUdIQyKV+4DD/KG9qXNS/HNPW8GTcjzu5D7rllmCBgegA9pdYZZoe3Zs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7632.eurprd04.prod.outlook.com (2603:10a6:102:e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 16:58:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 16:58:47 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 20 Jun 2024 12:58:27 -0400
Subject: [PATCH v3 1/3] spi: fsl-dspi: use common proptery
 'spi-cs-setup(hold)-delay-ns'
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-ls_qspi-v3-1-1a2afcf417e4@nxp.com>
References: <20240620-ls_qspi-v3-0-1a2afcf417e4@nxp.com>
In-Reply-To: <20240620-ls_qspi-v3-0-1a2afcf417e4@nxp.com>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718902721; l=1322;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1ZOLTYd9nKz3dWoCJmAdaERqxG9Ou/5gY0RXA9AdHIo=;
 b=2vXfgwGFREdrwbDSdVRF4yG2zVVj9U5x15ad/LT9YjmGmka/EDSXzXvb7BZHkHKHw7wHqG4te
 Oc8/PKEXmvuDJd962UB0nI5I5YXSPzjmwaiOsdxDyIcFQCKXCb5AFYx
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:217::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7632:EE_
X-MS-Office365-Filtering-Correlation-Id: 51137bef-79f3-4217-646e-08dc914a4047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|7416011|366013|52116011|376011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlhyR2g5OERra21icndZdjlsVnQvVzlkaktpM2FQK2tDRHV0OXA3cTFSMGwv?=
 =?utf-8?B?SVZZMmVYTWU5d1p1L21lM0xKcDllUXFkZ2N6UmdIY0hhOEhBbEViMjRFLytK?=
 =?utf-8?B?TnpMMEhiVmdvbnZjazBTaTc2MDR3NUR1RFBVazVjWDEyZGF4Ym14SmVwTjdC?=
 =?utf-8?B?MVBuTWpJWEpOQXlzdUdSUVlwRWdOZjc0RWFqKzVqKzdFM2FNMUpJTnFvOWJ2?=
 =?utf-8?B?WGhtcnNwSVhZVnBucGt5UXFQYUFnZHI2RVJiVXkwNERuZjN2TzlYRHJhSHlE?=
 =?utf-8?B?V00wNDlKMnNEbzVyekFGTVlXUDNqMGJYUGdsbkxzcmg4RGMyUlFnMG1Fd1pS?=
 =?utf-8?B?T2cxUmp5YjR2L1BuZWRPdlN0cEhyczVhUUY0ajNGQnljclFmOEoxaVJXdnNj?=
 =?utf-8?B?cFdvREljT1RNQVlpUWFUbzNIZjFkU1NoZ0JqL215RURTek9RUlRUZ3ZPYmhV?=
 =?utf-8?B?bGNlNDk0OXZDKzhoNlpZZEl4UVpIZGt4K0ZHcG0zMVlPK04wVngvZGtodjFi?=
 =?utf-8?B?MVV0Y2x0YWkreGtWcWViaVIzVGtTTnRrNTR0NVZYU0hLK05PQ2hwd2JYWXF4?=
 =?utf-8?B?aC9SUzhHamJJU05JVk5UWjZvTzZKY1ZYcWxJZGlkOVVqakZiYzlwOTcrQUJ5?=
 =?utf-8?B?ZFN2d3d2MWx6d2MramdyVU5NdDQ1STJpR3lQMmxMbjE1T1VyTkJQVkVlZWNQ?=
 =?utf-8?B?OWsweXY2YWdJS0g4cXo4OWYwNTJyLytkYWN0SE9OY2N0SGFWb2JyQmRmc3h3?=
 =?utf-8?B?VHcxUmZnVzhxRzF1MnpiQjBTR1VXUGdyOG10UXBEQWZGenlMMlpDd0hpcjlZ?=
 =?utf-8?B?ZVhCZDRYTzBmaXRpcjI3NUhMSUdVbnRtUWdGNHVpSU5uaW9xSnpGM1RHemRN?=
 =?utf-8?B?aXdaeWFFVFZ1TVFUNHdaMUgxSUp4aGZmb2swS3hlMm1vMkM3Sy9ESXRMdlBv?=
 =?utf-8?B?VUlXOCtHVUNLczR0QTk4eHhPSlZZcTVsM3lXMjNYRXFZdlJFckJuSlg1U1g4?=
 =?utf-8?B?ZzI2bHlGT1BPMFFOa2xHL2FZbkQrMi9raEpuVXpJZko4SkYycldWUlNlWDJr?=
 =?utf-8?B?NmRRY1dpZDNkcU93Y2IwVG9TKy9FSXNZOGxHS0VEWnRySGFqTEFMUEpDaVJX?=
 =?utf-8?B?NUVGL3JCVFJub1BWVlZ1L1A1b3U5NFhneVRSN3o5WXlUZ0RkVjZGWlFKUmZM?=
 =?utf-8?B?OFUybW9VVm9YYWJHVElEOWVwRmdNMzRiMWZFYUdEMWdUZ0RxRFRrK1RUeTFJ?=
 =?utf-8?B?QndhT2J6MnJwNThXLzh0Wk9ERlQ1WVdGWTlLZjN0eEVYZUREdmVsNjFUb291?=
 =?utf-8?B?T2ljV3R0ai9wYVBqSlQ3d2tVaFRsR2V4SXBtOERBaXF1Nm9nWklET05NVThi?=
 =?utf-8?B?bHpETkZQK2ZWRC8zdENZOGticC9HODJMYUhyOWt3ZVREU0dGRHlhSkIzb2FD?=
 =?utf-8?B?SFFBc0NyeDFaa3k2eEZFYVJFeUlyR1F4ZHowdHdTcXhyZmljWW1FUEhBSTJj?=
 =?utf-8?B?SU5YZURxSlNHS1ZIRTZkbjdzT0VuQmNsSmE3OVF5MGRxRU4rQTFmc0NQaDJq?=
 =?utf-8?B?Tno0MFlCbDFmOXBUcElYdkdkUGRpVmorNXhIVWp4ZTVTSytIUnNqcTI0M2Jv?=
 =?utf-8?B?YkdkZ05pQjc3bjIwRlE1SjJqYVRqR3Qydjk4WXhRdkRKMFRlTHQyZjZnSWVD?=
 =?utf-8?B?eC9jZElDYUNXajQzaTVlb3BwWVlNL2NMTCttR3BQVmZwVHF3aHpDMWRNM1B3?=
 =?utf-8?B?K2tKS2RsMnE4WjRGUFNVQ01TdFc0ZldaWlRjVHptSlphbmQzWW8xd3J6dklp?=
 =?utf-8?Q?3PXb1zWzUHoE8jn2/QQdTmK8/q8GCWmjj7BJE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(7416011)(366013)(52116011)(376011)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUFtZHJvcDFNdW1RZGZxdm5DRXJ5WGxWSktoYWlWcGdpYWh3dGtRcUFjZWUv?=
 =?utf-8?B?bzgrdTd6WkkrTmlCUTQrOHZmRjFNb3RIbFd6WktPYkVUMTF1dHp0aGFKQXVM?=
 =?utf-8?B?VmlsMmlERTV2dGt5cEk4dGtUejFzYkhCdENjNko3THlwZXNCZ3NIQU5JTTZW?=
 =?utf-8?B?NkdFY0JUMllSZUFBYWJkQ09aZnV3aWRDdGdLQmIwYzBPWUp5WnMvWlZIUEpE?=
 =?utf-8?B?SGFMQVF0cDhuY2M0SDM0ZFVUWE1VK09XdzJaZ2V3K1EzaDBUcGFPM1NtcjIv?=
 =?utf-8?B?SkJPeFRzNHc2Y2JjMzNuSmdyTEVySXowbnpoNUNod1d3bFJRNUNobmNiRVMy?=
 =?utf-8?B?bWFnbW5XWGM0U0RjN25iVWxhT2FCY1Q5OXRJU3N6b3haSDBNUGEySlVmVTNu?=
 =?utf-8?B?dzhPQmUwYm5TVU5LaUJoZ3JncldDQXdtdVJRMm5hRHlyOUZYbG81cjltZTlI?=
 =?utf-8?B?N294L2xzUFJlTnRqQ1dWTGVHUnovaXRwMGUwQmhValorUzRiYjdtMGFzRVFJ?=
 =?utf-8?B?R0ZidUpvTmcwUlBUOTRKUFZkUU80Q0ZvYTVhTEduVjZZb2JqdVJHNWFJOEVX?=
 =?utf-8?B?cUh3QmhqeC9QT0VHYytzdk9NZW5IbENaTHdWUmRWOFlQM2NYQkluWnhRT3Vy?=
 =?utf-8?B?RTdFNXU4TVB6ZytjK1BOeExvRUwrMHpOZHBGSnhENGZ1bWFUbXJQVUwwdzNI?=
 =?utf-8?B?ODArMkViZ1lTS09MNVdnL2hJV1ZCK25RVUd5bWVXenozdUdLWEg5U2Fwa3JQ?=
 =?utf-8?B?UEpyVzFlNHpucVBPWmxQUjJTSjUyeEdZeFN1S0VkT1U2cU9pN3NaSTFIUVRI?=
 =?utf-8?B?VkxYZ3pVakRvWDVpOVU3SjFLSktURzZjTGU1L2plSkRNOVlwSXNJbVE5QzVU?=
 =?utf-8?B?a1pQZ3VrZGxOMi9RRkpOeWp6SklpWUFvOVpBSDhpVCt0ZEI1dmVkUlVyNklM?=
 =?utf-8?B?dUdFSHJxK29OWkdrV2luNm1PTEQweEhHNURMaFpKVURzbUFKcmpPRVJjZVRj?=
 =?utf-8?B?d0pDYVJCOTVPNCtteWNkYmJZZXFkMnhKTUJYSXF6RnhRYnZQZVVFSHVUNWtp?=
 =?utf-8?B?ZlZ4aDdyR2d2V1drbzBHQjAwUjFCdjN1b0lXY3NFeU1VOC9WKzVQQVpucFd1?=
 =?utf-8?B?VEF2ZlljMEo0S0p2eXNnUVJmOEFOTXhBSnRzaVZLRGhHdmN1REZFMGtBYnFk?=
 =?utf-8?B?TUo0Mis5RlhaZkcwaEwyc01hc1F5V2NKem1KK3dzWEs4S0pqRnhqY3VSenh5?=
 =?utf-8?B?eDdyYXIwV1NWUDRQcmpETS9BS1J6TW9zQjNTdlMyYmhJUkpLU2JmNjNiaHM2?=
 =?utf-8?B?TGpGbG41cnFNc3Z0L1hnNjZYRW41OVp0enNuVFByT09yZkU1NUR0bVREQnha?=
 =?utf-8?B?QWFKMWlscnFsU2R5UjNQYVdiNFJBMmxzR3p1VDE1eFJqdkhIVzNCYjJFUW1W?=
 =?utf-8?B?TTYzc3J2QUhBL2hBNUh2WVJsRWpOUUVYQnlCYk11emNFSHV0dnZiWTQ1QVVj?=
 =?utf-8?B?S1NQaUpnc0Y5anNSME1QajVTYlpSTThhMmdpU3E4Z3NaaHMwcm1QRndvZEZT?=
 =?utf-8?B?bCs2Qk9WTWtTbHVCc25ESmVWS1lXWjY3blcxdll2MjlodGMxSWlwMWZqWkFI?=
 =?utf-8?B?K1ZQQUZ3YjQ1djdwQzBDbndXRnRZczR2TWJLWU5PbjJSRytzL3ZVR3EzdVlr?=
 =?utf-8?B?MEZLUmlOWWJJZlA1clFya1ZSRUJDS2szRFA2NTVzRnloN1pEa1g1bU0yZ3hl?=
 =?utf-8?B?aTdxYjZTYVN2YWRpYXhiV1NiV1J4a1pIQWcxOWdOT0hTY3d5VEZva1czYnNL?=
 =?utf-8?B?NGV2VmQ4WTBhZ2pIV1p5eVg1RWVoVVhOM0lEQmFPNlJXY3VJYldBKzZsQjhj?=
 =?utf-8?B?NzBHNFY2OWNUR2lSMkJtMkVJSS9JcE5SaFJYaTNhSk5oeXkxOFhLSFZ0SHVS?=
 =?utf-8?B?NURmcnprOHB5b3UyRDFaYWZURGQ4eWphQ0xXYVlkdklQeUMzMFdTQUJBdHkz?=
 =?utf-8?B?LzBHK201dHBzUGRMd3YxRG90L1FpQlpmcEE5NWZSM1V4QmtxRExaWVU3NEhm?=
 =?utf-8?B?QXhhaitTdE1mNzJDMXl6ZEtWYVlZQU5VQ0xEaGMrUU9tNmpUdncxaDNaOHZ2?=
 =?utf-8?Q?ItCZ3CsWpMS+gdFdoBxCPsL5y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51137bef-79f3-4217-646e-08dc914a4047
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:58:47.2607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5MJpXElOHKtfBo9Ase65r5xX4HyJWSDPioezltT9P3NsavtE5gGBPTRsw1+mXB932QwkTUZYTvnQkTYuDpEQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7632

Use SPI common DT binding properties 'spi-cs-setup-delay-ns' and
'spi-cs-hold-delay-ns'. If these properties do not exist, fall back to
legacy 'fsl,spi-cs-sck-delay' and 'fsl,spi-sck-cs-delay'.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 0a2730cd07c6a..7c1f8af9d215e 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1018,11 +1018,15 @@ static int dspi_setup(struct spi_device *spi)
 	pdata = dev_get_platdata(&dspi->pdev->dev);
 
 	if (!pdata) {
-		of_property_read_u32(spi->dev.of_node, "fsl,spi-cs-sck-delay",
-				     &cs_sck_delay);
-
-		of_property_read_u32(spi->dev.of_node, "fsl,spi-sck-cs-delay",
-				     &sck_cs_delay);
+		cs_sck_delay = spi_delay_to_ns(&spi->cs_setup, NULL);
+		if (!cs_sck_delay)
+			of_property_read_u32(spi->dev.of_node, "fsl,spi-cs-sck-delay",
+					     &cs_sck_delay);
+
+		sck_cs_delay = spi_delay_to_ns(&spi->cs_hold, NULL);
+		if (!sck_cs_delay)
+			of_property_read_u32(spi->dev.of_node, "fsl,spi-sck-cs-delay",
+					     &sck_cs_delay);
 	} else {
 		cs_sck_delay = pdata->cs_sck_delay;
 		sck_cs_delay = pdata->sck_cs_delay;

-- 
2.34.1


