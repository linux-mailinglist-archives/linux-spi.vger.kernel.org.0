Return-Path: <linux-spi+bounces-3376-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F2890466C
	for <lists+linux-spi@lfdr.de>; Tue, 11 Jun 2024 23:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A593AB21C90
	for <lists+linux-spi@lfdr.de>; Tue, 11 Jun 2024 21:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A2869DF7;
	Tue, 11 Jun 2024 21:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="OrXkl80s"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AF33A8E4;
	Tue, 11 Jun 2024 21:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718142751; cv=fail; b=XoKrfiL3Pfx0s8R9NYHrqNLnJGKn4jmwUBlp3OvaNjHYTSnYyX66GxlWV15EOh/nhORcGOBqSknSBEC0UCI21pwee7c86yFG1wCriwKmj0L2MP0+UnclydLLf3s6rnZDe3211Q6xnQxPnX/VyNqis8mVXl9cLcAiklH8TuRS5q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718142751; c=relaxed/simple;
	bh=I2wLcrlx1fmJczRMP3pTp9ivXzdx/ltmsh9rlCa2vxA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xk3LaTp7sYwfpHxlZxWFeJfB+orVF1+GsmHF6FLulmI3rJm3YPouLxKygJO4K+ShnBCE+v7Q1TNJ+HWD9Oo2HXExBorIFhzF5C0iovGsEu7Fk+KZr8Z3GNxYJuz2kdkJc8UWONQ2exq2oIdgUWpfE0JlqCf62BOHBFmv/4Nw12Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=OrXkl80s; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BH7UHS002547;
	Tue, 11 Jun 2024 14:52:18 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3yptq3h62x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 14:52:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kz+ghB3LKhzSf55g/waUKD896uwLdhZIphPwh6FY7uQPO5o2rQnRMAvwFohfYjOuu8GB8/8Trmf46QRmfNcrgd/SEITib1oFV6rV8W4EVBu/07U6itfVWngQz4mg3Dr0w9Fu5z3KQLns18M0YNpeg8h6gUfUWy/TF4r2d7Ow20v1jtX9gCYQlqZIJtbqdqUTnIDAGJ3C/LQRtG5pEJUJRDlTe//rrq67K/vDyuKESyhzMu/Rwuea685VltW8lg0dlcyghSGzJP2BJZZA5QOP8PtrPOwkqv2bVBE62y6rfaZS6qDeZsyivZynmBBiv4rPonvS+JDUy+4V1v2KFK+bMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPYMRTtWEWW0eqjBXNXKWRY9LGrq5Be4UfWGvgTZhCo=;
 b=ZaxJG/wMHJIXMiBbhPyZmq9AFgrMPOqsIMSEW+bDdDw0nZDfa4WGR9aoxU7JWFu07SGPucF+yEVRpxjKG7JAD5DeZRHMqs05eqEtqpDcpl3hZ9fO8f4ogHltMDxnVciWo9OWbJYCoXHcqLY+MAvq8WREix+LZW+KxjJi6JzbVP7OwvZmMRU44vbQFafawl0e1CRP9qDaPMnoJCeLd50tLvfeiaicv/jzuAm5329J1RSPK7+Zv5XWCkbutfMr9cQ6ZGwuBjmcooK23VBc+vsVv61OnSTMBPJg2CRpwRlqB4x7Sf0q3zlH2pg+SiNpJ6tsbiLbbXjYXKiSeZxloHNRZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPYMRTtWEWW0eqjBXNXKWRY9LGrq5Be4UfWGvgTZhCo=;
 b=OrXkl80sIALlTvCWYhk7UT/ulkXgDK975z83QjjgRz4S6mo32VYj4SOB//YiL1BqidCf/2k3o6Yx0jLuZl5Y1Da98BxJ/hvQpDMIiwpGu5G+bgl4ZPSwC2tkssU+yImJKtI6t92vUzIbo/Uvhg/ll20OX4gmdJP50vtwqIk3skQ=
Received: from CO6PR18MB4098.namprd18.prod.outlook.com (2603:10b6:5:34b::5) by
 PH0PR18MB4457.namprd18.prod.outlook.com (2603:10b6:510:ef::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.37; Tue, 11 Jun 2024 21:51:58 +0000
Received: from CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1]) by CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1%3]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 21:51:58 +0000
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
Subject: RE: [EXTERNAL] Re: [PATCH v8 2/4] spi: cadence: Add Marvell xSPI IP
 overlay changes
Thread-Topic: [EXTERNAL] Re: [PATCH v8 2/4] spi: cadence: Add Marvell xSPI IP
 overlay changes
