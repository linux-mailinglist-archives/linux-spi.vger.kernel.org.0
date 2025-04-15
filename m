Return-Path: <linux-spi+bounces-7603-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07648A8ABCB
	for <lists+linux-spi@lfdr.de>; Wed, 16 Apr 2025 01:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B614190368F
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 23:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35ADD29DB7F;
	Tue, 15 Apr 2025 23:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="np/Soxcd"
X-Original-To: linux-spi@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011067.outbound.protection.outlook.com [40.107.74.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FEF1DF985;
	Tue, 15 Apr 2025 23:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744758279; cv=fail; b=jMHlcueoZbkP7UduyrOs+6dAWhTgGPCFdgZeX9nFixjlsZV8I11bRL+RDFpZGjfq76u1L7tpvBplQ6L/YUthV5x671BOJ4Y5ZgfNbYRqAlcGa68fLnaHH3adhE5CGxzJV7A3mLlc8UTBzXorxnpoE+o2+Ejk36HfhHjBstNgOQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744758279; c=relaxed/simple;
	bh=SFSwUiAmAqbj7ybg98JBcRklIm4XPAJoH66SsbTdzP8=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=LDqn52cjnhjwBSmRduXJmKNPgyDfS6QLTpF0K0UXM8iciiOgWdBhTKSaKatELLnS/f3XkoOCle6GaQnhiGn1h5KC6glO/xRFVC2pWj/+SMXB/Shda4ODsuKlxQYKCrnifdjLkgzKzQySv+Jm+SQTOoL4PJXqIntfhJGQ1Il5O4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=np/Soxcd; arc=fail smtp.client-ip=40.107.74.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJF53Q44rx7rQSE/G0SFMp8VEPTzuzIygPPKNnWbJePzFx+lJKatTR++zrw6ctOEUL/lOzAIfMtt7tpZ9YLGz6ovWTsgaKJ6JQyI7J4PveBUZ2LRwHphj9hbls7AX4zQDFQ7tRRxszI9jFYzXfu4xm+mEiFCk6eauUYQDpez0mS5onySX4HK+MeRXt5tXZ6fLPoLiiSpqjj/zY1xtrxbLDhc3vlE8vUahXyCd/FcOhQyJpb9KxN4zIxNxUjn8OGe8SeFUVmow3d1n65U1VtnhN0rCAnR8UpFnD3b6FpPe3BtNvaevG8g9amW9GGET8HfPRyVlgbwQD4bJqWRnwOU3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tot0FYu78/5aZNyNfwdun3sPdXOXPTuveuTw8rVY84=;
 b=pkP2VtQn+kTpRGcF0XO1qvwVkjILHeH530yOct49k4RGwf59PNRxAiJ+/ycoiy31cMaNGwxvzcVQaHiPaxkbevGkYoEIFSlHmqqVEMh+FirRcPsjiCXEu5hLqPsNR6rb9EYrqSHkXDlAAUdg0xJ+7Yqy0TvEFQCPPbW9Xqu+mkZgNbh1yUVs2NyUb+5ButWE1fB89HiWYOc3WLbsvxPNS//9s/8EcMpsfhtlnl7InS1usf9TnGD7AWMC//027U4TgPgStynFr+QYtAGAiMq/XyS6fciuJmB+3W0NZNG2ZxR/PN97P6v6p66WkovfAHa2EelOmAyPJ/SunJ85GdzTXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tot0FYu78/5aZNyNfwdun3sPdXOXPTuveuTw8rVY84=;
 b=np/SoxcdM4llH6xTMA8UvXSCzdF3FPz9n1DzsenuO8qfX54vHvz5tMO2EiP6rC40wk5teQBsmRWxs9aljt1wzXi5k1Uq5LF747TzuA6a+/pzg7qVq4s2s6gPBKVmxbD2nxGtE+jzxGUWY7dhVy8UA/5mBqzbZYWLgKxSZnfe/Wg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TYCPR01MB6143.jpnprd01.prod.outlook.com
 (2603:1096:400:4b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.31; Tue, 15 Apr
 2025 23:04:24 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%5]) with mapi id 15.20.8632.036; Tue, 15 Apr 2025
 23:04:24 +0000
Message-ID: <87jz7l81s8.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jaroslav Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 07/10] ASoC: renesas: add MSIOF sound support
In-Reply-To: <aedc9fed-ba6c-4e22-9641-53ff0df8cb06@oracle.com>
References: <87zfgi1a5a.wl-kuninori.morimoto.gx@renesas.com>
	<87plhe1a3f.wl-kuninori.morimoto.gx@renesas.com>
	<aedc9fed-ba6c-4e22-9641-53ff0df8cb06@oracle.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 15 Apr 2025 23:04:24 +0000
