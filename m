Return-Path: <linux-spi+bounces-9525-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB23B2BD46
	for <lists+linux-spi@lfdr.de>; Tue, 19 Aug 2025 11:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9986B1BC5ACF
	for <lists+linux-spi@lfdr.de>; Tue, 19 Aug 2025 09:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFF6320CCC;
	Tue, 19 Aug 2025 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="RvQeqhZT"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012025.outbound.protection.outlook.com [52.101.126.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8276F320CAF;
	Tue, 19 Aug 2025 09:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595314; cv=fail; b=nbJ9WK0B2TT8LD9K8fDaE+zllDAtRULEc+lbWCyjLSSxqwHPMLK2d4DAXFOD3xoKyAu7lCFJ/5RjCmI33IYimKPX5KHdZ0d+E6g+a3dHs+d1atUsfliYdmKlQ09wru8pV15mpw4viS7B9B4M0n0qo4LuHSwhiFFFkPuN/vIgqJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595314; c=relaxed/simple;
	bh=a808EyDjfRRrodHugn6jT/pPUxmfrUsUhfITC6SbP5o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AwNsa4Nc5NndpVjU1pj4bV4dyN9xwUY6MyZKWTtIpbC5GiXbp91xqEt1Qlvl+dJez+8z3lJlbGpU7xM8/nAxrcRAfp4Wqav7HD9solvd2Bz+h5kkV3moBG1Mz8yjtDVB2GugmZbUV+VqIKauddzFasqFMBBggCeFS6bf9zThFr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=RvQeqhZT; arc=fail smtp.client-ip=52.101.126.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7Ph1DP3m0dHjCpzj4nPzXZZzHEQ71E0QrdZUj8beJVkotsqxukFc1rvGezUnwqfSFkBcE3v4WAqq3A/lFR7RC/Fg1ImJcH/p3EIEYVBLsMcOvtYQeBwMSnHsWhQwvW08VABk+MT19aUXxd2LCtbTc/Dh8hILDd3sbIejSalKAhTL5HQ7MpIu7VF2MgYnoZ3wCb1kvpJk0/0SCsyfg3i05FT2H3OA74AEJYwUleW5xrbUnI3wxZPHIcPRpq9fdiRDp3RJCexX6tcRpwu3hCIB/JYAxTyimg+lH4dE5E0KcIrfyfDo4GyXl9snBtN1X/gn3F4UQ7TqzFeG9RyMILT0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6GpkC6OZdE5C0t3H8ng348s/eovzSj/+U5UuiZM4J04=;
 b=FRDQBF2uQfR0sPOnLyHnjFRTUZIG9i/TYj/ZPRspiIecsV0hKKi2L6xxPSb/wPP/oP7wkbFncjMUDdAQc6aiqa8w1VNtKPfJ4wH48fuyv7dkXZRJN3rOZbyu/QeLgc1C0kwBPeRC4nOeakHgPFPg8aGyVtXbUdrb1WNovBLHgEDPl+CkJ/2CP0FRo+nMtm36nExtIVOk5FcUWPZ/fpdLtHj2F+ubP3GPpnwFmMPIQW82KiuReK3hPF2jU1UqhQMqw1BEoG+ooyM3BmSsJPZvOz+mQP4iu1V3/Hss40b5NsHA/fJhSxn7YDgThoKTQ41J/Wv6IlNGIV14+VqVOhJVww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GpkC6OZdE5C0t3H8ng348s/eovzSj/+U5UuiZM4J04=;
 b=RvQeqhZTDIkEg6nuWF37ejvBja3fi2eOqnEnO/SRl5Hwv2ACWAVIdt+0qQ+01jn7ZR/XPtQqsq4lW1Zqo1LHUWgtckjbU0Qyz/3fqwuKJ07sMkOyC8nLa12hMj/uY/OG8f5Oiqcr3Z8igyYdPVe24zTQojjad0UA/h1ROChgvV3jTqn0y9IjdGeKaxjZYs6io8KD85bE2Wz8RTRw4OzXhlBMmWT+bogfSApPobTSJuAf+1HrZUmLvJb29vBxV9ipIs6HyryyLY06rWOpIomqj1T55T0jlraR+4iMcIIp7s4yIZKRB1Gd6H88eH3N3Su24ujxUVxPZk+Xx3JlrKJ9WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TY0PR06MB5054.apcprd06.prod.outlook.com (2603:1096:400:1bd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 09:21:51 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 09:21:51 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: Sunny Luo <sunny.luo@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Mark Brown <broonie@kernel.org>,
	linux-amlogic@lists.infradead.org (open list:AMLOGIC SPISG DRIVER),
	linux-spi@vger.kernel.org (open list:AMLOGIC SPISG DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH v1 2/6] spi: SPISG: Remove the use of dev_err_probe()
Date: Tue, 19 Aug 2025 17:20:39 +0800
Message-Id: <20250819092044.549464-3-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250819092044.549464-1-zhao.xichao@vivo.com>
References: <20250819092044.549464-1-zhao.xichao@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0038.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::7)
 To KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TY0PR06MB5054:EE_
X-MS-Office365-Filtering-Correlation-Id: f6b19e1f-8b1c-4c26-2409-08dddf01d46f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Aw0iIeZdlqHW0bSwoM+pXd7ipPPAia84ymk1bDb0wZXy6GqZO76L+SfebCQT?=
 =?us-ascii?Q?C3vHk5mGAK7lxKG0Rj1FnCvSkwqeRrr236Q/8o+Cnyq0hIjW559hODGy6zmA?=
 =?us-ascii?Q?n90ToJeeaJNpTe9FrpBnM/eu1jjuUVvQX0LSBQJAHQD1X8rWCpnMz/cp6UIr?=
 =?us-ascii?Q?RTqZlrEerLYUUfW35g4N+r1gSiGjg3cv53za6LjWXWI5ApsDX5RFhp0N5cmM?=
 =?us-ascii?Q?iTHvYnj8gXxHIjseQdlfH5zaMTkxzlYrox/oT6Lp3B2Q0wAxahG1OFA1m1J6?=
 =?us-ascii?Q?iqyQ66gXUKv3xXcZbtPz0o+aYkfnrTeV6EzFy7InwXWlIFf6+rYfA6BhgTLM?=
 =?us-ascii?Q?q9mIDOGKQYogbRLmQSd/SfS1vRPGPx2pmLWmPzWWnrzXBkxjU0XjmMzTATZa?=
 =?us-ascii?Q?8jhPoA4pPVdcSbs9c4sCnQBlHCA3p9KY4AldUuA4nC9RnuwDr5k3DupAJZQE?=
 =?us-ascii?Q?DcDr477kPRDgQDTu59ZABRXDImDlrEwRy95jKMQhqNWyEyCjMsJjbMgq2UY4?=
 =?us-ascii?Q?Ato25uVRf37H8TsKA2OjmI8FV++zQ6mSzgBb2f/8ZYhjbWjuOrGIp46uW4h9?=
 =?us-ascii?Q?AUXkdo0K0Yn6FE9W3WNkykSeGPhFOtQzulX8s6FiQacqdlxrq3p0PFhP3wjf?=
 =?us-ascii?Q?EJQlXsE/jx8cOJIJoiEqyQsDvrbV2XbfIhq/LS/F5uhbLeRkE0/S2R5An0j5?=
 =?us-ascii?Q?I9KHb41kfrGk3zGkW8MC9sLM4teVyGW+0nHg8atbv04Dlvqt6IZ4yZOXc6HS?=
 =?us-ascii?Q?MAiY0XAztvhanKZ/EmpZYPKq+KneqobtAWhhYcRfquNRw+NQq9XO1XZiTdul?=
 =?us-ascii?Q?/JPtvNt92JjaefIl2WolhxUm/4HOofGfTiAZp6+d0W6CQQWZP+2kZPCZGkju?=
 =?us-ascii?Q?sd9XKEGJab122e6rHX9Jz9gTFlFCwNCnzJxCoB3sUM07Ad/HNj5NfIyMhuGg?=
 =?us-ascii?Q?B6U+93ilFzh3DBBrZtNMd6a3oo56Ngkojsf/yqDuu9AgzScL/xw3xMhbyr9j?=
 =?us-ascii?Q?20pi2A/oRc/tDmOv3/SsJm93A5UHwmfeDQ0URSXQf7PmAWEKd+nxVjhHMVw6?=
 =?us-ascii?Q?V9lJXDxeivNIBVw2OEjf/x/8xxB39yh9Ls1Hz6oqsZPs4JXRoEV4EQ0vf/jh?=
 =?us-ascii?Q?BwhLkabv/OjNl3SoOfosf5koJh19YkP3nIQ59Dl2DPoMHb3AdE8PMZFj3aaL?=
 =?us-ascii?Q?SsJhKK9r6SNLKcDu2sPUOjTeqhTmfd+CdYUZZGivwL9XnVmPxY5QtmHg4b3G?=
 =?us-ascii?Q?cA3qTTWp35TaPNruaSRWp3DfsiCSYGh6avPfMva5azdxbbiSD1F1HefdA1VQ?=
 =?us-ascii?Q?Waj1W4yI43WmIbjwwhcG3TUuozEGcXVbq7pUwbOOhQQRpzD+AM1Wbp+1WI3Z?=
 =?us-ascii?Q?twKvEFKam95Q2kvZf6wavggil7Q2pDNf7qzAd/QPu0Ml1wzToc5vrdINwuMN?=
 =?us-ascii?Q?MUsE8IkuDQYVyUsFdII8bwB7XoCpEKxVoTRmpKvJCo4c4QkMNzchbA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RfiVM7lET+G1UIAnf/3dGv6vDPAMOLXX3xesWOtbPAlrOi10D4If4ZYaA3SL?=
 =?us-ascii?Q?Xkc4/NkoTDj4qKGF66fBUVyFaQYkF4iHTEeoAtNdkX94dMibFwyD4DwMNvRU?=
 =?us-ascii?Q?ND+UwoQ3wDTqhUmjgBc2EHER1HRaRjnh22ld+k+n4VS1M3UymW2KQsBpAtye?=
 =?us-ascii?Q?OHWgSMwVIl8stKPciK+XygQnNMqSz/ljRiB4d2FD5jUKypKxSiwj5K4wtBgV?=
 =?us-ascii?Q?qTTzmR+uAL25iEacmoV/geG5iudVqH+IpUpa8tYFDVHPuxHtv5r6jfFW3xz0?=
 =?us-ascii?Q?pmNoBDWqVG0qnmWKAmQh0dAc+y0tajRQClzTrsiLH7CIyPTtSIdLC7+aqY4C?=
 =?us-ascii?Q?CIhsANHfyul/a5lfHLy/Q968qlzJqhGvKKdM1rVZdqypYiSkcm3JPe/5m06p?=
 =?us-ascii?Q?siWAYdrnAsCk9Oh9TNY4lao/5BLX5EJ6QcLTZnugeNNzD+yHKABIH4IKKW5C?=
 =?us-ascii?Q?tAFjeZG9BYABlTWUIRLCCWpVrvWqPHJwNXb6vyHYFwntuvnP/HkczLPJZTy6?=
 =?us-ascii?Q?z2rT+WAr5qeWuCsG2KMlZYWWF73gMy2zp+eMxweA3sXRaYMyppLdyr3zjo6G?=
 =?us-ascii?Q?36lZg4rWOU9OrFKLosG/b2OAQ0mvvvaqeKXpqQyILzkaYU8zuKQWUiO14d+s?=
 =?us-ascii?Q?P61ntSqTW7nQBQYBfNoqI368fQHM0hiunVUkxE0a4O4h621vO6GB6rWc7nd6?=
 =?us-ascii?Q?ymvvjgVvtLpUoB98CFIfp7p9Ni06DMRBljoAucuZ1G28iVClUT13bykNGdk0?=
 =?us-ascii?Q?YqK9di14zwA7piJ2wLEAhqLu57ja9aIL8jGbxaSw/1BEp/j8JumHfJjCDYt2?=
 =?us-ascii?Q?+wfvGtYtGJQal4AWmpL9O5+5c704jpv61CeobdWQTl3ILIJvx1j4av/VQVVl?=
 =?us-ascii?Q?ty3PPgHVTt4q8C+ZrbG4ZCiF8DFa5FANyajuER7GHxD3i91mxu2IYcrkh5bY?=
 =?us-ascii?Q?Cz5wpSfahtv6ATZNvB30ZgMdGhzKfIpogrFnZjsonvTzraMwJRGwcQjAuiqV?=
 =?us-ascii?Q?7XsyVG2DdlNT0XHjUztRuVgVfdbNckAzixR/9Kzzi6E+CVcZrNV8CVqHxubS?=
 =?us-ascii?Q?RayDeRudrJuCYvpn6TK5yC5zxinlOrG/QbDG4wztO1LkD4MWVWYhn0AuLl3r?=
 =?us-ascii?Q?vJVN8bP3DBLjkjO68+zhWoW+ND2kTFw9N7uF4IpjMZGy/fcEIB+/DwtARuaf?=
 =?us-ascii?Q?c5wfHtMz/nbjz+YPIXuxSRtGah0z52h8CP5S/zvVd9+UFoxMeTZ0u7W28hYP?=
 =?us-ascii?Q?Gf5uQvn5EZ3KzeYh4Rsk5EIyFYYWmMkULSjMJrsUnettzklQxz3Po3hfC6mv?=
 =?us-ascii?Q?oBHe0L8cxHkD4Kd2uxNfjhY16S4maN9JMhMcqd13nWqr3N6gmacR5wi2LVOh?=
 =?us-ascii?Q?4rqSzRXAtbdbdCohU22BD+dzYSB/cWq9aaWQTn3as3oVNbDdLe1LEqm41mfD?=
 =?us-ascii?Q?XW7qnfpHCoXdH3A5OMqvkjTxdFROh4jrq1id1cgPrjXY9I4oxvtMpSp7vVF5?=
 =?us-ascii?Q?SKo5qt96u9Gsnt2SekNG+dwLi8CR9PjvlEWW/GVj/E4ALWiz2Gq+NzONO2mK?=
 =?us-ascii?Q?v6EVEsPUyEXQWjG+pGu3t3tUcubzxaZ0/4AeLgsH?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b19e1f-8b1c-4c26-2409-08dddf01d46f
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 09:21:51.0860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9E7+Hk2d/sDyNtNFSRXyxjyb2L4Y9kUnV3XBjLwNw93wOxRBdXBake8Y2kGLLxHBtNSBej0FjM7rHob7NnlP3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5054

The dev_err_probe() doesn't do anything when error is '-ENOMEM'. Therefore,
remove the useless call to dev_err_probe(), and just return the value instead.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/spi/spi-amlogic-spisg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-amlogic-spisg.c b/drivers/spi/spi-amlogic-spisg.c
index 2ab8bdf2a676..d1d5f3114fa8 100644
--- a/drivers/spi/spi-amlogic-spisg.c
+++ b/drivers/spi/spi-amlogic-spisg.c
@@ -733,7 +733,7 @@ static int aml_spisg_probe(struct platform_device *pdev)
 	else
 		ctlr = spi_alloc_host(dev, sizeof(*spisg));
 	if (!ctlr)
-		return dev_err_probe(dev, -ENOMEM, "controller allocation failed\n");
+		return -ENOMEM;
 
 	spisg = spi_controller_get_devdata(ctlr);
 	spisg->controller = ctlr;
-- 
2.34.1


