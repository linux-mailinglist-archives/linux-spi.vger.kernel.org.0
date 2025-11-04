Return-Path: <linux-spi+bounces-10998-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C7DC3285F
	for <lists+linux-spi@lfdr.de>; Tue, 04 Nov 2025 19:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D6254E04DC
	for <lists+linux-spi@lfdr.de>; Tue,  4 Nov 2025 18:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B313433DEC2;
	Tue,  4 Nov 2025 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JE20FR5T"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013069.outbound.protection.outlook.com [40.107.162.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7891C33BBA0;
	Tue,  4 Nov 2025 18:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279732; cv=fail; b=ioiB6Q40MLLwQEFSlFHrR1MSf9pjxxwvskXwnAWe4mxa3hFO18IzFX1C9HKlQOKHPsbL8UM0sc+3g5XrQcAB78+UEVNgYssrt3cDCu947IjzYGyUDZyrQO0Em1xeOXpz5OHpK19G32RXbC3HOZKkmGD4SQU5kwmG3wsZ5h7DKDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279732; c=relaxed/simple;
	bh=ITt5VxS5zN8a3wDcYW8zHFmt1up22wMsMgLg5cyCOQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Je6q5jt1ZmywXSTzumKN06cymJ/5gs+Reypk/FZdynncc5omigRx5s5Wz+L95kMfySSwoghCe25peA4lhbGo7n/LLw8KK0EwwBbMCD16y4/Xyodp9NZX4Pz1pc4cWMD2qsE8Rm6yiYcvsnahYCDJE39AD86DchnHXgKQUUSe3nA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JE20FR5T; arc=fail smtp.client-ip=40.107.162.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LduRd13cfnYcoG10EyKzdnSLMUOmrjsRLhUVJr+SFHj8ZsQFDpJmFfEAsVRbtNDTfL/9ieKzRGbJgKxJQa5V+8HMCSqFCf9ZvqgJZXxXkNJ/oxUG7SrTuO2PB5EWPUTte48YjvzP5l/doEE5fe1hZOwZEEkyQUkvwAMVi39Vwel+34vFMBL1FM+lzfG4UdNk1lBtMKQAQ8g6KThUyDFm4kVJanWxw89QnXNOhb9S/5CaxoXCsr25WEab0zXAWqIvWHGbfMwFxICNZLt5ie8Y6+sB2bDaOeC3/XpcD9JL18U0EYqhxFqOnk2y+tBw1iRkn9tZelBintVlvq2FK+VjQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apqb1imuz4WoWiGRn3ZSbeOY6Frsap5EG+9VotIGkrM=;
 b=GARQlhDrVQzQjjMd8I61i5cYd2a9Q6UhfUHtqdOP652AyOEe8Yy6oMuBIZQuPTR9qPuruSeTuTaIuEhUsthhwZEaIQqg6/5RkL92oCvKbo4c2d47eSa6vwD+kyKYW8liXTTB5OP4ChTcdVlrzxJz8aSPXe2CrHNKYcmoJAxo/4ClL0qPqB4I2qeOcytugsWLHD4+fOHfY2DKvZ7I7YlOZUGXzhTt4xu7YT3GIC9EKxcKpwFAVN0n5tVvxpcV8cp7uJwMiB7u4TEExOKesjqtpmzYzhUezMbmJ1sEGx7iNciZ+hoPqh6Gzxdkuk4lJ/aUr+uc7DxSY6Mw2g1/EiP6kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apqb1imuz4WoWiGRn3ZSbeOY6Frsap5EG+9VotIGkrM=;
 b=JE20FR5TaPjHEgvv14wtmiMwbmmiNaBklLLcSEtFgZUXpg/NnmOoYzVVWUmjJqeWvW8tufD3q3MIf/xnJxxreQ181cSHogEsmJqJHJtzqXKD+1Zc4sQ/lt9YSoxcHX+ZGvabHh04vFns5RmJVZCoYd+7mniK0U/1+T2vFYfjYe1APJGRsGdrtnny7exhTVHv5njfOZzoPjJh2bPgYHg52OInf/BUyo/W89Q5LXU+ouuGOnk59mOovpfcAKX+E+9ybB6f6NKgUsquEpIwjr3gzOzT5YI2oyiklfkRyI/DmJNU1+esLdMPtTiRc6v9IKeUIQNqTqM2BHyT92EbpresUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DU4PR04MB11459.eurprd04.prod.outlook.com (2603:10a6:10:5d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 18:08:44 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 18:08:44 +0000
Date: Tue, 4 Nov 2025 13:08:38 -0500
From: Frank Li <Frank.li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: add driver for NXP XSPI controller
Message-ID: <aQpBJgBtmNXnDkzJ@lizhi-Precision-Tower-5810>
References: <20251104-xspi-v1-0-1502847ade40@nxp.com>
 <20251104-xspi-v1-2-1502847ade40@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104-xspi-v1-2-1502847ade40@nxp.com>
X-ClientProxiedBy: CH0PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:610:76::35) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DU4PR04MB11459:EE_
X-MS-Office365-Filtering-Correlation-Id: f74af60d-9520-4eba-8390-08de1bcd3166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5iJHvfO9V6lGarMOkJ60o2SXhfDMW61ycfzT6hy40mjNilRkDOOc3wcJugz7?=
 =?us-ascii?Q?lZvSg5s416tYNXDraDjJ9wgkSYqIDyqZaZmqTzlq5zvxHtfuwbZmHab2OYK4?=
 =?us-ascii?Q?XVeflcPFl/9KuFaAGcqK4GM9VEjdsgybUM7nHSEq9aIsiAjOz6LUifIEuc7t?=
 =?us-ascii?Q?U8ICfA9CACDobwZI5IPBaWiut0XRQsU/wu2KO3lhNcDI6CUMlUSW7xjHGxby?=
 =?us-ascii?Q?5htD/aQfjlB74po3rJdbSVwAG6ifbiBqmgl5goY//V+t3ledKQlya4+cCl/2?=
 =?us-ascii?Q?D2hDRQLbyDpdhp0sGZMpSsUcWjxcLbh/sXAOaKOfCo3vNxLK2iVJ8oRBc/9b?=
 =?us-ascii?Q?mUwRl1knw/FyGFVDv83eUWmtJYfww9WVrreXebH23ts6mvOVpE1dOMmz6K1X?=
 =?us-ascii?Q?yhF+QetYFMC3uC0/zxAC28sCAw/94fi6t7jdvEzyUrmOA4moDrc6EXIw0pz1?=
 =?us-ascii?Q?ixFdaF4q6711q+b9UoukGVySDOR055xF2KPazXN0C1WmKsdg9qPLhRhUjj2s?=
 =?us-ascii?Q?Fua01xCjPQYDaLD4uMKEMJegLQVx8CmgetSWTT1SwCBhSMRTGqnu/BgePjzQ?=
 =?us-ascii?Q?9G2RuDImO88RHkAzY9lYs4+QjjfGM/UMpbF44vut7SAjVJ1raeG9fpOdC81y?=
 =?us-ascii?Q?+OHGFOWbEl4iE/7ttbbONF08eWTXz6VneKglZ+RVr3Cle5GqnJWqxXCh9nM/?=
 =?us-ascii?Q?gD7n8DSZk7B3anhp3HSMwaldueSme3n1SHYrMQESeV/OO4dTN6xZ5Tm32rgv?=
 =?us-ascii?Q?VFH//FZMwqTtBIfWz3Kcs5MReqXGLfC9B4+1VH9tEJOhv76+4drI3tzIiBG/?=
 =?us-ascii?Q?JDK9iOPjd6cvQzqQSmDiNQqeEeDBxnLp/vpxUu5XJp9WKp8S3uPdgHnxPVZe?=
 =?us-ascii?Q?uoYauCad5GV7bH15/Qu9gG5DzxMT5bOU6oyyLZhmbUzrKI+EgDqE6rdoPCdN?=
 =?us-ascii?Q?FkWlo/f2w4sEAHwsnzZ83d/u9XyBSEJrAaQAltN3xT0hfWYx7J0bfpZiD9Bl?=
 =?us-ascii?Q?rL3x+tqXCTyVYodpzfv1cQjzJYyMzUQdDnH4SEgEeOYefcpQ9QK6sknkijmt?=
 =?us-ascii?Q?3S4usrAJziOp4lBpXIf6a5VTd/46okSHRClUYYgL8WfbQCxe2HhubvpoA3fC?=
 =?us-ascii?Q?Mv46IlyUjaZXQS8G6yjzFqfU4dEwTYygh2SbqrlHus6i7eSp5oFDIREzdA7U?=
 =?us-ascii?Q?Sk5Y40aZPgU9MYY6+Led+AaIqG9T/0YyyZpFDdVQm0BJdjkdqx1PSsu55pnu?=
 =?us-ascii?Q?9fEwFDLHoSDXMTqwJMTMl+E1PJFFQOzIXd65ObxyoJ4LlK3zrVEX3tvOtjqm?=
 =?us-ascii?Q?2d9l+OUozfvJdh8IT31uDsM1FzEn0F05SJRpqnJWMZ4o50Q1C6asGKoUnoD9?=
 =?us-ascii?Q?rcCUHwbMT+NmeiYfbeuXdoOUABB6s8jX83aKcHhHrJaG6CahOeVJsexbEyEl?=
 =?us-ascii?Q?yzJ2UoQvpwMSWq8Z/zB3WOwDrIU9l/MibNFbpBr0xLpgiQbLml56ArGjMIQU?=
 =?us-ascii?Q?RiZDAa8MJvInSFqOQZp1uLQ+TjhSY77jfuRz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?00YvCB3ZQtb74+RAxIDfPEi4zh3np+mDpKnFk9CW/py5j1BuHgiV9QKIx4my?=
 =?us-ascii?Q?/S9hT15uxCZeJcz2SZMrs0QA44RB69DnhhIV9K34szQeV1DFVpbBoS5LwoCX?=
 =?us-ascii?Q?/iqFAahJWgCYXBvhyywHFAIeITLrcV/femhNrKW4xClh0VN0tuGaSFH5VpgO?=
 =?us-ascii?Q?9lYvQTcxdZt4065RoJxlMnKoi/J3PqNIMBVZNvn1009kY6s9x7VS61NwUaer?=
 =?us-ascii?Q?YSzWlBnxOFul9xx9c8+FHHdiFFWYkZDXhpo69GkDQlpErfNjUvaYEVAtE1Px?=
 =?us-ascii?Q?/zGEXGPsgCa4WbrW8HrmlitI3lgqmUnibPY9+DeR8MPsH9rizRCPjOr+E2Jn?=
 =?us-ascii?Q?T3dx8NsfSOTjBYTHTIffTx59Pume18clzEoSBBqx88tLdKJ2rYfrm2xuC12a?=
 =?us-ascii?Q?8FjMBJsUiW/9pqMmSsb9rrjoT74jcP4SSQCClFgJsGmeukQ4Z6WIg8rP5iP6?=
 =?us-ascii?Q?h1SSqGHyj1ZLJLeBRrEidOaDNk1zLBu9JDcvmI7aUbcFavAdNijtdiMu9yop?=
 =?us-ascii?Q?jAikpXSjbXBfw6ZxOK991w68hOE5JEeCKXg9G916M2YWXgR7OXlYZatG9Lmv?=
 =?us-ascii?Q?uLtCMpEB37YJFk0X682PJhpyi81umQ4LVxw2OXGcWlmA+n/wC0egH/uRGSlo?=
 =?us-ascii?Q?UdqAzj5/J0+Y9txrI5iQTpvRzHODEEABdSyH4O2TeH0ZCMdCH73YVQqX5yZn?=
 =?us-ascii?Q?Ikpe2qMvfSFivyTQDukoSEzEMIMcnhwnbztxt16JItRxFLOYw6FtLUNXph7C?=
 =?us-ascii?Q?we5Pan4+FwrRPV1IxHfhaZdjv8B+7i6lCuZRjjjmFF2z749qUaWd6b0ZIBk6?=
 =?us-ascii?Q?XxUgls3mMkLTKhH5RH6OLQHb18StcxB2CyKlYU++bQeEKesF4bG4LCTQyBup?=
 =?us-ascii?Q?09myUE6wT+E12hxaAhibMfDvWF5PqQHc38s1iyVjq7ybUlQWHh3iOp126nWh?=
 =?us-ascii?Q?gj0meqm2evez81DL+gk4JKtqvRwZTpilMCOhmatVkGy98Cz0wGqWGgdy+LZ1?=
 =?us-ascii?Q?SN85Rrsol6909JntPekvY2i91pCQ6Kih+MFurhaFh8/cHosI0afuasoJrLj6?=
 =?us-ascii?Q?+FzmeNu1ijPK+JSBDEEAq+o71WsvKnImrz17pZmtO86Ctm+54fYNfMDg3OPn?=
 =?us-ascii?Q?euvu2H/0qhTybvGVsBEo2TL+W5r9HG0FdTCr6w/IggRy4etKAH6GtBYL/y9w?=
 =?us-ascii?Q?p7xsPUKkDeCqueRLAzOSgifqDxF1DTi9+/aZMg/aXAva6TE1/715zdHtIr1Q?=
 =?us-ascii?Q?ze6u1HXNbc0DojLBX5zDZlluqhGAAcqhorS0rFybTMyyK0yBzp8+KSdgvcX5?=
 =?us-ascii?Q?apmaWTJ0ASvSeOTlefXEcPLK5AA/6b5kvPR6eEULMZlFn9+uTqd6IyL17M7h?=
 =?us-ascii?Q?jPKJGFvs1hY+FoAA2OWq2NQtrylTLNbFVN7eiz9ji7EZF7eFRBVS5OCoVqyG?=
 =?us-ascii?Q?LIHYaRbDd93Z6mAXabCcruyMYb2G1GTLaAMTagEbMZOC10dCXGaKnWJL6Fab?=
 =?us-ascii?Q?uFYr7smWI5FzW5JXhJqyjp1G0UQfGBAVFSjtei0kuv6p5stRWs4e7mqROac8?=
 =?us-ascii?Q?4MNECmmiWuaeC7yk80xEo6J+xh50jPSTDIbJEjrG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f74af60d-9520-4eba-8390-08de1bcd3166
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 18:08:44.6821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NlM0EVhNo5HK1eKVAiP2U+hhzk33oMHxRspbPXQhC20T+ihQVmWCdShpGDrBN+8vmtlh6VLw0yNzjmwnWCwWNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11459

