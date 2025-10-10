Return-Path: <linux-spi+bounces-10539-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD9DBCE5AE
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 21:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958B7188ED9D
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 19:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41E13019D9;
	Fri, 10 Oct 2025 19:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="nosbJxBg"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023129.outbound.protection.outlook.com [40.107.162.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD72F3019B3;
	Fri, 10 Oct 2025 19:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760124063; cv=fail; b=qASpgusUPEUX+mJiBHW+z+GSNYsF6opv4cHIo9ADLD1+hTVgY/kQkLvWgkg+MozEMVU8YvaNMZGzLIdNCZpb9b9BQpl3ApRrLkxzYbnMAJRZCLI9B5NhRSSGm7flBBqOhKDRlb1cYSCcTiUgT9inAa7R0GjkzfBGvSQoryhH1Y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760124063; c=relaxed/simple;
	bh=8l9JymTCgM+epgUzk4VcWqTdwxznhd6zcMGkq7eDAt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qLmZfxJ/YQQz5nmSTzIfrEcsKY4kSCf+KbayuNX6NH3KL+5yk1UiWOcZ5Th1nY4FTKM2Rvsl8BgoVs7gFWtQWXagEm+OiV92JQZBy32Ghd2dHUV0PKO13x80+9oSqBEvm2Tbp5P4X6cpxXc6A3U/PfFAZjc/bHp+eyA8BXAzraI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=nosbJxBg; arc=fail smtp.client-ip=40.107.162.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIdEQhNOOyvGXGIf/ioi/cs7fG4XCNi+SBWKU/Pqyh6Y7t+YOQECK8xp6LB7rorP/FLtic5udIJWRHvnCnBYcoTTo/BmGbjR9FbPzMrcJdZV+FtvAjURsdMEMFMFbNARlE24Q7mRBhVem0aNx9kmh6Sg9XVLTocTHxJ3f7eS117WmiMd/BEoMfEJu1RzvyJpATFX0joAOyuafphJQOqaFnY6hD3Cfzd0kIug3AVPSfFJJV0eCCYXC7016OGRWVhVEIOkuc61i3Oc4oLVUSGa5jfY3BXHX97fykbYg1wqEMaA6lLrwXySF8x/SBQ7Pva1mhqrQnuQw2jQlcrfTUKQkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNX4iO0o0uMaRyxU4/UJ53mvcG+yuhoVl4mVMBYOSyU=;
 b=jrsAXiNZnlY+qMUE3z99oT7ySdfVAaZl9ztiDyfZABPd6wonN4mHLSqwlI2ZrAahtRrizZwyjRbzrsFOKGHc0qAqUPik7nWwFQMOMRU25xDMJBWAFy6aj++Y3JXPyWLxy5JNO2BsT1bo+6VI+vhDBMuEG3a2F1W+EIuaRTUFIjTagTPNtGjQGBO8R8dobyDX4Avf/IFV1G4whcKnf7gGYcI+4nESfFwKFAZE58dgoXK04JTXTAUs+p9dgtGfD7cHbzknR9IJv7jP0oKfAh3FdxoGyty+GHZhHGYHotxjDspncW4jvlgDpaQoGgdKyPQuUvtgsIivEWEyrkTcaHwXXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNX4iO0o0uMaRyxU4/UJ53mvcG+yuhoVl4mVMBYOSyU=;
 b=nosbJxBg3a0PhFp8FfBNFTCzVGQQJ14qFYifkCK09XuYt78wmiOvvYpU3jb9AsoeJWp+tidJlm/OPE1WG8R3twFSGSpveNDx847ML5UCmCXVdVtJONNron/WZmzy189rMiVoQZUNe1Z37P8RG0cppZWi5B1fSeDeeUzpVCojUbSlUtTvM3m0c7uLG+oFasK+IXcAvUTIcFBZf1oRblhQJdmq7uuV/MhJRQs1atHTg3lCzZ/L6y8PcZpBL37bv1UkBuYsZZex6ncCI0W643lo5kOwd5iKqtfesh6QzgHpWfJJSpn9P09olBOobffWCDqXs7UDajPULQiRsi2+BWlbIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DBAPR08MB5784.eurprd08.prod.outlook.com (2603:10a6:10:1a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 19:20:56 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 19:20:56 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v8 07/15] spi: airoha: unify dirmap read/write code
Date: Fri, 10 Oct 2025 22:20:30 +0300
Message-ID: <20251010192038.1592889-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010192038.1592889-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010185940.GA715991-robh@kernel.org>
 <20251010192038.1592889-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0020.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::32) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DBAPR08MB5784:EE_
