Return-Path: <linux-spi+bounces-5054-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 013D098A8F5
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 17:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66565284406
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 15:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D085E19342A;
	Mon, 30 Sep 2024 15:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NNMU53zj"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB7C193415;
	Mon, 30 Sep 2024 15:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727711093; cv=fail; b=V0+ESyGWzKYiYB/yv5HbrgwoaQs1Whkeg2BZS/A35K8gHUuPL7Numx4Uc64sNgXaM3slktDP8Lx97OfUXpbYRQMEhNFFmA+pRH20dC7h2BhV2N4MqfXDDp9k8k8J1iY68wkK7BhP9jcVsX+S2AV9sKQyJLLrpm9ER8Z2SncHGlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727711093; c=relaxed/simple;
	bh=fMYAzE8XgYtsF0VpVImWIkIYP3n9gIkPWpsO5caCXP0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=agjYp9+dfRHxoJcCa4FWf8C7O8cMFnxnaD7JLOe1dosT+RaN+KjvTgD13tEM/v4SqwDNzsGP3DsZWd5KDMr7lzm8DtQVcZYaUzQZBMEzN1aj9n/FGsJCDg/kbCouoxbrTNVEUEv/N3F7qMXD9caou26apIy4lAmSNLzo94rKoXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NNMU53zj; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G989xrMRiIhaG2KQ+87XirG5eYfskB4wKtdsbwWVKBUgXXflJe4KR+b8t2fWGsIBqmS67k1z+gU+ZBesAICKlEhpHUvEJ4CMAn+c3+mJ86gHef5rEf/xhC5MNSYccCCCVPFnRGUudipXaHrF6ua6KhmzNlEajAePH6kr32nWYSsUhIwVLPYG/tMZB373O5RofZZoHVzxm3sqNJWRHheVHLgdhL8OQqk062kENdBlendP8JQx5YQhZNYeYTFYAOKijiNR2AbxBa72C6kbAjf+An82PceM+Yz+SZ7rHow0eeHYHf1EfIr2G8tvAxwfiFSCYaj4u+kRYNoWRb4FWdtOHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwF9/8wgDsEuTBt7PtInXPq++XizNY3Ihr2+y5lwoFE=;
 b=aobSB16xhbnH2xVUssPdE1FQm3VuxjQGwNHJeZ6RDDu0az8i0UX7cPek9xsUFCKHEdwR8SKyfIc8oZh81B/Hev6wUOKTZerJ73dFAhnvSz03zoVxrblc1V9zm0GV/+pjslZ6VOnJHWieZhWH/TS6RHb6aELQ8jRhzmCrLYUegT5HLNJGYMRZl/mtcb3oy50HoKtaY12hLnYoG9rM5AJ+6RdkWiwn2rNrmKNFsiT8BjbQuD+g8sPJmDow4pBWSXvfVRS3qk4ykIE9NUaCofkY7w+H9o//S1UzzCzSJHyv2dQY3JGQbqxeq58Q2F/mCuHjEAseqJUw4R5pzwuKuZ5Rdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwF9/8wgDsEuTBt7PtInXPq++XizNY3Ihr2+y5lwoFE=;
 b=NNMU53zjCqz+jkJbRnZBR0YB2ltZ+TjgBsw39I5YxFD1imKBfQzFAVtukissAwyFaFaF3s0ZxugM3HrkMLGsTv8gfW2+YzdOWo3Up8t6Ax8Erq45FuYMoCQwc4jt2sBaOfh7gq9XWt2h2fnB6c6UY4fb8e5PFlDKWCebPtjHK+A=
Received: from IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7)
 by DM3PR12MB9349.namprd12.prod.outlook.com (2603:10b6:0:49::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Mon, 30 Sep
 2024 15:44:48 +0000
Received: from IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa]) by IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa%5]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 15:44:47 +0000
From: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To: Conor Dooley <conor@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
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
Thread-Index:
 AQHbDbS6IWXQrG+wX0CC5AjhvyS/qLJnJHoAgAE51XCAABg2AIAC3+PggAGMU4CAAMdKAIAC1yFg
Date: Mon, 30 Sep 2024 15:44:47 +0000
Message-ID:
 <IA0PR12MB7699EDFA3753D25C8126D901DC762@IA0PR12MB7699.namprd12.prod.outlook.com>
