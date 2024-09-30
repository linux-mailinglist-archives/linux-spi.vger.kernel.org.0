Return-Path: <linux-spi+bounces-5037-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFAF9899FC
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 07:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CF21F21917
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 05:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB23126C10;
	Mon, 30 Sep 2024 05:21:15 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01on2116.outbound.protection.outlook.com [40.107.222.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D715383A5;
	Mon, 30 Sep 2024 05:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.222.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727673675; cv=fail; b=nm5vhBtaDFYXhxrfZzcnDbHFxhEhE8U59XzV+OZAbs43EsJMzy2URlN7I6bLgZugss6dZ0WdKD59vSVrKHuT9OlnCsYwgUxec7vT6wYJNOS3gS2h+a7k2CnXBxKyxCxfJDWE1TG9e24P+bc5mol++FODfNfJRFpH84wrCUvgG3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727673675; c=relaxed/simple;
	bh=wgKkS1VB9Slr8paJyiimxnE7Q9ULs+DKbLebA0P0t3c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hqju8CuIaMuJgZn/LWdvhA7SpXvOLnkrYdAOPSWTn5Vr6+MQE3zwK5OExFFej7ackPzRjLjtxmW+D6eokelgGCZBe8Gj5986ntEwvk+aD/dJs2aBvimRUx2BWqrF6ZG6bGHdwG6Fp8eOZXeN36x5YqbLTSIUT8H9rW1mkBJgEqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; arc=fail smtp.client-ip=40.107.222.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcShiMgpD66/R7SaZr3RlWxbRNVyGy4CVWTix5pDQLW1YTHR9I14torHUbSyL+utUWP7xC2k8oXfAfYHSSUZ8nCUd//DMOXz/fp2+ZXQ1rJmIsu600PY6OOQVtWlvtnWzEjjIjdSBqGewcnnlgOCGVa0gnnFDFr4Au+Y7Jz8tlZ/V1FytNZ9luOZP+Z7lK2YRy3u6YqGxWfU8gvrbywcQQHvT0lSZ4YRnTcn42U8WZKMKlPQXM/1T6LS69NlzVSZCiAUEgpc4XAFxs/6wqokypkcgR9uNi52qzruum6CV3zv/zgY7oFtiJghe4karo5XIWgtMgKK+n6meEhGQ+HeRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgKkS1VB9Slr8paJyiimxnE7Q9ULs+DKbLebA0P0t3c=;
 b=WjtjzO0GButwe2UV21AfVE6k3Je8gkMHG8pBXhIg3cd/BEYzifT8A03uYLjhoFFGV2KzkOwoAuV6FY5EQe1eI6eDCaKNH1wZlg/qTmvF149p55nFd4nI9/y6iSP/e/DXSEpmPrtyEnSMyBn22W7kMADyh7wRX/PMkWb7Q3dkxPopzoKSmqo45IjHEG/INPG7Dc1y0T//MUD86vDb7anY0XNSl0ERP+OX8258D+HNL8+oS3XGBEmCCB8I/pRcf7Twofft44w3a6GsFJjPu2PvmtnOXFWYtIKlF5k0mnQTOZ+gJI4iRY2rwcoZ9IIRcem5hMSPicQeCp29e2hEZFiwWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:204::8)
 by PN2P287MB1871.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:1ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 05:21:10 +0000
Received: from PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac]) by PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
 ([fe80::1134:92d7:1f68:2fac%5]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 05:21:10 +0000
From: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
To: Frank Li <Frank.li@nxp.com>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"olteanv@gmail.com" <olteanv@gmail.com>, "broonie@kernel.org"
	<broonie@kernel.org>, Han Xu <han.xu@nxp.com>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>, Yogesh Gaur <yogeshgaur.83@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/4] spi: spi-fsl-qspi: Fix casting warnings
