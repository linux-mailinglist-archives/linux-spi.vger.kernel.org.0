Return-Path: <linux-spi+bounces-11571-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F070C88AA4
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 09:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CDFB84E7CE7
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 08:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF52318149;
	Wed, 26 Nov 2025 08:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RK7b29ae"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010008.outbound.protection.outlook.com [52.101.69.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EDC31815D;
	Wed, 26 Nov 2025 08:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764146064; cv=fail; b=rreZ4ESpWPlJaylh73E2AzG9UzoFhy+rTMacuedumFEtXN4WdC0LRPpBSUHJ4VXqD1L+yqWDShgZgGqc+A138ptoozgixkx1VbMzdU0z1nY30FxWRfLOvCy/8PeOX0lFpZe4jeWnuyHnRl2mDwG4vo33Mlhy7SzoCgjdb8HUmHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764146064; c=relaxed/simple;
	bh=Vh972ZjiYvuatd341wjoys5ALZEyrZ1PGe7IA0K1NBU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HqHnJP+XoO7wX9N0ObFX18ln0U1Os2ky8MrpS4/190s+HcYtxFxirsAT8NqqE7blB9ft0KY3BVrWq1I+7+T/M7fdrqohUN4dwCT3P4D83SwTdpUddkpJ30+QaMV7KZ9nqxh0eKlAdnxJwXUokLt2UdzDxVHD2DUsr8jvPXOSyvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RK7b29ae; arc=fail smtp.client-ip=52.101.69.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZLBBJklOSLfz2Wm1ezO3DbKNUbcbYgZrloFGfJTFBmy5S/c6pLXig4SJiz3ENhJ/67fdgopEpYJxP8rMabm80Vjmz1PaUpKtC/nDXOdjXBmFc1ZE5cnCsFBj2mucI2ly9+q4QfrPJSmfto2SEVJJcUYjv4s3+4tndgafFu/SZ72qCLnYshzXwpvfeaPmW2fBVTZcmlIvtssC54Wd311CMRqGZTnSi3DOe5H1rQZhPaX9H30JcREmnUIBj1rpW0nCKOlSMdK30Amca16Mit8LV4LsATI7ePjXikDdG3ZPlm2ayaUEze/OO0JNri5FIoY2Aa3GKxGnc06X8sJuyRvzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vh972ZjiYvuatd341wjoys5ALZEyrZ1PGe7IA0K1NBU=;
 b=BiohcdkJMYI5/cEaZdFkZ+65cbnY4jfqjCJergUjWwZJ/TiSCIC6wjfTumKO/Yh2vcGGhZXQ60h3e2IDMuWz++DLCr4+Pr8UPpsBPK9O+lUfq7nd2eBE7HLdYZwkfpHUPnMLWqRVenWgXecawCh8TyiCA259aNgg0J1G7jj+twdd+nCIz8SDa/X6EEFKozlV5uZ1wddMXNK3d3NYYQSu4/KMzFwNZK4NAqcYynljksQIasV3PiCAAL4lXwuh5h03En2LaAw3lquZXoGNHkHb4qRqmk4Ih1oppZ++5Of+78dKcN2HFhrkImENFY0jqgCMe70dY9pY2gH1CufNPrDCig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vh972ZjiYvuatd341wjoys5ALZEyrZ1PGe7IA0K1NBU=;
 b=RK7b29aekxH7RwQQJzHwmVQ7obHug+kKy+DPo2dAteRVmqbVkW53Gb4V3uiZcstKcvACBSIgmlZHSJg7A5jFCncwPUwOz1hH9FO/lAP5wnnB2NjU7rYz6lpt1OwPOoFBrKksQ2jj5VW+DaVmQpBeiMZ8ib0rghDtIB6iVdcZEq39DyNtp6in74YTYSGwugRlSO8+GO4KFOTdfjjznf3LG7cfzwfaceSNlm2dYc84+D3SxuX/zjgUdC3NuV6cdyl88CibYgok5l8LzOtMwfF5IQkbs6rC0RSjvFq79/LxiSJgT3ywJzOU6lC02/IE1vvs7e9AVGTN9GfFDn66H54xSw==
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by AS8PR04MB8772.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Wed, 26 Nov
 2025 08:34:19 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 08:34:18 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: "broonie@kernel.org" <broonie@kernel.org>, Frank Li <frank.li@nxp.com>,
	"hawnguo@kernel.org" <hawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH 5/6] spi: imx: support dynamic burst length for
 ECSPI DMA mode
