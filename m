Return-Path: <linux-spi+bounces-9534-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4061B2C6A1
	for <lists+linux-spi@lfdr.de>; Tue, 19 Aug 2025 16:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84901BC5EAE
	for <lists+linux-spi@lfdr.de>; Tue, 19 Aug 2025 14:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB27215798;
	Tue, 19 Aug 2025 14:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m4RD8Tp6"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012056.outbound.protection.outlook.com [52.101.66.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E2F202C30;
	Tue, 19 Aug 2025 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612538; cv=fail; b=Ng6yYaqkD6q2hA8Eh7WxGQ1Y9DjsriXJMn/l1aYRECLXZw6fhlxr3QFVWEZZHZnMXI1/Wgt+QKFsa0KXvRa/3rL8uNt4aoE2T0H2ZcX9WWNPXdfh8G9ngAmLmGr7Tl8SOKHWvzqq2xY4PY2jT+VbRZWc5z49EeHeQfAMuxkrsmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612538; c=relaxed/simple;
	bh=k1ocQ5U0Eq0gMlzFX31Vg1rt/dJgZ+8JBrOFuWRcAck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=INwwBFLbmTh5STKUBWxBDXSgBazE09zdhcMho4emYFK1U3U23Rq7HapBKYzlwYdaFR6CUOOn/rhnY93T912p0jUndiJ6KNMnXU/FY68TCd6f7T6FbpqsQ/WvT+faqg8JNtVKE1DifTU62y+U2r1MqiyW0mUA1OAAx3UVRTwdy0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m4RD8Tp6; arc=fail smtp.client-ip=52.101.66.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ccHRmzCRXTsVP5PE8gN4xZpDkWTP1kFqiQ70qsnqItzCBVDua32Na2k4eEK6axFMw1UGgZJwnskW/4eVsvTIAwfwshHiC1H/JH/zohSsCpkfD3mp8uSED92NEX9G4SudsrIlzocUQd0pzBOXr+cYz4bgNE6bAAG+PmGsJzKGVt1AEL0hWKs9h1dhcm4FNJwuvwEvTmh/ycbDWZhwwe3g28yQ4gfR6Otod8or8hmFDCMK8h5xhklWMthjnzo+iHtGvzluCUTeXUXhQvBnYyZ0RwERjODwO7Lyw5uOzT9rGqHQrbwZtlP+8gYFQZrww3DrqlAWOwRDU3r6+eXdXRoDnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ne+6CHolEFw1RgRlEaPA8/YwN8YnHhtvGJQHG6eRAwo=;
 b=dZnXK7mCK29wTtpjjIzjrJT6StNezGKRZYxz0/j579XrxJhyqOBDTGAcL4AXq/I82BycA3mbujuoqf4B4sd2lDVpAqnz4kCFWsA3LS3HH969PhngegMHKIumWC+8bR3PuikPCocf17hbzPIw3d21TTNIESSi2zFM9G3uYU9mD0Om3YNGA1asbz2dC/sQb/njepWdJ+dPhkpMbrp2DouDUK+tkc/9iuC1xuD1kxtiojq+Zr9NiAaqYZMAu23UoYcJkTVcv6oL1CA/YUSHnYIkWOXCnVXHKo/pvRO10CwMCe40jyBTAXHoJevt7TZ3dG9nRBz+E4fulS9trg5vFufEJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ne+6CHolEFw1RgRlEaPA8/YwN8YnHhtvGJQHG6eRAwo=;
 b=m4RD8Tp6bKKHj3EwYtyPQVYPN2x0ymW1/RMBnNE99AnGcCSl0TEyBpNxK45P2pN8lNQrlPrgl9ALzRTTS7dKUaEw2o0opfN7AZOOy0vDyVLnDB8eNtT4ZYl/qcFXOua/NAtnVZ8p8YtqAqu1QaQuKl3F9p3J1h09tJjL38z2G23hdPqOI68aYcQCW4KzNHIJgR3y04urUW1Gg5qHIB/QGpy3ek7BKvbpyhm72kXiIrAGnJgVloB6I5HTj5QnS7IVFNGl0GepxqddamsUEoOTkvE+QsDr+GXOm3Elca7WzgXhMcpVdY8ZHeLfzC9sbhAHnr262M31YY+cTRXjOdba2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DUZPR04MB9727.eurprd04.prod.outlook.com (2603:10a6:10:4b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 14:08:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 14:08:52 +0000
Date: Tue, 19 Aug 2025 10:08:43 -0400
From: Frank Li <Frank.li@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Larisa Grigore <larisa.grigore@nxp.com>,
	Mark Brown <broonie@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>,
	Fugang Duan <B38611@freescale.com>, Gao Pan <pandy.gao@nxp.com>,
	Fugang Duan <fugang.duan@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 12/13] dt-bindings: lpspi: Document nxp,lpspi-pincfg
 property
