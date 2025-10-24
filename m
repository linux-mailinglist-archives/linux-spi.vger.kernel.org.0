Return-Path: <linux-spi+bounces-10836-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5A6C082BB
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 23:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29CCB4E20CA
	for <lists+linux-spi@lfdr.de>; Fri, 24 Oct 2025 21:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C2B302CB1;
	Fri, 24 Oct 2025 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aoNNbUVc"
X-Original-To: linux-spi@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013055.outbound.protection.outlook.com [40.107.159.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65F9302779;
	Fri, 24 Oct 2025 21:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761341008; cv=fail; b=o/0TDz0tBe0Pewtu5CeFMQyb59O0rFpq4ByaYMVVvnHdfCGcM8PxKrZXOCkoLN9THed+/kQhPzILXVgUljCrsmGJPwIkXW6ymV3pww6lrd0E5sZ4AxWiWg8Yt06EtrGxyfq5JnnDu5ANcsz99tbbW6L/gPvhqtsgsXrbAFngkfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761341008; c=relaxed/simple;
	bh=m0YOK/vb7Fpx0NGJ2tl9c7nWVX4XNyPibeBUKOtzwNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tqk+5nfRRm9yjiIoeP65ssRaCPYRUDdW8kbDPePlDedTNFoamMZCkhZrdD64D8MOWVW+hA8rB4HtR7uO96J6Y8ypsaCOxq+LasA4k8jV/7ESoEzK5V+69vZ8uEyAOU6kGBCTvCehg5sNmDBD4ql7ilO1EbRyg0OiSj3BEuIsw48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aoNNbUVc; arc=fail smtp.client-ip=40.107.159.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpMiv1CF3mEvYNw//pubaukbJgOaSfIOMkP8EZXV2adw8gKaLCTdqaaSVvCxWYYOK3TH0lA9tCVLbgRoNr3Sm0WCjuOYFzXLMBz02VfgdRmfJB9fqlymK8rvMVrRl4px8CETHcbuqGM7cQ1cnT2QHBm3mUUtsTqzb7TxPfaM/U6OU2QaK89AhyUyZQPkZFMaEZQTeWGtv7v8Xb0gNtO+cFd9Q2lqMGG/Asdc1xlS4CYcR0oTsW+U6DI69/qtgBhMqsudpB95+xzqQgviS7jI5yvUkgoJ9XI+FviplrZ84fZse4HyIh60qzIlaJTO26pnMq1776wMB4DuBktZ4QpGjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PBes6iBaybeUrTOuP8mfojMQcAlgv33kILG+c6PHZg=;
 b=mAsxMaMtOmmCS+af68Cj4DJeq811+YvNCIFS4yk5uuEauaRKyNJCSlmiP60WOVauE7DBXf/mkeykXoJOlMSgFb10x9unIIQUTEaBzs9nbtlT85e8l7rQeHRWGEeXR5FP4aw6u/p0Hva/17o7fOMP7PLLsIuaKC1ddAnCXyx+26GoYJnHUOA7xoDbhIOdrcb7VtJh6Z8G/XsmkllfXJHbiX7wJGwcCq9cTH9kQFRYdKkl1Hr8/DqyYUcmALn3eyAH/bw/fQDy2/YCWghBKKs/oL7CVSJglb9JefvxE61DZBGOe7RoDaI/EGsr7lvSylEdfK94MX9zOn8bHb3AVB6u1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PBes6iBaybeUrTOuP8mfojMQcAlgv33kILG+c6PHZg=;
 b=aoNNbUVcgBdqxu8l0s8h0OpgmcqHZtPo9587KJibXodqkaH2ZY8z3d/rkVaoCGEAzgB7FkSHpNO47RHmOLAaAGXrH7cDQhE1s7Wn9dEku0C52xkVddHi8mm+zIVbZ+DYA+WyfgXx0rzwNpM9CyylcdW1y7cWPSeu4clcp/NWO07JBI53KAvCqxJbl1RswO24leOs4MQNNTTUI5HTwIJ3ayJuUEIkxer+Sav1uDSB8W3AQc1eUproeRIPpMwxDewVQ6kyhL0yKqH5Kt83JZG3zlseKjHFIlofyyYe+G8W60V3ELQxiUYBCqGulNvscKhkYjvDIdobiL9xNU2wNm1cAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 21:23:21 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 21:23:21 +0000
Date: Fri, 24 Oct 2025 17:23:11 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alex Elder <elder@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	han.xu@nxp.com, broonie@kernel.org, dlan@gentoo.org,
	guodong@riscstar.com, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	spacemit@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 2/9] dt-bindings: spi: fsl-qspi: add optional resets
