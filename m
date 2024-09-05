Return-Path: <linux-spi+bounces-4659-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E15F396D3BD
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 11:45:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99D0F28A3A9
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 09:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F215D19882F;
	Thu,  5 Sep 2024 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RpiBJK8k"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010039.outbound.protection.outlook.com [52.101.69.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A2F198A1A;
	Thu,  5 Sep 2024 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529500; cv=fail; b=b+JSYp61dGENlU7yTaM5ak7I+KDa2yjqM5eq3LmKL2ikn2ISLh8O6IirxiL7RY30L2xdiIRljr2VyhBLyJa4L+kHhy0LotPzdPUZZ0A5ADri7duWFifQdX9diVh5Wjw+TAGMgeJrfMqv90uKQoUqVK8fzocxPuTGuofcbn+mk/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529500; c=relaxed/simple;
	bh=5wnC+CsmBsWmHQas9tWVjecNBLm1Fxt4rhcikYF3ZwA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iCVQRDDVPwmovCmPwJzAke5K2U6nrG+VstSs3D1ga5ztMt3AzdnBcfc+9J34OKNcLwdCjHO1mVlJgQ6Chwbp0xNE9+FqOLf9x43yM/bCjngMZNfSu6mh3u+ub00Iz42QqSO8b4Vf6RdWvJgk1npd5zCT8zJcUJEpudNQJOrGRy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RpiBJK8k; arc=fail smtp.client-ip=52.101.69.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8jBWdXBMqvIaMuo7iy8TZjTahRpmY5BPbiEPP8wl4FnCus62+o75XzrFWoyA40teSW2T2lO+VqdTcXfKItaULoGPswJaGpJT84CxvkRnbixThvbhjO6xKDArPehC0CWV+K+8N+PQdt02qB5qyYhDVUiqHHH5GRCVc094jaCpqRBWBlDE7kqdwXQYMdznC8barFuOInVPR3OvZygWglGzgaHczm6zORfuHuIiCzz3gB68WlBTwMCBrxJdsuYXZnQdZuKYnNWuKLS6J1DmVi11eVO5cgOrUHIeuWL/9B3F0xI2LVIb8oSytSgsvTFTxyp+/u9symYuBagxZVlxPSL9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vx/l0AGaWqXHvTp/Eniw1LbiPRLj5TIvLHJVbEGhTXQ=;
 b=unYZzkvM/jb2pwDUFysVZzTHsyM6busK9OcxA7xUav9AUbXpx94+nDk8QaXiEIBtCd31DZltQXrqBzA1+C4eCUChnhGlNvwWxAX8gSVKBYUac1dj1Nl9pebYvS0a1qfCPJM71yzjTbAMZTtDwgkUexbIzIJnM9eb41ANNyGHTD77jp9AjVHcIudjdPP5F7dOLB22X5pMXNfbjq0NCTXomz6F5DzaSm91Yn65KN3tSB6tRqalG1/nI/ADgVYSVMuJn9TRWqVy4QlyXqK0RZcnPkOc4ZcOJCeLgWY/KEZMVyWsSf39Y/YLdnwiAjAA6f2yFfDiyaz7cLxjiVYa1Xu9pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vx/l0AGaWqXHvTp/Eniw1LbiPRLj5TIvLHJVbEGhTXQ=;
 b=RpiBJK8kjLeqKfA3bI2rTNgzuCuZPbU9ofsOdERUIWbQqVYEJT+yqPwortKnloYtEzKzfUnovaojWJtvDhBeboiyswchZPutc6GwcMobTkH1Gn12RN29ZpkfjqZMlZw6WgPBIy06MzWTyO2ehvi+GDCZKasmMsXyKCCcj6WAyYP1UsgQgeSCT6g9fmUsw0H+jwUFArqcvZ+ghEEVMMTXM9udub9IWWFk2huQvcFrbLglmp6j+QDxHLx96fjFHGuTZIFg/YOjdPgNWz4st/CSd4hlkuWsIC0lt4tS06SP3boE/4Qk67k8vekp4ls3sA7QAhDyhd4T9UGod2+3CcsJ4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AS5PR04MB9753.eurprd04.prod.outlook.com (2603:10a6:20b:679::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 09:44:56 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 09:44:56 +0000
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
Subject: [PATCH v3 1/4] dt-bindings: spi: nxp-fspi: add imx8ulp support
Date: Thu,  5 Sep 2024 17:43:35 +0800
Message-Id: <20240905094338.1986871-2-haibo.chen@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|AS5PR04MB9753:EE_
X-MS-Office365-Filtering-Correlation-Id: 26e176a9-b67e-4a71-33bd-08dccd8f6664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E9QvkUFRGAD+uYtZksfI8nijCU+SucOtfrVOeE0jMMpqFoMteg0a8rugI4S6?=
 =?us-ascii?Q?IZi4X8PJfNEayJjVLqsnXxfvxNxkzGZqRVxNqbuwF+7094FNjpw4lrHAiLvD?=
 =?us-ascii?Q?d7C8RgnkYeUitNQzCmdrvmAhPluZwhn2cqGVSTx3Nt6AeQf2K4q4fYjEzpAd?=
 =?us-ascii?Q?QDD2LgA9xZbUW9+iTtwjYTu/rUWh237qR9z4ZTtZG3t4JrbEfR06VFkrG4nB?=
 =?us-ascii?Q?gUgsRvmjltFntPtuSQ+kDLmT0CkzWAmF958EiyH4j2ZoeZ+r77IgFQM1YwsA?=
 =?us-ascii?Q?h3T0GC082QbDlMkCkUmGsu/0Aawe08kVhaF+Hn+KCMx8gxOiKhtYZWnO7366?=
 =?us-ascii?Q?l5FxR2VoFsGzjv2DFJ2JYf/iHEydBnB8KB93MetpIOF8/e4b+Xzl0uTozFqZ?=
 =?us-ascii?Q?qrywxk2h/tH9ypFdK67cQACvFQ4oPufcZSF9ABV8yNV2EUimLJK0tt10bDGR?=
 =?us-ascii?Q?k0JMzSLWtXqRhNoVSrq96rgX/UzFBzcbIc32xI3LEBx+urog4fgQfnAQ6XiZ?=
 =?us-ascii?Q?rUoIY5bBjFLUj7IIKQJEmEzXXh2FbpCer04xKLf1KUGILr7YdR76CMi5GrO4?=
 =?us-ascii?Q?zP9LbERJk7Vum9pZQvzzSXHSZE3/04EoQoMu5KphS/9tPSvwY7WyrXkueaJf?=
 =?us-ascii?Q?oecdh0USjo4HWsxnJ2CRkAUloJa7OMakI2St93ZmAhiVhvd7xa3wLaREmxn9?=
 =?us-ascii?Q?T+t5bz/gppCIoBGVZx67EqRAHFrbmHQz+IonDYk4TBW0SQ+gJAsfhPuhMhBf?=
 =?us-ascii?Q?Hb9nYGHhuyqtHwk7MPey9gcUmzx2mmVr3uFUFmL/ic7S8a2oxNFp0IpyOeOb?=
 =?us-ascii?Q?NZu2EgaC1DUUuV5o0Vzui0TNPhhqd78dh2bFKd0FZvkxJbtnQxzegmUeW4PO?=
 =?us-ascii?Q?hvtEUUxPMeko0mtuWDJC6wTdg6q0sgSyvf8+NjjpxjekYmehE7Jj1bgV5i1d?=
 =?us-ascii?Q?ogPb040WYcXZb77lEK4OvEHeSsO91ZKp3u0ngPxsVs9AlMPTKAmyDeYXld8x?=
 =?us-ascii?Q?ZdchPYpW9geOdsQsoYO/WGY58xMnloETg0J7lWta0tpmEewZvBF3Q+GFlmsB?=
 =?us-ascii?Q?omdqZPpRlIneCnlz3ECXYLKbB4gbDiQjxxSE/N39OmUYkrbjNKbFqFBV1uX7?=
 =?us-ascii?Q?fEeW30X+BbDZsaod7Op6H03J0bvdshNahsbm25I49J8qDu90WastWMU/pJvy?=
 =?us-ascii?Q?vQ3dk7oxSf/sjY3dMnQGxu0nE/iU/vT6XAmcqLi1ooPYege9r2Q8uDmuFwvb?=
 =?us-ascii?Q?pBMhZSMtip7mYzjMQyPxbM1YeKXyxqPnZhsTiQ1/JFBuzPsjuHJ3TFCgRxg4?=
 =?us-ascii?Q?RZpoI/3PUrHpujHF/kI01QFePtd/OM4yt5syHGm8T37g3x51Zwt9V9m8Alkz?=
 =?us-ascii?Q?d3y1ksayufAguTikgIjBoR3gdWla06zopmkKrQvebrW9qAalyw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H7PESGMWsmQilBMf0iqLJIBm+1O/pz7tWLR9CJJbOJVfZt6Wp4UZRUGDLumN?=
 =?us-ascii?Q?fX73eCXa9iYta8B0n2Ko/Hmmw5L31iqbR4BCrce0nRqsn4x6Y/5QpwnwmDC6?=
 =?us-ascii?Q?CoVYhS8/q4kkqgmha88gvwvc/S5ep6tqA0b7lWMBP9bRIAaq9o+rcayGkZ19?=
 =?us-ascii?Q?HYQiB3/frb7jfOkYVHxwxDEksFoVLl4fY4TnTk6lGaGw09CljrqhfzaQeifX?=
 =?us-ascii?Q?0bWgtWTGXzo1cIyhO6YQBz5SEQdNZ/bTWYoFk1qaEahDr7X1CgcCKx7qbxQ6?=
 =?us-ascii?Q?AzTt1zle1eq+ECMmOCv+VwQrt6jLcQgOwYMb7oFIqxu5V0pYI1hsrnWpTutY?=
 =?us-ascii?Q?2qKW98g64ZfybbE0yd1Tr7ozLqPl27N+SVYD0ETwqW5K50rFASk0/w6SO3oo?=
 =?us-ascii?Q?YbucPc/eKWw3QOgIx0jlvWpuCYnYckRHmnrC6GzXaa/GZaBPHS2wxKT3pEhB?=
 =?us-ascii?Q?I4SrQc93NmQJL2czrXm36n+UaATvurcwnaIyKJzm7/OxIzujpPcHd50Rx3wq?=
 =?us-ascii?Q?0RKQDVUKZx+xqq7uFaAbKNuUG9qXYLm/lQ0bMh6kq1lcUdu2EB1mkuV9hyvY?=
 =?us-ascii?Q?/nLJ8W79/LgJ/9jY1T9UgObmPy3RYXCXreigUo/fzNPgBLh5mqeuqsgEchDn?=
 =?us-ascii?Q?a9Mf8BQZcNikOANX3+OQnd4nfTKMFS5mCbxZuGXIbVUstosDCWnR/8dA6HBu?=
 =?us-ascii?Q?OFjSUhAmqhZTcu8lmnfVgXZhKD3xPLxTBcJXQPJmV8QFqYPLKXQtyPRZy1oh?=
 =?us-ascii?Q?t1flZKkn/QJ6rh8aILeRi3dMRnVcGQ/wGA++fMv8EFbdnIb34NHfRWrMRpRI?=
 =?us-ascii?Q?ZyR0nPUKpUPc5CTAuiJ50W3LbcCXVT0gO1BEqHiycX0TcKpjrbT7TorGgKdO?=
 =?us-ascii?Q?iVV1R3h4iT6l6SJ7IfA6t5irqkxHkAAXj1hLdUiAjoadINgfTDcYujIBrS4b?=
 =?us-ascii?Q?MP2hW8Lf9gWIyhSp6DqZg9ISzUDIZtUL/vOM1CLjUGgxaK81YoQrXyP/nU/U?=
 =?us-ascii?Q?/eYS5FO756LBQhKyIfqhDhMf6ktIpvQhhBKRWn4hb+LMjmCCGlUVkzyzWuRD?=
 =?us-ascii?Q?nM295Ex31iomd8CpYZpsRVGn+zicZFKlfm174ZE5NMTWTtlz2DDyB42z+Veu?=
 =?us-ascii?Q?YxspeWcW1Hi4FA5PFGBc09WqN4zaFaphrtZe/Fg/kv0I4nUiI6+mYNFeGwdD?=
 =?us-ascii?Q?V0GpbySadsNsbTpnVlfJ7TIwCweKzI+wHQg/EVHrq2CsOmD4igfojxPqgYwG?=
 =?us-ascii?Q?OJOaq/OiGqEIBZ7Z1VrkqaJSXnwK0fJ9WYBsDEUp3l1g8CllvSUqwhcJ4dNE?=
 =?us-ascii?Q?Hv1DwRjMeuCTUXVjMMyulu8bTdvfsxl7XGFHFkYeXnPOs+GgZ3Ozjfe3aLyE?=
 =?us-ascii?Q?pu585Er4s8tRek1sfuCUgTvWjk7wOk74Gdk/hh7ImoywAWcugcJmR5YQjkrW?=
 =?us-ascii?Q?Vp2Rf8ZgI1AuR1acsewohSWqYsEaSQtEnobWSzhKvfW1botebID/1aK9E2hL?=
 =?us-ascii?Q?IjhnAEIfw/2J/Y4l7hNTTtmXX3NGrnV/ZI9Z99qWfm/XryVtDTHxZ80kHOc+?=
 =?us-ascii?Q?DykRP+++Ii48QJoAO534gZ0O0r0xJHD7N4Skb6uI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26e176a9-b67e-4a71-33bd-08dccd8f6664
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 09:44:56.4574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AzXEHXnDNoh8IACwyssqPZv/4c1LHK9NyoLF0RxuMe8E6EdIFj2k/X1r4ZgPhD5o9OKLU+xk6vT+OkeyTwNnKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9753

From: Haibo Chen <haibo.chen@nxp.com>

The flexspi on imx8ulp only has 16 number of LUTs, it is different
with flexspi on other imx SoC which has 32 number of LUTs.

Fixes: ef89fd56bdfc ("arm64: dts: imx8ulp: add flexspi node")
Cc: stable@kernel.org
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
index 4a5f41bde00f..902db92da832 100644
--- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
@@ -21,6 +21,7 @@ properties:
           - nxp,imx8mm-fspi
           - nxp,imx8mp-fspi
           - nxp,imx8qxp-fspi
+          - nxp,imx8ulp-fspi
           - nxp,lx2160a-fspi
       - items:
           - enum:
-- 
2.34.1


