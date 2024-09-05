Return-Path: <linux-spi+bounces-4681-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CB096DEE8
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 17:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C73932810D4
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 15:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81142AE7F;
	Thu,  5 Sep 2024 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HY9iwKw+"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011019.outbound.protection.outlook.com [52.101.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B59F507;
	Thu,  5 Sep 2024 15:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725551572; cv=fail; b=UDaXV08UCi7dYuPFvs+CTmZS1ge0yPdOEkv8sIClNdBtZUHzAGgc31bih9XYhfOGjTxAj7OT/8HC6HXF71eq2QnZGSFfHa08PwghgWYhYG4NbYFXSR/tFbqvHiYjLxBvXLWDv4993JflyovIsUrzvFsFmO8pGgq/PRA4da1u3Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725551572; c=relaxed/simple;
	bh=y4OK3fvYHmfwJfFFNPtcC1BOQRcIhJ79qzA68r9mMzs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=e8ziObxRMVqRNm1gI4ENUgRMoP6setqpGWjYCBCT+znF1XzqYU4ZOh/pAA5i19mC6fzvzU1VH3oo57P27tSy5t9TMI4ATc/ESbijOyypBoDrg7BvhwhKoXZF1uR3rF8/wtmC0SEu/Db75kqa6MhgfJsnoDNeX4/ZyZu/rxo9FoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HY9iwKw+; arc=fail smtp.client-ip=52.101.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSyeio4mahsqSOqXB5t4GsBhzJa6Ubothc5mpOPYwIqQ5nWhhV6hMCTRyDxGahQhgO5xO/nXfuvxA4Wq6sATuhwT3zCzM+STPszHDFcQkVTW8Jb2+kqDfwVpKP7Gb/FMH0dinW8nbHTqPHxVTVYjpyItAYv3BbbyoAbcKxEL/SAtAI7lawb+ju14LuZbQnpd9QzE8fVJeMQ67iOoXK+G2szonhRZ6imkBhJzJHazZOhJ4bF2VMuNGr/pAVDEUnj+DI/3MwvhcOM8lx9OXO8y6cY/BEoxuC0/NlNVV06HANTPcxWtNrMfHLPKYGRTCVccSFwD4q8veBz4uxAPJNqmcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8JCXmvp4hCFqcw+MPTFiE74cXHxRP+zXJvRzewC8XI=;
 b=Q7zwnQ08o94m63vAzxftp30ZRblkwJqhQJ5k0X/Iqo6mH34gEcsAN4L0KW8IX4ULynRVKqgIgA6iKLq8eBxQkEU97VDkXqN+9X1+M/ilWnn/nA5K8jHKcQfrOwhoKl/r4illc9Ei4GQ/h3jRN2aGaxmgv1g0NepBYh90igZFfEgf47BcN53Edb+O5nEH5Biqx/Xj0fQk4nZMI0u6nRb6CBIYySPM1+1i9SNYPo6pcxQKP/B/HY4Lc/kJ4HhW4yZKojKHp6C6CtqNFTXY9U/EeD3u7nI+ffF7Xf0eh63CN+Bq7mNXNnc6Lv3aVoalFkR8yDhMbJi8yCLDhDhEVUXk3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8JCXmvp4hCFqcw+MPTFiE74cXHxRP+zXJvRzewC8XI=;
 b=HY9iwKw+TPHko2nwRTiZ223ZTRFVq1GxOr7LASd05ZL1nrUI2bEqb7IaPofNW50cMHCCzObOJ+qeYZ0CY86vIgcDO7hoWQnr7prsfrzWnoDHLDgcqhmWcNbUY6cyXrCwu4wZbxDstKHZY1jq2ihQPfYqS/CuOgXM/epwJULQTvBwtKnOs6IcvsMq4y7ozChpNYzVqCOSn1orMkjzKZckMO1/fAywJ0pDu0+k+WcctEJOYisTDs4N2bOBa+P8J8/7aEu5JJ8w/8fsmjK5YQ8rSadsbgc4UIo+e1Lh85OtfzrZEvmiStNdWLRCso7MIfFPxtAXqRTLN5Mug5piZyQBbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB7715.eurprd04.prod.outlook.com (2603:10a6:20b:285::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 15:52:46 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 15:52:46 +0000
From: Frank Li <Frank.Li@nxp.com>
To: wahrenst@gmx.net,
	broonie@kernel.org
Cc: carlos.song@nxp.com,
	festevam@gmail.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-spi@vger.kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] MAINTAINERS: SPI: Add mailing list imx@lists.linux.dev for nxp spi drivers
