Return-Path: <linux-spi+bounces-3424-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F7690C94E
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 13:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048251C22FE0
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 11:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CCE15ECFC;
	Tue, 18 Jun 2024 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ft9XH2pR"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B12C13E025;
	Tue, 18 Jun 2024 10:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718706263; cv=fail; b=p0R0zMtKN82Z0MpodIO9mA5dK6HLOdn+xr4lXcZBfW1Cy3F9yhAxOHeVezHxxXceN8gQE/WqzZj1IsY1kEfXmlnu7IAPl/I02b+ZmUi0UZ+4tWKNLAeoICrvodQasqV9W2r/FmgRVGX6Fe5P/soBwrJQmOED4wIWgSkBI7z79eE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718706263; c=relaxed/simple;
	bh=elnn5K400hnyB3lN/+bdvTsxCIJ9a85tAI5aDbgxiuQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g5nv9hZZtB7+jFxs3+tcexgs6z4dzCv3qZaiFqoqsLWc4AFMmdB1BZliwhc0kI/54j7YTgFrAgsden+RoUfeaQPKFQvqTibOuT55eK1+KziqpON54p4K8W9oo3JfwtKJNVyFyC2GNnaa4kSySf1cI2dxJEHM3vZZ079Q45A7uWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ft9XH2pR; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/sUt7n/YrtPY/VMWuGXGM7kPuNeT2J0R7bpJtvdyd0exz30BKzbTPrzUcqhZOKt3aGTUS5+K1pG/1ruqTd1RW485G4AqroWk0Wtk/taJkzY1TTYDzoAb3HeEgy8OMsTvEHKszGqCMVEGxpD7+aTgjpq+fUTIbd+m8CqqXRJVKNI07IwuHUzeNmtZZAaCNRjFhRAt0pJIze4zNIoZz+TC5P7Qmb3gduBZrWOqWX4LovXt8PrRWmDHJlFtATH33fxlO70GI8fbgVyDq4djdnI2dmjqasRXzY6tgVIohtLKWfi/Si3paN7Jnae/Qp9WMF1uT2jkgMx9LiPQfU/zPz1DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cuTfU38fNGCU81QOg5pq86AgFvQBoe8XOn/+UdSIc4c=;
 b=O4ONIg5DfkT+or39nudbT4tUhAMtFbNX1WYfqYUOLpCKig6AtpvhRQ3GqtsBvNSxSQ/nAVCoNp0NKV+1j5sjtnoLsMQuQf3gYIR8K1lsAbM9TQChImBJDNnEXRGOj/u7diMbwod76x2GaXFNBtyYKigdiOQPes7MOo3lLh94+rmxXYu3+I27wyP+hZ9K0j7qbE51W1WQ883sEjPDksuCAbk0fM/vr45MEzjpJozc/tBNCZhyz4br/QEJqMkM7uEiQ1RJvl8L2bMIjxahQQpsz5Qdy5FIAFzDpVffHwcWzXld5lnUI96MkbVxJ8D0C0jNKkeEYeR9QF7cpJFoX3xhIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuTfU38fNGCU81QOg5pq86AgFvQBoe8XOn/+UdSIc4c=;
 b=ft9XH2pRPqNeGgUsVGLfsNzmG6ponbvMUuOmTf1/1EmFEGrsro+eIb9DrqPyT9zWejTEVTDjEmQ6CMpSWEUqcEol/A+8WqK795ndlyzRa7xXi3Lyk4G2n3wulaSfsRxXNsGD50qx3DezsTW01ffkJEdK4AumZSl6Lpsk2VVlssE=
