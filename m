Return-Path: <linux-spi+bounces-7577-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A878A8911B
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 03:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4ED178E7E
	for <lists+linux-spi@lfdr.de>; Tue, 15 Apr 2025 01:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D501D1FDA9B;
	Tue, 15 Apr 2025 01:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="DYPfajyd"
X-Original-To: linux-spi@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011006.outbound.protection.outlook.com [52.101.125.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D341022F11;
	Tue, 15 Apr 2025 01:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744680039; cv=fail; b=syDRH6/9dfBTirElj84NV7vWQwank135PM+XFdwhJfVHyUS8LoH5LB+N/M3GqXxdW90Cs+4DJmUw42ia1PznGxQ8Es7+2MP1xIso5SEPdJzuN7KAD8BC8Fp9kFA06ULn+xp92oo6c6rOe8rRGAS+FpmaLrmtGHk+ftLnWiYVrSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744680039; c=relaxed/simple;
	bh=z9rH6TcEhE461OQf75fy4b0XnOCYmB8qo7UIBtwNmgA=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=r8gjvuQQiQCPTdinHrPlhI5FX3loq51llYZjA32GKTE4+XOueE4f14mSD341QwW63mHE1HeSLsRadOSRMofS2GtdY9zAjAoSLeU96J1JoLS2uzjKOkDAXx1itXfjDH/iEPyc3Rjr5NRw+eTvpr5KuM37AdLQdPs6jatb/5PqNv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=DYPfajyd; arc=fail smtp.client-ip=52.101.125.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=prbeC/3eai3mTu7WfYUZ21i68lXVT5T7l2k1Z4Ew3k3Hgbi1y6kU5nGsk/+RyfVUrdL2mducvUkwYh++Bi0slsWLUMbtNZod1cDGXFbTYdraAx0j42dTQAu1kXqxVfwddfp/igfQyCMA4bJT7h4IQiTsKS+IAFg/SiTbguAzG3XbEq7yec6vKxxqpkYpelhTWZKHiGp0L3a6RIed4l0PX8Jog1yp7Nt2wWQPoQQd7m/l2pzyt0i6ZSnSEv9xAxsirVBdA944nqf77KFxneCwyhIv7S329EQAB8iPuo7HCF82mORy4S5Q7wWAC7yA0ii7GFLRLnxwLO7YrQbWu9oG0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Azl+/SuaBKYwb3xsHep5BMehe4uETJILxqUuCAmCyQg=;
 b=mCy9AuS6ucH/Cu58K5Aa3voPJBhpup5hr1xpL5b3A/FdUZzygF7AywYadK0OC4sK+tYBaFLjn8v2I+s0ECPtf7iWIYb7+UMtwA33sQTyrs0dOTvAJ/CtMZK4wU8c8scCo7qnDXSAyvQTVMFA9f9Q/q2dZokk+e1wapV3xxMKSd+FJOyvwy79oBeNLLOSkbLqNmQHTp6dp8SwHM4spJ6Iz2zVYiyOIp1RRJu6E4ds1i/qvXPIgOBOsgNrUjlNjlDMYaPyJgQe8bZKG9gnfgsjoni9UvohvfoyhpdPTeHe9voWCTxRepdY8y2OUpIagNFAg/e78AvO73Dwzg7xX68UZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Azl+/SuaBKYwb3xsHep5BMehe4uETJILxqUuCAmCyQg=;
 b=DYPfajydkcFLn6E5AH2cTe7LJNqNj/aZP9DspDJNpXCCh9hxuwyDMmfZcDycuiKBcEv/3bAItiYPVb/HJG07oBCfCGiA+FqLw2fhetle47xSFlyHg3YOQ0c0F42+QT3BVu5p4zJzsIUWMXEDE+pkJeP7hCyFzJJmTZQh935spOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB10906.jpnprd01.prod.outlook.com
 (2603:1096:400:3af::14) by TYRPR01MB14111.jpnprd01.prod.outlook.com
 (2603:1096:405:21c::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Tue, 15 Apr
 2025 01:20:29 +0000
Received: from TY3PR01MB10906.jpnprd01.prod.outlook.com
 ([fe80::592:9b7b:ef57:2dd8]) by TY3PR01MB10906.jpnprd01.prod.outlook.com
 ([fe80::592:9b7b:ef57:2dd8%6]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 01:20:29 +0000
Message-ID: <871ptu2pb7.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Cc: Conor Dooley
	<conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jaroslav
 Kysela <perex@perex.cz>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Liam
 Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring
	<robh@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	<devicetree@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>,
	<linux-sound@vger.kernel.org>,
	<linux-spi@vger.kernel.org>
Subject: Re: [PATCH v2 4/9] ASoC: renesas: rsnd: allow to use ADG only
In-Reply-To: <20c8df59-6e36-48a4-ba98-e1006de9e09b@quicinc.com>
References: <87h62vh5mj.wl-kuninori.morimoto.gx@renesas.com>
	<87bjt3h5lc.wl-kuninori.morimoto.gx@renesas.com>
	<20c8df59-6e36-48a4-ba98-e1006de9e09b@quicinc.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 15 Apr 2025 01:20:28 +0000
X-ClientProxiedBy: TYCP286CA0258.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::6) To TY3PR01MB10906.jpnprd01.prod.outlook.com
 (2603:1096:400:3af::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB10906:EE_|TYRPR01MB14111:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e355700-d871-418b-2029-08dd7bbbb587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IPNv2jHnAUWfLcmUbMSTiuF0CYnJUkrLO9PWWpmE7H/8azN641TNdwNiT4kf?=
 =?us-ascii?Q?rOOzdfIDN3oEsJNI4dKya4PpdYRGY3bhLiVE8R7+6vMJVJDlIfGDNvxN0IQ9?=
 =?us-ascii?Q?Rt7oYicMBCKG6cL3aeTv3FB6FxRVMhpsJDfO3RRraX7QNURkm7UPjNQJ7UtM?=
 =?us-ascii?Q?jOtkwvgkBiav/z9BQofOcU8Im+dwHVNGjCMlaEpV5+tsFcbtgetbsJ1cpap8?=
 =?us-ascii?Q?HQ0LZyCRGL118un1p3AN7JYHnwLi+qTxlg2CbGA5tDxCtKTOxT2O4ZB5WMoF?=
 =?us-ascii?Q?CLxyXujRif01r4SFiAtQzXBpCvFBUdLzAc6sb+70sY8RVRfQ3xhU2U0XCdSD?=
 =?us-ascii?Q?ndTGcV2lmiEs8QFHwloa4eqDibMTZUfGwuXx3UlZI03Rm8n8D3/KfEt2YdZi?=
 =?us-ascii?Q?DZU60G4HC/rV0GyIm2QVhaiBrdWTdag9/zUkkdaz2l+22DnIPDsfKTvPAGUj?=
 =?us-ascii?Q?wef6Jz1ZCFpca3KjoBBEgc2+exzUgYY+lf+SBgkqGOf/vIvEx37NH61zl73x?=
 =?us-ascii?Q?FfqeQhrf9a0DP6atWNqYirC9ieus+ep1X25bGq+Px922s6MQ8njouX4eAjYP?=
 =?us-ascii?Q?2p7NxGkmOmdZgdbVtrYj0wgjzfhLO/lyuQxJEPjMPu4HIlKQAOcQJn/FGbc7?=
 =?us-ascii?Q?wVRTtLtma5fp7+2xcMBh9Af45MLp+GHHGQO31zs3BZVK0UWuBXSKOXQjICaO?=
 =?us-ascii?Q?dTA3mF3OHU3TDhYuFTjKl5CeFzd/Pk0KJXOIS4VtM9xLhfyVI//TMhM5nfGz?=
 =?us-ascii?Q?EjQNFPBRKymtZoh5X5k1vjZ2g0LgUq4L9itpwIMVP0T193vd5AXUM45V8hHR?=
 =?us-ascii?Q?BPKkB7XPpk4kw4fTX6paYC9fQi1rv8+O4ypGISOJV8hcFD9qImYdqYgkuc7X?=
 =?us-ascii?Q?IbSuKr9vdWbL30pv3d0PM5hzaqyA5Oqp95Gu40wHHdKYOLQJGpd/b9AntWLC?=
 =?us-ascii?Q?7htQx3RFhHhh7y7CV0qL5hLGxyIBETf5iXu1N71E/QqRFwV2nu/fCEdQAynB?=
 =?us-ascii?Q?EifiCdtOS6kk3J5bqcWEnXEhsEGItMiH1xPWbE0resUcMB/+0YEYjf0ukJJp?=
 =?us-ascii?Q?Q9wTUWO4Adp5SLi2Owp4ow63f3+fPJhOl72r4d/ITK++b5lJqxEhlOFtPr7T?=
 =?us-ascii?Q?wRuY2tSg3sp/ExYiUOhj6lQj6iy2D6R8j1G1Z3am1MGyh0TvXpo1XuW6LPPa?=
 =?us-ascii?Q?ITyOwoXtxMIjN0mWnFuo+kKVIBHq7pfnXHJy/GZpx2iclj/vraYmd15rgcdp?=
 =?us-ascii?Q?XqqD2iSVMU39n+B2mwbz/kIDMAzggO3JRmSlRrjHUaSV91ffGLRv8/t2RRzF?=
 =?us-ascii?Q?GdtwbejIHqwRb5V6aM45k8S2vQhRTtOC4eCz54oZinsS1O/97nHXeq5sI3g4?=
 =?us-ascii?Q?f0mHdcrMaCfyInVa9mi3Qcr+kQVHf1EdwDWRahSoxnGN0/KLE9eBWqAjkiky?=
 =?us-ascii?Q?dujU+bh4O0clm9za7KuL9WMVzHjnMwQMZaJqVuRE/55aB74Ac8HfwQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB10906.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?73USmOjfHBFu9oMp/cmO6Gk5DG4i+ZIyOXUdPZjO1bM5Zf09au7o+6OSshFj?=
 =?us-ascii?Q?MRHlqjs/zY2l64CCO+yb513aYSu0vVwKP4FV8wrtdgi7AxFe/yCmtLF5eUCa?=
 =?us-ascii?Q?hChIHRicKOc+NqOTUq0bqEZTo21++9BRISd4MhVD4sZ1+ZwB0XhswTcvzk2o?=
 =?us-ascii?Q?4oKFQ3wd4ZdiHDrWEGhJVqiGk6xFwat7a/yR4yR6TcM+bBlN1jxpnzTYOjrg?=
 =?us-ascii?Q?AVOxLZG1LQJBP3NAMU4vX9XsBmd4c8VaYBEmOOAmJ1X4TlSZAd8rUJveUl65?=
 =?us-ascii?Q?UhKPaS1Gj9tmoyOs/r/7dE4WAYSWE+SHHb87mVH10vqcQEHk9/UaISRG7Ppx?=
 =?us-ascii?Q?QU3KNvEUkUrA0DEAygB5aOJb+xOoOvNFly88JY5/yBBQV6MG4HBor6xg0J5J?=
 =?us-ascii?Q?Ah96LETy37Dw1OpfWzuIDtvxIx5yiON7Ijj31n489YfgkXEHX7L9oH9B12ak?=
 =?us-ascii?Q?qLYjZsYj0iMI0sZweKf/hVXSLt1bnMtTv4xCQWcwQ+Rwk5oSkfu4F3b/+3MG?=
 =?us-ascii?Q?C064quJwdkMjw/JC0Mjyj5CMHxdxo4VWuVSASZyRNno/mOFCpKeRr2XKmS0t?=
 =?us-ascii?Q?RWPey10/0ytZAHa900zIIxmMzj/Ww44oadDU4G1RXhEgMF+QGECihojBhjwX?=
 =?us-ascii?Q?DbHhjcDxRTZwMi8Wk/F9afUG0Et4PRpj+KQqhliro0Kojul/6c7Y1WT6smnx?=
 =?us-ascii?Q?GlAp2CpBduv8EUwhjAX/QpSVn5ZuAzJ2ba/U+g+MqtkXWX33S4UVlVM+zsGZ?=
 =?us-ascii?Q?5h+5t3sp7vzkeufIT2x4hKAg/4JGDXFDXWNDBQ+1OEXIaB3AvGTbf8fb80nH?=
 =?us-ascii?Q?Ds4woIn/terGT9ENB5G2X2u9QKnqq4a8a3t+fEKJdLOuw6TNT9q+neBQCibH?=
 =?us-ascii?Q?OXrtx36eZJFuvueSChBveimI9QOxDoAMVDyjnvqeSRrg2AqthwGfSfdPhZw+?=
 =?us-ascii?Q?TmM+21WQHPwDIQJowr02WnGc4u8xta6pP0sdQnqxPPnJzjhal7zkheqv+gIn?=
 =?us-ascii?Q?VK/EsIA1gpJYQHnm2VPtGGkoLafsehdv31Ambg795O62sOZQgh3eZXKrJMZ2?=
 =?us-ascii?Q?vga/qD4ZnD7X0pCZm7H8dxcNduOXwdd/QaJ3SuGOkUnSSF4lkUHPm+AtYfJU?=
 =?us-ascii?Q?xdFL3r3cYUWQQlvEIDJkVfVQzpf0u3fYkyW3B2pslBfGy1VqaMrJE1mrllQT?=
 =?us-ascii?Q?CwPTFNrUwEQNEbsK5hojnVjvZZYp3FtG2u3VNvjarTqVuDEmtaL/v3PqNYVm?=
 =?us-ascii?Q?fkzleSOEwSVi4jqw4SRzAYgriGECHUA1DvUaSqM8vUGloGPY2wGq94OMam+/?=
 =?us-ascii?Q?vK3aOWc2YekMXLNkWEqsoTRv3rH6D+ltpY64rTpY2MEFSiJjCbV9oMpgUrLY?=
 =?us-ascii?Q?Es86Frot0hVaMFKnYDx0V7G36wxvSnOdqrGV6t36b0y2LVp3f2+iaaj3VnGz?=
 =?us-ascii?Q?CDoGCxY1EOsh8/lispKKTZ2Xo1amhdVCdCI3NYzdAwA73Jpb4WXkYg+Hq3zh?=
 =?us-ascii?Q?SbIYeegMmtfkKZmipA1+6AbnzNoXV1VeeerhYVXg7zO0L48UFVPzOzZspokP?=
 =?us-ascii?Q?XsALOHvXzAvPYX32xvCuzUdOwf9nSL02x+DUJ8gR/2JqLhFwaAV0DA+0RnSK?=
 =?us-ascii?Q?m7cdXNb0PLMJ5xsikR2kBYQ=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e355700-d871-418b-2029-08dd7bbbb587
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB10906.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 01:20:29.4200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xkz1I2h4W28xnh/oBw2vTxYOAOgH3P9byCCXXZjDrTQNKhpN7LRt3g/yOUfI4HJJ+x1Gojpuxs8oOa+sTqbqJ54+LOneDpmvThVGvzMGO2p8QVQkfA7ZzHMgNEgY1YPR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB14111


Hi Mukesh

Thank you for reviewing

> > Audio clock generator (= ADG) can be used standalone, but current driver
> > will be error in such use case. Makes it as not error.
> will be error ?
> Makes it as not error ?
> 
> I could not get exact problem here. seems you need to write properly.
> > And, current driver registers it as fixed rate clock, but actual clkout
> > was handled when SSI start works. Setup clkout setting when it was probed.
> > Otherwise it can't be used ADG only.
> > 
> Same here, its not clearly explaining.
> > Because of this fixup, current rsnd_adg_get_clkout() function name will be
> > strange. Rename get -> init.
> > 
> same here too. Please write in some verbose which says something.

Hmm.. indeed. I couldn't understand what I wanted to tell...
And I noticed that the code/patch itself is not wrong but strange.
I will update around here in v3

Thank you for your help !!

Best regards
---
Kuninori Morimoto

