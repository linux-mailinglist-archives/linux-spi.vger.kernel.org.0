Return-Path: <linux-spi+bounces-11614-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6007DC8CAD8
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 03:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19DA53B0A4B
	for <lists+linux-spi@lfdr.de>; Thu, 27 Nov 2025 02:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC0026CE1A;
	Thu, 27 Nov 2025 02:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jje2wqg9"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010010.outbound.protection.outlook.com [52.101.69.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E9126CE32;
	Thu, 27 Nov 2025 02:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764211006; cv=fail; b=iasxj+TrYsmY5cA2RGIudsci1zoFVHVOG7IB+fiN4lT/Gu1V8jE818ICobRNamnEGQ55lz8DPPRbvXqFAGAVXpGhrOFu8uyjCwukIM9eU2N/s0+EKqmT7gUch3kG/zeOpRiea4F6ANjwDJ+aBjIv8juHgzc887+50ziM+5Rj6Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764211006; c=relaxed/simple;
	bh=L6LJ+Mv7HVhQJaGN/40F/AaSyJBaG5sFjOgoOtccT5s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hPxpvSA+M8U7SP9l2NHx4aZ9eVj17R7ZTNiRaObJGjBmE4y7gAgWUCW/7gjkJhVfrPkq94CxJ7kjgdqESQRZA/hyR0jpWu/mzA9HVswy3jLgm+EpiCWqU5NJaAFSX6ETb9gsC3jzjR3Iu+D4a44nkr8/+aojOv9pW5MJXJFOp7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jje2wqg9; arc=fail smtp.client-ip=52.101.69.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQIy5BFN1htuyViSAuPD8uMIceju8Dtx40466aF89oBOz5AkAwdEX1h3jKjVN3lY9MnmquRd5ZhKZ4AgMN/H5pmqpedfDKDN+231+rsHCspBYi90K1MdtRQ/drD6NpjJlNmysk1xslTXKgkyZWJ5FCQh2gotD74tJVmU92ScdGg32vH7Fmho7nkyUEhOin3LVO29GidQvs3ydr1SnrGwJN/quZQwbNO5A/KmNsGiCsPryq7Fmy0Qwvpe2Kd8bEO9me15V/prwL+eErQi3JMKzTC/bLrdkw9+lRw5TKgJzy14YwAtsRNPjcSiGtAzdjx4lzwbFpePAm6AjU+PKJbsnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6LJ+Mv7HVhQJaGN/40F/AaSyJBaG5sFjOgoOtccT5s=;
 b=rUbunkc4kJx1aIxnvQ2MrpR9AHLD64UHkjXWdX1UDy79wiR7cteuomwHzDzbHVMZnjpCz0iZMLJGwCyQFtB6zJQmrf+qgltApm7duiE5HMfMnbk9F6txNMP9OQAAUxox/IUbFEUflEsjDwnSwdm7pcZqmMMwtFgNJyxPY2WUv8kCF/6tf8eqgFpDaSSITQEDdvYQz11ggku/hQwMN2Pxfw+mo+7iLksSn122v511JHaSl8qLDe6E1jMdaECy9V/jdrhx+E3Y6M52XREmt0gkfVBu5aiVuq+gnUAOFIYDFO7Tooio7GEZW3vfHMouO/4RdX8lB6MJT57r6OWEvezvJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6LJ+Mv7HVhQJaGN/40F/AaSyJBaG5sFjOgoOtccT5s=;
 b=Jje2wqg9P0/PmpoDTkG3FsAPr+URkUyqlfsUa9f2o4v/tO9SZQfbZbBcHjBHdKt+sT0HJWaFchFWXqbNlVBLdyDZmGbfifwyL5IYMH8m2rjXaIdzCXTTojs6MxiknVoEl+S9hqTDJlKSb1ILcvQeZ4QizZqRYHywmvG/p2eY8yUgQM8z5YcDivD/17OVMd6XhctgtYDeQeB4kMkqpHc5dH0vPX1t4Nf5LUIdjsIRetlosJpwxhmWk8IL3d+fZEo0awTcKxCCUlfSF7fnsigmRvjDk/dfbrvKH71E4urgIdhwPAlGho1iZo6NMyzxPMCyINi/GGtQe0WR9C5S1SG6Ig==
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by PAXPR04MB8475.eurprd04.prod.outlook.com
 (2603:10a6:102:1de::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.14; Thu, 27 Nov
 2025 02:36:41 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 02:36:41 +0000
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
Subject: RE: [EXT] Re: [PATCH 5/6] spi: imx: support dynamic burst length for
 ECSPI DMA mode
Thread-Topic: [EXT] Re: [PATCH 5/6] spi: imx: support dynamic burst length for
 ECSPI DMA mode
Thread-Index: AQHcXsZI1qP3cluYRUSLG/l/FXTkW7UE5PQAgADm8pA=
Date: Thu, 27 Nov 2025 02:36:40 +0000
Message-ID:
 <VI2PR04MB11147811EAD5EE9668B7A9B57E8DFA@VI2PR04MB11147.eurprd04.prod.outlook.com>
References: <20251125100618.2159770-1-carlos.song@nxp.com>
 <20251125100618.2159770-6-carlos.song@nxp.com>
 <20251125-impartial-porcupine-of-courtesy-841990-mkl@pengutronix.de>
 <VI2PR04MB11147F814915ECCB6AE36F0F9E8DEA@VI2PR04MB11147.eurprd04.prod.outlook.com>
 <20251126-colorful-finch-of-joviality-aee641-mkl@pengutronix.de>
 <VI2PR04MB111471DB8E08CC180DA90589FE8DEA@VI2PR04MB11147.eurprd04.prod.outlook.com>
 <20251126-refined-fluorescent-kestrel-7d3f9e-mkl@pengutronix.de>
In-Reply-To: <20251126-refined-fluorescent-kestrel-7d3f9e-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2PR04MB11147:EE_|PAXPR04MB8475:EE_
x-ms-office365-filtering-correlation-id: 77e9c90f-73b9-41fa-b302-08de2d5dcbfa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WXhMaGUrN0ovMmQ0STZ1eFc0SC9ZTllMQ1QrNVZITlVac0RhNWtvRm8zbkZL?=
 =?utf-8?B?ZWF5Q3o1WlBpclV2VXBnUU9tTFhZT1NsSjBmbDFRVmhML2lsUEZ1d1JhMGo1?=
 =?utf-8?B?SWEzUDM1NStlVmRYc25BTjdnQnRkUzM3MVBuNFl3bkdzWnBpUGJpNkZJRURi?=
 =?utf-8?B?TXlqWlpUUkttWFZ3MGhGc29vOFVqcldmWGV6MENNcHZaaTV3VjZad1p6R05n?=
 =?utf-8?B?K0R3YXlSN2NZS1FoZHo4ajh6T3FsaGtFVTY1NUIzNkx5T3FOdHdxOENtemJX?=
 =?utf-8?B?dlhKZHJKT0hOTVNKT0N6UHE0bXE1U1hiQnd4dFpuRFdVK1NHUkQwdi9ucWVo?=
 =?utf-8?B?d3l5UG1LU1lXNXZOaTY0UXRWOFhIYmczTHpIV0NKa0NIcW03engrR1UxRi85?=
 =?utf-8?B?aFBicVh3ZUtHeDlZbkw2L0RGWkY3MmI0Ukc0UWpOSVYrRnNScXk3bE5vLys2?=
 =?utf-8?B?SjNONnBVTlI4MmJXSEJpOCtuQlZ6NzBxQmlPamFFcDVyb0xvcVNlejJSNnR0?=
 =?utf-8?B?NHU2K2NlTk5mWEIxUzI3T0F2eG5qRDBPRExoUUNmREdWLy9sNHQ0cU5xNllX?=
 =?utf-8?B?THNiRXd3NkpxUjVmd3ZBS0FocGpwd2psR2o3c0w3ckYwL3kzcTYyTUZLdUk3?=
 =?utf-8?B?WVY2LzJhR1EweW9GZmgxSmlWejhKKzNaWXd1Q0s5T21SMVh0NjhFSGxyUDR5?=
 =?utf-8?B?b0t0MitJdVNNNzNZdTJVMTA2d0ZaL2lic2ttNEtOa0QvMTlTOWJZRk54Y2tP?=
 =?utf-8?B?SER5MEZ1a2RaajBueUxBellPKzJCNDhpMnNWaWZhZGttVXpEVzFGd2VqWFhB?=
 =?utf-8?B?MEFPZGJoUFQxL3ZueWUyYXJwRW1idkt2SXA0d29uQ2VwOUdTUEM4U1pSZVN4?=
 =?utf-8?B?TDFkcHRWc0w4bFRQNlJpUUFncEhUMllKSUh5SW1pb1o5VXc3M2tzZHZnSkVK?=
 =?utf-8?B?YWkzU01HY2Z3dThSTitFOEtJTG9wQ0V5Y3RNMXJYZ25YQk9uaENWbkQxVksw?=
 =?utf-8?B?Q3N3dHJibk9XOG52cUYrb2dnRHNmYTMyNzQxOWRQK0tZVzV4VTVOVWxVd1pT?=
 =?utf-8?B?TWw5YnV2am4zVHRYcFRHUWxQK3BkUHpBdWpNY3VZTlFzdDFYZ2UvUkZ5L1pn?=
 =?utf-8?B?MlZPSUZhOEpzd0pCT2x2QnJMWHZmMG5HRlhialAzeEtHQ2daa0hSdlNiaXB4?=
 =?utf-8?B?ckZwTmdmSnRlYVEwa2hKYkFDRU9pS3MvcjEwYS81ZUJYeGtGeXNvSnVUMWpQ?=
 =?utf-8?B?UExNM21UYmNMWlZvS1E5Smx0bDhmdldZQW5TWURycDFQR3R0MzB0NHB6ZTBh?=
 =?utf-8?B?NkdBbnpIU3NzbzU3OXV2WElyVFdDL0hhWlB4cXJIK21EazN3b0o0M1dRc0hh?=
 =?utf-8?B?c1p0SkhBSUJHZldpRWN4WUV0dFl5blVNUHYrakluZ1RaZlR2VDRkVWVsaDE1?=
 =?utf-8?B?c1ZEKzhPQkJpbnVROGRDaVB4R2RCbU5MTXRPa25aVm1Cb3JNOU13c3hWbFNr?=
 =?utf-8?B?R2dPeDF6YjFGUEJEbkcyTHI4YS91aFRqN0tKQU9rVlE4OGRXd0l3YkJuSHh5?=
 =?utf-8?B?alk1SEM1MHBxeElNRGFOZm1BUjJDUmFTQVFFaTdNSzRiUU90bUlUOEVGMG0y?=
 =?utf-8?B?RDd0Z25pVFR1SlVFVVE0dXlibkl5VFBBZllzMVUyUTVtR0ZqUUhtREFQTXBs?=
 =?utf-8?B?UWVDbWZkdEhrM05OZG1EU0ExMVQ1TzhUcnE0VWpKRmg2YXZEaG5lVWN2RjM0?=
 =?utf-8?B?cFNmRVVKNkFibjNMTGpMWFpnbGd4ZUd0NlB4anV3V3RKNGxPNnZjWmpRNzhM?=
 =?utf-8?B?SjFMY1pJZXJ0MWM0L1BuR3ZvU05jOUdzazF2S1ZZL3NISlNwRGUzaGdWMTVU?=
 =?utf-8?B?cm9IUGlNY2JqWWNxMlh0ZWt6WGVMdk9TWXhXNVdNV2hYdTNXVTE2aU90akkx?=
 =?utf-8?B?SDdwUTZvL3pqdGhwSWtXQWxOVzlzSTFjQkZSS0VneG1CdlArQ3hjbjJtcDJy?=
 =?utf-8?B?L1ZTRndDQ21RPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TDhnMlE4K2JabFF6RHRyRHI5REdCUU54Nmd5MWo4YmgySkhYbC9vVnhVNk1V?=
 =?utf-8?B?LzkzdUV4eEl2TXZpUkozclAzQm1Oc3BYT1lpbmJSV3NOMXZML1J2ODNiVEF5?=
 =?utf-8?B?S2lJZ3hxYTRYWVU1VlVFelh3TCs5Z0pNYmoxaGtQd0xGV0ozWHNRNjhHYjI1?=
 =?utf-8?B?K290bFRZTkFMSmZ6NXJORmNrRmMvbzZLcnZkOXoyUnE5dGNUS1IwbzJWT1NJ?=
 =?utf-8?B?ZThOTFFKamMza01NOXVHa1BTc1V4c1YxVTU1ZE5GMXZMWXBBT3NSZ1lPc2VL?=
 =?utf-8?B?NGRkYjhFb0FJUWVCamI2Qy9KbGVnN3FtSDdvbHhWbmZqVTNsellTYWwyRlVV?=
 =?utf-8?B?eHRQRkRMRm80YlZ4ZklSTWN1UkJmbUpQNnh1YTg2S3NqcDVXYXZvczlQSXFt?=
 =?utf-8?B?UTlFRDRxN2ZpVTE0L2FybkpYOTQyZ29lUEdEeXcrdVBjQmFVaE42bjhEeUVz?=
 =?utf-8?B?Z3lYYWFpb2QwbTZ2U0xTYU5NNUV5bHgyM25yNWZrT2dTcmFPVGZIbWo4RnBY?=
 =?utf-8?B?d0VJYTlsWXVRZEhTVm54MnRtUlkzVVdlS1dXallxa1BaL2l2SWh1OVYxZnJj?=
 =?utf-8?B?NmtJSFpvNDlPZncvMXlBNDlERExUb1lxZzhRaWFjb2FyNTVJMWJCQ1lMVVRh?=
 =?utf-8?B?VDk0emxjc1RkeE5RMUhrMUdOYTllVjRUN2s5QjFFNTNwcnpHdTZ0TmR2b3ps?=
 =?utf-8?B?VHhOQXkvWWR5RUZmVHZRdHVvTXEzM0dTVmdJdEpnT3BNNmNRam1BNkphaEdX?=
 =?utf-8?B?L3NDNUkyNDVqSXFVRlZpYUdVQlJOSVROWWhPcnVMZ0M4d21nZjUzVE5sYzJ1?=
 =?utf-8?B?Uk5PRXo2NGNoRElrTy9VK1JjUGhtRmtOOUJFOXRQdkRaQzExaG1xY1RmOThE?=
 =?utf-8?B?TExxWXEySjNrMEMyQ2FTMzZONEFiVm96ZWtsZE9kRzJnUHZ3MEg1OEhuNmc3?=
 =?utf-8?B?TDBUSVZ0N0tqeUxodVRaazlSS0RvVWIzOFFvbGRYd3lLaFVNVHRTcFpSaGtK?=
 =?utf-8?B?MGxXdkxMYXRVd3BxaHYrU3hxSis1Uzg3WmFMait2bXFlZGd3WEF2S1VqQ0ww?=
 =?utf-8?B?TWRSbUNUUis5MnpIOFYzTDNtUFR4dWdpYm9zNk9EYzlKYnZjVVFXRENhNWpl?=
 =?utf-8?B?MWoxMHlFbDh1QzhFTGVGU1g5a1piMXhMdVhPWDJEcy8ydjMxN2xEWEpwcjN1?=
 =?utf-8?B?N2doS3Q5blRkTzNUeFBKY1hiL0pCbFZPMnFWdDlFM1BRWUp3OU9JbFEzVVNv?=
 =?utf-8?B?L2dTWkNvdzhsY0ozNEd4cDlzK3gvSTcwQVBCSnZvcTBXL0J0MHpxSXdnQnU2?=
 =?utf-8?B?Q2NUcEloNUZ6STlFTmMvL3cweDludnlZelpOYVVzd0h6Um9BMmFINmV4M3Vm?=
 =?utf-8?B?TzBsZXFGTENWQW5TQVZrTzZxVWRWVHFDRWxENGVNQzUyNHZnVktxMWtGWVE0?=
 =?utf-8?B?RFVLKzhsVDMyV0hDL0hvM1E4NWRIajBsNEYyL2pOSXBLd2JYaTVRcEo0WGRD?=
 =?utf-8?B?bE9zeUF1dmUvanVsUy90OHNabmVHQ1pMZ2orN1hCbXh4SGt5M052cCtJMVNN?=
 =?utf-8?B?MnFSYnBmVnpjQ1Z1Yjd0QTRmMHpIcmFOOGdUdWFSL28yTTNHSlUzOERkTnI4?=
 =?utf-8?B?NTB1VGpIY3dFQkdKRi82cGtsQTJtVWRkbTJOZDRyb25wNVRKK040ek01TnV0?=
 =?utf-8?B?TWlmMUtIMkRqcVlNbm1palhvQ08rWjBFbFQrVTNTMmhYYU0rSk5Gc0NCZmtw?=
 =?utf-8?B?QStqRW9FZjlZVGZoNFBZNjZhcVNyVVA5U1R3SFRxbzhwY2h6eHlrVjMwS2x5?=
 =?utf-8?B?ZnV4RWxhY0E4WWZTLzBuTzN6TERHcFNNZGJuanNUMDBGK2ltRFFNOGh6alNR?=
 =?utf-8?B?OTJlMkxFM2JQaXB3UW4vb1dYSUdtTFVUL1VYbGhTZWtSZjJxbTQzYTRTajA2?=
 =?utf-8?B?cWJEbDNFUlk0L3dNWkFianF6NmQ2aGEwc1pnbWpxR1FZR2xHTVpTRnNyU2w1?=
 =?utf-8?B?WmJYeVNTd0pDOFVjRDlUYWZWK3FIaHVqSGJheTNRVmJqcFBtaFZ0QjNNZjVE?=
 =?utf-8?B?bUk4V2htWGFhMEd3VXMzQkNXNjdTeDduSUxNN0t3ZFRtQ0VXRkg3WWMzQWw2?=
 =?utf-8?Q?nbbuB6PG923hYgxz5qIro7nfs?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e9c90f-73b9-41fa-b302-08de2d5dcbfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2025 02:36:41.0252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A/g/NQT10sOtBmyhY6MLJmwcLBienSj/77sZoC8zx3rq66YKvlfij7tdIYr16Z47fBFi9D7CVv62+D7bRclqKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8475

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyYyBLbGVpbmUtQnVk
ZGUgPG1rbEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAyNiwg
MjAyNSA4OjM2IFBNDQo+IFRvOiBDYXJsb3MgU29uZyA8Y2FybG9zLnNvbmdAbnhwLmNvbT4NCj4g
Q2M6IGJyb29uaWVAa2VybmVsLm9yZzsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBoYXdu
Z3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRy
b25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBpbXhAbGlzdHMubGludXguZGV2OyBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7IGxpbnV4LXNwaUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVF0gUmU6
IFtQQVRDSCA1LzZdIHNwaTogaW14OiBzdXBwb3J0IGR5bmFtaWMgYnVyc3QgbGVuZ3RoIGZvciBF
Q1NQSQ0KPiBETUEgbW9kZQ0KPiANCj4gT24gMjYuMTEuMjAyNSAxMToxNzo0MSwgQ2FybG9zIFNv
bmcgd3JvdGU6DQo+ID4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4g
PiA+IEZyb206IE1hcmMgS2xlaW5lLUJ1ZGRlIDxta2xAcGVuZ3V0cm9uaXguZGU+DQo+ID4gPiBT
ZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDI2LCAyMDI1IDQ6MzEgUE0NCj4gPiA+IFRvOiBDYXJs
b3MgU29uZyA8Y2FybG9zLnNvbmdAbnhwLmNvbT4NCj4gPiA+IENjOiBicm9vbmllQGtlcm5lbC5v
cmc7IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPjsNCj4gPiA+IGhhd25ndW9Aa2VybmVsLm9y
Zzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiA+ID4g
ZmVzdGV2YW1AZ21haWwuY29tOyBpbXhAbGlzdHMubGludXguZGV2Ow0KPiA+ID4gbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Ow0KPiA+ID4gbGludXgtc3BpQHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU3ViamVjdDogW0VYVF0g
UmU6IFtQQVRDSCA1LzZdIHNwaTogaW14OiBzdXBwb3J0IGR5bmFtaWMgYnVyc3QNCj4gPiA+IGxl
bmd0aCBmb3IgRUNTUEkgRE1BIG1vZGUNCj4gPiA+DQo+ID4gPiBPbiAyNi4xMS4yMDI1IDA3OjQy
OjM2LCBDYXJsb3MgU29uZyB3cm90ZToNCj4gPiA+DQo+ID4gPiBbLi4uXQ0KPiA+ID4gPiBGb3Ig
ZXhhbXBsZSBsZW4gaXMgNTEyICozICsgNTExLiBTbyBmaXJzdCB0cmFuc2ZlciB1c2luZw0KPiA+
ID4gPiBCVVJTVF9MRU5HVEggPSA1MTIgYnl0ZXMoYXV0byB1cGRhdGUgMyB0aW1lcyksIERNQSB0
cmFuc2ZlciBsZW4gPQ0KPiA+ID4gPiA1MTIgKjMsIHNlY29uZCBwYWNrYWdlIEJVUlNUX0xFTkdU
SCA9IDUxMSBieXRlcywgRE1BIHRyYW5zZmVyIGxlbg0KPiA+ID4gPiA9IDUxMS4oSWYgaGVyZSB3
ZSB1c2UgNTEyIGJ5dGVzIGFzIEJVUlNUX0xFTkdUSCwgU1BJIHdpbGwgc2hpZnQNCj4gPiA+ID4g
b3V0L2luIGV4dHJhIGJpdHMsIGl0IHByZXZpb3VzIGlzbid0IGFjY2VwdGFibGUhKQ0KPiA+ID4N
Cj4gPiA+IFdoYXQgaGFwcGVucyBpZiB5b3Uga2VlcCB0aGUgQnVyc3QgTGVuZ3RoIGF0IDUxMiBh
bmQgb25seSB0cmFuc2Zlcg0KPiA+ID4gNTExIGJ5dGVzIHdpdGggdGhlIERNQSBlbmdpbmU/DQo+
ID4gPg0KPiA+DQo+ID4gU29ycnkgZm9yIG1pc3Npbmcgb25lIHF1ZXN0aW9uOg0KPiA+IEJVUlNU
X0xFTkdUSCA9IDUxMSwgRUNTUEkgd2lsbCBzaGlmdCBvdXQgNTExIGJ5dGVzIGluIGJ1cy4NCj4g
PiBCVVJTVF9MRU5HVEggPSA1MTIsIEVDU1BJIHdpbGwgc2hpZnQgb3V0IHRoZSBsYXN0IG9uZSB3
b3JkIGFsbCBiaXQgaW4gMzIgYml0cw0KPiBGSUZPLg0KPiA+IFNvIEVDU1BJIHdpbGwgc2hpZnQg
b3V0IDUxMiBieXRlcyBpbmNsdWRlIDgtYml0cyB6ZXJvIGJ5dGVzIGluIGJ1cy4NCj4gDQo+IFdo
eSB3YXMgdGhlIHRhaWwgdHJhbnNmZXIgbm90IG5lZWRlZCBiZWZvcmUgeW91ciBwYXRjaD8NCj4g
DQo+IElzIGJlY2F1c2UgeW91IGNvbmZpZ3VyZSBidXN3aWR0aCB0byBETUFfU0xBVkVfQlVTV0lE
VEhfNF9CWVRFUw0KPiB1bmNvbmRpdGlvbmFsbHkgb24gIXdvcmRfZGVsYXkgbW9kZS4gV2hhdCBo
YXBwZW5zIGlmIHlvdSBhbHdheXMgdXNlDQo+IERNQV9TTEFWRV9CVVNXSURUSF8xX0JZVEVTPw0K
PiANCg0KWWVzLiBETUFfU0xBVkVfQlVTV0lEVEhfNF9CWVRFUyBtYWtlIHRoaXMuIEkgY2FuIG5v
dCB1c2UgRE1BX1NMQVZFX0JVU1dJRFRIXzFfQllURVMuDQpXaGVuIEJVVFNUX0xFTkdUSCBpcyBz
ZXQgPj0gNCBieXRlcywgU1BJIGFsd2F5cyBoYW5kbGUgd2hvbGUgd29yZCBzaXplKGFsd2F5cyAz
MiBiaXRzKSBhcyBSTSBzaG93cy4NCiINCkJ1cnN0IExlbmd0aC4gVGhpcyBmaWVsZCBkZWZpbmVz
IHRoZSBsZW5ndGggb2YgYSBTUEkgYnVyc3QgdG8gYmUgdHJhbnNmZXJyZWQuIFRoZSBDaGlwIFNl
bGVjdCAoU1MpIHdpbGwNCnJlbWFpbiBhc3NlcnRlZCB1bnRpbCBhbGwgYml0cyBpbiBhIFNQSSBi
dXJzdCBhcmUgc2hpZnRlZCBvdXQuIEEgbWF4aW11bSBvZiAyXjEyIGJpdHMgY2FuIGJlIHRyYW5z
ZmVycmVkIGluIGENCnNpbmdsZSBTUEkgYnVyc3QuDQpJbiBtYXN0ZXIgbW9kZSwgaXQgY29udHJv
bHMgdGhlIG51bWJlciBvZiBiaXRzIHBlciBTUEkgYnVyc3QuIFNpbmNlIHRoZSBzaGlmdCByZWdp
c3RlciBhbHdheXMgbG9hZHMgMzItYml0DQpkYXRhIGZyb20gdHJhbnNtaXQgRklGTywgb25seSB0
aGUgbiBsZWFzdC1zaWduaWZpY2FudCAobiA9IEJVUlNUIExFTkdUSCArIDEpIHdpbGwgYmUgc2hp
ZnRlZCBvdXQuIFRoZQ0KcmVtYWluaW5nIGJpdHMgd2lsbCBiZSBpZ25vcmVkLg0KTnVtYmVyIG9m
IFZhbGlkIEJpdHMgaW4gYSBTUEkgYnVyc3QuDQoweDAwMCBBIFNQSSBidXJzdCBjb250YWlucyB0
aGUgMSBMU0IgaW4gYSB3b3JkLg0KMHgwMDEgQSBTUEkgYnVyc3QgY29udGFpbnMgdGhlIDIgTFNC
IGluIGEgd29yZC4NCjB4MDAyIEEgU1BJIGJ1cnN0IGNvbnRhaW5zIHRoZSAzIExTQiBpbiBhIHdv
cmQuDQouLi4NCjB4MDFGIEEgU1BJIGJ1cnN0IGNvbnRhaW5zIGFsbCAzMiBiaXRzIGluIGEgd29y
ZC4NCjB4MDIwIEEgU1BJIGJ1cnN0IGNvbnRhaW5zIHRoZSAxIExTQiBpbiBmaXJzdCB3b3JkIGFu
ZCBhbGwgMzIgYml0cyBpbiBzZWNvbmQgd29yZC4NCjB4MDIxIEEgU1BJIGJ1cnN0IGNvbnRhaW5z
IHRoZSAyIExTQiBpbiBmaXJzdCB3b3JkIGFuZCBhbGwgMzIgYml0cyBpbiBzZWNvbmQgd29yZC4N
Ci4uLg0KMHhGRkUgQSBTUEkgYnVyc3QgY29udGFpbnMgdGhlIDMxIExTQiBpbiBmaXJzdCB3b3Jk
IGFuZCAyXjcgLTEgd29yZHMuDQoweEZGRiBBIFNQSSBidXJzdCBjb250YWlucyAyXjcgd29yZHMu
DQoiDQpGb3IgZXhhbXBsZSwgZm9yIFRYLCB4ZmVyLT5sZW4gPSA0LCBCVVJTVF9MRU5HVFJIID0g
NCBieXRlcywgRE1BX1NMQVZFX0JVU1dJRFRIXzFfQllURVMsIERNQSB3aWxsIGZpbGwgb25lIGJ5
dGVzIGluIDMyYml0cyBGSUZPIGJ1dCBTUEkgd2lsbCBzaGlmdCBvbmUgd2hvbGUgMzJiaXRzIHdv
cmQgaW4gRklGTyAoMyB6ZXJvIGJ5dGVzKyAxIGJ5dGVzKSArIG9uZSB3b3JkKDMgemVybyBieXRl
cysgMSBieXRlcykgK29uZSB3b3JkKyBvbmUgd29yZC4gQWN0dWFsbHkgMTYgYnl0ZXMsIG5vdCA0
IGJ5dGVzLiBUaGF0IGlzIHdyb25nLg0KDQpZb3UgY2FuIGNoZWNrIHByZXZpb3VzIGNvZGUsIGl0
IHVzZSBCVVJTVF9MRU5USCB0byBtYWludGFpbiB0aGUgcmVhbCBiaXRzIGNvdW50Lg0KRE1BX1NM
QVZFX0JVU1dJRFRIXzFfQllURVM6IEJCVVJTVF9MRU5HVEggPSAxIGJ5dGVzDQpETUFfU0xBVkVf
QlVTV0lEVEhfMl9CWVRFUzogQkJVUlNUX0xFTkdUSCA9IDIgYnl0ZXMNCkRNQV9TTEFWRV9CVVNX
SURUSF80X0JZVEVTOiBCQlVSU1RfTEVOR1RIID0gNCBieXRlcw0KDQpDYXJsb3MNCg0KPiBNYXJj
DQo+IA0KPiAtLQ0KPiBQZW5ndXRyb25peCBlLksuICAgICAgICAgICAgICAgICB8IE1hcmMgS2xl
aW5lLUJ1ZGRlICAgICAgICAgIHwNCj4gRW1iZWRkZWQgTGludXggICAgICAgICAgICAgICAgICAg
fCBodHRwczovL3d3dy5wZW5ndXRyb25peC5kZSB8DQo+IFZlcnRyZXR1bmcgTsO8cm5iZXJnICAg
ICAgICAgICAgICB8IFBob25lOiArNDktNTEyMS0yMDY5MTctMTI5IHwNCj4gQW10c2dlcmljaHQg
SGlsZGVzaGVpbSwgSFJBIDI2ODYgfCBGYXg6ICAgKzQ5LTUxMjEtMjA2OTE3LTkgICB8DQo=

