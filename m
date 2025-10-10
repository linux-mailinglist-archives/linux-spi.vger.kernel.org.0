Return-Path: <linux-spi+bounces-10505-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C33BCB86D
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 05:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 109234E4FD8
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 03:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274F12749EA;
	Fri, 10 Oct 2025 03:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="ixS10/5O"
X-Original-To: linux-spi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023102.outbound.protection.outlook.com [52.101.83.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F52271470;
	Fri, 10 Oct 2025 03:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760067126; cv=fail; b=SolLY0wEkD25Jh3aVET/KjhWy3Xu07TXFrzlnwKx3VTWq7/JuGhfOjbUyMK16M67KhgxFRNV010brqbXFRECfG80CP31s7nEMc5g+HD8sbNVkja/wUqsgLLJcDuPfgq8h5BQBGzPlajfOBfjM5RiJNFD0A+WjXUVD4JLtvFi6YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760067126; c=relaxed/simple;
	bh=4vEupTlFblAxVYLWw8wNiQeHRVE4Pd1f1C8AoyYUpKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C7no86aR8iqvWO+m4VkMLlRiFlpY0NJ7oGRWXGrNLP6O9HcrW9eUAop5K/CJCP5dmuyqHwRtX2YNsUrhhPL2xF+iqH5B/tyqhUJ3JbcxD7h2fvcaXqFS3ZEK3Gk27v4poypBGL55+0nkZKRbtz0iaDIuTyNZ8BmfXSGOe/2s0Yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=ixS10/5O; arc=fail smtp.client-ip=52.101.83.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PF+LSgiCAe93N3DF6kg+BAR6BVj+kaMm+A7cYZxK0dNQB57WYAg268p6pdDKfNTmV6bc5hIRjCTjR8Jo8IY0FmHg8l1KbG3jANFvhixdaObDEImHijlqXawarqGhb57FhTUEWJmAOi6YslqhTp26bT6Bvx5NZP/qcrKZPh/giMmVjYMm+K6I+CR2Qs19yPisOzfk2FVK2Fg9awk0Fco+ffM7zlhlUxsUAOGxpGJ9LjoLaZzUWMEEoWlGKnkzs01O43v5DavvGkd4RolVtQ4fmjdVtuFvJJFb4wZEM4Izs1n7rJvP6sKf7HB6/AUWUqY+74MVfFkj+mtxusjcjbMppQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vYefZq1Kji++ENuMNeN4dsMVnRysysPfLivp5ZCp2Ho=;
 b=f02LkIMUqRFEK6Ro5DnqiZYSVNuH4CtzDXEh0Gp24yc3hehqjXujFqxS3D0XqtWgsM5h8k9Zaz9GQnEcw6Uli1kqpORmlxNB0/+yFnCLDVTpH9zkVdtyl3KJz3EHZyu4QuSGOnNDc6yRz7lJgcSUCgvGCz4AGX9P51Ek8J+ZCkoVoxKohU7lzQZPGv3MSc3MUC5Rk80+7/3erLwy0/VSih2b6xylYxAa8E4QtNUJYdw+O1DgtDZFts4bOjspXbwMIZJvqZLhO3ASBVgU0DzIn9JSyeVuxR0y28kBuw93mJE7ZKGUAbfhkZru8f47yH6i3QTT0W9pnpOqwpb/DDokZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYefZq1Kji++ENuMNeN4dsMVnRysysPfLivp5ZCp2Ho=;
 b=ixS10/5Ok+ib0ZwQStVFPQHkgq0YTt6IN/1pAhD7d1C3+5cPPeMQKh1BUeUgIzCBR2L1gR4HxfxYi4l1kqDM2Nh0tf+nQGpKN+nkOnVFsM/hXLdXLioZP3nrTWYVkGwrwNLbx+P45Nbt8t8iuw8anQ6oIDyd7RDrMqKU0SDO3aiIce/epojyAVw//zfB11sUWuSo7Q3Q4aiaSBP25Mb1Jsf5rlC6MLdYJJMyFpSix0aH2SeSyCUqkdFAnYVSi4TF37GpXfnzqRedDpDObOJdwa/sW0QJMfQdt997rtMKO5WgPuVH+u15kiOQnSCNOvDBrkCcpvctw0LamyGYUrlb7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DB9PR08MB8359.eurprd08.prod.outlook.com (2603:10a6:10:3d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Fri, 10 Oct
 2025 03:31:50 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 03:31:50 +0000
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
Subject: [PATCH v7 03/17] spi: airoha: add support of dual/quad wires spi modes to exec_op() handler
Date: Fri, 10 Oct 2025 06:31:22 +0300
Message-ID: <20251010033136.1475673-4-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010033136.1475673-1-mikhail.kshevetskiy@iopsys.eu>
References: <20251010033136.1475673-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVYP280CA0035.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::28) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DB9PR08MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: ad55fc4d-7d83-4284-ba4e-08de07ad8c78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+eLK9dld0T/qeJ4Ik6nbyfsSaMn7WIR6ESIDKXiDCNXtARqBZO38SbbqF0ON?=
 =?us-ascii?Q?DKHk7yN/cZsTo7Xd5r/Z5+eaIdD4gjKoTbnVebIt0vTtSYuuNiqeRH5VrL7z?=
 =?us-ascii?Q?ZUz7fKioqpQGchUAGXkQO40dVclTAShUN2QZmIr7B4vQdh7e3f/kxOe6ueVg?=
 =?us-ascii?Q?DuC/1X3r+U+54YBEmdOm1iECMVyTBbIXQNKyt4rPCMPtEWrsS21ZInPIHymd?=
 =?us-ascii?Q?gD5vhoOWjp3XzzJ8P2w9gk8gRghPw5R5rW4N7Z2EPgXywfn50K8f3/M7OCo0?=
 =?us-ascii?Q?JBwXrBaLn+RxfDG9pn0met3IWHa85368U9qUt1YwbEze8tcWssNZM1+OE6x+?=
 =?us-ascii?Q?NiO6NIsFujkYlMYuVt29lc+bmdqc2BI4Q7arIr+cgtyI2Z/9ZRmSKjsSwo2Q?=
 =?us-ascii?Q?3r4Byyw2OrdTBat2PC77degCwU26uMUkKVKpceDJcpZ5unov2GOq63o13j5P?=
 =?us-ascii?Q?OmW+GdfefyWxBZmu1F06mPoHEWTCUXfXZgjJioL6QiMdWi2svSps/AO6VZ52?=
 =?us-ascii?Q?zbrmVEaqty7ViaPgCdZpClHngxDIeZM0IvF0fRErxwT0urctnr1drQVp1+85?=
 =?us-ascii?Q?pZOX/iH4UCGRfoWQbBWib3FG/+cji+T6kLeTOAm5FNsg457nbc98a8m0v8Ya?=
 =?us-ascii?Q?4osepBwbdqlht1aFSKit874V6qgB9KylR+jre8hgAw45hl/APg9Okz9/FASa?=
 =?us-ascii?Q?OX9zG5/qeOUTrKSyGAT+hNHjP5drj6EJbwHs+5E2JGlNU/eYIPAav55fpyff?=
 =?us-ascii?Q?ghPvrL3cnCQHsg6eIZb3YI8tovhf1kedGSUA95WBs0bz7zCj3R5f6IZ/g/37?=
 =?us-ascii?Q?wFL8ljtvzqwmBfRq/F6sHSyuPiotyl7HWGmFC+3JRMe1LaRHTPT6rYiOihxL?=
 =?us-ascii?Q?RFr6wMWXqSV0B52cNcLrXUrB5xMiRH5SD6Hc8Hsazq+gt11ubsPSDVhZC3Qm?=
 =?us-ascii?Q?YeWMFNEUL8LY3mljqrfchNqkNLWBuLNZUYgr8NLfORlaIDVRN5oN61l16MAS?=
 =?us-ascii?Q?mPBe1sK4aA3lHRFilxQuSGGdQ2BQpzHNdt48LoI0dKC/SfKZEl/rNUFBXbwI?=
 =?us-ascii?Q?FCZJYzqh4LgngTn1Uhp25JuRm7g4E2yWcWA2Cxt7UJU1acoimG+xUx8nd6gT?=
 =?us-ascii?Q?8fpl6OuYUBHdpGV+e9cQKztnZNHKIOMeWCxIsXTSFAsO6zMSyxazVl9gnFlZ?=
 =?us-ascii?Q?dWQcEILgEHk+wccGGlTB1Qq7Au3J5NWvnBg203pdR+7AxHN0Jb2MQ4vQ8tdQ?=
 =?us-ascii?Q?IKIISEfxTS4WxD80vpRk69stGdHE3wRcW0+aUuXEmo6BiRewCQheQFhgsmRk?=
 =?us-ascii?Q?vzvN2zF4czilTAUp3Pu7V5p6D3mXnSJ0XISjiC531I9kcDLUlxjx3A/fqjrU?=
 =?us-ascii?Q?DtLZT1QeG/9FiskvtsQ3nu9JYhXJ968rp6rHpixC43Be1GYZMM4Hd0UYhLxl?=
 =?us-ascii?Q?YRYlmdtTrPvhYZV9okoF1IWHlZgjNrDJbm2fauWlHMaJrrx6+XPl0aifiUml?=
 =?us-ascii?Q?G5Qbh1s4cDML7t72NrW29i8xa6zlWVxBwYWC+QrXPp365jBsljS5wcl2Tg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CYi7gRX8s7Af6wOqfKvdOBjjQPF8FubjIBW0rqfSPXUklyKy1wMNd81e8Sxp?=
 =?us-ascii?Q?exAjsBsj65n6mPJWJT4zd2Syh6txzFcCiW3hKJ1MFqOEXdXI4jnOygyz2EW0?=
 =?us-ascii?Q?x0CfoaBrS5O9G5e+jMHv/g3IBJMoGn7q+jN9B/kspc+Gkc83uDeaslfDsuhZ?=
 =?us-ascii?Q?17nmkD2CzKaLyvA/ykOG9i5+QNPUgM33do5DDHaGEFfZ9M3/cXcHbo1ePxAw?=
 =?us-ascii?Q?ak1n65PPP3qK99fpovRg5JG5kUaYs5QaYpkhwURIZ/gVUe6fXUCz30eyvtWC?=
 =?us-ascii?Q?yr3ZAVPoaC26Am+2+VlgqbbqfsaxErF3PcDrEGKsJ7jFjWsKbD9ezX0Lc53K?=
 =?us-ascii?Q?7hEULhq839i/n5AQ/xo40U5F23G7CCyzEGnLar/tsDJAQO4bt29lGdHWHKEa?=
 =?us-ascii?Q?dx4ZB7owrCECMLN2nkB6XYxXU7abFet7vpF/nbIs25AaZjstkoo4S0/lvdEm?=
 =?us-ascii?Q?h6OHA2VDoEoM0zJ7T/eXx29DhIqt5LbpGIRhPuzQcer8x5tocykJhJnsdDdK?=
 =?us-ascii?Q?QRkpBpJzY+kIrQ2Mq9conp+PTRm6tiHqQ5qesW/rtd1zvmZu+PcOx7eK/Mth?=
 =?us-ascii?Q?XdiqayjQ3BizOMOOM7nOXtxHLNna4hm2eeQEvHVSbgoI/dqVNHV7erVwrrq5?=
 =?us-ascii?Q?lXXQ9ukW/b9iHfnAkYBMPyEoePB0W0iX3oTFqOB8mG0FsD8BdbtLVOKl2MNp?=
 =?us-ascii?Q?Vata10h+N+z8HyqDWWCn3Sx37sG0Pq/XKQMLPn4HFD6mVyWXOB31B3IQ1ML0?=
 =?us-ascii?Q?/J+ybsEr5W36G1FI5/0rON5gHKh5ea3l54Gf0c7SJPdKSIpylN5sDMltq/Jb?=
 =?us-ascii?Q?uyeF00fAm99KuMljhnbr/OBdLkLqcAcidvyvRnqYkfIjvQgzaiS+SSBtP/B4?=
 =?us-ascii?Q?VfhIqKo6i+ubS31HPyWaZ8bz+jYZnOpSYVN7BK875rTLiKUV4dWGv4qt7En/?=
 =?us-ascii?Q?dz4AU/yAsmeJ1LGFu2HMIoXK6j8tQiWTCx7xrwJwalHEi3hnhA3HmxdbYtR4?=
 =?us-ascii?Q?jeOR8LHQh14h8ykH34YPQ5N9MQdURTbtz6a9XstQ7jdpewdwt81dZpprzDxZ?=
 =?us-ascii?Q?umxYIDc+aHeYoUwvxnw+NIXbOuZ2nlXC9rggoHVND399YCy1iJ5HBMRMAvdC?=
 =?us-ascii?Q?5vVcYiR5UpYfnmVBqvqrTzWKDptl+8qy6f5C4e0XNLT1ey8bCV/0Vnt7oehH?=
 =?us-ascii?Q?avmNhqFoGFJmZXKm0DV+X7cjmKMGL9n8wXrSen0igBVG8BArHegELUbjYlFN?=
 =?us-ascii?Q?2PfSAepcFOgTh8maZ6HzXbeQB/zPDB0/pUoFztjIDW7ERphCommbESe1Rr2I?=
 =?us-ascii?Q?YOcnF5aKyUNkrMAeZz3WDsVcQ9E5bKhanQ+bCMByt/ZyByArrrCbkXHnoNf4?=
 =?us-ascii?Q?ZJOGmqd7lcHaJM8ivaQ+aptCgPJ4RmgSuY6qw7fUiaiT8ugyzdWEMgPFl8fX?=
 =?us-ascii?Q?fMpvI6YPFvONQQLq8S/NCyaIYU/yS/m5/uCKrm4J6BPbnz4fE+VfmTCXeJxC?=
 =?us-ascii?Q?Nd9pMRkNSkguJxoIuuvHYj6WThzg8MoweTUc7gJW1PQZ3at+KDcgoTYjCJJ5?=
 =?us-ascii?Q?zS5Azns4pIvFNJibna/TZSloRsecpSAcifSCCJPMIqEHtOnEvG4QbFxWXJEK?=
 =?us-ascii?Q?IlxiAhWKKou+7DcLAEobOpk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ad55fc4d-7d83-4284-ba4e-08de07ad8c78
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 03:31:50.2870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYzku7XbU16Wor6A2EVIkeAOs77AQKmGU/871lSu02nZPfGC+TRAZYazG2pBc/Jg2FrSPFbnD1y9BxSn0HWo8ooUPy8DkHtCbQu7W3q5a4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8359

