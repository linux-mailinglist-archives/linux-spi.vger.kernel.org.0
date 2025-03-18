Return-Path: <linux-spi+bounces-7190-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB24EA66E52
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 09:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B62016E7B5
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 08:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D0D1A3029;
	Tue, 18 Mar 2025 08:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b="qaXCcet5"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2093.outbound.protection.outlook.com [40.107.22.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879CB749C;
	Tue, 18 Mar 2025 08:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742286767; cv=fail; b=Ry0fbLQJatomKfkjYOTouNQXx73qRMY9cG06f8w09QSe9c0xCeeLCWznk5qbI423+TJRN/8JPBdLRcXwszY0NnpaZ99NhJbqdQ5N0F0NjUEJU6Fv7GWifZ4lFq2wTQV0xJaFr1TYqLJyETSJWMFudnoDzD//qdA8fgFuDbSnel4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742286767; c=relaxed/simple;
	bh=CbNRfPt4GXtJSBECeW8B8ufj4kefJ4ZHSKiQYSZKk98=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uwt7trtPWNpi8YsKEaQgw/uzX8suxs5DkTNuTVNBIZAtfB2z0a8RqbeQpEEFWbDWNvu0xxK+i3fhbelVmg/wn5QpZHmg3IDPColQkXsFEU6N3XQentLTyNC92kbVsYa+U7fQi70gNX/IZizksuoBYJNk01b5+k3BlzdruBlOMzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com; spf=pass smtp.mailfrom=gocontroll.com; dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b=qaXCcet5; arc=fail smtp.client-ip=40.107.22.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gocontroll.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdGUnuNBkIMpHD2dMxnpZTMgUIKmBXMjQu38ir2ctzOrPwc6CXsla/W/Hjbsuc/5qGi0gaqR/uRn9fr6jsJj/qmcn4Lk75UqgSpKq76RK6BJG5MizE7iFJrSPr++3DXZ3JrfOJBXYdT1SLIQlYbuaI5r55r00hjsrWpEI2N8uCIwys6n4D5p3/HiQtw6xxMLhGk/M/CmEKppc2R3jT+d3vyDZ40f3y1uCnHm65SMAy2hcB3SorByYlvmIMoa4DptOy1QC49R/NlKB/xTcWNL+F0O4Rtod/ZwyDfUljTHiTi5vELHrIGCQWypa5CODEAsYHGKgHssFO6OElAd5+Hdtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmApZO7T9s3AhYShbKg/uuCqKr9ZU1fKWkfuEWJXs58=;
 b=kphbZmizNtrLAnukqJQ8dZDK4TUB3PC58AiaPfb7vMrwOKRCbcmLKYvCvJIGSwfqUQmjSu7085mf890LK/3hnYmkAwHO/gumh4cjiLRrICxYsE52Mos18W0RJqARWQUBtKlb9EFgdQns6NrVrSDA7o0CFh2UwBUgEWZd81p013ul0C0IYfeoG+WKQWO1ckltdrUThtGKsoxenlX9eVEdQ/Rn7dSRNd8mEzaIaPXOINm+JaikdStFz5EYRnS4hK3rQZE3myHABt8ZZqtHM7aH5kH6dLdqn+18z6kyxPpL/TVfdUSD5pkdEXBDEKpark/WP2DpntKx/O2nCEH2l6JdUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gocontroll.com; dmarc=pass action=none
 header.from=gocontroll.com; dkim=pass header.d=gocontroll.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gocontrollcom.onmicrosoft.com; s=selector1-gocontrollcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmApZO7T9s3AhYShbKg/uuCqKr9ZU1fKWkfuEWJXs58=;
 b=qaXCcet5KClXNhnE6LevWniiDxUjOYmictKzhCclnRbLzEn+PUwz0tYgn8NFofFJj6+epMeZPHT3mXQmZUJi4A2UHMWD/z7HTDJYKU7XwQRWI014YlRaDCA2P/jtw81jNhjqPNQ35yRgm6ivDWhbwRCBUkyFx2HNeep9H5wl7rczQRtYtZ+Pzgzan9bzeohpT+IKxBtXN4wpqPLJQMJ7iXfzlj5joO1U8AiBo5zIXpHDtW6FArQ6v7sM1YU/UynElSfPJgFVJEFuJoyFdlxCNkM4Gq49HgGDqLTegP6fm7VfaMwfc92Moy6vRJgXR9q+K+Nia7fEcE/vk19tUd5UAw==
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com (2603:10a6:102:ec::16)
 by GVXPR04MB10705.eurprd04.prod.outlook.com (2603:10a6:150:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 08:32:38 +0000
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f]) by PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f%4]) with mapi id 15.20.8511.025; Tue, 18 Mar 2025
 08:32:37 +0000