Received: from DM4PR12MB5231.namprd12.prod.outlook.com (2603:10b6:5:39b::19)
 by IA0PR12MB8976.namprd12.prod.outlook.com (2603:10b6:208:485::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 10:24:17 +0000
Received: from DM4PR12MB5231.namprd12.prod.outlook.com
 ([fe80::518d:e364:6eb1:3f10]) by DM4PR12MB5231.namprd12.prod.outlook.com
 ([fe80::518d:e364:6eb1:3f10%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 10:24:17 +0000
From: "Thangavel, Karthik" <karthik.thangavel@amd.com>
To: "linux-security-module@vger.kernel.org"
	<linux-security-module@vger.kernel.org>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>
CC: "Gaddipati, Naveen" <naveen.gaddipati@amd.com>, "Narra, Bharath Kumar"
	<BharathKumar.Narra@amd.com>
Subject: RE: IMA Reports No TPM Device
Thread-Topic: IMA Reports No TPM Device
Thread-Index: Adq4qE45KxXVKDnZQr2Y5S02DshRfAIwHLiw
Date: Tue, 18 Jun 2024 10:24:17 +0000
Message-ID:
 <DM4PR12MB52310B4519DE2FF70420DA5EFFCE2@DM4PR12MB5231.namprd12.prod.outlook.com>
References:
 <BN9PR12MB5228AB9BF8A3951983B39EBEFFFB2@BN9PR12MB5228.namprd12.prod.outlook.com>
In-Reply-To:
 <BN9PR12MB5228AB9BF8A3951983B39EBEFFFB2@BN9PR12MB5228.namprd12.prod.outlook.com>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5231:EE_|IA0PR12MB8976:EE_
x-ms-office365-filtering-correlation-id: abcbb44c-b0b3-47a1-b1fb-08dc8f80cf1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|376011|366013|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jXb3wrKgmnXoHvNiqnhsvRkz3fmL9eNKJX5jiCEyxx0c7ULvck93o1MCJJkz?=
 =?us-ascii?Q?VtgdfDQwk3uFwbhlNtjdTL0f0v9LykLm1Ul5ns01MfPtPJ/LQ83z+zQA5QZk?=
 =?us-ascii?Q?LyvLjh2NuFxgns8qAtqi7ziZOswS9RvCfs/BMG0eBGuJwEhvnL0KciELYecO?=
 =?us-ascii?Q?54Sxw82GGE/h4qn1Yf5yPeMy60DbmOvlJSIMcHwukXHKm42dpeE2daqFADK9?=
 =?us-ascii?Q?BMSmvZ+xMvloLgjiNbp2PnYrtO0341s+rUWvCSqO33BaDgt9Mzl8gHCcMtag?=
 =?us-ascii?Q?jn3/iyNOnwEWqReLBgq/QWQ+gSNR9ftgeLwKqNyuTpXk2H3fNXIM9IRziQMl?=
 =?us-ascii?Q?1a922KkWEoxeB8bKIW1dBhDxGt98LE7594P5lrEg+IRsT8T9R4T0AKnjVi8c?=
 =?us-ascii?Q?yecDw5rzzkDweBKN0F8Hp18ZDSgtX1zrAdrptVPg2eBZRxy49V5h9m9ObqTV?=
 =?us-ascii?Q?HZrrjmV1Bj2rdO8d9TCecrybO2hMMHk9vp6nwnSKVuHoD3vVqOTLq6MAm2SU?=
 =?us-ascii?Q?QcEubaGHJj13nQHjvTcBpytG8irAieXrShWmKQJbFFoQIZYH4uX3Lq2WqwMg?=
 =?us-ascii?Q?cEzSVF+5zrRPIwrGWTuqhZ8lyR3I8eBSZ3zlRQh3xBKKYgc+b5eozqBcRCO9?=
 =?us-ascii?Q?xQrnchr6oTEbDkdexwasR4sfJScaWUHZXibwuESnpn+5DkzP5A8j+MIjl2bH?=
 =?us-ascii?Q?Y5RKgez4cJyspXqTUf/0kxoOeGHGs51rgMQD/E/pKg2cMsyNulAGt7QO5r27?=
 =?us-ascii?Q?CyFK5Z0W8UegnwM7DRMVs1j7+j1xMNttM5VcSbmkfwIZLvrgXg8oKTaFqFKG?=
 =?us-ascii?Q?ZfNSAHRczUt2UB/YxAdwCrt9iX7xmKuFnnag9HJYt730xJIkyehVfqYZ5WQz?=
 =?us-ascii?Q?gHQfnvCNJJIGD+mTHk5UqpFoE9TFbpsYwTMjhdXaWUO/NKZ5nwgQrp/YrwAT?=
 =?us-ascii?Q?AtwlWf4Qyk8pDN6tAvMAFQAoDQ+sa9RrSX5aN+dcYWtYMjH7pl/XfGM1p690?=
 =?us-ascii?Q?SIXGORd9dyBGrS5kwdDhcvWZugEG4Wy9o653KrLSCf6Nnp4UdoDhdj1kAaJ2?=
 =?us-ascii?Q?41X1JBqUUuGg5NqydKQeyrFpHNW+WtNZlnjPJqujeuCsb0uQRExts+k2Iz5i?=
 =?us-ascii?Q?60gqXda2swvpyCIl/T57tX207Mw3Szt0h1j+dqWDWd5pbrY2MLZ457tWKscq?=
 =?us-ascii?Q?ca7mnqliLhex1rdi6Fa0F2KW7QRdqxirYcY0pGV62hVpbdyvoDqaQ4QZnCMh?=
 =?us-ascii?Q?gZyLk/hFZlnmsyyF9/U7/Qwq2tVfE1ejLg3Vz/VrvUE4Zczs4pIsR45zfmW8?=
 =?us-ascii?Q?oVyBxVKX52vjoEMC86Tk1CUGv666OR1rknhf08t6KqcyfHXg9iT5uGmdRxzd?=
 =?us-ascii?Q?zzKzE4k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5231.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6SYDDC+LkCJTw5S33ABIzDiHIJ86Q0ZaN45QBaWKS46vukiD5m9U18RT3zby?=
 =?us-ascii?Q?Vi00JJQNvepWP/dh026v68Eg1uSaNmC9WWlanrEAFlXmzsL8GnA0olWuYrXb?=
 =?us-ascii?Q?Oub+yxOF4OqgdjSSYrwMGi3fO9PNMg3JKlK8PqP2Rk747S/sTOkVnJuPUeW1?=
 =?us-ascii?Q?o3H+zSdtBFCklGOiNZl2APfP+htOTA38vCE5LRv3m5sg3Mbp+burUb7AkQH0?=
 =?us-ascii?Q?OYRUPMQ+hqDoUahmO2aXxlMYlZWjbO3VUCBIVK+VS1fOfcBmrhevZscdcqNi?=
 =?us-ascii?Q?AANKp4ldpiiRCXs9GX1bu3t42TF8uI7DlGdGv6rTbUZXTLhqtk1M9nyHTRed?=
 =?us-ascii?Q?eg0ALtAnFDG8DBXTct1Q0xo5wV9285dofL1avt11+pbzy/hJcsV3VKWS1O5s?=
 =?us-ascii?Q?Rw9CYEyRy5JBnDIWJTNI25oWbkq1s6aIklPOLx+vYC7sWMoORtfNeNd2Cy05?=
 =?us-ascii?Q?QONb+pQ/odt6wPQxcWg6Mr3YLHVFwsNqQo2uLTAg9zh1QhT8a8hm4SpBojjC?=
 =?us-ascii?Q?uOq96WcS/GHUU2YwXfWJ3rdMxt9Eqg/Krl1NifUDotBDEoQ+bT3iaL+w+Xo6?=
 =?us-ascii?Q?Xjf+0FR7ifckJlxlZOQ8gNJtyKLejMIfpQc5SWzh/kUsOchcumH+93yHZQyR?=
 =?us-ascii?Q?cJlFnwQZ/uvmoilN4zL8QyIn77RN/O5gtdvtqdMhXGA0jdfz/BTJWHXg9hsB?=
 =?us-ascii?Q?t+KPIl/t+62qrUK6cqWAQVP1DhEga/hI6kX3ZpMPg5wuoabvTE0u4VD/zC1Q?=
 =?us-ascii?Q?QsEGy2vs3V7wkaw067dTvPgT1xJbDy5GMD5+YLxo5cHdCg7qjQfYHd0UFjb6?=
 =?us-ascii?Q?dd+838PdusBgAp5sc83gnbzcdvXeIMx+Jekniq2Lty3t7mfgKO/L8uvJY7ZY?=
 =?us-ascii?Q?AuRsPLPdxLguYImXhHKKqSYO6lwEbMuEpmEws9lVXr+Xnf81WEEP2RB/IizS?=
 =?us-ascii?Q?EAiZt1QtsjL8kAifNBDKNjHawgXLmtTLynsZ+79yQtClkOqwW7yuIcl8zGVO?=
 =?us-ascii?Q?LB50DaxdvlBFawxUO8hPafh1rSmCRkLaPeUzo7qcUOrJ2Tx7Z3BwEigwSnx6?=
 =?us-ascii?Q?7aKNki+LS3wx1PfxFvedG2VknPDNZwp7IfE/iNgPAqhFXkVysM+TMYspDOlJ?=
 =?us-ascii?Q?uBz8oQbnRJIiI07mrofwM1/6NeuPjBbo8EWGQhkDpgy2Wsn5C3artNBp/uhK?=
 =?us-ascii?Q?8LqtkOV7388zJKT2rMJhQNi++mM8LH6zdYWojKzJ9XfmtrJpxePTomFP67WP?=
 =?us-ascii?Q?5J7dbeW40yFqKXxCOFE/h24iCLZaybbFvgs5RXWHZ7yDs745Pi22f7IwrnXN?=
 =?us-ascii?Q?VzoQVK1GAszqYQCE2rkoPO7xRrwlXOVeunf1rB9cvgohWaUAVzPOj/rnBTnu?=
 =?us-ascii?Q?CDhXAtpa58dLuSfh+n1MR94MrCyNHLRk88ZNs3zUklfgFkDiYlFHaASLGhSs?=
 =?us-ascii?Q?PQzbOK/Hvo5tN3+6n0WET4Uu7rLwnsqMZRu33l0VOxKUG8c4t64Ti2SL39Ey?=
 =?us-ascii?Q?IBFR+y9f7+S/46AFtgTZVFCh+xVXjg9ENteNcl4fFKBxVi3ipXTZiMsnwhUb?=
 =?us-ascii?Q?R8Puk4OgQ5tl4mgmb08=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5231.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abcbb44c-b0b3-47a1-b1fb-08dc8f80cf1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 10:24:17.2675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AsVneGiJkOz8IWuin8BPFCHIJsvPtzBaMfqQAZyUpsVengfsGPQ0Z5V9OdyboI/Sd+paWlNZq+wGGSUHAtRSug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8976

Hi,

Can you pls let us know how to resolve this issue.=20
Looks many reported the same issue in forums.

Regards,
Karthik

> -----Original Message-----
> From: Thangavel, Karthik
> Sent: Friday, June 7, 2024 12:49 PM
> To: linux-security-module@vger.kernel.org; linux-spi@vger.kernel.org
> Cc: Gaddipati, Naveen <naveen.gaddipati@amd.com>; Narra, Bharath Kumar
> <BharathKumar.Narra@amd.com>
> Subject: IMA Reports No TPM Device
>=20
> Hi,
>=20
> We are booting linux v6.1.30 on Xilinx ZynqMP SoC which is using ARM-A53.
> We want to run IMA on TPM device connected over SPI interface.
> During booting found that IMA reports "No TPM chip found".
>=20
> Please find the below logs which shows IMA subsystem init called before T=
PM
> device.
>=20
>=20
> [    0.000000] Linux version 6.1.30-xilinx-v2023.2 (oe-user@oe-host) (aar=
ch64-
> xilinx-linux-gcc (GCC) 12.2.0, GNU ld (GNU Binutils) 2.39.0.20220819) #1 =
SMP Fri
> Sep 22 10:41:01 UTC 2023
> [    0.000000] Machine model: xlnx,zynqmp
> ...
> [    2.561405] ima: No TPM chip found, activating TPM-bypass!
> [    2.567199] ima: Allocated hash algorithm: sha256
> ...
> [    3.727105] tpm_tis_spi spi1.0: 2.0 TPM (device-id 0x1B, rev-id 22)
> [    3.764152] tpm tpm0: starting up the TPM manually
> ...
>=20
> In security/integrity/ima/ima_main.c
> late_initcall(init_ima);	/* Start IMA after the TPM is available */
>=20
> As per above comment line IMA should start after TPM is available.
> But we are observing the opposite behavior.
> Please let us know how to fix this issue.
>=20
> -Karthik