Booting without this patch and disabled dirmap support results in

[    2.980719] spi-nand spi0.0: Micron SPI NAND was found.
[    2.986040] spi-nand spi0.0: 256 MiB, block size: 128 KiB, page size: 2048, OOB size: 128
[    2.994709] 2 fixed-partitions partitions found on MTD device spi0.0
[    3.001075] Creating 2 MTD partitions on "spi0.0":
[    3.005862] 0x000000000000-0x000000020000 : "bl2"
[    3.011272] 0x000000020000-0x000010000000 : "ubi"
...
[    6.195594] ubi0: attaching mtd1
[   13.338398] ubi0: scanning is finished
[   13.342188] ubi0 error: ubi_read_volume_table: the layout volume was not found
[   13.349784] ubi0 error: ubi_attach_mtd_dev: failed to attach mtd1, error -22
[   13.356897] UBI error: cannot attach mtd1

If dirmap is disabled or not supported in the spi driver, the dirmap requests
will be executed via exec_op() handler. Thus, if the hardware supports
dual/quad spi modes, then corresponding requests will be sent to exec_op()
handler. Current driver does not support such requests, so error is arrised.
As result the flash can't be read/write.

This patch adds support of dual and quad wires spi modes to exec_op() handler.

Fixes: a403997c12019 ("spi: airoha: add SPI-NAND Flash controller driver")
Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spi/spi-airoha-snfi.c | 108 ++++++++++++++++++++++++++--------
 1 file changed, 82 insertions(+), 26 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index bcc464ec9c61..fffed26ff990 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -192,6 +192,14 @@
 #define SPI_NAND_OP_RESET			0xff
 #define SPI_NAND_OP_DIE_SELECT			0xc2
 
