Return-Path: <linux-spi+bounces-7581-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D47A89154
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 03:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2FB3AC9A6
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 01:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DE214B07A;
	Tue, 15 Apr 2025 01:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="TBOPNv9W"
X-Original-To: linux-spi@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010028.outbound.protection.outlook.com [52.101.229.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA5EF9DA;
	Tue, 15 Apr 2025 01:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744680852; cv=fail; b=YwYZ3YSOD7/iie/RTuz1I4TWnTiFDbbODNb9NRZzPlSAIEh9GVr+XlPV0Efo2hN8E3yII1JU8Sjm9Z04sJI9e+924GQFbKH6wEjQGSOV95iOUTpm+oIMFysQ/Z4oymX8YU461g9DU4MuN/me0AkTUU4nh2TSmml/zjSi2ppHQqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744680852; c=relaxed/simple;
	bh=anowNrnL30sliY5BrGOyosSHWetaDujKhZR1HjnvRbk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=nE+tO/5WU7zYx85jftoZI5xuOla2pZV05JszN/2KvGQ6JdVc3Lj4FBc89+ErQfULVuYmgOZHGSHnNduks3eKBHJHzxV8z6tpdf1sOucFkz+OhNMZUZCVoaZloHO4paMYWgD1a+MuNejf6te5SM4ZtIFVinBvfIBiOrB1A2SwsMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=TBOPNv9W; arc=fail smtp.client-ip=52.101.229.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtWYJCICn52GT1HiQP9XRsAEGmeSnepqcT1FnDRYSxNNSD6+LZ8CpgG2ouoXhI8lDAc/NTD1ewTiQJq83i43oQJ/UiHutk12hR8gnPHLlewY0M7heYEWIwRlQCtKEXBXaWuRQev2nZZ5DG7GiE07WZJW9bFABaiN3G7CvcHPSuO9Zg0vhjSYIm2d/bMWO4FIHoaRTdfZkLMdkWWde1l0PwZpj8/3naaydL073D0ZSaXSh9ByhqJ5NB+2L5T2fEBBIuVE94VqrvV6sglPFSHOGQIo6KK2yFqGKoXE9prwWGk609lB68qYsevpLVXztHSbPu59X0H+zCFuLXawa5j73w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4OBrN4ryYBMSnBmUyBn8Go+ckE7Pd5NuK68kK5v00Ys=;
 b=OaI0CXk2TD9s4MUWUBjJGODl2N965EyDOjrnmLoAmiI9o2/lyV6Bm6qUC2MVwmH/pg1dMPm/kMpn6iNfKLwxXkAK0nFu4N5g86MJZ8c9q8JcpYF2yLPf4CVzwmT+rbwehHnLLci9c7ug2195kJV2OSc3DmP9Z1+rnUsqw3bQPCwiq/h9hTAKs/PkmaTk/d8dM7+eyFQJBbS2R5K38hiS6bKx6cABig9ol/ZeSSoSEaZeupaigzJ82xcpwHdOHgaJKKWVj1brmkZQBZ8VXYnUnbgA476Gl/CPcczjtTU97JnXM4it66r4VMGGRf4al+HDOcEpb0KBfWTSLYRe2n1qRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OBrN4ryYBMSnBmUyBn8Go+ckE7Pd5NuK68kK5v00Ys=;
 b=TBOPNv9WtR1TaQzxgmA+BYLbZ/BFI9mRsQcIbabPDQitlSWwo/BoNRL3kLijc1asb1nWcFMHKba97oaVi86lMn39ntu1nyFfEdfeEqCjyiQhiHxkWCz9NZ6X/GLc6XmBaTc01TK3OfpGoTie8dWpGPAJygWOM8BzgeUqtaEyQhg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB10906.jpnprd01.prod.outlook.com
 (2603:1096:400:3af::14) by TYCPR01MB9536.jpnprd01.prod.outlook.com
 (2603:1096:400:193::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Tue, 15 Apr
 2025 01:34:03 +0000
Received: from TY3PR01MB10906.jpnprd01.prod.outlook.com
 ([fe80::592:9b7b:ef57:2dd8]) by TY3PR01MB10906.jpnprd01.prod.outlook.com
 ([fe80::592:9b7b:ef57:2dd8%6]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 01:34:03 +0000
Message-ID: <87v7r61a44.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v3 03/10] spi: sh-msiof: ignore driver probing if it was MSIOF Sound
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
To: Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
	ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org
In-Reply-To: <87zfgi1a5a.wl-kuninori.morimoto.gx@renesas.com>
References: <87zfgi1a5a.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 15 Apr 2025 01:34:03 +0000
X-ClientProxiedBy: TYCP286CA0251.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::20) To TY3PR01MB10906.jpnprd01.prod.outlook.com
 (2603:1096:400:3af::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB10906:EE_|TYCPR01MB9536:EE_
X-MS-Office365-Filtering-Correlation-Id: ebf67299-e5f9-4d91-a413-08dd7bbd9b04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|1800799024|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q1ehriTOYlpYxUJdA1YHRX3S82iIXqhwwoG8vXPZyvXVLS08girxqDqe+Kx0?=
 =?us-ascii?Q?eLEKLJcbkwSaJ0CwJLNH/ohdKxqwtU+m+o4SWLJaezu4Ds/I6b60EROmaRwA?=
 =?us-ascii?Q?eeRrTPZ1+u6GDiWwIt992oAt21tHeTitfF7iBAHGahbYLPCj3hyBqS4LiJ1t?=
 =?us-ascii?Q?WSKcD+9AaWEM7T1and3+SBR/auUJazVmCx0GJtKehdMqMm+3brN29PbkgBof?=
 =?us-ascii?Q?HyCZMSb08IdtB+jcQ0XOX8PD6cMOZW0lDJbpmO4x4zT7d7GPlQsTC3iv5lMy?=
 =?us-ascii?Q?7lagEoQO4QImrcHrokv9J/vZM2lAme6wQfoXU4EgrbVWOQ5R4TBBglNHy+Xz?=
 =?us-ascii?Q?KAHzec1DBhL7cPqrWATVvZa+CJn2TRMdoV2OyqmqFW8H/bo2dRhdT/ZyIIi5?=
 =?us-ascii?Q?+i+wcxbhW5OBdryXtTGTe6Jh+F4cJpoPYOnIiaiB10V1Kz/kM6VGjDpkZjQv?=
 =?us-ascii?Q?VGP03uCq4XW7xcgbGMLYi18Ffo5yW/ccxfXvm9ulaOafHKD2gOBIAtgOJ1Kz?=
 =?us-ascii?Q?Mpw9didg3RKN1ye5sN+a7VGEg2f3NQCp1uvbQ/9rpgMWueVTBnfgf8ZiVNj1?=
 =?us-ascii?Q?LB0wP5YsnDGMPpQ8SmmkT/zxzhLB8o7qY9lE+CJT4G6+oKlF7uaZ2BXc4zL5?=
 =?us-ascii?Q?yl8ixBXjmgEXAirjEZ3jb2Q1waqc/u6ySWI8AHpPXSkiHY08bSFnbIvhqy+0?=
 =?us-ascii?Q?Y/Q41+qowx0Ur+hLL7nnoMrKBNh4yBLFBBJR7Hd6OPJYxxDxP6AbM9pKGo4M?=
 =?us-ascii?Q?I4fJ1EwE+xe3do79LIzQKJqWqnd1p69aAQE9o1hQdrAKgE9j2uCvSL9R62Ih?=
 =?us-ascii?Q?yJXKigC4oHgxOPpCRKlvtPxkherLwlaeuI4cGMNza+KeHye1OrYrhdVByfq6?=
 =?us-ascii?Q?jKybtCseCLIO/gw17sJWIrBm1CHL3K4+Lv0PtDdQ764lRtFvUuix1w8cS7Gc?=
 =?us-ascii?Q?6JUCQ+qZ87ufF6l4AkVn/7EicNju2Sl2AzUqKQ/BsyE160T+EZA6/ZIN7Wr0?=
 =?us-ascii?Q?78PQds4AgJv+fHu8FZ/LsnhliDNKNJwZTXkV8Zu7Dm+ZOyf1i7tdepR+uuu1?=
 =?us-ascii?Q?PzS2Ny3bQTMOJlIpSOI/sBbHKL2cmVebAOQNwyWvIUB2f1jebO0dKfiMr/VY?=
 =?us-ascii?Q?sVwElYhP6Re9LLVQPtd2SB/yAw6LoxTQb7GZDgmdJOvF3gzZRsAvRfpNzaU5?=
 =?us-ascii?Q?EE0cRBeaoaMQ2rxbY0eh1j1JO+kvjidwHTpZ7APFKKvIUbolpYSX8h3MBXAm?=
 =?us-ascii?Q?mJWxdJwLSlkgwGrrbSuUBup07Yq053FBP6LX/2GjtBgiWAu4/R9t9EdUfccR?=
 =?us-ascii?Q?AlIKcMHBLUL1cj6BEljrSqqjwVe+9bfhwgGgWLAncPQLXED3dkv+yfb8xzT9?=
 =?us-ascii?Q?VRUkFpj63G9HSbB9iEmVQwx8jsKNr9aD3+uGJsvBTb1bxx2PWPUm+xWbD8U7?=
 =?us-ascii?Q?Cl2o3wVELT2KXWAQkbUvqlNwIPBHo/xbTLLeYFxBWFZaQsenjFCHiYffsr0b?=
 =?us-ascii?Q?E7Xt+TPaw7N5GqQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB10906.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(1800799024)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zn4qZpzzUoMZ4zxyiP3hnUBH9u6PjstUABeD4jKOq4FX+v3M3f2GX9PDgqkq?=
 =?us-ascii?Q?0tQqkjOqfK7xBgI94AUor6PVrr6UVLC6Jho+KObSclHwK4jicDEcgmYUhq8W?=
 =?us-ascii?Q?VI31Ez/h0dD2KdSqmBAjxnUhf0w/JSNfUmlfjk9gOAwJwoXd3hKD5rZxAeMs?=
 =?us-ascii?Q?3bN29tpRIszd4hpSKnRskGYoCm+XJ8FTOXZxrTwWSQygtJ/lED84KJnDrOXF?=
 =?us-ascii?Q?35qWk2FFVvifNp1oDcmhSXAPiH3Tlt+ULtP6098z0nimSMz2WW7+dxx2dtbg?=
 =?us-ascii?Q?zx4jNBtom31LNVt8CDRBfPfB2zshSrbRIXdu63QpU6gYPFYm5N6LBcku28TE?=
 =?us-ascii?Q?JcTCfv2qgj3XbEReXNC0OTM7916Tj5/F7dBycneU2z2B285FV9bFHJCMyU88?=
 =?us-ascii?Q?LdgsHYaeCNLMWJy+nIBH3y7Wt4RXk66QPM4krKZM7RkNNIEsqpZL1YMpuZkc?=
 =?us-ascii?Q?miYCCPJa7wA+PTh26g+YKnU9UWB8rEjY9vlVKLdzNlN/wC9fnLbnez2H294I?=
 =?us-ascii?Q?XkBAYqNTTwecc01AYwqTvX/x4K5jmVEhYihZoyNHFn5aP9JpbmDWrheTIuDB?=
 =?us-ascii?Q?3/vkvmnEE5PbyWYVxS5FZlQwHSfh73guo8yYC9+XbHU8ExuKCk+ghIigDzeY?=
 =?us-ascii?Q?DI0jJM12OWAfjGXk6M648KOKe8j/uFnM9tosCa0+DNShk1PsnDguQd93/aRL?=
 =?us-ascii?Q?x48ltaWv0WCbXX0ay+MbgcDh0q+OlN+UOGAzfPBu+Gg324XPoVSJpIH68SfT?=
 =?us-ascii?Q?9KCgRWK4cuaodAFgtbrQsIbQMNgCKslJWGfS9kTOZIVGQ8xf+YamTfk4BADx?=
 =?us-ascii?Q?+I2rJCI1AuQIQSV8O/nX30qxCqmvk0n/HisDp+UxEaLaK3mucgSeAbjUUbI0?=
 =?us-ascii?Q?tb9eW8MBI2/D2uRHne8L7M3v+wW+QqUOdjPO5QViY6Qvh4mghB09kLwC+yr/?=
 =?us-ascii?Q?P8RJZ1Wfmo1uPjbNOpdJsnzsmaUcud7nVjE8CiD5iGUJ0Yn4okM+RbjeeT6k?=
 =?us-ascii?Q?xwp9A8PfV5m0naunBlZBjkEo9SAlFKO2mFEdRMIfYQsQGRLXq/K0nw4Muitn?=
 =?us-ascii?Q?7w1GTc6SJdivhJy61OOJ5y8v5/T/0aUnw2vHRLrZu2+dUGdP+NSG6FbdiL9u?=
 =?us-ascii?Q?cGqWOmyBL9QZWtDDFP+zhicY3fVg6RB/i7C6t/kAMSraWtMS+G41vRZFokKU?=
 =?us-ascii?Q?/EGUOF0Pvf+uHRilGFsB9/Yiiw48eT+Ll2HaFY5nfxB2BzF9L4Cy6DQ3AJTD?=
 =?us-ascii?Q?fB1AvoWyhVxxvtiOhWSOCBEiwpyFbmH8SEDPUC6d5VlryN8BjpWYGRZWnvho?=
 =?us-ascii?Q?KpEMuNBgv00p71hgzQivUMRj7mkoya8rRqqTZ3Yzj0SpABZGDnPmcAlDsEc0?=
 =?us-ascii?Q?Fn1U0tUn2SJaA123ewvIHoVI+Y3JW8uwx71XDQQJgMbb2o2u/3u0Z17qECiO?=
 =?us-ascii?Q?ast+DXcZrpYLt1EFPHYckVEYOgDF/aTu5Rlz4agjzuMOprw0dZsi9jUoZPUv?=
 =?us-ascii?Q?mav5uX6qj30FyH9Bf+jdwo6M/YVK54sAmW2XF6yt4D1LpZW9oQxS4aRVFURo?=
 =?us-ascii?Q?+oKXegYeOAznpsaoqhUX7kkGs95EatKeYwaCJOU+rICUUEQUtxrUrcqBXXwm?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf67299-e5f9-4d91-a413-08dd7bbd9b04
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB10906.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 01:34:03.7818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3RawPuGa+gvNb7CnLuK6nyipAUH6pA9yjaw5CoBTw35xZYVOWzT98vziZXuqgWcqnfofQk7pVmbCAkpRVzxdlq/QwoHrHPU+GiDedaPFuQXH0rw8tFIhbernmSXbzzqF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9536

Renesas MSIOF (Clock-Synchronized Serial Interface with FIFO) can work as
both SPI and I2S. MSIOF-I2S will use Audio Graph Card/Card2 driver which
Of-Graph in DT.

MSIOF-SPI/I2S are using same DT compatible properties.
MSIOF-I2S         uses Of-Graph for Audio-Graph-Card/Card2,
MSIOF-SPI doesn't use  Of-Graph.

Check "port" node when driver probing

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-sh-msiof.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 581cec19cb77..d9e3d83fc7e8 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -20,6 +20,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/sh_dma.h>
@@ -1281,6 +1282,11 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	int i;
 	int ret;
 
+	/* Check whether MSIOF is used as I2S mode or SPI mode by checking "port" node */
+	struct device_node *port __free(device_node) = of_graph_get_next_port(dev->of_node, NULL);
+	if (port) /* It was MSIOF-I2S */
+		return -ENODEV;
+
 	chipdata = of_device_get_match_data(dev);
 	if (chipdata) {
 		info = sh_msiof_spi_parse_dt(dev);
-- 
2.43.0


