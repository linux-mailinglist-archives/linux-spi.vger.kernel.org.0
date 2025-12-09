Return-Path: <linux-spi+bounces-11827-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAEFCAEF93
	for <lists+linux-spi@lfdr.de>; Tue, 09 Dec 2025 06:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D486E3031981
	for <lists+linux-spi@lfdr.de>; Tue,  9 Dec 2025 05:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1438031ED8C;
	Tue,  9 Dec 2025 05:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mZjg5fWK"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010013.outbound.protection.outlook.com [52.101.84.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0464127467E;
	Tue,  9 Dec 2025 05:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765259818; cv=fail; b=gFMWqudIzVRFv0VwjSiKGSefiGFOsHgEiIfkPRf8RX8uLFTEP3vcZuF7NlXI5AfRUxwr0QLKTFg0Uzof8ClZ5mMzXmfQSS4aLRLWqkmRDdU+YKopYsw3KvJ8mbl7jZhNYBM2NUlq7X6Wjsh2QHnrtdkHpUbP2vdWyg9gcllnO0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765259818; c=relaxed/simple;
	bh=keFHHR/lzrQSFeWcP3qpCKWo8FMMBRCutN87YgqfXb0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rPAg4m2u0G/7YxhFwqLpbdwVFXa/Nrfw59YSKsJC0AkVAXMMXuPjXjkgWtuLHVhsSoWgAABMXSLcfsSDzJukPv/cIUBRR6RU5frSbLujA4VZA7AlXO2YNLTr1jJqlSCU7Dy62Jise/shIMHu/dvnwXgsZIvArTI84i0UBhTykwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mZjg5fWK; arc=fail smtp.client-ip=52.101.84.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPC4Mc/KQxzHcDBNKu27oRVMBFrgwyogXN9bJD+uBbFPpDsq+oESEyTUK5Ch1oMxCqSJNSTeFtT6QnGURGIxtSvWyuTgWY7/XD79KABb5Hn2OkDp+QvZ4jv9qEtce2vodYkEL9mI+zeBYqfoeiM7j1hZwtgMFb/JcENworWtikBAVvUVcw8/OZwMYXYguDwn/o7qqOwY7ZoabynbDFNqgX8jjIfN2JX2/WtQlgqPCiC4n74DZZ2fuDY6rhHXxMUqQ5B4SPPvIBOfycGuJPm72khrr26vXtm59xgF0bk7HscMAEUJU0SQdctIH6PN0h+aXg6WlOIHFQQGVfARrN/gfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZc/qxJZ9CtLKvbfJpvR68SKk4r7VbYlWdS4qTKtSHc=;
 b=S4djnFrs0eDUxrqUlSX816ihwIntjGH7O9+zqPd9ydJ46tSS2eb5CycODVYG4LBvTP9Tu/QSGODgMqU4KeTvDyueZbU6GWgMQv6l8dZ26eIkqt1QE81uMGcoV0kvytLnFe2HuSAk5XP1aofE9OqFcfLpKsW2qFxzC/f+8BxQzIIOWtlUijLhseT62E2SLoYt8DB60PctDLhQb0myLsJpENXJcj/K3u55y4UtSeygYbXqAWXwBYXCDw75UK729Y0nV1a1awiTRYCHIQGNrVo1CBBsA3KPAQr6l8VYSNbGfVW68H+P5FfQB0e9LBXaRPJT1ZKApYuXMkt8DWRBL8olKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZc/qxJZ9CtLKvbfJpvR68SKk4r7VbYlWdS4qTKtSHc=;
 b=mZjg5fWKSJibTGxEAZog6xgcmPnh/Edz+0d8JfgrL8o3GlhpEcKZujHH86qV44eLHVSgRumVYt4q0/F9jhB+Jeh22Rlz0vd1bSM+Ey+GURzNSzo+nMhBf73BWeidu1KJWWprgH7ONGi5tTqXd3zOtYgBxRjLQIEnWxahdsOke1peOgZSnmUHRzvm9k7PosJDxMhQh9t2a7I6eYTkKzQElO6+QmNxkX4zf2NXzMt/DBbSQXdPbO4Ft+LVYe1M51afUPJAPMCOhB5kLtFKO612h7dqb+zatnxv8vfwKiQBvIZ69t3JVSjwf6TgpHsXn5BdCMHlIwgcVMGLTUiiTPOW4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by DBBPR04MB7785.eurprd04.prod.outlook.com
 (2603:10a6:10:1e7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 05:56:54 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9388.013; Tue, 9 Dec 2025
 05:56:54 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Frank.Li@nxp.com,
	broonie@kernel.org,
	daniel.baluta@nxp.com,
	carlos.song@nxp.com,
	andriy.shevchenko@intel.com,
	david.laight@runbox.com
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: spi-fsl-lpspi: convert min_t() to simple min()
Date: Tue,  9 Dec 2025 13:56:34 +0800
Message-Id: <20251209055634.3845602-1-carlos.song@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:196::10) To VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11147:EE_|DBBPR04MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: 460db9c4-1821-4aad-9d8e-08de36e7c0ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?78uAbohAhzO1zbfuGtXhVReTLwWYUlQUuxpL7KwAs8tXkob9mdj4ZynbCSQy?=
 =?us-ascii?Q?WQ0HFHdtmWAFp+ge8WT8doanOqngf4nqW5Mfg4a6lzJzQEH65zQHSF3ykYVw?=
 =?us-ascii?Q?DmgS4dMdJCKbc6D/1r0UdcPiuNmz5nb7PIe996/vQTSsVFH+ux8ne0MDKuu8?=
 =?us-ascii?Q?G0gR2gyL3uaQwhNK02LRSlFotzzSH3z4BJ5/6ZylxR9LgxcE97zcoD8uiOnw?=
 =?us-ascii?Q?SILpcY8wvGgy+vJXRzjwSCYjiWh1hw2BmamlhlA1odoYZEWJcdpznSmDS7rK?=
 =?us-ascii?Q?6NEkD+MuMT90eNZKSKo2MQGgoLvTrvSe3nQLWLbhbGb5bhv/AfWhIm27H+lO?=
 =?us-ascii?Q?vo5pZodISrKwjbOb157d3rHvyO7rBb95q+ULd28LObUnXSSy9AnJTat1MGM7?=
 =?us-ascii?Q?WQt/XHdP4kl4ZpTbpRKjCpmRJX8Je6zvdaaZMrj5Vk6i6WF9q6EOlz6nWUkk?=
 =?us-ascii?Q?obiyfqHV+iKcHBndk4q9WVirgOf24YAa5RcmsNkmw83Hohty+MuouNRc0cJA?=
 =?us-ascii?Q?DanOtNzOash22ZCTy/D7TcC4Cw5cIXz+r8IdIXd4zMhUSX5b9Yv2K7wsSNEh?=
 =?us-ascii?Q?LGFehQNG12tJ1pOoETX6reHel4G6emqMKchT4LUglzQpYEcuCOLsFG4U+g4D?=
 =?us-ascii?Q?kgjgLnTCs+k7JHlEkSXF9SxSD6MTtAgZdbxh+bVjYVW/ZxLp8AJopX4DZyf0?=
 =?us-ascii?Q?gjO74T6n6naFv1PINLZJeOjleSxDG89ealRT2cXazxmMlucrKFahiqERHGwb?=
 =?us-ascii?Q?SXU5C3O3vVfcEYz/Oak/AcIfsDLfDLZHc3qVrhMQ1Hz57W8YscfIfno7798L?=
 =?us-ascii?Q?wJEvpeBPp2qJCdERHztcHKW1rsEIWErDJHBS0zueyWal0jGuZtx8PAuYqo2N?=
 =?us-ascii?Q?tjFavQqArWe0a/gOKYRlzqvq325KO/hTPS/9JiSbYe8m98CQD1K8pIB7w0lS?=
 =?us-ascii?Q?tf6vq/wbMX7HwToXPlQJmHccniZlk78y3BamRweD/S1k64L+q74op739+J8e?=
 =?us-ascii?Q?tClDyBdV+W93Y0rjprmpiHWRxyNpfdXXIiIFYR51YoKvMWV2+ohCREtezwJ9?=
 =?us-ascii?Q?sgBmKJONznAuyy+s8x3YuU0rAHo4wA/S9qGtMXvTS402LGe6lULtrArj/A9K?=
 =?us-ascii?Q?OwhCv7uZK8y+tOG56amGqCJPsmOZ3to+zYoaB/T5MHx/J/NTTQJQnqS6EIAz?=
 =?us-ascii?Q?5QMSi3wfvJh6z6Yq2H23KQgWy+4Z5FtGSmhP1JYPL5M9/umoIDK2kBzzR3Rk?=
 =?us-ascii?Q?I2pzMjRIV14Beir71X3BUt8KmA6wFXotlJiqaOceul7Dva2nlRPgW8PieDZ3?=
 =?us-ascii?Q?1SFbrolhzOfgjw/UiF4gJSNlPX5B4NoDo4XBTQNrQGoAQcq8uGrBXNFtjs9N?=
 =?us-ascii?Q?rcog2MzbqOc0dn4klGbei1Rh6Hu0UZpHXJOXYZXwRnxgmyjlD73Hvm6oppp4?=
 =?us-ascii?Q?aGH+JZolN7t6wGNms7cdZkI6oArZegwWzdyyESqi5ecrxCC9nICpiEaHoEBA?=
 =?us-ascii?Q?NSxWhl8JfbUYVYsEDrxtINEXNK3eeyO5oClz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DSm34libpTr3V0OBHAgsxVAEk5IYZoPB89u/YD47i2sQEJFwDiIQ4C4s6H37?=
 =?us-ascii?Q?Z+Hr6NfSN8mebSOK8jQFszdv830sn0jGcejk4ACOEDn0r/Qtth/30V4gbv8Y?=
 =?us-ascii?Q?AYQd9ZKcEh0UqzF6xu/8E9BFdbtwvKdun/HG62L/v8cg068N1jTO8/f1cZSD?=
 =?us-ascii?Q?0G9foXadDVHjVKQN5vY5Gck20tYrtzGjfqqJVUVc5wq94Z4QtMcvjakWRxZu?=
 =?us-ascii?Q?X8LdV3/xth3KSBczLFa/HF11vtbkFZM1ictwHXDzTXbrqFb+HpyhXP4QQwue?=
 =?us-ascii?Q?tXJzdRI26goptRqNytTa8iCV230KP0ObVItosPaTRqZvhTEsp957LLwZI6IA?=
 =?us-ascii?Q?9z/Ei69vUfQdBT1zJP9Y2zwhRvXMcK52Z1XEFGj8kfp12kj0QFC0GZDvZn1H?=
 =?us-ascii?Q?u0cU3gwgz5SZnlbRXvqv8GXyKUpuZ21infJrMRBlNpGo5octR98gS712316v?=
 =?us-ascii?Q?d5wwn9K27okUAQfh1lgOkrFJcXkLEyV7YEEsMkmr8stO0Mie0hO+R/3S2DRz?=
 =?us-ascii?Q?oB8RiHDXjesR3ky8JdwEJtAg0i2095MVEWMOsgnf4C/Qqb0h088jMFveg41G?=
 =?us-ascii?Q?mbjjGIVq7JxzTlm+ZVDNIUqOCRPBEM+A0pEI2npCz2W/TV7vReIhC4t7lN1V?=
 =?us-ascii?Q?JzEYWT8nhb6hTUB41Q+ZKFc8ETFqQ8C7MRfYbp5jcvy9Ym/5CyPPYX9AUvqN?=
 =?us-ascii?Q?AER34bnbNUsgzY8NJ3l4FE9x3mJdmnSgUIZ4F7lGIjYJ69yoeRS9/H2eVFsf?=
 =?us-ascii?Q?/lkLsEaojw3iL6dSER6vO7ht9MRmj0ItY4ghRosBJxPNXrwJ/mGJMDSZ9Nxv?=
 =?us-ascii?Q?5Ara4f2Dc9YWwV1cLgYx6iU65arvoZHendiLRb5rSB/vJ95yLaQ/7Tz0aVSu?=
 =?us-ascii?Q?WYGDCqo/tCby+jOVASRLfW87U4NoLOl4+Myc++OrEjggUzq1A6W9wzX1j//+?=
 =?us-ascii?Q?BbrSfIh0xybA1ER4PmF74vxaFqu7ypS8AyqED6zfle6lx5egXIgeSaZOvpyj?=
 =?us-ascii?Q?83wrx/P8PTm6MoSY1It4Yrka3CqrjUZ3a95kPF2y8bIgPBHw3LkZ97XaSv6r?=
 =?us-ascii?Q?Rsx99//+LflieVsU2c+Nob9F4WQR0y+vQsSWnjp4imL7Y7spAezMZwAUMjqs?=
 =?us-ascii?Q?ubq2e0BoaZzPHWNSBFwaU1kmqhkpS3J8RwbnYQ8nB/sQApYevJnqWmy48dNx?=
 =?us-ascii?Q?pDNv6A293yG70zQNVRWSeQ5bmJQiI70HzJ443BbVT86tzmkMV2Mcg7lz7joH?=
 =?us-ascii?Q?I929ZF98khS/0FP1SuB2E7df6Tf8DW2TmTe0HvqF1xwb6yLFhqCZ9eEesSh5?=
 =?us-ascii?Q?dKCNg1rSd8N9XzcgXqNV1ues4RC9Rj818QeqQ/CEfo5S6CyLgJZ/Qx+pHiRx?=
 =?us-ascii?Q?UoPvTuJTAn80YlxfpAC3mS1RwLV/C5Gp0CJzZFpQDEASY9agEAd8DX51fphQ?=
 =?us-ascii?Q?tr7U4aIcRQACvpe4Jwiara+CnoiIhVg0Vt4/olDpahLkyiNNV1j4+zELTiMw?=
 =?us-ascii?Q?hQBq2VgWI/apbUrZHDons6pz4q8uBf+62/R5Lz1iL6N/ddfMZu35Sdob7zQ+?=
 =?us-ascii?Q?i/XuVam6f0RCJJFSdUVXQZw5BoIc38ccCnwlLo7H?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 460db9c4-1821-4aad-9d8e-08de36e7c0ec
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 05:56:53.9171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TK6WSHmzSrscE6IwY8KpRu+6ksglQi8sqfw99tRr0Y8cX1zYlURR8lP8nXr7GojiN+M0cNDwZ/cS0mGd/vJCaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7785

Convert min_t() to simple min() for better readability.

Fixes: 9f0c21bac5a8 ("spi: spi-fsl-lpspi: fix watermark truncation caused by type cast")
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
 drivers/spi/spi-fsl-lpspi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 065456aba2ae..01c674d466ed 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -489,12 +489,9 @@ static int fsl_lpspi_setup_transfer(struct spi_controller *controller,
 	/*
 	 * t->len is 'unsigned' and txfifosize and watermrk is 'u8', force
 	 * type cast is inevitable. When len > 255, len will be truncated in min_t(),
-	 * it caused wrong watermark set. 'unsigned int' is as the designated type
-	 * for min_t() to avoid truncation.
+	 * it caused wrong watermark set. Simple min() helps to do type cast.
 	 */
-	fsl_lpspi->watermark = min_t(unsigned int,
-				     fsl_lpspi->txfifosize,
-				     t->len);
+	fsl_lpspi->watermark = min(fsl_lpspi->txfifosize, t->len);
 
 	if (fsl_lpspi_can_dma(controller, spi, t))
 		fsl_lpspi->usedma = true;
-- 
2.34.1


