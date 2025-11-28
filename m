Return-Path: <linux-spi+bounces-11652-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 196E0C927CD
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 16:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 93842343ABD
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 15:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCF4236A73;
	Fri, 28 Nov 2025 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="C7dlTDTB"
X-Original-To: linux-spi@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAFB22FF22;
	Fri, 28 Nov 2025 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764345356; cv=fail; b=k3db4z33065Hg6Y9nbI2rdtsa9KZqwpXsQFYbb8r0ud+WHY85yLKDGayZvEoNwgsY9qKfDL2Ll6yqYOvyD8n1gPchEyyhgsSxcmxQ+vD3+xwTxuEj5qe+qGVdOXdNRUohHojmieKOFWLa7NVPf8IK8arYyXNPzn12uWuTsVDOhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764345356; c=relaxed/simple;
	bh=uvnCq72xieAOT9OP6GdOKawk87ApxbjcGUUc07J/6r0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZSS5PFKZDRc+AT/RTLGANMQJZq/YzcOqe1lxiaGKMPONmhnxrpjX6iGzg5B3PEbW9UDxn1azShLa42eUicd6DYRltOe/rppycVUPeTLmNRVoWMfByqwy6ZCwJiWrKYzXtf6KUvH/5AKe9jpm4+H35++AWwOGg0YR3WTy6b0OKCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=C7dlTDTB; arc=fail smtp.client-ip=52.101.62.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFzm9LzIgwvmVGIAn4Zf9mhKfaLIw2NmG+a3AmNxLO12/GDzWvO809YsafTj+7VDaxOkbNJ2cg7FGk6CxH1hrdSrc5T6uSkPjg1pakLFAErkDWUP1d8OUYzPpVvAB/u3OPWfGnh/sF9VagCP12s9tLw2QnDnMqy8+U1M3w1AzTsLfDr3X9pAhQvceXD2Q7J2IzqKFf8PYRNj9ZXuvrC4ApKQqLU9d5Ab685z1udnfuWhWTOfGiB2jpcWOlm+1WbE3aflkjRDpoYsfeP8HzG7X2RD6ArPcI1Khgh/jPVZ6ToWaQka7iT4FMVk0Z3o9VabWSfMK79BoJHyDv3XzTSKdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uvnCq72xieAOT9OP6GdOKawk87ApxbjcGUUc07J/6r0=;
 b=qDj4nUQ9GVKoDtsNg/4mf4XAwFDu1SKfhxlVsSiH7J7I0MLrmjv98+7e0+V1ZLQqnsN71YF9RwQgn0CpS+KyG/oOGG3oCIIgiGhhALpqMXL4wTM91NC8WrW9ot7YnyQOVHzA67eBXjeIMonxQVXXRs4bUV8a68xml7xMK008YnNWvh5o/seGGQyOX+U5ejOUDCiJftILFGZOlluSDlu5zpE9OwMfmafyDZtglho00vgHOtTeji7F9Bt4ybCFx/lJiR3EEEkw3lO2eNNRoXosesvJ95KQFCgacCIieZLObdMpyk/y9q/i3NqRhudIyxHPeXMrw3fbt5nBnT1rWPW1ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uvnCq72xieAOT9OP6GdOKawk87ApxbjcGUUc07J/6r0=;
 b=C7dlTDTBxx7LcnJDDRC3koUDok6qRVIlSLmdeTkABR6JsfP40Mpqbx8A9JB4dAaDenoQbRTBIjIMYmiLC2R+1r3gpyR/H78lZXA2j1+3nMx/hw4twJc9EqUdtZT0ojOxr6QkfYnHnUyq9T6bNyx+tAhk1K/d/5QyGkEvSAWrIl/H41GzhX2+WsWTj/bjBB7V2vM5+IQnhIqjj9ILBwrgCiJuGNZ+pEIp38tvK1TBkDxvx2ucsYWvFn1fOxtti2AWrAQeUHluFuWtatqezF6dM87tAM7eZSAMUYAlmFiD+f5BHLbvF2KZfK8N7fJxut14d5Osu9DjO2X9chhzXjuC2w==
