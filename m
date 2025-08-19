Return-Path: <linux-spi+bounces-9535-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98226B2C6A3
	for <lists+linux-spi@lfdr.de>; Tue, 19 Aug 2025 16:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D4D67A1AD0
	for <lists+linux-spi@lfdr.de>; Tue, 19 Aug 2025 14:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9334422126D;
	Tue, 19 Aug 2025 14:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A5hdaJwJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012042.outbound.protection.outlook.com [52.101.66.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8C9218AC1;
	Tue, 19 Aug 2025 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755612684; cv=fail; b=SXQyRAUXhy2+ApGQS8/JHQagKDfsMtg+apoVtDz7Kz1EvPuRWxpFA0Xm1rU1tHVgTTFBb2QFQGlLd3i0q9OqAfSvi61/iPQmbSofGUDDztLR6sE0reG1n+Px7Czlnn1K+lDFMT3jyeBk2ZsdYYcC4gKyR4NEtVyyc/JLNPRxRzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755612684; c=relaxed/simple;
	bh=wcoKe0v6zpgPKp1NRqnIIOpbCP1DNAGVN9LtL00vKsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UGOfdBmvKJrg6xXVPw1O931DX5MfdrIUnuItisRS1tc3K0bXO9gSwbTQeljwyx8xsDZK3xLh9YyJEviBLY+8xPkAnYdNtmp5WVwRpoy05d37sinx4i4knA/H29zPDfVEcp6UulesPZw6nJiKtlXnAbmH7s1lCPt5NdQvOuHdVP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A5hdaJwJ; arc=fail smtp.client-ip=52.101.66.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FzgFzRWjL6oMZCZ1oDKsMe8JPTXyQcSzWaX9G7/gua4Qape2sfKGXb2OEXDnuvYjmEeoZkqio9yYi9isLjeQyja/kojU2iUCMjPIqLse4YAherf6yLjltDHH7CTHDntJWyTl7kyRyhV0TCsGkAuLjcOAlRZtb/Djf7a0Blin9TTs0VFUk1XiEAQH0TBpjj542XVBGVO5yoygURmbf3ef9o02a7zST+G391p6ysLusSKuf0F7NDaIaTOtBHr3beDhZJ+kzJkIPZB0qvaLzfRLI2Pfy3t+YBzW4wQGbvmWi67GDmWST7KUh20RKyYPZS07/ZVLjEJFRmC7axPRJyC5CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hF3zR5ZgzrMwFbmsQ2ctO9LdgvWSyevjL7UppgLQN7c=;
 b=H4ugZZiYPw4+LZicaVfRk3qB8UCtTMwLnwMCxo212tO/+UMKxzmB0YEjv6+NGiK+ZTPjbYI75RdmeWQ6MDY9KCZlYvvsnayOgwJPk4gV/yPznJv7tlUkWFwo54PELjP3wOCkjAcxPi8C9z6spzd94tqZhUON+AnEaNkdmyYeQA2fOCuEooRlIka5JkqqW0FRjuPI5f96rSHfn75QPGCtxRu7+jSETxHqc2Ie8omxZ1HteqLCvDJLKe3zBgRLFbL8NjEKedc0pTla6L2R1dAEcBEBNs6LiRdr7EG6iNRnuV/+fdcTVyy1qlzVADEJaTJ+aRHafMZkYlcKcbijPSkxYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hF3zR5ZgzrMwFbmsQ2ctO9LdgvWSyevjL7UppgLQN7c=;
 b=A5hdaJwJNdQzbcnd5qepO8P3Ps0RTfGe5bkWjfWHtFAGBPPQ4iEFgaHS//qImY5GkFkrbK54KpxrJnpyR+StxpsZMEZRzSP5Ku4lnH04tdRz15f39KLEF/sHbohoGGwtqiet2XF7SlZnAm+d400+8sC0Uc+vTCOajGcjFA8SJb4EnyZfA4F+FN/tLA7H8aLFGFKH0m3qvlLF5ySylG48u2eMcRcSNOqM5iHZN4f4cq38i0CkDMqOToXfzydmcoFh+l/S5ULcvzZiTFRmTYb59hBY+2SNZ3Qt+oeold3re1bv5emIKx0SYmjHLr6ph4H69+jrU2T0plsuSZy0IGi/WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB11536.eurprd04.prod.outlook.com (2603:10a6:10:5e1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 14:11:19 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 14:11:19 +0000
Date: Tue, 19 Aug 2025 10:11:10 -0400
From: Frank Li <Frank.li@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Clark Wang <xiaoning.wang@nxp.com>,
	Fugang Duan <B38611@freescale.com>, Gao Pan <pandy.gao@nxp.com>,
	Fugang Duan <fugang.duan@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 02/13] spi: spi-fsl-lpspi: Set correct chip-select
 polarity bit
