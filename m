Return-Path: <linux-spi+bounces-8770-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79C0AE8738
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 16:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB07168FC0
	for <lists+linux-spi@lfdr.de>; Wed, 25 Jun 2025 14:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B753317BEBF;
	Wed, 25 Jun 2025 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cPyFZYQR"
X-Original-To: linux-spi@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013039.outbound.protection.outlook.com [40.107.159.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223AE1D5CFB;
	Wed, 25 Jun 2025 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750863368; cv=fail; b=Iabu43BwyX5Bc5jx9YDi03nLQlJhJN7DGvtoM7RN2T111qTogscIOamthf2fgnaNcqP+Wh60h2OTU6Y2bPiWS1jNc3HpGZWMkPJGzFvPccR+hMt5/lsp2OAICjpDD1hWF2yf7gEh8hh0rnZK4regj/hQwXz+GcdZqdZoH+00Hv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750863368; c=relaxed/simple;
	bh=aP6IOJXQFZOW5NXufcQCdzZ2MkcV0eiXmyEuU5B1RHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z8DYmDXk51dyHNqdZj9xzyO+cIK8TGIhy+a9Cgs4NC/stQ/Vz6FWyyv05dW4sbo1LQWz6d6F3/INs9hDBoMwhb+qBwY6uHRK2qoTXcBzW/hFltSUbh4sNIdsNpFCobc+rpSU8GvStqADqA3mhlghlhrWZDAGsRgZblHoT3muGOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cPyFZYQR; arc=fail smtp.client-ip=40.107.159.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vGez9J/8d7HILBV+rFVvDQDow9LGwv3VXvtqg1xlQscdB7584veaY37b5UTtouhoOCRz3tanz2BwHRKQ89smCJSiX9ysM0CZESNbnK8p/d5vq248xJhNjgTNskrEwx3/QbrejG882DqwLzMW+dLhYgDgpyzhjey+N5O/6bUGmELLUZlFWdvJTso/yG49MKggqYglffhjV/6SkzRLojWINYo7zHqFvADQZxb209QFejT1YLb4kG19vvvgg4RqkJTAx2UfFw0Qaqr8xdYaa1VvVN+Vqi+QPYGa3KaKiQY/KSS7bmp1+fWbZEMYNtyfdGWV7aTu/0KhfM9lPxfN39J9Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iDa8fY1UtHC+s+EqUo9CngrppWi0ejINAB6dpVfrYY=;
 b=E8vc3TCEjE2KIq3n2luavmaypmsR7mJ0ik1xZe63q12+HHBU7EG7gZ3HYedc1R/kNW2rMmGLHFooU30Zw5hYRI/9US5W3ObO3zgZoFXNuZFtoKgCTIIn+Nhszt48Ong1xSlnO95DuZtCHcuBNRESheROowL0x0ngW/9YHg98yULwNPmYW18wOzirZ9BOy6fTg/E7O1Av2lcsleWi6LOdkGKI+Tbcnh9s8GgKt6sm3tDv/AGfMdXxrqograbWZJzGY3IoF1ecUETBXQT2Q09LT5B4zzddwn421ZjHwZvLjLYemdCU02DyAOEAJyna2RGAEDT7n0mJsEbcMJnyo/YhVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iDa8fY1UtHC+s+EqUo9CngrppWi0ejINAB6dpVfrYY=;
 b=cPyFZYQRl3ruPjKfG6JaQkBxz/j4tmjjmkwrQok2lBGWOtM9ZJdoxBm1W9u9JAr0uLEvRRDlVDL4iPuVKqTCMnXXHcaT68ocuJGQ5IbGLgNMu1CLGH5OFa1XrGbmUbPqprF9Aizgwgr7qP5rqpmqmA0IlSjzxbibAfEEdpzPrmRPf7tqMZkpA0WqbYJM7HVaTDB0zJbJP9G5nRt5l2iYEZGFwdUh2dWVtucNmv5xNQttw0hTwpjMC+2+nzACtnniCrKferEMVwOjOBHdoDLZI8nMm96fWY8UMUl0of9/iqJQNlJlJYcs9I2c+I2M7AjVzY9WHKjWIqPUmqzxQhnHAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV2PR04MB11448.eurprd04.prod.outlook.com (2603:10a6:150:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 14:56:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8880.015; Wed, 25 Jun 2025
 14:56:01 +0000
Date: Wed, 25 Jun 2025 10:55:56 -0400
From: Frank Li <Frank.li@nxp.com>
To: James Clark <james.clark@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Mark Brown <broonie@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Christoph Hellwig <hch@lst.de>, linux-spi@vger.kernel.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] spi: spi-fsl-dspi: Report FIFO overflows as errors
Message-ID: <aFwN/LlXEmv82PcF@lizhi-Precision-Tower-5810>
References: <20250624-james-nxp-spi-dma-v3-0-e7d574f5f62c@linaro.org>
 <20250624-james-nxp-spi-dma-v3-6-e7d574f5f62c@linaro.org>
 <aFrXRDJmMgt0qTlL@lizhi-Precision-Tower-5810>
 <0e26494d-7b85-4874-a2e4-a498ce1864c8@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e26494d-7b85-4874-a2e4-a498ce1864c8@linaro.org>
X-ClientProxiedBy: AS4P191CA0020.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::8) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV2PR04MB11448:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b925e1-9716-485b-f490-08ddb3f8669e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hek4beFCoHRfFXJcr6loG++0MzQnTrUJRKwVfHhu/kXT6XEKXm0eu+6vhSMo?=
 =?us-ascii?Q?+HVoW+fTpgfqMc9UdQiPbe0X/Ot3C479YB8j1JhUAT5baFasmSqO3ZD6rP9j?=
 =?us-ascii?Q?xms4DrZYkZSMFgYQ9yQxzWrqV1HxcpmCi7drpKqa8/H6vv7ZIru1tRSOYOZx?=
 =?us-ascii?Q?paltPW9grD5lloodYtYZbd1yu6Qzdw2upoWTSHJCWpdnbXx4O0O2UNeKEUYI?=
 =?us-ascii?Q?GXIuUFl5z00UcGM1IY1Rnrqt9qEfskOYyyMbGqbigQYR15+Cbt8PngZLC0GL?=
 =?us-ascii?Q?uOMG6cdFqFsUH3UdPZ+5N6ik4CEgmWtzS1HxQ4jtSCjLc4bogoLiBzy2PxcE?=
 =?us-ascii?Q?vdMCSiAlPuqiaSALoMfNuIDIFdj0U8FEcMxMwQSXJrsnsnvK6FL02cVdDYMU?=
 =?us-ascii?Q?khp/48aaJNqYKmjW8IolPVq9Wrtpb63NqfkximjMYtluC/Z/sTUHlTSJuVgV?=
 =?us-ascii?Q?qoz2OM8wD58dHipbqFxipbU6mXNaSJB3HNqV3Zavl63zGO7j3mit7wjs0MYC?=
 =?us-ascii?Q?TE2t8GbcTE9SKoOyyE/2z28svk6dnQ1My3IM1Vlu/sMne3Lk9+oaTvQqHJx4?=
 =?us-ascii?Q?pSF11z23LCk6OGJ7rOte4BZiyQxDeomNNVHP63L1qUD2+jOYJ9Y7kXYNDNbA?=
 =?us-ascii?Q?i97zdEIaBYikJkgJQGpGO0jt9MJk/tY6nXZ1YCadkELM7rgF2G+GzWo0a4LN?=
 =?us-ascii?Q?ObUIWzCbgIHy4tQwirUCL1ny5MVhAzQ1yBayVgLAvvTFyDrVQScZmaJOz33S?=
 =?us-ascii?Q?0ZkZLi5ooqFL5WPt2IHt/Rv9dueueZeDILQaJ3KvXubUsC0wuCQLFmrYDKWG?=
 =?us-ascii?Q?KxzY49M+UFcB9firbFfti8W4T49/PB+KzssCLrMjUf5eCOPkfdjG3CoB+xrb?=
 =?us-ascii?Q?GWix7ORBNehFFU43QjE/11CBa2/c/zwl9ZT7dFsgV8PxDdJZUc+kqjH39edN?=
 =?us-ascii?Q?jv4kI7f1cJywRkaiTYsWV6M6LAVuuuKKxmkQrJGeO4kwJXFgCCuQf2iHKHzz?=
 =?us-ascii?Q?rbgAP7ojK5HyzBcy9AaHvU2+HLxGnLn42jzBeKhhsdsMH+JgcgESCcXk0wkO?=
 =?us-ascii?Q?GGjO4dYh3KlQILJrqdJj355zt0fgW2R5WxEVV6o75Vx9k8dih8Kp6qEb1lmg?=
 =?us-ascii?Q?BKmoXRjHLorIooreNvPpphfoEPr+gk6eKbb2JHxoHqfACFfPrsUDLi2IXGPC?=
 =?us-ascii?Q?7cI1sXgE0vuMIOowwNWNmR56TSNIucI1x+iUefH0P8ZqRo/ZYdReTfJniUE9?=
 =?us-ascii?Q?Jee3n4R7B9BOq0QY8XbNM/RC6YTn9vy8n631qiIjSfmShfgNZKNquIPss4vM?=
 =?us-ascii?Q?iyn0ndJGn25Bh6EicQAZoCGrYPo1N414opoh23XqXhZk3tavrLRpdpYvuyib?=
 =?us-ascii?Q?fAfChOlMYgxifKvI05ejp24je0ktlG3hMRj4MxV93v969yVQMGGhMQbzCZgF?=
 =?us-ascii?Q?ZOmsBbfdbw8O/bzRdbsxZmQb73LXeo5C00UXFIj68d1+Qy+8/PqJsQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HogdzWuzqKq+ZZCMm4dnvbqOWs9s63mt9MZZTJue8vU8VvidvdF0WXugY9gs?=
 =?us-ascii?Q?5i+yx9L0LLWt6xWwhwa1bFJTOadgu7IPLrDnLfwMdW+UZ4tWIGJqJ+242zi6?=
 =?us-ascii?Q?xGgwS+WxQFWXdnYpqXcpc4TtQaoo4nSceisVKbFGc32X+/25MrpAvgE9mbKL?=
 =?us-ascii?Q?4FLR/2aWI4j8y5ucF+MrWSoonhXL6rwwUPRMBbGoyvuWnnbJXc3RFCor+5dN?=
 =?us-ascii?Q?ZU8BAuN4iRSazul3WbCbqzyaoxHpLd1FeUnMiQpdYl4dmqiSZ5iyFwt7bFO/?=
 =?us-ascii?Q?UInkuZ5QLHc/KCLSKugtcL5AkOFuK1Y8+gFwqFOdjDM9+iD9JDttnwmcZymO?=
 =?us-ascii?Q?Nd2yV2cGKMTnrvHtHh+feRjapekFGLeozg6Wd70FDXiC80/p1nCzpxgNZCaC?=
 =?us-ascii?Q?E9AlYYfnEhoxhsPE+VSfE3Cbr4fluTKMXQ9NBs/gHO+tEIzSQdIOJ5+zkdVz?=
 =?us-ascii?Q?ZVt/GoAEFTiyE3N4Hmd6O0IY1lgMFdDJ2TD+Y8jyGKst9pWn7ALlPiFLXdTa?=
 =?us-ascii?Q?BnUZh5xDUtMmDSvNqZnA0yDT+Yce/KvEZ0jvjsp25UkVUVlMRm1TYX+jYrhz?=
 =?us-ascii?Q?x6wow7sLe04nKNqVuw8bZVe76JU4PO7p129HpEQl3iSqMdE1nykZzLHslDIM?=
 =?us-ascii?Q?AYMrbsShv6TNFrsgni4SNJ+UyTyHbLMdIncro/9lzDPRLv4fw264U3BAieoV?=
 =?us-ascii?Q?scQT1fXC2itGNlyDSneEOadlh0lA3r6GdlYCBlIYIYgMtYNqapG3Yw/KkmXC?=
 =?us-ascii?Q?ZVbqkfTx603L5WV6zJsT+5GRj7PgKV5O3eX7FhXr1II0oo0r4wKwQfOxl9BM?=
 =?us-ascii?Q?i4YOeuT0pt6E8FNODtjTfgX0Kid4h40dW0TQ/urtFsjMvJksztezJKbzVDFA?=
 =?us-ascii?Q?hLp01oUtuGeweTkpVm/VjJHEcF7WmRmvIepsWYpH3fdJk1Y4KlUWEbQG5oSi?=
 =?us-ascii?Q?7lHMkNemjYymVCvpiYD+tsTw+LSyKn58N+sSEpQIPZ/25spvy+PKFJp8KJsK?=
 =?us-ascii?Q?8enAqVqgTIK5wkfpHxMCW4rHx5ILBGu1YL34TIqPCQb1daz4VnFb2YAPNkdo?=
 =?us-ascii?Q?XgN9hIh+oKSnRLFk9JWL+6YqXZ/PU8uPawHd+bGLl3vccCCKgyiZ6NXqUyLy?=
 =?us-ascii?Q?fd/cmzl2LZJWgUXf3oz7VNEWnGT4gJpYkZGn+KZ88or/ZtgXRweV+I3ccfey?=
 =?us-ascii?Q?88CHNSS8z1wCbT2UC+kPFmzO/iFQI2EOojPRA1KMuEnXFvVmyjJheVlJ2EoT?=
 =?us-ascii?Q?dL4lWEoqnzY7vWtVwZRvomMiqhKb52gHepRntexHy9uR6xaKo9XRoBlMmbsn?=
 =?us-ascii?Q?5xmiVGwk9FnNsWpTII7wMHp/KWfhHZWf0fgW/UOwk7Bk2MznGUf52dxxXOeY?=
 =?us-ascii?Q?YXdk7dqjraddNSmehGqOwMNsNuo4auUy7yYd38bMgzdW0bY6V7nWaqF3on6P?=
 =?us-ascii?Q?QtKxnKPn4EKcfnY/HgwRI7qUbgGFhZQU+2Hkw+ZwuHLdWesyfLWXHo0A8JZb?=
 =?us-ascii?Q?cSl60p2KgAaINnY3MJBAVMhFGNo30MY5l0bHHaWY+F/SOANmx3IgaDYhZwx0?=
 =?us-ascii?Q?rPUNm5OoiJJrFq6Spbc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b925e1-9716-485b-f490-08ddb3f8669e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 14:56:01.3017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KV20t7uOhWT2XNiU4ILEKmk4hpZvMZZ/4FWr7ZcjAEZAuo6rxHgnIeEo9U1lm2oimpX0NPYbcXETcigvk6j8DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11448

