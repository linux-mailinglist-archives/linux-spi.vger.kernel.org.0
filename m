Return-Path: <linux-spi+bounces-9618-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0B8B325A7
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 02:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68CAC1BA8A3A
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 00:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0B917AE1D;
	Sat, 23 Aug 2025 00:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="EXoul+2z"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023102.outbound.protection.outlook.com [52.101.72.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1762E139D1B;
	Sat, 23 Aug 2025 00:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755908209; cv=fail; b=lXarpbDdp6YgcKOQIMW9lGG4G4htqDtEncefpB/y+/BOxtq82BKlOIu72ERYNdUiAhEJyh6fKPrvG+wNJt/+HE6gr8U1jNySrsOBXwzQNZs90kA++5lWHZ8Yt0opTlT2XWwQJw+eBdJrKsy/gMRdE/3ngw81cLiL8mOB1HGYZvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755908209; c=relaxed/simple;
	bh=aO3GnJu6lejs3yxXIrTQ0ddPhApAONuTDt/BTjr6tIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OIE5CKSoe7JLEsTqjQgqJWRcVjXrrdIjYfyWM600JmyFj1m+YnsJIhek3jThcD34AiBAikrwokD8yDQCvLMn/I2HQ3XPnpZqZUW7FgbqNwWguWwmS4S17iuB90Jmcs5T3CYGNqfJ0TyIDtTEyFR4k1lBUR1I8Imzws5AzCv1fyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=EXoul+2z; arc=fail smtp.client-ip=52.101.72.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnjXwSOtB3Kzm+KSza4O4kJDiYup090+1/fN1GBFnq1qfpVc1pBoE/3uVF5vWiM/NtRWAiSGg4bKyK2j9o2u8mLmzlf6Z0ujhXb1XIvvH3yG0hMwDpl8q4F4Z418oRAk3Rxh6u/TJhGjdC6X6FhktLlu08WgIouuKwpOumnx1vquxvynCBe733VJUS0wvbuuYYt0nuQJcLmQa6/qw3DV73KkxqMeedN4abf1P1QWgjpsDN3pwq5cNeb1eU6+jdwsowWXXf+yKlaqWIg94tfmETzB/nU+y/UQbEdG6tu6yA6KzmY5ezUYPOPXysgIUaKk5cnGaoOASKctF8z2X7GHRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgK6t6s2St14sOjI6n8WumMRK/Rf1vD3Ixtt9ciSuic=;
 b=lJWfSyr0/v5qr37Ba5VmtmMXQvGp66xSpmUMxaQcWHGBvZ7L+jtaF3FUxa3n3WyF55yLkP9No9v2BJVSUztJkydZnQEe6NY4w5MHQpgHjVs3jjELB3tfgvALHdjHthZUT0eQ2xruB3VdRpS9X/BiArb1rvdgf6LqjiDDW7Hs7S/Dt/9GDHFJ/yNEiHvEd2dEhfuhXaNXn8lAJI9PalPQLn5Auw1NpBMRRbeMwPnJeLnCCu2u0LyqjaoSvPnJUTYlB+8xl/KxYt6EEgcw+ATYCW+4JKkvFlW6pz2swIr2OtC+JmsGGzpRUK2vgytFadSjq4AoEu4XNLSsxQszptPJ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgK6t6s2St14sOjI6n8WumMRK/Rf1vD3Ixtt9ciSuic=;
 b=EXoul+2z9yXyWaA6Ghu2UOfzzJ28B+xLIHEcRfYil3cF7syOoPHhrNqlpDhdEVlhzolvEFB32nctM3k5TPm2JB5AD0W+lO8iAL/LIH920nwz9PrWLkd+339a5Hykwya5x3rb8De8tGyxORYpJEviVcymg8pSz4DVcNyTOOLQUsrWS8La8OuRNwFLCzmTEJkvnjQdGLMO/i36lPb5k4UqLgsBDboHBWC8OOo1hQczLkI/TW0w3Tbam190XI9uJNiQVei0+JSzFP+Ke8PP2e3TU/O0kCs2bSchKYnqyoT2D92TTsRreDZ2kNLu/NGK7q+FIdu38VDFef4cCNYSQJ3pAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AM8PR08MB5618.eurprd08.prod.outlook.com (2603:10a6:20b:1d7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Sat, 23 Aug
 2025 00:16:34 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Sat, 23 Aug 2025
 00:16:34 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v4 00/13] spi: airoha: driver fixes & improvements
Date: Sat, 23 Aug 2025 03:16:12 +0300
Message-ID: <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <aKgSY7bOrC8-qZE3@lore-rh-laptop>
References: <aKgSY7bOrC8-qZE3@lore-rh-laptop>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::8) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AM8PR08MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: dabe797a-e0a2-4598-3734-08dde1da5137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qn9Siu+xdl9C3BJUeX19ohqDRW3Rdw+D1GsiQ0sQLiZFAsX2ignITPOU0Xky?=
 =?us-ascii?Q?/TaU/Y7fHWd99Wi/+GytfZOi9PAODrKl+X8IXjblp12kd36bR03nNtq1kh04?=
 =?us-ascii?Q?DkBm61szWqHixsRIBQJUGLXTS17YvezxhhKRQIArYb/GWAyh/HHKpN0NJtjQ?=
 =?us-ascii?Q?i779XzZNRYxvqv5loE8rdZBOY7vDzPi4OusFbw3BhUtds/d9NSC4JOMVtypv?=
 =?us-ascii?Q?MtWSPXkRi1ToMHKTiYLnxRMtbTEHwBhVFLZObnubZ9TON0Y0z0VzMjlv02DS?=
 =?us-ascii?Q?I7PE5Vf/+856t5rqksayiXjSf8AxbfPnp/bP52drE5WvCYadRhNyGOXwBN+0?=
 =?us-ascii?Q?rRZhg/UN3EFr4H04nRePa73rLbPAAeZZ2+LgIR8pV1gR/fS3SynpQW9oVFV1?=
 =?us-ascii?Q?sFVV96ic/atjmS/6Vc5n8ASogN2e3eZnW6UwJPviZRdnvHWzraZYZj6LSmMJ?=
 =?us-ascii?Q?R2xepNb/fpzlLfbwL9bEws8LH2mu2AQs742ND6ps6LbS8SBY2l+JbB6CYq5e?=
 =?us-ascii?Q?OLBW4AJs5AfgTTnjkTKkPyxgo2LzwzapDrwo5fKSS3F8HNQv0YNT9WWnVWfA?=
 =?us-ascii?Q?HgGYyUICA/wEZxuHFt0hs2+NQW0VVrYS/wVZkcEWA1xGa2CuDCDQoYrKqj/j?=
 =?us-ascii?Q?zaJlzFdqqPwBfmcPzN+r2ugPN1LL+eAXdmjJbZ5n3PfEctHjRbZDI7hijTZJ?=
 =?us-ascii?Q?iXQsAuDUYP5KSqy4SBf7SYSt+RxkDCGwQIHjCsnKxaQ8nTtOFfvVyVBoXSod?=
 =?us-ascii?Q?sw95Ob/VQlJ7V/bpTfPVwSjOtiIVFnJdtzfFdzxTGLx22iMoMUWwanmeg593?=
 =?us-ascii?Q?fLsB88pdks/KYDTLdc+8Ew9siX7yEsM5cZS7vftCuijhoTNVN0rKJT6hO0e4?=
 =?us-ascii?Q?9hOe1nHmEk3BVe0LEO0v8ucJxcVPg2m635LDzxNpw84Vg7INBO7JpipZinSp?=
 =?us-ascii?Q?+cXk1sM2GlRE9WtVBJdCL9n82x9J9EOrmkgvOo0J+tXBifbxg9HYt26UHsAK?=
 =?us-ascii?Q?IFj6lnIE/ksbnE53349lIwttPneVqSmJ+Fgd56ZaZAY/V/QAHVEnOiITnDDO?=
 =?us-ascii?Q?mImWSumr4dQmq7gqd5LrQFbVxnv/uwUmhCssDp4BRO0ZGv8L6l31veNnvwl6?=
 =?us-ascii?Q?8rjF0CKMmw6nl3SyLqlxuLYBIMRuH7t4FjciWsBwG0Qiijeq/SlsjOd8lRXa?=
 =?us-ascii?Q?+iNT+MdCwqM/PLegxVKdUZw/0K5g2wHIjAiZbgnRlxQ4RjcVIYfgtzAy1Lpt?=
 =?us-ascii?Q?7c4c8KnPov9jdjmo/AehRZIReDYCtA2ijZU6gohDBoBqZCBFS2mxHZ6z2d17?=
 =?us-ascii?Q?3q8tBZVFHrYpSYH2osGsvpqVVN0i7Fk/lXa49FyAZVThNtPgQxD+W2RxHPYc?=
 =?us-ascii?Q?gsdoAXW3PlmSoApZFvGne85G/8phDrn0ZU/iRoASyR0GV7TsBIVPxWtD631z?=
 =?us-ascii?Q?FeWrikcVCak27EzyQnX2aWnpNib6nquW3r7PT+35y1zNNtuWyWwpBA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qWJKSZS7cddxx5SgheFThcUfpsziExdl9vO0zqdubQVd0eZKZVGYstHTnA/H?=
 =?us-ascii?Q?jQky6hgms58mFKl9+amV67D0f5y1DosyogSThid9MKPmEebM3rCBg7/km6H+?=
 =?us-ascii?Q?6feZAEKvavHLVT8QkRY8vGf59iQsZuDkRKra6ioc9uF2+q9lqyInuR1Vispg?=
 =?us-ascii?Q?SFQE7DLp6rbuWhHDgP5QebcW1mqCHekoPEEZLJ0HO/hpbCSbBFuY7yi+2yJx?=
 =?us-ascii?Q?GW9DAUqXkab93hbiXUSZfp+GgpzZZ3l7qYlwojA/ME7dzTEvwIu21RyfEfua?=
 =?us-ascii?Q?sjTrcZKWjunAOBRxKoH7H0b7lHHHq3cJ6n0t+TjrUVBPnr8rEZEE/HPtSmbW?=
 =?us-ascii?Q?xc9j60DYlI03PZt0AxB2bKJdZqxcu+6+DNJBtcEDXWzhnki8kXeoiQlsLHq9?=
 =?us-ascii?Q?3SWGvwWKWdXgE1JBYRS5M1xEGpqmf+I4rmv/snxKVeyr4W0krXLvx9thmG1L?=
 =?us-ascii?Q?TtCv+2Zb31YFU/sq60Ep77ccvFTGqbQTDWrK1F5ewSn40bLl2qtdJrozWccB?=
 =?us-ascii?Q?WylwJmceCL4XdfCiMwvp2ac0sHbmN4QStPoleSaPgeUq9tY+tzYM0DVX0LEw?=
 =?us-ascii?Q?fRLrzHDku3MtehVmzczoToWPEBA1JxPwk8YFHqZETujoOOqzAe+poNirg2aV?=
 =?us-ascii?Q?7JzTrmRoXa56jBaN4uWU+AupZ39aBdteQZBgeBOU74mzcglEHr1nDFYsFm3r?=
 =?us-ascii?Q?ij2DXoOwwX0oQgAKa8qNEAAvKbuJgyP9BpI/62ft9F6k6e5QKGsRV64eehEf?=
 =?us-ascii?Q?M2zAqkfEsje2xHs/YgMOwcI6Gg8F7cY9YG8ltE7uvm3wfSW/MM9F0yo+4k5V?=
 =?us-ascii?Q?Be5D0ci6SffE6oDoLPhd1C0j6Y2ZEHtziRsCrh+JrfZD5ToO8uvYKo1TgPXV?=
 =?us-ascii?Q?sXrxuL7HLjAlQj3689VcDZbE+0D1iLVr9FE8HSXHhaw//kwpZDvoyZeQj0ZQ?=
 =?us-ascii?Q?nqVniI7tne61RZQdgeBjpUKb4EMiKgwrR0+S9QTVgTdUU9u1g9sgc2H8Sqsp?=
 =?us-ascii?Q?D6ZikzLoYbhZoH2yQ72sY33iQxU3g9HkUGqiOoQhOEL5SKwitgPt3enuGHJ0?=
 =?us-ascii?Q?5Td1nKqvEykWE6llMGC20l/WVhFntDVTxUPJatgffzMK/oWJaYnQNnjX50fg?=
 =?us-ascii?Q?ky1fA8jIVJ3wQmJZtyVtIjfwBZFn+WXeSdMWABCKDFv71P9vlxIsWnPmw1tx?=
 =?us-ascii?Q?TaKZ15/ADxk7AttZNFazTa5tS6c7RLRNRBoQDVNmRzNgD8/3hzyu8mBL42NK?=
 =?us-ascii?Q?ynibX6CRQutOp3NutPntLu6rO2U38e7AO7MptsJ7TJe13XMORBvA9sB05Y5o?=
 =?us-ascii?Q?DEpvJXzPmN6WlP5KRim8eFcEM2UZdC9I8HTd+gauVKL+vqGLKps8XhLM4XSn?=
 =?us-ascii?Q?fPrjaqt/gQwh/8/L9FdhN2Sd6BgslzJK7hVUTnixYJate5kboU+X4wQjJbmQ?=
 =?us-ascii?Q?pungySIscfw8KmzFPZHA643/SoHL1eY/BSPH6Lyb0f6fzEHQIiA6tplubrJM?=
 =?us-ascii?Q?5cKBfhVkoqfXfKmwey+3DO+G97wl3ttW1x2DKeiXMdSNaXhVCn8BHN3Of2Yn?=
 =?us-ascii?Q?xE2rkiJj8DxVCDgvus9KM07C+YEQbQI4V3VlwIo0SpU2OSkaYIRwR+T7wZkc?=
 =?us-ascii?Q?jfeF/sRXJorRx11KLUhvRfM=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: dabe797a-e0a2-4598-3734-08dde1da5137
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 00:16:34.1058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ak7T8blgnfhobtDg2KnO1YeH1GNixVLeR+S5hu7YG8W32j4qMgOjeWsZKue14rhnt+NA1otc0CX/yLvbY7akUPJVqVxXFmP/OZ7xNQHWNtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5618

