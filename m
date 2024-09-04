Return-Path: <linux-spi+bounces-4606-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6CB96BA3C
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 13:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6EE01F223D9
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 11:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B681D9343;
	Wed,  4 Sep 2024 11:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fVnt9H16"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344061D9347;
	Wed,  4 Sep 2024 11:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448698; cv=fail; b=keasQC/gHUEPytakJDIuAxXKNLLCVuIJRCMfYBws1Qx983e3J9HO/SReOnLVNQhp6GQ7oSeS1cykGsaWGwBDlbX3S3SM2dYdw/R9AoJoVsUwL2C5feqr0uwXk+B7IZ0Q4M/uVayETMkrDQjW/unNhqqq47vxwOvi7ZUZSqV5JL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448698; c=relaxed/simple;
	bh=SEQuwJn8wkDmLzcjbdqFDyLAUaTL19L69U46AFcUJsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mb22C43Dxp5L996fsFBuh+RvQAs+bLJdMk/VqTtPArCYHutNYjys15M2aBhkV4mJ0J7D9ZYc5Fs4zdUZaRXTRCNGTQLJognptAHQn/FXi1nCBNjANs3EHG1G2pMOm39GQiBYbvuPPrZUlE27gDOmzNQs5acG2+qP6hAhsZbT2og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fVnt9H16; arc=fail smtp.client-ip=40.107.20.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bExbs9Gm58XYB8vMJwopGyZxqtn+KMMdYvvnrkEhYUNiBnYQZ+GLQnp6oh+hC0FpIMCbn1XNm9agHlOs2l1Wy/LLBphZGqegynsU+7OSdzglTIwH9O0X/bxpYO3j5Ql+qjhPTCEo5nrCunzOz4i9KUiJmzHfpJot6G5p4jxWSYfUZSEDPdfzjrU6hs9uApkOMV5zi50SCdWvmco3eR7JnCh40Lr1uUlmhSleYdE6c9UCKRe14gFKFsiqNOBWSbVZ0NBG9Tp0/tMADVqN+/b3xpydeBhk20gal1dEQ/V0NWduB+I2HoJ8UEJfhHrAh05Qi0dCNZCJ2mD8+KALWdTfqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ymvq7PQ+p1dKhlinLG9w917VkG8Bpe4eeMRo9LuSZ9Y=;
 b=hGXBmPGIrJ0WPH1aeywXtmxknaBiq38/qJKtyeA2JNqdpU4TlO8RhIrh3KWOcyz2UX8Ow63OScSXc6p/n6mbIyBROuGjmjzDHdoxAYv6i2x+FXWtNLz11e+4rSim0Ve49w9dKtMDFWw0/rKipcRIsCvZh8xLZWvS7ZjhE0BBA8pQF8KIanl7NuKJj2YZ5uIBs5+32s7oJgw6eXsIA8nBy68jCRRdDeyc1V8u25gv3hNOgNuyIDHp0mcAunGkcob/BUJnebOCyinmfSd5s//yLHWE7zExxK9gtfg0g9fBSewhMv/NFoYFExVF3EoxhzaGaID0MR59nnx5mZdItlgA8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ymvq7PQ+p1dKhlinLG9w917VkG8Bpe4eeMRo9LuSZ9Y=;
 b=fVnt9H16or1Y669lep35fU0CXkNCvQnPnHiYNx1EYaCY2cEnHFT6Mab2jM1bsauX9+73UQvRTKEeBCm4TyJ+aygiOshAjhrQFtnv8BSr4CqYR6KjyvVq679GOkchXIb+tPUchgdOw5O+XqKo758CNrxwYA6FmmZUuvaEEo3QAlvRUSJDhulxLuTNDWRy2EBtdJapt/DdX3R1xCqFqhVZ2BOyDLbedmBWXCbpVW0MU6DJHxF8i3BjOhC340UKX6B3JQ4qYmmOAWbwpvsyQ4bBo+bxPVWCeMAEMCoYoSVS/L9paRlWQO5HXRkeDoiVZFuF9YNnDN0BwSrHHnXuh2hsGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PAXPR04MB8831.eurprd04.prod.outlook.com (2603:10a6:102:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 11:18:13 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.7918.020; Wed, 4 Sep 2024
 11:18:13 +0000
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
Subject: [PATCH 6/6] arm64: dts: imx8ulp: correct the flexspi compatible string
Date: Wed,  4 Sep 2024 19:17:27 +0800
Message-Id: <20240904111727.1834935-7-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904111727.1834935-1-haibo.chen@nxp.com>
References: <20240904111727.1834935-1-haibo.chen@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PAXPR04MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: eb5b5733-f705-4dbe-138c-08dcccd34394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/+9SFgFnMknoDbKFDULDk8oCH+Gs6W35IXojpAOKx96G2DNCNp+c6/vLQve1?=
 =?us-ascii?Q?Zzcnsu3YNzPULF2ehupf9HFIRYZkKTvCtqYye7M2YVhkY2Aa0b+IrLhXGCLM?=
 =?us-ascii?Q?OS6P+Ftm/MwbYL8D4fZkAIZSzZKTgBSLv27l0Hf9hJL68VAF3ezxu5kjOWNQ?=
 =?us-ascii?Q?rfh3E/QPpn5mDgbJsFW89RfaaAXBYwaEp5Q0UjQoWJjWuBW7tlyLzw6oOkPZ?=
 =?us-ascii?Q?lxtFrAlBgpwovSAPiXKrSyW5fIs8/C0S+/8cd/64sWqcX51jApcBU60dpT4m?=
 =?us-ascii?Q?Bmg3fT98Inhvre3nHWoqnj2Gn698W52BEVEcluGnLgT4bdxFQihOgMPD/T1m?=
 =?us-ascii?Q?ADUqFomko4661AV8FUf+0DhEf8nD8MX2jHMzfY3iHmucqEIhuaW5CbMvlPjn?=
 =?us-ascii?Q?FtAtKmARIyBR8ebbiPpYxrRcI4hYbppYAcKrnu+/U4HMDbFFv469nVvvlewU?=
 =?us-ascii?Q?XWI0r4dzIOW4P6TFIzeKar70WiZljjdf4fQyRhdeEQtwKvLl668aZzJwlC/X?=
 =?us-ascii?Q?gLIQFpguiRjmkbYa7xegAeicWi1JAo9OX3VN9NVcfvFffeC9dNuq1FY2ebGk?=
 =?us-ascii?Q?vVrEaWxRsq+8szivucf0skQiRvdcYcyFF8XNMuujjvXqknClhAbz2Xv1cJta?=
 =?us-ascii?Q?PFuvW2jDcgi+9GHoz9NMeps7+0jnAqII4JnajEuFDf76XAAhxQehptJd0q4L?=
 =?us-ascii?Q?qUjArEocmYVmBekk34L2Uo+wXFeHXQEutITzCIKBMeGhOWXHJ77S5izdTkBE?=
 =?us-ascii?Q?smqn9cn5ePOPzEgCGKNvhdYgPVOXszjFkJTXM2YiLDi7s9bv4uk/48zwp/PA?=
 =?us-ascii?Q?VmquqeFvXLoT1zI/tyzf/AXXIZsOszL3+t547r1gSBRcrtJ63NZI6rdoOWMU?=
 =?us-ascii?Q?CnWl3Ad71hvqvdp/G7qtjwt6NMNv7bLiwVpyemB+AsEEd2Dtxz9Fd+cTXgxR?=
 =?us-ascii?Q?MjDESq5FAoaudxINKFSlUPc9hB9e7LA5CG16AlydgmSriCQxTIuZq2+s8WlO?=
 =?us-ascii?Q?sBYu7Z/5qBjE0Urc5xNeoMi/RWS8+m3dBSIVz7d8OXAkgBB/MlsMOblLoVTO?=
 =?us-ascii?Q?9wizLMnXIn86H16Ov4Iyyk9FyyjWtE1VHOTp/kLXJV/LVkvyLKc+hK/N6pZj?=
 =?us-ascii?Q?29GoVhdU4/K/aCNps1NOYTaVJLG2MMPvoJGW1JRT/iTb+C/e/FJ2hWW8N1ys?=
 =?us-ascii?Q?dDM4ZUUXVOnNc7BeR1X/ny3YqxGM38NyhxP4Q5xVCvUHrJU6R6n2KyynHC2u?=
 =?us-ascii?Q?5H7AlRCukDXkOuRyjNI6eib0IHNzL0vEHDyV/9PlaO05z4IS1A6CGpEUKMel?=
 =?us-ascii?Q?KN6mv+su4BAcUDKWu5oVbS/xIVyFTWyNCG5Sujwyvvds77K6xoM4lChMFpKn?=
 =?us-ascii?Q?WwSB4piZFhK32UGCxdv67qMTQ/wftzgNctJsb0qA5z9KLl0oNA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BMoBv8Tr0zso6ItGSUECKuRwrBA2DGv0FBBbjwtl6UT7kvAfeiI7WMjAyRXd?=
 =?us-ascii?Q?YKHqY6axZwagvpvlKBKnz51ZVO1OKOGettiIVDAWIvSlDZTh9QGQMcrIOcad?=
 =?us-ascii?Q?rKhAIfdo5M92qGwbp6mTb2/Hhol+em4NoolmyPDKrNGo2lOD3Hxkc5GfDVTe?=
 =?us-ascii?Q?RSNr8Ig8FX/PTXqUPTs+uohQQ5s5eL2A9PTZfzrhOSXNZp1kOwrDB9mmMQSu?=
 =?us-ascii?Q?CnOwU5pUVp0i9Tn0FX3MgHXu9br3aWzL3E8t2er5gdysaWjCryiBYdoJ65oD?=
 =?us-ascii?Q?q3Di5uiHZkYwUtslf3q2AL7A579KIC+6SjgYN1vJu/3+drQligoYD3fWhVuj?=
 =?us-ascii?Q?HoyhfxwKEFrzkpJhYY204Agb1ySWrYpNjpyYkZTe5V4XOcB/IEShfb8FhffF?=
 =?us-ascii?Q?hJmkmFk/n5vrUCozhaqd+4NyQ0T0RWmtD79qz6pi6/v5S5/AcIJOtQtLryPD?=
 =?us-ascii?Q?1+nwAlmaUnwywL1fI11r4HCdmevSea7louChKkgkZ8VeVcCOqvLZ0xHfAmAY?=
 =?us-ascii?Q?p6NhbexdprwrgFkAZzQUR0e4f4qzMb80f/+2BqiLhh9dCviE5nFyFn3jKbND?=
 =?us-ascii?Q?X9/AyfGPNL3W4tMTnXRRizMPFNUJ9+bMzG784zZ9wfG8ActfcvQ09Av/WqdU?=
 =?us-ascii?Q?1tX59ZxbYbsvti2wDDsSh7LHwVswXAEiLGdJYu1B+nILHeO05m5syRr23zaN?=
 =?us-ascii?Q?6JOmH5Gk7BsPaRThNsJyyjQLFnBtl8M0BBhowEFGHJ/zfTgjoOeZOn9nAVjn?=
 =?us-ascii?Q?LRrKE7wYq7MrLA5/lib65oGyIC5dZnZgrsI8pVpRY3QQJc/PTgY5O4851qnP?=
 =?us-ascii?Q?wq5NEpSVkg/jqs5KN2aVNmCR6+m8EL93UnIKIRYZsxm3nCv2H3tjZcPRry4+?=
 =?us-ascii?Q?1YC/9hSQVo5iKiscf/NNeOHXQHgXpTrHwFteul/14CBpwr6TRav3yUPErwDM?=
 =?us-ascii?Q?HTw5hEEx2lI0aARRAgUBovoqzdA3xsu7RWPY+8RJ3ilIdeIP6LmROuamC0OD?=
 =?us-ascii?Q?H1nU6T+lISh2G2DOJnSPsi0o1b1janDWHpzpoQU0w8ixENP9EebCtKBCWkXW?=
 =?us-ascii?Q?XmC16c0Jz/9BhanhiWbxTIlgTHqrF8zhvyYMOQp6L9Qe7W6ypmliTWMvwIbQ?=
 =?us-ascii?Q?ayQ5UdbsuuR9q3YjJ9HGJF8km5Og8D9T5kvRbuP8LQfrForwWHhtGDkTO2Po?=
 =?us-ascii?Q?UwiJcEJjXIM8zWcd8ThiUaxy+kj1BiqLUp7ihMaN4EDYTRtCcMES3wSqQrK7?=
 =?us-ascii?Q?nCgOPAJBvgDvaoD9B73AdqxZmWlQimYhIpvHKov2i8GaHOGxDuTSwzR8w0Y0?=
 =?us-ascii?Q?2Z62BZLFVxh0cEDpZG2TlnGis74vJcj0ub/RKJZQULz6cVDBWUx6oUljhJAS?=
 =?us-ascii?Q?inwrF1vCr/8+QcaFMayLQyucbkK5P7sAEoL3ncFaCA4aEzRxE+F477nNNbKb?=
 =?us-ascii?Q?gsG9qg4xKmfzzBENdeyZHEkN6E15U9PfCZ4F053vtKSF3cpOK+U4sndJl/Hl?=
 =?us-ascii?Q?1HoLrnIY//25QXkRz8VcT0oszYuaAdL0RcCcsRmvMbSO1M2BT80c22nBW4D6?=
 =?us-ascii?Q?NevTcB85JOkpN/9VtJNUFDCnKtNs+spBbty8JjGA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5b5733-f705-4dbe-138c-08dcccd34394
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 11:18:13.0190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VPqc+wjJy+Rhoh4dIgnMDle/xZCgw3JZIWJ7cMH3o7JEN+8DX97nHgNvMisqk6nVBdKIGayNrvOiKJoZO9MSLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8831

From: Haibo Chen <haibo.chen@nxp.com>

The flexspi on imx8ulp only has 16 LUTs, and imx8mm flexspi has
32 LUTs, so correct the compatible string here, otherwise will
meet below error:

[    1.119072] ------------[ cut here ]------------
[    1.123926] WARNING: CPU: 0 PID: 1 at drivers/spi/spi-nxp-fspi.c:855 nxp_fspi_exec_op+0xb04/0xb64
[    1.133239] Modules linked in:
[    1.136448] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc6-next-20240902-00001-g131bf9439dd9 #69
[    1.146821] Hardware name: NXP i.MX8ULP EVK (DT)
[    1.151647] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    1.158931] pc : nxp_fspi_exec_op+0xb04/0xb64
[    1.163496] lr : nxp_fspi_exec_op+0xa34/0xb64
[    1.168060] sp : ffff80008002b2a0
[    1.171526] x29: ffff80008002b2d0 x28: 0000000000000000 x27: 0000000000000000
[    1.179002] x26: ffff2eb645542580 x25: ffff800080610014 x24: ffff800080610000
[    1.186480] x23: ffff2eb645548080 x22: 0000000000000006 x21: ffff2eb6455425e0
[    1.193956] x20: 0000000000000000 x19: ffff80008002b5e0 x18: ffffffffffffffff
[    1.201432] x17: ffff2eb644467508 x16: 0000000000000138 x15: 0000000000000002
[    1.208907] x14: 0000000000000000 x13: ffff2eb6400d8080 x12: 00000000ffffff00
[    1.216378] x11: 0000000000000000 x10: ffff2eb6400d8080 x9 : ffff2eb697adca80
[    1.223850] x8 : ffff2eb697ad3cc0 x7 : 0000000100000000 x6 : 0000000000000001
[    1.231324] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 00000000000007a6
[    1.238795] x2 : 0000000000000000 x1 : 00000000000001ce x0 : 00000000ffffff92
[    1.246267] Call trace:
[    1.248824]  nxp_fspi_exec_op+0xb04/0xb64
[    1.253031]  spi_mem_exec_op+0x3a0/0x430
[    1.257139]  spi_nor_read_id+0x80/0xcc
[    1.261065]  spi_nor_scan+0x1ec/0xf10
[    1.264901]  spi_nor_probe+0x108/0x2fc
[    1.268828]  spi_mem_probe+0x6c/0xbc
[    1.272574]  spi_probe+0x84/0xe4
[    1.275958]  really_probe+0xbc/0x29c
[    1.279713]  __driver_probe_device+0x78/0x12c
[    1.284277]  driver_probe_device+0xd8/0x15c
[    1.288660]  __device_attach_driver+0xb8/0x134
[    1.293316]  bus_for_each_drv+0x88/0xe8
[    1.297337]  __device_attach+0xa0/0x190
[    1.301353]  device_initial_probe+0x14/0x20
[    1.305734]  bus_probe_device+0xac/0xb0
[    1.309752]  device_add+0x5d0/0x790
[    1.313408]  __spi_add_device+0x134/0x204
[    1.317606]  of_register_spi_device+0x3b4/0x590
[    1.322348]  spi_register_controller+0x47c/0x754
[    1.327181]  devm_spi_register_controller+0x4c/0xa4
[    1.332289]  nxp_fspi_probe+0x1cc/0x2b0
[    1.336307]  platform_probe+0x68/0xc4
[    1.340145]  really_probe+0xbc/0x29c
[    1.343893]  __driver_probe_device+0x78/0x12c
[    1.348457]  driver_probe_device+0xd8/0x15c
[    1.352838]  __driver_attach+0x90/0x19c
[    1.356857]  bus_for_each_dev+0x7c/0xdc
[    1.360877]  driver_attach+0x24/0x30
[    1.364624]  bus_add_driver+0xe4/0x208
[    1.368552]  driver_register+0x5c/0x124
[    1.372573]  __platform_driver_register+0x28/0x34
[    1.377497]  nxp_fspi_driver_init+0x1c/0x28
[    1.381888]  do_one_initcall+0x80/0x1c8
[    1.385908]  kernel_init_freeable+0x1c4/0x28c
[    1.390472]  kernel_init+0x20/0x1d8
[    1.394138]  ret_from_fork+0x10/0x20
[    1.397885] ---[ end trace 0000000000000000 ]---
[    1.407908] ------------[ cut here ]------------

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index e32d5afcf4a9..43f543768444 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -384,7 +384,7 @@ pcc4: clock-controller@29800000 {
 			};
 
 			flexspi2: spi@29810000 {
-				compatible = "nxp,imx8mm-fspi";
+				compatible = "nxp,imx8ulp-fspi";
 				reg = <0x29810000 0x10000>, <0x60000000 0x10000000>;
 				reg-names = "fspi_base", "fspi_mmap";
 				#address-cells = <1>;
-- 
2.34.1


