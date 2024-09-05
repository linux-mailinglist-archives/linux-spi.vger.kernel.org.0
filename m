Return-Path: <linux-spi+bounces-4643-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C36796CC38
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 03:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A5528725E
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 01:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2428F7D;
	Thu,  5 Sep 2024 01:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZS30kKO5"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012018.outbound.protection.outlook.com [52.101.66.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ED79463;
	Thu,  5 Sep 2024 01:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725499569; cv=fail; b=R21n3pxWnfXalldTtduEh2b2VKy7WOvabTseD48O6dyE3OhDG8hVMvx0MNTfFTJn3yV6g/28TiIwYEK0vM6fy5ar+WSQ6LqlbamTDLRnPRn2MyyLkewpUt7T6pVP/xiO9w9l6vBRPmCtDkJwriF8SLuuyhOp9SknzTFR45aCHEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725499569; c=relaxed/simple;
	bh=bgHQVPtclnhy7cMZagwW4s/Ma1SQmCsNPjLNr57jtQo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nyLFeLBN9XK2E4aXJp7H6IfSrUwxQUHYqKeo+v47fgt2DqOOwTDJjNS+3Gup8KLPaT8ULjUD2Z2L0htVGSswHL4AcoEJbJHuMuYGaVAzVJdlLnp54Y9lorcSer1omQ+76RIMoLUMX3pyB+IYsoSvoN62u9HGeGDJfslwumzBgok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZS30kKO5; arc=fail smtp.client-ip=52.101.66.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzvqJGzZboQHFQemoIGwYL8tvkk5swFzmzAR01l9ofFODO9SD3o1ENTbDkhdkd4lt9FD9Ij1gu8c7lAZMOAowgaeeMOPpb7sLT9ROfUWWoN/ADz2qd9H33gX5q9D1g/HgoY1eFnzlaJ/PRZimmlG6Bqv55brxmpbJ3QLRdbIskMMWTVoOubMt90piLbx9D7/hFLncPEXNHyUD5cpHVgWAoOAObD12sz5wSjyUrkp715g/KY7+jQzPYfgWkDAHKVqEXe8H4/prrNM4Nl1XG6fNNPC9zEEQYLVNBx9CUTsh480+cGtW9e/ECDR4kBqqY+/Sfsp0JuN7ehWs8Mp2guD8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thvCg4480IRPM83YQl/gi70lBnBoWYQF2kfaBDmhVGQ=;
 b=SJws0c5B57/KU0up7EfPR5x2PRy1+OSRKCsVf2c/fIOEqsxc7tYEns4B5M1g0PvA4/2keemGE2g+la++xaIjpbfifsbOYgsUr9BvinvovYHv1s1f54kKVvHr4Erh3keH1Du6cXtEz+88y1nutqed4eYeZTdayerr0rYgbc96aFEReE7J2yB5hgzMkUCfVd0LbLiYKn1/QWtysSB5eKjcTfRBrGggNbBoKQC5mjqy+vM9P7KdsfRCl658l3scNcIyLyTtPBeaS6mC8D24oUu2DkH3eMkx0qlpj7vHkLJb2LwAIPSonLihaQ0dZiCsWM0G3vnTGsaCIHF+1FQr+y2W0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thvCg4480IRPM83YQl/gi70lBnBoWYQF2kfaBDmhVGQ=;
 b=ZS30kKO5T4FUUd5ZX6FetGIgNwaTj6P6/ugmElMmwpQprvVFguoMLYr8y9FmRbcGlxNvLUlc6YVUjQw7Xa51xI49uJIBi7VLUgEXYk6eStcq+1jbQgW88Q5q+w/iXuRMEiTOsuljq5he8eR6l/jYifymvInYTf00BkrkCl5FOlg8a1FsxuaNojN4PECLxHquIZZuHDe34awEGXuRdC0mNOhthLgGnwJ3WEhyHgwZptitGFIqOpFKrQdj7ScQdtdDJEcillJttqj4ksv4XYrhya1Z5X4sSOlsWT74jicDCIvJeGWe3IURpAmWj5Uq2xZmitl644UD4dQaxxKICWhwow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 01:26:03 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 01:26:03 +0000
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
Subject: [PATCH v2 0/3] fix the flexspi error on imx8ulp
Date: Thu,  5 Sep 2024 09:26:14 +0800
Message-Id: <20240905012617.1864997-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|DBBPR04MB7497:EE_
X-MS-Office365-Filtering-Correlation-Id: 82feb8f0-e51b-47c7-7efc-08dccd49b4d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2gIZcL6HiHldbiijlDXt7dYImPcl0qK3UuKGhlomD+bKwTWIpSTj3uXUiHTH?=
 =?us-ascii?Q?FQPqbrz+lnW7xwFrgBX2e4nGcPXaqfZcN4XzeSLmVvOGcSPip/9P4wCSK8NF?=
 =?us-ascii?Q?pn9jSi4FOadnDyGqcMc/x/+buXPGG6SgeC9ApWVcd9HxR+wPjmr9YdErKE9q?=
 =?us-ascii?Q?6XKzl3OdvqFOzsUidUUuPynyHtoJl1rDRzBY2A6Wx1us2Aaf8IlSigN9pxIM?=
 =?us-ascii?Q?s5nNvv2MLVA0hjetyJGxhw5qv/4xirIXmhwTZaWQ49yxlUv5WywQxHypakSy?=
 =?us-ascii?Q?BUNv7CTbcWiGt0hYdbN5sqKsvp2nbSh5aDptxiei+3HRP3NGIVGtCw5hleXL?=
 =?us-ascii?Q?30ji23YKfYSSQ9WhvSWJQrrFZ9qtpMAQXxwWE9Yf9aBJY2P6xP3XyqUShqdq?=
 =?us-ascii?Q?nQdDgJ1JBmdS99ynGI2oZYdmZ9BdnmsdFD5O/JjHImaGtfnj6X1XOStUmNuM?=
 =?us-ascii?Q?Z0vsc31UmRdgE03wrWdFJbNJy2x+Mg251dD8n4Up8A++7ExvWoHZ+Dp8/0UY?=
 =?us-ascii?Q?C8JZE+3AgkU8m4orqJWk3Y1Pvw8YO+xzq3kjFUlXi0Cl9LaYJ8wqyDfBDYiz?=
 =?us-ascii?Q?UZ/i9gz1zxAL0t3/f8nAnph1zsUN9UKvBLylHFSDlL4VCtXDHJtA2rntig4Q?=
 =?us-ascii?Q?mFtgRawx5jjuMuHmFV0NEGcF4WuPh3G754SeMmCMom3VgtSO1Tpaks7L7vwQ?=
 =?us-ascii?Q?opynO2h/+QMjM57a3qfa1GmJBVQlmUwCBw/JGI1D4vfSRU0PxjoLrEO7q6p7?=
 =?us-ascii?Q?EvB4mWaiZ84KWZHVzLVfWxPEBVXPGVzRXDGKTgWhL/PB+acZk5ZrY9WlH4JE?=
 =?us-ascii?Q?XcW6DteKXw38ClZV0UCmESWpoyL+ynQdST6ql0ueljGMmyogDwDA+XuyBDRA?=
 =?us-ascii?Q?D0q1VBOggMuXeWOYEPkr3gkKx266Z/rIymqXyfGllSBbXbLUjYJJMeeLu8Vp?=
 =?us-ascii?Q?zvVdkj0Ya8dh6fOAVdo6si84Cpuj1MKw9xIdHjy39L1pTKLrSmcvfdfrREKo?=
 =?us-ascii?Q?uHesq1B/GnDITWyeK4gaQsmw01mlsx0pXiNMVldu05BlkCLmQ+69V9rU8C1o?=
 =?us-ascii?Q?3JK/2/B8CgdDprr3o11dyuip6IJBIikezVopoW9QCJUjotR3VWRoENIYYvw1?=
 =?us-ascii?Q?A7qbKrMwRCPit5Y5Tqr6P1Zuk4QRwqrlKJw0JtHLbDMj99CoaJUXeWkxA1KS?=
 =?us-ascii?Q?PazDJFkn9s8U6wQhMxUmF8xxnSgFi/DP0UmX3UVXaEV9pDNdZRHZDZWhbnil?=
 =?us-ascii?Q?37leuDra/EZ29YGXnZOczRpNXjF0eXFo1wEE5IUHmclwh3xSuORZVsoheRv6?=
 =?us-ascii?Q?vV+m7fhgb26noaSf5a+H1duIzVrwUuI5jlA2SNPWbSb9oZERkMSKoLBXDPsB?=
 =?us-ascii?Q?61RfmN+ZEDf0oAIAgAMuyKLXthODn+s2Q7jVi0ScD/I7sK8GUQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1qRDSMAkvM9MdfOG+ccTYbAr6xVxJVFpBpAr9np4qOlMPm0sVAzvuc2gn2hv?=
 =?us-ascii?Q?f3r5brdMEgxMbAzEB8WVDBv4l+uI9fk10hTE7RMiGhwVpcGF585yN76/f8RK?=
 =?us-ascii?Q?pX58cv2jNVC9K2lfAkXW/SMXjtBzVI+RnDu2G8QrwnY7qtq0CDxQYVRd8em/?=
 =?us-ascii?Q?AQs9hKCfU2B1jW03yBrcz67TG1IH8EmclIG3ak5aqma6HiS4oPIlHZu47wkb?=
 =?us-ascii?Q?U5/GH5eYOQIJ1IzsvKPi4sq1sptLWzKRPGHRFfwMbNw1wSuRsSjEhnCqy+a5?=
 =?us-ascii?Q?zs/KcnPxvAuod3QblvMCS0Yyjhc6CGUATMaRgH6vRMZDPNcZyMQZe78rKCO7?=
 =?us-ascii?Q?uM4EPhldX6ej2Zt59HQ6YVzymh94HYGw6SeODkm0s48KniiQ49ttpGwUymDf?=
 =?us-ascii?Q?K1XrMhM1UgcaJYIvv3fZpMohsg+LVp2FoDEsGIC54Zeh58sy+NEjJvEzNDh5?=
 =?us-ascii?Q?B/p17mC7UnCT82Jy05RL70fI0u3mUafSmVyCsAyaFmXBhvzKSTgOJ7Rn/3N6?=
 =?us-ascii?Q?z8CB/qFOYs40XScrnxuRELEdlXLnvHwlNU/01nOrsfH7Hp/arG6laTl69+ed?=
 =?us-ascii?Q?ZOeqaf/+M1PzIK3w4NnvRUsRuV7hmlZjDMNL5pHKfNIVURMfLZLBV5Nw0LWy?=
 =?us-ascii?Q?SESY4gsYS9x+XGiS4Btktl9ySLfr+Ne/2tJPTRgy9S8PHr83afiTZTMWPqDX?=
 =?us-ascii?Q?ydHYFox6t4B8siOHvH5QPjipELQ5aFiJXiWhgbTnm9tWVjKbpgpQLjveKJ+w?=
 =?us-ascii?Q?uyc6zD/nSqbamRWK6pd1XpfJ1UgFZEwdDwFZAcYKEekJKh9VQsKfiMTtUzp3?=
 =?us-ascii?Q?OjvDbg/VjXK+l8J6OX2t+v3oh2F0OFnOQtVpmh7kuNxL4o7xWgOO4FHQlSpY?=
 =?us-ascii?Q?srueEZR7Upm5doFLFpWqN6hPuyFO5y0qJGI9sLytA/sN2KCcsE1K5kltoSXE?=
 =?us-ascii?Q?EpMo12IG4GrEIrtnyVWgdMN9WUm4AlwqnWIB8Rio9JItsYtxGsZ8aQSW2vje?=
 =?us-ascii?Q?pFCYs1G0s62a0mgr5AESjbvpK2YnkgchDYbZe4NribrVW49WJ9rJN0KzcEHd?=
 =?us-ascii?Q?87nKKEaf6lsNm3T5waeZkDTO/YDRV0/ZLSbBF8UT1gXh1I+zkxSseZxIvTk7?=
 =?us-ascii?Q?cvKPIJW9NuWDI8JSPQt6TM+Sb9mpgIcbaWLh/L1yto+dDDsv8z+L1RDOVrk5?=
 =?us-ascii?Q?5cVtMBOFxYn+UBA/hedZdMceFS+Qz5fCS+qJ8oo6ykURLScy3tE/4Wk4/50H?=
 =?us-ascii?Q?gIpV/RzS9JL4KzyXUYBD6cavw22BzMEr+ixPYq13sZQLToAfQwonOpikUV4L?=
 =?us-ascii?Q?7rz8Yq3TJlaZ6ek5a4IcqwEZ1aD9A/OzeuU+XlolDp1PlzDAozOQn3me1Fk9?=
 =?us-ascii?Q?vU2Czi0xBjH5pG4q3PZxVL7atUS73qmRpgvINlTvUC5c69B/gm9hAzUrdAP0?=
 =?us-ascii?Q?6uj7neEJx9TUEkR06ZtLKxhwKBQ5GlVc39DC2rncS8Q7XhAdO5C1jYtXr/JE?=
 =?us-ascii?Q?+FVmpd0uIMrfEX9O/kF+ZWMMK8NfPI68TP0eg4rzlhvqOW8dLmE+f+a47wuG?=
 =?us-ascii?Q?cZZSGy/im1U8tiIHv+bM2miL+kdS52B+ba+owkqj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82feb8f0-e51b-47c7-7efc-08dccd49b4d5
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 01:26:03.3822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z7dl2nlBxnfa+A/yQEROhJTEgQPw6bxggTFhxllg76c7wTLQiDlhr02imLBBvTW/d51rzMT79S2Wb3kxH5Pt3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7497

From: Haibo Chen <haibo.chen@nxp.com>

The flexspi on imx8ulp only has 16 LUTs, different with others
which has 32 LUTs. So currently flexspi driver will write the 
wrong register when fill LUT. 
This patch set add a new compatible string for imx8ulp to
distinguish the LUT number.

Changes for V2:
- Remove the change for imx8mp, since this broken users

Haibo Chen (3):
  dt-bindings: spi: nxp-fspi: add imx8ulp support
  spi: fspi: add support for imx8ulp
  arm64: dts: imx8ulp: correct the flexspi compatible string

 .../devicetree/bindings/spi/spi-nxp-fspi.yaml |  1 +
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    |  2 +-
 drivers/spi/spi-nxp-fspi.c                    | 54 ++++++++++++-------
 3 files changed, 37 insertions(+), 20 deletions(-)

-- 
2.34.1


