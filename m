Return-Path: <linux-spi+bounces-8294-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 75579AC3A5E
	for <lists+linux-spi@lfdr.de>; Mon, 26 May 2025 09:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BB6B7A2D87
	for <lists+linux-spi@lfdr.de>; Mon, 26 May 2025 07:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B1D1D63C0;
	Mon, 26 May 2025 07:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mSCSAxtt"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A44013AA27;
	Mon, 26 May 2025 07:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748243286; cv=fail; b=C3w07tiVHBSdtxEdwNVkI3shhjehSBCi88ZGkpjJt9TG/IwLlE7XVA84ca8qqB9Zbrfb9ed0r9/l8IrLsa9DSZ5IcNg5vart2KBoWOUFsPcyfGTn4/piDIdaOvoCnHs3qrB/1UBVyT48rI0BVeuDKZK4Mvq1gjXD8wt1YuiQNQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748243286; c=relaxed/simple;
	bh=6Tna5XbfWJBn1MfUP0oOMMPV8gQMmiDptr24HavYzgE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kI5nvdHkCcCtoLZOoKhvpt5oa4jsjI1QokcuoRKC+C1eboRt2qHxuOveGAuSubmmYJ9GOA7/1QjKUvMP8xM0awJJoVYVWqcjn+8UzayPqf0cpBZwi4ecaNCGHj5iF/NMEtfFT9rcPZxQ0mnoLzLnCBYS2BDPqX7gw3cGtOAVv7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mSCSAxtt; arc=fail smtp.client-ip=40.107.212.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MkSKvkhbBp4z6Mau/UWzbLvF4+gFoU42StZAfuFBopbSTSchVyTtJxp7PjygxJRyQfYS72UKS/F7Q2UVgD61xIrxD9++PrArGcFTMWIqrS+eHwZMB/yhP1YH8xeKROANYCnJ5lxB42AH7rPlXTFv6pCIjvSJbU2I3NC5flg6qK4LBL+W9orGVz/uAs3K5HtU49aRGywiGL+tGm1JEUqkwcyAXEcoZ3OlwVFn37JAqREsgic1q7RDYHKT5+/O+Z8d7k/MRoqrCa95HeWXCF/LQh2OmmXkO7Zl2KWIaR3DunsdOyR8A/iUB1jR2mE6ut1Glpev9e14a8zfae0guPDsPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnNFo9DAj0e7+dWkmohyas+ody9mQWd4QH/JC3tLVfs=;
 b=AueRyyJT6Ckf6mKhxJfl+1ZwF8G8Ea3vT44iRA0JHvchdSm2CLeRM1QhoQmzQJR6wF+tt5VVJru7kZUT5rzTxmZ5tGu0dDT8akvnHOX9JBX/tMfU05LZikfmqzZ7O9B/qv/GglNaAOfzGW7asBEVe4Eq5WoO0f5zif9+j3AN6qlRVCfuA2fH2XOGcdlgHNVaHE4l7AhtiKfCAboLgq6O4vO6U4jcgvzTdsLjWMzVSeIMBwzBpZTZciMOR6GJS6jR8zna8qdYFwtzSSKnP76C0cUfywskbmoQozKOObUdzpy1yNhr8gXMnZpqvkQnucM9KZI2cwBO3c5C1Di4S0JzMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnNFo9DAj0e7+dWkmohyas+ody9mQWd4QH/JC3tLVfs=;
 b=mSCSAxttS440L2nsSQGemGh7s1PPHf0Y7CVfTjGTAuuubTOPnQDt3xCWebNnMSA9dEEeOnbFJkl57dcBn0pjF/bEqV7jNUXl+9Lm+UyBJTpjq9idNxhUcbP0V8dmc+L4LsiCFjIvKyWTk/AqiXhAQXw1eKV9MHpGaBySMIz3vxk=
Received: from IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Mon, 26 May
 2025 07:07:59 +0000
Received: from IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa]) by IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa%4]) with mapi id 15.20.8769.025; Mon, 26 May 2025
 07:07:58 +0000
From: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To: Conor Dooley <conor@kernel.org>
CC: "broonie@kernel.org" <broonie@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>,
	"amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>
Subject: RE: [PATCH v2] spi: dt-bindings: cdns,qspi-nor: Update
 minItems/maxItems of resets for Cadence OSPI controller
