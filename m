Return-Path: <linux-spi+bounces-8870-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6203DAED321
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 06:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20FB73A94E7
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 04:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A0FA59;
	Mon, 30 Jun 2025 04:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="wC/ZAAUV"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3340D11185;
	Mon, 30 Jun 2025 04:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751256098; cv=fail; b=PooxjTPb0mADQ2tOw7oJfS4AnRTJWyfbWB1Okz1BkoSnYKHj0tviWVFDAYgRGKpYiKQk2qHedDe7qae3EQC9ZtXtul5FJtcSPwWlPdmHhtuNFzc3j0TIcw7zuUpdmAeEzNJcEG42vb9L+Gsl4MEMBeONxhR8pziZoS2dMhDMH94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751256098; c=relaxed/simple;
	bh=CTYjcI94S4+0RJoWGNozzjzJ0XTz7Ww3oOhtBqpYXeA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cl3WTjtGaiNUwP++5QiQv8L7xl/MwVOPCS2pnfzm1otbJtAtMmCk4GfMJ+AdVwgXv8lzi6j6g8kOVtwkwJ3wB5GOAnjF3uGv/D8r31mE+w20/D/dmq7/CKZiwltYA4AtPy2A65ODX2/PbasbdNqjnOtMQl6o08DzaYdx8ztue2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=wC/ZAAUV; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnW221QWu3nuvjQtT35qrC+glPtetJllYvA8SNPfUsrWhuKuh+2Q+5IYtaU4gUwEsjg+l8RaygdnfXXdRu6U7XE5FGhndIdVkbRMG/OfsnlxIKlNjuBEBm+3/kvdWAO9pdIoNC4WLprA3eBcaZg3XkYmGzNCsLcnzdqtV2Z4ROmHBvPXj33lQkTylxJ4flEGmzrQCHPKaYbuEqCyt9ECAiDA/JsrJcXkvXlxze0JnFn4WGE64v7XfgYZco5ICXjPbjP2yRhP0gYVRUMQ/1AOTmIaTCFI0fqeaJy8uc9GMs2xlkjfQAQHAwwZwKIZcxfzaTunnIpaAtd8CObyu0Lwzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVvQ7pwAfuLqLjItV5UL9wEI3Dtdlh2AfwSQt23CL1Q=;
 b=QoT6mSYdxH31pVkM6sUfhj+Vsyrs5EnpdPr/Zc6q/HIh4pn9sfSRIjT0mVXmp9vqz9OomkrsK5+aSBAl3yLeyTyoSpNwHVVM8nML5UWqeDxxgjv/u6f9/LS5DOeREmz+8FxDwM455vXMHydYitcaJgxJIxLUD7Ba4768KVzWTz6BAFGvb6KGX9OGamZYsPMFc4bZWAbKAxekvQovkANYy97d3jKw/KYKgF6K5bYq1UCDbyli3glmSwHAt0tEBgFUMNpqzhD9FIk8fONV/kfUWuKt2YzpjFuON/qYftw5Azb7m3Gov8LmYLLAwWqzaaqTYTRJdp5/yH5gf1cD4J7rCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVvQ7pwAfuLqLjItV5UL9wEI3Dtdlh2AfwSQt23CL1Q=;
 b=wC/ZAAUVQign05xl67D4KNXMhSUDkP3ORtOeCmswSfNvs3TnVkAWJeGZo1WKqXO/r4jlv83a6/wyJ8tGnQIaE+jkf3i6hwmp6ORCWRq9aDueMrnUO+r6opBRGESLBrC+3VdvYRT2zVq8JHd4bqWltwyHPFUAFQ1mard1zAbjIRoj1jIb9Rv9XozAAwn9G3Bf+/GhNXZJg/QfzO5qXCMEfbLlzMztGNiyJb9FeZ+VmE2cXGbCG5OkbACgarOH/MU5mHxZ6q+lTpVJB6KVojsI5/5ORLO7vyePOpW6q8puVqac8fTgW/tFXVjxnHUwvyXncNTI/eCc3o/AztqqR9u35Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM6PR03MB5017.namprd03.prod.outlook.com (2603:10b6:5:1ee::21)
 by DM6PR03MB5274.namprd03.prod.outlook.com (2603:10b6:5:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Mon, 30 Jun
 2025 04:01:34 +0000
Received: from DM6PR03MB5017.namprd03.prod.outlook.com
 ([fe80::2898:accd:c6dc:2168]) by DM6PR03MB5017.namprd03.prod.outlook.com
 ([fe80::2898:accd:c6dc:2168%6]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 04:01:34 +0000
From: khairul.anuar.romli@altera.com
To: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list),
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v2 1/1] spi: spi-cadence-quadspi: Implement refcount to handle unbind during busy
Date: Mon, 30 Jun 2025 12:01:30 +0800
Message-Id: <dea0cf48c455378163c122266e99b6e844bac436.1751255054.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1751255054.git.khairul.anuar.romli@altera.com>
References: <cover.1751255054.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0191.namprd05.prod.outlook.com
 (2603:10b6:a03:330::16) To DM6PR03MB5017.namprd03.prod.outlook.com
 (2603:10b6:5:1ee::21)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR03MB5017:EE_|DM6PR03MB5274:EE_