On Tue, Nov 04, 2025 at 11:07:37AM +0800, Haibo Chen wrote:
> Add driver support for NXP XSPI controller.
>
> XSPI is a flexsible SPI host controller which supports up to
> 2 external devices (2 CS). It support Single/Dual/Quad/Octal
> mode data transfer.
>
> The difference between XSPI and Flexspi is XSPI support
> multiple independent execution environments (EENVs) for HW
> virtualization with some limitations. Each EENV has its own
> interrupt and its own set of programming registers that exists
> in a specific offset range in the XSPI memory map.
> The main environment (EENV0) address space contains all of the
> registers for controlling EENV0 plus all of the general XSPI
> control and programming registers. The register mnemonics for
> the user environments (EENV1 to EENV4) have "_SUB_n" appended
> to the mnemonic for the corresponding main-environment register.
>
> Current driver based on EENV0, which means system already give
> EENV0 right to linux.
>
> This driver use SPI memory interface of the SPI framework to issue
> flash memory operations. Tested this driver with mtd_debug and
> UBIFS on NXP i.MX943 EVK board which has one MT35XU512ABA spi nor
> flash. NOw this driver has the following key features:
> - Support up to OCT DDR mode
> - Support AHB read
> - Support IP read and IP write
> - Support two CS
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  MAINTAINERS                |    1 +
>  drivers/spi/Kconfig        |   10 +
>  drivers/spi/Makefile       |    1 +
>  drivers/spi/spi-nxp-xspi.c | 1430 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 1442 insertions(+)