+/* SNAND FIFO commands */
+#define SNAND_FIFO_TX_BUSWIDTH_SINGLE		0x08
+#define SNAND_FIFO_TX_BUSWIDTH_DUAL		0x09
+#define SNAND_FIFO_TX_BUSWIDTH_QUAD		0x0a
+#define SNAND_FIFO_RX_BUSWIDTH_SINGLE		0x0c
+#define SNAND_FIFO_RX_BUSWIDTH_DUAL		0x0e
+#define SNAND_FIFO_RX_BUSWIDTH_QUAD		0x0f
+
 #define SPI_NAND_CACHE_SIZE			(SZ_4K + SZ_256)
 #define SPI_MAX_TRANSFER_SIZE			511
 
@@ -387,10 +395,26 @@ static int airoha_snand_set_mode(struct airoha_snand_ctrl *as_ctrl,
 	return regmap_write(as_ctrl->regmap_ctrl, REG_SPI_CTRL_DUMMY, 0);
 }
 
-static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl, u8 cmd,
-				   const u8 *data, int len)
+static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl,
+				   const u8 *data, int len, int buswidth)
 {
 	int i, data_len;
+	u8 cmd;
+
+	switch (buswidth) {
+	case 0:
+	case 1:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_SINGLE;
+		break;
+	case 2:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_DUAL;
+		break;
+	case 4:
+		cmd = SNAND_FIFO_TX_BUSWIDTH_QUAD;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	for (i = 0; i < len; i += data_len) {
 		int err;
@@ -409,16 +433,32 @@ static int airoha_snand_write_data(struct airoha_snand_ctrl *as_ctrl, u8 cmd,
 	return 0;
 }
 
-static int airoha_snand_read_data(struct airoha_snand_ctrl *as_ctrl, u8 *data,
-				  int len)
+static int airoha_snand_read_data(struct airoha_snand_ctrl *as_ctrl,
+				  u8 *data, int len, int buswidth)
 {
 	int i, data_len;
+	u8 cmd;
+
+	switch (buswidth) {
+	case 0:
+	case 1:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_SINGLE;
+		break;
+	case 2:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_DUAL;
+		break;
+	case 4:
+		cmd = SNAND_FIFO_RX_BUSWIDTH_QUAD;
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	for (i = 0; i < len; i += data_len) {
 		int err;
 
 		data_len = min(len - i, SPI_MAX_TRANSFER_SIZE);
-		err = airoha_snand_set_fifo_op(as_ctrl, 0xc, data_len);
+		err = airoha_snand_set_fifo_op(as_ctrl, cmd, data_len);
 		if (err)
 			return err;
 
@@ -895,12 +935,28 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 static int airoha_snand_exec_op(struct spi_mem *mem,
 				const struct spi_mem_op *op)
 {
-	u8 data[8], cmd, opcode = op->cmd.opcode;
 	struct airoha_snand_ctrl *as_ctrl;
+	int op_len, addr_len, dummy_len;
+	u8 buf[20], *data;
 	int i, err;
 
 	as_ctrl = spi_controller_get_devdata(mem->spi->controller);
 
+	op_len = op->cmd.nbytes;
+	addr_len = op->addr.nbytes;
+	dummy_len = op->dummy.nbytes;
+
+	if (op_len + dummy_len + addr_len > sizeof(buf))
+		return -EIO;
+
+	data = buf;
+	for (i = 0; i < op_len; i++)
+		*data++ = op->cmd.opcode >> (8 * (op_len - i - 1));
+	for (i = 0; i < addr_len; i++)
+		*data++ = op->addr.val >> (8 * (addr_len - i - 1));
+	for (i = 0; i < dummy_len; i++)
+		*data++ = 0xff;
+
 	/* switch to manual mode */
 	err = airoha_snand_set_mode(as_ctrl, SPI_MODE_MANUAL);
 	if (err < 0)
@@ -911,40 +967,40 @@ static int airoha_snand_exec_op(struct spi_mem *mem,
 		return err;
 
 	/* opcode */
-	err = airoha_snand_write_data(as_ctrl, 0x8, &opcode, sizeof(opcode));
+	data = buf;
+	err = airoha_snand_write_data(as_ctrl, data, op_len,
+				      op->cmd.buswidth);
 	if (err)
 		return err;
 
 	/* addr part */
-	cmd = opcode == SPI_NAND_OP_GET_FEATURE ? 0x11 : 0x8;
-	put_unaligned_be64(op->addr.val, data);
-
-	for (i = ARRAY_SIZE(data) - op->addr.nbytes;
-	     i < ARRAY_SIZE(data); i++) {
-		err = airoha_snand_write_data(as_ctrl, cmd, &data[i],
-					      sizeof(data[0]));
+	data += op_len;
+	if (addr_len) {
+		err = airoha_snand_write_data(as_ctrl, data, addr_len,
+					      op->addr.buswidth);
 		if (err)
 			return err;
 	}
 
 	/* dummy */
-	data[0] = 0xff;
-	for (i = 0; i < op->dummy.nbytes; i++) {
-		err = airoha_snand_write_data(as_ctrl, 0x8, &data[0],
-					      sizeof(data[0]));
+	data += addr_len;
+	if (dummy_len) {
+		err = airoha_snand_write_data(as_ctrl, data, dummy_len,
+					      op->dummy.buswidth);
 		if (err)
 			return err;
 	}
 
 	/* data */
-	if (op->data.dir == SPI_MEM_DATA_IN) {
-		err = airoha_snand_read_data(as_ctrl, op->data.buf.in,
-					     op->data.nbytes);
-		if (err)
-			return err;
-	} else {
-		err = airoha_snand_write_data(as_ctrl, 0x8, op->data.buf.out,
-					      op->data.nbytes);
+	if (op->data.nbytes) {
+		if (op->data.dir == SPI_MEM_DATA_IN)
+			err = airoha_snand_read_data(as_ctrl, op->data.buf.in,
+						     op->data.nbytes,
+						     op->data.buswidth);
+		else
+			err = airoha_snand_write_data(as_ctrl, op->data.buf.out,
+						      op->data.nbytes,
+						      op->data.buswidth);
 		if (err)
 			return err;
 	}
-- 
2.51.0


