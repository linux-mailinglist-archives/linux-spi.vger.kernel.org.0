Return-Path: <linux-spi+bounces-3097-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA2C8CFB59
	for <lists+linux-spi@lfdr.de>; Mon, 27 May 2024 10:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81514281469
	for <lists+linux-spi@lfdr.de>; Mon, 27 May 2024 08:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0274960269;
	Mon, 27 May 2024 08:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="k+/G7BlY"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D68456477;
	Mon, 27 May 2024 08:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716798374; cv=fail; b=SNsRF83RWkJIcbFa1Nen1QN61l/iVo83bgMgtvxVjfd58JJBhQrC3weZ/8bnnb8i0HbF01Xzj58rvDc43Lko9GeISTdB6lMCtS66QRUIFiQnX/Bf2YeRHNBMl6Vz6BUeDyu2xdkwiTEWSsOqeiW12Ig1Vb4I8XF0BeQ5R5eKz1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716798374; c=relaxed/simple;
	bh=SGbNiCbOVYuUZ8saPMWBOW5sL2wbs2mlAxoeFW3gJag=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bkaKdTYvaMxf23VEDWqdM9uJZ+9iMG7dhBwcxDWAL2bSLSsIWK8zLoK52UAVk51AsTI7Cn4FitWWg888+xEKbOnO+sbr9Vif1tiwHRRjva09rtL6As6x1cuLQbWHIwBh+TNw1mCRWLyuG/U01w8eZ+ne+IbYcMwa+yM62PnlYhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=k+/G7BlY; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44R5fikh027960;
	Mon, 27 May 2024 01:26:08 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ycm8grhue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 01:26:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2xDbcmtDnOKMScUUubSIUFgg9vBMTgIKdv1yrEvgu3eHf52Lb9jzxjmX6knph0MsbBtaYz0372/x+GZBNW9rDxkV5xsPna/qakIYI3kh+rDoS/QN/xQwTrjppjEcg9W+2LMUqhfdo6u78sVcZzZCF2m3cuzoPkGG/pvVYmgI8bQaYk0yYE0+nE8lKE8IRg5ETK+LKPvvL0jbG/l0L8Uml2541vPrQgLtMnChnNUxibgTIgF0uE6ZX1cdcF4mxAs2K3mXOuvKhfZ4m5k3uPKTsC5WQi8AeM4dPLo6E10fB1/si6dqrvZ0gvVTB77NqnLpW6c2lBLc7LW/4+5pF5lTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z45CiMJnsYiYgH5ctZmWkBqH59TvA3pOWcUeUriRCVM=;
 b=SFK4zW0BluBBjwExDWRnKR8dGLVrh3B4TRG80yfL9QPgHg7lParLQPS/DuXuDvQ3drciohmQoJdFreW3XeFi30tBf2aAGjEVTJ3OMZyaA/7vEmiENELynbV6qxaKGpcs+9QAojqGWSeouNWv/4Mt1TgKsHJ1UDNVSUgIsSJTe/xxDnMc5wTxo6qGrMHTieYm+/RnwV8goTnyY1yNBVdT/1gXtm7m2KN3vRfapOnJqLGjlBpBJJBV1XrEQVkvjgryy0X8jVH1tNVyPX+h8ZuvqiyUaXayj+xvwHRvibMglCczw5Lw/5rDXcSAfjAlVUMikeJoiHh+9rFyBVL40cbprQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z45CiMJnsYiYgH5ctZmWkBqH59TvA3pOWcUeUriRCVM=;
 b=k+/G7BlYD6ulQWYfOcBFyqwWJ2KYUWFZTZX0AI8a/K+yqS3Q+1C4ITgGmvY33kLfkeGJITHL9IBGU+AfhmCHZwSWxXoDqdwykanJze8mfPopMV8skxnHwTaCJr6NwtGtaaIy9hKB9/h7aEMouEWeTOKaJoBH3aki3Mimhy/OGI4=
Received: from CO6PR18MB4098.namprd18.prod.outlook.com (2603:10b6:5:34b::5) by
 CH4PR18MB6269.namprd18.prod.outlook.com (2603:10b6:610:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Mon, 27 May
 2024 08:26:06 +0000
Received: from CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1]) by CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 08:26:06 +0000
From: Witold Sadowski <wsadowski@marvell.com>
To: Conor Dooley <conor@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh@kernel.org"
	<robh@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "pthombar@cadence.com" <pthombar@cadence.com>
