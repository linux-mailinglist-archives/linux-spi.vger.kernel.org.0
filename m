Return-Path: <linux-spi+bounces-12355-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD00D1CBB8
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jan 2026 07:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E599304E171
	for <lists+linux-spi@lfdr.de>; Wed, 14 Jan 2026 06:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5955536E47D;
	Wed, 14 Jan 2026 06:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CWcDJbXl"
X-Original-To: linux-spi@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013061.outbound.protection.outlook.com [40.107.159.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B38299A81;
	Wed, 14 Jan 2026 06:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768373432; cv=fail; b=XYtPWYxS5Exg1L/4Iw18emGOIah74nmZtyd+IdFvFu2PDY7m+5RoiafOWS+z4jD4y8L97VU4kekmmJ9KLQh/XULm0ZaZTbCPZp+ap3TP2hEv0gt9qJJyGrUBQirKehyqfq4l8RPRWgoHFN6Np0KT3QSqLSI6fgtc11uM06GY+qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768373432; c=relaxed/simple;
	bh=MK9HEyM7t9e1aXf+nQ0L1GS6QNRr0Yq8FJTndbQ2c3I=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=X5dzbS42twJMlJXDzn4E5nDPXpfdY84n04Nx8WAuHql3vgZeTDr5f0chTko+ys+ELvlNeZ2FOAOfGavpnQ4plu5rsMARYW8kzXFovCZ6i4mijPBb+Zfa1sf8mZWG0xIBSq+jK1hvTdWyv+c/QRNFMA/lBWgpbLs+mufNeWshOSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CWcDJbXl; arc=fail smtp.client-ip=40.107.159.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tITzU1rC61iaofQTOtwTNoflwYY/qoeKyfsCthOEdXF97AMQ2touiMLUaOABaM/OZWCMxub1Ja9GfZIxYs5yGJ8URLfvnCEBLZ8ziJgwGmJxdobt7PXziJLBnqtbxGLXWc2D//PFfzlM9LbKPq4uv+47pzI3FKj8q5VPzWeIytaNPddz/GCfDnCHrQdY1PVc5pth65qone3MzWsv2afb7TvXtG6pFCYiR2OiW3QhoSzg1B/mh5hwgxzSupVlgp4klUikmyUA7xi6MkD9cO4o0Iysqg9nbqvDuyM3iB0mk0ebtnl6ZTh5bNQOjhwlvOGWFu9bfGgK0H4rW3CRgKcJlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYJYRVLo+Dg2rBtgykOZNFz7bbPOElbLyzV6Ea58Vf0=;
 b=jxv7poCyn8hYq3aLt3Qf3mK8TCmSN09pk5B30vNsXF9+7rdxE5BLbjzIZTqJdFKnCVKgjIfVgAyWYlEWlTRIoEvtAAM1JNwQL+Vf2kNUjLPS6D7GHalUvbGXOZW52Z1uuV0Rz+lao3RJLbXr24u5V86znMkbfFFFcdXuvcidrT/kiYGOrlNSgx2uHKwodUFD4K4wVWvbIualN2yTpBwnEdaAEFKQ4gq+3f4vV+eVqgcEQv6Qv1qj6rSmgVwgBWswKbweTHnDUCb5G9YSKUIPePXeYqbe1XqX/gZ8MaXO5/u16RLaNwMo8X32YdBusT436XVXDhKdQaWkkYY0HTFWiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYJYRVLo+Dg2rBtgykOZNFz7bbPOElbLyzV6Ea58Vf0=;
 b=CWcDJbXlf/ft2/pNfMqIhzM0IQBlzMEfQY7Jkhpxo4FpqSCiHoV4zxm6N1L+eEsHKKl0Cj223byDMn10nATtfo5OuIVP3EiV8D9Cfnomgnb2jFMdwSvAgTkgT/SviicrewA1jiSnl+EIocLtimkDSIqM29F9pcmBhGeuc2qvMJu+dXiFUFkHD1k1S/U244vR0VBwd1T0TlutKGM4lp8sKw4mmvJi21/umjVIrWqkL3cm3rEchl+xQM+shO5Xzr8t61tHma611WRMTv27ZEbG07hgsZBUHgQ9TcqZCLHmB5w/CgFFjOqgCY+2QYE7xdBnOKk4XFXmhCu4Dw1CpT6OkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AS8PR04MB8673.eurprd04.prod.outlook.com (2603:10a6:20b:428::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 06:50:14 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 06:50:14 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH 0/3] Add MT35XU01G SPI NOR flash on i.MX952-EVK board
Date: Wed, 14 Jan 2026 14:49:44 +0800
Message-Id: <20260114-xspi-imx952-v1-0-acc60a5a2a9d@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIg8Z2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQ0MT3YrigkzdzNwKS1MjXQNzExPLxNQUs6RECyWgjoKi1LTMCrBp0bG
 1tQAjUGC/XQAAAA==
X-Change-ID: 20260114-xspi-imx952-07449aed6ba8
To: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768373406; l=754;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=MK9HEyM7t9e1aXf+nQ0L1GS6QNRr0Yq8FJTndbQ2c3I=;
 b=3IVyBLP29eWUpmCH0JStgNrumMAtPrA7YRyCv7rzfck0WX/j4wuGdvO9iiYhcBBV/DGNfDknT
 Xiwa2jD/dSrAzC3I3U6Zygewjc7/yPrnaJIJc+bVa3moJuX3i50iF5r
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SGBP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::32)
 To DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|AS8PR04MB8673:EE_