It'd better descript why can't base on existing driver, such as register
layout is total difference.


>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2a47206cdb290b27ac6829d3a92289ca65d28d46..4a08d20a18509addcf6beb655b9a85ea4fa34925 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18629,6 +18629,7 @@ L:	linux-spi@vger.kernel.org
>  L:	imx@lists.linux.dev
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/spi/spi-nxp-xspi.yaml
> +F:	drivers/spi/spi-nxp-xspi.c
>
>  NXP FXAS21002C DRIVER
>  M:	Rui Miguel Silva <rmfrfs@gmail.com>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 4d8f00c850c1453845680192007342221e80da86..f9e958e574ecb12f3fba75633c1206223cec820d 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -480,6 +480,16 @@ config SPI_NXP_FLEXSPI
>  	  This controller does not support generic SPI messages and only
>  	  supports the high-level SPI memory interface.
>
> +config SPI_NXP_XSPI
> +        tristate "NXP xSPI controller"
> +	depends on ARCH_MXC || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  This enables support for the xSPI controller. Up to two devices
> +	  can be connected to one host.
> +	  This controller does not support generic SPI messages and only
> +	  supports the high-level SPI memory interface.
> +
>  config SPI_GPIO
>  	tristate "GPIO-based bitbanging SPI Master"
>  	depends on GPIOLIB || COMPILE_TEST
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 8ff74a13faaa88399723f9e944f9198076c3e543..9323ba633780daadcce2b04f5492ae0647259211 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -101,6 +101,7 @@ obj-$(CONFIG_SPI_WPCM_FIU)		+= spi-wpcm-fiu.o
>  obj-$(CONFIG_SPI_NPCM_FIU)		+= spi-npcm-fiu.o
>  obj-$(CONFIG_SPI_NPCM_PSPI)		+= spi-npcm-pspi.o
>  obj-$(CONFIG_SPI_NXP_FLEXSPI)		+= spi-nxp-fspi.o
> +obj-$(CONFIG_SPI_NXP_XSPI)		+= spi-nxp-xspi.o
>  obj-$(CONFIG_SPI_OC_TINY)		+= spi-oc-tiny.o
>  spi-octeon-objs				:= spi-cavium.o spi-cavium-octeon.o
>  obj-$(CONFIG_SPI_OCTEON)		+= spi-octeon.o
> diff --git a/drivers/spi/spi-nxp-xspi.c b/drivers/spi/spi-nxp-xspi.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..4f60dc61baba5b09bf9949a6afd1a65d55a7ed83
> --- /dev/null
> +++ b/drivers/spi/spi-nxp-xspi.c
> @@ -0,0 +1,1430 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/*
> + * NXP xSPI controller driver.
> + *
> + * Copyright 2025 NXP
> + *
> + * xSPI is a flexsible SPI host controller which supports single
> + * external devices. This device can have up to eight bidirectional
> + * data lines, this means xSPI support Single/Dual/Quad/Octal mode
> + * data transfer (1/2/4/8 bidirectional data lines).
> + *
> + * xSPI controller is driven by the LUT(Look-up Table) registers
> + * LUT registers are a look-up-table for sequences of instructions.
> + * A valid sequence consists of five LUT registers.
> + * Maximum 16 LUT sequences can be programmed simultaneously.
> + *
> + * LUTs are being created at run-time based on the commands passed
> + * from the spi-mem framework, thus using single LUT index.
> + *
> + * Software triggered Flash read/write access by IP Bus.
> + *
> + * Memory mapped read access by AHB Bus.
> + *
> + * Based on SPI MEM interface and spi-nxp-fspi.c driver.
> + *
> + * Author:
> + *     Haibo Chen <haibo.chen@nxp.com>
> + * Co-author:
> + *     Han Xu <han.xu@nxp.com>
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/log2.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pinctrl/consumer.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spi-mem.h>
> +
> +/* Runtime pm timeout */
> +#define XSPI_RPM_TIMEOUT 50	/* 50ms */
> +/*
> + * The driver only uses one single LUT entry, that is updated on
> + * each call of exec_op(). Index 0 is preset at boot with a basic
> + * read operation, so let's use the last entry (15).
> + */
> +#define	XSPI_SEQID_LUT			15
> +
> +#define XSPI_MCR			0x0
> +#define XSPI_MCR_CKN_FA_EN		BIT(26)
> +#define XSPI_MCR_DQS_FA_SEL(x)		((x) << 24)