Thread-Topic: [PATCH v2] spi: dt-bindings: cdns,qspi-nor: Update
 minItems/maxItems of resets for Cadence OSPI controller
Thread-Index: AQHbywb9dprIEt0NbkSOfExrWnOpALPezReAgAWyaKA=
Date: Mon, 26 May 2025 07:07:58 +0000
Message-ID:
 <IA0PR12MB769903933CC9200FD082143BDC65A@IA0PR12MB7699.namprd12.prod.outlook.com>
References: <20250522104745.327675-1-amit.kumar-mahapatra@amd.com>
 <20250522-dropout-hertz-6f1db9256655@spud>
In-Reply-To: <20250522-dropout-hertz-6f1db9256655@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=9d93cd5e-f1b0-4d16-bd9f-be4916e8d69d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-26T06:52:41Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7699:EE_|MN2PR12MB4336:EE_
x-ms-office365-filtering-correlation-id: d763e970-6d78-44eb-f1b1-08dd9c240bce
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?F6TYFy5fFKDFeQ6om5r+lS5bW2LHpYjlDTuUhlv8G0OWirqo4CH1KUs9uDri?=
 =?us-ascii?Q?RU+SPbGtBfU1Pcv0ka4iyHq0UeQeJg3/Zv2YQr4SQPiAeEoekFpZ15+09Zk+?=
 =?us-ascii?Q?LzT5uyxyigARx8gAFMScNrsnUNy6scRHyn9YkmRUHYF9TlRl4aIA2N32868w?=
 =?us-ascii?Q?9D7nYOh1GVLriz42OtapG5rzUzesyao6jS3th1CYjrBYpyHsDhJ34uMi4WSq?=
 =?us-ascii?Q?IKsM1RIGROOrWx5umzRxQkU+xB5PL0AJZjFA+yhJ0BwNQjbRCaOzMc432Z5m?=
 =?us-ascii?Q?a8QmKmHn66yUnmNLm+YrObqOZ+GlqZmM3xIIoLj53EDcWPEFZbFwQVZj5bt7?=
 =?us-ascii?Q?3mMWDtL9JVW/kGS+qNT7dXzMfNKbUJIlK4mEjDXB6vy8NxFLtyi545w14Y4t?=
 =?us-ascii?Q?GMplyzAvxjxVYSH+LIimXaN3w1g2Cxo1EeawGneHodUQFCuMsQKL0MbiD9rn?=
 =?us-ascii?Q?GiPMXASCsBJgr+fM4AFVMvKn02GCQZBWVEY0ZT5KOexOEGaQ4ZNYwTJYrx4e?=
 =?us-ascii?Q?9i3TFKzqxdqStEp/o3t5wi2lL8vbUy6zblogDgrYLuWx5GwRg+9fMjdf4OoG?=
 =?us-ascii?Q?n1PIb1tTQe57ro5zRTD8f6m3KuFwj/4+Qq/UgybCDG1KktwBFPl8T7x/uxIl?=
 =?us-ascii?Q?F+jZTdeC0b02Mdoof/y0NXYtJF0hJSiWPH8sT40O//1rZ83xSbj2bu4tYok1?=
 =?us-ascii?Q?IORiO4ipq/PFxemyWTf8u6zeGkNVSkVhX7IvlTNu2SPxRw7355hy5b0UfHq8?=
 =?us-ascii?Q?t5Ox5hnGykxnlrq9dn4TGyyI9EBASwkhVuFrrWLyNCk2YTMBMCfgv+CqBLU0?=
 =?us-ascii?Q?ncyCk883S08Xpq8kmIvdrjCL16MZpOIgBRackTZyPIqydvSoHFDgJh7EF2Or?=
 =?us-ascii?Q?OU0VReMTIIJwj9UwEAqLDZEpx9DCFulAyQfNPAZCmzIUE4qp8V+gelOWWoDp?=
 =?us-ascii?Q?W6VZVDiUS6Ar5xCmDQ9S7zCjNEiyzRdDSgqn+vzRI+fTKcR/IReSFooUUkVo?=
 =?us-ascii?Q?igNH9PyymVIYhfuT+RyVkqbtSQGOeNdUO7wR3Gf9ZIIG//MGeDVO4XfTreVz?=
 =?us-ascii?Q?zEtrDPSsoAPHSvRUedi21QUQRRJdiosj50ha+o/H00MMq9He7eMge3IsZG43?=
 =?us-ascii?Q?5L3W0AoV7FDsjn+Mt8WYY3VLcrbukD+eSfMpnw3PNXlwdkbu6Q6gcE1gd4bG?=
 =?us-ascii?Q?tLztO6qqc9S0Y+t6aPVkyiU8sNS4blnjo3eeArv4bo6qKJOn/QA/yUefi9SA?=
 =?us-ascii?Q?ZI/jPjSb7eq87p2Vi2+/eJU+yXTbeu31lR8LPPDK9gKn/YftrZ3smNGlhcSh?=
 =?us-ascii?Q?Ny1lksPFOpCdBQOIonZ27rfdUNDIwMPb4NWVg92xVapmnRvsvY65+gpDQp84?=
 =?us-ascii?Q?VRzMiXrkSHrDBRugyCVtitN0HhQjhHJe7YCGQamlDV2e5ci2UOAE9iBCo1iW?=
 =?us-ascii?Q?aYy9iqplM8A=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7699.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?O/EmFYVkwX2zLsOrxdbBg58fFI9g+MTGtcNLjQ5qzVHcrH5aV+/HkwSn//ST?=
 =?us-ascii?Q?OpIabw9x858ew8sIsMlqRM0gznJpZxVGJT2zLuRkWhMaLGrwj79+ObooRtOf?=
 =?us-ascii?Q?uPMynotohI4vQJQ90RXTi8YgKmpXIurM9yDzpvlh6SFqpRn9NJa2PKKiIBxc?=
 =?us-ascii?Q?Uz4c/EVE+o/+q9uekyC0xQ598vlJCVJtIbMbndhmsMB1vrq4XPOO+nvqTbYA?=
 =?us-ascii?Q?pNXe4NOZETKA3pIRahA56juOMfLp/yCovkeFAtWzMRPBVVKbkkxIx9zL6MnV?=
 =?us-ascii?Q?YwflgIL9KHaJPIVmuHWbeFSySoumwh1ieijF+tqjrizXudSKYfymRvV2KMV1?=
 =?us-ascii?Q?twnqnbp8wHoZKpkGlrflhqYWzEkESg99v/Pg4y51TMkORUfs3JeTePwXpNMz?=
 =?us-ascii?Q?v9YpQ2eIy8UnemDOYBEGDcWaHjmklJ8GdG+pubmZyP/yaloOymRNVwCU7TWP?=
 =?us-ascii?Q?zwQmofpFWKtYO14S7GUyefHD+dyjsl4cVAk/sie+WitcbybEJgGmMSUobVT8?=
 =?us-ascii?Q?hCggfTLJmPaxf6CWyEq9eZ4cUWZanb7wVThP7rkKJAr/9HVuEpsxXwjGFQH2?=
 =?us-ascii?Q?tsmhwcsbdIRR65GdhDRbuDVSNuHE97uY/WjB7p23Y8O1NjrDaonzvBK+oUez?=
 =?us-ascii?Q?4lb5yQq7MLV95gM1b3GBMXy3OVXAwbKQ20koI9Y89OTxcrms19mLK0s/V79H?=
 =?us-ascii?Q?PMgqP9bAxstkopl8twwZ621x495jrT15aydKOzUNORVY58/IF78Ymq0g9doQ?=
 =?us-ascii?Q?f/K75yif0/5eDgTo6uyS3FlIwRsxsYsvVUATmUa+IgMRevC7QZLysLX5nn2f?=
 =?us-ascii?Q?OWBMoQleQKodcxvVH+JZNVWK6tbZ0yfdSyUXXNB6FBUdpHfSwpUFzRszst0r?=
 =?us-ascii?Q?ThrcFYI5Neu6vzo/bb0sqz6dE4LmbagvAkHMeEgAVrIHGksHWXTNAiX8Rgm2?=
 =?us-ascii?Q?9lfdZDIVSVpIDMD+NfVqukKSwXdEgV7J8f3Ogq68r/rOG6cZ26WohdzTL5Bw?=
 =?us-ascii?Q?riZj3fv9g8TDr6iG/8eIw9CXLOgUUJhCG30GMj9BwY1IZIgQJgLbbwGVV/RP?=
 =?us-ascii?Q?xqPN9wWIOIrhPo49MUFsDojtegXSnoLIiMw8ow8dceoysMSwWYcy16YdJR5B?=
 =?us-ascii?Q?CqDCuoFCxnEE0vxzJR5s3wbTA3ySzoIWoJYtQa6IFs7/3fPDvtdhuz2yr1mE?=
 =?us-ascii?Q?jlmCv4qoCsTjYNQnct40Xjh9j5oDDZm/zVNuWfhpo0x9L6Qk2o0iEvai9l++?=
 =?us-ascii?Q?NKqtqRrDo+BhbkZt4C9mFL6VkGyhF/B9e11OpVOHpzgSYFjxcPo9c84tSTsv?=
 =?us-ascii?Q?q60RcTvq1H6dpUvqsQtC9sbYP/u2q9RlbM6Lb6+/gFwgZ1sIjl+ddgMkzew8?=
 =?us-ascii?Q?A2sUmTaG01ctjBlWcMqzKjbbv4qAfakUjlEWKYUiWEIT4EnuUVAecpPkK9D+?=
 =?us-ascii?Q?xnCqZxtGze38IaP9Mb72F3Cxt5UDDTWgAoz0Q2LeaUCPOA3GQz22cW0D8Xav?=
 =?us-ascii?Q?nCSvlGxmrbOcf75wFESP/HQhhFzh7PPjmB+HzCEgT/Heh6j9fVpF/248CCZP?=
 =?us-ascii?Q?kONR5nQHP9s+PAPNwbI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7699.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d763e970-6d78-44eb-f1b1-08dd9c240bce
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2025 07:07:58.6912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f6JAP7pZowLd1th0ptgR/9zhbCk+Q5ibTETbye0wz0HjnWH+x48GmcvCVDkAyY5B/mv05c/+x9uZWyScq0zNWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336

