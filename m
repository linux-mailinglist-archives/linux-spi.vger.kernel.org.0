Return-Path: <linux-spi+bounces-4958-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4090998580C
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 13:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2B29281123
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2024 11:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 490A8137775;
	Wed, 25 Sep 2024 11:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x/nJ9d18"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F32B14C59A;
	Wed, 25 Sep 2024 11:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264163; cv=fail; b=UTUYOo2g8qNPGjvVjxHqI+bJXY5jpqy4ZcaMnFaUy0GqwFaS3qdWgB6Dw+Uai597PkpZxT0ZtPO7h0CRPYcMRGG+lDp2+uUj6XqQhGijNKeChJUG/iMRp+LTuKTXEKFi8MiykKy/cB2vxou3HnZO5FgVnKkW6cRmSP507jOfaLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264163; c=relaxed/simple;
	bh=TYPHPX+l5XdZ6s3f/jqOj7f07Y4bKm3SJSnO+5+4+Bs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wwtrnh7jWfxbLaA+MgVse7ELtx5lbE/1s8RcLo5WgLew2NAeZDmBva8TdHqbzh37/J9QMW1s7oVVcKJKwqU10GWsYcPIlT5e+rccU6L+3s4pytCzDvkBLAQtUvbjVXX8JrraEPoVBGbylHSn6gfZnJkTpkTrpShQ6t4O4ejmfN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x/nJ9d18; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1CxLBF2U1h5SRb2XUArATiIN9gDrhRwdv3+JE7tckVf9e/vls783p8F4MTD8Y2e7Fv7dNzvTISGqv/yN6uYlqvog+hLkJgMwkiqPUIHs2Y5AnRBYf8rOIf1cRYA8PtwX6qt+HkT2N3WnsOEt4zImaBRl1TrieAXIzLreVA7Yr8OI8fE9/y9lY8z4CNRYPBJdMU1o0CrBglDeec/epX7O6WTIjplUH7l7kmo+QZs7d8puxc/O+Vc1G8p5oNzVvoxqDVDB+jPY2EU3+hx6DW1xQ+ZevGp8yvrh2Q6osTAG65LDIXEnFdygsTdG1hBUeEZ2Rr9ZHjbXtireJDNjftpPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLAo6bTGmQ147NfsfHDSvkQ0xGF4nX64fae/7/3QerA=;
 b=w1Q+IotbtSsNVBNQAJiaCoVq7SwpNtlzl8jVXJIMLUHqx0Jk4klG8sUJJbgkuT1fWwF2NC/Z/8ZxMPHSYrazDd0rm81l4NHvNyTdlu+nlu33DxB5xNTRY0A5jD0tzI/9+hUCc52zDC42oJZw66ZcoURaX4nysoz11puTUf1c/fNbszokDwVT4m2nyECM/cjskp6O7OploqrxxUcQcHJPeDZAkg97Vo2OYwW1y7zbaLCRu34pn5xdVryIdW4u0eV5xACzwK4dFWGNNbVwVuDk05OnFI34yghxh7ru1CpMwjwpew25VURLycNibRsOCgeyIbjLAZ152ypbR2p189VZZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLAo6bTGmQ147NfsfHDSvkQ0xGF4nX64fae/7/3QerA=;
 b=x/nJ9d18JgZgfkthBXo1eAfhc+xhy0v+Q7dbCKDvjB3b6MjWT894O35bHZT2wAlNsws2Y/guI/YaEBG72ChRNUB907mwp78NLWcsQakabrcS1KINte4SdO5IhvFVvBj1IGfTsYC3YqUNdhtfZ7wVUKNVhkv97aFbiRD/oME/rAc=
Received: from IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7)
 by SA1PR12MB8946.namprd12.prod.outlook.com (2603:10b6:806:375::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 11:35:56 +0000
Received: from IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa]) by IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa%5]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 11:35:56 +0000
From: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To: Conor Dooley <conor@kernel.org>
CC: "broonie@kernel.org" <broonie@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "Simek, Michal"
	<michal.simek@amd.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>,
	"amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>
Subject: RE: [PATCH] dt-bindings: spi: xilinx: Add clocks & clock-names
 properties
Thread-Topic: [PATCH] dt-bindings: spi: xilinx: Add clocks & clock-names
 properties
Thread-Index: AQHbDbS6IWXQrG+wX0CC5AjhvyS/qLJnJHoAgAE51XA=
Date: Wed, 25 Sep 2024 11:35:56 +0000
Message-ID:
 <IA0PR12MB76998D7BC3429606508E6202DC692@IA0PR12MB7699.namprd12.prod.outlook.com>
