Return-Path: <linux-spi+bounces-7660-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB8FA92E3F
	for <lists+linux-spi@lfdr.de>; Fri, 18 Apr 2025 01:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C006D4A374D
	for <lists+linux-spi@lfdr.de>; Thu, 17 Apr 2025 23:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2542222A7;
	Thu, 17 Apr 2025 23:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="TBCCIfLz"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010046.outbound.protection.outlook.com [52.101.228.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732EF221DB6;
	Thu, 17 Apr 2025 23:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744932211; cv=fail; b=I9v11ONVAhWL4OiDfSGXae7/+LHsDxK0Z6rLiZRKdWhPcrPFpxfsH3yO5y9TbkA97zsqQmt2vHGc6gHqmsaIMlJ/3VmLMIqQem3XZ5YV8krXtlxMfN4iSZYKLGTEkhgVfo8xC5x2pxk5ID+fDYOHrBuIFMbeHuaIoKCpjEFYkFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744932211; c=relaxed/simple;
	bh=Zq2a8NsAj42CcdwLvbkly/laO9Mz3nNNzDHKm3zGh/8=;
	h=Message-ID:To:From:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=TbjmBuP73PPY5DrUFCZwEPszYy3t3eT3Ysc9ltYFDR7n2iydA26t7KAfAbGBIbufPDv7rFHhGqPMI2sZwncPy1W5mTRLDXrK6rxTxUPbMtehfTW1ZDUEM2YCJGiDX7DZMdhScXWJh8uO4lT7GFC8sQl9aHwUNXCqzPF9UAtuEOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=TBCCIfLz; arc=fail smtp.client-ip=52.101.228.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfLjeDPhytaJvrycAhjVYQa9lZH9VdODalR53WTyq8kAfbCfnGgeJc1jh6mFUr8QFA5a886adn0o+jg3tM44KQEUeYhVPmg0UV2XWNaid6/iJ/fuToChFjaIpJPlbU4J7oOczCreIY11CpGwwLi7SCQYxFgKTOiBqLQgetkDv8hmCr5FU802O8daA4MjAAsf+YnW+mWzLoaiepAQqBUYZplRofwn7Ie21rPrT1RO0z2V8TX8S/3jMl3/59SsxivkVfYxrYUSmlcx5mq8WoejaWaq9+tNQiNa/4ag+uqdDmr6O6XUTOgyuRcK+mUWIHRhvyZv03sOy07ETv4ga5SHPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=042qXt/EcC/QBtxXIwGOPhO279NMqSeqeGNhHG20Gp0=;
 b=etGHY2Js9B7yzFgEf94yGSjRSfsCNXNA7PBME4UkrpA2hA02PV2nPkK6ONvIkI2IxGc8F33FNQAZZTNDXPfB02wHJHDbC0UrXmxKVWBeeP0yqBF5Zqg+6XxJNJGzAIjsH0s3FYy0Yl2yY+BTY5Bj1ycp5hHlaKSS1i8aeFQxbSgLjCPYzMPCspDJxokjmMGqtqP+JU9olwDiRMCp859RtqjaAb5B8crJvJdWXMGDei4f5Qu1j/H4I8dQsPfGD5G4wC7rgKTagpc6PPHIWwfZO5j5b+IufBB0ddMgjydjWMFhI9Dnt3JFduUpcwuTtq261WvJJljqxqfxU+VtMQDDzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=042qXt/EcC/QBtxXIwGOPhO279NMqSeqeGNhHG20Gp0=;
 b=TBCCIfLzcvjop/uzaWepvZKVFo+XF8f2GCbJS7BlWZJ/ZH53CAPOh5C8grBYttsQwHYEAYA5TSdRojR/9hf3RT4x4rlf4VD7eAAFs73qPy7dk7nvM5t++/nuzOn9gzOdPqsOd21IMDTvYzApe/qIlxNMUtOWj2oaSMC3gZ/hYJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY3PR01MB9998.jpnprd01.prod.outlook.com
 (2603:1096:400:1dd::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Thu, 17 Apr
 2025 23:23:23 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8632.036; Thu, 17 Apr 2025
 23:23:23 +0000
Message-ID: <87tt6m2x05.wl-kuninori.morimoto.gx@renesas.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Jaroslav Kysela <perex@perex.cz>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Takashi Iwai <tiwai@suse.com>, Will Deacon <will@kernel.org>, devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v4 5/9] ASoC: renesas: rsnd: care BRGA/BRGB select in rsnd_adg_clk_enable()
In-Reply-To: <871ptq4blr.wl-kuninori.morimoto.gx@renesas.com>
References: <871ptq4blr.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 17 Apr 2025 23:23:23 +0000
X-ClientProxiedBy: TYCP301CA0004.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::12) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY3PR01MB9998:EE_
X-MS-Office365-Filtering-Correlation-Id: f621f59c-f845-4f4f-1bee-08dd7e06d8fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LoBhcquUBLVV0vINmbDPsl1TrmXdY48dh/B2HcmpByyE8ZG9dAXtYKGL8Bha?=
 =?us-ascii?Q?Mf8gjEJFzhrVvmLjedANjYQCGQNkVLy5gOLFARy/YL+5Q5AzvS83sjMKow9Q?=
 =?us-ascii?Q?HIKS5Kd6gfqbHXsLR8qrh0AA6S1rK+5bJFtCYc2MLpfFl9pogDGyzpP487Q9?=
 =?us-ascii?Q?j2rsPjbkjFdHgJRaOT4ds/2Ac4gJEU6KD5uSRPyiTs0lgve0Myyo6kkm3bXH?=
 =?us-ascii?Q?FJ14d6B63ds+eLryikPMpl+jHBL3XjR5/2flCKi66H0JLuW/I087edKaO/Fs?=
 =?us-ascii?Q?UcLgGxJBAdXMrkaW/mYBOySybGEu7eU3pKudBQ3B0yteeiJ6kS9pq1l3ijgt?=
 =?us-ascii?Q?YlFIsHq0yIODTnWmr+WtqFKPuf9YoYAKMAkgQ6acaZ6DzeyUODw6bDszwhwC?=
 =?us-ascii?Q?y/L6GHD93YlWHpRj6UYW1wYzJbr6Iyt2CGN3LnI47P7o8breFvbF+B1XslhH?=
 =?us-ascii?Q?dhCUpSHF6RCb9eq9JyRKcsXNdJShEtsdYLO9gCG5NWU8TUhjOuO7pSe4tkYl?=
 =?us-ascii?Q?P7Lb7QfK+ie7ngqZkVIr9DVPFhmb1gsRQwBhVxORU6KGL3c3ZxFPdXxIc95e?=
 =?us-ascii?Q?GYD1W/JbZQ2UYUMVmL4Cy9HQm3RBzm/VOQ8/UbzvNEQRvPcL299uYmsWQ/Uv?=
 =?us-ascii?Q?zfmxbGwtgqryF8EWskaaS/kKBcZBPaAtwQz4BOMhni2JJzBJNAbl9ahnj76N?=
 =?us-ascii?Q?1lY+2GDya3bJ3P8MnRWievxWbMveBZs/HG/f2smzDlhunr75ZXKRx92XBP8+?=
 =?us-ascii?Q?x4hAhsPDq1ybJMeHC7uXyK3EBmomQMp6zVYKkowrp2BOmydkvbANpUZzLBBn?=
 =?us-ascii?Q?ke6/HNYjCFdNrJpSAUuQxI7oO0wdfYqetWmwaAqM8ceL+yj7vsDAGmHV8ZGc?=
 =?us-ascii?Q?QlWueUz/BwD5N5epc527bZkpkF9ePDJmMNI2TNyVOu4KuYuOc1I/AzWZaI2c?=
 =?us-ascii?Q?M3MXM5xdgqjRC/eWXsR+bXg0L/WTSnCaeY+eQWOUqdS73Q4T+vRireqcd37P?=
 =?us-ascii?Q?cZ2FchBXZHusJsC1v3BcKrQvDtqzQJmilTsi7+QUjMuDVZG974W5EOkzYbOW?=
 =?us-ascii?Q?MArdBtTZDAljllJI+wLcD7vOnYQH+6P6SwKp2ga1ISxGQqwunKfG//GdBts9?=
 =?us-ascii?Q?ICMKznf+Sre2Llw2RWwhJHCZ0TbIwEx/ECTpSJzQdxsMBTG7hja6kDwcx20s?=
 =?us-ascii?Q?+qlMpIbRCt3tqcmyASAAQ/hlYT5mRXcWF4x+ys6cn7c+8tzMpOx6lmsFTVu6?=
 =?us-ascii?Q?+F23LNA1BrI+/NEQxM7uS1TM7aK2jZtA39li94inGw+148DUfzwJO2P9lvpJ?=
 =?us-ascii?Q?nHoNE5fYQQji56WeGXHXe/6lO7VH7I8XWg+r6BhKU/tQ+SOHjPAvOpoNh2UV?=
 =?us-ascii?Q?JX19iw6F+vGGECrQatDQNH2r/zZJiPPs3uWC6NSG/JyUNULm4x8Uti0o9wOA?=
 =?us-ascii?Q?7BipxBwERVMGSHiMyXvgHEPctyE8qJIGBi72iFMQMo9va1K7c2I1Den1G9Xn?=
 =?us-ascii?Q?EZcDWiVi55eRfhY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZjqTsJwHi3CLF/VQJIGiexGyqv7YC7eANE2uexogjuYejAJXiQnnvJurF5r1?=
 =?us-ascii?Q?0IlFIi4vCIgKjGCcJkccv/XenF9john94NxdJJy5GiAXhvr9Itd6uU8VtM/Y?=
 =?us-ascii?Q?j0X4thnX5Yzm15rwX55H1uls3NbfFz23H5wy0enbgcPanm6Uq8fkHFpOUsgS?=
 =?us-ascii?Q?ahtIK/PJ1G9yMeL1Iwcb1qWiF93R3BsYviilzpeM07hBvOddPVk6ix/2M55W?=
 =?us-ascii?Q?z5QiAuml9Gmng8+TuP/x1/hlUL3UFVmI/m4GdC2azXkxu0iV+gXs1Z1hJqmQ?=
 =?us-ascii?Q?HgecGzxO4n6/2+9rkDSgzllyvkNVDL6pfOCNOTkcA2ZSois9ZAARBy4sBss8?=
 =?us-ascii?Q?lu+9PnXJt5UNx/2H3KqWOjRtkf2mXb5PNHKlE4GHfqz2830HF6T1nW6fwj8j?=
 =?us-ascii?Q?BSTCiL9LvmAkveTcbAttKs4Sznt13A39FKRKZSQPWGx5fUxJkpwF06Ud82gT?=
 =?us-ascii?Q?rU0u+yNb3d+T/dH4nwGj1rTWdEjBYl/qvaPyqFG2KPgDAhNCIW1nrJ5D5ozg?=
 =?us-ascii?Q?uENWtFgXy7SMnKVXGOS9s80l/lm5dL5zWNJXd4R5RSMmM7QTaS8prn6kpyzi?=
 =?us-ascii?Q?icz35Y2pxiEKMSqUJzQmrPHkfDJybEUaLFROuMiW6n4fhDEOtjPf0SdCnpXS?=
 =?us-ascii?Q?RLYNem7vyWqjXxhTHCHbv7uTYezkWkKNxv41C2zoKZULl2UjVAKiXsHMPYV8?=
 =?us-ascii?Q?103JDGc/1vtUMVXFQIKaF62gwEvzMcrNAIu8CVPhqZ9cJwu+oGY4sI6QVG7I?=
 =?us-ascii?Q?Egpmm3S6x4zjQLee+1t8aA4dRLjtYcgH5R/XRhvPotEG1QUM06LWZ9qNB+Rc?=
 =?us-ascii?Q?1GWFjgdcHO2gFMV2/ebtS1sSkyP9tphLpjQsn9d+I0Ry2OPruaAnUeqPOmA9?=
 =?us-ascii?Q?OFTpN7oW10suPVHuJEfgFca32P5f6vA2F87wiPOGEf5U7w9seC3bsgC42cnN?=
 =?us-ascii?Q?GhXo/mNdoIRXLuzvr3gH+12MguQcqjEYvxNDnVuA1ulMhvk9yQl/h8w8iuQh?=
 =?us-ascii?Q?W9who1WwD+4zuConqUJ3gIxMeaRxeapfVEhfosx9lB4pluPmRu7X9SCc7q4/?=
 =?us-ascii?Q?nJwaGTlF7zc3tUIkWwWL2Aocklq6ISI73Tcff7nbwj4eSFMiEaRJSXVD6CzB?=
 =?us-ascii?Q?d72UWpa3aLlk+l5IfGaCe2SxEHspzpLSoHjdvgFosk6V1pwIAQYaGjVQUyeb?=
 =?us-ascii?Q?PliBHB7/Ni++FrjZUVegqcUSLKAflcutTsBI9CROLKd+qMy52NmIo2jAJJnP?=
 =?us-ascii?Q?C7CD5xPG9g1QW5IuH7mrBdnxSf103ophHFFaulXiHfZ0si+nOfz2652s9cHw?=
 =?us-ascii?Q?jKmmPP9xNOPsi13wbyycR2FpWvXkF2fxrFWNbxKEt46FtPLgAnweMSkAF5XD?=
 =?us-ascii?Q?dV8/Y5hRXlhepBP1XI5V+e4ndPQyB71GkY1t9X0Xa0RTFEVCDk8d8zl1BaAs?=
 =?us-ascii?Q?4jix1q5+leMLyhEfghRRHFbO/0urLnk0Zk31966fb4U63Yx8efNz1x35+tee?=
 =?us-ascii?Q?rz7Lq64Mn4OpkGHTsNiVNdMMZAK/ZMcA2VpX5NqyvlebWcEY7y7hS+JouGt3?=
 =?us-ascii?Q?BJAAXPwJPaCEIlXf2SBoKl+E/dzUBvtkApN9WSulvcN78YShF/Nc7zdUucSo?=
 =?us-ascii?Q?LuCYKdk+PT9zRDwU/+M4RJk=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f621f59c-f845-4f4f-1bee-08dd7e06d8fa
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 23:23:23.3692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7UVP/m5/Ypoa/P9XMiRIP41abDGTWjKHUAJPzEUvvXDHa4/ck+VLWWfOvMVo3zOciBF840rCGK+NMZXT0zrX0wEDPzPbDzdqCKN5rYHQTyIcqBmePvVxouwqua11rp/R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9998

