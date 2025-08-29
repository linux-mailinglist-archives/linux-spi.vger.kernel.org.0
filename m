Return-Path: <linux-spi+bounces-9779-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADAACB3BD96
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 16:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26571CC1499
	for <lists+linux-spi@lfdr.de>; Fri, 29 Aug 2025 14:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ADA3203AE;
	Fri, 29 Aug 2025 14:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KYlmnr3S"
X-Original-To: linux-spi@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010038.outbound.protection.outlook.com [52.101.84.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55E829E110;
	Fri, 29 Aug 2025 14:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477645; cv=fail; b=HQHopk+ixRGLps2aavgOZqOxS7Egwl+iRD6UIrrvCQ6MfMu06GAi0gUaF9OKl69X/Wa4JJbxnpUMN19Qhcpyjjkqg0iKbW5mBSUZN7+yOYyxfy4zbizgxZknigQ/MneOA4IVN0MQ/KHhCXPMQd+0wTlscBUNy3VdOInLb+R8IOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477645; c=relaxed/simple;
	bh=7PzrHolFb8P3zBI5e9SU/f+tyxaXvUcWhendIsYIIRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZtL6/v6f6qCqxb5orRkHvW/CTevx60MJKy0TgNpT8gPTXpUAimo8FkL7nsYYYXUqQUSuxfRNJYfGzW26Dh1NKzr/LKt1gG8JRTHFi0E8WpvpAxz+aidJLB1g/it4SkHVuEzd7Dhl8+g302olYAnIxJaJnQzTRdmkXLNFxGhMeSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KYlmnr3S; arc=fail smtp.client-ip=52.101.84.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgu1Ksfxux4RTLFrqrptdfR7+8BO8bGdTx24xlb8oJrfY7xoTTxgweN4/WqhI2hH9gOtdqB/BS3wvKoQ9lnIKbotpHGmeVP+T+iSyB2QvPMGILl9Xx+L/a36rUq8DQfsqJxP5dkqkgrXReJr0+zfOKB01LbMpGStgMCPxLOTCwPyrnR8XkBKf29TLMB8hlF+CrsRkQKxLxD4qndb/Z9rvZeP4UEJ42Hnn46p1wmiwH84X+H2uBVfbv+ICprb4tWyQMyelt0FHhbzASOmr3YMuDSkrRcOIGTHQtz+2ed7lZz2WbISS+b0/Tpk+7GyN4C3yoyjbEx3/OYQPWR5sMOMjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PzrHolFb8P3zBI5e9SU/f+tyxaXvUcWhendIsYIIRA=;
 b=yDZDsJXpu+dQKGaw6bKhmaekJ9GF9/LU86xxug7BkRhp1+0XznguGUJpxrxuvMSlLUrnOtVYi+R8QGbbOGvjxrcFKINP2IpuArfDaIqj9e2ynetjj3fFG4tRAG0Yq76r9xJZeQ/Qeejenof7V7debM9zMeouKYUInr2Bbyg1q/W634bk+jjonynei0ZpH67jbcUnk4izOE6SDfOdy8xWSV0UtlZ5UltcR12GIePr9Oj9QMiZr5K3MCB3kJdLBnTUePyvYHEEUV2MZ+tdZKKf1LE5kNHMRVe7crB7eUQb14oaYpO8VBFKSWoxYSc+5glUQ/cmr1kpFbQ69Ycs7j9ZAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PzrHolFb8P3zBI5e9SU/f+tyxaXvUcWhendIsYIIRA=;
 b=KYlmnr3SYKyvnqhvUYKGxutKU3AY5btdQN0RNEHtZZyTa/BUIhJv4QaQ6UHRp5fQNkyZmkwAKFHm4EYFAqmtAyKBVIiSyUeyFT0f7q5AH8BGAsMGoxHFTV+u14zobUSh02bmHeNun0ZeFF5HKO650baKipm9Ia+q2KzF5shFgwfQl8RH0ZRBvTBUB7iL7NPiU1JNLNaPJCfzpV4o31iUGaDEY1Ve80TM/oVOicT1GEHw7d4BOKnRaCwNQXPTNzpnjg6EZwZ5UP0OWi0VBJ52QMruEzok7Z7xyC3nWdR0xfa1etKoGP0ArmGUQSQBAXx1xxjKBe4EqMIuMkmNqbxAiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by AS8PR04MB9093.eurprd04.prod.outlook.com (2603:10a6:20b:444::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.11; Fri, 29 Aug
 2025 14:27:20 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%5]) with mapi id 15.20.9052.014; Fri, 29 Aug 2025
 14:27:20 +0000
