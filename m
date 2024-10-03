Return-Path: <linux-spi+bounces-5092-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED54998E9B4
	for <lists+linux-spi@lfdr.de>; Thu,  3 Oct 2024 08:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0A91F24439
	for <lists+linux-spi@lfdr.de>; Thu,  3 Oct 2024 06:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA55177111;
	Thu,  3 Oct 2024 06:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wD/F1Y1F"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB48A7441A;
	Thu,  3 Oct 2024 06:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727936593; cv=fail; b=Nsgc8miYEdAlbKquglB327EB9s3IkNeksb3ZzwWzCugp2Z8wgF37zKR/HsMAWw2R24p5Ze2DIKfLoshRCOwTBUQQUagJPdwYgncsi9VgSi/1Md5axVggbEpq0Nr59t+JPXcyebCWnUomktayvdilt0X7Wx5fuVqdOe1PXuUl2NI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727936593; c=relaxed/simple;
	bh=BCirnDUE5r0dHBTiFKoWNgKPSeBgUgRpkhhTGeChI7Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DepYaELhRWeVWkoeZ8G+Vs/zkOR8kmlQFMhIQWmvix1QqZJzgV/Aj47pQjnQOXGZDbroQO9iLWPSxe0ce6TfVHR2KEPHA/pbAmhJE5V4LS3KEtZK0tkxLPApcBqkVV8u+SF6RsGXmw5wqpWL+mgcCNFbcAMQobQQ3Ls2foK1G30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wD/F1Y1F; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEWFHifn6Xq0XMf3/SL2Ubb9PhyF0MfkaqtgIcVOkfapKqHQCVjcJVh35MsoLJmaOfgZ/38AV0wrkwvcSitrcFHac/ipq67mEqzPuK4qfiwhBNvzezwMIsGbCYrtYF4zux7yapgKUuIwW+T1ut7Z66tNR5LJlv32x0NXxz3QYQBFrx+i64ZfUdh6Ls/NZoyv0ebHP+tU0wUj3HCEg4ZA/Lmw0V+pNhCcCD4I8b5ghelZGMhlRos1mN8c+u55gaWUnexOrdqeiK/m2sWi+JaV/bbCX25iWxQWM9ConmaRy3An5tGtt7I2UjAYy3b4UfsP7YZaktQYBMvLzyKIdKSSOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkSSgF4zEJyI72kxT6dehuov7vV4LLq51W0+F2/R9Tw=;
 b=PCe5FxE7JzUQIfLCtx0ALHEP1NI52VjeCS6qYagw9AaX7Y8YLPFVCzWKHXg/XQjHYVNRYgxy7Ex4/H5UNfaJvXDkaXvsFZi2hi0/E9hIg35DdZBNQylMzeOlN/Ca3Ft88F082qH/Dyanioy7uPrk8oqJk7fhR4wYe3eeLa0+ojZNOQkM+pOUHzUOYYP5wj8Ms2oCFuQea0NxFnVJqrIx4jTBMOFf/uxU1V6yam4m+0Pzvl25JR9ZM2HasJa+gzL5pDIycl3l7BgrSNOAYabVP85XNBHO7Zbl+aaP4x3niK0R7kOvrosIvpwqHY0SC3Cpr/fBrF2NBHUv08UW/Vp1GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkSSgF4zEJyI72kxT6dehuov7vV4LLq51W0+F2/R9Tw=;
 b=wD/F1Y1F+rRJrU+bh3A6R4cxZTetGagfW55DQRHUqAPXQi7bXjem0uBfAz6JaB2kdNWXeNSkMxPEPlONo03TRydbUJVYHC5oXWXnlTX97oiAHr6TYWdw6HJanc3Dd29D2t9CA55zn12UiyYu94tPVHBxPeObPGAPfYuV0ezSCfU=