[AMD Official Use Only - AMD Internal Distribution Only]

> Subject: Re: [PATCH v2] spi: dt-bindings: cdns,qspi-nor: Update minItems/=
maxItems
> of resets for Cadence OSPI controller
>
> On Thu, May 22, 2025 at 04:17:45PM +0530, Amit Kumar Mahapatra wrote:
> > The Cadence Octal SPI (OSPI) controller on AMD Versal SoCs requires
> > only one reset entry. To reflect this, the maxItems for "resets" and
> > "reset-names" has been set to 1 for AMD Versal SoCs, and the minItems
> > for these properties has also been updated to 1.
> >
> > Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> > ---
> > BRANCH: mtd/next
> >
> > Changes in v2:
> >  - Removed "resets" & "reset-names" from required properties.
> >  - To address review comments, removed "maxItems" from "reset-names".
> > ---
> >  .../devicetree/bindings/spi/cdns,qspi-nor.yaml        | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> > b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> > index d48ecd6cd5ad..648b8452877c 100644
> > --- a/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> > +++ b/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
> > @@ -17,6 +17,13 @@ allOf:
> >            contains:
> >              const: xlnx,versal-ospi-1.0
> >      then:
> > +      properties:
> > +        resets:
> > +          maxItems: 1
> > +
> > +        reset-names:
> > +          items:
> > +            enum: [ qspi ]
> >        required:
> >          - power-domains
> >    - if:
> > @@ -132,11 +139,11 @@ properties:
> >      maxItems: 1
> >
> >    resets:
> > -    minItems: 2
> > +    minItems: 1
>
> I think you're still missing one of the things Krzysztof requested on v1,=
 cos you
> reduce minItems for all platforms without restricting it back to 2 for no=
n-versal
> platforms.

I believe we can remove the "resets" and corresponding "reset-names"
properties from here, as their default minItems/maxItems are already
taken care of in the else block [1].

[1] https://github.com/torvalds/linux/blob/0ff41df1cb268fc69e703a08a57ee14a=
e967d0ca/Documentation/devicetree/bindings/spi/cdns%2Cqspi-nor.yaml#L39

Regards,
Amit
>
> >      maxItems: 3
> >
> >    reset-names:
> > -    minItems: 2
> > +    minItems: 1
> >      maxItems: 3
> >      items:
> >        enum: [ qspi, qspi-ocp, rstc_ref ]
> > --
> > 2.34.1
> >