From: Maud Spierings | GOcontroll <maudspierings@gocontroll.com>
To: Lukas Bulwahn <lbulwahn@redhat.com>, Mark Brown <broonie@kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Lukas Bulwahn
	<lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: adjust the file entry in GOCONTROLL MODULINE
 MODULE SLOT
Thread-Topic: [PATCH] MAINTAINERS: adjust the file entry in GOCONTROLL
 MODULINE MODULE SLOT
Thread-Index: AQHbl90Qe4CVTXfJ3USspVGc02L2erN4j39y
Date: Tue, 18 Mar 2025 08:32:37 +0000
Message-ID:
 <PA4PR04MB763052BB2CB83B9A790D1EB7C5DE2@PA4PR04MB7630.eurprd04.prod.outlook.com>
References: <20250318080913.31455-1-lukas.bulwahn@redhat.com>
In-Reply-To: <20250318080913.31455-1-lukas.bulwahn@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gocontroll.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB7630:EE_|GVXPR04MB10705:EE_
x-ms-office365-filtering-correlation-id: 2e53f408-56ff-4149-b129-08dd65f77072
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?9nRXrkDEG8rYz4o3yypRAG+Jvrh4QeZge7w2DbhcUEOsXjEXpNPR92wrGb?=
 =?iso-8859-1?Q?YjdXfc40i2LqqmQd/x6A/a++tHWQQPb94D0+SXoQhM9/g3d5lM+4FlZtIl?=
 =?iso-8859-1?Q?+9lLJLZSoQtF4osy97chnMDzqrD+DVPzSUK8Yl8XCHSeVAriGY4VnZ0apk?=
 =?iso-8859-1?Q?oEmg9hx3ccWu1nYo2Zs4NRV6aV/8HLYGaMJKFMr1NcyAmxaY6Pj5lNGqfN?=
 =?iso-8859-1?Q?p3In+ruwrWkfqaf5V7RjHqKvypQAESutj5UeB31uTjkHqaHuk+I9UiVaSS?=
 =?iso-8859-1?Q?abSsEx9RZArwdRBsf+sTeRI6T6Df9VzAypCdAyfMa29Mv2eGC3iDdNgOmp?=
 =?iso-8859-1?Q?IyCA7uJoP+3lp48RJh9spEHUygqm617oJ6h9N3R+FBfKfoTEWYlZoynVdL?=
 =?iso-8859-1?Q?L/+c0B4uUDD4oBqVHJ6G95lhwBaDRLj9KK4yS1J+3Xi0g67DKUpczvhGuH?=
 =?iso-8859-1?Q?xZkbstFSBqlNtcEWggU58uDx1miqkUMV/vovLCqolDA2alindBRpvHo5Pm?=
 =?iso-8859-1?Q?OCGF+Iq4OVzaQvLQiB3VYbBHgCHcpqljZCH3JT50iUQOcFG1UUV/UUS947?=
 =?iso-8859-1?Q?1MqyuRey26ZjdqxqH9VQBE87h8QAu9XpXChokwibHhHbWLLJpnTc5dsaRd?=
 =?iso-8859-1?Q?Ht8XHE5nRn+O20nbgBLl5uR26VZok71yTqWoEXFE2kP8h8YH2ZhQ0Yf0hg?=
 =?iso-8859-1?Q?+lvcPJ84aytNxr1aH8TRtXeM4P6/YCRkZ+wiP6EMSt1SsSmx4kMMvy+Cbh?=
 =?iso-8859-1?Q?ZPYEHQfWFHBktwNMMeDBXodHNo5swQFuLdW5bQjeyK4XUFSGhlUIeVsY8v?=
 =?iso-8859-1?Q?rI87ejW4hH6ji2WLuLH/q6r+wVzE0JgEJpyrjYGqdQpyFts0rkqOvDp1JZ?=
 =?iso-8859-1?Q?gDIUGF2qeMpcLXGuel/amSIxcuFW/fb0Jk+GAkdIJcnjDJ37Q3VWXScv7a?=
 =?iso-8859-1?Q?JiyOjyqtHlf6cR5mntpuDLWJXnUW9lFLrdA6bPAPIzmXRN4AjcbRHLsOfa?=
 =?iso-8859-1?Q?OF42LpVTWUaoD7VBL/ffKC9irc29sFCDoUWMePB/odIKdtbM7v52f4Lnrq?=
 =?iso-8859-1?Q?Ir8XYmt7vzkHPTi/wF5IseY2kNDckYX8phz7WD5HOxUFbzqiCERt9896Ay?=
 =?iso-8859-1?Q?zE+Ecfry9bErK8AS26G9MU/s+ckpKNsZtmF28w9o0lEJImPSaqhguz9iQU?=
 =?iso-8859-1?Q?01TykgpTBrkYbjX0vluU7tIAu9QXdX39eLzq7YNOVr4uM60J/3ncaXsVWm?=
 =?iso-8859-1?Q?mTRAjWSbJavvoNI9ZejuVyQr2RvzVsiHz7jI4pjV82opmBh4vTuO6WXV0i?=
 =?iso-8859-1?Q?rjzHuDLQEE0l0ZTCKdoMDEAmwZNmbD0wRPZMYOQgdyqEe5UzpreACchPlr?=
 =?iso-8859-1?Q?Sq7LHvdyLAWhMwc5jmGWK7xKOGmVjLPpU1ps1wT5mo+NqyblQ3EpgA6zfz?=
 =?iso-8859-1?Q?0tGtsNFAYjWYORhvCYYTeeB0G11WeI916UaEk+rqNd1Dlxj3tQBakdtrXQ?=
 =?iso-8859-1?Q?9nnE8RuSeOrhVrDQ5nTPV0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?6eyBiSar6pxLR6G1EIvBw9IAPmeJ7F39fZm03O89Lt9Se8AYsx7P4WArYa?=
 =?iso-8859-1?Q?65mKDum6GlLCa3qymTHgXt3BytKdSpQ7vXyzPFu65nOVvxxG+MmK1al4wO?=
 =?iso-8859-1?Q?HsVjrZhK1ALiZHZZnMxjSNobSetdS21EvhQyamFFM16uzB9A+VgZwc/GOB?=
 =?iso-8859-1?Q?LdvD8YNVO29c5sIVYss/eH8qxwttcwbt+v0FGnvIQhWA4RArRGuctLsTW2?=
 =?iso-8859-1?Q?7rurVA3wU1yaX4cj0NH9X1hyiU8F6DyY44tjwjmo2VTLpngaIe5PU0SMa/?=
 =?iso-8859-1?Q?ElnAmdTHXFQ8NGSvCNxP83S2327A0615pFzlm9u0CytTrD9EXw6TbD0RG7?=
 =?iso-8859-1?Q?ShB7rtv+rLYIzBHugCutQpE8Tn7T3lPG+SloZVs1Ga25jNaSlP8JppRWJ8?=
 =?iso-8859-1?Q?wQXCmlOYJVg205FDrn8iVujA4tagorQU2Hjn6K/iJ2oXexXZU72XfjkmGO?=
 =?iso-8859-1?Q?68bsxEzlhRoO/dj8VQB8NtfJ5e0+zHtvKsnmvHcAyTH6Cp7fwYqTKrqhwu?=
 =?iso-8859-1?Q?WjmJtsMCU43zjlaYizKwBz+XSrtCmpb/XjGvVr2T/Okyzlw2r50pPb1/Z8?=
 =?iso-8859-1?Q?DryS8m/yXw2vC5v/IZ5vKkDVe3o/9IEt1UvWtt5eAsS8rGdJuJV6tEgJeH?=
 =?iso-8859-1?Q?UrvxJi01r2k70x0zxoMWTmVycq2n/0Voum592v86K8aCYw/V3STant06cR?=
 =?iso-8859-1?Q?F9BtSDNEGDz6DfMaSbIfXk5IlEvAK49aQNviGMgeV+kr05803TNXFtI3y6?=
 =?iso-8859-1?Q?i73UxIk9DvdEtdjADZPlfpP3TW+Tf719day6ot1wILNJJnXpuDG1ksFLET?=
 =?iso-8859-1?Q?xAAfx+ewQMeOlcJvjqstAflkmmyjSAX68HXJhFIZj+e91mwfycF4hy/wLc?=
 =?iso-8859-1?Q?zBYBmmxlIzC846hW8NMIKrZiIFPXrvUbskXOquc4LJ2C9txo0vetUfNp4N?=
 =?iso-8859-1?Q?n9ru559L1BqRntSCWLdhwvITP6yAK6D+0cz4cY9DdTaq8GOon09xQyRx+w?=
 =?iso-8859-1?Q?0hHvB7V3/cPffDrFooYZNWz7tLWi9J3Kg47FJcLrdkiD4OGiyzURw3JyEu?=
 =?iso-8859-1?Q?6JqI2glvpfEKQZHoC9stGN6OKx/CHJyPTZ5YXE9SojUr70f9Y+mEhSVDo1?=
 =?iso-8859-1?Q?nHsK2fg4cVct5MOWEGnQVlcUsYubxKKwxXcqHh8QqLJ7i6mK4Y60bn/OFm?=
 =?iso-8859-1?Q?ezAS9ltikf3o/T4xYMt/KgTyuYPkyjSqdL2t6Gd8/CSMlxsEeqTimrPR3p?=
 =?iso-8859-1?Q?R/niIZVmSeWB/7s6IriMjl2NOENDNEOCthKjLk2qkM1lJ/7QPb3cUxxZUt?=
 =?iso-8859-1?Q?rAcF2ohOck4BXika47p0xMSzmN8qgBvVfesv4olyGrCdTHERskNh2srMGO?=
 =?iso-8859-1?Q?T8TU5BFASfAXyLC64kCK5KFRm3o5S9XhtkCW4qreEWOMMlrXyiTUN6AtCk?=
 =?iso-8859-1?Q?5FdupEl4FZ9l9KNahoNp14OYMv1FlqnR3WTzQ0B9Y8Ixgw6UnvTbpmfARo?=
 =?iso-8859-1?Q?z+RudksW4sxDhFKAI692691znpbASCKKM9hZHfStNHaiagqMORDrFkuAyU?=
 =?iso-8859-1?Q?V3jO0Osu4ZL7l+7gALD+WzHdN/ul6Fy6LlEqqJSnmRJx1BIT2tqHaYWrxa?=
 =?iso-8859-1?Q?bycZ540FdXvaBGD+UP3eDl8trvRrU+CfBZbg+bMBxhLzzFE3pplW1bXUpG?=
 =?iso-8859-1?Q?IoddOtgErkuStzfokrNfv2V35dNbZTzNZ0i+aIqfQ0FLqCrqZwoygko4O1?=
 =?iso-8859-1?Q?OunA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: gocontroll.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e53f408-56ff-4149-b129-08dd65f77072
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 08:32:37.4301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4c8512ff-bac0-4d26-919a-ee6a4cecfc9d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D7Xp5L+1kgyJmwIsB2EYFu9yTAmMN04u8syRW42RZm4rUv7DFdZsjoHIyODmdyRkG7weZAh2kHtsINosOCY13i5IjlYnKbjiTvDzy2mqC7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10705

