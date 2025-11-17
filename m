Return-Path: <linux-spi+bounces-11252-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 361EBC63C1B
	for <lists+linux-spi@lfdr.de>; Mon, 17 Nov 2025 12:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B6EC4367F75
	for <lists+linux-spi@lfdr.de>; Mon, 17 Nov 2025 11:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0830329C7F;
	Mon, 17 Nov 2025 11:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XjhbRqsA"
X-Original-To: linux-spi@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013008.outbound.protection.outlook.com [40.107.159.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF87329E40;
	Mon, 17 Nov 2025 11:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763377448; cv=fail; b=B0kuayP0uRyl4PzRgJbYDTO/QkTRxYLWYZFPdYtnnYJwS5TgYVhqMx03mzagsjz2pSt8W8wrCSDwbKgSxDx8eT9oNo96kg4wOByA10tm7g/q+ngfIL9f3hCsrqBHv6tu+p+J5bGrrg1gy74SCAb4bBqc6PoUEOWElqyMcdVUVG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763377448; c=relaxed/simple;
	bh=yQDG4rNkfkPFlm5D26RbADnFzpaiKnTZxGqdu5mWnlI=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=PP/VaTIXZ0v26oEiPMEXhBsMeLHu9PSEZb5G2mhBB9aklD+9Y0XUpeSmSUCB75qAmHhDlBndZ1RDQdDdccIc0XMoIP0Qoplzk5Ey5+GP6iDFzN15C3BervJjr62lssz6MuRerphdjj6GRwoexSUjZnbfI6gN0b6WKavf+1+rdS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XjhbRqsA; arc=fail smtp.client-ip=40.107.159.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0dcFCToJszLR4nqpTlcfM0LcSEacsajhEMGttBfXRjTd+sKza+vXihJ2YWLRnKLZxGSUpkgs0+eKLYd0V/v4bheqhEgGGQEu7Rr2BBRW/pSUqk0DSHf8lkm9MUItT9ryd25i6pWE+l9HKO09sJnoyrnw6YLehyx042pldIpFOZvvHIBm+TvEjQisX3uzqzCTFNYCwhfuvU/E6hBn15hQ74PsMbVoiKybI2S7d/Q5bbiut1Ox3EmVnL4nFIfw13h8HT2n9n1pHy57XV09ctgQYTTJSo97XPvJOSFhxeYD2Epk6BFGERySN7CZyexpz/rMmqSphgxYDfJPCfC8SayVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feB2Cj0n6cXWPh3ypB+JpWNZF6NaDrLfmX6TvYjAh8Q=;
 b=LScykR7B9s7OxyGfOvAontmPolot1wW8xuYVBYNB7dEoNpon9KGiZCNNx9iBTnMLTtCIun9sgW59dwlzB7wDu2anUPxgeVF5dAbCWDHoc6JjojaZ7a2CQ60Vzz7qJtiU9l7UL86ZhFyOCvVOIsDfuQo5kSxfATVAdpal9saCz5WFzGfrXnMDGqai/KdXQP9ZrR9ms7S8ja6QeySa0PGD22xnP7/h8erc2bYijyZYlnRlJXYTe5OtrOb9H6kWXYAMv8ptmD4B15SBt9tOjjpJ9oMQSZ8SKp2e0mtyDXCm2rWvZfmqfSmmfsSduraiw9WUABAIAEVHlYh6+pCZrzAmMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=feB2Cj0n6cXWPh3ypB+JpWNZF6NaDrLfmX6TvYjAh8Q=;
 b=XjhbRqsApMO/uQRpKlTgT3JnMVOLjmwroOGThxqAna+bdQ3G/geSs2HjwwfNwziyThMUcydqaoqTX7MlDfSSybh3bOjlODm5oBIyeGLIGg2YjhIxpSQsupxfobwnHutRe1DQdS6lKq3Cp3vp6ftY2oz4WES8IncL8cbT9+tMmAUc5nvtCQ+Ie6j0OoRkeatgPmYzBRGcVXkuW/vFPso1eh7ZOvxCyIHCsH8mGY3wY3o6OcRDt3EfEnznqwJ0eKqBarve7zdKhEwLJP7UzOorPKdqDnErpXZ0G+40Gs8JKXsERcE/TFZK0Lpn9LlfIqLO3mcXhZYHxfPDg/vXordAQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by GVXPR04MB10851.eurprd04.prod.outlook.com (2603:10a6:150:21e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 11:04:01 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 11:04:01 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v2 0/2] Add support for NXP XSPI
Date: Mon, 17 Nov 2025 19:04:23 +0800
Message-Id: <20251117-xspi-v2-0-e651323993fe@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADcBG2kC/yXMQQrDIBCF4auEWdcyisG0q96jZCFm0syiKlrEE
 rx7bbL8H49vh0yJKcN92CFR4czB91CXAdxm/YsEL71BoRolqknUHFnY1aGVhm4GJ+jXmGjlejD
 PuffG+RPS91CL/K8nIFGfQJEChRw7qI1dSOPD13h14Q1za+0HqFe7YpYAAAA=
X-Change-ID: 20251028-xspi-afc0a17e9708
To: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763377498; l=2453;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=yQDG4rNkfkPFlm5D26RbADnFzpaiKnTZxGqdu5mWnlI=;
 b=7Vr7pdcCpZibaDx5XjOkJAK4b4TE7nBcxYlqXV9UTlO397/hLjI5qO2WwqTlpmb+Lo99c31SJ
 xkXcAd/1D6GCMLxsWwyatakDzgB8yk8oOD9Hi/J0yL0ntP1xNYon+F4
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SG2PR06CA0231.apcprd06.prod.outlook.com
 (2603:1096:4:ac::15) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|GVXPR04MB10851:EE_
X-MS-Office365-Filtering-Correlation-Id: c1353370-d351-4415-9fb2-08de25c903be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cG1xWkpRRDdpQzE3Z1FGU240Y29vR2RaSGk4dS9sS3hkR0JTY2VuRVRpSlZB?=
 =?utf-8?B?ZUpHbjMxQktnOVoxcVB0NDF3bjI2SnN1eVIzSU92Sm1lT3dWRnBsRXVqeWJp?=
 =?utf-8?B?cmdKZUFlc3BvMHkxb2wxZkp6SUdESXRWbmV4RzhOSnVUQitVY1krWjhzRTNH?=
 =?utf-8?B?empvb3pkV1p4Tzh6c0M0VUJzMFVTZVhoZ3JXQkphVEhVaVp0US9tQjJkQ1Fp?=
 =?utf-8?B?WVRxaEtRMk1xQmZrUERUcm1HN2llNDh4anplM2Qrb0dHYlFxUVhGUWFWOFFN?=
 =?utf-8?B?QnNSVjVGbnVIaHVUUnI0NWlDOC9WalJYZml3NE5xNEJOMEFoU0RQaW9vQlpW?=
 =?utf-8?B?bWx5dk51a0pocytBRE5KRnZydEF4UjI4c3ZPQ1JpWWtVV1ptQzJKa2N1bzB5?=
 =?utf-8?B?Z1ZuemcySEk5dWZXNmZ0WldjWENHTEVzT2RHeEdxdjhJWjBlZE5xendDK0dI?=
 =?utf-8?B?eVl0TEZEVVA5NjRtTk5hNjN4NFlLcmhmaHhmSjNtN2xzd0ZycGZ6NVhzTkRK?=
 =?utf-8?B?WG5Bb0VXYncwSEtxclhwUDQ3WE5FZWZkZG9OdnorVUtEUGV6NkhXaHVkQUJN?=
 =?utf-8?B?azJYWElockhBQmZRU1g0UUpMTXdOTVJ5M1c4UDVvK080cVhMMS9taEpINXEz?=
 =?utf-8?B?T3BOQktqZTNKNEcrcldDS2pGODVOOTJabTJicWRYQ2N1VTVYaVRJK0dEdjZq?=
 =?utf-8?B?MGVNTVVPOElLanN6YlJncjJHOVVNU3IxRUM2SVBzak1jNjQvUE5KbllaZStI?=
 =?utf-8?B?ZWVjTW1MRXU2NE1nZ2Q3SEFvZnJGRXZsSlJ4VmlnMC9rRk91cmRJVHlmR0lo?=
 =?utf-8?B?dE1OZHNkUHp5bFpwL3FkcFMzcTArZkdCMGV0T3ZOUEFmOVVpTFF1OUJIZkor?=
 =?utf-8?B?eGxFQTh1dGxHaklBSzFlSEQ0VVc2ZldHTFV0dVdQaGl4QW9ORTVxUUtPWW1Z?=
 =?utf-8?B?dkxoaFBjcVY1VEhmVzlPemhmYmMwSWRPSTExYkl1b09HeERxUEo4cmhaVys0?=
 =?utf-8?B?cU42TWRwbnQ1VnVJbzluOW43Y3h6ZTVYekhiaUZ3Nkh4dERUVWExQVFGNzJ1?=
 =?utf-8?B?TFo2ZFQxcjFiWTg2YXkyQlB5bTZFUDl0ZFVQbUhTSHlmbVdXcmVaR29zWGZa?=
 =?utf-8?B?bGZveXdUc0tjUldjVkxqZGk1T1ZFSzBkZjFGRktpTkNoYVF4YmxNWU1Idm52?=
 =?utf-8?B?S1hKM2lPbXRDUlNwbmVpeDNMaXh2ekZ0N1hWVmhhdFFvY0VwREZoaThqalpB?=
 =?utf-8?B?UVFCNDRzRTc0YTltZGVselc2ZytXN0ozSGtheGVGOWJrdUVKbFJaWnB5MG1p?=
 =?utf-8?B?Z05OT0xScU9SeGp0eXhiRDdBNWk3M0h4bWhsUXNPVGxET2ZsbGhtUDdzSURj?=
 =?utf-8?B?QkplNENiZ01KTnZSdm9la3NuM1NzZlBOY2hDNVpydWswL1doeDM4YUlzdFlT?=
 =?utf-8?B?dy9QZkM5OFhVbG9OS3VOREF5eXhQNy9XU2dFZm00dXQxV2lwK1FxbkFaa2ly?=
 =?utf-8?B?UkQzSlcwR3JWV0JNMm43bkhIbVBvdld0YTE1ajU4cnRXU1lzdm9KbmRUY2xx?=
 =?utf-8?B?OFZNU1BWSEdBMDhORWsva2dLT3l1bUNLRFMyNG1sZEMxT2hONnVJZ0hpS20x?=
 =?utf-8?B?YWQvQ0RyY3I5SWZyYzRvNFFBUkFiWU9rQUV3ODRybk1aUkRsY1dJSjY0WURT?=
 =?utf-8?B?OVMwVWV5MHVSSW1JMjArVGJISlBBRFc5YzhWdzFleVJUL01aWkppK1VTVEtY?=
 =?utf-8?B?NXY0ZEZiQUpKK05mS2NIdVRkaFJWUkJNdHdPZ096aS9oQXRYcXViaHhJN3N1?=
 =?utf-8?B?NFVkMzlDdHVFb3NQS21MN0FvMTJrMlRVUXZXWHVxODk2K29hcS9lbHpXV3lG?=
 =?utf-8?B?L0Z6WGRQWU1uQXRKRmJzSC92b0pCS1JYNGRtYTF4ekhocXlzY0c5Nkg4M2dw?=
 =?utf-8?B?Q0JERkR0MjBCdVgvUlpkd204akhsVFZhY3FyUk9nS0JGTXNRc0RwKzZuLzNH?=
 =?utf-8?B?dUt5L3pFU2EzRy9zeXh0Q1IvRldPSU5pclFGMGtFK1JwUG82THg2YlE2elNv?=
 =?utf-8?Q?rI63j9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YzhaVjQrSDJOZjZKeUJwYitCcDJRK1lBQlpra3FBMnpyWHR3ZlQ5dkRDeTN1?=
 =?utf-8?B?OU54Yk8zQTh5bURzdjYyaEdiQWhQOFBtbk9zZmN1a1A1eWdXVUFNZjlUQTVy?=
 =?utf-8?B?NkpZcnE5WDBRNG1pakE5akk0SFBUUWNyTkkwYXRtZmkwY1RvM2NrMEJSMldK?=
 =?utf-8?B?Z3pBUFpZZkRkZ3ZsQ2x3ZUhkMjFJYVpNclBEYk05MWdMSFd6KzBmUUNra2kw?=
 =?utf-8?B?ZlhmY2trNmtaRHhoczFIZkEvQUc3RXluTmFWQ2JrV3h4Z1VpaXQwK2ZkNzUr?=
 =?utf-8?B?Ym1ZK2ltdjBONEtORDA4d3lnNFErVWJVcXpIU3FHMUhqU0tJYnhEUDRTamlL?=
 =?utf-8?B?UHZNbjJhbk5ZWmRFRkVSTmRxQkVOcnVYY2VraFh5b24vZGNvQWVUMGpLMWVw?=
 =?utf-8?B?ZHRYcXBPWE9NcnVlRGtXOHVEZ3QzTDZTaExDcFNNTWV2SWhZSWFKbmlaR1lh?=
 =?utf-8?B?WnlJQmREQytEOFRNNkNrRUxZTmNDSWdWSHZ5Tm1tTzF5MHlpbFR1T3ArRk1J?=
 =?utf-8?B?cWt0TDdCQWFUc1JrZ0k0ejdCc3g4QStHVTlyYTBodGloOUVuZkU2Y2hiQVhh?=
 =?utf-8?B?LzlDdWRvR1VyZXlQbVZmU0lXZ0JpWVR4SGZYbU0zbTU0K0RtZE1jS3JIRlpW?=
 =?utf-8?B?UzllbjBHZktnQ2xTTVh1d3VlYlZHTmxnVnJrY05oUmh4UGhUY2VaY0U3SUc0?=
 =?utf-8?B?SlUvZnlaRnBCK0ErVFltL0ZTd2puU0FNVG1JMExNMytVM1hPRUpKK0s2ZHAz?=
 =?utf-8?B?THhVMlZmbEkzbXlab0R3Kyt6bGlRMmpBdGY0NHZITk43citWZTVUbHB5RDha?=
 =?utf-8?B?d2tZOEFQcjZSV1ZhWkNUQ2pHUjNZSXo5RGltdHBTc0puM255TVNnSHRFVVIx?=
 =?utf-8?B?Rm5WOGNtaGF1VFVNckJOVkM4TTZLTEFxSmRPVCtBQlJsMkxFY2RJOTVlWndo?=
 =?utf-8?B?RFk2aWRVSS9CQlR2WUU3WkpuZElRTXBKbXN0ZDY0ZHpjL0JCQ0xUcDAvc0ZG?=
 =?utf-8?B?VXk1THZMdTJ0S2lXWW1LYzRudWdPWHdDSWg2YW5XRjNrcHNaS2RjRmphQTBv?=
 =?utf-8?B?c21rZU9Id0lEeFlHU0cwMDVwMWcrc0pOYzRrWFl4TTc4YkFEMGNaUmxWRjYz?=
 =?utf-8?B?VnFFWS9hNmppL0xXUCs4S1NPMERvaXZKYlJEOTVLM1VuMWhhbXIvemZxdUsv?=
 =?utf-8?B?UnZQVHZ5Q2FEZ1dNUnl4ek9jTTJkT094cTgwaTFaOWw0Mnh3UXcrWXB0QmdF?=
 =?utf-8?B?MWp5Tkd3c2xQKzNsbzVIVjdhVXA4OXpCeTkyd3ROOFZQVE5aMk15aGVrcXps?=
 =?utf-8?B?ais2a1F0Qk5senpSVW1tejNXMjhVOHRlTVJDSVpmYmdNelNQVlFwTVp0ZkE4?=
 =?utf-8?B?WkVRUjdVb2hpalF4ckQ3d2U1SVJDaS90RkVNcGhrTlVSRlJ6NUFHd3FYbWxh?=
 =?utf-8?B?cURZVXRmRTE0L0RPeGJHRnQxVG8wL2lFNmJHbG56UFNPRjdLRmY4Z0k0ZHZR?=
 =?utf-8?B?VjVFeEd3VjY2Z1ZqVzFIV0FHV0pibmx2bkx6U0pxZmF0L0lONjk2bXpMN3Yy?=
 =?utf-8?B?T3NjWVhvTGQwa25CclFKVWFTU28yS3hzRzdIWHZiRVhRdjk4eUdPWEpZRENN?=
 =?utf-8?B?d0Fyam9sb2ZaRWdZMUx5Nk05aTlCWXVjamh6YzFVN1JIZWl3b3BuZmJlUXVx?=
 =?utf-8?B?WGh6SmVjZVVHU2M2UjNPaTNxTWlGTkM0Ykh6RDF5SzFjbjFMQ2VFaVpZVlF5?=
 =?utf-8?B?aU8za0IrVUh2OXk1U1NHV05MUWhkZ3ppbU04NytCcnZSQ3NPRkdMRFN4dDZX?=
 =?utf-8?B?V2V6aU42c3RhZGhzTjJEZXFEMktKaTBxRVlHSmdFTkp6SG4vcnBRQWJDcWl3?=
 =?utf-8?B?dUc2Z3g0KzNycTk5RFVCWmdTTHVHMlpzTkZBNHZCVWRRQU1nc3h6UmUvVnhW?=
 =?utf-8?B?TTRGaWdzMllYTWxZYzc2MzZvMVF3alVwTWkrVjFSWGdpNTZpL2dSNkt2dmp0?=
 =?utf-8?B?amlHZlB3MUtFL3VjOUtxU2hnUFU0K2pHUWNsYlk5c3pGQ09YYmlmcXd0VnI4?=
 =?utf-8?B?ZkY0YlQrKzVWRUd1bEdNblF5NlFDVVJXV1NOYURKRnYyWXJFbU5wTlYrTEth?=
 =?utf-8?Q?KoTydzFs1XENac98KuJx38vKD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1353370-d351-4415-9fb2-08de25c903be
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 11:04:01.6990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nr4AYIj+Jb5b5z/0m5hXdPnDayWg7n/Yw+GcYdTypIfL5wM1Cca+KNLPpj7mVr70s3hmgHysgHd1T8EDDP3ocQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10851

XSPI is a flexsible SPI host controller which supports up to
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
 drivers/spi/spi-nxp-xspi.c                         | 1365 ++++++++++++++++++++
 5 files changed, 1473 insertions(+)
---
base-commit: 0f2995693867bfb26197b117cd55624ddc57582f
change-id: 20251028-xspi-afc0a17e9708

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>


