Return-Path: <linux-spi+bounces-3398-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0589907BE8
	for <lists+linux-spi@lfdr.de>; Thu, 13 Jun 2024 21:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355981F2429C
	for <lists+linux-spi@lfdr.de>; Thu, 13 Jun 2024 19:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFED14D420;
	Thu, 13 Jun 2024 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="E5reWWgS"
X-Original-To: linux-spi@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB2414C586;
	Thu, 13 Jun 2024 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718305262; cv=fail; b=Z22Goy5V0OIatXND1WeC8dzaY2v4KgfDFkuMgyqiiClv1U6nJRtyMvzClXX6wnM3H0MOC/Cmn1JGLx2HCD787YNM8YTTAeZnr/yGR08Frm8SGMbg+rDip6phWqYkYsZjILVhXihGDRFRM7x8gxisS5eUGvmmBKIuvlUQxniUXhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718305262; c=relaxed/simple;
	bh=3kpVvZ7+OURsKTsSaz4XUDS0WqPemahfcN207RlHNzM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Tguq8M9b6Y0d3cGak7rs/ejW+ONeVm4bYVTu1wmYxy71xNSdKRFpSsWthsC+5Oi9mvgFAY/n+828Rm/BBftz8CW4jkHN1KJ2SrKstlfIqmjhOXobWgxQ0azp2uI1B+p5bpigYYAwNkexvCp6kquTD80OJoQM5nEgM5qmBotZNjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=E5reWWgS; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfSBpC0/9XWx4gh+yTkQQCV2w43gx4Sdo7j6RiBzXjhAlgZyP+oPoimk/c87s9m/fchtHYKZweswRr92AqRKkhcqx3VkyEzA2vMj0pqDqeZ6ktANrWlewEk7/xxWlvdo2XaRxzp0GWwc9jM04DMxhkuxO43f1F+Ht4oxdLzwMpfjql5ifz1xZtL6ZRMq6PimyyBdKZ8AN4BejvjPvcY50Z8nDb6tiOaqyHRJ0+VbQ03Reg/ExB3kwr+Uuu5zPfvkbe+cDW9d2VkUly2MmmabHsdS6IutPI9Gwwp1C+4Z3zDipYDDvLtJF7R+tSq0WRiackRzqqeOZVYQn0q+sxTMZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDtADWTc9kg50HQBuTQK3rA2YPCUGjvoANTHpqA38gA=;
 b=Q2C75vy2ILJ5Xth4byoMQ7pdn9e3iwF2q47/t5Xk7aMNJaiQbGjxLAdFIOvBtk3rxORJKwLnHJiNq08X72TfMrU8z7UEh2PZtMK/vAYSRP+nbGTn9OP9NNvwCTPTSlLVjDS0TAJye5OlTiO34mSbRWN3ECyGlOyMEJ0+43AmUKlc47FuqtDePxcD/gTaYC6qwh/YL0cguZacttz9Co0SUCDP2+v8dCcn000kRMr7IbCLD8AI8TbTAeZ6Luxuu5BmUk3YqcL4wfVUwAG0BGRwZfZmugYl8XnQ+UzTPlU45UxjbKgfWh9hL+NnQ+22lNF77euOKCGJUiukdB4i7VWIFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDtADWTc9kg50HQBuTQK3rA2YPCUGjvoANTHpqA38gA=;
 b=E5reWWgSJ94RBSeH12Yt93ayHCDwUoZawVvdgqkY1LmQZymbcjraksv5edWbjufR6WJQeGaLBcw1TKtnv+jbmSMnosBvAUvm9PaEOH0cgV3c1Z6Z+MuxtzU8osZ3Rh1SCL93BxzcYouLF2he3Ii1ioWQ8YYXgEmuDRmQZl6nbsI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9384.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24; Thu, 13 Jun
 2024 19:00:58 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 19:00:58 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 13 Jun 2024 15:00:38 -0400