Message-ID: <aKSF/mDIV2mKgArP@lizhi-Precision-Tower-5810>
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-2-9586d7815d14@linaro.org>
 <aJ4TkKdkIPiJhhF4@lizhi-Precision-Tower-5810>
 <90d40899-c9b8-4628-a0b5-06ee0aa497be@linaro.org>
 <aKNEfJrD+pp8+0dT@lizhi-Precision-Tower-5810>
 <7a81e256-ec55-4baa-a054-04c4fba0b5c7@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a81e256-ec55-4baa-a054-04c4fba0b5c7@linaro.org>
X-ClientProxiedBy: PH7P221CA0080.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB11536:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d0d677-ae32-4f16-75bf-08dddf2a44f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9DSrK5vaAbdFCqkrMQP4sn8b5tExk0Fv6bk0HlwrTHczlTGW3EUypOBeCHQ/?=
 =?us-ascii?Q?xyA56YDi0VJ5q7iPah2SI/un+d/u6EEVNCiE+lm8Eu4Q2yhHSX494Lpjsq7N?=
 =?us-ascii?Q?Ly1Ohsjd85dh9HQcdPef4Ue++qwUmgZW3qrJKEsaKiSzHfA+0GUx7ihEMJT5?=
 =?us-ascii?Q?btdLHX01oOgL1TSvC5DcMy0l3Pwlm4ZBnSPPoniqLdlPKbno/5eHpNN0CKTH?=
 =?us-ascii?Q?DdCoQsapzc2iSJ+QgOIx8AlLmOHuJt33Uf7RSfrv8HZp+92JhVze2pslVG/y?=
 =?us-ascii?Q?ItNcBi1g35EvULZn+yFGeM7e+5VY4KpIwtCf0TsnnSTd5gA8VVJswo0rLoBY?=
 =?us-ascii?Q?/vUkjLSfffL98i6WS9dOD5aMe5GV5bkVM9B5giYeeVAtqQeukgpX5Q6uwM6c?=
 =?us-ascii?Q?AVMUIOBakqq3oo6V3y9rFoIa162ckHCR6sEj9X1EYaSlW785OPbp2u6lsShT?=
 =?us-ascii?Q?tWdCNkLBBkfvSc0em2/h8D5vh4tC5mT6ls78wZEhAhUPcVCMwpLmxSdCLJff?=
 =?us-ascii?Q?qcTVYwwCBoXvGXJt1xf3rh3IO74RUdWLVJgiu6b2P6ndD3v1rO9J4NXwbZQb?=
 =?us-ascii?Q?P5c5VRh1tw/3xnlRKuRNyEjnZCfE6t2OtzNC+qDzPM621lwRgPF/XYkKsBue?=
 =?us-ascii?Q?mKWEsY9djOBiiW9GkO5EJcA4PmSv3HWn9rbwB4zfHUtzbrvJbdAmYRADC6MD?=
 =?us-ascii?Q?UEFHBY8R7QDUTDnEwRx9GeoQp1sscnA4q2I3uSeDwEEVhnBJtGLqWaI7wRXX?=
 =?us-ascii?Q?Z2H58PDzdk56QMraA++ne1pqcD6nlAhZUshx39x/7bNng1gq3xVJXSuRr0aI?=
 =?us-ascii?Q?VO55SlbLOPITkUGqs2azyif5r8ZWheLYZE8R0u3RZBaYKFV0p0hgycSeAqe+?=
 =?us-ascii?Q?FGhncak9T1CeJ0BHiicK5I1q9QbYXNUkfv6hFF7wEq+bAalXkACIYw9eV4U+?=
 =?us-ascii?Q?oIy/r5gSuWD8pbrBbOhneqa9sRHfOkDGSxFDzHOQd7dYVSeTPwbXB+WHWJzc?=
 =?us-ascii?Q?1/nK9HDg9U9t/peYTQZfPXD8kdqVG4GmxMKbcBLCKcHjzyr8BVKOy8LKl53U?=
 =?us-ascii?Q?Zrn5/nJvwQfGhF6muNsYBoBXNq0HOG2rzMNYvaVsXbZpFd8x4PZ2TM4TBsOg?=
 =?us-ascii?Q?eZUxATw41n7K3GrDrJwCEh3TDb3CtYmuBrdxXvHZaaOWoF2ymwBbxeFObdff?=
 =?us-ascii?Q?8Lt3PSu0YzTEQ1xD6X5foqcZYlxVSqF9I8L+He1gXko6420D6V+DpTlV1q6f?=
 =?us-ascii?Q?Tda1X65WkUQVkpCMcKbZmXB+8Sqnj9NBsST25B+RbphijnfORk0dEnQO8W8Z?=
 =?us-ascii?Q?UXJ+8XKOHoK4FcZ0OL4AUhi25eF8wuPdfY7feQwGy5m52zjS1HX90uZeGFRq?=
 =?us-ascii?Q?q7t6nClzqZp54gHLE266KSmyKTHCsZqVD38DJUuh0cpH2MMpDZlphvIp1SpQ?=
 =?us-ascii?Q?lN5Ns5wNVksZnqACLScgA2YfLfx7pARvUM+Lt0qMdWtH1uaK0Od5Ow=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0OMynibJEmpKHcCLxqLvdpiENDjKFEKk7x7HCjP+iJJoEeVx/1gAmTxb91Y9?=
 =?us-ascii?Q?qbRVWrUpyC1pwQkBWf9bU8dyK1aEd6VPsaiHKjF8gXQZnYBmfKsw9zkt9QDh?=
 =?us-ascii?Q?w7Y2a9CkXgH+yb2n0xrEYCTsZNYxlFxhJSAc/rIdzFvcAwyIHrP9LDQ6aeGD?=
 =?us-ascii?Q?Bi8bMdYJRULnilmQRzgNtfcjyVX7phld3W5gFjYGmmVBYIlk02iq/ESpaxCt?=
 =?us-ascii?Q?+nb/YibYDAjZh+TPvoa9RtjHDxNRQn8K7ThnCxta9ND/l2HFh1W8Nfpuy9lL?=
 =?us-ascii?Q?DmNUW6j/MJp73n1v3bycjO9R0pRzV27MT0jMLhKiVKkT181mKrPXFu9aVAE0?=
 =?us-ascii?Q?npN9leoCcVIo/c7VLy/USgrswyQSSZqNpfFfRxz1hQ1IGQ5DWPmyvYSO7RkB?=
 =?us-ascii?Q?NFSv2JTDX9mKxvanvKVDYKXK9h8SGjxA+tBEbW7BbMA8sEB4DKlyWH+jvhLL?=
 =?us-ascii?Q?d4m5V7BUx+a2A31RYl8dZqn1YbWDGjWoVOW33WUFe4fb28oqMM5Ch/H7TY61?=
 =?us-ascii?Q?PJbnkuKuO2AzjKDeLTr1NA930o6HAj8r4Pdf1vKtu3EgDyFAt49GWw3x4Hiu?=
 =?us-ascii?Q?5tgePXddSWfEE5LV+yWHlpD3YKRvWfuewCFBYLiVUrFO8muPBeFDnj9Y3M/d?=
 =?us-ascii?Q?ranR1cXE0QZTzsS2Eop6RGElK5wFAoj32cxoXruOKulwgg8bhYdczJRnCqmN?=
 =?us-ascii?Q?wFz8VXEeImWhsVrpHcPippPOjFg5hJbboZlEriIPC/QLw4ceoFGGmZTIo7/+?=
 =?us-ascii?Q?RTpyUjB9gjKpVDZG3rG9Djl9gkNvqU7iD/kSqPhg+66UUvaIqIY3X9wS+efH?=
 =?us-ascii?Q?JLmyYhhZeRrmL40WtJlWMNZK8FDmRBrCYH/JepIon++CZcIE7rCx3Th/43WI?=
 =?us-ascii?Q?c6sgzRUvWZg18D2Kwk3OQn3M/hserussQhqCTFjOuXTC+c+IQUjyVWWjiPA7?=
 =?us-ascii?Q?f+FqeoOGmcG2Z+x538Jsu8UxL97vZNqSuT+b+RbrKmUumiXG47zfoevMft+r?=
 =?us-ascii?Q?pCgSUUNLkGnsy9W/fCCk3SGoU2H83bo7LWgkaZYmLpW44AlFeIm91CmTGRgK?=
 =?us-ascii?Q?aMIdnf5q1268D956c2FNj2us1boy+8Sx7wDnpGm/C8ZPuzclRNzYQ0mpLUTk?=
 =?us-ascii?Q?Cd4YvC0uS/Bvfb58MFoblCS7NyJ5NxM0euvDhITY+aJNg056WMM9ZSRDJZGp?=
 =?us-ascii?Q?61a1bbFh2QqaGY9hkiYYLMqWFvOq3zm7uIqzxF/HWFigii/eSq5dD6zuub0h?=
 =?us-ascii?Q?ZkBsCld8O7lurUQN3aiJCITuOKmM///XBdp0LX8p2zGD1GS4Qn8lXP9Klj72?=
 =?us-ascii?Q?MJvOl8ZNAdHsP/4CTMouhW3ItN2E63iYJDHpAi9+FLpXfYOZFgaepqoXxfXZ?=
 =?us-ascii?Q?GcPctoJLSM6DyPZJYhHFiVeGhNEXWb26lqnUzIxCe1iXe8er7mFerJH0FQzp?=
 =?us-ascii?Q?16+yF8gUVIrnDzGXJpbI2UnTzcbh0dZfmLnSlGTtiUEgDFi1/kMk4/K/orzL?=
 =?us-ascii?Q?RPKwut1QBbOLTg4ZXNnt/G58Zkik+lLTF/vFqm2+ijZHhYQV9cqmeXg6ujYv?=
 =?us-ascii?Q?50IHufu3UCeB5kH7UpGqpmUzvyMQDC2DnYAIMgSb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d0d677-ae32-4f16-75bf-08dddf2a44f5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 14:11:19.7359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l6uDRUVXFiNX7XxLYVSQTsF8BtN/TIXUlTQIJozA0LQd/UoIJlj3MoakhOtppc57Ri9c+1p2D/BDLmu0Y7/7XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11536