On Wed, Jun 25, 2025 at 11:09:57AM +0100, James Clark wrote:
>
>
> On 24/06/2025 5:50 pm, Frank Li wrote:
> > On Tue, Jun 24, 2025 at 11:35:36AM +0100, James Clark wrote:
> > > In target mode, the host sending more data than can be consumed would be
> > > a common problem for any message exceeding the FIFO or DMA buffer size.
> > > Cancel the whole message as soon as this condition is hit as the message
> > > will be corrupted.
> > >
> > > Only do this for target mode in a DMA transfer because we need to add a
> > > register read.
> >
> > "We need to add a register read" is not reason.
> >
>
> Maybe: "It's not likely to catch any errors in host mode so optimize by
> avoiding an extra register read"?
>
> > Add checking FIFO error status at target mode in a DMA transfer since PIO
> > mode already do it. It help catch some host mode ...
> >
>
> Are you suggesting that we check for FIFO errors in host mode too? It
> requires an extra read and check in dspi_tx_dma_callback(), but I'm not sure
> what it could catch. Realistically as long as everything is setup correctly
> then neither of those flags will be set. It will either always work or never
> work.
>
> It might be better to add it later if a use becomes apparent otherwise it's
> extra noise in the code.

I think your origial last phrase is not good enough. You may rephrase it
to make it clear.

