Return-Path: <linux-spi+bounces-11299-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E53C6E079
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 11:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id A311A2D7CC
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 10:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD4B34D910;
	Wed, 19 Nov 2025 10:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kdYNhtSS"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013040.outbound.protection.outlook.com [40.107.162.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046DA2E5B27;
	Wed, 19 Nov 2025 10:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763548921; cv=fail; b=fCQp59BamVhfFUC5eK99XS33/IBTyk8Lv1u1zdzoMqrFgjIBIdru68WydBmk6EqJTO6kyxudbUToVZESAz0Vwo4bH+YbMJS5+/uxieqvmpTZRnGvknNpHyT2u6s1bdj2tKdIq1Kgf9LLC/ImSqKiWbADD43SZYQBR82/4VjiuSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763548921; c=relaxed/simple;
	bh=axeCHIhhffTirzc+h5Mmk7mKtPBc48wotNZoDDrtivA=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Ma9INakWCFZhupqZ2VyZY1Fj6QJ/8jPUIDgs8TvS64w0qK8gT21NqHPk9xBy+Z58MPy7aI8j1g98kjj07PMQy8UbZDDcjAGRam+foUXsZydRZnmJ5Tt7fan1XNXNrfH4GUP05sAm/RsWAF+jwaTZI5JMdU5He32BrQmj4Cz4hoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kdYNhtSS; arc=fail smtp.client-ip=40.107.162.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p3bLEyDWmFe5I0a7nJdYhplhLST7Q+wSr4iO0CAdTqaB3NMN77CaYJ45lMRJYXUtaRjbxta6mJTQee5ym+E4YO8K0NW1tE5lYhgHWdV+XjaiyZnRc94Luy9kVG/ahLGqNmosULhbN3tDFO59G+Exup25gEuGPzjNikhfyj6YIM7sk1Ctvkjbjws/KA3akeRHe5FX1GAPn8np6bVDpvkKgVN1mb2+XxjleP5V9xiWjGiiWWju6wmSE+kI0bLguocZwMWay8uwuaGI1pE9VHIUW3/NbO9POnAcdMggaz96WgPmK9aN1Y6cRQvfDVy7BxwUfSXsQ0fe4w8M2zGK2cAQ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3UkxLAllDVHLrCkLXIwF4M32edflEmaw7EAF9d9fNk=;
 b=YgLe4W49ccXFUlpF6+s42zhCyihd8JS5eBmLqGjeittm0x4jOgnCCMfKCpRkQp9ee7ZSo8flbQalErywJagAZUglXix0tMiBg/o4omAnsH17T2JxYsopf6spBlaIOOUkyAEh1QhKxXuU8kjnDDdeUgDmllU8X/+J89x50veyKcctP7XBn43rEqIFbCwi6Rnq6V0Q49VaOTdn1Nk9VdjjL+ghOeXACKU8/eCeM8MICSpuZdDEyURC/7Ls+e6Cxn8jpqSoE8JwkIlhOHzoxz+4RZ7c5V4E9FXvJttEGjcSjTuHS3HU42VNusg8NoRX61GFA9MivUVMrvHSKbffS18CBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3UkxLAllDVHLrCkLXIwF4M32edflEmaw7EAF9d9fNk=;
 b=kdYNhtSSrQDfCu+Ee4wF0hzQzy6KciqLLQXPyhhV/BA7LZxUggs264PP8EY6h0NPee5oETL4hjmWgOZuGl2C9FFIm0To3HTS0N9gR66fLyr7Wq894yD9FljB6/rfFjJqt45bjcBR3rxsmqX0SPZyskLLGmdh8Ae4OvIZL9GQHZ0USoIPssZ9Y1w8LwjJ7QIRRvdXySkcpHq7wajwyFb7+5bn2eCklQfRI0iCgNDaq5w9ZNLk/4nTL+sEDw5MCDdNqBZs7o57PWMXPJYtxTkw1b9CvKT4P7Csjm2ssWswmsoBsJSHrrl4nR8OedfVBmu9dy3x63HWizQnn//nDrLuvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by VI1PR04MB7070.eurprd04.prod.outlook.com (2603:10a6:800:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 10:41:55 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 10:41:55 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v4 0/2] Add support for NXP XSPI
