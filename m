Return-Path: <linux-spi+bounces-10863-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F4EC105B5
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 19:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26473464A27
	for <lists+linux-spi@lfdr.de>; Mon, 27 Oct 2025 18:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8AC33032B;
	Mon, 27 Oct 2025 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HNzlSNof"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013024.outbound.protection.outlook.com [52.101.72.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DE632F755;
	Mon, 27 Oct 2025 18:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591035; cv=fail; b=LN/F/BqpUENhyusn5hAj9z+PO3nypJaT0gdLiP24JMsZZ80ANoQqMi5IRhCze6Lq/KDdJzDnPZL2iLJarOp4WExYtrVvq+uukfvMGT7ITLKBQWo3GpXiQaTwVldBGwxvdw1AL6njLJbaht/4OcYlWJUeMW60l7+/VKDJ45VSOAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591035; c=relaxed/simple;
	bh=E5Pc9fbJhibMJTamIkPI66f06TsEwjtyf7Qmxzai3dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NDhYVbLNUL3IQo8bvfTTCVFkNfcvyL80cXO4JxdotP+gyQf5NMd1uuZ56igPUf4yynsIjM/RFUKsPvzt/rxUsJ9JyY0KOBiBpvt1SAqApXsscW91yeD1xcsRPbyuGRWQLNa6w0gS7n1vFFo/3kn9uD4Mkff8GOqthK2KwBiNgMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HNzlSNof; arc=fail smtp.client-ip=52.101.72.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ieCazSpJjtbmBpPsacrualaVpON+xmrWpWNpzzLXfkiQHgl81OPaPQs7MpJu4DYhNY9xox/sNeCj1XwTajRP9eg1P7VxY1Zf7HnyqSyTc+iJj797Qsl76nCQ6VVmXedNF+RlNeeJgLQE+HSp3XSdqrA90hY9qMyePBmIm+aMpOmUE7JlLwy2fKeHtpo307oZbWdrEzk2u0+c5cvdq0e0grKDw5J/fJlWHl2YWuPy9xsjbabLX8HSYSPGrpjp+O94x51oYYPFDiGKScbXCTAKZAOfgrzbwB0bdtqCr0dF7Kt7o1IAYcnmP4rey5c2OXbacVQgggNafpwY2F58pB8I+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aq3mRXZAgvKFJUq1c/lN7f16a6dx7afUVteRnnsVfCI=;
 b=Of21t3lYkRQwBJURpnOsfpJ9+s5ZZc//Q480RzEBgQVqh8rQI3eveQGtyI1OEafKE0sIYnWrzgXL2Kfc2PR02Wx0Ud/LsSrxfanpByzv4yHODwLc9fLakmPYt1DKc2qHEwz+bMDjPMVhzmRXrjO9854/Q9NeorWHQfFNptak+ohYu7Bc/Jystu+6ybwgMeKYVe3XHA8QoQW+BqBea3IALwd+7x7dW8W44KBOAUcvM95rFSgOXNErhRzeKStXrXSVWkmHrf4msQler5h25ouEJ8n0q/hE31Mk6uWwEDyyUSgYNhR4JU2zHW7qs3rT/XRC83q5CgI1jK4jfK0D5MWIuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aq3mRXZAgvKFJUq1c/lN7f16a6dx7afUVteRnnsVfCI=;
 b=HNzlSNofsxuMla6HC+HZ/kjGO08Wz+8Lw3LT/op8z8j4X67cagdc2Dl0H80K0mwjZSEu8uw3w0nrgQ4fSe0kDXlhbirkFkkD415rBTnXse/KWqrc3Qslyh3hP7jlq8SnTzg4aVA2AD56bfzd3ZBDl0rhZfndHKQAuNjJ5NeOs/FBV8XNtkfOhOMTfJPdTD8Bx2pmNvU0v+oESnKUlNt4rdIKR57aZb11KjPNUGRqd4LA6TRjPyK9WNZ79onfyhyQc955LIlazJk/muPUMUrSODugrmAk07wa752vMBUt4cCFP6rthoSXW8NAK/9i5Pm5wZRgyEydAdiguySuVkFkTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by VI2PR04MB11148.eurprd04.prod.outlook.com (2603:10a6:800:293::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 18:50:27 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 18:50:27 +0000
Date: Mon, 27 Oct 2025 14:50:18 -0400
From: Frank Li <Frank.li@nxp.com>
To: Carlos Song <carlos.song@nxp.com>
Cc: "mkl@pengutronix.de" <mkl@pengutronix.de>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PACTH v2] spi: imx: add 16/32 bits per word support for target
 mode
