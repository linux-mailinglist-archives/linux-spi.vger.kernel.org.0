Return-Path: <linux-spi+bounces-3397-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59EBB907BE5
	for <lists+linux-spi@lfdr.de>; Thu, 13 Jun 2024 21:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F36A1F24268
	for <lists+linux-spi@lfdr.de>; Thu, 13 Jun 2024 19:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284CE14BF8B;
	Thu, 13 Jun 2024 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NBYcw6yG"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284E5F9F8;
	Thu, 13 Jun 2024 19:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718305260; cv=fail; b=bmsMVjOlrnL0hrDFTC7JJmTt5V72z6HUxmA6ixXCTSZvioPr17xA8PYGQNHK1aKY5n5v8lmS5826hic+xOgFCq0jEmcyKdAJQq2/32LR0YZnkvcqYGFYtqAIxvoY+jsu6DARun48uWHydWMa5iV52AEF7Q+8YkQxXaLyfV8RMc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718305260; c=relaxed/simple;
	bh=1ZOLTYd9nKz3dWoCJmAdaERqxG9Ou/5gY0RXA9AdHIo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gXPabdaO+jQ9szFCS/GYgtmpqbCWs65SMXZ8ZucjjrJE832sLmgLD+zbRI4tQSBusltL2m1zhACjE9gE7pZBcrRV/fJQE6LcxswqZH8hocvKHK+dprggg1dMjts+W85uycwqAMyjULjDAvRt+P75OZ1IwJobhaqpBqSiSgBom5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NBYcw6yG; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K445UqfDJI51X14P18VydNEYxc/ge/2ir7kLOyWLKGBPT3NH4AhW5vCaHZAAjNHCwom/Ohb/G+MrUBj000rsZtj4yZoUHnChEohwUqR0KZEgG0YW7J1rLct2zd7ewXYu61eovX4OY/8ndWtfd8Yd30XGWCR3yiNDvlm1Xvwz/geGdH6FIUFupQmX3nIgLi6vKdHBnUsGBTNfD6Gcr98tCWMR0QJixUge8bm5cHlz3GBJl8UrgsD2JxqvpABW2LkOnZD45bdASN0kKKRkMZn1QbbfuTK2R6C504v6F7RXfclzmWQAVsIeRtQg/Z8aX5mSh3Y0Bb50GUWN6gObVUTvxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XUAB24xN6kjPK5ovZyDhtowkdtlZKMCF4c5Y7a2oS+g=;
 b=H+ggjTEfdXf+5Y02s7r8s1QIXvB4ZAcIKtTLKO9UZiXBWaIpz8R/6QDf+bEZjtB3ejMKEhS0PAhan9aUF+oX1gZWQoRsljc5TfSgnutxEPsX3awrprcYr2rXAdaPVKrBMuFzLqlObWXXhkuDLJShhfD8RylSaEaeKfbm32pIfFKRdsVwh+qSNPZUdhzpD395AtmMOuZ4wK3UM3ST91ZHCVzbE0rp2agV2YRK1nIaTfly77onx10uJvJVMUehO8H9SsP+sC+qNleW5V3Bqhg1261HhsBi5UuGhxmPwL2kXaYjIXWSPfqSfg6s/y0yGjrloMS4odSRc9UiiRnwawblDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUAB24xN6kjPK5ovZyDhtowkdtlZKMCF4c5Y7a2oS+g=;
 b=NBYcw6yGRii/aUzIwnyrI59G6PH9MqaHhp+dKoiDKhayRvSp/Rr4CTLK/2ryxJUSfDo3H3hO6yCayvXI8BAXIP7QG4EgGZgyGluf2S6eIlEGbNjLuY0srYi/amcKZW3+2jtyUWCSdrelk8YXU9JWZT+tZz3bhqdmK7nFk2l+3NM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9384.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Thu, 13 Jun
 2024 19:00:55 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 19:00:55 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 13 Jun 2024 15:00:37 -0400
