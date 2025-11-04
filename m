Return-Path: <linux-spi+bounces-10997-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C3EC323A3
	for <lists+linux-spi@lfdr.de>; Tue, 04 Nov 2025 18:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C073BE1BB
	for <lists+linux-spi@lfdr.de>; Tue,  4 Nov 2025 17:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834A733BBBA;
	Tue,  4 Nov 2025 17:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U295ctf1"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010033.outbound.protection.outlook.com [52.101.84.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4325133B6F8;
	Tue,  4 Nov 2025 17:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762275770; cv=fail; b=QXQAsnZ41+HmMSwl4LKABPBsCae5iiUq8NeO4D+vNo8kun75Y7jMVIpkyp/NtPO6XHhgMO1A8sNVtjMRsYaEGyUeItHQelu9kiwAh7rmAEtP7MkrTpso2MSSChPAyxAonDY1sf9zp7OBRE+zh94NPzbjJiTj3Zr3XdkJMAkloCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762275770; c=relaxed/simple;
	bh=6bGwpe/0slWcOqbIKB6WbBQkbs5oXYLeskKK6p/T+oI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=U7raX1CURg+XVI65fLJoiBMdE5SWopfJWY+nEPlY0PkhBOd+rT+pnwqOzvTmNpfBfWzJo3x3r4tyG0v5YcGBBukxXszu0qgG+dwv5vADlbMamdlCPd94sR+U4seg1UZVqwmLMD9HtMtCDpaFQ+kc6oxulozwOxcW8dwChqOk3cE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U295ctf1; arc=fail smtp.client-ip=52.101.84.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EK0dpknhvSxBQA9FdVfw+4SvcHnrPjm9eVwkYJQPvFuabfwzNrQz18Ks2VC7EpC4yuF5em1bKDkNC+802FfJQO905ylqZa21OhQxKPXkxst4ipOnvda6tRzLnlsHszAFAsGmxmNt+RyybP+yRtiH9dDJiwFDfSGIqwCDPHNZDALBP8Y0iP6+L0MUqvbvBXWvpD5vgwdSws664Z4l3IwGglbNv84BVXeX8Gl8SF+iWewbKfZwkg4ktSGZUHxA+jIzi+EutdcTz/7JczAum7DWo3YfN7NSEnNzVkZGcY8tWjP5u84j1SnZc5JmaME86kcmcw+37zDYvEo9pSwpqKP8eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbX+yCKdcc2LlClAfvkqgxNk1MWkkccAHACm0NfaHvI=;
 b=jf7NC43WGUcOHLgrAXgsuAgrRnG26ALx0Y0x6GOyrCSh+6QVyrKcrr0n3oTeq69Z1kd5Ta/1ELaLXn8wueozKRo8rAKuYd+ZKaws4mwi0xuoACGWj/2MfbI55SmiZnh+argesVeTWZzd0PY9UBkwmRghjnBYAZ+xg55yLu+vOENwWSSoWKd2pE/d/Anh+b8q3KuniRsw/A+9PvDmIkGpzET9e1owUcWP1R5x4cA7CWcikeIRj4qToCmmpd+Alq/IomyniZ+l2G3HOCtEYu3QFF8dLgIwHcLKTu67I2PPHMV7UP+SkMHKhsmJjQGw5+qib076T7b/Dbeeb6NE7suqfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbX+yCKdcc2LlClAfvkqgxNk1MWkkccAHACm0NfaHvI=;
 b=U295ctf1qNuNz8XHilFvyWbnPV6WeKlh6l8Sc1shYMNldyb4uD4SsLVLfSLLiQXgWIak0eXc1ebIEO2K4uUQEgsiUS6TYdH6qZfWBDfMZ8VLkqbUwnFBlcZU12Q6fAZP79p6b9/JUh/Lqjy1h9N6O+ZjbUxYXya5PL3jlt0hfK0kHnOVWNAyLm/GMK9zEA5Wb8DjYV66L8L6wk1+1lnLD6qYE7nTztw+X7gzEcTXmz3mEI/mWZsSJhhk9oycKByvY8OK6JiU74coBd/wtD++26/NWNGvNZAxoBsQhoOR6TPIfm8yM5nvPJ1Z2nYWuoA7h/EjY4ondap277N8Yd8omA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DU2PR04MB8648.eurprd04.prod.outlook.com (2603:10a6:10:2df::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:02:44 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 17:02:43 +0000
Date: Tue, 4 Nov 2025 12:02:37 -0500
From: Frank Li <Frank.li@nxp.com>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Han Xu <han.xu@nxp.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: spi: Document imx94 xspi
Message-ID: <aQoxrW27WC6EEAkW@lizhi-Precision-Tower-5810>
References: <20251104-xspi-v1-0-1502847ade40@nxp.com>
 <20251104-xspi-v1-1-1502847ade40@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104-xspi-v1-1-1502847ade40@nxp.com>
X-ClientProxiedBy: PH7PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:510:23d::18) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DU2PR04MB8648:EE_
X-MS-Office365-Filtering-Correlation-Id: f8b3a45d-79de-4eb4-2a16-08de1bc3f891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tXu7oaHTDfRAomlTDAeHqCAy1zx2GtxWNZi7hZdmQrItqr7ZYCksLPJXWy7p?=
 =?us-ascii?Q?d9/giwy/a/I3tgIrymuh85rX/+CTj7YEDTKkZVrBnrVtAX9FIjIQYLfFhY3n?=
 =?us-ascii?Q?r6W9PhvwH/jSSNJsKPN9hMwZMVt0Ut9weEV6JtferzRXdjDqaXfSlo63Q1VC?=
 =?us-ascii?Q?8oSkXaW+VR9A2DRdemehk0yWSFsqDGqqj7fxqz3nJUVYyHASyzq5ZEwGLbaN?=
 =?us-ascii?Q?GEZmwDuwz4nuT9V85xDT3Yi1wLb8xvUOCclWvZ15YBAUIQE0APDvZQzclv2R?=
 =?us-ascii?Q?VIjnjW5UMd8/+En/NR1ALlP+jPMPvLkG4gz0ebeEtO/56wOvs9qU67Nzxh7a?=
 =?us-ascii?Q?v1A4gkGknKgPdMXLY38eWrL9jz200MY3MgtGZLJ46TwWO0bt11sZOgZn2rjD?=
 =?us-ascii?Q?enHLY5VTGOVJttC/xmpzBJvOaDObN/79brHyCH/9QOf5r4N4Ueyem4ELS8Wt?=
 =?us-ascii?Q?ybBHxg1bIisU64W+k3CKyKoeDj63viY3/wYjqmDgWSWAUdGkm8Ek8IP9OGiz?=
 =?us-ascii?Q?1HHM+J1tLkGqWacMAcik63l94OBdBtTGvvSA+IrF8BLJrPGv8E5wzrK8mhbR?=
 =?us-ascii?Q?vUoO1wP4aRJkGw3MHEvtk2+/HN9caCSmE19MAET0OuryUW3L0FEGATrpZRvl?=
 =?us-ascii?Q?T/xfwdexXiZ1POTF4S1/cNoaaGkByHBaRA2MJDUoD7EyvBUbbu9icPIRnAyo?=
 =?us-ascii?Q?YJkQN9LUJKW6nCl18fe1/4XhN1af2vb2WRJz6L3OFqCZM8huPN+mJEXl6/Hb?=
 =?us-ascii?Q?GG7u2Xw/vUd90xOp/xXKrlnjFbpR+CwhQtoyZ7XSlK8Hs6XBUeUY+oeRKepU?=
 =?us-ascii?Q?M1+bKrqEoM2J6cgF/IiaqTKk3aP9Vz3RDajBQYKbJGZvkAjrTJr6GEDoMAFq?=
 =?us-ascii?Q?MaeSF8X/kego0oqKkJRgKCZ+Gi9yZN32evxGJormH59V+LhmrtDjXq/eOMxv?=
 =?us-ascii?Q?eR4NmZl4KZKX/ZZDv7FqpjsCjhVsZdQrVKTMgUbIhCyeaXEQ5Z0A0oQ1Gsm9?=
 =?us-ascii?Q?7lcDXsv3WcuDCvVgB+bfNAMiyAZ7YyUtF68AS5jysdWqMbtbe9vnQNxnTImF?=
 =?us-ascii?Q?q6f8pWrNPpRwJg4bcL99weWXvNsdS6wLSjNUavMC1XMZg2VPV/b955zrjezI?=
 =?us-ascii?Q?3elBYgEVTxo4WcHLWr+3U20EuH/Mm6Dj5kSTsrpVzL5PTXUL0z30nWNXID8Y?=
 =?us-ascii?Q?SGTqEO2e33DEJ1MwgfGIzqSeK4YtutCWkRIUbPjm5oKhgRmNCckM72RfE/x6?=
 =?us-ascii?Q?sPrdr2xvWTN9DndKyZGDn5C8W7X92ehk51Divg5KQgVzcHn/RgZJ/o2EIcoC?=
 =?us-ascii?Q?7Vas5X/sBMnWribH7rZBgfkkkUBIbPGJn7TV1fBEAgkscHkZli2/C2tButzj?=
 =?us-ascii?Q?Mo9JFeCdp4WFi0PDvRXT3zOSalAcnlB1KmH/S7BFcdTwEjD7tXMfBB38fLly?=
 =?us-ascii?Q?0wFvAKJmEj+W1N+1GiYmOpSZII/ccJMQlFfhaE4phZq22EtAqeuyqw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rk4IBvqPBrLd3TRJT5AGxWVO4mhYKeQl3OCPp3cx7Zlj/8LVuxAbvWfg/h7u?=
 =?us-ascii?Q?lj2Jz3FxOV32iFglur7evfXBlTJd/zBSNFLYB/fU3RkD8wShk5r1gEbyF/El?=
 =?us-ascii?Q?4kgef/m59LVTls0tMJtuTWaesxzGllOXcr4Nh/yGVnxK/MUfW797ROwpeNOK?=
 =?us-ascii?Q?96q3BCmhmN4Jf9TadHRNUtXZ4EZkgJXm5DbXgTyZ++v0puuYlRn54i4P+Hlv?=
 =?us-ascii?Q?iG+SMZu3gpnfUYNu0L5Q0T40/YQ90gDtKUJc9pzeu9eIXzgZK4Ep2rBReF3+?=
 =?us-ascii?Q?LaXAisaz5UK0mLmwHMb/gsn0TxZ8GjxAud/yy2zuRB0zcRaCcQvmK709ByVz?=
 =?us-ascii?Q?2XNoSv/4uPtkXfEBH/6vDWoP4XI8fKTfpUiSJta+6ccHerNwRDRZ1UfwAunD?=
 =?us-ascii?Q?8XN7onSHWNtuYc2ZbOUVHZ7idPvK7QpAHZjHVxTaBJCnMGo9dnlwJXzxSwCF?=
 =?us-ascii?Q?B72H7FH4TVz/WGEaUu/yjdqaj1ss3aIn3fGH6rqVowjjtBsZAlI3lo3VmlFA?=
 =?us-ascii?Q?xYVVEFOyu/GbBXpOC2cCoouPyvmss/yNosu9cY85ScvHebaoq2T2IBzuJVAd?=
 =?us-ascii?Q?37xZFQhP7SamLgTGwK5BuPhz4R/pBX5XkCNCV2bzmJQ3NIopx3uAOI9uuowj?=
 =?us-ascii?Q?8LNLY6akGeFEXvNcoEGpSjsmegpw6OneKMZBDfjlqMyTA07hzQ8WHBozpgV6?=
 =?us-ascii?Q?nKSZwftfnBALfzanOzYbwOvuqGxU4dcvGM2lC1ePWQzgF4puvbR8g5hXhnJC?=
 =?us-ascii?Q?DSGINSiSismk1fXlKXBjkd3we9FcjbHbcmK51Mh/s9SG0h3O+h7q/LeE5vMI?=
 =?us-ascii?Q?TimYRjAceYKq7E+q2DKpwgTi4viJl4jAahel4Trf92HUNS3tQ4g8p2Lcg6M9?=
 =?us-ascii?Q?t6WwzqyQNFvfzyzvnLlkHgAS7IhwrVJodLVqrnRg2PQvfS5d1aMthXlv4AS3?=
 =?us-ascii?Q?fz3gGi2Z8tGXDX0KO8OmJ6zvDOdmHkMge4KbvZ5uh8t8qM3F9COdutwA2x1r?=
 =?us-ascii?Q?T84OOzrTDZQxxZXgAdiK/fJnCCIAGi+vhzb0GNUwIktavCRp8YsOKn+ih2Pa?=
 =?us-ascii?Q?CyRpLzz9XEAK7J1lsW1T0t4AizfIyxLCXj5mQYPmctLmzcmkLgmYefSuZ8M1?=
 =?us-ascii?Q?R0TTsMg/VRYwJ6b50Ec6bs8G5UEMuKHGzaGx1DlfedVIJ41dA/hv0NynkB+I?=
 =?us-ascii?Q?uRhRVcSyOf/7hH4amOs0VvNJ8tfgPTHqxi3H0Pmei+2llx/XPXmsTqXW8Jxj?=
 =?us-ascii?Q?Z3KYKWFfMAcjfPV0kUzBQ4EDytOq/x4lnyUTFW5Xj8d9BuYMQZaxM5CG94zx?=
 =?us-ascii?Q?JQlwIKKHkd6wOcoCoj7Us3z7g9ElY0k28KR/0A30Nvsbnt4SRosa8sw9mG9/?=
 =?us-ascii?Q?C0iOi+lcngxh8N4Nyg+RnZdQS4r4gBRaKAOm5r7jI4Y/DHrNUZxnwxURlW5w?=
 =?us-ascii?Q?jNB6qlqVdTFzaVpmlAFWyLPmp6cXcVOQ3pLUdLlIj9XFTESr4HmR+sYJ/N4Q?=
 =?us-ascii?Q?j1a9tsjVY106PQXulXzPFueUJy2gcl/Yb+IM984ByOH5xYLJDoE8DAUv34z4?=
 =?us-ascii?Q?TohGJ/+k8VzYPZR8Se0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b3a45d-79de-4eb4-2a16-08de1bc3f891
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:02:43.7319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hu5u10SqFig+xIEOLbts1gY66RORjDPrrepx/zzJTe4VDGKENo9m8JX/PAipeke9u0OgTB+D7g7+W1LnkCDGcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8648

