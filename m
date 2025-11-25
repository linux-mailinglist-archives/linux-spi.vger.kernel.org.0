Return-Path: <linux-spi+bounces-11501-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D52C83C1F
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 08:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C47C634BF1C
	for <lists+linux-spi@lfdr.de>; Tue, 25 Nov 2025 07:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA152F5A2E;
	Tue, 25 Nov 2025 07:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QiuIRpB1"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013062.outbound.protection.outlook.com [52.101.72.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF382DA750;
	Tue, 25 Nov 2025 07:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764056514; cv=fail; b=gI9X8ssMJp59trzZju44bOXXyY/LkC5ksPWXC9o3LrWU4/9FZoyQN/A8RY3gNKMIG4DuwJ9IoPAMd6/pWSr8zhMdfYEM2vGHZOfzFHZHAsRfiA26IxuMjghwBumKpwHQVXhU+fD0/+BSzN/97J9uB3GixGIGhBx80EjchPaL/ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764056514; c=relaxed/simple;
	bh=ZG6Hfq0CbIjctEUsiUnJbydpLLoQA81rOCqHEey4FqM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VMTX0kFi+RIxlUjhnQbdVc5sbTMNNL+rr1MoBvesTF5jKVWnOpdeRtLw8i375IB0kTKW3GIfzcekGc6NQFWWWL/zJ23i8+GVW0iNLpb6JH/+lI6lfFPEL16pClh1ebVuuSnMIrzNONoR5w8Rmkle7InVocswTFwVogbmv88Bf4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QiuIRpB1; arc=fail smtp.client-ip=52.101.72.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S59/ydMDVAvuvCvKvbODxxQWgmSDgoIY2000P6Cmc2/s3uvL7gjXOQj/mCa7YT5EaPhSt/YelJAR7kCUwExbgna8b/bcNK3+WpvzutHDt/b71aJf3ULmZgbihqVgwwoeprr4VjR+dMiqBG2+4M3zqo2NpXsT5Zn/oyrA9eHSBny9zXBpTH4337z+/SmSmPHYxXaklViV+5VvrfPHr5nXknNqUb9k4jbM3Nm9PgBlrARi987G/OnMwWaTYqbAyM8W30W0cIsGoHzS5AcivvcEwW7u3YvjtRsidoXNWqotW7gHA5RiHsLMyXploG/Zj2OuLOeuqhKeSv8pIQDY4JJU3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2bQhmKEQ1zh86gzAzhSMDilNWd20m5Eh0U7swyuF4I=;
 b=Xo9/zbBdG4ATYyoz1UiOA6ep35G7VBwxCdg42fEc7J4mgr2TA9CuO+Cs4AMMoBDVc7nTx7tGhQ/YjAdCuIYhDCQgEyzLw7NqUTWCcLlhPYpP6PPKA7VXHt4L1eOoOGHBG9F1LrtcAkILYGN14ZnzysQbvuUG5K3feMiDk4ljhLoFzqCsCZzuplL8PbeoKt+sL0N0odVOOQTkWVKGHOUfYz9n8GmtkdM9sLybBFRHf2Jwj5FR7/i9EUzcIysPoY205MScZlIY7X3NAqGJ3yVOsMph7sdGFnchdQ1JWYhyQJ6AeILBfVBk0j4uGTUnKirdl+Wf30R3j2bO+bv/OJJFyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2bQhmKEQ1zh86gzAzhSMDilNWd20m5Eh0U7swyuF4I=;
 b=QiuIRpB1bQ0pnbcH/MfUbPJYX5rBNJUmSJv7aXd7il2Ltrn3Wv4KmHoNUMa/nEnAptbqiKkITkA7cj1vhNMxBN9tYLSZ2yWIq8yKLMn3FyXLXAkJ8fb74OC9C2EMFiECdTc3npq4L3nBBzvJcBu2++3iHbcBl3ldfqa7ibapuZaCW5CPFSJRvJ6Y46tVTUwGujga3uLhO9NSeE/KfRSaO/YUXjpE5YLilHWLj4kj0CdfaV/euWKNpatBK4FU91yVRQsUqmrEAhPvamiDtOXmVVSPpsa5VyldA2j1WuXzq5c8LOL3rlwfkdh29GSYqSJcoYZjWhsHfOjt0vAwpWMlnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PA1PR04MB10699.eurprd04.prod.outlook.com (2603:10a6:102:488::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 07:41:48 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 07:41:48 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Tue, 25 Nov 2025 15:42:19 +0800
Subject: [PATCH v6 2/2] spi: add driver for NXP XSPI controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251125-xspi-v6-2-22b22de50cda@nxp.com>
References: <20251125-xspi-v6-0-22b22de50cda@nxp.com>
In-Reply-To: <20251125-xspi-v6-0-22b22de50cda@nxp.com>
To: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Haibo Chen <haibo.chen@nxp.com>, 
 frank.li@nxp.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764056560; l=43660;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=ZG6Hfq0CbIjctEUsiUnJbydpLLoQA81rOCqHEey4FqM=;
 b=uued25nP1lwL3PmHK0/IzKK4hRUSTG/Fl27gu24jaNl0Ok6P9/+lIPSjUNqsIVICnvc4Hg21T
 I2Qxa2m/EZDDwJ5LEb0iylWfkSok1RBoykcJgB7Y2fspKb/BPJOZYo5
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SG2PR03CA0086.apcprd03.prod.outlook.com
 (2603:1096:4:7c::14) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PA1PR04MB10699:EE_
X-MS-Office365-Filtering-Correlation-Id: b268c401-0993-4ea0-8081-08de2bf61709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmNhVkhoYis4K0JFbFJON3E4dmpiOVg2dmVwVXlkK2h5Qm1DYmJsQkdFK1B4?=
 =?utf-8?B?b3ZaZVpSVHpvTDZya0RXWmVpYndGMjJ1MzhEdHI3TFdDOURRTnBNbTdXQXZZ?=
 =?utf-8?B?ajFZaVpLWmNqNTBKVkJtaXF3d2MyUEZjblBwc2piYXVaSks2dlRWVXNOcStY?=
 =?utf-8?B?MytIby9MdHNkRUhNSnRkS1MzOGZ5L1R6OXBCNlUyU2tya2o0WmFkeDhLZXp6?=
 =?utf-8?B?ZUU3UzQyNWMzSVVQOUtSdDlEK2QwaytaQkE0QVl2dldhMVh5eGNBZ0hZTFZ2?=
 =?utf-8?B?Q3FrYU5CbGV6djZBRnhCWFh0ZG8wQXVMV0s5NHpsbGlOTmZTYnY4V212dFBP?=
 =?utf-8?B?QjF2N2paWXhXczl2MHBFeDFHZUF3TlFCTU5jVHVPeDg4enNYeVdLOWpNTDNJ?=
 =?utf-8?B?bkZZYlI5UTZteHZGakpRRjVTWjBWSXJkYVE1VldKNHZYYnZIY1djWEVVZkhL?=
 =?utf-8?B?S0JsWFJhd1BRbCtMai9QNWkwY1RXMVI0R0hoWXFtSFlHWVcwWlpIQVowTXRY?=
 =?utf-8?B?THVucDNZTnVCYTlLZkhKQm1DNWUxSWNTYytJcFJ3L29yMnloc2tORnRmd3Jj?=
 =?utf-8?B?L2tUd29XTlBQYjh1eERFckMwSTkyY2trY2laRjlkZFJEczY1SnY0ZjNSTElC?=
 =?utf-8?B?NjBoMlN6emsvZmVoQmZEc2NaUWNzTC90aURPOE4vSktHMlpEcWw4MnlzZzFO?=
 =?utf-8?B?MWhaKzZXUzZwV1d1QVFETDhneVc3cWo3UVJTaGVGUGJ1eHhLTE5PK2Iwby9Z?=
 =?utf-8?B?OEN4TWpDc0ZHdThPUjdDNGU0SHJ2SXIxajZtekVab0hEelZyZDgzTWFLNm5w?=
 =?utf-8?B?d3IzWVloTC9jcnNHWTRzZ0hUZU1yaUJYOWZsdEJLbVhVUGM5SHVvSlBJVEJB?=
 =?utf-8?B?bUpFVlhNQzZsTEhNUndaNVl1WGZhczRPQzlEQTVkRTFRTmlRVWVZQ2k4UkxD?=
 =?utf-8?B?THlNVno0SnFoRFpZU2Z6VlA5TXlLc0s1N0dCeFFvRkk1MjIycnc1Wk9aVmFn?=
 =?utf-8?B?VEs4TDVBZGJ3enlnZHhlYUwra0xXREZUc0pRUlVGaHVZazZTYURWVlhKRjJj?=
 =?utf-8?B?aElMZE9HaVM4K2p1ajIwWGd6RFF3QmQ3Q05zMkljd3M1UE9xcjhhUmJReGxU?=
 =?utf-8?B?eWZHU0paam9QeGpqanNsRHlBK2J0bkFzVjJ2Mk5LckRLaysxMHBVVnpyMk80?=
 =?utf-8?B?eFJDaXRLK3JNbEllWHJMRnJWMCs1VEEyUTgzUUx4aXlDbGFyYm5jdFBKSk9u?=
 =?utf-8?B?elhLY2FlL2Vjckx4Um4vbXRDdHgwZHEyOWdzeCtHZENoZjhldUV1QndVR1dj?=
 =?utf-8?B?MktxNngwQjRUTll4SnRVNmxGY1dvQkRzc3NuK3d5ZTdJOVBxMk9RWUZUaGs2?=
 =?utf-8?B?R2xUUkFQa0ZCdGZHa2JmdjlTOFY5d2VlQkZndnJ6NE9lSU8zUjBGOXB6T2pm?=
 =?utf-8?B?aUJkd0FaS2o5SloyQzNxeHVVQmRjNDQ4dmZrNThtV0ZaUlVZR1RJTllZcjE2?=
 =?utf-8?B?dzNScmFSVWxUV0Z2OUNiSkFpdzRmalFaaUtZZDY0RGsvdnBqeXVrNXFYc1Bw?=
 =?utf-8?B?cWhhaTZnaFNpMldQWDd0Z3crVEJaV0xySklDem5pVVJNOHRSa1dZb3l0dE5S?=
 =?utf-8?B?UTNyVTdqRzVzQm5tMGllQW9DKzZHalZBcG5ITnl0NkdiM2VnK053dHJyakNm?=
 =?utf-8?B?UUliTERwQkw1Tk9QUVJybTBFbHNlSVVRY1NXQzRoY3l0TDVLZTBSQ05ZQmF4?=
 =?utf-8?B?TWEvMTJGTU1TTHRUUC9vbEFVcEgyQzFJMlZjcE92eG1iU3pUNzdhZU50ZjZT?=
 =?utf-8?B?c01MTU8xelVPeHJmZWdTWXByeVU2Q0xjKzU0bGZOTXlGU2Jhc0pweVRkTUg4?=
 =?utf-8?B?c3QrSzQxSlphb1l3Y0Nha3c2Z3NrcStEbnFGZmNlS3RhVThDQmg3RURzaVhF?=
 =?utf-8?B?SEtuMmRVUlhYK2pQK0ZkZ09CTlM3UjhuUnlQQmVkb2RvUEVEaWcyWDgzYmVO?=
 =?utf-8?B?cTJPNHAzT2R6OWdKb1FuZEZJRmM2eWRtUmc0TVZocStlS2xaZENmQXVNYW5a?=
 =?utf-8?Q?ASWhHb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0pGaGM0bEJrYVdFVFh0ZjRKNDZzZ2lUUTJPUUM4TWtSRG8vMWprL3N3ek5z?=
 =?utf-8?B?Sk1VOFBiQnFLanpPd2srWTFFYTdqUlJKR1VWU2E3Y3NtUW16LzJKQnIxUkFu?=
 =?utf-8?B?aTB2b0V0N3c0QWQ0ampjRGpJUGpzOU1Wa0NmS3BuejdPQmw3QnBoYjZvT0xV?=
 =?utf-8?B?RFdhT1g5ZVNHUVdCOEQzMXZQQjNYZ25wakhhc0VNL3ZDMWVhOWVtWVMrclVB?=
 =?utf-8?B?dERMWUpqaFdpbUtLSU5TOW1oYS9HZGFaS1pKZzFDaWk1SXRHejRZdXc0eXNV?=
 =?utf-8?B?UFVJZGZrRWEyb0RNL1VoekZ4aFhwV3lzamVaWktBZ3p6a0VkeXBGL2FJcCt1?=
 =?utf-8?B?TnZ6Vjg4TG5pT0JFNFdwY1IxQm5xZWVGV3YzcFBPOTQ0WmFYMmVYekdyeFI1?=
 =?utf-8?B?RFdpOERaT0J3Q2dLQ3NVM1pDZ2F1YXZDOHVZSjdWaGRaVEpGVm9ZMit5cEZS?=
 =?utf-8?B?T3J2aGFXc2k5OEo1YnZkK2VpQnd4TEU0d1A4dE5ITEpQNlVsSzZUdC9lUkd1?=
 =?utf-8?B?TXdXRVkwckVNVmJBcm54WWR4cUEwN1VpY3NFZ2ZqbWpuQ0RReGEwMkgxNkdO?=
 =?utf-8?B?MDFUendQWmJMWjZ5NXNLZG9ER0FQUk9ybmd0YXc3S0RvTkxRd3FZWEV6M1VG?=
 =?utf-8?B?bklvZkh3MTdWS2lvaXRqTTh0clBXdEFFejdQa29qSndkanl2a2U3TEl2Yk4x?=
 =?utf-8?B?UWRrNmZTdUNWZi92bExLQWQyOXVOb0c3Wm1mL2p2QmhhVXZKMTRJVXVkTlRp?=
 =?utf-8?B?REw4bXNwbDcxcmR1TFE4RGVKNWlTK0ZZTlRrN2ZtSWdiZU9tZWswalNkTG0z?=
 =?utf-8?B?citlNFpvWEpMSXpwNURIeGZKTng3ZnJ6blFibDhIMlY2dzQ1dHIyZjVvUEEw?=
 =?utf-8?B?WXREN3I2SXFZTFZ0YnVjdllXMFBpT2FhaHd2UHhlUVpyWndiT2pJMEg3UExQ?=
 =?utf-8?B?NzdKN05QRVNaU2poVW9nL2doSGVNR0dkcTdrYkxiY2Y2OXh2L1FKQ2s2RUMy?=
 =?utf-8?B?dHQzWmhZQld2aU5jUFpYUkNrUGhOVENpRnc0cU9QZ0pnQThWZWpQUE5ZRUU1?=
 =?utf-8?B?Tm5BemtXNlFBOVJ2Z0xXVDBmeFFudTlHcHBCQk5rbHd5dUorelRBSEk1R2dx?=
 =?utf-8?B?RGc4UEZNVmVzU3JpazJTZlIyRHEvODB3UDdFaFU2Uk9nbGZWcSthL1ZZSzNa?=
 =?utf-8?B?L3FMeG1UalJ6ZExJalVGTnZGMWlHY1l1VDJTM3FxL0ZDNXA1TDlKMElFMTdW?=
 =?utf-8?B?MzNyOEVrancxdGQzeFF5VTlHNzNKZ25uRjR6cFpuamlXdVNncENoQmJNb3l1?=
 =?utf-8?B?c1VIZ2xDelRGK3JYTkhjU3VFNWc3Zm56WVg2aFVEUjRHVVdHeFI5L3hBNkFu?=
 =?utf-8?B?dTgzSU9PK1FRWE9aQkZVSFhmQ0F6a1g5c0lCWWEvbmhNR0svbjRTQjVnSDRk?=
 =?utf-8?B?c2xoQnJGR3BVTlo1a3lxRGx1cUprQVU1TURkNHI2WDVaems5VDFSYVFiT1Q0?=
 =?utf-8?B?RWFwNkxndXRiMUZ6MnJ1TzFrb2RsNEI2TEJvb2ZwMCtPNHF6UFhVNEc4WUZJ?=
 =?utf-8?B?SnVvR0tuYUMxbGg4cGhUUEZuVGhsaWdvSS9pdTg1VVU5MnZ5M3Qxcnc1Mkwy?=
 =?utf-8?B?UE9OQnBZc2FKbWFqWHY0MUF6UVpZcFI2UFlvcDhzdXdVUGhSSEJsZzFqcmZT?=
 =?utf-8?B?MWtpYVVncDBBYVFNRXYvR2ZUVncybmlLUk9ZbFVUOVpiSDJKMXR6NksvTEUw?=
 =?utf-8?B?aUNwMm81OTZKK0M1bVBvSUlJby9ONzArVkhXUkFiRnlYa0w4TVZXb2R6Ty9h?=
 =?utf-8?B?S3Z5THR3cjNuWlgxaG1sZFBES1M2WnFnZ3VSeEc2b253MHBHREhFQy9Lb3JH?=
 =?utf-8?B?UGpaaGJza3AwN29iN1Y4OVB3Wjl4ZDgycnY4OURyYUhjb3l5WmpDS2g3cFBl?=
 =?utf-8?B?OUdLZGxGNnNFWW00WUtvNng5a0dDN25najlHK0ovenpONDZUeGlJMGlFdHgr?=
 =?utf-8?B?cmZwYzUwQ1RrNEsrZDg5bk12Y3BIN20zMVJzN1JZTDdUWGhUVW9kRnZWbjN4?=
 =?utf-8?B?dnNxZzVLdXNwMVZYR21weVViOS9zU2MxTDBQSkZnMzloTzNrRjBUWmRiUWFv?=
 =?utf-8?Q?H3jSPM/e+dt6EbjLieCtz3lo+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b268c401-0993-4ea0-8081-08de2bf61709
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 07:41:48.5625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9iu6YsbgiVniXLYrKhc9Nmt//InoLr7Gee50MXFzt0txD7AFF+EYv9IauJ3xRGx8jCNKVmCzHHe5f8f+hLBusw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10699

Add driver support for NXP XSPI controller.

XSPI is a flexible SPI host controller which supports up to
2 external devices (2 CS). It support Single/Dual/Quad/Octal
mode data transfer.

The difference between XSPI and Flexspi:
1.the register layout is total different.
2.XSPI support multiple independent execution environments
(EENVs) for HW virtualization with some limitations. Each EENV
has its own interrupt and its own set of programming registers
that exists in a specific offset range in the XSPI memory map.
The main environment (EENV0) address space contains all of the
registers for controlling EENV0 plus all of the general XSPI
control and programming registers. The register mnemonics for
the user environments (EENV1 to EENV4) have "_SUB_n" appended
to the mnemonic for the corresponding main-environment register.

Current driver based on EENV0, which means system already give
EENV0 right to linux.

This driver use SPI memory interface of the SPI framework to
issue flash memory operations. Tested this driver with UBIFS
and mtd_debug on NXP i.MX943 EVK board which has one spi nor
MT35XU512ABA flash. Now this driver has the following key
features:
- Support up to OCT DDR mode
- Support AHB read
- Support IP read and IP write
- Support two CS

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 MAINTAINERS                |    1 +
 drivers/spi/Kconfig        |   10 +
 drivers/spi/Makefile       |    1 +
 drivers/spi/spi-nxp-xspi.c | 1385 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1397 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f3ce467100d7600f498656dbe36b52a2a575cb3..3c6ffca0137f6a3ba705a2dcd76a6dfc0f2609b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18907,6 +18907,7 @@ L:	linux-spi@vger.kernel.org
 L:	imx@lists.linux.dev
 S:	Maintained
 F:	Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
+F:	drivers/spi/spi-nxp-xspi.c
 
 NXP-NCI NFC DRIVER
 S:	Orphan
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index e34aa246eef90ea9e43b58f603e50653e0fadfd3..09472a38b93376b09f6efb6ba90ebf6f7dbd6b4b 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -481,6 +481,16 @@ config SPI_NXP_FLEXSPI
 	  This controller does not support generic SPI messages and only
 	  supports the high-level SPI memory interface.
 
+config SPI_NXP_XSPI
+        tristate "NXP xSPI controller"
+	depends on ARCH_MXC || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This enables support for the xSPI controller. Up to two devices
+	  can be connected to one host.
+	  This controller does not support generic SPI messages and only
+	  supports the high-level SPI memory interface.
+
 config SPI_GPIO
 	tristate "GPIO-based bitbanging SPI Master"
 	depends on GPIOLIB || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 863b628ff1ec0b938be81dff024aa7dc7d50c36d..649dcba0aa1140da7d9bd969138859922a2e03b0 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -102,6 +102,7 @@ obj-$(CONFIG_SPI_WPCM_FIU)		+= spi-wpcm-fiu.o
 obj-$(CONFIG_SPI_NPCM_FIU)		+= spi-npcm-fiu.o
 obj-$(CONFIG_SPI_NPCM_PSPI)		+= spi-npcm-pspi.o
 obj-$(CONFIG_SPI_NXP_FLEXSPI)		+= spi-nxp-fspi.o
+obj-$(CONFIG_SPI_NXP_XSPI)		+= spi-nxp-xspi.o
 obj-$(CONFIG_SPI_OC_TINY)		+= spi-oc-tiny.o
 spi-octeon-objs				:= spi-cavium.o spi-cavium-octeon.o
 obj-$(CONFIG_SPI_OCTEON)		+= spi-octeon.o
diff --git a/drivers/spi/spi-nxp-xspi.c b/drivers/spi/spi-nxp-xspi.c
new file mode 100644
index 0000000000000000000000000000000000000000..25339492bf3a0d94f286d42e55f47e71ae1af472
--- /dev/null
+++ b/drivers/spi/spi-nxp-xspi.c
@@ -0,0 +1,1385 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * NXP xSPI controller driver.
+ *
+ * Copyright 2025 NXP
+ *
+ * xSPI is a flexible SPI host controller which supports single
+ * external devices. This device can have up to eight bidirectional
+ * data lines, this means xSPI support Single/Dual/Quad/Octal mode
+ * data transfer (1/2/4/8 bidirectional data lines).
+ *
+ * xSPI controller is driven by the LUT(Look-up Table) registers
+ * LUT registers are a look-up-table for sequences of instructions.
+ * A valid sequence consists of five LUT registers.
+ * Maximum 16 LUT sequences can be programmed simultaneously.
+ *
+ * LUTs are being created at run-time based on the commands passed
+ * from the spi-mem framework, thus using single LUT index.
+ *
+ * Software triggered Flash read/write access by IP Bus.
+ *
+ * Memory mapped read access by AHB Bus.
+ *
+ * Based on SPI MEM interface and spi-nxp-fspi.c driver.
+ *
+ * Author:
+ *     Haibo Chen <haibo.chen@nxp.com>
+ * Co-author:
+ *     Han Xu <han.xu@nxp.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/log2.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/pm_runtime.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+
+/* Runtime pm timeout */
+#define XSPI_RPM_TIMEOUT_MS 50	/* 50ms */
+/*
+ * The driver only uses one single LUT entry, that is updated on
+ * each call of exec_op(). Index 0 is preset at boot with a basic
+ * read operation, so let's use the last entry (15).
+ */
+#define	XSPI_SEQID_LUT			15
+
+#define XSPI_MCR			0x0
+#define XSPI_MCR_CKN_FA_EN		BIT(26)
+#define XSPI_MCR_DQS_FA_SEL_MASK	GENMASK(25, 24)
+#define XSPI_MCR_ISD3FA			BIT(17)
+#define XSPI_MCR_ISD2FA			BIT(16)
+#define XSPI_MCR_DOZE			BIT(15)
+#define XSPI_MCR_MDIS			BIT(14)
+#define XSPI_MCR_DLPEN			BIT(12)
+#define XSPI_MCR_CLR_TXF		BIT(11)
+#define XSPI_MCR_CLR_RXF		BIT(10)
+#define XSPI_MCR_IPS_TG_RST		BIT(9)
+#define XSPI_MCR_VAR_LAT_EN		BIT(8)
+#define XSPI_MCR_DDR_EN			BIT(7)
+#define XSPI_MCR_DQS_EN			BIT(6)
+#define XSPI_MCR_DQS_LAT_EN		BIT(5)
+#define XSPI_MCR_DQS_OUT_EN		BIT(4)
+#define XSPI_MCR_SWRSTHD		BIT(1)
+#define XSPI_MCR_SWRSTSD		BIT(0)
+
+#define XSPI_IPCR			0x8
+
+#define XSPI_FLSHCR			0xC
+#define XSPI_FLSHCR_TDH_MASK		GENMASK(17, 16)
+#define XSPI_FLSHCR_TCSH_MASK		GENMASK(11, 8)
+#define XSPI_FLSHCR_TCSS_MASK		GENMASK(3, 0)
+
+#define XSPI_BUF0CR			0x10
+#define XSPI_BUF1CR			0x14
+#define XSPI_BUF2CR			0x18
+#define XSPI_BUF3CR			0x1C
+#define XSPI_BUF3CR_ALLMST		BIT(31)
+#define XSPI_BUF3CR_ADATSZ_MASK		GENMASK(17, 8)
+#define XSPI_BUF3CR_MSTRID_MASK		GENMASK(3, 0)
+
+#define XSPI_BFGENCR			0x20
+#define XSPI_BFGENCR_SEQID_WR_MASK	GENMASK(31, 28)
+#define XSPI_BFGENCR_ALIGN_MASK		GENMASK(24, 22)
+#define XSPI_BFGENCR_PPWF_CLR		BIT(20)
+#define XSPI_BFGENCR_WR_FLUSH_EN	BIT(21)
+#define XSPI_BFGENCR_SEQID_WR_EN	BIT(17)
+#define XSPI_BFGENCR_SEQID_MASK		GENMASK(15, 12)
+
+#define XSPI_BUF0IND			0x30
+#define XSPI_BUF1IND			0x34
+#define XSPI_BUF2IND			0x38
+
+#define XSPI_DLLCRA			0x60
+#define XSPI_DLLCRA_DLLEN		BIT(31)
+#define XSPI_DLLCRA_FREQEN		BIT(30)
+#define XSPI_DLLCRA_DLL_REFCNTR_MASK	GENMASK(27, 24)
+#define XSPI_DLLCRA_DLLRES_MASK		GENMASK(23, 20)
+#define XSPI_DLLCRA_SLV_FINE_MASK	GENMASK(19, 16)
+#define XSPI_DLLCRA_SLV_DLY_MASK	GENMASK(14, 12)
+#define XSPI_DLLCRA_SLV_DLY_COARSE_MASK	GENMASK(11,  8)
+#define XSPI_DLLCRA_SLV_DLY_FINE_MASK	GENMASK(7, 5)
+#define XSPI_DLLCRA_DLL_CDL8		BIT(4)
+#define XSPI_DLLCRA_SLAVE_AUTO_UPDT	BIT(3)
+#define XSPI_DLLCRA_SLV_EN		BIT(2)
+#define XSPI_DLLCRA_SLV_DLL_BYPASS	BIT(1)
+#define XSPI_DLLCRA_SLV_UPD		BIT(0)
+
+#define XSPI_SFAR			0x100
+
+#define XSPI_SFACR			0x104
+#define XSPI_SFACR_FORCE_A10		BIT(22)
+#define XSPI_SFACR_WA_4B_EN		BIT(21)
+#define XSPI_SFACR_CAS_INTRLVD		BIT(20)
+#define XSPI_SFACR_RX_BP_EN		BIT(18)
+#define XSPI_SFACR_BYTE_SWAP		BIT(17)
+#define XSPI_SFACR_WA			BIT(16)
+#define XSPI_SFACR_CAS_MASK		GENMASK(3, 0)
+
+#define XSPI_SMPR			0x108
+#define XSPI_SMPR_DLLFSMPFA_MASK	GENMASK(26, 24)
+#define XSPI_SMPR_FSDLY			BIT(6)
+#define XSPI_SMPR_FSPHS			BIT(5)
+
+#define XSPI_RBSR			0x10C
+
+#define XSPI_RBCT			0x110
+#define XSPI_RBCT_WMRK_MASK		GENMASK(6, 0)
+
+#define XSPI_DLLSR			0x12C
+#define XSPI_DLLSR_DLLA_LOCK		BIT(15)
+#define XSPI_DLLSR_SLVA_LOCK		BIT(14)
+#define XSPI_DLLSR_DLLA_RANGE_ERR	BIT(13)
+#define XSPI_DLLSR_DLLA_FINE_UNDERFLOW	BIT(12)
+
+#define XSPI_TBSR			0x150
+
+#define XSPI_TBDR			0x154
+
+#define XSPI_TBCT			0x158
+#define XSPI_TBCT_WMRK_MASK		GENMASK(7, 0)
+
+#define XSPI_SR				0x15C
+#define XSPI_SR_TXFULL			BIT(27)
+#define XSPI_SR_TXDMA			BIT(26)
+#define XSPI_SR_TXWA			BIT(25)
+#define XSPI_SR_TXNE			BIT(24)
+#define XSPI_SR_RXDMA			BIT(23)
+#define XSPI_SR_ARB_STATE_MASK		GENMASK(23, 20)
+#define XSPI_SR_RXFULL			BIT(19)
+#define XSPI_SR_RXWE			BIT(16)
+#define XSPI_SR_ARB_LCK			BIT(15)
+#define XSPI_SR_AHBnFUL			BIT(11)
+#define XSPI_SR_AHBnNE			BIT(7)
+#define XSPI_SR_AHBTRN			BIT(6)
+#define XSPI_SR_AWRACC			BIT(4)
+#define XSPI_SR_AHB_ACC			BIT(2)
+#define XSPI_SR_IP_ACC			BIT(1)
+#define XSPI_SR_BUSY			BIT(0)
+
+#define XSPI_FR				0x160
+#define XSPI_FR_DLPFF			BIT(31)
+#define XSPI_FR_DLLABRT			BIT(28)
+#define XSPI_FR_TBFF			BIT(27)
+#define XSPI_FR_TBUF			BIT(26)
+#define XSPI_FR_DLLUNLCK		BIT(24)
+#define XSPI_FR_ILLINE			BIT(23)
+#define XSPI_FR_RBOF			BIT(17)
+#define XSPI_FR_RBDF			BIT(16)
+#define XSPI_FR_AAEF			BIT(15)
+#define XSPI_FR_AITEF			BIT(14)
+#define XSPI_FR_AIBSEF			BIT(13)
+#define XSPI_FR_ABOF			BIT(12)
+#define XSPI_FR_CRCAEF			BIT(10)
+#define XSPI_FR_PPWF			BIT(8)
+#define XSPI_FR_IPIEF			BIT(6)
+#define XSPI_FR_IPEDERR			BIT(5)
+#define XSPI_FR_PERFOVF			BIT(2)
+#define XSPI_FR_RDADDR			BIT(1)
+#define XSPI_FR_TFF			BIT(0)
+
+#define XSPI_RSER			0x164
+#define XSPI_RSER_TFIE			BIT(0)
+
+#define XSPI_SFA1AD			0x180
+
+#define XSPI_SFA2AD			0x184
+
+#define XSPI_RBDR0			0x200
+
+#define XSPI_LUTKEY			0x300
+#define XSPI_LUT_KEY_VAL		(0x5AF05AF0UL)
+
+#define XSPI_LCKCR			0x304
+#define XSPI_LOKCR_LOCK			BIT(0)
+#define XSPI_LOKCR_UNLOCK		BIT(1)
+
+#define XSPI_LUT			0x310
+#define XSPI_LUT_OFFSET			(XSPI_SEQID_LUT * 5 * 4)
+#define XSPI_LUT_REG(idx) \
+	(XSPI_LUT + XSPI_LUT_OFFSET + (idx) * 4)
+
+#define XSPI_MCREXT			0x4FC
+#define XSPI_MCREXT_RST_MASK		GENMASK(3, 0)
+
+
+#define XSPI_FRAD0_WORD2		0x808
+#define XSPI_FRAD0_WORD2_MD0ACP_MASK	GENMASK(2, 0)
+
+#define XSPI_FRAD0_WORD3		0x80C
+#define XSPI_FRAD0_WORD3_VLD		BIT(31)
+
+#define XSPI_TG0MDAD			0x900
+#define XSPI_TG0MDAD_VLD		BIT(31)
+
+#define XSPI_TG1MDAD			0x910
+
+#define XSPI_MGC			0x920
+#define XSPI_MGC_GVLD			BIT(31)
+#define XSPI_MGC_GVLDMDAD		BIT(29)
+#define XSPI_MGC_GVLDFRAD		BIT(27)
+
+#define XSPI_MTO			0x928
+
+#define XSPI_ERRSTAT			0x938
+#define XSPI_INT_EN			0x93C
+
+#define XSPI_SFP_TG_IPCR		0x958
+#define XSPI_SFP_TG_IPCR_SEQID_MASK	GENMASK(27, 24)
+#define XSPI_SFP_TG_IPCR_ARB_UNLOCK	BIT(23)
+#define XSPI_SFP_TG_IPCR_ARB_LOCK	BIT(22)
+#define XSPI_SFP_TG_IPCR_IDATSZ_MASK	GENMASK(15, 0)
+
+#define XSPI_SFP_TG_SFAR 0x95C
+
+/* Register map end */
+
+/********* XSPI CMD definitions ***************************/
+#define LUT_STOP	0x00
+#define LUT_CMD_SDR	0x01
+#define LUT_ADDR_SDR	0x02
+#define LUT_DUMMY	0x03
+#define LUT_MODE8_SDR	0x04
+#define LUT_MODE2_SDR	0x05
+#define LUT_MODE4_SDR	0x06
+#define LUT_READ_SDR	0x07
+#define LUT_WRITE_SDR	0x08
+#define LUT_JMP_ON_CS	0x09
+#define LUT_ADDR_DDR	0x0A
+#define LUT_MODE8_DDR	0x0B
+#define LUT_MODE2_DDR	0x0C
+#define LUT_MODE4_DDR	0x0D
+#define LUT_READ_DDR	0x0E
+#define LUT_WRITE_DDR	0x0F
+#define LUT_DATA_LEARN	0x10
+#define LUT_CMD_DDR	0x11
+#define LUT_CADDR_SDR	0x12
+#define LUT_CADDR_DDR	0x13
+#define JMP_TO_SEQ	0x14
+
+#define XSPI_64BIT_LE	0x3
+/*
+ * Calculate number of required PAD bits for LUT register.
+ *
+ * The pad stands for the number of IO lines [0:7].
+ * For example, the octal read needs eight IO lines,
+ * so you should use LUT_PAD(8). This macro
+ * returns 3 i.e. use eight (2^3) IP lines for read.
+ */
+#define LUT_PAD(x) (fls(x) - 1)
+
+/*
+ * Macro for constructing the LUT entries with the following
+ * register layout:
+ *
+ *  ---------------------------------------------------
+ *  | INSTR1 | PAD1 | OPRND1 | INSTR0 | PAD0 | OPRND0 |
+ *  ---------------------------------------------------
+ */
+#define PAD_SHIFT		8
+#define INSTR_SHIFT		10
+#define OPRND_SHIFT		16
+
+/* Macros for constructing the LUT register. */
+#define LUT_DEF(idx, ins, pad, opr)			  \
+	((((ins) << INSTR_SHIFT) | ((pad) << PAD_SHIFT) | \
+	(opr)) << (((idx) % 2) * OPRND_SHIFT))
+
+#define NXP_XSPI_MIN_IOMAP	SZ_4M
+#define NXP_XSPI_MAX_CHIPSELECT		2
+#define POLL_TOUT_US		5000
+
+/* Access flash memory using IP bus only */
+#define XSPI_QUIRK_USE_IP_ONLY	BIT(0)
+
+struct nxp_xspi_devtype_data {
+	unsigned int rxfifo;
+	unsigned int txfifo;
+	unsigned int ahb_buf_size;
+	unsigned int quirks;
+};
+
+static struct nxp_xspi_devtype_data imx94_data = {
+	.rxfifo = SZ_512,       /* (128 * 4 bytes)  */
+	.txfifo = SZ_1K,        /* (256 * 4 bytes)  */
+	.ahb_buf_size = SZ_4K,  /* (1024 * 4 bytes)  */
+};
+
+struct nxp_xspi {
+	void __iomem *iobase;
+	void __iomem *ahb_addr;
+	u32 memmap_phy;
+	u32 memmap_phy_size;
+	u32 memmap_start;
+	u32 memmap_len;
+	struct clk *clk;
+	struct device *dev;
+	struct completion c;
+	const struct nxp_xspi_devtype_data *devtype_data;
+	/* mutex lock for each operation */
+	struct mutex lock;
+	int selected;
+#define XSPI_DTR_PROTO		BIT(0)
+	int flags;
+	/* Save the previous operation clock rate */
+	unsigned long pre_op_rate;
+	/* The max clock rate xspi supported output to device */
+	unsigned long support_max_rate;
+};
+
+static inline int needs_ip_only(struct nxp_xspi *xspi)
+{
+	return xspi->devtype_data->quirks & XSPI_QUIRK_USE_IP_ONLY;
+}
+
+static irqreturn_t nxp_xspi_irq_handler(int irq, void *dev_id)
+{
+	struct nxp_xspi *xspi = dev_id;
+	u32 reg;
+
+	reg = readl(xspi->iobase + XSPI_FR);
+	if (reg & XSPI_FR_TFF) {
+		/* Clear interrupt */
+		writel(XSPI_FR_TFF, xspi->iobase + XSPI_FR);
+		complete(&xspi->c);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static int nxp_xspi_check_buswidth(struct nxp_xspi *xspi, u8 width)
+{
+	return (is_power_of_2(width) && width <= 8) ? 0 : -EOPNOTSUPP;
+}
+
+static bool nxp_xspi_supports_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op)
+{
+	struct nxp_xspi *xspi = spi_controller_get_devdata(mem->spi->controller);
+	int ret;
+
+	ret = nxp_xspi_check_buswidth(xspi, op->cmd.buswidth);
+
+	if (op->addr.nbytes)
+		ret |= nxp_xspi_check_buswidth(xspi, op->addr.buswidth);
+
+	if (op->dummy.nbytes)
+		ret |= nxp_xspi_check_buswidth(xspi, op->dummy.buswidth);
+
+	if (op->data.nbytes)
+		ret |= nxp_xspi_check_buswidth(xspi, op->data.buswidth);
+
+	if (ret)
+		return false;
+
+	/*
+	 * The number of address bytes should be equal to or less than 4 bytes.
+	 */
+	if (op->addr.nbytes > 4)
+		return false;
+
+	/* Max 32 dummy clock cycles supported */
+	if (op->dummy.buswidth &&
+	    (op->dummy.nbytes * 8 / op->dummy.buswidth > 64))
+		return false;
+
+	if (needs_ip_only(xspi) && op->data.dir == SPI_MEM_DATA_IN &&
+	    op->data.nbytes > xspi->devtype_data->rxfifo)
+		return false;
+
+	if (op->data.dir == SPI_MEM_DATA_OUT &&
+			op->data.nbytes > xspi->devtype_data->txfifo)
+		return false;
+
+	return spi_mem_default_supports_op(mem, op);
+}
+
+static void nxp_xspi_prepare_lut(struct nxp_xspi *xspi,
+				 const struct spi_mem_op *op)
+{
+	void __iomem *base = xspi->iobase;
+	u32 lutval[5] = {};
+	int lutidx = 1, i;
+
+	/* cmd */
+	if (op->cmd.dtr) {
+		lutval[0] |= LUT_DEF(0, LUT_CMD_DDR, LUT_PAD(op->cmd.buswidth),
+				     op->cmd.opcode >> 8);
+		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_CMD_DDR,
+					      LUT_PAD(op->cmd.buswidth),
+					      op->cmd.opcode & 0x00ff);
+		lutidx++;
+	} else {
+		lutval[0] |= LUT_DEF(0, LUT_CMD_SDR, LUT_PAD(op->cmd.buswidth),
+				     op->cmd.opcode);
+	}
+
+	/* Addr bytes */
+	if (op->addr.nbytes) {
+		lutval[lutidx / 2] |= LUT_DEF(lutidx, op->addr.dtr ?
+					      LUT_ADDR_DDR : LUT_ADDR_SDR,
+					      LUT_PAD(op->addr.buswidth),
+					      op->addr.nbytes * 8);
+		lutidx++;
+	}
+
+	/* Dummy bytes, if needed */
+	if (op->dummy.nbytes) {
+		lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_DUMMY,
+					      LUT_PAD(op->data.buswidth),
+					      op->dummy.nbytes * 8 /
+						/* need distinguish ddr mode */
+					      op->dummy.buswidth / (op->dummy.dtr ? 2 : 1));
+		lutidx++;
+	}
+
+	/* Read/Write data bytes */
+	if (op->data.nbytes) {
+		lutval[lutidx / 2] |= LUT_DEF(lutidx,
+					      op->data.dir == SPI_MEM_DATA_IN ?
+					      (op->data.dtr ? LUT_READ_DDR : LUT_READ_SDR) :
+					      (op->data.dtr ? LUT_WRITE_DDR : LUT_WRITE_SDR),
+					      LUT_PAD(op->data.buswidth),
+					      0);
+		lutidx++;
+	}
+
+	/* Stop condition. */
+	lutval[lutidx / 2] |= LUT_DEF(lutidx, LUT_STOP, 0, 0);
+
+	/* Unlock LUT */
+	writel(XSPI_LUT_KEY_VAL, xspi->iobase + XSPI_LUTKEY);
+	writel(XSPI_LOKCR_UNLOCK, xspi->iobase + XSPI_LCKCR);
+
+	/* Fill LUT */
+	for (i = 0; i < ARRAY_SIZE(lutval); i++)
+		writel(lutval[i], base + XSPI_LUT_REG(i));
+
+	dev_dbg(xspi->dev, "CMD[%02x] lutval[0:%08x 1:%08x 2:%08x 3:%08x 4:%08x], size: 0x%08x\n",
+		op->cmd.opcode, lutval[0], lutval[1], lutval[2], lutval[3], lutval[4],
+		op->data.nbytes);
+
+	/* Lock LUT */
+	writel(XSPI_LUT_KEY_VAL, xspi->iobase + XSPI_LUTKEY);
+	writel(XSPI_LOKCR_LOCK, xspi->iobase + XSPI_LCKCR);
+}
+
+static void nxp_xspi_disable_ddr(struct nxp_xspi *xspi)
+{
+	void __iomem *base = xspi->iobase;
+	u32 reg;
+
+	/* Disable module */
+	reg = readl(base + XSPI_MCR);
+	reg |= XSPI_MCR_MDIS;
+	writel(reg, base + XSPI_MCR);
+
+	reg &= ~XSPI_MCR_DDR_EN;
+	reg &= ~XSPI_MCR_DQS_FA_SEL_MASK;
+	/* Use dummy pad loopback mode to sample data */
+	reg |= FIELD_PREP(XSPI_MCR_DQS_FA_SEL_MASK, 0x01);
+	writel(reg, base + XSPI_MCR);
+	xspi->support_max_rate = 133000000;
+
+	reg = readl(base + XSPI_FLSHCR);
+	reg &= ~XSPI_FLSHCR_TDH_MASK;
+	writel(reg, base + XSPI_FLSHCR);
+
+	/* Select sampling at inverted clock */
+	reg = FIELD_PREP(XSPI_SMPR_DLLFSMPFA_MASK, 0) | XSPI_SMPR_FSPHS;
+	writel(reg, base + XSPI_SMPR);
+
+	/* Enable module */
+	reg = readl(base + XSPI_MCR);
+	reg &= ~XSPI_MCR_MDIS;
+	writel(reg, base + XSPI_MCR);
+}
+
+static void nxp_xspi_enable_ddr(struct nxp_xspi *xspi)
+{
+	void __iomem *base = xspi->iobase;
+	u32 reg;
+
+	/* Disable module */
+	reg = readl(base + XSPI_MCR);
+	reg |= XSPI_MCR_MDIS;
+	writel(reg, base + XSPI_MCR);
+
+	reg |= XSPI_MCR_DDR_EN;
+	reg &= ~XSPI_MCR_DQS_FA_SEL_MASK;
+	/* Use external dqs to sample data */
+	reg |= FIELD_PREP(XSPI_MCR_DQS_FA_SEL_MASK, 0x03);
+	writel(reg, base + XSPI_MCR);
+	xspi->support_max_rate = 200000000;
+
+	reg = readl(base + XSPI_FLSHCR);
+	reg &= ~XSPI_FLSHCR_TDH_MASK;
+	reg |= FIELD_PREP(XSPI_FLSHCR_TDH_MASK, 0x01);
+	writel(reg, base + XSPI_FLSHCR);
+
+	reg = FIELD_PREP(XSPI_SMPR_DLLFSMPFA_MASK, 0x04);
+	writel(reg, base + XSPI_SMPR);
+
+	/* Enable module */
+	reg = readl(base + XSPI_MCR);
+	reg &= ~XSPI_MCR_MDIS;
+	writel(reg, base + XSPI_MCR);
+}
+
+static void nxp_xspi_sw_reset(struct nxp_xspi *xspi)
+{
+	void __iomem *base = xspi->iobase;
+	bool mdis_flag = false;
+	u32 reg;
+	int ret;
+
+	reg = readl(base + XSPI_MCR);
+
+	/*
+	 * Per RM, when reset SWRSTSD and SWRSTHD, XSPI must be
+	 * enabled (MDIS = 0).
+	 * So if MDIS is 1, should clear it before assert SWRSTSD
+	 * and SWRSTHD.
+	 */
+	if (reg & XSPI_MCR_MDIS) {
+		reg &= ~XSPI_MCR_MDIS;
+		writel(reg, base + XSPI_MCR);
+		mdis_flag = true;
+	}
+
+	/* Software reset for AHB domain and Serial flash memory domain */
+	reg |= XSPI_MCR_SWRSTHD | XSPI_MCR_SWRSTSD;
+	/* Software Reset for IPS Target Group Queue 0 */
+	reg |= XSPI_MCR_IPS_TG_RST;
+	writel(reg, base + XSPI_MCR);
+
+	/* IPS_TG_RST will self-clear to 0 once IPS_TG_RST complete */
+	ret = readl_poll_timeout(base + XSPI_MCR, reg, !(reg & XSPI_MCR_IPS_TG_RST),
+			      100, 5000);
+	if (ret == -ETIMEDOUT)
+		dev_warn(xspi->dev, "XSPI_MCR_IPS_TG_RST do not self-clear in 5ms!");
+
+	/*
+	 * Per RM, must wait for at least three system cycles and
+	 * three flash cycles after changing the value of reset field.
+	 * delay 5us for safe.
+	 */
+	fsleep(5);
+
+	/*
+	 * Per RM, before dessert SWRSTSD and SWRSTHD, XSPI must be
+	 * disabled (MIDS = 1).
+	 */
+	reg = readl(base + XSPI_MCR);
+	reg |= XSPI_MCR_MDIS;
+	writel(reg, base + XSPI_MCR);
+
+	/* deassert software reset */
+	reg &= ~(XSPI_MCR_SWRSTHD | XSPI_MCR_SWRSTSD);
+	writel(reg, base + XSPI_MCR);
+
+	/*
+	 * Per RM, must wait for at least three system cycles and
+	 * three flash cycles after changing the value of reset field.
+	 * delay 5us for safe.
+	 */
+	fsleep(5);
+
+	/* Re-enable XSPI if it is enabled at beginning */
+	if (!mdis_flag) {
+		reg &= ~XSPI_MCR_MDIS;
+		writel(reg, base + XSPI_MCR);
+	}
+}
+
+static void nxp_xspi_dll_bypass(struct nxp_xspi *xspi)
+{
+	void __iomem *base = xspi->iobase;
+	int ret;
+	u32 reg;
+
+	nxp_xspi_sw_reset(xspi);
+
+	writel(0, base + XSPI_DLLCRA);
+
+	/* Set SLV EN first */
+	reg = XSPI_DLLCRA_SLV_EN;
+	writel(reg, base + XSPI_DLLCRA);
+
+	reg = XSPI_DLLCRA_FREQEN |
+	      FIELD_PREP(XSPI_DLLCRA_SLV_DLY_COARSE_MASK, 0x0) |
+	      XSPI_DLLCRA_SLV_EN | XSPI_DLLCRA_SLV_DLL_BYPASS;
+	writel(reg, base + XSPI_DLLCRA);
+
+	reg |= XSPI_DLLCRA_SLV_UPD;
+	writel(reg, base + XSPI_DLLCRA);
+
+	ret = readl_poll_timeout(base + XSPI_DLLSR, reg,
+			      reg & XSPI_DLLSR_SLVA_LOCK, 0, POLL_TOUT_US);
+	if (ret)
+		dev_err(xspi->dev,
+			"DLL SLVA unlock, the DLL status is %x, need to check!\n",
+			readl(base + XSPI_DLLSR));
+}
+
+static void nxp_xspi_dll_auto(struct nxp_xspi *xspi, unsigned long rate)
+{
+	void __iomem *base = xspi->iobase;
+	int ret;
+	u32 reg;
+
+	nxp_xspi_sw_reset(xspi);
+
+	writel(0, base + XSPI_DLLCRA);
+
+	/* Set SLV EN first */
+	reg = XSPI_DLLCRA_SLV_EN;
+	writel(reg, base + XSPI_DLLCRA);
+
+	reg = FIELD_PREP(XSPI_DLLCRA_DLL_REFCNTR_MASK, 0x02) |
+	      FIELD_PREP(XSPI_DLLCRA_DLLRES_MASK, 0x08) |
+	      XSPI_DLLCRA_SLAVE_AUTO_UPDT | XSPI_DLLCRA_SLV_EN;
+	if (rate > 133000000)
+		reg |= XSPI_DLLCRA_FREQEN;
+
+	writel(reg, base + XSPI_DLLCRA);
+
+	reg |= XSPI_DLLCRA_SLV_UPD;
+	writel(reg, base + XSPI_DLLCRA);
+
+	reg |= XSPI_DLLCRA_DLLEN;
+	writel(reg, base + XSPI_DLLCRA);
+
+	ret = readl_poll_timeout(base + XSPI_DLLSR, reg,
+			      reg & XSPI_DLLSR_DLLA_LOCK, 0, POLL_TOUT_US);
+	if (ret)
+		dev_err(xspi->dev,
+			"DLL unlock, the DLL status is %x, need to check!\n",
+			readl(base + XSPI_DLLSR));
+
+	ret = readl_poll_timeout(base + XSPI_DLLSR, reg,
+			      reg & XSPI_DLLSR_SLVA_LOCK, 0, POLL_TOUT_US);
+	if (ret)
+		dev_err(xspi->dev,
+			"DLL SLVA unlock, the DLL status is %x, need to check!\n",
+			readl(base + XSPI_DLLSR));
+}
+
+static void nxp_xspi_select_mem(struct nxp_xspi *xspi, struct spi_device *spi,
+				const struct spi_mem_op *op)
+{
+	/* xspi only support one DTR mode: 8D-8D-8D */
+	bool op_is_dtr = op->cmd.dtr && op->addr.dtr && op->dummy.dtr && op->data.dtr;
+	unsigned long root_clk_rate, rate;
+	uint64_t cs0_top_address;
+	uint64_t cs1_top_address;
+	u32 reg;
+	int ret;
+
+	/*
+	 * Return when following condition all meet,
+	 * 1, if previously selected target device is same as current
+	 *    requested target device.
+	 * 2, the DTR or STR mode do not change.
+	 * 3, previous operation max rate equals current one.
+	 *
+	 * For other case, need to re-config.
+	 */
+	if (xspi->selected == spi_get_chipselect(spi, 0) &&
+	    (!!(xspi->flags & XSPI_DTR_PROTO) == op_is_dtr) &&
+	    (xspi->pre_op_rate == op->max_freq))
+		return;
+
+	if (op_is_dtr) {
+		nxp_xspi_enable_ddr(xspi);
+		xspi->flags |= XSPI_DTR_PROTO;
+	} else {
+		nxp_xspi_disable_ddr(xspi);
+		xspi->flags &= ~XSPI_DTR_PROTO;
+	}
+	rate = min_t(unsigned long, xspi->support_max_rate, op->max_freq);
+	/*
+	 * There is two dividers between xspi_clk_root(from SoC CCM) and xspi_sfif.
+	 * xspi_clk_root ---->divider1 ----> ipg_clk_2xsfif
+	 *                              |
+	 *                              |
+	 *                              |---> divider2 ---> ipg_clk_sfif
+	 * divider1 is controlled by SOCCR, SOCCR default value is 0.
+	 * divider2 fix to divide 2.
+	 * when SOCCR = 0:
+	 *        ipg_clk_2xsfif = xspi_clk_root
+	 *        ipg_clk_sfif = ipg_clk_2xsfif / 2 = xspi_clk_root / 2
+	 * ipg_clk_2xsfif is used for DTR mode.
+	 * xspi_sck(output to device) is defined based on xspi_sfif clock.
+	 */
+	root_clk_rate = rate * 2;
+
+	clk_disable_unprepare(xspi->clk);
+
+	ret = clk_set_rate(xspi->clk, root_clk_rate);
+	if (ret)
+		return;
+
+	ret = clk_prepare_enable(xspi->clk);
+	if (ret)
+		return;
+
+	xspi->pre_op_rate = op->max_freq;
+	xspi->selected = spi_get_chipselect(spi, 0);
+
+	if (xspi->selected) {		/* CS1 select */
+		cs0_top_address = xspi->memmap_phy;
+		cs1_top_address = SZ_4G - 1;
+	} else {			/* CS0 select */
+		cs0_top_address = SZ_4G - 1;
+		cs1_top_address = SZ_4G - 1;
+	}
+	writel(cs0_top_address, xspi->iobase + XSPI_SFA1AD);
+	writel(cs1_top_address, xspi->iobase + XSPI_SFA2AD);
+
+	reg = readl(xspi->iobase + XSPI_SFACR);
+	if (op->data.swap16)
+		reg |= XSPI_SFACR_BYTE_SWAP;
+	else
+		reg &= ~XSPI_SFACR_BYTE_SWAP;
+	writel(reg, xspi->iobase + XSPI_SFACR);
+
+	if (!op_is_dtr || rate < 60000000)
+		nxp_xspi_dll_bypass(xspi);
+	else
+		nxp_xspi_dll_auto(xspi, rate);
+}
+
+static int nxp_xspi_ahb_read(struct nxp_xspi *xspi, const struct spi_mem_op *op)
+{
+	u32 start = op->addr.val;
+	u32 len = op->data.nbytes;
+
+	/* If necessary, ioremap before AHB read */
+	if ((!xspi->ahb_addr) || start < xspi->memmap_start ||
+	     start + len > xspi->memmap_start + xspi->memmap_len) {
+		if (xspi->ahb_addr)
+			iounmap(xspi->ahb_addr);
+
+		xspi->memmap_start = start;
+		xspi->memmap_len = len > NXP_XSPI_MIN_IOMAP ?
+				len : NXP_XSPI_MIN_IOMAP;
+
+		xspi->ahb_addr = ioremap(xspi->memmap_phy + xspi->memmap_start,
+					 xspi->memmap_len);
+
+		if (!xspi->ahb_addr) {
+			dev_err(xspi->dev, "failed to alloc memory\n");
+			return -ENOMEM;
+		}
+	}
+
+	/* Read out the data directly from the AHB buffer. */
+	memcpy_fromio(op->data.buf.in,
+			xspi->ahb_addr + start - xspi->memmap_start, len);
+
+	return 0;
+}
+
+static int nxp_xspi_fill_txfifo(struct nxp_xspi *xspi,
+				 const struct spi_mem_op *op)
+{
+	void __iomem *base = xspi->iobase;
+	u8 *buf = (u8 *)op->data.buf.out;
+	u32 reg, left;
+	int i;
+
+	for (i = 0; i < ALIGN(op->data.nbytes, 4); i += 4) {
+		reg = readl(base + XSPI_FR);
+		reg |= XSPI_FR_TBFF;
+		writel(reg, base + XSPI_FR);
+		/* Read again to check whether the tx fifo has rom */
+		reg = readl(base + XSPI_FR);
+		if (!(reg & XSPI_FR_TBFF)) {
+			WARN_ON(1);
+			return -EIO;
+		}
+
+		if (i == ALIGN_DOWN(op->data.nbytes, 4)) {
+			/* Use 0xFF for extra bytes */
+			left = 0xFFFFFFFF;
+			/* The last 1 to 3 bytes */
+			memcpy((u8 *)&left, buf + i, op->data.nbytes - i);
+			writel(left, base + XSPI_TBDR);
+		} else {
+			writel(*(u32 *)(buf + i), base + XSPI_TBDR);
+		}
+	}
+
+	return 0;
+}
+
+static int nxp_xspi_read_rxfifo(struct nxp_xspi *xspi,
+				const struct spi_mem_op *op)
+{
+	u32 watermark, watermark_bytes, reg;
+	void __iomem *base = xspi->iobase;
+	u8 *buf = (u8 *) op->data.buf.in;
+	int i, ret, len;
+
+	/*
+	 * Config the rx watermark half of the 64 memory-mapped RX data buffer RBDRn
+	 * refer to the RBCT config in nxp_xspi_do_op()
+	 */
+	watermark = 32;
+	watermark_bytes = watermark * 4;
+
+	len = op->data.nbytes;
+
+	while (len >= watermark_bytes) {
+		/* Make sure the RX FIFO contains valid data before read */
+		ret = readl_poll_timeout(base + XSPI_FR, reg,
+				      reg & XSPI_FR_RBDF, 0, POLL_TOUT_US);
+		if (ret) {
+			WARN_ON(1);
+			return ret;
+		}
+
+		for (i = 0; i < watermark; i++)
+			*(u32 *)(buf + i * 4) = readl(base + XSPI_RBDR0 + i * 4);
+
+		len = len - watermark_bytes;
+		buf = buf + watermark_bytes;
+		/* Pop up data to RXFIFO for next read. */
+		reg = readl(base + XSPI_FR);
+		reg |= XSPI_FR_RBDF;
+		writel(reg, base + XSPI_FR);
+	}
+
+	/* Wait for the total data transfer finished */
+	ret = readl_poll_timeout(base + XSPI_SR, reg, !(reg & XSPI_SR_BUSY), 0, POLL_TOUT_US);
+	if (ret) {
+		WARN_ON(1);
+		return ret;
+	}
+
+	i = 0;
+	while (len >= 4) {
+		*(u32 *)(buf) = readl(base + XSPI_RBDR0 + i);
+		i += 4;
+		len -= 4;
+		buf += 4;
+	}
+
+	if (len > 0) {
+		reg = readl(base + XSPI_RBDR0 + i);
+		memcpy(buf, (u8 *)&reg, len);
+	}
+
+	/* Invalid RXFIFO first */
+	reg = readl(base + XSPI_MCR);
+	reg |= XSPI_MCR_CLR_RXF;
+	writel(reg, base + XSPI_MCR);
+	/* Wait for the CLR_RXF clear */
+	ret = readl_poll_timeout(base + XSPI_MCR, reg,
+			      !(reg & XSPI_MCR_CLR_RXF), 1, POLL_TOUT_US);
+	WARN_ON(ret);
+
+	return ret;
+}
+
+static int nxp_xspi_do_op(struct nxp_xspi *xspi, const struct spi_mem_op *op)
+{
+	void __iomem *base = xspi->iobase;
+	int watermark, err = 0;
+	u32 reg, len;
+
+	len = op->data.nbytes;
+	if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT) {
+		/* Clear the TX FIFO. */
+		reg = readl(base + XSPI_MCR);
+		reg |= XSPI_MCR_CLR_TXF;
+		writel(reg, base + XSPI_MCR);
+		/* Wait for the CLR_TXF clear */
+		err = readl_poll_timeout(base + XSPI_MCR, reg,
+				      !(reg & XSPI_MCR_CLR_TXF), 1, POLL_TOUT_US);
+		if (err) {
+			WARN_ON(1);
+			return err;
+		}
+
+		/* Cover the no 4bytes alignment data length */
+		watermark = (xspi->devtype_data->txfifo - ALIGN(op->data.nbytes, 4)) / 4 + 1;
+		reg = FIELD_PREP(XSPI_TBCT_WMRK_MASK, watermark);
+		writel(reg, base + XSPI_TBCT);
+		/*
+		 * According to the RM, for TBDR register, a write transaction on the
+		 * flash memory with data size of less than 32 bits leads to the removal
+		 * of one data entry from the TX buffer. The valid bits are used and the
+		 * rest of the bits are discarded.
+		 * But for data size large than 32 bits, according to test, for no 4bytes
+		 * alignment data, the last 1~3 bytes will lost, because TX buffer use
+		 * 4 bytes entries.
+		 * So here adjust the transfer data length to make it 4bytes alignment.
+		 * then will meet the upper watermark setting, trigger the 4bytes entries
+		 * pop out.
+		 * Will use extra 0xff to append, refer to nxp_xspi_fill_txfifo().
+		 */
+		if (len > 4)
+			len = ALIGN(op->data.nbytes, 4);
+
+	} else if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_IN) {
+		/* Invalid RXFIFO first */
+		reg = readl(base + XSPI_MCR);
+		reg |= XSPI_MCR_CLR_RXF;
+		writel(reg, base + XSPI_MCR);
+		/* Wait for the CLR_RXF clear */
+		err = readl_poll_timeout(base + XSPI_MCR, reg,
+				      !(reg & XSPI_MCR_CLR_RXF), 1, POLL_TOUT_US);
+		if (err) {
+			WARN_ON(1);
+			return err;
+		}
+
+		reg = FIELD_PREP(XSPI_RBCT_WMRK_MASK, 31);
+		writel(reg, base + XSPI_RBCT);
+	}
+
+	init_completion(&xspi->c);
+
+	/* Config the data address */
+	writel(op->addr.val + xspi->memmap_phy, base + XSPI_SFP_TG_SFAR);
+
+	/* Config the data size and lut id, trigger the transfer */
+	reg = FIELD_PREP(XSPI_SFP_TG_IPCR_SEQID_MASK, XSPI_SEQID_LUT) |
+	      FIELD_PREP(XSPI_SFP_TG_IPCR_IDATSZ_MASK, len);
+	writel(reg, base + XSPI_SFP_TG_IPCR);
+
+	if (op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT) {
+		err = nxp_xspi_fill_txfifo(xspi, op);
+		if (err)
+			return err;
+	}
+
+	/* Wait for the interrupt. */
+	if (!wait_for_completion_timeout(&xspi->c, msecs_to_jiffies(1000)))
+		err = -ETIMEDOUT;
+
+	/* Invoke IP data read. */
+	if (!err && op->data.nbytes && op->data.dir == SPI_MEM_DATA_IN)
+		err = nxp_xspi_read_rxfifo(xspi, op);
+
+	return err;
+}
+
+static int nxp_xspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
+{
+	struct nxp_xspi *xspi = spi_controller_get_devdata(mem->spi->controller);
+	void __iomem *base = xspi->iobase;
+	u32 reg;
+	int err;
+
+	guard(mutex)(&xspi->lock);
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(xspi->dev, pm);
+	err = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (err)
+		return err;
+
+	/* Wait for controller being ready. */
+	err = readl_poll_timeout(base + XSPI_SR, reg,
+			      !(reg & XSPI_SR_BUSY), 1, POLL_TOUT_US);
+	if (err) {
+		dev_err(xspi->dev, "SR keeps in BUSY!");
+		return err;
+	}
+
+	nxp_xspi_select_mem(xspi, mem->spi, op);
+
+	nxp_xspi_prepare_lut(xspi, op);
+
+	/*
+	 * For read:
+	 *     the address in AHB mapped range will use AHB read.
+	 *     the address out of AHB mapped range will use IP read.
+	 * For write:
+	 *     all use IP write.
+	 */
+	if ((op->data.dir == SPI_MEM_DATA_IN) && !needs_ip_only(xspi)
+		&& ((op->addr.val + op->data.nbytes) <= xspi->memmap_phy_size))
+		err = nxp_xspi_ahb_read(xspi, op);
+	else
+		err = nxp_xspi_do_op(xspi, op);
+
+	nxp_xspi_sw_reset(xspi);
+
+	return err;
+}
+
+static int nxp_xspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
+{
+	struct nxp_xspi *xspi = spi_controller_get_devdata(mem->spi->controller);
+
+	if (op->data.dir == SPI_MEM_DATA_OUT) {
+		if (op->data.nbytes > xspi->devtype_data->txfifo)
+			op->data.nbytes = xspi->devtype_data->txfifo;
+	} else {
+		/* Limit data bytes to RX FIFO in case of IP read only */
+		if (needs_ip_only(xspi) && (op->data.nbytes > xspi->devtype_data->rxfifo))
+			op->data.nbytes = xspi->devtype_data->rxfifo;
+
+		/* Address in AHB mapped range prefer to use AHB read. */
+		if (!needs_ip_only(xspi) && (op->addr.val < xspi->memmap_phy_size)
+			&& ((op->addr.val + op->data.nbytes) > xspi->memmap_phy_size))
+			op->data.nbytes = xspi->memmap_phy_size - op->addr.val;
+	}
+
+	return 0;
+}
+
+static void nxp_xspi_config_ahb_buffer(struct nxp_xspi *xspi)
+{
+	void __iomem *base = xspi->iobase;
+	u32 ahb_data_trans_size;
+	u32 reg;
+
+	writel(0xA, base + XSPI_BUF0CR);
+	writel(0x2, base + XSPI_BUF1CR);
+	writel(0xD, base + XSPI_BUF2CR);
+
+	/* Configure buffer3 for All Master Access */
+	reg = FIELD_PREP(XSPI_BUF3CR_MSTRID_MASK, 0x06) |
+	      XSPI_BUF3CR_ALLMST;
+
+	ahb_data_trans_size = xspi->devtype_data->ahb_buf_size / 8;
+	reg |= FIELD_PREP(XSPI_BUF3CR_ADATSZ_MASK, ahb_data_trans_size);
+	writel(reg, base + XSPI_BUF3CR);
+
+	/* Only the buffer3 is used */
+	writel(0, base + XSPI_BUF0IND);
+	writel(0, base + XSPI_BUF1IND);
+	writel(0, base + XSPI_BUF2IND);
+
+	/* AHB only use ID=15 for read */
+	reg = FIELD_PREP(XSPI_BFGENCR_SEQID_MASK, XSPI_SEQID_LUT);
+	reg |= XSPI_BFGENCR_WR_FLUSH_EN;
+	/* No limit for align */
+	reg |= FIELD_PREP(XSPI_BFGENCR_ALIGN_MASK, 0);
+	writel(reg, base + XSPI_BFGENCR);
+}
+
+static int nxp_xspi_default_setup(struct nxp_xspi *xspi)
+{
+	void __iomem *base = xspi->iobase;
+	u32 reg;
+
+	/* Bypass SFP check, clear MGC_GVLD, MGC_GVLDMDAD, MGC_GVLDFRAD */
+	writel(0, base + XSPI_MGC);
+
+	/* Enable the EENV0 SFP check */
+	reg = readl(base + XSPI_TG0MDAD);
+	reg |= XSPI_TG0MDAD_VLD;
+	writel(reg, base + XSPI_TG0MDAD);
+
+	/* Give read/write access right to EENV0 */
+	reg = readl(base + XSPI_FRAD0_WORD2);
+	reg &= ~XSPI_FRAD0_WORD2_MD0ACP_MASK;
+	reg |= FIELD_PREP(XSPI_FRAD0_WORD2_MD0ACP_MASK, 0x03);
+	writel(reg, base + XSPI_FRAD0_WORD2);
+
+	/* Enable the FRAD check for EENV0 */
+	reg = readl(base + XSPI_FRAD0_WORD3);
+	reg |= XSPI_FRAD0_WORD3_VLD;
+	writel(reg, base + XSPI_FRAD0_WORD3);
+
+	/*
+	 * Config the timeout to max value, this timeout will affect the
+	 * TBDR and RBDRn access right after IP cmd triggered.
+	 */
+	writel(0xFFFFFFFF, base + XSPI_MTO);
+
+	/* Disable module */
+	reg = readl(base + XSPI_MCR);
+	reg |= XSPI_MCR_MDIS;
+	writel(reg, base + XSPI_MCR);
+
+	nxp_xspi_sw_reset(xspi);
+
+	reg = readl(base + XSPI_MCR);
+	reg &= ~(XSPI_MCR_CKN_FA_EN | XSPI_MCR_DQS_FA_SEL_MASK |
+		 XSPI_MCR_DOZE | XSPI_MCR_VAR_LAT_EN |
+		 XSPI_MCR_DDR_EN | XSPI_MCR_DQS_OUT_EN);
+	reg |= XSPI_MCR_DQS_EN;
+	reg |= XSPI_MCR_ISD3FA | XSPI_MCR_ISD2FA;
+	writel(reg, base + XSPI_MCR);
+
+	reg = readl(base + XSPI_SFACR);
+	reg &= ~(XSPI_SFACR_FORCE_A10 | XSPI_SFACR_WA_4B_EN |
+		 XSPI_SFACR_BYTE_SWAP | XSPI_SFACR_WA |
+		 XSPI_SFACR_CAS_MASK);
+	reg |= XSPI_SFACR_FORCE_A10;
+	writel(reg, base + XSPI_SFACR);
+
+	nxp_xspi_config_ahb_buffer(xspi);
+
+	reg = FIELD_PREP(XSPI_FLSHCR_TCSH_MASK, 0x03) |
+	      FIELD_PREP(XSPI_FLSHCR_TCSS_MASK, 0x03);
+	writel(reg, base + XSPI_FLSHCR);
+
+	/* Enable module */
+	reg = readl(base + XSPI_MCR);
+	reg &= ~XSPI_MCR_MDIS;
+	writel(reg, base + XSPI_MCR);
+
+	xspi->selected = -1;
+
+	/* Enable the interrupt */
+	writel(XSPI_RSER_TFIE, base + XSPI_RSER);
+
+	return 0;
+}
+
+static const char *nxp_xspi_get_name(struct spi_mem *mem)
+{
+	struct nxp_xspi *xspi = spi_controller_get_devdata(mem->spi->controller);
+	struct device *dev = &mem->spi->dev;
+	const char *name;
+
+	/* Set custom name derived from the platform_device of the controller. */
+	if (of_get_available_child_count(xspi->dev->of_node) == 1)
+		return dev_name(xspi->dev);
+
+	name = devm_kasprintf(dev, GFP_KERNEL,
+			      "%s-%d", dev_name(xspi->dev),
+			      spi_get_chipselect(mem->spi, 0));
+
+	if (!name) {
+		dev_err(dev, "failed to get memory for custom flash name\n");
+		return ERR_PTR(-ENOMEM);
+	}
+
+	return name;
+}
+
+static const struct spi_controller_mem_ops nxp_xspi_mem_ops = {
+	.adjust_op_size = nxp_xspi_adjust_op_size,
+	.supports_op = nxp_xspi_supports_op,
+	.exec_op = nxp_xspi_exec_op,
+	.get_name = nxp_xspi_get_name,
+};
+
+static const struct spi_controller_mem_caps nxp_xspi_mem_caps = {
+	.dtr = true,
+	.per_op_freq = true,
+	.swap16 = true,
+};
+
+static void nxp_xspi_cleanup(void *data)
+{
+	struct nxp_xspi *xspi = data;
+	u32 reg;
+
+	pm_runtime_get_sync(xspi->dev);
+
+	/* Disable interrupt */
+	writel(0, xspi->iobase + XSPI_RSER);
+	/* Clear all the internal logic flags */
+	writel(0xFFFFFFFF, xspi->iobase + XSPI_FR);
+	/* Disable the hardware */
+	reg = readl(xspi->iobase + XSPI_MCR);
+	reg |= XSPI_MCR_MDIS;
+	writel(reg, xspi->iobase + XSPI_MCR);
+
+	pm_runtime_put_sync(xspi->dev);
+
+	if (xspi->ahb_addr)
+		iounmap(xspi->ahb_addr);
+}
+
+static int nxp_xspi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct spi_controller *ctlr;
+	struct nxp_xspi *xspi;
+	struct resource *res;
+	int ret, irq;
+
+	ctlr = devm_spi_alloc_host(dev, sizeof(*xspi));
+	if (!ctlr)
+		return -ENOMEM;
+
+	ctlr->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL |
+			  SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL;
+
+	xspi = spi_controller_get_devdata(ctlr);
+	xspi->dev = dev;
+	xspi->devtype_data = device_get_match_data(dev);
+	if (!xspi->devtype_data)
+		return -ENODEV;
+
+	platform_set_drvdata(pdev, xspi);
+
+	/* Find the resources - configuration register address space */
+	xspi->iobase = devm_platform_ioremap_resource_byname(pdev, "base");
+	if (IS_ERR(xspi->iobase))
+		return PTR_ERR(xspi->iobase);
+
+	/* Find the resources - controller memory mapped space */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mmap");
+	if (!res)
+		return -ENODEV;
+
+	/* Assign memory mapped starting address and mapped size. */
+	xspi->memmap_phy = res->start;
+	xspi->memmap_phy_size = resource_size(res);
+
+	/* Find the clocks */
+	xspi->clk = devm_clk_get(dev, "per");
+	if (IS_ERR(xspi->clk))
+		return PTR_ERR(xspi->clk);
+
+	/* Find the irq */
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return dev_err_probe(dev, irq,  "Failed to get irq source");
+
+	pm_runtime_set_autosuspend_delay(dev, XSPI_RPM_TIMEOUT_MS);
+	pm_runtime_use_autosuspend(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable clock");
+
+	/* Clear potential interrupt by write xspi errstat */
+	writel(0xFFFFFFFF, xspi->iobase + XSPI_ERRSTAT);
+	writel(0xFFFFFFFF, xspi->iobase + XSPI_FR);
+
+	nxp_xspi_default_setup(xspi);
+
+	ret = devm_request_irq(dev, irq,
+			nxp_xspi_irq_handler, 0, pdev->name, xspi);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to request irq");
+
+	ret = devm_mutex_init(dev, &xspi->lock);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, nxp_xspi_cleanup, xspi);
+	if (ret)
+		return ret;
+
+	ctlr->bus_num = -1;
+	ctlr->num_chipselect = NXP_XSPI_MAX_CHIPSELECT;
+	ctlr->mem_ops = &nxp_xspi_mem_ops;
+	ctlr->mem_caps = &nxp_xspi_mem_caps;
+	ctlr->dev.of_node = dev->of_node;
+
+	return devm_spi_register_controller(dev, ctlr);
+}
+
+static int nxp_xspi_runtime_suspend(struct device *dev)
+{
+	struct nxp_xspi *xspi = dev_get_drvdata(dev);
+	u32 reg;
+
+	reg = readl(xspi->iobase + XSPI_MCR);
+	reg |= XSPI_MCR_MDIS;
+	writel(reg, xspi->iobase + XSPI_MCR);
+
+	clk_disable_unprepare(xspi->clk);
+
+	return 0;
+}
+
+static int nxp_xspi_runtime_resume(struct device *dev)
+{
+	struct nxp_xspi *xspi = dev_get_drvdata(dev);
+	u32 reg;
+	int ret;
+
+	ret = clk_prepare_enable(xspi->clk);
+	if (ret)
+		return ret;
+
+	reg = readl(xspi->iobase + XSPI_MCR);
+	reg &= ~XSPI_MCR_MDIS;
+	writel(reg, xspi->iobase + XSPI_MCR);
+
+	return 0;
+}
+
+static int nxp_xspi_suspend(struct device *dev)
+{
+	int ret;
+
+	ret = pinctrl_pm_select_sleep_state(dev);
+	if (ret) {
+		dev_err(dev, "select flexspi sleep pinctrl failed!\n");
+		return ret;
+	}
+
+	return pm_runtime_force_suspend(dev);
+}
+
+static int nxp_xspi_resume(struct device *dev)
+{
+	struct nxp_xspi *xspi = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		return ret;
+
+	nxp_xspi_default_setup(xspi);
+
+	ret = pinctrl_pm_select_default_state(dev);
+	if (ret)
+		dev_err(dev, "select flexspi default pinctrl failed!\n");
+
+	return ret;
+}
+
+
+static const struct dev_pm_ops nxp_xspi_pm_ops = {
+	RUNTIME_PM_OPS(nxp_xspi_runtime_suspend, nxp_xspi_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(nxp_xspi_suspend, nxp_xspi_resume)
+};
+
+static const struct of_device_id nxp_xspi_dt_ids[] = {
+	{ .compatible = "nxp,imx94-xspi", .data = (void *)&imx94_data, },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, nxp_xspi_dt_ids);
+
+static struct platform_driver nxp_xspi_driver = {
+	.driver = {
+		.name	= "nxp-xspi",
+		.of_match_table = nxp_xspi_dt_ids,
+		.pm =   pm_ptr(&nxp_xspi_pm_ops),
+	},
+	.probe          = nxp_xspi_probe,
+};
+module_platform_driver(nxp_xspi_driver);
+
+MODULE_DESCRIPTION("NXP xSPI Controller Driver");
+MODULE_AUTHOR("NXP Semiconductor");
+MODULE_AUTHOR("Haibo Chen <haibo.chen@nxp.com>");
+MODULE_LICENSE("GPL");

-- 
2.34.1