Date: Wed, 19 Nov 2025 18:42:27 +0800
Message-Id: <20251119-xspi-v4-0-a451afbccf33@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABOfHWkC/1XOTQ7CIBCG4asY1mIYoKW48h7GBdKpZWHbgCE1T
 e/u9GdRl9+E5w0TSxgDJnY9TSxiDin0HQ19PjHfuu6FPNS0mRSyACErPqYhcNd44cCgNaJi9HS
 I2IRxzdwftNuQPn38rtUMy3ULgNBbIAMXHAoKauNq1OLWjcPF92+28CwPBMxOJBEsC1BSWasa/
 CfqSPZvZkWkrJWz8Cwrbw5knucfNsp4E/wAAAA=
X-Change-ID: 20251028-xspi-afc0a17e9708
To: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, frank.li@nxp.com
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Haibo Chen <haibo.chen@nxp.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763548973; l=3265;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=axeCHIhhffTirzc+h5Mmk7mKtPBc48wotNZoDDrtivA=;
 b=9yheXfqTHSyOWtYAiiYdEyCE7derZx6NqPieAlIqpRZ1kIoz+K1hG6b1OHLwma7NN1BgbL+++
 mm47Q3bz9fJB40tkyR6ghFqVzITm130IyuuTmKjKOsj9XxqaztyduHf
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|VI1PR04MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bb3a64b-3800-4abc-eadb-08de275841dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZXhBVWVLbTNJcmNwTGw3d0p3MzBZdzBWbjRwZDJ4MllleU5QdmlnK0lPcDRt?=
 =?utf-8?B?U01PYTdwSkI5M2RDdGpEYm9TaGVPa0duLzJFZnp1dXZsbjZjeVVIb0hLWjFL?=
 =?utf-8?B?NWp5TklqNDNuVXVKSEswVmZVNVNILzBRSnZPQlBSQW8rYVNXY1M2dGV6bW9O?=
 =?utf-8?B?Z0ZGZ2JMMlZXTGk2NmIzcy9FWXhPVUlZTHhuY01OUUVhUFR0VkpyLzIzdlM5?=
 =?utf-8?B?dkJlL2xkSWl6cGdhVTNNVDFNRExTaGJYSmhRbk84ZEoxM1BaR2UxRTNRS2pk?=
 =?utf-8?B?QmdGU1ZPNUhhR0g2WkVoNzhFQ29FNlJSS1ZMWWZEQk5OWkRWTXZTQTUrZzRn?=
 =?utf-8?B?SFpPRm5NK2llRkxTSjNwSHQzQk8xNTRCSTNCYjMrYTVibmxscVNRUElSM3Uz?=
 =?utf-8?B?N1hvY3JiTnhxenlRaGU0NnViMjdQRHpyeml6aWtvTXVNZnVTbXoyNkVYUkxF?=
 =?utf-8?B?UUNlNTNpdGptcDhmVlFjUXF2M01mKzBUallMdEZZaWlmU1lJR29wWnJzTTly?=
 =?utf-8?B?cVpFelJYUEdHZWp5RzhvN0NuV2dRVDl1d1d6aTNWYXVKTndzNlF5MnE2MGNq?=
 =?utf-8?B?V29FaDRxdWhuVXR4QjlPd3FiTFlFLzNLUGZ6SGlJSG1yQ0dBWStpTGEybzFy?=
 =?utf-8?B?cDVGS3B0VzQ5NjUvZnNJK1lncTlCVUNOWDFwTXl0citBQ1RTNkljcFcwZ3Ay?=
 =?utf-8?B?TlZFQmo2T2NGUXBndWZQTEI2NFE3dkczSWVpRlhXY0hKbm5FbTNCeDdiaXhv?=
 =?utf-8?B?eVl2TkdmMVRDQWJteDlOSzFNdkhMVTJjRCtKV2pxbmtFTVkyLytDTEN2MThw?=
 =?utf-8?B?UndxZ1NWUE41aTM1T2FDbzJvalY0WURWbElxRWJvaFk0d1RWMHpQY2tWb0k5?=
 =?utf-8?B?b0o3RnFsd3p0UWlTLzZNYUZFTHhpWnpWVDBZV2lsVjYyOW9SRE5GaHRtZEE4?=
 =?utf-8?B?c1ZZMkZQOWx5TUQ2bkN2bXVlU1Ard2VPVk9kd0VWKzlXOGZoeVdHUkpYQnZK?=
 =?utf-8?B?VkM3ankxcWhFcHpUMmdTZ0JDeWoyeGF3am16c1N6d1IrMGZqV2hLNEpXVHk3?=
 =?utf-8?B?UFdNbjRFMitNaUZTU0dxNVUrUW9OeisvYllaakJuM0FTZHJSV1d0ZkhzdVVn?=
 =?utf-8?B?TXM5WUlMWks2U0k5WTJUYzYvc3VMcGxzcHdJRCtCNW5WNGIrVmdWUHBWMW9u?=
 =?utf-8?B?YmZ4dE1ZMFR1akpUSFFVaFpBcXgvNkpUMGJWYVRGdUYyVTZpVXdXWGJhNHNH?=
 =?utf-8?B?d0F5Z2RkaXQxOG5kbGNEMXA2ZUNnQmM0TGozOWNSOC9OWnRSNkpTUTFXV05C?=
 =?utf-8?B?ZlYzUzN0OHNJRUN2WnYrWXZFcE5hYnJhL3B0STFKeWhYYmU1WDF1bWRhcFZw?=
 =?utf-8?B?b29QUUVIRjFlbHZodDdrVzk0ZzZFNkhyNVhHbmVMRWZtRVBGQ3JldTcxd2pO?=
 =?utf-8?B?ZC96R1hjMjNTelcxMWVESmN6Y2hFaVpDZHVqYTBCWXA3M0NNK3Z0RzFsQXBw?=
 =?utf-8?B?QlIwTzZpbzVCN2Q1b29WNklOcVFERFRSZy9oRVRBMHlZRmpyT2NMdlEwalR2?=
 =?utf-8?B?OXluVVFyb2pCNEQ0VGZjRXVaY0FSTXBLY3hsVjNMelRSN0NrOFIxajc3aG41?=
 =?utf-8?B?SHB1bitzNmdkMHVVbjZXdEQrZ08yU2V1SThDeSsxVGJBUWJ2NXdZVjY0L1VZ?=
 =?utf-8?B?akVraXROK2JmYUlYeUdsdG5tREgwaTF4T1ZZc1BKUGdxeU9VUGlmTndqTXhr?=
 =?utf-8?B?ek8xN25iT2VuenN2K2hjNXF1SkR5VCsxSi9hMFNyQXY5cTJ1T2RXTmNOVmNl?=
 =?utf-8?B?amhPQ3hvT3VGWTE0aGJxNTdxR2hPcTZIbHBLcS9JNW9QV01IaUE3TmVOOFl3?=
 =?utf-8?B?VlJrZWJaUThDQWdxOUdOemxrQVFwZVJ4RVdCRlRESDlMMlNsd3FMQmVEMDBa?=
 =?utf-8?B?YUFVYmxrd2lUNHdWZkk0cFZsZnhyU0RrTjlEZ296OEVqaE02RnF0Zktyb0RX?=
 =?utf-8?B?WXBwVTVtVm82d3djU1JZbWhsaUZGMiszUkdzbUR2R2Z3eHlWMCtCR1VIdFVu?=
 =?utf-8?B?aE1Jb0VSY0RiOHF6dVpEbmFXODVFSEl2Ukd2LzU5Y21wb3lJREJ3d3IzWTll?=
 =?utf-8?Q?SzdI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXR1UWRsemtIWU9EYSsram9hVStUSVVYY0l0WkZEODhDVWc1ZGZmaXdKcExl?=
 =?utf-8?B?WWorS3Z1VFJoWGl1dE05WmpTRHI3T096SzhTclA3SDREZFZDV1l5ZEoyaGlt?=
 =?utf-8?B?aHlMTFowRmxMMGE0VUVUSWhrVTA0enZSU3BUSmUrOXhPMytYc0ZxZ0hqMWs3?=
 =?utf-8?B?MXhKNDBCUUdRcTNKdnR4alBzZTVHVjNqWVFFRVQ3ZzVudVdsb1UzcmJyZThJ?=
 =?utf-8?B?c2tQTW5oOTFsL1F5SWhsajFaWVk5VUN6MllQUUhKOEMyNys1bmhPUTRGOTJ1?=
 =?utf-8?B?aGFsMTJvRnUzeE5FUFNDRVg4TEZiTm90eVA5Nnp1UUZIMTJLMXk0UnFHemRU?=
 =?utf-8?B?NnRubU5MbnU3VS9tZm9IZHhxT05QeHBESGhPK2tqMm5XOENLay95NE9PZXFV?=
 =?utf-8?B?c0dQOVZJUFNsVm5kY214Vzl1YitCRUsrbWJYN1RWODFNMTRWMXIwOFZLcG03?=
 =?utf-8?B?eXZBSStycGxyWkQ5TlN5UDR2cWEzZEdWdm9iQ2pUUUhaVVR0OTlMWFhBdkR5?=
 =?utf-8?B?ZWwvZ3EzV3Y1cEcycHJqZElKNklLb0t3cUFLREVnS1BhaXRDVnVTMWNrVkpT?=
 =?utf-8?B?S3pZRHd4TWRWS2ZONmVKWXYzcUd6UnR1NURIblhCbVo3RS9ZOHZmNU9iejNR?=
 =?utf-8?B?Q1o0RHA2L1l1citwVSs4VEI3bHlWaUkwRHBjYVZlcURuWHdhM1drck0yU1N4?=
 =?utf-8?B?dzV1Z2ovTVA3dDNvZzdPRTJaNjdSM3pXY0l3SDZDbVljNGRVMjA1c3JNN25u?=
 =?utf-8?B?eTBhNHdvcGhpNFJiZklvZnczT2dkc3lTMldWVTV1UWZYUUxQWXlXOVJ3R3ZY?=
 =?utf-8?B?Wk5XN09NZ2lyTTlzeU5GcGIxL0V0MHN5Mm5OejNUWGpRcFR2QTF6VzVuSkgx?=
 =?utf-8?B?UEszelY0UTRQUEMyVC9vRDNQTDllRHRFOGZMR0FjRkRjbzBVR3VDQndGYys4?=
 =?utf-8?B?WDNTcEVMaW9FN1l1U2NXOU93VmllS1V0L2ovTU5FbHgrcURCS2praUVTY2VD?=
 =?utf-8?B?TGRiOGFYVWZPd0xzbkVJZlJRNU04NFByS2NrVDVGa3VMb1B1V2Q1dHVlWW1t?=
 =?utf-8?B?bWpmM2hJVnV5VzVPNWIxQUxnZ3A2MDFPZjllRklGZml3dDhMVlU1eTVEckFJ?=
 =?utf-8?B?YWd6cjdrdmswWVFVeWVodjlpcmh3VkQrMXpyUXkwZHdmbDhVczlncG0wdTdw?=
 =?utf-8?B?dEZoVm96MTRSbWN0OGdZQWlQUnNUeWt5M3E3TElhRDJJbDBIdkxibDlRR1V0?=
 =?utf-8?B?bHhFS055NVRDaGlDVTlBaWVMUjBRTVpCTk81RkpscTJSOW9ONHQ1NzQxNmkw?=
 =?utf-8?B?OGtUMU1rVkxhZUI0Y3lMWGJFYTJJM1A5ZXJrMHdab3BqWHZhN29yVUk4aS9k?=
 =?utf-8?B?Y0xSY3JiNTVWZlBJYjY4RVdnRjMzOXlGeUxGZmpWV01uRlVQaU5JRWpYbndW?=
 =?utf-8?B?NzhHcVNPRjRTdTA3NEJkck91REc1UUZIdDRRV29LZE5KWmZZUk9ULzloSUJW?=
 =?utf-8?B?NUk3NUFPTnRGWjJaUDJHc0dkR2tRdGlqWUpLOFk0a08zR1RVdlVrR0pHSjY1?=
 =?utf-8?B?aHRkS2dISE02NiswZmlsWXFUMEpEWE9IaElzUFRUSGNwSVNLdlNNOXRWcFJF?=
 =?utf-8?B?T0h5Q2xlTHlQbXlyUHF6b094UytHYUZqdytMNzhKQXhkbGVGWVU2OWd2a3VH?=
 =?utf-8?B?M2pvVHVXYW9jZStobTVjb3I1SkVNcHdwcE03aFFOZGFoR08xa2dRQUg3SXk2?=
 =?utf-8?B?QkVMVE1wdkhXL1pYbWQwRXhJQ1Y1YjY1T1FVUklsMEdZRDVMRTRXRTRnUCtt?=
 =?utf-8?B?eWpPYTE5WjVSMEFkWDI0Z013a0x3TmVrVzFKYXREYndDWnFhVGJoOGQ5ZlBI?=
 =?utf-8?B?YTlxTmZ5bUw3QnJNZ2I3ZXJLcndPZmJYa25XTW1zZ1pSNlNjKzRjMXpKUDV6?=
 =?utf-8?B?dGpPSkMrZDZ4ZXlUemo2ck42Z3BDZmJrRnZlOHV0QWkyT1hNREtiS0tEVlRn?=
 =?utf-8?B?SmhHTjVFZFN1WExFeFdnM2tWcHloaEF5ODRMQlRIc09WRHRMejhqZEt3Smxy?=
 =?utf-8?B?bmhpcW5lNDdyK1Erd2RKR3gzMnJjMTNCNGhybmVuZkdJZU5Gd0lFOUNUa1lj?=
 =?utf-8?Q?xVGD1Qsst+GiWXJY28iARiJ1F?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb3a64b-3800-4abc-eadb-08de275841dc
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 10:41:55.1533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xMF5lHvNFCbNN5YRHFLwrZ546pPX5fqOyJs650nCAnQrrGLzHnKuclVrYLo78ypv5y6q1UZGfULjS2oaX/COiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7070