X-MS-Office365-Filtering-Correlation-Id: ddc16fbf-09f9-4d1b-0529-08ddb78acd90
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X0cy6qgMo0/y+m+OVL+l0fqfvrF4DU/lACoPt3l7Znsy9V/4OHyMErBBO5N6?=
 =?us-ascii?Q?BlCjUEQOHVZLBiUkGKj4L2fss9O/2NzxpIAzgrsQP5bmMk1Hy27pLNQh87Nf?=
 =?us-ascii?Q?lWKcCdw5lhMMFhyZHcdJP5sHBkYZW/itSdx2Dl38wFYi6pQvvDLIooN7BXc9?=
 =?us-ascii?Q?ZAmRtOZ4KcfBqci6oR03PB9mxxQ23MYGG/5oMDlJB1tHgUTaSdqTEKTTI/6j?=
 =?us-ascii?Q?I3eRn+8c2BfVBgqevEEf8FW8gbKBQH3rR5bKt0TlH556Anh1iRtH6Rled5PB?=
 =?us-ascii?Q?GdArOF2aILd/J3HYy4eW0gGz6C8I6b9weo2tvkhZz5ipcHnXkJ9CYYyq7xqz?=
 =?us-ascii?Q?b/oCHMB3lXOMKApY/7agrYtv2aaRyo1jsOiOaJYNQTy1EVFXTD/UOWcVBScH?=
 =?us-ascii?Q?BFZ5C8d5IdIsarVDrFfzwCxPGmJTSdKv2kYGSR2xtGTQWCuBOKfeHC/4XRa/?=
 =?us-ascii?Q?zl/+yKrr2Vk4nCdhC0MAX1qKw5PJ0/J5kteXVvOX6+/8TGgmeCZokoYXIr/B?=
 =?us-ascii?Q?MlW1udeDDZWur8nyDdkFjUhAEgH4tJOlZbDxGY4PsNCZJDtu4i/9xM25bIA4?=
 =?us-ascii?Q?iI3QS62fW+QkACeDhQgK8R01QqbMbQgMKY+sWvL1obwkgmOK95dH2QgMyj8X?=
 =?us-ascii?Q?ChfXUzc7KS4wExJ4lBUDqRZEQvHhk+fTK9ACK1SzewnhxZ3Kjvv8+ae19SZy?=
 =?us-ascii?Q?Lii62XNA6BdoaRLvoBsGhnGlizNOCjl9LoEdSeg4X0R8kHYxAf5hsy2Kztr8?=
 =?us-ascii?Q?FI+JSrRY9WjU9vzvqIVN6R5IWAzfrRkZnT0X+kg+CDqb8OU3HYeb5B2A+I8L?=
 =?us-ascii?Q?EhAyJAZItCR5J7xuTad14CsLlStc445IJismcG79vYZD36XpoaCbpZ2mt6np?=
 =?us-ascii?Q?IoFPEG8A0PnMOEPoVvd7LLHobQ8ZMF1egVVCuxb5L1CnXNXRmWh9jo/odRaj?=
 =?us-ascii?Q?7yUp26oyswjcm5/m4Zs0RiR3PrtVtFAsoys2RTLRCcrMtyJRrKyJ/RoGSPGO?=
 =?us-ascii?Q?z8Aq6j3nUg0Vvphxyowmf9mzwWSENnfMLJykhg/9pm0s8+6wTmidi8fo7dQk?=
 =?us-ascii?Q?iXYF++tMvWqsIpJHEzKjifh1yGrA7k0DVyg6lj+IbRaZgklK2OgKZoVB5lNG?=
 =?us-ascii?Q?zVE6idUG6yNZ3v/g8lOL9tHXrlNkJTcBxLqeIvoyhB2GC71hi9SKMV5lTl9y?=
 =?us-ascii?Q?oSzWyjEqF/v2nROX6u9K0RBaoUYLey94bdwPTWL5wWp6T+djxFgLXm06g3dk?=
 =?us-ascii?Q?pX47/YjcaAsonsuLEY6OdI0m9dSgjC+NuKas+J9ELmKbPVFKIwOngolrRMCQ?=
 =?us-ascii?Q?eIW67j6gWjgcO5iWXm4+UZrMpEkF4z9OTOqSSjU3Hkj1qWiUjIrsVDIbr2i5?=
 =?us-ascii?Q?b2Htc1VmqgSNXndh9dMg16P7QowS7+3BBRTz/ilX7TWTsXrAyQDC28Xba/vH?=
 =?us-ascii?Q?I5AaGzQev2s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5017.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BhZzl7ajESwvh0ybgfjg79uz2C4SXNmN4hoX9E51gpfduKehPJ0eYiXH+Pn/?=
 =?us-ascii?Q?Hi2MtktDMmQ5cWwiT2zg8T0TiJnLD49YKY1Kz/0jj1Yr8UKgY6+eBKuQGbVM?=
 =?us-ascii?Q?P//zNCgCLOZtLGEhciz4S3iWZ5e+8/7rcmCczKKg0JBGtVPAYW78SL1sbFoJ?=
 =?us-ascii?Q?TSG7Er+0xIFuG4ADni529XL4Wr8yoezNJE3zi94RE5V0RVyqAn3XRFL6IMyT?=
 =?us-ascii?Q?/ux0JkDoxZQhuW4Uv6VPx+/lOz2mwNbU2UIqN9yXTchwu50PL4lslCBuoNj2?=
 =?us-ascii?Q?jm3wPH12N4o43KC+ggy1ml2HgJ8G0FgNLmJpVsa3YvnhIU6XIK7cA+6aRX5W?=
 =?us-ascii?Q?0qxTYvJPNItmiGkr/GbYpUJndBb07xcmiF3pf6+EFCWfV2FVGsnf9EcJwlAr?=
 =?us-ascii?Q?qIadX4ZSLLcrd3DKlAWisgWeWFo/cGs1ecXu7CSvN/8rg4XcqN1QzExjvRjE?=
 =?us-ascii?Q?qhADqZYQanF6vd4wpaPnzy1uUp5sG4A6+BpdkqD1yxRbdjTYT5KiK9bxxFDN?=
 =?us-ascii?Q?R2LWZxdxKkh0KdKyWm8DzBegZhV0xP+CcjWCVvR+4BR2CkqSp6g1sNzTrr5S?=
 =?us-ascii?Q?zzN8/uPwqgXZx5zu8ZeYMKSh0gp8TqA+08o6yGWh9/Tb1Y8yk3hyvOQ+YnB4?=
 =?us-ascii?Q?1hNUcDKuy+oGKhdy6sjBh20sHBeeb4SyQeAGPNXNyYRdaoIhgMoA3l2Nz0f2?=
 =?us-ascii?Q?Eebo6qrMLjBn+p89ovRyC9gx77dlBDRY9hk4YrzPpmhr+tV5Aqnr87iWxicD?=
 =?us-ascii?Q?kXSOB6CQbqiVv16y7Kav83pxmdKCNhGRAtnTgfuOaz3zSJBMyVG/XDPOdIVe?=
 =?us-ascii?Q?NdDkb/uAg9GnCeaBPPfD2ySejURe+T1d5CttMxI3yWEcnO2W7KsCxp85EVns?=
 =?us-ascii?Q?Hlbpbv5yRz845YuxWNMi909PaDr/OQCfDjRGiJiVXQ74u6kQD4nm8nwoj2ji?=
 =?us-ascii?Q?Tz2yfGAU7L+z9fq/2PBOhxWtt7PVkpgn7wF9ABflHU6Fgew8GXxgW8yIYKUf?=
 =?us-ascii?Q?/hyNYbceKcwI6TQL1zQb/hidEUi6UMwbTLFfbNeHuLTxP4l378m9ji7xfY4N?=
 =?us-ascii?Q?JBoe/0OvttRtYpX4P3iQjHGOzU75/YvKxOVE3q+m8N0CftBtFB+QfwhoVBM3?=
 =?us-ascii?Q?iBJpEzarXOUiYej0tZbozHjiz0BBQUyJ08+ryjxATVMAdfUxfP+WrWIa3kF/?=
 =?us-ascii?Q?Sg5ZMHLEewiepYAZoOut59W6KZimmuEprSKVXuqI28p2fPA/RZPsRWzjJh7C?=
 =?us-ascii?Q?AzjKoYlI3SMdvs83VCFhNnNb5ZtYOQ9YqqKlBFx7bCNni4Lk+Nsl4l72k9xY?=
 =?us-ascii?Q?41xHI9bnxm4ebqoNv28LT7iOaHsJ+2eMTwq99u0ETfTGUN+8RcJbOoEexkeh?=
 =?us-ascii?Q?1aKgBJp2JKlkpPKW7582/y2GLBP9JHROdUz2tx+H/7X1IjxVnwPPq9b/8Fnz?=
 =?us-ascii?Q?3smRhFXRQY5FTzMo7AAyZAD0k2kOjtBw7S11b0R1+mcXrfYSKCg38TcsxiCw?=
 =?us-ascii?Q?w76048aUQ6onDOkk8xMNHWgxcqgQYvWYF3D5MtE7DmbXmhz/Xur1gHGzbxN6?=
 =?us-ascii?Q?ssH24exkCuNcR52zpX1wAkhlOVFn4YSl3HFoFTDCAR0Bf/Zv96WYeSDhULzz?=
 =?us-ascii?Q?Mg=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc16fbf-09f9-4d1b-0529-08ddb78acd90
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5017.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 04:01:34.3247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A5xE2Qk3MOc67dMXKEF1qSnbScmgSa4B4XHmDk82RdNNVeiBW67E5qtDF/L8EltcnBp8GW6mXvQ6MR7RKLtmuRvXTBTnNZc3eFuBNYiVDdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5274