Use FIELD_PREP, check others.

> +#define XSPI_MCR_DQS_FA_SEL_MASK	(BIT(24) | BIT(25))

> +#define XSPI_MCR_ISD3FA			BIT(17)
> +#define XSPI_MCR_ISD2FA			BIT(16)
> +#define XSPI_MCR_DOZE			BIT(15)
> +#define XSPI_MCR_MDIS			BIT(14)
> +#define XSPI_MCR_DLPEN			BIT(12)
> +#define XSPI_MCR_CLR_TXF		BIT(11)
> +#define XSPI_MCR_CLR_RXF		BIT(10)
> +#define XSPI_MCR_IPS_TG_RST		BIT(9)
> +#define XSPI_MCR_VAR_LAT_EN		BIT(8)
> +#define XSPI_MCR_DDR_EN			BIT(7)
...
> +#define XSPI_LOKCR_UNLOCK		BIT(1)
> +
> +#define XSPI_LUT			0x310
> +#define XSPI_LUT_OFFSET			(XSPI_SEQID_LUT * 5 * 4)
> +#define XSPI_LUT_REG(idx) \
> +	(XSPI_LUT + XSPI_LUT_OFFSET + (idx) * 4)
> +
> +#define XSPI_MCREXT			0x4FC
> +#define XSPI_MCREXT_RST			(BIT(0) | BIT(1) | BIT(2) | BIT(3))

GEN_MASK(3, 0)

> +
> +
> +#define XSPI_FRAD0_WORD2		0x808
> +#define XSPI_FRAD0_WORD2_MD0ACP_MASK	0x7
> +#define XSPI_FRAD0_WORD2_MD0ACP(x)	((x) << 0)
> +
...
> +
> +static struct nxp_xspi_devtype_data imx94_data = {
> +	.rxfifo = SZ_512,       /* (128 * 4 bytes)  */
> +	.txfifo = SZ_1K,        /* (256 * 4 bytes)  */
> +	.ahb_buf_size = SZ_4K,  /* (1024 * 4 bytes)  */
> +	.little_endian = true,  /* little-endian    */
> +};
> +
> +struct nxp_xspi {
> +	void __iomem *iobase;
> +	void __iomem *ahb_addr;
> +	u32 memmap_phy;
> +	u32 memmap_phy_size;
> +	u32 memmap_start;
> +	u32 memmap_len;
> +	struct clk *clk;
> +	struct device *dev;
> +	struct completion c;
> +	struct nxp_xspi_devtype_data *devtype_data;
> +	struct mutex lock;

All lock need comments, check_patch should report warnings.

> +	int selected;
> +#define XSPI_DTR_PROTO		BIT(0)
> +	int flags;
> +	/* Save the previous operation clock rate */
> +	unsigned long pre_op_rate;
> +	/* The max clock rate xspi supported output to device */
> +	unsigned long support_max_rate;
> +};
> +
> +static inline int needs_ip_only(struct nxp_xspi *xspi)
> +{
> +	return xspi->devtype_data->quirks & XSPI_QUIRK_USE_IP_ONLY;
> +}
> +
> +/*
> + * R/W functions for big- or little-endian registers:
> + * The xSPI controller's endianness is independent of
> + * the CPU core's endianness. So far, although the CPU
> + * core is little-endian the xSPI controller can use
> + * big-endian or little-endian.
> + */
> +static void xspi_writel(struct nxp_xspi *xspi, u32 val, void __iomem *addr)
> +{
> +	if (xspi->devtype_data->little_endian)
> +		iowrite32(val, addr);
> +	else
> +		iowrite32be(val, addr);
> +}
> +
> +static u32 xspi_readl(struct nxp_xspi *xspi, void __iomem *addr)
> +{
> +	if (xspi->devtype_data->little_endian)
> +		return ioread32(addr);
> +	else
> +		return ioread32be(addr);
> +}

If you like, you can use regmap, which already support endian.

