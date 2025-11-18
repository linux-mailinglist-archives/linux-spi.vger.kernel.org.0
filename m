Return-Path: <linux-spi+bounces-11268-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EE9C6728E
	for <lists+linux-spi@lfdr.de>; Tue, 18 Nov 2025 04:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 7AA5129E58
	for <lists+linux-spi@lfdr.de>; Tue, 18 Nov 2025 03:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199B5329389;
	Tue, 18 Nov 2025 03:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mN6f3ug8"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013058.outbound.protection.outlook.com [52.101.72.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E494A316914;
	Tue, 18 Nov 2025 03:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763436838; cv=fail; b=cJB6um4FkjLFdr1FklPk5rHrHJ8lZjkeBytRp4FV41nPEAzWTeh5pXjAud0A9Qzz8UAj6y1i3rY6epjEIdnm7AOmaJQ4hMyLpCmybK/bHwxkU1efN4fxSYi9Ay9l6wWQnYO3X2SY/PEOr1ISNP9ZPaa+J7j1YifXLH3viOdJ42M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763436838; c=relaxed/simple;
	bh=b+IE4Lz7ea29IUFS5vsVJsFW24OXuYTNix2PFwzrFZk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=mraPbBmbJzKhsLBeRG53cVJzuOVu7Qtt5b/WN9qswo2lwlzA+WYj4pEgGDN8CHG2gnXdA8HiB8gl5o7jd1HTqo1Wri9jIIoWqoEyp9EBqC9QZ5qlKV5T8k+mZ2pBtGoBHgCcwB95/gf0C9a+FseDj9LfZWQVJVBHYWwYyPVwz2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mN6f3ug8; arc=fail smtp.client-ip=52.101.72.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hyebnYfTgSly5hSBJ89t/FaG2HuNInBOtRS7+MwM2lPH9f0KKHmFL9byvJZzfEr1VDZiexZAjdThdE6rGyMX/Wnf27+SIfQLOgSC2yor2TdUL34tyC78KCnKcst/6JJ0Aeb4+uLA977sfhmChjwTSvDDKKZyZYRUAUwXzJg0iUSpEY1uuevkZ4gXH7TPYxexShQE62hlGDAQh2ATLeKHgnsTG/r1LvI4kFB2fqbEhbsq2QKL0VJoadSeSgCKiwfW+8nwFLXfbBFYJgKn+a2skqCtF8kvZN7CtFhGeE7jAlavg8sp/82OFVg6DEg9vVwOeY+DHsntFi6uNP+tV5AP0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1QOdbJ7lK7FmSotUJBeGv7p/ueqD0LSkIM4VIy3uGA=;
 b=Wxt/ZYvjCt/HzQPTeKScsTh4YY06FzJ4cBfH9bXGC4bM/V3nLOq5qHcHwhLlDU1XvE7yyVGpU333eU0gm/7ISPtdNWyKegn6T9kUWRSxNjBXWQL6PHMv/SrQF1rynH1QzRraNSQGXmGwgSA4u8bMHP20N0lRY54VehzxCzO/GoVWCV2pJwqvXCAhWHYMmarQWjQfv6cwwlRG04DXyBWxVwfqT5iI/zdsHbZAAo/qX3cgIvfzyG9ekCxgNO9W8uNplCws86tHpGoj1BDsh6AslG943L7yKwPaNMOm+HCy1wsgDgmauFQ+79FzmymZgrfn0ya22IuYiQnK9yX57whvxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1QOdbJ7lK7FmSotUJBeGv7p/ueqD0LSkIM4VIy3uGA=;
 b=mN6f3ug8h01d9wYNai9pYpHMQMCqlZpAhO3gpiAzNCMetWL73/eiFIMVc/utZHVKBm3E4aC3k3bfyhlhdKCTZUMzBSnIzS19d91Yl7TX6Y+yCmtdSJcpK7KakkZc0BTvpUyfGywa5yu68G7OQHnVGbKVqmkKOOHEa6/7QSJGoJNU2rbbuqOTiYuVDIenzzMsGo+AsfG3oCgYT5xMbt3IJJJ3VYg5t++N92+AyJ65esSpquj9Qdtx9Kj0ItoEueAwpc/91n1gh/8hoRX0fDM7fOErzntLwI2h+8f/oBoz2WUViPL/m4ugF5N4r7YBK2H9cKyNJsz50pBQdJPEMrPqiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DU4PR04MB10404.eurprd04.prod.outlook.com (2603:10a6:10:566::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Tue, 18 Nov
 2025 03:33:53 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 03:33:53 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v3 0/2] Add support for NXP XSPI
