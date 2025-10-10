Return-Path: <linux-spi+bounces-10561-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33FEBCE889
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 22:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98FE95457F4
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 20:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C2E2773E6;
	Fri, 10 Oct 2025 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="IWS1nAkn"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021092.outbound.protection.outlook.com [40.107.130.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7037D303A3D;
	Fri, 10 Oct 2025 20:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129134; cv=fail; b=Ir3p2xKofI3vc0UfizksbvIQmXSE+iYaA2+7FKFJBbJcOF0lxZZlNx1+c+lHPZQViq0hyKuOkrnsNNpaxxE7IK4OVogp13JunNwBx51qx1QHygWYjBnmnAjsPn8FDZ0Ls4vFe7uxpKPeaIF1ytgVN7G1J853Fyh0ApeznRVHteA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129134; c=relaxed/simple;
	bh=8l9JymTCgM+epgUzk4VcWqTdwxznhd6zcMGkq7eDAt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Olx6OESbbB0rNJKM7WKdDpa5tOqnmrSXyB2TCqlesmS8o4nwBScKIOt+7T3SMwyvPr2TwGD3ccrnfG3hBlF4fS8f0cpVlnKp3JOsjMDCphicMAljercDDSwyydXrYUeTjBFLesEoUkXnqpZlIHUl9zW4n7eEmaxa2/4ihb4MrvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=IWS1nAkn; arc=fail smtp.client-ip=40.107.130.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Un8RY5FAJQS/w0EPbgOI52oAqFFXoVloGJbx5jTN/8YWsekbj8Scm/348bLcHp1+EzqhWotGh9pptUAcfveHk1t/7ICUvVhyeJuTbzwYjvSlazaTh8gCGJXb0sZZjMjMXAXjlE5agCrnvsEnK98C4DIqhIoYW2mWu4HLUy+3sT8+4r2slg0TOEZcFCoGYoBDKxUFhMctnttnn08Wgut829mhNOflGwOUmuZe1iZd2WW8mHP21OtmypslEKdlwDsi2iSJhuBVl5kZwJefc5HxAz9m+FFtM9zs9X2Vg5Y+rnwCpmy1SKgDxKCfGYVBE81mNGuwvpzVUMw/MDYgCjPTxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNX4iO0o0uMaRyxU4/UJ53mvcG+yuhoVl4mVMBYOSyU=;
 b=MLKuiqcBmri6ILumz6lEr/buBESBA04x/Awiju/JhMZc2K4lzakjj60lUkg5tBAdWN9yPpSa+Ir7upsrRgsjfONr46cu0sjk3NQWBLCgMYILR6ivILylQe4C+Mh3d+0eoOdPxGO1jUNZbB0LENNV7w6FJE5AvAFCyZtvN1/VZWw5d+277OrYNMqU5SKzmUr5wck1e7lnXp3mAjlg2LWJlQ9EkKdVJViSw6cqfnkWmnbrw0ETyfjwnOEBUIGsFjJKwtX0zZgN82sbZCME9zMDGjmdVcjQae81n/wVNvyHwOFvaqC6ZRlSvAmSKGle4xHQEGHwp+wCIETZJ+RAE+Idwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNX4iO0o0uMaRyxU4/UJ53mvcG+yuhoVl4mVMBYOSyU=;
 b=IWS1nAknci0AEmxTSWA+uEC3x4AR9SraJjz/tg4zZztDxMA+YRosF1+9pBne9JAwVkBYwzibqoO3aNQoPI64QFGTNiKHmkwKWxVpoXcdr2K9CVFms3N+xMD8+uhf0zhq+/QhdLhTMpwJOjn06riwT6hbKRbgttV5bbmFce/ZMEumossIfa2TtUjqlzedgXilKV1JvupCSaX5XvZtsLPg/5qKFNFkBnR5SNYbkhr9ipHQCxFBoJrKW1lRdC18T9+2g+V1b1pJF41L6XFqrJN7CAVg9NWi158yFHAWfFM6UNTEgMDJ4rpzZYHJVbHwyFfCR9xuvZm2sBgtWf1TTzXRVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB11561.eurprd08.prod.outlook.com (2603:10a6:150:2d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 20:45:19 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 20:45:19 +0000
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
Subject: [PATCH v9 07/15] spi: airoha: unify dirmap read/write code
Date: Fri, 10 Oct 2025 23:44:52 +0300
Message-ID: <20251010204500.1625215-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010204500.1625215-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010204500.1625215-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00011B51.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:b) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV2PR08MB11561:EE_
X-MS-Office365-Filtering-Correlation-Id: 094b87cc-3c82-427e-94c4-08de083dec8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W7Kx/8YMGAb3GawoRR2TCM45Z+3Cf4fxCNLTXXtHCd3lNCaXB98lS1TC7YIu?=
 =?us-ascii?Q?AwbVoNf/lZL85rV1E+ghWhw2DfcpGFPBir4CPpun7GZbNE+29pIuSfkHVOsX?=
 =?us-ascii?Q?s2z+zeYcxA8NHx5btzIcGHYCfkQDxsfmHMND1uRu/VNr9G7WaNgg91ITSz7b?=
 =?us-ascii?Q?82pPRYFNJY0HXPg8Hfty/71kNYMnC4GA3sVDJ0xPFQtcLb32a7HLb8pl5h4f?=
 =?us-ascii?Q?Z7BqEoXp667U8zIgIiR5OvmqgbBai0poWDfUPNqxHQeHUuquC9+hdZUWycne?=
 =?us-ascii?Q?I9tflKx1HGY97sP1e0Z9sQiyuO1mn4JJrPDszj+l7TR94ksQTwvKfo9D6MBq?=
 =?us-ascii?Q?ZUzbw7Ig+3tj8bFn3pl7HeY9jzHKwcfMaB3wPl5VRqQKQnNeruFjLVCqaKUI?=
 =?us-ascii?Q?4bYLk9ouj9TyyCEKQx8crlaX2izZMvpQKALJOM4XLKTHnk2+lhXidH1IWSch?=
 =?us-ascii?Q?DQrpxgGFHjshwdlNdPSNDqxgjt24jlyHNWfvye9lWIf1td649rx1hM8VG9Rh?=
 =?us-ascii?Q?RziXzlHfrDblje5XW+vdKPVw/wezpPjWQcPsbPj64GcIuSg2I70QBckqvnsq?=
 =?us-ascii?Q?gzrm+7IeM5k4uy0QUw2XbMBAuWZyIy+7zCCc4iUCNUJI65u2e9MtW/gMwf1R?=
 =?us-ascii?Q?qk57pnrcBpf+imgBsNOUIL82yRYc+NvwRqgf2wYPfxKePRuin4Y3UfPhhQrt?=
 =?us-ascii?Q?IjSVqyCa/8xfvtkoH1PU3raROcP9M1HFstu7q7owGP99Ag1I2+BYxyc71roE?=
 =?us-ascii?Q?wsAWtww9jA2zvKwcos1tehpjF26jwCNe3m6Xp9bpCGoGEaetlaN/K/8sApFT?=
 =?us-ascii?Q?5drJvMASyxLC6dQdd/h4UsUIvO4MmO6MXoYnB6jy4blfS+4tygzCkcX3dFaG?=
 =?us-ascii?Q?/CjihPw+v9mGsEUfepXRTy/ePkb24aoy604BfJVQvA1wZgkU3QcHIZL8U/sr?=
 =?us-ascii?Q?3xEfpQvx4p+AWcjvd73uAPgw9EkhXBdAUWicAHOhrGQJl14UmsbVXTcRLSKX?=
 =?us-ascii?Q?kgQrXqqiJm+jQoQK+Xz4Zx7xdMZZ+EW0ftlu1DQoM52thAwSleA1SNb04Qej?=
 =?us-ascii?Q?XstYrGkhyjZ+ainG2Uls1T86lZ2dOpQkTkJhJCQ2MyTYcOz2eI6N39GqqwNu?=
 =?us-ascii?Q?ryZK4PiAE7RyxiTrVHvYMLNUnIRU3I0wchRLkiw5zMnPKWmpWJa6bvSX+hLg?=
 =?us-ascii?Q?o16FEZ6YJfOfOwI4LIU4VkE55lMhFYyodpIDMFZbloJ3myXtYE3yeEDYuSTl?=
 =?us-ascii?Q?jXYfDpIyeI2d6sRCD8xsIjCeUlvg5sqVhb61VqKR7af7fArepYdnYcbr/OkY?=
 =?us-ascii?Q?kNAN7ICfuk78q2Ut9hBEgoIuI0d354GJbvZZls1kOiFFCcbYalIE3bN8bcnx?=
 =?us-ascii?Q?n1IzTN+7m1Xzf5efrq+QVokMEW22zlf1ZtPRU6adomzHaTa7jezioTE0bOpm?=
 =?us-ascii?Q?6IU9y7aSpnp1awm1gnFb5AeWfJCSpQTqFTw8i5QRi0YV4GZaPNp5dncNvY7i?=
 =?us-ascii?Q?iCUqcC2dpFzbcI6yIAq7Ts/maPvl3/mHwSvNZu7lY2vGgkdyV1LMgnI0aA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZhG0QzfCyUVeAdui4fXpp2ClnJVEESED5fsXEYAxbiSmfNR0Yyby02LCb1QF?=
 =?us-ascii?Q?HR/8VxK9nbcdyKupl5JeitHccOfb1t2y6XB3sHssudyg1dNBsDqY5j+/HzOW?=
 =?us-ascii?Q?zhHxc27Lfs3D7x9AQYYPs4ZYTkHFYWgSC1UhzSa7o8YoMCz1NFrZr00Rqh8M?=
 =?us-ascii?Q?+SI51xeh6k+KlzndrNESrizfvG1MjZGr00v4XET3XR7PuRAcfvG8lX6AlWQF?=
 =?us-ascii?Q?Ddueu57Qs0MA17lutWJ9fq2xlCr79ryzJAdjx1Mi8p+rbl7Y1Bgr6QSRt4OO?=
 =?us-ascii?Q?7Du92s5Yhpp/3qng0c5rlVAfxJJ47NZr9mf5bBiUDPZjIMO5q2HnmL0Yxa8L?=
 =?us-ascii?Q?iQtxh2uKl+pf47KydyCQPUNgbDrlXfr8v8fn3DNzHlSqBoqbN9Bd9xb4lfAQ?=
 =?us-ascii?Q?XtmwG9SWz+vxGZ8lDn5lm+tVYtd+tOY/LncaaWoqrKtlRazCHxNVMrjPSLh6?=
 =?us-ascii?Q?v57CKxcccU2POQFW5vBCQ3GiguxkvneNe7zEbw3+ATq/U5Fyl7T6bTVzfAmF?=
 =?us-ascii?Q?gm/rmTah0eJZjPRZpsOe04nEYw6jX6nhQyzDUXoXOGGUI3CZAAVnGY2hGHtP?=
 =?us-ascii?Q?vCnCi5zemtV8aH9JktBz9oLfz5+o9pUnvdQIGQODZLAJaMtLSjEv3qPFfUkl?=
 =?us-ascii?Q?siAnvimPn/uZV41ihO/BdYStdRptgv8VdmMnkTsS1Czt9t2ld/QeUQyhJsVR?=
 =?us-ascii?Q?sSOwvGcA29SWbecDxjOlfXCdmIx72s8+Kjl/pVCSn2ZcJo1OPxYLf0qSCWXR?=
 =?us-ascii?Q?SkIiKuCRbt3nJoWFuPVvnWYuV3M88fhMhT5R5TOucXel9moXBADwFdWB6GR2?=
 =?us-ascii?Q?xC0L0p/ZgzfMz+8lPMiVTWcBtbRt81i73ximpRcIaJrIooXzyJbkHyZ0CbjM?=
 =?us-ascii?Q?0NbN6R1hNaIY4UdUkdxlQbNegvWbTrER9cEeyWF8HI4OiXVUzRSDETKBl6q7?=
 =?us-ascii?Q?FSXCuOmHCn/LOZpWSS31PSW/NaCFtkSIZ5ujQpPYsmJM6BRFseL/WSSO1Igf?=
 =?us-ascii?Q?/XBbC1SbdpMZfGygThqA3tCd/jyVP/fZqP9VcJrYdm9BQOYbJcj0ifmu2uMW?=
 =?us-ascii?Q?+lIewx1G8RV1C1sT6OpZYLwGS5VBqBzuWNUVyN5ZcQDjXrr2dMV1Ecid0BgP?=
 =?us-ascii?Q?j1qzg8zUtb+96iYmnrwp62KWvH0cHIJnOvHGF+Op5mf7ZRxfL7bDVA5MjsLw?=
 =?us-ascii?Q?4ZXi32vil7dz8O4xSSpSpw/cXVGAzSn0DVfHo1GaK2N9CnhcUzlNS/rBpaSE?=
 =?us-ascii?Q?dMcNnILOq2VFhKZU8hqJpXTRO0g4HQY3elIJ+WS+qX81yKKwUOp+aESSnZ/C?=
 =?us-ascii?Q?O7gzpIiharPemtK0D4mIz56pMd2FN6tdECTvSijVXz1PJJJ7UYbuSDU0ZSq2?=
 =?us-ascii?Q?yOvcLqypUUXfVkYqq2DYnAxjbks1gUknQ4RGMwi5XBXC+BLwzYELuymXY9eq?=
 =?us-ascii?Q?JB3G/GRzPC44kL49BjYq+qYpreI3OOj+YtqZQjPOJKIpnT/fGN+il7QEwXIc?=
 =?us-ascii?Q?xgOOFMLJHQlKex6AoI/0/zkmtWoyqPWHSg/H+qHm4BlvubPd2b6C+uJFo0zL?=
 =?us-ascii?Q?9+VfzYubCKlBcPRk8mvtLCXqCNxnBNeyHAtOFJsAxuBzBSe12PaQivGlKeNr?=
 =?us-ascii?Q?Jwxt7JYh9URhLQteOFV6e9o=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 094b87cc-3c82-427e-94c4-08de083dec8c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 20:45:18.9714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EvWPuAQQVz0pCHzdkyT8tpqcAZo8mBhNDzYnJ7ntaHLfLBcpNPTb0BjixF0qBEVPjB0JQ2zoyjPeWI+HDLR8Ir7wZb5GVvPJyWZ8WcBn4gw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11561

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