X-ClientProxiedBy: TYCP301CA0039.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::16) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TYCPR01MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 12eca6ed-c129-4b26-c0d4-08dd7c71dd3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b+16fTxgP8MsvLMB7KuVXCUsN0ohXdG8CE0oMpCRmnCXyMWAB9XdlxEEdTeg?=
 =?us-ascii?Q?6taUh/XH8ZlxKqrBCSvUG205/H6IfFCz2V7Akf+3T1JtosW0fDzwd+K+mfV1?=
 =?us-ascii?Q?PlOImFqW73PDpWoiDNIHgpmE6XpfxJYK0YR9fD4Wol2ckptRQ9vzaBUBASwc?=
 =?us-ascii?Q?GlpxAEa1KLPvE8XSVfoxssi2lJbjUArvHKBFGIPKlPqcKwDNbphNQb/4XFFt?=
 =?us-ascii?Q?6N6A2hCPPNwJV5LTI573K99B80Pvpl0dozOx670Ta0NMg5l/leVTnMMO7h5K?=
 =?us-ascii?Q?XpVlPdkC55ydkMjK/3mIH0iGYo0eUEkmgk04CxB4S/W9zMJf+fLROnQgI6gI?=
 =?us-ascii?Q?8j95cQG3SnK0N7zKu8+xznPPQRiMI53JWDis5erc0Ch8yJcT5ILyzaCo64FH?=
 =?us-ascii?Q?fNg0EIuKyX0U9BVs8PnRxkjGSvIyHyU9YPhM6S3EHj9rhtsvSh5TN0q6WkZW?=
 =?us-ascii?Q?h7PJUJN0hGqAs/pOtfEwkwE6gMaisJj8oXfefBJ6VCOUuJrEtCITm8IRSwc1?=
 =?us-ascii?Q?yqta9mmZNknE2luwAJLQkg7UtgLkdPIYrbCYRcPcpAy8bdxSlcu+ZXS6TTsb?=
 =?us-ascii?Q?juCKEBNRo6ElectvElibVXsL6NONBvyOQf1/ui6uSFjVVv97VJNasxEifiy5?=
 =?us-ascii?Q?cpbpz7/Xh6U/EYrPYnu643JPRKe5v9fh6ZJsF3HRP6pb2FjE8WHLKBXcQTbg?=
 =?us-ascii?Q?zZz3WajqicdBxFjJROYQvkQgrG2M0SHGt8rz/iELpkJ0qZ3omGj3JUymhQCh?=
 =?us-ascii?Q?1lnor5q/NTwKq3G2G8k5QwUTfbI7feWR3Y3Lko6gIVRYJLiyl/Xvfuz78hHG?=
 =?us-ascii?Q?e1zZHacnw1NhKbryOJbrdM2FsXOR1yoUnLiImYQ+OPhfq44CWFgfBJnFR3LE?=
 =?us-ascii?Q?fBW9+FNaU0UfaCuUJo4pwL+IQW9nyEQ0vBech8uzhTNNjfCNetqGnvBSpHIg?=
 =?us-ascii?Q?/WzzHSDB24BafrbOCHMb3o7fiDusJT5oorAmZgKpkNHLZQzDJnJDSWTKaGk5?=
 =?us-ascii?Q?J9vZH3B+SFdq/W/iC4rlnULOWRPB0JGCYi8Fawfq/eS/8Mz5a1SYxc8l214a?=
 =?us-ascii?Q?UM8QZ2wPN4mG6i6YpXmtrKSePYdw4ZHOJD2pXiSGlo4b3h+wnYmB1yGYnvS1?=
 =?us-ascii?Q?xbXTWrVV1tieNunM0WBbkIyYGadXKAMuChL83UqvZ6HGfP1oG+qFC5t9zRNh?=
 =?us-ascii?Q?MtLb3Ks837UJZuTrSn6BsdA72mfvSXctqqhsqBMRmjjx1DtL2WFsDKVtdBjr?=
 =?us-ascii?Q?MxF6ILl7HSOvuxbDL4WQ/U+0PBXztU50EDldYT6ihFTCvXQANxoWD3jXQLir?=
 =?us-ascii?Q?g6PZz74IlM/9q/OMqdlCiVZvz5RHRO0It00KkD8XjitLoEO0tf0regR4yGUQ?=
 =?us-ascii?Q?i3RHU6cpwXU1jVOcvd5FlyZlK/AuCZDWWSqSj00YZljIjlFGLcvFVj1EjW06?=
 =?us-ascii?Q?aPnHy4/I8BWcEayhUSd36qbE2QRZJPZjs6JxbcPNmr2ZY9iRQ3ImeA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DfXk3b5NORl4+aGsLxc679ySs/wKnl5D3tcnFpJ/KRwqyizu4GWVqFeb0CTE?=
 =?us-ascii?Q?81GfbO/s27Ifgg/dfxKZ71PCS2O2lG/Friksxv9ylbLRKiKDSmp4ie6FVndO?=
 =?us-ascii?Q?GHTNHoe4JdgkS924zwU5Bf6YeGeLez23sY5Xfr8uD1vK3JigZ3JkDHkDuSBo?=
 =?us-ascii?Q?aFwWYiyDg3wRB8aE39BVVrv2SG++a2dOiu2XasHM7BCvurZviBXVNdB4Idfg?=
 =?us-ascii?Q?ssrLurr6bPQTtVO7dmd39ZHjXoKZvBsVh1Zcj4QbwYTdHkvL+j/s0J9ykFEA?=
 =?us-ascii?Q?UR42ZpiQ9oabizsJBdFXX9qeHHEaiqNKzMMrmWGycA0llZDc0TL1gEPR7D0t?=
 =?us-ascii?Q?RP2vQ6AkblNC/YDCmyhjo0Wv5uwdclGiIFYVonihxreMC2RWGbfv40Zfncu/?=
 =?us-ascii?Q?aaqemREptw3XrbsoqWLNKL73F7p2lKHEGpUE6Z07W7lovZFr1lNQ1p1tFX28?=
 =?us-ascii?Q?ORHpRJooimJ2VzsZr6re/xzYI9FKvkkNDmrfXt2yomuObyTnNu8vVDKBx7N9?=
 =?us-ascii?Q?34kzlKcgHZvtrUo4qWyFFKeYc445x7tH00hMI3FIlcGY1I2n+MECY0BiYeBd?=
 =?us-ascii?Q?U4dVgwvjxBhXnZsVvC66iKjAXzy8tITl44QGRe6gFuzp0p8SwsM6k1hwS4Yj?=
 =?us-ascii?Q?vFjnSZ1sERsbjttEJuLDZSdnhW25quCnROYJcf9rvZ+Yv4mwIuMYBlYJoGJ8?=
 =?us-ascii?Q?knkC85gckaXkQUH9xaYt9xxOHCy7WAW5o79hl7kD25ryrXbnzsH1WahAq/wP?=
 =?us-ascii?Q?ur75DuabmBSiBr62j8nOW6UpdkTZNJdBB9d7PmfA/T8x6572D7MS0c/ibGPC?=
 =?us-ascii?Q?XDUATgDjpM7Fjqcx7dP0/Pz59fkmxQ/T1kvu3waU5LN6kvDJv1Nxmv6/7GQi?=
 =?us-ascii?Q?K88MSYCKO4JMlL/TcGB4zu1qH8yx27ozMe+BO6FExzXgDDdljRXRnBw5SM8v?=
 =?us-ascii?Q?aH2yVX/A2yyRliciHsTZqxQ8/6rgAvLjP3ipJ0WwUKjcRme0B8wjMrdg21TV?=
 =?us-ascii?Q?XypI0AwTv9LReD5wo/s0BaIz1sMI36ai16S4l6vu+klXRMbl3F0IoDvYkCAy?=
 =?us-ascii?Q?6eqZgVGy+ahPJTk/+/Cx05unT7ZETJDDWOAC2tKn7MuNC++ouAE+K7o6MfYg?=
 =?us-ascii?Q?jjQx8+/cwFsRAUbxsttU5PxMgpEFKoP4J73/llDIDy149vYpb0y0jJJa/o8u?=
 =?us-ascii?Q?FkxFG59ccaWzB1JaggNWAQE7eyl/Ux7KCt6vZDG0dgTv+AmEwFf2he7RVitc?=
 =?us-ascii?Q?0F2J4/OcFS6Sg3yVsk8dOchTdRfV5a4urb13Df689mMSLpDGwrNVHsF/3MvO?=
 =?us-ascii?Q?/QpS+QCKsjQVsAtrNlyY9wxb5y3mFeD9FlqfRH/fBQaIBQJlwBwWjK5JhArH?=
 =?us-ascii?Q?vg7SqeZ84rmUkJIyEc7GZWUnp5ascUl7FdXSU2VV9k+uN/44ttS5Oe9WLC0r?=
 =?us-ascii?Q?VKlpvUpGOl638dzO6gDBOvLtya5H2LpFRtfejFw5wItJ3g/+jeBfBgNeR57L?=
 =?us-ascii?Q?aMQHeJIHpCdSlQNG74i4497bFuI3JnmloGTQk/rCpkay4pUMbJqCd9QAD/1C?=
 =?us-ascii?Q?w86PlxU53/ktxUisaX9nRgthI6b6qslzCRlp6Eivq9R69lTYYgjSlyyo1HFz?=
 =?us-ascii?Q?OYF8od87OokRxUHYnrsi6vU=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12eca6ed-c129-4b26-c0d4-08dd7c71dd3f
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 23:04:24.2798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e4vNj8txVGis2kDztNu7AbJ+HnLc0EIeocl8PBFkl7ofRzNIRANoOjQxm8GI/4jXgqMdSe/YYMyXUrN40Uv0S6CMqjeregLwfNJg7aiMWu3z/7rTQPy/ALZJM1V8f+Dq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6143


Hi ALOK

> > +	irq = platform_get_irq(pdev, 0);
> > +	if (irq <= 0)
> > +		return -ENODEV;
> 
> nit: -EINVAL will be more relevant here
> 
> > +
> > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENODEV;
> 
> nit: not sure why -ENOMEM not return

Thanks. Will fix in v4

Best regards
---
Kuninori Morimoto

