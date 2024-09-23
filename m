Return-Path: <linux-spi+bounces-4925-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B39E597E6D0
	for <lists+linux-spi@lfdr.de>; Mon, 23 Sep 2024 09:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C194281482
	for <lists+linux-spi@lfdr.de>; Mon, 23 Sep 2024 07:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C145B328B6;
	Mon, 23 Sep 2024 07:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iotmaxx.onmicrosoft.com header.i=@iotmaxx.onmicrosoft.com header.b="cEKeRvJs"
X-Original-To: linux-spi@vger.kernel.org
Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazon11022110.outbound.protection.outlook.com [40.107.149.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CCB28689
	for <linux-spi@vger.kernel.org>; Mon, 23 Sep 2024 07:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727077716; cv=fail; b=Q6xZODn0jvF0llpsj+Zc4m5AcGysgNjg/L5hZtLzt4uNd2hj6vsLCdi7p37Ve5Srv60O/G5Mu+/kUP1G1hpwdbQH47rsahNKdyZSLEUj33o/mT0Yjs93Iic/CAHrUqBBtkX5S9/CbPvik0AtCzHKyIcL5Dtl6zSocXzBHfMqJLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727077716; c=relaxed/simple;
	bh=rMW7Udpsx/VQZRTEOaecHmAVBvw0EmGwznfBk0pyNdU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FaUIJhJTtuZRJC22+bvFEtlwFlplJWhk/aAnm9o/CaNHslpl5yK+IAHvSRR+fAlzBz4Qb/prtykgbKUPKzX9iuZdunSA0T7YQuknVBDik0cGPzmHtK3EgPTNJe2ML5WwufbbieLrJXfKHhkrl4ydilZs1Iejxnwhy3aEEMChn9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iotmaxx.de; spf=pass smtp.mailfrom=iotmaxx.de; dkim=pass (2048-bit key) header.d=iotmaxx.onmicrosoft.com header.i=@iotmaxx.onmicrosoft.com header.b=cEKeRvJs; arc=fail smtp.client-ip=40.107.149.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iotmaxx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iotmaxx.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EEtYrl2LLjpc8rQXNPPD/vmTk64Q8r3ZPiRpB5G89+xU4U1yU9eYp38w3x/JhI2T81cEqPVdvyrS9i4t0bJWZAgw24R5ZHmuxx1LTWQcSnkZUaBiDLmfTqS2OzxbD3htiUgaHpLx8Jt9cFjTx+PKRhWpSakU4lzHRP/iTb0E69iYoSPEbjb/47smc1oUD6h9rxFtCnIPa9sjOuUZLMcs9ATU+v1UYSz5r0IUsItV3+oKpAkwDDl+fgPmrBmquBhiXp2VvPiDGssvN0slPw0FgY1e9iSUOURfR2+fjigLYDSCrqQnOes6vNwAmlN9UUteLvDGcaUgZFylLIroBgXjCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMW7Udpsx/VQZRTEOaecHmAVBvw0EmGwznfBk0pyNdU=;
 b=pirg5PuSqtKOVdzi7S0vn8vMQQE4asHlsQAGfkXCDOIEmLoUmefgk6p4rfbw1QvKqAsNXCXIQIK4DM9wF5F0za7OHwsxLsaHkioYbHSls3UzdbGhZjLIRE0mwu9kR/vL166DiDH2SSDS0QQGkF1vMMclGkYM9hs+Iad8ewvI2CNrzexzlKeykw5OisOeTpE3oCipD0tQvoNxKDeDbUgIkvXKyIIDpJ9ckMnIo71rx+Noh+t0GI75eu8H2j70KjQ5TtmKa1OndJFbj9vx7Xch9xb0UAVRUjyA1TVTkzcS/4U/rt50fDYit533Oqgv/jCbWdkejJgh/brU6gTpjpPwQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iotmaxx.de; dmarc=pass action=none header.from=iotmaxx.de;
 dkim=pass header.d=iotmaxx.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iotmaxx.onmicrosoft.com; s=selector1-iotmaxx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMW7Udpsx/VQZRTEOaecHmAVBvw0EmGwznfBk0pyNdU=;
 b=cEKeRvJsDfNTEp+RSkpuEqsbZt0kThnhPYSwA0b4qU4jrsOr5jXB28+m+8O6httdsj5+8Io8O1wZirxJyVEZCn+B+KMSilDK3ewbWOnUruRjboAzU5UeEUEXRhPnl9ews1FyqeeTkS9QKgqN+7QqJgHHWu5DbyeWT6mi7KyoLiTKDrVImlZAK+eED/ypLgulGehSRGiU3e5lSGJCM5jfJgDEEbDBj1rhWX+tT8hhxDn9WYML+VrPC+GKwuoy1xJgmws8YMi8HP1qrqu5kX8krKVqSoPyon885PoOWishOcU0SOqxVQZdXw6ZuHtkXeoYP8OVJdsYsJLYjuea+gf59Q==
Received: from BEZP281MB3361.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:64::12)
 by BEYP281MB4517.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 07:48:30 +0000