XSPI is a flexible SPI host controller which supports up to
2 external devices (2 CS). It support Single/Dual/Quad/Octal
mode data transfer.

The difference between XSPI and Flexspi is XSPI support
multiple independent execution environments (EENVs) for HW
virtualization with some limitations. Each EENV has its own
interrupt and its own set of programming registers that exists
in a specific offset range in the XSPI memory map.
The main environment (EENV0) address space contains all of the
registers for controlling EENV0 plus all of the general XSPI
control and programming registers. The register mnemonics for
the user environments (EENV1 to EENV4) have "_SUB_n" appended
to the mnemonic for the corresponding main-environment register.

Current driver based on EENV0, which means system already give
EENV0 right to linux.

This driver use SPI memory interface of the SPI framework to issue
flash memory operations. Tested this driver with mtd_debug and
UBIFS on NXP i.MX943 EVK board which has one MT35XU512ABA spi nor
flash. NOw this driver has the following key features:
- Support up to OCT DDR mode
- Support AHB read
- Support IP read and IP write
- Support two CS

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
Changes in v4:
- PATCH 2: add changes according to Frank's comments:
           - rename XSPI_RPM_TIMEOUT to XSPI_RPM_TIMEOUT_MS
	   - rename POLL_TOUT to POLL_TOUT_US
	   - return IRQ_NONE directlly
	   - use min_t() to replace min()
	   - use the new macros PM_RUNTIME_ACQUIRE_AUTOSUSPEND and
	     PM_RUNTIME_ACQUIRE_ERR in nxp_xspi_exec_op() and nxp_xspi_probe()
	   - refine nxp_xspi_cleanup()
	   - use devm_pm_runtime_enable()