Thread-Index: AQHauO35xUH3Zn/k1UOJaBN7iNN9L7HBLaqAgAHtIRA=
Date: Tue, 11 Jun 2024 21:51:58 +0000
Message-ID: 
 <CO6PR18MB4098E3DEF64621FB147BC345B0C72@CO6PR18MB4098.namprd18.prod.outlook.com>
References: <20240607151831.3858304-1-wsadowski@marvell.com>
 <20240607151831.3858304-3-wsadowski@marvell.com>
 <Zmcj3fZ4DF8r_qf0@finisterre.sirena.org.uk>
In-Reply-To: <Zmcj3fZ4DF8r_qf0@finisterre.sirena.org.uk>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4098:EE_|PH0PR18MB4457:EE_
x-ms-office365-filtering-correlation-id: 41807f58-c6d4-45d7-6d4c-08dc8a60b7ca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230032|376006|366008|1800799016|38070700010;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?zjaI/acnWxV6lpDOQtKDLm4LUmuKxB121mE9DfxFH3CnJx6CR3pRsq3Jj5MF?=
 =?us-ascii?Q?n/L1f34WSab7A/4v0yc99/FN/ahHqZCuGKNDUudA96QbXMWcV5qO3u8Usowd?=
 =?us-ascii?Q?/bC4yEpBswv6VMd7deOcFEyYdNZbvePpoimNGSBw1yyo2MuyI3JKB/kEyHQW?=
 =?us-ascii?Q?z2GhpOD/D8wkYFz29hPOvq+Wc0WdPa4SMuw1G2bId2McD2ClxKcBZ0kT1Ezw?=
 =?us-ascii?Q?57lMsMM15VRNfFxNlM90oRVI8cw7Zxb7Qfx4eUAR2pZtXRCl8+d6Pi0Ywg02?=
 =?us-ascii?Q?LwxfwRGgVf3EoDyckNUNMY1aelKFzKBxj07Llp2NeHHQAggKzmyFngb3e/IF?=
 =?us-ascii?Q?dqAc+qACX4JVy0SXNPF0KATjPZEdZ7c9Depf5/1HQcSxyaFw8q6WhRvblyAJ?=
 =?us-ascii?Q?kCh/6R3N44n03tZHFw2GtT0aeVDouvGtL1/WmwQGdM95PRpz7B3LZr59vlJG?=
 =?us-ascii?Q?m3o2h/4IwFrx9tyg3lHECwGETd6H8RJDwUhIninLiq7pMmrknoT6Jv4+BqeT?=
 =?us-ascii?Q?I1/fn4nIjdAKRDCscXPMaQPqXsvVVex/cj5L3qilOOs0x3vo5lSKjkuMObGb?=
 =?us-ascii?Q?xjO4PSih5Zq2+Ce560wAtdLHDbbDK+o9XTzwTDIZg+iwIkPsmdCC+g2lfbkj?=
 =?us-ascii?Q?GJG+E56Jj0zFjDk2fxA2Nu7Iw9ke+3UE6XJ80GMMaYThEnhdn/NjCoXUOJne?=
 =?us-ascii?Q?ZGjF/bYvgm97DNlwFTsBwqiL6qd1bW1XLulePPXPUXNgtnr/RbYeequ7wGCu?=
 =?us-ascii?Q?pyofqC1guoD/XUXo/du6Mmm94jUyn2QHtQWzj6iSl0vMQulEheVFz/Q9vRV7?=
 =?us-ascii?Q?Ar+nX5vRSvYWaDfb8rDq+ouD87sExFunc1ZOscMR1xKIToCi2X8ww+n5npWb?=
 =?us-ascii?Q?RJVUFWJaJETpECwPVlPe/OllNz+uzwEIGNkgjqIxytIG1vFnwK0Hq0VmdIei?=
 =?us-ascii?Q?GvTGkM6wQeptRUuVcry9D2AeqszK+X2Cg6mcc4CVsAorLNQS71+NZUDYJaEN?=
 =?us-ascii?Q?fv0UJif84uGx7ezO/hH/6PNlznXiuZPAMlbG3IrBFRqXqg+dsKV1SdVodRis?=
 =?us-ascii?Q?AA1dUEikfeWo7m5bYJSrrnGp531rkkcTXpWlvY8WQoBGRG+eC29NEnQJZsvH?=
 =?us-ascii?Q?/MPb7Cnd/bsw5Lqo23my3QBZbMXhzMm9liLjoZrbgjEtreRvIottozknEgdQ?=
 =?us-ascii?Q?jbLOxkFqBDzTJCzuEbGkvWnFliG/KFnYVuqOSFMV759aSVHAVRpyNdOzCvDI?=
 =?us-ascii?Q?yvDa6+zhxfawEJlgUNdsx9FKzs9S/hD+q+jXEGrlzhLz5z/R4j6Pw2qUmXAl?=
 =?us-ascii?Q?6Y+JiUL/8VIAFXfLxh5rhJCHeLmis31wz/Kc8YkOpdBKaf7kuTQDCMVnXitw?=
 =?us-ascii?Q?nY87uLM=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4098.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016)(38070700010);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?O/3iPUWvSIw+Q9ZucugWBPTYqkm/TgU+n1LMLCjBFrN4yjCBIC/irk77NZIo?=
 =?us-ascii?Q?7SSGvsORgXe6ussfb2WoDuhKgoFcma+NyUa8RrX+GiNirBX8DfNKDg8V8Ods?=
 =?us-ascii?Q?s4pIKLP62+TvYfANx1o1kecm6SVeS1CtzbhAWvAFBztcn+/i8yKVjGydnVRf?=
 =?us-ascii?Q?hfoi4ER6XIQgNMWC9Gg2EL7xRz4Q+dCeynDxgv4V27ZT20X5MRE/1B/EO0Ve?=
 =?us-ascii?Q?OHXWCzeR/c1F4Qpz7Hi3ralCRZ5KSMcG6HJmYZAnNnt7a3AMfgWAYlf7xium?=
 =?us-ascii?Q?be0mwNLhXwknCoF5xvPOOPw9uisIRV55jr9B2B9W52Sdcztgo06NB3Nyh4X4?=
 =?us-ascii?Q?xbrB1QpMsAG0obO1LUFAqbU/R0D7WO6lTKZ1a0PdmxqsTOXUL4Rot/UZgjJi?=
 =?us-ascii?Q?8sdR1q8OtUkMMST5UzXRjwZORHXdr1FxQ0rJsBPuKKAXV7hzSrI2i/wAbiZb?=
 =?us-ascii?Q?zECSMzw7ldVMOtvbx4mxn3bKJnbypYS4touFpxG8b8hk1DQyFHVwFq0h2p0J?=
 =?us-ascii?Q?yxPXQcdbE1xnO5xpb2gkAuAWBT2hQ9Zi/tK2UI5nLtCkDe8MxFw9zDP3Ekz9?=
 =?us-ascii?Q?SRDzK/GHDohkSoxek01nig2TjXweXwdP9N/YhhZCXxgQrqJ9kcNJgFCKpAns?=
 =?us-ascii?Q?rTtX9KS0oi6HPe9zHiYsaUH7DZdsF9L7aN3HyrTdSD8mbKXWmPhl8a5JjSBa?=
 =?us-ascii?Q?UnDltGBc99iWAW4QIaPLdRTw8Ap6CIAW9dnUdpz9t9y+ha9KGO1mHwiM6rrI?=
 =?us-ascii?Q?j3b79aIwfsazC8+jMLv8/ZprYZyqvWW+CMkUJ6ALCqtQLp+60t08IER21aow?=
 =?us-ascii?Q?bp/vId53MJtOaLBRgEQXNGSAB2yMHGH5gzQg8X/Ejc8N2/FZZD9+RIcF2JSa?=
 =?us-ascii?Q?06gEgxzhU0N0g0pOuAC8sNPafinD0vyuspsuehMufYT/dvpVgcgr+pW/O5NA?=
 =?us-ascii?Q?PIMlpVe0sgNg1wKpEBk7CsPOee/hSS52O/1XcuRFsMd5mMneriq3yzLfvsX9?=
 =?us-ascii?Q?mYymJSXdhXn1T8AgZSfZGLPeSbyEA8f35PILkpZ6ZsH52lG7znGzecpDvUQv?=
 =?us-ascii?Q?VX6mlPhFM8j7TfrMGCI6yIFLQ18KCtQg8lzoNZWkwsxesbe8/Yy3W2b/qWpN?=
 =?us-ascii?Q?2WaXosJ5k09ZV7oRcDZ2PZBwTnC18Dv+6NReVAHwM/89heQgssab0ZxC4Di2?=
 =?us-ascii?Q?Yewa0TsGIiXdgFCkufBYA/sFrNJpa4NNrjQLdMD7/G2gR7QdYZSK/8nblsJt?=
 =?us-ascii?Q?+Rvkl6QfvFzNSXVkMLiN5BmLH0gdzho1A4X+t1Pywxj/vRIlgYkLHWH5IsJ0?=
 =?us-ascii?Q?cbgpGPFRWTGZ1Vtvb3XiPliCWtlxNNYE5RaL/MHw6shBxjk7g/VoPaefzPJE?=
 =?us-ascii?Q?M1D79pQHohIUSq/MSNx1HAzItY3CWoUTszxn9VUBxegpsdvR56MHF0ULuZ7U?=
 =?us-ascii?Q?LHO2GbnD1sEuG83YvHjc3aq3DAHZFDq2vicT0VcMUG3rieEFLxC7nAZY/XD+?=
 =?us-ascii?Q?g5wJQaO1xbehEH9O/XyhUqZ6vLAgcBZ1KpjsjeLQuME+ysksSd3NgvZz+Ggy?=
 =?us-ascii?Q?qR40qlReEerIxEicTHJo71vTWtMTRA/dAKqBbr2x?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 41807f58-c6d4-45d7-6d4c-08dc8a60b7ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 21:51:58.4226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PHMoJZ/sP2CTWgNjDuvaFMdBuR2Q9CYXLuR8mMyhkkZj4QHhv6rRub8rL9kQB5OOGg0qy2aY9ab38B8KOOciXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4457
