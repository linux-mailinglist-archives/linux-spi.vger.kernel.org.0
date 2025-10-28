Return-Path: <linux-spi+bounces-10868-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6109BC13E2D
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 10:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599453AC265
	for <lists+linux-spi@lfdr.de>; Tue, 28 Oct 2025 09:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40BA2D23B9;
	Tue, 28 Oct 2025 09:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BRmztOwI"
X-Original-To: linux-spi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013027.outbound.protection.outlook.com [52.101.83.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698DD2C029F;
	Tue, 28 Oct 2025 09:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761644548; cv=fail; b=ZQlpDNN6PWgCJ6lZdHG0gC9+yFFexNQMm1zK7D5Qgw3/KRfaBIt83OKp0wcFomdCJqF4trOTfpoQVov787Ir1W+hnV8KL9egtbCaZ+26WYke7tjSA/+q7sj6KUFGeTuyW5Y9DOUFUhJcsUzMoFu/GfjERWBg13sHOAQOgm2ZQ60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761644548; c=relaxed/simple;
	bh=GXQpolrXKQqe9HGxX72ylUAb+LNwqgyz45ar5bWJeSs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SolF0SmD4e+e9W5LEhEoGwS6vbg85rGGod6HR/fXq6rqSL56gC+M0TFO4km1lRUHGTb8y3Ho9dImhyi0bdrxfvQ2vLDt5Zzy21OjeHmfrJdfNOJa52RWi29BIib4PKEhQvTR4+16xMsGef1CDb2/ezKigX2oi+JikI/p1/4rkI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BRmztOwI; arc=fail smtp.client-ip=52.101.83.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iiUc1xfSggZffmm4t/1IUMFFe6jbHX4elW51aZOJ2UkJUTRLK6srb70vrhmkxcpobAG4VqHlyDYZxZzyic2A+JchEw1o1brBhlzjmXLoDYqU3zbnoXZM2XwzBfxhVtEnNKkbb0oumVtE+TtBr7IDFY9Pgl0p+Xk7Qk40t3dCr0ROYhYDbcd7fGl5aP06GMJg8byBzKED7jkQmBC0baQx2XPzUn1w8jPluNvvUjkIKRQP1qWTTCro1lgnJr0PJPY/S9VWhVg9sjU5+I+VNyEG/aDs6r/PjM2mTRurYZPkLUNm1hpmpS37Lf0MTz1WTWFr3Wn8mGhJAjzHhuaOkHe1nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXQpolrXKQqe9HGxX72ylUAb+LNwqgyz45ar5bWJeSs=;
 b=yocug1BZTMb8jHXgObjmJeFGggQjlNndsI9FAWIZ3Bxrhb264WdtwgxdafwBQdQaOpaaIi5S28OYI9KQ1LOAuThfYWkdJeq9FfJlIgYMqucIL+DfxLEuTgbwGuTvlRwWa44TttX7OHEr17/JvAAo9yKJppHBX8nQewaTNHHymLH+/D8eJWvolmkBOujkOnjS1DPcEWwDLUmbmFDrTBXACA8WYjPpFYYd8i6JbSv75S0k7ZYU9mcOiHXwmNclaQqQQzGxkfw8Z+U7bF75Jtv92UXCasBNIeVXkkcZhAl1HzzTL8OqIKjUsjG4R6HTPMPEfEP5eLHXCmLmvzi97w86XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXQpolrXKQqe9HGxX72ylUAb+LNwqgyz45ar5bWJeSs=;
 b=BRmztOwI8iSCRmpu6qrAw0WOGejZ9GwZli377/z9VZCUEE24j3sjCgXdWeNs1OiVDdCceCnXyrnm0EcdJ6YAB1CLqEow40b83v6XtUhheHrczTJXVL1pq+9MJXGs1lj+MA/QFNoWp8p+bH10pghjQzMsh36nKrbcLeb4OW6qVMx7A3nbnouKGffwWY4a/Y0/hEWYQqzcgBmdrs319LxL2xKoSXOyJaFLk1+thPX6bWMppnaBuyPlb28H32PS/yvM4WaLVd7JgEA1u8mVdYPD200BuaHXWm/5Bn/iLmTsnr4nZwePJVUbTze2n7Ayv9+S8ew+tRtokYuCQnoKuAi0rA==
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by PA4PR04MB9640.eurprd04.prod.outlook.com
 (2603:10a6:102:261::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 09:42:19 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 09:42:19 +0000
From: Carlos Song <carlos.song@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Frank Li <frank.li@nxp.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] spi: imx: keep dma request disabled before dma
 transfer setup
Thread-Topic: [PATCH v2] spi: imx: keep dma request disabled before dma
 transfer setup
Thread-Index: AQHcR+8nrk5n4lTC8kWfx2u0Ku79Wg==
Date: Tue, 28 Oct 2025 09:42:19 +0000
Message-ID:
 <VI2PR04MB11147B5FC64C5376025438FA1E8FDA@VI2PR04MB11147.eurprd04.prod.outlook.com>
References: <20251027110406.543370-1-carlos.song@nxp.com>
 <CAOMZO5DM5NyGdyz4_6WF7qcsMmjAdQvfK0AKxZprUfhC=882pg@mail.gmail.com>
In-Reply-To:
 <CAOMZO5DM5NyGdyz4_6WF7qcsMmjAdQvfK0AKxZprUfhC=882pg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2PR04MB11147:EE_|PA4PR04MB9640:EE_
x-ms-office365-filtering-correlation-id: 44631fb2-c27f-433b-817b-08de160649cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?RkpwRVBqc28rdGhNa1Z0ZUYya2hGRW82WVRscXVITHpIazZKQm96M0w5YnlS?=
 =?utf-8?B?ZmdUSmJUMHgwNWhDRitOVnErSjg0c1Z0YkQxeksvSWlFRWRXVk1JK1h2dG5I?=
 =?utf-8?B?S1lsRjA5ZmcrZXNBSTc0N01VNmJIVVYyUDdtYU53MTlYSFFxb2xnTEx6SG9s?=
 =?utf-8?B?dXJYWHJZcjNCWkVIYVNUZGg3Q1N4Z2xaTWJkVDBJWUtFSXNJeXg5WXZ1dGpE?=
 =?utf-8?B?TVd3czZDSkp5Sk94dnFBYmFLY25tY0NraXh3Y0tYWUxXR1pqUE5JL2N1MUtG?=
 =?utf-8?B?bTVrdXJzQmtWOXJmVmxFQS9hSEwyb2xSWkFqK21uMGxRcnFIQ2tROTJSdmFP?=
 =?utf-8?B?eDJxQVRHU3luTzJXTzZ3c28rbG9ZMFBhZUdKOE9sNXdDd05QQjk2azl2SDFD?=
 =?utf-8?B?dFFGaWY1dHJqYXRLRWh0ODl0NHhKUWdrWlBTdTlEcEdPbmxkZnJnems5dWE5?=
 =?utf-8?B?ZlFwOW1tdnQwc3FxTzlLR1cwZ3VzdDNNUkpSNTMyNEswWE1KVW5BYlBBWnlp?=
 =?utf-8?B?NUE0c2RIcS9MUlNuSUcyN3JMakdwcXB1MDFsWWdMSU5QTS9WS2FXY0pjZU8r?=
 =?utf-8?B?MThFV0FFeHFJYW1vTHRORFBsSkMxNFBLck84LzA2OHlHWHlkQmJnS1p6M05j?=
 =?utf-8?B?RTFqWlZBQm1aQWh6ZktpQTJKNmVVRmFCTk4remt0K3J1WXdjdjNRRWs5dnR0?=
 =?utf-8?B?K1RmOENCVUNRdmtldnNYWncrUUZPaGdRRlBXS2x6cU5yVmdsb05sUmd5dzBs?=
 =?utf-8?B?T054OXNaSGcxYUp2azdNelBHd2xNd2k1M0pieXVzcnVKejNZSkN0T3hNZUls?=
 =?utf-8?B?NnBxbkNBbldaalhiTEFKSWdkRktITzRuOEowb2hMU3J1OHpkTGRacWFDNzE4?=
 =?utf-8?B?UkpzajZQZXNJR2hOMTZ3MWV3TWIxL1JTb3J6cEN5Wmc0WWZNR2V6VDI1S0Uz?=
 =?utf-8?B?cEVOSGlXV2g1cER2a29YaXd3M2RXTm1SRGp4SFJIQVRUVnJWVkNkQXFJQ0J3?=
 =?utf-8?B?Y2ZoNW4vTWRmbkVuM0FobWhGZzFiUW1QNG9yZWdENFFUYWV0SGJWL1BKMGZH?=
 =?utf-8?B?UlpCQVJsVDJBZFpIQlNEOXduaHhqc24vM3NuNXFmQ3UyMDV2YXdOend3c2E3?=
 =?utf-8?B?NmlPdlNNM0IyRnZSc2RVOFZjb0V5dFNzZ2NPdCtlUFl6L0xOcU5ac0E5WTFm?=
 =?utf-8?B?Vlp0YTN2aUVla0puMzJFdzhKWWdKakRaMEdrU1N2aHM4ZzJFcnRHMVY2Z0xr?=
 =?utf-8?B?R2JPK2hLL0JhUThEcXFVMjVqV01qM0FhUlJBWWEvOXljTmtCMEROVlNmRzdO?=
 =?utf-8?B?aGs3LzF0THMrOUQvWEU3azJRZ1h2V1lvMktHaklxRmh6OUlFTVJwTnhZaVVn?=
 =?utf-8?B?WWNZTGttNFl4aW51NUpEaDlyQmJrWDlPS0hvVWJkMjdLSmtqR3Q4YzNmZkYx?=
 =?utf-8?B?WGxibWovZVRhenF2dFA1SUdpeEpENTVicHlLUkphcnR5Tnh6aUhhQTkwS1M0?=
 =?utf-8?B?cy9EMVgweEhPeWx2N0RJQU5idkc2NUE4Z29DY2crU2RxQjNTRTJYT204T01n?=
 =?utf-8?B?Njh2NjJ5L3FVaW5md2l0UzRyQmZCbHZRSmFaR1hjZy81ak9HUDlZdktrSXZD?=
 =?utf-8?B?dWtJZGViUkY2Tndua0VkWFBOUWpMMXg4UkxLanhCSG9QOTRwL0w1czFkaEk1?=
 =?utf-8?B?TDlPeXR5SWpzWTg5b0V4ajkyOXFBMUlnMjkyYVZhMFdqQVA0OEFQWkFOUHJ0?=
 =?utf-8?B?TGZrRGNTeTJJV2JLQ0FtZ0dRRmhMTnZFS0ppd1JuejlVdGVoSkc1RVlSWHhk?=
 =?utf-8?B?MDB1RmZqZ0VTU2x1YW9TRU1SN1JYakpvZU9WLzhKOVc2WVZmaUZoVHBwUXlq?=
 =?utf-8?B?c3ZtNjIwOGpMZVFpK0lwRzltNWhtVHpQVGlvV3FzVEVsUElyem1sMzVWUzFX?=
 =?utf-8?B?WkpDc0tyNGxnaFVxMU1sL2lvbkhLc3dSZmZxNmVtUUpDWkJKdEJpRnhjUkU1?=
 =?utf-8?B?V0VNMUtHOEw4SEVER0lrK0ZmN3dZSkg2YlBkWDliemU1NEJCdHdSUmc5b3Fw?=
 =?utf-8?Q?jDLiFS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZXJ1aGRCZW0xUDN5MjgwNTZLRHQwaWZnOXUvdk5yMUY4REVQakoyMnFEaEJ6?=
 =?utf-8?B?ZlJHZmh2dEhVdTQ2R2lDSlNZUytoaUgwcXphN1J0TlpMMWNGQzIxRCtwK0VM?=
 =?utf-8?B?aS9rZWY2MEZGdnhBTWE4ZUVrL3Vab3A5RVVpSC84cHlvNzNXY0dFaEZIR1c1?=
 =?utf-8?B?dFdUbURSb3VZQlF3YTRvREd2MWM5NmQ3WjYvTm5FOXd5UmZRS2RqcDZteUhq?=
 =?utf-8?B?Q2pvV3JxWE1wUWtxWGV5NkNrcUdveWV3d0VvcFpZQWdLMVpkQzZkRnFvVDBr?=
 =?utf-8?B?ZldDNDN4YVI2czRjejl5OWNzN1N0WGlDMTNBTnZYbUdlNWp0T0NIUFBqRkM5?=
 =?utf-8?B?T1MzRDBMSGg2c3hoTGtFU2tYa2o2eUlxc0ZKTWROZXlaTFlDSzRoalRGWjh2?=
 =?utf-8?B?UTloc2kzRHBRU3BTUFdMN1pMQ1ZjQlozellNUEhkeldlRjAwNXdGWXRqVWJB?=
 =?utf-8?B?ZTY0eERzSzZCdjFoWDJ4VVFVeCtsRXZQTkRHRW1INmhZNS9PWVJ3ekRPR2ZE?=
 =?utf-8?B?Vzluckp2VUNqT05FcjVXSFd3amZTV3kxZjdJUnNkQnFmT1E1clh5OFIvYnYz?=
 =?utf-8?B?VWNBR0JJUVU3QTgrUVdzVElHM2cxMlJCMGZBVy9NNEw4Z05lVkhVSWU5bTcy?=
 =?utf-8?B?UCtGcXRCQ1QwTWVPUjlzQ0ZTb2NNSVZMeUFEK0lneUhYMDVqSUFOclEzMUhB?=
 =?utf-8?B?blhOTkxCK2E1bmhwNmZHZ0p4TThDcTdOU05Ud05XZWR0VlpMS1B2TDdTRXhz?=
 =?utf-8?B?SWIvRHNIUytucUVoZmxBVXlsZy8ra1N0UFJhS2EzRjl2VTlaWG5uR3FjUVYx?=
 =?utf-8?B?TTA1Q0M0TERTN2tvT3RtNG5ydmFhSkhlQ05WUWdvRDNaRE9FZzR2WkpyZ0p4?=
 =?utf-8?B?b0ZEdDUweEFHbVFUV1cxNm5FY0dPNE9oeDZMNC9Qd21Za1d2SUNyend2VFNV?=
 =?utf-8?B?b3VZZ256NWNDSVFOckl4am5MMno0WHdXQTY4ZmZPYkg3NGRUY1AwTVpudkZD?=
 =?utf-8?B?aFhRM0Z5T2VMZCt0Mk40STJhL2RkenpYdndLTkM1USt6c0psQzlGbURockdS?=
 =?utf-8?B?Nnl0SVRYUWtOOEVaTjZPQk1qMzQwb0RxSG5NMjZtUnRYK0FWUVlGclBqNEho?=
 =?utf-8?B?NzNxVG94KzZESUQ4ZGdBYTlZbnpFMXNXc1poSndYTEY4VkEybGtqZDhqUEE0?=
 =?utf-8?B?bks3QmtBYUNmVWUrN0NQaFJIUkFXdGRtSmtHQXpBYXAxQU1EeUkvVG5QbHZk?=
 =?utf-8?B?eVdGYW45S3Q2YmxlTE5GSTJPU1VDVlBwS3dicHpIN091WXlkczROQmMyUGRr?=
 =?utf-8?B?Nkl4S1J2cW01VDdndGZVdGtNams1SHJaVGxEZmZaWU1RZ2t3VXNtTURpaWwr?=
 =?utf-8?B?USs3M044TklvUHo2c1dRZ1E4Uytyd0Z3ZDU2SkR0M1VVaUZ3ejRaL25wMkhp?=
 =?utf-8?B?UGgveks3dXFsbmU5cmJWMXFHeTJ1SEV1Mm9Qbno5MDk2dW9NRXQ0UC8zd2Ro?=
 =?utf-8?B?dnM3U0ZjVFd5WHEraDRhSVhVcFB4b1FtSzg1bS9TYUhlQllwanFWSWVPQWdh?=
 =?utf-8?B?amluVlJvMFVmRmZKM0V6QVg0NWtIeXBkQkFEVUdOeEF1a3pPVGFWVUJNemFE?=
 =?utf-8?B?SFB2YkJ0Q3NEMWJBTTNkUHk0NnQyeE1qZERTd05IOVA4ai9hVkg4VzlJOXk2?=
 =?utf-8?B?R2taMDJSa0p3OHg2Q0MrNEd1TEZQMURRYnRSRXBLbkJkUHNMcFljRm5xNUww?=
 =?utf-8?B?ZUdBRFFYYy9sWVp0QlB3TnFiRnRTWExDcGhWaldwcHlETURyUXZBNWU0V1lH?=
 =?utf-8?B?dHJWemN0cXArTlJuZi9HbnFiM1cvbU9IemxCbDRKMjJuVEhJQzU2bEdTaHVV?=
 =?utf-8?B?cGs3Q2NpNkt5c1U1SkNJUVdFc2hGUHdkRU9wK0kwSUNqODhTZ2tNeDcvWEZk?=
 =?utf-8?B?ZW5INTFNWjg3VlVydEN6MitISjFjanl0aEtIakx5NHRKTDE0WWllK1ViQ1ll?=
 =?utf-8?B?Z1RiNUduSmJQNWZndHg2VXErRWhlTGgxcHQ0aFJObWJJZlBUVnBTOTdZdVVS?=
 =?utf-8?B?ZmhMVjl0S01SdHpPMTYxaUxMRW1PRHAzbFVBTGNhZWdtbjBhVXNOdG9zck4z?=
 =?utf-8?Q?+1xInyU8NCX89RT/DCC+a+GPh?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 44631fb2-c27f-433b-817b-08de160649cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 09:42:19.6908
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FBvMtsyFQVDoxVKErEig4HUqyi7990WuhJRs3cMIAgZBDsmHZaa5Ak4giHvnn1q0K7r0IXXVpwL/CCaZjtyb4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9640

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8gRXN0ZXZhbSA8
ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBTZW50OiBNb25kYXksIE9jdG9iZXIgMjcsIDIwMjUgODox
MyBQTQ0KPiBUbzogQ2FybG9zIFNvbmcgPGNhcmxvcy5zb25nQG54cC5jb20+DQo+IENjOiBGcmFu
ayBMaSA8ZnJhbmsubGlAbnhwLmNvbT47IGJyb29uaWVAa2VybmVsLm9yZzsgc2hhd25ndW9Aa2Vy
bmVsLm9yZzsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRl
OyBsaW51eC1zcGlAdmdlci5rZXJuZWwub3JnOw0KPiBpbXhAbGlzdHMubGludXguZGV2OyBsaW51
eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCB2Ml0gc3BpOiBpbXg6IGtlZXAg
ZG1hIHJlcXVlc3QgZGlzYWJsZWQgYmVmb3JlIGRtYQ0KPiB0cmFuc2ZlciBzZXR1cA0KPiANCj4g
Q2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVu
IGNsaWNraW5nIGxpbmtzIG9yDQo+IG9wZW5pbmcgYXR0YWNobWVudHMuIFdoZW4gaW4gZG91YnQs
IHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZyB0aGUgJ1JlcG9ydCB0aGlzDQo+IGVtYWlsJyBidXR0
b24NCj4gDQo+IA0KPiBPbiBNb24sIE9jdCAyNywgMjAyNSBhdCA4OjA04oCvQU0gPGNhcmxvcy5z
b25nQG54cC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogUm9iaW4gR29uZyA8eWliaW4uZ29u
Z0BueHAuY29tPg0KPiA+DQo+ID4gRHVlIHRvIGEgaGFyZHdhcmUgbGltaXRhdGlvbiBvbiBTRE1B
IGV2ZW50IGVuYWJsZSAoRU5CTG4pLCB0aGUgRE1BDQo+ID4gcmVxdWVzdCBtdXN0IHJlbWFpbiBk
aXNhYmxlZCB1bnRpbCB0aGUgRE1BIHRyYW5zZmVyIHNldHVwIGlzIGNvbXBsZXRlLg0KPiA+DQo+
ID4gUmVmZXIgU0RNQSAyLjYuMjggQ2hhbm5lbCBFbmFibGUgUkFNIChTRE1BQVJNeF9DSE5FTkJM
bikgc2VjdGlvbjoNCj4gPg0KPiA+ICINCj4gPiBJdCBpcyB0aHVzIGVzc2VudGlhbCBmb3IgdGhl
IEFybSBwbGF0Zm9ybSB0byBwcm9ncmFtIHRoZW0gYmVmb3JlIGFueQ0KPiA+IERNQSByZXF1ZXN0
IGlzIHRyaWdnZXJlZCB0byB0aGUgU0RNQSwgb3RoZXJ3aXNlIGFuIHVucHJlZGljdGFibGUNCj4g
PiBjb21iaW5hdGlvbiBvZiBjaGFubmVscyBtYXkgYmUgc3RhcnRlZC4NCj4gPiAiDQo+ID4NCj4g
PiBTRE1BIGhhcmR3YXJlIGNvbmZpZ3VyYXRpb24gaXMgcG9zdHBvbmVkIHRvIHRyYW5zZmVyIHBo
YXNlLCBzbw0KPiA+IGVuYWJsaW5nIHRoZSBETUEgcmVxdWVzdCB0b28gZWFybHkgbWF5IGNhdXNl
IHVucHJlZGljdGFibGUgY2hhbm5lbA0KPiBhY3RpdmF0aW9uLg0KPiA+IFRoZW4ga2VlcCBkbWEg
cmVxdWVzdCBkaXNhYmxlZCBiZWZvcmUgZG1hIHRyYW5zZmVyIHNldHVwLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogQ2FybG9zIFNvbmcgPGNhcmxvcy5zb25nQG54cC5jb20+DQo+ID4gU2lnbmVk
LW9mZi1ieTogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0BueHAuY29tPg0KPiANCj4gU2hvdWxkIHRo
aXMgY29udGFpbiBhIEZpeGVzIHRhZz8NCg0KVGhhbmsgeW91LCBJIHdpbGwgYWRkIHRoaXMgYXQg
bmV4dCB2ZXJzaW9uIHBhdGNoLg0K

