Return-Path: <linux-spi+bounces-11301-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D61C6E0A6
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 11:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C13063861DF
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 10:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BFC34B69B;
	Wed, 19 Nov 2025 10:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TvheNvFD"
X-Original-To: linux-spi@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013052.outbound.protection.outlook.com [40.107.159.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C0133CE8C;
	Wed, 19 Nov 2025 10:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763549000; cv=fail; b=Eea/Hu8VAvMK2qk4AOL0M7IQPKFZ0hd57aDayWLaZ3XxN5l2yVtlO+NW7LKjywatSa36546oDhzoMsWZ/IdU/lJczXS9vVp/45hf+zFCh7bdUaYz5+jfrHrIJAxSqRtd6Bzot10xoLZSCLWNu9fdD4x4hwnec1HTzA2gS93QZsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763549000; c=relaxed/simple;
	bh=DyzDhhUAkg1KIRDzUSzmcu5RPQ0rKpxlHOLEvNBGNVA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cH4xVeJhJL10VLVnDE4meKNuHP5bhYoT1anExlikL/YQzIJuJz+zyQ8uDGrlOhzXFj3NHlydciZv1rmPT+Zd8jw1M8twcBXFT0+o8FmCH+1PrJNuk/SLRKWEXSKChi0qONzUQkfjl+wyC3RmvChnRX5MV6dU33eMbHeokapxmyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TvheNvFD; arc=fail smtp.client-ip=40.107.159.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQ67wZrSUE7zFzlz4vCVrmZKkcjJig8vZCk3r798eRH2Y54KVzcBji5GdPxlyD86aWGY4ctq0IPyfzac3vcEAuqw8MoJtu3LoPuN6WQY2vDJ25uIoo4kfQ1hN1LH1hopxqOTs9LRXVEjXkQkOJ/+FxrK1MkVracUyF1/Gkp3DlBM+uTBHeGtURDzwG7S8hEQXPwUjKwSSWHrl3RxYOVddXS6wTg31k7PBeUQpLFKqgwkAYjDuUSwDDzCTbxlQlSoffJ7j8RNGKG/HQs+IMxotgK9zsBHS7WhLHIpQUEGqCLF9NsySm43lSNkClzUZTSXT+ZbIpEzGaCpyZdhZSA4NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkM7snniHvjEFlCP4bNLsunSDAgaVJ4y7Ljqcp58nb8=;
 b=bCPT7qjT961GxQQ5YuqGEj9zKEfJwB9PjY7NJ6dptzSLi5qRuDqFlWwnuvyOGdL/UddmfG83caEfUM7uBugtYWa/gG5uLPKT3gLpXDYpKqSL0b6jKGMnSsoKxUZNk7LX5hYPSMfU+vqfGHW/xXqZmgn5dOQWAfsbn/mjUETXwF6FsvHub+ifVn4pvnemoDFirkpNq2CtnyzYyRIKlgko9oHxf/R45d9ZmtRIK8mfWStsUfmkF/BzZq+Ihsq9XXZ4LtM2y556WD535B4E5sZqD7N7YR0F9JsmvqzMtnNIPNrka7uC8HLlopMNxJWeM2jUL8SBX6nTR++pwfgk1WLHfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OkM7snniHvjEFlCP4bNLsunSDAgaVJ4y7Ljqcp58nb8=;
 b=TvheNvFDxK7K3uno5h6dGn70BlgdKC72YLOngz3eVknNkWliFgEihi2D97rgfR9dNUvTjCvSh/7tvotdYojpXBJx6D4fh9viru/DdXY+QTjvpHxBi+3SEFY00BM/Dv1SwpOiCqej7RDov++msUsCCst3iiHjFMz+ZX5WTM9BowLyUmulk9WjLpex+++zfrHoV9R82/Sc4MeSco4DSoVAVLfcljUJsMmYgAWMjXMWPjRX9gN8lA3UVnBsQR0CaRxErRCJWmJ7hcIrBHyD2aMGnG+7N9TmeG54OPwH1Sv75HY3G6cQ4HJCOTZQh90Gg3lIZ19AKz6FfU+jxqA+jO0uFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by VI1PR04MB7070.eurprd04.prod.outlook.com (2603:10a6:800:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 10:42:00 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 10:42:00 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Wed, 19 Nov 2025 18:42:28 +0800
Subject: [PATCH v4 1/2] dt-bindings: spi: Document imx94 xspi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-xspi-v4-1-a451afbccf33@nxp.com>
References: <20251119-xspi-v4-0-a451afbccf33@nxp.com>
In-Reply-To: <20251119-xspi-v4-0-a451afbccf33@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763548973; l=3868;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=DyzDhhUAkg1KIRDzUSzmcu5RPQ0rKpxlHOLEvNBGNVA=;
 b=LJzfchCPc4unchTnMTLM1dArVbtA7o/7/11ZbUWqBoeOAssoZ8TKe3jjrvgPh4TWTt5o6extI
 IHPIscODxEGA5dCLtG5umGbYr5aCa1jIE/P3Yqyz8GapLvkWxN6enEp
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
X-MS-Office365-Filtering-Correlation-Id: ed82bde1-1c38-44b1-c117-08de27584528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmhrYkdOTzJwSmtwMDJjOEp3ZWtUY0IrMU1sQUwwaEZGZmxoUCt2MFVBYVBU?=
 =?utf-8?B?SW8xekVJVmlTbjVVY0VzcncrWEFGVktub3pWaHZJQmFscXFOeU1GNXRISU9l?=
 =?utf-8?B?NERDWkErek80NzlTWEJlNC84aDNBbHhsU2pvUmZ1cFVhaVhqTm9DMElvUUtN?=
 =?utf-8?B?aFZnRWlpZjhMMWR5bjFPeEpmL1VmdEtGS3JaR0dWRnhSMzV4WFFYOURrSk5o?=
 =?utf-8?B?NjNNZlNHYWh2R2tPdXlwYWNnNEQrdElaaXBZdDZqeVc2ZHV3UTVETWtTTkdx?=
 =?utf-8?B?M3VPL2VCWEFvZnBPRklWMDB1c3d5UHJlNHA5ajhKNjNvNnN4TXFaaFEydzY5?=
 =?utf-8?B?UWFLWjJMbWhHaklqcGxVeVdzK2NkSHNsMGx6YktWeHNPQnN2RGN3UnRNaFlP?=
 =?utf-8?B?RDFxcmtwVWlVdkhuUGdrSm1hQlIzNktFdnpaeHd0ZFJyY0hZZzc0T0VNMEw1?=
 =?utf-8?B?dXZkT3FLbXJWZytHQzd6ZGRwajVsL1Fra0xnUkNGZDFhQXErS2pDQnZKWEor?=
 =?utf-8?B?OVMwNVVYRmVyakpBaXduQW5hYkFOaVhZZ21pdTVtM2kyNXQwY0JERTNSR1d3?=
 =?utf-8?B?VGxzd2JFbGQ3M3l4MEpmTFRBVjlUSENaRzlra3NHQUNXaUdIeWN4R3BYa2ZK?=
 =?utf-8?B?YjF3WGFmUDhGeDBBZStJZkJBMzVlTXlrSzRoYnRkNFNldDhGV3l3QUZGbWJn?=
 =?utf-8?B?a3BwVjAvRHFza0pMZ3oxdXE1ZlNiZURuUWx5R3NoRUg1M2hyazNFQzZrbDlh?=
 =?utf-8?B?WTVpbmxvK0pFNnVuc0djZ3pyMGdhS2NxczQ0TGx1UnZBRkZDRmlseFowVjIz?=
 =?utf-8?B?aDd0Q2tJYW9lcHZPKzVYUXYrU0ZhSU93Y1hCb1ptTVlhSGFwS3RjZEl3YS9T?=
 =?utf-8?B?dVFGeDVqWGNTVlhZak9rdmNucCtMeThaS3IxRlRCNkVzTXIxczRhVnVXZHg2?=
 =?utf-8?B?QU5yQVZEVVBINDRGQnJ3SUhJWDErYnE2VVFtRDhIZmVWT0lEWnBQL2FBem9I?=
 =?utf-8?B?SlB6dy82UnRhdHhnc0xpRFBtRzYraE9rbDl2WXlCL2NCM1c5QlIxWHJxUkty?=
 =?utf-8?B?UERqbHVEb1dpUkRpTGM1TUxkeEFFb09SUWVLQkFnc21aaEpYKzNTWmh6N0hB?=
 =?utf-8?B?Rkp6dHYzY056M1ZyWFcvQnNZNEJzdXg0QmNlemVIc05vemkzc2ZqZFBEdzFD?=
 =?utf-8?B?K3FmSmpvMUlkTlNUaG1OcjAyYjdLR08rRG9vbVBGYkp3dWlteWxDd1RUS21V?=
 =?utf-8?B?RDlzQXBvYkNIb0VOUFFkcm9ha3VvMXhTN1RncDgxRTkyZVhTWjF2L2hXWlZn?=
 =?utf-8?B?Y3JlODZ1RlJnZnBDT1JUY1hZR2pEdjZ4Q3c2WVBnTXBCMTlQL0taWkltaUxz?=
 =?utf-8?B?M0xwT3ZjSE43SU4xYUU5UlRlRTlmdEV2TVZMVkVxUlluUGFRcWg5d3dYRnZr?=
 =?utf-8?B?ZEoycjNXb045a1g0Nm9qSUtaUytEc29wWmljYWU3UmF3NmhEK21vUVo1Rnpq?=
 =?utf-8?B?SS9hdWNHdVkzRTVyN09KY0ZMNVZnR1NUV0hRQVVVU3dYNzRlZHJVanRqWTNL?=
 =?utf-8?B?OHNmQzhGSzREQ3pqSndYbGxKS082VFMrR3RzekhGakFrWEVUSWxjK1I4ekpH?=
 =?utf-8?B?VzNRZm4wRFpWU3pQY0Vic3MyNVlsQmV5MGdMaFZLczhGeFJ2SDY2ZkpxNGtk?=
 =?utf-8?B?ZVhhUzVJUmx3L2J1UTliVmRIdkEzcWN5ZFQrNWo3eFNiL2dzL0tvZTJQY2g0?=
 =?utf-8?B?dkUyRW5OS2poSU5tZEpMaFN4YXlKbnJuaDR2TjJNK1ZvQ1VEZEtTdi8yTWI3?=
 =?utf-8?B?ejcrZ1JjZnZCaXdqQXhQdmsyNDczdEpFbUpwMUo4d1ZUVEpCSGtZMGRNMDY3?=
 =?utf-8?B?L2l4R25DSkxQaCtZZmVnbnJlTnAxM2NMQTlyRDZiamt2SEEyZERzcldIL2JU?=
 =?utf-8?B?c0EzdTFtWWFCSVVYRTd4ektlajVrN1RhdUQ1VlpUUFFJcnJEMjhBYWxUb2dX?=
 =?utf-8?Q?GEgTXPxKBGu5tDdpdL965BC1+cPQyI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1dlSk81S0VieVo1LzdycmJFOUl5bnFkVkpaRHZZa0JhNjdXbVQ4eWNqRUh3?=
 =?utf-8?B?aWtqYUZCVHUxaktyMEJGZncrK1pDNUExd1AwektCcHNNZnpuOGFzVVZIYTFY?=
 =?utf-8?B?YXNjbzJERnRLRmxUcWV1QWFZSjYwNDJPR2pUYVY0ZHJ2WlUxbTdad01YaUl2?=
 =?utf-8?B?YThmY3BEdVBBVG1WRXozb2pUY3ZOTGNrQ1pTT3pJeUh5TTJ5SlUvb0JQa09Y?=
 =?utf-8?B?ZEV1WmgrdWVBclpwUlFqT0NZK2V2RGVoc2N1Mkp2QlU0a1E4aXVhajk0ZDBI?=
 =?utf-8?B?MUVDMUpibWFCRWIwOUhwSVJuY011Qytua0hFWTExeTBMV2RGQnltNzIvNGt1?=
 =?utf-8?B?eG5RVXN6VmRmbjR3Y1FrYVVUNjd6RzBrOWlWVzBpbUVENkdQeDArYVJQQUFI?=
 =?utf-8?B?cWdaNStzNU1yZ25iU2lqRHRRT0dYM1M1WW5neDdZdmJhSkRkM0IyVnVpbU02?=
 =?utf-8?B?YVJPUlVKcUlQMXZwY2pvWjFLTndxVFprL2htdjVhVkh2V2FWZTl1T3RiaTNa?=
 =?utf-8?B?OGdFZjRHc0VaRDVVRFBiY2tmR3c4WWZCaVo1S0Q2QUdLYy9KOEV3b1Qya0RD?=
 =?utf-8?B?WnJBb2NWYTlFU0JTc1RseURiWE9xZjFYeE9sSXU3Zm9KQ3Y0QldsZGwxVDRl?=
 =?utf-8?B?QUlheTVaaU5QRzN2Vy8wRzZ0eTJJdnB2VE1yN1o5RmpTb2Z5TngvcXVIMG93?=
 =?utf-8?B?dlYyMDZxMkloSVBZVG4rTStZN05iZWtIa20yd3RVWHl0MWdtR1l3anBnQXlR?=
 =?utf-8?B?bTFOMVJIRUFkeFcwVkhMNnkyRkNRQXpQZ2YwQk5Wd2V1UW40TXpxcXNVazNx?=
 =?utf-8?B?cXIzTnlxY0V0MWpOcUh6eXR5alpERUVkUnZqa1NpaU1WMjhnMUY1WFRRYW1M?=
 =?utf-8?B?TDhyTkVPOEVQa29Pd2JBSk90MXd3dSsreU5vbkNyY1YxN0VpaWlLZGQ0WXJ4?=
 =?utf-8?B?cUdVdWlLVWdaZ3NmcktPc2k1UHlCSktPWDFoVWhWbVVhRVVMYTNlUUgzZU5m?=
 =?utf-8?B?VXRjeHdOOW81ZTJoY2ZCTlNFNk9NRVFxNnI2dFZ0NG9MWTgvT0k5L3ZYWVR2?=
 =?utf-8?B?VWpOa0Jod2FDSkxWV200OXVhZDVvNUhrNVJ0ZWlzVDRUL2VtM1BtVVhOU2ZZ?=
 =?utf-8?B?OFVJZmh4ZmZTMm5wZ1ordWVmc1pDTHdRS3N2cTZkQWNwQmE1ZHBTcnVWNnha?=
 =?utf-8?B?VUtpQkdjcXVSaUlEN28vUWIrSHgyajFFUklCNFNJRHRKemVkUGFjT2ZRZDVT?=
 =?utf-8?B?M1JoaVRyYTNLUXdrT2k4VWI1UEovTUNEVDE3WmpLV2xCTEdEVGFaV3M3RGgx?=
 =?utf-8?B?NVovQys5b3lhaG1SMzcxWStpRE8wZ3dwOEswVkZ1aGc3b2RTTUJDUXpjRll2?=
 =?utf-8?B?eDBnTmN4U2djUzR6L0JTVkVOeTQ4RlJwZWpuZzk5QU5qdlZZMTVCalhCODNB?=
 =?utf-8?B?dno0L1pHWkJEWFBhZG9UV3FsTVE5N0dVRXdOckJUMUNQbGtKcXRIeTdSd2gr?=
 =?utf-8?B?aVBLb2dxRUFMbUJYdWYwaTBDNzQ1My9lZUZJYzFVVHpjVmp2RUVFcW9QZlph?=
 =?utf-8?B?ald4UHM2bTNlV0lJZXo0TEtSWGVqYlJzNVM5c0JyZnlWTEw5WldoNHFVZ2dR?=
 =?utf-8?B?ZTFrcHJSS2E0K1VFc1F5ak5nY0pwckhRL09TRTdJLzBaZ0pvOHVqc2JiSlFo?=
 =?utf-8?B?TUNvTDRuODFQdWlBLzA5MFc2dlNJaDk1UWErZXVocXB3Sk40RXBCVkxNbFdm?=
 =?utf-8?B?dWdsTlVZa005ZFJXRWNUbVdzeEYxRHJMWGRPWGVLaTRSL2pBZHROeHo5RXJB?=
 =?utf-8?B?dXRvMFhUR2lzSzl6dFljMkRCZ2ErMGlKUWlEbytydm1ZRHIxNmFCV2tOQzYx?=
 =?utf-8?B?aWJGK09TMy8yc0FvV3ZMK3hPUFprZ2gvY3VUVkFXRno0UTEvTnN0MzZHN1Mr?=
 =?utf-8?B?OXkxeFFBTG9ZMmZoWXRzSExlWVQ4ZE94b29Xa2RZNklHcnNMU1lidjgxTGEz?=
 =?utf-8?B?Mk1wQTU1R3ZoMmJrVkVSR3NTWTA3K08xMDlLL2lPeDh4RVhEYjhEcS80bU1L?=
 =?utf-8?B?VzVZbnVCUEpzMko1S0hObEpYdW9JQ3Q1MEdBU0paUDM4TUNZclMwVFBJR1RJ?=
 =?utf-8?Q?A2GxqEZToqYjSO2gX7x4Ed8Wq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed82bde1-1c38-44b1-c117-08de27584528
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 10:42:00.5692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: as1MuTsbC6sWO62Fvt8+dJCgtqKaFhMC6L48eQ71e+eSLcbWIV9EF/9yG2MfcXEAd7DOzrRAyBi4+T83lKrwfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7070

Document imx94 xspi that supports interface to serial flash
supporting following features:

- Single-bit SPI, Dual SPI, Quad SPI and Octal SPI.
- Single Data Rate or Double Data Rate modes.
- Direct memory mapping of all AHB memory accesses to the
  chip system memory space.
- Multi-master AHB accesses with priority.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 .../devicetree/bindings/spi/nxp,imx94-xspi.yaml    | 88 ++++++++++++++++++++++
 MAINTAINERS                                        |  8 ++
 2 files changed, 96 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml b/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..a0f4b162c85855c55d06c6ea1a2417af5121fab2
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
@@ -0,0 +1,88 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/nxp,imx94-xspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP External Serial Peripheral Interface (xSPI)
+
+maintainers:
+  - Haibo Chen <haibo.chen@nxp.com>
+  - Han Xu <han.xu@nxp.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - nxp,imx94-xspi
+
+  reg:
+    items:
+      - description: registers address space
+      - description: memory mapped address space
+
+  reg-names:
+    items:
+      - const: base
+      - const: mmap
+
+  interrupts:
+    items:
+      - description: interrupt for EENV0
+      - description: interrupt for EENV1
+      - description: interrupt for EENV2
+      - description: interrupt for EENV3
+      - description: interrupt for EENV4
+
+  clocks:
+    items:
+      - description: SPI serial clock
+
+  clock-names:
+    items:
+      - const: per
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - clocks
+  - clock-names
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        spi@42b90000 {
+            compatible = "nxp,imx94-xspi";
+            reg = <0x0 0x42b90000 0x0 0x50000>, <0x0 0x28000000 0x0 0x08000000>;
+            reg-names = "base", "mmap";
+            interrupts = <GIC_SPI 390 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            clocks = <&scmi_1>;
+            clock-names = "per";
+
+            flash@0 {
+                compatible = "jedec,spi-nor";
+                reg = <0>;
+                spi-max-frequency = <200000000>;
+                spi-rx-bus-width = <8>;
+                spi-tx-bus-width = <8>;
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 59b145dde215f7a2bd01867ffaf4d621eb0f901e..ecda64e8087de3704315c1cd39720ee2c9399b9e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18869,6 +18869,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/trivial-codec.yaml
 F:	sound/soc/codecs/tfa9879*
 
+NXP XSPI DRIVER
+M:	Han Xu <han.xu@nxp.com>
+M:	Haibo Chen <haibo.chen@nxp.com>
+L:	linux-spi@vger.kernel.org
+L:	imx@lists.linux.dev
+S:	Maintained
+F:	Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
+
 NXP-NCI NFC DRIVER
 S:	Orphan
 F:	Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml

-- 
2.34.1


