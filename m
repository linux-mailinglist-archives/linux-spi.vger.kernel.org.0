Return-Path: <linux-spi+bounces-9327-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E894B1F017
	for <lists+linux-spi@lfdr.de>; Fri,  8 Aug 2025 23:02:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A35A7B2D9B
	for <lists+linux-spi@lfdr.de>; Fri,  8 Aug 2025 21:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D10A24166E;
	Fri,  8 Aug 2025 21:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="Azm9fjX1"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023080.outbound.protection.outlook.com [52.101.72.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA781F2BB5;
	Fri,  8 Aug 2025 21:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754686923; cv=fail; b=KWTi8FoLBiFCxLCOzxyMuu2ME4WvgHNPs2/dhHr30CDlac6/9wElj87MfPqzWi1FVoGxRIakMm23V6crrGpNM+4bUfxLXc0q6Im2WZ7NIgGJl4yeevIq5AmI+hDlnFvhoGb3xoATXxFViB+IrILPkMsxYaWWzxczG8SdsbDE/mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754686923; c=relaxed/simple;
	bh=RUJ/NlWZxXWuI9sY3h+keyD5BJapOjSnVNWKLjiAp0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Bheu8+9FIu2Uz3GWT83QDPK9eCN0sbLJzuP/AZzJg8ZnDbsqoHKue0py4ilwL5C8GD/Hu2+dhrfFTSCBZUW1RDo4wZOdyU1IPxvuiOF7FdKT0ogCZ8EeLgkEO9iCb5cqKXzZBGJCtv/hznMSiVVwDJLouwTFaqcwvmrzRWkdfKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=Azm9fjX1; arc=fail smtp.client-ip=52.101.72.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4WjgooNBqxp8fUK/NULswFLufqW6pbHhXRr0S1Og24VWvRv10ne/MEt4H0YzbXMvmIO2kXV9OU8ysYGHNcLhb2Q0nPJF9bgWLOIk/KLM7tszrppPTQnikZtvY7Xp1sbkRUKpoI77ghDO0ZoYRgcPUPUS7OxHjvUMRtOvHxSesyNUyerlKP6e3fH7wjx+ggyo3N7xFsylUTlalpTkk/9jTDtllS9e5ywcfoViOU0e5FqSXcNJh9y7/TXAiUa1gSYyxC4EUzTns4P7saQCu9Evw5xYNfUeECT3Ymiqlvg4kNj3GQ7LEPd696SurbMZS7NFusPovsvQasIdmahKJ6JNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkDHTcYtIUZMbVvlZrJWXFspGTX8uHELM6iB87Gsnn8=;
 b=NznaGgyg1hsnG7Dngp92alEEo3HAEs29NLdMIsLzq5hVZAEHAgeUEyUXlcwfEjsB3HxiMinXti85+T+SgRWWqeSiye/FSf7bVbCNwb0iIOQ1HqUlAJYd6i2O22XaYrVbqW/x1lBRq5PjewleJDKwRjUJwlcw9ZabiIVxBkqRiXIXdBKi1rnLgTLYe24UwWee36KepIT1g5tn1EQgFzcFmjmJ0DNxolU+mgVc5SQtj1fo99NmMjtT0wJpSKdmNR6VPwiaw4Dl1KpGkeWyHzYo67DSreTCbFEG6h2PCBRmt9LSVbshe7JVuuFwcKfSrkLWsNMECybOjUrCgAJlv9hqqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkDHTcYtIUZMbVvlZrJWXFspGTX8uHELM6iB87Gsnn8=;
 b=Azm9fjX1fT1qnIyoebMNefh1WZrbZBG+/uHuEy+egnQoa2WL9e4Vq72q71Xzf1Heuif5ceXxUvnUVOPGueZRLeiyok5lNzbTgZNKHmDanermgO5AAyA6l4mxO2Id02aUVgROBDEFQqClTXpxdQQ1k9d6PVfApRY5An75yZ03gS8PgSGLqS9fFXjb9tnSnVsCbT2/USIVExDXyZHskjKZSUSlOwYTdknSWXsr4c+iBhFc+QuqbxgNDPu9B/iyJAV80EoBejCP8JGJeUMu+tFIsU1GTTTaQmtkb7HZtytSdBzpSIxTMAGmM+GSZJuA1STDrUIBdQSsR80PlJVKGrNtdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS2PR08MB9739.eurprd08.prod.outlook.com (2603:10a6:20b:605::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Fri, 8 Aug
 2025 21:01:57 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Fri, 8 Aug 2025
 21:01:57 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
	Martin Kurbanov <mmkurbanov@salutedevices.com>,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v2 0/4] mtd: spinand: fix continuous reading mode support
Date: Sat,  9 Aug 2025 00:01:43 +0300
Message-ID: <20250808210147.3085391-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <87cy98g6ts.fsf@bootlin.com>
References: <87cy98g6ts.fsf@bootlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1P190CA0037.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:52::26)
 To GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS2PR08MB9739:EE_
