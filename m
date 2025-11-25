Return-Path: <linux-spi+bounces-11492-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A83C83120
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 03:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66C724E4C80
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 02:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4A121C84D7;
	Tue, 25 Nov 2025 02:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="m15ZKxn3"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020129.outbound.protection.outlook.com [52.101.69.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F451A38F9;
	Tue, 25 Nov 2025 02:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764036675; cv=fail; b=LOv75Hz52PQEcxshzBrT1Y6PD5hDAbYpO/wsnWmfiY6W/PEAiRIV4HoigLFCzG+9DSqppJ4FxAI+PN8KvoblomF2fxXyzmp+mfnjDF8JHTivkYYR/UpwWFkYzkZt46iD4055QjxNztz0aK7dU9qeyrXlLKvIYPUFGE2EIPq6hTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764036675; c=relaxed/simple;
	bh=BVV2d1iMGgU8oQGGzRXJBwchTlNY7Ur5147G2AagNbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VrBiDWpbT9q2r/MS0lwThS3YAWmoGGJ9SwwMLQTNALIyDjiAGjKC82qSxIsiG/ixPGdWC+B3ObbTc5IXSlDA0sdt489wCV15pahLOxFZ45GCriRDucjIy4WRLZyO5s/XreIYLZXoMd9VkzI1XE24hWD0CwGCJCky9/NMxMCRDC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=m15ZKxn3; arc=fail smtp.client-ip=52.101.69.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azNFB4qSSn9vWv7bDKBhrb/dX8MNndHGRUrW52/V1p5vKYFJmydGgwhk3Bd8Dg+BSKAr+MsZqvUVxEOGISXBwxnhJChho6JsBDRiRCbon54gf3juGKLh9OHtjf0s2fD+LAWeW66JxT4IJtsUGW6Z7Bn80Z2GbHtjzbL1eugmaObjIRPdL04HnbDghH5tL7kRODF2apNdn+dM2bIbtuHrY7KulzP+2odHuwZ7yzTvlhL2s2cRRKEqMB/uiYYh3PMNa+rlA6ibHSvF0C94m1MREGN+joiUXsMHTh+VqqYadmZWu0HfOByZHJNvGbs7OsM8GLy/C7gn7gweckTwtNEwkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/uk6YN3wWeimPkLE8tq8o174MVIYE7GvKzJVvEYf00=;
 b=djkUaub3FrlU2FoZdj/d63YD+A41Tz4ACPuwfynn7Or45bG2io61MEnXB70an7We+eZoIfD/6NrQWTImABmqjqgrzCsXlx5ee2slU2w+Z3x/Q4i6OEE9mp5vS8r1RUQAp3Fo5VGN21Y9xXMdf3HiRdHW9LlRs2ZairR1/CrrB+4dEd8alOjhnQEtT0ZtXwavYcQMfjAZYBtpMG9150T3TadIS16+I4gmydV4AqygWxe/0DI8SjtB7HrJmFdSHESEhds5CYx1CR7M/cSN6ktgUuEsJNUpTSELd7XyotsoBCZA6FlkRIfqDgoF7P4CkUEHz1LKvgJN74anHStoclqESg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/uk6YN3wWeimPkLE8tq8o174MVIYE7GvKzJVvEYf00=;
 b=m15ZKxn3ZnaioOoAXhJCmYnkIq+LSNsOeWaN+bpZWsRmxQIPOiZm+gfGoJnWtMEwBEGYJtdDvwBMEwq/GZUDK4hDCOBakUoXHr9YMO8ba93qVoDHc0Q4szZY7LB6dKGYKlb45vtOeZ1aLvXnEDt74nrOIax2GHVhZY8/UCs6bMGxRAfW5ORithPGtNCHnK4Lx9daZLFzF69MVkgs2VjdkTQYliUijVaEIsjtZxxzbo/Y/zKl1PV0E6HofFYoDalRrWH8G0IOggD7M9zXX7NMfpLmuyAZBB8M0dAhGQqMEeBVBFYDBR8twxWVixvYJeiRdK5jN5L+3PQTxhnv3awqtQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GVXPR08MB10638.eurprd08.prod.outlook.com (2603:10a6:150:14b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 02:11:02 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 02:11:01 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v4 1/3] spi: airoha-snfi: en7523: workaround flash damaging if UART_TXD was short to GND
Date: Tue, 25 Nov 2025 05:10:49 +0300
Message-ID: <20251125021051.857159-2-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125021051.857159-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251125021051.857159-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0099.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::34) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GVXPR08MB10638:EE_
X-MS-Office365-Filtering-Correlation-Id: 8af43512-e909-489e-2fd0-08de2bc7e193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UlkQjg+abNmz7bzben8JN8cmpcRn1xZCNhy+zHqZbie4WbCuqlDvzAc9G/Ur?=
 =?us-ascii?Q?6CdxSGXewGARBTx6X9RdBGgcJYaauMSklxdFKZqG+s+igJ4+5KY0TwG9IWX5?=
 =?us-ascii?Q?zjsZDyhZDLMELKjX/PwEhxNOhw1zaMmHxItp7m1TQzJeIYMiZr3UO7tQViMu?=
 =?us-ascii?Q?nvZxcY0DLSV2vssOTWhGb4jSFMZFFqDtzTaiV5voqdiP3Z+Sq9QSqc64wrzF?=
 =?us-ascii?Q?xRSBAoiOfwDvx9+k5kq0LWP4qDG4Rx2b+9XE6vckPIhBwfRIixrsLL1gx9dW?=
 =?us-ascii?Q?JMx+13QSUbUzigXKr9Y/RhJm5WHXojwiO6c7/7fc6yoD7cnWp/CkRfS1fOKU?=
 =?us-ascii?Q?fuhBGLZLS05UmoC68oLPkvPlIYqJKWG/S3w58jv83zqz4B7uZTCCze3hBx98?=
 =?us-ascii?Q?ILOoGqCaNeE2D0/+ZRDfqgPCx5GsYNq+oS8knSojB+zxze9sPFnY6OR2P/09?=
 =?us-ascii?Q?EC69f90gWA/DabeEqq8vxcBHxVWhdW1Kcw7jeHmIn6aNBatRn3qbEjGP0ECS?=
 =?us-ascii?Q?XwxqR6d3lulBuUwP1pGuz9WBjtnKeiFVNQHzMwZdsUsHIoMRugdf1AQxSB2t?=
 =?us-ascii?Q?pYwxgNzyF4JDWTd9c3n0K6dmsbnv/fpN0QTkxrPB5OTEcijpyOC59nR1DoJ+?=
 =?us-ascii?Q?/re5hyAV3GAN0/2O4Dvtqo+rAuS0HexB16QccSvsy45vvy2Z3ZBYTyIogAzA?=
 =?us-ascii?Q?0cd7qBXbwZ7nCEryS8XAx/mNWNUJFK9+YYPCJj71IoI0JG5hLRMUCyWBkI//?=
 =?us-ascii?Q?h41/HuFa97Y0ekGWKAxJkW8JS8WBGxA12cOhMcoC7ZfzR5JRLdLxwh2lLw7W?=
 =?us-ascii?Q?TstZ6lFi8c62lwZR2vwXGq7PAetW22Ipaxtq9o8dCU2tSaypPSy5b1AEG0sP?=
 =?us-ascii?Q?2pI9MUmNmU5y96lFCX0hFUJqy1TKn8xWkJUCdBW3OFroEUeMwytOJiHt/be+?=
 =?us-ascii?Q?bt0tc8gY0T1NFoHUFrRSy8Pz0w/GNQ/OuRA0qO/6KfVa9P4KxcN4lD0aRcoK?=
 =?us-ascii?Q?1qzjnN0N2jl8ceBfdK8lB8u+DBia8oSNCsnBpTA/gZQ7GPo6U2pEBUL4gq/w?=
 =?us-ascii?Q?7TzbrUPplNKFqV9pmtHYgHBc+UKps/w+hmbfZka8tXWBIklXMzwi586uFX60?=
 =?us-ascii?Q?7Qi6VAN2kV5LwvIui0VJTIC/Q2x5EacXO2p0bkD1Tvyb/urIj9jUFxxlBv/J?=
 =?us-ascii?Q?izmZi0rJKM1a62f5CXjXPTCvy3/S+/nntZ9kRstFit/LAeMSubvvvMgGs244?=
 =?us-ascii?Q?bcKcU5K5zGBWWMGKBDfuvOXgpVkA97jXCecGoSRuyEzoIMI5TSvN8cy80joo?=
 =?us-ascii?Q?1+cYyVbuaHsCUnTlMQjz/d43qrkn17RV7WfLsu1UqKyBYEdzppx0SZKe3qb4?=
 =?us-ascii?Q?bKMXq2qA8CGnmTfeQjSNw+S/5ur0a8P3Z80I/X153+vNJEuB1vY98TsBDy5d?=
 =?us-ascii?Q?4G+lolMBmIyXVjDpg9MUctiHkoC7EXoBEAReKjLKapW3go6TIn5ujuWwtTZB?=
 =?us-ascii?Q?LgwHXvFWHO5KjGBsiSIeWL8yh4vn7GV+PX+LKv1xaYV2Qx0gJsaQ7ml71A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZOWVHaBuzdcb+py104xGKjKjAYwhI26dOLAcO/wazMbYuoERUTtSPm7eDzRV?=
 =?us-ascii?Q?IUrQgeVnZslrHDUGDtMLygRacYPU+ILeYKJrk1/yL3c/Bnmq7zJjhZjiHEBS?=
 =?us-ascii?Q?nXPZnVAKkR0WtjPwkiXTw0z5WZ6NP3x9je7uBa7UwHBbpFmUe9OiTw2ZtOHv?=
 =?us-ascii?Q?PVrP++k8VrHIY6E67sBqz+Gdhnm20mS4s42JMjZdB+veMADgQ36JjS4jY5Y+?=
 =?us-ascii?Q?THXCQIA9+XIwYRRXYa9z6vH6NJtFopUUjr0WQ789IAUrrwzXiC5SDzKzvJey?=
 =?us-ascii?Q?YGkKUbefHNzLfHSfjOWFT4YKGCbD4iYpNI0Db8s35QRKHquHOY+Q7kOYb0w+?=
 =?us-ascii?Q?KH9RAwPO5ZMZpm2T5jEdU1QOVN8OPrztLM9iEZ5Ims4ufg9TSLJoEY25vzuh?=
 =?us-ascii?Q?Luydk5HWlaBR09/ts7xmmJWtXz/f6pdH0QZoFlPIFe/hvGvj2H+FLJ+LESH1?=
 =?us-ascii?Q?Ol1u5r+bAyJQHv5zBTwQl6gFbhUSYVeKqcOomlYbe+jGW8J3p7rfiRl4KGwz?=
 =?us-ascii?Q?E+amYa9AGIf78AYvvbv8dbw+gXHITm2QhUWvpLdqD3WFH1DfiaDKtjYRtBf3?=
 =?us-ascii?Q?4oE2kOLpgEo3/Q6sre3D5SIj4l1QHih5ihfWg/20o1HP5k7ABHPfIEzLuzhs?=
 =?us-ascii?Q?k5nknGRyDokxrIpZ021VKM/YZvxJWxeeUxWRD8K8GWal9vO12oQairIatzjy?=
 =?us-ascii?Q?GWpFLC5wYXCtxpBgATMdAoAPcnJiPZTauMRireVQoTASoMKqO5hwf44e/iGH?=
 =?us-ascii?Q?st2MKvlLWl+7TUHCkiW8/z8zgvHrijls4sk2LTi5yGCxDFkUxdgzgFQGoVa4?=
 =?us-ascii?Q?BXDNXH9+kWwAmRlHVeEJrHexEI8EAbJL6lzS9g448/fDAwQ42bix8D5tUFMK?=
 =?us-ascii?Q?D5A7lErNH74rY7B9ZlW12QhJ9JxfYEcDQWKxo7t2y11WhWFcuUe7M03xu6xk?=
 =?us-ascii?Q?RInUXpOJBpYA7Zf4Cvz/jetL452Si7G4uzaKGckxkDyH3by8LOblLXAE6FBO?=
 =?us-ascii?Q?d+glrPo0kTJ6uH9vT2eOyv8+C5mSXFmZ2nUXpr/bczAQIOUq/TZV4uJ62cmD?=
 =?us-ascii?Q?I2chW9ayJUwQnSlKj+laUzvcZVTTyUjT6ilgEA3bSEpqL9Dt7nzyfx4Tn9yR?=
 =?us-ascii?Q?oZjC7GhoB0uOp9MUQ7wEUJv00nvG59vy2rvXRFrRobXe59OoKKIFRcSEC71E?=
 =?us-ascii?Q?beIuU7mLILiTTeXQaAkDSZ+4ERs4az14wWW4B51unXql6QoPGkHWkF6MmRag?=
 =?us-ascii?Q?oUmE/HSxCpIh3HUX9s/2uI4PtODpKlkBOQplRW/kxrwfTh4APDfGPXH2VGwt?=
 =?us-ascii?Q?rDRzKueJwe8T+WF+ahHPrAeS9Smy5FcflMlSQ7b6mGeVFvffwrVWMSZNXRcN?=
 =?us-ascii?Q?REiWMJZKFeD6hZyU5p7qaVfMXS+ywNWYBzohRbrc55zZoc+UasOahZN0io+M?=
 =?us-ascii?Q?dCpFX5FvfaU+Wksmr9VkprbY00YFT7JJLuR8C5mNv/SdC9cdW16MiKtu5Mqv?=
 =?us-ascii?Q?XTtIoJQWF38n8BMz0BzjEqhi3qQjTZLW1pd1X8SiB2n9usA2WHCnQXK0uHFk?=
 =?us-ascii?Q?zBybc1M4X6Aosmzg7UW8EwljlUisyoGKWmkyAMfEBWt6eRZz2UqQCGIdOA3q?=
 =?us-ascii?Q?QW72tFUjjMNsHVok52ZfHA4=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af43512-e909-489e-2fd0-08de2bc7e193
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 02:11:01.8704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m27NMMxkotfL2r3P3Zd1Ym9RPJiVp/m11J550Z0KTDHYXEJnRZM4XdFU2pT7xpr/a02f1gA8RRAdRmOGgZY8ZAGsqujml1xWarxo2JLDasg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10638