X-MS-Office365-Filtering-Correlation-Id: fee1812c-2dbd-4710-8122-08de0832230c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ge2QEOIMrEM+DY8JWOCTJpYMhcNQT6UZu4hwTbje5LhwaLMZk1FR/t0K/MzX?=
 =?us-ascii?Q?2bZY3yri1sVA6LQFhnEe4LbVQW+fewGb5NJ5PALR6W+S4Jg3XiNrIJqVsh6u?=
 =?us-ascii?Q?5974hAyIKMqoTH8Qa6cFfol9Mp/9wlk8YdBCr40g/EY65hpvuVvnNCgi+a+n?=
 =?us-ascii?Q?J3mRZBi1sfGNPLY4rOnGZxOIwK/ZeXmL/L+nlb7EuCcckqaK93bPuDurSJsR?=
 =?us-ascii?Q?7Ovs3VVgypfBrjVGZBB6UOP+b86P+Of3XRf3Um//dU5PXLwXQ+lhK7LiLLM1?=
 =?us-ascii?Q?RjUb66wdnJhlneFxG71oFWIgxpjKXiN2RScqk5r5XiVH1XMaqSPtrfuLjMRJ?=
 =?us-ascii?Q?XyT+2edbR6xZyqt8Dcu2hNWhsbdTFpAtwj3hiU1e024QJBpUf74110PLbFLG?=
 =?us-ascii?Q?VINWN6WjgtbicKKjqR5IYy36xvnS12S1UxuRIw7Iha+UowzQpqEWjbtVSVJw?=
 =?us-ascii?Q?bt72NxCsDaluqQEURdXxVmfHrfffj8q2IdC5tylbq6rYtCCN8TKOMtkDSWFE?=
 =?us-ascii?Q?BpoehqJULJ3Xy+N4Vpt61MuS3b8WTM2Oru50CtbumWwgdIq8fC8rapmg56M6?=
 =?us-ascii?Q?HrUyZ/zYohPy42nUYU3W0K2COD/u41pWI/f7IUQGLrV5hm++EbSztMmYdYmO?=
 =?us-ascii?Q?WBvNmZMB7ZwpEtkfzqusFFfD1AqLsBl4PIZbDYeZu4AI9K7LpTgVXpYc0v/l?=
 =?us-ascii?Q?7t3k+RXPjbu/IwtDCP7xue5J3D3GiEwP8xwKepBfWYmkpWLhUGMtIos/0fC5?=
 =?us-ascii?Q?GIl8KuZXoVqDRZwfS4NhHFtleIecA2m2SPNFxg5VFlLKhtc+YB38lS3yjmHa?=
 =?us-ascii?Q?O3bNyaLRyPQXEqu8mXReXergDUO+hYS4doy3YerCybPf6SG9sNwlN354lMj3?=
 =?us-ascii?Q?rHHFNGhu68Bzza14D/+6W4Icz2V3MQQOIrAnSkwRnbZUhZUqbh0vTr2ti0v5?=
 =?us-ascii?Q?2JI4xqvL2EvcUPRp9dFGtPqZIOlOr9Jna87r/j2Kv6OrBOUMPolTyZCJrFrP?=
 =?us-ascii?Q?90fHtlivMrVnMP05gP1UF7+jIxd4aymVA3Je8kJ6PdYwOIRzuVlXRAG5uTzf?=
 =?us-ascii?Q?viDke02OGKYeTbxpgDw3duME5YjiDPGdjWnE0O6lnFKt+oFC2jW84EG9LINs?=
 =?us-ascii?Q?hljMNzP2O2k+nko0O99JEFfeZCeQxcUNnZeDeBh2IL2Yx87s7u8wI3mFmEkV?=
 =?us-ascii?Q?YA033SC+g1k0a3KZfjw0iU+UqiGK/3wMNgSmQL0iDGCQxfd+YljixIyyV5gY?=
 =?us-ascii?Q?gvK9bOSLxiZ6dpsmFwdLfs4ozUHFT96ci5Stg4N3vlkRHZaFhVqbGayIhd4F?=
 =?us-ascii?Q?HMLp/Cs7eSWQeTWlcC9IyTGyHEpPRJcLp4qypQezfzyMtgu17nfXcaIa+ayc?=
 =?us-ascii?Q?m/hrkuodK2B4th2/1Ql2APmrrZdW4pC72Q3gbAjmnR78MAD6mPjGkFiVz27O?=
 =?us-ascii?Q?IBDO1kQujiOUXWr6hUUV+/0QEDgAq4ut+Dt6mqVA2v8Con/KLP8FryAKAxQ4?=
 =?us-ascii?Q?GXvyEBi5LV2w4qbHRL1XeI+hRs1D1CE5526V3YVXCZF8VWcgB1AjjQb14w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kb57TFDN+ecXvIzS2qeKiD1s4Wzd5k+9obw8Q6rZRqtqI6UcobfEQu4L4e1d?=
 =?us-ascii?Q?uYtg+Uk8F9DFtQDMc0Rn30B+YrSVbhNts0KaMxT8QkQ5wYBw6kNUg16jPRnL?=
 =?us-ascii?Q?GSVjgEQvXqb1nIivmh91ji4mF2WEocuQhTsBBwhwPEO495+BdFQHzm00pPnX?=
 =?us-ascii?Q?OuIfOEC6PXg56ivsHt5Pa53d40nxzoy+ZUy4Ey+XEl80mFXlWxbUulx+xyYY?=
 =?us-ascii?Q?n5ed/JQNj+lCdaxozgPTgbq45lkwjGMMAuR9RPGtZJiLp1H3x0m0iuGSb7sM?=
 =?us-ascii?Q?TN5j6FYjXDUDooxjajWeh4xkVm2JGv/QODPVR8Bb6ALOQGGHZWfgVKl/6LxT?=
 =?us-ascii?Q?9KehC9Ogi/Sbs1FGAD/TTEG6b99uE3ng/STOFYRaeFaDemPxU58QQqQ6pJqZ?=
 =?us-ascii?Q?JTI7D8oIitlDYQ2dmW2IK9LZ3NgjTkvl88Cyp0xZU5pu8fPYkDon7xrPR5po?=
 =?us-ascii?Q?onhuaa12aOLQ7npv07BjHCRPLiNDguWC6IjGCwmnZ6Jc+DGsNOWMyZEwwznP?=
 =?us-ascii?Q?BMq91JbgSUjjxKyg/IlWwj1UmJ6i1bt5/cCg9e010BbWTXdj+nHrWV29dw1N?=
 =?us-ascii?Q?gOpTlOprtgfgufefJ1wuKnXV8WKgmj7oA362jPfKOKpyjzJ21NktvE8YT3+o?=
 =?us-ascii?Q?k0WttDAVvsK9u1nbO4tOlq9mj/E4ru+oyN2W46KSLLWb2jdZfQfZgaL/jlUy?=
 =?us-ascii?Q?FGsIx6OzXZDTAnCcmJYrb8xTM/Au6Ynf1eTTebkQzDfVeFVFMPaM5dqbl6zu?=
 =?us-ascii?Q?1fd/ynLT6QfXElaQU8WN7pi9DRMY9yFGg9PnXXdbJ4N0oIEVCwqpjQxmk19b?=
 =?us-ascii?Q?m42O9HRpDMCXU3pHOArPRKCCeaNJkdfT/Wd0vIsiscIK37++FZrClpsVrp6V?=
 =?us-ascii?Q?5/4GBijs7wrvlFQWzilHLfghgmtvvd9l3GR7wptwE/aHDeSILU4TM4M7YEer?=
 =?us-ascii?Q?0gYUUoP/cT9L3IlPzYtFjqSnAniVIfRwMlyrO1BY0Kuz9ZwjsL7tmhXKnV1w?=
 =?us-ascii?Q?qlzsMpx2NeXPzQKnGB4NhCgs0/PIcMW3TTpkIhR0pS/qCLOcFdql4pZdXPVG?=
 =?us-ascii?Q?DzM3EJ/TcWG+TEsfko8Ax+mJi5VoSKPvm+9b7fcZeKH5aj4DYpL0tMfeptUe?=
 =?us-ascii?Q?UkUJ8d9Wjgt3bThTQ5pWMIVVc0rgGs8E86IC/bw/P/FLhypMaiIvx/BZeJGr?=
 =?us-ascii?Q?isGACWSTM+jxbqvfSw8DNZKcdq4kyw43CM+ONPwxAmAjkBhjSeEfpcRRnXux?=
 =?us-ascii?Q?Px6v/4xtnwnuP1nSTnKQCIwyeVs2tx4HPZySWg2RlatjQHM0uGIC5Ooye8ug?=
 =?us-ascii?Q?sijnhRo1GQxO+IQRrM5C2mDdFAM+xT2UlwBI2YyCuoKGWe+dzYWEwJpwajdP?=
 =?us-ascii?Q?9Z7TTX6xcT279n5pu8ZqDJmGqgQCEyxcsNdfjNHelt47msm6VpWkuNh7KZhE?=
 =?us-ascii?Q?7yNbr1QhpcDk7AQaeOpOIsh2kMNvcseIRJ9+W/kz66PdlDXSk2OtgqoeF/N7?=
 =?us-ascii?Q?EyEX70L5BBGUS1oazEWdu1s6a/V3eDqA4cTWrvmgHXPgj1rFi8h8veV3At3z?=
 =?us-ascii?Q?iWBqXQjXS6mkQyTNwg9dOVTbdQMf464ZBydcc8Iq4PWA5pUHkDf4TiKu7suX?=
 =?us-ascii?Q?XQD3cKAR6LdDHXhv7kQIg4A=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: fee1812c-2dbd-4710-8122-08de0832230c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 19:20:56.4322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+L0eXoN+5Q44zQfg42/ahfapjoTOUVPa7wNcNS5HqwTvoqi6A5Gr9+NGk2/titI67Nw8UJdeCEdAVTHeZQPib0HEJEXo3evvk598u/qrfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5784

