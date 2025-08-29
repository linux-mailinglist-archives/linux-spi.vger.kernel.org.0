Return-Path: <linux-spi+bounces-9777-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074E3B3BBC3
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 14:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B685EA23158
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 12:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C87318144;
	Fri, 29 Aug 2025 12:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dUE0sO8o"
X-Original-To: linux-spi@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010030.outbound.protection.outlook.com [52.101.69.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C169EEDE;
	Fri, 29 Aug 2025 12:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756472088; cv=fail; b=WwHOaCRCwAEvSS6mMrOlxu/bienLAWZA5VRtvllQS3OD14vEWKbggWcmQDAhGWlQl/LSn2fu78KFsvX26l/H/0gLga3zSGTVZQ8fCz349hgXZbdPsyeBnnENkaU0VM7HR0VtGHUPxX2qea4Gj29CUW2a/0ardFf7PArd6TR3jxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756472088; c=relaxed/simple;
	bh=pWp47ox+J6pOMReRsJkQHAQ2+vNCyiPvjCKoWsy5rM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UyVX8yyIpoPFnLeoC7FjhlZTIPK+SNNr/aFhfDGh/KEIsOjfNAoLsAbZtCgq0+LJZEAW1Ctv7MXObZfqDnYG5Ytay7zSGFJHwS813puJqtxRt6Tr9J/TuCO+ykK22mevLa2SXsdwnRAN3oAX0YTkYak/q5hFRNSIF8mbYP52I1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dUE0sO8o; arc=fail smtp.client-ip=52.101.69.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GKFHaZhjZ5ye9T1i56xVBCrkvzFA8pY+Vr9boODNQBIOsOo+PZtYRKcZzosyT7aWr0ap75pXBHfBYsWMDkUrFqq9hQndxQAIHwgrXp8Qzsi4sDcby0mDUJqHP69jmZtAPFmUyjOOuI1WT9JPnRLW/CgTCqowMIHWRFZKt4nFOTlkqJybcvUniHSuvTAjEiqoF6dfzqtP4y44ciIrfLP1dqSZR5+8pjNFdAciiQ/sDG1ZpQjUFESbWOEi97QDH1Ba1kNlFh0Aitq7EA7OOzRhDKkyb/7qKDQYWVls1CuzygcWX2IUEOzEEDE5ajuLWMxZg2Inhwa+Eapf+1QIDiRpMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWp47ox+J6pOMReRsJkQHAQ2+vNCyiPvjCKoWsy5rM4=;
 b=i9bTTHdBP3XjE+WzxQkSapANWrAwnGR5qeHUGbJNgBRihU5KXoaNN7MRkczqoaK+ac2Fw9dHA6zhZfSbS0x5qA0Na7v80BAKlvIZoOzrywpoXqwIdPsiMqVPkTm4F0iTe8jpAkONHUFF0EZbCfGU5tn8yTnP3FJ1vZAl4+qVX1VWu8+MFW8pEd8nLKliKuJ38WJypNAhGJoj3NW/cvsDbMK032TqFUkOkv95ob8Ia3fxCQAsJYDSfCN5PnbTzqSNA3mU2un/h7r3/NE1CDmAMezsLAPzsQDYILo/ksjsYTB0AAL0WM5ID8Z9iXHHelcL+HB89yHIVL/lTWIJWOseCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWp47ox+J6pOMReRsJkQHAQ2+vNCyiPvjCKoWsy5rM4=;
 b=dUE0sO8ompO+Qx61IBBR62TPS81eP76OYxGQ5nJNtCVEOgdh4SjC59rXJ94XUSHAj4edEFQ7PSqtGPOps9MHoHTIa7VLv7jyp6FjcmzLTJ4kchHUnR17uZYun646OEcrfhvDk46eLMDa5HWya0t2OlLnO9b286HKYLA1de//t5MlC3AutlBN/1lDF5rgoZ2JzVJy/EfWzOlOeTt0ljLj+mcdmcF/OrAPCuKP2O979MlNp0heWpM8QsZ300gNUzjRi0VWf97W89R1EbtfJEeCes0MwVYjOvh261HBi2ZgbFh5kZHTjddEIKeDtr6VVRWbCFReYOK5kOGomV5HZw6Yiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PAXPR04MB8491.eurprd04.prod.outlook.com (2603:10a6:102:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.12; Fri, 29 Aug
 2025 12:54:43 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 12:54:43 +0000
Date: Fri, 29 Aug 2025 15:54:40 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Frank Li <Frank.li@nxp.com>, Christoph Hellwig <hch@lst.de>,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/7] spi: fsl-dspi: Avoid using -EINPROGRESS error code
Message-ID: <20250829125440.fuxwiekll53myiui@skbuf>
References: <20250829-james-nxp-spi-dma-v5-0-3246957a6ea9@linaro.org>
 <20250829-james-nxp-spi-dma-v5-1-3246957a6ea9@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829-james-nxp-spi-dma-v5-1-3246957a6ea9@linaro.org>
X-ClientProxiedBy: VI1PR07CA0150.eurprd07.prod.outlook.com
 (2603:10a6:802:16::37) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PAXPR04MB8491:EE_
