Return-Path: <linux-spi+bounces-11581-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B4CC892A5
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 11:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 62332344D53
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 10:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAE429E112;
	Wed, 26 Nov 2025 10:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fsgu+E5G"
X-Original-To: linux-spi@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011027.outbound.protection.outlook.com [52.101.65.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF372E54B3;
	Wed, 26 Nov 2025 10:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764151348; cv=fail; b=MKjOHLteZ9auzQdwG9YG4ZsxfmAHjo1r9uW9S0inHSZSXq3qCYs/A/0grRHzcR92qCH/FXBBDdXWhiLpjYE8EbH0dAjV8nD6pMYKeLB8YLZAMM2kTxLeobz181aZ5w3h0aHODNOuyerTmz/1i8Q+vlBugdIKIc11Ey5x/bo572Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764151348; c=relaxed/simple;
	bh=xhvLe83GSrsrcxlGmFJE+bqKSK8ZNjJTye1czLb7zqg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NKONv6CfcJG3/gEpGekaettUjT+c4x9N/FNuJdsF9sRFAJZkKRHMj+CTuPQfPLVZc85GpVVJW1twk9hhJAN0vqe3ipFZhfOZzE2QM+bLyTe33zzwDHM6seHZYz2uzhbtWX5p6tbrrRr0Pk9lCi5a6MdiNmnp9iLFwpLfCAQ/Bug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fsgu+E5G; arc=fail smtp.client-ip=52.101.65.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sXM32vnte6owg8Iiw9/XnGdN98vsXclyf0GPsT/y7DAijY9TQet3lONbgsB+VxqRNb1FUkpRjulYhctHwQhDDZNEpXVRqIYpLfxGhPzhMyX7XujuHUMPRXBSrx1Z9l9OMTAwIcjXGWb+3d4NqHCud3xF6+SLeNfMo1B0mqY7rGJaPBOgzD5gXAHgfR3mkryaAVKJfFTpTemRY4SG0t/MVvxoeGe1aNWrOUbG8HPxqKPbmr+6L/r9Lya+dTQ9V6UdjS3zpL/2hslX6GbW4cwQc6DS5YM/l52f1gu1FImBeb2yxu4hHOi45g95qTvbnsbl3Bw1enGaGA6vz11E+jNJCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mg96QbLrlN/EdLEjxlPRbtA8VE2h6sWRuqunYY18NGo=;
 b=O8fa3i4QvLVyAGVQu/clSKHlF1pjHIdEK+zd/mSeAcN4QEIQsRUYK/U53g8G5qw3V05mawTGPZeVPGvT/nja34x5YQdG6ZzbK5kpmMtWB2ER31ljZwT3f4DW0zC2g5Nrr8JSrm2CXZuP6adpCZ//fn//dlMN5wWPvcz6cbfI6L8U2LBc0el3MvuFTKHdfYeVArdaMj6IAge3mTjX4azad+KcUvE/tPQtFQOV6VirxLEQKF1zDQKZor6qbnXe6yXEeD7ZLMWBjpBdJaFJswfgGULeb+Nysb14Vq/C/85nAyjJV2+f4rYZhAUET3CnbMvWBBT2maUWSwMPhvBhg6Lvbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mg96QbLrlN/EdLEjxlPRbtA8VE2h6sWRuqunYY18NGo=;
 b=fsgu+E5GVijHU+bvgKQr32G/SC+acCPq+FzlK3nq6yG7ujNXTYd9re3W2g74S9P2X+Y5jb52kTE3ZCb68nGwDrPKExr1QWLsbDo5kbCwi5smELDyRWeyGJnqImHfOnJWFuoBLFb4pUzOE0BUhCejMX0QmWAHpYSe8FaChJkY4uOsEtD//cuM5/+vFhLnbkdIKamg+LD79TzGHI/oXdw77oSqXA+yOIrOjjSkL6cskhyXvvNVnMgHUej4TwxVEYXrJxjrsih0HDhU5a+A21XNHFcJhh5dy1XzNKq616pYdd4rlcKdByF9gaEWe4jfSPwNcPi8Z7wpv/A3gNHmJPlqCg==
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by AS8PR04MB7701.eurprd04.prod.outlook.com
 (2603:10a6:20b:293::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 10:02:23 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 10:02:23 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: david laight <david.laight@runbox.com>, Frank Li <frank.li@nxp.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "rongqianfeng@vivo.com"
	<rongqianfeng@vivo.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: spi-fsl-lpspi: fix watermark truncation caused by
 type cast
Thread-Topic: [PATCH] spi: spi-fsl-lpspi: fix watermark truncation caused by
 type cast
Thread-Index: AQHcXrvCfkb2RruU+0+KZKhRvXZXAw==
Date: Wed, 26 Nov 2025 10:02:23 +0000
Message-ID:
 <VI2PR04MB11147BCBBD5005DF9AA8F3E9AE8DEA@VI2PR04MB11147.eurprd04.prod.outlook.com>
References: <20251117030355.1359081-1-carlos.song@nxp.com>
 <aSCRFu2koh/w7ELs@lizhi-Precision-Tower-5810>
 <20251122105716.24769251@pumpkin> <aSXHB_CWYZYnQ6ui@black.igk.intel.com>
 <VI2PR04MB111477CFB4C4253842C234FF9E8DEA@VI2PR04MB11147.eurprd04.prod.outlook.com>
 <aSahdZm1KvT0_x8B@smile.fi.intel.com>
In-Reply-To: <aSahdZm1KvT0_x8B@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2PR04MB11147:EE_|AS8PR04MB7701:EE_
x-ms-office365-filtering-correlation-id: 5ef38b99-89f4-4420-ab8e-08de2cd2e523
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CEtBXp42FMTAzT30B1nPAWWnCx9LDN+pjOHs1qoT16j9K5HQq28ig1TeQ5bU?=
 =?us-ascii?Q?qVnlVksqwEoTlq1umH3NS9YO1F23blOfCd38fGrfCHBtSxydckNHmD6U3Vay?=
 =?us-ascii?Q?ZztoDEK2uRH8rSiNDpDyaBb4w0A4Z5z3K5GTp1ll/AmqYkt3+nw0dA5h0NXe?=
 =?us-ascii?Q?WOFpyprWPovZlSbuTuTxR7eb9bWh3Pi7vDqwoXdsJA7eBVOqsKrVLQpHnrhg?=
 =?us-ascii?Q?vb0mz4eVkH1megaHbYAvsTuptds7rLs1JXswvazl1/d0KDr+Pq0fvbIzn2jo?=
 =?us-ascii?Q?L+JExCe6/KNmsmKvfxlfO+PqqCrp+eJFE7bv11vHJMC6xTeQ4CF+4AGQMhYf?=
 =?us-ascii?Q?fXwwDqAClXc8bOTG+sz2MBSCeUoNLx9Qht+wNoJMlO5XPWdvhctaKnNKPJJ0?=
 =?us-ascii?Q?22xtc+dFzF8ht+LpzZ7+YA4zklC/M1+Yrp2ijLfvDBtPUOOk5ZtVGBHjGn03?=
 =?us-ascii?Q?dX57k9YUxkn+MkS1B4LJdgWF6TV6NKPNO1LmXH80bWENfJYTjItz3WjLDc8H?=
 =?us-ascii?Q?mbBQGH8tNGezTfgLADS/NMpYeOFfDCVtL6rVpwd9/P/1Zgqv4zh3aNNFxwVq?=
 =?us-ascii?Q?f4g2fyhq5oJNO4FoNEyif+zoy21VtiSyiLW1B2C1jl1Ipz5UvIJdwe3TLIg1?=
 =?us-ascii?Q?uBMiblDwFNV863Arfi9ndfqzHZB6BQPrRttmi5YzXqPyks2JTC2hYuLXRdPR?=
 =?us-ascii?Q?GBrmqV7qvsayqkY0lawesFS7pQtyfyDval/TSD3Q9WlxA0j6UGuu9saTZ5/A?=
 =?us-ascii?Q?D4VtkGuJ8eHAGLqSlC4LfzAx1cw3dB/4dARicHETTWOA8woEHgtr3WMVHCRV?=
 =?us-ascii?Q?WyuUhSdqLrXK3dROqLVIlMPTzXxvaFBlfuyIoOxyyCcO+vRiTK4IYz6k6Qft?=
 =?us-ascii?Q?T5GwZrmszHxweO6yEKclBNwR1S1/YDE6oRkz6ySCI8DIC9NmkmuJN1we2OWh?=
 =?us-ascii?Q?dFHfqnq5FlIPP5lrdTLNkr/djMLWqJo0xoqayFj3s+IWBJw5VWhgdQ7YquDI?=
 =?us-ascii?Q?/NPXyAWQ4JK6FoB5EDOZmcQy1H6gFdJvJQgOZGxw9dGqCS4a4CXRjYMHVAL7?=
 =?us-ascii?Q?pKtXdR2tMsUwK1me7fPP+q+eoSaLnLtENHauMlIrLSXgsASvrJKh/hZHaQEu?=
 =?us-ascii?Q?sscPmlMHauKfcghi1XbbtQQpfMuP/lE136asN2Gpd5a7ybfERN6fXAWy8kiC?=
 =?us-ascii?Q?lWd7EyfOhPL3fS1BFOa09cEoAIYK0YM+ngfpM1IpNixEP/2odBQLPXbu8rhg?=
 =?us-ascii?Q?e/wA7cA/AVnUrMpBfRqrhCQ5U6/wsxCCIdx2fPmjidGSe9SdzHraOgpKMcyV?=
 =?us-ascii?Q?hnpLDRmj9wWeDYflSH9Ef7WMWdqUpQh6JMlJkLOwbiPkWsT4Sg3ScVWh4mjk?=
 =?us-ascii?Q?jzSXkKdfkDyZMtPUeMAm0+EKRwQNML24GGaM0QXtfgngS+PQB8J5lhbzRlnY?=
 =?us-ascii?Q?kj0R2aqbxsphhRSJzDmTxY7YjD1H+CsB+Eh0V2sp0l+EaQXO5uPk/g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HHYU+DlaEzARXxOIDAUzxLMmos4xHY9RhApPMcm0y424L1vrJ3u6u3WdfxBT?=
 =?us-ascii?Q?Xa5kwKLXqYWm1sa/t4HnhvbvlcCV8a0KfPdWrnbAUMtpTyjl+7D00505eHhi?=
 =?us-ascii?Q?B4YE4Krw7yQJKoqHyduwx46mkR+ySR3KDPlDpIFGCP3GyuYUvosYgrUYeIs7?=
 =?us-ascii?Q?380USD3qwQHT0q0IvZ7VX70I0GYORjsxgqc2OWjCijHDvArprcb2W5LjBOlI?=
 =?us-ascii?Q?eGnd57I23OYj29hdjP0xEQR5aVCbE2xJpBUgFcpeM7NjRqkODNjRuP1I+MOd?=
 =?us-ascii?Q?kNZ4JCd8Jufp5gWhMeWnnztkVMN5HltwNTnk/E38L647TUbMbz+ly+xxWFLq?=
 =?us-ascii?Q?eqx1PhqdOXXbdkxaFzKI+W1YQZb0/Yt0/7QfVuF1+7Dz4ehCICCDYbP71l04?=
 =?us-ascii?Q?W2gPQfzLxLnaqSo9vN4Ntt1ESRNsaLwNzEoDmDFqozmVRyXgoR0AvuMCXVe6?=
 =?us-ascii?Q?LQA33gaO+4ic8iTqvROB4MhbJjbB/Sb+0XWzfdtdBp/QsCOcnNuZvD/bsrF6?=
 =?us-ascii?Q?QrwS+u2z5hxW9G463ZV7rTUQ95jsfxyO0UKZRlF73bSkHRe2aFmGwcggPB3v?=
 =?us-ascii?Q?VjmzXHsJNTQw+NE0Tdvf49psoGn6SqYei4qdvRtD7FkARoIBxvVQ2AnAcRAP?=
 =?us-ascii?Q?EJZeqCsxAdDqwiS6SdPbr1Q3+8iJvUox57jXMytMW216B1X5QUjz5Q/3xEyS?=
 =?us-ascii?Q?jIlU8Uq4X+SYOTR6raNHwptmw9M9tbTZkRKpvHjRyU2l1ejoKAXwCAOMr2tg?=
 =?us-ascii?Q?+QDtLauwAA7B37kLXTNORgjk6UfgB84r6898kxTCOmJsgwBpfP//cvwnr4mT?=
 =?us-ascii?Q?TlGcuL+rjhx0EJb6Bo85iwXRNINA8Ce+Tev6geosel6eknKEzrZp6k53ycqx?=
 =?us-ascii?Q?lT+HH7b02AfPyzwJajUkXQuQ86bpFYY6C0FDtanLtRADqyk44R4fjG438MFO?=
 =?us-ascii?Q?8oGsCpjsbH05GlnKsgqUzVuhMqk6YYNdql3TVhK5wkLNmFU1o5m+zbp3nzH+?=
 =?us-ascii?Q?4QEpvoAp8Kn3QP/KMxjiZU01rZfeB180ttEy0oQRwkYvdzR08BGAGeFZ6CKD?=
 =?us-ascii?Q?GYNb8Uyy2ctcdB+h6Tv5JZ3biGAMgfoslND1u9FXQP+tblUzoKYjqhRRfsEQ?=
 =?us-ascii?Q?LrnVCsJlAFPg1rYp3ymGatAO0TuBvUiZXkGaEFUkJFsAqtNvuijTQ/ueN36o?=
 =?us-ascii?Q?/PNCoLwoAdIKsdAKMnS+umcXp5VVt0Jsc0dgVdi9jRr/xOfrEiAR/iWQyWls?=
 =?us-ascii?Q?STuTBy96yiqqAU55EES5m1GI/Y5NDn56N/jIoAs6ls5BPYzQpxjieQeX/mq+?=
 =?us-ascii?Q?3e7uA8c/d1x216Ay+FOwgVJfJPzBkCwjvnlfz+gq6WkOEFZC0ATeH3vYOvIO?=
 =?us-ascii?Q?M5AYRNQeOy5PDWDwSFZe3YU1sjOdnEzL9yl5cVbvKklM56HgwiZ+x97B3ltV?=
 =?us-ascii?Q?592r7F46477rQMHOcLPHzXmQlthMy4xX+TqsPoo9O5u3rCaA9rxwm1dyuyrF?=
 =?us-ascii?Q?D2Gjnnuy/6B/BTfgHgALZ0ILS73YImFznKR/mc7xbYmNeGcrvoP/PNpn6hZh?=
 =?us-ascii?Q?5jS+Pe/mHie/HnhH+7AlGMYQoqzYmS+gGjev9q4d?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef38b99-89f4-4420-ab8e-08de2cd2e523
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 10:02:23.1792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g/RooMqQ5x1cPvXaDQIIxXycbkBpFt6/avz6Ru3AWPOv1tNUZdcGXpdfu+uF5Hr7jn/q7YZC2ov5iQuNH39iRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7701



> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@intel.com>
> Sent: Wednesday, November 26, 2025 2:43 PM
> To: Carlos Song <carlos.song@nxp.com>
> Cc: david laight <david.laight@runbox.com>; Frank Li <frank.li@nxp.com>;
> broonie@kernel.org; rongqianfeng@vivo.com; linux-spi@vger.kernel.org;
> imx@lists.linux.dev; linux-kernel@vger.kernel.org
> Subject: [EXT] Re: [PATCH] spi: spi-fsl-lpspi: fix watermark truncation c=
aused by
> type cast
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report =
this
> email' button
>=20
>=20
> On Wed, Nov 26, 2025 at 02:10:25AM +0000, Carlos Song wrote:
> > > -----Original Message-----
> > > From: Andy Shevchenko <andriy.shevchenko@intel.com>
> > > Sent: Tuesday, November 25, 2025 11:11 PM On Sat, Nov 22, 2025 at
> > > 10:57:16AM +0000, david laight wrote:
> > > > On Fri, 21 Nov 2025 11:19:34 -0500 Frank Li <Frank.li@nxp.com>
> > > > wrote:
> > > > > On Mon, Nov 17, 2025 at 11:03:55AM +0800, carlos.song@nxp.com
> wrote:
>=20
> ...
>=20
> > > > > > + /*
> > > > > > +  * t->len is 'unsigned' and txfifosize and watermrk is 'u8',
> > > > > > + force
> > > > > > +  * type cast is inevitable. When len > 255, len will be
> > > > > > + truncated in min_t(),
> > > > > > +  * it caused wrong watermark set. 'unsigned int' is as the
> > > > > > + designated type
> > > > > > +  * for min_t() to avoid truncation.
> > > > > > +  */
> > > > > > + fsl_lpspi->watermark =3D min_t(unsigned int,
> > > > > >                                fsl_lpspi->txfifosize,
> > > > > >                                t->len);
> > > > >
> > > > > There are thread discussion about min() and min_t()
> > > > >
> > > > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%
> > > > >
> 2Flo%2F&data=3D05%7C02%7Ccarlos.song%40nxp.com%7Ce0e6b6d0ae23480ed
> > > > >
> 8c008de2cb70f79%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638
> > > > >
> 997361915264343%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydW
> Us
> > > > > IlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3
> > > > >
> D%3D%7C0%7C%7C%7C&sdata=3D%2B4ARYhKtpMih2eUExScbLgjTTbm2%2FmkR
> tF%2
> > > > > FesH0M5ZQ%3D&reserved=3D0
> > > > > re.kernel.org%2Fall%2F20251119224140.8616-1-david.laight.linux%4
> > > > > 0gma
> > > > >
> > >
> il.com%2F&data=3D05%7C02%7Ccarlos.song%40nxp.com%7C24c955c5ab414a26
> > > 730
> > > > >
> > >
> a08de2c34dda3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6389
> > > 96802
> > > > >
> > >
> 735067934%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiO
> > > iIwLj
> > > > >
> > >
> AuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%
> > > 7C
> > > > > %7C&sdata=3DNEBirtRBR5RXz9cUXuqWVtHT6b3memVhsRe5mA7AIAQ%3
> D&
> > > reserved=3D0
> > > >
> > > > The big comment even carefully explains that the two types are
> > > > unsigned
> > > ones.
> > > > So a simple min() is absolutely fine (and the comment can go away).
> > > >
> > > > The old typecheck in min was just so stupid.
> > > > In this case the 'u8' variable is promoted to 'int' (they always
> > > > are) and then converted to 'unsigned int' to match the other type.
> > > > Even though there is an implicit 'int' =3D> 'unsigned int' cast it
> > > > is impossible for a negative value to become a large positive on
> > > > (which is the only justification for the type check).
> > > >
> > > > I'd check the file for other uses on min_t() as well.
> > >
> > > Just came to this thread to echoing what David said. +1 to the
> > > above, please convert to simple min(). The use cases for min_t() and
> > > max_t() should be rare really.
> >
> > Thank you for all ack about this patch.
> > From my points, min() ot min_t(unsigned, x, x) both are ok.
> > This patch has been picked, do I need to do a new patch to use min() in=
stead
> this patch?
>=20
> It's already applied, so send a followup that moves from min_t() to min()=
.
>=20
Will do this then. Thank you.
> --
> With Best Regards,
> Andy Shevchenko
>=20


