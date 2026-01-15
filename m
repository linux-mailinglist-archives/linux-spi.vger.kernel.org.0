Return-Path: <linux-spi+bounces-12409-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7887D24548
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 12:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51927309F2CC
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 11:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC9538A2AA;
	Thu, 15 Jan 2026 11:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L1Tc5s8E"
X-Original-To: linux-spi@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013068.outbound.protection.outlook.com [52.101.83.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F04C3939AE;
	Thu, 15 Jan 2026 11:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477924; cv=fail; b=CIx9pvEDdz4yc7aq9mZLgJOy4HV1HDZXxKvfvdOoz0+XGT53cQ6+e0WbbMM5jJfyMH3fiiEoOCIX9EBLMYUgd2AGQfycirRfBwfnbUJOCLMwFi5IqEsvshOa98PvVIugtfNntK2pEmCrd9AOQK6cZv6WvWgs4ZBX7KzS+FLD92g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477924; c=relaxed/simple;
	bh=GOMjhb9YakFDqoTn9c5xPyL46pyUb3HO0jtPoVBx9N0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JMuARtVaBfyAgleswrh524wPFQN9E0OonnVjIBu7ZGSaxXJIoidft2zC9DdX/OShg8ZkRwMiOPVNwJgrTkhzk1+HfUQ2ZR1Mp03wb4tupPXGBYis5NbG2EkClWqhfsI1nhgvgF4ad43P7XNOBv8ASKY1zribtQ8keV84JmmKJqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L1Tc5s8E; arc=fail smtp.client-ip=52.101.83.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBO6cy2GWxYkSiso1VpEsIVg51uT5Rk1Hktrlc8DSaIKFDpq1d+8Rmd1gu616Yb7C6acgeLC/q1iCi2zNDryAgub0dLeC0Lw+powmtFUH2pkrcD92L5TL1gg4dKBElsIQWqsGBLx04PPpRsNBufka3FYXvXeHUW0xTi1Cpcecu2VylBEKPpPfg3SOeyhJkgWcNYaySgKWoKBS6FzynpD/6cZiMuiM0J3nWvY0JyLunbAGFdUEJcwGVCIDJmuQ/LGgCfjgrURXxl/cg4mAxJ9vvMyPqp9n1CagzcVv172jTdIuSwXnglzr8VsDzs6PnW7asJGtFVFGT9WbY8KkDiokw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOMjhb9YakFDqoTn9c5xPyL46pyUb3HO0jtPoVBx9N0=;
 b=WyMSDlhl9gWa+G2H771LV6p7BYvumnzhYELEbGWxkxoyVpLstXXd0dhD9oDQs+j+aKbXLFobRfVZ3F7Fib5rYWHkA6NVbq6j2bcyolmH1G6bY/m5rqlNwNmSzP0vaPmNkeJOCept4KP/9Fc7p9hva1TDDql7VfNDUsKiyHjP6hq7IQxApynJq2ANq3N+p0gX4tKXUyo+KhsPf79gIQioX3RjWc9WMcIwaII2wy/wM2p3/han4E/tNdl+ojFwj5I7JltDVsMt2f+V1Ep03MgWPAlljaYhRhmeRfXmu/7y73H6XNIFQBkUpotpwdf+CtklxHECViKjRChbPz1eAaI2tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOMjhb9YakFDqoTn9c5xPyL46pyUb3HO0jtPoVBx9N0=;
 b=L1Tc5s8EW/XEjKLJP02rXOjqsHfvqOfhxtIU2IsaWqeqjUlq6FA73toziNz0NXIr7ZB7wkvkNbgYSFhYXwnUpuS2tzP/+doDyBKdRLjWYdcXfmf3LAO4Tznxqyvegn/+y8fjLEIsj5hnLl8H+eYg86aZ+iTa2qgCgdrQaZ5cEX8r17ymX0/BtgbzL2lMvBvLFpgMS7CHHvfgGe+Foz7fAyPBsP9kA8m3yqkuW8fVtoMLfiWlL2WhR6jDNQGvbKGvXZXpJeG5yEc1a9eMFMg/5wuMinjal+m08uCZLqCON0SoRWbSxnR/WNYhDA/cNHtTGOpmWR17JZx8vtn2U7dDww==
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by GV1PR04MB11037.eurprd04.prod.outlook.com (2603:10a6:150:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Thu, 15 Jan
 2026 11:51:54 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 11:51:54 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] spi: dt-bindings: nxp,imx94-xspi: add nxp,imx952-xspi
Thread-Topic: [PATCH 1/3] spi: dt-bindings: nxp,imx94-xspi: add
 nxp,imx952-xspi
Thread-Index: AQHchSIM5Orr9bvUFUeehwAkk1ocZrVS+2EAgAAkHYA=
Date: Thu, 15 Jan 2026 11:51:54 +0000
Message-ID:
 <DU0PR04MB94967965CFD39EE3642615C9908CA@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20260114-xspi-imx952-v1-0-acc60a5a2a9d@nxp.com>
 <20260114-xspi-imx952-v1-1-acc60a5a2a9d@nxp.com>
 <20260115-imaginary-banana-beaver-7b45ea@quoll>
In-Reply-To: <20260115-imaginary-banana-beaver-7b45ea@quoll>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|GV1PR04MB11037:EE_
x-ms-office365-filtering-correlation-id: 5a60f5f6-0a5a-4ede-9b74-08de542c7a88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|19092799006|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?YTlsc2FOSzZwT2ZzZmljTll5NHd0a2l3ZmhabEdsVUVTcXlTd1NmamhUS1Bz?=
 =?utf-8?B?VUt4OHZXWFJKUmR6K0lRUGNmT2FlZG05UkFhVStpZURkK2NZcGdqcGRFaFhy?=
 =?utf-8?B?dWNpNDZTNktmUVI4UFhtV1ZmdzBpQ3FDS2JxR2RMMzJBenhmZTJEcXlFczky?=
 =?utf-8?B?cTRzNU1Xb0VISkR4SlkwTGJvZm94U3RGSTNZUWUzWDdEWE00bHQ0MnVMS0Ri?=
 =?utf-8?B?NU91cUwwb0pkWGxrejhKSmJrYUg1MHVBR2Q1WndqcWJkeHJsMk9hOGlCU3Y3?=
 =?utf-8?B?ZUpKN0NQNGVWTmNMMFl4cDgwU1BuZGswamN0cmp5WWNJV1BXbVU0a1hKYUcz?=
 =?utf-8?B?YTVrQysrb1g3d00xY1JLTEdNUkhhcEcyV1VPRmE2VXc3UkNyUTg2SDUwMmVS?=
 =?utf-8?B?VkVaeUowWHVCRGJWK3o5K2dlZm1jTEdHblgyUUprRDVtZ0VFalQ5cmp1NEhF?=
 =?utf-8?B?Rk9YZVNxSCs5R0FHdnZ3K20xNHl0elMzZWtnYUVlbGtwWENaMFh1NUJSUC9F?=
 =?utf-8?B?K0ZqM0gvd1FEL3RmTk5XS0poaFFQaXBkV1NDbmY4aVpBRFZPR01PSHZrUHZY?=
 =?utf-8?B?cXBvSFpJZjBLODV2Q3NYeDhvMWRqOE42MXhycUpXK1JVdEE5SEdBQUdMY2xN?=
 =?utf-8?B?UDBCN2NRRGJKQVdCWlZVRWY1WXdLOFZQeEgvODVOUG1tTGpORjVGRmlMVkJj?=
 =?utf-8?B?M243KzJ6bmpyNTM5SjVqLzVkcklrc3N1N2kvN3orZEZaem9TNHV5MzNXMnh5?=
 =?utf-8?B?eUFOc0JiM1gvV2lxL2N6d3E2aHN0ajIwNWM5ZGFxQ0VHTHhCMU8vWnBvWDcz?=
 =?utf-8?B?eVpiQ1dUYzJaaUdNd3JRaVV1c2lxdEFCZ1hXQzJZaWc1VGFUQ1FHS2I5Uklr?=
 =?utf-8?B?ZmQrcWJkYWVUaEJFeld4WDFQL0JTS3hicW9SczVjaVZheENNUkJxOE9yaENu?=
 =?utf-8?B?WWZHL1FGWk5PckJKdGhYa0VuQVZKY3ZvdGRXUVlzSnlid1c4ZjJpc0x3bDFh?=
 =?utf-8?B?Rmw0S0pkOForRmNtRlVxRS8rL3o2L2h3M1NqUFNTS2t5bXlaOGMwQnYzSGd1?=
 =?utf-8?B?cFhYQVMvUFliV0RoSzZrQmRMb3JSSm9oTjk5N1lyZFRnakZXVGVFbkVXVVpF?=
 =?utf-8?B?MitTMUxXNDBTbjBPd1Y2blF5akN0aWhrVXR6NXVjYzNnbjAvOVFZV2x4NitI?=
 =?utf-8?B?djJISWZGZmg2TDlpc0VCZVA5M2IrR1Y1NS9BcGZMTjhvS2NTeWRXbS9VY1lh?=
 =?utf-8?B?NVR1aTJsZ2U1aGppOXVlbVRMNng3N1NUekFXbFQ3T3ZScXluT3d3N0ZUVUd4?=
 =?utf-8?B?RVpXNmVRS1gxOXpmdE9zYVVaeHZjTVpmc0I0SnR6ZGtaY2F2bGREQXp2dnRZ?=
 =?utf-8?B?S3hiQjhudDJXTEg5aEhDUkpMRjF4WlJzRDhOeTkycThZVEwvbGx1bWIzQ3V3?=
 =?utf-8?B?YWcxeWVnaXh3RnRjOFBEWDk2R3BtRld6TWNIak0vSW55UDRPYytITUlKM2RG?=
 =?utf-8?B?Y3E5SWlFanJvcFNjVUMrNWVYcGhpZDFkQ1RCMVlMR0tORDVrVENqcGdQdHVp?=
 =?utf-8?B?TXpiZXJIdEZuaXBNZWt2em9za0Z5U0Z3MzUvb0w1RnpzMWt3VVNERTNOT2VR?=
 =?utf-8?B?T0JXSlg5VitxSHlKWmdETUR6eUZBcXhpcWZpQ1gxNjAzOHJXL0liVHVaWHNH?=
 =?utf-8?B?NU94Rm56RGZhcVBjSTBmWTcwTkNDUkR1blNtcFdocjlHcHlzbEd2TmxkRzcy?=
 =?utf-8?B?YWZrT2FST3EwaGRkRDdLOEs5dk5VN2YwTEFHdzVTWUhNZWxJUU5GR3Zta3p0?=
 =?utf-8?B?d1c1dHRmNFczdUFFc1o2QTRqQkpIdmVWZWIyNHBPN0I2Y0E3Rmo3V3JGVDVZ?=
 =?utf-8?B?TWFFeTNFR1g3K29YOHBYZi9Kb3hVZytmV0plTW9TbGMyMmlxb0ROSlAzQWto?=
 =?utf-8?B?VlBFQUdOZkxxM1ZpWVo0eGJEelRqY2pEYkhuMm5wdkt5dVhxalZwZURFMW9q?=
 =?utf-8?B?Q2VWMjR0WFhVODFSMUR2K1JPekFONWE5TFhUUlBkdVpNTWp6VXp0dW5OaDhI?=
 =?utf-8?B?OUF4ZlhpaUtTZUlINEVrYlVja0pjZ2ZwSVUycys4TzRhZnBoK3JtdVBOVDlt?=
 =?utf-8?B?VFltRm5WRkUrMVIyWTNZU1ZUeDRHTTJneEhhdFpDNTJmaGV0SnR5OERYY0hY?=
 =?utf-8?Q?uiUOqZK+C/+6GeveFib4MJU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(19092799006)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RDcwY1lxQi95UnJtOVVkN1IreHVVbFFTeVYwbXhxM1ltbUNvNVdRNjd0RnpH?=
 =?utf-8?B?eFM4WXRGR1E1d3NlUmZxd1ZCQnkvMnkyR2lON1VUTHVOUzdTVVprSlM3S28w?=
 =?utf-8?B?Y1NtcjFyUUNwblJ1cHgyZ3BYY05nWTZLWG1yMWZWc2Z1dkpXQVVxY3JCUFQ2?=
 =?utf-8?B?S2RHa3d6VzVMRkVZaWJsWXhNbHNwcFZCUjVXcy9VU0VWMkF6bzYyZjR1bFNC?=
 =?utf-8?B?YTgvbFdIYTRGYVpPMXQ3WW5ZODh6K3o2SzdvSHJ5KzkxOG5iVTFST0pmZGZh?=
 =?utf-8?B?bVlrRHB6VkhlUnA0NUg4TUZPYS9MNlFTSWRORkRkTjlBdjYvY2dUNmxVWU9r?=
 =?utf-8?B?MXY5Tks1NFd1bWxzZ3JtUjZVR0hjK1dDWDBjMlh4SDJteWI2Ujg0YXplMlBI?=
 =?utf-8?B?V29wVVBzelY4cUh5eXZRa0ZEditCUnNvaXdINWVaeWpwNHhlM1RGYTBoWEF6?=
 =?utf-8?B?YUJUaHNTOXJELyswRlJRbGJLL2ZwV0poWFI5eGg3ZEtQNnAraHpYMnNYWU5m?=
 =?utf-8?B?WnVkK2xGaG5pWjNOcEZXejVlWUQreE5uQmFOWERnYzBlQ1VFOTV3MFZ2cFlL?=
 =?utf-8?B?WVFsNE5icjFwdEErTSswWEQ4aFBJMEgxQXFVMzdwY3hzcGZFVU1zelhNMzJ2?=
 =?utf-8?B?ZmU5SllzRk10Ymg3azVsWlFSVzJUbkRmTjNqVXBZNFBHcUlyZmtFVlhxN3lV?=
 =?utf-8?B?Qkl2MkJJY1E3QlpMSTRNYlVYSVBZT1U5bzQ4NDBYVlZWUEZQQUZXcTRIR3p2?=
 =?utf-8?B?eURhUXpsRVcxMFdFNzdtT0haZDBsbTY3RlVYMmdvbnl4OG5zU3cxVHZFMVFr?=
 =?utf-8?B?bmI2ZzZiS0xMaUEwQVZ2VlBMUzhCN0ZiYVl0ajRrUTVwYmMrcU9tcTBSOTNH?=
 =?utf-8?B?ckY1K0VsaktBWDM0anJheHBLNkVIaExBNm95SEQ4R3hRYTIwSFFrL0d1bWVT?=
 =?utf-8?B?Z0E1SFMrVVNSTWJubUR3VXNpMnJqMWtEc2ZjK3VWZm1lc2F4V2FkOERsRmVH?=
 =?utf-8?B?OTVIcEEvNTBUbXdIcWpPVlVzZm9McFc0YWNQVE0wOUxDRGRHRmV1WGRkZUl1?=
 =?utf-8?B?RC9nZFlndzh6QnA3VzU2b0Z5UnhFS0dUSUhIZVl5YXd5a2tZZ0UyQlptOEZk?=
 =?utf-8?B?cW1UaDhzSnVPenI2S3ptazZ5djZBVDBsYnJtTXBYMTZwbzF3eFNPSGQ5Kys3?=
 =?utf-8?B?RFQyc1kyTkJoSFhjREdhRGZrN2hRZUtVQUlOU2NaU2poWDNGdmY1YlAyU29u?=
 =?utf-8?B?SUc5ZVlWNkdBa3hwMUhHUzdISE9GQkJ3TzJyVjZBb0UwRjJudkk5QUZkK0Ey?=
 =?utf-8?B?SkEyUDA5VjN0WlloZmhRK0NYbUhoRmNLb0xjamdSUkRleE9XeDZpZ04xcWR2?=
 =?utf-8?B?aEdtemRhL1VmaGhhek5Hd1FFdEErUVpyU2d1R1plUy9qbWlzRVNTMGNUWWJw?=
 =?utf-8?B?YTkzNnlaZ1ZleWUrSUpYY2R6dFFPVGR6R2ZpTjNPK2VEeXFjcnBibHA4Q0pM?=
 =?utf-8?B?RG9taStzbWp4K0c2aU5CNG4xbWZVVVdDT2V4M210dGhyNkNLeEo4eFZqMXNs?=
 =?utf-8?B?amd3Z2VjMDJXek9UT3ZXOUEwUCtVbm5xZG1xS0VoQ2tzNFN5akF2ck9YQjJ2?=
 =?utf-8?B?emIxUnBXUVBBUGJ1WVpaUnlkWGlLclBlRmFLRW5kNVRrUEYxTTA4YXRrTnl4?=
 =?utf-8?B?YzlvakhIVXRjY3d4bHZEZ2xHSTE3ZTRoUlB0NlBkczdBMy9QRXkzdnFxbFhw?=
 =?utf-8?B?aTZFbUcrZHdVb2Y3YWRiL3BnQ3p6SitMY0RwNGxwRnNvWUZ5MU1pN2RoYmNU?=
 =?utf-8?B?VGZiWXZOdFRmUUl0MVRSZGVuWGpMWk5pRWFuQ0drSGNlZXdxR3RZWkphZFpL?=
 =?utf-8?B?SDRzUHZzYnR0bXVLT2xGRDh5OUF0V2NoQklSZVRuV1Y5RkgvVkpLeXdJN1Nn?=
 =?utf-8?B?OVB1eDJCR2JyMFVQTk1FUG5uKzhRSHdBQUppWG8zb0dzQS91d0dEbTRmc2FH?=
 =?utf-8?B?ektndGNaTzdicnczdGcwMlE3akpteGs5Szh1OXZzV2FIYkRQUHRMenk4cVY5?=
 =?utf-8?B?eHJuNTRwdG9mR0o1SDcvNTk3L0k2SHNTQlJCTm1XdEI1VXFIb3c5UUFGNjli?=
 =?utf-8?B?dStiZFp3SmsrSzJNcmdyUklyT3VvZWtwMytyaWsyZHNXZFFlL1NwNHhXTkVZ?=
 =?utf-8?B?dDhFVEI0ZzE3K1Q3QXJadWE2VlY3RWJWb09jSE5KYkJqWVlHbWQ4OVc1dWR1?=
 =?utf-8?B?QzQxa2hHWHh0aVdsUkpRRVBXY0Z3cDczTWpEN1dUZzA5eFE1QytENDhGZEww?=
 =?utf-8?Q?4sWVf41HjGaa3KSX6L?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a60f5f6-0a5a-4ede-9b74-08de542c7a88
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 11:51:54.4077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b1L0T1FxjpHSkYeiZAkehLWVYGJdmgSU1i+f/f0vtU3KzBiNZGIAnm5vybEP1vUu7OiFatmo/JhClX9ulNrvAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB11037

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnprQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjblubQx5pyIMTXml6UgMTc6MzkNCj4gVG86
IEJvdWdoIENoZW4gPGhhaWJvLmNoZW5AbnhwLmNvbT4NCj4gQ2M6IEhhbiBYdSA8aGFuLnh1QG54
cC5jb20+OyBNYXJrIEJyb3duIDxicm9vbmllQGtlcm5lbC5vcmc+OyBSb2INCj4gSGVycmluZyA8
cm9iaEBrZXJuZWwub3JnPjsgS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6aytkdEBrZXJuZWwub3Jn
PjsgQ29ub3INCj4gRG9vbGV5IDxjb25vcitkdEBrZXJuZWwub3JnPjsgU2hhd24gR3VvIDxzaGF3
bmd1b0BrZXJuZWwub3JnPjsgU2FzY2hhDQo+IEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRl
PjsgUGVuZ3V0cm9uaXggS2VybmVsIFRlYW0NCj4gPGtlcm5lbEBwZW5ndXRyb25peC5kZT47IEZh
YmlvIEVzdGV2YW0gPGZlc3RldmFtQGdtYWlsLmNvbT47DQo+IGxpbnV4LXNwaUB2Z2VyLmtlcm5l
bC5vcmc7IGlteEBsaXN0cy5saW51eC5kZXY7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0K
PiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAxLzNdIHNwaTogZHQtYmluZGluZ3M6
IG54cCxpbXg5NC14c3BpOiBhZGQgbnhwLGlteDk1Mi14c3BpDQo+IA0KPiBPbiBXZWQsIEphbiAx
NCwgMjAyNiBhdCAwMjo0OTo0NVBNICswODAwLCBIYWlibyBDaGVuIHdyb3RlOg0KPiA+IERvY3Vt
ZW50IGkuTVg5NTIgWFNQSSBjb21wYXRpYmxlLCB3aGljaCBpcyBkZXJpdmVkIGZyb20NCj4gPiBp
Lk1YOTQgWFNQSS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhhaWJvIENoZW4gPGhhaWJvLmNo
ZW5AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3NwaS9ueHAsaW14OTQteHNwaS55YW1sIHwgNCArKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc3BpL254cCxpbXg5NC14c3BpLnlhbWwNCj4gPiBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvbnhwLGlteDk0LXhzcGkueWFtbA0KPiA+IGlu
ZGV4DQo+ID4NCj4gYTBmNGIxNjJjODU4NTVjNTVkMDZjNmVhMWEyNDE3YWY1MTIxZmFiMi4uMTZh
MDU5OGM2ZDAzMzU1NGNlNWE0MmExMw0KPiBhMzINCj4gPiA2NTMxNWExNjk5MmUgMTAwNjQ0DQo+
ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9ueHAsaW14OTQt
eHNwaS55YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Nw
aS9ueHAsaW14OTQteHNwaS55YW1sDQo+ID4gQEAgLTE1LDYgKzE1LDEwIEBAIHByb3BlcnRpZXM6
DQo+ID4gICAgICBvbmVPZjoNCj4gPiAgICAgICAgLSBlbnVtOg0KPiA+ICAgICAgICAgICAgLSBu
eHAsaW14OTQteHNwaQ0KPiA+ICsgICAgICAtIGl0ZW1zOg0KPiA+ICsgICAgICAgICAgLSBlbnVt
Og0KPiA+ICsgICAgICAgICAgICAgIC0gbnhwLGlteDk1Mi14c3BpDQo+ID4gKyAgICAgICAgICAt
IGNvbnN0OiBueHAsaW14OTQteHNwaQ0KPiANCj4gWW91IG5ldmVyIGNoZWNrZWQgeW91ciBEVFMg
YW5kIGJyb2tlIGFsbCBleGlzdGluZyB1c2Vycy4gQW5kIGV4aXN0aW5nIHRvb2xzDQo+IHdvdWxk
IGNsZWFybHkgdGVsbCB5b3UgdGhhdCBpZiB5b3UgdHJpZWQuDQo+IA0KPiBVc2UgdG9vbHMgaW5z
dGVhZCBvZiByZXZpZXdlcnMuIFJldmlld2VycyB0aW1lIGlzIG1vcmUgaW1wb3J0YW50LCBzbyBp
ZiB5b3UganVzdA0KPiBkaXNyZWdhcmQgaXQgSSBmaW5kIGl0IHF1aXRlIGRpc3Jlc3BlY3RmdWwu
DQoNCkhpIEtyenlzenRvZiwNCg0KSSBkaWQgcnVuIGR0IGJpbmRpbmcgY2hlY2sgYmVmb3JlIEkg
c2VuZCBvdXQgdGhpcyBwYXRjaC4NCkkgbGlzdCB0aGUgbG9nIGluIHRoZSBmb2xsb3dpbmcsIG5v
IGVycm9yIHJlcG9ydC4NCkNhbiB5b3UgaGVscCBwb2ludCBvdXQgd2hlcmUgSSBoYXZlIHRvIGlt
cHJvdmU/DQoNCm54YTEyOTM3QHNobGludXg4OTp+L2xpbnV4LW5leHQkIG1ha2U2NCBkaXN0Y2xl
YW4NCiAgQ0xFQU4gICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MNCiAgQ0xFQU4g
ICBzY3JpcHRzL2Jhc2ljDQogIENMRUFOICAgc2NyaXB0cy9kdGMNCiAgQ0xFQU4gICBzY3JpcHRz
L2tjb25maWcNCiAgQ0xFQU4gICBpbmNsdWRlL2NvbmZpZyBpbmNsdWRlL2dlbmVyYXRlZCAuY29u
ZmlnDQpueGExMjkzN0BzaGxpbnV4ODk6fi9saW51eC1uZXh0JCBtYWtlNjQgZHRfYmluZGluZ19j
aGVjayBEVF9TQ0hFTUFfRklMRVM9RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Nw
aS9ueHAsaW14OTQteHNwaS55YW1sDQogIFNDSEVNQSAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3Byb2Nlc3NlZC1zY2hlbWEuanNvbg0KICBIT1NUQ0MgIHNjcmlwdHMvYmFzaWMv
Zml4ZGVwDQogIEhPU1RDQyAgc2NyaXB0cy9kdGMvZHRjLm8NCiAgSE9TVENDICBzY3JpcHRzL2R0
Yy9mbGF0dHJlZS5vDQogIEhPU1RDQyAgc2NyaXB0cy9kdGMvZnN0cmVlLm8NCiAgSE9TVENDICBz
Y3JpcHRzL2R0Yy9kYXRhLm8NCiAgSE9TVENDICBzY3JpcHRzL2R0Yy9saXZldHJlZS5vDQogIEhP
U1RDQyAgc2NyaXB0cy9kdGMvdHJlZXNvdXJjZS5vDQogIEhPU1RDQyAgc2NyaXB0cy9kdGMvc3Jj
cG9zLm8NCiAgSE9TVENDICBzY3JpcHRzL2R0Yy9jaGVja3Mubw0KICBIT1NUQ0MgIHNjcmlwdHMv
ZHRjL3V0aWwubw0KICBMRVggICAgIHNjcmlwdHMvZHRjL2R0Yy1sZXhlci5sZXguYw0KICBZQUND
ICAgIHNjcmlwdHMvZHRjL2R0Yy1wYXJzZXIudGFiLltjaF0NCiAgSE9TVENDICBzY3JpcHRzL2R0
Yy9kdGMtbGV4ZXIubGV4Lm8NCiAgSE9TVENDICBzY3JpcHRzL2R0Yy9kdGMtcGFyc2VyLnRhYi5v
DQogIEhPU1RMRCAgc2NyaXB0cy9kdGMvZHRjDQogIENIS0RUICAgLi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MNCiAgTElOVCAgICAuL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncw0KICBEVEVYICAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkv
bnhwLGlteDk0LXhzcGkuZXhhbXBsZS5kdHMNCiAgRFRDIFtDXSBEb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3Mvc3BpL254cCxpbXg5NC14c3BpLmV4YW1wbGUuZHRiDQoNClJlZ2FyZHMN
CkhhaWJvIENoZW4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==