X-MS-Office365-Filtering-Correlation-Id: 52fcc07e-1ee7-4ef2-12a2-08ddd6becf4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ASJC2BvPJxqrh+5NOUEmP1AVgRNsp8vv7Ohq4znLqXJJdPbbgrFhnWU9Sqfm?=
 =?us-ascii?Q?tO3JK2ZoZDMXI3dzFj0Bm0hYjr1ClTzIBH5CdsVPh63V/hUh06QdAOX8joKx?=
 =?us-ascii?Q?VOzBeMsomDqH/bBy4dwf/74jOWjNxp4UPEWp78bffTjt09chw/jrUJqd6SJ8?=
 =?us-ascii?Q?LCPpmX5wAlE/enh1zAmHTAn5rcNT7h/6jO+tEFHQnWZv+CA2s0+4UEG00Zuu?=
 =?us-ascii?Q?AUd7m1lHwA+RjCAN2js6/TVBvFCAfjWAAnRfIUc/VnNZ4dmgJ68yw/px1skO?=
 =?us-ascii?Q?FUxGed6XCgJ+FQfqPlSsuxanSoJtQxkbmBKEJs42KsRoukNnP71sHKF/hznc?=
 =?us-ascii?Q?w0fFWnGwYn01Q79eHydEGjXHkjjt5xRSxW2XN6FmtilZBTZq7KgVfxlrKkVm?=
 =?us-ascii?Q?92wrNcU6HVDBE3NIS4XQy444i60yvPhSFcWk8A7+Wx2XAUOQH6riNKRHCJAh?=
 =?us-ascii?Q?4fUoilH3nf1usZkxeMLIK1CLJIceJVPlBFQIKIvKcBp4XV2LGewk1rQc98GX?=
 =?us-ascii?Q?f7yAzzAXFZRycAFcb3jkz3WoldTmc8Vsa3sMOA0NYeQiPagJ5wIjmfiGQxAA?=
 =?us-ascii?Q?NyC8u32vQESzboCqJHSqUkabT9BICjLFaVZoZtIox460ueVANNd6BKsCs0N/?=
 =?us-ascii?Q?9lbPYfpghuJINUsqy5lighd1uyEXfZR+dnr5tf8eYcDzs/nGci1UK7Sc0Lv8?=
 =?us-ascii?Q?hA43bC6BKaEeGxJcPx836adGuUZQanR9N7laT5xr6p5CqFexHtw2FQJimD4j?=
 =?us-ascii?Q?b57I33dxmDOeCJeSxqzFHmOYXym6AdvtfjNBwAz9FpHl4Eo5hNQ9qfr4aBxI?=
 =?us-ascii?Q?CfAPmnKNCO+HtMyFRpO7M7TjeY5DsMr0OB1hi1cUssZt52xJEE9US76MJ94u?=
 =?us-ascii?Q?+10md5uygEvuber1L0Lzc5e2L678zDqQKnkovDh3RhQmJa44crChah8vo1Wq?=
 =?us-ascii?Q?/GJlI346gZatBujD9FZjD507k6viaSq/gt6cXCzOLYb08d17QmkMbHj3nHb4?=
 =?us-ascii?Q?d9a0H0xZcAkIzPP0dfWavd3zVh0py1Myl/3eYqKMYyNIDAdjBxeugf1JV927?=
 =?us-ascii?Q?GsH51l4BMz/oIuCQkBJOEqaZJtZyhZY6WAptsot9fUD7pQ8uoXqamzCSdCb/?=
 =?us-ascii?Q?3FQYZ+jRIUOsuhmGowrwWEL9VlP/67SW1YY0PDxorLokcel1K2KlyVeJVoBo?=
 =?us-ascii?Q?BtT+7jQB4XrW1586HgyT9erkvRGiMRJkpL5rLxF6JiSI7IXL/M7/VMf/WwmV?=
 =?us-ascii?Q?QyMjLbFuPBrTIRioMPGYFJG9/cGnDqX8XfkI+D0+4FHmttwPJ8eiGBl0wRAH?=
 =?us-ascii?Q?KR3aV9NjtJ0LRudjK34DRgt6XitvtQTRehe4CnfgpGIimRt7QsvboEXTUc9v?=
 =?us-ascii?Q?6YjHEenDKMeYUCcLmCuk2TfkiunXhA/2zya1UVzOn1hgIgDZBGT8QAGLddLJ?=
 =?us-ascii?Q?7SYI36O9PVr2uLWHHHAVzv+ZUSZyYgMmJMtzLXs8Fd/EkdpDYUT2Ge2fsnnW?=
 =?us-ascii?Q?ardYVljA/RpXaJY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ne/lzDBAWAJdG618AC9CZGr2JlTp5BMTo+4voxAg62POUmVvGasL6QYWGG+u?=
 =?us-ascii?Q?7vuFsErecb//bKcqffArvEF6+kQF9sHxwdt0SlfFQdo7WoV68Hqmr1HqtmWN?=
 =?us-ascii?Q?JDiiTh4ixcto+b4qIbNjVfehyBMFmWSQgYKEgUsEIL75cB8lPjuuuzOgoguD?=
 =?us-ascii?Q?KPCsI3yaiUP+ASo/KDWwMK9lhnaLl119bKOjhe7DQfHzcwVjZm19QELrAQS3?=
 =?us-ascii?Q?wHIKThj+IHIdqyennLXa28nZ344ujZJqbHlEDleunUkZZHGIFPooeoCHVuMj?=
 =?us-ascii?Q?ByDEhBXJFtxox1sjOHsm5haNKduGFPQhGAre2Y2aotugwFuwCUlkqnRVIYa9?=
 =?us-ascii?Q?Z1/yP23yJiYsIii+B94PYA7Pt3+pbVQMEK0Z7m12L4tKnWNq1LEbX211V51O?=
 =?us-ascii?Q?WETG3hQBXo+cH0zA2y7w+B7lzZCWsVS+crPhKrhfvcDjY6Wj6ShHWbTS6UPH?=
 =?us-ascii?Q?ewqRIJxl24tAKkbDKQ+/kB/FqeaFzldsHWFtxcj1Xs/w/9ML1fIPlZ4c7oqy?=
 =?us-ascii?Q?aVOkvaQE5bpm5pnQQ/xwJCUpNHqYoAD6Kp35b9ouEoYP8H1geDuXHpbKzLzB?=
 =?us-ascii?Q?AjrpRTVbL1Hkra0AClZJenYGipgFlb9SJ+fKmHXetp//nKSPmBVGDpdT1SrW?=
 =?us-ascii?Q?JYpC6S9mJ0BDqRlqpCXg4myjvSmaW0vfgdJtmKmJL0ZkXtVuLdjhwabRB+nq?=
 =?us-ascii?Q?OooudXcNDXidHDTJvX9iteMyhJOrDlp3Hxmu2ZyKvEz2+lsmzIULxdhOIK5m?=
 =?us-ascii?Q?pS7WOdom7rwMDRDBLfWbr2s0KG2eE+Yxvzb1B4bTcmdCZDu9Z3Y/KBCwcbUA?=
 =?us-ascii?Q?ChTkqhXKPYL+oyojfJMRy7rZawI6qBAbQPhseu/9Fu1hSTfLYMNMZ7AO6J7P?=
 =?us-ascii?Q?ko6VyhyY4MtrUqesF5PBGeY5YdCBU7mXZETm+xOIF3aWhPUp4xuyEXofkYEq?=
 =?us-ascii?Q?FWGPa0tZBFpCYJpqy2wRKpf/7dJqNixiOgUw3gz6gzaiW8djCZwQcGhYFxGg?=
 =?us-ascii?Q?nhFnfZnjQXXDZbaykEVoL/bSk90ipeH7mXRphS1iw5RnT82X+13Up+BgS8Nl?=
 =?us-ascii?Q?f1b9XCLK8NYYHvXvAA1EHrTcnm2TB24x/mkEQUMByg2+Hga4TAptdEmbvU20?=
 =?us-ascii?Q?KVnm7RYYSXCWnpW2B6gslSZgg7+p0EAVIyKD5jZ5g6nk2zgj5nD7VrvZt+dc?=
 =?us-ascii?Q?RX3+zPCWO5qC+eyt5e2G5Kj6c4SQDFfX1d4V4zPRchExyUzn5+7lveKlZAJn?=
 =?us-ascii?Q?ENFAv+H1aqYJZG5/bOku+0hnplD8xahkeJ4wJlQ9+ldXUAzNCfbDzTOWsz5J?=
 =?us-ascii?Q?AxXKDlpSgl19GYpuaNbqDlebB0yBEBHe21vEEtNU0NHPftxpu2pT4OmSV1bC?=
 =?us-ascii?Q?jK7vRuWynmI2bPXcsa/5pSXUs0a9VAqAEX9SPxXq1TP39Tq4LjZ3YVoCJmSv?=
 =?us-ascii?Q?UGCLQ2J4788Z2yz6k8ZoXiFrL4iv9VBIKm1eDmI+50NvTBwMMxLrgFUJMlaY?=
 =?us-ascii?Q?NUNzpnKhU9xZlPWsdTuMVd0DseqTJaUfeLrydWqkvBrI/b0WEmlzCGzwFzbE?=
 =?us-ascii?Q?w0eJC8AnmlA2w4X7jtHOGnqgmnBbtEVRPhGRcvnv2/i989f/s04A6aujq2pD?=
 =?us-ascii?Q?AA=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 52fcc07e-1ee7-4ef2-12a2-08ddd6becf4d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 21:01:57.0595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xa1tj+pBlf54fSzKpQUSxb4EAG3UimOaAnxlgCRvB/MB5tyKg20JLMUh1bORAR5siTASrwM22Or6ZZyUMNUGFqkO8hIDbCyw+LBncmS5oJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9739

Continuous reading mode is broken for some spi controllers. This may lead
to errors during reading of more than one flash page at once. This patch
series improve continuous mode support and add a fallback to regular
reading method if continuous reading is not supported by spi controller.

Changes v2:
 * added helper to create reading dirmap descriptor
 * fix spelling
 * error code is not used for regular reading fallback anymore
 * it's possible (but very unlucky) that someone will do raw reading
   of the flash in continuous mode (i.e. without OOB), so fix dirmap
   creation for that case.

Mikhail Kshevetskiy (4):
  mtd: spinand: fix direct mapping creation sizes.
  mtd: spinand: try a regular dirmap if creating a dirmap for continuous
    reading fails
  mtd: spinand: repeat reading in regular mode if continuous reading
    fails
  spi: spi-airoha-snfi: return an error for continuous mode dirmap
    creation cases

 drivers/mtd/nand/spi/core.c   | 88 +++++++++++++++++++++++++++--------
 drivers/spi/spi-airoha-snfi.c |  4 ++
 2 files changed, 72 insertions(+), 20 deletions(-)

-- 
2.47.2