Message-ID: <aP++6ghId1LvQ1NF@lizhi-Precision-Tower-5810>
References: <20251024113107.513604-1-carlos.song@nxp.com>
 <aPt+JJhaB9dUOwL8@lizhi-Precision-Tower-5810>
 <VI2PR04MB11147AB20690F99BB6CEE2300E8FCA@VI2PR04MB11147.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI2PR04MB11147AB20690F99BB6CEE2300E8FCA@VI2PR04MB11147.eurprd04.prod.outlook.com>
X-ClientProxiedBy: SJ0PR13CA0226.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::21) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|VI2PR04MB11148:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e95c72f-ff5b-42dc-1a8d-08de1589b188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|376014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BxjG13GqeNBWVcoUXOcNQp0ezEjqXtUdaDpNZQ4fWOeEOhexGRPZm3wrPRbz?=
 =?us-ascii?Q?eorNolPQ+7a0cFhLubybnQJMx+lZF03ovq5jWPclDJoqpAGIZRMf6ZhSzS7j?=
 =?us-ascii?Q?Rh6chHqph6PzE53PseeDjSdeuP98eW5KYMijTj/VK+eTbCzMZqZAHQ1zqP+L?=
 =?us-ascii?Q?61P2RkOE85SN6+DPxEPC5fVyWlt/0Nq6BmUszErTZYj1+Zy7pQNAbNAvJvwU?=
 =?us-ascii?Q?0d/3PN+p05+RGgLeVR3wW7Vf/Xz8LX/qTrLyJHUpjm5uWvkIAcNXDTwntn0V?=
 =?us-ascii?Q?7zr9j3aODDn+zB/rw0j0LIFqDcND2KNKMfEnteWz6s10YLm/8b9+0YEtlpcv?=
 =?us-ascii?Q?eZ7xVESsTULtR5WZiViKDVbwi6t268oqzZKaFSAHujc1eS8UQ14IFwV4J56U?=
 =?us-ascii?Q?hhB7TO3Glp7ozi3waFu91euyEPm5esiAet3I3yHgQY5Nuv30gU02rZpArZpu?=
 =?us-ascii?Q?EEj0c6jVVfGnaWW0fsXj3v0UuIu0ru8v+vtyE2j2lAJh6x2xvYUuhqTvicLC?=
 =?us-ascii?Q?xmrFMrC+QJANFoSOdbA2OYyxN0PXH7Jtp/cLtGI0b8XXPDSOCCKuDz+OhC0Q?=
 =?us-ascii?Q?SrASHKS5Km1iANj2reTBAxH2rO3aY3FEA7vE/4mSbhINGAhH0lOYRpSzitsq?=
 =?us-ascii?Q?ESDu/w5wxpGpfOTUK80bonh2gacVRuMSF34D2iN2szgyiRdOa30X0cPiBNoN?=
 =?us-ascii?Q?REYfhP6fSigXW9wacmoO4fMkr2AgYsB/MBoNonj2Ph49PrZ3evQ6sQhY+hx4?=
 =?us-ascii?Q?emfdJrj2XJ+ZXbUQ0q4lqAxXA+tCxzsCNebZGddZP1vL3vX1ITP7xhKhnpKv?=
 =?us-ascii?Q?gIm2Qnrk+LkhFqK+9YdIXLZqw3D1fmzMFaP/+QyrBpw6TxAVADGxqrK1IEDo?=
 =?us-ascii?Q?pZOeyn2REaeGhGoeEzff8WcZSSSDynvfXRLjFOQSnwRwPY1Mb5CvpZP7ukOO?=
 =?us-ascii?Q?/6ccVDWTvKbZ9G69PlbJp7J3xHIzcchGyg/5gyiDXNS8bBY0SY+T2Rm4iiUY?=
 =?us-ascii?Q?1k9Luibx33ijhrohFNP4F4e/GjLejOFV2qaVbJnF2KR7LgsA1FeuNUFc25SB?=
 =?us-ascii?Q?si7RxtXgsWZ8+ov7uu0iJOpM8kla7bD/LRGjkWpu2MOvhwltiZW49vFjewoQ?=
 =?us-ascii?Q?V/Uz96w1Lccejor80pAh40GwKrqGvSw6zYO2lAqWCbhtGL63vlVT+eQcQT0H?=
 =?us-ascii?Q?7F1U9LrClFNQu3pI1iMJZTet5gbr8F+xCenqNEaysMB3Hqd7jDMjAYklym5w?=
 =?us-ascii?Q?ITTBgDhOp3/7eRaQHHqBvF88iNzEdmQj1D1tXYZ9pis5GJIoVMb/MrgJXpx5?=
 =?us-ascii?Q?zL9NH1KyzPZxQHRxlRV0YnMgCKHIJQLQW7cWnMhKauNSNhLEOelaYduN4oHj?=
 =?us-ascii?Q?p6QGPK/W69D3kKuu5M/l4MkE5W7F3xOr1sSyavVet8u45Av6ueJ1pK6WpmnW?=
 =?us-ascii?Q?ejZrKsbw6cLn+GcgXjEFNLq73A3WBUO0dSgphRWVRLW3B0q5mB36hYpkRpJ/?=
 =?us-ascii?Q?LIsvgAaETVhyzjNipIzJv1I7M3nHHZjSgdG1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h37XW6ETYyXSTJlbH0lHsFg7GDPDwdqsXO1grG7i6CWA7gwmAkm5IZZ88nzC?=
 =?us-ascii?Q?y4q2zhqZAWjV3ygjtqjDl4UlOEm8KFMwIj/9LTED3psa5HIJL0c1CYf8RbqP?=
 =?us-ascii?Q?BGkDmsW7Kbg/lfI6MOz6sqR1WcUT6b0JjL7txr/5zcrG78aQrJSg61INC2DX?=
 =?us-ascii?Q?WgPgQPFdC5QAnDX55XRPBhONphCuKIwKepoTKisnVhlavMsFSd0R1onANEH5?=
 =?us-ascii?Q?wS+DH/UJVm+JxTcnXe7b/MLRX2LNjcwZ43nhHNj3EMgMIPEZ57m9AYTDqlR1?=
 =?us-ascii?Q?PC1Cijsii7i/l5XLYslShF5NNXRQPTLrvOH8lMY6e6Joe5wFtBKU+lA2vGBu?=
 =?us-ascii?Q?xnPzFAL5LAlQ+i7WV+IzUm4E7dwtzMHEy3y7bnLaf2n+EmW1Zef3Cp7b+MH5?=
 =?us-ascii?Q?UG3MnyVh0SPY8VXFnvWi1WxeGJtJ1KkXsVjObUdj6na+V7WiJ9FBwn30noA2?=
 =?us-ascii?Q?otMOHKZCGzEuvuY8pncCRpxETzNq3pMf5kFZjuc42KY6OzWyahZDt6IDbGco?=
 =?us-ascii?Q?zx1vHuXak3/usWCoLJD4pXp9k679z07oujt2k5GjTrISqwEzAl5P5fqr4rTx?=
 =?us-ascii?Q?/R1rqiMYqi6xVhrefNrK46tp24itOPIznQ+aply5d0WOr9NXeuWDtBfQnTAV?=
 =?us-ascii?Q?MEebWe1aThsh9SLW8A9KucKDmlCqC1bxD/TOb2vk3ihL94H0f0qrGptHrsML?=
 =?us-ascii?Q?SHTn8DZIbRojYBETQudb0FMO28mk9aXwaOCRxzlLWwkxsw9UCIdWkoGbXpPV?=
 =?us-ascii?Q?Jn0LW8bYz5zW74lbX7PH5AuNazmfNghjuykDou7SwOgcA0m5pFtTyNO3/mLf?=
 =?us-ascii?Q?HECWwZjuVjMbfSdCExJ7Ufup1k9hK1CzS73MxySIqsXLfIN+H7hJ91z9912A?=
 =?us-ascii?Q?ja+Kmo/vtjiHtTgz1TTBEbBDf8PtP2yRS2U+5nS8gAT60K+WHNuUm7MwRPW3?=
 =?us-ascii?Q?JbTvVaWuaFLWbqx8GSNRg408NvQMwicDWuqT2oFkKliSRNbjfk9RPW9/Kw4r?=
 =?us-ascii?Q?jqEHc810vCv2nCjJBt4vQMG3JlTZLWfR19f4I4fPI+3CpCJBxo+fO9Ii5xmu?=
 =?us-ascii?Q?BFqmzIAe0WDcHCdcH9F1IEiJJYZyG1nEaAx6g6+KETpiSS/BI0rFSE8Czijp?=
 =?us-ascii?Q?IrLZ1mHv+Uyu5vCUjl3kwApyPN8vrjCIx/Q76PRlq+E3oxeWyKvadf+evOV6?=
 =?us-ascii?Q?AttrTMDy/UdBRWAnwzLwYdTWetF7PPkpYlMreO6UJpd45SHJAXzBmaZOJt/i?=
 =?us-ascii?Q?6sgGF4qlLj6X1+9FN/ZXYvMYd2duuUA8HvaH6xRyFPXmumaFN0RQzRHwRZQY?=
 =?us-ascii?Q?NSEGnuMKT2qoA3IdjqBJXfL7wRyCJPq5Ko+J0FCCFNH64JEy5x+CRHyNUnSZ?=
 =?us-ascii?Q?URvZbOdzZ1cPAcDePn6w3RoNZfsYGRe5xnu60+PA3DBu3lP1C9XkCrzv8TBz?=
 =?us-ascii?Q?bf9pEvzgC9bH9c/xIi0tFfGjUlVl7hlEEjyN4xUUZqMO7Y8EG97GI8s0XFH0?=
 =?us-ascii?Q?oG2esBBq8iDWZdTbdKSLLeICLnvdMGsDGKlS6f04QgsDj0nASQ3/uyuGnFxz?=
 =?us-ascii?Q?pKZe7L7hI+cC9P2urvc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e95c72f-ff5b-42dc-1a8d-08de1589b188
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 18:50:26.9600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +S9yizvfJnxMklcNXPuMYcihxzqn0E4fFIY04zC46jCuUxFEeZuhhiiEX1B6Vux3OGxgcbGq0GBVmmuNwBieaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11148