Received: from BEZP281MB3361.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9ab0:1ca2:379f:bde9]) by BEZP281MB3361.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9ab0:1ca2:379f:bde9%4]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 07:48:30 +0000
From: Ralf Glaser <glaser@iotmaxx.de>
To: Mark Brown <broonie@kernel.org>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Subject: AW: migration from kernel 5.18.8 to kernel 6.10.3 spidev driver not
 loaded when device definition in DTS overlay
Thread-Topic: migration from kernel 5.18.8 to kernel 6.10.3 spidev driver not
 loaded when device definition in DTS overlay
Thread-Index: AQHbC1w/6Yctt+bYbUiB04WGEGBf2rJgyNkAgAQ4Dvs=
Date: Mon, 23 Sep 2024 07:48:30 +0000
Message-ID:
 <BEZP281MB336107A0693341C9BB88B88DA56F2@BEZP281MB3361.DEUP281.PROD.OUTLOOK.COM>
References:
 <7bbd3bc198a84e25ba25e28a6989ba3cBEZP281MB3361E029FEE3756F30ACBA99A56C2@BEZP281MB3361.DEUP281.PROD.OUTLOOK.COM>
 <Zu2RVC1vGUh_-KYb@finisterre.sirena.org.uk>
In-Reply-To: <Zu2RVC1vGUh_-KYb@finisterre.sirena.org.uk>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iotmaxx.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BEZP281MB3361:EE_|BEYP281MB4517:EE_
x-ms-office365-filtering-correlation-id: 561beb42-4a28-4d40-6cf4-08dcdba41ddc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?/fXSn/82A+VaU9mPuGXhmDyDFpp8lFgTBGs66AXQA3yp/jmeheVxM5nnwQ?=
 =?iso-8859-1?Q?FKOGAfs/ExWnsmyvq7ktowtDMUrMtsJTyPZjdo2G21c7T4aP9fX+VQZsqk?=
 =?iso-8859-1?Q?+rhSSvGFIu7DEBpJBbLelIhKsGHFK4V1nk3XoPRpAzPRpM+bIMDwobGrh7?=
 =?iso-8859-1?Q?oLLRx1jiamfGUVoyWqoGdmecTlMb+FOggljlG+BVgzj/fntghLBygjZwyg?=
 =?iso-8859-1?Q?jTEvoR9OHZbnEZkhqbsM49gmMfXSbQK5Tvjvqvo6FibyCezz+XWUdTRH1R?=
 =?iso-8859-1?Q?hYusjASujiilj+vhqj0CYwx8XbJa0GKYKFeUr1EynrK2VujfdNW5ZPmSzg?=
 =?iso-8859-1?Q?x1u0lNmeGE/Jl3vPsYklT6spyamd0hAmtFPrSpJbTnOKK4IaovDqQfJmFp?=
 =?iso-8859-1?Q?o4E7x6hMlDhcXMWaLC8wpodzHLtVJuUFb+Y9R3v2FeEbYxR8ym275qAZpz?=
 =?iso-8859-1?Q?VbVCF8WE7+c0zgBu/VdFrRLCKEzids6JfXWV9KuGqIvJCq19Ddde5xmjYs?=
 =?iso-8859-1?Q?7PrHtcEJnQq59l9ValOEhR3oZHpoJO7NpfopAHBbbM5/Z7tDooliqVSVnO?=
 =?iso-8859-1?Q?x5tpw+xlZaFr0XSpYd/7CKyxd2F/IiWmY0zEshY3b0zkmzBxMrTMiQ+MT4?=
 =?iso-8859-1?Q?/2v63aUujNqU3h4kTGI66hDc70yplGkcx20z0cqz9s70XLNwf3jL03YkDV?=
 =?iso-8859-1?Q?BOdnKBpP7nb6kYxgjMeuFeXYOKuHlA5uvj3zKMA3BS0ZEJTlykWCZfumYI?=
 =?iso-8859-1?Q?RkLn1dPkyIaIhaDzU7Dr//vblYc7HkaQhKdW8rniKQV02wkZxB7cU9cVGi?=
 =?iso-8859-1?Q?P64KAtZ4FYpFskSQp5O4f7+vrcccGbJh9YHNgvgF7jZbr+L9XzgUJFJk2B?=
 =?iso-8859-1?Q?VovivCx8Qmjveq41bOpEGmDE43TIyjE+AFITc1MFPzhbkIdO7EwqdCN9mq?=
 =?iso-8859-1?Q?irBE8AGMo5l+lihoHN4blAe2m0f4XdbPUCTq64mPf5j4kJljfu949khhC7?=
 =?iso-8859-1?Q?QWfQ9bWT9LJ+nEy8Bj6leaf18RfL65AY96dVm60+JzrX3ZALjV2D459poN?=
 =?iso-8859-1?Q?54U2BTGIipk+YaX8ivEYYooWL84LQSuMzuwTJdjRmHJYkAJmWqyQvCNjdM?=
 =?iso-8859-1?Q?bI1EFgSrovcF7QauXjX2v93bpAkcwql82GuZVtRCIr/Kk8fNNv0d05KCCG?=
 =?iso-8859-1?Q?pWbo3iQH1DfBjKDzHqEL4WbDQPx1/iZ1BVWKCMHvyXgKH9y6+aoF/3MEdu?=
 =?iso-8859-1?Q?bKpGuEPIK6801iI89sWTtyLXYLtZkZxKi7shnKzCQC8CIbSXpdHiJbhGKH?=
 =?iso-8859-1?Q?4s+uZsKDKUC2Iia+p0tVRyfIp4R34OA7gCffkSCPiM7by6LJglqx8avltE?=
 =?iso-8859-1?Q?9AZdkPKhcQ50YkEdZ7mYDQEA+/0JVO7w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BEZP281MB3361.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?vLFPYAX15yjaRrmU6gYyvTWN5MJ+Apb274HWNyMaaUqzEQ8gQG2Vih8erI?=
 =?iso-8859-1?Q?eW2TKvWOneCmQ5uKYDZVIbXi3dZ53VieQT8PV0foC/0Dsix6sNt79ZH7nl?=
 =?iso-8859-1?Q?+o5C+VlY3bCm1dx3eIyQSC7jb+98p/NJtmuw5W44eol+J9TQioAzFMGHUX?=
 =?iso-8859-1?Q?rJPyYHFy3gxMyOkg3YpucNkfqRHS31y/xZAVZ97Tf0kt9wLZttIx6oDBZT?=
 =?iso-8859-1?Q?Q+m5+U5aK7BwBkJKSGx+nIiNU4XTIgBTA/fiEPRpTuFqsowuQBoKNVLoNX?=
 =?iso-8859-1?Q?l4JzLYk0x++dEDgA5oKb0nMbgNK0WKpCBxSJE3AH22Hlb/kBFVS+lfT/iM?=
 =?iso-8859-1?Q?EQMX292x1zYy+Xk4VhMcB0U5KmF2Tvhjcagwe7nRC/u296+ZlcseoYOAwP?=
 =?iso-8859-1?Q?RQLpTHe7batBNMqBnPmNBoU+6Z0Ly8jSKz2JslvePlj3xLOHtu7Pc+8ptY?=
 =?iso-8859-1?Q?Fy3NGgtY6rhUYKbSuA6igwPxbRg/tjJbtuzF2bG60Xl9uwziPg+NNlzFnF?=
 =?iso-8859-1?Q?LJbu687lc0pnWR8keL3seRvxugnpRsEPQuCqHaNMBAkNB3ToYIddtlPUmd?=
 =?iso-8859-1?Q?uANhL4Zej+M90FneELHwYnSEPnZLACJ3GvZyIyRtaFjMXBKGWGEO8iuL+2?=
 =?iso-8859-1?Q?WbmZKAdHSoZXKr0X/OIeACuxbRDXkXotgupnllyF7Z5KOfpBK1hh8GPo32?=
 =?iso-8859-1?Q?tLf/icp3UyTDQcIbHoGLuLtdipwVrqnEhWrnHdK7E1bD5rm9HoMgNHrvC3?=
 =?iso-8859-1?Q?n7YBZSBp81KnQZu3449OqdV0ozfBc6kSzV1gRPi+2utUVGVEHoCwc3x9so?=
 =?iso-8859-1?Q?rUPsfwvtIKIecasdfMyZH74GyqbFJJN3s+hqHrGm/9xcow8TvAOGmrS10g?=
 =?iso-8859-1?Q?yf1B5B+STc2dT3pCyXwHXLtUxELNnt1s4rsFX5g7jwI0gQhnB7qgjgBmkk?=
 =?iso-8859-1?Q?mCcn71Mgo+WnDxzA32qD0a39u+l4EGg9ajRS6gpgErvxU3eHwcsKfRR6gn?=
 =?iso-8859-1?Q?mpA+aXEQO8jDmbbNyn21DHctGx68rzwxzrWwKZX8wQZkZu1d1qXplIf8kB?=
 =?iso-8859-1?Q?ROnRP5o2RQIGDcpuy5Zo0a2CSvx0lvJmdupuLdMyAI68J5vXQaUbs0wm0e?=
 =?iso-8859-1?Q?B072wqgW+Qg/fVDK/z1403sMBr4emLbOWlnaTf9TwL7SMrfYog4YsuypvL?=
 =?iso-8859-1?Q?M+e5HwN6D5SDV7EoSyl4gFj49gJ//KbP9W67zYxrZr49E56Hgo+LtTI4YK?=
 =?iso-8859-1?Q?7e/hm+7m04fbgHG/uy90CC9S4flj/vy02GoO0QouB0dKEXZ0WK2LTR3kZu?=
 =?iso-8859-1?Q?XGlirAM5bCpqz4kKIt3JT/780v1pWFXgzoTGzqsaOVhOrUuiF8H6nSd0tD?=
 =?iso-8859-1?Q?tEs9QMAt9WHmNH5xW+SRKIkIPInEiSh+AIi8yHitJ7K8EwAyToPRsiL1ml?=
 =?iso-8859-1?Q?r44JXpkZKPIxoYDKGbW7MdOJ51a5oPwWhxFOoq2jtk8IINJU98PHOI3pVr?=
 =?iso-8859-1?Q?yn3ZGRgrPPtG9g8M3AZNyWYRtGe4qhhppnDv110413tJpf5hSKwpmICsri?=
 =?iso-8859-1?Q?EPNERF9pbrwZWEU9cb1rdxoJ+/FIC2hToLhRGW6aPflEfQM+uLDdqJ8dkL?=
 =?iso-8859-1?Q?z9u/xiVf9B43r077O1uXPlF4Uu4+3r9hCf6UlmA1NhHeHAokX0z8Rc30W2?=
 =?iso-8859-1?Q?mQuF56lKnCJxfejSm0A=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: iotmaxx.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BEZP281MB3361.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 561beb42-4a28-4d40-6cf4-08dcdba41ddc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 07:48:30.1636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a87713f9-2dd4-4b97-bace-ad3bca53b833
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RCrhpIj180FPdusoYIlTvHAJBAlf1GLlAaHS4efx1xXvbziDtUvffpWZq1vTN7ysPo5Pxvtrqzf9Mna05J3sZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEYP281MB4517

