Return-Path: <linux-spi+bounces-6777-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AC6A328E0
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 15:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D3816A767
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 14:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA532210F6B;
	Wed, 12 Feb 2025 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bdc5ps9a"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A1E20FA91;
	Wed, 12 Feb 2025 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739371203; cv=fail; b=Y40lafsUm2Y0jjo9ceoWhShqaqJRaOlZnekVRpflporPIkCOTuHnxkGPxFzW4qHIHXis3oCEeHTVfv+YWEWPqbaoqa+S+/s/b15FDr8L3YKOBOxqzlFjKtDEYGaPfPbCJYqL0nsTdMe1bL/dYERRf54xSg8hbNjlRaUTndBKC+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739371203; c=relaxed/simple;
	bh=VGzpnlzm+R5s8XSHLiw6Xop/oRyDIiseHn6fZlsmkLU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VN7fleJ2xHecCy96XN+tYy1ra0V2wDwv9YMpUnU6xpRJM2d9ODx+Gzy6PHW5Ra3UwQU7JCm/jLD/6nr5FZr7Nz1zBkrIaleX6TmaRGYftf2klUgbPGSAk+hatyT/Sa8DNIhd/nLVBh2mv767m9TLCFQso8FHbclAu/x29On9TSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bdc5ps9a; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmBeQCSK4ZvP4knfCc5gTf+S7FNEl5XgLJzKiZXS1ZUp2rwbWuWHuoOmIm77ds7pmrXAeXqBgDUvblTitxPdmKdXqV5AKRbeJt6OQEJZ6K+q5hPxff4JoSiOfvUaplWTj+xXnGTsfzp+D7B/Lkyjbm7bbpfRSMBgjx3zAwNKR52aAktby1aVe+ogeHbvmtfdt/ZfRghVNXJIsJuSO7eEpWfHutqxqo2eNMnGxgopSWkdpOYwNgyv0mjdEkCd+K7C565MbkAWoYOP1Aamo71a+Tk0oZtg/6CLlveDc/aLgfeIj+YfJ+zB/2frO+u06CgbRlafVzhCrXM7llpYImDlBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzydTC6DeyN90U7HCXHla70g316fxnM/2TkQ9eCP8/g=;
 b=YI9pjWLTiwyKnHy3e7tMs2daxuyCZTqGVIKXu7rbnUQerueg8HQF+vdu84PljZ5aInmNrDIja5eS/8O4maAy+QX3JyDYK4+92J2Tkq3wHDkOxPQ3gsipnwYAJgZN7DRtfTUs7P0XF0DN4CHekIzvI0qcZD9c8kshFh57UTu6sjKYU/DGB1BC53dtjtYTmqwKLoKDmX35gC7KGk/dGowaUNo9zjDuqyG6GIXj4NnlriDNyZyyt8WxxWvS362en5QXLHy7TYfk9FUv9pxwM3G3xqNLAcNWCQDg5djsY00YANaGcv2P8WcS+9acQU2NBefOgMsvmwXsFD8LPyKtrl0H7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzydTC6DeyN90U7HCXHla70g316fxnM/2TkQ9eCP8/g=;
 b=bdc5ps9aoSdk5M6wVIqdih6F6aStwRIK5vA4CwD8Yg6S3+1AyjXaHFP3x8c8MKn5n6fjoK5XGLO6ev479z0N/ME3tF6amBSUf8ac1u73l5lERVi2rqwth4a4E0g5r9BWYj2/R5kER5RUieYwi5JsoJLDMe2Wvbc0EK4lF3FKr6ex/uhrn3Gu4sRdOec7ohePR+SkVuJlNbIue9vX1eLXl/0OULn9JJ+8OCAOWc+3MRUTIvFQrLiZsocyUw3hPmeuxZO63VYc9D62dVEIny3FYUgdzpeLMo8o+bTpWx6dYEFJJmcNkicj7zKQzRoJPL4QhkNw0MAu1UMlA/eoUsEwVw==
