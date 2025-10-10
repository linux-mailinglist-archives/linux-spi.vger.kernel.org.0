Return-Path: <linux-spi+bounces-10553-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959B4BCE84A
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 22:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82909400D1C
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 20:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E03302742;
	Fri, 10 Oct 2025 20:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b="1DMmrNMn"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021092.outbound.protection.outlook.com [40.107.130.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E8D27A917;
	Fri, 10 Oct 2025 20:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760129121; cv=fail; b=djCaFU5ekWTNt9N3nRdSRCLK4H3yl71gbgnBATdZZnVg3AXMf2dEz4h2/WHXEJKgwa7Zx/jxR0bI8vPeQN7avqHh1donCrN99h8sdeeqrtgHhmrH8LfK9Bc4C1I92aqQopO2C/FGzorK3hFii02G8tbj7y1LiLlhu5nd/6c+QDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760129121; c=relaxed/simple;
	bh=ujIqe1Mfc+N5XQx5oWvl3u/g+a1RgzXvbV8Bpj5Y7Ns=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Z5+YhymXUvk++0LISoYzlv4ccsbvZAFJEVJLqu52V/EXHJcVq28hN6KfG2tljv7ebanEBpP1pZCaKVCVuexuq9nc17HPKgJex2jo0ccXwNTVSq15K0M3iJj4ZGFV3RHTV/DlOUv0sacjpSddyjcCPHyboWgI6S2LLJGtALA/qMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (2048-bit key) header.d=iopsys.eu header.i=@iopsys.eu header.b=1DMmrNMn; arc=fail smtp.client-ip=40.107.130.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzQTmq4UQXCg1J+h38GnAtyd2CxQxG6IR69xu6sBr/BCOY2lzBUn0KhmCiiUIxLzVAGoSKQidjbwGLP1pilYZWqelwtjto0i06JC/fnG85EzACpX1NJtRWSqtR+v6ivaU31iY52p/h/oeUuOjagmE+XGuVeHgrK//5rgN7R6159bdPH0ETAAM7Yym+lKyuDGnNq3XWM5BOj92jSjLaEKFrXl7RS/vGUFBdzvWcwMFsUAh2IXExiVaktnf8Oa3ZSalMKkngUFYmrN09/9IlaSZCjAWTMXRRgPab92YyDbTr9hu/LBegOxKGRzxH7dSM25xjCl5+J6Il+xGNrjYQ9iCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GO4OD6/Pnn/x7FJA9OjoibbWnXApTINrfs0HliFc4us=;
 b=YTojUNfcu2iAakSMvMOvjEaR1Es7f0i2sxyF7N/uWVV3WB+jOA5JHgQ9qEzNVyS4HS/6QI8xD95fUltWYXaudWz/Ij/JzqZOeXtxdY5QUoAGQNnRQvsYCXbvMB6RqM21wPsV3bekEohvuaKOUtgP3MwPzvon8r4HCRqr2a7gfGUOsyVmO0ZOQlffKPrjuOnsoioj7aATnbaHiEue2ZXqF4QUivMx79+2KwJXbmf8pthvSbtrCpe9/XMOgC++Yg699OFL+PXWXw1MPlKWIUDw0ypnASqLAVA8TllB0wAkSiRMDLYO030DzMhWbxVY0BWinVR8qFcXb4L+AQ80vj8Vpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GO4OD6/Pnn/x7FJA9OjoibbWnXApTINrfs0HliFc4us=;
 b=1DMmrNMngEMs+hdo4Keo1Uh55eHwGRSyYJABfY75XpUSWrrx2SLvtXAVyDdijird3NbX5h5ex/ZGe9aM0JqVyxzlIvlaY6A7z8X4eKpa2g9Qo7t3BtRJF3g2wa0fD8gFuGhwRx9GWZCuCz6I30+uzwQVxO+T+o6OeX9PZ9AMBMUcWE4dvEwm0n9PClotDGgsK9INVkdAyrTn7/of9uaUiupJ+67GPCaDBe9o2k1q9v9zrl+gP/AgHYnYJzQADljbWADv3Y/iSzjx7ZDBeSgGmf5GrnedVdBjwFmFvunFhCtxkfbBofiH9dA5TlDZBjJzW50Iol2bfqOWtek5tkAvkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV2PR08MB11561.eurprd08.prod.outlook.com (2603:10a6:150:2d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 20:45:08 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 20:45:08 +0000
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
Subject: [PATCH v9 00/15] spi: airoha: driver fixes & improvements
Date: Fri, 10 Oct 2025 23:44:45 +0300
Message-ID: <20251010204500.1625215-1-mikhail.kshevetskiy@iopsys.eu>
X-Mailer: git-send-email 2.51.0
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
X-MS-Office365-Filtering-Correlation-Id: 63247d30-9d36-4f88-7eb4-08de083de5dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aAU4IiuaNjP2MrA4XX0YBlmfc5hCtW+vGLSOfMdhjL37rmZh40c4Z0EWsSSl?=
 =?us-ascii?Q?D+vOmQQWVQMZ4CtMFbn9Hwx80b93VCb+ltzH+R4bIf9fYDUEi8jsYUCL8GcH?=
 =?us-ascii?Q?A9jaHZ73aWneHgzd1NGno8WTCQsQu77+S6+fdaYYWgdf1oQhiyby5t8g5ulI?=
 =?us-ascii?Q?rcICpkKQB7g11+RCxllkCSoA+rDs0zq3CaNGCWAPURrNS27RJ4gjsnQF0arq?=
 =?us-ascii?Q?aVUft5eIhB+YOy5MHvo+GMRBlAssi2MmQJ3nj0jlMDx5qCoPAPMoAovvrJ5W?=
 =?us-ascii?Q?9CMd80rPPLM1q0VUls7lvNoqhUWW7smxtNFQ0g2aQbZvlJY2URcdOrc4xaZ9?=
 =?us-ascii?Q?S86LKCKPGSBt7NDZqUSg5is8Z4HA0/DCesJ+E/6Vyu5YfuJT61A+UN3Dkozi?=
 =?us-ascii?Q?prbCqLd/S4NEC04GA1SLLchqWzXHMHDMuQCWKrlz29pZy8xftVQ2RZHW4YGK?=
 =?us-ascii?Q?uI2rmbyAEnadjauCdz5Jek9hCK20uEdDFaF6t0lY9kUUmMSBs7yi+Xl1WcrE?=
 =?us-ascii?Q?IpBbxCq1msQXhMQK0iIluDc5mFMgoA+KHdluy90nbST30xf96bni1rrtuiRe?=
 =?us-ascii?Q?ieGh8bxLAi8Ez4OqosUCBF1dRvOSRek4FWCHYF9txJWEkzuhhwr3a/8XBjrq?=
 =?us-ascii?Q?hb8XCiePh7wXqb6d8cTb+aP88jm5wVRDZJGeR6ZOwcC7d13vURjKWwjeHOtC?=
 =?us-ascii?Q?4E0U1oQYO/2K5/0s/ksA0DU7rWKzBDvYvKHmapDe1gSnjItr/1toNO3RRUHU?=
 =?us-ascii?Q?nzZvlJQwIdj2PW6D8I2a2vWnooDcXghXoBeitoFw9T4w6/51y26TzY55CY2x?=
 =?us-ascii?Q?6DbOTlwK7li/s8TrvsysBh8b4DaC7BSXUiorJZESDWYv7X5cQoQm3+874VSU?=
 =?us-ascii?Q?iHTCXMvV1LEYzV/n4EsQiriGcpzrlfcpawZY6foYTkweIZQNg8Ahhv+WJ+bl?=
 =?us-ascii?Q?T3x5j+j4G/tEnb2ZW4rfvsaP3xBYB+K553QVUJxDSi5U92atLD+kjgV+yDB3?=
 =?us-ascii?Q?IHcKj4MeBS+EWepczsJpDi7AY4L6+D9OINIzmgFnST6LTLJa16iHixCij02S?=
 =?us-ascii?Q?P8kbPwJM9sVxrdl2pdAppeqdFQ/lYnwBJgl4/OsFqk2ACKexrv1ezbJN8/UT?=
 =?us-ascii?Q?wTyq5cAPXTevhQcCIoU12CfxMYzbf8FBHc8tHqci1XJHPjZS8eirUJBpS0ie?=
 =?us-ascii?Q?D94lfIBiv6xY5cGM+a/tn8vp56My8+qaSzOFHDAnOEnDdXwaRqB0HCt3jUbJ?=
 =?us-ascii?Q?t/gR8Wjt3VF1w3FcSikvRMHG6y/K1EYX0mIfLfJkwMxoZ0T4x3rdN2kolfny?=
 =?us-ascii?Q?rE4lyh/kUlL909TwOu319e3tpI/vxEdOOBrAvhaLkhAxZf7vhQwZXsT9Mkwj?=
 =?us-ascii?Q?S73kzlPclVVzQjlZwAxdKERwNQzF3d/w1SRM9hk8fjivJ+YdVsOc6OoV0rYs?=
 =?us-ascii?Q?GV9h3maOCQ5qObdXHRYktPBPQ6s0mvPUti595s6sfKe+rXRok6j0Vkvdzv3u?=
 =?us-ascii?Q?PHt1fJB3U1pV+R8uOlcAUNjRaR//PRyly5cjo1DszkHYRxhx9Twuk6cp4Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR08MB8121.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fPtVVruxCdvHFvskoE9HaHoyt+yezavLZaaonzloistdc6Ir2sGw259+Zz11?=
 =?us-ascii?Q?rXwZploqADZzfzbsYajoIMi/D8/I9afN39HsbPdNmRJw4Ue7O0Gm77Z3l6OP?=
 =?us-ascii?Q?LtVXa9kSVh6B+PiVgOMrpFEiJEnXwp0T5UkvN5CfZMqB4QbcBdAcpGZo58jB?=
 =?us-ascii?Q?RYxdvr9uJxcUlhUqBZfVVqcjX8QJgP3q/Ns+iLrbM8TSG9kPa7YuD2JDV6nQ?=
 =?us-ascii?Q?3ZBbiI3l50nJgtUQIw7Fd0tIoV2AQg4E1kiIPTpxEyHLw8oNmKEYSfOCowOS?=
 =?us-ascii?Q?JjqbZD5HmdargaYE4Tt6RZRZf77w2Ua2rgCMEehP/S6oo+h9Wpmokzlu7QIN?=
 =?us-ascii?Q?cTZHQmlEXI6w5cSLeHKyaggltTsVPGersWWNYleC3XUgu6ldkUqQ+4BwJVnF?=
 =?us-ascii?Q?WXxhu9xwfwGCr58ZRH3m8Sm0NXpiEpxewoz1qY+Soym3WG6oJbrGCFRUb7qf?=
 =?us-ascii?Q?rxAHYsOjgfVFJq43yHzFUZ6Mh7NHjIqoThg8uAsk5AjSEk0I8v6w4Q8WuoXb?=
 =?us-ascii?Q?YcYyC5sckZQ1yoqRzppXU6lJDIIfeMAxPDQIIRBQoYUocNHpRcToTby4EZii?=
 =?us-ascii?Q?xOIakHQOGxS4c1DXCRz0IIQKaRfFr4Q8+nGgb3paDlepn12Uo8IyWE1euYS5?=
 =?us-ascii?Q?kxXJ2JGziI4XwluCqotr6pCJRZoaTG6aPg47exHQAsCA0ZBWasM71VjO+fMt?=
 =?us-ascii?Q?97wUjBLjuiY8dfHiuoTH+wvMf29gkMD7ZpltM6S0SGhznnER6H9KrK3oM20m?=
 =?us-ascii?Q?/nWr6nutajCr3/9nKS4wcaIJVxtXxp3wQPD0xfvCb237euIOr4gjb8hlJL5P?=
 =?us-ascii?Q?6uEDT2H3ySPHuuE/wifW0YDzeKYF+ZZTAIkBhHMrUQ9ySk5nXJ7s5GI2w1Ae?=
 =?us-ascii?Q?NGaC6Kqx5xoRn6Rne25albwBiS4nyCfVWD+6SdVfy4L1tpWWCOl0PMRUSXwV?=
 =?us-ascii?Q?wRD/EiOtaoH70DmIE717AQ8X8eSSBdR2mi6TNog3y2a+wntpWqi/spBC+Qj8?=
 =?us-ascii?Q?TbbfVVjxKxE3iXvKlGj3pBX+dqAIesu6TeWxuVFYDndlC5qmrrdNUU4eIPaK?=
 =?us-ascii?Q?IKBefFqw9epEEkLpWx6QZTMK+b8GGKHtBhSYduVTDeTGhXq12uPG4M+PgBS5?=
 =?us-ascii?Q?1RhnPi9olevVw6LF89UK6QRbxY50/3hm6b4beaamj+JdksG1cISo32v8S3T7?=
 =?us-ascii?Q?9l1qkf3F/k3oRrhemx4uXukpmgJR+0hDqQ7NcN1eOwANLzvO6RwL+kzeDLE9?=
 =?us-ascii?Q?Txmy2wdYBxfl8mGNjokP36cUrmQYdYHG1QPjUgLv3U9d0+ogSbOuuznqd3vF?=
 =?us-ascii?Q?aIF8xe2mP2D0VmLW1FuAvWmgva48YYjWWNvicLY/jfFXlaW226AMbbcHRCrW?=
 =?us-ascii?Q?2OiK2lxIhYJQ80MK3ghxhBf8ZGU4fxHQZv9A7ZlLbgWmYFQIf14YhQF8yXEn?=
 =?us-ascii?Q?HjcJt1s3RIiTOqgNvo79ATZffwImr0p6mOVXd8QQexQOdqgYX18xZvFKBj0q?=
 =?us-ascii?Q?3C8Bk5vGU6gefPLRSYJxsdV+My2tceonDvMXux15gM2cfX67JEf4oQQN/xuq?=
 =?us-ascii?Q?2B550Ba2MMzcwmZBWykUCnczJM4U8FRE83KXcYwfau4nucG4mIz1Hdidvn0m?=
 =?us-ascii?Q?ZI2rhdLqIpVjpak5zG9F1V8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 63247d30-9d36-4f88-7eb4-08de083de5dc
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 20:45:07.8632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: daTgyXoK99mVavGrWxnQeQTwLvSXDmszdBp52YXYuilDEU4VVw7jNvxT6efg5SFVpgVi9kPqwjP/7GBAyywJfuwhON1Jl5SQpNPNpXsZ0k0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11561

This patch series greatly improve airoha snfi driver and fix a
number of serious bugs.

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
 * Add support of EN7523 SoC

Patched kernel tests:

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

Speed test of original driver (with patch to fix support of flashes
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

Changes v5:
 * reorder patches a bit
 * improve description of some patches
 * minor fixes & improvements

Changes v6:
 * do not fill with 0xff the whole write buffer, only areas not covered
   by user provided data are filled now.

Changes v7:
 * add EN7523 SoC support
 * add en7523 specific hack to avoid flash data damaging if UART_TX pin
   was short to ground during boot
 * add SNAND node to en7523.dtsi
 * update dt-bindings

Changes v8:
 * remove dt-bindings changes

Changes v9:
 * fix en7523.dtsi a bit (thanks to Rob Herring)

Mikhail Kshevetskiy (15):
  spi: airoha: return an error for continuous mode dirmap creation cases
  spi: airoha: remove unnecessary restriction length
  spi: airoha: add support of dual/quad wires spi modes to exec_op()
    handler
  spi: airoha: remove unnecessary switch to non-dma mode
  spi: airoha: switch back to non-dma mode in the case of error
  spi: airoha: fix reading/writing of flashes with more than one plane
    per lun
  spi: airoha: unify dirmap read/write code
  spi: airoha: support of dualio/quadio flash reading commands
  spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
  spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and
    REG_SPI_NFI_SECCUS_SIZE registers
  spi: airoha: set custom sector size equal to flash page size
  spi: airoha: avoid reading flash page settings from SNFI registers
    during driver startup
  spi: airoha: buffer must be 0xff-ed before writing
  spi: airoha-snfi: en7523: workaround flash damaging if UART_TXD was
    short to GND
  arm: dts: airoha: en7523: add SNAND node

 arch/arm/boot/dts/airoha/en7523.dtsi |  21 +
 drivers/spi/spi-airoha-snfi.c        | 551 +++++++++++++++------------
 2 files changed, 322 insertions(+), 250 deletions(-)

-- 
2.51.0


