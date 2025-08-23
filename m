Return-Path: <linux-spi+bounces-9646-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 048E8B32A6D
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 18:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 888EA188C4D7
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 16:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436992F0698;
	Sat, 23 Aug 2025 16:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="CNlkIynN"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021129.outbound.protection.outlook.com [40.107.130.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8032EFD88;
	Sat, 23 Aug 2025 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964905; cv=fail; b=pbXHpRIK8HLvT/71P01lpahPbitVNj3AUHOqwpQmXpS1sZK0E+0fZu/VZ23hqhS7tjvl77OTQEQ9TGZTp8n6FfFusYptzOpbEREEXFea4MamVivgVVWQNmGevndqU9vYkIl7n0LQRFYntrGgIMKwkDn/Us3RvE9b3jzpui+z3uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964905; c=relaxed/simple;
	bh=9XuiH50tKdVRvzSv2heLofF2LN/sL5KWv9/5UPvj8Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZZ548lfo6gQ2GtpUeV056wBPrbq7LhgUjQpG5GjFkfCsWMYnQC+5OBcWVzcuyL7T7D5nOj3avRYAeJcwz4ZP9wYanin/Uk6lyzS791X/rau5Dojy5DGDpti8w+tSJj9EWTfeVeCHqmG6rPciW/OOY+JB5P7SJPlWYxR9GXn7c1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=CNlkIynN; arc=fail smtp.client-ip=40.107.130.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N+CK0mqWzvGyJ+SvdLue81lyXUJiRl5cUR7c/8PN7Fv8jUpDnk1xnbebfUD1daQTLl1x1b3embXS7zp8J5hL7B48AIuTTuMbUwi4sem4OChzCem3XzfsbPhyvsncYjshoe0VvATXg3QnYIBcm/4NhGgkNL/dBxx7GW4QOYN1E0I47H4fAEACk7GCiW6izfwvk+Dhc7Sfu7OVJij5oEjcFhPo6KODQSgU1HtCwEgUnK5fFaVKyDHZcEllVO3K2Lw4TPAHIcr6G+QxeVdgtRNPFOzPEryP37AW9WrNmlwkHW9mbJpTwB4W0US5CiRa8FfEuGqTGXJl5x9Wyg3XfCWBOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9aPr2dVgLydMAozF3g0hYlfzC3ZcQd6UmrwXJ1HUSg=;
 b=h8y9CpFzPjML8RiRNkO/Qv8QzRwtfz+8rbsXSmwpBJE5IPSBBGNmcATx+7e9JxVCRfa17hVuTwnuEMvkjrU9JJ2NYWG4D3ldjJAVoSXhMdPYYFKGUav8PVVZabE60zqU9LCjZXP9CAbgvyrzrlw02b8bIwp5gdOaZWWrWQrw8bKns4Z7YY8Hw//TsUtrs0rTosq5GXBYsOm1a2VbT28ojcu2/Tcpr7xLCtrWqId6nYFjmXDhlM1ZvDH4A8rXRRA4OQVHLucXeBSqdPHJyKDWinyikGVGFYKIMJ0k8eexJwdQJCa/go/rE5nsnsrrc0igjvIQAzoGLic+M6K1iIV90Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R9aPr2dVgLydMAozF3g0hYlfzC3ZcQd6UmrwXJ1HUSg=;
 b=CNlkIynN5bmSsAo29Zhokluwclc+vYqMdyFN8WlSOTB5QsqgROm8acZ4FFr8zbOcZzMLZXlt/thFgpRqykBZuKB/8wdahiJJmhDYiRPrrgrYC0yEOeH+gDHOhNPoQVXL7GeH9J4Vhj4meBGv+KhY8MLARUUgIe7g8EymVS5OFOXCddWudrQy1X17W6l2Luo6/NcGIwNhq280Z6hZ8E1Rq42Wdnzf2Y2ClRlHi6j2YCxTjUHur1HsJRt7G9qkUnDN8XyxoftjDi+PlUpz5FNMxV2CYOAcpQ4YJflsGe5qSQerO6GcgQoMSxcoZNmwgjVXajEd/eJ6Z6brNninKuoxxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB6399.eurprd08.prod.outlook.com (2603:10a6:102:158::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sat, 23 Aug
 2025 16:01:35 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Sat, 23 Aug 2025
 16:01:35 +0000
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Ray Liu <ray.liu@airoha.com>,
	Mark Brown <broonie@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Subject: [PATCH v5 11/13] spi: airoha: set custom sector size equal to flash page size
Date: Sat, 23 Aug 2025 19:01:14 +0300
Message-ID: <20250823160116.3762730-12-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250823160116.3762730-1-mikhail.kshevetskiy@iopsys.eu>
References: <20250823001626.3641935-1-mikhail.kshevetskiy@iopsys.eu>
 <20250823160116.3762730-1-mikhail.kshevetskiy@iopsys.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00007568.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3e6) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAXPR08MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: 007d8bd2-a8aa-4d30-6c51-08dde25e5628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0qpFwYoVrSbBwsb7h5G7DuHHexCk0IGgZjCOqzU8V7wsSdS0Mygr5xXDHMJ0?=
 =?us-ascii?Q?mdidAJ0lVlDGTHktVGpn/VJqIbyr5s9sO7qss67icz5a2bB2uhEMJ5/HhprS?=
 =?us-ascii?Q?ohzTZjQeAc2phrr2NOz2yYPMKZrX5WB9nn6uOYec9o1kIymgJHRLjhkQz/oL?=
 =?us-ascii?Q?DPaErP5MhEzLklz/7EMti+wuObAaCrbD8Y4dKH5UlKoI/xSG4OuhmCvf2zLp?=
 =?us-ascii?Q?YbtGBLjOP2GgxByv584R3DRtnjIlSU8zBaAOFhZUJN7Wh/jBN9rOEOOeFi9P?=
 =?us-ascii?Q?Iot9yC1zfN0z//VvG6CI8loFBKUBvTWyqMZ30ncG58k7TsDfVwRyZ9oJIkKS?=
 =?us-ascii?Q?9WYEys2JS4Oe9eLC+YC+sdms65Iq31U4s66shJMwHBXNUTA9JoglytDMPpp1?=
 =?us-ascii?Q?8E/DEJsywkDNYH6t9w7A/PJ9r58fALQqap72SE0+ehXJzT8svU8zXGcncUzt?=
 =?us-ascii?Q?Kd86VwoMy0kCxWHeMEfyZHIZlMiznfnPk6hTps9k4m6pY9PFL8Seosd15mAl?=
 =?us-ascii?Q?/TCCyyDxQ2p2kEFpznLsmq6WH4Smz714rnFWQEj/saan2ZXTze2DFCp4I73m?=
 =?us-ascii?Q?8Gdd9M+b6qOpnyTPJUTMVmgq4eLor+N0Fa9V1jmYy0WF6rfnOC5ibo5FEx2q?=
 =?us-ascii?Q?ouuE7cYdm6UEWhmEjBPcdWlKFkGbsIe6ji9B/ywAU91HGqaYbt6QoUAPWVsb?=
 =?us-ascii?Q?BrkxdQVPFVekQl7iDVKBB8OYQkdP/SOweV8EfRv/8zs4CqbZAGRWj6UVfiCJ?=
 =?us-ascii?Q?ZsPKy8wDXvcFmmplMUTMI0rA5exYzYzLXr65i+sHUKFFfn25RUS31qU737fK?=
 =?us-ascii?Q?DI14r7girp+E+GQwXDSmIrphdviDSA2GDtN9FGVTBetKYMHfbfeZIUgeJ7gp?=
 =?us-ascii?Q?20oIuaaOQ6LRUnn9IxqW9/iXn21eJXQz0U1ZPBBj7OYWI8o1uw1lhKQ4Bb1s?=
 =?us-ascii?Q?dlV1bQqf4E5h5/Cklc22AvZ2Yp08giA+8peCkeoXfQ/7+IwpYyFET36+SAHz?=
 =?us-ascii?Q?O5DLlAviqg2JkciXAHlqvHhgoAhPeR3kZ8DFibcs2up76k+3e2xEQqYONHEr?=
 =?us-ascii?Q?Xwcl1NGshz/VGWCBC/ChW7qdCVOzVUentI15SvcK4CN6wjZHTVv5UcY47KIS?=
 =?us-ascii?Q?KER/Rom6MnDfELMVDXnbw0SnyOwf39srMUGadKFJRAXnX0/Tt66VG5+eBsIW?=
 =?us-ascii?Q?j0Yls44acnydmhjp3mSKnNbPvFgQTTSfjuIdNs5g0LEgTRvtfhRAwgOc1dM9?=
 =?us-ascii?Q?YKkLZAMTPKi5Hz/AdoXIairXHoiTrZG+6fESdKWTpOF0ya5tSvsCyIZFG8m6?=
 =?us-ascii?Q?VU5tttH4Y8r7okddwkPFRb9Uji6jN0NwXxIv2XSiZA7uvPvc2tG2sCPOc462?=
 =?us-ascii?Q?5EE1d0fWV6MAMj9Vf7z4xKJUL3nLNp/jFSuoPEaCsh7O5xruUxXrwn2JkVrV?=
 =?us-ascii?Q?WCM77Sdo10hxdJX48EgSGX62Tq2g2HP2VK4Qky2cF5jM8KqZYWUM5Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t6pUucEr/ZZcQK4JWGOo3ZalDPUXWAl53IRunkkVwI0iTf1ZJBkZ+Fcuyaw4?=
 =?us-ascii?Q?hdhjVc0a2p5u7N2XrDGcpFGw4aGnq2cboGBedU0/O6jG7EmjNWsGeEHqcjKy?=
 =?us-ascii?Q?pM2dze57WTGNt+wlHvawB8xD+zNsmyQfmGPKEDdcsylOTs+n1O+DPdl7NYY8?=
 =?us-ascii?Q?ZJ+ce9SJk3trTQqcedXQDBl0NnImQGnR5WNfUxddmCjAGe7hk4EoAeDOej8U?=
 =?us-ascii?Q?3krXacOAYmeh0H+dn3KCTsp/pXC8pLhFr9blydp43WanLXLNi/OJPZ0CmWlo?=
 =?us-ascii?Q?0h7ahhel4rDf5/1EDWA929z6C22C6OOMz2HG/GaU3YFGnRzPl0hkShKD1ZIX?=
 =?us-ascii?Q?adBIvfYjop0aG030MGI1SmWq4nByJRj+xJ6khn0eD0v4E1fhN8DqmlR+qt/s?=
 =?us-ascii?Q?RQtO3dpcQOjYqr8rXA0Wexj6x+49fyDcp7h8TxVZc6rWxPRNkBuznnEMJE/5?=
 =?us-ascii?Q?JjwzhxFq50AdkRvkNZOd/vlLqV26x3lAO0lj7BLHlTeH9qhBDJ//hWyiVQkP?=
 =?us-ascii?Q?UVzPca+TqXETRClB+mmdx7s3Vhaq8Mj6inlJcazqUlRad/9IXrEdEtaeGbWx?=
 =?us-ascii?Q?vtsTolKeXLhRF23ZIwRI9tljeacMupsbGC1Nym12hZFX1s6tqt2KBRSRa8k1?=
 =?us-ascii?Q?ZB/za9JUH7PC6nH7WBDj17L7oSpHJpOF5G/kD9jlRsIrw/79B/BA42utDG/A?=
 =?us-ascii?Q?kLnwGpwHkqn5+3drbswoMlFZ0sewcv6eXR0suPYoeBE3QTisAPZueQ6Q2rjo?=
 =?us-ascii?Q?rVNnQobfr/en65wHgkAa19OTX2vacf5IWYvJD2ugui0dnIv//m/MblEJUglJ?=
 =?us-ascii?Q?ylo3AE1xve1rABGkMWxCdT+6uOLWDHn7Z9mAEpQLSZdJ3LvsC2yKytmiGrTn?=
 =?us-ascii?Q?pzpFEdGlA7+NsqkWJhC+5AayjrMa4Zpe3yva7Yey4fn/Veh7MD5Ad4EimYVj?=
 =?us-ascii?Q?hwyXY2fDELdZR41BeGkXzD+U3vjsRIY6MRP2VPyb0L63c46wiaOzxdVTajiL?=
 =?us-ascii?Q?rv5I9uXBJuvWICZobbA78kZx3iOenhZSBwirvIRY00UGznh86BgdNj3IVN+q?=
 =?us-ascii?Q?NvsG6E53+vIA+zxFhj9WrUSGyKlRD1pbKX0EbRaUAcf5pKiupeHEpSMNW0x3?=
 =?us-ascii?Q?PUYggcbDIeWQjjz6vnL7rT5sbA49dI2K5hnKpn1y2mGopokbAUftO3v9TXki?=
 =?us-ascii?Q?ZHtmH3FNrjNs8Qrcfr6Y3OzozkcyhKIf46ftRQoZDAEgiP1c92dI0mrAoUEp?=
 =?us-ascii?Q?19B+ExAd/EeDsMTOPxrutBVfRRMFTrQdkcVIWqGAsq/LakJKn7jk+gJVny1C?=
 =?us-ascii?Q?rUGJ89psz9rg5WqZcBoHN1kmqR5d0UEpOQ4HpIEEenpMkxsQ48s3rBP5M51M?=
 =?us-ascii?Q?qQZSpgYuc8RNCNQ4EWK4KXpPf62y8FXxXVhfteHL8isIU4R/sNoPg56BDrtH?=
 =?us-ascii?Q?UHELtDCGsz2Y0+uyOy+pLxfdgBySkt8zjomcG+Au7pdnbq0/CFtpoCNClIJT?=
 =?us-ascii?Q?OhV39WrWmOftxbJoUajHSTr3K33H30vyo1dDU23sOZ1N7DZLRMW7k1i1mFVd?=
 =?us-ascii?Q?06lpWI6HPjT6SuzaPn2sh2bbt/ANKfduSTm4uk8JoDImrphGOZOFe9jY+0fD?=
 =?us-ascii?Q?TpIzi0xySysGwLgx7WUmhCw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 007d8bd2-a8aa-4d30-6c51-08dde25e5628
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 16:01:35.8335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oME7qsdO3IWQuh1g3xj3z1xqIuUVbBA9tBtPTGNgsCYTiS7VKq5Jtpbx+/6F0PYEaPCBODymi3NSd7MlVge0mXn3hB2MUm1VBoC066cptkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6399

Set custom sector size equal to flash page size including oob. Thus we
will always read a single sector. The maximum custom sector size is
8187, so all possible flash sector sizes are supported.

This patch is a necessary step to avoid reading flash page settings
from SNFI registers during driver startup.

Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
---
 drivers/spi/spi-airoha-snfi.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-airoha-snfi.c b/drivers/spi/spi-airoha-snfi.c
index 3fb76e2dd5e3..babf7b958dc3 100644
--- a/drivers/spi/spi-airoha-snfi.c
+++ b/drivers/spi/spi-airoha-snfi.c
@@ -519,7 +519,7 @@ static int airoha_snand_nfi_config(struct airoha_snand_ctrl *as_ctrl)
 		return err;
 
 	/* sec num */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
+	val = FIELD_PREP(SPI_NFI_SEC_NUM, 1);
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
 				 SPI_NFI_SEC_NUM, val);
 	if (err)
