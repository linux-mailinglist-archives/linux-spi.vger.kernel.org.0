Return-Path: <linux-spi+bounces-4604-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0026396BA36
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 13:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2489D1C211C1
	for <lists+linux-spi@lfdr.de>; Wed,  4 Sep 2024 11:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847BC1D88BC;
	Wed,  4 Sep 2024 11:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dch+UqG3"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BAB1D88C1;
	Wed,  4 Sep 2024 11:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725448687; cv=fail; b=FlqseWhTSOiQTOFE5l/XqIOxGz2tsjZaEjw7TkNfkiV1/gy16i0TyQvqGx/sZz7f9+rYLq7Qq8LT5kQUeObfbNeN8mCaeKuQ/0ChGhWqyTKhz99lAZPuNxoYf+lRMLStDIChd62fc/MVXxL4o21C5xJJz+G9vvmtW4LsSDtvey8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725448687; c=relaxed/simple;
	bh=Pgx1+SmhLB/eipsOqzHgsCjZ4JT9w09SCKFeN5z8EDU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nehwt5GxsVjmWKgVgtp60ftzKyWq3DkmVo0r1jaeIFvxN5AbTyYjWwlrvEmXxrash8yWuAYBEF/hC8RYpfp49M4NRqK5CSb2LafzSiyAC4CGZNnFwHGgEwfWLwpKtpgL3qY+usWGWM3FJ60jknz9f6sb00wL5zUB9dFWCPSHrWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dch+UqG3; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZtAuh0Rn3Dukjdyi4gwh5bW9kVViQ9WZDLAiCGNCe1xUAQciJuvyqrPSluTz4p4tE0wCuZ3OlA/+6b8hVShWJHh1JLZZh0q5NyZnhmVRzFb66ygT5525H7ZH7omn6PaWeovhupTqGKVgbj4fbrX0ZO5XKI7YqcmrpyC7CEzHOuZoE4Ik0Qj+kCUIHto7jAwM0ltHG+imjd5E4efrPOYfKjLPF/hm5rErK8LhsTPknUJ4R9eYFW/ORQugHbpbN56M778OFBNQDk7TLes4opq6yYce61bkyY+D/bfuLMmD9M4Cb03cL+tV/zoESyCnVfYIFcdOJ2GlviJoXXzGwTsSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0/PyJJbA4U8WohQt5UkhZH3+XUj3PPAIs2WHPl1Myw=;
 b=vzxiAuc9aEMs1WkhEfPg5PSA79WEDVoa0uz/cj7kQ5SXkT5FrHqmVsa2aRf/tKq+9eqhp85YyK8yV7+To4f8nqMfc7sIe6g8TqJBSH02Nb8aw3nL54SDYHxhHYVUAFZUlknzfqSpM6NU3QWxoObFEY7lNCKcKgwG8cNzAM+AncybuIEliiT6ZzyeZBCXAGvdUy3O5fHkt9kZYMA8x0546OpnEO72uJD+IAqZ+m8nG4fViOIiUzvmpjcWFZYiJaF3UAMfFdlqhv+Hpzeg19uX3uwa0nJ21GRxkO1+hLD/2Wudhru/K/kaYyN0dtcuxHX4W3w66SLbzpiGlyYeu7G7wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0/PyJJbA4U8WohQt5UkhZH3+XUj3PPAIs2WHPl1Myw=;
 b=Dch+UqG3QhtptGXZ0z0MtBUE6tseD36+/NUDUHjTukG1AC6i1abH4KjIMPzj21S0EsJ/no/SIClOk1rf7Omjgs/V80CZMFJk7DcHe8bZaxlwA19D3tK6D4QSMgiUvd6Mp1JG4jbAlvqgYnm02bzYgnCsaDO1TQvl7DFIagv0/kL5Knk2TUWkDfM/rmxZj43bU0EBKdplbocp6oEglCcD7nDA8ngvBAgzhjH1i9PXPuUHRinGtBjQeVEc8r2YWsZZ1nYuAwG7VFw3B5ig/l0yvFvm0XE1p1wo+/PkIRro9T/+xSUWVZhJVIhntV7n9l2WG2E234shkLAQ4LeF76ylCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PAXPR04MB8831.eurprd04.prod.outlook.com (2603:10a6:102:20e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 11:18:02 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.7918.020; Wed, 4 Sep 2024
 11:18:02 +0000
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
Subject: [PATCH 4/6] dt-bindings: spi: nxp-fspi: add imx8ulp support
Date: Wed,  4 Sep 2024 19:17:25 +0800
Message-Id: <20240904111727.1834935-5-haibo.chen@nxp.com>
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
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PAXPR04MB8831:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f41290f-07d5-40b9-ba3b-08dcccd33d2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eUcdNZLxU9cHKQKd38fLqjpsnlcVulALgBpZJjNHV45NXFeAoCeS11/ewT/n?=
 =?us-ascii?Q?HdeJf0P9Ed1DoqsB5JWF1zlzTQ8Xqe+/LQbKvYdPxvcMK3m4vzbI7mLCHw4K?=
 =?us-ascii?Q?8bvnumqwES0fvpmFcqRNn5J6m5hkpJNGEJuuU7ZUpw1vAAizyXvRbZygluni?=
 =?us-ascii?Q?tR42K0IbCnyxIFHIzDI7Q2xce347FJh4XVELckN6DYwK0nd5FA3bQEbtSUxy?=
 =?us-ascii?Q?FsBvTr8lX/aNLDCB+yeDnKIG6JiCllYkc3+PFaPZ7oF5Z0qGQTfuBgiteIfE?=
 =?us-ascii?Q?4MwrwR3hzr/stuRFhddtzR7CPXpavEPtjTVmAKO6fpFey6mpMfqPOvS0Apbw?=
 =?us-ascii?Q?Ao7ceqoq+7fuy0pXykCtanjiowUlbfYHKncSmSwz6URkH1GrONdoupsf01RB?=
 =?us-ascii?Q?O3+/QodiX4JllqN/AwMKCrd54Epu4hlTagia04BeJe7U/FstRW2n/Je5q62s?=
 =?us-ascii?Q?akVy6WQmVsI6OmKGX8uJSOWF+S0izc3Fi4zsYgxlfyGhMPTREGi050Io/zVe?=
 =?us-ascii?Q?2DC3TmiUe9kGkGsIpKZACkKQNhU+LT6blCZzLu651ktyHGoibg+kvczvM+MJ?=
 =?us-ascii?Q?akJJGnN86nFm/EiY0ozSjMOVc/qoacm1/9JJqzzdczxKRNdP33N3FnWkKa69?=
 =?us-ascii?Q?uLrLzx1AGqSsdU3oEBh+HKM4CM0nJ8OcMOR3b05Ac+BcxrJ4SGBCtJkqxJqc?=
 =?us-ascii?Q?Bw91Fo+3kVdypPemelWQnkC9ylofMU29FsqIjiC0PSnEWNEfjeThs10PGL+S?=
 =?us-ascii?Q?xlFbn9ubtVNoFFvloR8q1mm31LvNuDYrKs/JvTntihp2oYl/UKlGTjayRXwG?=
 =?us-ascii?Q?A5dOmQyeAIyIeLd8F5tuiCpC9KcYUxV+DR9tPTrXoqTHH5bz6JT/QrguWY73?=
 =?us-ascii?Q?2JMXpxcyf7FLw9J56NtsDl9vhjx7Bj89CUB9l5wxf93Hwu3FyhXIj5z4ZwWn?=
 =?us-ascii?Q?8QkZa54/uGjUvQ9Qce0VG0LQuOrIRoQrq0wUahxkErIPJafVZzO52a9kHgPZ?=
 =?us-ascii?Q?F9KfP71jB/lHEIU7+hwnt1UFcuKBTMcCE5ilJx8FvXSYxz4iJr+Dda939rMI?=
 =?us-ascii?Q?bW/EyxUhGIpoO6YsPAslcBFWDPzC8p964MUaJUSSRmcThw1lb1+EmIkSDdH2?=
 =?us-ascii?Q?2xLi1AEXuU4amzcfRwLeGka0UvvKxrawkm2SFwHKcqAm9VxGjD3eBOr5RmYh?=
 =?us-ascii?Q?coLJMIYXvvdzmnc/Oulm4lTgIfjtn0+X8T3coHTJyE486vgRMY8ROR+pcj/Z?=
 =?us-ascii?Q?gYOQO5L6A5ikkgPAH3UKZ9k7DYd/Wrybffw6U95Kdo5hjqW4ashuGv1l66t0?=
 =?us-ascii?Q?EvUL0WI7qT5kt6SGrnWUdlYC6mOsMaf3nxRe5BSSeXyzrZJ6gfU1JoN26QJi?=
 =?us-ascii?Q?K4VhZ7KfdhsEMuqmUWJ2cx+sJXZVyUg2QNNxgnxjXxXrR96msQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/6z5o0pFbxNDU3sXxxQxKDy7SaeZa/cBnupBYheKlndSbshn5E+IcxjeEMeQ?=
 =?us-ascii?Q?46h9/FEd1rW7XLNu8HBbuPSmmCzQsPwM79iS+oR+6KG683osPdFyCr+/L4Al?=
 =?us-ascii?Q?lWE1nophcw3yyKP7VBWJxbVP9G7FHWM41au3T0cd5yzIq4we/s/GPdOO54E/?=
 =?us-ascii?Q?aFXQKdV6Xjft2GMxuJcti8B9BPjnCkxsyRqkcuv19fMznW5zZWltK2JNsMXH?=
 =?us-ascii?Q?qPbtXJ5j+ub18NPkJnb+H4mvLHRKtmfYe1VtVtOWnMVkyEQDaKteZBV9mGlp?=
 =?us-ascii?Q?uRPX35Gk19qM35IwyVLK1JwvI+Wxgk6xp/XorHzJyXgni/jClzA1/jFJVcmJ?=
 =?us-ascii?Q?HhUOujTFeYsVJ4RCySbiXn2geRMl8qpDUjtglS9PFPio9PyfGRf0Yp9UitBw?=
 =?us-ascii?Q?9jPXQvoJ9BBdFoshhSZr+EKL6Lz53XJ6k3cfFPneawZKP7aKOpMgdaead5h1?=
 =?us-ascii?Q?p7iPuggAhkJFUovAsBedKrRJumRW16Q3Mz7kiWrtgke3wdZ0vs39b1zD75xH?=
 =?us-ascii?Q?ooCgVFybS6TuA2Z5tll2uBf8JweGhRvzQ7lz1yLiUNsEXlD+kSZID3gHq1X5?=
 =?us-ascii?Q?EQI6VC+UAO6HAGJoLViPwQs6Uf4TqGCXcyP/DP7OHNJUZQW+3xTJW7Il4qsR?=
 =?us-ascii?Q?XQXrGd2mP0D09ullv6G3tbGUQWGKz0kcQ7+qGqkUf7o5PhWE8au9sKJC/mrr?=
 =?us-ascii?Q?vXWU7ZewSsxEg58GngXHOMywJyLWHgDqBjRQJaGnoSWqXaylmILGa4/Xgqqi?=
 =?us-ascii?Q?Bhx5NCJ31kF4YrvA6BSAchw4hhRNGA27OSs66UG1nnis2MCz0hnTP8Gwa0nR?=
 =?us-ascii?Q?jBQ4rxfemmoMSTckfcLTK9D/QombSRxtbCUpUBL+AQVsVxJk7RHi6NiXkpb5?=
 =?us-ascii?Q?TWsv7+zVqTz2TWppCz36tvQeObvTiPYjEkC4ImM4Emr9/RSiv8YlfZLRgb9Z?=
 =?us-ascii?Q?OhEoN2wyWS6HUevkm9d42x8RK7OpOW1FvDeZd2IVw+HZySBjsPNPZogv24QP?=
 =?us-ascii?Q?WvYxFwjVd4n6EQ75zJUbxKhJ9rqZ9DrfgclLvNVani3QosQ3I597d6HnZlr2?=
 =?us-ascii?Q?zXjdKnO0X8JptcroY6Xfc7RixDgdJRyuaiShQk4Iiw2wlVMA00SQrvmDECfU?=
 =?us-ascii?Q?m2M7Z1fwOAeB1XV8V3fTIzJ70dcnwWvaOX/ilaNkONQmRZ/piWe3kM99Pjb5?=
 =?us-ascii?Q?CJnimNk16+QsijJ7W/4A9LlDrkurCxaHLbFfl33C6TQicbGRFCgYUX6w+SkN?=
 =?us-ascii?Q?9wJIWbjzxL+ooDLBNmq8ZEel53BLctI9JnCOZIZw+FjWpLf8jQx0S5PHSzib?=
 =?us-ascii?Q?SnJcHXTFRirYorl8zeUMo0b1HixXJupy0UrBMMcVuQZYo66UWp9PPbrBSti9?=
 =?us-ascii?Q?ycyG+OLQ9g437ypEginOOz6EtAKhob2wy4OPCbAMzvXMyasmkNb98yucTZAp?=
 =?us-ascii?Q?Ir+D/9nCs+zROBCMB8jEPHSDwEPB6GZXUsy0NmuQISFQaYV5/NN/VXgB7X0b?=
 =?us-ascii?Q?PfoJjxHIUi6E4oU7VZfG6SuCS6YgNZIaJcgcT4WW9/iKJA83gsRev3+VZGiH?=
 =?us-ascii?Q?hfdky52pAWzaeaWOuQscheFtupiS24swO7cwLELT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f41290f-07d5-40b9-ba3b-08dcccd33d2c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 11:18:01.9298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QrW6FmXuJ5Qt6CcH/Gk+qVSmYkWiXbekNmQDnhF9GcOk8jMOCPuGQFa2HmjdxwqCicD+SgbFTPOo7pk05Z1lyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8831

From: Haibo Chen <haibo.chen@nxp.com>

The flexspi on imx8ulp only has 16 number of LUTs, it is different
with flexspi on other imx SoC which has 32 number of LUTs.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
index e994ff02f479..3cbba282c040 100644
--- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
@@ -20,6 +20,7 @@ properties:
           - nxp,imx8dxl-fspi
           - nxp,imx8mm-fspi
           - nxp,imx8qxp-fspi
+          - nxp,imx8ulp-fspi
           - nxp,lx2160a-fspi
       - items:
           - enum:
-- 
2.34.1