X-MS-Office365-Filtering-Correlation-Id: f09e0e92-7ba6-4631-3458-08dde6fb3963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|19092799006|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p2Iyj2wjsh2Y19D7TnUwnDGtkPdSN2QZvHCUMvT0BCjYwxgfeeur/2Jf8bFx?=
 =?us-ascii?Q?q2aMHdloKcReDb5UEA4yt7PTNfCrF0bjkEwxeFnJcsfdVR1wP4SXNKJ5YCp8?=
 =?us-ascii?Q?hI4XBp7/qjvDmCEIwr47y0TqD/IP6lsMqNxWTEYlc+8Dq5ZLZI4HKjgxdyT8?=
 =?us-ascii?Q?y4XOvSVTEzEhN0UmlZq560Tx7UgkZ0osWvO6WY4pIFWIcLjp7glteNkkyQVS?=
 =?us-ascii?Q?j0jsymmxMIaXdYrbuH35EO6hi94GstcvNwWS/DFt3wHeiVzs9HCIV00b+/X0?=
 =?us-ascii?Q?bi5lsOru8SiN0bVM9yTU22Zn4Yu01h9mS5KOFj94Vk9o9t2pLKpHzd0opTX2?=
 =?us-ascii?Q?bfkVkYkXMjWKEOTAZo/D2cCyBgXQ1q4Z5JxwFbqYzO9i/oC/qJcCkF4MJxvB?=
 =?us-ascii?Q?Au1uORiyAquTXMCimTtcRZBMmfYfT6AS+HcQk6//SU30uXeHI/spLG2fFvAW?=
 =?us-ascii?Q?j97U25JouvOcDtPyVgivzfjrokU84QkWcJqSeNVX7b/acl5nbMybmvyNK2Bu?=
 =?us-ascii?Q?R7wYlV2+GWOiPopnuZDNClwsMGZkIqIKwwCFeOUvPM4woltapV+HM35vFZHj?=
 =?us-ascii?Q?gKUzihtRPQSzzd7XbcEsYDqqHyo3PSowjY1BFBQ57Trzc8Dd7kOTdHp92SYm?=
 =?us-ascii?Q?pVKJqlpp97HNxAEIspP0yJZ4bA6o0a6jFRSCK2hOQiQBfZs61u922uHvUGuP?=
 =?us-ascii?Q?dweEEPMzkn2QlBN6PHtxTrFI5PsuSj1g1I1diuErtHuVx1kXOYCcPcLiePUD?=
 =?us-ascii?Q?aKlZasJ7qrq+zSaYfLj6yjdinehao4dWl28Btj7YJNVyClSH9n8snBQMZSTR?=
 =?us-ascii?Q?Q/rqCGR/VCzM8J8p8KVFjRDJNmt03tcIhT8YCxfkYWOpTaps4jATv4n5oBDM?=
 =?us-ascii?Q?EMxVDQ4sFSTntGTimEPopMkymkQ39XdmVB+uJbd4sFz2xWfMZD2RXRymuF/T?=
 =?us-ascii?Q?5kVgV8nN0DO4gcMgtINd4Z8WXnr+lVk5EnkVeGaol0+1idcjP9EHDJpbFUw0?=
 =?us-ascii?Q?JE9zhgT6jhgrFPCqdwJFFUzaV/cw/0IhImcwf/lvFSzpeE2KuQd3mr5cgjWF?=
 =?us-ascii?Q?kq0xjb8D36EFfDzITmftjTDETz5GLNvVtoH2uso1AfQfEVaeGdWOyVuAEMsW?=
 =?us-ascii?Q?9fZ83p4zterOVDQrSCg9DP3LmzgLPA2RqhaG8Q52lqrfzezjOmJasFBYA210?=
 =?us-ascii?Q?KO0ZmTLQ1wRGh3Q5p/6pUi4T4wYu9YwNa9fftgOEB6V0uau8kAFLI923LyFp?=
 =?us-ascii?Q?Y7Xdu8yfl3GOWxaZXE6eTvHOjj2Ayjo3uBdPOfP6kMfaLZg+HgQo3p2ohev4?=
 =?us-ascii?Q?iPypHt8LfthxNjpJLLZBEAxwThuaa2atumGdVMxRBX+FVauTGmiqjniiTZbf?=
 =?us-ascii?Q?Uzdxf7P7vky0ddAyFb46idGgf+TgckGA5bfF9dBRXsgDzSwOn2y6EdpAAeV5?=
 =?us-ascii?Q?XL158oc9GLw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(19092799006)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hArn9kta/jeB+yEdKXqX8eRl3WSBWDaWVHgkaWZqbDJkfClk1aAdkRDtY/hd?=
 =?us-ascii?Q?DscMk6Mzgli9/fev32+46QUMaiij2ryjo84jRxmDaVnrmqwnhcZAwJBqOLAy?=
 =?us-ascii?Q?xoOhYku1lWAkSjKjXhUBw7RBWXN+gNK/Xna8Q+O8YOwfHoz4M0LFRjfxTfqI?=
 =?us-ascii?Q?UTebuGzCPBoB+nwyVAst3j2VCqHHg7nlJNhzY1sjamBtMYrpFofW98v4TQ3p?=
 =?us-ascii?Q?qxUvro8rF9OTlNrxCDVEMEL1P42PiNZt9CCzJkLoWGCuN63VqZil2BNqfDQA?=
 =?us-ascii?Q?S7AFQi99jNf6T6BPtALQUZioI6U4gSTQL2h7kvTULO+CfB98anS5LZd3zqFc?=
 =?us-ascii?Q?RQXE5Sfnn+7fsCmH7wcv9KLlHLpNMJ0sK90qMHJQ4aJQBck/wz6qeyPPdSVy?=
 =?us-ascii?Q?/scMHNAuhZ2xRbDs0SS2P8l/D1GxuvzKnR0J2c3kvudU+PAMG38qSgpvftyL?=
 =?us-ascii?Q?fozbPz29pIrxyH8lAvkKvFHADvb4kX3xe2KBag0zSU/yBJCF4+jueNxvMx85?=
 =?us-ascii?Q?yvyUWYTtoZFbq39Rb0Cv6Gw0mXjgU5miv7JxoV2jJ3su1vRJWbE7c8++1opd?=
 =?us-ascii?Q?PqgQPBN0xCKyKk64R2mCJcd5p+qHzqot6YNhwrEzQjzDYtIxIhH3tjO6srmI?=
 =?us-ascii?Q?qh+8H+ODx6CXfsk+R3IMEvw1apl7OhNeqtzsNKM8hl8pT5HXkgFBE2WsesAE?=
 =?us-ascii?Q?10FH71hLH3DUd5Vt/a69LIK8jmILFIO8zjP121xNNYRTILF7UinjXt/CVzlW?=
 =?us-ascii?Q?AZHVHdgLWOqglQpgXPPYX/xH+s41goNn//F0AAhfI0yl2hMR2Wd4ngfBGTmG?=
 =?us-ascii?Q?FhbCZNmQ3tsfWO39aG29KuXK8rbQ0fm43pmfryvmGra1tJEVrG9cqMSUbCxq?=
 =?us-ascii?Q?l58XQvX3J/0CR554H9ZyMX84F7E4g3vZD4o/rO4zcaaLkTje3Wbi3Z0ZaBKX?=
 =?us-ascii?Q?2HjWfz6pqsbyy53ZZiJa0q8DvwGRmciKCvDfKPAEAv0xWnOWI3ssPuapeV40?=
 =?us-ascii?Q?Q0SKKZzRVbATRvc4xuHOF6xkPsFhrskWyU0ytN7F2hg3NF+u35a5NWLuSxA9?=
 =?us-ascii?Q?erNTh6qmTwlNSJfya5VVOea0Jca1ZjdZ6BFtX0/ImBJiepkX/I+OoAoJnwLN?=
 =?us-ascii?Q?9o2meAOjsq/WnovKYVqlONrkghX16Kn0XWcqtuoHhVYAIoGCBspfApe/EnJt?=
 =?us-ascii?Q?EeVmxu/vPEDsF6B52NfGyTVHmDyPcpTIV6fhzfB/qd2rGQ/NoTV7/L3dXMIF?=
 =?us-ascii?Q?XjjqoC0B6jPpPv8bA99HMPc7maj3JPOwD9Wr6V2y8aeXawifVsIoYwLqCeUp?=
 =?us-ascii?Q?sGsE3fZCIY60TwBZ3ijF3dKwHJ4v1K8l2t57Bp7tHP8Kp46910p5AvKlUD1t?=
 =?us-ascii?Q?+FH9SEHvncGa+C9YqR4eHjHbSDDap0fh4ieKrk/G00lgrGFdmeQULNRuukHP?=
 =?us-ascii?Q?XZyhHdkd5Rgjq+CnJhuTxK9ZQy0Le5gnziIF34ff/gXVkQiKe9zccvH1ZQWS?=
 =?us-ascii?Q?hZE1LZFFtoIF/vt9YjzcvjGAgioVar5bB14OR9ObDMXkVdGaZBAKOHGTwEo7?=
 =?us-ascii?Q?hJnZ2hIaOMNT7OLIdg8949hg7GSbEn4qD/BqJkzVT3pk7Ml4mZ0j4GEr5IdW?=
 =?us-ascii?Q?7lsiQQw+pyLkfn7rh/IVc4JdDHsVpY82mBId+YllLbLwg+ykT55hS6WIeBJM?=
 =?us-ascii?Q?0dqrGQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f09e0e92-7ba6-4631-3458-08dde6fb3963
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 12:54:43.2441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JyrmekfVQV/4ce5mU4A6A3Xa4QabDttvQJ4R0Oyx58fva4eXS2aATi5UPNCKHSflpIFZMwbVt+sW325L6oxQsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8491

On Fri, Aug 29, 2025 at 12:46:43PM +0100, James Clark wrote:
> Signed-off-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

The way I'm understanding these tags is: you wrote the patch, I submitted it
(which is not what is happening).

I think the conventional way of describing it is:

Co-developed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>