Date: Tue, 18 Nov 2025 11:34:15 +0800
Message-Id: <20251118-xspi-v3-0-6d3a91b68c7e@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADfpG2kC/02MQQ6CMBBFr0Jmbc1MCxZYeQ/jooFBZiGQ1jQYw
 t0tYKLL9/PfWyCwFw5QZwt4jhJkHBKYUwZN74YHK2kTg0ZdEOpSzWES5boGHVmuLJaQrpPnTuY
 9c7sn7iW8Rv/eq5G29QgQ5kcgkkJFRQrm1rWc43WYp3MzPmHTo/5TyH4VnRS+FGS0qSrT8U9Z1
 /UD699T88kAAAA=
X-Change-ID: 20251028-xspi-afc0a17e9708
To: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Haibo Chen <haibo.chen@nxp.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763436890; l=2738;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=b+IE4Lz7ea29IUFS5vsVJsFW24OXuYTNix2PFwzrFZk=;
 b=hKoG80dDRU3uu4rkfLsDd42fTi3TLIcdqQw6U+6XDN0ymENTqL6nupR8/hBINEKGN1ivaZyv+
 Arv6XBFyNOGA7F1JSPlK207Vr1r51k+kPGS5LoCL5tlpaCQ4LgiyDIb
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|DU4PR04MB10404:EE_
X-MS-Office365-Filtering-Correlation-Id: 358c7a36-5ee2-476e-f1d2-08de26534ba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|19092799006|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MXdSd0xub1p6RjMwL3VvblM1NHNMZER6clJpbzIydUNVdzlNSDZlNFlxcE9p?=
 =?utf-8?B?dkpKbis5NUlOT0gyVDljb0lLWVNsZ2JWTUxrb3k3TVpYZktDTlVSLzluc2Yv?=
 =?utf-8?B?OU11VXMzTXNzdUFlVFFtTkVjUHpWVit3dWR2a3FyTnhPVGs4MTc3dStNakc2?=
 =?utf-8?B?UzVpdnNmWFRCeGFvS1lTbklkOTdXaUJ2VUlTemZkQVVZcDZoM0xmWWJIVnhC?=
 =?utf-8?B?ZVhJd1ZqVGVqUWN6MzZISlIxL1o0YzFvY1hPdDUrQittdFpPRCtsa09zRHdG?=
 =?utf-8?B?Q1pYekZORmFQV2xiRk5NQ3RWdFJ5cW0vbm1qN1ZQbm93M0Z6MUJtaTIyUlJo?=
 =?utf-8?B?aFV4bCtMUmMwVVFuRWhiWHJvMFVjODFDV0Q0b1RDMWo2L2dFK2o1d3orWG1G?=
 =?utf-8?B?U0lPdmlJaks5RGdPaHJpYkw1NlFGcTNmMndLWXgrd0FaNXJGeWJkY0dnbnY3?=
 =?utf-8?B?TlB5STVBWlByVmpmWGFRVUY4cEdpK3Vid3l1Mm1YLzBYZlVGZTVlTW1BQmRC?=
 =?utf-8?B?UHU1RHRVbWo3K1BacklqRWpNdHlrUGhXbW5DN1pJWEpRQUdwZFh6djNHS20r?=
 =?utf-8?B?NGR2ZXFTSm9QaFhGS1RDTzg4cUp1ck5jWlRZVHplb2hUREEzNzJTcGNWU1pr?=
 =?utf-8?B?Z3g3MFhJUkpMMEtKQVU4eGJlTjgrbFArcUxkVHRJOG1xbU5PNHVocmZORFVr?=
 =?utf-8?B?UWVCWUFVMUdMNUlTRWl0WFZZNWxpdjlxZFdlNlZUQ1VNb0lXdnVuNHA2ckJK?=
 =?utf-8?B?RDRTeWxBOWZOems4TGpYRFVjbTJOd2lqMTNtNzRiaXlyZmI3YXVsSlpYcmto?=
 =?utf-8?B?MnBZRHNVUm9DMmxYNnNtbjZYdlFnVXg0MDUzbDg5eG5MTUdBcDd5cmxXZXZI?=
 =?utf-8?B?aDFrU0o2allBUk45WlZQOGlwU2NvLzZNTWllLzNkd1g1QnB4akkrRWcrWEd3?=
 =?utf-8?B?ei85TVcxQXQzUEhtaVNhc3NEam1SaVBRa0R2aThYWHBFVmN5WG5sOEdSbjN6?=
 =?utf-8?B?cTlacklvYUhwSVVOdzV6MGFMYk56bG9LT1JaTmpNeEdMZWxvYnhtTlphb0Jt?=
 =?utf-8?B?NlZvL3VpK09yanJSMHcxRFpsWDMxcUNocjFKaC9OUXVDd21qUkxUQWs5aVYw?=
 =?utf-8?B?NjJCL1djYmhZVUJJb2dRWXhpd0hHRG1GYUpUSGdiN1hGaUZzKzdlMlRldWNu?=
 =?utf-8?B?MzQ4b2pNTTdJZitwWUJ0SjZjdkFoeHRtTEhzY0VHS3VHaVJjNnFzNXFheHhR?=
 =?utf-8?B?WXJwczBBUUtBMDZMNHAza3hoVWIwTTI4R2EvbGhSeU5HeFlHRHhrRTl1ZE9v?=
 =?utf-8?B?R2dpeEw0ci9STzY0TFBCcHh3V05yak5FUFpJQ3JQRG9CaDhwRE93cG9NRGRS?=
 =?utf-8?B?VTRmWjRwRWZPZUtKekpKWXZ5eEdHWGtKVHF1RFFlL3FLb2l0akVmY0UwQ0xk?=
 =?utf-8?B?VDZnbHpKQjZsZlpYZDhmUUJIZUFxNndtdksvL09LZ1l5VEprOGNLbFVkaUJV?=
 =?utf-8?B?RlRIbEltczhid3FEejRYN2hYMlM1NTNuNEdYYmFDbkxkTlMvTEpKMEJ2SlFz?=
 =?utf-8?B?aE5ITWt1S1BYMXhDTElyWFdoSmJtQjA2Z2c5Q1FyempiNjZJekF3RDJwMlZF?=
 =?utf-8?B?aWhZVEVOeFZ1alhmS3F3QWpRT203Zm5wZS9yNUFOeitZUHRXRE1aQVVkMnRN?=
 =?utf-8?B?Mmprb1FOZXJVYTlTR1NtSnRBNUZmdjJtZjBHcUhOS2pBakRuM0lIbGtjdkQr?=
 =?utf-8?B?WGlpMUtqOEt4QmFVQVVVZkpndWJrVTBzVy9EOFBZYm9QOXZmQmpSRmZmRFdS?=
 =?utf-8?B?SS9FVkpBVDNTUE80L3lCbWdKMVhtaWtKN1ZXb0RZbGQ1QURqWng2L0djWDRE?=
 =?utf-8?B?QTJNQ0NDUkorN3pPN0tCOWhaWjg1L0lWK1cxZm5OakhsMjc0a1FIWUMwVXR2?=
 =?utf-8?B?ZXJQMXlIVlRGd2g4V3lBWlVsVXJNbGFPQ0FpcFBrTlpFWlF4TG4xQU1LV1l5?=
 =?utf-8?B?Q1NtNDNwY0ZLbDkrRENMMDBYZVhzUEtqQThQR09PdCswcnBFRWVRYTNkWjE3?=
 =?utf-8?B?RnRyTzZ6R1RkdUxqY3ZROEJjSVRlcGhVVWRwdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGJoa0FaVW4xRS9LNTRuYmovaTB5V0Rpc1RmZC83TFZpOVhoSmRRQUNhRnl2?=
 =?utf-8?B?ZVhkQ1lONEZQRlVWdE1ocHUvMG9oN3ZJKzdEN2h6VmpZUlcyYTVuSlpJclB3?=
 =?utf-8?B?QXdxdnJxSTY3SGRwT3N3VzNuY3JaNjJUSk9nT2l1N3VKRUVaSHA1K0FNaFVE?=
 =?utf-8?B?N2hwTXdLT2dhQlpTT3FKQUVqY2pmK0dVRE40N2NQc1AzNmZwQnNlK0tHekpx?=
 =?utf-8?B?U1Y2Q1NRZUhJd3UzU2V4R284aitveUhlbzVES0lCTHR1elRTcnRHZWllY0RE?=
 =?utf-8?B?d1RFR1kwbDdFVnN1MFlmMlI0TWJhVE1GV3ZTdWoxTk1yVDlLcU1RY2ZEQTdR?=
 =?utf-8?B?RmZOdTY1WVVGV3hZOFk0Si9VRU4zeHQwTXl0NkhWejErWjFuOUFmUURnaHY3?=
 =?utf-8?B?MjZRQkZvZ2R5TE15c0RFNTRQNS9DRytaU3BjclRUMGFicjN5cFkvOC9lclU3?=
 =?utf-8?B?TVZUWnBuNi9KWW03K09jTmloUW5qK2ZYQ0tlQUJ5WkhPVTltZmNoWDRFUDUy?=
 =?utf-8?B?bkh1cmI2NzByYjlTUHB2dnpOcWtFSVg2ZmFNM3I4Ukg0WjBNeGE5UUxjR2I5?=
 =?utf-8?B?VWxzM3B0VDU3YUE2RVpBanZ3Q081NXpFTnFwNlBOTEkrZER1TWlrWjJJdTF5?=
 =?utf-8?B?aVFzaGExR2dLdU9Ga2tTTVhkRk81N2Z6SjB3Tm85eFVPcnNTZWkwWmVoR00v?=
 =?utf-8?B?Z0YzdCtNQ0pHQjZYbnRndFpyM1NZL0VIc1A5SjhTRFNiWjlIZ0xMbEh5STBE?=
 =?utf-8?B?UW5CNmFUTUU1dW9ZdmNPNWFFcGR3UXlNbnJBbnVCMmhKbTVTbWFENStZWi90?=
 =?utf-8?B?S0VRS3l4Ny9LdFY2VW9rQ0pmVkxrZUpDOWZSVnlDYTJ3U1R5SU1LNTRzclR3?=
 =?utf-8?B?NEIzeDJtU2kvLzI0djVHL2FGT0RJS0Npb2FMbEhpUC9wQ1RRb0c1b2MxcjNn?=
 =?utf-8?B?ZW5VYnY0MUUwQTI4a2h0dEh0TUFLQ1NQZ1h3Q3ZLcGVIK3MzMDEwYzBBVFFF?=
 =?utf-8?B?RFFDOHRYK2VsMG8yOUtSdHZjWHNTWHVmVTF4M25QK0dZVnFQMGNDakI2c3h2?=
 =?utf-8?B?d3dUaVJUTjcvVGN0UGdSWVkreFh0Z2FUVjdkVEh1S0ZHbFlrTEh4YVRjcTE4?=
 =?utf-8?B?c0FOZStNektZN3JSSFJJVkE1ajRmNkZteEs4QkNRY0lPMCtQWkp0by84YVUr?=
 =?utf-8?B?cUFHMFgybkUraDRmb2IwWDloZW9JZ3ROb1BHNm42My9weU5Mcm1obTBENWdw?=
 =?utf-8?B?K2VGZE9kK2NLOXZVUEJ6RVg3amgxc3RILzY0YmEzaFBqSFlURzVQOTNqTzZ0?=
 =?utf-8?B?SjN4YmJjQWl4eEFQZ0pNTE11dzRjbTFET2RYOG1pdUNRU0s0NjlMNktuOGZS?=
 =?utf-8?B?cXZLV0NrQTg5TUR1S0hQMnNRSW90RlMvZDMvOGFaR3FlL1ZWU1RwK1hORDE1?=
 =?utf-8?B?RWFCb3IxSFBSNGdIUnIzVTVWVW5lSVVJMXc5M2xubkJrVmpqZlZBcDl1QkJD?=
 =?utf-8?B?a3Y2ZGVhckluMEh0ckVUSUM4WURPc2RuTUhTNWFoQ0htbzZCRVc4QW5mdkwv?=
 =?utf-8?B?NTVaRFJzM0t6NndrVkppT0dFd2FHVU0vLzY1bU1sWDd2NlNXTXN6RkpacS9H?=
 =?utf-8?B?b0h0eVZuY1BmYTNoQVhZWFZPWVJyU2JtUUx1MnNSMWc5a0JFWlhsQTBtNWVq?=
 =?utf-8?B?SU96TVo1SGtHeExkR1VXOHpyN3NuVGxiTnk1eWdSdWVSSkI1eW1kNVBKZTdU?=
 =?utf-8?B?M201RkZGNXAyalR3VGFhTzBaMTRuTUoySDhnWE1OaEkzYkM5YzljdXBIbkJa?=
 =?utf-8?B?QUYyYnB1QXlSVXAraTFTNWNyZHQrMEFlQkVNSGZOaDRHSVM4cXVEdVdGVU9P?=
 =?utf-8?B?YUFCcjRQRGUzeGtPNTB0ZzJQNlR3ZHowMzRxRktLZ2hBYUlNV0xPSnU5cTd1?=
 =?utf-8?B?RWRRN0N5YS85RU9DQjFMckg4SEI2d3kza0orZFNwbGlNVGdiSXluaVZFak9C?=
 =?utf-8?B?RmxkMU1tTTZaWGQrZXFFNE56SmZlMmVCbmxBenRUNjZnRmZ3YTZpcHV1Tkxu?=
 =?utf-8?B?dEt0SzlLUjJGcUk5WmoxTjhHSkJzWTAvcGt4bEhxN1IyTS9MVVJIc3BnU2c5?=
 =?utf-8?Q?KYUu3UX6sZTf9CTcmeCJj06Pj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 358c7a36-5ee2-476e-f1d2-08de26534ba3
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 03:33:52.9458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xcs/Z73waPmwadkNwhEMoV7MJFLor/+tLmnPlkzUHlVaZM75EVlZiebn/Io1uKBvIICoTGNtrJcEkS7TJkCBGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10404

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
 drivers/spi/spi-nxp-xspi.c                         | 1367 ++++++++++++++++++++
 5 files changed, 1475 insertions(+)
---
base-commit: 0f2995693867bfb26197b117cd55624ddc57582f
change-id: 20251028-xspi-afc0a17e9708

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>