Message-ID: <aKSFa+Dj895HMJrw@lizhi-Precision-Tower-5810>
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-12-9586d7815d14@linaro.org>
 <aJ4ox8+OLhIir2bU@lizhi-Precision-Tower-5810>
 <bd59344b-9dc0-42bd-98c8-80ab9ca97123@linaro.org>
 <aKNJFJDf1Clnkbex@lizhi-Precision-Tower-5810>
 <91b3e06d-501a-48db-b626-5f056287a451@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91b3e06d-501a-48db-b626-5f056287a451@linaro.org>
X-ClientProxiedBy: PH7P220CA0067.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::9) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DUZPR04MB9727:EE_
X-MS-Office365-Filtering-Correlation-Id: fda06d1f-5e3e-4910-e352-08dddf29ecf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aYya4D87VDIXCiCNp9C01myeUNaUgbpJ15yl9F0gtdZfIYqjqLULH1kp98Mb?=
 =?us-ascii?Q?8Ef8lWleoBsURhCpHK+4eCU3KUkBrEq2vdqSeFddSZ8HxrlA2sv3trN7eLh1?=
 =?us-ascii?Q?RNkGaPVqKfB/WbpaGSWcAjYxinov8TYr+L9Ys0h+WB+W9UiQk3vRv4Dy3nbX?=
 =?us-ascii?Q?fdE/p6ZAxvYTibdFXEz6v3G2ng2PvIaO3NLU3VRf6PYJlvShhoRMoVXhXQ7I?=
 =?us-ascii?Q?bDbjR8fZKYw/h7+3lAC16NVsmQwIn/0pOSTsp+WO1eCFU6zXwcbEUtVQaEBK?=
 =?us-ascii?Q?NoUA5ORl/7H25p28CaNNEHxUyzB+9faqVSuUW7lCxHVVIYFg9s/Mc+WqwgXP?=
 =?us-ascii?Q?PGADl78Rj5qapw9owq0HN1nd9gYuKJp37CFWhokW27C3ZgrD5LCjgSywf5zM?=
 =?us-ascii?Q?/HF9us9H5LEiPQnG7TFkbyGeg1CeP+BWs3K49AH4Vb5JIQCjgULFH5qhRjVM?=
 =?us-ascii?Q?iVlp7eGtFUqmsiAOpjZfgazTAnmG6iA538GYLzZq7KUc8UGaXdjkWhZZNvRi?=
 =?us-ascii?Q?dPZ5pb+JKGF66gzVbZcOlCDPufbNu6qhRqlV/1t7wf4Q8zeLyWhWdaXb+lc7?=
 =?us-ascii?Q?WdLpeeO3u8UOFd5qpRHlCbnrn6quJ1eoPC+X8ruxJVvu8che6zexmiVzYBYR?=
 =?us-ascii?Q?FJ4NvSfEzgf8Mqx6Bdm1rLfk0lunGO9UWr+GrwcaNPMH99w2tFhPuwHG8MvI?=
 =?us-ascii?Q?1KyE3wzysJk0uIkp2ajMf6zGKry3Qo9MfPHp74wY/JZ2FaDVCkNW8RN580uf?=
 =?us-ascii?Q?9CJQdfGErQriWxtOyoZSzx7CkD1x5YEXplNZVUP4j1hAPEk2UEvSHljYq432?=
 =?us-ascii?Q?8wtK8A8tHPNhVKBxRo8qWRHL/svnIpNUUC2U10p5L33RGCycFzdLdsCi7eF1?=
 =?us-ascii?Q?Vk42R2wyoK766bzXFQ5fKOP6YlB5JUQusPaRoog7ABEWbu4f1N+/fTYHwBg5?=
 =?us-ascii?Q?Bi90Dm7BE+y357EjDWqvWXhDUoLeCk4meYCQXfqdmPGErcf1yr9dbRKtGUx0?=
 =?us-ascii?Q?c0vwnwt89hvHNgtTTlsQM+JHpMrkavGnQuTFiZ2/doSD6C0fkKU5poDt7YvI?=
 =?us-ascii?Q?OiqbGCnukk732xLH7tet4Nocv19b4cjOfqssN6Ys7/Th3UM1QxVjF48SNuSV?=
 =?us-ascii?Q?+CmmWMQSE968e6KHNmZX5zNOI5+vgqMlmO731+Ok+u2xYuH2W0Fc/+MXvuUq?=
 =?us-ascii?Q?G6P5sAR89q4wHy8S5WR/5nzD85jthjgd6QTw3MoZp4Y0UdevVoKPqbWPdEsu?=
 =?us-ascii?Q?WNDRfLTRPdGMbj4cRfONWLDEeK/RrcWr1BW/i6k3uWd156DKBbcUWeVpxzm+?=
 =?us-ascii?Q?kOp4Ewxm3f1A/0DR/bTxTSJwStShTw+jjAqHZeHp6Ro12sM0CHweeZjDwfdI?=
 =?us-ascii?Q?5d6gaaf0bG3bgSx6BhMVSbO2pqXEWVOKWhPMSgDKKJ6tiAAZFU4cfzlMZ1CE?=
 =?us-ascii?Q?AgMBlvQN5zEEP3Jm2jJLsu/l85r3nkAhKUC65Ak/Q8NkLcwg1QoO/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CwY7pQZlye71X2X/dTSE6wkwpAha4iz1Yetzb/Z76IBpph5Xk8NF/dDIyQ3d?=
 =?us-ascii?Q?uEj6ysHLVXANLOmfoDJOS53mAihjdEOS15oJR2P77BAcZMhs+OXKa8q2m0LQ?=
 =?us-ascii?Q?Q4gc1iz7ip3a0rBfq3WswrvJoR9iKM7sex2geIVayVve2Mk2J3l/jsI0oh8Y?=
 =?us-ascii?Q?Azfb4SOPVOv+dqwkXCSJFAvVGzHUSnrEM1bMZ+sGdh0Wm7+6yM0Bd+sGC93E?=
 =?us-ascii?Q?yM2pUizFuiLd86E2Jk5cEa/+TE2PQDjGWO6tMsCuWGn9wGtde2GngC5/Ooaq?=
 =?us-ascii?Q?oOLi+kKL3SXsALMYzivYWwtwLB7szCteBdQJ3Bx9AOc6OxyJgRmbjVU/Q6AT?=
 =?us-ascii?Q?D7ek+uEFjlmISx3h98+kKBAV04Dc+WKGZzIhO/V8yvkXfkz4z15fn4iQMJnc?=
 =?us-ascii?Q?OEMZgcNECbgZVxBCnlJAZybKnTx8sXA355B2xBrPiX9mi7yQRSlUPKD5N28u?=
 =?us-ascii?Q?c8dikU+XLL2Ds2VFl09Mk9slECjVkQSeC1fxxAuAj282wk7AMsxWAsm//WCn?=
 =?us-ascii?Q?4EQKTC5b8906ObIik0ziun/POmfLytn7oTdOMSB1uwgtsyUWTlXPKyRQtW/M?=
 =?us-ascii?Q?okiRTHrQ4Tb33XPBKOdQ4lxdnF0yfz3bGuryc3a2JLxYpnRnnvFCdYO8Q0bD?=
 =?us-ascii?Q?ZSHNiuifElFPhbiMWMq33PC4H92zjP17vAcvBw/78DOTaO8CzU6tkpP+FKfV?=
 =?us-ascii?Q?OkCyRBSEOtqvaZ/q1zLFU4tss5DdQgXN7cBIJ4pVrIPpY+6YKHuamqx/9BUk?=
 =?us-ascii?Q?1Mm+KuH7ZdcG8JA/Uk/MfuTwN/qzvVHqXBOvT3b+YAJd4PbgSKD1N0QRo443?=
 =?us-ascii?Q?hZXirkbd02eW6Vh/OKkLmJghLLjuYG/ZVLU7+Vf1XD9DYISOY2hm6/IUaLKF?=
 =?us-ascii?Q?Lj6pPqZp5YuJpGIksqWFxBu6APklWkLPcNAdsNer0+BYZQkGLL0r1Ed7TvHe?=
 =?us-ascii?Q?eViSXQeQEylfwGANXQgFfh2GBtaMZvG0tRR7OfwmNVRk85Db8uETqeE4nP6t?=
 =?us-ascii?Q?MuoYabV0RemdHcRDvSolcNjbUIgSdiTvF99B0FZzQNnVhiuv0bJjaL5dsi6z?=
 =?us-ascii?Q?WdbTg/HBK4TQWrAz+4K88tgniLbznIcZrW14+d8CKWY1RtywO4ZCjQmNth7x?=
 =?us-ascii?Q?/lfKJAc4rnXAiywHi0TSwv6/DHGkVB+70IX4y6eHZfBdtoex42PnStaeItoB?=
 =?us-ascii?Q?EJSLcDwrW+W3ieY8Ysw7v9hXFH//3PyDfB9lZa8fsOvGm40ieUfu/ACLiL5v?=
 =?us-ascii?Q?1fLTAiCJXY/ln+FPKvUK+B5DGOBZ41vMsFc5pMGlPY/5ppFsSWjbwZzDXeeK?=
 =?us-ascii?Q?AOnl9lUzZuSrCeo83VWGU++O5GclXrCwO/CkZeBsIpkssIPM9oJQGSdgjUrX?=
 =?us-ascii?Q?jM5zUeO6oYhrCmEQN+y262zZGRv3ktIzVVrPsSLDoc0eKsS79qMiRekHGJhw?=
 =?us-ascii?Q?I6J1C4Zwc+g4SA3FMOl37c9qPMYxrXVAMFIDGgjmBytzB7hlYArL25/JBE1H?=
 =?us-ascii?Q?33OqLSd0fS9VvZql94JxoKMErO4Qv6/QiWKdb63DWAHASWXX4zbuPLrmd81Q?=
 =?us-ascii?Q?Gq83raUXXuJpNx5MLlXld/LTOLR+GVnyU6xIWZRj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda06d1f-5e3e-4910-e352-08dddf29ecf8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 14:08:52.0964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFAmsX8DWc28w44c4gBIONTarLDyfm+ZrJ9qS3YmkBBIp4PE3q0B1bWTYvD5bEoBFfOWSAW/Bf9G2F6kT5hlnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9727