Received: from CYYPR11MB8386.namprd11.prod.outlook.com (2603:10b6:930:bf::13)
 by LV3PR11MB8675.namprd11.prod.outlook.com (2603:10b6:408:219::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 28 Nov
 2025 15:54:29 +0000
Received: from CYYPR11MB8386.namprd11.prod.outlook.com
 ([fe80::22ac:bfa1:678f:f510]) by CYYPR11MB8386.namprd11.prod.outlook.com
 ([fe80::22ac:bfa1:678f:f510%4]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 15:54:28 +0000
From: <Prajna.Rajendrakumar@microchip.com>
To: <andriy.shevchenko@linux.intel.com>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<broonie@kernel.org>, <Conor.Dooley@microchip.com>,
	<Prajna.Rajendrakumar@microchip.com>
Subject: RE: [PATCH v3 2/6] spi: microchip-core: Refactor FIFO read and write
 handlers
Thread-Topic: [PATCH v3 2/6] spi: microchip-core: Refactor FIFO read and write
 handlers
Thread-Index: AQHcX9Af6NbjthqNa06lUqBqYJmOobUIH4ZQgAAbPICAAAMe0A==
Date: Fri, 28 Nov 2025 15:54:28 +0000
Message-ID:
 <CYYPR11MB838630D2647A77E25E1D55BC90DCA@CYYPR11MB8386.namprd11.prod.outlook.com>
References: <20251127190031.2998705-1-andriy.shevchenko@linux.intel.com>
 <20251127190031.2998705-3-andriy.shevchenko@linux.intel.com>
 <CYYPR11MB8386F204FAE5BB6220944DDC90DCA@CYYPR11MB8386.namprd11.prod.outlook.com>
 <aSnCNVwEBKhbppvA@smile.fi.intel.com>
In-Reply-To: <aSnCNVwEBKhbppvA@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8386:EE_|LV3PR11MB8675:EE_
x-ms-office365-filtering-correlation-id: 11ffd077-8dd7-4c41-d0f2-08de2e9669b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?9qg24tXFTIkvZ0nx/PrijanLB28mKtgogoFTlBsmmYr5lNvx/d7dl3U7wkrV?=
 =?us-ascii?Q?y47uAy935p//9gxEVlil5qAiuVO+5AD9hFkf1EV5hGO7J2wjgjrT0HThH7B7?=
 =?us-ascii?Q?yVhvAVOytie9ZVtkzGTopgQImWly0nxs1JLb1iStTrgRDX5o/SirMoLNiFAK?=
 =?us-ascii?Q?IpTjdFsndqtm1XtNNRqrbzPorCXBnnaTNrkeMwFL2FeVHQJv0bXzWUorGhzO?=
 =?us-ascii?Q?PcRRHtfAOBI8L5d7B1N3rLn51ePcQ9LKvob+fbPmTdi3zxbxRA/MsTCm/GaH?=
 =?us-ascii?Q?6+xrjzUvFpYgL3MihrCAXxKl5TckBccGKBzpxaIQ1bPpTTpFEWwNBlbAPg+J?=
 =?us-ascii?Q?8uiB3EjCiWnkDHc0UzAcRv6FZp/hyIfXSDuE2V+7DlhoMco7ok57tTW2kC1J?=
 =?us-ascii?Q?LOnJVpzuPo64dCOSN8UzElHSc7/tlOEkeQ9nLdKheDYjUKJMt1aV8E0sF475?=
 =?us-ascii?Q?VDohfM5IaczqhnJKBmG5inT2sJ0vFIRNTyvIrS3P/XYdyLQ7akECz9+IHQ+u?=
 =?us-ascii?Q?np2Kx4B06+WlCpJLl7K5d2urEo0dg31uZOn4yCFHj+9YrHlo8zpgMUKyv/aT?=
 =?us-ascii?Q?QMND/r0aEA/Hl1PnJaYBAAbt/U2UOvpOarD20gf/g4GR4HSbASeeqGQfFo0X?=
 =?us-ascii?Q?6v9IEm6LuNFkOE7PfvLbZSQCfhavD/Z53D3vVB2yVss+AKITeK+zq7gtKhEm?=
 =?us-ascii?Q?HWFXDZvJnRnQDiGMo6bufrWM4RfjIhuthAWsbbw1jJWZ0wxh7GvVGWQjBIXd?=
 =?us-ascii?Q?G/h9KvA9uP64n9t7VxBJg95ihj4nGMTbjP7hfyGRHIsJMCKg+g5AaGTIrLxj?=
 =?us-ascii?Q?ME+BjMuh1PlvP9ndbg5ysnlGHtUTThVD2zslYXpgjJyX5hq+GODl5q7+rfF5?=
 =?us-ascii?Q?Km8vZ7W0S/2YRN8pvdBOPbzRdxa0RCbasJy17Pb8370XshIKULFdQFHVsPoF?=
 =?us-ascii?Q?GtH4ozQ07wCM3hL/sDt5XhIChfWowo7oguMfpgsCtB6Rmn68pHqUUCDTcpda?=
 =?us-ascii?Q?i3GhNrYHhvhaFFKtcx/Y+lccBdTD4HPpkYygh1SfyXbvEJP6PKBJPVB0UXmD?=
 =?us-ascii?Q?6DjPwFo4H4fQ6cS6WNfmQ/KEk3dr/zFkNLhHMVxHnFKI6AA+J9cSyYrRetJy?=
 =?us-ascii?Q?zBPa00gH818YPRGqQebcoervI7TD+8mDNqiPshnDEtgQ4sCdFB5NmmyMRNvg?=
 =?us-ascii?Q?jzEaeQJm1mbRkszAWhpoSKLIGm7l+Up+gqIgpxUG3slvhRtNvm2DH5tf2jFW?=
 =?us-ascii?Q?Mwq1ll/dZuJP76Cst4jKdprevIacm16mjnO/r1drQ9QkkzUy7uuYuHcPpN/U?=
 =?us-ascii?Q?uXCiXHzRjr0Q0gs6hpv2TMnYJcVubalNsOn0zslzE8j3UeB+LyJNWzq73Tpu?=
 =?us-ascii?Q?nOAwr7cTBXeyH6QR+szXsu4S33hxT+KjkltBr7U6DRFHL5/OXWP5fnafeA92?=
 =?us-ascii?Q?TmniB0U1XHaiGjYO9sU04Xvc2bE/A8gk0OJENpx9BLIp4Pi5NCFTpNjonKRJ?=
 =?us-ascii?Q?E3dzdzHjwfkqCGyKA6j3qsw2uHiYx1tVoEOs?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8386.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9ffI6jqYdVBnyEB8YTJi7oQwiFBcAKIvfrOzHaUIIZEkgtvmep/3TDlh6ev8?=
 =?us-ascii?Q?czItl0/NNghE88N85OUnPpXuwhpRvco+9NghUaRlodwHfLfUO4+/mpQr6LuA?=
 =?us-ascii?Q?KseqJHlZDonSboWVan+2w72s0Z6Ts5t7Y2r7kW352x6yCBoTLkPQmI5JGfI9?=
 =?us-ascii?Q?XAt0Fvj1IuJOC+3R/tdwyOwPysD99ylCiQBMFpNeF7xrVZUxFpuE9pNJ/NUd?=
 =?us-ascii?Q?kEejGPRt0Um+K6vVtatgpuaMMqpwgoXkKiP1HLJWZRVApnA07TwcAmxzt4us?=
 =?us-ascii?Q?+zjEbNz4a/Ko7obN6iC4vEuPPjlZgZsCeEotCNlFhMprR9plSSAleF4OWDKf?=
 =?us-ascii?Q?14NcppZYk1ljEwRuiXLE/ft/3l4tCUdwqTZfh1YoTT0J2rbwvr8xSFoaVSiZ?=
 =?us-ascii?Q?Srrt7xsPGwHL/zrSp1UlvgqjREYz1+kxVWA274ZHijQi1j3aKEeHDRBvRMrG?=
 =?us-ascii?Q?MpJhJUrF+CUGKR7yvrQQKRYEL3Widn1F8chuuh5KR6gTiwRlO0CKy1lx4V25?=
 =?us-ascii?Q?Qo0calDHesV7rtxPGSucBkMevV3cgo3+OfB5vYDgRRZ8WlBslSoqbUNhUSHD?=
 =?us-ascii?Q?xr6su/7qRl+2/YFVnaGgBCBHnvmegna56xVJepH9A7u6p3ueTAaC+CDxE6wI?=
 =?us-ascii?Q?0oD//JcA7EnV+7xwFxgGbd+3bctf/La6lbOqnDes5LkBtv9gZJMrAa1hk2iW?=
 =?us-ascii?Q?d+qdMMtijHsK8/Bu1xqKy9cKwLEk3bMzSmDpEp9drQM42x7ELFc7ykhk56hD?=
 =?us-ascii?Q?ozS0G+yPVpWygXuwJx6e1tc1UbbUFODdHjGLQenP6XjcCDXZ+tekUc0w2/H/?=
 =?us-ascii?Q?lRmNvXOd7bDALIKOA3nFiK51AjC+ao/Wj9HHUaGBXWLcX0nKFG/3BMq6kFiO?=
 =?us-ascii?Q?4AQn1Tpd9bNSkHXQsVxbP/GfMmsBAGqvGguw8XoASmtyZ9Ox5IA90UH6FWMy?=
 =?us-ascii?Q?IpCCedUs+bLPJfki9WHcrwfkebe+Hj4m2S9AhAceq8S1GZ5Mg1VXSUMby699?=
 =?us-ascii?Q?MgRBHnHXJcH3LJ9u1WmCwN4qLLd6wmrnJhih4pESqag18AvN+nHFMEmL/BUQ?=
 =?us-ascii?Q?n0Qm0X+zthD4fwMmDJleI8SrbNnz7P+65g2svP8ppfdzsO++sR98HLdv12S3?=
 =?us-ascii?Q?BmbjCUeP2uhSOj4eQOsUb5UtmJGsn2CJJOh5WgCCpSjpjVg+35S2MTxPxgt5?=
 =?us-ascii?Q?Rm2o/60E5MtU5Oj0Apmo60KIqTm1kH83YbSYJ1JJhLu04CAsIg/ULfG0D4Ey?=
 =?us-ascii?Q?JnFOdsQUyFQQa/H9AHYYuerVa/c2zw5V5foTNZazfc0kX64KaM8L8+I6Y63+?=
 =?us-ascii?Q?Mh7Iz7+tAmdFK3SvDpeAc/Mx1N1+yRA5Dc6xLIj1qvGJeC9R7CwwX5Tsx3Dr?=
 =?us-ascii?Q?HXyHApBuw83FdoTDwy99XtqrzWC8xyoEmDPPwBBeNAQYgvaYlnx89CkNJlrn?=
 =?us-ascii?Q?vIAF7IBO9lvuLtIJTg9WiN2pC5bNWRIZwf8xbKnTLCmSB4px7VQuaLZPFF+z?=
 =?us-ascii?Q?mcyUO4AKHpIDBZzBSjmeGXevU5fYGPBO4aDXxFUJ3aMc4HyaJK8xlbKNyevw?=
 =?us-ascii?Q?CBqDDIJxfkyxjjSYnh1FTTmNmsMqH9EIl0RgKg3CwagQHNS69zQYI4R5s9OQ?=
 =?us-ascii?Q?IrKQ27lJyYWO42ai3LLioio=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8386.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ffd077-8dd7-4c41-d0f2-08de2e9669b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2025 15:54:28.6287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6vEI7Pi7SFgcG2Sy0+6Y0pSSxs11q/1ZSSis/BwJdDM24E2Rx5TktKbsNvI7OeYLFa7sv0PW+paVlUSOmtgJZ9yQiD8CTCR7GM4o+/XI1prxAk827AoEe7uVKvPYqSl/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8675

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Friday, November 28, 2025 3:40 PM
> To: Prajna Rajendra kumar - M74368
> <Prajna.Rajendrakumar@microchip.com>
> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org;
> broonie@kernel.org; Conor Dooley - M52691
> <Conor.Dooley@microchip.com>
> Subject: Re: [PATCH v3 2/6] spi: microchip-core: Refactor FIFO read and w=
rite
> handlers
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know
> the content is safe
>=20
> On Fri, Nov 28, 2025 at 02:16:27PM +0000,
> Prajna.Rajendrakumar@microchip.com wrote:
> > > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Sent: Thursday, November 27, 2025 6:59 PM
>=20
> > > Make both handlers to be shorter and easier to understand.
> > > While at it, unify their style.
> > >
> > Reviewed-by: Prajna Rajendra Kumar
> > <prajna.rajendrakumar@microchip.com>
>=20
> Thanks, I assume now it works? Since Mark applied all but this patch from=
 v3,
> I am going to submit it separately with your tag included.
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20
Yes, works as expected. Thanks for pushing this separately.

Best regards,
Prajna

