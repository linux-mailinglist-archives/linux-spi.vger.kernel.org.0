Return-Path: <linux-spi+bounces-3377-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A20D1904686
	for <lists+linux-spi@lfdr.de>; Tue, 11 Jun 2024 23:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2A9BB243F5
	for <lists+linux-spi@lfdr.de>; Tue, 11 Jun 2024 21:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD8C154BEE;
	Tue, 11 Jun 2024 21:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="qXMbtPRg"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356E4150991;
	Tue, 11 Jun 2024 21:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718143038; cv=fail; b=UwzAz0J1p2ZGdCZIv/xUNcUsuCGoTExqKNjmAotng/QyVd9qWPE8kAz29U/gsDrE8bl/SDEzFnxqztwp0ABsIzK4r5raxhJ/Wr2oh/5T5EEWIqe6jI6GVyvTVC8tAeYFBiNp/netUYMnE5K2oTYvIwJ/EuERLKt9i59VLw60ibE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718143038; c=relaxed/simple;
	bh=sfh6BHH7TxC0J23C9UaZgirvj6y/saAQEwnXyB0aWag=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kx2Kiz2QPV/mtdX5iAb7N4CVQnfmp218XeN65ye1a3/se/k/5MV4Tuyad2S+YsMzVeVT46bTsL8TXECPDskhSKd3+ngYiQL7nmeM7bpsE37gV5X3DbGcvoD0/wb6BUHTlAag4u3U6g6tq8XbrtApC17n7q4hH76BPE2vdUvokgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=qXMbtPRg; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BH7W8H002563;
	Tue, 11 Jun 2024 14:57:13 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yptq3h6k7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 14:57:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N/AoySXBn434xkUnH/xtnVXanAqMxi+ZuEI6+87SXs1cxzD/tJVyTY8jWuYkTyJEQEuml2BlVrMF1AxNb6ZdXIxcPY6GPQnYS/chR0v5/8+udnmSFCm4cZIFV1/dSdsNb7/XZ8bhTNwP/iBd9Lm3EHgHdwxl+Tk5BsxOUksVXTnIUy7uvHF00HkZgLY76yau1gEtIeVJUZQxzDNwt+Dol77O2dhXSYrAGBhE9MlgMS+oKjMvnbJkUebepjv86gVlQsRaSLnHfk1nYLK1dJymdwp102t0v7+NVMy3to5NaV3i3p9U5eUhE34qIe6cuGh1xO6GD0vaxl2U+I1t5/9JKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DLTeuE4DJ4v2ldraOAgz+zdqnCLBzt057HNAwOGnPE=;
 b=AjoiJ/w1aHWyk3pTWEr672kYizpc/e+ENG9dwrR7irIonaGpIxCFs4YP4GGha45SJD8LEtQdeTdvXcsFPdGOgr2LIapri6xCkdeDmT1WUlK+waxd6tKeSCu9z3jsQB8vMVSNrxSV6dCUhpdg5TcYvvNg5sZciGwMjVyI3cu4zwpLtlQg1YU8x2+0Yf3PU2+0SaI5P2K8jSFKSlHnukgpQiFtlDNGlQ872Zz/oO18yr47YLbBdZeSpltNdxDhMswLSQpcOkvt0/+ZxmkozURStZb50+hJSNBbsJmUSzUZd/35sezfCVozHAS14K9SO0Gsz1PccmE0QvjlZgilqigO4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DLTeuE4DJ4v2ldraOAgz+zdqnCLBzt057HNAwOGnPE=;
 b=qXMbtPRgLH24WM+t65RVrcWQ7EnK2u9mZdQmjGu9pFzFpg1Qsp8jfnGp78nGluViwmlRVih/fFzU7uMVAtQun+zNMDoInKcx4M+98AJSxg3/6zxgvCqnD3oAtjoMvL6jSBhTBM6YvCo3Duz1diTYGomsKTTCjF49VDdEZav2Mu0=
Received: from CO6PR18MB4098.namprd18.prod.outlook.com (2603:10b6:5:34b::5) by
 BN9PR18MB4250.namprd18.prod.outlook.com (2603:10b6:408:11b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 21:57:09 +0000
Received: from CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1]) by CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1%3]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 21:57:09 +0000
From: Witold Sadowski <wsadowski@marvell.com>
To: Mark Brown <broonie@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org"
	<robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "pthombar@cadence.com" <pthombar@cadence.com>,
        Piyush
 Malgujar <pmalgujar@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v8 3/4] spi: cadence: Allow to read basic
 xSPI configuration from ACPI