On Tue, Aug 19, 2025 at 10:51:03AM +0100, James Clark wrote:
>
>
> On 18/08/2025 4:39 pm, Frank Li wrote:
> > On Mon, Aug 18, 2025 at 03:47:45PM +0100, James Clark wrote:
> > >
> > >
> > > On 14/08/2025 7:19 pm, Frank Li wrote:
> > > > On Thu, Aug 14, 2025 at 05:06:52PM +0100, James Clark wrote:
> > > > > Document the two valid pincfg values and the defaults.
> > > > >
> > > > > Although the hardware supports two more values for half-duplex modes,
> > > > > the driver doesn't support them so don't document them.
> > > >
> > > > binding doc should be first patch before drivers.
> > > >
> > > > binding descript hardware not driver, you should add all regardless if
> > > > driver support it.
> > > >
> > >
> > > Replied to same on "[PATCH 10/13] spi: spi-fsl-lpspi: Add compatible for
> > > S32G"
> > >
> > > > >
> > > > > Signed-off-by: James Clark <james.clark@linaro.org>
> > > > > ---
> > > > >    Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml | 14 ++++++++++++++
> > > > >    1 file changed, 14 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> > > > > index ce7bd44ee17e..3f8833911807 100644
> > > > > --- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> > > > > +++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.yaml
> > > > > @@ -70,6 +70,19 @@ properties:
> > > > >      power-domains:
> > > > >        maxItems: 1
> > > > >
> > > > > +  nxp,pincfg:
> > > > > +    description:
> > > > > +      'Pin configuration value for CFGR1.PINCFG.
> > > > > +        - "sin-in-sout-out": SIN is used for input data and SOUT is used for
> > > > > +                             output data
> > > > > +        - "sout-in-sin-out": SOUT is used for input data and SIN is used for
> > > > > +                             output data
> > > > > +      If no value is specified then the default is "sin-in-sout-out" for host
> > > > > +      mode and "sout-in-sin-out" for target mode.'
> > > >
> > > > why need this? are there varible at difference boards? look like default
> > > > is more make sense.
> > > >
> > >
> > > + Larissa. I think this might also be a question for the hardware designers
> > > about why the feature to swap the pins was deemed worth including.
> > >
> > > I'm assuming the flexibility is given for routing reasons. If you have
> > > another device with the pins in one order then you can route it without a
> > > via if they happen to be in the same order.
> >
> > DT team need reason to judge if a new property is reasonable/neccesary. You
> > need  mention the reason why need this property. Here, some board design
> > swap sin/sout.
> >
> > >
> > > > SPI signal name is MOSI and MISO
> > > >
> > > > Frank
> > > >
> > >
> > > As mentioned in the commit message of "[PATCH 05/13] spi: spi-fsl-lpspi:
> > > Enumerate all pin configuration definitions" the names were taken directly
> > > from the reference manual and this doc text was too. I think diverging from
> > > CFGR1_PINCFG could be potentially quite confusing. And MOSI isn't mentioned
> > > once in S32G3RM rev 4:
> > >
> > >    Configures which pins are used for input and output data during serial
> > >    transfers. When performing parallel transfers, the Pin Configuration
> > >    field is ignored.
> > >
> > >      00b - SIN is used for input data and SOUT is used for output data
> > >      01b - SIN is used for both input and output data, only half-duplex
> > >            serial transfers are supported
> > >      10b - SOUT is used for both input and output data, only half-duplex
> > >            serial transfers are supported
> > >      11b - SOUT is used for input data and SIN is used for output data
> >
> > dt binding is ABI, design user easy understand property string.  like
> >
> > enum:
> >    - normal
> >    - swap
> >    - half-duplex-on-sin
> >    - half-duplex-on-sout
> >
> > Frank
> >
>
> If we're not directly using the names that get programmed into the register
> then it's better to remove the implicit 5th mode that you get for leaving it
> blank and to use that as "normal" instead.

