Return-Path: <linux-spi+bounces-5329-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40EEC9AD580
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2024 22:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1593280626
	for <lists+linux-spi@lfdr.de>; Wed, 23 Oct 2024 20:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9291C9EAF;
	Wed, 23 Oct 2024 20:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ONlHgzmg"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2064.outbound.protection.outlook.com [40.107.103.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDD075809;
	Wed, 23 Oct 2024 20:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715456; cv=fail; b=Ob9L2fQLcWoPGrvqR77qq03UKOPNA/ww84IGyFmChozWUy5sPUlCuUI5es6LkEC12ToHCwJMXYBcnTxpfRCHbAxIWHLWd/Ka4AsGYK8KN/3Vr1hUXO9mdxJVQ8Xm1qZqxXBrqLQOrzxj/0ZUIOtBbUbTx1MbK6LHK5Ku7hwP/+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715456; c=relaxed/simple;
	bh=UXnW3XyLFb+aR4FajaCZIoXOKhIXJB+utDPQnWA3+x8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bCQKSmNcZkOI8vZ3SHEfdvcCJkLsaQSutcSYF3AaAhvWVUd6IOth3HZZWG7gkWYTOlCTgVvkGbaX3rJepUW49NaSHMCVbHLJBgNY7PwPvEqWKQGc6mXwR8r0wQ+paYZJr0e28zkw5hGjczJqC1ztPTCcCFRlIS12L2WxBVW2PPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ONlHgzmg; arc=fail smtp.client-ip=40.107.103.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVhDdQEcfYXR7E/MN1cYKUh2YOqDTldyK2Vfq/xf7VE5xTX5lqbSWx/yvOyYZq94AmuNx3nVEpA8WNz38nVtEntbYZDc4QDx7JD6vDSUo0vH31cRyTsjYHQq1NBKq0HImOqI6AyhaCC7Fdj/BbF7zn9TmS3Ikqm/s2hyK5THgteQhBy7p5c2kMyrcIeg+Besj8BXpHY0X8gYmWrVLIxOknVieHUK/TFSHA00jHG2Y3a7WsI8FPOZJBtwidka3oupGwnLL4WbFx7LzqzAHc8JsuY3sFH0X8btOoQ0XIcKbiiozXHchUu1UROl/gOmB0NN7kRoqXIOlPTBqvNB5Is0Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opXBXWLafG0EjOihcbjmqy+P2P/LR7hsYpNOv9BKBws=;
 b=KTqVlSF1ppBoV138tXJI9ptpS/YjMZnyHFThSgMC0adJWWYunjThqIS8tYSdcynGls20aPpeEqo2NZyzCDZ+SYghW0nlrsr4cXiQk3P/4wIQ/Gk49KnG0/m/zUIKRHJDlag2YiEVeHJxDSZXpjCnsy9s0xtr/CFlMBtxbo2YIhbGDlS8NuxbDsCxvOYXgf1L2qSCo72JNnwRVZEUXbaSXHdFCSQfh+MamrliDyvuHylDnYMQfw4r3NLKFUUg5tcO0kinRcvGoG0HawKV8TQ0+Wq8hpbNkg6TsXyuY6UAHcb+kl/n0VJFcFkv5cYl4c1w+C72gvIFZFmscNqaFen4xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opXBXWLafG0EjOihcbjmqy+P2P/LR7hsYpNOv9BKBws=;
 b=ONlHgzmgQmh9d2YLy6anhKjCmvPAPsxEOoG4f1Lo0T6U/cTB3Fiq0xXsx9XsWPESJSfo6l5vgMKqMrlqHWG1YkgwETwJweQGj8pefp4SwXpZ4P+lyhwC8Sd0WXcP7oAxBjSKRz2dvFK1VylgaaVxoy9nQbvF965ccfzqnylJnFLL17qiUSv4Y1QX2vYYS7/WGkZk8S9WxuSK9yl/0z/NGA3lyalvrKp2PBGv+6oV6eErB3dGkxta/NAR6HBirR4SBIKYCcZwfDGSlsxEwhyc2Xdy+86lWOPqNgZGP5fzjeX0xSvXhsWdmdRdTn41R7H8xUCZktXqZI0m3yu5pwopyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7173.eurprd04.prod.outlook.com (2603:10a6:20b:122::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 20:30:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 20:30:48 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Vladimir Oltean <olteanv@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	William Zhang <william.zhang@broadcom.com>,
	Heiko Stuebner <heiko@sntech.de>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Dhruva Gole <d-gole@ti.com>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	linux-spi@vger.kernel.org (open list:FREESCALE DSPI DRIVER),
	imx@lists.linux.dev (open list:FREESCALE DSPI DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] spi: spi-fsl-dspi: Fix crash when not using GPIO chip select
Date: Wed, 23 Oct 2024 16:30:32 -0400
Message-Id: <20241023203032.1388491-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0179.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: 80cc799e-ac2e-4b05-0b7a-08dcf3a1944a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aRYWqkNUDq0XQAI2pWyoaB2jInFZJ6rnuWx1n0/IaFQl5wtzwZXdqtbNst2l?=
 =?us-ascii?Q?QEmVyKumOFs7uxrbjKJPWVnz1/3JEQ6h4LexSUeYBF1f3UFi9XxtAxjxkNKo?=
 =?us-ascii?Q?ksp0PGw4C9oQM23mrwJD06x+NAes4A364+LK9xwUI2JeyqkbQzija9bogj3n?=
 =?us-ascii?Q?m2uZ/28WWAm7MCCvZkQRF9Xdy6W/PntEPWZwJqCPnLmSMq8twwFR/tuXks+Q?=
 =?us-ascii?Q?xQeJweP5RhbFkt+l+8RnDZ4KsiaufUf4zTlypGw3oHYpBLVniG/HZVihmut4?=
 =?us-ascii?Q?H2ApcYyLkkK8Oivh31P2IKA1fdSaEnmCteb2TAYAj36AB/cLynTPeE+3hoHl?=
 =?us-ascii?Q?E9RKhgwqBWA+1rrcjyLdThqEraXq6dswQxdXb9IZbQR162+vyTH8QRkzV6/1?=
 =?us-ascii?Q?R5cjOaoutMPrMy6WLipreaTXARchUGjzA8DYnAEJUwxv2xAEB/TT4YC2S6d7?=
 =?us-ascii?Q?p26IDlDvNzSMKTdeMkMoaTSbOzMUpImoMrpd2DC0b1oPCTiVsW5ppeDSrbKR?=
 =?us-ascii?Q?5rwWFQjEeUMyuEgL1SLf9bqWpKDJXTeiRn5Qso3yXYtAyyMWDJ+Ymw0df4X4?=
 =?us-ascii?Q?2K7DRnB9jr4wgrjcvrB0DncVD5NQeUlliHw1oyu9cht0c5dDuO8Ut4d1m0dA?=
 =?us-ascii?Q?doHZFSwHkjWBzV6DfHA48KE+iaOg8o8/PGMDPMcvAaZeXhJLpGaSP5ktxUpE?=
 =?us-ascii?Q?31oLW25w1PvZ9AAUErnVgMMsNqfbYGcwA2lBzKTV4SRSlZY96UFmQK9gyLHF?=
 =?us-ascii?Q?SNu1DIxq63vukmSAtD8rIFvE6xoTxvXlJ0sBs8gYH1Mird8VBbE/qD2Yz0Zw?=
 =?us-ascii?Q?ATUrzoCrCFFkSrndfCsn0SKruR4Uc/Qhi4WQygqFyxNp/yocCI79ZMMffWej?=
 =?us-ascii?Q?KF15QPjk8f2JuVoTWxj0JYbehmftkdKDKga4j7utcFFLyRf7kvKBxZ3VcOXB?=
 =?us-ascii?Q?l7KbwtJQfNV5VSJ62rV0n3ymFNGTI9yYcI+/0uH7RtB2BZO360pwg2MJsNU+?=
 =?us-ascii?Q?Gyf19A8iOeo1aSuZzZJbdGF0BlA9VqPDFwOx4xTc42vVgbgNakX9bnCRxvb8?=
 =?us-ascii?Q?3Qbm/eHQlEAapFRUhvpgXx3ADckccjYjsig98tqtgWpAKXL8B1pS4MQB10cS?=
 =?us-ascii?Q?vvWOA67cZlJEzjHyJrzEGripRRxJk1IBP8xFEJN5IZzLveGXDCpwjgfuIqjT?=
 =?us-ascii?Q?eLpRcGlWxSxYb8jnPfDETcjiiMLJ/aVLVyGwxGIhfp4CvUMQx8XQHcAmKV31?=
 =?us-ascii?Q?fLS1B9Gz5Ex0U8CYjPQCUg8wt4bo9F03ZifRKV2Wax0t9/xmbxSAmu/2Af+N?=
 =?us-ascii?Q?nNU5VqeZr5XhAssz5wZHdSPMWgqZ7Me7SjHrJBXqje2R4N++9IbUmA5NFgA9?=
 =?us-ascii?Q?9XAU9hwJ8xOgQ1lBui9GIOiVpiu2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Fl0qfxysqLOd+UT5m4GrIQ2ZIDlEoiDhBjDVGNedmUOQRoFql83uNt9csEp?=
 =?us-ascii?Q?3hGc/OMD1jRdOODIKDkCsZPxExcd2qHI4VtuG3lw6as4SCNL3C4WE1pipyX3?=
 =?us-ascii?Q?nNgP29604fycuvmsECc1jqrnu2pvcixYJMgqBuFRLxk84An77Vy4oSOEeXl6?=
 =?us-ascii?Q?vrw9Uh+vlrecLzMysgYk7sMO/RMDt7seL5+jFAO5qXuy8wyijlxxaRiK/SVy?=
 =?us-ascii?Q?p+nLgOdleadbk/pz6HgfCG5iTH5xykCmnuuLN37YMfNoNkGpaZxRtJ/UfZne?=
 =?us-ascii?Q?ffTmcXkglWu0ZZ7MEmQfnMd3W4UxG9Dy9gSjCn/zKjB53w35lK8I/RdCg6xf?=
 =?us-ascii?Q?umRZelxv+BrlcPtjXw9DSHUEh+ylruwiURANHfoHG9VI+5bIACbxK1D+ENWi?=
 =?us-ascii?Q?jJmx+vkCFDuQXrBjLdd+efr+2UrtrbXZvZA+A5iEIBRLvCR8QTxGawd5o9Lp?=
 =?us-ascii?Q?jZAIZ/Zwz6xG+CEz5l+k98oRLtbyuPPvrIYrxWewoM1IXnFDlBr6MNOhuLmF?=
 =?us-ascii?Q?CMdhS+CuU4bvSYbzxDBFlLT5TaXWH0l/Jg9yj72E/TyNiltP9RIZYLMlWPYC?=
 =?us-ascii?Q?Bl0U0Z84iXokYR4/j0AFGeF0A9uMKxnwj/JFik05unFKP0ZdTzh53m2eNgcP?=
 =?us-ascii?Q?sFIo5bPPfvj1fOLRyscAAEV2WSe24zPWrGlFQlT+wfwqjYespYs4184Drgom?=
 =?us-ascii?Q?Ioq0t7jFWQDeHtInaGQ3S3H1sgCo1rfcjdTDISc+vpL+qf5uvjdVbl/neom+?=
 =?us-ascii?Q?dtryrKOdfwTg6Dx+8rjP6Iwf6W0PK7IDwAhbAdYCLHLoh/mXAPVXMAj3JYPC?=
 =?us-ascii?Q?FsI+ikqPUj5L3GJf1yP1BNCtB0Lp/iNJLwzPV31+BlseDLSje2PW1avSyCph?=
 =?us-ascii?Q?Z1enNaeesa9r457Nau679IwVduwNwHpVL1olaElldMarx97zm5auMyBzYJHF?=
 =?us-ascii?Q?1kYAehpSe3hJOblvXl0jTeQIu9OsrtEzzsFSGXxdBsiFTqFo6KE0rBxdzuGg?=
 =?us-ascii?Q?yloKVeXmd24n88GgHjXQd9fwpIM0D1fncvelWMPwBf+MN5Os7qRcHeKRCBiF?=
 =?us-ascii?Q?XoCWkeKZBtdpJFirpk59GQPTzI4jDTPgpUInDM3UfucZ+/Kh35dhjXhL9VLe?=
 =?us-ascii?Q?W94K5PzfiwO/nN7dvzjSCMgUcDilIG3vr3OqGntcv18JLtoHh7VBbNxr0Dl/?=
 =?us-ascii?Q?hKng50SAGWhkJ2ItQuogk8NmUQzqBo2fTWTxL7uBWIrj23zdzgo3wsAJj/xq?=
 =?us-ascii?Q?RRWcLxnah86cd0MDIOaoMP6i3Hx53kUMg1ZjfN2qdweNIOi0GQ/EMu3dSxJC?=
 =?us-ascii?Q?RbaY1wyY5f7jCMwMpvUZiggnON1GNlUmo5F0HRhzMcR0nm8RZicnnVEHeBi2?=
 =?us-ascii?Q?DjSGmg9pzrT4BDImLlO74jtokCXTuXuJz+hLSbpOJ82r3LZj7hN3r3/hI4/g?=
 =?us-ascii?Q?/hjvPTw38uirT0Ukdwe8cvt+cUdAmgDPB2+Tp1NZ+hL53r0K6PdLQ5Mw5FTj?=
 =?us-ascii?Q?r5n9r57CNtkmkZDHOIuaoiFnDxv3bzzeLMjUdq+CXMsHZS0l5WSuNgRd3EFl?=
 =?us-ascii?Q?UWwifIQggOGz/IQbJSLTHAsWEj3I4YlJ3hujplsR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80cc799e-ac2e-4b05-0b7a-08dcf3a1944a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 20:30:48.4493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKCmAs89J0WVRTYWNrXF6bTdavrNX0T7x+NIimAD7gHJhdV0YL4l7xgB/ePOCMvkAwj9C8pmgDccHbgpv6ua5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7173

Add check for the return value of spi_get_csgpiod() to avoid passing a NULL
pointer to gpiod_direction_output(), preventing a crash when GPIO chip
select is not used.

Fix below crash:
[    4.251960] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[    4.260762] Mem abort info:
[    4.263556]   ESR = 0x0000000096000004
[    4.267308]   EC = 0x25: DABT (current EL), IL = 32 bits
[    4.272624]   SET = 0, FnV = 0
[    4.275681]   EA = 0, S1PTW = 0
[    4.278822]   FSC = 0x04: level 0 translation fault
[    4.283704] Data abort info:
[    4.286583]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    4.292074]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    4.297130]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    4.302445] [0000000000000000] user address but active_mm is swapper
[    4.308805] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    4.315072] Modules linked in:
[    4.318124] CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc4-next-20241023-00008-ga20ec42c5fc1 #359
[    4.328130] Hardware name: LS1046A QDS Board (DT)
[    4.332832] pstate: 40000005 (nZcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    4.339794] pc : gpiod_direction_output+0x34/0x5c
[    4.344505] lr : gpiod_direction_output+0x18/0x5c
[    4.349208] sp : ffff80008003b8f0
[    4.352517] x29: ffff80008003b8f0 x28: 0000000000000000 x27: ffffc96bcc7e9068
[    4.359659] x26: ffffc96bcc6e00b0 x25: ffffc96bcc598398 x24: ffff447400132810
[    4.366800] x23: 0000000000000000 x22: 0000000011e1a300 x21: 0000000000020002
[    4.373940] x20: 0000000000000000 x19: 0000000000000000 x18: ffffffffffffffff
[    4.381081] x17: ffff44740016e600 x16: 0000000500000003 x15: 0000000000000007
[    4.388221] x14: 0000000000989680 x13: 0000000000020000 x12: 000000000000001e
[    4.395362] x11: 0044b82fa09b5a53 x10: 0000000000000019 x9 : 0000000000000008
[    4.402502] x8 : 0000000000000002 x7 : 0000000000000007 x6 : 0000000000000000
[    4.409641] x5 : 0000000000000200 x4 : 0000000002000000 x3 : 0000000000000000
[    4.416781] x2 : 0000000000022202 x1 : 0000000000000000 x0 : 0000000000000000
[    4.423921] Call trace:
[    4.426362]  gpiod_direction_output+0x34/0x5c (P)
[    4.431067]  gpiod_direction_output+0x18/0x5c (L)
[    4.435771]  dspi_setup+0x220/0x334

Fixes: 9e264f3f85a5 ("spi: Replace all spi->chip_select and spi->cs_gpiod references with function call")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index b52950a0f5f92..067c954cb6ea0 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1003,6 +1003,7 @@ static int dspi_setup(struct spi_device *spi)
 	u32 cs_sck_delay = 0, sck_cs_delay = 0;
 	struct fsl_dspi_platform_data *pdata;
 	unsigned char pasc = 0, asc = 0;
+	struct gpio_desc *gpio_cs;
 	struct chip_data *chip;
 	unsigned long clkrate;
 	bool cs = true;
@@ -1077,7 +1078,10 @@ static int dspi_setup(struct spi_device *spi)
 			chip->ctar_val |= SPI_CTAR_LSBFE;
 	}
 
-	gpiod_direction_output(spi_get_csgpiod(spi, 0), false);
+	gpio_cs = spi_get_csgpiod(spi, 0);
+	if (gpio_cs)
+		gpiod_direction_output(gpio_cs, false);
+
 	dspi_deassert_cs(spi, &cs);
 
 	spi_set_ctldata(spi, chip);
-- 
2.34.1