This patch series greatly improve airoha snfi driver and fix a
number of serious bug.

Fixed bugs:
 * Fix reading/writing of flashes with more than one plane per lun
 * Fill the buffer with 0xff before writing
 * Fix reading of flashes supporting continuous reading mode
 * Fix error paths

Improvements:
 * Add support of dual/quad wires spi modes in exec_op(). This also
   fix flash reading/writing if dirmap can't be created.
 * Support of dualio/quadio flash reading commands
 * Remove dirty hack that reads flash page settings from SNFI registers
   during driver startup

Test results:

1) Boot without dual/quad wires spi modes support (patch-3) and disabled dirmap support

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

2) Boot without fixes for flashes with more than one plane per lun (patch-7)

    [    2.980989] spi-nand spi0.0: Micron SPI NAND was found.
    [    2.986309] spi-nand spi0.0: 256 MiB, block size: 128 KiB, page size: 2048, OOB size: 128
    [    2.994978] 2 fixed-partitions partitions found on MTD device spi0.0
    [    3.001350] Creating 2 MTD partitions on "spi0.0":
    [    3.006159] 0x000000000000-0x000000020000 : "bl2"
    [    3.011663] 0x000000020000-0x000010000000 : "ubi"
    ...
    [    6.391748] ubi0: attaching mtd1
    [    6.412545] ubi0 error: ubi_attach: PEB 0 contains corrupted VID header, and the data does not contain all 0xFF
    [    6.422677] ubi0 error: ubi_attach: this may be a non-UBI PEB or a severe VID header corruption which requires manual inspection
    [    6.434249] Volume identifier header dump:
    [    6.438349]     magic     55424923
    [    6.441482]     version   1
    [    6.444007]     vol_type  0
    [    6.446539]     copy_flag 0
    [    6.449068]     compat    0
    [    6.451594]     vol_id    0
    [    6.454120]     lnum      1
    [    6.456651]     data_size 4096
    [    6.459442]     used_ebs  1061644134
    [    6.462748]     data_pad  0
    [    6.465274]     sqnum     0
    [    6.467805]     hdr_crc   61169820
    [    6.470943] Volume identifier header hexdump:
    [    6.475308] hexdump of PEB 0 offset 4096, length 126976
    [    6.507391] ubi0 warning: ubi_attach: valid VID header but corrupted EC header at PEB 4
    [    6.515415] ubi0 error: ubi_compare_lebs: unsupported on-flash UBI format
    [    6.522222] ubi0 error: ubi_attach_mtd_dev: failed to attach mtd1, error -22
    [    6.529294] UBI error: cannot attach mtd1
    [    6.533450] clk: Disabling unused clocks
    [    6.537583] Waiting for root device /dev/ubiblock0_5...