References: <20240923123242.2101562-1-amit.kumar-mahapatra@amd.com>
 <20240924-impaired-starving-eef91b339f67@spud>
In-Reply-To: <20240924-impaired-starving-eef91b339f67@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7699:EE_|SA1PR12MB8946:EE_
x-ms-office365-filtering-correlation-id: 65234d31-fb04-4d75-d028-08dcdd563897
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?k8pFt5NhRAFs63tmCyJW5zcFTY0yppANflK5BEdXb4cfd6r17bsxjT7iNX+6?=
 =?us-ascii?Q?1OiruMjxiQZ2cEoJFQUYs8UGSRhNTE190rW0/ovEbtlxR+TpGQIjjlsQXEzr?=
 =?us-ascii?Q?KNCjVHNjqB7TMDhClEWG1hnXQBFE9RZmrR8+xCl8ufSZZiCopx2ECQ4lQDYr?=
 =?us-ascii?Q?5CTfigLaYXLSxA65GNJJoB0ens9ncY4IY1coWxi1olV9v62qm/mvoJZz0juF?=
 =?us-ascii?Q?o1fypxPe2zngNBjyTdr5dYTa/b3jA5NL9xNo9VALPJYba0WnpwQHTy2WMGCj?=
 =?us-ascii?Q?gIcK8vm2O+E7a9/W6frw0vYtgX9tQsFXi5xkgNicZTFH+naEds5YoGzHTSt+?=
 =?us-ascii?Q?MW4Dn56ejgVW25yf1WtmTY/b9Jp5EObgHxwzYkoCeVOnFjtIYO9ZnOXFIZcK?=
 =?us-ascii?Q?tn1euM/nJNX9UQYD/itfxdM0ujgCWnNLw2ajPHxixYg2XNdAw8saqb3iYwKO?=
 =?us-ascii?Q?ujuXyu0AJflwa9troWJyR7Wd9GtJOdcjOjH8P9nxJUcxVYTRf07TaBxx50/5?=
 =?us-ascii?Q?aPZ2xdnRjCN1fS5dIX0JvqmeTn2g2cRi8fkjTc8h7rUlIQhxB+cTyt14WqT9?=
 =?us-ascii?Q?bzYHXLXv34dvKJAd7rD1jde1nx9eQ4omz/CVyFMhcsSljx2A6aNdEKU41/Bf?=
 =?us-ascii?Q?llmZPuodHm2YgZS2z4tx6VndvNnYNncoLGxcczpx2i5q6KuwFvcvB3B5RqW0?=
 =?us-ascii?Q?C0IeYLZCBQMAbhCs13QSLx3WmSLjdjXWHPGToitLIO3xvroDHVb7MQMecMaN?=
 =?us-ascii?Q?KIKSdohz2KffUP4CWBW8Ig70/ZzRSf8Yk93SlF67/sXf+xEjNbQJYlfVjBxL?=
 =?us-ascii?Q?qakZD8QGVifFnFKI4lB9H/HB9FM/21UO/xCWyHRkoX6Zp1DhWyJclY+jXxNW?=
 =?us-ascii?Q?OBse5EqA9mxxGCO2wk0WA9VhOIZ1wab89clD4PG0e2Imax7lqPr+7oXDnjkK?=
 =?us-ascii?Q?rYqCFj9gOCm4SM5eKbFUMcb0FpG0WgkDa+C925DpPPZVD7QmLCQds0czyoiB?=
 =?us-ascii?Q?DPcMu1vFXujJES0+OsD5T4ogtQBs7gkUZepRnX9uvZDv//YVnnLThn+sT1R8?=
 =?us-ascii?Q?YxRdQaf+28B5ApcP3HDl5JIztYQHmZ5VtMMjxZyxboLJmznzt2ib90LQe35W?=
 =?us-ascii?Q?ovIcP0X4Hk6zFaWa6wOESK0vWLMmoaYIpebKPZC5Q4CJdjEvA/6YiqwS50NV?=
 =?us-ascii?Q?Jmp1jtDFyWhl9mVqoWHlEem2QHi98gU3pZ83stFWYM2OpDvC4CxNGG4EtOkF?=
 =?us-ascii?Q?5aWTMO4e4Wmu6ExnWBR4NAeZcloRy3FvfzAyTOaBj3ZQB0acle4iBvAqeysG?=
 =?us-ascii?Q?RIqVseSsinnHR321FBUVe9X2xktMvak38Gs3j3xmYCFa6ySKfUUGKobHKDra?=
 =?us-ascii?Q?A5XYPmAdh8sv8Lbycedzx1eZxNmflAPV9EBwZxoSIT+wCfCr3g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7699.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?QDRiDAqNA9wQS96NjePcVmQ40VTbjnxuVa25Oa8Rcdarx3n4cvDyUwVqPyd7?=
 =?us-ascii?Q?KKn9GykyV6oGK3CIOMQzu8t+ndFKiaylgqjz2H7HYQJCoB76bvz4+JanqxZP?=
 =?us-ascii?Q?BJ/J7w6JLhhKkLMXeQDdqxQeaqlxOiqnuufdl6rS3RmTd8ZvAtCuMU/QhAwe?=
 =?us-ascii?Q?MEyq5Du2cce5a71jROm9F3sdtDjwVAbgo7ERgm+dMw4BLN240TuCcjEAcWoY?=
 =?us-ascii?Q?D/ziHMyHcbwdK37/QHPZBTbQ50+3K8QN466s7ssmwDi19gLBkC18/L/7C6rd?=
 =?us-ascii?Q?LtWoyGkkbodcioRuLgPSHO6DbnZ7x2cbWWOXtnbzUdP1XZsWAN/szWt2AaNP?=
 =?us-ascii?Q?i5PN1475A3uLjQ7kAEo4DUW2YH/XgThrQefeyZHUoqdtSQ0uugVSShrc2LgM?=
 =?us-ascii?Q?M/Pb9IMBVYKCmRSAqeg/wxzC3YQKsoZf4gYQRXEI9SEXHTwibkF1of5iGHGc?=
 =?us-ascii?Q?rXqcXK4trQsTGJFaiqgN+LOMNZZtJlIcWwJ1TlAoh5U21KuuX+PQMJ3vX4Rn?=
 =?us-ascii?Q?KuH9RooFL3zOGPpOT6j81fGijIkLj1R8MxSVgca5FVgWQOcv7fz6kxkgi8/G?=
 =?us-ascii?Q?hxiUVRx8Fy4ZPM5e5+z0vfi7LON1otX+3K3guAgEwlRoV4/u9MV7Lyy92BgF?=
 =?us-ascii?Q?K2vnuCftbSWKXsW1JIGNMbKMo6wcFv0d/H29k/9IzLpgw9u7qNXK8QvmOe8t?=
 =?us-ascii?Q?ZRaQ/9wsohMrvjeSwnrzPKPLHN6rPUyDl2R6GkHgtdno6MrNwX5TdBnskosy?=
 =?us-ascii?Q?GoIPEkFu9VmPJPArFnF4AK+2sEFa0sc7EKuUzpa37yj4KUiW0visGfjAUs1b?=
 =?us-ascii?Q?gRiphctwtR58LVjLHoxa20SPPy/BAxJdN6nmgS5WHoaTzWnnwUha9EJkH0Rq?=
 =?us-ascii?Q?xIstF0edBPpCoztUyAijUK9/usBsiWZhY+IXf6cmzvrlxWuWy2loYCk65HlQ?=
 =?us-ascii?Q?3vzXfdcGgJbkKOIjH5sbl96RhCIAEKx21c+qkASbQicTRrZ7uF+ingvdxASg?=
 =?us-ascii?Q?XzWMXZ4flN35fAw9Zlnp4PC9cqrqlWHCMhev3UVSdxOoZZDOsRsO31eDzYb1?=
 =?us-ascii?Q?uy6pgRI6ScKKyEEkjg1WMOLI9pqBMPJxcf8yBnRvB5kuloGuRZv0Dxd3DVgb?=
 =?us-ascii?Q?3bTcxiZyBOR1U1bSe0a68owxKzZb//WasUshPil1bFIFWzAZ+lR5orjyCWSz?=
 =?us-ascii?Q?gc1whTLvTXlD1qzSg07WmcSnoVMqDZasTooksxzu79+nde6nzxtI5Ffj8dRT?=
 =?us-ascii?Q?8TCb/oB+bJ16K76lBUWWzlD79yzi1D5ppmhbt3876qd0cuKlBHCaE+/6cz//?=
 =?us-ascii?Q?rTJ4e4iTywQ+mODsWCNC96oxd66zo0gxaFtYBwbtNE/fF3iKRjFCd9J6Kwov?=
 =?us-ascii?Q?UYID/gOC1Q1SN/vJUIRCbi8Llt7xFllVlw99mcVG9LKPvK2L5jKI8bzwFjZp?=
 =?us-ascii?Q?cDpqt1UeoMbgu2ppizRyPNzEC06/GDXCC1C5ETFTbQs1gF6vw8d1HXc05MPX?=
 =?us-ascii?Q?gDX1TnlFFFdolQXyAFI24Od1ZUDh168CfsyxvSw6tFCAoERDkaTPeZHAa03m?=
 =?us-ascii?Q?yijMpZnbMnuHmNThVUI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7699.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65234d31-fb04-4d75-d028-08dcdd563897
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 11:35:56.5955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /1UgPaTBrmVAIEr9WPZOs8vpf7AKZPs8wN60CYRT6yy84lecKSbLprzulCXQGqxw5YZlG5kVqJrb/FKfA1CkFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8946