On Tue, Nov 04, 2025 at 11:07:36AM +0800, Haibo Chen wrote:
> Document imx94 xspi that supports interface to serial flash
> supporting following features:
>
> - Single-bit SPI, Dual SPI, Quad SPI and Octal SPI.
> - Single Data Rate or Double Data Rate modes.
> - Direct memory mapping of all AHB memory accesses to the
>   chip system memory space.
> - Multi-master AHB accesses with priority.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  .../devicetree/bindings/spi/spi-nxp-xspi.yaml      | 84 ++++++++++++++++++++++
>  MAINTAINERS                                        |  8 +++
>  2 files changed, 92 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-xspi.yaml b/Documentation/devicetree/bindings/spi/spi-nxp-xspi.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..36970514036fe8e776908a15ed1ea2b21f2c4c9a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-nxp-xspi.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/spi-nxp-xspi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP External Serial Peripheral Interface (xSPI)
> +
> +maintainers:
> +  - Haibo Chen <haibo.chen@nxp.com>
> +  - Han Xu <han.xu@nxp.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - nxp,imx94-xspi
> +
> +  reg:
> +    items:
> +      - description: registers address space
> +      - description: memory mapped address space
> +
> +  reg-names:
> +    items:
> +      - const: base
> +      - const: mmap
> +
> +  interrupts:
> +    maxItems: 5