3) patched kernel tests

    root@OpenWrt:/lib/modules/6.6.79# insmod mtd_oobtest.ko dev=1
    [  263.191711] 
    [  263.193218] =================================================
    [  263.199014] mtd_oobtest: MTD device: 1
    [  263.202768] mtd_oobtest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
    [  263.216791] mtd_test: scanning for bad eraseblocks
    [  263.221956] mtd_test: scanned 2047 eraseblocks, 0 are bad
    [  263.227361] mtd_oobtest: test 1 of 5
    [  265.077216] mtd_oobtest: writing OOBs of whole device
    [  265.121767] mtd_oobtest: written up to eraseblock 0
    [  275.174147] mtd_oobtest: written up to eraseblock 256
    [  285.210279] mtd_oobtest: written up to eraseblock 512
    [  295.241724] mtd_oobtest: written up to eraseblock 768
    [  305.280167] mtd_oobtest: written up to eraseblock 1024
    [  315.326883] mtd_oobtest: written up to eraseblock 1280
    [  325.364049] mtd_oobtest: written up to eraseblock 1536
    [  335.398609] mtd_oobtest: written up to eraseblock 1792
    [  345.358981] mtd_oobtest: written 2047 eraseblocks
    [  345.363694] mtd_oobtest: verifying all eraseblocks
    [  345.386088] mtd_oobtest: verified up to eraseblock 0
    [  349.830833] mtd_oobtest: verified up to eraseblock 256
    [  354.276245] mtd_oobtest: verified up to eraseblock 512
    [  358.721496] mtd_oobtest: verified up to eraseblock 768
    [  363.166881] mtd_oobtest: verified up to eraseblock 1024
    [  367.612694] mtd_oobtest: verified up to eraseblock 1280
    [  372.058211] mtd_oobtest: verified up to eraseblock 1536
    [  376.503820] mtd_oobtest: verified up to eraseblock 1792
    [  380.914843] mtd_oobtest: verified 2047 eraseblocks
    [  380.919660] mtd_oobtest: test 2 of 5
    [  384.202620] mtd_oobtest: writing OOBs of whole device
    [  384.247584] mtd_oobtest: written up to eraseblock 0
    [  394.305121] mtd_oobtest: written up to eraseblock 256
    [  404.342199] mtd_oobtest: written up to eraseblock 512
    [  414.374204] mtd_oobtest: written up to eraseblock 768
    [  424.409891] mtd_oobtest: written up to eraseblock 1024
    [  434.453378] mtd_oobtest: written up to eraseblock 1280
    [  444.494321] mtd_oobtest: written up to eraseblock 1536
    [  454.534480] mtd_oobtest: written up to eraseblock 1792
    [  464.490962] mtd_oobtest: written 2047 eraseblocks
    [  464.495681] mtd_oobtest: verifying all eraseblocks
    [  464.518015] mtd_oobtest: verified up to eraseblock 0
    [  468.955635] mtd_oobtest: verified up to eraseblock 256
    [  473.395502] mtd_oobtest: verified up to eraseblock 512
    [  477.834373] mtd_oobtest: verified up to eraseblock 768
    [  482.272717] mtd_oobtest: verified up to eraseblock 1024
    [  486.712148] mtd_oobtest: verified up to eraseblock 1280
    [  491.150704] mtd_oobtest: verified up to eraseblock 1536
    [  495.589439] mtd_oobtest: verified up to eraseblock 1792
    [  499.993138] mtd_oobtest: verified 2047 eraseblocks
    [  499.997951] mtd_oobtest: test 3 of 5
    [  503.404228] mtd_oobtest: writing OOBs of whole device
    [  503.448822] mtd_oobtest: written up to eraseblock 0
    [  513.480773] mtd_oobtest: written up to eraseblock 256
    [  523.489361] mtd_oobtest: written up to eraseblock 512
    [  533.506896] mtd_oobtest: written up to eraseblock 768
    [  543.506268] mtd_oobtest: written up to eraseblock 1024
    [  553.506503] mtd_oobtest: written up to eraseblock 1280
    [  563.511266] mtd_oobtest: written up to eraseblock 1536
    [  573.519567] mtd_oobtest: written up to eraseblock 1792
    [  583.455111] mtd_oobtest: written 2047 eraseblocks
    [  583.459837] mtd_oobtest: verifying all eraseblocks
    [  583.499358] mtd_oobtest: verified up to eraseblock 0
    [  592.382953] mtd_oobtest: verified up to eraseblock 256
    [  601.267297] mtd_oobtest: verified up to eraseblock 512
    [  610.150907] mtd_oobtest: verified up to eraseblock 768
    [  619.034702] mtd_oobtest: verified up to eraseblock 1024
    [  627.919683] mtd_oobtest: verified up to eraseblock 1280
    [  636.821168] mtd_oobtest: verified up to eraseblock 1536
    [  645.705487] mtd_oobtest: verified up to eraseblock 1792
    [  654.520336] mtd_oobtest: verified 2047 eraseblocks
    [  654.525134] mtd_oobtest: test 4 of 5
    [  657.578146] mtd_oobtest: attempting to start write past end of OOB
    [  657.584336] mtd_oobtest: an error is expected...
    [  657.588974] mtd_oobtest: error occurred as expected
    [  657.593848] mtd_oobtest: attempting to start read past end of OOB
    [  657.599953] mtd_oobtest: an error is expected...
    [  657.604569] mtd_oobtest: error occurred as expected
    [  657.609450] mtd_oobtest: attempting to write past end of device
    [  657.615367] mtd_oobtest: an error is expected...
    [  657.619990] mtd_oobtest: error occurred as expected
    [  657.624864] mtd_oobtest: attempting to read past end of device
    [  657.630715] mtd_oobtest: an error is expected...
    [  657.635333] mtd_oobtest: error occurred as expected
    [  657.641043] mtd_oobtest: attempting to write past end of device
    [  657.646966] mtd_oobtest: an error is expected...
    [  657.651574] mtd_oobtest: error occurred as expected
    [  657.656451] mtd_oobtest: attempting to read past end of device
    [  657.662277] mtd_oobtest: an error is expected...
    [  657.666901] mtd_oobtest: error occurred as expected
    [  657.671774] mtd_oobtest: test 5 of 5
    [  659.382333] mtd_oobtest: writing OOBs of whole device
    [  659.388056] mtd_oobtest: written up to eraseblock 0
    [  659.393526] mtd_oobtest: written up to eraseblock 0
    [  659.704525] mtd_oobtest: written up to eraseblock 256
    [  659.710187] mtd_oobtest: written up to eraseblock 256
    [  660.021093] mtd_oobtest: written up to eraseblock 512
    [  660.026752] mtd_oobtest: written up to eraseblock 512
    [  660.338427] mtd_oobtest: written up to eraseblock 768
    [  660.344048] mtd_oobtest: written up to eraseblock 768
    [  660.655718] mtd_oobtest: written up to eraseblock 1024
    [  660.661462] mtd_oobtest: written up to eraseblock 1024
    [  660.970676] mtd_oobtest: written up to eraseblock 1280
    [  660.976386] mtd_oobtest: written up to eraseblock 1280
    [  661.286858] mtd_oobtest: written up to eraseblock 1536
    [  661.292587] mtd_oobtest: written up to eraseblock 1536
    [  661.605397] mtd_oobtest: written up to eraseblock 1792
    [  661.611142] mtd_oobtest: written up to eraseblock 1792
    [  661.918754] mtd_oobtest: written 2046 eraseblocks
    [  661.923458] mtd_oobtest: verifying all eraseblocks
    [  661.928812] mtd_oobtest: verified up to eraseblock 0
    [  662.072499] mtd_oobtest: verified up to eraseblock 256
    [  662.216152] mtd_oobtest: verified up to eraseblock 512
    [  662.359956] mtd_oobtest: verified up to eraseblock 768
    [  662.503238] mtd_oobtest: verified up to eraseblock 1024
    [  662.646847] mtd_oobtest: verified up to eraseblock 1280
    [  662.790603] mtd_oobtest: verified up to eraseblock 1536
    [  662.934269] mtd_oobtest: verified up to eraseblock 1792
    [  663.076329] mtd_oobtest: verified 2046 eraseblocks
    [  663.081114] mtd_oobtest: finished with 0 errors
    [  663.085647] =================================================

    root@OpenWrt:/lib/modules/6.6.79# insmod  mtd_pagetest.ko dev=1
    [ 1142.213082] 
    [ 1142.214590] =================================================
    [ 1142.220433] mtd_pagetest: MTD device: 1
    [ 1142.224278] mtd_pagetest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
    [ 1142.238388] mtd_test: scanning for bad eraseblocks
    [ 1142.243536] mtd_test: scanned 2047 eraseblocks, 0 are bad
    [ 1142.248935] mtd_pagetest: erasing whole device
    [ 1143.962562] mtd_pagetest: erased 2047 eraseblocks
    [ 1143.967301] mtd_pagetest: writing whole device
    [ 1144.011729] mtd_pagetest: written up to eraseblock 0
    [ 1154.137933] mtd_pagetest: written up to eraseblock 256
    [ 1164.265201] mtd_pagetest: written up to eraseblock 512
    [ 1174.393365] mtd_pagetest: written up to eraseblock 768
    [ 1184.525700] mtd_pagetest: written up to eraseblock 1024
    [ 1194.650920] mtd_pagetest: written up to eraseblock 1280
    [ 1204.773676] mtd_pagetest: written up to eraseblock 1536
    [ 1214.896934] mtd_pagetest: written up to eraseblock 1792
    [ 1224.942600] mtd_pagetest: written 2047 eraseblocks
    [ 1224.947410] mtd_pagetest: verifying all eraseblocks
    [ 1225.053133] mtd_pagetest: verified up to eraseblock 0
    [ 1250.760034] mtd_pagetest: verified up to eraseblock 256
    [ 1276.448242] mtd_pagetest: verified up to eraseblock 512
    [ 1302.138825] mtd_pagetest: verified up to eraseblock 768
    [ 1327.824020] mtd_pagetest: verified up to eraseblock 1024
    [ 1353.532178] mtd_pagetest: verified up to eraseblock 1280
    [ 1379.234385] mtd_pagetest: verified up to eraseblock 1536
    [ 1404.943865] mtd_pagetest: verified up to eraseblock 1792
    [ 1430.468816] mtd_pagetest: verified 2047 eraseblocks
    [ 1430.473702] mtd_pagetest: crosstest
    [ 1430.477717] mtd_pagetest: reading page at 0x0
    [ 1430.482328] mtd_pagetest: reading page at 0xffdf800
    [ 1430.487469] mtd_pagetest: reading page at 0x0
    [ 1430.492084] mtd_pagetest: verifying pages read at 0x0 match
    [ 1430.497668] mtd_pagetest: crosstest ok
    [ 1430.501409] mtd_pagetest: erasecrosstest
    [ 1430.505323] mtd_pagetest: erasing block 0
    [ 1430.511511] mtd_pagetest: writing 1st page of block 0
    [ 1430.517166] mtd_pagetest: reading 1st page of block 0
    [ 1430.522505] mtd_pagetest: verifying 1st page of block 0
    [ 1430.527739] mtd_pagetest: erasing block 0
    [ 1430.532565] mtd_pagetest: writing 1st page of block 0
    [ 1430.538229] mtd_pagetest: erasing block 2046
    [ 1430.544181] mtd_pagetest: reading 1st page of block 0
    [ 1430.549498] mtd_pagetest: verifying 1st page of block 0
    [ 1430.554718] mtd_pagetest: erasecrosstest ok
    [ 1430.558900] mtd_pagetest: erasetest
    [ 1430.562381] mtd_pagetest: erasing block 0
    [ 1430.567208] mtd_pagetest: writing 1st page of block 0
    [ 1430.572858] mtd_pagetest: erasing block 0
    [ 1430.577680] mtd_pagetest: reading 1st page of block 0
    [ 1430.582990] mtd_pagetest: verifying 1st page of block 0 is all 0xff
    [ 1430.589279] mtd_pagetest: erasetest ok
    [ 1430.593023] mtd_pagetest: finished with 0 errors
    [ 1430.597651] =================================================

    root@OpenWrt:/lib/modules/6.6.79# insmod  mtd_readtest.ko dev=1
    [ 1478.691648] 
    [ 1478.693158] =================================================
    [ 1478.698981] mtd_readtest: MTD device: 1
    [ 1478.702829] mtd_readtest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
    [ 1478.716939] mtd_test: scanning for bad eraseblocks
    [ 1478.722072] mtd_test: scanned 2047 eraseblocks, 0 are bad
    [ 1478.727475] mtd_readtest: testing page read
    [ 1548.352125] mtd_readtest: finished
    [ 1548.355553] =================================================

    root@OpenWrt:/lib/modules/6.6.79# insmod  mtd_speedtest.ko dev=1
    [ 1617.353002] 
    [ 1617.354511] =================================================
    [ 1617.360332] mtd_speedtest: MTD device: 1
    [ 1617.364258] mtd_speedtest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
    [ 1617.380150] mtd_test: scanning for bad eraseblocks
    [ 1617.385428] mtd_test: scanned 2047 eraseblocks, 0 are bad
    [ 1621.021861] mtd_speedtest: testing eraseblock write speed
    [ 1700.915306] mtd_speedtest: eraseblock write speed is 3279 KiB/s
    [ 1700.921250] mtd_speedtest: testing eraseblock read speed
    [ 1734.931886] mtd_speedtest: eraseblock read speed is 7705 KiB/s
    [ 1738.682742] mtd_speedtest: testing page write speed
    [ 1818.818644] mtd_speedtest: page write speed is 3269 KiB/s
    [ 1818.824058] mtd_speedtest: testing page read speed
    [ 1852.913595] mtd_speedtest: page read speed is 7687 KiB/s
    [ 1856.674492] mtd_speedtest: testing 2 page write speed
    [ 1936.437284] mtd_speedtest: 2 page write speed is 3285 KiB/s
    [ 1936.442869] mtd_speedtest: testing 2 page read speed
    [ 1970.498124] mtd_speedtest: 2 page read speed is 7694 KiB/s
    [ 1970.503624] mtd_speedtest: Testing erase speed
    [ 1974.343389] mtd_speedtest: erase speed is 68316 KiB/s
    [ 1974.348479] mtd_speedtest: Testing 2x multi-block erase speed
    [ 1976.068855] mtd_speedtest: 2x multi-block erase speed is 152811 KiB/s
    [ 1976.075309] mtd_speedtest: Testing 4x multi-block erase speed
    [ 1977.790232] mtd_speedtest: 4x multi-block erase speed is 153301 KiB/s
    [ 1977.796693] mtd_speedtest: Testing 8x multi-block erase speed
    [ 1979.511905] mtd_speedtest: 8x multi-block erase speed is 153273 KiB/s
    [ 1979.518367] mtd_speedtest: Testing 16x multi-block erase speed
    [ 1981.230700] mtd_speedtest: 16x multi-block erase speed is 153539 KiB/s
    [ 1981.237249] mtd_speedtest: Testing 32x multi-block erase speed
    [ 1982.948381] mtd_speedtest: 32x multi-block erase speed is 153648 KiB/s
    [ 1982.954918] mtd_speedtest: Testing 64x multi-block erase speed
    [ 1984.665992] mtd_speedtest: 64x multi-block erase speed is 153655 KiB/s
    [ 1984.672531] mtd_speedtest: finished
    [ 1984.676054] =================================================

    root@OpenWrt:/lib/modules/6.6.79# insmod mtd_stresstest.ko dev=1
    [ 2190.651750] 
    [ 2190.653263] =================================================
    [ 2190.659087] mtd_stresstest: MTD device: 1
    [ 2190.663105] mtd_stresstest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
    [ 2190.679846] mtd_test: scanning for bad eraseblocks
    [ 2190.684981] mtd_test: scanned 2047 eraseblocks, 0 are bad
    [ 2190.690389] mtd_stresstest: doing operations
    [ 2190.694655] mtd_stresstest: 0 operations done
    [ 2214.262705] mtd_stresstest: 1024 operations done
    [ 2239.019612] mtd_stresstest: 2048 operations done
    [ 2262.820899] mtd_stresstest: 3072 operations done
    [ 2285.061376] mtd_stresstest: 4096 operations done
    [ 2308.297322] mtd_stresstest: 5120 operations done
    [ 2330.530459] mtd_stresstest: 6144 operations done
    [ 2352.651759] mtd_stresstest: 7168 operations done
    [ 2375.188275] mtd_stresstest: 8192 operations done
    [ 2397.738174] mtd_stresstest: 9216 operations done
    [ 2414.792572] mtd_stresstest: finished, 10000 operations done
    [ 2414.798257] =================================================