for example: according to your patch

"Only do this for target mode in a DMA transfer because we need to add a register read."

"add a register read" is result, not a reason. the reason should be "you want
host side capture such error."

Frank


>
> > > In IRQ and polling modes always do it because SPI_SR was
> > > already read and it might catch some host mode programming/buffer
> > > management errors too.
> > >
> > > Signed-off-by: James Clark <james.clark@linaro.org>
> > > ---
> > >   drivers/spi/spi-fsl-dspi.c | 28 +++++++++++++++++++++++++++-
> > >   1 file changed, 27 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> > > index 58881911e74a..16a9769f518d 100644
> > > --- a/drivers/spi/spi-fsl-dspi.c
> > > +++ b/drivers/spi/spi-fsl-dspi.c
> > > @@ -560,12 +560,24 @@ static void dspi_rx_dma_callback(void *arg)
> > >   	complete(&dma->cmd_rx_complete);
> > >   }
> > >
> > > +static int dspi_fifo_error(struct fsl_dspi *dspi, u32 spi_sr)
> > > +{
> > > +	if (spi_sr & (SPI_SR_TFUF | SPI_SR_RFOF)) {
> > > +		dev_err_ratelimited(&dspi->pdev->dev, "FIFO errors:%s%s\n",
> > > +				    spi_sr & SPI_SR_TFUF ? " TX underflow," : "",
> > > +				    spi_sr & SPI_SR_RFOF ? " RX overflow," : "");
> > > +		return -EIO;
> > > +	}
> > > +	return 0;
> > > +}
> > > +
> > >   static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
> > >   {
> > >   	size_t size = dspi_dma_transfer_size(dspi);
> > >   	struct device *dev = &dspi->pdev->dev;
> > >   	struct fsl_dspi_dma *dma = dspi->dma;
> > >   	int time_left;
> > > +	u32 spi_sr;
> > >   	int i;
> > >
> > >   	for (i = 0; i < dspi->words_in_flight; i++)
> > > @@ -614,7 +626,8 @@ static int dspi_next_xfer_dma_submit(struct fsl_dspi *dspi)
> > >
> > >   	if (spi_controller_is_target(dspi->ctlr)) {
> > >   		wait_for_completion_interruptible(&dspi->dma->cmd_rx_complete);
> > > -		return 0;
> > > +		regmap_read(dspi->regmap, SPI_SR, &spi_sr);
> > > +		return dspi_fifo_error(dspi, spi_sr);
> > >   	}
> > >
> > >   	time_left = wait_for_completion_timeout(&dspi->dma->cmd_tx_complete,
> > > @@ -1069,6 +1082,10 @@ static void dspi_poll(struct fsl_dspi *dspi)
> > >
> > >   			if (spi_sr & SPI_SR_CMDTCF)
> > >   				break;
> > > +
> > > +			dspi->cur_msg->status = dspi_fifo_error(dspi, spi_sr);
> > > +			if (dspi->cur_msg->status)
> > > +				return;
> >
> >
> > Although fifo error may happen after you check, it may reduce some possilbity
> > and catch some problems.
> >
> > Frak
> >
>
> Not sure what you mean by this one. But I've seen a few small errors now
> that I look again. The error check should be before the transfer complete
> break. And tries should be reset for each part of the message.
>
> > >   		} while (--tries);
> > >
> > >   		if (!tries) {
> > > @@ -1085,6 +1102,7 @@ static void dspi_poll(struct fsl_dspi *dspi)
> > >   static irqreturn_t dspi_interrupt(int irq, void *dev_id)
> > >   {
> > >   	struct fsl_dspi *dspi = (struct fsl_dspi *)dev_id;
> > > +	int status;
> > >   	u32 spi_sr;
> > >
> > >   	regmap_read(dspi->regmap, SPI_SR, &spi_sr);
> > > @@ -1093,6 +1111,14 @@ static irqreturn_t dspi_interrupt(int irq, void *dev_id)
> > >   	if (!(spi_sr & SPI_SR_CMDTCF))
> > >   		return IRQ_NONE;
> > >
> > > +	status = dspi_fifo_error(dspi, spi_sr);
> > > +	if (status) {
> > > +		if (dspi->cur_msg)
> > > +			WRITE_ONCE(dspi->cur_msg->status, status);
> > > +		complete(&dspi->xfer_done);
> > > +		return IRQ_HANDLED;
> > > +	}
> > > +
> > >   	dspi_rxtx(dspi);
> > >
> > >   	if (!dspi->len) {
> > >
> > > --
> > > 2.34.1
> > >
>

