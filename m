Return-Path: <linux-spi+bounces-3554-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1E29156C8
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2024 20:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF11C1C225B5
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2024 18:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D671A0710;
	Mon, 24 Jun 2024 18:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z+SYxvxH"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2047.outbound.protection.outlook.com [40.107.103.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D2E1A00F9;
	Mon, 24 Jun 2024 18:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255366; cv=fail; b=ptCU9CrWZDDSaW2XlsnyeTDtrCrp2yHmT+TVt7hAaKNzn7EJifwUX/nazWP3N1DSvYk/Eq+L8drifJlVFjjig1gmpE7qS1Kn4gI8n9Dv1dgiexuU3360gv7Msjkd/CyMyWjyj1fcehsJS1ly/uyLKKm8viXN8RKiusPVYitORl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255366; c=relaxed/simple;
	bh=G/DRGrVocyvETq+rGdmcTSv8wITZDgGEQQ67/lp1qLk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tZr4D5ehXIi61bIMVnTxi55h+L9DNzDMd08sJuLRLC0m1/uMy+LaFxHbWSTln+TR1CHh7OrpYO0xEOUYcybTikPgv+n+srYLV70KMBr6KOWugsTnLOLAFwMH7D36ZpQOhXVcT+kP1nt803rrv7QbS2MSKheiqq5sg29M5dLqlHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z+SYxvxH; arc=fail smtp.client-ip=40.107.103.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYTb/gOfOIt+vnd2wd5gJ06RQPPPJMb1fjdFNmC28miVfwItDQw+LmXsiLztL33mt1KxPcUgrZsaWDigqJm0DT1nC/gx2rnm++tRgp9uUd//NN5kGJB1C0wHLyk7LOBlQdxkBEXN2B7yTER4SoRzNAu/+cG6Q0uVZmAhZk9iwKPUZK26GHGwVNPNYZzcYmg5iIBVwVFXSLbcm9QOIeRu+jr4tES2P7Ff7A9Jqdlsq/oSgUHglPNNKSepbRE5md/PUFJqtSiKG6Dwe3ZRsXuRSgGSSOYdElZhw5WKhhh7jlyNmkLQQ6Pwi7UxNgoR5QjnWv9+TjabN4tfmBvMz14giA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=afuQfaQ3NwhlzpZWwGE4ZN3x9AZmumDll6moPhPmMUs=;
 b=CC29RlurcLGJ9XYxyxC46GPP5mAwDR79rCql3v6S4rDWpaaMQ/8mJIjufrw78H8WdUI9EoZaVHc7m8Al+FiYJuvXVUHhzBmZwQltWUF/VdC7OSD1oXyqmENRsgAjaBcD5VwC2CXlYyv0luEoIjiw13uSzxt7SwFbEmyvhnF0Odc4K/6UD5LObTKy7EMwrPZCYUjJxafVQZxALXnon1Cu5um6ExYNhzbh77oiaR/Bgom8CkBGrBItN01jmHn/HIzcKS34lKMIyIuFuTWDSC3cUqlL9qkcD0do+qqB4yNeIwvo4D2/COJJL1Bl0HWMFV0mM10epA1vGoyK7ziUACf//g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afuQfaQ3NwhlzpZWwGE4ZN3x9AZmumDll6moPhPmMUs=;
 b=Z+SYxvxH8Vkbf51S/Fugq/utNsdGwUuap/75qkQd3CIPRnkI8yQW053lU8WhBVDDc0xM7I170/L6NHQP89Ao6FdKg6B+ALPEOCQEUJaM4c4tfPjhX7YR8Eh7PnMWF6YUsvur7oPLOVkn2jCWUQ678N/hf8IDm35AWiFSS8QymtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10138.eurprd04.prod.outlook.com (2603:10a6:800:242::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.27; Mon, 24 Jun
 2024 18:56:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.020; Mon, 24 Jun 2024
 18:56:00 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 24 Jun 2024 14:55:28 -0400
Subject: [PATCH v4 2/3] spi: dt-bindings: fsl-dspi: Convert to yaml format
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240624-ls_qspi-v4-2-3d1c6f5005bf@nxp.com>
References: <20240624-ls_qspi-v4-0-3d1c6f5005bf@nxp.com>
In-Reply-To: <20240624-ls_qspi-v4-0-3d1c6f5005bf@nxp.com>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, 
 Kuldeep Singh <kuldeep.singh@nxp.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719255350; l=9546;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=G/DRGrVocyvETq+rGdmcTSv8wITZDgGEQQ67/lp1qLk=;
 b=l+4vQcvmorXujEmS8KIG8itUk7LoAXYMTAdUrTKUM+mE/SQrSe5Kz03TS9nXlSGVgzWJSqI/L
 hOGjJ5F2UBkCXkkAHmHSGzpmhJS9Sfa/XCoCEuZ44YbSUA8i1cJ3A/H
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10138:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d37e1f3-99fd-4866-0213-08dc947f4a05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|1800799021|52116011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzNFbW9hSCtDU0wzQmRDTlhGYWVVTkdTTC9WNEx2ZzVPM2RkSE5TOFhuRDFO?=
 =?utf-8?B?ZGpuRVhNMXNUUGROS1lNYWRNTnA4YXpDOU8yTllNcDVkQStvZ1AzaXB3NkJ2?=
 =?utf-8?B?ZytLY0lEZnF6WFpqVnJLNjBHYll2NlpDWUo3OHU5YVdITHp3cFRITzllbEFK?=
 =?utf-8?B?eXFMWEY5VWpjOFArd2RSWkMyWW9xNElNMFdWcW8rS2lMWXJzcUFRMTN1a3RD?=
 =?utf-8?B?UnJpS1Y5K1M4bk1keTQrTTJ4UGVyODErSit3Szk5MElrbGNJcjJjYVV3QzFo?=
 =?utf-8?B?TlRqNVp1SVJSMWRHVGZ0RkhPR2Q5OVhmZk53MVpYbi84ZGdIMmdDQnpPZE5Y?=
 =?utf-8?B?eHdxTG5aeC95UFAwelMxa0NyNldwTVp1RnBuU0FCMUhHaTIyVzExRDVLRFM1?=
 =?utf-8?B?T1huL1J3VTNmb1dKeXNFZjBvYjlCd2tzMGR6Z3I5eTJhTzdxaHVJUU1GdTlY?=
 =?utf-8?B?ZC9SdytnbkdwQmpoTXFrNE1NWXZESmNOd2lpQWludG4wVGh4cVAvdDRKVDVE?=
 =?utf-8?B?ckQxS3ZoSjIzK29nT2d5TGpiU0lQNjNOQmhha0tIVHBFckJGdC9vZlhNVGll?=
 =?utf-8?B?NDVvNUNZVkNnTTlzM1FZd3NIWHZuQ01qbmdKMXBneW1BYmJJZHlUc3VYMng4?=
 =?utf-8?B?QU5yQWhGeXNXaUhKTEtRMmpHQnNjZHZjZ09ubkVDMnRwazRsTzNzRlhZdWR0?=
 =?utf-8?B?V2RSR3VhSVIrWDVUbERQMVNxSWhTKzhpMHBsOGxWZWFxbDZ1OSt0Nld0YlUw?=
 =?utf-8?B?WjlWblF4TkpoMDd5aWxvNGJnODJKSCtpOVVxeFdKN1RqRGxlVXhIZFJuWjRw?=
 =?utf-8?B?d250WWtiNWlyQ2hsckhIcmNUNjR2T2cxSlEvSnY4TVRDZSt5amcwa1VyU2Y5?=
 =?utf-8?B?dHhQYnhEQ3FJamhIKzFDVE42enNPSXd1ZURIRk0yYUFZMElIWDdSMHhLRGVX?=
 =?utf-8?B?RE4vL1hqdURWZmJPMmNibVM3N1d0YmdsQkprM3dDVXI3SlB3L3NvQWsrUk85?=
 =?utf-8?B?cHhQbGxhTkZRVWdxRzBOcndmRnRDMVgrWkx6UW9xWGNxbUxaRE5JTGJHWmNG?=
 =?utf-8?B?VGl5UzZIcWZjSHpSeEFnOWx2cHFyYUFjQzRLaUdkQTlTVTQ2dVVyTFJwYnJC?=
 =?utf-8?B?aUtNWTNOdVdpeEkyQjVzSGFLRkhObXdjOCtDWHU5RHZyZyt5WHlXb3hnZy9R?=
 =?utf-8?B?QzNCWVJxUnJzNXEwSjRORDNiV3hGaU5OdWF0NnhPbWxoM09zRTAyVFJWdlZJ?=
 =?utf-8?B?bmFkcUJMU0Noak1uZlBaOUdMMjBieXE0aElQR3RVbHdqZFE5eUFuaFpXdURP?=
 =?utf-8?B?ZG5tWmRSS045a2pmK2hSSjB3WUV2bHppczVHRlJBamltR2Rrclc1ZU1SSlBl?=
 =?utf-8?B?N05rVTBUUWtFb0tybkFHVWlIVUF1K1JkS3Ftcm85ZThmeFowSW5KU2ZsRTdU?=
 =?utf-8?B?dUhmWDdQSVBUeVgwYVRtcitLa3dYbkdvalVpR0tiOG93ZEl1b050S2hFNXhp?=
 =?utf-8?B?VWNad1pOZjgrWi9GSHVTOXVxc3gvY0ZnSE9HYzZjYzMvYmJlZVRLclRkVGhj?=
 =?utf-8?B?ZHpIazJMdUdZTXFrektvVEdFclFPcFNlWnNPRXBER01pRmFiMy9iVTJNYmpH?=
 =?utf-8?B?bHRiY2lpSjh2cEdjZVdWT1JRaldGQUVJb1lFdmJPVmRDbWoydWVxZ2dGcDRR?=
 =?utf-8?B?OEZuUkZYWENROEZUMXYrdHdGK0ZGZjBVSEUxVWdXa3I4MXFsZzk4blR4MHZy?=
 =?utf-8?Q?F3QEIyux2JwcNzIV/dL9I9NCJ071uEZMNgV2lyT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(52116011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmhuZEhPV3c5bFQwMFFyekN3VHdiZm1rQ0RyNDVGVDI5MVFGN3hyOHVONDJ0?=
 =?utf-8?B?cWlTOTErWjRFK0VYU3oxb0hpY0RWUWsvbFV1bllKUG9tVzlpcWw3VDNYbXZT?=
 =?utf-8?B?aFBpUngyeFo0NkE1T2JSYUdpamNseW5oWG1heGdXZ0FCVE9YLzNFKzhNODBH?=
 =?utf-8?B?NEFwRjFPczRXNTBZQmdOSklYdVVVUXF6WGlQcGlyczZPcXN1RDZqcXdIZUpn?=
 =?utf-8?B?UmYybHkzaWdmcklxdkFMQ1FSN1JyZEIxTFkzSG4rWTZqN2Jmd0pGb044ZGlu?=
 =?utf-8?B?RGg0ejFWdlB3ZGhwNzZKZDNFUWxibkN6eUVEN0RlWDVlY1NLdFJtak5iRkhw?=
 =?utf-8?B?T2lPSllLVkVLc2dIODBPMjJJV0EydTZGTGVhbVd3c0xTRm04SFAxTHF5Njh0?=
 =?utf-8?B?bTJlNGZOQjFmV1g0bXBESjQ2aDVXQ1dNek83TWxjM2M1R3VnV2xQRXB6Ni9j?=
 =?utf-8?B?NG0ycHNsTzVsOVBqM1FJSGdiaWtZS0RjaElPR2p5MW1XZW5DRDBmMjBRNUlq?=
 =?utf-8?B?YmtKR1U4NUJLajFFS2FCTzd4Z3paK3dYTGRHaHNjUWF4dC9iY3RjYllLQzdZ?=
 =?utf-8?B?QW01RUhTMHJ4aVJycHdtY2d2U3ZNYVExQ1VZRWQ4YlpUNjU4dC9nS1VITXRP?=
 =?utf-8?B?S3M2OFVpeTJFcmtTYlZJeXN1UWUzUE43L3Q5OS9ib2Y4aW9OcWtodGw4dm1M?=
 =?utf-8?B?Q3EzblM4dlVrcWw2SDFoaGF5bE5YUGZLR3d5WitYRzdVd2oxREFCa2kwRGNL?=
 =?utf-8?B?V2diWFdiSCtDQ1l2alZiQkNnVThiODAwdlBJRzg1TW1XY2ozWjM1SW1Hcm5F?=
 =?utf-8?B?cXBGUXBDc2pwVm1zWWtoT1hPZjU3elFJTkFVZ0M1ajRJaElvTm44RmdOR1dw?=
 =?utf-8?B?emh2enQvd2k0eFNQQ2oxYXRzaXdySWZNWlB5dmVNN0lTMjFXMkYwbGRMa1Jx?=
 =?utf-8?B?c0c5d1ovenNCMVVVeE1EZ2h2enRkN0E5clBNSStNc2xmd0JPM0Y5NWFzdjR1?=
 =?utf-8?B?MlhVdXFrSHZLRElKWXA3Qjd2UDJQWnlFbW52d05UdUhKR1J1MWdBZDc4d1pG?=
 =?utf-8?B?R2o1OWQ2ZHJJNitRS1hVOWR4WWliVXhUNXJyalpiN3VCWGVMY2xxWm00QUp0?=
 =?utf-8?B?ZE1veld1L1ZSMlp6R2o5Q052NGV0bkROWFVGbFlwZXYvc1VyUlJpdjhudGFL?=
 =?utf-8?B?a2pQUWQrSmNzV3BibDJOYkd4N0lHK0RabVZwem54TVhkL2U3VFdtcGREMlZR?=
 =?utf-8?B?RHFkQlBVYXRlMHlpeHNybExXNFZFUG1SL1JEQXBCczY2S3VldVlMaUoySnRj?=
 =?utf-8?B?dG02YnRZbVNtcjdHK3hMdXBiejNRVkQ1MEp2clNZLy8vK0pUZ2tManRqSDV5?=
 =?utf-8?B?RitOdzFta2lCaTJmOGNSWHVMeTMwT0xNbmhpc0FrQUZtSklsd0VoUVFKc25Q?=
 =?utf-8?B?SFZ4NytoWWlqSytCQm0veFdYVWhjYVpOSjc0VE1VNUFkSkpjU2lsc0tyRklK?=
 =?utf-8?B?YzJuMkhHUnZMdGNiV2VsWU1SeTZ3K2xlNDFxZmJPR1lEVkwvYnZ2ckNoS2VQ?=
 =?utf-8?B?cVZkTm9WTXNMcEZKNkRuL2ZxUzNmT3VCRmpwcGNnVEREeFpkaER4VDJMWGdt?=
 =?utf-8?B?WWtSSVJSWVBSdFpySDhFa0ZsY3puQVZ4MUhRSFp1MldiSnFIY0xxeWZrdExE?=
 =?utf-8?B?NmJvRS9IeGZRNGxIOTJ4MHE2VkJtUm5yNTVrVmRzYzlkeFBXNU51M1FnU1hO?=
 =?utf-8?B?VnBRSkNiSUxSSTF2b3lHWW80Y1hJaEkyQkZxZGgvY3grTkFjVTRyOTRSUDBl?=
 =?utf-8?B?bDE2VXorYTQ1dFpGMkV6ZUtTdUVBVE83QUh3UU1kSUZzeENjZkhSRjZ5Y2hW?=
 =?utf-8?B?OGJndkNBMjRDMGlZWXJyWnBVUHRoWnBiNjdvVGxabU4wL1BhbUt4RTFPMkhx?=
 =?utf-8?B?VE1GRlhSUEtBTHJlVCtCenppUmQzWWMzNE52Ty9nY3djajFsV0pXRmE2Q0FH?=
 =?utf-8?B?Zk80Vk1KN2RKR2hyd0hIMXNkOEtKK3VqNzVYQ2xjWldldVRGR1pjYWRIM2s0?=
 =?utf-8?B?QkFPamFBLzlxNGwxd2V6U1RjSGdxZUYraCt5cXhYM0MvWGZnTXMyck1qVnB5?=
 =?utf-8?Q?IecP34V+aiGW1Ez+iiYwOstER?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d37e1f3-99fd-4866-0213-08dc947f4a05
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 18:56:00.4195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9JpOe4Qndu9j7ZEWD2N/D2rtsijP9/+EnNtxYDH16/5rP9MxvC1cB65n6Zflsm4qXG5di7fpTJ2GX8rfL54lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10138

Convert dt-binding spi-fsl-dspi.txt to yaml format.
Use part Vladimir Oltean's work at of
https://lore.kernel.org/linux-spi/20221111224651.577729-1-vladimir.oltean@nxp.com/

Additional changes during convert:
- compatible string "fsl,ls1028a-dspi" can be followed by
fsl,ls1021a-v1.0-dspi.
- Change "dspi0@4002c000" to "spi@4002c000" in example.
- Reorder properties in example.
- Use GIC include in example.
- Deprecated fsl,spi-cs-sck-delay and fsl,spi-sck-cs-delay by use common SPI
property.
- Use compatible string 'jedec,spi-nor' in example.
- Split peripheral part to fsl,dspi-peripheral-props.yaml.
- Remove 'interrupts' and 'pinctrl' from required list.
- Update 'bus-num' description.
- Update 'spi-num-chipselects' description by add "cs-gpios don't count
against this number".
- Remove 'big-endian' description.

Co-developed-by: Kuldeep Singh <kuldeep.singh@nxp.com>
Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
Co-developed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>

---
Change from v3 to v4
- Add Co-developed-by and Signed-off-by from Kuldeep and Vladimir
- Remove 'interrupts' and 'pinctrl' from required list
- Update 'bus-num' descripton.
- Update 'spi-num-chipselects' description by add "cs-gpios don't count
against this number".
- Remove 'big-endian' description.
---
 .../bindings/spi/fsl,dspi-peripheral-props.yaml    |  30 ++++++
 .../devicetree/bindings/spi/fsl,dspi.yaml          | 103 +++++++++++++++++++++
 .../devicetree/bindings/spi/spi-fsl-dspi.txt       |  65 -------------
 .../bindings/spi/spi-peripheral-props.yaml         |   1 +
 MAINTAINERS                                        |   2 +-
 5 files changed, 135 insertions(+), 66 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/fsl,dspi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/fsl,dspi-peripheral-props.yaml
new file mode 100644
index 0000000000000..9b62b75e17a7f
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/fsl,dspi-peripheral-props.yaml
@@ -0,0 +1,30 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/fsl,dspi-peripheral-props.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Peripheral-specific properties for Freescale DSPI controller
+
+maintainers:
+  - Vladimir Oltean <olteanv@gmail.com>
+
+description:
+  See spi-peripheral-props.yaml for more info.
+
+properties:
+  fsl,spi-cs-sck-delay:
+    deprecated: true
+    description:
+      Delay in nanoseconds between activating chip select and the start of
+      clock signal, at the start of a transfer.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  fsl,spi-sck-cs-delay:
+    deprecated: true
+    description:
+      Delay in nanoseconds between stopping the clock signal and
+      deactivating chip select, at the end of a transfer.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/spi/fsl,dspi.yaml b/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
new file mode 100644
index 0000000000000..bd28335a6ac86
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/fsl,dspi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Freescale DSPI controller
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - fsl,vf610-dspi
+          - fsl,ls1021a-v1.0-dspi
+          - fsl,ls1012a-dspi
+          - fsl,ls1028a-dspi
+          - fsl,ls1043a-dspi
+          - fsl,ls1046a-dspi
+          - fsl,ls1088a-dspi
+          - fsl,ls2080a-dspi
+          - fsl,ls2085a-dspi
+          - fsl,lx2160a-dspi
+      - items:
+          - enum:
+              - fsl,ls1012a-dspi
+              - fsl,ls1028a-dspi
+              - fsl,ls1043a-dspi
+              - fsl,ls1046a-dspi
+              - fsl,ls1088a-dspi
+          - const: fsl,ls1021a-v1.0-dspi
+      - items:
+          - const: fsl,ls2080a-dspi
+          - const: fsl,ls2085a-dspi
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: dspi
+
+  spi-num-chipselects:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The number of the chip native chipselect signals.
+      cs-gpios don't count against this number.
+
+  big-endian: true
+
+  bus-num:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: SoC-specific identifier for the SPI controller.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - spi-num-chipselects
+
+allOf:
+  - $ref: spi-controller.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/vf610-clock.h>
+
+    spi@4002c000 {
+        compatible = "fsl,vf610-dspi";
+        reg = <0x4002c000 0x1000>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clks VF610_CLK_DSPI0>;
+        clock-names = "dspi";
+        spi-num-chipselects = <5>;
+        bus-num = <0>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pinctrl_dspi0_1>;
+        big-endian;
+
+        flash@0 {
+                compatible = "jedec,spi-nor";
+                reg = <0>;
+                spi-max-frequency = <16000000>;
+                spi-cpol;
+                spi-cpha;
+                spi-cs-setup-delay-ns = <100>;
+                spi-cs-hold-delay-ns = <50>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
deleted file mode 100644
index 30a79da9c039d..0000000000000
--- a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
+++ /dev/null
@@ -1,65 +0,0 @@
-ARM Freescale DSPI controller
-
-Required properties:
-- compatible : must be one of:
-	"fsl,vf610-dspi",
-	"fsl,ls1021a-v1.0-dspi",
-	"fsl,ls1012a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
-	"fsl,ls1028a-dspi",
-	"fsl,ls1043a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
-	"fsl,ls1046a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
-	"fsl,ls1088a-dspi" (optionally followed by "fsl,ls1021a-v1.0-dspi"),
-	"fsl,ls2080a-dspi" (optionally followed by "fsl,ls2085a-dspi"),
-	"fsl,ls2085a-dspi",
-	"fsl,lx2160a-dspi",
-- reg : Offset and length of the register set for the device
-- interrupts : Should contain SPI controller interrupt
-- clocks: from common clock binding: handle to dspi clock.
-- clock-names: from common clock binding: Shall be "dspi".
-- pinctrl-0: pin control group to be used for this controller.
-- pinctrl-names: must contain a "default" entry.
-- spi-num-chipselects : the number of the chipselect signals.
-
-Optional property:
-- big-endian: If present the dspi device's registers are implemented
-  in big endian mode.
-- bus-num : the slave chip chipselect signal number.
-
-Optional SPI slave node properties:
-- fsl,spi-cs-sck-delay: a delay in nanoseconds between activating chip
-  select and the start of clock signal, at the start of a transfer.
-- fsl,spi-sck-cs-delay: a delay in nanoseconds between stopping the clock
-  signal and deactivating chip select, at the end of a transfer.
-
-Example:
-
-dspi0@4002c000 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	compatible = "fsl,vf610-dspi";
-	reg = <0x4002c000 0x1000>;
-	interrupts = <0 67 0x04>;
-	clocks = <&clks VF610_CLK_DSPI0>;
-	clock-names = "dspi";
-	spi-num-chipselects = <5>;
-	bus-num = <0>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_dspi0_1>;
-	big-endian;
-
-	sflash: at26df081a@0 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "atmel,at26df081a";
-		spi-max-frequency = <16000000>;
-		spi-cpol;
-		spi-cpha;
-		reg = <0>;
-		linux,modalias = "m25p80";
-		modal = "at26df081a";
-		fsl,spi-cs-sck-delay = <100>;
-		fsl,spi-sck-cs-delay = <50>;
-	};
-};
-
-
diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 15938f81fdce2..0bb443b8decda 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -122,6 +122,7 @@ properties:
 allOf:
   - $ref: arm,pl022-peripheral-props.yaml#
   - $ref: cdns,qspi-nor-peripheral-props.yaml#
+  - $ref: fsl,dspi-peripheral-props.yaml#
   - $ref: samsung,spi-peripheral-props.yaml#
   - $ref: nvidia,tegra210-quad-peripheral-props.yaml#
 
diff --git a/MAINTAINERS b/MAINTAINERS
index e04f583780c5f..25e485fad9ae8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8748,7 +8748,7 @@ FREESCALE DSPI DRIVER
 M:	Vladimir Oltean <olteanv@gmail.com>
 L:	linux-spi@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
+F:	Documentation/devicetree/bindings/spi/fsl,dspi*.yaml
 F:	drivers/spi/spi-fsl-dspi.c
 F:	include/linux/spi/spi-fsl-dspi.h
 

-- 
2.34.1