It'd better descirpt irqs

interrupts:
  items:
    - description: xx
    ...


Frank
> +
> +  clocks:
> +    items:
> +      - description: SPI serial clock
> +
> +  clock-names:
> +    items:
> +      - const: per
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        spi@42b90000 {
> +            compatible = "nxp,imx943-xspi";
> +            reg = <0x42b90000 0x50000>, <0x28000000 0x08000000>;
> +            reg-names = "base", "mmap";
> +            interrupts = <GIC_SPI 390 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 391 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 392 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 393 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 394 IRQ_TYPE_LEVEL_HIGH>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            clocks = <&scmi_1>;
> +            clock-names = "per";
> +
> +            flash@0 {
> +                compatible = "jedec,spi-nor";
> +                reg = <0>;
> +                spi-max-frequency = <200000000>;
> +                spi-rx-bus-width = <8>;
> +                spi-tx-bus-width = <8>;
> +            };
> +
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9c92d43af5e22ae57877e239b47fd70decdb3fb9..2a47206cdb290b27ac6829d3a92289ca65d28d46 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18622,6 +18622,14 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
>  F:	drivers/spi/spi-nxp-fspi.c
>
> +NXP XSPI DRIVER
> +M:	Han Xu <han.xu@nxp.com>
> +M:	Haibo Chen <haibo.chen@nxp.com>
> +L:	linux-spi@vger.kernel.org
> +L:	imx@lists.linux.dev
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/spi/spi-nxp-xspi.yaml
> +
>  NXP FXAS21002C DRIVER
>  M:	Rui Miguel Silva <rmfrfs@gmail.com>
>  L:	linux-iio@vger.kernel.org
>
> --
> 2.34.1
>

