Return-Path: <linux-spi+bounces-11332-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8503C6FFBB
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 17:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A4B34F1B73
	for <lists+linux-spi@lfdr.de>; Wed, 19 Nov 2025 16:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0324233A6F6;
	Wed, 19 Nov 2025 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YN7tj8c4"
X-Original-To: linux-spi@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013066.outbound.protection.outlook.com [40.107.162.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2992633A6E5;
	Wed, 19 Nov 2025 16:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763568187; cv=fail; b=nW5B99ARVAHk1/QoEiSo22rCuOmanH0vvixOJCfi2sGgVbYwJGfMwQAf5K8N+h/bpxKeEw/V/nI5Wv7t9fR+nVtfQS732PYbxqxfNVeBvplCBFVT69Irxd1bumSGgaovENubuaP6yExOyheenDrPfEpI+zo9hnWJw/VEcAvlrAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763568187; c=relaxed/simple;
	bh=o1CdiSbh03oKSUnyVp5CJ7FSoquYkYGPKcz3QT4pkkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TnnUBUnVbI59IdYi7NP8ShyvufDrZ9cKFeElgv27ucX8QBtYcM0Cr8zliNgHMkHgzif3CkqTYhfEt5Rn88OcXzgLQN3RdZsuINATGyv6n9PCrOTdt7GMvv+iTSlXof5//8sQwk2SyrITmhLuSRXz6j2pA3b+Iqm4dUng//2LtxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YN7tj8c4; arc=fail smtp.client-ip=40.107.162.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XuPeBn3YP8zYJ2/6wptel3GDbcOrCIqEq17VdrXvrNGdej9zdJzdYYe1V4mVCSmxhbgjcwEu8xEV3ge953rEQ2L62VN8Kbfm/RTGPYjbFzo/k8pv9JKC8pIAS6QQqTkWWfELaHdRHvi/vyLzXNLw/Dklg3tXwp/FHzbiwVYDnXW3aRyT9FXTd93Wa8rHIjYUGwy/Z7L/Cg1YsQBc8CUNuqg2+AaGsbg1Nh0lLJ6dyVQKU6J9lsf2c+ygGwd6CtZ2Yo8NZXy2ToU17cZIBDrPCGhnRv/TFLCBtBzuV9fyRaRbMr+SIMY44WufhT264FovHs/OXWqcbspVQTDC++XRZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFWTbYDfK6iX8AuRFl/hhMn/eC4oCL+RR8++edymnpE=;
 b=bDkYP2TVNN53FPl+tdhcK4JNsmE8BKgoBMe3myHD03qi5vd4OphDmDZQu43xOXMWTK8pGhnajGEx4vocr71IUdEJNKnHzezLx/QLb3rr026Y1iRD6wZgBVvCpkmzhTvR7rhWaNMd+IEX/Ko/lOQNx7pxRdCgrxKoBSkTq1M6zlMz03PiYMcG8d/Y8PT/OItUuk5LuFP7TJz1uEgH3j2NiAwDkxsWvfmxbkNkjhhhEcqK2jljA61149HCJ+j5ZOsYkHlzrVQk9vYrwxZS90+myD6Ez9szGkggrSp9xSjCWUHbj77e5JxtZVDipz8SLLBjh3C/Ilkss5G73rt1iVyy2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFWTbYDfK6iX8AuRFl/hhMn/eC4oCL+RR8++edymnpE=;
 b=YN7tj8c4stqvTFoOaS/NxBH20wll/4LAJaoWKdumU5emIOgPQ3v2QHnIPvI7MHp8rdkAOowLY8WPLmAmUu2NGMR4w8kRm7Bzwff4qa7wm8edsh3/xl3yEKLYWxFsSuS9ZMDM3kFP63rsXrel6e/V0oJeYWDgOfQsUw3aHUnhpJwcr75hW0MxW22KXfOX63+JfMR6FCFUA0KWZ4j4JK7wwHnmMdfyc86fPMgBk2lrg5thm8zfYZ+brxxKWqjU9YRU0pwCXUef7eJExqb5A+l2CUmtDsjcDmuPswgnweoYL+NuNSQa744PPtebHNARHTOTZsRPJXM1w0AHWGIdSq9urQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GV4PR04MB11971.eurprd04.prod.outlook.com (2603:10a6:150:2ec::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 16:03:00 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9320.021; Wed, 19 Nov 2025
 16:03:00 +0000
Date: Wed, 19 Nov 2025 11:02:51 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bough Chen <haibo.chen@nxp.com>
Cc: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 2/2] spi: add driver for NXP XSPI controller
Message-ID: <aR3qK18c4/XJY8JW@lizhi-Precision-Tower-5810>
References: <20251118-xspi-v3-0-6d3a91b68c7e@nxp.com>
 <20251118-xspi-v3-2-6d3a91b68c7e@nxp.com>
 <aRyfoXaTdL1gvPOY@lizhi-Precision-Tower-5810>
 <DU0PR04MB94965531DB74151BFE651BD690D7A@DU0PR04MB9496.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DU0PR04MB94965531DB74151BFE651BD690D7A@DU0PR04MB9496.eurprd04.prod.outlook.com>
X-ClientProxiedBy: SJ0PR03CA0368.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::13) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GV4PR04MB11971:EE_
X-MS-Office365-Filtering-Correlation-Id: a93daf87-f2ca-4b82-81bc-08de27851cd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|19092799006|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2QzeU1pdG5SNWNNemR4UkpmSGZjYmo3UkIxUFlvK1lLN2k3S2RnZkl4cUdU?=
 =?utf-8?B?Mkk4UEhCUHN2RnpENU5TYTJQK1doUERMY2crNU9pTkdEaktoWGxRclJxT3hS?=
 =?utf-8?B?UitqTTd3RWxwSGdCOE8yWDFvQmZvakV2b1RNQUpOMWJ0Vy8wRlMwblkyK0Q5?=
 =?utf-8?B?Q1FaRGZVYXZRSVZYN0RYODhWemRIOEtiWmtGQzlBbEFiNVpGRFdiN1p1ZGNM?=
 =?utf-8?B?cFk1bTVUSWZOMExBbU0rTGp0N1o5WDdmL0dFRGYwNFNZZi8zaVFjVWx3UlM1?=
 =?utf-8?B?WVZWK05ZSVNZMDVHcmVkQUFMU3VmaXNveWZGUkVjS29VZTB3RUpzN3I4K1Yr?=
 =?utf-8?B?bzJLMGdnNnd4RVM0SmxQMGQreVgyVzBrRlAwU2tsOXZhWjBSejR0cXdWbGcv?=
 =?utf-8?B?ME5hamZsMlRzWVlPT2VvZVRUd2w5NXNwNGtubHFBSGZUMDBsVkJSNWJkSkVZ?=
 =?utf-8?B?OU5XL1VHSXZQNHlBbmxCMHJ6NWIzZlphc1ovdUU4cUcrRHlRSmtURGtoZUVY?=
 =?utf-8?B?aXJwMVpQY1NoOGp1Y1ozZndOeHJycHpjT0c4MDkvYlBVeU1wS09vUDZCZlZV?=
 =?utf-8?B?SVZybThtYUNmUlltTXVvUjI3WHZ4Y3lGaHpHa1hQVm12M213ZnI5M25MZENa?=
 =?utf-8?B?N3E5dFpQckxDM3hwNHg4WEtsNlZESG5YWFc4WU9acW1qSjBkYUVIVHQwVzVB?=
 =?utf-8?B?eCtOeFYxcEcvS3M0Nm9HUFFLSGZtNWd0YXhzUzVXUVRhS1NrSW1tTENCSEdD?=
 =?utf-8?B?aWw0bkpYRkl2QUFidTZsL04wSHlaeStGdXJ5SmU4QlRnNVAxdkZrdzQrZWxl?=
 =?utf-8?B?NWQ2MFlVS2c0cHA3cTI1QnIzSDZRK0NJWEdsVDAvQU5NUFRTbUR1Zkc0UG1D?=
 =?utf-8?B?U1RZUnk4U25OVXNGeDJhaDRJVm5PMzdOeGRXQzBqK2dDVUcwOGp3MFJ2bjB1?=
 =?utf-8?B?aGVCaWVDWjZvRW1nUzg5bHZLWWNzZDkyNENOR0t0RU9WSW91WFNOeCsrTlVN?=
 =?utf-8?B?aW44b1lyeWJXQ2U0dThUa3lQS0VRU3lBc1dYUHFWRWQ5K1RxcjdlWjVONyt4?=
 =?utf-8?B?RGNubXNMSVNzRmN3d1BFQlpIQ2VKdFJsb291VzN0Qk1PSklsMDEzRDFTdEpk?=
 =?utf-8?B?bWNxODhEWkM3MFc0Z1VTcTdmSGgvZlVoQy91QWQ4Yk4yVHlhMzdFb0pENUN1?=
 =?utf-8?B?WEhITU1DNis2TkRWN2FYZXc5Vkt6aHlrQ28wWlVFbVlHQjBMdTNPaXk4U2Va?=
 =?utf-8?B?SHJnRmxOK2VKRUFEQitZempUdnVXMmlEVTZycWd2THRGRkpVNHJ6akYwSnMw?=
 =?utf-8?B?VEg1Qlgxc3Jtc1EvZWE5aXkzalM2ckhYd1V6VytYNisreW9rZWRYd0ttT0NF?=
 =?utf-8?B?MEUwVzVDcXhyd1BJT3U3WUp2RWk5MzdIbGo2bXVWQ0Y1TllTbCtlZ2FCN2hz?=
 =?utf-8?B?aDlKTUc0UStkV3YweEhSWm9PM0VDNm1BMlhYc1p0RjE4NldWWjBXZmkwVng0?=
 =?utf-8?B?M1FJQlRRZDh0YUtqWi9wZTB6a05BRWJlajR5bUZsa21Kd1J0dTJTSCtyRmI3?=
 =?utf-8?B?aUVPaXptMHhDSUFRcnlXaTRiZzhQZlZvS252K3JTb0oxU3lvV3pqZVk2cXlm?=
 =?utf-8?B?eG9GaDArNjZHVytvV3RDRjhVZDQwL0pmUVZBY0J4S3V5NXhQYkhWVWJidTV5?=
 =?utf-8?B?Y1JoQVY4LzM5ZDQrWW9NNWpyTjJ4bmg1d0RyWHU1ZWZFa08vL1RwT0ZQNFhy?=
 =?utf-8?B?T0crMlJYdEVWV3V4S2xZRlExamdaM3BhUy9PT2U0cUtMU2E2UFNhLzlKNHVK?=
 =?utf-8?B?VkRiZXpBcWkwbkN5WldiTzBkVVphWXIyeCt5RUF3NWNmLy8xcUpneXVBbzN6?=
 =?utf-8?B?NHA5RDN1SWhMMVU5a3Y2NWZEWk16Vk8wb2RCWFliWnFvMXdjaE90Zzk5Ly94?=
 =?utf-8?B?VGFZUEZTMm5TcDNaNTM3VVZ4WCtVZUswcUtMTGkxeXJSMWNHUTVzY1IzRjh6?=
 =?utf-8?B?MkpuN1VOTjF2S1JQRmVhRU1wQlBHSFk0ZmlqNGdlNTZXWXVxN05wN3ZyVVVh?=
 =?utf-8?Q?nHxEHa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(19092799006)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHN3RndyQ2VpSkFNY2lPOE1KTEwyZUZNMDU5NEhJRWE2WFEzamxqYzNnaVFY?=
 =?utf-8?B?TkxvdW1icmM2dHMvOXdIeXlmZ1NrR2JlTmZBN0s1MDliUHVXb0JUMjE4RXJE?=
 =?utf-8?B?Q0t2THZOcld1N1lTVzZNVWMrajNBK3VTeTc3N2xmdFVIUlR6aWRpdC9jaGNx?=
 =?utf-8?B?RkNrVENZREVIODg3N04rV2VzVGtVYzAyeW5JWTI4TWg3dURpWEpFSVV3b2ZY?=
 =?utf-8?B?QlpHUnhTRVZteXVLNkZ1eXdjKzU2NE8wcTJNOEhoRzlwTGtqaDVQZjJQUVR5?=
 =?utf-8?B?S0thRTh2a0FvNm96L3NUbXQwdlQ4SDFXM3FIb2IvV3BjTG1aSTAxT2pTa1BM?=
 =?utf-8?B?SEsrdDVhcGNtR3IzQXJ2YjdzMDQyVVdocXJtSEVOaWhjSFhrOEdKVVkxQ1RX?=
 =?utf-8?B?azcwU3ZmUTAreEQ5QXFwRVRrOThPa1JiNytmY253Vmd0ZklaWHN0SjUzTzRH?=
 =?utf-8?B?N1hBazEvS3J2RkNmc1cyS3piSGI1dXBScnN5MGJab3NGelFoUVpMc1k2T0hY?=
 =?utf-8?B?YVJwVlVVL0o3VzVaRmUrWEJqd1ZxMGw3cUNvQ25vUkEzS2JIc2dIWVl4c3lY?=
 =?utf-8?B?K3ZyNlUvb0lMSkk4ZkZvVjZ5SjNBblM5bXhneHlpNnVPelloS2VtNExXYXM2?=
 =?utf-8?B?SDhpMjNZTVh0MFlXY1gvWE1mbXNkczVEYjRFS1RiZWdQWGE5MFh1NWMwdUpM?=
 =?utf-8?B?T1lMbjl0clFDdndURmhGZlBGQzV1NDg0Rmh4SE1FRmVxci9UcnJxbkoxY1c0?=
 =?utf-8?B?UWhmQVZnNEFSMDNoUVl3ZXJKelN0NkxlcmlWeDRGb3VPTFVMek1nTUJKWXZU?=
 =?utf-8?B?ZUk1eEp5WVIwd0wyVjFJRkdWTVptU1FLM0FuTjFURGRVMTRQK2N4SXM0UUlV?=
 =?utf-8?B?dlZBeU82U0M5Q2Flb3JUcXJLdjViaWxkSjhwZWIrUXFvL25UZGtDSlBaNldm?=
 =?utf-8?B?OXZkTWxSWEdjYWZkRWJGZjBFYTBIc3M0U3dWS3I3eUJxUktMcTRiTmV6NE5Z?=
 =?utf-8?B?blNHN1ZxZDBzQ1NlSks5OW1aK2FLbHR2UStKNGpaTk5VdlJ5dUozaFoxbkd2?=
 =?utf-8?B?dEI5ZEJsQnJSTVM4S0J1bHU5OVFkVStpZFRqQjV2d2FNTk1tWjBwQW9SS2xP?=
 =?utf-8?B?MEV6amhublhMWmhZZFdYc0wxUjU3UG9waHRpQ2JtMUxMdGVFN2ZCWm0rQ2or?=
 =?utf-8?B?cUNDK0hoZ0dsSjFvU3dKK3ZVTTJtN1F3cGxRVHRQVyttV0R5QjRxRmNUQk50?=
 =?utf-8?B?LzFMOFVHSjZwOGMySkdlRzJGWFhnVDZIbjJFeWFydGxmcFF0VWxQbGNhYnlB?=
 =?utf-8?B?NllZdjRGU1pjSGM3SzN5eFhTQ0ZWYzB3dlFuMG1nRFNxaEVOQUpzSWxFOE80?=
 =?utf-8?B?TVBVZnVxblNpQzBjc21SWm9QNE9uZ3BWeHFtSEdHZW1SSHVmQWRDMkgrUlYx?=
 =?utf-8?B?R3pXaWkzd0V6VzlmODF6S0lYZ1ZrOVh5UWNXMzRLcFNXT1VvcW9DMWRMREl0?=
 =?utf-8?B?bzJJU1N1WVY0Y2tNTERpNXpldlFIUXU3UTRReVJKaENPYVk1RTF6VitIMTRj?=
 =?utf-8?B?NzhRZW5lVG5iWVBYVXYzd3ZKK3NLWC94ZVRYUVB3VE5GTm5nRDJnMHNCVUx0?=
 =?utf-8?B?NStvTjNsdy9aN1IwRUFaSk9lc2MzanRxY3VKd3dlcWE1Ykt6VEZUdFA5MlVP?=
 =?utf-8?B?dGdoRktodGxDNGcyVWdtTDlGRXdRWXBRbjF0T0lEdHZpbWNQbytyck5jSXcx?=
 =?utf-8?B?Tld0Q01oaVNKYUVCV2tTd2ZySVFMbGxRcklLNUpRUkdDOHY4cnpENGE0YjRs?=
 =?utf-8?B?WmppMzBUZkYxSFIxaUY1MlhRYmsrcFRrQmJFWWJJczFLZ3BzYlJiVTRjdmxn?=
 =?utf-8?B?RU5ONFczY1pOb29tOW9heEpBQ3ozWTd4RzVNbFo4YzFXcDB4a21UVkcvU29F?=
 =?utf-8?B?bHBBUmtWWUViQk9XRTliVmpBVWIwNnM5aTdxekZOKzBSRTluYktPRmNDYUZo?=
 =?utf-8?B?MzNMWTdTdTNIVXJQcTRpUXRjZ0RabUNuNURTMkUwelAyUDAyWDRqSTVYTGpX?=
 =?utf-8?B?N2sxaUZHTmJwdU5sOFJtandTSUF4cjVrQWhKcWRwS2lmZFJrMklRVXZYcFNk?=
 =?utf-8?Q?3apwQqnZQT5+sDAr8yHmHM03z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a93daf87-f2ca-4b82-81bc-08de27851cd8
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 16:03:00.3824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c2+6N0IGbRGC/PhdbGM46ipEbodppTYr6QawUV6T0JNkoGNIrPXq2PJhF6TUCuSNpHXQHs4o0byh2+P/nNpRlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11971

