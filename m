Return-Path: <linux-spi+bounces-4662-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6433896D3CE
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 11:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1CCEB2677C
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 09:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D151519754A;
	Thu,  5 Sep 2024 09:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dMYKvCbT"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011039.outbound.protection.outlook.com [52.101.65.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FF01991DB;
	Thu,  5 Sep 2024 09:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529518; cv=fail; b=fBCBkHO8GgPzoE+ZUW7i9wCsdZKaWG7Uurygok43FJ4+xUTqPqFnNmJ4KS04eexkivqc/jwFX+d4gf43+jBN1pyGM3jedPegV0RATh4lDjKh6xIQd5JKP0FtUdFy0rkaqVdcH0wEKnBePtS6fqkoH1J1dVk3AN4EhtwSKBY4+kQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529518; c=relaxed/simple;
	bh=3iA06v5/dHoH6EeEPdup6zwcFIvyN4NsZ1SH2syH6BQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ESa0NZ/jqxVQighFAa1gClIwZSfwFnwNjxML8aNNrN/aJD9uZOkXAFgsjNhEDGCTxM52OVLIEv0hAzls5XEu6y/lcuPI0ni6s0/KiND57kfRu8PdKGv1OhaijJrajcJn2fwcjCBtrxD3uPCLkIsYctuXICHP2Bhc8QLAqiijuJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dMYKvCbT; arc=fail smtp.client-ip=52.101.65.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=belSZeAe7dgXC1HbAOxiy4c9mJMGuOzx68Ud19qq3f9ySkqWtZo8Ok2zqoTS/I2GCSJOTFdHRvSc5F6dpnE3Rd2AFusp6e3tSSb0/BgC5M9jwV944UJMihPQAPBRL0bYFGleeWvja2LW4+JF+IB7RY/LE3h8xoz8WCWH0uIFDiLJr2E8PwUqshB8arsbhXxOsfWr1TCIhx2eDK0eVYXkzU4kM1aIEXQcDmtJEaFxBXlFi5+WCGfJd9ZxKVDLdQsgG5P0Xu+OKDbYD3dc3N2N36XPR5zy2bncImfcV/BBt6FD/YRXGDfnP908oLyQcjj5AICgC2tWF/MLRHysTUSN3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBIt1Za1kBEnq68eNm7JrLgbI+uKSuTodZCxEFcCF2s=;
 b=tcnGJIf2MgZoeQuEPdqEdGFenEVYZQY98XA4rg5AbH6FmdWCy0dBg3Agj547vZqTMlMdQAML3A4lsC8sRniUhbUCM48HGDT4if10c7xrTT6hpp0QaPJgoweEw0uj86nnW2rpEKP/TWon7zssSwjnwn2Is+dDy3O71bR4G6WaPUCsWpwPlFn7a/xPGGXn+rpXTZfiY1b5Gku3N5TTEJhtJ74U+EH+WJcDPWTKHpmorwhxzurhCU71BWYqeJ8bla8loolGDnCN1Mn24tfq8GgGyQtDeeDqF4Vukk2LrYeHMd7w9XMD1rP6d8Yf79mZhV5m3jK2mdTFZS5gbyWEG9FomQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBIt1Za1kBEnq68eNm7JrLgbI+uKSuTodZCxEFcCF2s=;
 b=dMYKvCbTiyQKtvuvwiZ0P14TmpvFuNSnwo1S3CHZ6sidGFSK8GBqd52gIqkjb5t7TD8XGSLmeivEBtIM48Q96C6qU/iaNt725cmrZw5uUiYGGLKO1HPM2DN/aEk4o1jeTug8+1/owCZm1bKeSoUA4a6Ed+uzOEBhFfPRUqwMsy+ScDZ327T+iW9IzKCfv5hCMihj6DXBZh5QOcZluKV/0pxIrSEmIgcPCzjIGvXMK11cNSASutioCRPG2zqLJ8O14x5UZBXw4c8VwP/CHn/5bXYEVjniwG5lIEaliyI5HLilfDPIEFx5dVurmUMA534TIVu7De0GA37ud1fRc3IzfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by GV1PR04MB10306.eurprd04.prod.outlook.com (2603:10a6:150:1c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 09:45:14 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 09:45:14 +0000
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
	haibo.chen@nxp.com,
	peng.fan@nxp.com,
	stable@kernel.org
Subject: [PATCH v3 4/4] arm64: dts: imx8ulp: correct the flexspi compatible string
Date: Thu,  5 Sep 2024 17:43:38 +0800
Message-Id: <20240905094338.1986871-5-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905094338.1986871-1-haibo.chen@nxp.com>
References: <20240905094338.1986871-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|GV1PR04MB10306:EE_
X-MS-Office365-Filtering-Correlation-Id: cd387213-8482-41ba-f8df-08dccd8f70e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nfxfPudGxsUoS8wz7K+Lna2PujXOzijv8u3ljRw0MQkYzU1KH4gPwoxbcg2L?=
 =?us-ascii?Q?Vw7bupLww0CUeQnINyOjJbDSjT1mmXC1cOsC/iIO1xghgs4w8Zpas8tBg02t?=
 =?us-ascii?Q?CvYZH8K/+RYbl8vpVRxYbPrEviAA009wnOhIFxstD/4lI9JvCDgTi63p0WnR?=
 =?us-ascii?Q?EGiBZurZfDaExKIgTz6KNWM9JCw48WjfzweovAPBUQvliU0pYePRFfTvawBE?=
 =?us-ascii?Q?cbC6gFzr+mnnmkAAb2hrCj7apABu9G/0bdU25jNFFCr/VUwPZZcAVnVhwy7C?=
 =?us-ascii?Q?FSQIH49UGVuZ51Z30pGG+k0Ti/cYZ6i+oiJ2lMxNPLyXwy/IaoC2mJtWbBGP?=
 =?us-ascii?Q?FjLJOQBl5GQxCwZAkqbhjF6YS7vZwwX59anOFiNzbvVxVsyURA/mI1JJrH3h?=
 =?us-ascii?Q?UM2pixRXeK//eCEoh2hWmxPsDm+H6axyH10F035xWIucHKMceWiLNN9PxmvH?=
 =?us-ascii?Q?A0fIqyCi8yWTePsgBrRYwxo1TtH4Mfx2tIzLc8RP018xjWjZ1XV6QWWnMeR+?=
 =?us-ascii?Q?J4BbN/+kUsr7iLu1gls4vye8nKOc3C2lG6btX+RjApLrNmAHk7SmT1mMkOdC?=
 =?us-ascii?Q?rZpLFohpYtKjkYzeSuYSGP2tFQxUqI+cpP70rdf+ldpQCVShM82QaEFOiijg?=
 =?us-ascii?Q?pRXCPxDIjlavlxV6HrWQ8Wa3A/Z2Se6W2iCUa2QpENndmOxsxbvVPGis5mAs?=
 =?us-ascii?Q?sBi9m1CuoY2ajKYu4DUVtb+PtmtKoK3oFQI6pLD7symTyUmckdgtJPDfOWkd?=
 =?us-ascii?Q?scveuhwMcNMXcXVfAkpo1ex0LvV6lNzT8aOr0c+tRHxaWzmuPr/RjCMJE4Is?=
 =?us-ascii?Q?ipbWqHvU3cvRhLIl7w4GHTrQ0dr1YXJ0EZa29r+PY85XIWCupR+f40QUoenH?=
 =?us-ascii?Q?CvTfxO2xfM9l+DrV/07a3pHDTYNkWOeZbAM2D/L+oollJWIM6+uajcQtKea5?=
 =?us-ascii?Q?3CfFLiXFzD9AH8rPA/iNVcR24Q9Paex521JCNwcrtmAxN1rFsliepxpGsgp8?=
 =?us-ascii?Q?4cedoMa0uzXgmH6W0WU8moI0gZPal+9QPaQN5FZmPqcWo0mKt5VFyi/MHppO?=
 =?us-ascii?Q?Csh59/XrE8sv+q0PyORv0sv4HbtDkdXvVMMbpqCGW4a/lI6xhmm1xnbHeERJ?=
 =?us-ascii?Q?74LgFvv81pEk616vB7IgDxMWNSV+pXEKDvJriIq57wg3BT70a4s/hbApASia?=
 =?us-ascii?Q?P6hxogW45NRkFrRN62qSGu4L2g9BkdtA5vrCYRm/QUQ1Sub30gUIFjNf2l5q?=
 =?us-ascii?Q?4E8BRkOADYlqINKDRU5gpFEGeWTRfNUMi6ocb+ss9DqNy8ognbnTD5/yUQNW?=
 =?us-ascii?Q?WmhTPxnUkz/4p8MSxM9CMGGSbMLnDyz57pMs6fkvOIk9LzTGRT9Kvke8+IGc?=
 =?us-ascii?Q?/nmrdQUjZ3Cmv1iBg2YfzPjNApebOCyfvKpj2uxD5WWNImdIfw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aVat3Dzxk54oz8SW0uXqE5sL+mY3mfyNvDiD8+7mkO13KsnlvlRTsErJ99li?=
 =?us-ascii?Q?Z9beOAfFnfoK5CtVva2bjuvdm+cUSdhdEY/uz75riZdGO5eaNtXXQM3qESMX?=
 =?us-ascii?Q?jr0TIOwNYEA0KnYOF59kxMUslkpp4i7M4Bhwjp13a5HuVUl78RuJ1Fkrt0mc?=
 =?us-ascii?Q?W/8cVZ+N56Yp2DyaR9uM/7rMWnFpNmLXyyJJkAOLDXlIPlUPzZ4DVUkP9pmj?=
 =?us-ascii?Q?EosrbHczRGmwaEKzwv/K5dQpsUTN7tTqIuQZRjqmad20hajKcWe4zIY1nHot?=
 =?us-ascii?Q?j5kx9SFq3Yb134iwmenNMG9ARDXDLJhHQO2QrrCseLp+XXwDc5IMLNDOZlGp?=
 =?us-ascii?Q?f0YdttnSs2rIR+JVioeZygBCxiJSzNqq1HzIjkB9o4SPIDwPU4Jw/Ph7REQ/?=
 =?us-ascii?Q?7BBIK5Sz93WyZvFs6rY423qsWwPdL0YbMYCz4CI8fD0WmGXpBX3XHO9pqIQ2?=
 =?us-ascii?Q?InUPgcgYK67z2FeP6baXhnjpDEZzrLHRfcddqM36oWud1L7H9F3k42war9wU?=
 =?us-ascii?Q?C861kMUEg+KGcMJDjAhu/kRl7YmBRyPpmKxbbDhGLw9m/Ll5IuJuZOwbvu6f?=
 =?us-ascii?Q?Uqe78y29vHrUY8xLShl/nXcBHrwD19sKikEfMv3/mONfY2eOXnhL25EWeo+7?=
 =?us-ascii?Q?Ta3HI56q5wgZGo6aT8hr98BoHLYSSn1Fneh9U5QjC6mqiMJEao1HCRr6OJAG?=
 =?us-ascii?Q?RI5bRTlAvgCcPsCFMRUPU5zO42cS9G8jBj2mVxncSEHoARhGMB4hla9AK638?=
 =?us-ascii?Q?s3ioJhzQ3OVEX8RYWMh8SQEIDkDsEyMAeiVbMGlZlMfaW9qC9YGAmY7D5+lY?=
 =?us-ascii?Q?fdVPOwVplWzTXL0oFIf9ZhWbxA5Nu7QS1/LRXcaavS8gcWOOCbHMNWK7ZYi4?=
 =?us-ascii?Q?dGUu8PBSA+TbSwvhRrZGHNAq2cRYT4LGtzGTnrLr2xpQQ9oK3j13Y2quZNzt?=
 =?us-ascii?Q?4NmY1dVnrUGYvSv5ufkOlVVqxPdSFmcJS8tsWy/Rfan6L9ayO+Dp3etIE9Ul?=
 =?us-ascii?Q?0VqdyOlIXfE5YQlTmnCyC1BZOOFyPTvFEd8/WtbOAP2Zyn6ADIFSlUjK3JjE?=
 =?us-ascii?Q?epFmo9zeO3xaeEbsuXHeXmJZc5sMcy7KUHSy2cBJI0b050GigfKlS+8oktgP?=
 =?us-ascii?Q?werPV7qIFEz0y0VDpdxn855bmh1FBrelagt8kg4396EIPjg59X2tPDKvEiNR?=
 =?us-ascii?Q?V0gMQPGqmvT5p3fxJpc/m55H9L7f6VBMsPOk0le0yBk2IqPKQnLpuZtN4VIw?=
 =?us-ascii?Q?tV6xvaReL5fR0sbsiEAFSwEws2SMiVWL+37EoJKzAuLpRRhWGbcHUiyC4Qxv?=
 =?us-ascii?Q?6+8x7o6PNk1QxiU/KKlqa5SmvlhCPENSReYuVFF6RygFNB0PR8yZ+bvtvaqB?=
 =?us-ascii?Q?cMCnHlkKSuL7oVCTMKUTQFRlq4ZsPmR3egyjuhkIpYQxnE7LyIL0f9ATcah3?=
 =?us-ascii?Q?JUciLd8nRfbxS09enOXjKoVux0IzFPvbgOKehWZ8q4qx3wzBKWWOBcJxviPz?=
 =?us-ascii?Q?BtMyOyvbuppO9yeO57OuzhkYOd67XvrdqTQttmxWdsvCLua/bxzImLB9o5Rr?=
 =?us-ascii?Q?p2h+eb4jUFqRtmzC1vYmpO+UVH1JHp0PBIZnoAjg?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd387213-8482-41ba-f8df-08dccd8f70e7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 09:45:13.9868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LEV3DP0Ax+iTwajvkX10yK0/+XurJ61a8up/3cCl5ydQu/WYwMBmhK+MIn1Wf1URM2YrTcUx/taAsqEXvbaB0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10306

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

Fixes: ef89fd56bdfc ("arm64: dts: imx8ulp: add flexspi node")
Cc: stable@kernel.org
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