make sense.

Frank
> Then "swap" is to swap whatever
> "normal" would have picked. Otherwise "normal" being a fixed value doesn't
> match up to the current "normal" behavior which is actually different value
> depending on host or target mode.
>
> So it would look like this with the "if no value is specified..." bit
> reworded too:
>
>    description:
>       'Pin configuration value for CFGR1.PINCFG.
>         - "normal": Hosts - SIN is used for input data and SOUT is used
>                       for output data.
>                     Targets - SOUT is used for input data and SIN is
>
>                       used for output data.
>         - "swap": The inverse of "normal"
>         - "half-duplex-on-sin": SIN is used for both input and output
>                   data. Unsupported.
>         - "half-duplex-on-sout": SOUT is used for both input and output
>                   data. Unsupported.
>       If no value is specified then the default is "normal".
>
> > >
> > > James
> > >
> > > > > +    enum:
> > > > > +      - sin-in-sout-out
> > > > > +      - sout-in-sin-out
> > > > > +
> > > > >    required:
> > > > >      - compatible
> > > > >      - reg
> > > > > @@ -95,4 +108,5 @@ examples:
> > > > >            spi-slave;
> > > > >            fsl,spi-only-use-cs1-sel;
> > > > >            num-cs = <2>;
> > > > > +        nxp,pincfg = "sout-in-sin-out";
> > > > >        };
> > > > >
> > > > > --
> > > > > 2.34.1
> > > > >
> > >
>