Renesas rsnd related clocks are enabled by rsnd_adg_clk_enable(),
but it doesn't care about BRGA/BRGB selection (It is handled when
SSI was started) (BRGA is used for 44.1kHz lineage, BRGB is used for
48kHz lineage in this driver).

But it should be handled since probe time.
Includes BRGCKR_31 in adg->ckr to handle it since boot time.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/renesas/rcar/adg.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/soc/renesas/rcar/adg.c b/sound/soc/renesas/rcar/adg.c
index 191f212d338c2..e6b7273b27ad8 100644
--- a/sound/soc/renesas/rcar/adg.c
+++ b/sound/soc/renesas/rcar/adg.c
@@ -19,6 +19,7 @@
 #define CLKOUT3	3
 #define CLKOUTMAX 4
 
+#define BRGCKR_31	(1 << 31)
 #define BRRx_MASK(x) (0x3FF & x)
 
 static struct rsnd_mod_ops adg_ops = {
@@ -361,10 +362,13 @@ int rsnd_adg_ssi_clk_try_start(struct rsnd_mod *ssi_mod, unsigned int rate)
 
 	rsnd_adg_set_ssi_clk(ssi_mod, data);
 
+	ckr = adg->ckr & ~BRGCKR_31;
 	if (0 == (rate % 8000))
-		ckr = 0x80000000; /* BRGB output = 48kHz */
-
-	rsnd_mod_bset(adg_mod, BRGCKR, 0x80770000, adg->ckr | ckr);
+		ckr |= BRGCKR_31; /* use BRGB output = 48kHz */
+	if (ckr != adg->ckr) {
+		rsnd_mod_bset(adg_mod, BRGCKR, 0x80770000, adg->ckr);
+		adg->ckr = ckr;
+	}
 
 	dev_dbg(dev, "CLKOUT is based on BRG%c (= %dHz)\n",
 		(ckr) ? 'B' : 'A',
@@ -683,6 +687,9 @@ static int rsnd_adg_get_clkout(struct rsnd_priv *priv)
 	}
 
 rsnd_adg_get_clkout_end:
+	if (0 == (req_rate[0] % 8000))
+		ckr |= BRGCKR_31; /* use BRGB output = 48kHz */
+
 	adg->ckr = ckr;
 	adg->brga = brga;
 	adg->brgb = brgb;
-- 
2.43.0