Subject: [PATCH v2 2/3] spi: dt-bindings: fsl-dspi: Convert to yaml format
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240613-ls_qspi-v2-2-b288f6f5b736@nxp.com>
References: <20240613-ls_qspi-v2-0-b288f6f5b736@nxp.com>
In-Reply-To: <20240613-ls_qspi-v2-0-b288f6f5b736@nxp.com>
To: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718305248; l=6289;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=3kpVvZ7+OURsKTsSaz4XUDS0WqPemahfcN207RlHNzM=;
 b=vq2e5E7bPq8Kk3+pfsTqhXj4v8wgKfNukl5HjF4nZULDJIaInAVyMyZBRKDeBfrrve1Lk0sDQ
 av2ivLZkpx8D/3Pn/q5FDqwo9PlJDsNxJ3CrnMX7/bYwdqe9aJZl2sT
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
X-MS-Office365-Filtering-Correlation-Id: c495db6f-a249-4eed-e750-08dc8bdb294e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|52116009|376009|7416009|1800799019|366011|38350700009;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZC9HR3Y0bWJvYitRd2V4dWxodkRVd1hYQTVGby96WCtwSEptdm4zY05HNk5V?=
 =?utf-8?B?UnJuNjRPUy83amV0T0JRc2hZdStpUlRmdVBDakJxaExJb0RCVkx3dWtZVnFz?=
 =?utf-8?B?SUErZlBQMWt0OTJiWVUvcVBOZHhNYmtiTS9JbnZuTHZOcVVSenliWVIrQ3Y0?=
 =?utf-8?B?MUsveXExNjFMN2RmOXVvSXBsZm8xL0pIdGdaNkxaU0hmc3FGV3p2ZzhjdGJW?=
 =?utf-8?B?SlNOelVvWlRzZVBtYXVMdWh3QjdCYVV6MVlma2F0WHFiU1pNVFFKQmx0RnUr?=
 =?utf-8?B?RUtpUHlSVUg1WHpPRTE1SWIzNEpxQmtxWkUyTjBwdWNhSjRKekxpeHFqaFdV?=
 =?utf-8?B?L2dJcGlVMXAvWFpab0UxRHdyLzFEYWdKWUtqUjlXY2VMenNzOHU2cHhNSXI1?=
 =?utf-8?B?cHRnVkhWNUh0NjZ4dGtMVy90cmNMbStGREdHTitJbjY1bzFBdlM1U2JyVUVX?=
 =?utf-8?B?bXlGbDZxdXN2TmdtYksvOUI3U1U4dXBTWkpKeHJpR1M2emd6bkpLcDRCWjV4?=
 =?utf-8?B?Y2ZDaHYxeXdZUFpyZ2lmdkVxR0N0cHN3amVRa3g2WkRFS0dWdW4rdVlxbUJz?=
 =?utf-8?B?RTB4OTVkVzRrZkVNL2VXT3pvZ0dyT05GY3E5alBvalJGeFBKdjF3NHdEa01J?=
 =?utf-8?B?QWs0cUhwSklDTHBQVWpZTXRiMWZIWG1xTithZmkyeURLQzJkR2Q1TUV5OHc3?=
 =?utf-8?B?WXByd1dHeUxxOVZmeTFRWXdGSUtWeUo4cEp4MWtsU2VDUnN6SmVVL1BlTGZk?=
 =?utf-8?B?cTJ1WnVOYjlueitjM2cxUnk3b3RiV1A4WEhzZ2Q3ZjNxMytmTlFMZHVKUzRG?=
 =?utf-8?B?WEtjd05mYjhLaVQ3azgvQU55UVhwUmRQcGRiR3AwK005T3FZYVZYRjJ1dVFS?=
 =?utf-8?B?S01GQXRyNExWbFBhSkpGRkJlWnVkZjdjdDZ3Y2swdzRJWUM3cHVYSS92WnJJ?=
 =?utf-8?B?eEhpa1IxNlNTcmpybDlGTVYxbURPWVFuOE9RV1ZYZkVGWWM5Q3lmMEd4bXdk?=
 =?utf-8?B?TVdRb1cvcWlkaWMvdDY5NnhpcmdjaTR4OUdzVHpiVjRMUWVBOFNHWGtmUFNE?=
 =?utf-8?B?UGYyOFBKdU1zc3BlU1hjbHhFMXh6OFdJTjZOdXBNL2JNaWZUZ1U0d3NGZVhp?=
 =?utf-8?B?Q0x2NjhPQzMrbnB5VnE3MkkvUTRsMkRsWE9oWXBwanRtOGlaQ1UxdlE0L1dZ?=
 =?utf-8?B?RjBVUUZUY2NSQml2L1ZsNjVCcFFCQ0NudFhjNHNuT3RkMTFqVGcrUS9YbVVT?=
 =?utf-8?B?RkwwVE10WGNnQU5RS2I0dXlpVnB1ME9oOUtFZXk0MCtzRHlWbUYxNEpYS0Zr?=
 =?utf-8?B?TmRFQTA2ZXRjSyt4TDNoY3dwYjVCM0VCQnB4alpLL21ldllTbXdOWUJ0TGpv?=
 =?utf-8?B?Zm1VemdVZ3ovQ3E0a3V5WDU5YVVHVndianJ4ZEk1WE80SFNXOWRkSjRFK0tp?=
 =?utf-8?B?WEdwVXZ6eGtjSitJNVZIZ2x3Z0ZORW1PdlZFSjZaaUtvTnZOYzBOQjMxcjUv?=
 =?utf-8?B?MGZXM21vdDdraDNyQXFkcExzZnBHSzBnQ2pPN2lFKytDMVlXNjFjTVMxSWtV?=
 =?utf-8?B?YVVoOGpxcDlleE04TGxBZ3FMekZaTGUyZ3BEQm04WkVPek9ZRmY4Mmt1MWk5?=
 =?utf-8?B?bUxTTjM1ODNOdjM3QlhzT1hNUXN4THFwVm1TbUVMcEhyaERjTmdCZHFmTUdU?=
 =?utf-8?B?M0RnTXRaeWpzOEhPc0pOWTRDMXhYUVcyWUpvbkZrR2lrbzZNR3pYdWpxTngr?=
 =?utf-8?Q?7DGABJnhWnT8B62Vz5M80/pwIEK3JQ65DubxELS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(52116009)(376009)(7416009)(1800799019)(366011)(38350700009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QWJSbHl5cXdOWGswWGhGWC9YdnJQbGVHV3RZMjV5WDFLZVIxMkNyaXpzNk1H?=
 =?utf-8?B?MWxQQnFDLy9Ia3g1TEFYMGpYcW1NanltdHp0bThmVU9EanQ2d1IrMDBqU3dy?=
 =?utf-8?B?WnZSUTVPNWxBVzVkRUM2U1RaLzNOSjhGQ1RQcWpzdkM2Z3JJZ1JlZlo4Q25Z?=
 =?utf-8?B?d1NHbFhoeFhCbHZxeVJhalpueE1hbXQwNEJhVkVSSkhSNG9lSHJjbXN3RG9O?=
 =?utf-8?B?dUFQeFdLMXl1S0I2NlBMU0dIVjN1dThLOSttaSs1VjA2bGdYSVplVm9FaTNI?=
 =?utf-8?B?UElySjhyWkp5a1ZTU3YyVHpOT0o4aXpyWGo3bmErTWE4bXoxRUhBdE1NeGNM?=
 =?utf-8?B?M3Y4WjVZRzhVSm14TDZCOUcybUphVnVMUlpEamp0bUpFV0FnemFkUU53Ymt4?=
 =?utf-8?B?dzRCT2dSbzM4TzRrdTBNRkF3eVlrdVQ3aTZwNzJiS2RzcUVmYlVRWEF6cUdD?=
 =?utf-8?B?OXJrRFlXUVp4K2JmYmZ3and3TXlCUkRhZWNzdVljVEh3WHkvK3Y2Q29yZWUx?=
 =?utf-8?B?ajJ6RFF2ajV6SHBWNnRLVFhHeEdaRlBkdkMvNXBIdWxrR0hIUjliMTlRQVdC?=
 =?utf-8?B?K3ZKSitxMnU3b2hIblBkaHk2S0YyRlpzZC9KUm1ydjhyUEtXWUowUlJ3bWZY?=
 =?utf-8?B?SnAydTJEZzUxME5vMStmaUdYazBOM0QyNWhGckNJOTJOZ0ZwTU5HdmQyNjh6?=
 =?utf-8?B?N0Qwa0F0cjNxRVY5V3RlSzh6emtkRkFPVEtvTVBMVWhTVVc5eC83Y24wQUdE?=
 =?utf-8?B?NFp3WmRtYlUrOVdBTkdjK01zd2FmNEdVVmo5M0E4N0pmMEhYbHdGSkF5cTV3?=
 =?utf-8?B?VURYQzdFSjVwOFY1TnVEa01tWmcwN0d2dHBHSEptZlZ5MWNMQndxNVZvSDlG?=
 =?utf-8?B?UHNDaHQwMEhsN3RNS0l2M1lnS1hNMEozOUlmOC9UZ0ZCRUZuV08ycjBRT3pz?=
 =?utf-8?B?UUk3Nllacm5JdFJnLyt6cml1bCs0eGtzYW03TVJVTW1zLzYrdmgzQ2szSVZE?=
 =?utf-8?B?US9GTTY5azlHR2FzWEpkbUlTNlpYa0dZd1BIWUtxWGhDWjZqQ3luRWg2SlQ4?=
 =?utf-8?B?WjFJU2U4bTdIamUvb09ZNGJJL0hnQklaYU1TVUw3MytwWDVzUzFqQWNOdVky?=
 =?utf-8?B?QXVKcHlJT0I3Zjc3Uk9PV25QanhUTVExZE91YmVWTjZOck1vWUk0NXNxQzBW?=
 =?utf-8?B?Sk8wUkxWTDNDZkNrOWJPSnJsdlVDVzNaekJDYWpod1dQVmViT0ppVnEvL0Z0?=
 =?utf-8?B?MFpHWWdhZVJob2pueUFTQmhaQ1JRa1ZPYVREVFpxL2pvdEYvTGNDd3dab0Zw?=
 =?utf-8?B?VE85U0NPY0lUbnFMcVBadGNPSXpQUVNWUXp0bVdUTXpqNWJmY2x6ZXk1NFN6?=
 =?utf-8?B?WURmb1FxVllYeFRaMCs2QXRhYjNqbjVOM0VONXRyV0ZSbm9DY0JiTXhQNGNt?=
 =?utf-8?B?ek9wdDlZcElmcVJDZTk5TE42QVBtcytRZ1dLVUppMkJmajVpNmd0cDFFQVAz?=
 =?utf-8?B?VVM5L3VZYzJhTnBQbGVSdlhNQ1BHRlJWVmNuK0Z1bG9JTkpZeXpPNThtdkxU?=
 =?utf-8?B?RFZKUFl5SzhBMndycnJoeVMrL2dWWm5sTkd1ZmQyRWVHeXdMZ2RHNTZHdWVB?=
 =?utf-8?B?NFhmSnRoTVZZdWlCZ3EyOHdraTJCTGRpWVBIL3BWVHdQQ3ZTMWRKbW95VVdh?=
 =?utf-8?B?bnp1U04wU0xtRFF3VTJFLzc2aTJ0TEpjTTlCUzJ3djJscGhrcDJnQkZJNUsy?=
 =?utf-8?B?dlBJZTFoWEJoVGhVWVJkdTI2NWhPdm5kNjMyTGlzVEVxNjZjNUNZREFKb2cx?=
 =?utf-8?B?N04yMUw5VXpvQmlyV1NuSUJlVWVNVXRKRHdiaUVqVGYrN2tBTnQ2L3BkVVNh?=
 =?utf-8?B?bmNuaHJMSTJsM2dTanM2NTVRdUhkRTJDRHl4L1M0VWV3T3p3a2dnaUxWYUg2?=
 =?utf-8?B?SU1xM2JTS09Ib0hjSUxiTlRVZG44VTh1YUJHcXlGdFB5dTMvSHAzTXZvSjhP?=
 =?utf-8?B?aXpEbmEvYk9PV2pRbEtpUGkrVExlUDZ0cDd6UVpTMWRTOUM3by9ZSzBkQzNt?=
 =?utf-8?B?RDFwTlErMWxzempsdlRmbGhnMVExU0ErZDV4c1JJQ0dlSzc2eWh1TCtLV1FC?=
 =?utf-8?Q?NVok=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c495db6f-a249-4eed-e750-08dc8bdb294e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 19:00:58.7879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0RuBXYbleNgIPo2ujgu2KdE+MhyaFnNz2nblgj1rwB/1j34Wlk23GO1vn1GLeiioSzkgxTFblPRie0tGeQXcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9384

Convert dt-binding spi-fsl-dspi.txt to yaml format.

Addtional changes during convert:
- compatible string "fsl,ls1028a-dspi" can be followed by
fsl,ls1021a-v1.0-dspi.
- Change "dspi0@4002c000" to "spi@4002c000" in example.
- Reorder properties in example.
- Use GIC include in example.
- Remove fsl,spi-cs-sck-delay and fsl,spi-sck-cs-delay by use common SPI
property.
- Use compatible string 'jedec,spi-nor' in example.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/spi/fsl,dspi.yaml          | 115 +++++++++++++++++++++
 .../devicetree/bindings/spi/spi-fsl-dspi.txt       |  65 ------------
 2 files changed, 115 insertions(+), 65 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/fsl,dspi.yaml b/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
new file mode 100644
index 0000000000000..924ba19aea017
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/fsl,dspi.yaml
@@ -0,0 +1,115 @@
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
+  pinctrl-0: true
+
+  pinctrl-names:
+    items:
+      - const: default
+
+  spi-num-chipselects:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: the number of the chipselect signals.
+
+  big-endian:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      If present the dspi device's registers are implemented
+      in big endian mode.
+
+  bus-num:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: the slave chip chipselect signal number.
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - pinctrl-0
+  - pinctrl-names
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
+
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

-- 
2.34.1