Hello Conor,


> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Tuesday, September 24, 2024 10:07 PM
> To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>
> Cc: broonie@kernel.org; robh@kernel.org; krzk+dt@kernel.org;
> conor+dt@kernel.org; Simek, Michal <michal.simek@amd.com>; linux-
> spi@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; git (AMD-Xilinx=
)
> <git@amd.com>; amitrkcian2002@gmail.com
> Subject: Re: [PATCH] dt-bindings: spi: xilinx: Add clocks & clock-names p=
roperties
>=20
> On Mon, Sep 23, 2024 at 06:02:42PM +0530, Amit Kumar Mahapatra wrote:
> > Include the 'clocks' and 'clock-names' properties in the AXI Quad-SPI
> > bindings. When the AXI4-Lite interface is enabled, the core operates
> > in legacy mode, maintaining backward compatibility with version 1.00,
> > and uses 's_axi_aclk' and 'ext_spi_clk'. For the AXI interface, it
> > uses 's_axi4_aclk' and 'ext_spi_clk'.
> >
> > Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> > ---
> > BRANCH: for-next
> > ---
> >  .../devicetree/bindings/spi/spi-xilinx.yaml   | 29 +++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
> > b/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
> > index 4beb3af0416d..9dfec195ecd4 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
> > +++ b/Documentation/devicetree/bindings/spi/spi-xilinx.yaml
> > @@ -12,6 +12,25 @@ maintainers:
> >  allOf:
> >    - $ref: spi-controller.yaml#
>=20
> Please move the allOf block down to the end of the binding, after the pro=
perty
> definitions.
=20
Sure, I'll take care of it in the next series
>=20
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: xlnx,axi-quad-spi-1.00.a
> > +    then:
> > +      properties:
> > +        clock-names:
> > +          items:
> > +            - const: s_axi_aclk
> > +            - const: ext_spi_clk
>=20
> These are all clocks, there should be no need to have "clk" in the names.