On Tue, Aug 19, 2025 at 09:21:08AM +0100, James Clark wrote:
>
>
> On 18/08/2025 4:19 pm, Frank Li wrote:
> > On Mon, Aug 18, 2025 at 02:05:16PM +0100, James Clark wrote:
> > >
> > >
> > > On 14/08/2025 5:49 pm, Frank Li wrote:
> > > > On Thu, Aug 14, 2025 at 05:06:42PM +0100, James Clark wrote:
> > > > > From: Larisa Grigore <larisa.grigore@nxp.com>
> > > > >
> > > > > The driver currently supports multiple chip-selects, but only sets the
> > > > > polarity for the first one (CS 0). Fix it by setting the PCSPOL bit for
> > > > > the desired chip-select.
> > > > >
> > > > > Fixes: 5314987de5e5 ("spi: imx: add lpspi bus driver")
> > > > > Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> > > > > Signed-off-by: James Clark <james.clark@linaro.org>
> > > > > ---
> > > > >    drivers/spi/spi-fsl-lpspi.c | 6 ++++--
> > > > >    1 file changed, 4 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> > > > > index d44a23f7d6c1..c65eb6d31ee7 100644
> > > > > --- a/drivers/spi/spi-fsl-lpspi.c
> > > > > +++ b/drivers/spi/spi-fsl-lpspi.c
> > > > > @@ -70,7 +70,7 @@
> > > > >    #define DER_TDDE	BIT(0)
> > > > >    #define CFGR1_PCSCFG	BIT(27)
> > > > >    #define CFGR1_PINCFG	(BIT(24)|BIT(25))
> > > > > -#define CFGR1_PCSPOL	BIT(8)
> > > > > +#define CFGR1_PCSPOL_MASK	GENMASK(11, 8)
> > > > >    #define CFGR1_NOSTALL	BIT(3)
> > > > >    #define CFGR1_HOST	BIT(0)
> > > > >    #define FSR_TXCOUNT	(0xFF)
> > > > > @@ -425,7 +425,9 @@ static int fsl_lpspi_config(struct fsl_lpspi_data *fsl_lpspi)
> > > > >    	else
> > > > >    		temp = CFGR1_PINCFG;
> > > > >    	if (fsl_lpspi->config.mode & SPI_CS_HIGH)
> > > > > -		temp |= CFGR1_PCSPOL;
> > > > > +		temp |= FIELD_PREP(CFGR1_PCSPOL_MASK,
> > > > > +				   BIT(fsl_lpspi->config.chip_select));
> > > > > +
> > > >
> > > > Feel like FILED_PREP(..., BIT()) is stranged.
> > > >
> > > > I suggest #define CFGR1_PCSPOL(x) BIT((x) + 8)
> > > >
> > > > Frank
> > >
> > > It's using an existing macro that everyone knows though and I found 65
> > > instances of exactly this. It can be read as "set bit X and put it into the
> > > PCSPOL field without any further investigation.
> >
> > Where have such pattern in kernel?
> >
> > Frank
> >
>
> Grep "FIELD_PREP\(.*,\n?.*BIT\("
>
> 65 results, e.g:
>
>   return FIELD_PREP(RTL8366RB_LED_0_X_CTRL_MASK, BIT(port));

Thanks.

Frank
>
> James
>
> >
> > > If we make a new macro, first the reader will have to jump to it, then it
> > > still doesn't immediately explain what the "+ 8" part is. Using FIELD_PREP()
> > > also has the potential to use autogenerated field masks from a machine
> > > readable version of the reference manual. You can't statically check your
> > > macro to see if + 8 is correct or not, and it also doesn't catch overflow
> > > errors like FIELD_PREP() does.
> > >
> > > There might be an argument to add a new global macro like FIELD_BIT(mask,
> > > bit). But it's not very flexible (can't set multiple bits) and you can
> > > already accomplish the same thing by adding BIT() to the existing one.
> > >
> > > Thanks
> > > James
> > >
> > > >
> > > > >    	writel(temp, fsl_lpspi->base + IMX7ULP_CFGR1);
> > > > >
> > > > >    	temp = readl(fsl_lpspi->base + IMX7ULP_CR);
> > > > >
> > > > > --
> > > > > 2.34.1
> > > > >
> > >
>

