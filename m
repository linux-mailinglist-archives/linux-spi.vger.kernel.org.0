Return-Path: <linux-spi+bounces-9514-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D97B2ACC9
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 17:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F4A188AAAB
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 15:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BB32586C2;
	Mon, 18 Aug 2025 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O4KoBmH7"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013059.outbound.protection.outlook.com [52.101.72.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA67B24A05B;
	Mon, 18 Aug 2025 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530970; cv=fail; b=UoroRkgufax1XtD89Fktvsudt/X/HWSI8rW8afrTtRCWGHwl0ZZxRK/VMBtM4mZqJtA8VMlaLi3JVfRF51X1jE3cqECFI0q5FbT5MYquXXNYYN+fP2AWX0QWdxoAl3X+REoy+8/v0BNAG2+45Ob3375c7hFiU1mkqjtiPhVnhcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530970; c=relaxed/simple;
	bh=8jA2ABh9LIivHtWheE/6QCU2wkFjgcygRSBs37nbhX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T9tlekwr2nxBKVjrfCHSwyaneIMKUieX2BhKNUWdvvBDzh6XCBtu/l1c/tX6XBPOhFM349LQi3+62kyHkDiLq/rpQ9oqxx468joBK5SVUmQB6DOrWKlVYNyTc59f7EaTBnQJoEXRfXHlLVVkb97WHtYnkXBb3XBNghNCVuHtFWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O4KoBmH7; arc=fail smtp.client-ip=52.101.72.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2s9kyncW0HoGvXgZRuqw/QzRnqOngbOAsD7HS2p88mR0qhKKShxbsqnWSJ+bFpT6m+a2HD3wHLmweM15JO/VJ4NhSqMs4u9HiarpXB2o7JEn80NHynaOoJcvui1klXDL+t/j9CNGbcwIkfYjgOYShm0JjX5WS3ZvglMcGe4hwcc1+Dhm4mQM5/2IcIMOmIvZLDoEkKqHF2bwvtwucZykg6oyARSFDFv4axjFvYVShmP/Pb4y+WDnwU6SpKsl24hV68JS0jhQ44UkR/D7oKxv0ahPiJ8ldlvob3luueafCV3/5z2zVwZVDdvp8NtO0/HcJKLsoHWGnQdtHVjYycYMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28EG0ZNWgYvZMzrz507KKsKG8jJ/BFHUM7FlZ4y9yUM=;
 b=VXxgpmIDEebsIOqQsVBgOFtSTp7/hwO6/WLQsDrPqChozGSEnszGudG2TKRyHFaJwU8do3ogjUJG+ycJnP+geMS4KjCLQjE5dkdXhdNxfejc5BFpbJV3kEhVNQLb7fQPOUednPV/NrfsfXWZQry4jzDskYOeO0fOudfoRCmvYbgQKbFQ6hIsrFObwCF8D3l+dkqSTE1hwa6rstLoHB2Ni3QzXAXdlclOnGxJdPIZj03kCf/4FAxYFU6PIM9Eil9hXgKMCZsxHXy3zUcOGov50yGVkZ4D5eUY+nSaKD5zym7jC7dL/FHb4dr9UBup8bhdOnoDcmo+aDNZLqws8MZ4Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28EG0ZNWgYvZMzrz507KKsKG8jJ/BFHUM7FlZ4y9yUM=;
 b=O4KoBmH74ynvSaOHF62V+XTkrvysq41TJfRBi/ZYIdEHFSutocRtjCBoZxVD24BtfvsKlMua+KVqhAT9fhazqAYFQKI813/oScJJYaCNYXrvvMl+TqIGDU6CA/wyeF5NTB/PVY8MRX1RHr+Of9qcsHrzx+Ngsle6uGle14SMKJx/8RTjxDJh26swbcTdcVls4fd/von3hxr6ZEhxfhfg1A3BWfmQLV1AwYm/pW2NMi9AkihNC0BtwGlPLcsQJDE6Co2Eb95QOPwyeljHKCJ7AMAZZh9dBhb3xoAXel9cZTjWIas+C613jP2X9Xy+QL9iHSoHj7B7xlE/MlaAJiQkAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10796.eurprd04.prod.outlook.com (2603:10a6:102:48e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 15:29:10 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 15:29:10 +0000
Date: Mon, 18 Aug 2025 11:28:58 -0400
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
Subject: Re: [PATCH 10/13] spi: spi-fsl-lpspi: Add compatible for S32G
Message-ID: <aKNGuvC5iuoTvqZm@lizhi-Precision-Tower-5810>
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
 <20250814-james-nxp-lpspi-v1-10-9586d7815d14@linaro.org>
 <aJ4qNVIp788gc2ZU@lizhi-Precision-Tower-5810>
 <1f3b68d4-e0cc-4952-a695-322ed9756b95@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f3b68d4-e0cc-4952-a695-322ed9756b95@linaro.org>
X-ClientProxiedBy: PH7PR10CA0024.namprd10.prod.outlook.com
 (2603:10b6:510:23d::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10796:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f81c498-5659-4885-78b8-08ddde6bfa47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ql7SZSpdhpNis/ZExAo2TjWRX7jbkI7o/EOpLDEQp8/4zXeqwBSfbrZHVm2H?=
 =?us-ascii?Q?W5r9SVYwUnHBTphu1Z9ljOCRlSgceppzR+a+hSaCjvRO/nDe47+wIYNbDLNt?=
 =?us-ascii?Q?FI+QoXYiSrZ/Ey/4NDNKUXR2zrc71cv9Hwb0F0JucU4dpyotYdqWegIYLLTr?=
 =?us-ascii?Q?CMauEBEnbkOlbp2t8VHTO2KXsQCmEC9qaUZK1aK/HkenV8lj+H2oXTAXOsN1?=
 =?us-ascii?Q?f6U/4/laGv4YIzyZx/7oJoGzTeKGdOM0CGc2d1aTVbMdVSHd2Q7UiR3ah52O?=
 =?us-ascii?Q?9SzYJNI310WmGJX8b2+w26bLATstDeZ296rV6qlFPo1TvO0ZHVZnirhs7TW6?=
 =?us-ascii?Q?44V55lR+htl3onGYmxXRYkmk3KfIe+P+SP+sk1OJmpKWkTtZVEtW35DO4IVf?=
 =?us-ascii?Q?eUkDiTOQsGT6v5+3SP11ROgsUkX8SNWxYhPA2Or2IwIbdlfR/8Ws9UrXdUlz?=
 =?us-ascii?Q?QIpfCXqdLv6mw31Z/Zt77zJFQetlqEd2L8CAxU8weEJKiRd0ChvbukmY8Odm?=
 =?us-ascii?Q?YaJuQKa1cUOE94vOLzTIJWJDV4YgwqhiOcwNIN4YJeEr6JSdhk5SY4qv3W+i?=
 =?us-ascii?Q?y13rlGKKHL1FGtHLCKdFMy+ntvPdNCmKUGhY3n3kXym/SuGv2kDTqkDYlvfQ?=
 =?us-ascii?Q?VzfORIUpUX3oA7i1qKbgyjLT+2QOKBEUp5QAPFDrkQ7LqvhurjYDxzVWVnvI?=
 =?us-ascii?Q?lQYIXTBsbZpEPoTnwaSx4r7bXoZMQO+03e/eGPskE8CNHtIWHG7+e9cT6yff?=
 =?us-ascii?Q?SgzZJbataYE4OlXIQqa+aorQnXPSzneC4Z5TmnC8cI823kNoTla0icd2YlR2?=
 =?us-ascii?Q?KHeKZv5AHXnVF6OI04WtFGCi35xZlXwRSZuFVWP3rWR7Itm8JPUViymQP/Pw?=
 =?us-ascii?Q?L9++18dujhwO9Oci819fO0JmvOzd8hNu9BTRrAv9W67aQ3xoByAbe9dxMyYY?=
 =?us-ascii?Q?bCd4QvEfQSedz3e+pCxysgs+SIDXn+RxmJUionYkmq+QmnifMDrg169cSHH4?=
 =?us-ascii?Q?XDuNn7QeOT9asENhrSBLE62kR7cBqWKUCpNYCdkh6/FVXu42gCIwi3AJwHcz?=
 =?us-ascii?Q?I2HMqTgmXjIb3rSTzq4AOI2m1lVtzg9Xv6BstqZnWL5bQxe3xa2xfc49fxE3?=
 =?us-ascii?Q?wlcEmu9f94XptQrARI0L/Ip5/9IT/RaSbdTB3eMzwsZk/qTe5uaGaFg3rifV?=
 =?us-ascii?Q?0Pt3ThrqCJ/RtL2MAvMPUSFmkql7SmQqcPDDl1rYexQsRvtBR07o6TXhZ0xE?=
 =?us-ascii?Q?P1iiF0Sp4VEfJBtmSrgeLCo6br3Hc2LICrz7T1ebB5e5kJX/2ygHP5B+QXCk?=
 =?us-ascii?Q?w5YRoAB6SeQQUpguVuxCHtv/dy/XzE8NNtbU9s1MN+gti5QZ6YBL21XGQhUt?=
 =?us-ascii?Q?24nxY+qkTJsjgYHWf0MjqUoOe7/XPetKKEqhWf525wCEBFuVrYz2VR3RepP9?=
 =?us-ascii?Q?kzOtVjMDsOeVFzsYe3xe8HnpUZ/lAP9EB/Q+7FSjOUPu2x06adT+eA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?alom2DIn8Gvy+chPdPIHhdo9airifiUYWXF5cc9a5upUcma5CP1kU4HlIb8X?=
 =?us-ascii?Q?vvG+zntgsNYXd8WiehMw0Os3giy+mVURHK063zkewcjxLwiYRNd2xBNVyyd1?=
 =?us-ascii?Q?6JCGPf2RtcDWGhWoqG9AWc5XVHj0KgHuPAlkqpHn8FpPn5O+YtshuA/jJy96?=
 =?us-ascii?Q?3Ta33W1C6HD4fF+CdYOS6UXUE0qL4sWuuaho+5advbsC0ZITv3hnkvMoFIlS?=
 =?us-ascii?Q?3GiNieXhz6Ku3ZXNViaoHuTJq3bcMjYfrmr9iGwa7BcNIVq+1LNPzs4KEdPx?=
 =?us-ascii?Q?P59zCMLNWUybLNDA/nfykTbDo0btX3/KMbz888R2HBaSxbYwlq9l9z1RKPO7?=
 =?us-ascii?Q?Qt8leAjIIu5P92RU9BbcKSJY8sCHrKhly3W9x7QKd3MiMPHeMuyEwbXkZ/zy?=
 =?us-ascii?Q?yF0q7sQiWHAhgsxwX/Uhr6fc+apeXvbS4lPXxRjjybFj7tsbMZyqJrINRLfj?=
 =?us-ascii?Q?coTGloSd4ZysDAxKh0SVOfIGBeQO3dRAvl4R4ohKzRgHDdfeTRStD+MOstzP?=
 =?us-ascii?Q?S/qqeEJ/DlCNjk3eBx+bnwjs+QAPGoDjhc4B0ajwTNm2UnKM5WbPW+/HRugi?=
 =?us-ascii?Q?/gIDnaFP3QJpAdneolBVFhFYXCsnHN7buRdTzIyPE4unhJzC6E4W0jsXcTWx?=
 =?us-ascii?Q?gaenAb3+x9epxF9bExY9Y/Ao4eHwu7jrPxWxZY5B55KDSrAUDxoaGxwexVJP?=
 =?us-ascii?Q?lKCPpLEG4ZULlUrm+Frl4l2jH/MsjKlyrYGUOF0nHI4tP0zmRxwnDctllLdo?=
 =?us-ascii?Q?uN1ThykVi/3i8H2oZuCvn1k4dAQGIBjGtv5iW+we+L2hFypxQlt6IAeF2gg1?=
 =?us-ascii?Q?ZFsXlH1xaSpnElKc8Ub5B0MC6L3bkmsEgOEPSYlS4ziUt321yEIm5BVUu5cZ?=
 =?us-ascii?Q?Ih7WPTFUg1k01TKarBGLo2yAywd7rEC9YgWRGoeHS0s4EIk1u7xgOUjVTl4/?=
 =?us-ascii?Q?XuyCe0mgpvUxmTCgLFNfyyoKmUQBaVOqoiUPkxUH3WcucnMh5nFuMerKLLSR?=
 =?us-ascii?Q?LDKXeO0Cf8RC59EqX0pfWNZgIM7wRASSbZSQZCOnKo1vpelrWhtL0zGqnb2I?=
 =?us-ascii?Q?g6T+fJuE5DblhKk6Nfs5RU+STzKtMBWdUL9BP63px7rQ4Ej2w+YrTqVVmQYi?=
 =?us-ascii?Q?4A9/IuwHpNSEISPdUciHCggiNuNlLMX8Ga1+k0u0O3xrR/rye5lTztRFZHlj?=
 =?us-ascii?Q?zU45GtxzIDL7dsTFHc8FXSYWc+1Ad4qdjXbppVCeYmZETrnOEef3dAYM9wVB?=
 =?us-ascii?Q?W+i9Ey9oOSNiTrpqhmyItoA8j03Rd0/a0GzlSjMb7gyXraD1eDlO0f1Jye4F?=
 =?us-ascii?Q?H/WViPKwpDc/7y2HpB1wxAYaRrPli5KGXKEcI28uyZu/1NrZSlD0K1V8R03g?=
 =?us-ascii?Q?a81Og2BCywWXyjtRuOYqdBBO+rEQe8X55EAP6XKrCkWyCix2LglFRVLIiBhq?=
 =?us-ascii?Q?TqmXEVHm1QDHKRhfUcmCo7mKMsCZI3JRjYMweftS7YRYNrxa8vODnMcmDOkN?=
 =?us-ascii?Q?QJOHA7k6G3BiRf+UqKv89Lq6Z2s7qtlV0Nk5yDKmi5CMfkCgV2ysyIoX27SL?=
 =?us-ascii?Q?ycPdFaXr0MeIFiEo0jOKdvli6u2DUTEHYpO4haJp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f81c498-5659-4885-78b8-08ddde6bfa47
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 15:29:10.0721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vE1YE/nW6hG6VwG7HThBCImnDEeJSZYf8e4Vq7udUDVbc+xJxmV41g5f/pbKJOxltc1ke1Q42rxuApET5S0FKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10796

On Mon, Aug 18, 2025 at 03:31:08PM +0100, James Clark wrote:
>
>
> On 14/08/2025 7:25 pm, Frank Li wrote:
> > On Thu, Aug 14, 2025 at 05:06:50PM +0100, James Clark wrote:
> > > From: Larisa Grigore <larisa.grigore@nxp.com>
> > >
> > > S32G doesn't have the max prescale erratum and it can query the max
> > > number of CS from hardware, so add those settings.
> >
> > binding doc should first patch. Create new patch serial for add S32G
> > support only.
> >
> > Frank
>
> I'm not sure putting the binding doc commit first would be right? That would
> imply it was a valid binding before it really was because the code change
> hasn't been made yet. Practically both are required so it doesn't really
> matter which way around they are.

DT binding descrpit hardware not driver. Verify binding by dt_binding_check
not by drivers. When driver use a dt property, which have to descript it
first at binding doc. So binding doc patch should be before the driver use
property. That's dt team requirement. You can wait for dt team comment this,
But I am pertty sure it is ture.

>
> As for splitting the set into two, Mark mentioned that he was ok with a
> single one, so I assume that's fine? The devtype_data changes would conflict
> unless they were applied in the correct order anyway, implying the need for
> a single ordered patchset.

Yes, if there are dependence.

Frank
>
> James
>
> > >
> > > Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
> > > Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
> > > Signed-off-by: James Clark <james.clark@linaro.org>
> > > ---
> > >   drivers/spi/spi-fsl-lpspi.c | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
> > > index 6d0138b27785..a4727ca37d90 100644
> > > --- a/drivers/spi/spi-fsl-lpspi.c
> > > +++ b/drivers/spi/spi-fsl-lpspi.c
> > > @@ -159,9 +159,15 @@ static const struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
> > >   	.query_hw_for_num_cs = false,
> > >   };
> > >
> > > +static struct fsl_lpspi_devtype_data s32g_lpspi_devtype_data = {
> > > +	.prescale_err = false,
> > > +	.query_hw_for_num_cs = true,
> > > +};
> > > +
> > >   static const struct of_device_id fsl_lpspi_dt_ids[] = {
> > >   	{ .compatible = "fsl,imx7ulp-spi", .data = &imx7ulp_lpspi_devtype_data,},
> > >   	{ .compatible = "fsl,imx93-spi", .data = &imx93_lpspi_devtype_data,},
> > > +	{ .compatible = "nxp,s32g2-lpspi", .data = &s32g_lpspi_devtype_data,},
> > >   	{ /* sentinel */ }
> > >   };
> > >   MODULE_DEVICE_TABLE(of, fsl_lpspi_dt_ids);
> > >
> > > --
> > > 2.34.1
> > >
>