Thread-Topic: [EXTERNAL] Re: [PATCH v8 3/4] spi: cadence: Allow to read basic
 xSPI configuration from ACPI
Thread-Index: AQHauO4K6zUk8Kb9I0eeU/kZ+sK2r7HBLw2AgAHyVVA=
Date: Tue, 11 Jun 2024 21:57:09 +0000
Message-ID: 
 <CO6PR18MB4098CD7676AA96B680FBC068B0C72@CO6PR18MB4098.namprd18.prod.outlook.com>
References: <20240607151831.3858304-1-wsadowski@marvell.com>
 <20240607151831.3858304-4-wsadowski@marvell.com>
 <ZmclB2CMhhkasiBw@finisterre.sirena.org.uk>
In-Reply-To: <ZmclB2CMhhkasiBw@finisterre.sirena.org.uk>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4098:EE_|BN9PR18MB4250:EE_
x-ms-office365-filtering-correlation-id: 766edca3-b5e1-42e1-d2c8-08dc8a617127
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230032|376006|366008|1800799016|38070700010;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?BVwbek9z9yPI1Eh0EQG2U6FMC5YgEvEzDQjSZXBA5QNrX4xoOp9VuUkUnlzm?=
 =?us-ascii?Q?nubRay+QCPEZrKrLRI0F5a5/JxFUh/pAIebegERQDV76l9fGczTwBLcPMJJw?=
 =?us-ascii?Q?6m+HfVXUIxILuRQ1emZZweYhvYcmb4U51IPbdqM0O5gVWfaIg0DWC9ShjNzT?=
 =?us-ascii?Q?BP8zFUJUK3uDSCKXESTGbYvBzVdwCrIvhSCyP6DOiTmEw5W+WnK/07tJTYjz?=
 =?us-ascii?Q?UCNpemXOGUHBzumk7aLtK9AFnLja+onPtN8RVzJWu04MbUMpcaZ80/eNyKNW?=
 =?us-ascii?Q?1uwnMIXpN19R4mLPhZKWcdxt1x/HTywyMNLFxlwBn2pdxiyV0r4qAStYwRf8?=
 =?us-ascii?Q?rhoe0XJDvlfC6BnLPrf8HlNGZRdoSn2+mueosDxqaQJIR7GaY7V5KVgvQmGk?=
 =?us-ascii?Q?vi5xyx476BzPEuQ4QCKsWuLupAGV0QiEmRU3gS4xVUOlL/qEaf/cCI/HRsOF?=
 =?us-ascii?Q?PjwRTvkVmORRMF0zeDE34snb/37jScAuyMfLTtLgzEQPk8ocavRFo3Ick6N4?=
 =?us-ascii?Q?8bEDbbkF2ccbh+gvNeoMv5rJgtPFGZQZOx2Pvzelr/9cjziVspHWN3iJci1r?=
 =?us-ascii?Q?KKb36exHgzrb/ipJ282HlrnwCGJhrQ9QXBn4diTNyznuA6sivmP9GvBlmhij?=
 =?us-ascii?Q?yU0Q0QSyPFkCqXhB1NVQGoCuj5rS+OuHk1zYBR5ircqlDWch04PWsYNvi28P?=
 =?us-ascii?Q?gkeRufEm4SivMgPL34wcC8qZNVt6n65ac7vnXKxICBDyT9ALe8Dn8xgCQfpj?=
 =?us-ascii?Q?ocHx6TGzCEt0NNbYiL9R/7Urp5W8KQ2yakWvCeblFt9Zjj37hnPMJ9d37Gxl?=
 =?us-ascii?Q?QBjunBY7OyqL5OIqzDjsl/Rkh+noOiB2Jmjuv4pIShMlNcBJObp8w4VTEU/Y?=
 =?us-ascii?Q?U58R2KMD8sq9GFixpJ43swNNOWKE6iwAvy5TTiUY1F17cPcNp+SzZZcOEvzN?=
 =?us-ascii?Q?XMBGb8KavzG91uDyU/k1fmHucyWrXC1Bt4TE2Rcx6GDFT2QeqqRRxh0bkyLm?=
 =?us-ascii?Q?LaJS1KlPQUcsuGVib7BpPMjlA1F+FsncDG43jELekFALNGc2nVJTVN9r5ENW?=
 =?us-ascii?Q?maITkOni2p57lu5W2gA2N+v7c79nVFeUBEPFPT0P8BRkCPXvQayoIR2aanMx?=
 =?us-ascii?Q?N+p3KpR3sGW824GGEzlDJm38o3hO2Inu0r8WIUNtuCQtL6XbM81xebDZJC52?=
 =?us-ascii?Q?eZJGb08Zb4KaMGB/kahjeD3+YVPw6CIRidgv93k496uT2HtIUP2VrG2nxpDI?=
 =?us-ascii?Q?r2DLXA8uCTagxA8nyIzjGyzCSKUyEpie3CC/WYopZ61G6yg8vRrBGC/GzXah?=
 =?us-ascii?Q?oXp5IzQT9Cd5v0w9LtggHxIO94R+xZ5qOChI0QFAqxmqnGYo9NLFPxuOMhLT?=
 =?us-ascii?Q?G5zCrT0=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4098.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016)(38070700010);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?PZ92c943RHoP1cFZ53ijSOKILB3JJsAdQCmPdcUXpduXcodrR7Qk7p9532vJ?=
 =?us-ascii?Q?ZGBZjhOHggVBO4ngK/6FvGZCFecDfwuQW5mhwg2B0lOgr0Dd7Ptpgy/MzjYh?=
 =?us-ascii?Q?/pe/G1q9FdkH/n++Al2lchAKN1seZEkXjtbrRy0SXWdmwjTYUirAyOVL39W/?=
 =?us-ascii?Q?NMJ7/PthcBKn/Dg3tZcopoWVhRdmIX8z4y6P8LJkUSH4LQBx91aUO/cHlt7a?=
 =?us-ascii?Q?G5L+uamQlBNUZMs+nKSg9q10y5ZbRRfh/2mE0f9hNUQL/x++nlqvB0cbxM4A?=
 =?us-ascii?Q?7srCVd9mwulTGsr07bhnoAfHvYEyM3i+WWZtPgEX1COcNf24rtWXkf2HPssI?=
 =?us-ascii?Q?Zdx1LVaPjTa4znj6bogKn2HrcGzxhFeDgbzGiCpto6c+Olx483guaPLU6uYX?=
 =?us-ascii?Q?1q6DhlixtasjSkkP21HsgHtJ5c7TCjOhknU8FfB/zvdh1JyH/vsbM6q1mzVb?=
 =?us-ascii?Q?xHbN38Rt9iTtQyrVBq1xGSYG3j5jeSyL7vkf55T/j1isTlKwWRoTg/a1Uk4d?=
 =?us-ascii?Q?rZCxEFzI0oYkx8Pd3gOCIe4Pm6M/A2lodN7pT8K7G68yNipu7YH1SxuLhGIu?=
 =?us-ascii?Q?reXNLljGkIkaVmBcHnYCn324F14AstocJ63a8dcw/FULHBMlek/gQfFCDGo2?=
 =?us-ascii?Q?qrRIhG7YQiVFvo9JquQBulJNKs4JteXico6mB8oCte6MEGGTplYEyViOF0w9?=
 =?us-ascii?Q?OgPOOTDi3SKrxwr2J6FEauJrAhoaqC/OyCIJqnvNDroDpKTbbxSdJxMjB2tf?=
 =?us-ascii?Q?6Sa9ZTiCfV7Tu9nd/o+nPMf6vDUULA06S+Nhr/lCi2O8DUX89O95peJJI48M?=
 =?us-ascii?Q?DX5dhbtj8zyhfXyFB/nFOU5zh1AtC7mjOaq1BPDvh9bV/CKG13077rNaP7iN?=
 =?us-ascii?Q?SleSLr7BaS5lc9IqOe4HJglkZi0wdIUbZCMSEPG+79GMyWt5pF/w8X8fqDYg?=
 =?us-ascii?Q?ZvibxNhh6p6liYNYm7qknAc6mrukRF5Tfd3vw/EghKMuryc7Ls8jgLsjKRqA?=
 =?us-ascii?Q?jJ47uC/twwVM+Xi8lbBO/ldObwH5ynQo3NJRQsvAqyOsdWjYvcZ3pY2N7wzA?=
 =?us-ascii?Q?MhKJAJd/2TrCOh8Tr8lfgP2PlzNjYcywU85FEoRETW1+DVb8fhsZXNkEclHr?=
 =?us-ascii?Q?wUcTprKP3T5rIN05DN+7J55B90zUvG8Q8ZPESIm0zr5d7SHVEoxl0vPSx8Kh?=
 =?us-ascii?Q?UgYJZCxNeNCYgzxDowKWXhJ5OLDhnFwEor1xakC90V+EsqIfWQ02iAtFyUqo?=
 =?us-ascii?Q?zxRa1vCehXSuF9rzBVRo/EGsrYGfiXrUMQB8Mdr3xFcnzPi5kHAQjBRl24EN?=
 =?us-ascii?Q?vedgC0z6sOZnf+/HOgt1X6NQ1Jvtni7RZ8IEAUV7PmD0X1xHFklTfZY6y7dc?=
 =?us-ascii?Q?B70cREjjSzvjoWsrCdYXXpHNyr+pXjy5ElOJfTPq9/sJuCFYTdCIHGD7TGEc?=
 =?us-ascii?Q?LYTNx82v+BCPXUmVhPzUxSKCDJftTUX8ESTbpiCmZ4k4ZM8ObEviNo5k7D06?=
 =?us-ascii?Q?DN10OhqKqHHuExCqHIDWg7wuaRD78J8hRxc+O2em6Vfz4AHGnEnG71tQOXNB?=
 =?us-ascii?Q?Ft4IXmqj82J38JDKJC9qrk1WgogAji4f3wk28+3w?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4098.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 766edca3-b5e1-42e1-d2c8-08dc8a617127
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 21:57:09.4579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NGEgZ8R2EBPLbgqmoRptUHwDWiqqkbdamKSYG+AEx1USSboXYrZj1YY/rPakzJbkQhsC93mMNX4auG61oE9rlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4250
X-Proofpoint-GUID: Ye9CQpVSG4Wj_MfgFyWK8PkUFXDxyPCg
X-Proofpoint-ORIG-GUID: Ye9CQpVSG4Wj_MfgFyWK8PkUFXDxyPCg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_11,2024-06-11_01,2024-05-17_01