Received: from IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7)
 by PH7PR12MB6659.namprd12.prod.outlook.com (2603:10b6:510:210::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.28; Thu, 3 Oct
 2024 06:23:07 +0000
Received: from IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa]) by IA0PR12MB7699.namprd12.prod.outlook.com
 ([fe80::7ed1:80d:75c:f1aa%5]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 06:23:07 +0000
From: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To: Conor Dooley <conor@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, "broonie@kernel.org"
	<broonie@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>,
	"amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>
Subject: RE: [PATCH] dt-bindings: spi: xilinx: Add clocks & clock-names
 properties
Thread-Topic: [PATCH] dt-bindings: spi: xilinx: Add clocks & clock-names
 properties
Thread-Index:
 AQHbDbS6IWXQrG+wX0CC5AjhvyS/qLJnJHoAgAE51XCAABg2AIAC3+PggAGMU4CAAMdKAIAC1yFggAASSoCABAjYMA==
Date: Thu, 3 Oct 2024 06:23:07 +0000
Message-ID:
 <IA0PR12MB769964FA23FA8B889B47539DDC712@IA0PR12MB7699.namprd12.prod.outlook.com>
References: <20240923123242.2101562-1-amit.kumar-mahapatra@amd.com>
 <20240924-impaired-starving-eef91b339f67@spud>
 <IA0PR12MB76998D7BC3429606508E6202DC692@IA0PR12MB7699.namprd12.prod.outlook.com>
 <20240925-trapdoor-stunt-33516665fdc5@spud>
 <IA0PR12MB76999B696A9BA0834644AC71DC6B2@IA0PR12MB7699.namprd12.prod.outlook.com>
 <03a1c7e7-c516-41ab-a668-7c6785ab1c4f@kernel.org>
 <20240928-postcard-lively-c0c9bbe74d04@spud>
 <IA0PR12MB7699EDFA3753D25C8126D901DC762@IA0PR12MB7699.namprd12.prod.outlook.com>
 <20240930-unbalance-wake-e1a6f07ea79d@spud>
In-Reply-To: <20240930-unbalance-wake-e1a6f07ea79d@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7699:EE_|PH7PR12MB6659:EE_
x-ms-office365-filtering-correlation-id: 46380de7-acc9-437e-6701-08dce373d8a0
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SIPs3LDaXhs5FadlqT6NhA9lEb8HvEJBXA5IBX8mp+4gxr94EVxAV70Ljj/d?=
 =?us-ascii?Q?fa0xpQMQf5itcdr1j/mvnFERNsEowtqvhf1MQJK4DrnHban4+P0b9kqR2Y05?=
 =?us-ascii?Q?YEdbaWjZqvCbDl4FFopQRfzhekucxeCoiE5lIK7YVgD8gPL49Mv2IxriEZba?=
 =?us-ascii?Q?Bzo7rqbeknRqXNQttPX1KRY+mxr2h2fp4zLEEz8kzNzDSFg3xR03IlCvPF72?=
 =?us-ascii?Q?pRkuHjhx/br0Fhj/l4PWCJAgD4O6sAx4ZoAR2RkgDp8uZYZ08sExOfKcg/DA?=
 =?us-ascii?Q?4j0CokKI2ZrTH30t9o5wdFiQ7eiY+T2SEqlWlHsQo5qKpzPF5VpRFK8P6cTn?=
 =?us-ascii?Q?iLnEx7ummk/5FNjZf3ywSJIomMuZUB7mJEsIcTMedoFreRMNYw1bKAY8vC4V?=
 =?us-ascii?Q?RpSw1eT33W03Qs23Jw12R4REFVXuwDK72m6ZTblyq5GOPcKCqw5cvSQR7xsK?=
 =?us-ascii?Q?pXfqurbzXiD1ORMRmDxWsEBSlp0jUIB8cdAIQz+Vdk2aUETIGv9IQaE01b8t?=
 =?us-ascii?Q?MgaIyXNwnx6Yv1LQy5Wit93zJS1f0QGiT404YfPDwtLj3xD5YsBW+6XMVlRf?=
 =?us-ascii?Q?GJq8Lwr0TXz5OwZlcxxDlRw3A2gNqfxDSSZe1i2KVsisc5CM8mQWz5PEMfG0?=
 =?us-ascii?Q?EkuEJdW1dGFsuiJB0ziFaCSIfP1m2wyHMtAE0HrsJl5jVOAL4tDpy3vGskym?=
 =?us-ascii?Q?CTIq72h+JKz8WaN0lKQQfvP8AAAReeE9tNKeyiXlMo8Yk84xHshL+tOoCclF?=
 =?us-ascii?Q?qOZ2gAaRZw+c5vOfq+6scKSqplCN2dfQ78x3CqDYgApW5B30X8wAWxfCnRwK?=
 =?us-ascii?Q?DWlqay8UnLBbf+szI5ikiCdqmNaVtfLTnlt/cbU6C43kJL0geIcYNgfxWCqC?=
 =?us-ascii?Q?9l0KGGVPLMmlglknjLv0q6lXQ+dsocZxOaLJ3XU3zemfHb4QmHrM5SETvodK?=
 =?us-ascii?Q?69pT0NKAacRkeFywH67nZOpDc4jBVeDD8Bcy9NYmXHvV82I3RpQ+h1v2wXOa?=
 =?us-ascii?Q?+x0tKqG8mbbdjOOR1KkIyzFQf/SgR+o9RXSHC4bjIMF+aeVA9rt3BgfK2xHw?=
 =?us-ascii?Q?l/RpjM6+tSQv5z06LY6YIQNim3YvJYsIZ1rifM+OOWu1GG4tFxAWgTq+DDWK?=
 =?us-ascii?Q?/3ZKOVYcmW/pDzATxshTrVSwhV3WronK4YIr3k4EYa/2u3x8pyyxIbSQk4gu?=
 =?us-ascii?Q?SIgmq+kbf+PjvfLdcqS//2zZ03HZPugmXA2DZ7PhP6lrk4cOkc8LV/S0kIdO?=
 =?us-ascii?Q?QKCJVoYQDpYI/zgPBDDt82oEx0NpvNFpb4JTeoH6Mw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7699.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3cuHywlhXp2gTXQPThXiHb5xwurr4qYDAeN9im6wcBdNiNHln7EcMhP1KeRD?=
 =?us-ascii?Q?Tj3xE1G7aI7zpu2Ya1fUqK4+fnhfl3MZxnIhSPQeUPk4xJtEmgx8h2tSLiDq?=
 =?us-ascii?Q?wduolUFEOrmZoKKNJObjVBVHy2KcYgqu9UN3kbgIxGs2J+/gE3A3afxRRXPZ?=
 =?us-ascii?Q?sWM8lazwE9I3/JOTfJxwl50ZmwEVpjUg1/GmEljaSCo2j2jJxjsvF/Xo+VpR?=
 =?us-ascii?Q?sQDaIZzjdWC1MOvkqvcieK8Hu5bdhnlGvvuLsDG7GaGkEG0KzWFOl610CkpM?=
 =?us-ascii?Q?Dur1HkYaQrvOHAOG4TB46MrUnUXZZ2SzBjEu0SrokwaQU5ZktM4k3p0uuO98?=
 =?us-ascii?Q?wpnduw+ZUgfkZnCCE9RYf2YXsXo/AygUUdotJICGk10o6cKt3dU78tAujNKg?=
 =?us-ascii?Q?2yC/gDWhpSvb9pUu68hjVb0y/Ltgfx/6+MwofkA2qRfMlzdIThDgbEJAJeCk?=
 =?us-ascii?Q?mRjipR7qHr5kwU5XkZtKiq/uqB3G/u8ijfuEZLHfESu889ySctOi75d/syyP?=
 =?us-ascii?Q?A2CY19RWDxqLIzAfciXTqMQpivnQg1uLw4NCA4AIUhUSIi/Tzy9z8qHB6rbS?=
 =?us-ascii?Q?Cd5wFlbkaGdt2RByfsd1Ny6otq4CCCX9I7wZuI9qSYXRTflHRYefxn50/hNF?=
 =?us-ascii?Q?uYeZ+haLM4V6/Fn2NoR6l8JrljCHS3MZw7FtouFz6KYdXbEOSmQY9y0Rfe5N?=
 =?us-ascii?Q?5CRkdoyMfkRgj1pEq6VbCV34r3EKsF/qsp3DEYRiEF7ZZnAtINRcSIkuRukh?=
 =?us-ascii?Q?8p5e9Yg7bM4neZZnTdG8Jww4a8HVQSWUAS8/PpbYcjF+Oz5ZEgKncYgXuPSC?=
 =?us-ascii?Q?IZ+wXFzb3j7/FH7xOJapJHCj4ThT6hNTPxRgUtYXcmtSFsHHRatCfRy8/8Uq?=
 =?us-ascii?Q?0KktuRe3X9QebmpSJSTKu7tv9j7025KGhLC8/bVEGLT7UCIcU0HH/jbcvRb2?=
 =?us-ascii?Q?6zCC2r+PlDsvj9GMr57T3Uf9iWSl0xZna/uQ+mEiv+yZTxJ4cO6Ha/gqoA0M?=
 =?us-ascii?Q?iL507KhdPKYweUWnq+hp4LLoJfNE7NRiwjn+5HgNCIucdA7NUKyfTNCJffkm?=
 =?us-ascii?Q?LaUhi5Aayw55pCkYWa8Yd8ssoIh8/nC5zqJmTl+hAEmUEMVSfsLwVQftPXf4?=
 =?us-ascii?Q?eWW/4JqQbNFWKlj/GlqJcliF4s/7C51nm0IiZdEZsb8Tak+sU9e/adEir/an?=
 =?us-ascii?Q?IDFCzWqr32YKDeTMf2oKf9aAVnH+xgK+BDg6wOcimXdMxpHmCowhsKsvaCbe?=
 =?us-ascii?Q?L1JSSNnpC5+ujtLL0rAiK22cd04FXYBv7Ok+RY+P5quC/feZVq7g7KYbkcR7?=
 =?us-ascii?Q?5YD61iQ25cOb1FnrJAe7QBx2Sk9GUU2ugoOnE3gE8Q+VmNUhpR036ghx23dZ?=
 =?us-ascii?Q?yLQAk+oASIuB7EI3l1AmxBbIYlvkTGV2UcZ2Dt/WkpGcWkbd2Hc/aGHoaaDt?=
 =?us-ascii?Q?tXJktNgg6l07sbN+tL5cRS/ErqCace8wySeLWXxh2jNSzUWrvHhjKw2o+RDg?=
 =?us-ascii?Q?nGEkx3sgBw+rZW34oHbplFxzd9mqhNTDu4wu3CRimkEZdg1Jw2g7ZbtbTD2g?=
 =?us-ascii?Q?eCR1xYgF5nrmGMIDuHM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 46380de7-acc9-437e-6701-08dce373d8a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 06:23:07.4742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CUiYfBPswxaAeIiZnu8oF1EDfqGDxtppzMGiypANhHkSV3kR5CjW+EVy1DWLULdIE/QTmjevt0B7NF6+d9VZcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6659

Hello Conor,

> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Monday, September 30, 2024 10:10 PM
> To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>; broonie@kernel.org; robh@kerne=
l.org;
> krzk+dt@kernel.org; conor+dt@kernel.org; Simek, Michal
> <michal.simek@amd.com>; linux-spi@vger.kernel.org; devicetree@vger.kernel=
.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; git (=
AMD-Xilinx)
> <git@amd.com>; amitrkcian2002@gmail.com
> Subject: Re: [PATCH] dt-bindings: spi: xilinx: Add clocks & clock-names p=
roperties
>=20
> On Mon, Sep 30, 2024 at 03:44:47PM +0000, Mahapatra, Amit Kumar wrote:
> > Hello Conor,
> >
> > > > >>>> Subject: Re: [PATCH] dt-bindings: spi: xilinx: Add clocks &
> > > > >>>> clock-names properties
> > > > >>>>
> > > > >>>> On Mon, Sep 23, 2024 at 06:02:42PM +0530, Amit Kumar Mahapatra
> wrote:
> > > > >>>>> Include the 'clocks' and 'clock-names' properties in the AXI
> > > > >>>>> Quad-SPI bindings. When the AXI4-Lite interface is enabled,
> > > > >>>>> the core operates in legacy mode, maintaining backward
> > > > >>>>> compatibility with version 1.00, and uses 's_axi_aclk' and
> > > > >>>>> 'ext_spi_clk'. For the AXI interface, it uses 's_axi4_aclk' a=
nd
> 'ext_spi_clk'.
> > >
> > > > >>>>> +      properties:
> > > > >>>>> +        clock-names:
> > > > >>>>> +          items:
> > > > >>>>> +            - const: s_axi_aclk
> > > > >>>>> +            - const: ext_spi_clk
> > > > >>>>
> > > > >>>> These are all clocks, there should be no need to have "clk" in=
 the names.
> > > > >>>
> > > > >>> These are the names exported by the IP and used by the DTG.
> > > > >>
> > > > >> So? This is a binding, not a verilog file.
> > > > >
> > > > > Axi Quad SPI is an FPGA-based IP, and the clock names are
> > > > > derived from the IP signal names as specified in the IP documenta=
tion [1].
> > > > > We chose these names to ensure alignment with the I/O signal
> > > > > names listed in Table 2-2 on page 19 of [1].
> > > > >
> > > > > [1]
> > > > > chrome-extension://efaidnbmnnnibpcajpcglclefindmkaj/https://www.a=
md.
> > > > > com/content/dam/xilinx/support/documents/ip_documentation/axi_qu
> > > > > ad_s
> > > > > pi/v3_2/pg153-axi-quad-spi.pdf
> > > >
> > > > So if hardware engineers call them "pink_pony_clk_aclk_really_clk"
> > > > we should follow...
> > > >
> > > >  - bus or axi
> > > >  - ext_spi or spi
> > > >
> > > > You have descriptions of each item to reference real signals.
> > > > Conor's comment is valid - do no make it verilog file.
> > > >
> > > > >
> > > > >>
> > > > >>>>> +
> > > > >>>>> +    else:
> > > > >>>>> +      properties:
> > > > >>>>> +        clock-names:
> > > > >>>>> +          items:
> > > > >>>>> +            - const: s_axi4_aclk
> > > > >>>>> +            - const: ext_spi_clk
> > > >
> > > > Nah, these are the same.
> > >
> > > They may be different, depending on whether or not the driver has to
> > > handle "axi4- lite" versus "axi" differently. That said, I find the
> > > commit message kinda odd in that it states that axi4-lite goes with t=
he s_axi_aclk
> clock and axi goes with s_axi4_aclk.
> >
> > Apologies for the typo. When the AXI4 interface is enabled, it uses
> > s_axi4_aclk, and when the AXI4-Lite interface is enabled, it uses s_axi=
_aclk.
> >
> > In my next series I will update my commit message & change the
> > clock-names 's_axi4_aclk', 's_axi_aclk' & 'ext_spi_clk' to 'axi4',
> > 'axi' & 'ref' respectively
>=20
> There's no driver here, so it is hard to know (why isn't there?) - are yo=
u using the axi

We are working on the driver. Once it is ready we will send it to upstream.

> v axi4 to do some sort of differentiation in the driver?
In the driver we don't do any different operations based on the clocks ,=20
we simply enable the available clocks in the driver.

Regards,
Amit