4) Speed test of original driver (with patch to fix support of flashes
   with more than one plane per lun)

    root@OpenWrt:/lib/modules/6.6.79# insmod  mtd_speedtest.ko dev=1
    [ 2894.142208] 
    [ 2894.143719] =================================================
    [ 2894.149556] mtd_speedtest: MTD device: 1
    [ 2894.153486] mtd_speedtest: MTD device size 268304384, eraseblock size 131072, page size 2048, count of eraseblocks 2047, pages per eraseblock 64, OOB size 128
    [ 2894.168888] mtd_test: scanning for bad eraseblocks
    [ 2894.174023] mtd_test: scanned 2047 eraseblocks, 0 are bad
    [ 2897.500416] mtd_speedtest: testing eraseblock write speed
    [ 2977.807233] mtd_speedtest: eraseblock write speed is 3262 KiB/s
    [ 2977.813171] mtd_speedtest: testing eraseblock read speed
    [ 3013.906597] mtd_speedtest: eraseblock read speed is 7260 KiB/s
    [ 3017.440320] mtd_speedtest: testing page write speed
    [ 3097.833394] mtd_speedtest: page write speed is 3259 KiB/s
    [ 3097.838812] mtd_speedtest: testing page read speed
    [ 3134.004981] mtd_speedtest: page read speed is 7245 KiB/s
    [ 3137.538423] mtd_speedtest: testing 2 page write speed
    [ 3217.906288] mtd_speedtest: 2 page write speed is 3260 KiB/s
    [ 3217.911883] mtd_speedtest: testing 2 page read speed
    [ 3254.049757] mtd_speedtest: 2 page read speed is 7251 KiB/s
    [ 3254.055254] mtd_speedtest: Testing erase speed
    [ 3257.599146] mtd_speedtest: erase speed is 74027 KiB/s
    [ 3257.604213] mtd_speedtest: Testing 2x multi-block erase speed
    [ 3259.320945] mtd_speedtest: 2x multi-block erase speed is 153139 KiB/s
    [ 3259.327413] mtd_speedtest: Testing 4x multi-block erase speed
    [ 3261.044585] mtd_speedtest: 4x multi-block erase speed is 153098 KiB/s
    [ 3261.051047] mtd_speedtest: Testing 8x multi-block erase speed
    [ 3262.786520] mtd_speedtest: 8x multi-block erase speed is 151479 KiB/s
    [ 3262.792979] mtd_speedtest: Testing 16x multi-block erase speed
    [ 3264.509898] mtd_speedtest: 16x multi-block erase speed is 153130 KiB/s
    [ 3264.516454] mtd_speedtest: Testing 32x multi-block erase speed
    [ 3266.233403] mtd_speedtest: 32x multi-block erase speed is 153125 KiB/s
    [ 3266.239961] mtd_speedtest: Testing 64x multi-block erase speed
    [ 3267.957985] mtd_speedtest: 64x multi-block erase speed is 153029 KiB/s
    [ 3267.964525] mtd_speedtest: finished
    [ 3267.968039] =================================================

   It looks like a patched driver is a bit faster

    write speed: 3260 KiB/s  vs  3277 KiB/s
    read speed:  7252 KiB/s  vs  7695 KiB/s