References: <20240923123242.2101562-1-amit.kumar-mahapatra@amd.com>
 <20240924-impaired-starving-eef91b339f67@spud>
 <IA0PR12MB76998D7BC3429606508E6202DC692@IA0PR12MB7699.namprd12.prod.outlook.com>
 <20240925-trapdoor-stunt-33516665fdc5@spud>
 <IA0PR12MB76999B696A9BA0834644AC71DC6B2@IA0PR12MB7699.namprd12.prod.outlook.com>
 <03a1c7e7-c516-41ab-a668-7c6785ab1c4f@kernel.org>
 <20240928-postcard-lively-c0c9bbe74d04@spud>
In-Reply-To: <20240928-postcard-lively-c0c9bbe74d04@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7699:EE_|DM3PR12MB9349:EE_
x-ms-office365-filtering-correlation-id: 6c52577b-a116-4322-3d39-08dce166d066
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/COWkAwoaFJiZGBZXFFi6KdJcfGk1R8BjuwoAQcDWnFdN0QAR47pAkqJ9wIr?=
 =?us-ascii?Q?Gq83vkL+5pCgpJImB3i9/j9bp8v2ct9a2M4PrJmeKuHsRm4S02wdXJB+jzaY?=
 =?us-ascii?Q?NzgcRiWs8TpHHji/bVEXtYFfz+ss65zyYjJ6yCMkmGPEL7/DIRqP8/wuD++E?=
 =?us-ascii?Q?b0GU5l3d5Geoh0+4thGejuJFTd/C1qotJW4Fyu9On8BIw756q5gbhQvZgEE7?=
 =?us-ascii?Q?D1nrtUBlF9GGA5Wm6xhSd4zo3ae7Dl5/uhZPW4vukh+ySOJFEo52p/dST+Td?=
 =?us-ascii?Q?ZkARol+BO4oZO2Pn6OJ+Jtsg46QNbMfRM0TPkCHSBTy2TflhJ/0ZtFEo2vgz?=
 =?us-ascii?Q?wU3DNYuBnERsUfmFXuwCvXnZff37wDke8g8iskQo9g1z1YLs/ZOJPtdsXCag?=
 =?us-ascii?Q?JaPMNOdCAL5Lh4AbnzMS6W5FFt5+kPRsJJNUnfJd5LQSoXJHvDuTtTawvmYk?=
 =?us-ascii?Q?ppDeC0ISNNOHLtEyKQbGjKYkjPBZ1tQIunusmkh245F26g1T640p3gviQ/wH?=
 =?us-ascii?Q?SbB8NkgUrssNLDRGTPdjzYwawf3qVQjpBo9o0+jHsD4CAxiu+SNzV6NiQw7q?=
 =?us-ascii?Q?a9Y02tOfmyyLNS3+6J47sXO97kj7qjBI9kIwKZz0t0O+d2L2ySDKYSb3ADE1?=
 =?us-ascii?Q?T6ipDIMgoF65Fn+f/aczlUlpXfDQTdo35dFj5JyW4QlW1qnHXzl7KH/zIcBf?=
 =?us-ascii?Q?7OXpfpgWvdAAs6j3uDlXyt0PDicAZqD4TTK4oY9sLpBKG+z/kQ1Ll5DvctC9?=
 =?us-ascii?Q?5JvU4VxNGzroezHn/Bx3afD0uYWyUk4jpOM9R5bBYZp4bE8AFY+xhfP6BR7t?=
 =?us-ascii?Q?dbOOszGDnXmOC6EqHoYQnVtjh3i6AS0J1bb9z0iHoTjMrAuReifMeJeOz3Yw?=
 =?us-ascii?Q?K1uAdlRRtnD9Y7TsBd81ijM3nUiCVuCUZYt1T18/8v0mb3Em3J9esmcwiYou?=
 =?us-ascii?Q?XbEWMT8eLjt1YidLC31R8nrk2CsUQVefyeQgCs9+Zz8IXSFIlMk45jtxP2jN?=
 =?us-ascii?Q?gqssDXSkk7gH4s4890INRXqElP1Mw3FBUOuVBfRwlQgN4+m3SyijHf+69de3?=
 =?us-ascii?Q?t6SUECyw1njc6XdBqppQQJ1ZDy4UswB7pxDr0zjH26/VzPf5h+rEn1l0eRGU?=
 =?us-ascii?Q?Kc6hzrlOdulhg3BAuojhIaPt738nHo5r4ma0AxXCirEuxUNLXtwpG4bFFO9A?=
 =?us-ascii?Q?zLZML7PLOTPzP5LC6TnhnCWbzltaajZ3+Fg5b4rsX9NQVdiyBv6RyVJMPYPK?=
 =?us-ascii?Q?BK/wxzQ7oVZPIbXRUfB/8NzLM8oUVv4j+vbaqt00jPY4Xvo+JA3Qs7CgANhQ?=
 =?us-ascii?Q?LxftYva+N9h9SiqglBmjl/l63+hIAIQYQdHd63bHUl3cVl5GfSH/DlJJ9i99?=
 =?us-ascii?Q?Rn2LXro=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7699.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MiW9sTA9s7hokoP0ahzN0bMqjG4Tfu+gMN6DbIUzMYeZF+w3zqxkUQZbWrJZ?=
 =?us-ascii?Q?O54Q+UTfTwfEflgsdpCJud+XSsTfZePuODANcJPo1/hOIFTJkRIvtjfPWSRh?=
 =?us-ascii?Q?6HMqUpPYcHSYM/rz9PVpKXDX0shmWH5soPdbfOsT2hQ4EcvzWzS0CeFFcAqV?=
 =?us-ascii?Q?+sM6/ypi0XTxnEGF5HB7s+3P/eOUTcuukxRWonhW6Aev9YNnAIDtYwjgIIx4?=
 =?us-ascii?Q?br3P2LpeAsEpyenOwxYNUFeQqNwX8EGIWb2x2pJADLdc+WFvw0b7JSgjyh/n?=
 =?us-ascii?Q?pE9HHXQiJYshX34YwMcZQlHeBgNd7VNB+WOm8BF0/x5R2c9RKbOgrjACsQ6E?=
 =?us-ascii?Q?97gU0uxy8EEMF280zRc/omRgFNhiHLAL6t2Ikr0O5ghz02HzRLZczsa4JlSO?=
 =?us-ascii?Q?TUO0aoDS1KG1jMce6k1BjXi1rwCyB1lSDArT+LCJTbjmYJZaVWd36+Asn6tw?=
 =?us-ascii?Q?7UY4azACbgofkv4QieMUkjbQuKZTZ7+zppALHR/tr7W0EgkPFsaMWn5ygBru?=
 =?us-ascii?Q?OaWvck2CeumXx7IJOCUmoSJZlPgWseGYeI1cqaBEoPGBAYQdrUz9Rqq/PUwj?=
 =?us-ascii?Q?pl5i9TXoatWEhfDXXrN/4hzZ7AjTpojvujzyBXWMoFkhM1tRdWvur+gq5DBL?=
 =?us-ascii?Q?OBx7kYZ44BKhVcbjC5E3sIi5B7PbJI5YLYD7kxr7/eSTaxi8rDzFTApl9w6A?=
 =?us-ascii?Q?k+O4VkJTlSydwAtK6fOEXpBIfV8eYCKEKD+C7v0YlKdAQXYSb3rd73G3AW9+?=
 =?us-ascii?Q?KY+zXLufk77wBUPti2uKZFMharSBvPsSfZ/8YsBMkzMDXKRnR2Pz9QfJ9ZBe?=
 =?us-ascii?Q?qgm9t9QfcvlIv8F59RsqOpp5yg+0k/VbDYXS2h4BOGdjSe24kRSpRW8MVjAn?=
 =?us-ascii?Q?27jxJ5hx1Da7MPuBC9vswNTzszEs62+XWdKrP0G3Hh6ZcqdpqObuMPK49lju?=
 =?us-ascii?Q?hRNr8x3R1kfIKzAmbBp/yDnTs00ZgF5L/dHvqKOe7RhjDrQyhvuIUf3KbBaW?=
 =?us-ascii?Q?5PYTnRtS0Os7+428TxOz9U/p2SgFje3nIXzu2TBgNEEVVC32nqLwWt4N7DWe?=
 =?us-ascii?Q?VuvX2IP6hBo0yOxPfyhFc7kGGhWxBvHDF7IVXwcpGIH2ZsDHWYYUQPiUfENs?=
 =?us-ascii?Q?wd+3kuVoQlvIlbu3RVK2uRhw3GEa4ydP8MRkLas1e03Q+kLVp6ht1AzpTViV?=
 =?us-ascii?Q?pVRB8RqQ2Fohrq4dGVfccm/FLcb+UieY9RNxg3jonA0OAUjOYO1hx3+g4c42?=
 =?us-ascii?Q?SV66ovUmvkyWCKXFKmW0u5Zb2FIdCnK36oguVbwN51yjv+E4RZMuf23n0x+l?=
 =?us-ascii?Q?cLqaDz8r06jRogeIz7EX/67bpjrCoFN7/GruxKiowh3u0SloNA/70ADeTWVN?=
 =?us-ascii?Q?BF0Q70LecAfJVdLrnRIRxqfdeK7rCulq33fNyuWGjk9Cy5Sd+xS3/5uCRp11?=
 =?us-ascii?Q?MyOAPSSF10yOrJWgwT/94fyyZsGU1a/lCytAdtk+sQVqOqIzykRwYb4FaQ5F?=
 =?us-ascii?Q?ZhG4CGWAS6v4lPm8FsAfdY2pT3ZKHpXrgDverdN2/EvYjPwmVkNT4jzqoWk4?=
 =?us-ascii?Q?ttgaL0gYFqIG0cH1XxE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c52577b-a116-4322-3d39-08dce166d066
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 15:44:47.8454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EV0CrY440RHi9QQFH7nJySxSWAXIyueAcaqMlGE8zcEOk39YqgNmYCmm0VKg1OM+7rNe32mZu4f5m8GRnAVVXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9349

