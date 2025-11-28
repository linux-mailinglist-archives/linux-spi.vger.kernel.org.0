Return-Path: <linux-spi+bounces-11647-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A42C92459
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 15:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3D23A4935
	for <lists+linux-spi@lfdr.de>; Fri, 28 Nov 2025 14:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876EA2749C9;
	Fri, 28 Nov 2025 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zslE4X47"
X-Original-To: linux-spi@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013071.outbound.protection.outlook.com [40.107.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D072741C9;
	Fri, 28 Nov 2025 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339392; cv=fail; b=feoZwTgkRMnZPUt7f9/KtTjsT+uO3LjO/o7b8K9xI+Ia3OmawLduzWSEBSO/B+4UI3RroRHgCp8LrxpJXTn2Jnj5N5/PA1KPHhAWCKuyEoFbJqAS09qHG3uH/o59Oqp1jAE9V9+OBj2hvRLIzNLX61t0aq4XejyO8/6QdqR8mGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339392; c=relaxed/simple;
	bh=NoxmPX4lBCLM020jMPUhNUVM6CBYSUhBkWaR405p2ew=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VJUK3JbaJiUZ4084g8DwZ5Arpb/2W3xUHmdEh9ZZeB0GHmoeBFpZDfwJ3sO8vqnZXnbS5bZtl6VT3eGaUikvb1ugKU9Ldd7U+G03DZ6iFw0VBVQrjce5g54D69HrLNmqiwXD9LAonRRqm0wnINsJaQ4R36eNlwPZagRMU38Fshg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zslE4X47; arc=fail smtp.client-ip=40.107.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yn4yhbBLfF5rheico2H56wJsfnoPHa29KvfqHSuR7Ohqan+IgdIAurstLjmarKQjwDhSElog+TdIvieOZ/PnshJFfZ0bdTkGyyWPY7zmld2+i45hkbomKswsv2GGnhSDm624Wb9ceHmO0UgigfvZQqLv1HOxcirA2jIy3RB+ZtKq0SjR6HcZnMmhuHFXmxPkI9DKRRFJoYWN6Hh4guISdAXuoRiSroykVPiesWgo59KDJ+cryCG4Ow/Rey0NyJqVilMdGnFRKMzIpP9282YXeR2sRsJPNuCNJ3EZsPoO9nia4gSSobnWJjLuo40cwjZZ5jBVq0DD9TAkipZQiDagew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPLZT/XcGdPf17jHyrCQnSmB23Ec5J2jK+mFSGoK3K8=;
 b=mPL6SHkyBqxySmaZDprAdXM+pyH6nZXGAnVjMIGq/RJ9G5IvoTxoifJxB+Jck6ZMI8SGKc/KXmNfiDAK1ZfAt11h66e0ygfjxM/NMqWm8ppCj68wH5bA8TvlhhAL4JMCnA2EtQUd7TVfdF0HjL2VyQs/MMVwoTTLNTZqMcuP85ZncT06Ubu9itBKqyQmVNzb4R2RlxHerymOrzSqbdMFTPWnE1BELkOcDtdpQ3L8fuLLk61RjhBLtsgXq5DdTY1gcYovYXEY4hrNkwmriNNTzw370jIQChBHWYIoJTjeI80veglfwOdQ+2D09WPgUVC2ZAUBjsrXT0roxcpfBG6DmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPLZT/XcGdPf17jHyrCQnSmB23Ec5J2jK+mFSGoK3K8=;
 b=zslE4X47JdQF5Bthl3UkTSv7Mrz9y2hTgyVbVlKQAx4ssnQ8vKbusBiwD0mN0lvI/4OFuhd/eJcKlffyBYhZHBGaXAoVS4IyxX4BCaurl0FbfpADycmmbziuFtC34/4jIvrAP46ygmype6GVg2Ks/Mcctj1kG6zhiVhSaWTtZ+GUJmek0Tr+EDbnCm9FNRXt63a2vfgtuksihvtl+FUeuvBB15AGyKfaZMOmgL6qmG/0EPxLcmbaI/pfb3USL5EtxDZEj4G5jltEe4aeU4lH/n5X8giTa8ZTS+pddj9TaVF5Na1SMJi1zFWBFstLfzAu8lMhVK3q0MXk+YVRKdirnA==
Received: from CYYPR11MB8386.namprd11.prod.outlook.com (2603:10b6:930:bf::13)
 by CY8PR11MB6844.namprd11.prod.outlook.com (2603:10b6:930:5f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Fri, 28 Nov
 2025 14:16:27 +0000
Received: from CYYPR11MB8386.namprd11.prod.outlook.com
 ([fe80::22ac:bfa1:678f:f510]) by CYYPR11MB8386.namprd11.prod.outlook.com
 ([fe80::22ac:bfa1:678f:f510%4]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 14:16:27 +0000
From: <Prajna.Rajendrakumar@microchip.com>
To: <andriy.shevchenko@linux.intel.com>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <broonie@kernel.org>, <Prajna.Rajendrakumar@microchip.com>,
	<Conor.Dooley@microchip.com>
Subject: RE: [PATCH v3 2/6] spi: microchip-core: Refactor FIFO read and write
 handlers
Thread-Topic: [PATCH v3 2/6] spi: microchip-core: Refactor FIFO read and write
 handlers
Thread-Index: AQHcX9Af6NbjthqNa06lUqBqYJmOobUIH4ZQ
Date: Fri, 28 Nov 2025 14:16:27 +0000
Message-ID:
 <CYYPR11MB8386F204FAE5BB6220944DDC90DCA@CYYPR11MB8386.namprd11.prod.outlook.com>
References: <20251127190031.2998705-1-andriy.shevchenko@linux.intel.com>
 <20251127190031.2998705-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20251127190031.2998705-3-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8386:EE_|CY8PR11MB6844:EE_
x-ms-office365-filtering-correlation-id: 3711eb40-bb0e-41e5-b823-08de2e88b848
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FrUPNHGqdcAs2+ZxkiXqwOG32cRSLOIYwpUNpR6TEFR/AP54Ak0dNKSFpmVw?=
 =?us-ascii?Q?UI0evI5vGm86sFzai4AJa5jGYHzbevyu/6ao0ca5Sjl/gwU7wxViQN7wCiGw?=
 =?us-ascii?Q?6j1Jg5N8dRUzS2Xfa48pr4E7Mnh3BGNoJ/AEg3yac7X6mPXil+DJw7lDew/q?=
 =?us-ascii?Q?6sggv5oQfCVykumkQVbs1hx6heiRPhetilVsPszYEQ7v8/jVEljNLRmUTeHh?=
 =?us-ascii?Q?RWqNFPm/GWWXxnKksAuhDsGpGOO/iEx9PuUno3KYqiBi7sBHEH+nWfp5r1P0?=
 =?us-ascii?Q?YVh27G4yFTf6jDi9F7WaxaMkmSAfbt998ja0MfIa8Gk5diXbDZgmf60ORtxd?=
 =?us-ascii?Q?DdHsUomXgDB1iPFPbOkUqyaqAVWJsIBQ4AZ2ea4OlLjTEenNgkN/2T0/Igjv?=
 =?us-ascii?Q?+rzyUgEFWnc/2or3vdG6X30o4C7pWYq3FuTFxEZMVXNDgoTLSj3tzt2wHVXv?=
 =?us-ascii?Q?TgbIxDSq+LtCwgLT8QAv+xOXQsib/l6AV8XrrA/VDvsYcqdMaXQ/FdYFcS89?=
 =?us-ascii?Q?CMnYmeSKTr6oin+0WQZCkdIazSqZWKvoNeMouK0dRZZjh74saOJS3BvizhH1?=
 =?us-ascii?Q?x9T3qobbbHEbEKVaTMD3VU/BmvtgbVSZOCoWorsB4Zbklz+Ov5lhKqho5z3h?=
 =?us-ascii?Q?+jRkI/quQNRzaI2TnxZmBa5wjPMA74rMnIiuKhA3iVyXIU2u0xwdO133xn+C?=
 =?us-ascii?Q?eBlgCW+Oy7G2Fqp2gMK2qzdQFovMZB1nsrXj2c1vNXldg7iogfeKtfdfPhS3?=
 =?us-ascii?Q?vAGcbeIcbH3ij/p7rxlELYVRe/5VIY6GZ65f4gxapywJ5Pkf6FUTMi60GpIg?=
 =?us-ascii?Q?LZhfpCEshbyF6MICRJogt7tcn4T7DOe9haOp7nnzHiPc73Jk2tOCaFI9/Vig?=
 =?us-ascii?Q?rWlNJdmpsWGW83EkZ/xRF5PTykaEO/GttXLvksox274cPUYpqtjtDlcRZSrh?=
 =?us-ascii?Q?vAgSeFPgzBB4AbcbdwPXbB7X1lUAFExpBobm5veRFsujKb1yambcRxJOJj2a?=
 =?us-ascii?Q?/eOUYHuAux0w2NC1aRkyiE5iCqxF7CUCH+e3yRfcF09FOQAplXVWBPPTF4XR?=
 =?us-ascii?Q?TDG75NzUJtHDJv/aPON86TgX2kg74oJrUxpaxjj9aKcnsepildLjX3k+qXCA?=
 =?us-ascii?Q?rUHyEkKCmBnKn4Xg9TFnAosSOgjdQB/SemoNgXyAPwp67unkUz39AJsRTRHs?=
 =?us-ascii?Q?AXjkGy6efVuH35cxVtgVq2bNDE98BO1w7XNZpGdCo303s+xIaRhFswg6Ehtd?=
 =?us-ascii?Q?uOnKidSTOxB3K+pUTi4AdXIfXGrVYY/U2T7fZmKwyPyiS7QSjGh+1GBWXyFg?=
 =?us-ascii?Q?pHQ96A6p2xyZZulIINMIdwKmGUc/0bwYaBMRPjibl/Yxi2NFFAAsEBETsP8F?=
 =?us-ascii?Q?5c+Nui/9IHo7GQ2xMOpx+dx90JlB9EZs0iESQVFVlG15K/QV9jvWiDKUsRQy?=
 =?us-ascii?Q?ylhZtMxylsCDTsEpAC7/2vISC2lZl6G2Vrn3DiIaLeyjApRyS+ZIzt2WBxZ5?=
 =?us-ascii?Q?1nfUS4QAMk0JRShvuk04XAU7j0GtSrkvm0yX?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8386.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?I0tpV958tPAnrEu85g9lYuCOgOr/hPDOyCVfL8jcBxI1wDL2k1NZYI5tHDMG?=
 =?us-ascii?Q?xIuFNuT716Z6yKIksGLbrKOVTTyAIDYpxT7Qrt/IEvBCORf6JGtp+2c+q/CR?=
 =?us-ascii?Q?AvHZIy0FUAYROnipBnmapfQHqgHzxjj7Vdw1w9BJ/ePcxoMgExIexMqyqQyd?=
 =?us-ascii?Q?3AGxQnCKVBjIlBX/+rUMqtRINHE0oiai4Rhd6w0cnpK+m+UMCYW02lExfIC5?=
 =?us-ascii?Q?XqRQNUoRg7QvrsLttjA7DFTCa4rWooni8I2ZezTvZegfC3OGt42A9eI4SVFC?=
 =?us-ascii?Q?zrs+8bAbFqy4O7iINQoSFCGiQi9ae16vxzZ6cyjgtS9oW8bzmxjeJuzevajT?=
 =?us-ascii?Q?G8OA9yxDeBjdW3bQANh3GH0fsPzFRhjzbPz4bzDW9jCKMCNqSDgXvdZC+71i?=
 =?us-ascii?Q?e25qLWLslx1gNhT3dP6z1GgHajJCNujmIdbVoEuh7DpkIAzplDB70FBXRPb/?=
 =?us-ascii?Q?7sFZ/pFJPJDLs5Spwg/Rh9w4VskOrtithabpVhMqnZ/Ni5okf0UI5Pk3bwfR?=
 =?us-ascii?Q?3W0Joty44bvBWVFk+z4pYWp1JQDI2xk52eQ0fHgks5DD5oAxZUdHW4cimV3T?=
 =?us-ascii?Q?UJUyGuGqXvdw7D9GNe/l9UmHPI6dcaE9aml39zxNF+uHJWH9wNrpDDTWNmpn?=
 =?us-ascii?Q?kzVYj8q4aybuzhKwL0ZmY8mTiUE/SQARWydtC4XkMlb3YxnXLuhV1/y8fli/?=
 =?us-ascii?Q?impu73YThI5DShmdRmbu9cu955BOY59FzbGZqyVjwSMexpuD9x3oDHRXSVW4?=
 =?us-ascii?Q?0ctJpWTBQ77kzlRVVpxHlMwY3yqZZCQcT25Uy7YbVlc1rGcsY6qmTd5bqSmd?=
 =?us-ascii?Q?EQX3SGfySMBR6p++dSgyS8+SqjKv5C9g4beXQYIeTYNZtLcy+98HLoKLgJ1z?=
 =?us-ascii?Q?WP79SeR1Ig0umId24f8IFh8P7Bb6lh+QgpSRS/dzeUP3p6uVACcbWJSZ+CDZ?=
 =?us-ascii?Q?+BOa6pwKtCJMazVpyef8CsySVsw697cvY2E1o9Yhvr4vUDbo/Kiu9wtvc3kD?=
 =?us-ascii?Q?bYgVUXryGocKO7GIvwId0uG0LmSbER6Qxg1vF54tcwvtDD5/P/dSpTHDV0uK?=
 =?us-ascii?Q?7qZI186R+trv0383wZzq6nea3d2volL1xJ74iM0DyW3LNeqNz/VcCLWBTNCD?=
 =?us-ascii?Q?IrTSpz1LlncfkJrkXOr0ECgmowxpIHI9ramYhTaUFA+5pNajmFdcE4sLDrLk?=
 =?us-ascii?Q?5iiv2BQwTUgpzjF88n93sBQ3tlGplswsEj0pfvwjuupGKWvOl6FXijyg9R2k?=
 =?us-ascii?Q?WLCES+VhP+OMZC4OBQSU73zDQTIHp0P0H9yJOfC5Ab+vdYvDiLVOrWCj/6fw?=
 =?us-ascii?Q?pElfTWCysYd9LNxHdDjwkLxVHGgutMgmWpVfpuMRRZKkuAw+l4oDr/0+CSFq?=
 =?us-ascii?Q?mw4xI6rnR2GFulFGdZ1NMA/+Vc5UH5Lajv0KbtoAsY+Pw0EdYFFR4xZMN6kA?=
 =?us-ascii?Q?F4VKKgacSsSyJepiAnMcV9aJdSCjQVFVpCHMjNq9IwWm1wZVK6pEcNjR5JPW?=
 =?us-ascii?Q?F/wqnqL+BzdM4kHzDn5xfSG/SYU9aacneFiISx3t9ESK3rzPO91KbB8sP9S2?=
 =?us-ascii?Q?LgxuWUGmfuJb1F2sqX8n8WjfBt7BsF7LkrR16T3VFpoDrMwQ4GZGTuWlUbno?=
 =?us-ascii?Q?pg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3711eb40-bb0e-41e5-b823-08de2e88b848
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2025 14:16:27.4923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uiTVVGIXgQemwKkBgbgq5skZwLJFzR5vaVHTwO51bAEWQsvE5SYAYfSNWlO8ZUdKXhQVWdUscwZUST/85PvLn1EiRJo8+L2aztUbBEFZF2bty39L5zS6AdorxrrOByuG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6844

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Thursday, November 27, 2025 6:59 PM
> To: Prajna Rajendra kumar - M74368
> <Prajna.Rajendrakumar@microchip.com>; Andy Shevchenko
> <andriy.shevchenko@linux.intel.com>; linux-spi@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: Mark Brown <broonie@kernel.org>
> Subject: [PATCH v3 2/6] spi: microchip-core: Refactor FIFO read and write
> handlers
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know
> the content is safe
>=20
> Make both handlers to be shorter and easier to understand.
> While at it, unify their style.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
> ---
>  drivers/spi/spi-microchip-core-spi.c | 31 +++++++++++-----------------
>  1 file changed, 12 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/spi/spi-microchip-core-spi.c b/drivers/spi/spi-micro=
chip-
> core-spi.c
> index 08ccdc5f0cc9..439745a36f9c 100644
> --- a/drivers/spi/spi-microchip-core-spi.c
> +++ b/drivers/spi/spi-microchip-core-spi.c
> @@ -97,15 +97,12 @@ static inline void mchp_corespi_read_fifo(struct
> mchp_corespi *spi, u32 fifo_max
>                        MCHP_CORESPI_STATUS_RXFIFO_EMPTY)
>                         ;
>=20
> +               /* On TX-only transfers always perform a dummy read */
>                 data =3D readb(spi->regs + MCHP_CORESPI_REG_RXDATA);
> +               if (spi->rx_buf)
> +                       *spi->rx_buf++ =3D data;
>=20
>                 spi->rx_len--;
> -               if (!spi->rx_buf)
> -                       continue;
> -
> -               *spi->rx_buf =3D data;
> -
> -               spi->rx_buf++;
>         }
>  }
>=20
> @@ -127,23 +124,19 @@ static void mchp_corespi_disable_ints(struct
> mchp_corespi *spi)
>=20
>  static inline void mchp_corespi_write_fifo(struct mchp_corespi *spi, u32
> fifo_max)  {
> -       int i =3D 0;
> -
> -       while ((i < fifo_max) &&
> -              !(readb(spi->regs + MCHP_CORESPI_REG_STAT) &
> -                MCHP_CORESPI_STATUS_TXFIFO_FULL)) {
> -               u32 word;
> -
> -               word =3D spi->tx_buf ? *spi->tx_buf : 0xaa;
> -               writeb(word, spi->regs + MCHP_CORESPI_REG_TXDATA);
> +       for (int i =3D 0; i < fifo_max; i++) {
> +               if (readb(spi->regs + MCHP_CORESPI_REG_STAT) &
> +                   MCHP_CORESPI_STATUS_TXFIFO_FULL)
> +                       break;
>=20
> +               /* On RX-only transfers always perform a dummy write */
>                 if (spi->tx_buf)
> -                       spi->tx_buf++;
> +                       writeb(*spi->tx_buf++, spi->regs +
> MCHP_CORESPI_REG_TXDATA);
> +               else
> +                       writeb(0xaa, spi->regs +
> + MCHP_CORESPI_REG_TXDATA);
>=20
> -               i++;
> +               spi->tx_len--;
>         }
> -
> -       spi->tx_len -=3D i;
>  }
>=20
>  static void mchp_corespi_set_cs(struct spi_device *spi, bool disable)
> --
> 2.50.1