Thread-Topic: [PATCH 2/4] spi: spi-fsl-qspi: Fix casting warnings
Thread-Index: AQHbEOFn+QUYD6WjJUmrnOptnijwM7JrxWkAgADwQOWAAxgqtA==
Date: Mon, 30 Sep 2024 05:21:10 +0000
Message-ID:
 <PN0P287MB28439159D94E5F8A7B0CC764FF762@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>
References: <20240927132944.19285-1-hardevsinh.palaniya@siliconsignals.io>
 <20240927132944.19285-2-hardevsinh.palaniya@siliconsignals.io>
 <ZvbR8OaXeg4SQc1i@lizhi-Precision-Tower-5810>
 <PN0P287MB28432411CBC8CAE2C443E74CFF742@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>
In-Reply-To:
 <PN0P287MB28432411CBC8CAE2C443E74CFF742@PN0P287MB2843.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0P287MB2843:EE_|PN2P287MB1871:EE_
x-ms-office365-filtering-correlation-id: 4a631ca3-206b-412a-c6c6-08dce10fb1e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?aPxhvKsAC+GWK4mfhyRt+BDAwIDwkZl1efppHNJIeX8p5mBMHvXya9rNLo?=
 =?iso-8859-1?Q?oCTa73faGeZnq4LtwTnCI96eU3xyYoxwHjkzHuY+CcGnbkotuIl5Xcahw8?=
 =?iso-8859-1?Q?pox93nwQPu+DKg4bdwHB7MDMk6uoegi5Jqivn9ucUoWXDLw7suPM6v0p3o?=
 =?iso-8859-1?Q?W8mc7pM5zbuTgC1ceTEH+gwxm6pQGmcm4QzRZ929ih3a46PRvjEdgaoo53?=
 =?iso-8859-1?Q?/JiCjqZ8KSMW5fTVhlCi1ZlGGrgPShgSrfSJdAYsUtiZKfutIbLmGI+dmc?=
 =?iso-8859-1?Q?kimCrDwlBobt4eXypKVK4zbiIVhMRsSdg0LF97Mg+T+0Y8ycAM8v2Tw2kC?=
 =?iso-8859-1?Q?GXpyBSQy3XpdP7NuXrFdZi7+ogzrMfV0cC96Z2O3EPwOhujRwwQwoPPDk6?=
 =?iso-8859-1?Q?I1xs24ejQCizgMpzToth/2kjjAPDmPgwtnrAxhKhQkqw0s5AnlfG+ut/h2?=
 =?iso-8859-1?Q?HhJx9cydrGZ5LEe2flYlkxw328mgE1sHLXhT6JJJMERJUJljiOpp7Bi3ec?=
 =?iso-8859-1?Q?kmjHExwRkWHQ2X0+wjX65x87tKfutaxWvXkuvUu1YtklfQHvkryGbaXrdY?=
 =?iso-8859-1?Q?LwGzJ7225ZTQesD8zmMAue6S1j3ECQMGxKKBfCFZHzVbx53X3Uh6Rw0TMC?=
 =?iso-8859-1?Q?S3z4bqhwD5cHBOYK0K8OCtrRh5ydFwDRFE9wbL1zmmHL9Kj2dEQ+M5aqR2?=
 =?iso-8859-1?Q?BjBhJLjGSJ3eFC2EeWX8N57y7oRnEOQvt0QYX+Mt+dpJHgC6s9DC06bMPt?=
 =?iso-8859-1?Q?04dlpAyXfPf76L6TWIoqv7MBgQerre0nq/hU/Vob1mOKiS/J9IpL6eJ8Mw?=
 =?iso-8859-1?Q?A3GDT3w8S0MzTTJE0iR3tG2iBkL0Z49zsFTYCYb4D6y9FGIORFpZEOMtAX?=
 =?iso-8859-1?Q?SVy65cnsc1w4dVV9H++aB45fN81fO6yjvZup+WYFmoKqURVya638TqxEox?=
 =?iso-8859-1?Q?WrmWZOz4phaU1yJUB1w8pZ6VIqfXXrUONJqMFJbN8GrL9uAswFEt9YrUXQ?=
 =?iso-8859-1?Q?F+DLfxCx2O/Fk+TgsQaJRrrm5WtzvmaLBSfc/uVOBIOs5tOtJfOjfrxv6y?=
 =?iso-8859-1?Q?JdmXA2m6nDbxpZCirGeG67AMPqvBdHAaBCNlZQqkFcqD0Or+K31HPzGZaC?=
 =?iso-8859-1?Q?zMZ9ZSUmet/OSmRj5Wr3t+xTPFTHQxlF6bY0Hg2vQy7GwRzQ1PjjTiAKMM?=
 =?iso-8859-1?Q?WuaFIJRu27IefTMtJtrolEYA5wd8YXdAHuTCk40Kcj7U7btfS/OTTp9XWY?=
 =?iso-8859-1?Q?ulpvWiKnaB5uzJcRneMBLo45gKqe1vyUjc59tsUD9aVI12cK/XXkux+wkf?=
 =?iso-8859-1?Q?5ICS9Iyp/tFBN0tCSZThP9v7rNsQJytpUkRr+sXlckeB4uJo7ZnOrcdU6u?=
 =?iso-8859-1?Q?YztFdsG4ZAt5QwN2txNeZW8qOtW1WYvg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN0P287MB2843.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?o5PHGmOPoHmDFMypkIHAlZF4Y8djdSkaIRv4iJW63fdwy4xxV8xrusg9L7?=
 =?iso-8859-1?Q?a9ymkJr9LJcABOgy9D5KGdkQxAXfQf8J7mq2d4qWr8hDU7a9I5auPTR6FE?=
 =?iso-8859-1?Q?YDowo1miyThydjacNfHalv/5JHAOaOKrg7gyAoU6hvK3KAN1ea9rppTJc1?=
 =?iso-8859-1?Q?T6km7wSPoSoBaaMzIuVTCDOFwmkTagSfYZy/iAqrwkKbiPZMEaHm9i1+ng?=
 =?iso-8859-1?Q?seK9p44O6yiUR8JCTdOQ6b7IXRWRu4oz3nC3hF5FAUtIiSle+cLAjYuY/G?=
 =?iso-8859-1?Q?iYodg/kT5HMqhJxUGJga3bPaPbKJOiMhq+LuR2q1w3KFdfB7fUHrkATG9U?=
 =?iso-8859-1?Q?2T5qtlhyJUiis2kaHMCqxPC45YKhqsK8NEBxrfJPbDR3sHQWFYI+lKzCkm?=
 =?iso-8859-1?Q?j/7Ppxqd5k+5iCqac5i7+qhDHOjYmor2QbTolhHU3ulTYFZOKPqQREUo2D?=
 =?iso-8859-1?Q?QtjuuSoLi9Pem40Xr1MJofzjZrvBzwWhZJeNeUDe7Uhun4jxxC428c1ngv?=
 =?iso-8859-1?Q?MhbBa7rcyUqPN9x76H39uyokd3NZoL+2i6Uo5kPz64DVqrqIQtKdTI9qOg?=
 =?iso-8859-1?Q?doE9YaQJ60PHIT3vYPjD2fHo5W/iJVSpqZ8wAOMl6iJzNQHIUP1vks/J4j?=
 =?iso-8859-1?Q?OvAVvRHD1J2q8udxcIzmUidb9RGE+sJoH1V/PFfmbHGnNpbdTtMRnO356g?=
 =?iso-8859-1?Q?t7nG679UE9WD7634Z7SBR8nS+JQHNiPfOfgYlq1eiDiQ0+6O6M1n6YTWCe?=
 =?iso-8859-1?Q?YTHlUqXuRxLo7zwXaxgM4wQ3uJ+xntLfjkbI1+kcWrl9YRuI3onucbzWwk?=
 =?iso-8859-1?Q?7aoKlhfShpKBgXDNac5C3P0Ar8acZO9RS+v5VeN/SSUa9UekNEVVvcbsbv?=
 =?iso-8859-1?Q?7QrR19/1LM4TcrNByYH4ZCRL6Ii5Y1zE6yk/eQtstuZ3//U1eadQR0mG4f?=
 =?iso-8859-1?Q?wn94Ui1tXO6tNM0szK7N2aPZaQ/N6YIWwFgMz7A2V6lyPkPJBFnW04HieI?=
 =?iso-8859-1?Q?wGvQ/ydYL45zA2zt2VsExpAz7PFjcZXgUCeCdi4ScKfcbFdGc0axcLieP1?=
 =?iso-8859-1?Q?z0YqEeyqY4hacJTrK4GbIYkocI3N6yacaUpHDppclUp73TcxnIXT66dQxQ?=
 =?iso-8859-1?Q?lE0DJKN0lgzg7eukQOL7Lty9l6UVeBSH1EtPOEviYcMdHpfb5OPgAOpadS?=
 =?iso-8859-1?Q?Kfj0L4N7P6990p5XXCBp2uz49GLQYu+dHMzY8mdhME1WvT5FnBkk2+O7nN?=
 =?iso-8859-1?Q?fv4kYDna9shcF6LsZje65s2SOrrdhrMPQ0TYBetvgZefsh/KaCrHD9s55Q?=
 =?iso-8859-1?Q?7ly8zBk66yXVCx1j8A1Y0u7yRMRozvBDFAuXTTUiYc+L36/UJFODplb+kl?=
 =?iso-8859-1?Q?ml5qJhQIgcMEiC6N7CUSi9jJvRXmR9PAsr6HvaScNBTZDshk5L+QcBH+Er?=
 =?iso-8859-1?Q?Tl2RxrOmq8ojHuFNj2jKQuSTte4+E31h+OHkQYYitXtCLyecjB0+EfDyia?=
 =?iso-8859-1?Q?4FStGlUzdPFmbj9xES3r7O5OB0eIUjwZ8sdG2cBY0Z1bPGuVjhJ0YxmznR?=
 =?iso-8859-1?Q?IPFY6fDzoOFmIW3Xtq9gEdAuiRR5KGhr5rJDIiruqKMYbawu9A+qX5JGKw?=
 =?iso-8859-1?Q?QKhU2viryq1cO7GLrm7e8td7LoB/lslh9zVqoKycP9alXnUXVL6L0Mjb/y?=
 =?iso-8859-1?Q?3xDgiwKk17jTzr60+dA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0P287MB2843.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a631ca3-206b-412a-c6c6-08dce10fb1e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 05:21:10.5056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5jJk+aF30OEeEGFUW8G/QpFo7r0n2rbCa94olKeGcvAKbEF+Dd++wKT1mohiG17DNiyRBS3y8TGc0HwnNmoeoxZrs1plYnDlDsl44AXD5sZ3eO5ExdihhN+CmJXSQF+l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB1871

Hi Frank,=0A=
=0A=
>> =A0 =A0 =A0 if (!q->devtype_data->little_endian)=0A=
>> - =A0 =A0 =A0 =A0 =A0 =A0 mask =3D (u32)cpu_to_be32(mask);=0A=
>> + =A0 =A0 =A0 =A0 =A0 =A0 mask =3D(__force u32)cpu_to_be32(mask);=0A=
>=0A=
>Most this kind warning report the real problem. I don't suggest fix as it=
=0A=
=0A=
Should I drop patches 2 and 4 as per your suggestion.=0A=
=0A=
>the 'if branch' should be removed.=0A=
>=0A=
>and simple=0A=
>=0A=
>return read_poll_timeout(qspi_readl, reg, !(reg & mask), delay_us, timeout=
_us,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0q, base);=0A=
>=0A=
>qspi_readl() already handle endian problem.=0A=
=0A=
=A0would you prefer I resend them with the changes you've recommended?=0A=
=0A=
Best Regards,=0A=
Hardev=