Received: from SN7PR12MB6768.namprd12.prod.outlook.com (2603:10b6:806:268::8)
 by LV2PR12MB5919.namprd12.prod.outlook.com (2603:10b6:408:173::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 14:39:58 +0000
Received: from SN7PR12MB6768.namprd12.prod.outlook.com
 ([fe80::bcba:e0a2:b1f7:eb30]) by SN7PR12MB6768.namprd12.prod.outlook.com
 ([fe80::bcba:e0a2:b1f7:eb30%4]) with mapi id 15.20.8445.008; Wed, 12 Feb 2025
 14:39:58 +0000
From: Vishwaroop A <va@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>
CC: Jon Hunter <jonathanh@nvidia.com>, Sowjanya Komatineni
	<skomatineni@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Krishna Yarlagadda <kyarlagadda@nvidia.com>,
	Suresh Mangipudi <smangipudi@nvidia.com>
Subject: Re: [PATCH V1 1/6] arm64: tegra: Configure QSPI clocks and add DMA
Thread-Topic: [PATCH V1 1/6] arm64: tegra: Configure QSPI clocks and add DMA
Thread-Index: AQHbXaVgT/gnWZOYtEy/xyoiiVmKTrMOSpQAgDWxe8U=
Date: Wed, 12 Feb 2025 14:39:58 +0000
Message-ID:
 <SN7PR12MB67687FB2A524ED45AEEF6C17BFFC2@SN7PR12MB6768.namprd12.prod.outlook.com>
References: <20250103060407.1064107-1-va@nvidia.com>
 <20250103060407.1064107-2-va@nvidia.com>
 <s355cib7g6e3gmsy2663pnzx46swhfudpofv2s5tcaytjq4yuj@xqtvoa5p477n>
In-Reply-To: <s355cib7g6e3gmsy2663pnzx46swhfudpofv2s5tcaytjq4yuj@xqtvoa5p477n>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB6768:EE_|LV2PR12MB5919:EE_
x-ms-office365-filtering-correlation-id: e1339984-fed7-453e-ca52-08dd4b731fb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?eD4xPScfcIPmzH5JK/I+atC4C4SQ7gOGj/39rO0cReG6+IFbz5kDMPSKK5?=
 =?iso-8859-1?Q?QyFWs3x+xlbEcbH8W2OjddPMta6nx7Z3GCBzzdI66ETYIXCaYMOA5OHE13?=
 =?iso-8859-1?Q?EUVlHAGwoit/9EKHiuzsnxknI5Qn/VX7RQgW1qmO4ZvwcZgOGeJ+qxsrrb?=
 =?iso-8859-1?Q?KDwW3BSx4yq+u5bxo6HdZFN4vKUSjmtrZcP2ie0G6RZkvGMtZmBoahPdGa?=
 =?iso-8859-1?Q?qzzQqXTavzfAfKBfIThck2uH5V9hDrn8h8EtVVzYof9ReRvjUfvc+IX8gc?=
 =?iso-8859-1?Q?HnRK3Sc72xTW48F44GNdJyb4s775OMLIwECv+n+zyfYzjuG6xPvH7TukzG?=
 =?iso-8859-1?Q?DfJ3r5rZwPxaBGGDCUGIkIZo1pRvtiNcVF5Z+mMFAS+ll3/DL2S5OUJynE?=
 =?iso-8859-1?Q?fuiGywsnwFk3+z0NKHLjNCYemn0Lz76cnr8HFQx7tVrY/m9dkayTzlJATn?=
 =?iso-8859-1?Q?N3WyBcrzZTfzC3OGSsOIS9umZvugHWBHU2MQCjfCTtG/vYhFsq1TQCbCUh?=
 =?iso-8859-1?Q?FM/uwDBDGICSKbBUcrlEsYLw8UZpy/0EjWWSwQ7IqN3nY7Xx8/r5MlDGG+?=
 =?iso-8859-1?Q?A+xtGo3lt1QrydZSd0Jn6dmeue4UZ798OOoHVIS4o/rVN8m/F3J0lk8Yqd?=
 =?iso-8859-1?Q?tsIZrvvhIEO3FuaRW9YZ8jj34kYpHad2Sfslj3OvOZ7U2DeNhcuT245ZIr?=
 =?iso-8859-1?Q?ZlJvupETaMue97g6ttB7AZqFJbHslawjsopbK298OZbFf1ENia2kiTwYOz?=
 =?iso-8859-1?Q?ivYrQ+3BLSugdZu6psBl/IIRSkICG6aWdolb56J9bPHY2uEvUvPmpxGc3e?=
 =?iso-8859-1?Q?LjGGMuxlkrm7NAW6eiKJJ/hgr54aiBthZHBCkd5hGfOPUoXXAcstGpih2E?=
 =?iso-8859-1?Q?wPKqsMtM5/Kp1KMOTxcaqKGwCzcJbxUMfL7kepXKdHFCLCk1xiYj+5fwHY?=
 =?iso-8859-1?Q?PzQVkNWIc8AWJJFicvHxaOnjqHEJuPVCnTRLWKeWAel2t/uUUgKgQFNxRI?=
 =?iso-8859-1?Q?2EweDRQxXBWTFloEl0GX+qssKXyQUWKZiZ85ezSfqkP9i2paEOU3B2IInk?=
 =?iso-8859-1?Q?6fNttLuIZzEq/RCaQkon/NwR6/ymtQszUky76Fd6vj/s0/q3DQQn74+5TF?=
 =?iso-8859-1?Q?s281RFg/ttdC2VpLTzaHnshCQZ9owtG/X8a9h1tVEGsiLUX/5Hsxg8hG4k?=
 =?iso-8859-1?Q?JirVS17U2YY5QbtYIwGR7lb2560L79FZJ3ABx7Ki+4ntkdIhZ7dxLaDCVS?=
 =?iso-8859-1?Q?XtUpfr2F/ha/5TWd5xpyJHgQQ5dr1M7AI4r9o5IITPbXzrBlUkk98qE1b6?=
 =?iso-8859-1?Q?Ka57vyPQW4R6XJQcZ1uWBzYKF2Gap+S1WFPCs1yoxM8xFbe34gR0+lnFJS?=
 =?iso-8859-1?Q?jNI+6Ep4dVLPOQnsbPFK3o9M28OKqGKmm2WkkoJIs9JZJHeUypVeTpyDLv?=
 =?iso-8859-1?Q?GlaPHXVUaKMpaobF764w0w+Haiv/Cl+kLl1fZ8rE1Mt4k2BO6YXT+iZpHR?=
 =?iso-8859-1?Q?fhqpCG4O9Dy45S7xNn+shG?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6768.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?9zaR+Idb9bq8Zpq1UFhghUfM+AWJzpFAmg/pQFVRNMxEQEhyeM5iywxSS1?=
 =?iso-8859-1?Q?tGf2nrzyb3OMEuG/PpBlqQKUpFriYj6UUVQXrXDr5RMO5FhlBqxslNOIrp?=
 =?iso-8859-1?Q?vEUO8zDKlKqrqJgoYQvRlo2DmRJ2FjsQ+oek+Fw02nntTJBzw7UlRU02dp?=
 =?iso-8859-1?Q?i5zp3LazZtkTzTQT1KxW5cJTjuBD6fk4JmrmsPLu3gh93a4BHZhwsYY0Lg?=
 =?iso-8859-1?Q?SIN3wb3StK2YO4ln0Z8H0/SXqsf4k3ZrGtyEA0hw+g2sDtvm3LgvNzflpS?=
 =?iso-8859-1?Q?wTnSR9LRIu2M6LF8toNZdnEj3by32/BS+ZyEvLms5fZdl7PrXw3KxBLdf/?=
 =?iso-8859-1?Q?wsBvAo85idhCQT+GXg3Xuu0mqOJd3sE2wvHhv69YbOYzngiBqvBhT7gfXN?=
 =?iso-8859-1?Q?JUFh3/PprlVZWwSTX/i44lM1BC7o0L8R+37o1co3vkfFJMlquL64xE+HME?=
 =?iso-8859-1?Q?EWFHBSoZfEoRT16hxYl1JyPqSKgII76HebKml0mulCx/kPZRJ98CMeR6oU?=
 =?iso-8859-1?Q?79IX8Ejw1BSbnCcNSxkiohk0dANjHKsJJw80u93pSmCHZdC7EC79bSD7U8?=
 =?iso-8859-1?Q?QHYhRQpnMxCiFwXUNpYV5KYTusHMJzj9pp7BaaKrmKDpJSdaGn8pNmNH28?=
 =?iso-8859-1?Q?OmT7Z7nb7PthoNlvj0oCRBO5sgJ/mw6VRDzLLhksEQU6fok+VEvS3Fev0C?=
 =?iso-8859-1?Q?fRVec73DOSjB4HGjz7T1Lam7syyOI1WTtidCIkUB5kL0gU7RgsWCKXbdFm?=
 =?iso-8859-1?Q?SUjncBZurLDrYfwqpO4FgGOs60OI+o1NEbZi22iWWJRVRz7gqWnmm7iF9A?=
 =?iso-8859-1?Q?g4WN6IMxBe8OkdlyerKjq40WR1VALWcgbZdVfoTAObVopfCnScoEo59H6V?=
 =?iso-8859-1?Q?HDY/umhRJmY9f6PE0o66+XD1PlCIFnAwp0ZBcO5GnnJtxrhmukQwkzgIhG?=
 =?iso-8859-1?Q?tAyGo+LlwBppKWx99m/tIGjjzyJhbVKDtvsH9sOMzylk8O9MIM0hUjL3mH?=
 =?iso-8859-1?Q?aXYS0rtMoZ5ed2kwTZRWPm1faVsd/8fjpDbuOQH7VYTABTIw6oMnpEFSA1?=
 =?iso-8859-1?Q?6fASPogXSTZGcZKNTFSB2RhTPtD0a2nkE2qtjRnHo4YjonoaV6P8HRnOUU?=
 =?iso-8859-1?Q?X1jOb1sL0x9CQEpuidu+qQmYQzMqm4EovSFT5NIG3J6kJrwfSvtLcOPlqq?=
 =?iso-8859-1?Q?vq2ONvJOcjDDK8HODUukOTdmjdFYLb/BudrYql3pPWtwGRTxHXslTjYU5I?=
 =?iso-8859-1?Q?PBlUmYXV4FMTxOkbBBGRT30dUQiIzeyhSQzXDsRVEnVSHRn9JpBUlzMaWf?=
 =?iso-8859-1?Q?jvJb4IYiodrkwFvpoDhsH07w+njc6KMzDPy3usYbkJDHvSCT9IkGtss1na?=
 =?iso-8859-1?Q?HeEZVs5vKn88Xl0H8ZvE+1wpBbTvzORjp8VeTumMb5ZVfSwJLce8cH6eKX?=
 =?iso-8859-1?Q?v9DXrwmcOhiCAqvuftHBZr37MipiRME14DABe4LV3hcUXdxTAE2iwbv7xS?=
 =?iso-8859-1?Q?bsJrD3l7xPc4H4VEVlZCqRXFV16QbcA9T00S5uV6vDeboXt9aTpqgC1C7B?=
 =?iso-8859-1?Q?QeHHMhOz4XSpRL4hMFoR9EAXc0ixsjCY4eNwXRYUyYMrwsjxMUq9i0Clgo?=
 =?iso-8859-1?Q?jZTRPfuBOK0xo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6768.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1339984-fed7-453e-ca52-08dd4b731fb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 14:39:58.1556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XcEUZiBc1MG16kn+XWdOLhwHDA8F924w9/STdoBcnaXpNlf/hR1aIz+Ottd/DNcZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5919

=0A=
=0A=
________________________________________=0A=
From: Thierry Reding=0A=
Sent: Thursday, January 09, 2025 16:10=0A=
To: Vishwaroop A=0A=
Cc: Jon Hunter; Sowjanya Komatineni; Laxman Dewangan; broonie@kernel.org; l=
inux-spi@vger.kernel.org; linux-tegra@vger.kernel.org; linux-kernel@vger.ke=
rnel.org; Krishna Yarlagadda; Suresh Mangipudi=0A=
Subject: Re: [PATCH V1 1/6] arm64: tegra: Configure QSPI clocks and add DMA=
=0A=
=0A=
On Fri, Jan 03, 2025 at 06:04:02AM +0000, Vishwaroop A wrote:=0A=
> Set QSPI0_2X_PM to 199.99 MHz and QSPI0_PM to 99.99 MHz using=0A=
> PLLC as the parent clock. These frequencies allow Quad IO DT=0A=
> reads up to 99.99 MHz, which is the fastest that can be=0A=
> achieved considering various PLL and clock divider constraints.=0A=
>=0A=
> Populate the DMA and IOMMU properties for the Tegra234 QSPI devices to=0A=
> enable DMA support.=0A=
>=0A=
> Change-Id: I1dded904aa8e0f278c89998481e829f1ce474e8c=0A=
> Signed-off-by: Vishwaroop A <va@nvidia.com>=0A=
> ---=0A=
>  arch/arm64/boot/dts/nvidia/tegra234.dtsi | 14 ++++++++++++++=0A=
>  1 file changed, 14 insertions(+)=0A=
>=0A=
> diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/d=
ts/nvidia/tegra234.dtsi=0A=
> index 984c85eab41a..96d0f13390ae 100644=0A=
> --- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi=0A=
> +++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi=0A=
> @@ -2948,6 +2948,13 @@=0A=
>                                <&bpmp TEGRA234_CLK_QSPI0_PM>;=0A=
>                       clock-names =3D "qspi", "qspi_out";=0A=
>                       resets =3D <&bpmp TEGRA234_RESET_QSPI0>;=0A=
> +                     assigned-clocks =3D <&bpmp TEGRA234_CLK_QSPI0_2X_PM=
>,=0A=
> +                                       <&bpmp TEGRA234_CLK_QSPI0_PM>;=0A=
> +                     assigned-clock-rates =3D <199999999 99999999>;=0A=
> +                     assigned-clock-parents =3D <&bpmp TEGRA234_CLK_PLLC=
>;=0A=
> +                     dma-names =3D "rx", "tx";=0A=
> +                     dma-coherent;=0A=
> +                     iommus =3D <&smmu_niso1 TEGRA234_SID_QSPI0>;=0A=
>                       status =3D "disabled";=0A=
>               };=0A=
>=0A=
> @@ -3031,6 +3038,13 @@=0A=
>                                <&bpmp TEGRA234_CLK_QSPI1_PM>;=0A=
>                       clock-names =3D "qspi", "qspi_out";=0A=
>                       resets =3D <&bpmp TEGRA234_RESET_QSPI1>;=0A=
> +                     assigned-clocks =3D <&bpmp TEGRA234_CLK_QSPI1_2X_PM=
>,=0A=
> +                                       <&bpmp TEGRA234_CLK_QSPI1_PM>;=0A=
> +                     assigned-clock-rates =3D <199999999 99999999>;=0A=
> +                     assigned-clock-parents =3D <&bpmp TEGRA234_CLK_PLLC=
>;=0A=
> +                     dma-names =3D "rx", "tx";=0A=
> +                     dma-coherent;=0A=
> +                     iommus =3D <&smmu_niso1 TEGRA234_SID_QSPI1>;=0A=
>                       status =3D "disabled";=0A=
>               };=0A=
>=0A=
=0A=
>> It looks like these are missing the "dmas" properties that go along with=
 "dma-names".=0A=
[Vishwaroop A] dmas property is not required as QSPI uses native dma engine=
. dmas property is used for assigning  the dma channels. In case of QSPI it=
 has own native DMA engine.  =0A=
=0A=
Thanks,=0A=
Vishwaroop=0A=
=0A=
Thierry=0A=

