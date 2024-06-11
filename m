Return-Path: <linux-spi+bounces-3378-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A70889046A8
	for <lists+linux-spi@lfdr.de>; Wed, 12 Jun 2024 00:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01D01C23546
	for <lists+linux-spi@lfdr.de>; Tue, 11 Jun 2024 22:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C8615383F;
	Tue, 11 Jun 2024 22:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="qNLIEobP"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A6418EAB;
	Tue, 11 Jun 2024 22:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718143362; cv=fail; b=eGes3vlS5UEhAWMVlkxDXTpAy+3go7dhisb7XwOAlXmJYLtpcvZ0E9f7FpjrunumczTjsEQi58U254k1gzGy8yhzku1J+CeYCmzuDCB7M1uvWJq/+DVzTXX3rblOh0NqLDEGTmmmcvsrNyW2Q46OH1fyl3BidIRoXjziS99WHoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718143362; c=relaxed/simple;
	bh=e/J/jRg8Dv3DJr99NmXC+IeNK9fFUAxFrYJuGtqm5yo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LcxqgLXyJO+EhIUzZwD/RU/V11kAJ8BOefnbpe6Py+7DizlxxOMtEOPg3SyfaluqRwRJck5oppENTZAIWcLT9AyvoAUbmvHAb0nnJV2gJT4ZaJvU5g6vP0tLSgcrjH82q4Kss7Y25TuMd3k5WHa+KyfOLbcvp+GV67F+rAxY39s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=qNLIEobP; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BH7W8k002563;
	Tue, 11 Jun 2024 15:02:37 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2049.outbound.protection.outlook.com [104.47.70.49])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yptq3h765-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 15:02:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KIexygQa7nDHcNU4qKSKaNGWNmfYVV7jOmk5Ngw5Zq6wZHYn9kILgrOu26mHHmH+pDmfUbwZqZbTP2CeRUW0c1xCGPoQBmsCcHqghrreJhCrBtyGsU0zPfSbOPqC+NBlVO2BteVdoUgGKRFZ2SKmwatqi6NdETgBscIi3VuQ/BHdSukcNBVLxX11VYeZeLmNObZCqnj0OgNVfOrOR8yHwF/J9i+yo0Ro34ZFdCozA8f6mFWtbammEZgOebNa3537QpaRMAec3/8QgdV+wfJlNiZ4fHshi9PFiCZlMdILhshFDvHkpvgM4xjNegDu8lRS1GOvsDD6vOxHBWGRNwoGuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZKfgM/LlNAWLtALxinEDP50oSh15qDLVb8f/6fVvAU=;
 b=foKBLWB2hML8qXiZf6PzE6EjATqI2doKYvkYvhImkzuLI12tTBRdDfOwBGmUF5bgJzUzFaCtBEJw3ro9gTjNwN4AnlY4zEWuWonxXd7BBgJK8cAkJpJfscU/pOKsleaLo1MsYTM5pHIzk7P2+dn+bBFUgXx/tMTPnOmEBbyJNu+dFeJiymo5g3ZZBIqZCHFWDbEFijnsEIbfg9Yf66mgIX/jcLas9xlNlog1N/3AM8z1GFMTQUXw4Nr7F3i+GhWM4SCgZeZA7VcVtYbFmEVxO5tQAxTcFXYGdm7UNOOK7Kzf6RNdmzyo+v0dyznWCap4XcpRExpszE7MZuKsX5dvDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZKfgM/LlNAWLtALxinEDP50oSh15qDLVb8f/6fVvAU=;
 b=qNLIEobPxWmVgOd3KUN7uWicnftHpmFZ6di07V9bGQngTsHU42oTIi2PXgijfd//+HfIrN2RPkvIZhbTK0LOuEU/4VwtVEwL5u8u82AAbhrq9x0RWf9Sygx+1dVotaVKV78mCk0i72QEWicIlDwGtMwYdYxcsjjs/4YQBvc8UQw=
Received: from CO6PR18MB4098.namprd18.prod.outlook.com (2603:10b6:5:34b::5) by
 BL1PR18MB4149.namprd18.prod.outlook.com (2603:10b6:208:310::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.36; Tue, 11 Jun 2024 22:02:34 +0000
Received: from CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1]) by CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1%3]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 22:02:33 +0000
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
        "pthombar@cadence.com" <pthombar@cadence.com>
Subject: RE: [EXTERNAL] Re: [PATCH v8 4/4] spi: cadence: Add MRVL overlay xfer
 operation support