Subject: [PATCH v2 1/3] spi: fsl-dspi: use common proptery
 'spi-cs-setup(hold)-delay-ns'
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-ls_qspi-v2-1-b288f6f5b736@nxp.com>
References: <20240613-ls_qspi-v2-0-b288f6f5b736@nxp.com>
In-Reply-To: <20240613-ls_qspi-v2-0-b288f6f5b736@nxp.com>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718305248; l=1322;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1ZOLTYd9nKz3dWoCJmAdaERqxG9Ou/5gY0RXA9AdHIo=;
 b=AigHny9H0acvhuIMW1lTlx9mJFrEZ5WuWDM01EOzUjFXuLy+g5t8qGmSZi7sV7BNo0b/iE1gN
 ss40sYh5ZuuATumuD0h1Wv0m0JUCL8+4dYUZZ4eCIxtARCs0gaie0Jw
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::42) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9384:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bbb6667-33f3-4712-3bff-08dc8bdb274e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|52116009|376009|7416009|1800799019|366011|38350700009;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aGtGVzBBWm82cGxmRHI5WWhzQ2lJOVdTNkNxK0trenZRUTh6SGUwT0dpUGRJ?=
 =?utf-8?B?dFJWUllWb0Zpb3ZHS3RSRGtOMnpOMTMrWFFtQTJ4TnczdWFBR08ydlViVkla?=
 =?utf-8?B?MDZkYk5FVC9vQytEMjNuaUEwblpzVXBaTzI3TTdaek5xWmxGT1VHajRvVTBj?=
 =?utf-8?B?K3p6Qi9ncnZ2NWRFS2JHeFR1UXMvaHBEMVU0Qk16UEp5N1FoOEJ4M25QMlls?=
 =?utf-8?B?R2NkOXBQZW81OHArYXV3THdLdnJmMHgrd0tlN3pKck9iUmZWSWN2bXhFTW9F?=
 =?utf-8?B?RzlrSmNGd3gwNWlIclVBbjFHVEdzNGJFZlpET3lpOTAvMFptMXpaakxoamRj?=
 =?utf-8?B?M1lzWDR1T0tSV2V6WTBWc0QxL2hSVWZCbGZtVE5IemtzQ3kyTHdYTUVMQUZr?=
 =?utf-8?B?VzYzVGRkTk9jSFhHK0JnT3J1cms0c1hxRXlKNzRnNHBsN291b01WRmxrKzFB?=
 =?utf-8?B?cEZ1eVljekl1TUZXQ0pFSUFVdEd4Zk5XMkttUTJHWGNCTzZxMmxuRXlCRHg3?=
 =?utf-8?B?UTMzODIyM1dRZGlkaFhFRDVlWm1WOXNjTTNvOGorT0NXR0FHenRvYmZuY2pZ?=
 =?utf-8?B?Q05zUDM5Nzlja1YwNDJxaXdFTVEvenI0RVpJUUxmN1J1SnhuazRzZmJldFY0?=
 =?utf-8?B?S3NNZXhPSnVvZVVDNXhQeHBHR1ZmVkZzU05YOXkveVJGd3A3alBPcXBlaHFI?=
 =?utf-8?B?V1N5KzZDQmlMQ1JBcTFmVUY2RFBJSDVpUG5hVlJROUpXSkJ1dEFwWElETjYw?=
 =?utf-8?B?RFA4QURodkVlRWx6OURBV1NraGtwOEZtNGxwODZSTFZqazFuTHNJbzd0c0kw?=
 =?utf-8?B?ZlRqSk9CYUZRYnhUV1pCU0F5UnExOXo5RTRGSjAzYTNZck5aN1JaKzJPSit5?=
 =?utf-8?B?Y2ZyL1ZqbEJFZ1pzckRpSUtpNjNZY3lFNEN1bzVoWGR4THdEVnk5Q0xldUNN?=
 =?utf-8?B?OVJtNGEvd1VyS292OGZVT2ZxenlYTmJoSDdoRHB3Q1MwRFRqRE5OMmpINjJY?=
 =?utf-8?B?S2t6cFZSQ3QxK2FYUEVWR1BtSlJQVWZvYzRPRDc2NHRHejNaN2t5YmFlUzlG?=
 =?utf-8?B?QTg4d2Vtd3N4OGdPaUk2ODMrcUp5UEZlbXozME13djM1TUh0N3hiQUppY1Ja?=
 =?utf-8?B?S3lySGdoZ3ZwOWNHRnEzcUdYZDNwMVkrWFNOeER4Q0FlQUpJNytacEtxZnNH?=
 =?utf-8?B?b3I4T1MvSjdYUDhDVDVneGlOZjJuSy9jektzT0U5ZTJ2Y1o4Y0FXS2ZpY3BH?=
 =?utf-8?B?NkNEcTB0ZEtUSFZCc05YTjJTaVNHNGNlWE1ibnRiUCtTOHZUNmdDWWhqZThh?=
 =?utf-8?B?K1ZXSGY4RGpyRFgwdFk3QXAvZnpidnh4Q0NoWXI4REkwN3NJSmJzNkh3aUhY?=
 =?utf-8?B?NkN0ZGFSdEd6eW1sUGNlY3lVb2dwV3pNbzJsekUxaGxlTjQwSkJKTnRDRzdW?=
 =?utf-8?B?bUVxME8vb3hsaHJUZ2gwT3h0WWJ6WU1SRyt6VStpK0xvdjZXZTMva2JJbGlp?=
 =?utf-8?B?Q1JVVnFUMHBxdWtSN21XSzUwRlFRSkhRNi9BaHhOV1E3SGJVNi9kVmt2ZTZD?=
 =?utf-8?B?cVNIUFVpOC9XdmliM014bDN5UVhWUnlrTlBFcGpETkt3eCtVQS9Eb0Z0a28w?=
 =?utf-8?B?VUJhYnd3UnlKMmpHUklFVFdmaXJKNDJ2Z1k3dENCTkJSUzZ6bkJpWEF4VDVI?=
 =?utf-8?B?RjB5VmZjZ1NmQWZsUENteHg5cytUN3BRQ3VVTUFlNDNEUFgwL1ZnajRMdjZn?=
 =?utf-8?B?a1hYYWc2TXBweHhUTmYyYVFYY2pCdlVPam0xd2tiellRMFhqMStiQkE3bmVv?=
 =?utf-8?Q?KgLntVJYCafG9iLJI/x/uFhLaRsL02+WozLZs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(52116009)(376009)(7416009)(1800799019)(366011)(38350700009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjlmQlN1UDZWcWJhY3FMamprWmoyZkwwdWxsbFVXNFh0Yk9rV0hNRGlvYThK?=
 =?utf-8?B?ZkJvYWRBdHVpSlNaMERqY1ZiOTdNWGlxc3NFeDJXRzV0KzlQYkNINVo3bWlj?=
 =?utf-8?B?R3pFOVVMK0xWN3pxOWF4MXJmRWU4TGd1NGxZVXMrdDJ2b0tzV3JtV2JjcXc0?=
 =?utf-8?B?Q1JxZHhlS1ZPYi81bk0xMk5YR3duN1hmZXpTbmxZQUJJYXpMN0hldHpMT1Fl?=
 =?utf-8?B?ZWxjYzhKbUlCQ2JnWnRNelE4ZGxpRm8xcnlvRWg3K3lSbWJJSSsyNHgvV0tW?=
 =?utf-8?B?U0pHZ1Q4TGcvNklqeFBqQjlnVmdaMXc3YkVFN2dDeTVib3dIUE91Mk5TVXFi?=
 =?utf-8?B?eEQzUUtmOFFBZGl4WFViUWFhYnZEUWFwNlhWeEtvajdrRU1XQ0dZQU5zdnh5?=
 =?utf-8?B?UFRtZzYxaVhiSnhsNXROQ2V2MXgrSFQ0dFlsczdoZ0ZsZGk2S2d3bFFCV2pO?=
 =?utf-8?B?dDF3YW5NQmhXd3NCTHprV25XZ3BoT3pzdmNxQlJSbG9sTFdxNStPUHBnUTNw?=
 =?utf-8?B?aU1HZHVkY25GaTZtRjltMVdFUlRUaElkU3ZES2xRQjZKaUY4aWpseDJZMHZP?=
 =?utf-8?B?WTFDREZuMFBnY1ZHelFkOTkvdldxemxEVmVqVGZoWjgzazAxbXRCenphc2tz?=
 =?utf-8?B?cVd5ZEJRazR0UXJ0UHRRZU9aSzlvQ0hTNGJBc0pEYlFxTVNRdHRLZU8xQWRi?=
 =?utf-8?B?SVdwWWo4Y3E2RmVuWVZwYXVqVjJ4clA4K29jdUNuVnZFeFVHVjVDZ2Q1aW1k?=
 =?utf-8?B?SCs4NkRObEg5RWR1VW5idjRZbmYzYkFnZm1HUjhiWXl4eGxoRU9RY0llNzJw?=
 =?utf-8?B?bk1TbWRrUkY5OUJLc3lGM2RCZTcweThFNWVndWJTTHN3RjllWExDazdBNHln?=
 =?utf-8?B?NWpIUlpseFpQVnFLWU9TV3p1d0U2dU01YUFKWnlIQkUxQUYyanYrOE0xNDlz?=
 =?utf-8?B?WTZweDk5dHZVWklBcnJuVFpxVGtpWEZMbFd3WG1UQzVjdk9sKzhOTTUyZlNq?=
 =?utf-8?B?TjBYSkRRZTV3RUdycGZFYUp6NmlobmV6TWhuek5TODFOSkY3LzRiNFducXUv?=
 =?utf-8?B?S1o0RXpqMkJKYWJoUVRCS0FxWFN1Z3lNeUx0amZkUmVRcFlJejRCL2t4SFRt?=
 =?utf-8?B?U243UGZKMjY5NnhzZGVzeGVlWVRvMGhkSzJVUVFBS01HQ3JsT2Vwc1hlSU9y?=
 =?utf-8?B?Z2JvaC9BQld1czJmdklzT3F4WnhWWnRIZHBHY1pBQytQNUVpTjhld1ZlNkg2?=
 =?utf-8?B?eWtUY2pqNDhhRjd6dnpvcW5iUkFobGl6WWs5RnVkOGZiWDhNR3ZmOVF6NVJo?=
 =?utf-8?B?RE5vRHovdW44azF2bFZ1RkxDdy9zNXpGZGVjRXVxbWN4WkxkKzZxS2JIR0Zv?=
 =?utf-8?B?MitWU2hxMExtMFUrSWVDNGpkclNHRE0zMWt4SmVQVzB3YUJpbG56Ukw4c1ha?=
 =?utf-8?B?V3R5bnlPclo2Z1RPMC9PWmhKanNsRUpYeThxUVB2V1NjRkp0YThyZ3lOSFIz?=
 =?utf-8?B?UzM5TFJpQ0RCdEMyb0tnM0FxUS8xYWZnWkcxY0ZSVHRPcit3WEtERkw1Ritm?=
 =?utf-8?B?VGhDZUZka1YzdmZ6cy84ZUFCYVpHdVNCa2RPZkdjM2kzSzlkeUtnSVB0SFdW?=
 =?utf-8?B?bHN2OVovZ28ySHFpMVM1bnJDTW5qUmJTK0lVTVRaWGVEYkVYNTlsQ1daZkhF?=
 =?utf-8?B?UlFHbFMwcitLTzNkNGJXOEloeEJLMm1FZVJWaTA1d2lQcGl2b0xudDFsSXow?=
 =?utf-8?B?Mk5TekorNWRmV1V2TlN3UGU0UmUwN1ZicllORXF4anJMZ1IwMjFidmxWcE9t?=
 =?utf-8?B?cXJDY0plWlhEamtwaiszOTZsTVVkNjdWUU1aa3hjeEc2WjQzUnlrbDlBSEpp?=
 =?utf-8?B?OW9JTkRoSzJHZ3R0ZHdUMDVZSmRpMzhzM20wSzFLQVprVER5YWMrOExEQksx?=
 =?utf-8?B?YWlRN2xsc2pMVEZIOHQzaU5laU9CeGtaWHJNSlFvNkJwdTByeS9VUHBpZk9r?=
 =?utf-8?B?QlF6SUZYRkV5NjJ5SHhwYWFJM1RNOXdhRURkMWJaTVdoWWJHN2xaTDBobVZq?=
 =?utf-8?B?eklHSmZuREdaWDJoNWd6bjZRMWJ2eDkzS0pqNEl0S1JtODdSZDJBUEFqNlZE?=
 =?utf-8?Q?vccA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbb6667-33f3-4712-3bff-08dc8bdb274e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 19:00:55.3959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kf1yL1RFvoB0hR/Kk4y8+pNB/fuCK3X3KeZAPq3aiRICEjoa+uquSKOvPAmNtwJsm2Zs7SdAqtXqyd/EK0HJXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9384

Use SPI common DT binding properties 'spi-cs-setup-delay-ns' and
'spi-cs-hold-delay-ns'. If these properties do not exist, fall back to
legacy 'fsl,spi-cs-sck-delay' and 'fsl,spi-sck-cs-delay'.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/spi/spi-fsl-dspi.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 0a2730cd07c6a..7c1f8af9d215e 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -1018,11 +1018,15 @@ static int dspi_setup(struct spi_device *spi)
 	pdata = dev_get_platdata(&dspi->pdev->dev);
 
 	if (!pdata) {
-		of_property_read_u32(spi->dev.of_node, "fsl,spi-cs-sck-delay",
-				     &cs_sck_delay);
-
-		of_property_read_u32(spi->dev.of_node, "fsl,spi-sck-cs-delay",
-				     &sck_cs_delay);
+		cs_sck_delay = spi_delay_to_ns(&spi->cs_setup, NULL);
+		if (!cs_sck_delay)
+			of_property_read_u32(spi->dev.of_node, "fsl,spi-cs-sck-delay",
+					     &cs_sck_delay);
+
+		sck_cs_delay = spi_delay_to_ns(&spi->cs_hold, NULL);
+		if (!sck_cs_delay)
+			of_property_read_u32(spi->dev.of_node, "fsl,spi-sck-cs-delay",
+					     &sck_cs_delay);
 	} else {
 		cs_sck_delay = pdata->cs_sck_delay;
 		sck_cs_delay = pdata->sck_cs_delay;

-- 
2.34.1