Airoha EN7523 specific bug
--------------------------
We found that some serial console may pull TX line to GROUND during board
boot time. Airoha uses TX line as one of it's BOOT pins. On the EN7523
SoC this may lead to booting in RESERVED boot mode.

It was found that some flashes operates incorrectly in RESERVED mode.
Micron and Skyhigh flashes are definitely affected by the issue,
Winbond flashes are NOT affected.

Details:
--------
DMA reading of odd pages on affected flashes operates incorrectly. Page
reading offset (start of the page) on hardware level is replaced by 0x10.
Thus results in incorrect data reading. As result OS loading becomes
impossible.

Usage of UBI make things even worse. On attaching, UBI will detects
corruptions (because of wrong reading of odd pages) and will try to
recover. For recovering UBI will erase and write 'damaged' blocks with
a valid information. This will destroy all UBI data.

Non-DMA reading is OK.

This patch detects booting in reserved mode, turn off DMA and print big
fat warning.

Fixes: a403997c12019 ("spi: airoha: add SPI-NAND Flash controller driver")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 8408aee9c06e..a2f2ae7c60d2 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -1013,6 +1013,11 @@ static const struct spi_controller_mem_ops airoha_snand_mem_ops = {
 	.dirmap_write = airoha_snand_dirmap_write,
 };
 
