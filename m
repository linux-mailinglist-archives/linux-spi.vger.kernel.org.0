Return-Path: <linux-spi+bounces-4334-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0989604FF
	for <lists+linux-spi@lfdr.de>; Tue, 27 Aug 2024 10:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6DFBB20B41
	for <lists+linux-spi@lfdr.de>; Tue, 27 Aug 2024 08:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478E517BEA4;
	Tue, 27 Aug 2024 08:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="qgcQxVOY"
X-Original-To: linux-spi@vger.kernel.org
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010039.outbound.protection.outlook.com [52.101.128.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8680B158DD0;
	Tue, 27 Aug 2024 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724749088; cv=fail; b=RPg/w3avbgpHPg/52DlZZ4OKk0dndKYQDe5+M9MxZcF4u8G6utA/lriVios7spZPvF9qsXKa67nPRvHQ6Nqc7BI9ucSKZagwOY4A4vqDLntIuO0pDLOHUqCxBzg8Od2+3yzjeIbs+SJAHv4g96Qu8wlFXK35s9gSeGpZThWfup0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724749088; c=relaxed/simple;
	bh=pw52ONbiz1mpKdpuTb2Eohk5aKT3RblYiJZpacJng34=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZK6rEwlNxev7s674jc4nktU8oTN5gsMjmpPz7qCZD12JDJTFbmyUFm4GxEollX3dF6SZ93qJyxdVZ5dI6qBlT4swTb/fhu8sdKi6PNixE/qVqKI7zbFnntohRVF2z/kJdUUeRuyNuJR0KC27asH8EnDhujXHyU6zXP1r0tw0lDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=qgcQxVOY; arc=fail smtp.client-ip=52.101.128.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjjSjmeyhebkOYtXURx57btMeUnqmlk6M89fk5Q9irODlw2+BdG2gJYmvzPySCFkV4fNRLyFvlJb8H1Nh0YfkPecUEGt6z58kIohmnW2pXE7HNsr/3b9/wi297PWzraHhVb/gnAD91JElZdJS5Z9fl99FPeoxUNoOehrZpv1BIyhZ6WAQQc7e07mtQESMG2ysOpZh6W8+eZdfcX1UCIwOhk/X9bagFVj0TtaYjskd76P2wnuZbruEL2cryqNbRQvKrJgL18hzceUroIitx6qvtdFMijO9wYx43FBemJ/t68AT0iPtNk1XEb9YgQ7YqTVQgdnhV06K5Lq/yxaWeB2Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rOvbItxax8oqxr8kRBnE87x2LRPUEb+hBpTqh2JgQNY=;
 b=i6PwVmuP2QKYM3IduJ0oG+YPh/63aojH2h2KdgAkQ0PVjSYTBbBoHMOcRHf9HvWRgLnt2J3bsIDjsFo8nByGkTfNII2PnQ1KBj5m9//iSPrzulUaR02k6rjjgiIx1bUsd5MtFr7t9tXwZRsOUdkM+fwYTmXIzZs3lgwavrahVFTB6QLvAuwk4FgebDjhtNrRqCTv6krxxagGpH7S1hNuauh3wug/x5GpD8BDzvAn7Zs3qkRyVJ8tB5+Pe4tPknVsXlWbsKqpif7W4U41VnwyIs9VXOaALZ2IkFf9OI2DnpAryxqObXqTVVIKDVPMnmcD/m/ISQ4EeZb3wVpptg4NAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rOvbItxax8oqxr8kRBnE87x2LRPUEb+hBpTqh2JgQNY=;
 b=qgcQxVOYIwVI7FdWdFQC7+UaTDO1OZspBW1bfAUiWLtocMgpTcvnbNZx9894Y+VUr+KywbMqe3oVaBIwjKRlQsSkt4x+qR13WojazCKPVHQPFz7wp6TYgGJVWhfLxRQLIWRCdxDDrGtXPG/K1GfcK7hG7PpJ6JWMEqF3x+9CYqSQzNs3D9HXwCbannePFo1ubs6DaJ9QmTak5nj6nmXdId5LV46noOksWtzwM3AWx9QBtzavrGCpUDtGyoJq9FW+UCK/8xjdKp1DnK3OPpPWC81LUVgAQUH5sAWipQ/u7i259iTH3bqE8lHo2rYB5vg+de33rRrB1Z8mjbKAgJIrjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by SEZPR06MB6720.apcprd06.prod.outlook.com (2603:1096:101:183::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 27 Aug
 2024 08:58:03 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 08:58:02 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: han.xu@nxp.com,
	haibo.chen@nxp.com,
	broonie@kernel.org
Cc: yogeshgaur.83@gmail.com,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v1] spi: nxp-fspi: Use min macro
Date: Tue, 27 Aug 2024 16:57:39 +0800
Message-Id: <20240827085739.3817877-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|SEZPR06MB6720:EE_
X-MS-Office365-Filtering-Correlation-Id: e752666b-32ae-4ce1-083e-08dcc6765ba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xpq4QtPaycsXPCwPQt430+yxhhzuloKg0xDb+HgPP7Z+ifWgd8lZbJl3B024?=
 =?us-ascii?Q?Cv0uVQnGWb0qGe5YIXDVP7+ts/XRDUlNU9+J8tTNLWjpnV4orBygnDOImd/J?=
 =?us-ascii?Q?Quku21sUJBQz4VBfNIaDkeOgQP30jh0XDGP1j27rDnBqhcU8TxZbtH9pXrbb?=
 =?us-ascii?Q?+71VQpCO+6hKMjFpzwkQC3JQcZ2FV2N/bs3Tw1VtkCtE7xFHQ9IOlf2jUeQL?=
 =?us-ascii?Q?Kq1Afql3L9OoW4PxPa41Im3vcn1rQvAm9NfU2c+hOS0OQKgfdpMX3qLD9NBi?=
 =?us-ascii?Q?vPy7Be1fAImJ838mg+U4R/7xjoHmw4PxAb+LnOt1iXswks775JFV6iHM3KKN?=
 =?us-ascii?Q?cytnwfzBZORjYJ2D6q53ngXJiW5U1LkziedtfAChAbIrhJ9tQwXvLqBqxXyc?=
 =?us-ascii?Q?tQ0VUHjB1vmFB9ybFJINewVOp9di2zYpOLy2QxN0aZdk10mzbr1giE8kheHw?=
 =?us-ascii?Q?oLJ3aIZRg24Ou2m/doWBNRdcB7yqFfNvZXNMBRO4r2ayoCb+hFpJobGc+q+X?=
 =?us-ascii?Q?JxtnJptZqWhPKLcd9YoCRT/wMJH4wbgqxVmpgIk8Uocjm/hbIBqYUMPulCB+?=
 =?us-ascii?Q?c2U+5E/WxpRoh9qgWMHpI3gZk6XH+AMIf/+YftSV6lNHJ8Qn0AmOjEyWb9j/?=
 =?us-ascii?Q?WpAG9z/BJPXFuVslnFljFau0rderhqdReChmjzM20WLKen6VpOy/fl5Beoa5?=
 =?us-ascii?Q?XdS9djrrBc3oFEnziccMYA8ECeyQdL13rpV9H9+MzsrmkXQRwXv4yk5VRd6A?=
 =?us-ascii?Q?3VWWMFhc1wdP4ss+tffnXlDiWvPbnrUJ2jzI56Ys7AyTJFpow1wfD2lbRnLV?=
 =?us-ascii?Q?2tUVzX7UnLNTQlhtTyYAnH0qcN592DIDUhoTkyYYELgiZL8oaSv4Z3fGSh8J?=
 =?us-ascii?Q?/6FY/hl0nJDI3oFgK94VLZv1rjqfoQ0Dq3ViOXSnLXKDSoQt2Ho9tHoULdXM?=
 =?us-ascii?Q?GDCQXBRNIJpXIMuvF+H/nSawKA8QXePQ8SLbUJEjV1WrCBYRyaeDI3GewscD?=
 =?us-ascii?Q?mR3fXR3X/ygoBW+gl/oGpxYnUAgxhv6pmKkAOxTnfN3VcD0sQ/JsIAbyp57N?=
 =?us-ascii?Q?Z23Xfm8WyZLDmtu6M1DA+nQOCmhbGRZrhrlRbNxoLXvvBWv4iQepJY7Ubm+y?=
 =?us-ascii?Q?Zj/2fgfpFhszyBskzpg2CTIaMmu9szsDdniRjKqtjhzTdy7xVZ65NN9C1mQI?=
 =?us-ascii?Q?evhWPHXEnKjpMGcflhS9SkJNGMuYn6v/HoO5R5PgIzlbPPzuP4hJxGkIe0wZ?=
 =?us-ascii?Q?A9foYpL3ttO9ns6AM8GsYJep9B0GChkZRoC/rUeLi6kU2URAJU0picnszGkR?=
 =?us-ascii?Q?tm4gVNq+qfsZC54BC9gSywbyhaNHqyh3INIe8VBsjplR5iv9qgJBWjDxX/77?=
 =?us-ascii?Q?3yWpDdS37equb0HPNTb0Ldaz6NGo18HL3MNy9rzlmdf3lhd5QQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kAmp1l139uUidWrF+es0vhhlEdNs9bvDy/KkGMzl2ShH/PwCwmt3zLnu6BCg?=
 =?us-ascii?Q?Zy8sfGCMkj92CDy057cPiq51+Z6zvoAwy3SYasa/T3ODpr/CU6HlCdlm/HmO?=
 =?us-ascii?Q?HUPhn+gvBSkdRjq7oYv+E0wUXY4q2Ym+NmcL/QEZ57mok/34AHacm9Vcw+yk?=
 =?us-ascii?Q?RZ+zPTFwJea4Qs6siufjAZricoR0Cj5XIXuwOzyKUCx/tpHS8FzQqx4VblqH?=
 =?us-ascii?Q?X47+SA541WJLd2wy0mLxZpUekRfIUEOVhmD1H+ZzAyJUXvOlpivZqlItOv8d?=
 =?us-ascii?Q?1y6s1VhqZ37le2p1++gyN/aeV6XHkU5EPQOxFIs2nmFXAruVEBerQPB9vpRB?=
 =?us-ascii?Q?D090B+rnmu26pkeeXNbGXAJgvz9aJyBRXS3YjV8p76t6Xf/ShVvAlojiLojx?=
 =?us-ascii?Q?E8WWkAhQUceiQuYzEdzLv4WmqD/5lR3a2oNfqO/wjnrhier3Kkl8sX/S9Qur?=
 =?us-ascii?Q?GAY5wYPLoNMwLyxXOICqc0w0PQMqXa5YSsOMG19Lo7A+9Z6As7p0WaHYEKxp?=
 =?us-ascii?Q?QnFYTlc018rRgmbD4jNP8Tju+btPaEmxrpLgLAg6ZWS87RGBtaDLOhBqg2xn?=
 =?us-ascii?Q?wSbERII6Jii14qCElfzEHKTcg1XrM9SUIjLNxAKExaCmoSGXtmadQI9p4xlq?=
 =?us-ascii?Q?G8xayVbCWMKLDXS1lg1LVoQGEt7LYkcWr9XdmnmAMjW1BjHA4PlKSj4K40L1?=
 =?us-ascii?Q?Bkx8t85on4alGaT4SGAjxJnHVXEcAZ8sRx4xXYd459//TRY/i3aWR89SbCA5?=
 =?us-ascii?Q?DLHq8UDeswwTmXAkNqz+w0iGQ6WbTN9X7IsknWSFN8wlwSY1cLv8dL5+vmqh?=
 =?us-ascii?Q?E9nb7HAtaseQfaJQ5dtVvdRH1Iqvx4OwQKnyO8IeTcO4S8lDbX3t4AcXtyb4?=
 =?us-ascii?Q?e6ApSxdxVxKQ6DrDjXG+9sReJoSDsJXnP5ecqhg1dw7gqp5DpOWmj34J4P98?=
 =?us-ascii?Q?LX/LkL1okTga+O62viupQZIuMQBWVV85HUsVavBoDbu0tJkmazBq9CYQw/HN?=
 =?us-ascii?Q?EXKFNxNWHOGZnLVv2l7kXngy5lIf3Y/VKdDdzZqN5MBXRYz/8DRxOdEMotQQ?=
 =?us-ascii?Q?B8FS/hqc5pXFDswxKRI4DdP0toB23jNdIJUsujPnqU7qPsekQ0QKhgCLPSJW?=
 =?us-ascii?Q?HMCW2p7suK9h0iQC6p8M0xJ0f0CQXpCnQtwViEWxiyg7crjnSjhZwAZd1llx?=
 =?us-ascii?Q?MWfOiz1XBZxQi/hmMQeEiw9zECamqB2ETAinXUuVfOYDZsfAPd4TsbYPGpyV?=
 =?us-ascii?Q?uNDKnZE1kDVI9FbLDgDFCfTIjWT6VyahIqhTqEqK/ERVAxvyvTcfMCw/ZcZ/?=
 =?us-ascii?Q?j7RASaoq2nhSyois/B8OOBVZFAaiZA3SJhxydglmyxbli0y0O4na9UhR2NHR?=
 =?us-ascii?Q?kx1koTNHDRlCWdDVkLUURwAjIwbrK4st762nhHy7Ib6o97rKFnwwky5nJAd0?=
 =?us-ascii?Q?+f65M2RwuLjVAS0Ww9MAPNdf7XtKKZqqpNHWr820A9JcoOLhqlcjsg6vOEJ8?=
 =?us-ascii?Q?DUyEKxIdjtU+oNDUlZx1TSEN/VYrwc6beUIADEgm+ByfmbU8HjwuhrPfCy/s?=
 =?us-ascii?Q?zaTy6Wikc4+bV5JGZpY8fP2biW/TgiKDv+YT4VbJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e752666b-32ae-4ce1-083e-08dcc6765ba7
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 08:58:02.7406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3K4Pi+tLOI3eq3+Ze6w46m0ZaTKPEOzlDjEJX2YFa2WkAOHRBoCaYeYWEjTJ6R9aupPtGtFM15/gck1xAtEjjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6720

When the original file is guaranteed to contain the minmax.h header file
and compile correctly, using the real macro is usually 
more intuitive and readable.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 drivers/spi/spi-nxp-fspi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 88397f712a3b..fda902aa5815 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -756,8 +756,7 @@ static int nxp_fspi_read_ahb(struct nxp_fspi *f, const struct spi_mem_op *op)
 			iounmap(f->ahb_addr);
 
 		f->memmap_start = start;
-		f->memmap_len = len > NXP_FSPI_MIN_IOMAP ?
-				len : NXP_FSPI_MIN_IOMAP;
+		f->memmap_len = max(len, NXP_FSPI_MIN_IOMAP);
 
 		f->ahb_addr = ioremap(f->memmap_phy + f->memmap_start,
 					 f->memmap_len);
-- 
2.34.1


