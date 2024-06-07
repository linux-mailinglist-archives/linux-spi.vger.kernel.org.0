Return-Path: <linux-spi+bounces-3345-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D0B900858
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2024 17:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8306B1C23DEE
	for <lists+linux-spi@lfdr.de>; Fri,  7 Jun 2024 15:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C881946DF;
	Fri,  7 Jun 2024 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="L+R/KhHV"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC80E1667DE;
	Fri,  7 Jun 2024 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717773191; cv=fail; b=EQpyOTAjU0RMvm9YEGZw4kDk5Dbi/0t4WNB+ygXAt91SO/nNNk1rAW6cIiIM/0pAYcXEFLBjEiQ1sDjlCypzFYlwlTOoKlf4BGNpeHOnYlLY2vk4Xt3y09ezJf7GkIgrKzCC41eOPX9+r9trA0MF5L+t/+F++NRDMbewDf90wUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717773191; c=relaxed/simple;
	bh=MXe0E6kp3op+Na6XVPoWy3uKyWkx7Sga0L/ixc5SX4k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WHG8eVgAvrrplJXEVZyGowBWmwAbWQ3P338PRW9/L9E7oHkh1Rm1O8Plz6AGpI4ZTAhZDRio9pqiuape99RGxOxARG/+9dBUbMh810N7rPtX5NluM751Vw6SwhUcrCv9Bl94bQO+z4/eLeDkCT3Qd1y3s5BujEz9A6t5yGM8+/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=L+R/KhHV; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45799KmS027397;
	Fri, 7 Jun 2024 08:12:58 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3ykuu21kw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 08:12:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMUQQZZieNCt+WU4kZwEE3DKGozOBGzY/vSGFgCv23HeXQLFCaSrAlAXcOulvtRK8QZbCh0VNNdS2Yp/AKoOQ4ky2K5KElz2LUwTmf2faQzRJcURb0I6lp4Z3VAm+eit/tPFzGM58p3OpgUJ1ybT3NhYK6mishK2qewFV7wHLcGqoP7rYSnoRtkqFlFby5OGbcRRph6va/auvkoLfka1PeMzYC11Yvd72ZgOrjCsiUDFO9FxxZjFmVXwbn/C/9TnwjiAyJ6siA9Vq4T1GhKSOAhdE5IujHlpbD0HI02BQmDh/fSr8cZv8tUTrMZ4/qumrMK9fGps5ZvGNTEPj/i7IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bu2HMtojNU0nosqkrDmvWlymHTOx1/aZmAKD7Cdvxn8=;
 b=AFahEly8YPVInMej3UDNVRL5hIT9YfhqtawTrUmtrE2t1hgLGqswAKvsBetSiesD/043tIdnXELGnrffDm4ksWwQFTxcitMTyZ2Y4qtJM9IPAfcoliqmM8/9EXux33wrxL0TgaUkLLV0I9pw8fyXVPnX/UcsrGs7V9arHknIImavY99FIG/J6IzaDO/scRbcNsAivPGKxu1wPNdNsG2SWSLiSeyQGN3+nHaCwS3NerMD4zWPnCwcUdhyNR0pVu5EQeg8eBDswH4Ykqt4t6pSv8jzcGnrOLF6BbBIdmKocYsXSYQUtN/vuJYfi0V9ece00JMaz0qRbCe20yZWgk6/2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bu2HMtojNU0nosqkrDmvWlymHTOx1/aZmAKD7Cdvxn8=;
 b=L+R/KhHVLC1WVQ6CeSQuBUaZGwqfo+4PfVklLv2sRAwoEuh5M6w8LWw46WzEhJmcsONOvqNuoB83I+gsHaQ1/evQKfkYZgC95Oc1IB8piblVh6HA6TH4WiEsgjMlYdqIyIU7GeyLc13IHZvMv3u7nMOvMhHR3+mDXAwM3PDjEUc=
Received: from CO6PR18MB4098.namprd18.prod.outlook.com (2603:10b6:5:34b::5) by
 DM6PR18MB3665.namprd18.prod.outlook.com (2603:10b6:5:2ad::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.34; Fri, 7 Jun 2024 15:12:53 +0000
Received: from CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1]) by CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1%3]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 15:12:53 +0000
From: Witold Sadowski <wsadowski@marvell.com>
To: Rob Herring <robh@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "pthombar@cadence.com"
	<pthombar@cadence.com>