+static const struct spi_controller_mem_ops airoha_snand_nodma_mem_ops = {
+	.supports_op = airoha_snand_supports_op,
+	.exec_op = airoha_snand_exec_op,
+};
+
 static int airoha_snand_setup(struct spi_device *spi)
 {
 	struct airoha_snand_ctrl *as_ctrl;
@@ -1057,7 +1062,9 @@ static int airoha_snand_probe(struct platform_device *pdev)
 	struct airoha_snand_ctrl *as_ctrl;
 	struct device *dev = &pdev->dev;
 	struct spi_controller *ctrl;
+	bool dma_enable = true;
 	void __iomem *base;
+	u32 sfc_strap;
 	int err;
 
 	ctrl = devm_spi_alloc_host(dev, sizeof(*as_ctrl));
@@ -1092,12 +1099,31 @@ static int airoha_snand_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(as_ctrl->spi_clk),
 				     "unable to get spi clk\n");
 
-	err = dma_set_mask(as_ctrl->dev, DMA_BIT_MASK(32));
-	if (err)
-		return err;
+	if (device_is_compatible(dev, "airoha,en7523-snand")) {
+		err = regmap_read(as_ctrl->regmap_ctrl,
+				  REG_SPI_CTRL_SFC_STRAP, &sfc_strap);
+		if (err)
+			return err;
+
+		if (!(sfc_strap & 0x04)) {
+			dma_enable = false;
+			dev_warn(dev, "Detected booting in RESERVED mode (UART_TXD was short to GND).\n");
+			dev_warn(dev, "This mode is known for incorrect DMA reading of some flashes.\n");
+			dev_warn(dev, "Usage of DMA for flash operations will be disabled to prevent data\n");
+			dev_warn(dev, "damage. Unplug your serial console and power cycle the board\n");
+			dev_warn(dev, "to boot with full performance.\n");
+		}
+	}
+
+	if (dma_enable) {
+		err = dma_set_mask(as_ctrl->dev, DMA_BIT_MASK(32));
+		if (err)
+			return err;
+	}
 
 	ctrl->num_chipselect = 2;
-	ctrl->mem_ops = &airoha_snand_mem_ops;
+	ctrl->mem_ops = dma_enable ? &airoha_snand_mem_ops
+				   : &airoha_snand_nodma_mem_ops;
 	ctrl->bits_per_word_mask = SPI_BPW_MASK(8);
 	ctrl->mode_bits = SPI_RX_DUAL;
 	ctrl->setup = airoha_snand_setup;
-- 
2.51.0