On Mon, Oct 27, 2025 at 03:39:36AM +0000, Carlos Song wrote:
>
>
> > -----Original Message-----
> > From: Frank Li <frank.li@nxp.com>
> > Sent: Friday, October 24, 2025 9:25 PM
> > To: Carlos Song <carlos.song@nxp.com>
> > Cc: mkl@pengutronix.de; broonie@kernel.org; shawnguo@kernel.org;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > linux-spi@vger.kernel.org; imx@lists.linux.dev;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: Re: [PACTH v2] spi: imx: add 16/32 bits per word support for target
> > mode
> >
> > On Fri, Oct 24, 2025 at 07:31:07PM +0800, carlos.song@nxp.com wrote:
> > > From: Carlos Song <carlos.song@nxp.com>
> > >
> > > Now for ECSPI only support 8 bits per word in target mode.
> > > Enable 16/32 bits per word support for spi-imx target mode.
> > >
> > > Signed-off-by: Carlos Song <carlos.song@nxp.com>
> > > Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> > > ---
> > >  drivers/spi/spi-imx.c | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c index
> > > 155ddeb8fcd4..017f83f5dfdf 100644
> > > --- a/drivers/spi/spi-imx.c
> > > +++ b/drivers/spi/spi-imx.c
> > > @@ -424,8 +424,12 @@ static void spi_imx_buf_tx_swap(struct
> > > spi_imx_data *spi_imx)
> > >
> > >  static void mx53_ecspi_rx_target(struct spi_imx_data *spi_imx)  {
> > > -	u32 val = ioread32be(spi_imx->base + MXC_CSPIRXDATA);
> > > +	u32 val = readl(spi_imx->base + MXC_CSPIRXDATA);
> > >
> > > +	if (spi_imx->bits_per_word <= 8)
> > > +		swab32s(&val);
> > > +	else if (spi_imx->bits_per_word <= 16)
> > > +		swahw32s(&val);
> >
> > Needn't swap when bits_per_word > 24, like 32? or our hardware max support
> > to 16?
> >
> > Frank
>
> I think we don't need. We are reading/writing FIFO by 32-bits word. In this case, we just need keep
> the default byte order.
>
> Is it more reasonable only support bits per word=8/16/32 for target mode?
> -b 8/16/32 can cover most use case.

yes, I only can't understand why needn't swap at 32bits workds, but other
needs.

FIFO 31..24  23..16  15..8  7..0
      B0      B1     B2      B3

next you

in memory val is

0x0: B3
0x1: B2
0x2: B1
0x3: B0

swab32s() to  bits_per_work 8

0x0: B0
0x1: B1
0x2: B2
0x3: B3

if bits per_word 16

val

0x0: X
0x1: X
0x2: B1
0x3: B0

after swahw32s change to

0x0: B1
0x1: B0
0x2: x
0x3: x

B0 and B1 still be swapped.

Does SPI defined term word fixed big-endian?

Frank

>
> Carlos
> > >  	if (spi_imx->rx_buf) {
> > >  		int n_bytes = spi_imx->target_burst % sizeof(val);
> > >
> > > @@ -453,12 +457,16 @@ static void mx53_ecspi_tx_target(struct
> > spi_imx_data *spi_imx)
> > >  	if (spi_imx->tx_buf) {
> > >  		memcpy(((u8 *)&val) + sizeof(val) - n_bytes,
> > >  		       spi_imx->tx_buf, n_bytes);
> > > +		if (spi_imx->bits_per_word <= 8)
> > > +			swab32s(&val);
> > > +		else if (spi_imx->bits_per_word <= 16)
> > > +			swahw32s(&val);
> > >  		spi_imx->tx_buf += n_bytes;
> > >  	}
> > >
> > >  	spi_imx->count -= n_bytes;
> > >
> > > -	iowrite32be(val, spi_imx->base + MXC_CSPITXDATA);
> > > +	writel(val, spi_imx->base + MXC_CSPITXDATA);
> > >  }
> > >
> > >  /* MX51 eCSPI */
> > > --
> > > 2.34.1
> > >