Date: Fri, 29 Aug 2025 10:27:09 -0400
From: Frank Li <Frank.li@nxp.com>
To: Mark Brown <broonie@kernel.org>
Cc: James Clark <james.clark@linaro.org>,
	Clark Wang <xiaoning.wang@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Larisa Grigore <larisa.grigore@oss.nxp.com>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/9] spi: spi-fsl-lpspi: Fix transmissions when using
 CONT
Message-ID: <aLG4vXsolXkpUUEs@lizhi-Precision-Tower-5810>
References: <20250828-james-nxp-lpspi-v2-0-6262b9aa9be4@linaro.org>
 <20250828-james-nxp-lpspi-v2-1-6262b9aa9be4@linaro.org>
 <aLGRJxK5Lr44P5hG@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLGRJxK5Lr44P5hG@finisterre.sirena.org.uk>
X-ClientProxiedBy: PH5P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::17) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|AS8PR04MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: d92fa87b-4020-4c40-b572-08dde70828ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|19092799006|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sHlmR7ZVRIml+SZ7Q5b2SeSXhvjq6Dygmj8YnZ5i2VIqlzyk7Cw9SZT8TYbv?=
 =?us-ascii?Q?Hrhp7cnM+aIqZhTeGKYB3ohcKWsbZKrCpGAOYXtPA0fZGHYoHv61eiqU/aDx?=
 =?us-ascii?Q?TzFsN/EIy/Z52qCTt8Yi5CbhPY8Joogkk5sohkpC39VyNfWoLK1m84Zl5ngA?=
 =?us-ascii?Q?3sx3RqaZIbarHL/Y5q+r1hQwTarlz3xWgYbZAD3vkEgYmwllSA2dppixsEKq?=
 =?us-ascii?Q?Ji7hZhV/YmORw+GgJfOjhFDAp4m8hMxz0Y+3lix0sC1srfWndmBdUUKm3rng?=
 =?us-ascii?Q?Hhu2lHP23ew+hsr7bJ2I3XFCGMqPm6/+aZXihIj/QTm+Wf/cePFMD+qUXj8q?=
 =?us-ascii?Q?SIA0W5LDsRSg9CgNqg2ULzkAXjMYXU3gUBc5HBbC//mgzVdZCOWvZJjLNL7G?=
 =?us-ascii?Q?tMC4xRDw98MCxBoK+erJisIBDu8DHayZGq7CkeNgYxupgJ7Ul7P4yqcii41E?=
 =?us-ascii?Q?A4C1k7BDDjvvbfIH41z2Kw4PRoOh5iLRT28e/BzofbkCAh31vlEbrWTX+rBI?=
 =?us-ascii?Q?hI+y/+NBiem0sSvZrgMnG80KQCH8nkLvjyldWkKHnqONiHZ5DsQd0pxH8ra+?=
 =?us-ascii?Q?G9JDLm3yZKMNoRcrM9Z/6y9kVz1noxcxGJa0xMn6/EQRf3NUx9nInaqz0MYN?=
 =?us-ascii?Q?0C4O53bwuTecD5ESS2prJxV5zslEyU+fK+lCAWdV3/GARqVivBH3iMrifxWP?=
 =?us-ascii?Q?GYJ1b7fIRE6iZM4i56ZB4KWxkxC7xeuy59BhswUzSAYC+qPDaACHkHCHaVQr?=
 =?us-ascii?Q?bdWF8REURh/oql6Bz/rAoUZsnEHu5CE5NSQgZScAIocWS9G9XNC8hkNdy6jp?=
 =?us-ascii?Q?oYjh9XU/KTMMcfhI8YO5OVFHjaevJ6fLzhhcCzUuFdhRwQSkjA8FKE+2/08W?=
 =?us-ascii?Q?cuWkmGuCnEKFDIq82ONPtKD5XgAmEIvOCNTaVWcn/icIyHjy4CEUJ3NKLmua?=
 =?us-ascii?Q?63zXbwJf6vpEHnsCpkhd1sHsuddl+SZ04QpBzvfvFNSjxjN+RvLEc/Bnqv3g?=
 =?us-ascii?Q?JMZXj12Ng5fhgT5x4viDirU2DVxSV0vAi+P7vyMQ1+S0WovuKd5nE5VviXuj?=
 =?us-ascii?Q?rtbtUr/WW8/2LvukyohDkyp7oOuYO0X12sCbdMp1vJ3t5PrDvbfAhw/+5ODl?=
 =?us-ascii?Q?q6De/Hj0PzrmcqyuHwNl/zYiwBn1QiUTe00dtCiTJLnJJ5zuo9RJD0h+EW9O?=
 =?us-ascii?Q?+hjxhnc3UDhWKr+f5bbEUYjqXg2DD0YWogTs7swvbx9jAoe1HsAb5IrHcj/M?=
 =?us-ascii?Q?/RsR750B7P1EQJncCXxQ9N/zGfIg42ztWEIa/DK5zzGUFAhMOw5r2dBKdIcH?=
 =?us-ascii?Q?KtlpOogsYgEEIikgOwzUMhgVg/nTJYPfRCrpUer1KKvxF6EFfKX8Xl2zClwW?=
 =?us-ascii?Q?EkGZ0E4XKPDmTy5dGIFl+/3wXBPDEzbWTVXgfbuI22WTJK5ti+13ktQ46X8h?=
 =?us-ascii?Q?5hmEapTN3CqthcPb4hMwKvmPD9FBc+dCejfMBKubi1X9o59uL5h+zw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(19092799006)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ClgfytwJ7FORjaHlxo6xW4xh94k34WNadY4UUdNkuUIj82eazWQ71uUcJKXx?=
 =?us-ascii?Q?EMutdIUAejsgNCyL9xY5kBrAdSagNRLuqdRmDTsjnK/8+1uK8cEnrLc48OON?=
 =?us-ascii?Q?b9zqDCQu4TSIvFnTytt1eknZCXfETpGYiy4xHY6j/nycvbOOmtuImkqCm5sa?=
 =?us-ascii?Q?ASUTXoYBYaFrzBfwNQaY3ikVNQ5H64Ku5Vbh9ZS5bo0707h94bNh5pktEv3v?=
 =?us-ascii?Q?dWJcnRv61Vf3N2oll3CeHJcMTYG04ezIYGapXJKA0qSfCFHC+ovjqPF6xDNi?=
 =?us-ascii?Q?auoW+Nglz9vpMGAXVVZ+TZ7dktw0LdPuGJtiOs3Veh+BLGR9aprECaRnH1PB?=
 =?us-ascii?Q?/RPYgearEu0kgZ6sy2DlxRBNkFu0ZyNpjx4uGb5E6zAJ1XV1OK4CpnOUMQID?=
 =?us-ascii?Q?Hg2xiess6e0PMD7kE1BUJie1RRbWOSEUM58B/eQwSht8h9iaO7wAkRUvtUll?=
 =?us-ascii?Q?PTgniqw0ybAEpI1gUiIbAFthYcJWGB73QT7eXnjIw/TJt/LVwXfzCcsuXvOE?=
 =?us-ascii?Q?BJPeJNtwf45ySQAY2pqUEb+P931AMZlB6Kuel9K8L+nRHQwTH7LrTvmq54rz?=
 =?us-ascii?Q?5qorZWS8t7mC4MWyM48ORY8t9yGCP0YHVJTj3FF+n16JpidrqGV6MRS3FrvH?=
 =?us-ascii?Q?2vW/totZMWu+niaEyTQj/mPtxFY6IP2t1cSwSujpqYvnwV01iiKiZywUKj6Q?=
 =?us-ascii?Q?2EbVb1IyKVnd6nRJEIEVZVxcJy53w+clBe5yPqGy0gboJ0WC1wVqSDGVcUEy?=
 =?us-ascii?Q?aT7x1z9ARxov5wpRDaD9zS1E1OI/IcH77nBNNLkXG1i7vt/cmgQvZwSD3Exi?=
 =?us-ascii?Q?tzKuqo7F6j5MR0Pz/BkXocmh+hR7HQ/Ytcylt794aGm686O2YuzgT95PdalN?=
 =?us-ascii?Q?Swh+dozjjSz731ASEEIyf2764bwQWgzCyD3Q8updIUtNmmjzI2WgL/Ak5Ad8?=
 =?us-ascii?Q?RKYYIbZHWGgHx5iMpy9MKtMhab01oF9vobicSonOKCG6Uks7oZKdGfWsLZ+x?=
 =?us-ascii?Q?8Kc5XDS/msNCtexToUXDmImJebh0jOQdnbXolFK6EzttVDGnnD/9HLwPDV29?=
 =?us-ascii?Q?uXOkMdYM+1SdWMUuA6YiJ0yA0noNpboawNq1jg/cXiOWlekIA1GSn9kLiTpj?=
 =?us-ascii?Q?HKCNjx23Y4GyerChMT9Bcb/DSWxkSdKI3CgahpKOchFipjJNiaaeebDal6JQ?=
 =?us-ascii?Q?awJqRqfJSIr0VfUkEUHfwJHqp8O36hblzsUfhPbtuSKq/JJUxPVRHGGF7kgw?=
 =?us-ascii?Q?OexEY4JLj6OY9k5wINTzygxCesB+92icSl3A6srj/xwNmXUvMzV+vlvekA6m?=
 =?us-ascii?Q?CQ9Jvn1aNtmqnC+rB9Dsk9eb5DawiVI3PO5B9bf/5OBuGxi0c0T4FNAAEKox?=
 =?us-ascii?Q?MZVZtvOqLFb+Lkq4zbeNZTiUVmo9sJ/EscJgMRoeVSzanFNZhER4WE1WvScQ?=
 =?us-ascii?Q?6zcwUIPSlUjGrba0i2Q5vKoyKDGGc4Xth3ylMdM5mpGYVNrf1YGLZKmHsXUA?=
 =?us-ascii?Q?OWHuKmnTOdSIDTOEy2In9pfNe92iyXIyZvFNTqIHZ4fjeN4q/lJswChoS4Ig?=
 =?us-ascii?Q?YcA731FnCnbc1kECoeTQ53gZyHtFrv5j0H65lYh9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d92fa87b-4020-4c40-b572-08dde70828ff
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 14:27:19.9019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n2g4aL6KevM35/dwPPH8/mgw05n/f1cLl+3hGv5Jf/YT3XvmWEEEdBJ1pu9b49De1DUpN+svRiY42BofkB4ZsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9093

On Fri, Aug 29, 2025 at 01:38:15PM +0200, Mark Brown wrote:
> On Thu, Aug 28, 2025 at 11:14:40AM +0100, James Clark wrote:
> > From: Larisa Grigore <larisa.grigore@nxp.com>
> >
> > Commit 6a130448498c ("spi: lpspi: Fix wrong transmission when don't use
> > CONT") breaks transmissions when CONT is used. The TDIE interrupt should
> > not be disabled in all cases. If CONT is used and the TX transfer is not
> > yet completed yet, but the interrupt handler is called because there are
> > characters to be received, TDIE is replaced with FCIE. When the transfer
> > is finally completed, SR_TDF is set but the interrupt handler isn't
> > called again.
>
> Frank, you've reviewed the whole series except for this patch - is there
> some issue with it?

I need read spec and code to understand code logic. It should be correct.

Reviewed-by: Frank Li <Frank.Li@nxp.com>



