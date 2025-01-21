Return-Path: <linux-spi+bounces-6415-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E24A17EBD
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jan 2025 14:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BDD1162D8E
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jan 2025 13:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6D9101EE;
	Tue, 21 Jan 2025 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jrXivckk"
X-Original-To: linux-spi@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CA2196;
	Tue, 21 Jan 2025 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737465588; cv=fail; b=qT6DJeFZ143qPa81EBlHc8l2ySqrFIBvzrRaAWOAC+Uq1d9+h6/hWrWEjSlxKnlcFPyWCpoRWiQUJvhBbLbjhl3ewwncVanaQNOW3MBgun99rKJeNBT077dYCQ19kd4vkDMG0JxxEqXQCWoQ4j4iwifNwjpNV+mZEGOfMVeDovg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737465588; c=relaxed/simple;
	bh=PTNWouGX80EDUtWDS0WQYxRzhO+0W8mXaId2u84eGTU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=StW5HhkmoTS7GHuw5siNxEqwDnodCXPi6zpHqx99Q6qsI/bkiZXba87hmDZvw+XRCnPlZ7YAV/w7l+JMVDSffkXO0RpQ3+kazebZIbKlr1vVUGq1trHSbhN/SYQUgY0o2i/LCF9dnYlEiCOcmXn7Fhbay0li1Vju7oqq55XvMGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jrXivckk; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bMpb4XORCujXCpuqRLEf4kAPqbZK+j3NXywwsrVRc7ZwAgAdALcLUFQ7z0gfHo3o30P50qWwu06sdRs6k6xcxqG9ko2T5CdCYFLzuyW61NPhcSs9DeAwCS9Y54XzIZy6igzoiSo2luSjqsDP0JvjDIBxxbcrcGsCv5crv125gEIuqOfCpuYcYueEJi1zLGmEKN/rbcYxILDx3bPKSvSEr7zL7x7nfNKtQERHViFcTjdWAJAdLsLw6vPQRqwfr7lXtzDT54Q1Yr1lQPzu/muyOHunBt55q8BaVZri9d/4qy0Y1Svo3GNRy4+2ok2bpQq/59nalC4c0YsuQ3u+tMMk/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=az5YyJq6RVFnD4Cobm6jWKwksxSZYFKA+5AD9/1sRAQ=;
 b=bTih+fVV3zDadyITmOk+U8ebzS3Kqx/tPYw0IKVGI1vsfreUrU08gGzWjBAhPjZ+WxiobC57BNRtW0r4rwxyC84QOm3Ooy9LqI/vnw8BvOIFgQNfdIFC/i3oGkraH5ykFiI1FBjN21l1NPLOxe+WoqtdNIlnsf6bUiPkrzy9CAUM9uIMg7MdKuRKLpmTnGeA9a20zadwlWqd4Nks1+7Jayfr32pzgily2F8Bt7+baWmu2SOnXXzMdc8qhi1TdLoXsmvE0WpbL6A+qfbfnPhsm8tKy+g8Z1K0NbI/gxkd4wvU03u1/eu85YvE+009OJD7F38MX2Ug3rRyXwS+OxI6MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=az5YyJq6RVFnD4Cobm6jWKwksxSZYFKA+5AD9/1sRAQ=;
 b=jrXivckk/Q+fGkJCIAi0INpLPW/6KFIFJEyQG7vfJ1cmE3xP/5UlAp/ZpUn+zA7FVBui7GwmZOba086kHvDxPBh8f7yPACsLEHgHXgOu8SlaMzagW+vt3Q0BbBu/o/LCqzy4R8GCwYIlvsMhhX9C3CASdM+NOqVtNTmrRvH8cP0=
