Return-Path: <linux-spi+bounces-9553-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05433B2DCA4
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 14:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E293A3BC958
	for <lists+linux-spi@lfdr.de>; Wed, 20 Aug 2025 12:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1016931B102;
	Wed, 20 Aug 2025 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="XrotUB6V"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020095.outbound.protection.outlook.com [52.101.84.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278DE31A043;
	Wed, 20 Aug 2025 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693216; cv=fail; b=Nu7XBeOorDRvl4lyFqqLRiI5Ex2trEZ4D6D/tjflssfF7xjHcK9LeOBQxBgHNpL2udmGEHPLWSCUtNJR/gDsE0Sfhc+yORdQ5G52Fzb3Gokm26tZcraLnOm/NdtRp3RAZKAw85i+i37Q3RPRW6tyjqAHC6KVtw7wLd0Fzhl/r88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693216; c=relaxed/simple;
	bh=pvuHC0j5KpuNTPRSIwTzuJq0wL4Cmht5scP5T+ro5rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m7oFheDPpkQkNnpUCEnWdWdmE9KsPYxhi/SIgrqJLuck2409CXc2gUP+M3fNNI09iMbqnd0yCC7qNBQ99aJg4IhZO7Oe/JFLWmR++aoK6TFlOLSxOoQiMQRULMi93PGkSaOsLEMn0wLa9Nt0G2J53gnXa1A/Yn/Fms/T+YN1vPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=XrotUB6V; arc=fail smtp.client-ip=52.101.84.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c921xMrXMDtQLWY7/1+oT8r0sPC7hhKBsUaTzXbtqgtuHvcQC7fMnt3ITQL+eLv/ax6mH4k9h+fAWXPJzZlBEdUhAkhSFa8VQ5AclBafKqIsmznH/0JZFDy/EC1+OssK2O6DTk2O4HQR8cc9bmuBvzDsFNh35brOoyMiTu2D3GHYtyr4KI+v7Kq7EH2N1qc5AcG5hH4xMaHyfyRTi77WncbX8FMt0Vx9P0zw9f/mj3J43l3XTxJVMNjYlXY3IG8YRPX6tgHOA+ZfK7Ybqg4zACsQnfkqHc54ZfMpgZkvKxhlhd96JJz5wH/vmSlmdegVbtAmpdMDfK95j1l+XKkEEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7LR9hp67UNwyO2xROSKxtkceXfRdbNTlh+jBsVvWUM=;
 b=CCQMee4Bcp9wP9IJwEsSL4ZKecSz0BTY1EmCkWDV8/XnIqPiWBLOyY2BTzQuLEOHSArHOLh+ysuwX4iOkBCo2mKKWI2K0SH0WvXCGUdqccPhM8vXNaZQfCVOmOtESb3qkkYeKlMD83L3VzDyI7FP4jh9uIFOKZfmp3lXUtK9Or1u1dvO2qHDyfd5iVUbe0ZvgH3deF0BCWMMMX5L7XU4DLEqUZ8eQh36dJGeiMflp7lfwlVnxhTxiJJ7pyKFBMRO8wJ2oXVXYuohVFnkRcJ8eMJcXDwlw/walXWQOEdd3ccY1dck2YXuGZkd7C9bemglsEH8MFaIi4onrLV1k6KRZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7LR9hp67UNwyO2xROSKxtkceXfRdbNTlh+jBsVvWUM=;
 b=XrotUB6VovziqZu45lK4/hnMrWpGwx67EYSO/fq1FPVx4Rd5nietlLk8gCXa+RNK7mIP7bjc+JBsmoIqqVCGCkJTQgY3i99fxjNY3Xa0TX5fKhbhNKfGDz89D63HFvyZkmQSJofZRp8llyZ5Z5beTfu4s/YFmop8J1t1i+S56/IFxkuX9W8jlO/eE6cUshSX0SC5O4fY4XSvLoEDs6ehWGl2seUyveEC+04IceUyXN3usbOIzUopnjjNY+I+jpk5UtH6VsmgB1H9+pW/8UPvU3vF7K1rkCjUVmlLHbL90k4xzBiYirGTBi3ZyvDSqz0nJ3Mw+8W7jFmL2dNHbatbfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB7788.eurprd08.prod.outlook.com (2603:10a6:10:3b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 12:33:30 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Wed, 20 Aug 2025
 12:33:30 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v3 07/14] spi: airoha: fix reading/writing of flashes with more than one plane per lun
Date: Wed, 20 Aug 2025 15:33:10 +0300
Message-ID: <20250820123317.728148-8-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820123317.728148-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250820123317.728148-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0151.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::14) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c7871cf-e085-4782-9b6d-08dddfe5c518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pR7oQ1S80wS9BaMPYj6njFOtHUMIY8IFSI3/scTpk5kPgW5hQI/l/p8sUANL?=
 =?us-ascii?Q?4xvqHN3f8rxSJUQ/rAcwpuj/YnUSSX6oH/CDEWAwFx/E2Sb1xMnscxu3afDI?=
 =?us-ascii?Q?H0auNt5PNqe5ZSGMM7csCYtZeFcSQ1DSSzWtxEUc8F3yyzIdjjConLJwz51t?=
 =?us-ascii?Q?mBw869oLF8gXXWqy2l7URdjcuwuwGfjjnm0dUOc8ony41LRs8Jlo9PmLRwJt?=
 =?us-ascii?Q?9sx2aQAa867PsYS3nu4YgGOhv1Eqs9NjWpNvAw4YucFS/28boYuPu9LSVqUO?=
 =?us-ascii?Q?X546PFBMK6pKDKBl/a/e6pw6E6PaM7EU6cBiI5unrXCLZNlk5vy9hIgkWXDj?=
 =?us-ascii?Q?1f2CqYV3c3G3vm4we2ZW5BfD0uGhtX55RnVwc+X8r7Kk7o8FwylW67UHiVSr?=
 =?us-ascii?Q?DZBlAA7g62O2AneGYknJMaIcIX72k6Jxwsvgjz2OVw/SstDOSi8p82O2gVLs?=
 =?us-ascii?Q?9u57a9kEUrUXKYjw66C1435VUyEJGz8lS6Qq/AGXTovsYd8E+MyPJ95rsRiA?=
 =?us-ascii?Q?H9oDiJAva5dCXCmi+LVJUn6/1MOgzvf1E3C1XNwpzmVO8z8mD7guWYcmfv6K?=
 =?us-ascii?Q?Oa6QTsireiD6qaR92tWgtxXZcKOFHyu/EFJNBqkgevN68h/CvubjMe/PvtqN?=
 =?us-ascii?Q?lxGhgnq+zEY7O0572kCzx+I1yeymS++f6kl/KSyElJ+nnwIa3Lp3hEDbi0Vz?=
 =?us-ascii?Q?OL3jAdjfH1uPAjADLown+6Gz+WWKnKb2zUeiss7Jiqq7hqE/q+JnSE+6KJrz?=
 =?us-ascii?Q?dFEMXUej0Dz/URb0/DdHloAX7u4NSqRzqbo9k0AinKTEPYD8+2POJnCqdx/C?=
 =?us-ascii?Q?sbx+xr8FEtw62ykAsvq6anFNlIBGHiqOlxLZcmFKK6i2FNFiojjIWwa/K4Mo?=
 =?us-ascii?Q?3FGHwDgp0/PHcTE7xuRKMlku0hN/DBhiR2c9qdKsd7wNxmCrMhGJMiN+MR87?=
 =?us-ascii?Q?lVGiFAa1izVeeJOENUOm2ITjzLiQ2UQjzyU5FZCPPp09ltf7JrjytN/9jVOb?=
 =?us-ascii?Q?AP5xizoaaF6qpcL5A29Lw34QvLdRh57ORAv5fGHFLDlyNrHqgfvYtsWbA0/1?=
 =?us-ascii?Q?YPsmQdjfS2vt4RXvd153CwhwSYHhihYNgYms3nk5WpbwivQKWL0hZLf3basb?=
 =?us-ascii?Q?YDf+IrttpaXnqWz6LCKCf6WYD0oKs3l/G8tBPhm5tLIZ3nxI4aOjQoZYXl1l?=
 =?us-ascii?Q?eGDxde7+CjAaE6LfA6Cw/yCD8CczDik7OWJTWP/xxPzDykjzS2EfrnXp/LI7?=
 =?us-ascii?Q?1uvzPypbp+Q11SR21MHCG2j3X0oIqIrtHkx8QfdKS/QB9f+aPXs2x0poePks?=
 =?us-ascii?Q?uBLw4ns59A6qQqOy2TCQymd+Im46HwU5ZSRFaGheA5RJEE1OJkJqp2opx6Oq?=
 =?us-ascii?Q?TBMDsKGV1dAb+t7e2HLlIbtArvWAtcSy/X1u9khqjD2oZzNHEMF94b3yQWn2?=
 =?us-ascii?Q?ub+bA9b2DMJE6B5cD5EvrM8E3gof1S/GRBb0y3DnInubs5FvmqYqVg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q9nseVgenXCszMh43/V6CNeLwyC5RAZxB5+zptiaxI/vn2AbZQDwXhEkjlkN?=
 =?us-ascii?Q?T5TlDUTEc5rR8cjd4SGe77n4nfCI57orpYMbKbvjfR30hzJUt0jzY1DdA7Ck?=
 =?us-ascii?Q?lny0WU8unCJBq0O/fXIYSQUFuS0eowRojwbAup4lJOPVLuWZ2FfvDIEUYdg5?=
 =?us-ascii?Q?eWAh0Go7+tKh6vxjasVOscQCcVdsnn7CDRa/qJcqAalPYf5e9mLcaMLnnnez?=
 =?us-ascii?Q?3/vnc2f27YdfrL2XasjyaHG/KLSTQxxVpi9QQfoJG/RMmQL4lT7WjlMy9HqG?=
 =?us-ascii?Q?VvDTD/V0yiuvNvKp6r2TSxruR0d9QjSrUHN54MmU6RuL2X1YJO4b4l3Ao2yI?=
 =?us-ascii?Q?qLURelxPpDTej/gjYPhVYaNLC1/VKlPGKKKY1H0LrxccDxEwb6QZuQylg4jc?=
 =?us-ascii?Q?WeJ9zKeoj9COGymsGihgKYNTGcb4egpL4W09yWSPjgFdfFfPgn4BixUQPWp2?=
 =?us-ascii?Q?QSGBeP+zZ96X1Sgmf+gTFe4/L/vPaFZUdBf9rn5EkTBEa3O23dhOtGL8AjN0?=
 =?us-ascii?Q?OFBrnkef0vDtjSSDdRKqk1kAVdOlO6EAGAS/LPSstMiKddm1QdxzH7+91HpR?=
 =?us-ascii?Q?1it79EpzPK0ftzbWs+j0LJ6dGlbrna98F7qN/mGumgmOTncheHtWBCsKVcwJ?=
 =?us-ascii?Q?pFIV/X/10zjnaX0YLOWfQhwpY0qFoSrSYWhmDmzZLNA2NGW5DGQkvby4hLWl?=
 =?us-ascii?Q?mxxNqeh108NIg8deIMsAeV0guZLH5Cuz4duMe2OcCbQkRlIT95qxRPK52paz?=
 =?us-ascii?Q?4Ye5xF5oaPJNanztC36V21M0HlUg4dSy5Zhk7qQMx1NXb1fy429rlLZNlZej?=
 =?us-ascii?Q?QOtHApdSyv7D243CGBfEJhZdqUPdPZ50VPeeSc3XQJtK+UpXl+WSr4ROx8IV?=
 =?us-ascii?Q?cZHb7SMhXJp05JBmWxDpSE2PRh3thZqYPS53hpf1YtsJ74QD2/pTDqVTAUXj?=
 =?us-ascii?Q?jPIXc6JSR41PmBwxFcs10v9cbWVJfTSSODiRwc5aajH6pZJZMy+FtlEovuty?=
 =?us-ascii?Q?lZmfnbcO8aNsO4f1x9pr6+p/kO2pDbdqhEx/uO6BjptOshiSyKLE7nIKCBdN?=
 =?us-ascii?Q?Hou4L1Sim9znj8VzzA9iE/kYQsWX7rG1UcMzyyNpRI78ocX2btZ9GW4HLxHx?=
 =?us-ascii?Q?3oD9xrXEvUL9y+McOME6I7dwBUoFmijghVTq0IrxIAZvrb9+pa4sxE7jikLz?=
 =?us-ascii?Q?XFM19IAQKnc3UdUjCOs1AC3j+rjBZTYAAVImQHv0jyXjMJm1de09MqmzPgU+?=
 =?us-ascii?Q?gvuoXmiFn2fF1O6GgZ4A121cNCLt/GVDU/gl2hBIVr8kBUNCdnkwtcKDMfGR?=
 =?us-ascii?Q?SanyGmK39WwgHMb2MmeBCU42iA5wD5WaHcY5bkbRP7ZLVx30V/z4YohODyYj?=
 =?us-ascii?Q?QtZS75NFTx3MzApeu1NYY9hERXESZTvUaiRoCRnFlCwfI/dL95mr9g3mXnIr?=
 =?us-ascii?Q?nOSKbLAFEdXnfucHW3OJx/yBCzj9lhfY1IEBhDOoS+7xyM8mcofyjNEWMXCm?=
 =?us-ascii?Q?Dmz9fxpv3HWQC8uOpuXGtUC2fcjv2+Rf/oljHWOzluSTjQfrTjOlNdJNRLpJ?=
 =?us-ascii?Q?ZtV7CMmIG2B6kH/9w60hyH2a06hTs6B0zK1fgpj8TH1hbuv6a/oZAqt9nvOH?=
 =?us-ascii?Q?8/xZp2jH6P1IQT6tq8ns6SM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c7871cf-e085-4782-9b6d-08dddfe5c518
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 12:33:30.5268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXmm4e3LQu+NYy27EY+58Lo7gnS8ZBUZtz3qNfnCDfbr9Mn9WSTLsv61UIVH7l3SmE1PJ++z904M5dzSnNnJrA1SKCIbMbUs28kWS1MQt2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7788

