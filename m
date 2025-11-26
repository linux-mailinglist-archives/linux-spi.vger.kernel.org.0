Return-Path: <linux-spi+bounces-11594-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90059C89C2B
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 13:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DEAA9345FEC
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 12:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888A4155326;
	Wed, 26 Nov 2025 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="J7wKG5cs"
X-Original-To: linux-spi@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011024.outbound.protection.outlook.com [40.107.130.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F12302CA2;
	Wed, 26 Nov 2025 12:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764160182; cv=fail; b=Kufd9qbxsNgMyO4SQYBr4RXWL+p95Pbv8Ojh5A69T3aFAiPHQZUR/fHfTrVvwXGAmadoZSHCoxRIgKGdi7jPuGXBAXJSYY9o00Ij78C2awDS2joZ0USIV2IhO3UfJ1xpepCAjO4i4tUGOH9VSIBxr7yt+WtrYRpd4PGU6sKREc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764160182; c=relaxed/simple;
	bh=fXiIJVOyCb1gJ9eYotSNHEgF7ssKfSOb6OJfvLYKeP0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NFJIH0Rpz/bQTIgMRHwYc+biQ6jPDmm4oegR0oaTARy8Lph/mKQEnuG1kn7GyLxL6IEnP2L/cFdU5fOX1nW/YlYY3VdKTChsWPejq8ZTJTve1gUDmslVCoY6Xf7MLCL6OUMByy2I4PxKBMfUZFG7E8OX9ETwm0enKZjGK00vEXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=J7wKG5cs; arc=fail smtp.client-ip=40.107.130.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlqX9ovZtRJ0XsV2Hi8X8Z7qIPwSv3JlCfpuiRjKiGguedG9pK2zTHAdWRrMGbzjQ1L+f54f/No2A382C7bbkwcoralk3nEwHrXOeZaODEYfvwxoVTmNfoQx+DvaT8xxhSYDHHhc2o9w6myNQaLuqi3Vm+AHUX9EJAqtEqIinLbAvQ0OqLiSMTANn1IRf+b7cUfh3J77aQtvM2VCgkHKjxstPnml6/r8vRaXOphgBsz/X/0tstIIosQSEl5A87MLuYkW14JVxvJ40bbt3P68KLYoptiftZWvSz6TyBnVZayxgfZBL/kYptG/Vd/s+g/1YBfGTJYQ39+u43irnBZr7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXiIJVOyCb1gJ9eYotSNHEgF7ssKfSOb6OJfvLYKeP0=;
 b=BouWFJZ5yj7D7H+I3Yog93jTb1JOHs4kPFvs4PCWMo5dQaG5tNpRBEBMOz2yKMiILD/3u/VwqSjsItu1XQr3CApfx6JSlrWeikFuc2ZalwReWLSh8h8b3fFic3K4unrk4XswPIlr2HD2m90wsb98URhU/Dn2na6XEW3outqtmPk6R5JNnS2B3hXFKK2aJvvjyZnAtMW1Kxq1XXEeVogFcvcqgdYxmsSGU7kYFmXBZZIzpIIFMLmE3k8ktWDE4giO/G3qQBJHWFKxjudOcnCXjonMQJ9FUJ2L4cn7pzokUdqBgvGbgpPVvnnlb2gNRBYaYcVIAh28Xh4ido97D0Y7Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXiIJVOyCb1gJ9eYotSNHEgF7ssKfSOb6OJfvLYKeP0=;
 b=J7wKG5csq1uj0ami7VaNzqvAhGkKMd8y3TkM4XvzP7ZVvWurh8uKL2RNRGBi4E6PTXNbSW0Al1bV4UNMCXWmSaO/qoY6ybMIFoHudjMDyFZpoe2c02v78cCem9dJJfzy7N62NF51ejNeEcxBgsPb7myCndxBmVRaV1CJV+QMyEgRy3hOOJujMrVSWcp4fhxVBEaeds16g4DmxAK30GSvMzsnIbWOQ27O9HDs8H9HVPHJ4xQd8AGAaz4rgbiTpI7Pg5WIN6Hvm7XDtjv8LS/fQ6mwfjEzhdwlxtYAWWseXxcIA2jAOtFHQ/jM339TSmyFw4FHDSVZwzWfd9MiHlnZkg==
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by GVXPR04MB10247.eurprd04.prod.outlook.com
 (2603:10a6:150:1c2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Wed, 26 Nov
 2025 12:29:36 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 12:29:35 +0000
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
Thread-Index: AQHcXfNVDK4T0P1c8k+DMajAF1tbjLUE4uKAgAAApQA=
Date: Wed, 26 Nov 2025 12:29:35 +0000
Message-ID:
 <VI2PR04MB111470B46C3B7B6AF66B69D07E8DEA@VI2PR04MB11147.eurprd04.prod.outlook.com>
References: <20251125100618.2159770-1-carlos.song@nxp.com>
 <20251125100618.2159770-6-carlos.song@nxp.com>
 <20251126-loyal-lobster-of-virtuosity-0aa824-mkl@pengutronix.de>
In-Reply-To: <20251126-loyal-lobster-of-virtuosity-0aa824-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2PR04MB11147:EE_|GVXPR04MB10247:EE_
x-ms-office365-filtering-correlation-id: 4983ce5c-9e03-44a6-052d-08de2ce775bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dEEwNFRuVHhVZWZIUnp1ZDBKSVoyTjJyRFg0T3hqYkFKbjlNMjVjTUV1clFt?=
 =?utf-8?B?NFpoUm5EcVpQRnN2TG9ZUk1LZGtHc2xxemZrbitYa1JpSy95b09WVjc5NGdx?=
 =?utf-8?B?YmVQd2U5ZlhNMTJoSFRBdkdiOFAxT2hQWjlpN0VRTk5TM2hMRGtmNnpJUmVZ?=
 =?utf-8?B?WlE1TE9vaFdtS0lxVnhwcW5XbEJlWFhVaFlNWHdYMVpXK05ITVJmVmNHTmFm?=
 =?utf-8?B?bkRoc3FySDFUQXI2bVpnZ0paVFRzS3pVVndvVmZkWGs1RlVGUWx4OE1yaUdp?=
 =?utf-8?B?QWRlRlRkcGhoekVNV0J0QkdvQnYyVEMyNGU0eEQwQ3dabE9takVpZFJPNXhI?=
 =?utf-8?B?RGMwaHJrTHlBVEdyZ0V5WVFQYWI4SGVDVDd3U2ttT01sTnQxeHFFeTlVbHdC?=
 =?utf-8?B?WWhETEZGSXh1UURWRW5uTTh1MWdwSWV2VkFadGloYVB2UlYrY3Iza0REVmRx?=
 =?utf-8?B?cVZEaE8xNGhERW0zcHowd0p3dnh4VUdORHpEQThJWmZ4YnplaTdyV0pNc3dv?=
 =?utf-8?B?VHljMnpaQkEwTEdWam55cnU1b2dUNmI4TFg3VFhhTFpBVGtMYVVDVUs2eXdX?=
 =?utf-8?B?eWl0UGdiMUNkeGJlRHQ3WDI4Y2RVSHJjakNaakw5b3hOREczZ1E1ekc5Umo3?=
 =?utf-8?B?MnRPck5DUjVuT0hDdWlOSEVMemY2M0xPRW5YQ29SK2svNHNPQWtlSk9GK3pz?=
 =?utf-8?B?bG5US2VMejZ1YTE5QUFjWnNsa0I2Qkp4TDRqcXFkcG9rdGZyVnZ3L1c4VExW?=
 =?utf-8?B?WXRTZzg2eGcwOXhhOTdLYldSS0M1a0FIZmgrVXE5bjRFU1UzMVdtVEpVV1JB?=
 =?utf-8?B?Z0lyN2JSRUd4S1U1ZzE3T3RXVkliNzFxYlJsVUlWRzBZcmRXUDh1MnBtOFN4?=
 =?utf-8?B?OHBnZ0RzNmJ0dHFMVkZnVXpQMGhuM3Q2TjFrTHlNTmxBREc0YU1jS1pRSnJR?=
 =?utf-8?B?ejVoS0FLYXZoRURuZU1Od1VuWVBqM01ZVll6enFQK283djRSaThDeVVYNjZL?=
 =?utf-8?B?WFV3T25sVDFYK1JDTmdnQkRlL2hUOTNLY3pwWm1GZWtJanZCWGY1K1NUZUN0?=
 =?utf-8?B?U1c5L0ZiS3AyaDFyeXVIbHVDTXp2Z2ZXNzNYay9sN1FtYWNScUMzeVROamtV?=
 =?utf-8?B?MlZlL0t6QnlnQk1JbmNDVktnM0hVdEhGSmN5Z3VPTHJHTGtkYnhmSTFMdmdH?=
 =?utf-8?B?K0lsaWhXOTRRT1dzK1FlNStNcGFSN0Z1bS9HNW0yUG1KT0RWd1NrK0pzcjZy?=
 =?utf-8?B?d2ljM1JlKytUWHpTMlRTWE1GdHBNaTNsTHltSTJWQVZ6WWpuK3cxdGxNWUdT?=
 =?utf-8?B?MEY1L1FSZ1dqakJNeUZQNGZ4YXpMNE9tVGxqVWY3TGxQRlkvVEk3SEIxSE5J?=
 =?utf-8?B?c2R3MkRWUzRGSUZaTE1qbWpvWkZXQnp6R2ZmaERXYk1mTTdxUFBpeHEwMXlr?=
 =?utf-8?B?WTE0dXlLb2pXdWxzMjdQVkVFYTVwKzM1MkoxR2tVRS91Y3ludStnTVYrQ2J3?=
 =?utf-8?B?UnEvWU93Ny9NOVhhOStkZGt1MDgwdklTUHNjRjQ1b0dYZ1JWYmhIcG1yUm1T?=
 =?utf-8?B?dGl6OVltVndQS0FaU2U4a0FHQWN0TzRYRlFWUHU1SEJCQzVFSWxLUmdVWmZS?=
 =?utf-8?B?WE9ocndMMDJ0R1J3NmdEMXFibVoyZ0lDcUs3dEJjV3FOSG9FbVlkdS9oSjVk?=
 =?utf-8?B?eG5Fd0U4VDV5SVBHbExJOW1VbWV5YzNPeGhPUG8zcGJGNVJ1cG1YQ3cxcGZJ?=
 =?utf-8?B?OU92U1QrQUNteDVhNkRZRVBaSDh6ZHRtdTRqeVBhZlRLZGxoMlpyZnVvYjRE?=
 =?utf-8?B?S0VJQmdQMDNST3U0ZzdpU1V6MEc5bnE4WGxLNUc4WTJqRGNQc0FEVW5rN1BF?=
 =?utf-8?B?QXY4SHlUS2lKSWhvdXQ0ZmpoVy9BTlkycWMrWWhtOEo1VnFnazQ4bmROUjNn?=
 =?utf-8?B?WVJYLzJzdE1aSk16Q2FTUnFIbVlyUDNpU0pGS1QzMFhhb0JOY2RRMkJYRUtR?=
 =?utf-8?B?a1pHRG0vMnVRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OHpINUVwbkVVSnFLWU41VWVqMFYrSTN4WTZJQjVxOGdKeUhERzgzbmRZRlE4?=
 =?utf-8?B?MkMwU3NEZWh2VzNJWE5XeFBWZ0VsVkVZZm5FSTJwbjRpSXdoUHp5eHYza3VJ?=
 =?utf-8?B?cW5VTzJWRW9YclppbjBxNGtyNUxQdStSb1dnK0hBbGhBNmI2bDE0QXlzUlll?=
 =?utf-8?B?M0E3cHc3aElrR2dUV3gyNU41MHhTZjlqRzFCSjVDb0QyM2NZMFFJTEMyRnVR?=
 =?utf-8?B?WUp5eHVMSmpjWHY0cXJLRFZkS1IxUHJkNERKN0w5S0ppdlVoaStya0k2NlhM?=
 =?utf-8?B?YnFiak0xZ3ZjMG94L3FsUFQyYkhBTnMwV2ZjeFJUWjlvWStQNDNxWHEydFQr?=
 =?utf-8?B?bWt2VUNmcTNaR2RmNzEvektOdmVYWTI1Y0I1WnVBSXF4VThOVjVVSDdsNjQy?=
 =?utf-8?B?RG9ITHdJK1pqZ3hjTnlobTJocUpPL1VVZ0tidmZGcGo4UUZvRDRNZXliOGFr?=
 =?utf-8?B?YTQ3ZWZVV05FYkdaQmp1U2swejNkMXBReUhtbEJhSmVacHlGNHVjZzhFSE84?=
 =?utf-8?B?dkdFd0dvTHIrQk5pZ0NlbEx2ZE5BYVBNVXFaN3NYOTRwS05wTTJqN1R1TzRn?=
 =?utf-8?B?a0RGRHNSdVBlOFllRE5DcVZwUVJEZ2dmQS9GWm44eGlXeFpNL1VsVGxiK1B0?=
 =?utf-8?B?dUJEMWQ3VmVvZzc1ZVJhUjdhaHVaTnp3RkRQSUNrYTZqNFJVTk1SaWd6ZW5s?=
 =?utf-8?B?ZzRMWEd5cmRSTDlOSHVuTnRGWUdTbi8zOG9ZMzNCdnNRSkE3M3l5dnFiN2Yw?=
 =?utf-8?B?bHZpT28yajdSMlJzQWNXWElDa3oxR05nVkZtc2lvcnI5bmRBaUhQUzlKRlpa?=
 =?utf-8?B?MExGQW1OaUR3bHVPU3g4NzVCOXptOFVUaDZYNEMyeGhQVnc0QkxyaXg1enMw?=
 =?utf-8?B?N0Z5ekZKbkVjRUxPWk4zc29ueFZoa2ZxYnl0U1h3ZmFodUhFMEJXYU9HdHpJ?=
 =?utf-8?B?bWhDSzUvMHlIa2lYTGRtdU1xdEJWODkvSDVOdVB1Vk95dmVnMWJjSEpQUDln?=
 =?utf-8?B?VExoVmlHVE9ydWZBVjlOUnVJTzh6OUlVMmhZbnE1TG82WFJjcW1XQ2czREN5?=
 =?utf-8?B?Z010TytWWFlydnVMZ2xMWHVVcTVBalpEVkVWbTVQQ0xaRmhKLzk0SXhocWow?=
 =?utf-8?B?L3FRYXhiS1luVjMzRU5FOGVnSmpaUkJ0dUtMSHdBUkVxZkJDQnVRTlQ1ZFN1?=
 =?utf-8?B?K2RQTERUR2IrbTR0R1hpNHpoRWZKTGczOEtKM2JnY0YxMmwxeDBhcnZlQ1B5?=
 =?utf-8?B?eHpJUXg5R1pPV2pBMys3LzY3VXV2eWF4eWlZVTg3Z1E1YVRRdEtJTFAxSjJv?=
 =?utf-8?B?dmczU3pwUW8vQWlQSnQ0TkIrRFk4V1AycVNPUGlPNG43NDZpUFNOZXVScGl6?=
 =?utf-8?B?TmNkUUJtQTJORjNVVEpueGlWanFUd2xEc2RQVnV5UGZwZWgyNEdmRHBnYjB3?=
 =?utf-8?B?ckQ1RUZ1SktzUEJGZzJxM3NRSUovSDB6WkgzaEU3dm13VTRNOW9pNEhieFpT?=
 =?utf-8?B?ZGJadzFUTk1tdDJjVUM5c05uOWZOUTdBa1Y4eG1FT1V2TmRGR1RZZW1yR2Ir?=
 =?utf-8?B?UmV2Qlk4QlBkMDNpS2NqU3k0Z2FyRm9LQTJuc0dqQThMYnphOW5oZ2gweUVK?=
 =?utf-8?B?bFpNNjN6QVFFd3dXMXZTV0ZtcTFuQStLQ3Q1YVNmU3AyYW8zbyt2VzZMcSt2?=
 =?utf-8?B?WmdLcVo0SHhBMEwvUnNmZElRWUFoOEFnOGQ1NytUYTRNcjA1SFVlS2ZoUFp5?=
 =?utf-8?B?RlNrSDIzTDNxdlZEK210US9WOTBWSWEyN2hOb1B5MGRmZ3R3c0NRVWpRZFkv?=
 =?utf-8?B?dWZjSkZBVGJZM2dHUm51cXBOclRtZzgvelRDVzJqOStHdWZWWHllM0QzYjc2?=
 =?utf-8?B?MnYxL3l6bEtoS1pLMndMdUZMQWx1aWw3MkxhZkVrYStxWWJOdjEvbyszR3FY?=
 =?utf-8?B?NmhETlBWNmNYQkpDVUljSGxHaVpHNWVEMitVQlZ0cjZjV3IvT21Gd3JLcjdv?=
 =?utf-8?B?TDNxZURzb1FvNzZDTmc0NktIdlg2dHVjcHJDdGZWWmhLZ3dreE5WR0U5SDhx?=
 =?utf-8?B?K0ZUVVJmQUhabWFGWmNURXo3ZW1UeEVyK25HZEVPbEF6VnN6RXhGeW9kcFJO?=
 =?utf-8?Q?vPFpT/97GLl7KLMVkoLQmAXyM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4983ce5c-9e03-44a6-052d-08de2ce775bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 12:29:35.7358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OBu/5CVXgZdX1kPIRbUDGBYrUer4e/qb8xVacBtILBjcF2zk2QCJGJ/RgRNUsRMkgWkUrFd9XUu6lmi1WCi96Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10247

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyYyBLbGVpbmUtQnVk
ZGUgPG1rbEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAyNiwg
MjAyNSA4OjIzIFBNDQo+IFRvOiBDYXJsb3MgU29uZyA8Y2FybG9zLnNvbmdAbnhwLmNvbT4NCj4g
Q2M6IGJyb29uaWVAa2VybmVsLm9yZzsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBoYXdu
Z3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRy
b25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBsaW51eC1zcGlAdmdlci5rZXJuZWwub3Jn
OyBpbXhAbGlzdHMubGludXguZGV2Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVF0gUmU6
IFtQQVRDSCA1LzZdIHNwaTogaW14OiBzdXBwb3J0IGR5bmFtaWMgYnVyc3QgbGVuZ3RoIGZvciBF
Q1NQSQ0KPiBETUEgbW9kZQ0KPiANCj4gT24gMjUuMTEuMjAyNSAxODowNjoxNywgQ2FybG9zIFNv
bmcgd3JvdGU6DQo+ID4gIHN0YXRpYyBpbnQgc3BpX2lteF9waW9fdHJhbnNmZXIoc3RydWN0IHNw
aV9kZXZpY2UgKnNwaSwNCj4gPiAgCQkJCXN0cnVjdCBzcGlfdHJhbnNmZXIgKnRyYW5zZmVyKQ0K
PiA+ICB7DQo+ID4gQEAgLTE3ODAsOSArMjExMiwxNCBAQCBzdGF0aWMgaW50IHNwaV9pbXhfdHJh
bnNmZXJfb25lKHN0cnVjdA0KPiBzcGlfY29udHJvbGxlciAqY29udHJvbGxlciwNCj4gPiAgCSAq
IHRyYW5zZmVyLCB0aGUgU1BJIHRyYW5zZmVyIGhhcyBhbHJlYWR5IGJlZW4gbWFwcGVkLCBzbyB3
ZQ0KPiA+ICAJICogaGF2ZSB0byBkbyB0aGUgRE1BIHRyYW5zZmVyIGhlcmUuDQo+ID4gIAkgKi8N
Cj4gPiAtCWlmIChzcGlfaW14LT51c2VkbWEpDQo+ID4gLQkJcmV0dXJuIHNwaV9pbXhfZG1hX3Ry
YW5zZmVyKHNwaV9pbXgsIHRyYW5zZmVyKTsNCj4gPiAtDQo+ID4gKwlpZiAoc3BpX2lteC0+dXNl
ZG1hKSB7DQo+ID4gKwkJcmV0ID0gc3BpX2lteF9kbWFfdHJhbnNmZXIoc3BpX2lteCwgdHJhbnNm
ZXIpOw0KPiA+ICsJCWlmICh0cmFuc2Zlci0+ZXJyb3IgJiBTUElfVFJBTlNfRkFJTF9OT19TVEFS
VCkgew0KPiA+ICsJCQlzcGlfaW14LT51c2VkbWEgPSBmYWxzZTsNCj4gPiArCQkJcmV0dXJuIHNw
aV9pbXhfcGlvX3RyYW5zZmVyKHNwaSwgdHJhbnNmZXIpOw0KPiA+ICsJCX0NCj4gPiArCQlyZXR1
cm4gcmV0Ow0KPiA+ICsJfQ0KPiANCj4gV2h5IGRvIHlvdSBkbyB0aGlzPyBBRkFJQ1MgdGhlIGZy
YW1ld29yayBhbHJlYWR5IGRvZXMgdGhpcyBmb3IgeW91IHNlZToNCj4gc3BpX3RyYW5zZmVyX29u
ZV9tZXNzYWdlKCkuDQo+IA0KSGksDQoNCkluIGZyYW1lIHdvcms6DQoJCQkJaWYgKCh4ZmVyLT50
eF9zZ19tYXBwZWQgfHwgeGZlci0+cnhfc2dfbWFwcGVkKSAmJg0KCQkJCSAgICAoeGZlci0+ZXJy
b3IgJiBTUElfVFJBTlNfRkFJTF9OT19TVEFSVCkpIHsNCgkJCQkJX19zcGlfdW5tYXBfbXNnKGN0
bHIsIG1zZyk7DQoJCQkJCWN0bHItPmZhbGxiYWNrID0gdHJ1ZTsNCgkJCQkJeGZlci0+ZXJyb3Ig
Jj0gflNQSV9UUkFOU19GQUlMX05PX1NUQVJUOw0KCQkJCQlnb3RvIGZhbGxiYWNrX3BpbzsNCgkJ
CQl9DQoNCkl0IG9ubHkgd2lsbCBoZWxwIGRvIHRoaXMgZm9yICJmcmFtZXdvcmsgZmluaXNoZWQg
RE1BIG1hcCBjYXNlIi4gQnV0IERNQSBkeW5hbWljIGJ1cnN0IGZlYXR1cmUgaXMgbWFwcGVkIGlu
IGRyaXZlci4NClNvIHRoaXMgY29uZGl0aW9uIG5ldmVyIG1lZXQ6ICh4ZmVyLT50eF9zZ19tYXBw
ZWQgfHwgeGZlci0+cnhfc2dfbWFwcGVkKSBJIHRoaW5rLi4NCkNhcmxvcw0KDQo+IE1hcmMNCj4g
DQo+IC0tDQo+IFBlbmd1dHJvbml4IGUuSy4gICAgICAgICAgICAgICAgIHwgTWFyYyBLbGVpbmUt
QnVkZGUgICAgICAgICAgfA0KPiBFbWJlZGRlZCBMaW51eCAgICAgICAgICAgICAgICAgICB8IGh0
dHBzOi8vd3d3LnBlbmd1dHJvbml4LmRlIHwNCj4gVmVydHJldHVuZyBOw7xybmJlcmcgICAgICAg
ICAgICAgIHwgUGhvbmU6ICs0OS01MTIxLTIwNjkxNy0xMjkgfA0KPiBBbXRzZ2VyaWNodCBIaWxk
ZXNoZWltLCBIUkEgMjY4NiB8IEZheDogICArNDktNTEyMS0yMDY5MTctOSAgIHwNCg==

