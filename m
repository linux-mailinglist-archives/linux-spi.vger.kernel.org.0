Return-Path: <linux-spi+bounces-10708-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A19F2BE602F
	for <lists+linux-spi@lfdr.de>; Fri, 17 Oct 2025 03:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 688601A6621E
	for <lists+linux-spi@lfdr.de>; Fri, 17 Oct 2025 01:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17AA4749C;
	Fri, 17 Oct 2025 01:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="SBmPWDWb"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022072.outbound.protection.outlook.com [40.107.75.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E9A21B185;
	Fri, 17 Oct 2025 01:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760663113; cv=fail; b=QCH/qahGCYrHq97QynXGSy8VMgZn3uf/P46byFRTVZajnZSXY9t2s+Dny/MKX+V1uYdk+U02GH3aeYuH9F2nFyvrWi1DAlSoXUffqFlkBOpibBjPNOVJUfz5OjfDoI6w6N6ZODSRFGFS7J9BbQdVhGKqPQzC0TNxMzcRDMeVREs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760663113; c=relaxed/simple;
	bh=5eTNnl1FxO2YXcSMcfGtjfowwXs4bJHuW2SIk10LB/A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dCead2KGXiIc1e+5LvlmKvg0w0izFXkTQth16elgu6EXboFQ/OVrdyDHistWTOXTOD3ptInm8TeBFT/YoEyRpGi2xdUhKHzPmJEqDbWKBiGUCRommGDAsGPfyyZbpkefa+kjCsLHwF00GxxCR/qAKu5Oia9I73YKgef2jbPFl44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=SBmPWDWb; arc=fail smtp.client-ip=40.107.75.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QrNkOcjXZbZAcsT0itUEiA0vm+m9A4zV5tyIPH9pFhjnyJ9wYg6ZNZFkMxjKgLkMvqYQqe3WjO7XDwD08E7OMq9YOnwm0g1a5FErLEpf72uDuDDl/DEJZB1UGT9koqnnuF7NZHBgUf8eGVrVoiLZ8BMheD5fJmNDzb+KBix1Qu64gWU5GKfl34iOJCzQ0grSTXDIhlwxHoHpYi42yO27vGdVaMTIyMa/mdJiOo3KaKd4csGGoRfQX4m+U3ic3X1UGYIECf8FMOJ970NUGnyDpF9iy7OmBZR6sdKFvgAZDvSf+OXosNSMcWS9rWkYoc2ssBGM/8zJn4OFL7cTnsFa5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFw+lw0iImvFiJqZhwThHkMmMSFoab+JjP06nNrTTnE=;
 b=LDWYDz3eBSYRDSpPw/XVKs4ddeoaU83aglOgHbeW78pSjSK87HxMKgPoEZ0lpbbYPNGBiItsJPwQgkA/53NThYHA1kwfVegeepPA71XdXEdnkCDoDimsgrfmkdJS00HtaX/5d9+divhTji/aIMdx8ZAoM/K6k8DSI7HrV+P9AiDRRS4VWzvqGZsaOnCWSVyzxcHWXsjA/9xD22F0oUBsA+OOO5NsDMUaslEDOxU/ZLKG6xGdx7eV7H+Bl6F5SFvQUZ3zwvCbW7UTPUuI41bnxtzif1swerShAjU4U9hWxIH2Otpf98CkbxXm9S7MQW8ThoetwP4itFoCRTVbCjmz6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFw+lw0iImvFiJqZhwThHkMmMSFoab+JjP06nNrTTnE=;
 b=SBmPWDWbhN/XLsUKg2ZH32GpKDo8Xhx0BimuMMVvsNnxi4kEsjmfcXv9fjDA3dkcZl5eFq12/3Krmm2wdBobrTKhBmYIazz/jlkRUW68rIWrm+b0EB687x/5EjEZGVqh73ldDdG0uhkG/G0Yge9yxivs/rrOUMOQIPKnPVUzAV8j4x3qGytXEcjmTtf43NLMCaQrNYotKaQLb/FI7CNWobENvI2B2fFXKiqixFVkb0kEcUDszFx/knVZfJlRRa1TMBmLU/b+ACgyRUcs72Ybk7Y49v+lhtXJxh+JTGPBnMT1WEH9ICZcC3tr7KnEHeLlJeLPpHJpUwXawzhFww60Yg==
Received: from TYZPR06MB5203.apcprd06.prod.outlook.com (2603:1096:400:1f9::9)
 by TYZPR06MB6076.apcprd06.prod.outlook.com (2603:1096:400:33b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 01:05:06 +0000
Received: from TYZPR06MB5203.apcprd06.prod.outlook.com
 ([fe80::b7e4:5d25:213:ef9b]) by TYZPR06MB5203.apcprd06.prod.outlook.com
 ([fe80::b7e4:5d25:213:ef9b%3]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 01:05:06 +0000
From: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
To: Colin Ian King <coking@nvidia.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
	<clg@kaod.org>, Mark Brown <broonie@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
	"openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][next] spi: aspeed: fix spelling mistake "triming" ->
 "trimming"
Thread-Topic: [PATCH][next] spi: aspeed: fix spelling mistake "triming" ->
 "trimming"
Thread-Index: AQHcPrHD+qVep+JgCEyp5ortgF9RDbTFhaRA
Date: Fri, 17 Oct 2025 01:05:05 +0000
Message-ID:
 <TYZPR06MB52031BFAE4FE115EE986FFA6B2F6A@TYZPR06MB5203.apcprd06.prod.outlook.com>
References: <20251016153000.9142-1-coking@nvidia.com>
In-Reply-To: <20251016153000.9142-1-coking@nvidia.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB5203:EE_|TYZPR06MB6076:EE_
x-ms-office365-filtering-correlation-id: 86ce1b5c-a39d-4eb2-05f4-08de0d1935b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?9rM2XhEz1fROR5mtH2BxZ3Kjds/uv/3fIINufXmqpTZqTJwzcb+zUVfzbS?=
 =?iso-8859-1?Q?a6VpTqGh0MLP7i0I67SWLit5oRIfgwX6eqKAl2V28Fu0O6A0Im8bo0L0Vk?=
 =?iso-8859-1?Q?MREsp+80O8PspDiMTGsA0bRkYEMSLwRXGhvyWYLD6FCT+hywpXMJeO3dPQ?=
 =?iso-8859-1?Q?Kr70BVezkDRsuhNB98YdaVclzy7FMW51YUi9IjlB7Uiyiral8vVTwnYlgE?=
 =?iso-8859-1?Q?t+Sxv84MFHl3f0MDIY7NLsew3NJiy+kKWk+I7XxZfZpVoq/Mt1eIlmAl+F?=
 =?iso-8859-1?Q?FenBFxlDp9/2zek1K9MtZOnkbhPS3vQX/fqq+JjVeu8qbildNoVg6nPkhk?=
 =?iso-8859-1?Q?nHVbHXFXhIM9TkYH1je/30FMD67NEWr1dfBL6uPE9YyWsiAvclqFuLRqmH?=
 =?iso-8859-1?Q?juxcqQ+UfMj4LooFRM7Ei+3raDAAZgykrqdqf5qbVbZYrM8DJpUNrleTqo?=
 =?iso-8859-1?Q?x2+RpjxzMxUZf7U0rmAp9D/IG6w2PHPxjbcv/Rb1xdGIcOMYyGJboV2dN7?=
 =?iso-8859-1?Q?6JBcxqS+qynK1jl/rBvdMSrw0k75isc5IJNThnahKRbrVHF85gl/gKWV1+?=
 =?iso-8859-1?Q?DZu/704vKmbdIP5uiRG5FtxPUEUckRrMSVn9cahr/Hj5//hnJDyEwoIZVp?=
 =?iso-8859-1?Q?0VL9u3c4XWsvSZfApYI4YktBuMu9qnbxxqKQsmzDUl8pfMMmZ1I+ZmfxjL?=
 =?iso-8859-1?Q?ozvZDFWoOVkp34NxMrJJzfclK8cIui9yxjnDYEQzatP9rnVzpp6U09jbnQ?=
 =?iso-8859-1?Q?SaPEv9lP/mT/4V5OwycobffIb8u1jbB/W05MYRVsR1W/Pykh6HCQnwXY66?=
 =?iso-8859-1?Q?/Np5gNbORcFwChVbm62AoIMsmL7A1WRInFUUfwp2c9XiNHx0v0uaY389Yf?=
 =?iso-8859-1?Q?3Gt8LBEbyt3f5gOIQ4+SIkxIcH5HjBWHWCJ3I7WcnJ7FJzv0ynolrOwLm4?=
 =?iso-8859-1?Q?+oRKv5snppVwSbjYkaN+4eKyK5LuiuC/q1bNVByEhvyA/ZJ75GEkurKiyj?=
 =?iso-8859-1?Q?FvbtnkEvT1/A5YwUMeat0Gm6mAGPZkkvDmW0cmf6oK2oRrBxiC5+L8JIiX?=
 =?iso-8859-1?Q?6bz6nFmEynriojUfdMzSm0s2do45rl2Hi2FhrkXQIMy8MBQf0ydO3oPSSd?=
 =?iso-8859-1?Q?DlZAypaSze0orow8KfmCWfYz2NJDlt902mqtQ41reIsxs+1vTPF3tXnXMS?=
 =?iso-8859-1?Q?mvLMmEpflb3cI/dKjSrYAXo9jH9LxqPqjHd/ZHEFwTr1c+fJ/EWcAFfXAw?=
 =?iso-8859-1?Q?9ld7FF4CLciKXhgtFqOGvCejSoqNUiGOzLzcX+X2sTzN7O+UAORoxWR1xn?=
 =?iso-8859-1?Q?FvJvfRT3vosNaTfLytXhY9mUkBDB7VspYZTDo2zKTPXec2S/gtRE1mGzYH?=
 =?iso-8859-1?Q?mU7Fuha5aq6vyMkfd3EXINAJN8sUTaSpjZqWSmpoTPjvrkw3cdvonUdzG/?=
 =?iso-8859-1?Q?avnJjsbk8QHc3CbtrnHoxm8h4hRFGUuc4lfU/1OUcy4QoHZBPqB4OYylt1?=
 =?iso-8859-1?Q?jeZwQMFmsDiP4BPYBYe7I6+0cnWRGuotQgFMqLFAfPi1TzUkZW2RI8hgwJ?=
 =?iso-8859-1?Q?wW0ZQ8trPyXUP6ZaMKMuHA9d156g?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB5203.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?p5tzW9W3GVqq+V7csUZbhoe7joUTuVxLfYvOFcQzwRuzZk0mrbAoly3e/H?=
 =?iso-8859-1?Q?qMff4QnK6TLJ6JjAF+ffuPm6aMQViCXJiu3UheECEuEBkRSiDpJYH+21aQ?=
 =?iso-8859-1?Q?3qODirH2eUjDaXI7W8G6PORLZSB4YNECiQ7hvHHT9zzo3tw0k9y7HmMrwa?=
 =?iso-8859-1?Q?ohs2LQEVEp4jz8zFnjqUinE9XIpz5YPhGoIqdzDPqI2L2V6fpeX5DnFlAs?=
 =?iso-8859-1?Q?RNmh06TmedH2z3OVe0TADeSjikolNPRgEvnCuSi7CFDSqdSTPCA6QD/gIV?=
 =?iso-8859-1?Q?E4fX//glFTUwq5h6eOFp0TSS0Y0guWXQXMbspKemmEEuSTvsJqIOJYOqHm?=
 =?iso-8859-1?Q?VA3GCrn2zT1dUwRFWhahDyGPg5l1sCdhgGziRZy8xR9bHlpSqpgkO/93h2?=
 =?iso-8859-1?Q?eGf2ZFbKoiieWrM3CLJwHBxRnM11JFeM/2esnO2uKY/3Gw6yTNXP22BRQ2?=
 =?iso-8859-1?Q?GFiazbXyIoxsFdGyfakwmtpj+IuxVFsgx3Em0Sd2JUGsoFVltQEz5JbOFr?=
 =?iso-8859-1?Q?rDgyz/rIwhgkFBMAKDlgBXEyM9JAZt2RCpn5rbiq4MaHu6ntnROPwvxIeZ?=
 =?iso-8859-1?Q?8c1OrCCrb5F7WJUtao2gO3YNv+V2OQAGUmSavNCpqkyAtsoK+D4v8VEF+U?=
 =?iso-8859-1?Q?oLPuSjQn4IVJeC5H/aZ6uBgf1jPt4L7MhsqPEMPMlE6IQuwsgkUGdBOiIt?=
 =?iso-8859-1?Q?PhBCiE708CY34GlAZ7Y3KBIJeSf0i1MUMui9lzzu1dbKA4i5HcEPJ0RIrh?=
 =?iso-8859-1?Q?lVPk/ZiLzWWIY0HLd5+ty4tpyecjivWhQz/FfU9JBGBMEzhdHh3b6B8Xfa?=
 =?iso-8859-1?Q?4Zen0W7tWRonUut+LnTWd7/RVSrn8g4pR1YcyIiNhztuneiHQvwzgauI5k?=
 =?iso-8859-1?Q?Ql23w4IkegcMLJ+3aYt4H3nVgBIY4n/eicVvoi5VU8TaDQs67sAS8h/2LM?=
 =?iso-8859-1?Q?IuiFYaHifh0omS5nwrAF/tSnVQtXPejw00RfxZV9yccSyAPW5BaHZb/q/R?=
 =?iso-8859-1?Q?iHlV+ZUPUgb7HuHNDB3WnQf4mIQBzDhDuDgqSgHcG2HbKLjEX2EWSkA1cU?=
 =?iso-8859-1?Q?sjVy6CG0pXvHmc0IFOTfk9I+zi+i6wLWkoC+o0BKsJd1kesHa90a1M6KDF?=
 =?iso-8859-1?Q?5+tNBeOIqYq4cBAX8v+0S1s9fk49KnYv6dFQij1Y4sId34CMmq/ujcDpYF?=
 =?iso-8859-1?Q?c4gJdTFSaRMDTk82nL/O7liJFL8p+mH9vxmuE+kvBpPoxmfBw/U3sbMiPW?=
 =?iso-8859-1?Q?q8XATKv9yjLf9mBnSRh7YAbBISOxmg0kmuwLPdDfkWh7zRtdL6brytoWmd?=
 =?iso-8859-1?Q?w6Yznfcc2G06HE1DDvEZv17OYCFn2/UHeJ9ymyJLS5c5dAl2qpfSaepQBQ?=
 =?iso-8859-1?Q?KbkqyKCW23MUAA+4Yu/VKimPXXmv8oIMxzkESHhheEgYcCMHfQ4RbxGnUz?=
 =?iso-8859-1?Q?btDTtr262F6AZjl0p0VD7caxiKD80FrHL1ZrCk9WWEx/otJT+ZaQnGbH9Y?=
 =?iso-8859-1?Q?XML5QgmFNJe9f6tLieIiAdZLyLcwSiofBbCvuO+wkOHi+riqduimtCxtBb?=
 =?iso-8859-1?Q?Yl5OXpiEtwOJ3CRzdiZ4CXr4Rw/RXWRIa5B+Ff9FLXbE7hHQ5x3v8UgnC3?=
 =?iso-8859-1?Q?4dcnOalrFNccDbOsXYFR7EexZg+gbL4/7xLqTmDzLEPS5vPifkDwJtMw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB5203.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ce1b5c-a39d-4eb2-05f4-08de0d1935b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 01:05:05.9016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6vYEM0qk+NtXWu6uZ1JccNkKVznrXZQuY2GJSLh6e8WHV30weKOt4p4RWHZWALefzF8YGOwUZxmh76+lgqzicwKYSM3NaWiBVfetr7n0v6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6076

Hi Colin,

Thanks for typo fix.

> -----Original Message-----
> From: Colin Ian King <coking@nvidia.com>
> Sent: Thursday, October 16, 2025 11:30 PM
> Subject: [PATCH][next] spi: aspeed: fix spelling mistake "triming" -> "tr=
imming"
>=20
> There is a spelling mistake in a dev_warn message. Fix it.
>=20
> Signed-off-by: Colin Ian King <coking@nvidia.com>
> ---
>  drivers/spi/spi-aspeed-smc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20

Reviewed-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>

> diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c =
index
> 0c3de371fd39..f3a7189afd51 100644
> --- a/drivers/spi/spi-aspeed-smc.c
> +++ b/drivers/spi/spi-aspeed-smc.c
> @@ -539,7 +539,7 @@ static int aspeed_spi_trim_window_size(struct
> aspeed_spi *aspi)
>  	} while (total_sz > aspi->ahb_window_size);
>=20
>  	if (trimmed) {
> -		dev_warn(aspi->dev, "Window size after triming:\n");
> +		dev_warn(aspi->dev, "Window size after trimming:\n");
>  		for (cs =3D 0; cs < aspi->data->max_cs; cs++) {
>  			dev_warn(aspi->dev, "CE%d: 0x%08x\n",
>  				 cs, chips[cs].ahb_window_size);
> --
> 2.51.0