Reading UBI on the flash with more than one plane per lun will lead to
the following error:

ubi0: default fastmap WL pool size: 50
ubi0: attaching mtd2
ubi0 error: ubi_add_to_av: two LEBs with same sequence number 403
eraseblock attaching information dump:
        ec       1
        pnum     538
        lnum     0
        scrub    0
        sqnum    403
Volume identifier header dump:
        magic     55424921
        version   1
        vol_type  1
        copy_flag 0
        compat    0
        vol_id    1
        lnum      0
        data_size 0
        used_ebs  0
        data_pad  0
        sqnum     403
        hdr_crc   c8418a31
Volume identifier header hexdump:
00000000: 55 42 49 21 01 01 00 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  UBI!............................
00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 93 00 00 00 00 00 00 00 00 00 00 00 00 c8 41 8a 31  .............................A.1
ubi0 error: ubi_attach_mtd_dev: failed to attach mtd2, error -22
UBI error: cannot attach mtd2
UBI error: cannot initialize UBI, error -22
UBI init error 22

looking to spi_mem_no_dirmap_read() code we'll see:

	static ssize_t spi_mem_no_dirmap_read(struct spi_mem_dirmap_desc *desc,
					      u64 offs, size_t len, void *buf)
	{
		struct spi_mem_op op = desc->info.op_tmpl;
		int ret;

// --- see here ---
		op.addr.val = desc->info.offset + offs;
//-----------------
		op.data.buf.in = buf;
		op.data.nbytes = len;
		ret = spi_mem_adjust_op_size(desc->mem, &op);
		if (ret)
		return ret;

		ret = spi_mem_exec_op(desc->mem, &op);
		if (ret)
			return ret;

		return op.data.nbytes;
	}

The similar happens for spi_mem_no_dirmap_write(). Thus spi read address should
take in the account the desc->info.offset.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 3f15c26a467d..7e1381c8f44b 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -725,8 +725,9 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	/* set read addr */
-	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_RD_CTL3, 0x0);
+	/* set read addr: zero page offset + descriptor read offset */
+	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_RD_CTL3,
+			   desc->info.offset);
 	if (err)
 		goto error_dma_unmap;
 
@@ -870,7 +871,9 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	if (err)
 		goto error_dma_unmap;
 
-	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_PG_CTL2, 0x0);
+	/* set write addr: zero page offset + descriptor write offset */
+	err = regmap_write(as_ctrl->regmap_nfi, REG_SPI_NFI_PG_CTL2,
+			   desc->info.offset);
 	if (err)
 		goto error_dma_unmap;
 
-- 
2.50.1


