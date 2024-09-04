Return-Path: <linux-spi+bounces-4600-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D8C96BA29
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 13:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7558BB28C3F
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 11:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DF21D0176;
	Wed,  4 Sep 2024 11:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C5AA6T4m"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8368F1D017B;
	Wed,  4 Sep 2024 11:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448673; cv=fail; b=q93yqxTHXGzGMBbPFQ+dFAbKDv3IjLaktY8FYmUua9kyob/7mtDuFf7u4KY0z0PzsBgQhhyW6p0oGIZAP6iH4DF0RL2BN5Nx2/ph5tTkqVKUUcuvSVWFWag5kCSFIzeix9otGxnuh5fR4F0eKdR2MXy8cxeWtt8Nc++/jO59Ke0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448673; c=relaxed/simple;
	bh=63dcorRl1GooexrUpr/xKOgP+ebeNU+uTmZnKqe6pvg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=a5pobGj8JPp0HPc8uM/jCAOxIfqZaeYu3ey5YAEdlXkUMYmbmrxwepDROpE5gXX4uzcAW+A5m4vOU554ArwA71K8uCcAwggZ+QYf9kaMuvZUhfSTzi7/6vOUbuowXSVysBAbMDjWFPqZEGOUXyKeC6rAw9RSH9pJ8b34THrgoog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C5AA6T4m; arc=fail smtp.client-ip=40.107.21.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkTMCj3LKzBoQ6PJrleO09KY8/snZlHVTiNFUHwFJYH4fzHu1hFHvcnX4UzVNT0Z5u/WaGujFoNoI6IT2yJz2YOjmzmQiWgxj4JExd8djVqQRXQCfht0hFqjOsX/ZAYftI6ed0Xw8aelwugmWIEt5yEbfR6PyP8HZBcnrxbCRtl6Ny3vP+/L0WMHtQqeLdhoh+Sv28pwvAVWzVsqg7gHXVPvB1SFeGzvfbPadVQCjdrtmB0lH+n6J58j4mHs4bGfhHzKa9+fK3+gLAqhcc0yrtSXzPFTCDCreKkyJE64y5tNtbSKbf2fE7dpCEwuGPP55jXF7Ho0iJYZWdPMsn0JnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uaes94WbseF+m8qXJsa7LnSmihuQgrahx8WWOXyfTxM=;
 b=Kh8e7JtzyJHkpvidbBLUd6mY/mKP553pd9ecjMZiQn3rLrjQmnPMPQwArAXAIeOiscIsz++Nb1SLHA2LVh+UjgPtAnqoUbyNBeWjj1SP7FRvII6Lk9+xJFVD2nnKDs03722km7F9jbsYs9umj+3qljJ+QH9ViNkZhGlU3Jtwbcq5KD6wJsUiFfmeeXlIakESlg2elbV8eT+f3aoCncNQ8lwYa5l8TcWFlJDl2U16Ep+3mzcfAOCS0vOaCLUTC6+BGHQWnpoJOyPg4UpDzcv8FzZ12jIWUuaKO7LexPrnRi8KRH6oIDdtpE41R4MledNzhmVwW6CO7n3kDCpLn9NCmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaes94WbseF+m8qXJsa7LnSmihuQgrahx8WWOXyfTxM=;
 b=C5AA6T4mWaZEfm5ncuyFw8QLbfEZyPAMNQxldYLfMvuViitw7/fBMrJg/aMUI13b94rX9h9s/HfhHIJcL7KjDfJqi+CiYo/mU6cjptFf7hP/ij+6mbp2/4dCadH7WqhFI0TVQyB5ktb7NS+8upQybea/OHtgP5Gj6rBQc651Zvxh60J8NnAA7qPWi/youP8ykUW5r5yksmKj++X4QDaa0i9MO9O1DGy7KpXPt4IIM4tMzaX4XjAAHeB9dbXdDOa85ANQMp7r8xFLD/uehDyUEmg1bGP/JV+5QYqSgsBWnOaEeUhi06zQbuEqsL/9ZjG1OgoSUpRGMm/t7EJrT4lYgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by GV1PR04MB10607.eurprd04.prod.outlook.com (2603:10a6:150:203::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 11:17:47 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.7918.020; Wed, 4 Sep 2024
 11:17:40 +0000
From: haibo.chen@nxp.com
To: han.xu@nxp.com,
	yogeshgaur.83@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	singh.kuldeep87k@gmail.com,
	hs@denx.de,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	haibo.chen@nxp.com
Subject: [PATCH 0/6] few clean up for flexspi driver on imx8ulp and imx8mp
Date: Wed,  4 Sep 2024 19:17:21 +0800
Message-Id: <20240904111727.1834935-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|GV1PR04MB10607:EE_
X-MS-Office365-Filtering-Correlation-Id: 823c04f0-126e-46f8-17bb-08dcccd3302b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A93XtteL1VaS+xTIeCKa+hmkTjgGvChE0gZdB0rag3qagnqoRqAxbkeu7BfI?=
 =?us-ascii?Q?8rUD8+d5cqTGWHAHs04toyQC/9R6vgX0ENSTfqp9BlOGXnZZSLuGFOHOX/v8?=
 =?us-ascii?Q?db7HmO6BmNy7jby05wrNn/nmQRbF42SHNhr2093JmjwZOeZRjih3qCg748Ld?=
 =?us-ascii?Q?2UdccmrIQWuQUg0gUXNdgFYPMh97KygZq/ZMtkRaPhkc6tz3rB0rydOH0F1m?=
 =?us-ascii?Q?ZqvjYCalXdJg0lEGv2sNJ8knJniyxoZwDKs2dJvtDkswYZnoDeSb591AuvHe?=
 =?us-ascii?Q?5LGCHH1Wkh0OyCDa4fNOBeiTcsyscMPR2jgdS19K7d29rLBt76IEroK3QrpZ?=
 =?us-ascii?Q?CnOqK4j+Aa7urkQBYgGetewL3XGvuN97K6P7ElW1cn3JL8+AWoQhZNMO7uk5?=
 =?us-ascii?Q?zevvF7g5+Qrs8qDa6F6KLjNUATStZY+hf+auDou9wGDMaDhDSDN28HMKmWHV?=
 =?us-ascii?Q?XPokciQlkHyorjgQrO4wfTR4eidzrgWao0gOFKyK/UwpU1PbjQS4BCJ+Pzks?=
 =?us-ascii?Q?wXALOidxTBJSvDxMiIOhLYEu04gSMguZv1HwBaf0gzk+W8zFnIWVTe6a7Lta?=
 =?us-ascii?Q?B+U+M5zoEyzvxn16/3hoe5ImdvbFcpBBv0QgiZ9rOGsyoZ1KvxhKNX/HhX0k?=
 =?us-ascii?Q?J+ngS9L+rA9eXlJjflgr07dPxfSIADTO0wzqr5QXXN0siW4nTtDEvDcxzWLZ?=
 =?us-ascii?Q?lltHJmUOJk3Lx488UY1y9HHgIXTjLyK8iZ5R+TQH6djhKhYOhXrrQIVdNAJb?=
 =?us-ascii?Q?qobmJ1Bb8Ii35ZsrWeJ2PqqDCtgnn1qmy406blYlQEDALe3FmyLe/G9rKu7/?=
 =?us-ascii?Q?BCPRj0k09zc6+qC2QNLu7OsFDyOvbNJmmgQ/cRK4El6UP2hMxHXXRVeMNjBW?=
 =?us-ascii?Q?wh/vIreew3skcRV2JTOy1RpJ4Fzl0DxccEk5UShdEPg09Wlt0AT189xA8bjE?=
 =?us-ascii?Q?WaDmIpt0/FvSC722pIC2UMGL1Rua1Egi+wvaGNaSptPBMkJHQOG/L8DIb6Wt?=
 =?us-ascii?Q?sv93vm+eC+5rPzz+TCBP19B/TWYtM3115r7A3sKN/+cZnxvtWo7jxcEkoMq2?=
 =?us-ascii?Q?6rQej7wKZlighREoPJsIlv5ZGDvQNrnBLMw+5A3nZzQaMGVW1dFBmOIyqqAz?=
 =?us-ascii?Q?S5ONjBr50oAGeuALgeK/Bblx+k3eE85Xvd+OFRE2y5PaRHqLP0qGsb1nAs3q?=
 =?us-ascii?Q?jrcydzgYZcmRFbY/LWU7F90mzNRVXssbxo6ltwn8BprLJtuVQhaW+F0NDj05?=
 =?us-ascii?Q?Plt5p3EMwhmFrElBH+UiCyDzcdWygvv07ik0pe8Dp4VtMDIYuNF4F6pAvilb?=
 =?us-ascii?Q?SwyTxl+MuSMgwDV4f3TJJemEGPoBcaEu5uBZEre/vcqQsNiFG55ER85Zb2tj?=
 =?us-ascii?Q?sNvfCnZp5jRqtwuoTIlhrzR9skaLM+4K2hqnN6G/FYKr39Ss6Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5SVKsWGoxlgvOEod3XA8+pwTWgk/T3/0nYnsXI492Rrgu81JvT/+34jUjHxs?=
 =?us-ascii?Q?UOatEIPbUXZUFt9aMgYF4vEWcXFSNrzI5Rf+MqE/fZ6cWEj/dIyovGQTBLiL?=
 =?us-ascii?Q?qchWKxCGsCPcJRAT6xIzmJn+RIps5pp3z0Hi16lzEJPIspDy4udo35SgcFRd?=
 =?us-ascii?Q?eVohGGdDk+P3NvkOjM5FwFop8TzKzxK6Y6VfZU+x9DieYoTnExzVSbOq10fw?=
 =?us-ascii?Q?VCbBcWZFPcg3jEgDCPz5fCSGf3jc0PeopDJ/QAehl8tYYVcCgG+zpxzoRIDn?=
 =?us-ascii?Q?uOjY1t01WafT7UQvn8WQMcLWvzx2uKohnNp1ibhsRFQp05AFRZxLilXP0SCe?=
 =?us-ascii?Q?5wuY7I4mXdr2T7z3bPR6JbHp/w75NiryFPilapXkM4//1OF6mFS1D+6fv7Vo?=
 =?us-ascii?Q?GyBN+3pIXp6QzSVoBGlBzay54p+qV1z3I5ExT+J3oOpH9ZstgpFSTwfRPEzu?=
 =?us-ascii?Q?a627uHB1/rMvQmwflmnrHF3SLnbJvBb5jwYKWOFuLANiV68enTdyQapYVXin?=
 =?us-ascii?Q?QqJMaNUUoZYXSBxBUesGIaen9ITemo1t6yWmTYIp5kxMRjKLHsf+KmgArik1?=
 =?us-ascii?Q?XO9rqkgc1mm/1Q9hsI8RpekvXOIzFwWX+gRIfWEXbfqRjG8xrM4DQ9vDxDd7?=
 =?us-ascii?Q?n9InrxhY/ShkqTHTqSa+Z0/5cai0GHO4VC1FKwTHoRTVBDJjghA9268E965R?=
 =?us-ascii?Q?ZhsWE7E0FqZ+ckmMXybgn6HLdf3mmnLkfhwvWEX7c3TKSCEmLRzu3LvBBY5X?=
 =?us-ascii?Q?/BGxguRBDy0d7iGBlAiEbkXh7Uf8bWKnJTvSW8HnmsgABtqrYYIHsUxUBqyq?=
 =?us-ascii?Q?nZP5+J5OKvYRiAWxlxdEvoSV0FZA98Ypm58PHSGRJYbTi5Z84bgfVX3Qa3LW?=
 =?us-ascii?Q?cUsmmSguGs6PA29Gv1QUfa6TMWGKur+JNqOHO7xiOaREsFftUbBfFgHahQKY?=
 =?us-ascii?Q?FtuD4wfBlOtiXdLUFG28NZTxuEIubscIUW+3E8khZmaLTq6Xt0CivKUARHtM?=
 =?us-ascii?Q?eon/2vnrTdBoQ66D4/S+uKykNd7zCsbCjjg/TqcVyVr3GKjdgzOR2AEB1GPT?=
 =?us-ascii?Q?KTcGY/nzHdU60kzChMnLKDahSisYohd5uQ1NB+0Qrmjpan8vjH7XFruCZJTE?=
 =?us-ascii?Q?g+rlRXiTFgtBQ5jtgIz+7ZyolWkrFpr1mY8MWtajxAEVcbqSIqdRJdrjydct?=
 =?us-ascii?Q?icJ4qh9V8Ozw2eb0W4K5uxyjnwCUfs8UlDhZn9t86bB5go1cB2WHgNrX41Eb?=
 =?us-ascii?Q?kdRBYVYt1xDdM5Otq5T/ieEcDp/xjTDKGtRJVQvOBnxmQqULJHL6Y3sERCN4?=
 =?us-ascii?Q?w0cuvQlaR9DA9JKSLb/jBLryOaXDlIbtqkPWXrz0lMjME2fMRPhmTUxOrmHT?=
 =?us-ascii?Q?nJI6b0NgMIjTiDQgdGmjIB6xGmshY8bnHXnsgnbX8wQMT94d4G6g2o6fR/Jo?=
 =?us-ascii?Q?zVbd2rXvxOVg46HNfi/hMGHoZw9MzNsbiDhR+ZXmwICUfgpAp6QwWQcZs3kM?=
 =?us-ascii?Q?xxA/16+TbREXYb8dbBZEEmDzuEG1beaTMCjmOt2CwuHXajFfYZvcTXUhMzEp?=
 =?us-ascii?Q?QMVxm6TnHM6DfjjPTJUNLEChBgen7sC7wvzcSJGA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 823c04f0-126e-46f8-17bb-08dcccd3302b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 11:17:40.2374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I0H5lMPyOINKJkLdm8dewAyXFAl7AHe13kV+f2bT7SXuPdmqEumvYp7H4ZwxsQrNaynBNTojyp2gQX9mXpJ+zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10607

From: Haibo Chen <haibo.chen@nxp.com>

PATCH1~3 clean up the redundant imx8mp compatible string
PATCH4~5 add support on imx8ulp. The flexspi on imx8ulp has a difference
         with others, it only has 16 LUTs, while others all has upper to
	 32 LUTs. so add this distinguish in the driver.

Haibo Chen (6):
  dt-bindings: spi: nxp-fspi: adjust imx8mp to compatible with imx8mm
  spi: nxp-fspi: remove the imx8mp compatible string
  arm64: dts: imx8mp: add the compatible string for flexspi
  dt-bindings: spi: nxp-fspi: add imx8ulp support
  spi: fspi: add support for imx8ulp
  arm64: dts: imx8ulp: correct the flexspi compatible string

 .../devicetree/bindings/spi/spi-nxp-fspi.yaml |  3 +-
 arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  2 +-
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    |  2 +-
 drivers/spi/spi-nxp-fspi.c                    | 55 ++++++++++++-------
 4 files changed, 39 insertions(+), 23 deletions(-)

-- 
2.34.1