@@ -532,7 +532,8 @@ static int airoha_snand_nfi_config(struct airoha_snand_ctrl *as_ctrl)
 		return err;
 
 	/* set cust sec size */
-	val = FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, as_ctrl->nfi_cfg.sec_size);
+	val = FIELD_PREP(SPI_NFI_CUS_SEC_SIZE,
+			 as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num);
 	return regmap_update_bits(as_ctrl->regmap_nfi,
 				  REG_SPI_NFI_SECCUS_SIZE,
 				  SPI_NFI_CUS_SEC_SIZE, val);
@@ -635,10 +636,13 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	u8 *txrx_buf = spi_get_ctldata(spi);
 	dma_addr_t dma_addr;
 	u32 val, rd_mode, opcode;
+	size_t bytes;
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
+	bytes = as_ctrl->nfi_cfg.sec_num * as_ctrl->nfi_cfg.sec_size;
+
 	/*
 	 * DUALIO and QUADIO opcodes are not supported by the spi controller,
 	 * replace them with supported opcodes.
@@ -697,18 +701,17 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 		goto error_dma_mode_off;
 
 	/* Set number of sector will be read */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-				 SPI_NFI_SEC_NUM, val);
+				 SPI_NFI_SEC_NUM,
+				 FIELD_PREP(SPI_NFI_SEC_NUM, 1));
 	if (err)
 		goto error_dma_mode_off;
 
 	/* Set custom sector size */
