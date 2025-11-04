Return-Path: <linux-spi+bounces-10984-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE895C2F100
	for <lists+linux-spi@lfdr.de>; Tue, 04 Nov 2025 04:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5626434A3EA
	for <lists+linux-spi@lfdr.de>; Tue,  4 Nov 2025 03:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD4726E165;
	Tue,  4 Nov 2025 03:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="I2oWyBdR"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011062.outbound.protection.outlook.com [52.101.65.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAF7262FCB;
	Tue,  4 Nov 2025 03:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762225638; cv=fail; b=CWqj5YJ784MvZwBrkS4zx1mjTNRgLlsVobytloCXSW6vJ1sjh9Y884zweIqIjNNloT9JSpLRVBS2100yVyBx40uR98gSdQSn15MTSSL0jBY3qvCvqlEiPW+Hd3rOVtBTmF5eBau+bATQWTNONYDvpCAmVHXDeTJqdRayReFvSYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762225638; c=relaxed/simple;
	bh=qpxqfypfU/9GtfOuVwc2s+5Q4NLrWRwUVpdNjY7TCxM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=MjiWciHc8m0hvZnT7I+YQfdfUCcLPruiGb/LVlfP0tJ6lEE/kD882gBtoLIB2NsFthF9CoQoGR0hR20WEsSQD7PMMohxSRZYuh65F8hgU8Wx2wy+9E/euBW7Yw5K8f4rO8fJT4n2HjPAglp66kK0tG4pr9QDlKsi6aMXlx74+BI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=I2oWyBdR; arc=fail smtp.client-ip=52.101.65.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6GDnpsE5R8VtMywIbqatwUgDEFdjjXyDsLXxr00bOAN0VzXFGBAZOqw/e+F5ruz8RTNul/pwa7xobofa5d2rJA/RGJaAkt4hcZ0ZofaZbS46xUqkOTr4LLq7wUpL+n04yXSYR4aDbWCcxJIDo498LnTaXOLZ9idhvmjpABqJWPruFbbqKSpNAp1stlIITJM9aJFp3776xQNP9kYwni6DfND2K5Qfu9CfeEP8NolC/hRcq7ufPtLIaIZa0jVwIWWk887raBvl8RdR9MM+1UeGRfUc+UqLFEB0nuiCdHL8WnqXpwSWb/gXocufPL9/m8/JIQVECGaqjXiN0i3QrX/UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSMvOxb0c1tN0h/Pda/mbBS2bin75j//Ws9+v5wK31c=;
 b=K30iEQwYMhvEeS5uCUd6v/ouFXOggpr4EIM9CFCjE1HtXnQN4rrbddxCF223/MXMRnGI1yf7FK5DXAwDPJZ62p0Hr8u4/NiH39ClGnMW1YmhfI21N0m9Olg6H84qa5lH85Iuw9VFVp/KTOMoxNXKp2Z80lqoPoViXq5QkFMvL2IOdnxNB72qGlTiYiNZHYraG6qmwfHc4jnS5NZ+Q1scXrmp91iva8Aa4r1WJ0H3sZu+3KlPwgaUN5tq84wK09hfMoLRv37ajHqFN25o2IkWXfoj5QNr9sgdEMgOBORuTjSONKzPK591LmRs9x5+hRbWq6sKvtPwPWTa5PCGbho0KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSMvOxb0c1tN0h/Pda/mbBS2bin75j//Ws9+v5wK31c=;
 b=I2oWyBdREiH5JOlJ+tQ8uTCxW9HRHYz1oHvVICDN69L/ktdJqBzg7mAiCbSd2406haMnASImoJio9XjhOtbhkMd5Lk4Aa501yc8mDBaXEci02BXPhJPBITysIp8Ayc97u4250WtwqajUbkp4NOvnfudMKnZhAjVlXNZ0habDywxgqRQwbdBCSDW2fJDmnOrxcqGpqxoU1ZCFTn7LbRbJaArClOe0N6MJ5jeJYbqjlzqIGjJItMMeSJe3nU1H4RbG4m74TyK2dnydjuzgiKAn+0GK22eh3ICUbztMeuiXdLlyUYpWl4JUYQsBaYqOh2ScCyYv07VNtUrXZ65rUfZXZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PA4PR04MB7806.eurprd04.prod.outlook.com (2603:10a6:102:c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 03:07:13 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9275.015; Tue, 4 Nov 2025
 03:07:13 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH 0/2] Add support for NXP XSPI
Date: Tue, 04 Nov 2025 11:07:35 +0800
Message-Id: <20251104-xspi-v1-0-1502847ade40@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPdtCWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyML3YrigkzdxLRkg0RD81RLcwMLJaDSgqLUtMwKsDHRsbW1AJU7thl
 WAAAA
X-Change-ID: 20251028-xspi-afc0a17e9708
To: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762225682; l=1893;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=qpxqfypfU/9GtfOuVwc2s+5Q4NLrWRwUVpdNjY7TCxM=;
 b=euqJj+ixR0epJvTapEVygPm1SNW9PRK6tDF+SujZF37BA3shyt42gqdqJusAfzzXyYVdmgrkm
 dNo3Cm9wjSXA9ehljszyOEMyTdh44ZNw7Cjj7twSjskZ6D9Yi2P1oh9
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PA4PR04MB7806:EE_
X-MS-Office365-Filtering-Correlation-Id: f8f8123f-2043-4d82-781d-08de1b4f4084
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFhFeUEvU1JvSDRRZWhpSitjVm44SlBEdGJjN2lwcHQxNUhoODRBbnBVSFhu?=
 =?utf-8?B?TmxuUjZTTVI5MnNGY0xkOVlZcTR0QmkrVW5sS3hvYmxMWU5MNVJvWjJxZDkr?=
 =?utf-8?B?WXJKWTFTMXdMNDdkV3FUbzNXOTl0eWY1ZzdhVFo5NS8wS3Ard0diOU4zYVlT?=
 =?utf-8?B?K2dmRmZSSkI5QVFQWlBlSEVBdlZ0blRobG5VMHh1YW9ZRllTc3kwdUlkMFdD?=
 =?utf-8?B?anJERmdCd01GNE84ZjVZaWtzKy9Ic1FoQ2F0cVcyQ042U1JaMUtQdHdxb0t5?=
 =?utf-8?B?ZFJkak5jSUhMdnhmOUg4cUhpTzJnWmhCUCtLdlpPTTJ5d0l0T0J4eUpHR2Mr?=
 =?utf-8?B?Sjh4QU5NVytHU0pZMVliNEMvcTZUQmoxbC9PQXNCSVlMdUpDMmcxVEdMUUQz?=
 =?utf-8?B?dzN3SmJQQTJJbC81QWVFQ0JOTWhuY2xXYzZQRnEwbWVKelRzcEt5QTY2eXhZ?=
 =?utf-8?B?Y1B2YUNucDBaNmdiRzluNGZzT0dFTitzMG9WWmU4UytuaytaYkRDcmhXVTc4?=
 =?utf-8?B?T2dSdERwdzZZL2IvY2dSYXVsTzNsRjJSOUJuVEpHVjNhZmhpRTdxRjQ4MEd1?=
 =?utf-8?B?SVRMbVZ6M3hKWnh6SDliQlJZcXZRMkxEanJVMzZIdXFTTVVwUkl0QmRxSFA0?=
 =?utf-8?B?aTR5Qk9KcDBsTTBraElKUkZveGdlY1MweGJTaFU4MDVNMnlBak15Y3MxZlFF?=
 =?utf-8?B?d3pZeGljMzk1Z1VkOERpT2R4cHdrQlJlbTM2RzVCSEhWMmZkN2F0cDQxSnQr?=
 =?utf-8?B?U3g0ZDFQbUJmTldQb1NJbVIzaStiNXhnUm1mQnFzeDF1czFiRkl3b3F0cjFU?=
 =?utf-8?B?cFV5WjViZFZxK1kyeTZiSkVma2U1aCtXMFRtamFTcHZ0SDJMdVZ0V2NpcHE3?=
 =?utf-8?B?MDIvd3daOHl3QlZBM3RVMDlNS3Nhd2NvMWJWTW5xcFZPSkNJWHBVTnFrMVEy?=
 =?utf-8?B?WjlFNTZ6dHlaOE9qS09NOUQzWTB1MDFuc0pDTGdKN2FKclErS3gzOXB4QTB2?=
 =?utf-8?B?Rng4OUQ3d21QRzVwQmRod24zblkvNGNqRkVHYUN4STUvVVJCRFRneGZ2bEg0?=
 =?utf-8?B?K3ZsaWRiWTY3V2RvdGRjc2tDTHFjY1JJWHo3cENuY1pRSjEvV01zNVp6eFVF?=
 =?utf-8?B?UW9FQ1NWWmtFYmM1emk4bGtYNU9ta24zRVIxTmFlZWp6VUV3ZU1kdVh5T21u?=
 =?utf-8?B?N1lWZXhuazQ5ZmtWSCtjUEltNTJXYWRtZEJGMmdjMlRoMkpkdWxXUXEwcjJT?=
 =?utf-8?B?ejV1TUF1Y3JsbnhPM3lkTnZ6RStIWlRuQjFyY3I3d3JCZEgyN2FkMFhDVlZN?=
 =?utf-8?B?eEc1L2dWM1RJWHV3UXAxb1NVQlVLSmlkbkxoNWY1M2VyL3pzYVJybHFyTHQ4?=
 =?utf-8?B?bEVzTU1WWmdvcXluTmtlZHRMekNUMUdsOGttUHBlQ0d3dmozRlNwSzZjblFG?=
 =?utf-8?B?RHV1VXhyV21wN0V0RStzS1VVbEphSmhpeEhwdkd6ckZqL1JVbm1Md0M0RXN4?=
 =?utf-8?B?YTMvN3k0U0c5ZmdEbFNlbGozQWZldHA1bDRXOTZBYzNkRDNtMkErem81Mi9s?=
 =?utf-8?B?YWp1N0FVT1l0WEwrUjRRRjR3NEpCWEhGY0NkemNtcjVwNFJRWXhRcEhkTUt4?=
 =?utf-8?B?SmQxQmcybWI4ZVFKRXZBQUQxbHR3SnIxN2ZmRm1jaDM4N25NQjVCSFhwbFdX?=
 =?utf-8?B?N1R1a3AyZ3k0cDh3blBnb3c2aHovSFBUVzdoWUlJQzJieUpWNDluckxnQjZi?=
 =?utf-8?B?L2lnS1QwbnRnSSt0Mk5va0RPKzhsWUZxcVNsL041ZDRGQ1QyVHQ4MjltZWNz?=
 =?utf-8?B?NTlxMXgvUDBCc0tremFSYWJTaHA5ZW9ycmo2U3pvNmlMaE4vWW0ySXh6bXFn?=
 =?utf-8?B?MmphdFY5WDlCNlAyS1JRR3lETUpUSmhPS0FqdVRsOUdIUFExMWQ2YkN2N1J2?=
 =?utf-8?B?UWYxaDhTY3ExWUIxN2I2dTJSWXlrLzZtMWJITXdqQ1M5dnExSUdmUnovakY5?=
 =?utf-8?B?QURqMmdkdnRLTlIvRXk2NGVsRFA2cWRKVkZ1dlhPbEtKcHBuQjBSanRLWW5o?=
 =?utf-8?Q?SvXDMQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkN0cXozVVFuV0xKLzFYUmpSK2lqMU5iSERtTVJaMTFaTEZaeGFZNmd0c2F6?=
 =?utf-8?B?SUF0TDg2SisyS0JYU0Y5V0p6LzFqemx3ODhVSnJicmRyM1FmMkxvTENXSlJl?=
 =?utf-8?B?Sk1WbjNLREl2SEhBTVdxUFQ4UGZFeUdIQ1NXZHpWUVkzRko0bFJsV2YrMURC?=
 =?utf-8?B?YlRpem94U1FiM3lMQWhxMTJud3A2YnFYc2hxSlpweGU5QSswZXNMQU5jZGFp?=
 =?utf-8?B?MVMwMVVEeWRqbmNSV0FYeE5IOENEdCtSRWFMZWFweE56Rzg0MlUzWmZkc1RH?=
 =?utf-8?B?dmtEY3lCanJGS1g1RXp3ejRSVEV3UVJuZmdMTmhYSTlFOTNGUU1IY21BVVVX?=
 =?utf-8?B?TFRzeWU3WU9FY2Y4di9BUUJ6YkFVZEZWcXNnOXNkZ1RicUtkU1RFMXhkK1pI?=
 =?utf-8?B?ZVlxWXJxSE1TZ0FiWDJuZXI1YmxRaEVqWnRYVmxYQ1Bqa3FnM210RVIwNzJU?=
 =?utf-8?B?VTRaRmJqV3QyZDNSWXFzaVJYWDNlYnlLUmlaSDd6SENwNisyN08rQjcxR0g5?=
 =?utf-8?B?U1FjZFdKeXNmRUk5V2htNWp1Z2xFaTNjOXh2R0M3N0o2T0Zid0grWVh1MXBY?=
 =?utf-8?B?RDE3ajJoeVZVV2hQUVl6Ny9VWGtndHc1Q3ZDVmloai9naXFsemNMYjZ4OUhH?=
 =?utf-8?B?NzBHTkNFUFBaMDdrOVF6dWYyZTFKTEo2RUR6bm9XYVZMUXJibHZsVDM1OFBm?=
 =?utf-8?B?YlVSQXF1V25ZUW5yMDdQYjBpbDgxRHh5YnNCaXJyak9yVzIvQzkwYWwxV2F2?=
 =?utf-8?B?VzZuM2E3eGVpdlRoUnlKNXRiTXFwbFVEeEtQdmtDRWtWdk9aZlRWM3pGWlBh?=
 =?utf-8?B?ejNSVktERWl0Zmt2M2xnb0FRbzVNN3ZWOG5udTR4ck5lNlhJSE8xdTU5aGxB?=
 =?utf-8?B?Mzg5QzcrRU5PN3FGWVBsUU92eGxtZ1ZYN2w5U2x4aXJEajJ5WFdGNHc1WUtK?=
 =?utf-8?B?R1h3OGJoKzAvcXpUNkpYbHFHTFJLT1JtRGpzRW1vdHUvdW1lSGc3RmY2K2py?=
 =?utf-8?B?azNVeVB3bnQwS2ZJaXBaam5ubWRkQzcvcFMwSEF1bncwVmYwS2p6N2ZHMlBj?=
 =?utf-8?B?azRJd0orOFpicGlkWm5LZzF3eHlwOFBGUFgzYVdVMjVwdGpsditwUCtCUm5s?=
 =?utf-8?B?MVNnT0tyYXkyNVQwd0R3dUhKKysvWTZ1dms0ditYaGM3M0VhbS85VnFFTUlC?=
 =?utf-8?B?WjV1ZUZVc1NBWHpXcWZwWmJ4NGRRaFpMbU05akFLTHBYNnF4Ly83TE9oaGxQ?=
 =?utf-8?B?WExPVGd4Z0QyNUk3VzlBUlpFeTNxeXgyekthM2dwVzY4SVRyTTZidzJVMHdD?=
 =?utf-8?B?ZU1LamtxNjM0aGdMTkp4SGM0QjhVb0tzZ1BvU2FpVmxLbTk2bGdVNjllVGxY?=
 =?utf-8?B?VWRFMkNocE9iMU9BbExUSCs5S3dmNjVsT1JKbXNpTGw5ei9GUmhWQzNqOVF5?=
 =?utf-8?B?QjdTNHR0RkhwZW4weWZtRkpGTS9mTGxzSUttd3NtTGtNVmlNNFY5Y1FzL1B0?=
 =?utf-8?B?MTI1ZVF2aytGYW1OTVNCYWpvN0NIQ3BUbUE3V0VoQjJCbWxFN0p0YUoxOU5m?=
 =?utf-8?B?am9QTldmUGEza1lHYVg0UE1OOUpsZ2NxSmw4R0dNY1RpcGYzZncza3duUEhS?=
 =?utf-8?B?VWpydzNTNmpveVRWSzFqL3M3MGkrTWxWWTUyQXAwU3FsMkF3ZDhWZi9xQVht?=
 =?utf-8?B?YUZ0RENFem0yWVROWXE4amw2aDlOd0Mxc24vTTFyVk1kOXRVbUNKbHJEZ25a?=
 =?utf-8?B?cngyTy93enR3MG02bHdoYUl5Qm5wcjJsVEt5Q1kxVWJzUnpiK1gvWC9ZMC9G?=
 =?utf-8?B?WGdsMUt6dEFwT1hMNzhza1BPQnpCL2kzUlJpdmkydHMxeXl3RStPaFVwS1Ex?=
 =?utf-8?B?VmJ0dEpPWk50aE9aY2hvTmN3OVQxZUIwWHl1R2xsdkJBU2g5WVlFQ1VLMHEr?=
 =?utf-8?B?UVZIY0Fvemc3OGJLSENESi9SUjE5bE5lNldaajhFRXFkdDlXNWhQT0M2MlBk?=
 =?utf-8?B?SGdHMEdCcUN1NHJ4ekRPc3JPbHZvY3c5MTVRNlhmZkpXSUdnYUJsUnBGVSsr?=
 =?utf-8?B?WGViRVBtNUtlZmFFVWZ5ZC9vZmI3RDU5NUY4REd2dUtpNEgrbDZsa29sOWZq?=
 =?utf-8?Q?0u0ehmk4XwJVpr7yVBFxg/5aK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f8123f-2043-4d82-781d-08de1b4f4084
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 03:07:13.7212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TEVWcrN+8NOemu6ACWH2rpNdb+v0VILXZF9a3gyIVMqmiloMppJ/JPefnN0N/IlB2FrMAVgMqogIRaaJPTztsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7806

XSPI is a flexsible SPI host controller which supports up to
2 external devices (2 CS). It support Single/Dual/Quad/Octal
mode data transfer.

The difference between XSPI and Flexspi is XSPI support
multiple independent execution environments (EENVs) for HW
virtualization with some limitations. Each EENV has its own
interrupt and its own set of programming registers that exists
in a specific offset range in the XSPI memory map.
The main environment (EENV0) address space contains all of the
registers for controlling EENV0 plus all of the general XSPI
control and programming registers. The register mnemonics for
the user environments (EENV1 to EENV4) have "_SUB_n" appended
to the mnemonic for the corresponding main-environment register.

Current driver based on EENV0, which means system already give
EENV0 right to linux.

This driver use SPI memory interface of the SPI framework to issue
flash memory operations. Tested this driver with mtd_debug and
UBIFS on NXP i.MX943 EVK board which has one MT35XU512ABA spi nor
flash. NOw this driver has the following key features:
- Support up to OCT DDR mode
- Support AHB read
- Support IP read and IP write
- Support two CS

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
Haibo Chen (2):
      dt-bindings: spi: Document imx94 xspi
      spi: add driver for NXP XSPI controller

 .../devicetree/bindings/spi/spi-nxp-xspi.yaml      |   84 ++
 MAINTAINERS                                        |    9 +
 drivers/spi/Kconfig                                |   10 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-nxp-xspi.c                         | 1430 ++++++++++++++++++++
 5 files changed, 1534 insertions(+)
---
base-commit: f7d2388eeec24966fc4d5cf32d706f0514f29ac5
change-id: 20251028-xspi-afc0a17e9708

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>


