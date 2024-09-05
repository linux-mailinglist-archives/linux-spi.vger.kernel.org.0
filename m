Return-Path: <linux-spi+bounces-4646-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F76996CC41
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 03:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 438252878C6
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 01:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE3416426;
	Thu,  5 Sep 2024 01:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kLNppWWR"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011033.outbound.protection.outlook.com [52.101.65.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C17F168B1;
	Thu,  5 Sep 2024 01:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725499584; cv=fail; b=RZ+G6sO9VeNL7NQdCgXbwNSzSZO2hxZRtoTdE75e+70cRiQj5yeX6eatwrVvJK5vbDK8lg14sXcfmb4aMDRLOBn0SVpkWQGmDHc0UAAbOQdRZ+KftbwrhspFMnr21FzBzIEq67dh6hqYqvBre1kt7L2ydHqD8Nrbbj8xhYWipIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725499584; c=relaxed/simple;
	bh=SEQuwJn8wkDmLzcjbdqFDyLAUaTL19L69U46AFcUJsg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vl5kjU0AuVFG2qzamf0UUCt3EIO864TD2xe8Qgg+Z/TxHckWXE0YBH8K2u4I8Fz22Y4pAtfdFuomdlBk3IY8im9KpQA+UGVZcGTmFjI6FPV4Ds4FZLEuxNA0xN9X50vH8ubrFxQSi9hhdr+Grzd+5ph5jfd31lp9Ssv+VlJMsyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kLNppWWR; arc=fail smtp.client-ip=52.101.65.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1uaZsgsBsI1TZfAwLeZBvo1GNWydcZwx7qZ1JD5U114+j6i9tmT4vtTjV73wwIsOio5y6m14PWIv6qp9F0+sM26nKiQvvWhdkekS0fD2/pkrKcTkElztU8xg4hnyIEW//uCL7NeKNOAHxzxg28Hf1mdnQ3z1GZ6dwR53yIYZdOUn1wg62eXtvlb0VnO2gVd8CeSwVwngNNaEZeA9258HpEPjFduZVTwnB7FHYk2eeAobexCV6bJSsML5L1IMpLmHwduw7hrhkq8dbRo6gq8k36dgksBOt0A3bmYWHHlkDgbKgNqjqNfcB3RZmuA91IAaBOS4mXJrjgdIHSFBqaQrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ymvq7PQ+p1dKhlinLG9w917VkG8Bpe4eeMRo9LuSZ9Y=;
 b=wKcWHjjri79RtbAlFUW5cQu+u/pu57ZvdJ3upG26BBjmOfB7Ctty5Jwm+Jb4luOq3g+moi0xWnST5KZAqqvfAiLEn1zavqaHUwAE0dT2qsH2t67kYAgMG0BAITGNC2rLPkhDOf4gCLrJRySFxumRKUL8eTCfHeX7wil8sUX0gIPaLPqS7fryklw/1MiHSGu/aqED+o4Tb+ryh3YThsc3T2sTCbl8GLksSygSHMqIFI9xYCUB4/6kfVOBtZ80sf5iEBEqIfj2yusDAl7nI5F9j9g4N8yBzese/YvNbCsoR7p5AG20FfxaStuvTJLKrQFp01/rlVH2M+Rlofi5H1bxhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ymvq7PQ+p1dKhlinLG9w917VkG8Bpe4eeMRo9LuSZ9Y=;
 b=kLNppWWRyUrFw3WSEROy1woLkqGJUPSqJ2QxRUGZq21OAyD+NNpHKtMUrTn30b9B2K20C8Cg9qd2+FUsdcgWLJ92lhudXcEDlG9k0+v2FB9ZHO/quEBVihiVwYdREcEkcZE++rpVztTHUopRs59f2fwNz+I9ln+b+07xRTBumUF6G13ckXtY+DglzDLX+r6O7lLBEiA4I7b9uWrK87Mury9ex5kZ51fRT7zGImWZq50mPQtcXzKU1oZ8GiVJnC9fbSa/S/JHg8L/WofJeoTXnmq3ls++4+hIPubv9hwfroQAB7zrSzl0idqhPl+OqzvXWZ+LMEhfbZXhTECTfULuyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DU4PR04MB10339.eurprd04.prod.outlook.com (2603:10a6:10:565::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26; Thu, 5 Sep
 2024 01:26:19 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 01:26:19 +0000
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
Subject: [PATCH v2 3/3] arm64: dts: imx8ulp: correct the flexspi compatible string
Date: Thu,  5 Sep 2024 09:26:17 +0800
Message-Id: <20240905012617.1864997-4-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905012617.1864997-1-haibo.chen@nxp.com>
References: <20240905012617.1864997-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|DU4PR04MB10339:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e20796-9d4d-4c54-5592-08dccd49be92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6945G2gJ/khF9ZbfPuMJ+5ljldUYK3zWpHWRtgGZkMmZ5/KYQI72I4JaTxe0?=
 =?us-ascii?Q?+dm2+hF7X6KQw5mrpdoLmscLWyzr4ohAet+0+WgRUXZN+naH6QEuNUoF0Pes?=
 =?us-ascii?Q?JIZox+zGhv+Ui1dCN12AGKex5o6qv1wisZ2ODZITuDMOyO7LK0C5HC+Bt5Hm?=
 =?us-ascii?Q?zZ3YTg1yMj412ACVdeZwssdD4ySvqKfv1vwnJY89ykEBda3LCQm1Jzgs6DVP?=
 =?us-ascii?Q?a/37UXhQsoM14YtK5dtKxa07+tSKgv6v1Z+A4LesHhN0ZUVpJ2q5S3XnGnLu?=
 =?us-ascii?Q?qnQinsa+Q9SbG6tNWJEUy02nwCAztcEmAFqoPsm//gZRb6eXewjSIYu2fI2A?=
 =?us-ascii?Q?l7epZ6yXiFtX/qb4dUw/aEVr5w6Zm33/2be6/2oSPXh8NesQlPilPkcWB4iJ?=
 =?us-ascii?Q?7Oab4MokUVIdgSvRLS5dYzFORYODl4go3PDBftCApJLIxVt3Gg/UDkUC1s2q?=
 =?us-ascii?Q?kTADHRKdlyakBatUkfaH+GGAfj39rhMpMkyZhn9PAiSQmoGzuqJM7vAIMznK?=
 =?us-ascii?Q?XGoiWP7bZFG7S9Vmf5zpQRvKZaMqNLyLCuQTDbEtkRVZiQCNhkp6W3XnYSG/?=
 =?us-ascii?Q?3asmF45njlDlxqXdETUOGeuztAwCScMGyuAs3nsxZaZCvSW8HLdcNJYl0Wtx?=
 =?us-ascii?Q?8tFLhANyd3Flxx8WBp8VE/nJdISSfIIryTRLAH013txwBO2JSomHw3Ka3z7x?=
 =?us-ascii?Q?doqhWmZ4lKWUtHVPnEzIp2uszaMdyd1hzg/r5a6pwKyYI4u3J62OZePQij9P?=
 =?us-ascii?Q?UV/i9fyM6QnmK7qbY6RxYYlUf4mapsECwZo4y6Xk6or3Sa6OI4OBEPZsLVLf?=
 =?us-ascii?Q?Lb6syHKonCxVqdvttlR3eZ3X2TyCXd/Zghq+tzMvBeDE+rkjDvFN1noH6UJY?=
 =?us-ascii?Q?T4X6Bq9SuLaQMbSfRO7X5KyY27JkJHzcTINHw67AXtwlEkCSJ+dpbsRW0G7j?=
 =?us-ascii?Q?PRcS08Av4efWl9CRdVhX9N4pWjZXACxPWj7nPMpCGqdtUb/A/UWuAnEzoDwW?=
 =?us-ascii?Q?jur9vDuPu0LD67bdxC0szNa2ynLBPhugl5xRxnCwI+Adh8vv5e6RmibPeNG3?=
 =?us-ascii?Q?xr43+A3VHG8VuizsJMYQ1yZX0/jVHB007jY+8aKcIc4VGmSYExGJCSQurnLS?=
 =?us-ascii?Q?TnJ03EknUAmG36dBKWodaKLEwvqi62sRhvTtzNsUtLw6U+KcFHCAef1fikLv?=
 =?us-ascii?Q?MZtHUjj3ekRX9qXSJY+2JuVHlhPwCFqCK+NwpBBqPkIzAmQk3Z0XcUuJosJc?=
 =?us-ascii?Q?/5U9HoYLZFJ/utQxmsL9WvMWB/1TojJyPoKeKlqkF4h2vsG1ZyAlJYs9fvYI?=
 =?us-ascii?Q?BrEh3KBfGSnsNPV5gONgTMK+h9HvniU+FiBDmwFC0B825qa/5zRyuw58Tmd/?=
 =?us-ascii?Q?Fd3RFxmoN6Judz6JZ+LVAK4JhaGhRJQbBfEaiSat/lHaZl4OZA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KWu0KDSYd2YCQ9gTCItyA3KlXPVgcEfnzZekV/bs7S5KSs2PcZ/YKKgdI0ks?=
 =?us-ascii?Q?1JgwCSyGp0C1Ah1dX7O7tgzPMYzB75herhjEGM6h9iylOX+FE4Sv+nvEOcBf?=
 =?us-ascii?Q?qDKVXMzhRANSwtQKGmmy7lthXvkieedqH/hi9jLK5bFW7cTBAj3zTLhAFEYJ?=
 =?us-ascii?Q?2v8tEFKQWMC5RVRwLgbom3gasRg0Wm19KYd8Dhyo4AbBoRHmleFmE2BAH2MW?=
 =?us-ascii?Q?G948SoV2LgYKZLpPF8KaxHLNkHNcHorZOtJvIXki28vqP/8fdGN7S2a1I/MD?=
 =?us-ascii?Q?Sh9LjT0QaOMkNfeOrOkeyIlXIjF2uNi64GiX2BPP1bbwv6v46FjW+SrOnQ+n?=
 =?us-ascii?Q?q/2qh0XpGwR7aeYrBDf10YFGRrwPDoR6CH7y9bLVye3hmiHi6pYX9pmQ7Us+?=
 =?us-ascii?Q?jTxoySHtpaScrE4UUasJNCwSj5FXOYqtZ3W+DEGaK5sGeiZP2apDnR1a5pVA?=
 =?us-ascii?Q?G0Lu36/istZ9Dp3tfhoBMVt+uQ+eRTI0bABt2OPKvv8Mnflh67nokM5Is1Yh?=
 =?us-ascii?Q?YazC68wE3hQtHKEnvPDrrxDyTE3tDPY6TOqvfoUUkO1Zq/XTEba6sItkgMhb?=
 =?us-ascii?Q?Fh/A9nql6twYgKqk9VBfhV4WII4+r4DSk/MkXCsZc97NIibo0t/I9F2eN8nc?=
 =?us-ascii?Q?OhMPiE4IocGU3yzty2ffGq0YV1CXi8vEXwgDFanxL6jrr/ryXA/MUUXrt4GC?=
 =?us-ascii?Q?xcR3MZ+h9G3gq+zDa73cYjXw62Bs/AT+VTCAGpNNrMGA+5Gg/2u/sQLASzId?=
 =?us-ascii?Q?+ovjkUOnFvcAUTX6qKnOputkBVY4XQR6LWGKgcYMKflMWt7ABP/HRISgKa3d?=
 =?us-ascii?Q?fvIiIwmwB+zWOHAD87s6kxypiU0ofpghcLzrVPXnmfwFrFyETp1UWGprjfB5?=
 =?us-ascii?Q?v4nVqO16nYRX6KMG4aQNLGRcyvjzzUJRzlgEsCuQQIbeLD7YPDLMhUCLVKlg?=
 =?us-ascii?Q?xHBEWmHE5HpS+ynXtT5EScLZhw/ttleBVIShSEVFkoj90ha7a4t/gWaC1Jc+?=
 =?us-ascii?Q?AeDQaqoI7LGLDyFGxz3tnxkXPkI7Xox2B8V9Pu4gNOBnmth0SG/lLCmtich7?=
 =?us-ascii?Q?Dan17vXg/4jwpZ4i4/nKRg/rp/J17+7fKK6t1DEKDDWvZD+PTpogDISHTxpl?=
 =?us-ascii?Q?7rxdbJIZy9gcamrMa8b1DC4mYRcF/bhbmp+nRRh3QTZUe28rjRwRfdNQiIH4?=
 =?us-ascii?Q?KUsFWQai73v9hn79+HigFo+S7j+Yna84qxmYBH+uyEqb9MumjGg4eX2PH3nd?=
 =?us-ascii?Q?YmAbbjdotA5tJZaAfjB/+iU5OCYFttZMIkU9cw+yglUP3nEVW1D2S9TblML6?=
 =?us-ascii?Q?O7pmvqajbSy1zHS0htXOZ8IejOLEAVV2TNVqSR/D6H3haqr+AQF3qNkgYjf5?=
 =?us-ascii?Q?VgqHHjCzaCaeKRBjHcQ+FPHfDYpmPcnFQnTYYcX/SCevaikI9x98SeqBD887?=
 =?us-ascii?Q?tMnnZfgV/GYuraDtqTkN8SDJwMZlmCQJ8I0d25P58bF57HEGcYboGRroqj6w?=
 =?us-ascii?Q?BvDi5MzMcNjGW+K+5wK/h6iKMJk/8lFfQb1He3W0cqrjcwj34yJ8/al07JtB?=
 =?us-ascii?Q?n0UxtOnTiXxJz2X1JyvAJ6miggEmdbJiJDLXrx8A?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e20796-9d4d-4c54-5592-08dccd49be92
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 01:26:19.5223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AilwsKwm9eSdwy2RYDax1oQsWsx3rG0fgLGRFioJLV8sgSD8NzfXLvGe93ijFMM6NQN7o5xJC3kWO2zfK8I3Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10339

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