-	val = as_ctrl->nfi_cfg.sec_size;
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
 				 SPI_NFI_CUS_SEC_SIZE |
 				 SPI_NFI_CUS_SEC_SIZE_EN,
-				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, bytes) |
 				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
@@ -733,11 +736,10 @@ static ssize_t airoha_snand_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	 *        = NFI_SNF_MISC_CTL2.read_data_byte_number =
 	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
 	 */
-	val = as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num;
-	val = FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, val);
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
-				 SPI_NFI_READ_DATA_BYTE_NUM, val);
+				 SPI_NFI_READ_DATA_BYTE_NUM,
+				 FIELD_PREP(SPI_NFI_READ_DATA_BYTE_NUM, bytes));
 	if (err)
 		goto error_dma_unmap;
 
@@ -826,10 +828,13 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	struct airoha_snand_ctrl *as_ctrl;
 	dma_addr_t dma_addr;
 	u32 wr_mode, val, opcode;
+	size_t bytes;
 	int err;
 
 	as_ctrl = spi_controller_get_devdata(spi->controller);
 
+	bytes = as_ctrl->nfi_cfg.sec_num * as_ctrl->nfi_cfg.sec_size;
+
 	opcode = desc->info.op_tmpl.cmd.opcode;
 	switch (opcode) {
 	case SPI_NAND_OP_PROGRAM_LOAD_SINGLE:
@@ -880,18 +885,17 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 		goto error_dma_mode_off;
 
 	/* Set number of sector will be written */
-	val = FIELD_PREP(SPI_NFI_SEC_NUM, as_ctrl->nfi_cfg.sec_num);
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_CON,
-				 SPI_NFI_SEC_NUM, val);
+				 SPI_NFI_SEC_NUM,
+				 FIELD_PREP(SPI_NFI_SEC_NUM, 1));
 	if (err)
 		goto error_dma_mode_off;
 
 	/* Set custom sector size */
