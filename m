Return-Path: <linux-spi+bounces-4601-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BACBF96BA2C
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 13:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74BDC285E3B
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 11:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDDA1D220C;
	Wed,  4 Sep 2024 11:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c3ety9CU"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D980E1D0489;
	Wed,  4 Sep 2024 11:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448675; cv=fail; b=XIH7SdsvmMHi15G7LF9k8ElPVBAt4F4QXg1/O9nrz4Z4ogBip+MCunFSrDA837/0PzXPHZm+MQy3qAWBGnCV1UD1C5HARG7y77SXybD5+qhnfOkJ1zuhq0+gJxMMPBxfCgpLVKnbYlajjIcpJQmXW3tHhTYgZJ/GWgboLMza3jM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448675; c=relaxed/simple;
	bh=cm1fXtC4039fJOHRBfh/UzdMshO72A6LFcb85hDy1zg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LQ0PgakmyXMe0b26CW8ECZfbsrTDANQzOydlkiXZ+9qMGXbTlpBv4u+6MPrsN6iv9yPc78Ea6toah7LAzPnNHuOlJcR7XetShSyHsj10Kdyrby1PWFfq7hLrXj1vVVQ6pLBHZt+MElvN5ux3SBVq59FMQH1Z0Fz2CZ6sLUrYOTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c3ety9CU; arc=fail smtp.client-ip=40.107.21.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YuLgCnNYidMB8PgoXQhfRwhwZQh5BcgHpuwsw9pUcLZUcMOoI9uQIQieKvDxisjX/VeRL27YjD8vy8+b7D2GBYxzQnuyS+sQtlNa1PoW13Xp4IJRiCzgZVduZgibFrDPc2wzhVPBqqnEoJ59BQqvs2O/lz0BS8KqtzorgZkK0OOrumfCoe6rV2n8ChyfmPmPpm0Nl/uX72ZgvUT4tuU+qOmQjPVqbtUxwwaNHuXu6l+uD41xgQtZpTSbP3XAWkxKvNFJKLAXg9BGgo1eOrhsrtWsggbSzHTH65u58T7eQsUuDZhercNSEz4djHZQ/oUlBG/kjLEH5zKGR+j8T6NLgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roqOKsWlUviYLYzzDmoZF4FgCwGyn2WJHPe9oGMTTDU=;
 b=g5swBHq9Gt9U1h5FL4JsSDBUMPQKQWTHbq5rwqjg75xifYH/5nxzBpfiQxJsqBG9XE+wJNRII9wX1f8E3D1vr9+5WM5kiS+5pJrIOvFeG/VfOTKZZf6tjphR+I5a8EqmjvO2D4vk12lSN3VrX+grT+dDW3cYlUg/noxE7XMFA145y83ohAlL5OsiC3uMM1RQ7dAQv11/zxWe0jbLBe97/60hQX1eDD/+xUHcHelSvboGw+Mn5BJxheatM0eiIug0DirAxgLloudbMJ0KsM8/Wj7mrkoEKG0Et4XPCc9tswcdJ5UYRpWhXi0PyEfMblJ2FBESsJKe8TgOqQz9btr5cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roqOKsWlUviYLYzzDmoZF4FgCwGyn2WJHPe9oGMTTDU=;
 b=c3ety9CUZYgY1TdpWgmLsWTbzVR1sTpkA8A2OU/CgnbRCNvh53rucE1Cvb9xAA9464SX+k37dz9ifH209y4DXWPEfRCpwYZTR5LGF8crQGeV//2/rJsY3B1dyeVVWMaH2KaLgiJzNUTxOX0+uy+mEn7FUgJg8vrfdMg+VV2IC+EbVIjngqc3BsIgdQ2VUgm8SnxPZqKl4kMwp1QVSk/VSTVvn6vD9X7GVbIMK2rM1hbt89r+n9KGRDkJmr0LsTpqi08p09xWdxtQuuxH+ZSQp5mtoXV3v3gxL7VHInYIRenQynhEZ4mbb0GFrtlKP5zSizR5b8dXDYwdJcGD9ieG0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by GV1PR04MB10607.eurprd04.prod.outlook.com (2603:10a6:150:203::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 11:17:47 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.7918.020; Wed, 4 Sep 2024
 11:17:47 +0000
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
Subject: [PATCH 1/6] dt-bindings: spi: nxp-fspi: adjust imx8mp to compatible with imx8mm
Date: Wed,  4 Sep 2024 19:17:22 +0800
Message-Id: <20240904111727.1834935-2-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904111727.1834935-1-haibo.chen@nxp.com>
References: <20240904111727.1834935-1-haibo.chen@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:194::6) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|GV1PR04MB10607:EE_
X-MS-Office365-Filtering-Correlation-Id: c85a9459-15e9-4d90-0338-08dcccd33386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZPOkix6583DdgldJ5Q6wfK+H9/JsIPlmVeL01Z8BnL6gEokNM0GA9G4c7OhC?=
 =?us-ascii?Q?10wuCpI07H62iwgRcOLZRrj7RQF4L1U0donQfVB1nWw8Fk/04IVDz5UFl6tK?=
 =?us-ascii?Q?qjsOMCkfiHCY7a256KR7ZXxwri/Y3BtdZg8X3HzV1V1cwbuhKSbJAAVn9Rbu?=
 =?us-ascii?Q?MNuAMr9iBuq6RLIDe+D0RwF73kAHao6zUN5rnKaT13g2SALe/5AAe8+zFMw9?=
 =?us-ascii?Q?Su/1UuaLRUSvIyUcWHRPpKOG0ubVB2KEJ3IIFrxR441/yhY/qjCtJZ2LkH2a?=
 =?us-ascii?Q?Uj6Wu8L3nudjNNjM7NeYekMN7FrybcY7ePAZq08IJ4ubkOtCzXrArOX9Lf+F?=
 =?us-ascii?Q?bt4LGKrJ9rIcOZf8BvIv+youYQxEDiB75IHf8Nm9lIzPtzbPsQzgGbw3CXbz?=
 =?us-ascii?Q?P4pM3CitttFFS6sDB3JSKvV+cbzfvfprnamNsVWIq17iK4OI7mejaJvR/y3O?=
 =?us-ascii?Q?U2B1MUKd4+iHvIyFwJXdiQJr4mCORUI2TAQdS4TkNlfxwCS9qeefXyNzufxC?=
 =?us-ascii?Q?dyqE0W+Qy/xJvTBKV32CROs7KXtbthwkp0BE7w9kS/xM9JjyG5PbjKeGEPo8?=
 =?us-ascii?Q?bXB/AUv5dipnp78MUuauymwHULg96U58WL8YupLRF1xpe77eJfjV5QIkJ+l0?=
 =?us-ascii?Q?HiDZfEriKI+RNtPGT1ARyOaakYGwplJQlh92rvfYqxtHPA4KTkXr7ImT8tUR?=
 =?us-ascii?Q?X3DqQacJ8EJXbWRN3/0XLbcbr7HcuvOpf/H8971bPLkqfd3RGqV5YX1DsgL4?=
 =?us-ascii?Q?Q58j9gNvno+AJYkm9Zc4NOQ9l0WBrk6qRLTxLeAORXkjPnowrTvCkMo4vDwf?=
 =?us-ascii?Q?5fT9mK5Lj23q5DHrSrgW3hFZCEM961LQ8kSbCo6eLX3ji57c+t1iW6g1E4eI?=
 =?us-ascii?Q?/2V+/XCGtSG9PyrLRkuOOklamK4LSHy63F+kKJo4M+bmrBIUrtiX/CLnV3FY?=
 =?us-ascii?Q?0wLvhJ9X/UWDR2M73ixXKSJ2hKTa1xkunj2RX8zclT6pJoYNF13sor6c8FqQ?=
 =?us-ascii?Q?hyR2Xpe3er4EKVmJb+hIZ/7uHQ/R8WTEAL0r9IJZKmvzdtAaXxvcRC6S5Xub?=
 =?us-ascii?Q?CM0YMrBaI84sPP6yzaiDBkHy8eRENf0CBGEIM4mLYYH1C8qa/yYuUyFXnqri?=
 =?us-ascii?Q?DMB2MKBAfwKAKEcRzizh1ObohZWEzJWqKYAcbSQE5m258oglWaW2cWhVC9g6?=
 =?us-ascii?Q?DkKXKNMSMFWzei69lOFTaKsG6bBr4EH8EEwv2ZUaS1YZ3zVej6dg1FSSbGjm?=
 =?us-ascii?Q?eWTQXvph2/l9f9dgVUv0KaSzURqaZpDTBVMrJECDN84gXZTlQXwij1bYWThc?=
 =?us-ascii?Q?hmW+0DWOTPwHpYvCaLz3YgL1yV/3vnfk/fJFcGFpowu/Jda+oqLz5SxuMiuX?=
 =?us-ascii?Q?wjgEwds8rVXbnANdzMHjJQ+TKCM1DgOf7+n7GuxBNdtrdEDhpA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CE8fjT3V8UO3Do7hImoK999CbbLx+6/U1VaajZ+xm0qJVq6bqtufWQdVeN6/?=
 =?us-ascii?Q?a1EF6p2tOWVZ5xAnDxOL/ayRSf8pp3jRpQc969k4kNt/dHlsvU+8sdH0KqPU?=
 =?us-ascii?Q?/Db+R4u1QYWFTu8CuybESU4iV8LYrdNdkGjzJZnyV+p42BH8oo6HbXOjwP14?=
 =?us-ascii?Q?6xpUlqoDYhiZuF/mZqgtaejDmwndxjiWCKgGCKSXfPZt4nl1nHHQVKBu3hf2?=
 =?us-ascii?Q?UpgMrLpcrV9ZtlOLpZll1/qz/QqFd+TKXkCyZNCWYsW3O0/oOXDnejldaN1u?=
 =?us-ascii?Q?111tmG18kdCBF4bbk6SGszP9gxxMM1r/3BmSpmdT81JHBA9EsJY9Z14fpmPu?=
 =?us-ascii?Q?EJnTHfsBeF3c5elOxeJC+bsj8GMphU6IfwuDLaCJF7yzhNH/RshEPmhHbVy8?=
 =?us-ascii?Q?fcowOkYyUSW/+TfiAmp/KC18Go4yiOM0cLKz/xD7qQ5vYbm5VP7L9TUN6naJ?=
 =?us-ascii?Q?L3NRqnXVwGLr5RwqKKF7krSycfmua1iEWYqNr9VmmmfrwosZIzA6+NGCJXdz?=
 =?us-ascii?Q?VSMdrIgpOgzfI4QM5HqCQKyCix0R29I5be/L/wt0ap5f22YLH+J+7lM62yJO?=
 =?us-ascii?Q?EUPhq/gFm6R6NCRnz5KQgmBgg8Z66EeZBV+NDSdsYGQjRNq4Yiutbgr9FT/S?=
 =?us-ascii?Q?eT1gbRYFKCaUR7aXuW2hQnLnGCu2b9X87Ew0cTWxZJLvZarllflVs3Z2S25c?=
 =?us-ascii?Q?aIIaccQvRrd7SuwpLb+qU1R9fUtOuJrKQ2DuO3JOVKBwljyAluDJC7IX0eq6?=
 =?us-ascii?Q?ubwhwDQ9GQayPVNUYC04g7vVqHU/DgG7COsHh369varPqd4OyYaYzpBrHzq1?=
 =?us-ascii?Q?aZ8W9ESthnZki+6ESolhthAjk1wRbNQeeY+if5AwYmfKOY1g4Ae80uxt4SUi?=
 =?us-ascii?Q?C6kAq0llTbwCmR2P+Ogsn21eOBZCp0oxHNSebm3UnZIPWon8kyRhr1JmLlli?=
 =?us-ascii?Q?WYoZJZjof8F8AQhaqzaicBY1kl4aNJqp3Gr32FB+7v8rdpaCMbqOlp02ZzfF?=
 =?us-ascii?Q?KXxQ0edtCfqd3++jPdf8QxAxr3aXPcxcPjLeLl81FyFydEuaeXeGWPZU47fi?=
 =?us-ascii?Q?I/BvsIzwvYEbJMO91sxsE0A8IgUkFAUd+13XTacKof8wigYNT3af5MPQGV7d?=
 =?us-ascii?Q?RWsXLSv528vwYEFX2HD58g+o+XZARUnHcUIcDFmVmlpDtblj9w+b3mCgnJaE?=
 =?us-ascii?Q?GaHHaSsQBJAd3QBNB2t0JF+pgHknkjRKOUokgljZEXmnnxrdJSMCMM1JKjZM?=
 =?us-ascii?Q?jdJ+IA3O98dyCQpGUQilybjmtmSJz6nLaQTmI9+oQ5NkzEyHh/YiqdbaPxxy?=
 =?us-ascii?Q?X9SODbnnbfSz/cE0Vi2PtKDaN9NqeRCLOvRPNDWJrt3qwIelDcr2JqHllbUg?=
 =?us-ascii?Q?UJ8hBdSTUb+vyZ42iHb+R1+ol7AvbM6pkD4QNtA7SHI45FpW9+uGnD2kklxI?=
 =?us-ascii?Q?DL75k/8+SCEdpYOf27DYcir0DXDv+SYN9GUEr1N60lacmVe5mK+qHOgqM0Dk?=
 =?us-ascii?Q?BbKB6l0esQbQXab5GtLSBNJqZ/w9aMkMtBpptEE86oCvqxn4OH5JeP8fs5M2?=
 =?us-ascii?Q?PyHUPW9nXmdIKju8rqjevtuOL3JAVZLkIgJjAPec?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c85a9459-15e9-4d90-0338-08dcccd33386
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 11:17:45.7869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNfmBzms+YULGPsYzhJl9Y9xvMn2Mf35sjy8e/I5bLidQNGzInFSWLIT7KChglNvFlZ3xE8gLWRT2SXeKMXOnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10607

From: Haibo Chen <haibo.chen@nxp.com>

According to the imx8mp RM, the fspi on imx8mp is compatible with the
fspi on imx8mm.

Fixes: 28b5eaf9712b ("spi: Convert NXP flexspi to json schema")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
index 4a5f41bde00f..e994ff02f479 100644
--- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
@@ -19,11 +19,11 @@ properties:
       - enum:
           - nxp,imx8dxl-fspi
           - nxp,imx8mm-fspi
-          - nxp,imx8mp-fspi
           - nxp,imx8qxp-fspi
           - nxp,lx2160a-fspi
       - items:
           - enum:
+              - nxp,imx8mp-fspi
               - nxp,imx93-fspi
               - nxp,imx95-fspi
           - const: nxp,imx8mm-fspi
-- 
2.34.1