- Link to v3: https://lore.kernel.org/r/20251118-xspi-v3-0-6d3a91b68c7e@nxp.com

Changes in v3:
- PATCH 1: fix the messed ordering in MAINTAINERS, add Krzysztof's ack
- PATCH 2: fix some typo, and add IRQ_NONE in nxp_xspi_irq_handler()
	   also add {} for else when the if has {}
- Link to v2: https://lore.kernel.org/r/20251117-xspi-v2-0-e651323993fe@nxp.com

Changes in v2:
- PATCH 1: re-name the yaml file, and correct the compatible string and reg in the example to pass binding check.
- PATCH 2: involve changes according to Frank's comments 
           - use GENMASK and FIELD_PREP
           - remove little endian, use readl/writel/read_poll_timeout directly
	   - use fsleep instead of udelay
	   - remove pm_runtime_mark_last_busy()
	   - keep one style to use up case
	   - use SYSTEM_SLEEP_PM_OPS/RUNTIME_PM_OPS
- Link to v1: https://lore.kernel.org/r/20251104-xspi-v1-0-1502847ade40@nxp.com

---
Haibo Chen (2):
      dt-bindings: spi: Document imx94 xspi
      spi: add driver for NXP XSPI controller

 .../devicetree/bindings/spi/nxp,imx94-xspi.yaml    |   88 ++
 MAINTAINERS                                        |    9 +
 drivers/spi/Kconfig                                |   10 +
 drivers/spi/Makefile                               |    1 +
 drivers/spi/spi-nxp-xspi.c                         | 1357 ++++++++++++++++++++
 5 files changed, 1465 insertions(+)
---
base-commit: fe4d0dea039f2befb93f27569593ec209843b0f5
change-id: 20251028-xspi-afc0a17e9708

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>


