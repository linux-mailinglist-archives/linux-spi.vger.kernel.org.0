Return-Path: <linux-spi+bounces-11584-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18019C89799
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 12:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54A33AF7DA
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 11:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2C326B760;
	Wed, 26 Nov 2025 11:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UtxMjAxC"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012070.outbound.protection.outlook.com [52.101.66.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54EC26A0DB;
	Wed, 26 Nov 2025 11:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764155867; cv=fail; b=j89FkhXnZ9/akoZKym4bF5Cmwzy9gUvTJ0qldlLI/fDdi1NMBKPb/kuPawfgWmL3ZAVq/BHP5UT7yjz6WdXu1D31uqwT+luzumZdUqV/Jy2Yt6aeKdClkgd6Ctc4Po73aa3wsy+xeRlJZJ7GpAHVhJf46s/e5tKDijWiWKCR6to=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764155867; c=relaxed/simple;
	bh=jdeCEIac8WjoW/wAhvAGU+461XyI2g38qs5XbDHXJYM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QKBh4ULeXiWfX9Q+irdN3FEDFGq/nu3WmH9oTDQDa+ir6vIcXWu5cWs67YRMliX1QPKUq2RzDmCuZOEk8SwmmKd5NireBJhzWOvZrqjLSRFeW/GwHmTchMH580+FWqFrupIwz95I7rWPEAuESTrvma0LjGDC8AKKueD5irHb2Ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UtxMjAxC; arc=fail smtp.client-ip=52.101.66.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OrPgpOwhL0/L7LhAxeNt8AexnB7qaoaeCeAlW+EuD8I0hcbfrDh/uzD+nhcLlkGyrZCUUsW9EwfzSCBfgcabTSBjpBMChkMSoUJGxdbcmV85c0TsRerZzwnhoGSNVwIEXiI38oRLabWJH3goig7uBTTaesKGTVtPVORgCelsSQQEFYmvdj678w2ZjSksaJt5fG4oNcQ8imvDSJS2QFeNEW7muQfTkJATi5/8IQ7IzLYzOm9+p4b9cs6qEKL6sOWsT+UL4qIHZn19etWzj3k7wJ+pf68QMwzE624Ixr5IckEeLG+PeaSOP/9NEbuPt0CA5bGFMng2+Hqjo6TXL1h0PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdeCEIac8WjoW/wAhvAGU+461XyI2g38qs5XbDHXJYM=;
 b=I+PYRFX+e1psV35I5uFZ2cGJpflcXpflusVyp/SCctwR+2dT5dWr9Ty5FfpQGLcr7ZaKk6ROYgjMDJxFSAtp59GrDOzE61fOQXRtryT1/tjFotM1KqqhwXZG9TPQ9VbkW8+jkouw9yqB5LPT+wySNrAjq0N05kE/BVEdYc6KDQwh1FIKmq/kcubxcrh726T0yn6BcLRZiB67yiybdGM+Ve9dTZOCIk1LkM81kkEd6hoxbI1WhCDwFbb83Cx2YKFE5SQyvGHbNOHYwagrIMPNwKUgPzJEB2MiCfTD2biLfq0ZKJpWb+lwa1iEsCo1wWUEU+0L4Wy9I7niR+bsGCxY/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdeCEIac8WjoW/wAhvAGU+461XyI2g38qs5XbDHXJYM=;
 b=UtxMjAxClOpnAWMVJk4o0EEloqNkvJ66uGetShh5iZxfUQqtfkzdv0hMex8bvt56jhUP2dzqw6L1+wycMjK+dy7T9RDZI93SdKOVam71XKDgGTltYzS14XBmJaxFQQaqERhDq864mpYwN966d+lPjZxPO96eM/Xf1+4wfNHPkzeC+MXLEhe9160ep3s6Q4aZY07GI6Dk1smi0VKKn7sKmOu2Ky0O9NPf1ilhfwV3dIlKSxXT+BIGaGETjdZvWXzC7+Svs+1U0nV6VOu3+hinbSRVEm29QmOhKJFblFsfsHdgOS3QnA2GFDXZQwf0eVwHh6I2zzSIurIz8z6pXaTUhA==
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by MRWPR04MB12070.eurprd04.prod.outlook.com
 (2603:10a6:501:99::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 11:17:42 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 11:17:42 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
CC: "broonie@kernel.org" <broonie@kernel.org>, Frank Li <frank.li@nxp.com>,
	"hawnguo@kernel.org" <hawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>
Subject: Re: [PATCH 5/6] spi: imx: support dynamic burst length for ECSPI DMA
 mode
Thread-Topic: [PATCH 5/6] spi: imx: support dynamic burst length for ECSPI DMA
 mode
Thread-Index: AQHcXsZI1qP3cluYRUSLG/l/FXTkWw==
Date: Wed, 26 Nov 2025 11:17:41 +0000
Message-ID:
 <VI2PR04MB111471DB8E08CC180DA90589FE8DEA@VI2PR04MB11147.eurprd04.prod.outlook.com>
References: <20251125100618.2159770-1-carlos.song@nxp.com>
 <20251125100618.2159770-6-carlos.song@nxp.com>
 <20251125-impartial-porcupine-of-courtesy-841990-mkl@pengutronix.de>
 <VI2PR04MB11147F814915ECCB6AE36F0F9E8DEA@VI2PR04MB11147.eurprd04.prod.outlook.com>
 <20251126-colorful-finch-of-joviality-aee641-mkl@pengutronix.de>
In-Reply-To: <20251126-colorful-finch-of-joviality-aee641-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2PR04MB11147:EE_|MRWPR04MB12070:EE_
x-ms-office365-filtering-correlation-id: 3b64efd3-ed93-40ac-9a89-08de2cdd6aa3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UmRXcm9JV2V4Si9NUmhLbHI4ZmsxNzRCeDBkMzVuNFc3aEUyZXhtN051SXJL?=
 =?utf-8?B?L2tIeXRGazkwd21leWYrTXIzVld4ZUxGL0poTHFYeEpvemVWMTZsaC9VcDFH?=
 =?utf-8?B?WklOdEtMZlBhaklNQnJmQmMySm8wRFk1NWF0dEUvSndiN1V3cUVzaFpleWho?=
 =?utf-8?B?M3Jhd2xobnVmdjNpVGFpVlRUMFdTajV4RXJIT2FNMGZGRDlFOEM0dFd3OE02?=
 =?utf-8?B?OE43U0lBdkVVU0p1b3p5OURHT0xuaTErZUR1OUJyamMwOVRFbWpDNFpCWFJZ?=
 =?utf-8?B?MEx1TjdkSnhFcjg2QzBUVzJGekRqM2dDUlFabnlFQ0VnTlFzMXJWMC9zZE1R?=
 =?utf-8?B?THdqNHpBSFJPQlJQUENPTUt5NWZpNmRpSVBLaVlreWdwdFM1SVRzekFjakVo?=
 =?utf-8?B?RUtpd1dlMHBPOEY1VUJNVXMyZ1FVbmFjdnJLN0ZjWlBDRzY0TXljWGFuUU9a?=
 =?utf-8?B?SDZURkdZTzhPa1ByRjIrUEZCY1RxcGVnZnJZemg3N1RoUURZd2g1Y3ZwZnl6?=
 =?utf-8?B?WDNFUENNT0xGaFBLQU5ZSkU3c3pOd0hQUDdoMTYyREtEQ0hmSnpwYTZ6YWZD?=
 =?utf-8?B?cEJQUXM3ZFB2ckNnNDl5Q1ZHUTFrN1VaeG1VM1hqc1ZvSVBKYWRYalFEbEpZ?=
 =?utf-8?B?WWtNYzQvenVzTlI1VTFlRmdlQ0YxbUZuVTVXWEtqb2tmdXYxL1hmUVpQeHl3?=
 =?utf-8?B?RGx3dDZmWU5wVVlmOVVuWmxsalU2ZjA3TFB5NEFTQ2FaTmhBdmxnZWcrMDZR?=
 =?utf-8?B?MXZ3K1dZMmRXNG5uYTNMcXgrTW81b1ZjdUZyRDJCSmpqVmVCdXpkbTVnWVo1?=
 =?utf-8?B?eWk4VXBuQW84QmVVb1VYNm4wSGhHdm5FSGJDa2FBWFZvUjI0NHBMbCsvMVlk?=
 =?utf-8?B?Skl4ZC9lS2ZhWHRMcXFMRDN2VFJyRDZaUS9iZkZVWEFiZW0yVUMzMzF0MW1B?=
 =?utf-8?B?NEFnNFlkUllHMkJiYUZQdFpjNmxXanJ3aDcvSTdQUGdtZmdSbUZCUXhEV2dt?=
 =?utf-8?B?a1NZZ0dyVFdaSktEU2hrN3ZTMHJsc1lPdksxV3pEQzY5WkJqZzFzYUV3aE9u?=
 =?utf-8?B?L3R5b0RDeHl2K3lqOFRZM3BhWUprMDZ5RTlvOUVaU0FuOWlDQjZQSWJlRytN?=
 =?utf-8?B?TEVZeDlaMjRoZ3Rqd3lGaDlYaTV2WFZPbFhUYytoNlJCRjJPWWdUOGpsU3FS?=
 =?utf-8?B?WUNaV0M4VFB1S1VXU1ZSbmRPay8ySXdQcXpUUzNNR0lGTldsWXlUSGlYUm9u?=
 =?utf-8?B?SG1zY21mNEc2K2FxV1FTdERvT3l0bkhOY1lQUTBmR05QN2ZaSzNwK2lKc2x5?=
 =?utf-8?B?M2t3R0tOYXZ3bHc1YllHUGlLa2Q5TEUycWtmb3ZjK2FJYkt6QWRxOWpOZ2dU?=
 =?utf-8?B?ZXo4cEd0WW1zSnZqNTd1dGYvUmlvMVhzSXZrMjFrV3pDOVZNYXBMcHpnZ1VV?=
 =?utf-8?B?M1kvK1pQUkpNSzJoQ0d5eEhLYWpkejlOVFVOL2RqRENoZG80Kys4djhGbEZr?=
 =?utf-8?B?bHFCUmdWVmNxTlhOdXdvcHJ3MGxxczYwVmlSdVlRaGZIYU5qYUNtcXVPYU00?=
 =?utf-8?B?amk1bUFoTm1sMzZ0NlNzTVpkQ3Vpa01ReFQzbml3Vy96eW8xRWh6bks2Ly9H?=
 =?utf-8?B?M1NrZE9SUlp1d0xyY3IwOFhJRWpGeitXd2ZTdVdYYVk4UnNLYXNLaENRc3VG?=
 =?utf-8?B?YzNtbWtkZDd5K2kvOTVNVDBPNDkrU09kWDhwalh0VURXSVg3cDdheWRrRERG?=
 =?utf-8?B?dERqbjlONHJqWElZTkxzRHpuZGZ6M2RpZnJPb1REUW52VVpSMk1xMWNCQ055?=
 =?utf-8?B?SjVtS1hCeEEzT1hHL1pxcUlMcVNnNUlDUjYyWmZFNnFSV2RmOC91TGp0WGRp?=
 =?utf-8?B?aDQxN1FiTjNVSlJmaDM1M3h6RVY4WDFSbVpqZHYwa0lFZ1hGY1dlTG1hVUNt?=
 =?utf-8?B?V2VzbmpoVTRhbm85RFhUQ1J5d0hHblBCR3dvRFl1Tkd4SUl1djdsdjVraVo0?=
 =?utf-8?B?N05Mc1Q2MnVBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dFJ4N1d3YVlYaVhXaENHdUNRczN1MUtjdUlNa1BpVFhBc3Q1cXhLWkRmR1VG?=
 =?utf-8?B?Uk9KY244WDJRU1RNQjRGdXpkZThQNFRSS3dtVDdpZFFhQjZtZHJEbGwvYzlR?=
 =?utf-8?B?a3VyN0EvQ3Y0WDRiZUQ5bXVocFZKMzUvRDJ6cTVoSkdlK2UxSUJlc280cE9T?=
 =?utf-8?B?aWRSNHoxbjk4ZjhjNXRHTEgrT3llbWc1REJVNGVYaGZWNlY0U2o2NzZzT2ZG?=
 =?utf-8?B?Tm82Sm1ESDROUk9iSG8rVWh2OFM3eC81VWRiNVJUWUNzc3czM3JEV1h6ZVRG?=
 =?utf-8?B?NlJkN0EzcFJYeWJXNjJudnpCUU45ZHZrSUo2WFZ4bWQydDNqRG5ZK29tK1pV?=
 =?utf-8?B?K1h5V3dwK0N5YW5zMFVqWHd6aFNtYUFoUHRsbGRZRGhmeEZqYVRVZi9BdnQz?=
 =?utf-8?B?bU9wV05Da1ZtclhWNFpoZ0xhZUI0ekFPSmM3UjhNclQ2WTRTeXRPaHJnOHlX?=
 =?utf-8?B?bXhHOFVqOVZCazFLaklLQldOTmVhbHJsalQ5L1c5dXRDMndJVExRTFE2S1pq?=
 =?utf-8?B?MG93eEV6QkV6RGFIVXN1OURueVV0TWF0T3k4c3ZrcnlROVgycUlobEJ3Ym9h?=
 =?utf-8?B?akN2ck9yVmhBRnYxL1pqbGVIeFpjdUJSelMrZlpNN20wendVVFlJK1R0bE9M?=
 =?utf-8?B?Z3kxNEF4aTI4Z08vN2lDUFI4UGpFSlcxWmlRZHRvVnVnMjRiL0dTa0JNSDA1?=
 =?utf-8?B?OHA3OVp3NExKSkdEbEpVQm50bTlLZG5kay9QNSt6OFpPamFMUUdNdU90SS9w?=
 =?utf-8?B?T2JwMytnOTNvMjJBUVNGSllUK21BTVBOMzV4WkhQaUNqVW8rSHg4MjZ2dUVK?=
 =?utf-8?B?WHJyNGpJblZNeFI0RjBhU2tVazVuaEVzRUJFNzlUanp4VURUUzgrMVAvemRM?=
 =?utf-8?B?R3lZelZiN3J2bUxSRFdpbW9qSndsYXJWQUNJTFRhTkJRcDkrZ2VYSWttczZY?=
 =?utf-8?B?ZlJYYktPMUpqUjZOZW5FV2p3TXBLZjBxWWdERUUwbDQ3NCtPL1dEdUEvMnc0?=
 =?utf-8?B?QTZRVVFqS3BIOWZhN0pNTTdqZm9Fd2JjaWRFdThPbHI4bFdONWpuOUh5b1ZO?=
 =?utf-8?B?VDk0RytIeEZOVnowUEZkUDBndjM2SFZQNzdnNUJyTGlqQ0ovS3h2NVE4Zk9x?=
 =?utf-8?B?UW1TS2xETTFyZ3d6TU1iN1ByNkE5TEl2enZObUovVHNOaTFpZmRrYTI2M2cv?=
 =?utf-8?B?Z2Y4MGl6RVZIbXlaSDE4Z2c0V3RBUThJWGREK092NC9rQ1dMOGw3bmpVNHU1?=
 =?utf-8?B?aHdvVEFhOHZ2TVVpbzRwMVcrTi91Vi9vWXE2YlZ6TlJUUFFtdU1Cck90dTVF?=
 =?utf-8?B?Q2FNUll2ajQ2cTRUTlJIdTFzaFRKcmhBRW5lV2VjR2J4OHQ1Yzh6NkVOYkxO?=
 =?utf-8?B?ME1qMDgwcXhhdTYvODhPcWw0ckFpbVlQL0NtampMdUhNRStGRGJ6S2RwK1Fx?=
 =?utf-8?B?bTNkalFtM1BuWG93S0YwcmdZQ3owcmMzNjBsRFgzV3NHdFFXVzd3Z2tKejcx?=
 =?utf-8?B?dXNOaENaTnhnVDFqSmRMZXhnRFFGbVFRWk5vN1VPZklKWWF1aEx0aitUNlpj?=
 =?utf-8?B?M1BQMkJEbkRWdEV5SmNJQnhldnBrQmpjeU5vU3lPS3JWZ1BNNmFyNTgwa3RF?=
 =?utf-8?B?K1V5TWpDdTMvMzZoekw2Nm10dVNocFJMb0taNHVEQUxuUStFOU1sczc5aUM5?=
 =?utf-8?B?bGRqWXhNOHNRN294UDIxSVo4OVRUQytzaU1NY3dlTXU3MVpIcU1CZ1ZZZito?=
 =?utf-8?B?eUY2RS9PM0FESlBESVZES1ZIVFNjSW9BZyt5Skx3TDZGVnlUV3Y4bFROYmZv?=
 =?utf-8?B?ZDh3WUdtWU1YSVpwaHpVTXNJeXE0OXVQWTZjMms3aExwVC9sUG94ZStOdGZB?=
 =?utf-8?B?eFUvaVNnUzJjU3h6VHVWNzRoK3BwU21iS1FleTE2cGNsMDVhNzVwWllNc0lW?=
 =?utf-8?B?Ynp6ZGNZeUR5Mm5IR1UwMUVMUTNDSTNrSUtEUmF2QWhTNUt5MklncmJZckFV?=
 =?utf-8?B?OWFFYnk3Q3R4dExGWDRVVUJENGpScXpOd3g0ei9jK0FJdkZ2a1FuNDBGNndS?=
 =?utf-8?B?UzladzAzeHdXWjFnN3hvUGZ0T2p4dUhycW1rQVVXUjVoT2MyUWhudFZHRnZG?=
 =?utf-8?Q?sj3PZmEGbD/K4BXmoZjaPde4w?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b64efd3-ed93-40ac-9a89-08de2cdd6aa3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 11:17:42.1149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ey8fs3vbSfc2JCo3gOpcnyxNeAJLrTkv3jRo6VxCwL9SrzueWyW9wKlHRu+QcDxq3ZArV76ByzNIly3yi0+5Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12070

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyYyBLbGVpbmUtQnVk
ZGUgPG1rbEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAyNiwg
MjAyNSA0OjMxIFBNDQo+IFRvOiBDYXJsb3MgU29uZyA8Y2FybG9zLnNvbmdAbnhwLmNvbT4NCj4g
Q2M6IGJyb29uaWVAa2VybmVsLm9yZzsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBoYXdu
Z3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRy
b25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBpbXhAbGlzdHMubGludXguZGV2OyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVF0gUmU6
IFtQQVRDSCA1LzZdIHNwaTogaW14OiBzdXBwb3J0IGR5bmFtaWMgYnVyc3QgbGVuZ3RoIGZvciBF
Q1NQSQ0KPiBETUEgbW9kZQ0KPiANCj4gT24gMjYuMTEuMjAyNSAwNzo0MjozNiwgQ2FybG9zIFNv
bmcgd3JvdGU6DQo+IA0KPiBbLi4uXQ0KPiA+IEZvciBleGFtcGxlIGxlbiBpcyA1MTIgKjMgKyA1
MTEuIFNvIGZpcnN0IHRyYW5zZmVyIHVzaW5nIEJVUlNUX0xFTkdUSA0KPiA+ID0gNTEyIGJ5dGVz
KGF1dG8gdXBkYXRlIDMgdGltZXMpLCBETUEgdHJhbnNmZXIgbGVuID0gNTEyICozLCBzZWNvbmQN
Cj4gPiBwYWNrYWdlIEJVUlNUX0xFTkdUSCA9IDUxMSBieXRlcywgRE1BIHRyYW5zZmVyIGxlbiA9
IDUxMS4oSWYgaGVyZSB3ZQ0KPiA+IHVzZSA1MTIgYnl0ZXMgYXMgQlVSU1RfTEVOR1RILCBTUEkg
d2lsbCBzaGlmdCBvdXQvaW4gZXh0cmEgYml0cywgaXQNCj4gPiBwcmV2aW91cyBpc24ndCBhY2Nl
cHRhYmxlISkNCj4gDQo+IFdoYXQgaGFwcGVucyBpZiB5b3Uga2VlcCB0aGUgQnVyc3QgTGVuZ3Ro
IGF0IDUxMiBhbmQgb25seSB0cmFuc2ZlciA1MTEgYnl0ZXMNCj4gd2l0aCB0aGUgRE1BIGVuZ2lu
ZT8NCj4gDQoNClNvcnJ5IGZvciBtaXNzaW5nIG9uZSBxdWVzdGlvbjoNCkJVUlNUX0xFTkdUSCA9
IDUxMSwgRUNTUEkgd2lsbCBzaGlmdCBvdXQgNTExIGJ5dGVzIGluIGJ1cy4NCkJVUlNUX0xFTkdU
SCA9IDUxMiwgRUNTUEkgd2lsbCBzaGlmdCBvdXQgdGhlIGxhc3Qgb25lIHdvcmQgYWxsIGJpdCBp
biAzMiBiaXRzIEZJRk8uIA0KU28gRUNTUEkgd2lsbCBzaGlmdCBvdXQgNTEyIGJ5dGVzIGluY2x1
ZGUgOC1iaXRzIHplcm8gYnl0ZXMgaW4gYnVzLg0KDQpDYXJsb3MNCg0KPiBNYXJjDQo+IA0KPiAt
LQ0KPiBQZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAgICB8IE1hcmMgS2xlaW5lLUJ1ZGRl
ICAgICAgICAgIHwNCj4gRW1iZWRkZWQgTGludXggICAgICAgICAgICAgICAgICAgfCBodHRwczov
L3d3dy5wZW5ndXRyb25peC5kZSB8DQo+IFZlcnRyZXR1bmcgTsO8cm5iZXJnICAgICAgICAgICAg
ICB8IFBob25lOiArNDktNTEyMS0yMDY5MTctMTI5IHwNCj4gQW10c2dlcmljaHQgSGlsZGVzaGVp
bSwgSFJBIDI2ODYgfCBGYXg6ICAgKzQ5LTUxMjEtMjA2OTE3LTkgICB8DQo=