Hello Conor,

> > >>>> Subject: Re: [PATCH] dt-bindings: spi: xilinx: Add clocks &
> > >>>> clock-names properties
> > >>>>
> > >>>> On Mon, Sep 23, 2024 at 06:02:42PM +0530, Amit Kumar Mahapatra wro=
te:
> > >>>>> Include the 'clocks' and 'clock-names' properties in the AXI
> > >>>>> Quad-SPI bindings. When the AXI4-Lite interface is enabled, the
> > >>>>> core operates in legacy mode, maintaining backward compatibility
> > >>>>> with version 1.00, and uses 's_axi_aclk' and 'ext_spi_clk'. For
> > >>>>> the AXI interface, it uses 's_axi4_aclk' and 'ext_spi_clk'.
>=20
> > >>>>> +      properties:
> > >>>>> +        clock-names:
> > >>>>> +          items:
> > >>>>> +            - const: s_axi_aclk
> > >>>>> +            - const: ext_spi_clk
> > >>>>
> > >>>> These are all clocks, there should be no need to have "clk" in the=
 names.
> > >>>
> > >>> These are the names exported by the IP and used by the DTG.
> > >>
> > >> So? This is a binding, not a verilog file.
> > >
> > > Axi Quad SPI is an FPGA-based IP, and the clock names are derived
> > > from the IP signal names as specified in the IP documentation [1].
> > > We chose these names to ensure alignment with the I/O signal names
> > > listed in Table 2-2 on page 19 of [1].
> > >
> > > [1]
> > > chrome-extension://efaidnbmnnnibpcajpcglclefindmkaj/https://www.amd.
> > > com/content/dam/xilinx/support/documents/ip_documentation/axi_quad_s
> > > pi/v3_2/pg153-axi-quad-spi.pdf
> >
> > So if hardware engineers call them "pink_pony_clk_aclk_really_clk" we
> > should follow...
> >
> >  - bus or axi
> >  - ext_spi or spi
> >
> > You have descriptions of each item to reference real signals. Conor's
> > comment is valid - do no make it verilog file.
> >
> > >
> > >>
> > >>>>> +
> > >>>>> +    else:
> > >>>>> +      properties:
> > >>>>> +        clock-names:
> > >>>>> +          items:
> > >>>>> +            - const: s_axi4_aclk
> > >>>>> +            - const: ext_spi_clk
> >
> > Nah, these are the same.
>=20
> They may be different, depending on whether or not the driver has to hand=
le "axi4-
> lite" versus "axi" differently. That said, I find the commit message kind=
a odd in that it
> states that axi4-lite goes with the s_axi_aclk clock and axi goes with s_=
axi4_aclk.

Apologies for the typo. When the AXI4 interface is enabled, it uses s_axi4_=
aclk, and=20
when the AXI4-Lite interface is enabled, it uses s_axi_aclk.

In my next series I will update my commit message & change the clock-names=
=20
's_axi4_aclk', 's_axi_aclk' & 'ext_spi_clk' to 'axi4', 'axi' & 'ref' respec=
tively

Regards,
Amit

> Seems backwards..