Hi

> > These changes enable reading the configurations from ACPI tables as
> > required for successful probing in an ACPI UEFI environment. In the
> > case of an ACPI-disabled or DTS-based environment, it will continue to
> > read configurations from DTS as before.
>=20
> This doesn't describe what the ACPI tables are supposed to look like or
> anything, it's hard to review this...

There should be an example of ACPI table in commit message?

>=20
> > +#ifdef CONFIG_ACPI
> > +static bool cdns_xspi_supports_op(struct spi_mem *mem,
> > +				  const struct spi_mem_op *op)
> > +{
>=20
> > +	if (!acpi_dev_get_property(adev, "spi-tx-bus-width",
> ACPI_TYPE_INTEGER,
> > +				   &obj)) {
>=20
> > +	if (!acpi_dev_get_property(adev, "spi-rx-bus-width",
> ACPI_TYPE_INTEGER,
> > +				   &obj)) {
>=20
> Why is this Cadence specific?

So that part should do to generic spi? I think right now it is not
Supported to read tx/rx bus width from acpi.

>=20
> >  static int cdns_xspi_of_get_plat_data(struct platform_device *pdev)
> > {
> > -	struct device_node *node_prop =3D pdev->dev.of_node;
> > +	struct fwnode_handle *fwnode_child;
> >  	unsigned int cs;
> >
> > -	for_each_available_child_of_node_scoped(node_prop, node_child) {
> > -		if (of_property_read_u32(node_child, "reg", &cs)) {
> > +	device_for_each_child_node(&pdev->dev, fwnode_child) {
> > +		if (!fwnode_device_is_available(fwnode_child))
> > +			continue;
> > +
> > +		if (fwnode_property_read_u32(fwnode_child, "reg", &cs)) {
> >  			dev_err(&pdev->dev, "Couldn't get memory chip
> select\n");
> > +			fwnode_handle_put(fwnode_child);
> >  			return -ENXIO;
> >  		} else if (cs >=3D CDNS_XSPI_MAX_BANKS) {
> >  			dev_err(&pdev->dev, "reg (cs) parameter value too
> large\n");
> > +			fwnode_handle_put(fwnode_child);
> >  			return -ENXIO;
> >  		}
> >  	}
>=20
> This is just a general refactoring to fwnode and could be split out.

Ok.

>=20
> > @@ -814,19 +890,19 @@ static int cdns_xspi_probe(struct platform_device
> *pdev)
> >  	if (ret)
> >  		return -ENODEV;
> >
> > -	cdns_xspi->iobase =3D devm_platform_ioremap_resource_byname(pdev,
> "io");
> > +	cdns_xspi->iobase =3D devm_platform_ioremap_resource(pdev, 0);
>=20
> > -	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "sdma");
> > +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
>=20
> > -	cdns_xspi->auxbase =3D devm_platform_ioremap_resource_byname(pdev,
> "aux");
> > +	cdns_xspi->auxbase =3D devm_platform_ioremap_resource(pdev, 2);
>=20
> This causes us to ignore naming on resources, that's an ABI break for
> other systems.

In that case acpi tables are not able to find resource by name. Or at
least I wasn't able to find a way to handle that in different way.
Is there better solution for that part?

Regards
Witek

