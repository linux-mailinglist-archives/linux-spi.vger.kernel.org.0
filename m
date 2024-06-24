Return-Path: <linux-spi+bounces-3553-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BAA9156C3
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2024 20:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CC6B1C22716
	for <lists+linux-spi@lfdr.de>; Mon, 24 Jun 2024 18:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6191A00E0;
	Mon, 24 Jun 2024 18:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dz9MxRFa"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2047.outbound.protection.outlook.com [40.107.103.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5832E400;
	Mon, 24 Jun 2024 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719255363; cv=fail; b=WJRiqzoNgEZEgZswZLGWdaHYgjEBUorMO9cJ/5z99sDDA72ccF9c77FVsRPrhDiX9yLUGYn7a6jcT5wA1cWrgYHkwcfy087El0yYDozwAaN9axcMdN5kzXq2EjQR8/BK3ylql73RrZGPS5RYadaFT5dD+wpv2r+kGUQKxnIZoo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719255363; c=relaxed/simple;
	bh=xom/Q3xfIs6MEGezVp+EwKNwxIbMrLVo+r2BbHJc6Ag=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=AeBmMa5UnyVwwwxCyUIaFnd+r0fZ306HpR2u+EijDALsyJb2opuevZykh04sDL7jS0JRQtiy57uir6eg6i4zLrT6t6vwGigyb2rJyfUL/V+ss0a0fVbr1KuNEpoa3myx3z0bqcZblJxeSfvb71TWvRSmCuG/XOBN5x7R8RiZo/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=dz9MxRFa; arc=fail smtp.client-ip=40.107.103.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XKaw+j58nTBa6BG3ZpXsyBXZtp+Fa8z6Jltj1gc8QTrVNL6ZOP+Ta7q8UuTaP4pS1Z1WXsf55biDnVYS0nvUpY/AgQOHF64YixqopL6XlCxorgRshOsNLxm3VmRHbgMP1LDg3vTqp8OZV5F3sv8NFbKs7TEiiMLB3jBBJMqdCOMcs1Dn1q+XfDvwP2/sMVH2maQLXjbJzfkXwHh4WN0BurHwVx7cYTmJ2va9g8YQRTxX/BdGP70UbxD3BOZ/6TVJE9OyUACYhNVZfN7opU8yn3wPX9G1+N7J7wGArHgiNeHrz97KELW8p3Oa/HzfgwvdEXlYfQe6A5seWzsBeFEvcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJKKqVfAjX5PWwwKAK7uVs21vcu3dYerlaGHxHm/1vI=;
 b=XIeZmEUB5TqXk21fJc+g9VikLlfOAbEkjK5++OrLnkk6IehbGrdjEEUAkVsd9U2bIZxCaYLvzDOIFIpaJi9aUEf6ihOcB2nwrjWSB6Ukbgzf0jkbFyIv2Pjoe1lrUUPoJMQ4Ob7b/wzoAFGMyUMCs9y4qVmwAejgYHPMHPYAOUY800hjm+6uxoEifome2ATUmiG+onTzBoohqGjnGcnhU1CT6iy58VVHN+CwtJVu6ZzYVgBYhUpOVky5WFjDXUXvbIs9dUyaowOmz7aLsRElMVJ2CcymKJ7Pg51igeMSYEGV7f1FzRoSwc6H25F4J4LSC0hPmreKSTksrkc+LwsYUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PJKKqVfAjX5PWwwKAK7uVs21vcu3dYerlaGHxHm/1vI=;
 b=dz9MxRFa+31XA1xfvIAVPw/4M6qSsJgTH0BvxCiCky9ZxHknNUWyO4kIaETFWZp4jEs2y0B9pehZqE+o95fWe+AQ08oya7N/FWChCNmdKQDD8wLuHqpi8s/ueWiDRETOoL7cxKtJb8C9F6VEApC2RlgsxgywvnOvEmptpmY0U5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10138.eurprd04.prod.outlook.com (2603:10a6:800:242::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.27; Mon, 24 Jun
 2024 18:55:57 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.020; Mon, 24 Jun 2024
 18:55:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 24 Jun 2024 14:55:27 -0400
Subject: [PATCH v4 1/3] spi: fsl-dspi: use common proptery
 'spi-cs-setup(hold)-delay-ns'
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240624-ls_qspi-v4-1-3d1c6f5005bf@nxp.com>
References: <20240624-ls_qspi-v4-0-3d1c6f5005bf@nxp.com>
In-Reply-To: <20240624-ls_qspi-v4-0-3d1c6f5005bf@nxp.com>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719255350; l=1796;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=xom/Q3xfIs6MEGezVp+EwKNwxIbMrLVo+r2BbHJc6Ag=;
 b=ds6pgWYJLc+WeFySdsnjMC9kS9ey9jjlIFm7dr+I7yx1KQ9RuAbBAOxxrdUNz1N/RomWv4BQk
 JCtsvyAj/hdDF6DTEWvNg37IByCj7GDAG+F5uL80aDQlIzgOic1yU6+
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
X-MS-Office365-Filtering-Correlation-Id: fa926f46-26bd-48e1-a577-08dc947f47e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|1800799021|52116011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHdHSk9ndDJDNC9jYnZTcU1BZlkwc0dIOWhvOVVJRWJGK3J5a3JJblhhVHhV?=
 =?utf-8?B?QmZZSGVVKzUxM0FxMmFaeGxmbTBRejIrSVd4QjJLMjdKalZRbHNjcFlRQ2ph?=
 =?utf-8?B?SkJ5eW9DMXVzckRiU2tSRmFvMCtPcU5IOU5wZENJbmdSTzRvR0pOaDg5ZEhL?=
 =?utf-8?B?UE8wZS9JcThDNEhXWVpMNVRORjE1V2RPZzc2ZnpOWHBjVGcxbGpFdXNBVXps?=
 =?utf-8?B?RjgxMHR6WnAxUkkyc3AxbjM4NUJ6bnZ4TGp2a0tWT0E2Y0FoV21EbnhOUTdu?=
 =?utf-8?B?c2NoV3BwaldINEcyQ08vQjlrTmhJU29tT3NQNzh6S1N6N1I5N2xqeUM4aWEy?=
 =?utf-8?B?UE5vTkFnQlFxUjBrNkdwSkpCQW80WjdkT2Jzby9NeU9QMVJvSE9FcXNFVlhF?=
 =?utf-8?B?QkdOcUE2QnZ3OW0vK2NmSWVVcVVCbW8rVnZnL2ZPcDhIVWJPK2RXWUlZdTNw?=
 =?utf-8?B?Y1BUM0ZYdktEU25GV1JZL21hdG5vVmN5UGFzVjRVbHBmN3lva292OEFZeFRF?=
 =?utf-8?B?bmxRdXNnaCtieUYzNDZjbVhMZ3A5aVBnZUlOSjZtRCtqcitzQTRLd3oxdFJv?=
 =?utf-8?B?UDVTYnBtdnRSaGpRVzVHWUl5eXlPNTAzYXFjUGxlWTJiR1dsc3VaaG5HclNP?=
 =?utf-8?B?c2xKd3p4THlNYk9oUUxhdE9oRnJ6akoxaG45R3c0RWlZZXNISElkN3c1aWts?=
 =?utf-8?B?cGZhOUo3ZGlaWEF6U0VKY0tGU1BNK3N6N2NSMXI3dVR6aEllRlRjZkxKd09G?=
 =?utf-8?B?N1ZweFpURFkwOWdEak95K3hsY0lXemJZT04wNER5TnhXc2JHTEt0ek5kYnV2?=
 =?utf-8?B?YjNZUDRob1FuWnpOaWxCT29zRHBWVHpsTFNObExMYzhhQ0dDMkVQQS9lUVIw?=
 =?utf-8?B?MVdndnJCRTk5dkdUNG00TzhxMXNPWlAyYVRtSDZabExkSWpJNTBNOWw0UXpL?=
 =?utf-8?B?cHdFYVkyb3FtRGJLaUdLRENrbVhFMlVNV3NtRVQ1VmVEdXpGWDFoWHpmOWpN?=
 =?utf-8?B?YTlxbUtoc1k1dzIwSGJpbmcwcHVtMU5WVG8waEY2Q0dkV0k1VlpPVzIvZ1I2?=
 =?utf-8?B?RjhDK016M0xQb2I5c0dGV1FZZ0NuNHNWNEkzYWx6QmEyWFZzYnQrK2ZJUTZh?=
 =?utf-8?B?TWhnOXZWeCt1ZkVRSy9YN3JDbmpnc213bVp6ZVZodWZvVUJtcTkySjBFcmJX?=
 =?utf-8?B?aDNSVS9haDFjL3hoNDZQVkFEajBtc1dJMUZqdEI1MkdTb2RPNDZ5LzlIQmR6?=
 =?utf-8?B?eTNaZnAvOGM2WjhXRURaTDhKaGJGWVhzc0RyQ3l5ZUpXbHNzaDcyQklzWDB6?=
 =?utf-8?B?Y0Zka293b3V1ZE1BUWVvWmlvZjZuZlZEcGM5V1dIbnY4UmZhdi9WMDJVSmo1?=
 =?utf-8?B?OGk2OFQzRjlLVkhLQmlrR2dtTFFId256dUY3aGlJS2sxYm9TQUhabE1BSlFv?=
 =?utf-8?B?RE95ZUZFZGxITTlPNmpkdy9zenNJcS9adm5jZ2EwRS85eWJCTXpTdVIyQXhw?=
 =?utf-8?B?bU5nUjg2YVZsNUYzY2svZWZ4S2V1TVU2L2VESEdnV1BDZHBpTGdVTTllRHZ2?=
 =?utf-8?B?VU9nbndUMHJtWGRpRDBuMEVxYVNxelZWWGNMNC9JNjRoOEpIS3k5V1hmNmFT?=
 =?utf-8?B?WnkyamhmcGxMRkNWWWFydGNRR3lBV0RPKzJodUpWUDdEbXJLWTJHUENvTXAr?=
 =?utf-8?B?WFhqNk1xRGtlSk1TY1dOV2VMN0dmbDFrM01MQ3ltNDlRdGxMd3ZveEZmZ3Iy?=
 =?utf-8?B?UTVUL29kTnFiWVA3aTFqc01mVzRmTHFhYmZwcTBHdUV5akkrMnU3VXR5ZjZP?=
 =?utf-8?Q?jsUf9wftWWoDgEnD6HHrGZKxEld8wrSeDGxWs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(52116011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a20reDJielpJeFdHOUZVSmFYWmVENFNMTzAwdVhsTnZrRGVUVkttUFN6ajVp?=
 =?utf-8?B?TGFUUXBISzRhaERQL0IyR25USkpobUp6NkJOd3YxbjdNR3ZBbW1DSTlueGU5?=
 =?utf-8?B?YmRHTlQzUVl2NjBucmx2dEk4RmNDSHkraTZ6WExmbjlrOVQyR3FYMkNVRzdI?=
 =?utf-8?B?REVIMDRDT3A3dFU3eFo3Ui95cE5GR1JlbWYxMk1zNUo2ZFVpczBKbXBKS3ZO?=
 =?utf-8?B?U2hHZ3ZEK2laQm1zRWpUdzYvNzNUZkxsUG1iMGpWNDU5THc1dE5ZVkdTQ3I1?=
 =?utf-8?B?UW9zM1JhcHUrMnBsWnNxK29GbkpYZW8weVptLzFHeDQ5ZmI1Ty9pNjk5MXpH?=
 =?utf-8?B?cjJPbmVYNkRpNmVRZ1djS0pwZklDWDlPemlJOFlIY3NoWG5MM3RweWJ6V3FE?=
 =?utf-8?B?NFBmM2ZCakR2enZNUWhUK1gvZ045aDYrK1cxZldSWWU5c2NZUU95M2F2eldy?=
 =?utf-8?B?ejRTSXM3b21ZTDV5cWo4RXRUZHN1VGhXOVpEdFZZRDk3aUhwOVl2YUtZejY2?=
 =?utf-8?B?ckg2U21VYm15TXZPSXJxTjR1Q0txdk5LbFZuV3RMS05RNmNuSUZvdkdGNkdu?=
 =?utf-8?B?MFIxRDljb2JkNGhjR3BicWZwZWd3L0dxdG1lNXpkSXo5S3FUbUh3eGpCVVNM?=
 =?utf-8?B?aUs5ZCtyMXpqRy9kZC8vN2REVXIxS3hlTVBWWEZ1YVZWMkxQSmo1UVNveUhC?=
 =?utf-8?B?Qk9nUm5WZitzQ2RVNFEwQnNwS1N3WjhyMGlzRE95YklwTU1HaEhvQzVCaFBG?=
 =?utf-8?B?c0svRnQycEV0UmtFek5hVkVUNWs4bDQ5Z3ZyMzFwNmgwa29hQ0FIbEIzc0JK?=
 =?utf-8?B?Y3g5d3VZbXhxVy9YdXp0Rjh3QTN6bTd2S0cvRzgzcERNMkdTbEdxQ2YxczRu?=
 =?utf-8?B?cEptNXU5VXBVb2xnVGEvYUNvV1JuMlkyN0RaU056OFQ1Y3lMQWFKZ1ozRVd0?=
 =?utf-8?B?QU15NDAvakdoNklpQVh3YldialgvUGV0RUU1QmF3WmtkdlE4NUQrT2UvT09p?=
 =?utf-8?B?c3ZXS1JXUk5wT09tU2tnMXFIQWhseFVaUkcxaVozKzI2ck5MWTQ4RmhFTlVr?=
 =?utf-8?B?ekxORXNBOWhrdmdXSkZVNzJiLy95eXJMWWJRdC9DUDl3MitSei9rMTJtL3hP?=
 =?utf-8?B?NkZseFBBcFZpOHFjUkdWamRLRi9zSis2OW5rZ08rWU1lcjlYbURYampmRHZs?=
 =?utf-8?B?dStoNS9wQUtlQ3hteG5HZnNUT05zWFVsNzBKMmRiT1pITzVHNDRBRm1DTU5E?=
 =?utf-8?B?VEtQNytjaHlYUEo1RUs1ZFIwa3dEZ2pHazUxOVhHVjZLUFFjWE1aSFRMeWMw?=
 =?utf-8?B?ejJrN0NpNjRrUG0wcUZZM3BMQThMTlBuQVJCSE8rZ2l1QXNTVUU5cGVybG1U?=
 =?utf-8?B?U3R3eWZkTW9kRzArN3NLQVlqa1I5Qkw5aTU4SnQ5WCs0TW5BVzJVOXJLMjRn?=
 =?utf-8?B?VjRUbFJTd3lpZzQzWWhLR2dyS0ZUdXQ3MFlKK3BSbEpTQlhBbUVRenpwbWd5?=
 =?utf-8?B?Y3drOVNQQ3BXdTBMbnArL2JXNE5rRG51RVVzV1loS2NyTk00OTY5czh4SlBq?=
 =?utf-8?B?bHB3Uk00T1JyU3FrWFBkMDVraE1ZbldzWGNmM00vYjRhcXVBQ05ibWJ5WTNQ?=
 =?utf-8?B?b1BqMDFuNGFDK3hYakN4VTlxWVJkMWk0Rks0Y1lIdWNUSXlrVHNNdkJXQVgr?=
 =?utf-8?B?bmdpaFhzNE9yT1BKUG8wSXZpa2JoNDlJTFRzZDlUOWI1SVJpNkFxQzF0L0ln?=
 =?utf-8?B?VHpYVndZNFNiUWU2Rzk1cTZnMm9IYmRlSVRneHRYZjNYUmZRN1FwOXhhWUgv?=
 =?utf-8?B?MlR4cFZXVWNBZ0tGRDhDNjNpS0EzUFFTNVpJVkZadjFmZ0NTYkkxWjhtN2N6?=
 =?utf-8?B?U0lCUGNIejVuN0t1WnRwV0VxZVJaSWVjWGhCaW93USthVFZBUkE5NWRJZit4?=
 =?utf-8?B?S1lnV0laQzNTYzhGZERRUmVDK0pFR1A0SzN5SVlQdGdQY1VxY1VyMjNBa1px?=
 =?utf-8?B?YkhTWGt5ZHg0eTVOYnduVVk1WmExWE5tWENVby9aQ3FLOXJaNW5QZTU1dCsy?=
 =?utf-8?B?NlBUTlMyUGc0cEU5UEFRc0h6WUpCU1BRbXVsKzFSVmMzSGpEN1ZiUThQb2xE?=
 =?utf-8?Q?+++QM1mZ8pVZmf4QIUiiU0hDm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa926f46-26bd-48e1-a577-08dc947f47e9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 18:55:56.8809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5MT7PxS8TaTDtPEbTttKt7KPG3GKS2xpf1LskO5YKpYEMq77eDMVBpnMNwn+gV/v5WOUq567jjKP9PPfKJMaaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10138

Use SPI common DT binding properties 'spi-cs-setup-delay-ns' and
'spi-cs-hold-delay-ns'. If these properties do not exist, fall back to
legacy 'fsl,spi-cs-sck-delay' and 'fsl,spi-sck-cs-delay'.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v4
- check spi_delay_to_ns() return value, which may return negative value as
error code. It will be very big value when cast to u32.
---
 drivers/spi/spi-fsl-dspi.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 0a2730cd07c6a..191de1917f831 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1006,6 +1006,7 @@ static int dspi_setup(struct spi_device *spi)
 	struct chip_data *chip;
 	unsigned long clkrate;
 	bool cs = true;
+	int val;
 
 	/* Only alloc on first setup */
 	chip = spi_get_ctldata(spi);
@@ -1018,11 +1019,19 @@ static int dspi_setup(struct spi_device *spi)
 	pdata = dev_get_platdata(&dspi->pdev->dev);
 
 	if (!pdata) {
-		of_property_read_u32(spi->dev.of_node, "fsl,spi-cs-sck-delay",
-				     &cs_sck_delay);
-
-		of_property_read_u32(spi->dev.of_node, "fsl,spi-sck-cs-delay",
-				     &sck_cs_delay);
+		val = spi_delay_to_ns(&spi->cs_setup, NULL);
+		cs_sck_delay = val >= 0 ? val : 0;
+		if (!cs_sck_delay)
+			of_property_read_u32(spi->dev.of_node,
+					     "fsl,spi-cs-sck-delay",
+					     &cs_sck_delay);
+
+		val = spi_delay_to_ns(&spi->cs_hold, NULL);
+		sck_cs_delay =  val >= 0 ? val : 0;
+		if (!sck_cs_delay)
+			of_property_read_u32(spi->dev.of_node,
+					     "fsl,spi-sck-cs-delay",
+					     &sck_cs_delay);
 	} else {
 		cs_sck_delay = pdata->cs_sck_delay;
 		sck_cs_delay = pdata->sck_cs_delay;

-- 
2.34.1