Subject: RE: [EXTERNAL] Re: [PATCH v4 2/5] dt-bindings: spi: cadence: Add MRVL
 overlay bindings documentation for Cadence XSPI
Thread-Topic: [EXTERNAL] Re: [PATCH v4 2/5] dt-bindings: spi: cadence: Add
 MRVL overlay bindings documentation for Cadence XSPI
Thread-Index: AQHaoa0LF2icoBWcPku2cJNyboeMIrGPJ4WAgBuz59A=
Date: Mon, 27 May 2024 08:26:06 +0000
Message-ID: 
 <CO6PR18MB4098338A6C600E5A8E8AF1F0B0F02@CO6PR18MB4098.namprd18.prod.outlook.com>
References: <20240509010523.3152264-1-wsadowski@marvell.com>
 <20240509010523.3152264-3-wsadowski@marvell.com>
 <20240509-hurried-canned-3ceac439b93d@spud>
In-Reply-To: <20240509-hurried-canned-3ceac439b93d@spud>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4098:EE_|CH4PR18MB6269:EE_
x-ms-office365-filtering-correlation-id: e2006348-84c9-49ce-1f53-08dc7e26a784
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?0nHhVyyjn+Eh/2VexvAT3oxwrCPbLeemwqe3ZatDse1Z3MSojfT7O6mfUt4b?=
 =?us-ascii?Q?bWFd3CjFH0GpPZJKUEO9DYFI+aoUjlu39XtAGu8kWIttSUgsrF4oyVHOcGrK?=
 =?us-ascii?Q?HeCnvt0HKqnID47c2lUs5xJP+5Zc+6LLpONPhkeNEKJnzi952t9Itl1XddNp?=
 =?us-ascii?Q?PGDjaWO84KGqzOxHEfC4H/JRUbx8JOd7/qlaJ9F8F2kd6VyjCZdkj7uO1EQ/?=
 =?us-ascii?Q?/qS7SwN+8ELUrrK4l3d8bWaIPD9vfy5jhBwZoERJxI4XEKN5uVpLsG41rMEH?=
 =?us-ascii?Q?FygSHu4hGotmahpbonnlVScwZJxl9CR1LKocrsXnHTgDOdtLseJrRvrVEyHR?=
 =?us-ascii?Q?K7ijUhMmnDyZKC0PzNs14RU14Ez0kuk9uzI+JsuMMUYMlieRrImJnQHSvMZg?=
 =?us-ascii?Q?1enX//RlR0RLEQPjVkfV8219JRuwTyzU/ZQpzSb7vfI2UAaV/q4tEF+NXRab?=
 =?us-ascii?Q?fVRIiQ9sxkO1ZS1YkeUPSPVAd3Chb4ycDT1zWwz8qzWJTQKMxh00OaVGJwyK?=
 =?us-ascii?Q?+XFpaXdrQlk4Cy5lhtRwJhB/4wEyg2xIBYIOZjAgj7s8TO0NPhbKEAK9CLIG?=
 =?us-ascii?Q?/zp+IeW89Q9Df+zm4xpbMwZZLa0YYUKfClUM3bDt27Kr3m08+lWQhLu7wiMv?=
 =?us-ascii?Q?laRcQey5rHKHKzEqVsYQ1Yjhv7Nqk/2ip2Vx9Mtmv09tAvzn0iSVtMDbdTSx?=
 =?us-ascii?Q?4HGks0jMMaXdcH0BBm50bOpB6OdQ6dXGPotMs5s0j31h6OgTwhRkcnGDMAWZ?=
 =?us-ascii?Q?FU8iTBaD1jbiIkeiKs52L1l+SzQcd0ZkA1Jch6iZmRGUR0Ur/Ow8xe2QxJN4?=
 =?us-ascii?Q?I4pNmtCZdzWWFP0FKOmzF4nWuKkszGFayv5F5/uZvrsXrRy7pugunphLaLce?=
 =?us-ascii?Q?im8HZM0IiaRaCsTXEM+3s8bk9h/bBN2EMBog1MswgdireyMpPqJdMjImhyIB?=
 =?us-ascii?Q?qZcTpF7hTC0aChrMJXjC3yG+u9PvQGlKr0MiJtEP6TzZJKDay3dI3aUc1II0?=
 =?us-ascii?Q?zYlB9RvTjZXOX1lPutXD84TQ81qYHWjB94qFuDp2x00C9gHcHWDkSYsTa/lD?=
 =?us-ascii?Q?bUQ4po4WiBHmtH6XfrpELln8+4dVV2iqsdC7dR8My0yK+tguBQaLn7jOUnBA?=
 =?us-ascii?Q?RTSuMa3bxlCIeMI8E5stCY+AIYytuiT1CMLrFEMcgB+gNLDJTKtTravofdzq?=
 =?us-ascii?Q?DyZSW5ONOFgQcDCxmR+iBo6+DAevftigjChTulHyj/Q/ztji7aIBXZDv9LtO?=
 =?us-ascii?Q?HlkKCXnM6vtdVUSjnm+RFNYO1b57+danZfUHyElifGaWsWJ9vANsZQfbys1w?=
 =?us-ascii?Q?nkUl3tYJFA1Fi/8tQFSCQwG3SIzo2XYTagjlr/Pb67Cu1A=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4098.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?XY6PedVPtjhb0TSUJz19mq9TRuTBKrScSvA6czVuKjYRXIHtOpDOs4NWdjA8?=
 =?us-ascii?Q?xnQ8AtWx/n6MC4CSZ9Ah9VL+bK640xwXPzVL30S265esqLqGMmtfIOpaRORI?=
 =?us-ascii?Q?lbOFl6QEahMTMVXpBcS5kcpI64bVwMPmf3fxAk+dRSt9ej6C2Jsq3E2w6Tfi?=
 =?us-ascii?Q?kR4V3V8mvroFX+XqSjnO57xjt/4poDqXYJAJc1kaNEJK2Rthh0cFvLg7sLDR?=
 =?us-ascii?Q?zChSR2l6xhYz26tv8iHDowJWd2au82hYUUEa08sjn015DZf7tAX+Ld8f+v6/?=
 =?us-ascii?Q?CckM4CVLShj12LEhIq2brZSnm2OBeFlOOAGmXkQOdogi6kASw/PHIwGJtsih?=
 =?us-ascii?Q?OwJcyGJ2NqWqfRsaZ0NFiQJhH0b+5NFzmwUNg8rkzy00siTccLBWMmD1+DLg?=
 =?us-ascii?Q?p8gmweh48C6mljnfNngE81TsceAOA3Jy884w46r7NvrphULzMr5MXkWKHIgq?=
 =?us-ascii?Q?WKjDcwCzGJS1gQoXTpwHCXm1F0Ms03RkE12hZYR06sF6d0gpxoiRRnXZ24XV?=
 =?us-ascii?Q?IV9qtwqkrjxfWu5gkPiDBOk2swd2IuUXbpLsI3y2uIN1fZBL3ewKFmmsl6VO?=
 =?us-ascii?Q?2fdRjhSkqJ0lpVhmI1PtjxTRvedYVnAQhLXziuzV53T85sQVYTuDUlmaSPQ3?=
 =?us-ascii?Q?Ws/fn0+qbkhSwUXfmhG97+hKFl8KBJ4DCYz4Q4AEUQH3Nw8uC/CzkpeQLFQn?=
 =?us-ascii?Q?1llDs4Y8UKem03QW28bkcma0LC93pK1rwxu0oMq0jMucymjKFThBXI6/bLAA?=
 =?us-ascii?Q?FCS46Sqg6N4qrTnxLLYsT7zouEXSPT+uyoCACxzScBdCS2uesL+gwebZtSZY?=
 =?us-ascii?Q?DaTYuh7PVfFzZlhhS9L46EjwtToz7rrNvE7rZWKHkQ6h/BazEbVxjtp5nCWz?=
 =?us-ascii?Q?2W7TB8bhUBVvr7/F7OiOG35+ec565DveJfSpwM0skd0Ncz1/lMElJ3GseJly?=
 =?us-ascii?Q?u+RW/mF6mYpVJ6dBezNozdug63lx7I0Gk0aq7SAScIr6dmg8wMDOttwdmXXT?=
 =?us-ascii?Q?V0v3cT9fi3Bj37jbKb+RzBebUfW0xVFa5ElwWdiXLqhr2wzYTwenF8mxuhep?=
 =?us-ascii?Q?pIbrNvRlu6LCwhav+nRL2yQsWEfjXn/014vH4KFRs7Zdn7ksWRzgDs2SaEaV?=
 =?us-ascii?Q?zrKD8qxqr89MMu7FN8KZrp1bvPmb4zDF/3EwlpM1rnGjzIDJVZppjWl0+ElZ?=
 =?us-ascii?Q?6WCYH5a+HjokpZqHK1eDLPlvH53+cC8f5AQwq3jAyCH/JVq4N+e/7sI7r5LA?=
 =?us-ascii?Q?g5rXp98gDDaasRF2qw/2kuTbq1YXtkqRAWCK95CrJZAPivV40dmefqgzhT40?=
 =?us-ascii?Q?CHHMY2ZlcDAl/O+kEkmY5ACgXot81KiFRCSxHIX6azPSdNers3TP2rSwaGeJ?=
 =?us-ascii?Q?0gDTEoDDIGmXOrssE0n5nWHoqbwPBs7a3vft9yalIW94iAIYNm9KLIAEWA7P?=
 =?us-ascii?Q?qn4GTUpsAIkZkSipEFoFQVFLmRwD8IolY6nquRPlqI5/CZ/qn41xGP/zKFul?=
 =?us-ascii?Q?5zVOpHtyPE4QwQoI2ODA8+BdO/kHtuI9KaNbG4R4UwxfolNT9FUgbbrA9keG?=
 =?us-ascii?Q?aQoBDTuZt5wHzI/B4Ub+UQJAjWdJqQ5wHKL6IHm7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e2006348-84c9-49ce-1f53-08dc7e26a784
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2024 08:26:06.3455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gf98mCN5HZisPFwBIkHnCvW6gX0KIEJdYIeBv5L3QKXJtFK/U5U7eEhre8u7vAALvQ7kGelfcDNgSsCh3HsrYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR18MB6269
X-Proofpoint-GUID: dBf2BG9F9qGzxcRcbkNpoGQLdPQpacTN
X-Proofpoint-ORIG-GUID: dBf2BG9F9qGzxcRcbkNpoGQLdPQpacTN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01