These are the names exported by the IP and used by the DTG.

>=20
> > +
> > +    else:
> > +      properties:
> > +        clock-names:
> > +          items:
> > +            - const: s_axi4_aclk
> > +            - const: ext_spi_clk
> > +
> >  properties:
> >    compatible:
> >      enum:
> > @@ -25,6 +44,12 @@ properties:
> >    interrupts:
> >      maxItems: 1
> >
> > +  clocks:
> > +    maxItems: 2
> > +
> > +  clock-names:
> > +    maxItems: 2
> > +
> >    xlnx,num-ss-bits:
> >      description: Number of chip selects used.
> >      minimum: 1
> > @@ -39,6 +64,8 @@ required:
> >    - compatible
> >    - reg
> >    - interrupts
> > +  - clocks
> > +  - clock-names
>=20
> New required properties are an ABI break, where is the driver patch that =
makes use
> of these clocks?

Alright, I will remove these from the required properties to avoid=20
breaking the ABI. We're working on the driver patch and will send it once=20
it's ready.

Regards,
Amit
>=20
> Cheers,
> Conor.
>=20
> >
> >  unevaluatedProperties: false
> >
> > @@ -49,6 +76,8 @@ examples:
> >        interrupt-parent =3D <&intc>;
> >        interrupts =3D <0 31 1>;
> >        reg =3D <0x41e00000 0x10000>;
> > +      clocks =3D <&clkc 72>, <&clkc 73>;
> > +      clock-names =3D "s_axi4_aclk", "ext_spi_clk";
> >        xlnx,num-ss-bits =3D <0x1>;
> >        xlnx,num-transfer-bits =3D <32>;
> >      };
> > --
> > 2.34.1
> >