On Wed, Nov 19, 2025 at 07:02:21AM +0000, Bough Chen wrote:
>
>
> > -----Original Message-----
> > From: Frank Li <frank.li@nxp.com>
> > Sent: 2025年11月19日 0:33
> > To: Bough Chen <haibo.chen@nxp.com>
> > Cc: Han Xu <han.xu@nxp.com>; Mark Brown <broonie@kernel.org>; Rob
> > Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor
> > Dooley <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Sascha
> > Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>;
> > linux-spi@vger.kernel.org; imx@lists.linux.dev; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH v3 2/2] spi: add driver for NXP XSPI controller
> >
> > On Tue, Nov 18, 2025 at 11:34:17AM +0800, Haibo Chen wrote:
> > > Add driver support for NXP XSPI controller.
> > >
> > > XSPI is a flexible SPI host controller which supports up to
> > > 2 external devices (2 CS). It support Single/Dual/Quad/Octal mode data
> > > transfer.
> > >
> > > The difference between XSPI and Flexspi:
> > > 1.the register layout is total different.
> > > 2.XSPI support multiple independent execution environments
> > > (EENVs) for HW virtualization with some limitations. Each EENV has its
> > > own interrupt and its own set of programming registers that exists in
> > > a specific offset range in the XSPI memory map.
> > > The main environment (EENV0) address space contains all of the
> > > registers for controlling EENV0 plus all of the general XSPI control
> > > and programming registers. The register mnemonics for the user
> > > environments (EENV1 to EENV4) have "_SUB_n" appended to the mnemonic
> > > for the corresponding main-environment register.
> > >
> > > Current driver based on EENV0, which means system already give
> > > EENV0 right to linux.
> > >
> > > This driver use SPI memory interface of the SPI framework to issue
> > > flash memory operations. Tested this driver with mtd_debug and UBIFS
> > > on NXP i.MX943 EVK board which has one MT35XU512ABA spi nor flash. NOw
> > > this driver has the following key features:
> > > - Support up to OCT DDR mode
> > > - Support AHB read
> > > - Support IP read and IP write
> > > - Support two CS
> > >
> > > Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> > > ---
> > >  MAINTAINERS                |    1 +
> > >  drivers/spi/Kconfig        |   10 +
> > >  drivers/spi/Makefile       |    1 +
> > >  drivers/spi/spi-nxp-xspi.c | 1367
> > > ++++++++++++++++++++++++++++++++++++++++++++
> > >  4 files changed, 1379 insertions(+)
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS index
> > >
> > 2f17f925ee23dd90acc1b4bf25f158070cd2b65e..527b4f284c3207fb9760ece5cc
> > 1d
> > > 350e7ad8fe50 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -18853,6 +18853,7 @@ L:	linux-spi@vger.kernel.org
> > >  L:	imx@lists.linux.dev
> > >  S:	Maintained
> > >  F:	Documentation/devicetree/bindings/spi/nxp,imx94-xspi.yaml
> > > +F:	drivers/spi/spi-nxp-xspi.c
> > >
> > > +#include <linux/clk.h>
> > > +#include <linux/completion.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/err.h>
> > > +#include <linux/errno.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/io.h>
> > > +#include <linux/iopoll.h>
> > > +#include <linux/jiffies.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/log2.h>
> > > +#include <linux/module.h>
> > > +#include <linux/mutex.h>
> > > +#include <linux/of.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/pinctrl/consumer.h>
> > > +#include <linux/pm_runtime.h>
> > > +#include <linux/spi/spi.h>
> > > +#include <linux/spi/spi-mem.h>
> > > +
> > > +/* Runtime pm timeout */
> > > +#define XSPI_RPM_TIMEOUT 50	/* 50ms */
> >
> > Need unit XSPI_RPM_TIMEOUT_MS
> >
> > > +/*
> > > + * The driver only uses one single LUT entry, that is updated on
> > > + * each call of exec_op(). Index 0 is preset at boot with a basic
> > > + * read operation, so let's use the last entry (15).
> > > + */
> > ...
> > > + *  ---------------------------------------------------
> > > + *  | INSTR1 | PAD1 | OPRND1 | INSTR0 | PAD0 | OPRND0 |
> > > + *  ---------------------------------------------------
> > > + */
> > > +#define PAD_SHIFT		8
> > > +#define INSTR_SHIFT		10
> > > +#define OPRND_SHIFT		16
> > > +
> > > +/* Macros for constructing the LUT register. */
> > > +#define LUT_DEF(idx, ins, pad, opr)			  \
> > > +	((((ins) << INSTR_SHIFT) | ((pad) << PAD_SHIFT) | \
> > > +	(opr)) << (((idx) % 2) * OPRND_SHIFT))
> > > +
> > > +#define NXP_XSPI_MIN_IOMAP	SZ_4M
> > > +#define NXP_XSPI_MAX_CHIPSELECT		2
> > > +#define POLL_TOUT		5000
> >
> > Need unit, POLL_TOUT_US
> >
> > > +
> > > +/* Access flash memory using IP bus only */
> > > +#define XSPI_QUIRK_USE_IP_ONLY	BIT(0)
> > > +
> > > +struct nxp_xspi_devtype_data {
> > > +	unsigned int rxfifo;
> > > +	unsigned int txfifo;
> > > +	unsigned int ahb_buf_size;
> > > +	unsigned int quirks;
> > > +};
> > > +
> > > +static struct nxp_xspi_devtype_data imx94_data = {
> > > +	.rxfifo = SZ_512,       /* (128 * 4 bytes)  */
> > > +	.txfifo = SZ_1K,        /* (256 * 4 bytes)  */
> > > +	.ahb_buf_size = SZ_4K,  /* (1024 * 4 bytes)  */ };
> > > +
> > > +struct nxp_xspi {
> > > +	void __iomem *iobase;
> > > +	void __iomem *ahb_addr;
> > > +	u32 memmap_phy;
> > > +	u32 memmap_phy_size;
> > > +	u32 memmap_start;
> > > +	u32 memmap_len;
> > > +	struct clk *clk;
> > > +	struct device *dev;
> > > +	struct completion c;
> > > +	const struct nxp_xspi_devtype_data *devtype_data;
> > > +	/* mutex lock for each operation */
> > > +	struct mutex lock;
> > > +	int selected;
> > > +#define XSPI_DTR_PROTO		BIT(0)
> > > +	int flags;
> > > +	/* Save the previous operation clock rate */
> > > +	unsigned long pre_op_rate;
> > > +	/* The max clock rate xspi supported output to device */
> > > +	unsigned long support_max_rate;
> > > +};
> > > +
> > > +static inline int needs_ip_only(struct nxp_xspi *xspi) {
> > > +	return xspi->devtype_data->quirks & XSPI_QUIRK_USE_IP_ONLY; }
> > > +
> > > +static irqreturn_t nxp_xspi_irq_handler(int irq, void *dev_id) {
> > > +	struct nxp_xspi *xspi = dev_id;
> > > +	u32 reg;
> > > +
> > > +	reg = readl(xspi->iobase + XSPI_FR);
> > > +	if (reg & XSPI_FR_TFF) {
> > > +		/* Clear interrupt */
> > > +		writel(XSPI_FR_TFF, xspi->iobase + XSPI_FR);
> > > +		complete(&xspi->c);
> > > +		return IRQ_HANDLED;
> > > +	} else {
> > > +		return IRQ_NONE;
> > > +	}
> >
> > else branch is not neccesary,
> > you can directly
> >
> > 	return IRQ_NONE;
> >
> > I remember there should be a warning for it.
> >
> > > +}
> > > +
> > > +static int nxp_xspi_check_buswidth(struct nxp_xspi *xspi, u8 width) {
> > > +	return (is_power_of_2(width) && width <= 8) ? 0 : -EOPNOTSUPP; }
> > > +
> > ...
> > > +	} else {
> > > +		nxp_xspi_disable_ddr(xspi);
> > > +		xspi->flags &= ~XSPI_DTR_PROTO;
> > > +	}
> > > +	rate = min(xspi->support_max_rate, op->max_freq);
> >
> > use min_t
> >
> > ...
> > > +
> > ...
> > > +
> > > +static int nxp_xspi_exec_op(struct spi_mem *mem, const struct
> > > +spi_mem_op *op) {
> > > +	struct nxp_xspi *xspi = spi_controller_get_devdata(mem->spi->controller);
> > > +	void __iomem *base = xspi->iobase;
> > > +	u32 reg;
> > > +	int err;
> > > +
> > > +	guard(mutex)(&xspi->lock);
> > > +
> > > +	err = pm_runtime_get_sync(xspi->dev);
> > > +	if (err < 0) {
> > > +		dev_err(xspi->dev, "Failed to enable clock %d\n", __LINE__);
> > > +		return err;
> > > +	}
> >
> > Now you can use
> >
> > 	ACQUIRE(pm_runtime_active_auto, pm)(xspi->dev;
> >         if ((ret = ACQUIRE_ERR(pm_runtime_active_auto, &pm)))
> >                 return ret;
> >
> > So below pm_runtime_put_autosuspend() can be removed, actually you missed
> > pm_runtime_put_autosuspend() at below return err after readl_poll_timeout().
> >
>
> Thanks for point that out, now kernel already contain this patch:
> ef8057b07c72 ("PM: runtime: Wrapper macros for ACQUIRE()/ACQUIRE_ERR()") from Rafael J. Wysocki.
>
> So here seems need to change like this:
>     PM_RUNTIME_ACQUIRE_ AUTOSUSPEND (dev, pm);
>     if ((ret = PM_RUNTIME_ACQUIRE_ERR(&pm)))
>              return ret;
>
> I will add this change in next version.

Not sure if Mark brown take this change in his spi tree. It should be
safe for next merge windows, but I am not sure if it is okay to use it
at this merge windows, you should double check mark's tree.

Frank

>
> >
> > > +
> > > +	/* Wait for controller being ready. */
> > > +	err = readl_poll_timeout(base + XSPI_SR, reg,
> > > +			      !(reg & XSPI_SR_BUSY), 1, POLL_TOUT);
> > > +	if (err) {
> > > +		dev_err(xspi->dev, "SR keeps in BUSY!");
> > > +		return err;
> > > +	}
> > > +
> > ...
> > > +
> > > +	.swap16 = true,
> > > +};
> > > +
> > > +static void nxp_xspi_cleanup(void *data) {
> > > +	struct nxp_xspi *xspi = data;
> > > +
> > > +	pm_runtime_get_sync(xspi->dev);
> > > +
> > > +	/* Disable interrupt */
> > > +	writel(0, xspi->iobase + XSPI_RSER);
> > > +	/* Clear all the internal logic flags */
> > > +	writel(0xFFFFFFFF, xspi->iobase + XSPI_FR);
> > > +	/* Disable the hardware */
> > > +	writel(XSPI_MCR_MDIS, xspi->iobase + XSPI_MCR);
> > > +
> > > +	clk_disable_unprepare(xspi->clk);
> > > +
> > > +	if (xspi->ahb_addr)
> > > +		iounmap(xspi->ahb_addr);
> > > +
> > > +	pm_runtime_disable(xspi->dev);
> > > +	pm_runtime_put_noidle(xspi->dev);
> >
> > if use pm_runtime_put() here, needn't call clk_disable_unprepare() here.
> > after use runtime pm to manage clocks, it'd better use it all place.
>
> Okay
>
> Regards
> Haibo Chen
> >
> > > +}
> > > +
> > > +static int nxp_xspi_probe(struct platform_device *pdev) {
> > > +	struct device *dev = &pdev->dev;
> > > +	struct spi_controller *ctlr;
> > > +	struct nxp_xspi *xspi;
> > > +	struct resource *res;
> > > +	int ret, irq;
> > > +
> > > +	ctlr = devm_spi_alloc_host(dev, sizeof(*xspi));
> > > +	if (!ctlr)
> > > +		return -ENOMEM;
> > > +
> > > +	ctlr->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD | SPI_RX_OCTAL |
> > > +			  SPI_TX_DUAL | SPI_TX_QUAD | SPI_TX_OCTAL;
> > > +
> > > +	xspi = spi_controller_get_devdata(ctlr);
> > > +	xspi->dev = dev;
> > > +	xspi->devtype_data = device_get_match_data(dev);
> > > +	if (!xspi->devtype_data)
> > > +		return -ENODEV;
> > > +
> > > +	platform_set_drvdata(pdev, xspi);
> > > +
> > > +	/* Find the resources - configuration register address space */
> > > +	xspi->iobase = devm_platform_ioremap_resource_byname(pdev, "base");
> > > +	if (IS_ERR(xspi->iobase))
> > > +		return PTR_ERR(xspi->iobase);
> > > +
> > > +	/* Find the resources - controller memory mapped space */
> > > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mmap");
> > > +	if (!res)
> > > +		return -ENODEV;
> > > +
> > > +	/* Assign memory mapped starting address and mapped size. */
> > > +	xspi->memmap_phy = res->start;
> > > +	xspi->memmap_phy_size = resource_size(res);
> > > +
> > > +	/* Find the clocks */
> > > +	xspi->clk = devm_clk_get(dev, "per");
> > > +	if (IS_ERR(xspi->clk))
> > > +		return PTR_ERR(xspi->clk);
> > > +
> > > +	/* Find the irq */
> > > +	irq = platform_get_irq(pdev, 0);
> > > +	if (irq < 0)
> > > +		return dev_err_probe(dev, irq,  "Failed to get irq source");
> > > +
> > > +	pm_runtime_set_autosuspend_delay(dev, XSPI_RPM_TIMEOUT);
> > > +	pm_runtime_use_autosuspend(dev);
> > > +	pm_runtime_enable(dev);
> >
> > devm_pm_runtime_enable(dev)
> >
> > Frank
> > > +
> > > +	/* Enable clock */
> > > +	ret = pm_runtime_get_sync(dev);
> > > +	if (ret < 0)
> > > +		return dev_err_probe(dev, ret, "Failed to enable clock");
> > > +
> > > +	/* Clear potential interrupt by write xspi errstat */
> > > +	writel(0xFFFFFFFF, xspi->iobase + XSPI_ERRSTAT);
> > > +	writel(0xFFFFFFFF, xspi->iobase + XSPI_FR);
> > > +
> > > +	nxp_xspi_default_setup(xspi);
> > > +
> > > +	ret = pm_runtime_put_sync(dev);
> > > +	if (ret < 0)
> > > +		return dev_err_probe(dev, ret, "Failed to disable clock");
> > > +
> > > +	ret = devm_request_irq(dev, irq,
> > > +			nxp_xspi_irq_handler, 0, pdev->name, xspi);
> > > +	if (ret)
> > > +		return dev_err_probe(dev, ret, "failed to request irq");
> > > +
> > > +	ret = devm_mutex_init(dev, &xspi->lock);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = devm_add_action_or_reset(dev, nxp_xspi_cleanup, xspi);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ctlr->bus_num = -1;
> > > +	ctlr->num_chipselect = NXP_XSPI_MAX_CHIPSELECT;
> > > +	ctlr->mem_ops = &nxp_xspi_mem_ops;
> > > +	ctlr->mem_caps = &nxp_xspi_mem_caps;
> > > +	ctlr->dev.of_node = dev->of_node;
> > > +
> > > +	return devm_spi_register_controller(dev, ctlr); }
> > > +
> > > +static int nxp_xspi_runtime_suspend(struct device *dev) {
> > > +	struct nxp_xspi *xspi = dev_get_drvdata(dev);
> > > +	u32 reg;
> > > +
> > > +	reg = readl(xspi->iobase + XSPI_MCR);
> > > +	reg |= XSPI_MCR_MDIS;
> > > +	writel(reg, xspi->iobase + XSPI_MCR);
> > > +
> > > +	clk_disable_unprepare(xspi->clk);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int nxp_xspi_runtime_resume(struct device *dev) {
> > > +	struct nxp_xspi *xspi = dev_get_drvdata(dev);
> > > +	u32 reg;
> > > +	int ret;
> > > +
> > > +	ret = clk_prepare_enable(xspi->clk);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	reg = readl(xspi->iobase + XSPI_MCR);
> > > +	reg &= ~XSPI_MCR_MDIS;
> > > +	writel(reg, xspi->iobase + XSPI_MCR);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int nxp_xspi_suspend(struct device *dev) {
> > > +	int ret;
> > > +
> > > +	ret = pinctrl_pm_select_sleep_state(dev);
> > > +	if (ret) {
> > > +		dev_err(dev, "select flexspi sleep pinctrl failed!\n");
> > > +		return ret;
> > > +	}
> > > +
> > > +	return pm_runtime_force_suspend(dev); }
> > > +
> > > +static int nxp_xspi_resume(struct device *dev) {
> > > +	struct nxp_xspi *xspi = dev_get_drvdata(dev);
> > > +	int ret;
> > > +
> > > +	ret = pm_runtime_force_resume(dev);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	nxp_xspi_default_setup(xspi);
> > > +
> > > +	ret = pinctrl_pm_select_default_state(dev);
> > > +	if (ret)
> > > +		dev_err(dev, "select flexspi default pinctrl failed!\n");
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +
> > > +static const struct dev_pm_ops nxp_xspi_pm_ops = {
> > > +	RUNTIME_PM_OPS(nxp_xspi_runtime_suspend,
> > nxp_xspi_runtime_resume, NULL)
> > > +	SYSTEM_SLEEP_PM_OPS(nxp_xspi_suspend, nxp_xspi_resume) };
> > > +
> > > +static const struct of_device_id nxp_xspi_dt_ids[] = {
> > > +	{ .compatible = "nxp,imx94-xspi", .data = (void *)&imx94_data, },
> > > +	{ /* sentinel */ }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, nxp_xspi_dt_ids);
> > > +
> > > +static struct platform_driver nxp_xspi_driver = {
> > > +	.driver = {
> > > +		.name	= "nxp-xspi",
> > > +		.of_match_table = nxp_xspi_dt_ids,
> > > +		.pm =   pm_ptr(&nxp_xspi_pm_ops),
> > > +	},
> > > +	.probe          = nxp_xspi_probe,
> > > +};
> > > +module_platform_driver(nxp_xspi_driver);
> > > +
> > > +MODULE_DESCRIPTION("NXP xSPI Controller Driver");
> > MODULE_AUTHOR("NXP
> > > +Semiconductor"); MODULE_AUTHOR("Haibo Chen
> > <haibo.chen@nxp.com>");
> > > +MODULE_LICENSE("GPL");
> > >
> > > --
> > > 2.34.1
> > >