Makes dirmap writing looks similar to dirmap reading. Just a minor
refactoring, no behavior change is expected.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 50 ++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 5ad3180ac6da..e90fab69d81e 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -672,6 +672,8 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	u32 val, rd_mode;
 	int err;
 
+	as_ctrl = spi_controller_get_devdata(spi->controller);
+
 	switch (op->cmd.opcode) {
 	case SPI_NAND_OP_READ_FROM_CACHE_DUAL:
 		rd_mode = 1;
@@ -684,7 +686,6 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 		break;
 	}
 
-	as_ctrl = spi_controller_get_devdata(spi->controller);
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
 	if (err < 0)
 		return err;
@@ -748,7 +749,7 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* trigger dma start read */
+	/* trigger dma reading */
 	err = regmap_clear_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
 				SPI_NFI_RD_TRIG);
 	if (err)
@@ -806,37 +807,47 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 					 u64 offs, size_t len, const void *buf)
 {
-	struct spi_mem_op *op = &desc->info.op_tmpl;
 	struct spi_device *spi = desc->mem->spi;
 	u8 *txrx_buf = spi_get_ctldata(spi);
 	struct airoha_snand_ctrl *as_ctrl;
 	dma_addr_t dma_addr;
-	u32 wr_mode, val;
+	u32 wr_mode, val, opcode;
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
+	opcode = desc->info.op_tmpl.cmd.opcode;
+	switch (opcode) {
+	case SPI_NAND_OP_PROGRAM_LOAD_SINGLE:
+	case SPI_NAND_OP_PROGRAM_LOAD_RAMDOM_SINGLE:
+		wr_mode = 0;
+		break;
+	case SPI_NAND_OP_PROGRAM_LOAD_QUAD:
+	case SPI_NAND_OP_PROGRAM_LOAD_RAMDON_QUAD:
+		wr_mode = 2;
+		break;
+	default:
+		/* unknown opcode */
+		return -EOPNOTSUPP;
+	}
+
 	memcpy(txrx_buf + offs, buf, len);
-	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
-				  DMA_TO_DEVICE);
-	err = dma_mapping_error(as_ctrl->dev, dma_addr);
-	if (err)
-		return err;
 
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_DMA);
 	if (err < 0)
