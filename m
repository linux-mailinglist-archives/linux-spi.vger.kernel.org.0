Return-Path: <linux-spi+bounces-3661-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 673E091BFDC
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 15:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311A4284080
	for <lists+linux-spi@lfdr.de>; Fri, 28 Jun 2024 13:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262CB15886B;
	Fri, 28 Jun 2024 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="qscR7VPT"
X-Original-To: linux-spi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB66A153BD7;
	Fri, 28 Jun 2024 13:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719582323; cv=fail; b=GAGgy4mpRPp/xVxys5Htaaf4PHitbIiIfknCOnkejUgsLcTgGCVBKNJL4smCjpfG8C/MpKmwqHqNQR4JYcryPNtRP56IOMPrgv95/M26Cb24ob3g5QSLCA8wgKvJ6aX/C7Ycrt6zQbQ4yyAqD004pKbIF8+Wkt6N5IEIsqErseY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719582323; c=relaxed/simple;
	bh=S6+lu0I6n2s6ZijobYcKYAiC9TIFIsBwvNm4HJmaZYM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VlkS6WTPxwRBAPH/oGABHApRLjZp5DJvkEBVcH01ay327Cd80reQPmrdMugyNCZca8B2QadBdeUp9VX1Q2kZahGOwVvzyDBJzjDnGRwm/RDTHeNrzjOAUrykNmvO5hMvQDVf9BPA0MHJ6ggCx9cF226LdMDcPWjNL8XH7DfW2+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=qscR7VPT; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45SAB3Xs014837;
	Fri, 28 Jun 2024 06:45:17 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 401tsqgkt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Jun 2024 06:45:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgKvVel2JBdEHXoboW+Q8KjzI9lXTQT/RbNCoxW2M1LzC6sMy8z5lkDkuFWuOCEUYOaF3xBdjSeO3lg8fdJhO2XSzV0KFG2ToCD5HuaoZibQ+/38yXvfHT5URlFKpmN9u11Uu631l3OFNJUg5Oy9iV6RcUm8b8BAGqVWeTUpwJIwBSo9cYwMOq3dXaGpYH6r1oO9HKINlBhMOhFuGSr4rMObsVNjY3aixnF/bFSTHQALrFNT8ZWQlSI0gj76ZVnVgMWRDjiR81aSPO385lBP8xi5SvUycUIBf/ZfU1rJXuDhJj9SgOS5q5/rNE8ovmGufPZy+pVJiHTgpiTlv+aKOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeLmZeVgJcYASXB7SzfDTv4ljel2Pokpa/Vs3FnIIfc=;
 b=c/nu+329i10An4VAlg5Rl4bvglkL1Eg5PPbmVNUtprqSd3lCur/llPy8hfpR5822MVEKn/eggN21phI6E2429CURath8hhFl34UCzQ+RHcCPbeactflFqQUh/1NiBwuDfYF52XmZSXSZmQE4tZpeaTAlcYNbX88MrwR1WCHh1KUVrNpkQE1/SOro/Zr9z8OZIQj5kBt7heuxX5J2xjMzkFUQd2vhEZYJ5ghaZLSr0N6s2RYWMuLxaw/esYhE/f+aT2ZyHeo0SYW5ijHF4cSgoYNsxpiVmtjXzDsYzSRCZzmrQRG0myf6DEHkBQNMOff/z82wyXlbZ8qXntjVlRQI1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeLmZeVgJcYASXB7SzfDTv4ljel2Pokpa/Vs3FnIIfc=;
 b=qscR7VPToP+aotNB9n3QT+3Uyay3A7IxM7hhfilHFZXQzfunaNYUwS/fVGlhPi5Zt407vSTtaW31pizq7//jQkcgbD+4EKAAO7d6RziLWh3xAoGTlJ3Xch43gs+Tn7aSXJstOxWyYHgPWyUWhX6Z+XNuVQ6DHOGfHF9jYEpFTjY=
