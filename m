Return-Path: <linux-spi+bounces-11365-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A189C722F2
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 05:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 90D1334804A
	for <lists+linux-spi@lfdr.de>; Thu, 20 Nov 2025 04:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2CE1F4CB3;
	Thu, 20 Nov 2025 04:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="jx2TWbzJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023115.outbound.protection.outlook.com [40.107.162.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7131D824BD;
	Thu, 20 Nov 2025 04:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763612892; cv=fail; b=ZKsrW7uRpk7Vy5viJ/aYFbzZwNOeV3acXYWE7qGVVvL5rPphKau3oK1OidHXuygpcLkhcPs7NytBKzSRM9c77TRGx1pN0SektWGQYiBkA+3mfrkTZ1Nky3zCVDItt+x8S99tzwnyeoA9woeknl2/x2YlIvpofNtE+wlgRRpdp/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763612892; c=relaxed/simple;
	bh=ltLdD7dDy1+K2MYrpGz6E1uK77MqrgiCe8v40QhXQa4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MOu/Ts0vCCFIoSLxlzELd7NYn2Z304zEsnUYQKJYvieJ8au219jNjdDr0BE9xVVXGpqBrv3vW6jIIlB5jBIo7COF2LHhe9iS5h1wMM2ft26BV7eQ5EjG/CI10SE43O1ARWcqLfGA9oCdyPiY9u/JFcP4MlpT3v7SvrRlC5Ri5I0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=jx2TWbzJ; arc=fail smtp.client-ip=40.107.162.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3kXh9AeQaG+Hv1FCGQ8K068aO76pqsoe6UuZH98ds1AJ2o1wJSDkZr/+5QV4evQHja9kZhfpvdQyQbJS1SfBlAoy1UfvoNj7FeURJsgZCeWf9hnIJ5WLQ6ITOfUZcxPR5O7M/qGo/FnEf1Lhgy+vy3PdT7OSJ2Ua8oY+YJ7rT4qEwUvW1WmTCMxw5ym2AZI9ItdEox1Ol5LoJg7QG7B/pAb3aI6kF3vncJETj7Dzw8GX/anTYTkmWAYvOyuwfzyVwcH5DA1taynNUo1+UfjBegCDuCako5j5ICIZgnihjV3iTDty4MDhq5w/QTqldWho+OXZwdpoWrGvHfIl/qByw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8HdSSH8mo/9a2nlWh2NQz27y3eMBfAT++fIBn2W0NY=;
 b=Aa2l4knqBKfiQiaLe0b7gOEoZmNytRwiJlYjyAWXQksm5DWSxq8Sl6RyKMiMjh4sDga2Snp29oLGwL5N8r1HpqjcY+/CLXaLVBMaT6xyF88q9/t+T0MJCojz6c6Dl/ipmk0u6RxBuSrH/h6SJ1aXK69Ie5WylxJjr8ngtuvor6wWlmKKF7wi+WEah0V0mj7xpxJrZO/8R3KfcVydh7DaDXd/t9w8BTMyDToTKUMm4k3xAubJ97tnBZcJZm4ZSgZk6eytTDkPJq6OmX2kxYPD+GF/osCIkCFWKHTmvizt5xMmNE+s6VeEgJ01iQURTu8BqpJoZCk350wjSeN6l34X8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8HdSSH8mo/9a2nlWh2NQz27y3eMBfAT++fIBn2W0NY=;
 b=jx2TWbzJZWc0oPtVhrXni7GPTY/xAtvsieDUg1xOnsjvhl79wo2yRHkmAioWXDCiWRuc2i9uLReXbJt4oBsDB/CFOClBwdbFd1ywN8sY1PtTrV0l7lkYc2pgBNsN4Oww/iNNbuXZkAlsnEermCbL3lEiBzhZiB0/lOI1ZAW3RtBSv54T1TDHlLxx+4c7EI8wZ97SQRmf0cgPpUXRiTiy0xN5CZU6dCGX5MR5K/j6Sf9ZJYJYYej7EgZ4lW5S0BG5tkD6wHg87ockw0pnRiudMs8KSXrcSxq34PagMtCZDDn9I7Vj+jUWh8UJjiZq99c7BmU26G0pAJKiZrtu06BfLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB6541.eurprd08.prod.outlook.com (2603:10a6:102:15a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 04:28:02 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 04:28:01 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
	Andreas Gnau <andreas.gnau@iopsys.eu>
Subject: [PATCH v3 0/3] spi: airoha: add support of en7523 SoC (for 6.19)
Date: Thu, 20 Nov 2025 07:27:50 +0300
Message-ID: <20251120042753.640492-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0041.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::25) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAXPR08MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: 151cd078-7d96-4844-d756-08de27ed30f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3QpAnT92T9t62GdqCeeojj8WMJukqlC+Xlu3aht/WJ19onYAQsTgszNQfpuF?=
 =?us-ascii?Q?QIvwYMb4ncUVGiJ8rog9+o/Jm8CKiesqcenaXRk1w+m9LFDNwo6zbxDZQtRx?=
 =?us-ascii?Q?jKK70TZaPFOLJjxFC8ip/1MeQD11YoPOTsNnj6Bk455lSvZRV7saS4yjYdKM?=
 =?us-ascii?Q?10BIpr52/Awc5Cdd6Huh6pjZo5ep3PlxcxJwakG19dFwqqCFczuxoIQQED49?=
 =?us-ascii?Q?qgesacH0cvLojXMD3FDIiH71cWUefBMZFCd+WBMS3mDVOFEUQdwkMrbbg8Hg?=
 =?us-ascii?Q?dUr8Mi4wzN1SkqKtyOPi86ygCveSkjRhmnN3x3v2KwJ54nvQC9N7BLjGPGCy?=
 =?us-ascii?Q?sAdu9dQ7ZQCxlT5skBCLQnT9+TE2lIW5tehmyr+nuV61frMJpDz6nO5HDGIY?=
 =?us-ascii?Q?Z9ryhueWMgmeRyZxdNJl8ykShU0lJwYeNJ1a6NFEB3ArW4qD9ioA0/q2L/oi?=
 =?us-ascii?Q?jpoZfyK2B/CEfGtRLegDxA7BCjrFloW0QJQMYmgckOVUaJfpvwCs39k3j/aa?=
 =?us-ascii?Q?hdsOr3fp9VBAv9RMMSOFDTERRoWiXKuTetFMDBnjzT4brY1Txl3x87zXrHZ5?=
 =?us-ascii?Q?x1nE2WEjhavDIIy3noF1woQRZGyniJuy+sCr9WdhSOIeyDwhdJlo7oNjv+7g?=
 =?us-ascii?Q?ZOcI8c2DaL4DUknf6iHKOxtLjC3M7Gx5+6kSVHQxI9GOajUoavFanAPUWs2v?=
 =?us-ascii?Q?1jCGiXJNHwydTsmaNRoLEwH3MuEgJ78LIsBJPkpKYPLak6lBiyu4SjKDBhZj?=
 =?us-ascii?Q?kF/f+FiwkNmIEye8iJq63A3LAoytg1EjEljq8T4lbcWo+oNj8VNMABzhC1xu?=
 =?us-ascii?Q?tR11p8Y7tCgHWftUtz87LBupncgJHo123eDgjEXdTYhVwra7T7KO6a1rOuRS?=
 =?us-ascii?Q?tOWLCp0t1IMsL9YHUv2wFSXrf0Pqr1rDlOfUb83WCBlM8diVxfGty9zs8EWJ?=
 =?us-ascii?Q?Xhl7uR1VlwU7kxMB2KnELg50ydFfqnys23pfDYQaoOob5M86NdeMCbzTtsnE?=
 =?us-ascii?Q?dHFsg+J8dg9zpJbDOZhW60wnpg/nRM56N/pUjEeEj0EqFsDE/gX0JVG1WQPV?=
 =?us-ascii?Q?6pAP0ePxLpUnHf8gpWIGCALoWlyRE/+XJzbIySbWNcvV+aW6MaRZSP08cGM4?=
 =?us-ascii?Q?Bj0EO42SfVVT6LFt1p4rduxx06ueWQmUPiUjOY5x3ATvAMFHx68W50idCwBA?=
 =?us-ascii?Q?op2g2185uvQuT/IEXvrrHIJprqNfMJ6PY8dYsx3ZbWKscdX8Pg5/w1MBwr3t?=
 =?us-ascii?Q?6izQyOBB+mCeRVp7TFV+M5vgvh3KMHNArOyCn5WkRJz6JTYhG1fFdEXBC1bm?=
 =?us-ascii?Q?lrvcttBdH3aF6jZCxjM9PLXKNSVo2klbRPEV+qW43NgZTweGtmx2QSWv0BMI?=
 =?us-ascii?Q?aHN/XXzZbzDGw7ijWj2dNYXKwd9ruJhAMHnLrLkm69LUAJ2nZttz4owDp/QW?=
 =?us-ascii?Q?RpBTIA5UID6oSZCKJ4GfEB/G3z7ZoxZBgDh6rycHqJHfCGhiMgxMILxgibLB?=
 =?us-ascii?Q?0zj/WcPFFIMzub5s29cZRxyb2AZFMBdimdAzHYBZcKQCqCxCcwBVeca3RQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S6wDTb/E4lqk2RFJghHlqsn3bO9ZFTQlcXyxRnamLiVvhDi0C54t8tSgVLsO?=
 =?us-ascii?Q?MpGbSb4UQPAX2v28jxz57NlH7f8bhXnTAMjYQ9dBgivR3ChOFoG9OtGyqu//?=
 =?us-ascii?Q?KDTUDhomird+4vGfBWgJlSvjfRkRc10qUfao/Redr8YwKAqIJF6aRT0gekio?=
 =?us-ascii?Q?5eQS9EJV4m077zYm3RTrVb26Q3bko0kKDHpvUg2AJd6iDw9P8w6YttYwGBqH?=
 =?us-ascii?Q?95DswfkGDI0ZNDhfnufRIol3j8PbXDzwVLRwwvYMYHC8UCzM6Kmv0wjTWbSE?=
 =?us-ascii?Q?RVlJdVarJPFoq+zidEbVL0glaotIJ+X4d7ZaPDF896vJUJufPlGIe7mjOi4S?=
 =?us-ascii?Q?SJMbMmRRAea9/XOlC4dgUTY8PcW/Qc5IJG7wFsn3A3RJ8H3aHhnJZonnVDps?=
 =?us-ascii?Q?NcsiJjm/0E5N+LpBCaoGngQar9RjmrLf6cvAIbC0OSHZeXUeNdBE8ISV1z3z?=
 =?us-ascii?Q?hbo6rrxZSxrSLB3mM2pefcRfxDXdP8gYnwk063Ut9qFL9eWTLW/iTkjdY2rk?=
 =?us-ascii?Q?It7SYqvU1QW+LZ9sWpx+WXTJjYfT7LOWjO6d0QS6A0viobr47ASHhwi82kVk?=
 =?us-ascii?Q?BlIdr85+sLqnsUQVosHFkgQDnlKS3Wj/Y0ZNcSu1ULgGH4zC+Zkj87PbENzK?=
 =?us-ascii?Q?osqTCoattcko7rytloa+TZOHyae35qIQGPJd1upXEwwpvWJvJ5HW+9RQ4nP/?=
 =?us-ascii?Q?aV7d8v2OAZdbuA3bmhkWy9mVZ1U5DtqYjwdT7oKwimZJrIgtHg2RTBEu2TQf?=
 =?us-ascii?Q?sLBMis9heZB6wB+u6b7h0uclJSJYNSZmnBeAbKiU5iatpfVLwOGziKqMZk7/?=
 =?us-ascii?Q?eYfephIjovb++YFchqKj5VQNfgBmvEQrCFffD2H+nT11CUgdGwFqRgkF65hh?=
 =?us-ascii?Q?dOy9NIFpMB2dZM8ntXKv2UjoKQ4APrE90DsX7IYva9pielmy9TVWhYKGx2kH?=
 =?us-ascii?Q?TY5jyEV76Sl4A5Jfjd1uScEDlDNrBz1UYhGIMSWlPOcy0PyH6l1bTqYnzPNX?=
 =?us-ascii?Q?+CNnQHKlqUjQqp0gQH0tDB4KdH0FyJww+0oDpgbr6s6jgH6aV0waig4XLK1R?=
 =?us-ascii?Q?tGg703QJ1+Hr2kf83oVANQZwMQ4RJnsEzZMTZCOXSi7U93eNp6HeZz61lGXu?=
 =?us-ascii?Q?GT88j12a3QVbFVQ/3xOSAuIPzmpYpI+Ye9HOqyPB7dzCgm+v1krPE6kaKI+M?=
 =?us-ascii?Q?2ouMcuk3b8mbuFmjEaQ2/hobVBp/lrhnj+iA2D7Kd3tLCvuzBoCzIFDPBNNJ?=
 =?us-ascii?Q?XuGcjj8N9JkYquQNbq3T4/cpUPzKiqbRXZ3ISzrPoyCEht4owW7Z2JBYhhal?=
 =?us-ascii?Q?iM70NjX+cH7DEqt0rHQmPi9GgOrKZgCmNbzXYQtQnqTg0GV/6Ka7VCoLzUHO?=
 =?us-ascii?Q?EPHHRHaf7GceiDuv8oloq9/NxPXN94za1wP2zoIDrmPdWXgpWnuSrvcl4BRN?=
 =?us-ascii?Q?Kw/LPOlHovic3EQpBDT4bsT/gfTnD6K2vIAu09ZZeMz8MzSdRFqDXDug0lD9?=
 =?us-ascii?Q?9AIK3vjaP1NRR9bFTM00aFGO0RtHhRq169ucinekJCXVpTVmAaIQ8EIgBQfZ?=
 =?us-ascii?Q?MkSafmg1aWLiNk/JiwuHdFxAtMEH0NH2LhLNLHj/b0uon3EE1VXF+rkRPG2L?=
 =?us-ascii?Q?RBP0C2l0MQa4Ba0SCRfAv48=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 151cd078-7d96-4844-d756-08de27ed30f3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 04:28:01.7748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pPdxNmw2oZH/Pv+OYy8ki9k485YJcWuBOTPp2D2kYTt/GvDVnbM2lWB+iiwPsjr952+R6jnzE1lRslgX8IIX4extB2BPxdxp3yQd+HNu8gM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6541