Subject: RE: [EXTERNAL] Re: [PATCH v7 1/4] spi: dt-bindings: cadence: Add
 Marvell overlay bindings documentation for Cadence XSPI
Thread-Topic: [EXTERNAL] Re: [PATCH v7 1/4] spi: dt-bindings: cadence: Add
 Marvell overlay bindings documentation for Cadence XSPI
Thread-Index: AQHashOgPo1FoeQZpkWJe/LJw4DVobGwlLeAgAvhSkA=
Date: Fri, 7 Jun 2024 15:12:53 +0000
Message-ID: 
 <CO6PR18MB409866472BE353D6DAB3E361B0FB2@CO6PR18MB4098.namprd18.prod.outlook.com>
References: <20240529220026.1644986-1-wsadowski@marvell.com>
 <20240529220026.1644986-2-wsadowski@marvell.com>
 <20240531014703.GA3691352-robh@kernel.org>
In-Reply-To: <20240531014703.GA3691352-robh@kernel.org>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4098:EE_|DM6PR18MB3665:EE_
x-ms-office365-filtering-correlation-id: c266470e-5397-4e3d-2602-08dc87044dec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?wISd5KXwF9tbT85pHisorjrQIfV3jU+qUS1PwMAQz91RPO1utGsMiqMw3jT9?=
 =?us-ascii?Q?ZCqBivPf51xBNaNDkym6OYzJJyV22j0mJ8WVRmuFMIE7aJUGTBLkcfsutmKJ?=
 =?us-ascii?Q?wEqNEjC5l6aWQDxAUkoJEJbecMPLPNvTidXQnpGT13TWg3Pp4JDVXAzdzwkJ?=
 =?us-ascii?Q?SQwvPrmbn+kD7k5qGC4xNfW3VEa5dbm6Uk/4oWBhzUbsex8bofd2/Q4N7H9+?=
 =?us-ascii?Q?MqHRBG/FiHqjrEjRHkEv3snkNBTzMIkwfYCP2/kWimGloRcZMchHB341FgL+?=
 =?us-ascii?Q?xa/fPuUyMJLDexjN8Imld51oPcJ5qn5Pw88fdkOwmi+JNnsR82+fBg6w4Gts?=
 =?us-ascii?Q?YA2Go7hp/D0gGLHdg86slsTnzD9JZW26H02b9b4CAc6fZemzOYcX+Un04UzY?=
 =?us-ascii?Q?BHm8GPmHvSHSd0Zaf4Qjh3p7dmTOATLrbXcOoywk/5tzXnfgwpzGwoOrdZhR?=
 =?us-ascii?Q?A8kZ70ssU7C64Bvj99Bpo8l3HWQhKiHBBK4aYcclUpN9x9DQvokFGHhz7mTg?=
 =?us-ascii?Q?JkQwkdj0J9A7oPWhg2QaLI2Io0pLZozh35B6klSWXkUvkH0m6BeTjfipJxap?=
 =?us-ascii?Q?bkx9MEQ9jK/Nrq70opn5q2GD3k+32sheHp829fx4oqnaQgCZcXtSCmHwsWd3?=
 =?us-ascii?Q?MmLb7bY3iRNDcd2294Ckpneh4+F2gVsvn8rmKrjK8Z3s570FlClyQIMORGUA?=
 =?us-ascii?Q?OHlxasT+3mOGkoP0S1SXrSmdoHJtDG6VlCT3iYQnM6YHpEhizx5p16RH94Jg?=
 =?us-ascii?Q?8mG+spjwkZYbrstoSwfM2Jxs90ZTBgtUQI+CkUstNecASiFv5EkgMmVhs0g7?=
 =?us-ascii?Q?exB61xGbeje5JXsgQUrVOQiKZluuDuNUGfeOjlHrYkkUG2w3LG61Sox4Jn/Y?=
 =?us-ascii?Q?Y2CCgaXXiQwxB47B/t71PW8G4iwgYW3kvxwI3CMaQ+X9MyEKApzWmZh4K4W+?=
 =?us-ascii?Q?F/gr/9NDGnzR1maCOWbxQSLEk+A3zG+EuMs1qPVAoEieEISsoBOKlTZJ2MaL?=
 =?us-ascii?Q?hwA9FIJJVonrUorZWNyON071uASQ1NqOUimZudMMILaIpD48aCwyExcEtKGH?=
 =?us-ascii?Q?UFQ2FT2BzsVxP/8Oh16AAZRqplur4Rn4dn8M9hWGx85FVZuPVnVYpWSBYGyP?=
 =?us-ascii?Q?EYgqWoY/5E9jVAFuaxFeRYgM/0bBDKQNvlr0Vp6uGm0jmfZlSjTPb6BQW18x?=
 =?us-ascii?Q?CMtZrNBWMbmvkryL7kClShaL2dYVkC2fPmfznI9hQf0bJQOqrTv5UhhYzICp?=
 =?us-ascii?Q?ofMLjR9/XndMMnToQEVKcadxmrMXH9yhYaPh8p1jHiuF80VWzjpPQjO4J7OG?=
 =?us-ascii?Q?CIBVZzmcoSBeQud60l6FWhbO1Cc2Y26TzUrJX0Xz+CeQq8cdEa0sxlbgP5xh?=
 =?us-ascii?Q?NPQ157U=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4098.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?6t6T6PRy6r4ARW6An5JkEZx79qHCC9bKLkhi9/uIqPgwz9CtnL7AqpKVtDru?=
 =?us-ascii?Q?996QcA2YIm8J89DnQIJRybiC0Cj37qkXChfURQTPq1iwKyNLZCB1iHIXV4wE?=
 =?us-ascii?Q?/N969uAxS49abDyikhN2KniXluOnXcQ3AJehWBU/RAENz2YwtPyC8hdhoywW?=
 =?us-ascii?Q?+moRDuIPNsfl6d6jf02xI3t53yCgPDUuLoBasrYKlIsIzMcGbeKdyLFBwy7b?=
 =?us-ascii?Q?RCzc2JpseW6nZxr023R7aW7aOV0+EEkdSIWPDQFzqPaFs+S4ZI4WdtoBJHtB?=
 =?us-ascii?Q?vH30pue9h03oHhkazPXiwrE9NoZLMKGOoGZeXyp1JnPjvRNhmuDkJRLvs14e?=
 =?us-ascii?Q?7BTzFeeb5LbyV8sAFf9DJJ17vdzof8oYB5zmLKpzZyzyuIYu6//ElT+IEQPS?=
 =?us-ascii?Q?/lcYFi36gqDTKQL4oOaVlBFWdfOOYJChceK5QvokjDy4wKKo9TJd14UIHH5o?=
 =?us-ascii?Q?eJX+JE0Ybn4F9/QxSfyXeYfusFfXTyBfQeDa68XFvsY5x9O2MfpOGA/uwlS4?=
 =?us-ascii?Q?s9yhr5iBOQ0uyW0GLQtZ9UOUXAanzOMpGfzXbHQExnuEZGsLlQb2WRFlH8rz?=
 =?us-ascii?Q?vDZ2nsfYb3NipzM/ICbuhi0qWHCRwtIlwCcWvgfmouJg/s+81ZKtN3qyjsVn?=
 =?us-ascii?Q?n3VLZi3UDWECXOA4RBqC6xffM9AwBm5ZtrXhDqQjnGwNa5LobU7fO2SkkLPG?=
 =?us-ascii?Q?zONePTdNGFpXt1A+ATpN//ORw49WMR1sfZOYMkL1Ouz/+PZQEuwj/a6ck36n?=
 =?us-ascii?Q?AfP0SVdaivNreVY9yidAuAMMWCi9koctxNolzCI26WDT3RfekoLlWXdg3LdS?=
 =?us-ascii?Q?oMPZqRWqwdWZRlNxIy/H0/VaUsidbOrE32tOybK/5roiJAFY5YApWY01LZvQ?=
 =?us-ascii?Q?P2PxluRpZoiwx62qKOvH5ivM96yZG89MCPUMV3hlfLxRZuQljJpLkEJThWq2?=
 =?us-ascii?Q?xu9ckLSkpF9+4O9j3kMe2T6O/k8p0Q0wBUII3rSf39bVBQPQpAFZaVtF9fP3?=
 =?us-ascii?Q?lPe5yMPFIpdeI6KZUIa7AgNIBOXBOSxom6aeShas69z2XuaDSaKRm+4roRef?=
 =?us-ascii?Q?SWF3BdZxJpjfWKMfoZlNTF6SqppZdH0jCQFJa7dutJDqEkUi4k+2S+pbB3z0?=
 =?us-ascii?Q?DMao/j2eA6KGy8AZnbhEJ5j3pGKGtvVzsu4lc4YsFPdBCZK5ab8HAbVaeHvK?=
 =?us-ascii?Q?MwcWCNVQfYMkn5ksag3hwKIb9nIfy1LQJDxpECg/nQT5ixWMZdtl5ysRVi6w?=
 =?us-ascii?Q?Ha0FXKgs3fIekClPjbM2QVFqHZExEa8AObXjFR/hTGx6HyOozpsTfAtyI/lQ?=
 =?us-ascii?Q?+VVaggN5ubWfDlQ8rE+YzEw71rsv0Zj3EWtdkB+joz+cMHnjlbmkVvyG0337?=
 =?us-ascii?Q?TKLso5XH5mD7P01RijBZ7DHCA3KLbRu9aHraCbZZIeQ/7Ts/3R8pCi2ZGHf+?=
 =?us-ascii?Q?2ncrd5MlQQE1noUUHWWptsDP9M92gh0U+Ne+z9U3wxgNFfVGogaLHwG8BR9m?=
 =?us-ascii?Q?Mh0cPLB9mv1Ulv5UY3b4eO4fHKnTgXRLzhjlhKbbgoTz/gyCji/UkMMoPcVz?=
 =?us-ascii?Q?KUFa6IWU9J/uXPSumAsuYoYjI+xEfBZDi+mhYmgV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c266470e-5397-4e3d-2602-08dc87044dec
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 15:12:53.6563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /z9+NN91KRneHAR4AlHL6OBeKiRQQbqEsOkCoxzKeXCBs25rccRJo3UtTZssZCUOQmpj5V4BvUlZgZQqovJYkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3665
X-Proofpoint-ORIG-GUID: ErNQWYr-Bl1-TNQ_nIewuZEBGn4oc66t
X-Proofpoint-GUID: ErNQWYr-Bl1-TNQ_nIewuZEBGn4oc66t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_08,2024-06-06_02,2024-05-17_01