From:=A0Lukas Bulwahn <lbulwahn@redhat.com>=0A=
Sent:=A0Tuesday, March 18, 2025 9:09 AM=0A=
=A0=0A=
>From: Lukas Bulwahn <lukas.bulwahn@redhat.com>=0A=
>=0A=
>Commit 8f1cc5242544 ("MAINTAINERS: add maintainer for the GOcontroll=0A=
>Moduline module slot") adds a new MAINTAINERS section referring to the=0A=
>non-existent file:=0A=
>=A0 Documentation/connector/gocontroll,moduline-module-slot.yaml=0A=
>=0A=
>It intends to refer to the file with the same name in=0A=
>Documentation/devicetree/bindings/connector/. Adjust the file reference to=
=0A=
>the intended location.=0A=
=0A=
Ah rookie mistake whoops.=0A=
=0A=
>Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>=0A=
>---=0A=
> MAINTAINERS | 2 +-=0A=
> 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>=0A=
>diff --git a/MAINTAINERS b/MAINTAINERS=0A=
>index 561d394cb210..92af00cd0eee 100644=0A=
>--- a/MAINTAINERS=0A=
>+++ b/MAINTAINERS=0A=
>@@ -10022,7 +10022,7 @@ F:	drivers/media/usb/go7007/=0A=
> GOCONTROLL MODULINE MODULE SLOT=0A=
> M:	Maud Spierings <maudspierings@gocontroll.com>=0A=
> S:	Maintained=0A=
>-F:	Documentation/connector/gocontroll,moduline-module-slot.yaml=0A=
>+F:	Documentation/devicetree/bindings/connector/gocontroll,moduline-module=
-slot.yaml=0A=
> =0A=
> GOODIX TOUCHSCREEN=0A=
> M:	Hans de Goede <hdegoede@redhat.com>=0A=
>-- =0A=
>2.48.1=0A=
=0A=
Reviewed-by: Maud Spierings <maudspierings@gocontroll.com>=