Received: from DM4PR12MB7693.namprd12.prod.outlook.com (2603:10b6:8:103::8) by
 PH7PR12MB5655.namprd12.prod.outlook.com (2603:10b6:510:138::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Tue, 21 Jan
 2025 13:19:43 +0000
Received: from DM4PR12MB7693.namprd12.prod.outlook.com
 ([fe80::57b7:d9aa:1cd8:ed14]) by DM4PR12MB7693.namprd12.prod.outlook.com
 ([fe80::57b7:d9aa:1cd8:ed14%4]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 13:19:43 +0000
From: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To: Sean Anderson <sean.anderson@linux.dev>, Mark Brown <broonie@kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>
CC: Jinjie Ruan <ruanjinjie@huawei.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Miquel Raynal <miquel.raynal@bootlin.com>,
	"amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>, "git (AMD-Xilinx)"
	<git@amd.com>
Subject: RE: [PATCH 5/7] spi: zynqmp-gqspi: Split the bus
Thread-Topic: [PATCH 5/7] spi: zynqmp-gqspi: Split the bus
Thread-Index: AQHbaG1pRtUQj8QAsUmesKXqjDXz6bMhHblQ
Date: Tue, 21 Jan 2025 13:19:42 +0000
Message-ID:
 <DM4PR12MB76932590B9A6BB1CC17AD67FDCE62@DM4PR12MB7693.namprd12.prod.outlook.com>
References: <20250116232118.2694169-1-sean.anderson@linux.dev>
 <20250116232118.2694169-6-sean.anderson@linux.dev>
In-Reply-To: <20250116232118.2694169-6-sean.anderson@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB7693:EE_|PH7PR12MB5655:EE_
x-ms-office365-filtering-correlation-id: d4400d54-6b83-4422-bf5b-08dd3a1e448a
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?flJHxIRTb9gJHWt/lCUUWLDmbfz5L7sDSX6DGJ/5AWjBvBFpYu7h2l12HbG6?=
 =?us-ascii?Q?H0UU1UlckZZQoPn4Of+OvzjopPQl92WU9WhLjiNiyWfS16luI3VCflbiCFO0?=
 =?us-ascii?Q?KnG488J0TY0OtOiIvJqn9iyk0XbAPgM92gJveAokyc8y5mL4TEir79dJgG8K?=
 =?us-ascii?Q?BetkjJfSgya52G5sOuP9trcp1U0TcSwYH/B9ykqNKOKmMLwn4IWpzC1hra5O?=
 =?us-ascii?Q?P0f0om3rxX2HxURGyYDdTZ3rhS0aywkWdzYk/yiqaLHU6720uGMUVo0KFaAm?=
 =?us-ascii?Q?atefdZOvpoPdLm8uPIGrE8qg43zVixS7a34UkHb1OuGHpqmlJqiFxBqO2AFK?=
 =?us-ascii?Q?yKBfvCQaAJOR9ZDlr7dpros+BaZAFcC5uRh1ZkYJ7NnGE0ipw4D/dI8l7nLB?=
 =?us-ascii?Q?SnQWmjLVaTBPGFzEzukYOIyqIQLx2SuaTt0e8Gy2JKPfG/uIfK6k8p/j4o3U?=
 =?us-ascii?Q?SVUw9peSCANh6KWpE5HzHsuyj7ki8n9eh0/TH+uVde5gZRGSSMNRrAJMlPUr?=
 =?us-ascii?Q?lGBcpsGvh6mRT/zm/bX1rEZA4taoZcNFHVUhFbIqpKR4HjivmjYFD/bqIgvs?=
 =?us-ascii?Q?iN8apH/5qfd2GauYLVf7LYCCSv2/gic4fse2rN8PwBY6kZqhgFyBwBpeyxN2?=
 =?us-ascii?Q?hrZ4sfAWKlMIbghvVsGykvDV2Vle94sxUrnRAFmoFx00UU2oC+tqm8rr6vA5?=
 =?us-ascii?Q?oKj5PS+kNUi46wOUkeSjGBqKjB/6DQaD3gQXOaxNJI17IcwTiC797MaCuOIV?=
 =?us-ascii?Q?KEQXS2DJQvDK1CTQYTdsSxQKGhZz5Qd1uk5+UkrONIl7RQOTNO1brS0/gaLb?=
 =?us-ascii?Q?nMoNCnnNi1zmKBIxvqTCqOAyPiiuoujCUM4MHwAH6PsyAT28Fas6Fg0GPmir?=
 =?us-ascii?Q?dXp8dbfqYcUvQAhgHSy/7qJnXWrGZrNsIQD84nxG31VeT2V0k31LNM13m6X0?=
 =?us-ascii?Q?IbmmxwN8gBWtRMUiYXUZ3mc0fb2IpRBNt/4zo47eg/Aq0CrMWIWD4/tShzz5?=
 =?us-ascii?Q?4gsyFy/3r9hP93ww79oqR2AlRd6c0g8TE8lWNlwpTHEQo869kDmXqn+mr6Vt?=
 =?us-ascii?Q?rQK1oHETck1qS4+R/FxTMvJhf+NV0b1M5kdhNzXGXzDLpoKXjOrTTJUJecD2?=
 =?us-ascii?Q?bzC/P1QNZ4pAiojY+JHDzhdUAHdx87ycvDymqeLp4cz2+4ocXlapudBW6PZY?=
 =?us-ascii?Q?KLMJA4JCrqiZKNj4oEcMIyfHtFJS3d+zFbG9Sd9xdDkfNDNLIOJE954F4Mss?=
 =?us-ascii?Q?I982NQ36uPnM3ccKnjW8PUt4/vCo+eGXbv+bwdosfEkPTiN9HUuAtPJzuT2e?=
 =?us-ascii?Q?zHHCBCpBsoVD1R2NZrmmXAY+WiJCiEUp8AiT6VktxFYZTpsMteyin7ltH0lg?=
 =?us-ascii?Q?0HMdBNm29focC6gISGX2HkzDgR791tGEHtgtrALguDyPtJF0Mpq3Ys4ClNzw?=
 =?us-ascii?Q?ui28HMsD+ucZWDCfNVSsNVjZig/wioq7?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB7693.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?seEa4OhQx40hyWkrzqb7zdJdFD7kjJSH6iRuYaKuy+nP7rrbfUiZXGzsu1Nu?=
 =?us-ascii?Q?rp/H0N3gSgBORNehXh9nsFGpR+riPJDoAzzRM9M/FMhqZiIWWmTrVt+WVQ0r?=
 =?us-ascii?Q?NeMZiTxRAGIyfiBZTcIDnef4fta6yT7srQOtXR9dy0ZCMsvxMP0EbRXCRYKK?=
 =?us-ascii?Q?nCmcNsux9TUSC2WXkbGAr4tEGIaFlJmiWEFLXzCJ3mf7z2pmSq+JHLNwoBa9?=
 =?us-ascii?Q?ct8mNXvbMPLWhUAydX0ZtCMZh9eUe0dlo0/ml92bSpzPOI12EnaIfwDzxXrW?=
 =?us-ascii?Q?Kkd44sPcyQXFUDTV73T2s9ezX7iN3U+yX72yaLcv04VUYVfJg0jfwcU80s1Z?=
 =?us-ascii?Q?toiwPHXHYb5NQG2swMz/0OaOHfDFeQdDLW4WNdxEAVQuFdMyxZoSYzI/YBOz?=
 =?us-ascii?Q?rkQHieChkZyIFJcjCtJyQd5XiitCQRDPLAhfbq4Wqf2wy94Gu0IutFtKmDOl?=
 =?us-ascii?Q?G1pUlvWt8BDXr/4VWYtJFQ5eLN+Va9olHXanslmoK2AEfSkHq6ZEMFgo8E4H?=
 =?us-ascii?Q?9ZvHyowHkGeCJzpsyoWvgp2UchPo4sdvR6SaMDMziSIJtIdsvOMHQH2nZBNc?=
 =?us-ascii?Q?2ytnMxNYOqUjBH+diVJIcaolPMjUixpK16ZS1t/ihbpdvQI+07iMjE4FK7Gy?=
 =?us-ascii?Q?xnR0jpqYtldz7pZdNJ/w95FykdpfwTg578qgh8aLDksqy+PyfUCZgDpNsHpJ?=
 =?us-ascii?Q?qGO27/UdmAuA6ISpmizO13efDMLf1XuieUledzHQlxg0O7KCBAOcmCKqY9aU?=
 =?us-ascii?Q?tu6iAOvuq94cCykGQdppvE2yF8lKAljGcf1ID621xqJ/LfxNP4DtG5LPNn4U?=
 =?us-ascii?Q?tRadJh5s/n6CHPjaRdLHb/K2PIkQQnmYTaNltJitpZKPyptK0B5ppqXdsb1N?=
 =?us-ascii?Q?Ox4VVMx45PkZ3aD+SOwfxrCAN4+qkSrlVImUyEqaG5I7XdguDRadk5GW/P6K?=
 =?us-ascii?Q?zZpV0uWndHUlkLnVo+PTjY/3y+rQHzYK2AbwxC7dAxFqXzaBSVXBi9pph2le?=
 =?us-ascii?Q?js2Y27He/UGUSmJQ2mjLnB4daVwD4zD3mS1V0xB0Gyk8+962d/DvXsZ/E3GV?=
 =?us-ascii?Q?cqF046izHkCxHiFdaZoOgoFDpbd1tHA1iAoWxs4Qb8WdHiOeO6Mub63B6p4M?=
 =?us-ascii?Q?PseBFM7IQiF1V6uu0+NA8VEh62hJcnQCCCqWc6RoOAjrqEsSi+/glXz5Einw?=
 =?us-ascii?Q?XV2Gy+uFcBh+zCbYn4xRPkgynxtn+aalc6P8sz6VXOdlJclxX92GkW5Tu8/q?=
 =?us-ascii?Q?MYgTygvqr0dZuXcZAqCS5tE3DMHYqpXgT62uW50CMyYxq3pb/zjUuR+waVGV?=
 =?us-ascii?Q?hswbxp0uas6s6AZ273cv6V+4SEu9Xk8GI+KhjskL5fruJr+ENAVNNjNtq66/?=
 =?us-ascii?Q?2f22hS1eAnF9kOwEQs2YoLwvJPpOeSEy8kY4LzD52D7Ax7x3JA0Q96GuvL//?=
 =?us-ascii?Q?dVjJSCOa0v/8G4Qt1DncX69CNu4SaKAVa2/EBZcXxduPEvItJSFDIMCR5PLM?=
 =?us-ascii?Q?M3M5cN6VvqTdIPlMNyLt2S2Ti1fwpJIh8kfmW5sC/oLLeDRveC22HjVEy7gp?=
 =?us-ascii?Q?zXKxA644ykKo+eEH4eA=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB7693.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4400d54-6b83-4422-bf5b-08dd3a1e448a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2025 13:19:42.9559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DJ9VBP3qPXqf+l80ytEy7nLcqBo8NI89zv/QI1fzO0jc0srWLzEOgwMjnWrSz6tk4mqBujt/PxAtFo64dix0nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5655

Hello Andreson,

> -----Original Message-----
> From: Sean Anderson <sean.anderson@linux.dev>
> Sent: Friday, January 17, 2025 4:51 AM
> To: Mark Brown <broonie@kernel.org>; Simek, Michal <michal.simek@amd.com>=
;
> linux-spi@vger.kernel.org
> Cc: Jinjie Ruan <ruanjinjie@huawei.com>; linux-arm-kernel@lists.infradead=
.org;
> Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>; linux-
> kernel@vger.kernel.org; Miquel Raynal <miquel.raynal@bootlin.com>; Sean
> Anderson <sean.anderson@linux.dev>
> Subject: [PATCH 5/7] spi: zynqmp-gqspi: Split the bus
>=20
> This device supports two separate SPI busses: "lower" (SPI0) and "upper"
> (SPI1). Each SPI bus has separate clock and data lines, as well as a hard=
ware-
> controlled chip select. The busses may be driven independently, with only=
 one bus
> active at a time, or in concert, with both busses active. If both busses =
are driven at
> once, data may either be duplicated on each bus or striped (bitwise) acro=
ss both
> busses.
>=20
> The current driver does not model this situation. It exposes one bus, whe=
re CS 0
> uses the lower bus and the lower chip select, and CS 1 uses the upper bus=
 and the
> upper chip select. It is not possible to use the upper chip select with t=
he lower bus
> (or vice versa). GPIO chip selects are unsupported, and there would be no=
 way to
> specify which bus to use if they were.
>=20
> To conserve pins, designers may wish to place multiple devices on a singl=
e SPI bus.
> Add support for this by splitting the "merged" bus into an upper and lowe=
r bus. Each
> bus uses a separate devicetree node and has a single native chipselect 0.=
 If "lower"

IMHO, restricting users to fixed names is not ideal. A better approach woul=
d be to=20
introduce a Device Tree (DT) property for the bus number and select the bus=
=20
accordingly.

Regards,
Amit
=20
> and "upper" nodes are absent from the devicetree, we register the merged =
bus
> instead, which maintains the current behavior.
>=20
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> ---
>=20
>  drivers/spi/spi-zynqmp-gqspi.c | 155 ++++++++++++++++++++++++++-------
>  1 file changed, 125 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqsp=
i.c index
> d78e114e17e0..9823d710c4d6 100644
> --- a/drivers/spi/spi-zynqmp-gqspi.c
> +++ b/drivers/spi/spi-zynqmp-gqspi.c
> @@ -167,6 +167,10 @@ struct qspi_platform_data {
>=20
>  /**
>   * struct zynqmp_qspi - Defines qspi driver instance
> + * @lower		Pointer to "lower" SPI bus
> + * @upper		Pointer to "upper" SPI bus
> + * @merged		Pointer to legacy SPI bus which is a combination of
> + * 			@lower and @upper
>   * @ctlr:		Pointer to the spi controller information
>   * @regs:		Virtual address of the QSPI controller registers
>   * @refclk:		Pointer to the peripheral clock
> @@ -191,7 +195,7 @@ struct qspi_platform_data {
>   * @has_tapdelay:	Used for tapdelay register available in qspi
>   */
>  struct zynqmp_qspi {
> -	struct spi_controller *ctlr;
> +	struct spi_controller *lower, *upper, *merged;
>  	void __iomem *regs;
>  	struct clk *refclk;
>  	struct clk *pclk;
> @@ -467,20 +471,33 @@ static void zynqmp_qspi_copy_read_data(struct
> zynqmp_qspi *xqspi,
>   */
>  static void zynqmp_qspi_chipselect(struct spi_device *qspi, bool is_high=
)  {
> -	struct zynqmp_qspi *xqspi =3D spi_controller_get_devdata(qspi->controll=
er);
> +	struct spi_controller *ctlr =3D qspi->controller;
> +	struct zynqmp_qspi *xqspi =3D spi_controller_get_devdata(ctlr);
>  	ulong timeout;
>  	u32 genfifoentry =3D 0, statusreg;
>=20
>  	genfifoentry |=3D GQSPI_GENFIFO_MODE_SPI;
>=20
>  	if (!is_high) {
> -		if (!spi_get_chipselect(qspi, 0)) {
> -			xqspi->genfifobus =3D GQSPI_GENFIFO_BUS_LOWER;
> -			xqspi->genfifocs =3D GQSPI_GENFIFO_CS_LOWER;
> +		bool upper;
> +
> +		if (ctlr =3D=3D xqspi->lower) {
> +			upper =3D false;
> +		} else if (ctlr =3D=3D xqspi->upper) {
> +			upper =3D true;
>  		} else {
> +			WARN_ON_ONCE(ctlr !=3D xqspi->merged);
> +			upper =3D spi_get_chipselect(qspi, 0);
> +		}
> +
> +		if (upper) {
>  			xqspi->genfifobus =3D GQSPI_GENFIFO_BUS_UPPER;
>  			xqspi->genfifocs =3D GQSPI_GENFIFO_CS_UPPER;
> +		} else {
> +			xqspi->genfifobus =3D GQSPI_GENFIFO_BUS_LOWER;
> +			xqspi->genfifocs =3D GQSPI_GENFIFO_CS_LOWER;
>  		}
> +
>  		genfifoentry |=3D xqspi->genfifobus;
>  		genfifoentry |=3D xqspi->genfifocs;
>  		genfifoentry |=3D GQSPI_GENFIFO_CS_SETUP; @@ -962,12
> +979,28 @@ static int zynqmp_qspi_read_op(struct zynqmp_qspi *xqspi, u8
> rx_nbits,  static int __maybe_unused zynqmp_qspi_suspend(struct device *d=
ev)  {
>  	struct zynqmp_qspi *xqspi =3D dev_get_drvdata(dev);
> -	struct spi_controller *ctlr =3D xqspi->ctlr;
>  	int ret;
>=20
> -	ret =3D spi_controller_suspend(ctlr);
> -	if (ret)
> -		return ret;
> +	if (xqspi->merged) {
> +		ret =3D spi_controller_suspend(xqspi->merged);
> +		if (ret)
> +			return ret;
> +	} else {
> +		if (xqspi->lower) {
> +			ret =3D spi_controller_suspend(xqspi->lower);
> +			if (ret)
> +				return ret;
> +		}
> +
> +		if (xqspi->upper) {
> +			ret =3D spi_controller_suspend(xqspi->upper);
> +			if (ret) {
> +				if (xqspi->lower)
> +					spi_controller_resume(xqspi->lower);
> +				return ret;
> +			}
> +		}
> +	}
>=20
>  	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
>=20
> @@ -986,13 +1019,18 @@ static int __maybe_unused
> zynqmp_qspi_suspend(struct device *dev)  static int __maybe_unused
> zynqmp_qspi_resume(struct device *dev)  {
>  	struct zynqmp_qspi *xqspi =3D dev_get_drvdata(dev);
> -	struct spi_controller *ctlr =3D xqspi->ctlr;
> +	int ret =3D 0;
>=20
>  	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, GQSPI_EN_MASK);
>=20
> -	spi_controller_resume(ctlr);
> +	if (xqspi->merged)
> +		ret =3D spi_controller_resume(xqspi->merged);
> +	if (xqspi->lower)
> +		ret =3D spi_controller_resume(xqspi->lower) ?: ret;
> +	if (xqspi->upper)
> +		ret =3D spi_controller_resume(xqspi->upper) ?: ret;
>=20
> -	return 0;
> +	return ret;
>  }
>=20
>  /**
> @@ -1253,6 +1291,41 @@ static const struct spi_controller_mem_ops
> zynqmp_qspi_mem_ops =3D {
>  	.exec_op =3D zynqmp_qspi_exec_op,
>  };
>=20
> +static void zynqmp_qspi_release_node(void *of_node) {
> +	of_node_put(of_node);
> +}
> +
> +static struct spi_controller *
> +zynqmp_qspi_alloc_split(struct zynqmp_qspi *xqspi, const char *name) {
> +	struct spi_controller *ctlr;
> +	struct device_node *np;
> +	u32 num_cs;
> +	int err;
> +
> +	np =3D of_get_child_by_name(xqspi->dev->of_node, name);
> +	if (!np)
> +		return NULL;
> +
> +	err =3D devm_add_action_or_reset(xqspi->dev, zynqmp_qspi_release_node,
> +				       np);
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	ctlr =3D devm_spi_alloc_host(xqspi->dev, 0);
> +	if (!ctlr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ctlr->dev.of_node =3D np;
> +	if (of_property_read_u32(np, "num-cs", &num_cs))
> +		ctlr->num_chipselect =3D GQSPI_DEFAULT_NUM_CS;
> +	else
> +		ctlr->num_chipselect =3D num_cs;
> +
> +	return ctlr;
> +}
> +
>  static int zynqmp_qspi_register_ctlr(struct zynqmp_qspi *xqspi,
>  				     struct spi_controller *ctlr)
>  {
> @@ -1261,6 +1334,7 @@ static int zynqmp_qspi_register_ctlr(struct zynqmp_=
qspi
> *xqspi,
>  	if (!ctlr)
>  		return 0;
>=20
> +	spi_controller_set_devdata(ctlr, xqspi);
>  	ctlr->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_RX_DUAL |
> SPI_RX_QUAD |
>  		SPI_TX_DUAL | SPI_TX_QUAD;
>  	ctlr->max_speed_hz =3D xqspi->speed_hz;
> @@ -1287,22 +1361,47 @@ static int zynqmp_qspi_register_ctlr(struct
> zynqmp_qspi *xqspi,  static int zynqmp_qspi_probe(struct platform_device =
*pdev)  {
>  	int ret =3D 0;
> -	struct spi_controller *ctlr;
>  	struct zynqmp_qspi *xqspi;
>  	struct device *dev =3D &pdev->dev;
> -	struct device_node *np =3D dev->of_node;
> -	u32 num_cs;
>  	const struct qspi_platform_data *p_data;
>=20
> -	ctlr =3D devm_spi_alloc_host(&pdev->dev, sizeof(*xqspi));
> -	if (!ctlr)
> +	xqspi =3D devm_kzalloc(dev, sizeof(*xqspi), GFP_KERNEL);
> +	if (!xqspi)
>  		return -ENOMEM;
>=20
> -	xqspi =3D spi_controller_get_devdata(ctlr);
>  	xqspi->dev =3D dev;
> -	xqspi->ctlr =3D ctlr;
>  	platform_set_drvdata(pdev, xqspi);
>=20
> +	xqspi->lower =3D zynqmp_qspi_alloc_split(xqspi, "spi-lower");
> +	if (IS_ERR(xqspi->lower))
> +		return PTR_ERR(xqspi->lower);
> +
> +	xqspi->upper =3D zynqmp_qspi_alloc_split(xqspi, "spi-upper");
> +	if (IS_ERR(xqspi->upper))
> +		return PTR_ERR(xqspi->upper);
> +
> +	if (!xqspi->lower && !xqspi->upper) {
> +		struct spi_controller *ctlr =3D devm_spi_alloc_host(dev, 0);
> +		u32 num_cs;
> +
> +		if (!ctlr)
> +			return -ENOMEM;
> +
> +		ret =3D of_property_read_u32(dev->of_node, "num-cs", &num_cs);
> +		if (ret < 0) {
> +			ctlr->num_chipselect =3D GQSPI_DEFAULT_NUM_CS;
> +		} else if (num_cs > GQSPI_MAX_NUM_CS) {
> +			dev_err(dev, "only %d chip selects are available\n",
> +				GQSPI_MAX_NUM_CS);
> +			return -EINVAL;
> +		} else {
> +			ctlr->num_chipselect =3D num_cs;
> +		}
> +
> +		ctlr->dev.of_node =3D dev->of_node;
> +		xqspi->merged =3D ctlr;
> +	}
> +
>  	p_data =3D of_device_get_match_data(&pdev->dev);
>  	if (p_data && (p_data->quirks & QSPI_QUIRK_HAS_TAPDELAY))
>  		xqspi->has_tapdelay =3D true;
> @@ -1375,19 +1474,15 @@ static int zynqmp_qspi_probe(struct platform_devi=
ce
> *pdev)
>  	if (ret)
>  		goto clk_dis_all;
>=20
> -	ret =3D of_property_read_u32(np, "num-cs", &num_cs);
> -	if (ret < 0) {
> -		ctlr->num_chipselect =3D GQSPI_DEFAULT_NUM_CS;
> -	} else if (num_cs > GQSPI_MAX_NUM_CS) {
> -		ret =3D -EINVAL;
> -		dev_err(&pdev->dev, "only %d chip selects are available\n",
> -			GQSPI_MAX_NUM_CS);
> +	ret =3D zynqmp_qspi_register_ctlr(xqspi, xqspi->lower);
> +	if (ret)
>  		goto clk_dis_all;
> -	} else {
> -		ctlr->num_chipselect =3D num_cs;
> -	}
>=20
> -	ret =3D zynqmp_qspi_register_ctlr(xqspi, ctlr);
> +	ret =3D zynqmp_qspi_register_ctlr(xqspi, xqspi->upper);
> +	if (ret)
> +		goto clk_dis_all;
> +
> +	ret =3D zynqmp_qspi_register_ctlr(xqspi, xqspi->merged);
>  	if (ret)
>  		goto clk_dis_all;
>=20
> --
> 2.35.1.1320.gc452695387.dirty


