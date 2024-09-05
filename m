Return-Path: <linux-spi+bounces-4658-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FF296D3B6
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 11:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B73951C21DEE
	for <lists+linux-spi@lfdr.de>; Thu,  5 Sep 2024 09:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B8819754A;
	Thu,  5 Sep 2024 09:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BY6vGkrc"
X-Original-To: linux-spi@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013071.outbound.protection.outlook.com [52.101.67.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95ED18D65E;
	Thu,  5 Sep 2024 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529495; cv=fail; b=nktPl7q5EeV0j4MhXBfG61cGYJI7jf3bMa4BTVKydHUNz+ZZUOhXzaQ4oMRLgrEWf2PRIw85nmyeMVGlZL4XgSg19KnzlPrb+y41rFMagkSyqcl2Dg9jmhNXxppkngg/Fxm7N83FHL6HEX0GHW4svACrOGEA0JqC3h2NYSTeGU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529495; c=relaxed/simple;
	bh=cGmLTl4opu8CqwM2gGMInE7EEHLhY32C5F1ua3VjsZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NQLNmj0b/vwpAgcZHYFlgr8NmwrJGnXJQyxcneZQPah7ld+Eg2uCUcCxBaxrNZooCGjjDXP5RXHr0Vie9zEcY6VF7nQqgqwPN0pQRxNeetEDgPuT+e+NZoS0FyaARlg1+WKiRA+netLbaKM+pGMOh8ndVrUDQakvbE7QP6elCw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BY6vGkrc; arc=fail smtp.client-ip=52.101.67.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/ej+tZTyQYA3Y5nBXI4yojC94jEGEaI/k+a87by17Uo6RiZH5cTOzj29itW3nQFf9SKmW61zGu4js9ePjSmW+kIGdQRaDMWuR30dagA6f6OnUei9TNzlyEiYrNqqeUuLlLKCrwPGuRAGqCq9MDOWWmKXs1LVlCHd7FNDteQrs6G8eVslNvl4Ql1gev+EKfNpgWO0hdzBFDcZrRSgp+SoaXwaB3S4+z22sfhELE8vSQ67xxoSXGK91dBtINrATQLP+UwwVn77TvqqqlW/F8AqEz0zpIjktuJC0JzrUUVIhhw5oRl/rTiAZjmx0G6mzhhgSGfZ4OTBjcJc1sD0bYJpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prXM4rf8YEc3AhFa3TbIuL6uBLNhDCa9LMsF5kDxPX0=;
 b=Emooj9thK0EEDwt5gvFxn1pKf7o9q544/5OkmQ2qFgKQVtxYFROaH7l+dhE6soykvvmedQ+SwgqlQTJs8l++pFNgM7w5LN+zjTPpTfLF7PxoNT8+StR4lhIncJFy9+JhR1wgnRPDHT/1XqOgtUZw1RqM0y0jRswhMgDo0xqdrwp418qXYSrwVn74vSe3PjmP2XSbbDAEF6ziW4z8OPOzA9byCaBZIRpWYnwHKushh8+53V23+R4tMsMqiiF4FYlzyeLGnkCkerSlzo888Z9nEd7v3N8Dag2y10ygJg4pf7+saAdQT1yxCO2Fz+bzbT0lNoSOVNgJE9LwI7azzir0RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prXM4rf8YEc3AhFa3TbIuL6uBLNhDCa9LMsF5kDxPX0=;
 b=BY6vGkrcIMUoZsx6FLGoNsRV8UC3bRi9gNaulkbwKeMYOyb01u10LLX6i6B4ypzXaWTeaYUyewJ/1P/5Oi7WkrHx756tfIUw3COkCvaYY9JIyaHO7TXF9fE6UVxRIRnowYejBJ24YccwIyro0DcJWvK4TXWKOy5C+fgwNMrgXbUyrk2P+9Xog8NKLal4PIEbnNcXm+PMj7SU7KcKsdH9/Gb5IiSiL+mR4zijrNagd7CCKV6v7s+qAS/TNkOnuYf3a0xHzoOFeZj7ytUcxaOgxT7s7YYh3YLR+VQ+lKGhZPtLWvr7dqlKYbahXzoTEZNz1ucwvebXcWaW7a1MkrmXvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AS5PR04MB9753.eurprd04.prod.outlook.com (2603:10a6:20b:679::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 09:44:50 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 09:44:50 +0000
From: haibo.chen@nxp.com
To: han.xu@nxp.com,
	yogeshgaur.83@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	singh.kuldeep87k@gmail.com,
	hs@denx.de,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	haibo.chen@nxp.com,
	peng.fan@nxp.com,
	stable@kernel.org
Subject: [PATCH v3 0/4] fix the flexspi error on imx8ulp
Date: Thu,  5 Sep 2024 17:43:34 +0800
Message-Id: <20240905094338.1986871-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|AS5PR04MB9753:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e58ba9f-1b0c-4c89-d780-08dccd8f62be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rk3b4iB+c6bH2HKMBpmktKg+M6rIGdFiz1fzBqHh8CfpOtc/UZxvtmvr9nIj?=
 =?us-ascii?Q?iGz1bweLQ74FEpY7ASVXanFe72p8tHNdnwK7jNS+W3saed8tE2eKPiWNWhRP?=
 =?us-ascii?Q?wGWgqvdbVCjmeDySjd04N+gym2xIPNyupx5Q4qJ1YUpJitEKxot+P5f7RYwU?=
 =?us-ascii?Q?XJ1DLUEXabHsviV02Uctvg5DNGBz58bo2yk8WT03uQO/leR4/5FjwaKKvvQ8?=
 =?us-ascii?Q?TwnH4xr5WAOjp6CzSLxILD/YKuHmz90DUX4q2qtDlB9xPnDDLP6RsyJaPaSr?=
 =?us-ascii?Q?vPx8B7gNHY0LT5iYTfLdff9YmlT6vx2m85gMb6wd1SWtKYQYsLvJeJ5uCJ5C?=
 =?us-ascii?Q?v/uJxqCOZRZXDlNIVbTVqoujjYdD9BhcID0BSOrUWXcQtLrIQtsYQ1iVWrJ8?=
 =?us-ascii?Q?0TrgIbbLHdMhB9ZDXlC/djMHKJM03DSVrOPVWLTn4roTgJNl0ZsMC+5V3LEf?=
 =?us-ascii?Q?LGgL6ySgJKup6PxF8bmfKTTTwg0HAEzQvvwB6Awow+i5eScHc+zkvZrEuYZt?=
 =?us-ascii?Q?Rtm4g9AoZL5OLqN7YqjgVBd4qZ4rgfVdRj/5BdzHW9hfAJKyZ31Ooa34/9nb?=
 =?us-ascii?Q?QxhSrqTVEBJyFXA7WmgDNSeJ7FzKeaoOnlWdJBzFDGM6XVNFwgp+oJbVwNWV?=
 =?us-ascii?Q?jGukxI9NQ542o3zssWwvux01y8bW8PoIRaj0duSlELsUhwu2KfDhDaHnzVpj?=
 =?us-ascii?Q?PnHxt97N4kx2k66M31cQn8iCD0Wz17DQ2MSeuuqYV8LMBM6S/jx9nmuPHUVg?=
 =?us-ascii?Q?vSa9E8Uj6OQwfKPiVlncPKEStE/M66JWoAKHG2B5p+Z7rSh/HAKYufRCF/He?=
 =?us-ascii?Q?2SWqIA39nHKRB0CXyHmW9EJBrrcmsZql3TngzUcqJbmKVF7bsKeaGsAuTWLS?=
 =?us-ascii?Q?gZYb8rjXwHTMJCfnQxPvdsLrKKmWZcD1Ganx3Sd+wY4CUt60d34pAQ4a9z5W?=
 =?us-ascii?Q?uC7T531h9zmnnYdtyPOPFDYUqkj8JXHoNYG2OkH3hAHM6twMUndqLudqKSsn?=
 =?us-ascii?Q?q9SAoTXXsTqsTtaE7bv0ZT+QVUzC7UaJ8V5RSa9apf5zKFCxTpBpWyhzeQua?=
 =?us-ascii?Q?897RnLhzg5g6wgaS4MGQqovJunZGg96EzyALYA8zLaoipQ3uYOoQeVebeePZ?=
 =?us-ascii?Q?zbXSEna2qwXT6dmnMpWYP4xODoueNy3o05ibwahlqlo3slcVyEWYGFCZ0kpv?=
 =?us-ascii?Q?RDrsKat24s4tWrE6vCyh8USpQ3+jR8qhDuk2GJTa0Xzrc1lTi655dzqNjupP?=
 =?us-ascii?Q?Y2z0Vmz6qHVgoCSU0HHjlcpO+7u3fxaIJnybRC+SUHvaaNMGctoNWNZ2Lp8A?=
 =?us-ascii?Q?uOkryQBMQ9pQm4E5OvPrH1Wv1gm77o0s3sL+NZ8m8ZM1bHmgtTYXrT06UnLp?=
 =?us-ascii?Q?DvOwXHuTLI1KviNAB/6DcyqvZE6pQfnyGeS2CBlxMH6v30Q7/w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ESvoWkHxQcS7+OelznfxvZ7Hb0d4VHVy3nYWh5tNXytriRQ1vogpBcK56Vxz?=
 =?us-ascii?Q?JsZZlCmhcRO3ne+cVkdVt1Gq5sYTDiDkyKkWp+LNK4auVF9khZJ0Po2EgQqq?=
 =?us-ascii?Q?OgzYUt2qvd4YtK1yJ3fTi86nOWolxzWGUYxUNZ21SpUyDvk+e9oIHjb9n+mh?=
 =?us-ascii?Q?MNV5OHIYc4PTO8U4l8kSVvUDF3Q3ZdoqRFBc3xDyJn3fm2/j63txLzwxejvU?=
 =?us-ascii?Q?2Nnac8ETEGgjgUkjYIPj0P73IN+OuRDEHJKne7ZYLZfbc414B0O8xg/zor7c?=
 =?us-ascii?Q?T1dmVRcGxljeSmDFnaQ2ih0DyzRWN1SyTCwvsyVWGUNOwwclv+0KY+0f42wh?=
 =?us-ascii?Q?3DhXQL8Vt3B9BfKjPgHsSQUvg8hnqx//eeAlRRqS/UE9cjWvhbVK+xLtGSN2?=
 =?us-ascii?Q?yu2el+4+vbTzNVU3Xs66a3gCGIXNHqhmDNARV+wZGn5RKxu3tCwohJOjXsYG?=
 =?us-ascii?Q?nBExW5LgTbvinLwEuQCvBwOsmL+s/JsFcxNQiK1K5Pj2hvgLSOGW/0LUVY4G?=
 =?us-ascii?Q?bYyNeYuBWjQZvTDQUeXMFJ8pQjWVuOON9yumy1yQ+AU4vAvtql3+MZ9RjN81?=
 =?us-ascii?Q?uvh/Sd3EFlfjoYJonR5K4/xkelEwIQidwn6ezN8b6WPhRw1IbqvAgfQT+fbi?=
 =?us-ascii?Q?Dh0fFrE6PlfeoyVmLNaN/bgeyeGEUgEZ52DLwC+pgG2xSa6LUatPvyqz6i0Z?=
 =?us-ascii?Q?MUYTie5Gjb79huuiMMWqhxczQRr8bR5MUndoF6z7n/eqiZsPih4RaxFOjkRr?=
 =?us-ascii?Q?pZE41lSihbyd/r8ISdmfJ9db1kvx0aGmwSn6IbwNU6AH6443JhTDxmrGD/9v?=
 =?us-ascii?Q?p7z/t8ntuW0WQEf3KkSqJjKnBcAoe/+5WxwK8Nnk3bFXWxfphdL6GqxWwP+N?=
 =?us-ascii?Q?YocP2/mmASMTZ6uzCscc7x0OUwvF0jvXGo//UWsVM7BXJ3ceK1woHH7V5D5e?=
 =?us-ascii?Q?gc4iAeYCvnfImx3kiqIf0OfEsV+Yuk4mzgc0CnYYqB+KHlZxFIfHXi+TN0tt?=
 =?us-ascii?Q?DNrGSynO0NhPzUoATf6Z7KwNYnV9c73oGW4dXMl1/2chgeuLRYlamXvvd/rP?=
 =?us-ascii?Q?oq5dzHToUOJJeYUMhRBt5sPbtZyBT50UgnjtXdCdHBh3KmBzYvb8tcXu9yfF?=
 =?us-ascii?Q?1e+oT1tozXtDI9nt00leyjAXdRLuYmXbuyRMu+mILWutbfh489e++SiH+jg7?=
 =?us-ascii?Q?BXIkx7rS1EML0Q472WGzWPuLLCIXZFxBOzU1gcRpkN4nzyEFhsPv91EMH8EW?=
 =?us-ascii?Q?U299wK4yrE5We2hA/9jDlm3bigB3YahO5LbNu3QERSHWxbfJZylXe/bUF4tq?=
 =?us-ascii?Q?MNd/tzXJ53q3qH2UV/yflY3dQfh3lbbYBC70B7h/sU0Vr7jCCahNcDR1nCR2?=
 =?us-ascii?Q?cbZJgEtGiOD7nGWbfsPE+wTZI0loFAQh0sNmOiIG7E7TdW0StEl+SDhXcpnP?=
 =?us-ascii?Q?0E/RNxJiaWaXjG+Uj1ho0GHCEJcUA+xyA8KfXJeekbTtQaGHxOTMffwqDV0/?=
 =?us-ascii?Q?+Rrv9O49t9SJKy4FN9/lXR7CQBz2mRk13PCSp4vogF2p4VoJC6F6DOJdrEs+?=
 =?us-ascii?Q?nDbYwlR1Ujli5GalTKa+FntIqHBYNTmOSf4vW992?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e58ba9f-1b0c-4c89-d780-08dccd8f62be
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 09:44:50.5972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wy5SGjjQhfgA1yYJ9AaSIpBZGQdAVkwZC6HE2caroI//+DxaeMOMFznZZDyCb9BV0f9eQl0mcAoGLUV0sZrQBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9753

From: Haibo Chen <haibo.chen@nxp.com>

The flexspi on imx8ulp only has 16 LUTs, different with others
which has 32 LUTs. So currently flexspi driver will write the
wrong register when fill LUT.

This patch set add a new compatible string for imx8ulp to
distinguish the LUT number.

Changes for V3:
- add Krzysztof Kozlowski's ack in PATCH1.
- add cc-stable and fix tag on all patches of this patch set
  all patch of this patch set aim to fix one issue.
- splict the original second patch into two different patches
  according to Frank Li's suggestion.
  one patch involve new number lut_num in struct nxp_fspi_devtype_data,
  another patch add new compatible string to support imx8ulp.

Changes for V2:
- Remove the change for imx8mp, since this broken users.

Haibo Chen (4):
  dt-bindings: spi: nxp-fspi: add imx8ulp support
  spi: fspi: involve lut_num for struct nxp_fspi_devtype_data
  spi: fspi: add support for imx8ulp
  arm64: dts: imx8ulp: correct the flexspi compatible string

 .../devicetree/bindings/spi/spi-nxp-fspi.yaml |  1 +
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi    |  2 +-
 drivers/spi/spi-nxp-fspi.c                    | 54 ++++++++++++-------
 3 files changed, 37 insertions(+), 20 deletions(-)

-- 
2.34.1