> ----------------------------------------------------------------------
> On Wed, May 29, 2024 at 03:00:23PM -0700, Witold Sadowski wrote:
> > Add new bindings for the v2 Marvell xSPI overlay:
> > marvell,cn10-xspi-nor compatible string. This new compatible string
> > distinguishes between the original and modified xSPI block.
> >
> > Also add an optional base for the xfer register set with an additional
> > reg field to allocate the xSPI Marvell overlay XFER block.
> >
> > Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
>=20
> Missing a tag.
>=20
> But since you want it reviewed again...
>=20
> > ---
> >  .../devicetree/bindings/spi/cdns,xspi.yaml    | 32 ++++++++++++++++---
> >  1 file changed, 28 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> > b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> > index eb0f92468185..49c6a2c82fc4 100644
> > --- a/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> > +++ b/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
> > @@ -15,24 +15,27 @@ description: |
> >    single, dual, quad or octal wire transmission modes for
> >    read/write access to slaves such as SPI-NOR flash.
> >
> > -allOf:
> > -  - $ref: spi-controller.yaml#
> > -
> >  properties:
> >    compatible:
> > -    const: cdns,xspi-nor
> > +    enum:
> > +      - cdns,xspi-nor
> > +      - marvell,cn10-xspi-nor
> >
> >    reg:
> >      items:
> >        - description: address and length of the controller register set
> >        - description: address and length of the Slave DMA data port
> >        - description: address and length of the auxiliary registers
> > +      - description: address and length of the xfer registers
> > +    minItems: 3
> >
> >    reg-names:
> >      items:
> >        - const: io
> >        - const: sdma
> >        - const: aux
> > +      - const: xferbase
>=20
> 'base' is redundant.

Ok

>=20
> > +    minItems: 3
> >
> >    interrupts:
> >      maxItems: 1
> > @@ -42,6 +45,27 @@ required:
> >    - reg
> >    - interrupts
> >
> > +allOf:
> > +  - $ref: spi-controller.yaml#
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - marvell,cn10-xspi-nor
> > +    then:
> > +      properties:
> > +        reg:
> > +          minItems: 4
> > +        reg-names:
> > +          minItems: 4
> > +    else:
> > +      properties:
> > +        reg:
> > +          maxItems: 3
> > +        reg-names:
> > +          maxItems: 3
> > +
> >  unevaluatedProperties: false
> >
> >  examples:
> > --
> > 2.43.0
> >