Thread-Topic: [EXTERNAL] Re: [PATCH v8 4/4] spi: cadence: Add MRVL overlay
 xfer operation support
Thread-Index: AQHauO4LZaM3qdOTaUCf+ifD3OpGhLHBMgQAgAHwyyA=
Date: Tue, 11 Jun 2024 22:02:33 +0000
Message-ID: 
 <CO6PR18MB40985A453930C40DCB5C5845B0C72@CO6PR18MB4098.namprd18.prod.outlook.com>
References: <20240607151831.3858304-1-wsadowski@marvell.com>
 <20240607151831.3858304-5-wsadowski@marvell.com>
 <ZmcnhGH2fcmrXn1G@finisterre.sirena.org.uk>
In-Reply-To: <ZmcnhGH2fcmrXn1G@finisterre.sirena.org.uk>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4098:EE_|BL1PR18MB4149:EE_
x-ms-office365-filtering-correlation-id: f8fe99c7-ab5f-4dea-ccd5-08dc8a62328e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230032|376006|366008|1800799016|38070700010;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?duWVvgXUWqkQ1P5cJv+cU+VDL8TkvZVaGTdFIOjejcrE0gPFGFr67YWjEISy?=
 =?us-ascii?Q?ZmB91BwjOoOC5Ix4gfBD6Li3LSiri3QRGzqxWv0C6SaAlc++mN1qAckVOUKL?=
 =?us-ascii?Q?isKTVBcoTWi8wH50gGEPszgNofNn/R3+7//MV2BTHYBFeYbsTTJlEFm26Beo?=
 =?us-ascii?Q?aw2ko5IkBSGmYI7vZWNylcW2yk99k9YXubuvDHB5o5i3svt6Qnvlgu93X1rW?=
 =?us-ascii?Q?JaJhzJsXxGZKPB6kby4RrBI1tooSLalIwBm+S6yayh6HC209C57keju6G10/?=
 =?us-ascii?Q?XnMkwgGrMYLnviA2JB/V7TKGm+42HEksXj5gM5BTBfhWvTmSwitIhrh/xavU?=
 =?us-ascii?Q?hO6J6+w4Chu542vi7O+sDSNc5KvhzZ2cwGcwlO1hL2xud19wEPlFRsn7IBhC?=
 =?us-ascii?Q?AUsPrmq+gNEj66tnfEdzhp8BxvixHS5D+MHqpCpageXrBg4hlv9+UiuszTnt?=
 =?us-ascii?Q?mznb0P5ttACleF766OgOUQZWUH6TIJmf0GCb2KmVN8qkDeRTOBCvH/uJKCEF?=
 =?us-ascii?Q?vp89TnpT6g3v6PLFdQV4tKLcuokGVTE+oTGKDVb3w1e5tLzivT7FZdtq42wo?=
 =?us-ascii?Q?UBwSGhO1gmjGueV13h1USy69FYBnYlvAeVmMNRYafmZ60RLDA3OF9VaOJqH5?=
 =?us-ascii?Q?WklQw2klXYgE/ewJRXB1xMsZ9/HKKi7E1ywMXxmhBSGmc3qVyiHQfGShbTaT?=
 =?us-ascii?Q?KH0M2gNE/28ih69u7sCJF1L1XEXdfp99MdrrtbL/T/5YB1FHCnMHrAegHDxR?=
 =?us-ascii?Q?jx0a+bkckh0VwHA7cPIrbg/0PyyVvvT5x/DPA1NWOWITq7pdZ/eu75k7xenm?=
 =?us-ascii?Q?9NDfZ27KYBESjKkKGDYwq0Nr9PSXhABpDuW3OycJubEtCbQTtoncD7x5wy2r?=
 =?us-ascii?Q?E0gQj+TRbzxFs7soNOIqKzl0z/a4bbLIUJ6JvxhsyS6ZyUG8/8EAQnHTFe8l?=
 =?us-ascii?Q?qzNjf8On8XWQAMCpnZzFnX1OlgX84zKmxUwczjNgPErGwccWOTypBKUot0dG?=
 =?us-ascii?Q?dfnYKSGI8xh32u1ZIArFPUEhxlIKwbBwqsNr9eh4ZQbPDpBdONdUBf1nIHiJ?=
 =?us-ascii?Q?8hSK7eCwknqt6p29uRX5U/ua8CRJYh/gIHbPXuDsdW+JbcmCR5CW8j+EhwcD?=
 =?us-ascii?Q?K+S8Of460dnlZHp55fNEG0E2K9vwLosOk2RnPhKu2dm0imNwd+OLR4ajEYwf?=
 =?us-ascii?Q?q6t12YmJsocqlcMLqyeQv9SPjgkzrS4CvOVeL8ohai5u7EzDKAD6V9bTfSKE?=
 =?us-ascii?Q?HQNwRTEF1Xo+FFX0ZsNLCSl7QUw8DOP72ZimAVqxLobW5JZiwklIcnjBuhVy?=
 =?us-ascii?Q?D+3Llq0gqZRvPerRJW5Wi2zj5Pnmf1JkCaac8bMvlocQJMRNdcU9lygj7afH?=
 =?us-ascii?Q?+i0swOc=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4098.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016)(38070700010);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?f+gokFDPRYgJIUGNYsvYMi3zup83jj0iE9Ot4i64Gk106p2CeomPlSokvMkZ?=
 =?us-ascii?Q?hNasG052nF6bGlZydan8ubQh4x/I4EPWOADeZEda6TEiGWGYeVJd8zxvodTz?=
 =?us-ascii?Q?77WFQuwxEGV5EHjoNtmhRmaqUF37NDQ344K9DlxGG48Pxk4cEYW2I9hGL081?=
 =?us-ascii?Q?oeyoYrQzBh5i5aq0PzPlo3zdizpz0AxDbdYeraFkdymSTDpG5iTLA5byWYV8?=
 =?us-ascii?Q?OkaLksf9rEUuLkFl2MDQQn/Eg6Sa7XbgtaB46takHZez0yQLK7c3Iuxfcv8F?=
 =?us-ascii?Q?GqfQY7LNa2NWNh/qM2cUYDU3jGh7eweNf/KjeAvrJ/4+j23iUp2UT0VBjrMB?=
 =?us-ascii?Q?ZA8mjQnM6bB4JrTtuSapSqP3C6fVHsppX9bhrh3S2e0dzFON3SeP6vq7/PU0?=
 =?us-ascii?Q?Z2Pwx3rUInsqeTBWAw5gpzPUw3/a7yfhsK/EHbBeZu+T5sC377zsC0ltZtov?=
 =?us-ascii?Q?cv9ncpDAUqQ64ku1U7hde9azERh2zW6Cj3SX/qMFE4fndVCUEPwcHpuLOI6S?=
 =?us-ascii?Q?vJd1jUrg5gqDv3z3ClYXi1b97Ny0XMUpm3ovHejFmp5EMLv7wcAp9/EArTsQ?=
 =?us-ascii?Q?lJj3o0rXi5YW8WR57UObuVwfH1IWLXnE0CfCXMZPiS4Z83N5XNzoNa3EZS/i?=
 =?us-ascii?Q?hiY6hL8kWVg+g5HuK3SqnJtadwpil8ioCbFoUEzhSH/S8YrjwMQLGjCrjRRl?=
 =?us-ascii?Q?X9D+eK9Q19vwzuTjgRUOXnTz8D5wfKZoqBO762M/YpLw2Mr3cEFXce8tnacT?=
 =?us-ascii?Q?qz2OpNIFCcFNdiuwIoNTIUEewlGo5xcyav835obIPsW90hFyeod+t7QXs0r8?=
 =?us-ascii?Q?l+ZvraD/I8o4WhgyH9bSgM85K5dG+BwOhByx9bboUlxyVSHNigXanRI0JkVS?=
 =?us-ascii?Q?we8+G/JgaXZ8jbskHZRo+ssKDJPYays/p8zQqf20VmCaxnKfQ1SbpzQQUfvX?=
 =?us-ascii?Q?+ZXDI4rVoORX4PHHxdPsdoW9o6ez64UH/Fxb1f/iyyJ08wpD2DhzS7Hwweu1?=
 =?us-ascii?Q?ezJ8jJ6ta/NIxg5ZtaJ/dQVBbvlPlad3Q3xUzEZTPcTgck5Dt0U5XxEaF/9/?=
 =?us-ascii?Q?3aB/krK9kLF4UrhZpIQgbQYBYUDgMtnfLttta/zqR2DuZUaULIRoU1yC0o8/?=
 =?us-ascii?Q?piSk/2J8ltvMj1bjul0O0e3D0zXw+VV8yE+/CoiBsGYpMTe/QQynIa78XnT6?=
 =?us-ascii?Q?oI43AlZ36RcWfdlYpjU5P3EKQSNalfrVovebYzBed6HUH4DnXI0Bh6q1Vd0e?=
 =?us-ascii?Q?X/cithyACoWIoHptZR09OirSzO1ErL18BW2ePi4hcA3KQtO6Hsn66qVXVE62?=
 =?us-ascii?Q?WwoYob9sXeNteKnGeZvhCZO5XKrc2+UvTREa9+4413tHNr9hKBv/6vhd+qwx?=
 =?us-ascii?Q?ghEiQXo1dwdpYmuQ8H/4MIuttm0b6WqcME28FHXteUmjLdCJCnJ4PtR9Q0Wc?=
 =?us-ascii?Q?HE4zdwN1eKTOxUfntk5RDQlr1lccFab7KOPshq9F2zW/nubp5JSrRg4meCv3?=
 =?us-ascii?Q?Hdrb6aegofHfp6srv2+B7oePM9QimpLKLWiHThOf8gaJYVAkx4qKbT3s33oB?=
 =?us-ascii?Q?Um20nH98hUHVLD3fx5qGE+li8a+GqgWW73tzLxYH?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f8fe99c7-ab5f-4dea-ccd5-08dc8a62328e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 22:02:33.9123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yT4dLayYJ3xvwiP1StfAzM9GX4WokSvWs+Fkasri1sqsiBWQPknQ0miqQvo0/L0utL0S50ApVRgOLM0SFzveqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR18MB4149
