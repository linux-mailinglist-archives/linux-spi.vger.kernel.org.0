Return-Path: <linux-spi+bounces-9547-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 241B1B2D951
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 11:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4F26A20AAC
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 09:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CF1230981;
	Wed, 20 Aug 2025 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="5h2vI/n7"
X-Original-To: linux-spi@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023079.outbound.protection.outlook.com [40.107.159.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78727221FC7;
	Wed, 20 Aug 2025 09:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755683359; cv=fail; b=UxN6YofhWv3+sPrwTlmuYHU6pUXm+qdkI0vhgTangb5i31XZpzk8jGcjDCR3Gz6saVtWJ9BUqn53EYi5+KaBLwrwVVmou5yBnG+fM+89cENIsr4YhKy0uA9OyRPRZe8tOBk3/K4RMU5AfqQkwEbNA6+JvnD4iOJ4HHa2oDnOlmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755683359; c=relaxed/simple;
	bh=g9i1oBURNLeyRxps0JxepzLZ7pq47oD1CA792qvWQ8k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OTKXg2Tfl4rK30Bws00uA1gUwurz/rtpUJ8fl50YwsfIipch15z3RCeSKb+CX7LmnKqUp1O+r77eNhKLddyelTlUTDbevopA3Kk9QQP+dr/ynOezz1k8RRjv3yicqaQdzShZMMP/JPhUj918+D0+RBcTaFZFzbRjFjuQt8RDMu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=5h2vI/n7; arc=fail smtp.client-ip=40.107.159.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2IGr+xXAIu6vL18hPk0CzomKwLtZTmspuZwvK9G2aGY9tVRDDNrZU0CHIjsJltiYmXwbFjpQ4IkCoaM+dCRebppG0t0TvtfMQQpnH/iZL01EOXz4RFD9206Sr9CIKoQGiwG/J6iKYVZa4akhJLo7IQaUq8/vN0CTICRK+ZeUJBuHGqW8JdOmduk3Hwv9q362F1A/p2vik/ynGUgKujSLLSto0uF0fIMqdFoVmxyI3QI2jShSS6d6fa+iCPDQxUZmuFeIY+dkoK93sMS1WJzGsioj3yQn11ozkWtSsUHEAM13lGFsWXnl3Mmq5Bs0fajP+QMNMwj8vUvunuhCwhVRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g9i1oBURNLeyRxps0JxepzLZ7pq47oD1CA792qvWQ8k=;
 b=qfGD31OVf84crgqiToFQqkmQXDZY3Hyv/Su28iXg3czWWwhGToeglhuTSQtZ4Bg7Y359MPWnN/Y/WUZ83mmprdojjzn1BOcd4+Hi4SsDETGWdW8dBwLaV+1R848+5oW+LzuM1P2pyndWfyplvO/kkhUmBWsZNJGu6RAzRA93RryVwvpNHuSZ67mSelo23SVBhKxe/+KJnSUCFh4W9U6iREmKT6EHeSLVNFGyn1vejYhdDhRldkb8W6zvgcZTn3hyQ5Nc2ybmrb3kYz0ORSvTwb4IImXOrYe9R7WnJNUPFmf7tkN5FCmnnMKWmSi/kGWfX0F+xLAmkThS4gbVDrsYMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g9i1oBURNLeyRxps0JxepzLZ7pq47oD1CA792qvWQ8k=;
 b=5h2vI/n78p6yf/bOkdwY/zJ7DwTbraeodizQkrMfT0vEvphY5P+YodfY3hYHfhQ/gMgER5crcCGFMSln5gFTkfXLwOn+Z6hrg/d67RKjeMn5cjHyZcODs5Fq8rqSiz5K9QbadshC47XSb0Xx60b32cEfKSi3gt1PjSuyS2w2+itmb495wVNOxk/9rkk3bqyRFnNxJIGmEg4uoCrbM65iyVfhWOo3G18tqRHgL1We9SHUazAzO4EwICYa3VTI7Ld/a4Evn83s4cCpCyWTCUcxJdW+LZZnZR0p5SL4WixR1bj41t16RSz1Rj+80Fa3WPRA4X6FMZP2frv1CGlOjAw2fA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS1PR08MB7450.eurprd08.prod.outlook.com (2603:10a6:20b:4de::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 20 Aug
 2025 09:49:12 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Wed, 20 Aug 2025
 09:49:11 +0000
Message-ID: <3e82cb6e-7edd-432c-9a3b-60e78c873b14@iopsys.eu>
Date: Wed, 20 Aug 2025 12:49:09 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 4/4] spi: spi-airoha-snfi: return an error for
 continuous mode dirmap creation cases
To: Frieder Schrempf <frieder.schrempf@kontron.de>,
 Mark Brown <broonie@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ray Liu <ray.liu@airoha.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Martin Kurbanov <mmkurbanov@salutedevices.com>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
References: <20250814065423.3980305-1-mikhail.kshevetskiy@iopsys.eu>
 <20250814065423.3980305-5-mikhail.kshevetskiy@iopsys.eu>
 <78542bbe-1def-4aca-8424-cc26542d9762@sirena.org.uk>
 <e8f77b06-b47c-456e-8671-ac8ae573af64@iopsys.eu>
 <a18185a0-407c-4a1c-b915-fec9b3283b87@kontron.de>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <a18185a0-407c-4a1c-b915-fec9b3283b87@kontron.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF00007A7C.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::607) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS1PR08MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a9bc90c-4443-4de5-d179-08dddfced0d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cldxYlAyMi9Va1hxRW85OTR3VXFkTHFCVmZFZnZOOFVFeHhCYjgvSkhqUG42?=
 =?utf-8?B?dnJ3Y2ZwOXE0d2R6b0xOOW1UV0QrU3d5aVllMnU1ci8rM2wvU1p0cGJBOU85?=
 =?utf-8?B?UWVNN29aREZRa0Q2Wm5rYTNPMDdNdEZ4Si9ScnRxd0UvcytTQ1M1QVZhUDg3?=
 =?utf-8?B?WHJ2YmtlWDJDZHJkcWVLMWFNdGRMclo2cmhQdENJQnBDblJZelVkd3BvYnRo?=
 =?utf-8?B?MGN6NXFEVTVkN3dyRGxOZzlQOXZsM2wxclpIclNtUUY4R3dIVFVEcEVtSEpO?=
 =?utf-8?B?ell2cDJZaHo3aGJ0aldoUUFDakJZVmtNNnI5ZWorMUJpaXZmMkI1TCtZaGJy?=
 =?utf-8?B?RTRrYmJGM0VmWGFpME5ZSnlaTHlWK3pXTnpRTTh5eTByc0hidTQ1OG4xd20v?=
 =?utf-8?B?YU52TE5lZUJDM1UvbHdwYmFUWXpCTXk1Ly9adzM5RmFIQ25zYW9zM01kRXZk?=
 =?utf-8?B?YlZpVFNyNldpUmZsWkZtRmIwU3FnYWdmclh0VFJaVndwMHlSNEZIL21iaFJt?=
 =?utf-8?B?ZmhJVGN0WkQvYkZ3WG0yNXZqMCtsa0ppN2o2ZUtqUndJQlFycTBYbVBwVzQ0?=
 =?utf-8?B?azN2dmpwNzdrRWkyNE1Rb2UzOFREL0E1cUNMQ0NMcEplNTZjcEhvWmV5THk5?=
 =?utf-8?B?cEFYSnlHdFpqcXM1aVZ6L0xTS3hvOXhGWWNGVGNuZUxINVUxUFN3VUpaNC83?=
 =?utf-8?B?bGZXQkVXNy9HMEJqZTBpQ2l4KzF4Y09XdnMvQ2Rmd2NRWHNITVAvaE53R2ha?=
 =?utf-8?B?NTMxRHFYOVd3YUhFS2M5Zy9VakxreFp6eXJrNEoyNUR6T1NweFJZcWZ2V0E5?=
 =?utf-8?B?bXg4OENRTWlmamxvd1J0TGlybFZRTWNRNXRZMU5xNGZ1eCtBY2JwSi81dDJw?=
 =?utf-8?B?OUVYSUF4aWlPRndYU1ZUNW5NdnBBL1JJUEpYY0FzYkdxSTA2WnJLNGs0bTNH?=
 =?utf-8?B?TkRhb2dJKyswOVpWRHA0Q29FNnJrL1lFMGs5UDVVdk5aUWxQL1MwVHZIV0dW?=
 =?utf-8?B?dGRINWpnRk90YnMzUi9ZaGtBcUN6ejhaNWkyN1BFMFhYNjVHTEpCcm9MUk9u?=
 =?utf-8?B?OTArYzEweTBVd1BoQ0RVZVVtdXNsUTFKQ3RoYXdtRCtDVldRZDd0ME03ZkY5?=
 =?utf-8?B?bDdieDkzR1Z2cURXTDBVY3RXb3B5YTZYbzVMR1VFMDdMNi9BNGN3Z041Nm1n?=
 =?utf-8?B?UEF5Z25rL2ZGcXFHdGltZURDb2ljMW93QmdaQzVuMVc3SkpqYlQxMlFhVW8v?=
 =?utf-8?B?Q3RqU204TnZGa2FEeitnUExpVXFmck1OS3dFcDdtekZKdHB0SnRyb3pRaGhy?=
 =?utf-8?B?NnlKUVFVb3ZqUFNhOEsrdzBkRzJDb0ZiRGhPZmR6a1J1WWJzdWs2V3RBTEM1?=
 =?utf-8?B?VFUxSWQxVFNIcFdPVVQ1WWFONEhlekZ1czlrUG96bGFMeURmWmlBTlQ5ODdO?=
 =?utf-8?B?NGZjLzdtZ3F4cmkrUU5MclZUUkFYQURTUlZLbDQ3bzFFdy8rNDRaeE5vNmp1?=
 =?utf-8?B?cWU3QWtSNkZxeWFSYjZRNlQ3K0o0M01adEtEZFRFbHdydEtMUUUzQW9HOWsx?=
 =?utf-8?B?L3ZpaE1qR0E0bGJCYWdrWjNDY3pPei9hK2l1RG1GSmxtVTM2ZkZmMWxOYUc3?=
 =?utf-8?B?SEc4ajFwa1BJeXlPRWptM2diQzZsL0l1Q1dvWGNqWDRMbWxFMWl3QVZkMzRt?=
 =?utf-8?B?Y2JZZDFjdFlxYkFtdHBod1hPRXJSODFocmFybzNlK2lXdmVzOUdNT0pzZ3Qr?=
 =?utf-8?B?Z1RMbGRnT1E1WWthOVZzK0kvWDFWSk93eWxkR3E4U0VtQ3pzRDRWdXhsWi9o?=
 =?utf-8?B?RVYzWmUzVHB4Zmx5MDVYVDFHeVVZbzFSQlJHZmVjSEgwbkl0MGhrMS9mS1dk?=
 =?utf-8?B?ajgraUNDaDQzeEo4NW1nQ1lPRG9yMUtDeTNEcFdHTW52WmllVTNrUGxDNmgr?=
 =?utf-8?Q?2X0vfP8+MoU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUZsdkovQlRoUlhaSDA2ZzNQOVpWK0lGQkFvanNNR2Vwa0dwUFQrOGQreDdh?=
 =?utf-8?B?MDJ0NVZrcFhVS0pHUDg5K2pMeG9SWHJ4djR5U0JrSFZWUXVjNEJiUnloWlNv?=
 =?utf-8?B?VVZGWWtSa3RiSWpDNFhuSXlBN0l1NmZWYlZUcW9YL2VsYThGMUlGWjc5Y1Ex?=
 =?utf-8?B?ZzZYVi9RZlN0K3JISjUweHI1anZSSFhKMWIxV0ZKcG9BeHV3dlg2NnRIVFpZ?=
 =?utf-8?B?YWlsa2trS25xSWJZRHFEcjRiVW4zRWh0dFhPell3QW9ocERvYXVhN1lvRDQv?=
 =?utf-8?B?VFEyMmV2cDF3RDljT3Awc1JvZGdpODc1amRTOXhjelJJcXpKa3Jrek1GaFNB?=
 =?utf-8?B?TklPdWhDYytIcnJBRldoVVF5SkJHQjgvUG50YWNZVThPdHZjUmRWOHR4L1Zk?=
 =?utf-8?B?UHMrK2Q2M0FacEVlRHRzcmk2S3JzWDM1NTJUWEc3WVlVREVJUHRkTWljMHJt?=
 =?utf-8?B?dHM0Mzdjc1VxcW1NRjJ2dUxrakx3RXczSFNzV1VEdGx2SENNV3lOMkM1M3dV?=
 =?utf-8?B?bldEaW0vaDEvdVUwMHp1VmQ0SFh4amxwSWxJYXhEMTVIV2tNRGQ3YXpZT0RY?=
 =?utf-8?B?UUkyUVp1bWUvS20yLzkvdUgzZElMNXQ0WjVzaFRPYXZHc1hWR2VBZSs5QnVo?=
 =?utf-8?B?ZVlMQ3l1U3lrWmlyVWJHbEUvTE1tUnJvUXNYUmhzWmpHVmVESUE4cW44alZv?=
 =?utf-8?B?Y1dtZHRiRFBNTktRaVZVSlhNVVFrYXJJZUFUZStzamhsZUxTd3JudFlLRGhM?=
 =?utf-8?B?Sk5pU2paSnpybHE1Z3NiS3ZDc25hZk1QNmdEWkxpSm90cmV1Wm1SMXU4SnpC?=
 =?utf-8?B?aDZiYnhzdjN2SEdGQ1JucWdaQ01QNEZLc29LWnFyaGRKZ09HVGJGd3JrME13?=
 =?utf-8?B?cjVKeU54MTA4WmQrN0NGdTJWalFmUUNuTVdxbXVGT044b2lNMXRCTlB6RjNO?=
 =?utf-8?B?NmRTL2EyS2d6QU1hZXZhRXdSTnF4VDZIdmY1Q2cxMkI4SkhySTNTdWtjUjNL?=
 =?utf-8?B?K0hZZ3lNOXMvMVVMMWVYNlVZdDJjVzVaRUxqMTFpOFhwL3dhWmtOUWJZbm04?=
 =?utf-8?B?SUt2bTd2VVljUkh3aGtrYkFyYnV4SnJ0YmFoNlBSNEVONHVNUGZyTkQzMFJy?=
 =?utf-8?B?K0RmL3FuaXE4R0ljdzNyNm5WVHNMcU44eS9VR0FvbkhaWThkYzBqZERXOVl6?=
 =?utf-8?B?K0x6b2RCUDQwRUYramZUbWZXM3krcWxsU29lQ1pOZXpLLzJzUUtJNXN4MGp4?=
 =?utf-8?B?bkVGUDdWMTRIQ01qTjlJa2k3VEdwTUNoVW9yQmxld1FuSVBZNFJPeU9IcHpo?=
 =?utf-8?B?K1J6QmxBczgyUFpTTlE4eG4yc1QrQ3VBV0ErelUrS2pwNFdHS1pzRksvRHVh?=
 =?utf-8?B?eFNjc3ZJK0h1bXkvWEpFVHk4clZZT2RzdE05VGV3TVY2Q2RFK0J2K3cybmdM?=
 =?utf-8?B?Y2N5c3BVMXVuQXI0Y3lGYmxCQ0FYaWV2bnlBZW9jNHhYL09zQjBvYlgyc0E2?=
 =?utf-8?B?LzBodmllTElkWWxwcktZYmdGNXRPTG5KV2lXdkZJWU9EMk9zUWlwRHVVOUpH?=
 =?utf-8?B?Ymh1Z3cvL2U0NHo5c2Jybm50RVBxT2ZKc3RMWWg1NXF4bE5UNjNhbW1BRGh0?=
 =?utf-8?B?bkR0Z0IwWFFZdjJ6UUpHcUsyY0FWVVpRdFlSVE9xTlRhSmZpMU5zeGZudTV0?=
 =?utf-8?B?cVp6TGJuNHVQK1ExMDl5aUxVb095ZXdvVVpzS2ZXL1JDd1JKbDNhSnhzZU53?=
 =?utf-8?B?aUgrUmEvOTJHdHZ5eHRXTWhoSHM1dnRJUHl1TjlYd1lqZk90b2ZRTUZWQmR4?=
 =?utf-8?B?TTN2cXV2bUcwWUJVc0NvdDlramlrMEk1SkNyYWIzSUxUbDZNaHRKK3ExT1Ri?=
 =?utf-8?B?RUVVaXNkNmFmU21zaDVlc3NVQ2Q3TmFJa1NOMXNYZnROL1Q1Z0lhOTZrQndt?=
 =?utf-8?B?RjdyUFpmaE9kRnpETXo0ZTBzT0dJREpVK0g2ci92LzNTbmYxaVpYVGdUZm1m?=
 =?utf-8?B?VkovbkR4SVRwbisrTzJpTW04aGJMMS9iVXpPZFJBc1RIZ3UwKzBPYzFTUUFK?=
 =?utf-8?B?OGxadXJOL0tLZjhXbzlmeVdTalBuTHl6MnJVcU8zQmo2U2taYkZ0UXRpdzZo?=
 =?utf-8?B?YXNaL08rZVZpdDhJOEpJMnZ4cHptNTNPcTZENjNmdmZkbE02NUJTTUFKcmJl?=
 =?utf-8?Q?4u11+f4Ex4A1Nff32JzVclM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9bc90c-4443-4de5-d179-08dddfced0d5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 09:49:11.8049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXmD9Jn1RurULeYN2be/SyFExTTWlDCCtArZmZOJ9qTGyXulV2Kan5xHfBV7dW1+nOHAfZwg07mlpWb3wMOj3tl/bToHCeOt2QSo1DwFw18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7450

On 20.08.2025 11:49, Frieder Schrempf wrote:
> Am 14.08.25 um 17:33 schrieb Mikhail Kshevetskiy:
>> On 14.08.2025 18:29, Mark Brown wrote:
>>> On Thu, Aug 14, 2025 at 09:54:23AM +0300, Mikhail Kshevetskiy wrote:
>>>> This driver can accelerate single page operations only, thus
>>>> continuous reading mode should not be used.
>>>>
>>>> Continuous reading will use sizes up to the size of one erase block.
>>>> This size is much larger than the size of single flash page. Use this
>>>> difference to identify continuous reading and return an error.
>>> This seems like it just applies anyway regardless of the rest of the
>>> series?
>> Could you provide a link? I do not see this in upstream linux repo.
> Mark asked if this could be applied without the other patches of this
> series through his SPI tree and I think that is indeed correct. The
> other patches are still being reviewed and applied via the MTD tree.
Thanks for clarification. I could add it to other aihoha spi driver fixes.

Mikhail