> ----------------------------------------------------------------------
> Hey Witold,
>=20
> On Wed, May 08, 2024 at 06:05:20PM -0700, Witold Sadowski wrote:
>=20
> >  allOf:
> >    - $ref: spi-controller.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: marvell,cn10-xspi-nor
> > +    then:
> > +      properties:
> > +        reg-names:
> > +          items:
> > +            - const: io
> > +            - const: sdma
> > +            - const: aux
> > +            - const: xferbase
> > +        reg:
> > +          items:
> > +            - description: address and length of the controller
> register set
> > +            - description: address and length of the Slave DMA data
> port
> > +            - description: address and length of the auxiliary
> registers
> > +            - description: address and length of the xfer registers
> > +    else:
> > +      properties:
> > +        reg-names:
> > +          items:
> > +            - const: io
> > +            - const: sdma
> > +            - const: aux
> > +        reg:
> > +          items:
> > +            - description: address and length of the controller
> register set
> > +            - description: address and length of the Slave DMA data
> port
> > +            - description: address and length of the auxiliary
> > + registers
>=20
> The usual approach here is to define the loosest possible constraints at
> the top level, so unconditionally define the xfer register region, and
> then constrain things based on compatible. In this case, you can set
> minItems to 3 unconditionally and then do (in psuedocode):
> if:
>   marvell
> then:
>   reg:
>     minitems: 4
> else
>   reg:
>     maxItems: 3
>=20
> Additionally, when the allOf: is more then just references to other
> documents, it should be moved below the required list.

Thanks for hints.
Yaml file will be reworked to match guideliness

>=20
> Thanks,
> Conor.

Regards
Witek

