Return-Path: <linux-spi+bounces-12426-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9CFD28A40
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 22:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40E6B30123DE
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 21:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65F5322B90;
	Thu, 15 Jan 2026 21:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MjCGUcg1"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013031.outbound.protection.outlook.com [52.101.72.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E951B2836B1;
	Thu, 15 Jan 2026 21:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768511307; cv=fail; b=Yl4cJTGGK1XowiiiPT2QLolBChSwKGq8AsZv8YckWd752rOXiDBZhmPBwA5Ch5Pm3V56MYAAbVbKWvk4+dWfYrhxGQDZTYdDDlrq46YNFRkNOffxqihATypNIcekLkIAvYLiteHQ20auFqsulM7RxxfvpalAgUDXD6bfW4JY9A4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768511307; c=relaxed/simple;
	bh=UdQD5RS1h9CEIqo9VM2H0E3EhtgBtvwHalmvC+g7H+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U4VMNVaanTGg1m+O+GTctjwmP4AZ2MaDK4TcXBN6ZKz5lWclk9B7ThHuhG6vh6G1BeMU9BHZ+A7J9nom+VPq1GxVRe26eJ+eGUxiDc17ZmpJOh0yC8RIDrA/dlWrj7GizODozwPS2bktgOf0G5BIvy0GmphKSLMY3VhnQwjZfVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MjCGUcg1; arc=fail smtp.client-ip=52.101.72.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XP7S2oveQAImrnDAm5R1SBh5LwgmM+7LI/sxc/1MNSI9dXQS7hyAboolh0xHfJqHTQgc289tWRSNA5gr15Wds7FuAnBqFCg5V6zqWgv3kofOjUi1gjZcukBaYua3JMxu9bkuP9mghHSm6N3UGWvN/HDe+Aiq8kgAKRwGqKh5ZmDBBhqEpPYZHDyPnqR1SymKVbauI3XjWbtxFjCj41mC/MnJt78mpOC1/0jw0FBHMnEDqaFLZG4qFneeVennCosprxAvDu+13uc88wRMiYNxG+Qh999JDG7YMgeG6NAJ7sYrGlscfWQZDm4LwpHpn2qGVWBl3+a27odFzrp8q2EVwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jC80PgVOhlhOJl34bUuZwfXrU2x/HfjdhWvmIfdUS0I=;
 b=EHBNSnJTZ+GxT0A+Zh1fQnTChykldRB6YwyJXhsJe4/TxnwBpyauOQmJSy/BpFQ8PyokM67VISIXhpZU5DSTh2sU/ynWqF+pRY4j3jyC8N73cM2S2Aonm0zCzhZsmit4wT6XpXxFeDFXXFpX4ntAncxpQ2vfAxFoDyJ2R5OCiN499oe8nuPw7pk/iJYK8Ra4xqPtY4wIuimW8SdOFs+XyO5pnHkWZ+viFbQAIfb53F8k7sUKOJTGgVRJnYs32G+9WeOBeHv3mGGuqwzZrzqG41LxfGSF+moL+b1FfDU/kLGxQXVKRMPwUtwueZFSoddbkNOXjSvFd9q8CaEgjki2Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jC80PgVOhlhOJl34bUuZwfXrU2x/HfjdhWvmIfdUS0I=;
 b=MjCGUcg1TTi82KRJbBMGjE5xRfA0flqIr8hcfWpo6CHRQg9pmLgvBmhqB/ZByVE9dSvrnJmNEVgk0rw24J0chHP9kDzK5kxD3HIN7w5lpLmSzXLry2pfEsycGyaRgQYbJfvySt02BWnANvDpJn4CyGIJ1Lpy1DlMHOWWfjXy8W5TVQP9dcQQLgT0ofFb2PCq7qQnfiLhQG97XVgITdM+d9o2BrqsdMvuqe/a50QH6RJqe5hfyaA77CVzxT2zFm08OqNWwLr8Tleie64Z2Ta4tkfl6xk89y9RYe3NrAwEdE9DWloibCff4YbXD/9qyl4hHEWmUmiFbRdDNWjAuIJ+tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by PAXPR04MB8272.eurprd04.prod.outlook.com (2603:10a6:102:1c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Thu, 15 Jan
 2026 21:08:10 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Thu, 15 Jan 2026
 21:08:10 +0000
Date: Thu, 15 Jan 2026 16:07:59 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Haibo Chen <haibo.chen@nxp.com>, Han Xu <han.xu@nxp.com>,
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] spi: dt-bindings: nxp,imx94-xspi: add nxp,imx952-xspi
Message-ID: <aWlXLzBri8o4YQ1t@lizhi-Precision-Tower-5810>
References: <20260114-xspi-imx952-v1-0-acc60a5a2a9d@nxp.com>
 <20260114-xspi-imx952-v1-1-acc60a5a2a9d@nxp.com>
 <c605c5f7-45b7-4e15-9d80-8bd224624b27@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c605c5f7-45b7-4e15-9d80-8bd224624b27@kernel.org>