Airoha EN7523 snfi controller almost identical to AN7581 one, so the same
driver can be used. The only known difference appears in the very specific
boot conditions, when attached serial console force EN7523 SoC boots
in undocumented (reserved) mode. In this mode dma reading of the flash
works incorrectly.

This patch series:
 * add support of EN7523 SoC
 * add spinand node to en7523 dts (so spinand flash finally becomes usable)
 * updates dt-bindings to mark driver as compatible with en7523
 * disable dma usage to prevent possible data damage if booting in
   reserved mode was detected.

This patch series was a part of a bigger series:

  https://lore.kernel.org/lkml/20251012121707.2296160-1-mikhail.kshevetskiy@iopsys.eu/

All patches of the bigger series (except these patches) was already accepted
to linux-next. The was no any activity around remaining patches for a long
time, so it's time to send them again.

Changes v2:
 * small improvement proposed by Lorenzo Bianconi

Changes v3:
 * split multi-line print on a series of single line prints as suggested by
   Mark Brown

Mikhail Kshevetskiy (3):
  spi: airoha-snfi: en7523: workaround flash damaging if UART_TXD was
    short to GND
  dt-bindings: spi: airoha: add compatible for EN7523
  arm: dts: airoha: en7523: add SNAND node

 .../bindings/spi/airoha,en7581-snand.yaml     |  7 +++-
 arch/arm/boot/dts/airoha/en7523.dtsi          | 20 +++++++++++
 drivers/spi/spi-airoha-snfi.c                 | 34 ++++++++++++++++---
 3 files changed, 56 insertions(+), 5 deletions(-)

-- 
2.51.0