X-Proofpoint-GUID: GQnPyGOK_ms24oecs_eNDTivaEeUBI45
X-Proofpoint-ORIG-GUID: GQnPyGOK_ms24oecs_eNDTivaEeUBI45
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_11,2024-06-11_01,2024-05-17_01

Hi

>=20
> > +static int cdns_xspi_prepare_generic(int cs, const void *dout, int
> > +len, int glue, u32 *cmd_regs) {
> > +	u8 *data =3D (u8 *)dout;
> > +	int i;
> > +	int data_counter =3D 0;
> > +
> > +	memset(cmd_regs, 0x00, 6*4);
>=20
> The magic numbers here aren't great...

That will be fixed.

>=20
> > +static unsigned char reverse_bits(unsigned char num) {
> > +	unsigned int count =3D sizeof(num) * 8 - 1;
> > +	unsigned int reverse_num =3D num;
> > +
> > +	num >>=3D 1;
> > +	while (num) {
> > +		reverse_num <<=3D 1;
> > +		reverse_num |=3D num & 1;
> > +		num >>=3D 1;
> > +		count--;
> > +	}
> > +	reverse_num <<=3D count;
> > +	return reverse_num;
> > +}
>=20
> I can't help but think there ought to be a helper for this though I can't
> think what it is off the top of my head.  If there isn't it probably make=
s
> sense to add this as one.
>=20
> > +	/* Enable xfer state machine */
> > +	if (!cdns_xspi->xfer_in_progress) {
> > +		u32 xfer_control =3D readl(cdns_xspi->xferbase +
> > +MRVL_XFER_FUNC_CTRL);
> > +
> > +		cdns_xspi->current_xfer_qword =3D 0;
> > +		cdns_xspi->xfer_in_progress =3D true;
> > +		xfer_control |=3D (MRVL_XFER_RECEIVE_ENABLE |
> > +				 MRVL_XFER_CLK_CAPTURE_POL |
> > +				 MRVL_XFER_FUNC_START |
> > +				 MRVL_XFER_SOFT_RESET |
> > +				 FIELD_PREP(MRVL_XFER_CS_N_HOLD, (1 << cs)));
> > +		xfer_control &=3D ~(MRVL_XFER_FUNC_ENABLE |
> MRVL_XFER_CLK_DRIVE_POL);
> > +		writel(xfer_control, cdns_xspi->xferbase +
> MRVL_XFER_FUNC_CTRL);
> > +	}
>=20
> Could this just be a prepare_transfer_hardware() and we could just use
> transfer_one()?

I have to run some experiments, but it should be possible.

>=20
> > +	list_for_each_entry(t, &m->transfers, transfer_list) {
> > +		u8 *txd =3D (u8 *) t->tx_buf;
> > +		u8 *rxd =3D (u8 *) t->rx_buf;
> > +		u8 data[10];
> > +		u32 cmd_regs[6];
> > +
> > +		if (!txd)
> > +			txd =3D data;
> > +
> > +		cdns_xspi->in_buffer =3D txd + 1;
> > +		cdns_xspi->out_buffer =3D txd + 1;
>=20
> Oh?

You are asking about that 1 byte offset? It is caused by way that
SDMA is handled in that specific case - all data except of first
byte is transferred via SDMA, the first byte is send in command, and
SDMA is not involved in that.

Regards
Witek