Message-ID: <aPvuPyEg0RtZWudL@lizhi-Precision-Tower-5810>
References: <20251024191550.194946-1-elder@riscstar.com>
 <20251024191550.194946-3-elder@riscstar.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024191550.194946-3-elder@riscstar.com>
X-ClientProxiedBy: SJ0PR03CA0297.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::32) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: d3646669-fceb-4acf-a779-08de13438e89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ldfCkn+Wwad/RThjOMx0GmxCFw6RyviG0W8ZwoE52oso7MvwoxTAo7Slsgk9?=
 =?us-ascii?Q?LVNltlAGFTMDwUWob9pImbKYG51Mzm1n07ApGDIiQm2A4p/XtNlT34r9iRPq?=
 =?us-ascii?Q?mnflLIKGTlv7QEVjOj2OAWuiM5IiuKthY9cWmgcS4DpUZ9RJ2UtQeRrXhmqI?=
 =?us-ascii?Q?PxXHJsQwviteCiWLlbxp124YbfZLGKpSB0rOUEahVUo/z+tnGv+JZxdffKfG?=
 =?us-ascii?Q?8JD+59tO6MMt5CHE85WzRnhncBUUA/zULn/xlsyyTi3GkePGdqT3ttVrJKxA?=
 =?us-ascii?Q?dC7g6tpp5rd/3Y6xrLA9nOOG1dDB3V7/bd/f/3DX+zdjic5QB3jME144ascP?=
 =?us-ascii?Q?J/vE1wpFm09kRQJFDLixEH5b7QQfe8hTGkStGwql/MKHRY8JEK80dN3JiixE?=
 =?us-ascii?Q?EIWC56BSxdQ53tIrv71e23lnR+VbFZZDQiow/6A3xbykTTOj2pgkOsP85jJm?=
 =?us-ascii?Q?j+xWESHvxubnTE/a1nPczUt9H58IowoaR3GE/X0uR12+fNcSeE8RCGV7C0ON?=
 =?us-ascii?Q?5Na5Q7Usgp/yyt6Wt+bVtp3P52c3MTQfgJn9VRZIOOL/LbkkYnmqWP9OTYO1?=
 =?us-ascii?Q?A2AMpMaIWZpZMXP2dJpNRxyAVLwBLFAMX9jGNILY6gI6o9dgCUihdTQemuYc?=
 =?us-ascii?Q?ZzWq/IKqj+phuyZysPsEaobSPiuowE5fR4J/iqj4sgMeQ6itWIK3GyOFUT1w?=
 =?us-ascii?Q?DyZMOnw3BcSp16PZMPLyT40TsNXDCZsvd7kczTpuiCOrjGf/1bgmRuQ9/VLt?=
 =?us-ascii?Q?z7IM4kuRHR8UcqI2HUsgkSAtKtaLHjGnnUSCbXQuJtBgsvGCZ5s1P4EJf60B?=
 =?us-ascii?Q?abdk3TyhaHsND3NkNg5+mCK0Cg1ogTH00J3rU+bBG2fvXENUio/j5L3YSB8u?=
 =?us-ascii?Q?m1Moj9EkMTDWUtN05FNv8Lzzn3lz3ueC7UErRNqJXv7wBoKVH9du/ubJPkss?=
 =?us-ascii?Q?eVKk+TyJQdbMVhbs6JzqnIl8OHV39YYbl4hwIO2NErqW6J3ACC5bWrvlNF0r?=
 =?us-ascii?Q?/1JoaWEUtSNYa0b6kNrgYXvJ9yBiySiPfeVQygjONhEeAWnECs8VJO0jt7I9?=
 =?us-ascii?Q?tPrF3MzC7VOg6heQt80CtlchPPdXmi3wCgtSPbsgxFLuhlxDJHcwCI4RcJPx?=
 =?us-ascii?Q?QMgACskg2npZgFrnyC5TwnubF/ltXtZSVoek0V61O0jmK3YxbV9wwqiuGCHy?=
 =?us-ascii?Q?EpXMJWz2cfekIB3yXyExe0mTcwAL02h55KFabCZsPz3V45yuXgNNJnum4Cys?=
 =?us-ascii?Q?67HLRMBEJKlBSaMN0CWEZu/iKRFj7ctQeW3QFKeHEd9yBuq8S/x5JNVWrHxC?=
 =?us-ascii?Q?6Sil+FAIcIi3z7p7NN9HLQmPOIs3VTQCsEfUJl/gsDTjfnxCDTEbKBvqD5Yl?=
 =?us-ascii?Q?t7tGBWQgCM9ZAUtI2ZR7dv0Jz+zr3R17TPLwtewXSM7TXKMe8axTsN16C2v8?=
 =?us-ascii?Q?ggzNj8pTO4hMHaaOggI4lYYkk5wfQ7caGDY0gFW/HJI/fRlWo3EeAGr4kJlT?=
 =?us-ascii?Q?AdmfSOu0oTW7bEZpz4/RZ18fmZ8GCTz0DmTX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uQmymX65mpF4gtH+ILVAbrPZUg6Oxi+iVusQQa1EYoijo/ifpmHXHSXeBsfj?=
 =?us-ascii?Q?uV+cEKIo//B9q5Uo4PaoPav4wTjcW/x/gfYbGPoCES31N+ZeBA2LXCZqp+84?=
 =?us-ascii?Q?OJMlnJTUeIOzm99OXrE4xK5kMK22/Ql547MlG+NuLFVQTA30C/P5IBU1KJvm?=
 =?us-ascii?Q?C5f74HD2WYJ7p3btsIa+G6cpjCa4dgZJczCbRTVaSs9S6VQKey2MY0O8wRjj?=
 =?us-ascii?Q?fwSx9LFpkadi8J1Iozux28gJKRywjiri58ekPjgwTuvS1bJUBdjZC3I75rST?=
 =?us-ascii?Q?uLIi5XP5PFb2ctCUKQ3oatTo09KSAbpf34jL0JZ8gxCdkApMLbmBB16fXlEC?=
 =?us-ascii?Q?x3qlO5uK9MWNtOhyWjr4b2owLRSL84ExjX6mnMI/R/0nUACvswBUL/oNNzoo?=
 =?us-ascii?Q?yYCo1ad85+5SeKWKDtH925yYiVreKP/zRkk/41R4c5OhNvjzOXlctpT9MjUU?=
 =?us-ascii?Q?p8uTY9PKyf2nXDqy+92a85Xc/TP0s2ESHO6B6aun7p7LsUJweeK8T/xC+x2d?=
 =?us-ascii?Q?7UslIEblg7eSwNAFjmMhLHbEoPNLEIoHu1kri5BtUjHigaLrq5bXTySvhlTq?=
 =?us-ascii?Q?VRipThBaRAmGzjKLeq4F4/ikgn0f6ejZuToHwjnZ1BFFkUf3ggpEP4gStBJ1?=
 =?us-ascii?Q?yksShtuopgLavB9gvZ03cNP2J7XKYy2t6hM0DF3IRLQk4jdgWS6SqGl9cWgs?=
 =?us-ascii?Q?YQiLe0uefvKhJsgqVq/jcbBSpbiERvh9lVWS5rrU2Ov90ghcTf6bgnqQMOGn?=
 =?us-ascii?Q?C+whRyXTKxTWP/MpHGWVX7JGbHdAHRRhJtfvahyccthzyzHXGqJkHyL4j/LS?=
 =?us-ascii?Q?9wTAzq2Nkocywra2FOjHGBvut4bJtGwX9I8v2pUc+S1qUBi2h21fSLCRDW5U?=
 =?us-ascii?Q?PK6KuWN+2oa/iVTwrlClgnI49U+dIjc6iuUEosGDq/crL2alOw+YoQ3zxYOr?=
 =?us-ascii?Q?/Y526x7suFZOOw4dHSKiYBVPEUIH7fzORnSi393GMEn4zSP5ChG9qUEKXBxG?=
 =?us-ascii?Q?/RJRhznQMViSezIWq5KqKJX+/Lt0J6FzKY27TKcTCw/PQi4KEuogaoqGynWn?=
 =?us-ascii?Q?tYIG7xeDv9OzeECQdRLEBKCWLUV6HPpPqNA1LjbwiujDHiVRnrMCNc73S3mv?=
 =?us-ascii?Q?FDvaCAzaMpGDY9cIhFcb5zgmb0c1FQcs1j78R09AqCmnYmiecPIlkgSkhvYR?=
 =?us-ascii?Q?JJpiE2FnaQJPXbQLHsYCjkC4m1V2gz0GViFKY49AIYJj9mGTzsgbuUlVMYKO?=
 =?us-ascii?Q?ebFvMKwT4BeI+oCMmJo0StD8pVqQcyaTyNDdqBnJrAgoqDRZ8CqNCQCg0ZGw?=
 =?us-ascii?Q?urY1Zo4UxMp00RtfypB3xZ/N87w4OIdUMls1tg3ivzXTW4a1SygfcavALq75?=
 =?us-ascii?Q?sNgCQMTi0DZlJaCcI7Kz1Mh6v5mmWIgvsjoKxTfm/lrZVgMJnSI+lXGkFQQo?=
 =?us-ascii?Q?6RwIXuyzPq6vobS441S+7Vst+in4QxJLPTZEWtk8zENAQkK6OqfNIT3lWnNA?=
 =?us-ascii?Q?+A2kvWOs8mF++Zz0tWklS17/RX0ce9/68H5S0kuweQARJnfyW2/9MTyRQuPF?=
 =?us-ascii?Q?ZrwNoo+kAxqcKGAl1ps=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3646669-fceb-4acf-a779-08de13438e89
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 21:23:21.0487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4nSE40DW2+Nfi0R1sY2XuZMrJ14KcejLfhBtBfqw6H5YjXqSRc8tKypT1V2jJtBgS8Oz3XQ5vbe7fMFQdAwUzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8465

On Fri, Oct 24, 2025 at 02:15:42PM -0500, Alex Elder wrote:
> Allow two resets to be defined to support the SpacemiT K1 SoC QSPI IP.
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
> v3: - The reset property conditional is now under allOf
>
>  .../devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml  | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
> index 5e6aff1bc2ed3..46e5db25fb107 100644
> --- a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
> @@ -11,6 +11,15 @@ maintainers:
>
>  allOf:
>    - $ref: spi-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          not:
> +            contains:
> +              const: spacemit,k1-qspi
> +    then:
> +      properties:
> +        resets: false

I am fine here now. If have next version, move it after required. More
if-else may be added in future.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
>  properties:
>    compatible:
> @@ -55,6 +64,11 @@ properties:
>        - const: qspi_en
>        - const: qspi
>
> +  resets:
> +    items:
> +      - description: SoC QSPI reset
> +      - description: SoC QSPI bus reset
> +
>  required:
>    - compatible
>    - reg
> --
> 2.48.1
>