From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>

Driver supports indirect read and write operations assuming no forced
device removal(unbind) operation. However, device removal(unbind) can
be forced by root user.

Driver removal(unbind) during an indirect read or write operation
causes a kernel crash. Ensure removal(unbind) is gracefully handled by
implementing a refcount and waiting until the attached devices remove
operations have completed before proceeding with removal operation.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
changes in v2:
	- refactor patch to align with latest mainline kernel.

 drivers/spi/spi-cadence-quadspi.c | 33 +++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index aa1932ba17cb..aeccb33e621d 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -108,6 +108,8 @@ struct cqspi_st {
 
 	bool			is_jh7110; /* Flag for StarFive JH7110 SoC */
 	bool			disable_stig_mode;
+	refcount_t		refcount;
+	refcount_t		inflight_ops;
 
 	const struct cqspi_driver_platdata *ddata;
 };
@@ -735,6 +737,9 @@ static int cqspi_indirect_read_execute(struct cqspi_flash_pdata *f_pdata,
 	u8 *rxbuf_end = rxbuf + n_rx;
 	int ret = 0;
 
+	if (!refcount_read(&cqspi->refcount))
+		return -ENODEV;
+
 	writel(from_addr, reg_base + CQSPI_REG_INDIRECTRDSTARTADDR);
 	writel(remaining, reg_base + CQSPI_REG_INDIRECTRDBYTES);
 
@@ -1071,6 +1076,9 @@ static int cqspi_indirect_write_execute(struct cqspi_flash_pdata *f_pdata,
 	unsigned int write_bytes;
 	int ret;
 
+	if (!refcount_read(&cqspi->refcount))
+		return -ENODEV;
+
 	writel(to_addr, reg_base + CQSPI_REG_INDIRECTWRSTARTADDR);
 	writel(remaining, reg_base + CQSPI_REG_INDIRECTWRBYTES);
 
@@ -1461,12 +1469,26 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	struct cqspi_st *cqspi = spi_controller_get_devdata(mem->spi->controller);
 	struct device *dev = &cqspi->pdev->dev;
 
+	if (refcount_read(&cqspi->inflight_ops) == 0)
+		return -ENODEV;
+
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret) {
 		dev_err(&mem->spi->dev, "resume failed with %d\n", ret);
 		return ret;
 	}
 
+	if (!refcount_read(&cqspi->refcount))
+		return -EBUSY;
+
+	refcount_inc(&cqspi->inflight_ops);
+
+	if (!refcount_read(&cqspi->refcount)) {
+		if (refcount_read(&cqspi->inflight_ops))
+			refcount_dec(&cqspi->inflight_ops);
+		return -EBUSY;
+	}
+
 	ret = cqspi_mem_process(mem, op);
 
 	pm_runtime_mark_last_busy(dev);
@@ -1475,6 +1497,9 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (ret)
 		dev_err(&mem->spi->dev, "operation failed with %d\n", ret);
 
+	if (refcount_read(&cqspi->inflight_ops) > 1)
+		refcount_dec(&cqspi->inflight_ops);
+
 	return ret;
 }
 
@@ -1926,6 +1951,9 @@ static int cqspi_probe(struct platform_device *pdev)
 		}
 	}
 
+	refcount_set(&cqspi->refcount, 1);
+	refcount_set(&cqspi->inflight_ops, 1);
+
 	ret = devm_request_irq(dev, irq, cqspi_irq_handler, 0,
 			       pdev->name, cqspi);
 	if (ret) {
@@ -1994,6 +2022,11 @@ static void cqspi_remove(struct platform_device *pdev)
 {
 	struct cqspi_st *cqspi = platform_get_drvdata(pdev);
 
+	refcount_set(&cqspi->refcount, 0);
+
+	if (!refcount_dec_and_test(&cqspi->inflight_ops))
+		cqspi_wait_idle(cqspi);
+
 	spi_unregister_controller(cqspi->host);
 	cqspi_controller_enable(cqspi, 0);
 
-- 
2.35.3