Received: from CO6PR18MB4098.namprd18.prod.outlook.com (2603:10b6:5:34b::5) by
 SA1PR18MB6036.namprd18.prod.outlook.com (2603:10b6:806:3de::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.34; Fri, 28 Jun 2024 13:45:14 +0000
Received: from CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1]) by CO6PR18MB4098.namprd18.prod.outlook.com
 ([fe80::5331:f53:fcd:d7e1%3]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 13:45:14 +0000
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
Subject: RE: [EXTERNAL] Re: [PATCH v9 4/9] spi: cadence: Add Marvell SDMA
 operations
Thread-Topic: [EXTERNAL] Re: [PATCH v9 4/9] spi: cadence: Add Marvell SDMA
 operations
Thread-Index: AQHawlNsdh2HUrFW2k2FUvVWwvURsbHXATqAgAY7+NA=
Date: Fri, 28 Jun 2024 13:45:13 +0000
Message-ID: 
 <CO6PR18MB40981FD7DB1DA13E851F9EEBB0D02@CO6PR18MB4098.namprd18.prod.outlook.com>
References: <20240619141716.1785467-1-wsadowski@marvell.com>
 <20240619141716.1785467-5-wsadowski@marvell.com>
 <67123003-9987-492f-b9ab-718e5dab0acc@sirena.org.uk>
In-Reply-To: <67123003-9987-492f-b9ab-718e5dab0acc@sirena.org.uk>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4098:EE_|SA1PR18MB6036:EE_
x-ms-office365-filtering-correlation-id: c163f4d2-6db3-4a22-78cb-08dc977889a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?+QlMVKq128qyOI+u0X17cDS68tzo8Fwblysd+JA9Nqbsd8fC28mM1P6aC3Jb?=
 =?us-ascii?Q?QXor7MppdxT4YPoNVRGM5BToIl0zGqptWZ5IxqK70p7mXzLqH6AhIMlKMdSa?=
 =?us-ascii?Q?hub8Yl5joOgJb9G2VQO/YbRULl8sIyborv+6V6/KRqkfuVWsf8UzqdlseBNv?=
 =?us-ascii?Q?aYHdI5tAaSc3BcQycHbDxUS43yKFxoItNibMRIpJ0n/8/sI0lkV6v/MREnnj?=
 =?us-ascii?Q?VUfWRuZAFpXgDx8tsZqjfz5r5C1PJWyDyT6mADPTRvEZ9313+L0/c0K4SeLo?=
 =?us-ascii?Q?I6kJ8r3bx72k1EBTfzWV3GrevbZO51bD1l4ILZo5T0FaSN7O88BNGG1Hp46b?=
 =?us-ascii?Q?LOr7SuKwcU7xWxrQORkLDuvKcTvAQWDrE9Q0iz8toDDFZijqlKL/fgEk+ZNb?=
 =?us-ascii?Q?di/chmLcYLQ9zCva1q6xOK4qMrYr6rch1tkDL9nyoZHFGr6sx4w7ab9Tgynr?=
 =?us-ascii?Q?rXl90nYxzUWZZgmCSV3ozfrcsv9RQ2hqxYAfANg9Z+07lyPXzn3rRJ/9vmEQ?=
 =?us-ascii?Q?FbPFProCHZ7ko5uuubZc97TDK/GaRaUWGT0FdUHrqNkxS+4xcom30SXk0mfn?=
 =?us-ascii?Q?P5MTlfYefOf7qsyIr8QhcxUC9xQhBzFFF3/0lt2Y2sOHcUkNziaHvWlM6YE3?=
 =?us-ascii?Q?Jnbez+uHgay5Lt6WR4jMAP8OW9N4ry0jFqOEmQV2RleYRXC+T6H0oqVIst66?=
 =?us-ascii?Q?gwV8Oq7+pVIRHUBRB3Wln0cvq9ZvyPaox1cruWAf2+83NzJWpE4TQ7IIMQJj?=
 =?us-ascii?Q?Y58KUNdrLG04Y7abDLVWGl0ek9035FbeeQS6iuDmXBNGVJbbnINqn6c0HOJf?=
 =?us-ascii?Q?NEX4/MvdN7MncEXsbCDeQsnsP36x+JtzrfOgNBcjoC57/Hz1Z15vbivb69aH?=
 =?us-ascii?Q?mOgv0EZRQLqHDy3d9b2S+B2biXKzggFkPpd4Lu6meVSZ8vyzsGAJlLrHRB3b?=
 =?us-ascii?Q?gzbAbM4KPqb80mFw0ibUFhimOC0bU6ly5w66m0Cp3ioxK/zbH/U/wH/iPcR0?=
 =?us-ascii?Q?uyjqJJfE0Lwt4f5/h4yakdE2ZR0/v/joHHEOWVlA/aiASHFICON5JRTi0zNr?=
 =?us-ascii?Q?yBPtj+Oql2YPcQ6bfYBo7JL8lLFhEUvQ1NQFvdoNA163gJqyfqtyRrkhfj2v?=
 =?us-ascii?Q?tsreeiSzfqpjBw8OocdEJWmO81DxjbHDNfiVtIxOKgx3DKZ6auyLlrEtQJFC?=
 =?us-ascii?Q?FnRh31/zBPynsRQyckrozb1Jl/b8SAlAEmgv7Rk08SKy8mDNpbIm9f0BQOT7?=
 =?us-ascii?Q?IKVJyCMOlGcjyvX+wteSEQQFCrihKQ5JeOVSg87PLs5zHgvgORUv3OgfJvHM?=
 =?us-ascii?Q?zhMeoUN8HcqneN4MFVGxdWLfXwxb0vujKGBxu1GbTStcg68jWT7ytfFVuVC8?=
 =?us-ascii?Q?6wFnzdHkE2LCrH2ETQ+7v/IqVVa+HzUzi3+JRsvUroqp/0gG6g=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4098.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?w9rt/H4YmkjT++dNbmqCSBHCm74IqCWQ6OMv1U5jB/9aOXGEYG/Sv8kVEhoA?=
 =?us-ascii?Q?tTls2AfWgcF2OxR8OqFjNdh7YEVpLmEvz4CSSK2uH59VwYaXYehiUFwnK9Du?=
 =?us-ascii?Q?UaBxTRQz6OQ8qLKpFjNzfUakiJU2vanueZWghl9DIc0lbHGEC9bfwSNNXJs+?=
 =?us-ascii?Q?mdyPV9QbA4zro2VUxsI38ANs3/2EnVjz/HtXg9ZRcjYvaMxOQ1CEkazz2+mw?=
 =?us-ascii?Q?bJ3Ge5OZKGMh3fwFQX+lXcfdDEVG8lRz4F0dceUTQc9NolWTHPeJp27/KyyC?=
 =?us-ascii?Q?VPbTxWNeC3902mAJc3OdxFreDdDUtLc/5K2Z5XICNt4IqsuGGYZ7vV4quWEl?=
 =?us-ascii?Q?G+RsCBASmfJVm/vNetzt+v2BRGjTnz8iPmaTQDd61aJEge7RehwbckIddWSu?=
 =?us-ascii?Q?F6EZ5QvolP8oAF+Tn/OqhGs1wX8+mcEaIlgTlXaKt4UoqcrzArnAVFXX4UMZ?=
 =?us-ascii?Q?6xEa90XzIQxMNbov6BUiSytPzkJx4jw3tSUfrghmbuynp39JYhWyNCQelovn?=
 =?us-ascii?Q?oPCrpTt2B8BeA5aVUcBOjjWTbfggcYpdPGCjeZwrzjzZnDnMhqiAeClKmQXc?=
 =?us-ascii?Q?lYy+uwgzxvUn3sxqpTH1I11+Ayc3jF2brLhrEev0tjo2M/H+siviyhggw9u5?=
 =?us-ascii?Q?piQdHLDH4bL76ggx8zS3ByYm1TeV1peJJiWJEKOmhqu5EQ616GemUncQTy/X?=
 =?us-ascii?Q?cKMbF2XQSZZbSiX+Kj10is79HYLSE+++WOZLqRRkBMke1myzipYakTXjWx5Y?=
 =?us-ascii?Q?oAnI919hPe3+1YPgnPwDT6RPbDODBLP9ulfJ9xmqhM/bIUZG7od54C8tXNr8?=
 =?us-ascii?Q?/ozlFnqVF7B+Y8IXFeWdmlQLkduIm+8jQx7HUiHIhY4d/RkAQ1NI1M4i7WPZ?=
 =?us-ascii?Q?VmKNvKfi9Nqr0DXLjHWHPYX6hAdiswqhkyJmGnwrLx5UqZbn+bM0RbZnCBPp?=
 =?us-ascii?Q?HFi9DxubgQj+PoOcwFkbafluOpkqC+Op1j0Dq2JTcKexAwIrray/wCYRJ2oA?=
 =?us-ascii?Q?Dac1B2b3bmSP1sSmadHWxfJhLWtdZCVebOKv58UuW5F9wPQEss6T4DZv3hN7?=
 =?us-ascii?Q?9RWk8P+x+PSbfXSdrJaCM3qVcJtEZlLv5ddEvtSkq+O0JtRQoQrR3ibZ6R1T?=
 =?us-ascii?Q?bZTQvBKWd2sjc0pTRLzYy026efmO45z3BwPmfSDliWqTzcJOM7mcJkw0LGSn?=
 =?us-ascii?Q?Xm2U2kKNwQi3MFLuBoad6To+cFsTU0ZRGBdoeNgyAt1UoVoPoa5YJp/9AOj9?=
 =?us-ascii?Q?JfxwRI05Gp/akorqAxX9dW/cABz7n3w5h0YKi2+WNpN/yEKRWouQi41eZ7FB?=
 =?us-ascii?Q?2XbXYtFUP/GyYsh57JUmpeipZmBjOQOav9m0iWQ75muyxErbqVebyx7eW/ap?=
 =?us-ascii?Q?O5ptWUZVhcBWjHV25iqks4yfOwdtYAssSg+cfY3XfRL/BUixftDKq1Ykg8q+?=
 =?us-ascii?Q?ufaKqwJQRGKDOh11AqjPe5ORjh7X9bwPg3bMhHMSNxGw7erW+SEgJO0PTxvo?=
 =?us-ascii?Q?pjoUg8c872MpCFfC/ZUeoK2dJKPfk8/WNRT8Zup1WJOmmRgSLOSFtHeTNLfm?=
 =?us-ascii?Q?+HB/WIdSS0Ro0I6n45Z4IsyQWOBm5VQqXmPFcmCV?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c163f4d2-6db3-4a22-78cb-08dc977889a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 13:45:14.0736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tfxn0l2rWpI+j+tcooQGzpsFumtbnTRl1uuXmVbhboAw9U1TE8xACByzyleVXQlBjp32/GdgWNvRazqSX+QDlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB6036
X-Proofpoint-ORIG-GUID: uwMh_gBABD17TzF7jVxS_5G1BqM1tLcy
X-Proofpoint-GUID: uwMh_gBABD17TzF7jVxS_5G1BqM1tLcy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_09,2024-06-28_01,2024-05-17_01

Hi Mark
>=20
> > +static void m_ioreadq(void __iomem  *addr, void *buf, int len) {
> > +	u64 tmp_buf;
> > +
> > +	while (len) {
> > +		tmp_buf =3D readq(addr);
> > +		memcpy(buf, &tmp_buf, len > 8 ? 8 : len);
> > +		len =3D len > 8 ? len - 8 : 0;
> > +		buf +=3D 8;
> > +	}
> > +}
>=20
> Wouldn't it be more efficient and readable to only do the memcpy() for th=
e
> trailing bytes and just do this memcpy() for the final word?

The whole problem is with SDMA end - addr in that case. If code will try to
Read it in non 64b mode, all remaining bits, will be lost.
For example - doing 1B read on that register, will return 1B, but SDMA will
transfer 8B, dropping remaining 7B.
I have tried memcpy approach, and it was not stable.

Regards
Witek=20