X-MS-Office365-Filtering-Correlation-Id: 0091d2ef-a482-46bf-e95f-08de53392b78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enZUMU9nN2tvc0p4cGI3YXlMYndiNjFqcEZvVktkRStnSEF2ZjBsdlhzYnJz?=
 =?utf-8?B?eGJRVnJXK2JuLzkxRUo5SWVtNUZlWnZ6M1RXN0wreSsrYi8vdjBpa01GN2ZH?=
 =?utf-8?B?ODJuWnVuV3VNa2h5cFJxOUo1VUZKVGhSdUNLRi95ZDhQQTJ3eVRDbkF2aTZO?=
 =?utf-8?B?S3loYyt6bUV1bURYY01oRXpobGtETEhKRHNaMDNGUWJzM1pQSUg4OW1IZ1VF?=
 =?utf-8?B?YXFLbFRNdlo5MVlXKzdoazdUS05QUkdzMk10eUl6ZVRUUVlZWFZpK3VkdnV4?=
 =?utf-8?B?L1RZVU1ldGxraU9QMVFVUHhob2l3NTZ5NjVwWk5BcW55SDRqMnZHSVdEYytq?=
 =?utf-8?B?QXNlZmhVRU1MLzFTN1BXckJNQWt1eEk3VnNleEpya09YcFUxSFFGak5kakRN?=
 =?utf-8?B?TFpCZmJBL25ENXhWd2N0WVBQR2x2UFFOYUxVcDNqSmhmSzJrZG1mb2ZGby9k?=
 =?utf-8?B?S01yc3lQWDFIeXVlVzFjTDFvdTNnS1l4MVgybUJXNjlpNlJ0Sko4TlFKMkNS?=
 =?utf-8?B?bUZJL1M3MGdjd3VpY3NwalRpeGFvaXM5TGtnaDJudEIzS1NlRlJnQ1ZWLzdT?=
 =?utf-8?B?dHN6OWF2dHZub2pubkRCZEV3dy9HOEEzaG8vamt5TkZJU1dCeUdUbEdxby9j?=
 =?utf-8?B?UnhZdi9wTEFrZHFWOHV1RDhCVEEraXpjWHk1QnBPWXhQcmVQQm1FYklGT25L?=
 =?utf-8?B?UnpFa01hYTVIbDBydnYzaVFmTnJZdDcrMHRhaWJKS2l5b1N5bzNtTjBZcDhQ?=
 =?utf-8?B?cXd5V0EvTWVmcG00VGZ6T0ZhZGgwOFdnVEtlVjZZWUZ4SjB5MXB1cURvL3Ar?=
 =?utf-8?B?bjhsU0U2QWpYaU02amJWZGdOanJ5bVl4dlVnKzFtd2wrYy93OGZSc2JTc2Rt?=
 =?utf-8?B?Q1FrbUkrTzdmY2VUb1VaMDhMVURRNTlVNXdMdkdaWmxtS21vekpMQlFUdTJ4?=
 =?utf-8?B?by84Q1RZV1g4eXdqdHpUOFBEVjRucEhTWEFrMDdtNlV4TXlYWHJwdUhRbHJQ?=
 =?utf-8?B?T2RaZk9lU2hBVzlkK2dXdVlXN0U4akppNml2UlVGSWFYSnJGaUljcEUzd29Q?=
 =?utf-8?B?VHpsRXMvQVZ1cWVOSm9kZ3M0bXBvREJDL0huc1IzQnV2Z1YxV0FDRkFDRUl1?=
 =?utf-8?B?ODlGVjVoUERmbmgyYVJBRGYvRmZsZUlIUVdYUEVYM2VhMnBrNEFUT3JUTFNO?=
 =?utf-8?B?ZnZRakErVlpaSlUweVFqK3h3NlhlZ2YzK1hmZHA4Y283b2dVckpGeW51cGZG?=
 =?utf-8?B?SG5tcExQdDZLditJZmdFcFFOaGhRSXNJL1NPaW1DTHJtUld1aW9jMlovVDln?=
 =?utf-8?B?RjkxSStyTEFkSUJ1bUI2YkxuYUVyT0U4UUY1Vk4xTmJxZUc1ZUtKS3NxREF2?=
 =?utf-8?B?aktSejdsMW03cHpMMTJvUHN0Q1hUMGx5T0x0NGFCRzJKY05rck93djBBZzhR?=
 =?utf-8?B?Q1QxaG5xVEwrelFJS3VIMlRrcll6elNIZVlTSmpIL1BMN2xoZXdjb1FWcXBH?=
 =?utf-8?B?R1haSTIvVUh6c1VrbURWb3lHTktySDRaUDBlZDZZcU9MeEdxRWswdlAxQ05k?=
 =?utf-8?B?RmNEejREMHc5UnpBcVFiS2NVMXA3VnZlSzdTcUwxOXBjc0pxOGZ6U1B0WHpD?=
 =?utf-8?B?Y2l4RUEwUktwT2hoMGZiNHBLc1VqUGRKbFNFZWZ2OE5YbU9JM1Y5MHJJNjho?=
 =?utf-8?B?cytnWjZBYzA0Y0RVWEFSM2Fqek85R1ZRa0V0MkV6bE1na0RTSlZiVXZpTjFj?=
 =?utf-8?B?M0lRUnUzUU85WHF5ekNJZjBiZ3V0OG9XeEtPeUUvREh6ZGdCMVR1VE9PUU1J?=
 =?utf-8?B?WWR5Sk1mZGE5RkY2bEt0bmlId1Zrcld0a2gzbDJLanlmZUN0dllBTE9tV3lB?=
 =?utf-8?B?M2VhL1dtd1gzSDU0cFA1Wit4Ykc4RmxZc3liT2piVUFIRE1DUkVjaW50Y1kw?=
 =?utf-8?B?T0lucXh0ZFNrb1BXcFo1RmJkdDFrc0NJNVRhVnJWODdtdjZEWGtyME5PTmYv?=
 =?utf-8?B?OVI1d2E4UHY0UnFuY2dGY05oZi9NeVc4anJydC9LL0ZMUSttUEUwTzVnbURD?=
 =?utf-8?Q?QPOGeQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tk9udlNQUk5nK25paUVrRW1ZZjAxZTc4WnJBbk9pMFdBNVA1WCtkVFdYNGt1?=
 =?utf-8?B?ano2Y1JRUU4zaWk2dERpdXlTTXNhYXQ2aUtDampOemVsaFYxRjN0YTlWVTQ5?=
 =?utf-8?B?VzVSWXhpbHBnUVZqQTFlQktINmpZWDQrY3dNN2xVcGFzdHV0VDdvcnlBczhn?=
 =?utf-8?B?SjErcStxbEZmOS9YRlpkNGIvYUVta3ZGRzdRTG00Tmc5ZUlFZm8rc1A5Ny81?=
 =?utf-8?B?ZFlyYks0cExQdVRSS1hYZmF5bXFyUWZzb1dQQUpJNDRrcSsxUEcydi9lUldB?=
 =?utf-8?B?aWFqUy9saThlbVlrSzlzWENsT1craWY2VmF4dnY3djU0SjkrNHk1ejg1VHFP?=
 =?utf-8?B?RVA0MmJjRytmZ1RwdTJOaHVEOWtOVFJBYUQvQXlrR3VjamFvYVJlWWFrbkdI?=
 =?utf-8?B?d1JXLzBtK1o3UkZzeHFUeGlLb0ZiVE9JdmpuYnhna2Z3ZGV1OEQ0MVRDdDhT?=
 =?utf-8?B?bldPSTB0SHdtSUl2andCRjdGRUJwMzh2aE1wdGsxUFd5RnUrR252MmxIZnhH?=
 =?utf-8?B?bklXdTJUb0RWSXFtZU9xSVFha3RJQkQxZUpvSUJIVXd0dTEzWEl1djhQaWpl?=
 =?utf-8?B?aERZM2ttY3IxYzg3K1J0aEptS2FSWW5ON3hIR1ZFczlSYTNZRjFyYktrMmZj?=
 =?utf-8?B?ZVNsd3cwWXdxOUlpOWg3Zisxakd4eFNSR3Q2bnRNVWlVRjZaRi9NdTMrMkhl?=
 =?utf-8?B?UDRXUXQ2RnhsditjaUNBd1dOQU4rcEJvV25ROHB0TEtQbjNQZVFpVHpSaE0x?=
 =?utf-8?B?QTZOR3ozQnMzSmppd3pQMTVIR1prTXJpNWJJcjh3M1hoeGdYWXpaa25tUG5L?=
 =?utf-8?B?RHE1cGJRY045VURtQWE3YlZvWFFSWEVTcXlvWTRBOUNLNnB3MVF3RXZOSkp5?=
 =?utf-8?B?dlVOL1AwZXl1cXBhdUFWTno0NkNBYlRaUVdRandFRHJRbEZxblNGbzdqNUJU?=
 =?utf-8?B?d1N6VHBwVEJZNEdDeThZS1VhcHQ4Yms4S1pjbHc3NHNzaDZtOVhlOXN4U1o4?=
 =?utf-8?B?UFg2T0tuN2lzQ1FOSHpnSjgzbW5pSGlrZUJ1TTQ3cU1rZnVGTktCeFhxSVg3?=
 =?utf-8?B?YXVpakdLTkdPS292TjkvSldoOVgzdzM0ek04WVZUY2lXVVZDMzRMK21uTWZj?=
 =?utf-8?B?My96T2c0VzdCUnJBdERMOFd4WE9rbE9neCtVaDBwa29iN1diRk5vMzRsVitM?=
 =?utf-8?B?VitCOU5JRjFmWVdsY215NUZWQXV5Q1FXczVNV1VGT3FXeXBib2JhN1BERjlU?=
 =?utf-8?B?ejlsM3JZdHJTMTltR3lWdFJKOWgzWnF5MG5DOUUrN21WVUZIUGJHdmtqL0hw?=
 =?utf-8?B?OFV4b1I1Q1R1R1JXVjY5SVIxN1UrWWM3WXZaNy8zaWtKaFVtL1pWNXN5WHNG?=
 =?utf-8?B?c0VTSGNLS2ZyZFhNclJHSXNRV0dyajFGSUYrTHhmNUExZmxFZzV1cWRsZWlJ?=
 =?utf-8?B?TllGdjByYVNpT3NmTEFYUlkxZGJnSlhtK0J4a200UGs1Q0V4Zzd1dWROSDVK?=
 =?utf-8?B?RW1nMjJScEhuYlNUWWl5cFlzaHlyOTRuS2EvM2UvdlRmd3llNmZEYkV0WDZN?=
 =?utf-8?B?ZmM5OVg2R011VnRTMzg0OW1CV2c0RjdYdW9RK3h6eHpYZ1hkTTRXNHhMdWx0?=
 =?utf-8?B?WDBscHpkQnFNdE8wWk9qZ1NNRlA3N3ZHRWxlV0s2NVRKMFhHOTlycGxXT2lK?=
 =?utf-8?B?cnQzaE9yTkR0Z2VQYzR1MjE3ZXhiSi9iR0NBWVFIYy9GZFZsNkU5eXpodlZV?=
 =?utf-8?B?ZDFSNkt0VTdhNVc5NDRkZEJOcVB6d2NjSzRWT29qUG5zU2RhWWpGK1g5MDRo?=
 =?utf-8?B?LzZMS0tMc3RoYTlibzE4S25CbEswdm9aUklxdUY1M1BTK2h3V0xrQUdoMGlO?=
 =?utf-8?B?UUVyVVZYNE5PY0Uvd0RQTnA1RERna1VRdFp0dWpSR0FpT21IQXhNZjlpMWFG?=
 =?utf-8?B?VG9PODM1cEFCSm1RbGNldWx3YzVpM3RyK0paV2tXaG03MC9YRnA5eVdiUTcx?=
 =?utf-8?B?OVQrNGhMZEhyeHdLemszU2hhZy9wRFNsbWZ4dnlrMk1aTlJHeVVLQ2Jlamk5?=
 =?utf-8?B?cXdXcnFQaDFEem9GbGhOU08yRFRPVUFkenZmOGpjTkJPQzVTYU1EZDlqOW5G?=
 =?utf-8?B?TnRPYVZ4MDlBWkpXUzlsTURxa3RNMUFHTGxpQmZQWTdwT1ROSmFmazFNRkFF?=
 =?utf-8?B?U0I2dlhZcCt2SjRTNmY5NnpjTFZaMG1VOVdRdURtckY5QW5URkZvOG1MK1Z1?=
 =?utf-8?B?M0JlRmdtOHdaSHVqT2tCNWVnOStkUzEzVlVBQVZrbmZIQ2EycDd3dllFNjR6?=
 =?utf-8?B?ajNUTkFCWk82M1Q2OTF3eWtQb0NnT1BGRzhFVFlSNzdEZXY0K29tUT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0091d2ef-a482-46bf-e95f-08de53392b78
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 06:50:14.3528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0HKXA/LfNxrOsLKtb+/3CMPS7QW2UopEyv9+YRQehGTBAcv0/kqOwQB+EbM3VUTymi9/10Sp3zqeewuNZ4FUFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8673

on i.MX952 EVK board, there is MT35XU01G SPI NOR, i.MX952 control
this nor device through XSPI controller. 

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
Haibo Chen (3):
      spi: dt-bindings: nxp,imx94-xspi: add nxp,imx952-xspi
      arm64: dts: imx952: Add xspi node
      arm64: dts: imx952-evk: add MT35XU01G spi nor flash

 .../devicetree/bindings/spi/nxp,imx94-xspi.yaml    |  4 +++
 arch/arm64/boot/dts/freescale/imx952-evk.dts       | 41 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx952.dtsi          | 19 ++++++++++
 3 files changed, 64 insertions(+)
---
base-commit: 0f853ca2a798ead9d24d39cad99b0966815c582a
change-id: 20260114-xspi-imx952-07449aed6ba8

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>


