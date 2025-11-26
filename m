Return-Path: <linux-spi+bounces-11572-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD40C88B25
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 09:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E1D9134D448
	for <lists+linux-spi@lfdr.de>; Wed, 26 Nov 2025 08:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89097319867;
	Wed, 26 Nov 2025 08:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gnxCvsdw"
X-Original-To: linux-spi@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013050.outbound.protection.outlook.com [40.107.159.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4C42C15A5;
	Wed, 26 Nov 2025 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764146634; cv=fail; b=ou4oFtWXGNZ5/5Xw08wgfFhG1Vx78KKahaBFIyY8vF8tDlqNNKH5f886MUkjIzLbli/Z093zFWLQrTMTRTBwIW0v9+HsPCBFqToq14yi+YcFlFs8Sw1oVtYY4QSs9oQpvGPjgd3HZ6Oz9g/MMnLiuXAaWD6Ug+oYwRoS+FpOrAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764146634; c=relaxed/simple;
	bh=sHkBHEWBM7EI+fjJ7Dj7m2fR2KlyjUmQHKX2g4l13Dg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ys8aZwwwU16x2JtnKpSf28Ry6nVNWZBe+X26cLk5Ynd157M06I56cdVKIKZAGA+F67yTAYpofkUJffefqltmEddoF+ruS0vV1zHBDUpQGcsw/Z5YDjviCYbhjRv5/YxwHb26xuJwHT+nMHOO+7pE3U5ahTNZpATvtfyTp+O47lc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gnxCvsdw; arc=fail smtp.client-ip=40.107.159.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USj5nkhOAI3EilKV6MSWDIJQN/p42FSgoB2xYsTeb4fj0wbWAWpIq8oZ5mnDFmLQPD7Q5hr5OeAsnVTTkkYJsSoZrqQEfFSLAr0J1XTeoguQ/BxW9o63vHOTJDb75VxLJVu8TQz30+P5hgxAbLxTbpdp7ecLfK6ivb+EtRt5byzFVOZVrTsrOhlqU/ItAev0UQmPV29SCgg2wxwQnVJXiHXuTPrfzPWrzjUHNOUjnZYC5dDi+P6EFnEpE3nujGpfarfB+/UWlaCxvGjNs5BpjOdjOeXdF0R1P2pP4iPs1g8u4Dh2YnKICwkeNdaTW4JRnqN5zq4Vg4hEOjQwB1he8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHkBHEWBM7EI+fjJ7Dj7m2fR2KlyjUmQHKX2g4l13Dg=;
 b=JBTnf5k2ezOViSLRJ2EmcfqwdgGfu7qjippWcf/vkXuKCtpyLb6Qlrg4C7qZ6KIXCu/qc05rM+G0V+8kDBf6+NI9UOk9d5VIoOdXOcKk7q1lOdRccGGp5FCX70A+rpP5efnhQAPn8cYlyzHcV5fy+4LrUPNUt1sJef8RY8l7HG2MIW4Fgkz5wt0p0pyvKyk32EfIXr3Air9Dwqs/vVSLwXCQHrMQNjkjvY8Tg78Q3PNYVrtkvsCglMJCsZAFllj1wZ0On3mM2tbGS3irqdVmhcMyIIjZ/O09NLRtBpCAYSDidQC+1lVVFFASX1AMRBBRnyXJTBJ0AJUA6Ux5mWFO8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHkBHEWBM7EI+fjJ7Dj7m2fR2KlyjUmQHKX2g4l13Dg=;
 b=gnxCvsdwVHDgnPP83xuZQ23UFuNwJ5zjI+3wyJIRq1KazVhCGjSaw1fNzmX29RehoqM0b2Cw5lhSGqGKy3rHJHBoRn9/ZI9wdlKiR8ycvDCCJBz3ctCM9WR4rfAW+gCGzayDT2stQJUu+3l1XErPYXh8yDrJ26JO42VDVxS16wp8LqoDGBDff7xfXlLIiYFAVazqg6G8WWlG/ltfkuGtzHhTS4SyOWSO+8vT+4XFriLRyJcS1FR29BO8bM3kqBZK+o/nMD7/1rafGaGgJZ+/FTmEapWtGv5LTDhoGHGUOv/XQek1Z3YL8eEKKkZaMMq4NhFGfFPVzVkYmJjYFSTuuw==
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 (2603:10a6:800:293::14) by PA1PR04MB10700.eurprd04.prod.outlook.com
 (2603:10a6:102:48e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 08:43:48 +0000
Received: from VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687]) by VI2PR04MB11147.eurprd04.prod.outlook.com
 ([fe80::75ad:fac7:cfe7:b687%6]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 08:43:48 +0000
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
Thread-Index: AQHcXfNVDK4T0P1c8k+DMajAF1tbjLUEoTyAgAACH5A=
Date: Wed, 26 Nov 2025 08:43:47 +0000
Message-ID:
 <VI2PR04MB11147C2A05A6848DC5E2DAEB8E8DEA@VI2PR04MB11147.eurprd04.prod.outlook.com>
References: <20251125100618.2159770-1-carlos.song@nxp.com>
 <20251125100618.2159770-6-carlos.song@nxp.com>
 <20251126-mahogany-skunk-of-drama-db31a4-mkl@pengutronix.de>
In-Reply-To: <20251126-mahogany-skunk-of-drama-db31a4-mkl@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2PR04MB11147:EE_|PA1PR04MB10700:EE_
x-ms-office365-filtering-correlation-id: 744f0ac3-59ad-469d-cab5-08de2cc7ea9e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|19092799006|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dlFROFpLZmR5OUlJWVRDY1laTEsxTjU5aW9tOEpiS2ZyRUN6UGJLRTFJYXFM?=
 =?utf-8?B?OFVKd081c0EyMnlXdFhtVXF5eEV6dS8zYzFBakp0ZnhsZG05QXRLN2Nueit5?=
 =?utf-8?B?MHloL2tNMjIxZkdSMXc4UHZpZ01XSlFCOG9BUy9SRUJ5WHp2MVk2TVpzRU51?=
 =?utf-8?B?clFTRXlnc2xTSWRiaERaUWtDOTFLanlSUm94Rnk0NkltdTBseXJnY1FKVUpK?=
 =?utf-8?B?cTVZRVJnc1F2ZExHeFFxSTNNRDhkQUxyOVpEREY5aXJCNER4aExaQ3p6Zlp2?=
 =?utf-8?B?M09DZ0M3YnJhNkRoM2wrYUNwbTllR21OMzhIRHFTWk1sUTZ0RWRmcnBUTzZS?=
 =?utf-8?B?dEt5Ni9helB6WkdpRG1aVHlac0xJUHB3RnVsTGpwbjNNTTJQS09mS1QxUktp?=
 =?utf-8?B?MnNXeVZ2TytmUmlPQXAwVm9wTU1lSHFLOUwrcFFtMlAzd3dzZG9rN0pCczVa?=
 =?utf-8?B?UnR5ZmNGenNNaTRrUmR2TFdscDRuaEJCNUZDczZJR2doT2JhR21hb1RBU1M5?=
 =?utf-8?B?dFlBVUNCRDBScnNwNWl6Vi9JaWdVME85cWlPSGRNTDlqcG9RaTJKV1ZubXNq?=
 =?utf-8?B?d3FvdmVjK1JyMnJ6aEJ5akVsbU5RejVOSFpXVGtYalhlTkFRSnlveE1idzQ1?=
 =?utf-8?B?OFUvM3Z5K2JSaWdoQk1GUzBOcjc2UERPN1lCWnU5VnlNd0RWcHpxQTYyRDFu?=
 =?utf-8?B?bzlrY21RK3B3bU9PajRCRG1ndlV4R1M3aW4zckNoRGdNZkQ1eUZwc05Gd05Q?=
 =?utf-8?B?L0RtRFplZDdVeWlzZGxGNHppdjFSVmhIdUh2ZlVOT1F2ZkpOZGhYcU1wdXcr?=
 =?utf-8?B?N0F0Z1I5dmMzenE1anhrMHhSU1ZHdGh0Qjh2WHJHZGNLWlR0RS9ZN2V5MDFL?=
 =?utf-8?B?RFMvWHVPYmNubmJ5ZFV4Q2s3UnZudWF0bDMvcHlYVXJhN05iOVd6Qk1LOE9t?=
 =?utf-8?B?YTBqU1BYWTNIUThFNU1xbGxadUhvWHphMEhNM2ZYck92Y1RnMmxEaFE4NUgz?=
 =?utf-8?B?a0x3aTgrZjM4Z05iYmsrL0xTVnhBUmt5cHdKVzV2MGxzcTFiVk1sN0JIbnIr?=
 =?utf-8?B?OEZhb1J0YmRWRW1ORGkwYkRnOEE1RTl4NjFWZ1ZsSkVRcXZlSS85dERNMG5t?=
 =?utf-8?B?Q04yUzIwZGRrNFJTeHBDRTdlcmxzMGpFSVkrUjNkY0lXLzdxVzlIYWZQQnU3?=
 =?utf-8?B?OGdTcWhpMXJNdmZRN1FOcmtyNzRwSE1KUEtBOUpLd3pNSlBTY2ZzN1g0TzVx?=
 =?utf-8?B?dVZwUDZzMlVhNmtyYmJvbGsxUXdtMXd2S2xXWWVDalB6SXhETlRORDQvcW5s?=
 =?utf-8?B?R2M0RDU2NUw4Y0t6dVphYkJVV2lZZ28wd1MvbzI1alZvUWZBWTJSbExQN1d3?=
 =?utf-8?B?Y3U1dHczbUhmbUMxYlduK1RlRnlsZ3ZMT1J4djJTaDMvUGRvbVRFN2x4Smw0?=
 =?utf-8?B?bmRkQkF5dUZFdzlNUjZXOFJjWnJBT0p3U3ZMK2YrUTVMdzNDRGwvbFVlOWd5?=
 =?utf-8?B?VnBkYkpIZTkzNTA3THVPbklhM1dkY0JZQ3JWdHc2Y3VwMjczbDc5UHVBSmxx?=
 =?utf-8?B?bjM2TFZVZk84c1czVk5aNmdIdzZZMUJYL0lRQ0RBZUVYejFHd2R2MmpBbFhl?=
 =?utf-8?B?cmtJMDRrbHpmdjhyMHVjeGxoRTN5MG1USHd3MnBqOCtlY1ZlSmx1enpTMXdj?=
 =?utf-8?B?ekpIemlHR1hLOXhubGZWVi8yQTVYaHBtUFNqdTl4STduV3lqZDBCa09ONjM5?=
 =?utf-8?B?M3BxNjdiU0MxM0VROVJjbk9XTWgrMXpWNm1Fd3dMRkJKNFYvYTY1aG1SKytj?=
 =?utf-8?B?YnJRTmZTeERqWHhMNFpIMnpkVFFxK1crYmh2Skhjdkg0ZVpMTmtwZ1Rqdi9N?=
 =?utf-8?B?b2JOQnR5ZjNlaExMK1ZDUXNBK3BjL09DOE85U2FDSUpnR2xkbVB2ZlNNOTJK?=
 =?utf-8?B?QmU1cXIvTzlQc1VBS05CMTROeTBhWVBYTHplVEVLYkdiWk4rWjE5VHRSTWZL?=
 =?utf-8?B?RmdQb3NZUmxnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11147.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(19092799006)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Yy96RFZXcEdKcXdudEZ4YnpPNThyV1kyT0pJdDg4VVhxL1ZDOHNrOUlzYnQ4?=
 =?utf-8?B?T25FNmVJZGtQZTVNcldVWm4vQnV2OXdSU3FHamlrN2lONWZHdDFSdE1sYkZl?=
 =?utf-8?B?eFFoM1BYdzFaTkJydEVxdDNSWklXeVI0MnU0Y1hqdVI2YkNRd0xWamo5Q20x?=
 =?utf-8?B?N1ZJaHcxazlDMmkraUpFYXBiMklJWCs4TVkxTkVydlFqM2VUVzRJUFM3blcz?=
 =?utf-8?B?RTlvNEd3dzF0TTl4dkxQcHJhTkVpQWZJdlp4bER3N3RhQ0NPckE2OG1TT2dR?=
 =?utf-8?B?dittejlVaVVQYWZ5d1BZcXlHKzExWUhFVGpxSjlxeXNsYVQ2VWR3Y25RRXFw?=
 =?utf-8?B?RGU5SW8wdmhwelJsbXRUbE1SVEcxeStRMGZPYUwwWm1xaWtZZHhmOWdhMElU?=
 =?utf-8?B?RzQxZktMK1NLMnMwTVN5aUFHSzlnYW5EaU9WVDRUbmpaMG5aQ21Va3Q4anNh?=
 =?utf-8?B?NWIybk9iU3I4UTh3ZlNFL2h0NlVqRU10dzZRZnhiRFBnbU5QaXNRMytEdjh0?=
 =?utf-8?B?MWxtS2I2dTlsTWdhQW0vdklhWHRDVHFrOWVjdlJLYXpkK1o3NDVkN2xTbFVQ?=
 =?utf-8?B?RG5SQlE0N0pEd2VYcWdYVTU3bitTS2YrbCtPMFU2MnN1K1RIN05hT2ZFWnBa?=
 =?utf-8?B?R1l3cUJValdUUG9PVnJFOUtWSG5UYTRESnp0TDJCcTlMcFlGeGdnaExwY3dm?=
 =?utf-8?B?QUN0ODN0dnNQakdvQ2VKNURiNEV6NDR5S20yUmZIMVkzblRLbi9KSG15K1RK?=
 =?utf-8?B?dk80dkNsS1V4N0NTYWhGMjZmblg2U3d0bVU4N0JyVnZLYmZUd0NaUUNUQUo3?=
 =?utf-8?B?bmQ4RXYzQWY5a3FaYXVQdFl3eDhDMUd1NjJwUzNDRXpGR004Q2YyQllIK3Fy?=
 =?utf-8?B?djkrTy91WGF1TlkrN0lLYSs3b3dNWWZjaS9lT0VFVFlGZkhyTm9LdXpGenFY?=
 =?utf-8?B?TmhSOTU4cEkzYlRhVE9aUXgzbS9oWHdUeXFuM090Nm41YWVTNFVxNjBlRVNO?=
 =?utf-8?B?eWZhWldTVzVNcmtsZVlJam9NZ1lqd3E1aEF3U0RaeDgybTdUc0Z6cHppOFVY?=
 =?utf-8?B?RUxZY0JjcHY3SnJJRXF1TmExalQ0MWZ0K3UwMHpLbG5FYTlYaGZMNEpvd3Uw?=
 =?utf-8?B?KzZmUDdENnlYclM2TTQ2SEpMa0hvVjd1bnMzVStDdHM3VmYwSmNtRm9jQ3FS?=
 =?utf-8?B?NmFraUFHVm5hemowRXdoZ1RsVTBYemtZalZYcmRHcXVsU3Z6bkRDdk5TL1JX?=
 =?utf-8?B?T3NUMFNTc0I5QWdNYVJTcXZhVjJmTVRDV245SUFTMFJpZHNtY1paTHBTUGxn?=
 =?utf-8?B?Vng5Vm11TEVScSs4UzloSGRLR001bE5FR1RqUGtVVUlzbURrL2hzTFR3bTFP?=
 =?utf-8?B?L0FneFlWMUZtTGlLMVpkSWI2QmllREJQd0xsKzB4RDc3WDVoVXREZWVxK3V3?=
 =?utf-8?B?cWRjYVRDTlM1cDdSL0RVVzVkSDVsWnA0Nk9YcWhvbUdhZ2ZVRTRlZVlwQUlZ?=
 =?utf-8?B?cktqZXFPaytOT09JNE9lbkRoQlJNOVFkTlhPZ3RuR2c3UWxsd1gvdkk5NURR?=
 =?utf-8?B?WjN6WTEwNkdzc25TZ3RTdXhGUU5JQnJGdnBVQlcwaDNrOVlnZTM2MHFZTDds?=
 =?utf-8?B?QVlDaUVvWkRNYXlaSlJLQUVBbnpnT05OOHJKNm1KTnlJMmhxRDlrNDdpTlF5?=
 =?utf-8?B?VUxVczlyTUxOOFg0UzZXYm5aQ0JzMm1iYy9hbUlVN3JUVWpUd2x3cUdINWJW?=
 =?utf-8?B?WHpYTXMxZGVGM1NPYnduVm96N1hIek1DZUt4ZkRRejJUY2RUbTN2ZjlmU2Fm?=
 =?utf-8?B?M1ozZnFwazRnUHlEZDhzczd3QUtvVGl5SEJOZ05MeE9DS1RoRzVhZnhFRFQ1?=
 =?utf-8?B?TUJ5NlcyaHcrb3pmS1N4bWdzWkRkSlZudmVhUlc4NngxREhyaWV5NENwd3FF?=
 =?utf-8?B?UXhUUForYk85T3ZpNVlYQ2F2d0h2YVYzT0ZZSnVYS2xjVDJoVDl4bnhXN2U2?=
 =?utf-8?B?aHRRdEJCRUlYVWpPSDVsRUpaTGFUZUNnRFBid1I5UC93Y0hHUnd4OVY4VjhQ?=
 =?utf-8?B?SWlKN1hramV4cUNMQ3VNY2tNaVp6K1lyWlhlNDJDQUJSTy9jREF1UGNEbTQr?=
 =?utf-8?Q?itKz5XyxTaUCo7H492Vu3pRIl?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 744f0ac3-59ad-469d-cab5-08de2cc7ea9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 08:43:47.9455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhWdIbYvpyEZefjU2DwWLS0aK37syqfU2vUyOoAgMhp6Hmiowtjr/tb5X30rZGx3cpXmUAn1/vSfBx5/zwerTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10700

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyYyBLbGVpbmUtQnVk
ZGUgPG1rbEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAyNiwg
MjAyNSA0OjI4IFBNDQo+IFRvOiBDYXJsb3MgU29uZyA8Y2FybG9zLnNvbmdAbnhwLmNvbT4NCj4g
Q2M6IGJyb29uaWVAa2VybmVsLm9yZzsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBoYXdu
Z3VvQGtlcm5lbC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRy
b25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOw0KPiBsaW51eC1zcGlAdmdlci5rZXJuZWwub3Jn
OyBpbXhAbGlzdHMubGludXguZGV2Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVF0gUmU6
IFtQQVRDSCA1LzZdIHNwaTogaW14OiBzdXBwb3J0IGR5bmFtaWMgYnVyc3QgbGVuZ3RoIGZvciBF
Q1NQSQ0KPiBETUEgbW9kZQ0KPiANCj4gT24gMjUuMTEuMjAyNSAxODowNjoxNywgQ2FybG9zIFNv
bmcgd3JvdGU6DQo+ID4gK3N0YXRpYyBpbnQgc3BpX2lteF9kbWFfZGF0YV9wcmVwYXJlKHN0cnVj
dCBzcGlfaW14X2RhdGEgKnNwaV9pbXgsDQo+ID4gKwkJCQkgICAgc3RydWN0IHNwaV90cmFuc2Zl
ciAqdHJhbnNmZXIsDQo+ID4gKwkJCQkgICAgYm9vbCB3b3JkX2RlbGF5KQ0KPiA+ICt7DQo+ID4g
Kwl1MzIgcHJlX2JsLCB0YWlsX2JsOw0KPiA+ICsJdTMyIGN0cmw7DQo+ID4gKwlpbnQgcmV0Ow0K
PiA+ICsNCj4gPiArCS8qDQo+ID4gKwkgKiBFQ1NQSSBzdXBwb3J0cyBhIG1heGltdW0gYnVyc3Qg
b2YgNTEyIGJ5dGVzLiBXaGVuIHhmZXItPmxlbiBleGNlZWRzDQo+IDUxMg0KPiA+ICsJICogYW5k
IGlzIG5vdCBhIG11bHRpcGxlIG9mIDUxMiwgYSB0YWlsIHRyYW5zZmVyIGlzIHJlcXVpcmVkLiBJ
biB0aGlzIGNhc2UsDQo+ID4gKwkgKiBhbiBleHRyYSBETUEgcmVxdWVzdCBpcyBpc3N1ZWQgZm9y
IHRoZSByZW1haW5pbmcgZGF0YS4NCj4gPiArCSAqLw0KPiA+ICsJY3RybCA9IHJlYWRsKHNwaV9p
bXgtPmJhc2UgKyBNWDUxX0VDU1BJX0NUUkwpOw0KPiA+ICsJaWYgKHdvcmRfZGVsYXkpIHsNCj4g
PiArCQkvKg0KPiA+ICsJCSAqIFdoZW4gU1BJIElNWCBuZWVkIHRvIHN1cHBvcnQgd29yZCBkZWxh
eSwgYWNjb3JkaW5nIHRvICJTYW1wbGUNCj4gUGVyaW9kIENvbnRyb2wNCj4gPiArCQkgKiBSZWdp
c3RlciIgc2hvd3MsIFRoZSBTYW1wbGUgUGVyaW9kIENvbnRyb2wgUmVnaXN0ZXINCj4gKEVDU1BJ
X1BFUklPRFJFRykNCj4gPiArCQkgKiBwcm92aWRlcyBzb2Z0d2FyZSBhIHdheSB0byBpbnNlcnQg
ZGVsYXlzICh3YWl0IHN0YXRlcykgYmV0d2Vlbg0KPiBjb25zZWN1dGl2ZQ0KPiA+ICsJCSAqIFNQ
SSB0cmFuc2ZlcnMuIEFzIGEgcmVzdWx0LCBFQ1NQSSBjYW4gb25seSB0cmFuc2ZlciBvbmUgd29y
ZCBwZXINCj4gZnJhbWUsIGFuZA0KPiA+ICsJCSAqIHRoZSBkZWxheSBvY2N1cnMgYmV0d2VlbiBm
cmFtZXMuDQo+ID4gKwkJICovDQo+ID4gKwkJc3BpX2lteC0+ZG1hX3BhY2thZ2VfbnVtID0gMTsN
Cj4gPiArCQlwcmVfYmwgPSBzcGlfaW14LT5iaXRzX3Blcl93b3JkIC0gMTsNCj4gPiArCX0gZWxz
ZSBpZiAodHJhbnNmZXItPmxlbiA8PSBNWDUxX0VDU1BJX0NUUkxfTUFYX0JVUlNUKSB7DQo+ID4g
KwkJc3BpX2lteC0+ZG1hX3BhY2thZ2VfbnVtID0gMTsNCj4gPiArCQlwcmVfYmwgPSB0cmFuc2Zl
ci0+bGVuICogQklUU19QRVJfQllURSAtIDE7DQo+ID4gKwl9IGVsc2UgaWYgKCEodHJhbnNmZXIt
PmxlbiAlIE1YNTFfRUNTUElfQ1RSTF9NQVhfQlVSU1QpKSB7DQo+ID4gKwkJc3BpX2lteC0+ZG1h
X3BhY2thZ2VfbnVtID0gMTsNCj4gPiArCQlwcmVfYmwgPSBNWDUxX0VDU1BJX0NUUkxfTUFYX0JV
UlNUICogQklUU19QRVJfQllURSAtIDE7DQo+ID4gKwl9IGVsc2Ugew0KPiA+ICsJCXNwaV9pbXgt
PmRtYV9wYWNrYWdlX251bSA9IDI7DQo+ID4gKwkJcHJlX2JsID0gTVg1MV9FQ1NQSV9DVFJMX01B
WF9CVVJTVCAqIEJJVFNfUEVSX0JZVEUgLSAxOw0KPiA+ICsJCXRhaWxfYmwgPSAodHJhbnNmZXIt
PmxlbiAlIE1YNTFfRUNTUElfQ1RSTF9NQVhfQlVSU1QpICoNCj4gQklUU19QRVJfQllURSAtIDE7
DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJc3BpX2lteC0+ZG1hX2RhdGEgPSBrbWFsbG9jX2FycmF5
KHNwaV9pbXgtPmRtYV9wYWNrYWdlX251bSwNCj4gPiArCQkJCQkgIHNpemVvZihzdHJ1Y3QgZG1h
X2RhdGFfcGFja2FnZSksDQo+ID4gKwkJCQkJICBHRlBfS0VSTkVMIHwgX19HRlBfWkVSTyk7DQo+
ID4gKwlpZiAoIXNwaV9pbXgtPmRtYV9kYXRhKSB7DQo+ID4gKwkJZGV2X2VycihzcGlfaW14LT5k
ZXYsICJGYWlsZWQgdG8gYWxsb2NhdGUgRE1BIHBhY2thZ2UgYnVmZmVyIVxuIik7DQo+ID4gKwkJ
cmV0dXJuIC1FTk9NRU07DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJaWYgKHNwaV9pbXgtPmRtYV9w
YWNrYWdlX251bSA9PSAxKSB7DQo+ID4gKwkJY3RybCAmPSB+TVg1MV9FQ1NQSV9DVFJMX0JMX01B
U0s7DQo+ID4gKwkJY3RybCB8PSBwcmVfYmwgPDwgTVg1MV9FQ1NQSV9DVFJMX0JMX09GRlNFVDsN
Cj4gPiArCQlzcGlfaW14LT5kbWFfZGF0YVswXS5jbWRfd29yZCA9IGN0cmw7DQo+ID4gKwkJc3Bp
X2lteC0+ZG1hX2RhdGFbMF0uZGF0YV9sZW4gPSB0cmFuc2Zlci0+bGVuOw0KPiA+ICsJCXJldCA9
IHNwaV9pbXhfZG1hX3R4X2RhdGFfaGFuZGxlKHNwaV9pbXgsICZzcGlfaW14LT5kbWFfZGF0YVsw
XSwNCj4gdHJhbnNmZXItPnR4X2J1ZiwNCj4gPiArCQkJCQkJIHdvcmRfZGVsYXkpOw0KPiA+ICsJ
CWlmIChyZXQpIHsNCj4gPiArCQkJa2ZyZWUoc3BpX2lteC0+ZG1hX2RhdGEpOw0KPiA+ICsJCQly
ZXR1cm4gcmV0Ow0KPiA+ICsJCX0NCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJY3RybCAmPSB+TVg1
MV9FQ1NQSV9DVFJMX0JMX01BU0s7DQo+ID4gKwkJY3RybCB8PSBwcmVfYmwgPDwgTVg1MV9FQ1NQ
SV9DVFJMX0JMX09GRlNFVDsNCj4gPiArCQlzcGlfaW14LT5kbWFfZGF0YVswXS5jbWRfd29yZCA9
IGN0cmw7DQo+ID4gKwkJc3BpX2lteC0+ZG1hX2RhdGFbMF0uZGF0YV9sZW4gPQ0KPiBESVZfUk9V
TkRfRE9XTl9VTEwodHJhbnNmZXItPmxlbiwNCj4gPiArCQkJCQkJCQkgICBNWDUxX0VDU1BJX0NU
UkxfTUFYX0JVUlNUKQ0KPiA+ICsJCQkJCQkJCSAgICogTVg1MV9FQ1NQSV9DVFJMX01BWF9CVVJT
VDsNCj4gDQo+IFdoYXQgbWF0aGVtYXRpY2FsIG9wZXJhdGlvbiBkbyB5b3Ugd2FudCB0byBkbz8g
V2h5IGRvIHlvdSB1c2UgYSA2NCBiaXQgZGl2Pw0KPiBXaGF0IGFib3V0IHJvdW5kX2Rvd24oKT8N
Cj4gDQoNCkkgd2FudCB0byByb3VuZCBkb3duIHhmZXItPmxlbiBieSBNWDUxX0VDU1BJX0NUUkxf
TUFYX0JVUlNUIHRvIGNhbGN1bGF0ZSBob3cgbWFueSBNWDUxX0VDU1BJX0NUUkxfTUFYX0JVUlNU
IGFyZSBpbiB4ZmVyLT5sZW4uDQpXaGVuIGxlbiA9NTEyKjMgKzUxMS4gU28gYWZ0ZXIgdGhpcyBJ
IGNhbiBnZXQgc3BpX2lteC0+ZG1hX2RhdGFbMF0uZGF0YV9sZW4gPSA1MTIqMy4NCnJvdW5kX2Rv
d24oKSBpcyBlbm91Z2godTMyKS4gRG9uJ3QgbmVlZCA2NCBiaXQuLiBJIGNhbiBmaXggaXQgaW4g
djINCg0KPiA+ICsJCXJldCA9IHNwaV9pbXhfZG1hX3R4X2RhdGFfaGFuZGxlKHNwaV9pbXgsICZz
cGlfaW14LT5kbWFfZGF0YVswXSwNCj4gdHJhbnNmZXItPnR4X2J1ZiwNCj4gPiArCQkJCQkJIGZh
bHNlKTsNCj4gPiArCQlpZiAocmV0KSB7DQo+ID4gKwkJCWtmcmVlKHNwaV9pbXgtPmRtYV9kYXRh
KTsNCj4gPiArCQkJcmV0dXJuIHJldDsNCj4gPiArCQl9DQo+ID4gKw0KPiA+ICsJCWN0cmwgJj0g
fk1YNTFfRUNTUElfQ1RSTF9CTF9NQVNLOw0KPiA+ICsJCWN0cmwgfD0gdGFpbF9ibCA8PCBNWDUx
X0VDU1BJX0NUUkxfQkxfT0ZGU0VUOw0KPiA+ICsJCXNwaV9pbXgtPmRtYV9kYXRhWzFdLmNtZF93
b3JkID0gY3RybDsNCj4gPiArCQlzcGlfaW14LT5kbWFfZGF0YVsxXS5kYXRhX2xlbiA9IHRyYW5z
ZmVyLT5sZW4gJQ0KPiBNWDUxX0VDU1BJX0NUUkxfTUFYX0JVUlNUOw0KPiA+ICsJCXJldCA9IHNw
aV9pbXhfZG1hX3R4X2RhdGFfaGFuZGxlKHNwaV9pbXgsICZzcGlfaW14LT5kbWFfZGF0YVsxXSwN
Cj4gPiArCQkJCQkJIHRyYW5zZmVyLT50eF9idWYgKw0KPiBzcGlfaW14LT5kbWFfZGF0YVswXS5k
YXRhX2xlbiwNCj4gPiArCQkJCQkJIGZhbHNlKTsNCj4gPiArCQlpZiAocmV0KSB7DQo+ID4gKwkJ
CWtmcmVlKHNwaV9pbXgtPmRtYV9kYXRhWzBdLmRtYV90eF9idWYpOw0KPiA+ICsJCQlrZnJlZShz
cGlfaW14LT5kbWFfZGF0YVswXS5kbWFfcnhfYnVmKTsNCj4gPiArCQkJa2ZyZWUoc3BpX2lteC0+
ZG1hX2RhdGEpOw0KPiA+ICsJCX0NCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4g
PiArfQ0KPiANCj4gcmVnYXJkcywNCj4gTWFyYw0KPiANCj4gLS0NCj4gUGVuZ3V0cm9uaXggZS5L
LiAgICAgICAgICAgICAgICAgfCBNYXJjIEtsZWluZS1CdWRkZSAgICAgICAgICB8DQo+IEVtYmVk
ZGVkIExpbnV4ICAgICAgICAgICAgICAgICAgIHwgaHR0cHM6Ly93d3cucGVuZ3V0cm9uaXguZGUg
fA0KPiBWZXJ0cmV0dW5nIE7DvHJuYmVyZyAgICAgICAgICAgICAgfCBQaG9uZTogKzQ5LTUxMjEt
MjA2OTE3LTEyOSB8DQo+IEFtdHNnZXJpY2h0IEhpbGRlc2hlaW0sIEhSQSAyNjg2IHwgRmF4OiAg
ICs0OS01MTIxLTIwNjkxNy05ICAgfA0K