Hi,=0A=
=0A=
should /sys/bus/spi/drivers/spidev exist when the spidev driver is availabl=
e or is it created only if there is a suitable SPI device?=0A=
=0A=
Besides this i will ask the DT people if they have any ideas.=0A=
=0A=
Best regards,=0A=
Ralf=0A=
=0A=
=0A=
=0A=
________________________________________=0A=
Von:=A0Mark Brown=0A=
Gesendet:=A0Freitag, 20. September 2024 17:14=0A=
Bis:=A0Ralf Glaser=0A=
Cc:=A0linux-spi@vger.kernel.org=0A=
Betreff:=A0Re: migration from kernel 5.18.8 to kernel 6.10.3 spidev driver =
not loaded when device definition in DTS overlay=0A=
=0A=
=0A=
On Fri, Sep 20, 2024 at 01:24:00PM +0000, Ralf Glaser wrote:=0A=
=0A=
=0A=
=0A=
> sorry if you received this mail twice, it was refused by the kernel maili=
ng list and i was not sure if it got discarded completely.=0A=
=0A=
=0A=
=0A=
You turned off HTML for this one, but also turned off word wrapping...=0A=
=0A=
=0A=
=0A=
> On 6.10.3 no /dev/spidev2.0 is created and /sys/bus/spi/drivers/spidev do=
es not exist.=0A=
=0A=
=0A=
=0A=
Well, if the spidev driver isn't there you'll need to fix that...=A0 it=0A=
=0A=
might also be worth trying mainline here in case there are any fixes=0A=
=0A=
that stable didn't backport.=A0 From a quick scan nothing is jumping out=0A=
=0A=
though.=A0 As far as I can see that's the issue, the driver just didn't=0A=
=0A=
get loaded.=0A=
=0A=
=0A=
=0A=
> If i however put the spidev definition in the main DTS file everything wo=
rks as expected:=0A=
=0A=
=0A=
=0A=
I've no idea what, if any, special considerations there are around=0A=
=0A=
overlays or the specific mechanism you're using to load them on your=0A=
=0A=
system, you should talk to the DT people about that I guess?=A0 I wouldn't=
=0A=
=0A=
have expected the use of an overlay to make any difference.=0A=
=0A=