X-ClientProxiedBy: SJ0P220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::18) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|PAXPR04MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 1508cd67-e0f3-47be-36ed-08de547a2ff0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D9/vDf2sEtCHpag1xKKQHnBSdIyra2rnSwGhKFb7EjbGhbTarUKucbsUGMq7?=
 =?us-ascii?Q?EkaAhaTqdVPEmWpLSNVRuZRnyxGHTnQk2dp16IewXRDXVAi7mUag16rtzEqi?=
 =?us-ascii?Q?LZcf70X/nrJnewaAyxHaCVY/TznpOkb7oMWezLf6CLJ4PQ2CtjaD+fftFa0T?=
 =?us-ascii?Q?xLKRpzUO+qU0m1sHDCR3vk4YhFaFmNBhzL46SpDYi+M5zIKlVVKNXuxqCdJZ?=
 =?us-ascii?Q?XHf4FvhFmO6IXq3n/CNcqGvVANDnunCIhJqZ89gfL+3hNyIP+ggWYq/RiZAt?=
 =?us-ascii?Q?SVMbq3FallMXfrUhtbjbOu+LG/DF1DvalV17OZxio7oP/Dm6NsHioFfRfHZW?=
 =?us-ascii?Q?lZ8uAbE4ga6hbQtHa4POLIOjjBd4kzgQe7q/VucmoN2i9dzaEadj0AzdM4hJ?=
 =?us-ascii?Q?KazVI0m+LwyaNrrmPpi9cXSf6FO5/r3UexYcCa6QKCVzexhmoLHEWM+hpSno?=
 =?us-ascii?Q?tVNkYylPe8uuQX8A3TRWaTSj4WEcWTe8a3Fi/kOZf3WSKQmCWFHD8WDsDkdt?=
 =?us-ascii?Q?1ge5RdzJ4+6BYmAW/LBXST7HvXR3sDu4BastGk0qtjokV1R2W0U7QQ/5zMkw?=
 =?us-ascii?Q?w+Ii7EXVkTnpcphC6R6jVqY+6gFEeMuMUZm5nsXfL90hiYq/Fvn12oRhvagd?=
 =?us-ascii?Q?WFzpeA12GuS2cNhAn2dN8UCbni6WkBygxmlI9Oi4VoVtfxa0m3pIVCHqpTQ9?=
 =?us-ascii?Q?jDXaeJQB4BvLSVjwdsSFpsYBzldNNHLAchT1BzE+wBhyZ0Ud3/a+OOU9r/T9?=
 =?us-ascii?Q?XkzVHsFbWgKosSE8pX5LbSiI5CGmkJ6YDQkRCTDXLlk4f0pRpmulGy4XIbAi?=
 =?us-ascii?Q?dmb7OVKicGtfh6pDvpZDBre5XzDtKS+xYSvzyTMetKNeo2EKa1qHDDZKxq0W?=
 =?us-ascii?Q?d6NuVdDivaq0dGxhtV5VWJfBNssFhLKqm8rTRJ1re0XfQweMr8+xPw0zBA5B?=
 =?us-ascii?Q?q6MjiP84SRfGeL2J7pndoRHGX4SLo0nrjC2OrWsErqIdNw1HQBLNpjQBif6x?=
 =?us-ascii?Q?LxSPk7xt2X33lFOcjApRfBAb4zIettQ1aplPt/r4gr/SlXuVvCS7evSGOQ0p?=
 =?us-ascii?Q?n59IuDZPy0GO2C4BecOXZVyZ+sSsnw3dypx4R5gQZwY/dU0sd/Xcwl5fNRVe?=
 =?us-ascii?Q?EzLb/PTIbwIkUyr6yZZ4SkkeGcjGHiHqXgXZIzVgLA0IKMfRtaWCHcahjxx4?=
 =?us-ascii?Q?cjG9ScBgX/WJzQFR42dRtTR7R/r74Z/AR6ONv3AxEYc7WDCYRAoWQhb3Pz0z?=
 =?us-ascii?Q?0M0q5xmBMRHTeKixYWVvb2l8Wx1NGFYzyxnhMksneofXuUxINWSJ4iEuDM8T?=
 =?us-ascii?Q?AevBHjrJwyzfdIdtbnwhlazGuiDFHDD0jkJG/QzMuWHYgGXj7jQi8M/S3ehr?=
 =?us-ascii?Q?4vrxnurJm1U7j2CE2xcf66Je2svOkGlKkA8MQlYv23FKuWKxt9B61L2Vl6e5?=
 =?us-ascii?Q?5I5duBcayk+/ieyVe8NhqGRDkjzH8P+v0AwniTdGVIVILPQ3qNbzE7PBEqVX?=
 =?us-ascii?Q?Wuvz/sNa5wIEN3JtYkAQ8pUbvo2xILnp0tHzbKpl43nQbbze11Xort322eBZ?=
 =?us-ascii?Q?sHSO8WC0s8oNlPwQSx2WsNOnTzm3jjxdG40+4jb0HrlORA9C7Vp3yT8tA+Zi?=
 =?us-ascii?Q?DrR++UgT10F6zHYhqdue3HM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zZJ9MoCP/JHZSPllZ4Jb0UAJuijQls8w0SyqyX1/zbaKDGKFXBk7nasTPXsu?=
 =?us-ascii?Q?5Ta7vCc/oDlZO6gToeTDAUY9awEk/jqJjt+M3m2bv6RQMn+n80RTYRWgNMU5?=
 =?us-ascii?Q?+FB4gT7BTX2A6CF70eHtsuZUg2nYPzx8fk5pJ6ZGxlwse+IsL2slICl8cWUH?=
 =?us-ascii?Q?MOmPlzcFQOACNeSPPyXtw2vBIVZHbqUvrEoegPepg1SocUfmmkEk0JX2CroQ?=
 =?us-ascii?Q?QechnRQf1ln/3oBioy8Kw9moOkmCq9Eq9oX4DbsTdLYD7b59AWKpKVYbBu6+?=
 =?us-ascii?Q?M86Pcd0U/vK47DKTslNT4NTqaMiheGZrQ94bHzFQS15ebxRZagy6qAVzO2P0?=
 =?us-ascii?Q?f8Wsm1xm+/Xh/Sx2+C0oBi6OqMEbvC0kDyv5CDh51p/Rmi4KyPhp2fTFPKkT?=
 =?us-ascii?Q?74Bm3Ui+4dJu0pEaAymJrzPoS6O4/Go3pvnpJDcZ0pmzj4tJKDxxWlQhCIUB?=
 =?us-ascii?Q?g32m0AjqJcprsKMWpTObCz+xgm/bHeFuPh1vB/1u9NkDVTlmbsx5QPah2e+M?=
 =?us-ascii?Q?0Is3oIU0UpKC6ji3OioEMLn1zKCwLcmilQKT2mogdzOQfAaARP+b/4fbHxyC?=
 =?us-ascii?Q?/NwPahrikrL0MuRmo6uYgAfX37K497Ma0Jzdp6ikbNbdXensy9SEkObEkiBn?=
 =?us-ascii?Q?MT/y8HSsAi4E5Gt1sxUAN0uirWUkAiRSpM1dF7hRPq/L1AOm+FWX8tSDoFHz?=
 =?us-ascii?Q?dMNHLUocw6gKwDI23bIcjRW6r5Z9dsv+XVzYEZIzjnWKYnLrKF4fZSNzMJBD?=
 =?us-ascii?Q?rUYHdFmCrwOV4UZwFxJkO6EMAXY6Xz81SS5MX3j2MChJaU+mNMOshqQhsIym?=
 =?us-ascii?Q?hg2PEj804dDpOiimp4QpeOorTeMiq8dxLPOlA7aAt+361fgWOOdw5gtOg4Lq?=
 =?us-ascii?Q?xBmxkTHbmPkgm4zFvK2djPnmg2MOAYwbcucIKTSFm90wP7c4TJhzIIibgbmK?=
 =?us-ascii?Q?kryMH9WT/ZqkiGPxhxc7uC8Ayf/UkLHgobwCkhdtTDKethgF8PoUxntanBP8?=
 =?us-ascii?Q?hfLeMFYRHS+3Af6fzk+lpn3baAoK4i3cMCEDS8UoB2wn45vZEi2lexPJYdt/?=
 =?us-ascii?Q?ga2T3ASkolPpU+EepJ3GPHM5IRhhVhbZfQWAvBiceXDQXl6+mc/UTL31HK3+?=
 =?us-ascii?Q?98VrR1c+iuTkrllBWclEmol1nJx3zLCg7QerZDNmPk/yVErRBqfD0ggSQ29q?=
 =?us-ascii?Q?BwRmTwZTcrstD4nfmnRhraSo8tngWWiNYUoEUxx8bO4szTEDpLW/i/cBx8wD?=
 =?us-ascii?Q?GoFERXZvbD1i0YlnMhKdnoHJKgq21uEhzgD/GerP8FOHnsrSb1DcVPonqBY8?=
 =?us-ascii?Q?/rYK5A+OIL0uj7ct7cZyxJMe5XKsl8Cnz+7snxIoSfdW5DNmWYBMIYw2lhwJ?=
 =?us-ascii?Q?VyNFzFNQ5giJ1lm70SmNDEGdOBRuJjhzOuQVp9lpcDIevc2ViaGzBTQSqWNe?=
 =?us-ascii?Q?/tzk6kxODbhBtRscwDLe7XcGWQOSxaNOUrP+ci3g+/o3LraALvcPqcBVKDMC?=
 =?us-ascii?Q?7WKQ8CVjAHK6elu8UHwkXATvX2kcyUmGQbJoHsOQU+3Z+MJFcv65wv5loAA/?=
 =?us-ascii?Q?BysNgSXFK9Zb1G92llfIHu/9e3tEbufGVMCHslQhnTjDeocawklCi1rY6d81?=
 =?us-ascii?Q?axPRjQl6M8LX4KNProUr0I9ePMImyqtu/TL7NFOxMS83cL4w3n4J1qFoc4rg?=
 =?us-ascii?Q?sO12b8H7TEpBL01iBkW2HZ6kFXrowPOBeQEKmfPi+Bh4X1d9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1508cd67-e0f3-47be-36ed-08de547a2ff0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 21:08:10.4287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MgaLgv9Wy9FulmxUs7Y6xoKCy/X2wS0UoNWyE2En686QeVDKu5tGs35y95w+9OC5X4jOiLTMz32yaktoWap1Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8272

On Thu, Jan 15, 2026 at 09:55:57PM +0100, Krzysztof Kozlowski wrote:
> On 14/01/2026 07:49, Haibo Chen wrote:
> > Document i.MX952 XSPI compatible, which is derived from
> > i.MX94 XSPI.
> >
> > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
>

Krzysztof:

	You sent an empty message here.

Frank
>
>
> Best regards,
> Krzysztof