Thread-Topic: [EXT] Re: [PATCH 5/6] spi: imx: support dynamic burst length for
 ECSPI DMA mode
Thread-Index: AQHcXfNVDK4T0P1c8k+DMajAF1tbjLUEnxqAgAACVzA=
Date: Wed, 26 Nov 2025 08:34:18 +0000
Message-ID:
 <VI2PR04MB1114788C5ADCB9D42399D12C1E8DEA@VI2PR04MB11147.eurprd04.prod.outlook.com>
References: <20251125100618.2159770-1-carlos.song@nxp.com>
 <20251125100618.2159770-6-carlos.song@nxp.com>
 <20251126-invisible-almond-bee-86a27d-mkl@pengutronix.de>
In-Reply-To: <20251126-invisible-almond-bee-86a27d-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2PR04MB11147:EE_|AS8PR04MB8772:EE_
x-ms-office365-filtering-correlation-id: 1ae66745-d519-4b3f-815d-08de2cc69769
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Zm5pdHpKc04xWmhFdStiTHFtdUZkTVlCcHhpalNWb1RPam9SRjROTkNOZW9E?=
 =?utf-8?B?SG5ZSUs0cmVoL2FoUGNLODIwd2FlR0dXK25NcVRsVHhZN3ZpTmVvRW9DZWI0?=
 =?utf-8?B?VHBKVnI3Z3RaaEFYUGJXWm92eEU5Wk9RcW5uUTJkTXZxTFQxaTRUNWlac1Rh?=
 =?utf-8?B?eVV1RjhNa3V3L3JYTGYxK3JmK0R6cnhxVVBlUGMwN1l1SXZaUHFQcVA1RWdN?=
 =?utf-8?B?Q3hMdGVNeTZvaSttbks1OUhETlNlcGZNVkx6QUQ1R3hiLzNBUXZiWVVLZnR4?=
 =?utf-8?B?S2txSVF1U3l5TjFtMURNSDhTL0hkWHNQbkdVUEhVcXZmczNQRGFPQUVhY25R?=
 =?utf-8?B?dzRhRGRXV08yakVIUW84UGJSNTMrZ0xxMWQyTG4xQWRxZ1UzN0lmZ1d4TGs0?=
 =?utf-8?B?dHk4RVE5Tnpzb2pRbVh4TXpDU1dybERBMEZPVHBURzE3UEpEb1dVRi9kbFp1?=
 =?utf-8?B?S3FxalBWUGIwaFpkM0s2ZzVDNWVwQ0RSYTlYdG00UUJLSnU5QkFkTUxhUHBk?=
 =?utf-8?B?SGtoSEdSL2ZzdGwxR2oyUnJOUVVnUWxycDdad1Areis5dDQzY1p5ekJYZ1JD?=
 =?utf-8?B?M0I3bDN2YXp2R1pIbSsvZzZrUjUrclByZGpWMDl6aGtXaVJaZzM1b1lSNHBC?=
 =?utf-8?B?M3ZMYk5QWnU0YVRhRE55MWk3SnlHT2NnejBSMVZXajY2TnY1VittZmttVzVJ?=
 =?utf-8?B?WlZqOEF2RnlPOU1Va05jTTJQdXNtZG9CY1JNYU13WkVNT0lTM01SQ241dHNn?=
 =?utf-8?B?TUpjQzl0QmlYdVJYanF2cDVJbnhRTWlTQXI5Um50b05YdFJoQTZRYmpuOVhn?=
 =?utf-8?B?WWpkejFJd3VXcE5LMUZGaGs5VHZlWVBWeWpXZEgyYlBQQmo3cmRtNWk5MWd0?=
 =?utf-8?B?ZmRITUtPM1Npd24vaW15NEVVRXRSSWRMUGFNdFArQWdVQWpUb2dEeUNXRFdt?=
 =?utf-8?B?TWt1c0hXaFo0N2lYbmE4WTZlYnpvaDdldTNwNmlVOWRtY1VFeHU2Y1R0ak5Y?=
 =?utf-8?B?VFhMaXhxekZ2bGxCNTY4UGdRaEtvWndCM0NHZDZsSUpnK29Rb3Jic0FuUjQz?=
 =?utf-8?B?bUNQN3haVUFSMHZXNGVXL0kvYjhqYTVWRjcybWZPcGdJVG0ydDgyNk05Sjln?=
 =?utf-8?B?RjhXL1RxMDNXYjNUeXBOdUNMY015QTJzemV6QlhkSkovT2NXaEZSak51TE9I?=
 =?utf-8?B?em1pYTBoelk0ZGluc245RUdldFJQQnZ6NFVSWkNaWW9aeHpxWnZOOE5JTTA0?=
 =?utf-8?B?aTNMdi9haWxBUnRQcmU5U0IzeVEyQ1lIMUlsb3R6RSthN1V3Njg4ZVhtZzIx?=
 =?utf-8?B?SzJFVTU5TTltWC9rNFB2eU5JZ3RMV0U0S3FEM1AwQXNUR0dUY2lDQWQ1UDQy?=
 =?utf-8?B?STBNdUZwemptaitQTzdzVzNhWU9OSzAzY2h6WlE4NTRra2JVci9XVldjSWlu?=
 =?utf-8?B?RU54Y1p6dGtLTTJBSDJpUjdZWU1hMyt2cm56SWc5bStkRTN5dkcvRjlSNncr?=
 =?utf-8?B?TWxtajFheEN5U1FxdHhOMC9EUDhSV3dFU2FwdHNiRy9SZzBzUE04WW4rWHc4?=
 =?utf-8?B?cW5KSUZTOTN3WUpMOFRrakJBaXhpL09xNkFSZ0dxYmcySGxLaXZWK2tsbUtG?=
 =?utf-8?B?NWdITmtWY3JBdmF0V3B5bHJYVlNub0lTVzhkZnZUbjl1SEhRM0RJRlIyWDlx?=
 =?utf-8?B?SFE4bUtJWkpQVFFmbXdxcGtwN2UvMHR4UGR1ZDFvUHdRcTJ4TGxFMUhzQjNr?=
 =?utf-8?B?L0Zpdk1XUFFKQk5QRVQ0aGs3ajRwZDR3cFd4UFJPUXNhOEN3OEhaWWxmZ0Jz?=
 =?utf-8?B?NW91RDQ3aWJXQm1YM0JNQnFsVDJsNlFYbVJtRGNoTVFrRUJxSVl3Y2V1ZEJw?=
 =?utf-8?B?S05vNk9zZUJoSGhlK0gzQ3FlMDkzd1gxMGxwTWtSaGJMWGFQdGlzaHloeDRx?=
 =?utf-8?B?N3VWQzFGYjNJd1hvTFZtdDY2L3ozZ3FkNDNWVTJESDRBb3k0anI4R2NLMTFr?=
 =?utf-8?B?dUJ3UXAycmd3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bUMyUlhzQnVNVTZwQURDZEJXOXFVWFp2bmJtTFkrRFBPbzhJWG9aR2lvS2Vx?=
 =?utf-8?B?Yi90aFJyUHc2MXZ4YjR5Zm9wUW5tSEtkVFd3RkU3a2U5Mkp5UHRpTmozWWlL?=
 =?utf-8?B?VG4xRms0eG1sdUJTM2xudlovVUNmQ0xTRnFJRitDbkk3VHZKcG9JNzBrZitj?=
 =?utf-8?B?TjJGeDBtSVBCRjA3bkZpRWZtYXErd2xwV25TLzFMQmNwM0dHdUhySDJLZG8w?=
 =?utf-8?B?bmtjUHk3Y0dQTDFFQnZrTVZISXpHVzg5QTJuZEhkVlVzOXNyTDNiMEtEcCsy?=
 =?utf-8?B?VFVMTkxDRzJhd2xMZTVlSnN3Q2lKYlNqRE5LVkdEMWdCbjllZk9tZkVmc1Qy?=
 =?utf-8?B?cmFJbjY1NzM5OU9FUDB0TXVpUHZhV0pYeUd1TFBkSVFlaVhjajd3Z3R4ck1M?=
 =?utf-8?B?eUN6dWJQTlVXNVprQzcwOUdKV3hLOWpkcFdQU0M1NVBZaVFheHN3UExqNTNh?=
 =?utf-8?B?SzF0RkZENzQyUXo4RWhzbzBBeUptU2NzM3FJaDZpU1ErV2x1WHVUWDdDRDBu?=
 =?utf-8?B?RWJHM2pJb1JWQzU4TUNqSzc5RlpzTG4vZWsvNWRMVjZnTXQ2MFZIY0ZVZzg3?=
 =?utf-8?B?VjhNdExNTEtUdjVNRm1yRG00bjh1QlYvUkcwdlhRbnd4c2VsQ3duUEl4bG4z?=
 =?utf-8?B?ODN6c0RZS0RQc1NVbGx5Qk1xeUJLZFZJRnA5WWozSHpBb3R6UUdZM1NHekY3?=
 =?utf-8?B?bjJJd0tLclQxZHNwR2RnUExWN20wODNxLzVvWnBkV3hkU0picXNrcldPNWUw?=
 =?utf-8?B?T3ZBYlF3RnNBLzg2T0ZLaXpWQWR5N0Z1T3R4OFVnekhUdFdNY2pHM0FQZUMr?=
 =?utf-8?B?eUdIbG9MUkkwMUhwaUJFb2FIaE8rV3ByWjlxVWp3OUR0UVhVdC8yUXRYN2Jx?=
 =?utf-8?B?WmZmNDVuaUo2STA5SFkxalZiUUNmeTJiT0FGeSsvbGQwWnFhaHJqcC9sNW9O?=
 =?utf-8?B?ZjRLYXBzcHhlWG5LR0I1Z3RCc0FkYktSMmwrUmhyOEhxalgyUFBsdEtkNitR?=
 =?utf-8?B?Q0piNjJ0d0ZwRnhaZ2dCN0pJUEF6L3h3NmpQb1dNSjZnZzFrb2MwMlQ5cWJ3?=
 =?utf-8?B?bEJ4TjU1SVNzRCtzSllTd0hPVjN6a0l2ZW1BcVo0NFNFNGJLWnpLNWN0a2g0?=
 =?utf-8?B?ZWZmb0V6YU5PZGFaZUtDZ05XZm5BTUhxVzczQnNRZjIyTURMZzdBa0lZdHdI?=
 =?utf-8?B?MjBQSSt6RUcwVWRpVUxkamN0cHMyVGlDa0ExWFFlSkVGNm5NSWtKK0F0a1Qr?=
 =?utf-8?B?Qkp2Y2ladFMwZ2M4T1Uxd3h1alNieUpZME5ZUlViS3dxVGUyeVY5dkdzcmZL?=
 =?utf-8?B?K0F5MDlvK0ZpanpQRThFU0ZlcWVTR1VVVS9DOFd6Z2VCOFRlUm00NWZPcGNU?=
 =?utf-8?B?OTQrTkt2T0g1cVpER3FKRTdBMEtBVkJ3TzdxNkVaOGRLOWlmeTN3MGk5RE15?=
 =?utf-8?B?aHltczFCNTIwZEIrRU9lNmsyT2dKTVlZOVZ5a3lhaCt3eXB5dm9HOE1oU3Fz?=
 =?utf-8?B?NlREZGljMW1rL1M1RWVMQU5mUFI1MGEvNG0yNG9xa21veHdXTDY0L3pQS2Na?=
 =?utf-8?B?WFE2Z25NUE84ekxVb3RSMVZxc21YMkdJWHdjN2FNVzdoNGJwSjdXckV3aHFC?=
 =?utf-8?B?YnNNSWdJRittWEFreW5Ud08wODJXTTdWVFJRRk5zSllVU0lUNlNvaXFkVkps?=
 =?utf-8?B?Y1J2VzdNTzZJTC9JOThRQnBjODRNeVBuSWhjVzFsNmZnc1E1Tk5weG45WE05?=
 =?utf-8?B?emhXNUJ1YnFQWEJVUlVJdDhmckNhdVJhYWZ3ZkxzK2l4bU5UbUkyVEcxcVhI?=
 =?utf-8?B?L2YwU2F5OXNZcUJrM0dDVGhKeWM0UzBwSk9Rb3JaaEF4QVo4WG1ua0wxRFZZ?=
 =?utf-8?B?MW1sYi9ORHpyb20vZTZia1dKY2krQXJpQlpNYjg2NVBLdXpBVkVwU3VmSFVU?=
 =?utf-8?B?aE5hMk80aEt6a01vRDlhQWZoMmw2bkdWRFJOWmIvMXFPZjB6WTU3SmpxTnlQ?=
 =?utf-8?B?RlhucktSL2ZVeDN4SzJKYng1dWVXTzZuc05oNXR1MGFCcXlkM2hxNENvOFBv?=
 =?utf-8?B?aXF2aWhxSUNaTmtjNlVTa1IzdG1CYUxrbjBrME1sTWlxZkdmWFJJV2M2QzBk?=
 =?utf-8?Q?qkZ5AmNy54m7yRtQ2/GGL4VGe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11147.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae66745-d519-4b3f-815d-08de2cc69769
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 08:34:18.8100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YQN4ZLi8sBVglU08lOuhMfk8x73W7x1OHk8Fh1JkBkxhR2zqrFWFT85eYmVDmeBLtOb7pJKkdfDsazpCoNw5oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8772

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyYyBLbGVpbmUtQnVk
ZGUgPG1rbEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAyNiwg
MjAyNSA0OjIwIFBNDQo+IFRvOiBDYXJsb3MgU29uZyA8Y2FybG9zLnNvbmdAbnhwLmNvbT4NCj4g
Q2M6IGJyb29uaWVAa2VybmVsLm9yZzsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBoYXdu
Z3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRy
b25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBsaW51eC1zcGlAdmdlci5rZXJuZWwub3Jn
OyBpbXhAbGlzdHMubGludXguZGV2Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVF0gUmU6
IFtQQVRDSCA1LzZdIHNwaTogaW14OiBzdXBwb3J0IGR5bmFtaWMgYnVyc3QgbGVuZ3RoIGZvciBF
Q1NQSQ0KPiBETUEgbW9kZQ0KPiANCj4gT24gMjUuMTEuMjAyNSAxODowNjoxNywgQ2FybG9zIFNv
bmcgd3JvdGU6DQo+ID4gK3N0YXRpYyBpbnQgc3BpX2lteF9kbWFfdHJhbnNmZXIoc3RydWN0IHNw
aV9pbXhfZGF0YSAqc3BpX2lteCwNCj4gPiArCQkJCXN0cnVjdCBzcGlfdHJhbnNmZXIgKnRyYW5z
ZmVyKQ0KPiA+ICt7DQo+ID4gKwlib29sIHdvcmRfZGVsYXkgPSB0cmFuc2Zlci0+d29yZF9kZWxh
eS52YWx1ZSAhPSAwOw0KPiA+ICsJaW50IHJldDsNCj4gPiArCWludCBpOw0KPiA+ICsNCj4gPiAr
CXJldCA9IHNwaV9pbXhfZG1hX2RhdGFfcHJlcGFyZShzcGlfaW14LCB0cmFuc2Zlciwgd29yZF9k
ZWxheSk7DQo+ID4gKwlpZiAocmV0IDwgMCkgew0KPiA+ICsJCXRyYW5zZmVyLT5lcnJvciB8PSBT
UElfVFJBTlNfRkFJTF9OT19TVEFSVDsNCj4gPiArCQlkZXZfZXJyKHNwaV9pbXgtPmRldiwgIkRN
QSBkYXRhIHByZXBhcmUgZmFpbFxuIik7DQo+ID4gKwkJZ290byBmYWxsYmFja19waW87DQo+ID4g
Kwl9DQo+ID4gKw0KPiA+ICsJc3BpX2lteC0+cnhfb2Zmc2V0ID0gMDsNCj4gPiArDQo+ID4gKwkv
KiBFYWNoIGRtYV9wYWNrYWdlIHBlcmZvcm1zIGEgc2VwYXJhdGUgRE1BIHRyYW5zZmVyIG9uY2Ug
Ki8NCj4gPiArCWZvciAoaSA9IDA7IGkgPCBzcGlfaW14LT5kbWFfcGFja2FnZV9udW07IGkrKykg
ew0KPiA+ICsJCXJldCA9IHNwaV9pbXhfZG1hX21hcChzcGlfaW14LCAmc3BpX2lteC0+ZG1hX2Rh
dGFbaV0pOw0KPiA+ICsJCWlmIChyZXQgPCAwKSB7DQo+ID4gKwkJCXRyYW5zZmVyLT5lcnJvciB8
PSBTUElfVFJBTlNfRkFJTF9OT19TVEFSVDsNCj4gDQo+IFdoYXQgYWJvdXQ6DQo+IA0KPiBpZiAo
aSA9PSAwKQ0KPiAgICAgICAgIHRyYW5zZmVyLT5lcnJvciB8PSBTUElfVFJBTlNfRkFJTF9OT19T
VEFSVDsNCj4gDQo+IGluc3RlYWQgb2YgcmVtb3ZpbmcgdGhlIGxhdGVyPw0KDQoJZm9yIChpID0g
MDsgaSA8IHNwaV9pbXgtPmRtYV9wYWNrYWdlX251bTsgaSsrKSB7DQoJCXJldCA9IHNwaV9pbXhf
ZG1hX21hcChzcGlfaW14LCAmc3BpX2lteC0+ZG1hX2RhdGFbaV0pOw0KCQlpZiAocmV0IDwgMCkg
ew0KCQkJaWYgKEkgPT0gMCkNCgkJCQl0cmFuc2Zlci0+ZXJyb3IgfD0gU1BJX1RSQU5TX0ZBSUxf
Tk9fU1RBUlQ7DQoJCQlkZXZfZXJyKHNwaV9pbXgtPmRldiwgIkRNQSBtYXAgZmFpbFxuIik7DQoJ
CQlicmVhazsNCgkJfQ0KLi4uDQotCS8qIElmIG5vIGFueSBkbWEgcGFja2FnZSBkYXRhIGlzIHRy
YW5zZmVycmVkLCBmYWxsYmFjayB0byBQSU8gbW9kZSB0cmFuc2ZlciAqLw0KLQlpZiAoKHRyYW5z
ZmVyLT5lcnJvciAmIFNQSV9UUkFOU19GQUlMX05PX1NUQVJUKSAmJiBpICE9IDApDQotCQl0cmFu
c2Zlci0+ZXJyb3IgJj0gIVNQSV9UUkFOU19GQUlMX05PX1NUQVJUOw0KDQoJcmV0dXJuIHJldDsN
Cg0KSnVzdCBsaWtlIHRoaXM/IEkgYWNjZXB0IHRoaXMuIEkgY2FuIGZpeCB0aGlzIGluIFYyDQo+
ID4gKwkJCWRldl9lcnIoc3BpX2lteC0+ZGV2LCAiRE1BIG1hcCBmYWlsXG4iKTsNCj4gPiArCQkJ
YnJlYWs7DQo+ID4gKwkJfQ0KPiA+ICsNCj4gPiArCQkvKiBVcGRhdGUgdGhlIENUUkwgcmVnaXN0
ZXIgQkwgZmllbGQgKi8NCj4gPiArCQl3cml0ZWwoc3BpX2lteC0+ZG1hX2RhdGFbaV0uY21kX3dv
cmQsIHNwaV9pbXgtPmJhc2UgKw0KPiBNWDUxX0VDU1BJX0NUUkwpOw0KPiA+ICsNCj4gPiArCQly
ZXQgPSBzcGlfaW14X2RtYV9wYWNrYWdlX3RyYW5zZmVyKHNwaV9pbXgsDQo+ICZzcGlfaW14LT5k
bWFfZGF0YVtpXSwNCj4gPiArCQkJCQkJICAgdHJhbnNmZXIsIHdvcmRfZGVsYXkpOw0KPiA+ICsN
Cj4gPiArCQkvKiBXaGV0aGVyIHRoZSBkbWEgdHJhbnNtaXNzaW9uIGlzIHN1Y2Nlc3NmdWwgb3Ig
bm90LCBkbWEgdW5tYXAgaXMNCj4gbmVjZXNzYXJ5ICovDQo+ID4gKwkJc3BpX2lteF9kbWFfdW5t
YXAoc3BpX2lteCwgJnNwaV9pbXgtPmRtYV9kYXRhW2ldKTsNCj4gPiArDQo+ID4gKwkJaWYgKHJl
dCA8IDApIHsNCj4gPiArCQkJZGV2X2RiZyhzcGlfaW14LT5kZXYsICJETUEgJWQgdHJhbnNmZXIg
bm90IHJlYWxseSBmaW5pc2hcbiIsIGkpOw0KPiA+ICsJCQlicmVhazsNCj4gPiArCQl9DQo+ID4g
Kwl9DQo+ID4gKw0KPiA+ICsJZm9yIChpbnQgaiA9IDA7IGogPCBzcGlfaW14LT5kbWFfcGFja2Fn
ZV9udW07IGorKykgew0KPiA+ICsJCWtmcmVlKHNwaV9pbXgtPmRtYV9kYXRhW2pdLmRtYV90eF9i
dWYpOw0KPiA+ICsJCWtmcmVlKHNwaV9pbXgtPmRtYV9kYXRhW2pdLmRtYV9yeF9idWYpOw0KPiA+
ICsJfQ0KPiA+ICsJa2ZyZWUoc3BpX2lteC0+ZG1hX2RhdGEpOw0KPiA+ICsNCj4gPiArZmFsbGJh
Y2tfcGlvOg0KPiA+ICsJLyogSWYgbm8gYW55IGRtYSBwYWNrYWdlIGRhdGEgaXMgdHJhbnNmZXJy
ZWQsIGZhbGxiYWNrIHRvIFBJTyBtb2RlIHRyYW5zZmVyDQo+ICovDQo+ID4gKwlpZiAoKHRyYW5z
ZmVyLT5lcnJvciAmIFNQSV9UUkFOU19GQUlMX05PX1NUQVJUKSAmJiBpICE9IDApDQo+ID4gKwkJ
dHJhbnNmZXItPmVycm9yICY9ICFTUElfVFJBTlNfRkFJTF9OT19TVEFSVDsNCj4gPiArDQo+ID4g
KwlyZXR1cm4gcmV0Ow0KPiA+ICt9DQo+ID4gKw0KPiANCj4gTWFyYw0KPiANCj4gLS0NCj4gUGVu
Z3V0cm9uaXggZS5LLiAgICAgICAgICAgICAgICAgfCBNYXJjIEtsZWluZS1CdWRkZSAgICAgICAg
ICB8DQo+IEVtYmVkZGVkIExpbnV4ICAgICAgICAgICAgICAgICAgIHwgaHR0cHM6Ly93d3cucGVu
Z3V0cm9uaXguZGUgfA0KPiBWZXJ0cmV0dW5nIE7DvHJuYmVyZyAgICAgICAgICAgICAgfCBQaG9u
ZTogKzQ5LTUxMjEtMjA2OTE3LTEyOSB8DQo+IEFtdHNnZXJpY2h0IEhpbGRlc2hlaW0sIEhSQSAy
Njg2IHwgRmF4OiAgICs0OS01MTIxLTIwNjkxNy05ICAgfA0K