Date: Thu,  5 Sep 2024 11:52:30 -0400
Message-Id: <20240905155230.1901787-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0093.namprd05.prod.outlook.com
 (2603:10b6:a03:334::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB7715:EE_
X-MS-Office365-Filtering-Correlation-Id: 247fe0d4-9887-441c-8fbd-08dccdc2c911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L5qWr4PEBqv6MgYF2UQd9FVchLOVVYtl14uWvtuRN2ebOybljt0MsP/03y5X?=
 =?us-ascii?Q?B4xN4AUgxA8dLY8Q/wRYJP/ILh3pXeF6XfOyp6ojLta5fYijdGiX2yA8MOYs?=
 =?us-ascii?Q?64GV6MZirevHcm4iwGgz30Ic0r0DvLHHpXSqf4AABobN2/7MVVNPJS7bEv3s?=
 =?us-ascii?Q?Y4LXa1hoECBXwKpxlDAcieMCipVTbSZlezzoEOPQUfKxxdyH/9yvQvJ/98fE?=
 =?us-ascii?Q?AKuQMnlQpWxbkPo2fAl/FJpyCv/3eUjWN5qsLe3c/Mp/Ywols5AA5HRMpIHY?=
 =?us-ascii?Q?eWaOlY96EgJUs574qxOwvVQ75TWiD0hZjjlsntMrdsIT31mHqWN14u91PoQ5?=
 =?us-ascii?Q?z/YuK+mB3IAOIETdwBGV1hdpR4wI8n7iwf0aIirefGPOdRLpClr952smaJ/a?=
 =?us-ascii?Q?FKC62knjirPSfhJOTLl5m5rkohFAqsElpjriAdb7qRaXY0kNBdXgKXVfjXN7?=
 =?us-ascii?Q?Os47qHjYP2ajnicvjPTlz9DsahcoygwIssukzK0X5DmYYQyOiJC4oWMgxkkb?=
 =?us-ascii?Q?obDY+EA4GMyeECHT0bpRSndqa1U8EyKLJWiMOY0NsNvj4ATBc+HXSeGBlEKQ?=
 =?us-ascii?Q?oIobPJoquRaPrWmFF5figTKEDxVi3KrlWiM06u/X8YnWURA+YdEvaX7eV9LK?=
 =?us-ascii?Q?z+4iLpiDofbNu1XN5wonVkehqzdtrwT8El7cdkYEv/yU0pLHfEFx/RXVf9v6?=
 =?us-ascii?Q?IwmNmNqwSqeUr/T4KXcWN25wosO1HnQab7ArshuVDfIj1DT7DjSqfgB9MzD+?=
 =?us-ascii?Q?JeIbVuddfXiHxwARB0N3skPrZTz6+gdTn4awv5j4M6Pue8mqb8qNjYyVfkp7?=
 =?us-ascii?Q?pKLFCAaQDXU6cqkKQq00MMzMK+dTjfcn7UZpqiL1tOz3A2LgMqV+F8Ag6vOR?=
 =?us-ascii?Q?hLeyDNSuZk2rh/8oub6p3dCwjt8Kfkx5gh/eOMLgbO5HM0EfL3J2UiKNH0Kh?=
 =?us-ascii?Q?ORllWvKevoAXPZ5eloHSwGDdA9iuBWPo+tK/L4bAi/zX6Y6UrGc3mhJEsn9+?=
 =?us-ascii?Q?PlTVS8+x6mXFyQKT5dori0CDUtm3+RRkmFMeYlFtGfI3FkST3xwCoVrr2rUU?=
 =?us-ascii?Q?w1q8bsLwbO719epmpuA0co0uHdhClxA1clNzZjaXJKEKCee+wHvOESX3U48U?=
 =?us-ascii?Q?GFh14bvSPH3LFVCFeh0XTnYH+3f6GG/dUbeelqgMKxcffKsHqZtchOlhG0OB?=
 =?us-ascii?Q?Uuudjx5vSndtdnGdFya+kbDTXFc/NKRZnZkxkkgnTWLDu3br/JVH/7GLA1LB?=
 =?us-ascii?Q?sHpERo0p9RLY44uCejdaZzRI5wwJcrX6tzeoc6NF9HoIGRmwGH+4ZEn5tI/r?=
 =?us-ascii?Q?QfIB/BNB1bTsvBFoyyAfcXuctbwPI3EO2lkA63mbSQMNeJETTRB+UQSqRUmr?=
 =?us-ascii?Q?ZrYvr++CXTX5DjOMqiK8g8kj0mfgrl99Ico0BqFM1ULXzTO6hg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3ir57mW2AIDhQN5OXGSVD31xkASUxmJlPv8f6H7bBjsr/tgmLIE2kcXlHaJ7?=
 =?us-ascii?Q?kk5sWP2oEnctEjcOuMqiupQYak2ll0pg7GmvyS3StJd6xmECuL6Y9aU8cqgO?=
 =?us-ascii?Q?5YjYgznO6SZ1klL0XOIswcJiFN47mOFAh2bPLtAkiD0+CiKGr/JJotpnB4vb?=
 =?us-ascii?Q?jC7QfanfyKua8gPQWd5yujCC7Uo6i3DVJKc4Az62/kJuiekDU9qy0Tu2yUqG?=
 =?us-ascii?Q?kzZqXlIShbu+luy+6akNJz0urijp2vz1O40iasxcYgJh1/qLsDfkNG9Dc7s6?=
 =?us-ascii?Q?L1jt7w930YXO+8DYRqmr73u1laWqRfNkNf3maRRjZxvYI6TY6b4rWbm3WRkx?=
 =?us-ascii?Q?KKryPFLyQkY6KTNR4k05Rl+CawbC73P56FUhJCXNoRq4DEADQv0n4PlJBX70?=
 =?us-ascii?Q?tND1fk86paRRssVLsgsEURSmkYSd4hophs3v9772+SOJ01pmZrQVzXOz2Tb/?=
 =?us-ascii?Q?PypbryaujhcJ2Crl3DN4wFBZJpDIQRHYNUKg3WVcY3e3tdPR98wCTgUUfvNI?=
 =?us-ascii?Q?1265LBjeLSBNJuuP0kuAucpuVs6BSKodBRJ2wip1i+tsF+F8Ef/843uTbdEc?=
 =?us-ascii?Q?Rn2Jerx4KqC8XrpTqnt7ro+xjRU1uAcZsJtnGACrn3tbQnNBG/z/TfxCAO9q?=
 =?us-ascii?Q?PAK9N+n8IhhsTEALN4JvxtMbCsEIJi3t3Sm3OBrG0Do4UXBuerNiLutCWVcg?=
 =?us-ascii?Q?KD6RS/3FM6twxQSuK8SKvhwc52790kTIJ4ugx9W48ozfHWlHyXumluzSDbJc?=
 =?us-ascii?Q?ZUe5XSfehaz/BWg/PzMZQG5VOnFlftNcB4io/dXdbjjjZKcQS/6w/1TAUU/W?=
 =?us-ascii?Q?qN1cZ4BfKONJU/zAulxwbwQ1ZPf0ucxUMUWNjfofPoFpnkfC1JdmiDV8rGnB?=
 =?us-ascii?Q?v5Xl+Slvhrliq2E+2sHp26buS8/pC1lLjVPPEnYi0QUFxX3NbEp9GyygcAyD?=
 =?us-ascii?Q?Plp7h+Le8j9EAOds9WsMuUo7jculhXctl5F8bFqa28qIg1f9qmB2GEJMD3S3?=
 =?us-ascii?Q?MyIZSd/uIqL3YAObzYmNQ0d5PQmyweLtAJZG7lRTWNuOWxaJWHWZ56E8yTwH?=
 =?us-ascii?Q?gBgQAbNxn+RxJulqWW12bvaW4KN5JprGozDCTHYMUsGta4T7nsgIwHnxvXLg?=
 =?us-ascii?Q?76+OXRspIbrpL5BP5qgqXHIpT1vPgkoeIjsgT3N0GKHvBpslLukIcThhifQD?=
 =?us-ascii?Q?OWfHuLkPb44NZyC6e+RL52esz1GmhWptA1L6i/Tl+iG/ZJ2xq7zzf2q2O2ze?=
 =?us-ascii?Q?1+diHiQMIHQkLoUVPL4vTxHwB3hidFeT5rkvwvy4CcOC1PXdWxYWmpUDsYHn?=
 =?us-ascii?Q?XLRbZV+yzegpG7hOYy53Jwy9KjrNJau6MIXmOeIKilSWwtQFT0nSelPzLOmx?=
 =?us-ascii?Q?DYjk73npt3MV1Hi4r84b3tL9ga2LT3CIEmRJUBEVlVD1OUzOSkSHQ66p/XqO?=
 =?us-ascii?Q?w9DSa0m4PnI7+5qWyuGvSv9sWBe7iKAX6NIllwSHPmAn5B5HtLb0QMc9oIr7?=
 =?us-ascii?Q?BTapo6MRRvn4NrvqzMvkjjOgFmtXUM7ogUWmbyDUU8f0kEDdyC1bJZwpEPI0?=
 =?us-ascii?Q?Njj2DXWcaYU0Sz2gF9pWwVcoO8LGPxSmvubFXMhy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 247fe0d4-9887-441c-8fbd-08dccdc2c911
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 15:52:46.3271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ipbIHTylFnpGSXPir/Tq2nYV0VhER9EC4tgF9zCOS4ycV7O0GLMmxk3XXbsGPUH6O/xcl7XwF3ezywwM8KLgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7715

Add mailing list imx@lists.linux.dev for nxp spi drivers(qspi, fspi and
dspi).

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 59eb18b0261fd..8900c53ae66ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8958,6 +8958,7 @@ F:	drivers/dma/fsldma.*
 FREESCALE DSPI DRIVER
 M:	Vladimir Oltean <olteanv@gmail.com>
 L:	linux-spi@vger.kernel.org
+L:	imx@lists.linux.dev
 S:	Maintained
 F:	Documentation/devicetree/bindings/spi/fsl,dspi*.yaml
 F:	drivers/spi/spi-fsl-dspi.c
@@ -9086,6 +9087,7 @@ F:	include/linux/fsl/ptp_qoriq.h
 FREESCALE QUAD SPI DRIVER
 M:	Han Xu <han.xu@nxp.com>
 L:	linux-spi@vger.kernel.org
+L:	imx@lists.linux.dev
 S:	Maintained
 F:	Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
 F:	drivers/spi/spi-fsl-qspi.c
@@ -16562,6 +16564,7 @@ M:	Han Xu <han.xu@nxp.com>
 M:	Haibo Chen <haibo.chen@nxp.com>
 R:	Yogesh Gaur <yogeshgaur.83@gmail.com>
 L:	linux-spi@vger.kernel.org
+L:	imx@lists.linux.dev
 S:	Maintained
 F:	Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
 F:	drivers/spi/spi-nxp-fspi.c
-- 
2.34.1