-	val = as_ctrl->nfi_cfg.sec_size;
 	err = regmap_update_bits(as_ctrl->regmap_nfi, REG_SPI_NFI_SECCUS_SIZE,
 				 SPI_NFI_CUS_SEC_SIZE |
 				 SPI_NFI_CUS_SEC_SIZE_EN,
-				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, val) |
+				 FIELD_PREP(SPI_NFI_CUS_SEC_SIZE, bytes) |
 				 SPI_NFI_CUS_SEC_SIZE_EN);
 	if (err)
 		goto error_dma_mode_off;
@@ -916,11 +920,10 @@ static ssize_t airoha_snand_dirmap_write(struct spi_mem_dirmap_desc *desc,
 	 *        = NFI_SNF_MISC_CTL2.write_data_byte_number =
 	 *        = NFI_CON.sector_number * NFI_SECCUS.custom_sector_size
 	 */
-	val = as_ctrl->nfi_cfg.sec_size * as_ctrl->nfi_cfg.sec_num;
-	val = FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, val);
 	err = regmap_update_bits(as_ctrl->regmap_nfi,
 				 REG_SPI_NFI_SNF_MISC_CTL2,
-				 SPI_NFI_PROG_LOAD_BYTE_NUM, val);
+				 SPI_NFI_PROG_LOAD_BYTE_NUM,
+				 FIELD_PREP(SPI_NFI_PROG_LOAD_BYTE_NUM, bytes));
 	if (err)
 		goto error_dma_unmap;
 
-- 
2.50.1