Changes v2:
 * minor fix
 * add comments to code

Changes v3:
 * add patch to prevent continuous reading

Changes v4:
 * removed non-needed patch, other patch was a bit updated
 * treat zero buswidth as single wire buswidth (thanks to Jyothi Kumar Seerapu)
 * changes were tested with linux
 * test results was added

Mikhail Kshevetskiy (13):
  spi: airoha: return an error for continuous mode dirmap creation cases
  spi: airoha: remove unnecessary restriction length
  spi: airoha: add support of dual/quad wires spi modes
  spi: airoha: remove unnecessary switch to non-dma mode
  spi: airoha: unify dirmap read/write code
  spi: airoha: switch back to non-dma mode in the case of error
  spi: airoha: fix reading/writing of flashes with more than one plane
    per lun
  spi: airoha: support of dualio/quadio flash reading commands
  spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
  spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and
    REG_SPI_NFI_SECCUS_SIZE registers
  spi: airoha: set custom sector size equal to flash page size
  spi: airoha: avoid reading flash page settings from SNFI registers
    during driver startup
  spi: airoha: buffer must be 0xff-ed before writing

 drivers/spi/spi-airoha-snfi.c | 510 +++++++++++++++++-----------------
 1 file changed, 262 insertions(+), 248 deletions(-)

-- 
2.50.1