> +
> +static irqreturn_t nxp_xspi_irq_handler(int irq, void *dev_id)
> +{
> +	struct nxp_xspi *xspi = dev_id;
> +	u32 reg;
> +
> +	/* Clear interrupt */
> +	reg = xspi_readl(xspi, xspi->iobase + XSPI_FR);
> +	xspi_writel(xspi, XSPI_FR_TFF, xspi->iobase + XSPI_FR);
> +
> +	if (reg & XSPI_FR_TFF)
> +		complete(&xspi->c);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int nxp_xspi_check_buswidth(struct nxp_xspi *xspi, u8 width)
> +{
> +	return (is_power_of_2(width) && width <= 8) ? 0 : -EOPNOTSUPP;
> +}
> +
...
> +
> +/* Instead of busy looping, invoke readl_poll_timeout functionality. */
> +static int xspi_readl_poll_tout(struct nxp_xspi *xspi, void __iomem *base,
> +				u32 mask, u32 delay_us,
> +				u32 timeout_us, bool c)
> +{
> +	u32 reg;
> +
> +	if (!xspi->devtype_data->little_endian)
> +		mask = (__force u32)cpu_to_be32(mask);
> +
> +	if (c)
> +		return readl_poll_timeout(base, reg, (reg & mask),
> +					  delay_us, timeout_us);
> +	else
> +		return readl_poll_timeout(base, reg, !(reg & mask),
> +					  delay_us, timeout_us);

You already have xspi_readl, which already conside endian so use

return read_poll_timeout(xspi_readl, reg, ...,
			 c ? (reg & mask) : !(reg & mask) // !(c ^ !!(reg & mask));
			 xspi, base)

Or remove this help function, directly use read_poll_timeout(), which
will be more strangforward.


> +}
> +
> +static void nxp_xspi_prepare_lut(struct nxp_xspi *xspi,
> +				 const struct spi_mem_op *op)
> +{
> +	void __iomem *base = xspi->iobase;
> +	u32 lutval[5] = {};
> +	int lutidx = 1, i;
> +
> +	/* cmd */
...
> +	xspi_writel(xspi, XSPI_LOKCR_LOCK, xspi->iobase + XSPI_LCKCR);
> +}
> +
> +static int nxp_xspi_clk_prep_enable(struct nxp_xspi *xspi)
> +{
> +
> +	return clk_prepare_enable(xspi->clk);
> +
> +}
> +
> +static int nxp_xspi_clk_disable_unprep(struct nxp_xspi *xspi)
> +{
> +	clk_disable_unprepare(xspi->clk);
> +
> +	return 0;
> +}
> +

both helper function can be removed, directly use clk_prepare_enable()
and clk_disable_unprepare().

> +static void nxp_xspi_disable_ddr(struct nxp_xspi *xspi)
> +{
> +	void __iomem *base = xspi->iobase;
> +	u32 reg;
> +
> +	/* Disable module */
> +	reg = xspi_readl(xspi, base + XSPI_MCR);
> +	reg |= XSPI_MCR_MDIS;
> +	xspi_writel(xspi, reg, base + XSPI_MCR);
> +
> +	reg &= ~XSPI_MCR_DDR_EN;
> +	reg &= ~XSPI_MCR_DQS_FA_SEL_MASK;
> +	/* Use dummy pad loopback mode to sample data */
> +	reg |= XSPI_MCR_DQS_FA_SEL(1);

use FIELD_PREP(), check others.

> +	xspi_writel(xspi, reg, base + XSPI_MCR);
> +	xspi->support_max_rate = 133000000;
> +
> +	reg = xspi_readl(xspi, base + XSPI_FLSHCR);
> +	reg &= ~XSPI_FLSHCR_TDH_MASK;
> +	xspi_writel(xspi, reg, base + XSPI_FLSHCR);
> +
> +	/* Select sampling at inverted clock */
> +	reg = XSPI_SMPR_DLLFSMPFA(0) | XSPI_SMPR_FSPHS;
> +	xspi_writel(xspi, reg, base + XSPI_SMPR);
> +
> +	/* Enable module */
> +	reg = xspi_readl(xspi, base + XSPI_MCR);
> +	reg &= ~XSPI_MCR_MDIS;
> +	xspi_writel(xspi, reg, base + XSPI_MCR);
> +}
> +
...
> +
> +static void nxp_xspi_sw_reset(struct nxp_xspi *xspi)
> +{
> +	void __iomem *base = xspi->iobase;
> +	bool mdis_flag = false;
> +	u32 reg;
> +	int ret;
> +
> +	reg = xspi_readl(xspi, base + XSPI_MCR);
> +
> +	/*
> +	 * Per RM, when reset SWRSTSD and SWRSTHD, XSPI must be
> +	 * enabled (MDIS = 0).
> +	 * So if MDIS is 1, should clear it before assert SWRSTSD
> +	 * and SWRSTHD.
> +	 */
> +	if (reg & XSPI_MCR_MDIS) {
> +		reg &= ~XSPI_MCR_MDIS;
> +		xspi_writel(xspi, reg, base + XSPI_MCR);
> +		mdis_flag = true;
> +	}
> +
> +	/* Software reset for AHB domain and Serial flash memory domain */
> +	reg |= XSPI_MCR_SWRSTHD | XSPI_MCR_SWRSTSD;
> +	/* Software Reset for IPS Target Group Queue 0 */
> +	reg |= XSPI_MCR_IPS_TG_RST;
> +	xspi_writel(xspi, reg, base + XSPI_MCR);
> +
> +	/* IPS_TG_RST will self-clear to 0 once IPS_TG_RST complete */
> +	ret = xspi_readl_poll_tout(xspi, base + XSPI_MCR,
> +				   XSPI_MCR_IPS_TG_RST, 100, 5000, false);
> +	if (ret == -ETIMEDOUT)
> +		dev_warn(xspi->dev, "XSPI_MCR_IPS_TG_RST do not self-clear in 5ms!");
> +
> +	/*
> +	 * Per RM, must wait for at least three system cycles and
> +	 * three flash cycles after changing the value of reset field.
> +	 * delay 5us for safe.
> +	 */
> +	udelay(5);

now prefer use fsleep(), check others

> +
> +	/*
> +	 * Per RM, before dessert SWRSTSD and SWRSTHD, XSPI must be
> +	 * disabled (MIDS = 1).
> +	 */
> +	reg = xspi_readl(xspi, base + XSPI_MCR);
> +	reg |= XSPI_MCR_MDIS;
> +	xspi_writel(xspi, reg, base + XSPI_MCR);
> +
...
> +static void nxp_xspi_dll_auto(struct nxp_xspi *xspi, unsigned long rate)
> +{
> +	void __iomem *base = xspi->iobase;
> +	int ret;
> +	u32 reg;
> +
> +	nxp_xspi_sw_reset(xspi);
> +
> +	xspi_writel(xspi, 0, base + XSPI_DLLCRA);
> +
> +	/* Set SLV EN first */
> +	reg = XSPI_DLLCRA_SLV_EN;
> +	xspi_writel(xspi, reg, base + XSPI_DLLCRA);
> +
> +	reg = XSPI_DLLCRA_DLL_REFCNTR(2) | XSPI_DLLCRA_DLLRES(8) |
> +		XSPI_DLLCRA_SLAVE_AUTO_UPDT | XSPI_DLLCRA_SLV_EN;
> +	if (rate > 133000000)
> +		reg |= XSPI_DLLCRA_FREQEN;
> +
> +	xspi_writel(xspi, reg, base + XSPI_DLLCRA);
> +
> +	reg |= XSPI_DLLCRA_SLV_UPD;
> +	xspi_writel(xspi, reg, base + XSPI_DLLCRA);
> +
> +	reg |= XSPI_DLLCRA_DLLEN;
> +	xspi_writel(xspi, reg, base + XSPI_DLLCRA);
> +
> +	ret = xspi_readl_poll_tout(xspi, base + XSPI_DLLSR,
> +						XSPI_DLLSR_DLLA_LOCK, 0,
> +						POLL_TOUT, true);
> +	if (ret)
> +		dev_err(xspi->dev,
> +			"DLL unlock, the DLL status is %x, need to check!\n",
> +			xspi_readl(xspi, base + XSPI_DLLSR));

	if (ret) {
		...
		return
	};

> +	else

then needn't else branch

> +		ret = xspi_readl_poll_tout(xspi, base + XSPI_DLLSR,
> +						XSPI_DLLSR_SLVA_LOCK, 0,
> +						POLL_TOUT, true);
> +	if (ret)
> +		dev_err(xspi->dev,
> +			"DLL SLVA unlock, the DLL status is %x, need to check!\n",
> +			xspi_readl(xspi, base + XSPI_DLLSR));
> +
> +}
> +
> +static void nxp_xspi_select_mem(struct nxp_xspi *xspi, struct spi_device *spi,
> +				const struct spi_mem_op *op)
> +{
> +	/* xspi only support one DTR mode: 8D-8D-8D */
> +	bool op_is_dtr = op->cmd.dtr && op->addr.dtr && op->dummy.dtr && op->data.dtr;
> +	unsigned long root_clk_rate, rate;
> +	uint64_t cs0_top_address;
> +	uint64_t cs1_top_address;
> +	u32 reg;
> +	int ret;
> +
> +	/*
> +	 * Return when following condition all meet,
> +	 * 1, if previously selected target device is same as current
> +	 *    requested target device.
> +	 * 2, the DTR or STR mode do not change.
> +	 * 3, previous operation max rate equals current one.
> +	 *
> +	 * For other case, need to re-config.
> +	 */
> +	if (xspi->selected == spi_get_chipselect(spi, 0) &&
> +	    (!!(xspi->flags & XSPI_DTR_PROTO) == op_is_dtr) &&
> +	    (xspi->pre_op_rate == op->max_freq))
> +		return;
> +
> +	if (op_is_dtr) {
> +		nxp_xspi_enable_ddr(xspi);
> +		xspi->flags |= XSPI_DTR_PROTO;
> +	} else {
> +		nxp_xspi_disable_ddr(xspi);
> +		xspi->flags &= ~XSPI_DTR_PROTO;
> +	}
> +	rate = min(xspi->support_max_rate, op->max_freq);
> +	/*
> +	 * There is two dividers between xspi_clk_root(from SoC CCM) and xspi_sfif.
> +	 * xspi_clk_root ---->divider1 ----> ipg_clk_2xsfif
> +	 *                              |
> +	 *                              |
> +	 *                              |---> divider2 ---> ipg_clk_sfif
> +	 * divider1 is controlled by SOCCR, SOCCR default value is 0.
> +	 * divider2 fix to divide 2.
> +	 * when SOCCR = 0:
> +	 *        ipg_clk_2xsfif = xspi_clk_root
> +	 *        ipg_clk_sfif = ipg_clk_2xsfif / 2 = xspi_clk_root / 2
> +	 * ipg_clk_2xsfif is used for DTR mode.
> +	 * xspi_sck(output to device) is defined based on xspi_sfif clock.
> +	 */
> +	root_clk_rate = rate * 2;
> +
> +	nxp_xspi_clk_disable_unprep(xspi);
> +
> +	ret = clk_set_rate(xspi->clk, root_clk_rate);
> +	if (ret)
> +		return;
> +
> +	ret = nxp_xspi_clk_prep_enable(xspi);
> +	if (ret)
> +		return;
> +
> +	xspi->pre_op_rate = op->max_freq;
> +	xspi->selected = spi_get_chipselect(spi, 0);
> +
> +	if (xspi->selected) {		/* CS1 select */
> +		cs0_top_address = xspi->memmap_phy;
> +		cs1_top_address = SZ_4G - 1;
> +	} else {			/* CS0 select */
> +		cs0_top_address = SZ_4G - 1;
> +		cs1_top_address = SZ_4G - 1;
> +	}
> +	xspi_writel(xspi, cs0_top_address, xspi->iobase + XSPI_SFA1AD);
> +	xspi_writel(xspi, cs1_top_address, xspi->iobase + XSPI_SFA2AD);
> +
> +	reg = xspi_readl(xspi, xspi->iobase + XSPI_SFACR);
> +	if (op->data.swap16)
> +		reg |= XSPI_SFACR_BYTE_SWAP;
> +	else
> +		reg &= ~XSPI_SFACR_BYTE_SWAP;
> +	xspi_writel(xspi, reg, xspi->iobase + XSPI_SFACR);
> +
> +	if (!op_is_dtr || rate < 60000000)
> +		nxp_xspi_dll_bypass(xspi);
> +	else
> +		nxp_xspi_dll_auto(xspi, rate);
> +}
> +
> +static int nxp_xspi_ahb_read(struct nxp_xspi *xspi, const struct spi_mem_op *op)
> +{
> +	u32 start = op->addr.val;
> +	u32 len = op->data.nbytes;
> +
> +	/* If necessary, ioremap before AHB read */
> +	if ((!xspi->ahb_addr) || start < xspi->memmap_start ||
> +	     start + len > xspi->memmap_start + xspi->memmap_len) {
> +		if (xspi->ahb_addr)
> +			iounmap(xspi->ahb_addr);
> +
> +		xspi->memmap_start = start;
> +		xspi->memmap_len = len > NXP_XSPI_MIN_IOMAP ?
> +				len : NXP_XSPI_MIN_IOMAP;
> +
> +		xspi->ahb_addr = ioremap(xspi->memmap_phy + xspi->memmap_start,
> +					 xspi->memmap_len);
> +
> +		if (!xspi->ahb_addr) {
> +			dev_err(xspi->dev, "failed to alloc memory\n");
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	/* Read out the data directly from the AHB buffer. */
> +	memcpy_fromio(op->data.buf.in,
> +			xspi->ahb_addr + start - xspi->memmap_start, len);
> +
> +	return 0;
> +}
> +
> +static void nxp_xspi_fill_txfifo(struct nxp_xspi *xspi,
> +				 const struct spi_mem_op *op)
> +{
> +	void __iomem *base = xspi->iobase;
> +	u8 *buf = (u8 *)op->data.buf.out;
> +	u32 reg, left;
> +	int i;
> +
> +	for (i = 0; i < ALIGN(op->data.nbytes, 4); i += 4) {
> +		reg = xspi_readl(xspi, base + XSPI_FR);
> +		reg |= XSPI_FR_TBFF;
> +		xspi_writel(xspi, reg, base + XSPI_FR);
> +		/* Read again to check whether the tx fifo has rom */
> +		reg = xspi_readl(xspi, base + XSPI_FR);
> +		WARN_ON(!(reg & XSPI_FR_TBFF));

Do you need wait for NO FULL?

> +		if (i == ALIGN_DOWN(op->data.nbytes, 4)) {
> +			/* Use 0xff for extra bytes */
> +			left = 0xffffffff;
> +			/* The last 1 to 3 bytes */
> +			memcpy((u8 *)&left, buf + i, op->data.nbytes - i);
> +			xspi_writel(xspi, left, base + XSPI_TBDR);
> +		} else
> +			xspi_writel(xspi, *(u32 *)(buf + i), base + XSPI_TBDR);
> +	}
> +}
> +
> +static void nxp_xspi_read_rxfifo(struct nxp_xspi *xspi,
> +				const struct spi_mem_op *op)
> +{
> +	u32 watermark, watermark_bytes, reg;
> +	void __iomem *base = xspi->iobase;
> +	u8 *buf = (u8 *) op->data.buf.in;
> +	int i, ret, len;
> +
> +	/*
> +	 * Config the rx watermark half of the 64 memory-mapped RX data buffer RBDRn
> +	 * refer to the RBCT config in nxp_xspi_do_op()
> +	 */
> +	watermark = 32;
> +	watermark_bytes = watermark * 4;
> +
> +	len = op->data.nbytes;
> +
> +	while (len >= watermark_bytes) {
> +		/* Make sure the RX FIFO contains valid data before read */
> +		ret = xspi_readl_poll_tout(xspi, base + XSPI_FR,
> +						XSPI_FR_RBDF, 0,
> +						POLL_TOUT, true);
> +		WARN_ON(ret);

Does just print WARN enough? or need return ret

> +		for (i = 0; i < watermark; i++)
> +			*(u32 *)(buf + i * 4) = xspi_readl(xspi, base + XSPI_RBDR0 + i * 4);
> +
> +		len = len - watermark_bytes;
> +		buf = buf + watermark_bytes;
> +		/* Pop up data to RXFIFO for next read. */
> +		reg = xspi_readl(xspi, base + XSPI_FR);
> +		reg |= XSPI_FR_RBDF;
> +		xspi_writel(xspi, reg, base + XSPI_FR);
> +	}
> +
> +	/* Wait for the total data transfer finished */
> +	ret = xspi_readl_poll_tout(xspi, base + XSPI_SR, XSPI_SR_BUSY,
> +					0, POLL_TOUT, false);
> +	i = 0;
> +	while (len >= 4) {
> +		*(u32 *)(buf) = xspi_readl(xspi, base + XSPI_RBDR0 + i);
> +		i += 4;
> +		len -= 4;
> +		buf += 4;
> +	}
> +
> +	if (len > 0) {
> +		reg = xspi_readl(xspi, base + XSPI_RBDR0 + i);
> +		memcpy(buf, (u8 *)&reg, len);
> +	}

mv this
https://elixir.bootlin.com/linux/v6.18-rc4/source/drivers/i3c/internals.h
to common place,

so you can use it directly. The code logic is the same. Or create similar
API here, we can consolidate later.

> +
> +	/* Invalid RXFIFO first */
> +	reg = xspi_readl(xspi, base + XSPI_MCR);
> +	reg |= XSPI_MCR_CLR_RXF;
> +	xspi_writel(xspi, reg, base + XSPI_MCR);
> +	/* Wait for the CLR_RXF clear */
> +	ret = xspi_readl_poll_tout(xspi, base + XSPI_MCR,
> +				   XSPI_MCR_CLR_RXF, 1, POLL_TOUT, false);
> +}
> +
...
> +
> +static int nxp_xspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
> +{
> +	struct nxp_xspi *xspi = spi_controller_get_devdata(mem->spi->controller);
> +	void __iomem *base = xspi->iobase;
> +	int err;
> +
> +	guard(mutex)(&xspi->lock);
> +
> +	err = pm_runtime_get_sync(xspi->dev);
> +	if (err < 0) {
> +		dev_err(xspi->dev, "Failed to enable clock %d\n", __LINE__);
> +		return err;
> +	}
> +
> +	/* Wait for controller being ready. */
> +	err = xspi_readl_poll_tout(xspi, base + XSPI_SR,
> +				   XSPI_SR_BUSY, 1, POLL_TOUT, false);
> +	WARN_ON(err);

most likely return err here

> +
> +	nxp_xspi_select_mem(xspi, mem->spi, op);
> +
> +	nxp_xspi_prepare_lut(xspi, op);
> +
> +	/*
> +	 * For read:
> +	 *     the address in AHB mapped range will use AHB read.
> +	 *     the address out of AHB maped range will use IP read.
> +	 * For write:
> +	 *     all use IP write.
> +	 */
> +	if ((op->data.dir == SPI_MEM_DATA_IN) && !needs_ip_only(xspi)
> +		&& ((op->addr.val + op->data.nbytes) <= xspi->memmap_phy_size))
> +		err = nxp_xspi_ahb_read(xspi, op);
> +	else
> +		err = nxp_xspi_do_op(xspi, op);
> +
> +	nxp_xspi_sw_reset(xspi);
> +
> +	pm_runtime_mark_last_busy(xspi->dev);

Needn't call pm_runtime_mark_last_busy() now. which already called in
pm_runtime_put_autosuspend().

> +	pm_runtime_put_autosuspend(xspi->dev);
> +
> +	return err;
> +}
> +
...
> +static int nxp_xspi_default_setup(struct nxp_xspi *xspi)
> +{
> +	void __iomem *base = xspi->iobase;
> +	u32 reg;
> +
> +	/* Bypass SFP check, clear MGC_GVLD, MGC_GVLDMDAD, MGC_GVLDFRAD */
> +	xspi_writel(xspi, 0, base + XSPI_MGC);
> +
> +	/* Enable the EENV0 SFP check */
> +	reg = xspi_readl(xspi, base + XSPI_TG0MDAD);
> +	reg |= XSPI_TG0MDAD_VLD;
> +	xspi_writel(xspi, reg, base + XSPI_TG0MDAD);
> +
> +	/* Give read/write access right to EENV0 */
> +	reg = xspi_readl(xspi, base + XSPI_FRAD0_WORD2);
> +	reg &= ~XSPI_FRAD0_WORD2_MD0ACP_MASK;
> +	reg |= XSPI_FRAD0_WORD2_MD0ACP(3);
> +	xspi_writel(xspi, reg, base + XSPI_FRAD0_WORD2);
> +
> +	/* Enable the FRAD check for EENV0 */
> +	reg = xspi_readl(xspi, base + XSPI_FRAD0_WORD3);
> +	reg |= XSPI_FRAD0_WORD3_VLD;
> +	xspi_writel(xspi, reg, base + XSPI_FRAD0_WORD3);
> +
> +	/*
> +	 * Config the timeout to max value, this timeout will affect the
> +	 * TBDR and RBDRn access right after IP cmd triggered.
> +	 */
> +	xspi_writel(xspi, 0xffffffff, base + XSPI_MTO);

keep the same style for hex value, either low case or up case.

> +
> +	/* Disable module */
> +	reg = xspi_readl(xspi, base + XSPI_MCR);
> +	reg |= XSPI_MCR_MDIS;
> +	xspi_writel(xspi, reg, base + XSPI_MCR);
> +
> +	nxp_xspi_sw_reset(xspi);
> +
...
> +
> +static void nxp_xspi_cleanup(void *data)
> +{
> +	struct nxp_xspi *xspi = data;
> +
> +	pm_runtime_get_sync(xspi->dev);
> +
> +	/* Disable interrupt */
> +	xspi_writel(xspi, 0, xspi->iobase + XSPI_RSER);
> +	/* Clear all the internal logic flags */
> +	xspi_writel(xspi, 0xffffffff, xspi->iobase + XSPI_FR);
> +	/* Disable the hardware */
> +	xspi_writel(xspi, XSPI_MCR_MDIS, xspi->iobase + XSPI_MCR);
> +
> +	nxp_xspi_clk_disable_unprep(xspi);
> +
> +	if (xspi->ahb_addr)
> +		iounmap(xspi->ahb_addr);
> +
> +	pm_runtime_disable(xspi->dev);
> +	pm_runtime_put_noidle(xspi->dev);
> +}
> +
> +static int nxp_xspi_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct spi_controller *ctlr;
> +	struct nxp_xspi *xspi;
> +	struct resource *res;
> +	int ret, irq;
> +
> +	ctlr = devm_spi_alloc_host(dev, sizeof(*xspi));
> +	if (!ctlr)
> +		return -ENOMEM;
> +
> +	ctlr->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL |
> +			  SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL;
> +
> +	xspi = spi_controller_get_devdata(ctlr);
> +	xspi->dev = dev;
> +	xspi->devtype_data = (struct nxp_xspi_devtype_data *)device_get_match_data(dev);

needn't force type convert here.

> +	if (!xspi->devtype_data)
> +		return -ENODEV;
> +
> +	platform_set_drvdata(pdev, xspi);
> +
> +	/* Find the resources - configuration register address space */
> +	xspi->iobase = devm_platform_ioremap_resource_byname(pdev, "base");
> +	if (IS_ERR(xspi->iobase))
> +		return PTR_ERR(xspi->iobase);
> +
> +	/* Find the resources - controller memory mapped space */
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mmap");
> +	if (!res)
> +		return -ENODEV;
> +
> +	/* Assign memory mapped starting address and mapped size. */
> +	xspi->memmap_phy = res->start;
> +	xspi->memmap_phy_size = resource_size(res);
> +
> +	/* Find the clocks */
> +	if (dev_of_node(&pdev->dev)) {

needn't check this

> +		xspi->clk = devm_clk_get(dev, "per");
> +		if (IS_ERR(xspi->clk))
> +			return PTR_ERR(xspi->clk);
> +	}
> +
> +	/* Find the irq */
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return dev_err_probe(dev, irq,  "Failed to get irq source");
> +
> +	pm_runtime_set_autosuspend_delay(dev, XSPI_RPM_TIMEOUT);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_enable(dev);
> +
...

> +
> +
> +static const struct dev_pm_ops nxp_xspi_pm_ops = {
> +	SET_RUNTIME_PM_OPS(nxp_xspi_runtime_suspend, nxp_xspi_runtime_resume, NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(nxp_xspi_suspend, nxp_xspi_resume)
> +};

use modern:
SYSTEM_SLEEP_PM_OPS
RUNTIME_PM_OPS

ref
https://lore.kernel.org/imx/20250411085932.1902662-1-arnd@kernel.org/

Frank
> +
> +static const struct of_device_id nxp_xspi_dt_ids[] = {
> +	{ .compatible = "nxp,imx94-xspi", .data = (void *)&imx94_data, },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, nxp_xspi_dt_ids);
> +
> +static struct platform_driver nxp_xspi_driver = {
> +	.driver = {
> +		.name	= "nxp-xspi",
> +		.of_match_table = nxp_xspi_dt_ids,
> +		.pm =   pm_ptr(&nxp_xspi_pm_ops),
> +	},
> +	.probe          = nxp_xspi_probe,
> +};
> +module_platform_driver(nxp_xspi_driver);
> +
> +MODULE_DESCRIPTION("NXP xSPI Controller Driver");
> +MODULE_AUTHOR("NXP Semiconductor");
> +MODULE_AUTHOR("Haibo Chen <haibo.chen@nxp.com>");
> +MODULE_LICENSE("GPL");
>
> --
> 2.34.1
>

