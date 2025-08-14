Return-Path: <linux-spi+bounces-9404-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD75AB25C55
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 08:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84A862A0066
	for <lists+linux-spi@lfdr.de>; Thu, 14 Aug 2025 06:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926922641D8;
	Thu, 14 Aug 2025 06:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="ZYsgiR64"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021092.outbound.protection.outlook.com [52.101.65.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D282620FC;
	Thu, 14 Aug 2025 06:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755154480; cv=fail; b=c7/LOfzK6tmznuoQbaYPjy1NdsG+SbpIYnU8v/BOzqGZQdmr3Ienmrq/UPNe0MhWay1SiROgXkLupFRjKflNHIDceLc0HrEFDDknVCmezyxwjL1qwshtg9vw6tL1yFyTtjY3vZ1hrvnJzdWYD7WqRgDA337m5+6Q+Aef+38azX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755154480; c=relaxed/simple;
	bh=kRomVO6gpbDDI1+PtsYhGbdEVG9UBvq4lxKMJhPfQs4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Y1e1Gf2EV/zux/RoGuzwqxFNybVx0Etc+h6o3KIpcGDc/AxLWH1zgHZY0uMqY59Ie2ztsPdsbaSjMLlouUwkzqH4AfwibvcA4o/BGcukQrwe65uPBY3GfldOa3CqtSi6GaPeQYTuqZA55sDeFl4r5b/H+g1iY5ROy69cNOT9UCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=ZYsgiR64; arc=fail smtp.client-ip=52.101.65.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TplOe761bbU7ymhTGRSt/5sLvp12ym/u5GiIn+IZP9valMSpG1qmi85CQdpoHswi5QjUiO5wI3LvAaxi+/YgWWYu5ao5K6L8B/TmdhKAgM8EmcPIuNGE+FJRaTb9X6d9NeC2ClacsogUqKZ1VNI/q602iT8KCDAexDTteA8p4wzzlCq5RdsmYcnubhrTi4LWaom0/H/glSSAk3bUSd7Cb1KBjTJClqmAZaD9FHPvhoZq9dGUewiONwVMYM7p7bcwhQm0gDSwF80Pbu/KbecAreM3jxSqCowzuWLRdSs5+PMnCCF7ylRW9mLAjdw2mgMi+/Y/TFovDg9jpp5rLnTllg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYllanHQRS6mJHaDsJz7BXa5RAhVD3LYJeSa6UFsmag=;
 b=YjN69CEKkTqdDaEQCwKXzUD/+wG8w423UX1ETWyThClM2Rr7PpdG7Tkj3kSkW2Wr1xV+hyp58K7gh5aGL2k11pf5TQPm2g0gG7Wjjjx3MuMB8sj35jt+i5rN+TbTLim7mxa+M/3V4icZ5wZKOlkkv1vKI76nNI0Iz+altKLQEoDPdaXmun5ZuFoQBBT80p479TD5lZfgbwbx3hAdb60H7k1l0QMIOxQH4Ga4UZA1nhYe4C+ETuiQLgagSZ9dOUsHFn5xqxDbC9xbSVwo1wRjgwaXka64/rdA7jQlfCcyfvMhPvp5crFfCrHUNfYNE6p00VtFfwrWmP0d9gevGJvzgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYllanHQRS6mJHaDsJz7BXa5RAhVD3LYJeSa6UFsmag=;
 b=ZYsgiR64IKrkBAlXM6LRqkblKGQudP5O9puWShcfDe0uDep3zCnqoGpOCJ/C8YzyXCpcmLZZZ8e0VFCMnncVnjmtbozVxL1tSgfYxwMEGRnQNW8TEAHoRwV2z0Ka/MQujtOXgSUxUvQoncOrQ/lqjmtLKVvNQHfhKIz9EPpKkgmCOUt/zjGUak0UsuOkNHYdf4sbUGk3IR1i7sy/bOOuL01fQesKXPyLNe61rZyf/c602slycnXSfSCS+qsqTzA2md7hKJfJx8IZQQR+2KJfR4bClL5Kkn+np4LG2ZJsvq2cGM7eeKHWZdQM0rtC6WElgcaxnrUEiBIU9j80Mrt3xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAVPR08MB9013.eurprd08.prod.outlook.com (2603:10a6:102:320::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Thu, 14 Aug
 2025 06:54:34 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.8989.018; Thu, 14 Aug 2025
 06:54:32 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Martin Kurbanov <mmkurbanov@salutedevices.com>,
	Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH RESEND v2 0/4] mtd: spinand: fix continuous reading mode support
Date: Thu, 14 Aug 2025 09:54:19 +0300
Message-ID: <20250814065423.3980305-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR05CA0149.eurprd05.prod.outlook.com
 (2603:10a6:7:28::36) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAVPR08MB9013:EE_
X-MS-Office365-Filtering-Correlation-Id: 17719157-6daf-4a22-3a0b-08dddaff6bf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qRo7YxfSAvf4SkprRUDkqBa88q45QxAZw/cFtkL5CuwFI0yOJYD8CC2Exk4E?=
 =?us-ascii?Q?WOUDvTY6/sU+HEvv/jfChIAKtizg3n/uZyXBP9nPMgkwxep4bM29cMzoi+QG?=
 =?us-ascii?Q?qFokVGEw2n7/wdf9BJzMqh29RBJgqepbibDaxcH/G9NgRb4wRWwHa5YfkVVe?=
 =?us-ascii?Q?sx8VFq9pEY69Y3wVXCnoWbzIvo+AMy1/ccuUDo5zei7w/f2VhivJAn6r+zG6?=
 =?us-ascii?Q?1CMGvjMdQWsyJu1tEwQ4txwaIy1iqo56olPXSU44UtG2lyOs62LAufnzBngk?=
 =?us-ascii?Q?3PFNdI5KATqsSQ5wJsrvRqWb2KwbQEz0Ua+PceuHSrKCSVZ8N/4jLPTeFV1V?=
 =?us-ascii?Q?V7/DUvQs72e+F6A9GVr9B3q1VM7qQliVAhUvu3fVKADn8SuSMsK9llbdUIi1?=
 =?us-ascii?Q?6LTQyI3PmM/R33UJtYxZGf6TGPobXl4mucFiOesvm5M+kzHKuYy/6sdzMHe4?=
 =?us-ascii?Q?r6ZsQMLx7EX2A6nzsJfA2NZaVbg0A1+Ps60l6W4F67fm1zI4BHoWwjSG19hn?=
 =?us-ascii?Q?uuKAw1BKYFJdnMoljdvHybLdGSn3luoCnIC8bsFQANyMfOCCSWEEQ694xJrC?=
 =?us-ascii?Q?9zkTlhf6jN6qWRh/nSO5sr+BDiwYRzVvObC7ZF8XmkTw+9CGJLwsLrH1ECxy?=
 =?us-ascii?Q?cBPiLU/Ytcj/TFB1gmaDnpHldeGFGUReLe1rQzScvoKabswzO7GIIaArkqED?=
 =?us-ascii?Q?0RKOIP9Ok62gPSq+SDHM7DiTqbvmBgq/z7jhiJp8GnbRX/Pm/0QxzY/B4j0J?=
 =?us-ascii?Q?JF7MujIrIKC7ksAr70DjHSsLF+WBMzc+SU48xxWcZcnHHKNMXc2wGbVBRCRd?=
 =?us-ascii?Q?ilorE+CWxiEWc3XUa5O5dU0O1d1wuvRUYYU1Len76Bn6nn/eLyxIrWQWAI3Y?=
 =?us-ascii?Q?xr2smIdX3VqJJODy8kfAorKSyVsg3aGhJxCRUwTjmynIzwLI6n0gk+IppQbQ?=
 =?us-ascii?Q?7680kFVmKpSusYIlqbsTYGWzf466CGrxXbHaYNbaTPNysl+PoFEL62wPwtg6?=
 =?us-ascii?Q?M41XFy9lSbKoDy+h6ruCjbgcprEEk0ElI59JKhdOgmGaN4WyvryzL0rUEL2k?=
 =?us-ascii?Q?LpPXXEJegX/Mg8WAfNXUhDc2EPkkz0AEPfUwszPXSp8DSEqF6OLla1rcCQVT?=
 =?us-ascii?Q?a3pI/SX0Spjw740Xc70cO7/xxOQvBMoXl4t0i6YOQMxi7swv4W4N4025jm0c?=
 =?us-ascii?Q?CMr+XNq5O1ADZY6JsHUqViIg/J7yBKVpL3V97zfhXnr2pLUuDX7hT6IHmT2/?=
 =?us-ascii?Q?1Wuo/2xa6ie1quoOXebBpaXfRNpPXbVgY4Fe5w9PrcCsLPebqXhW2oSBti80?=
 =?us-ascii?Q?1GEVmYG9tSTbdQf23Z7VBMaC4bUuiQkqpPU/KHEeiRtbyX3v+Zs8b9NEGMN2?=
 =?us-ascii?Q?OyCacuqRtVWrZj0twqJrR5Zuvf79LUHUABDnaVea12qVaOJD1RcK29FB8Yfg?=
 =?us-ascii?Q?ieJEgXO88M96nP3/clZowsTY21CDtyoZP9ozs0y2srnR0wZ9yvT1hvuwrMl8?=
 =?us-ascii?Q?V70dj8Xbpl9dKws=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PKshs/yKkg3FvBSm8D3Gf3giFrTb1IGupu3goP1rRXBG+aPOpbjJIzhJ/IVd?=
 =?us-ascii?Q?GSnePGXibBdIZFQlkocD2CQATjT9qo0TDbcwmr9fmRUo+1hhxHaVJDgJYhE2?=
 =?us-ascii?Q?iqAwlh1Mm7MkD1cI2VKr4/C4ib4ttSkPbFXLdvEhcTQwFyVBITp0N/pA+OMN?=
 =?us-ascii?Q?Bv/T30KEuxFdHbiSxX/u970HccndZaAY+5KAgRpujFDRyp1mtTMFIrS5DIYz?=
 =?us-ascii?Q?DmZcmAQ0XHIe2elixP3JWbVD2leyJ0eeN8sbin95Ew8Wkve7N/9+/9CfpXFq?=
 =?us-ascii?Q?yzxvhTm92cTLGJi+s6VrkAguq6JeX2ztZampV7tfgtG46QN1ggUxErNQjiRt?=
 =?us-ascii?Q?TGFzM9ecr7fSMYHC82Sk8nFl+SDSAV3xnaP73v8l8HVbG3VOHT1sdSk3CuIb?=
 =?us-ascii?Q?bjuHwK/7XSwJBz8wrs9lJRTiagdhxy4rvQUN8QqyfP9ilCzeKLsJQNLLVoqP?=
 =?us-ascii?Q?j4Ywz2MtFQ2QCw6cAdQSJeNn875HZ0qCJNTKZtbgX9tjL6rw5rTNzvSfDHB4?=
 =?us-ascii?Q?EORxHI+eo5N0juQYxvLKdVSxZefOJIQm5DQTKhR5RwHmu3GxmgPaDSQWUKQy?=
 =?us-ascii?Q?cecWn5oj9VZiqOWXiVsmbiUCfIEr0dnmpO/SRP6tk0qMAXEFG6Bl9vM8TbdH?=
 =?us-ascii?Q?JfdKKSEyr7kwv+oG4yJygiMZA15uTD8YI3ErBbUn2+r13UFSveJEggzgq96C?=
 =?us-ascii?Q?ehOvsrODwtg/Jnx2C3iBmOeQHZb73TNm8uNbCRvNCbNYLeCxuWXwpx/qFPQe?=
 =?us-ascii?Q?NZ6TS15iFOrZp1070ze9VVO40aNWTN1KgTjB8mkYbTcVwOo9Wn09IfcgvWpX?=
 =?us-ascii?Q?WzdIE1Gsp15mSiYDw5wx32hoq7FQunwWNx8R9JBY5WRVIbtyDtNrYHfn/oHZ?=
 =?us-ascii?Q?FQ5DLtN4xYovsGPTuN2QqhGV7kcivnGE5TASHG72gKKY261tZsXnVqfXZJ1C?=
 =?us-ascii?Q?RwnrPTprYY3tWcoutBGRLSTbE3wL7dFSzzZDhPm8CD/Zwh84Dj/XeUoDCfS1?=
 =?us-ascii?Q?tu6A8jAQZhqX58F/XnmbBOuz5RbIL+d3smJsjX7aMzcuoF12u9VsQ//s3EKq?=
 =?us-ascii?Q?BHF4ofX6RWqKyxa9e8YFj6GfzPJvvk6Udm5pWfuQCkHjzO/KgvWmJU3XSlDt?=
 =?us-ascii?Q?vI2Zkm4vPP29OJgeUTR5LKucZDUK5I63fLqR8pV2shiO3yMwRk+MiZg+sxse?=
 =?us-ascii?Q?ybwaOsU+2CWeqx9zma4E3IeETW8tjU2TjQQo5a1IgCigD9kp0IjH8bmh+/mX?=
 =?us-ascii?Q?JeWwyOwjM3N3kx5XvplFImP45IVk9nlz+Kmi89H45/N70aRXcCbh7kWYNuNp?=
 =?us-ascii?Q?ViolbjUlRcGkoWETBjjXfIjOpC5Ap8sW4832ev0QjQ7szoEgXs77pIqG5YnD?=
 =?us-ascii?Q?frtl4CrCGVGF+Ku1jWXmtoR/1zIsHyl/5S/PgDcLuKD3mdSgJMsX/2AIeXvQ?=
 =?us-ascii?Q?td76DgxB0hRZ/oItfAXvy+cCuXHqiFXEVUQrbdSoC0VBeachXBFYnyuVTLmy?=
 =?us-ascii?Q?DYfFcwZG+Nu9GvNZpjI8QALhiEjFBV9VUJwW+iRfF+lt79+MqssFo1nCO7sl?=
 =?us-ascii?Q?9oeCE4gPFFyE6BwBpdMVioBrmTj5T6Ll3+8FyVCB/HtA4wANe7MxCOUxlw1r?=
 =?us-ascii?Q?0A=3D=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 17719157-6daf-4a22-3a0b-08dddaff6bf5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 06:54:32.4599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kmLiV3Q0AP3A9852dW0ojP65MwEmwSpnTftRFhK5ajxDoSjxpeS701/5A/u1EIdNX/Et/2onNWypxVMUu1M/yafRKN9nOoCZaIyEbAtvRZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9013

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
   creation for that case as well.

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
2.50.1