X-Proofpoint-GUID: gFL96voD7RpI_4zrm8fWXWSa_Pi9JdF4
X-Proofpoint-ORIG-GUID: gFL96voD7RpI_4zrm8fWXWSa_Pi9JdF4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_11,2024-06-11_01,2024-05-17_01

Hi

> On Fri, Jun 07, 2024 at 08:18:29AM -0700, Witold Sadowski wrote:
> > This commit adds support for the basic v2 Marvell overlay block. Key
> > features included are:
> >     - Clock configuration
> >     - PHY configuration
> >     - Interrupt configuration (enabling)
>=20
> This feels like it could usefully be split up so these three bits are
> separate, and there appear to be other changes buried in here as well.
> I can't tell what changes either the PHY or interrupt configuration might
> be referencing.

That changes are in single commit as, using not all of them will result in
total xSPI failure. Configuring PHY makes no sense if clock is not enabled.
But I can try to split that into 3 separate commits.

>=20
> > @@ -295,6 +450,10 @@ static void cdns_xspi_set_interrupts(struct
> cdns_xspi_dev *cdns_xspi,
> >  				     bool enabled)
> >  {
> >  	u32 intr_enable;
> > +	u32 irq_status;
> > +
> > +	irq_status =3D readl(cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
> > +	writel(irq_status, cdns_xspi->iobase + CDNS_XSPI_INTR_STATUS_REG);
> >
> >  	intr_enable =3D readl(cdns_xspi->iobase + CDNS_XSPI_INTR_ENABLE_REG);
> >  	if (enabled)
>=20
> This seems like a separate change which applies to everything, not just
> Marvell versions of the IP, and should be split out and explained.

I will move that to separate commit too. It is possible that previous
stage will not clear that register correctly, and that will lead to
interrupt fail - at least in Marvell implementation.

>=20
> > @@ -319,6 +478,9 @@ static int cdns_xspi_controller_init(struct
> cdns_xspi_dev *cdns_xspi)
> >  		return -EIO;
> >  	}
> >
> > +	writel(FIELD_PREP(CDNS_XSPI_CTRL_WORK_MODE,
> CDNS_XSPI_WORK_MODE_STIG),
> > +	       cdns_xspi->iobase + CDNS_XSPI_CTRL_CONFIG_REG);
> > +
>=20
> This wasn't clearly mentioned in the changelog and is again being done
> unconditionally for all instances of the IP, probably best to split out
> and explain.

Ok, I can move to separate commit too.=20

>=20
> > +static void mrvl_ioreadq(void __iomem  *addr, void *buf, int len) {
> > +	int i =3D 0;
> > +	int rcount =3D len / 8;
> > +	int rcount_nf =3D len % 8;
> > +	uint64_t tmp;
> > +	uint64_t *buf64 =3D (uint64_t *)buf;
>=20
> Any need to cast away from void * indicates a problem.

I will check that, but code is checking alignment of that pointer.

>=20
> > @@ -337,13 +563,11 @@ static void cdns_xspi_sdma_handle(struct
> > cdns_xspi_dev *cdns_xspi)
> >
> >  	switch (sdma_dir) {
> >  	case CDNS_XSPI_SDMA_DIR_READ:
> > -		ioread8_rep(cdns_xspi->sdmabase,
> > -			    cdns_xspi->in_buffer, sdma_size);
> > +		cdns_xspi_sdma_memread(cdns_xspi, sdma_size);
> >  		break;
>=20
> It's feeling like it might make sense to have an ops structure rather tha=
n
> sprinkling checks for the Marvell overlay everywhere.

Won't it cause big code duplication? There are some differences, but whole
Part of SPI stig mode configuration is the same.

Regards
Witek