-		goto error_dma_unmap;
+		return err;
 
 	err = airoha_snand_nfi_config(as_ctrl);
 	if (err)
-		goto error_dma_unmap;
+		goto error_dma_mode_off;
 
-	if (op->cmd.opcode == SPI_NAND_OP_PROGRAM_LOAD_QUAD ||
-	    op->cmd.opcode == SPI_NAND_OP_PROGRAM_LOAD_RAMDON_QUAD)
-		wr_mode = BIT(1);
-	else
-		wr_mode = 0;
+	dma_addr = dma_map_single(as_ctrl->dev, txrx_buf, SPI_NAND_CACHE_SIZE,
+				  DMA_TO_DEVICE);
+	err = dma_mapping_error(as_ctrl->dev, dma_addr);
+	if (err)
+		goto error_dma_mode_off;
 
+	/* set dma addr */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_STRADDR,
 			   dma_addr);
 	if (err)
@@ -850,12 +861,13 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
+	/* set write command */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_PG_CTL1,
-			   FIELD_PREP(SPI_NFI_PG_LOAD_CMD,
-				      op->cmd.opcode));
+			   FIELD_PREP(SPI_NFI_PG_LOAD_CMD, opcode));
 	if (err)
 		goto error_dma_unmap;
 
+	/* set write mode */
 	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_SNF_MISC_CTL,
 			   FIELD_PREP(SPI_NFI_DATA_READ_WR_MODE, wr_mode));
 	if (err)
@@ -887,6 +899,7 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
+	/* trigger dma writing */
 	err = regmap_clear_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
 				SPI_NFI_WR_TRIG);
 	if (err)
@@ -931,6 +944,7 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 error_dma_unmap:
 	dma_unmap_single(as_ctrl->dev, dma_addr, SPI_NAND_CACHE_SIZE,
 			 DMA_TO_DEVICE);
+error_dma_mode_off:
 	airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	return err;
 }
-- 
2.51.0


