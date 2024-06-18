Return-Path: <linux-spi+bounces-3423-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F193290C46D
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 09:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 931722837A0
	for <lists+linux-spi@lfdr.de>; Tue, 18 Jun 2024 07:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF8212D758;
	Tue, 18 Jun 2024 07:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="f9o9n/8A"
X-Original-To: linux-spi@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5603F1BF38;
	Tue, 18 Jun 2024 07:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718695348; cv=none; b=KzUpst8zLI0Uwue+yQzEsBhFhj3GpsAhbxZMleLA8vi2O3DSgdZ74yqEOw3Z3zGWeRA/rIL/+ORkMYCcI632oRI0krLJYMbrxGTbeUwIFSrUVGFxpInP4OL0qzyaqJXrqo/ZHo1xfCI3HMgVCFYaKERTNdioZDHgncoVmwYoCco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718695348; c=relaxed/simple;
	bh=fgOMeiSNWMTUpBSBXUqhL6wT38bkG2TPTOJfTexXmnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PaAh0LYUq8Ketwc5tz0tw1R2Bzp3UToBpyqquWobM5oNUg12t8dFn+Bd5w1vdHUtrMBT/CtXboS85zNNOp4RuCJH7SJiKmlNR9bH4/o5uC1klHSswgSpCIAcoepicYw5MWm7Bo+KyLdx18BDunpPvsCBieApdcg8egBhKIT4pqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=f9o9n/8A; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=lFXQoNB3NgLdP7vmjHlHVASYxjD4E3i9aARHyEZwpPQ=;
	t=1718695346; x=1719127346; b=f9o9n/8AdOf+vQl5l4rPSdzVGbrgG1F6kQQ1wNUosMdY140
	bpSWviEOWuRpnFzbXLexSsXDdLw50hsUivvkHTzJfxLT6MuQ7YEqAYd2o5ojfqBwEjTyeLliQP2g0
	EKrBNUlVE5UYrIFsAFsMk5C1vIoF3DxYMGPZVWrHL20dlB0hQlQwn5gVU+eVVUCfNvQaa5hfi1Zh1
	fIAy/cHgp822HPW8rUOmGHXH+6PyLkN4Wo2/XlOgS30/RZsI+EMaZLiSdpF3KN1C/Dgc806Ckmvq/
	1oT8sRdwR0mz9ub3LMdcvaksBI2VxzNL+LTwTUoP/W/BOYlFnd50YqkIo/0yA3Hg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sJTAb-0005x8-Bf; Tue, 18 Jun 2024 09:22:21 +0200
Message-ID: <c11dc5f8-2638-40bf-b562-fa5cf8bf40fe@leemhuis.info>
Date: Tue, 18 Jun 2024 09:22:20 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] spi: omap2-mcspi: not working with kernel v6.10
To: =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Vaishnav Achath <vaishnav.a@ti.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, joao.goncalves@toradex.com,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20240612170030.3qatttsgrwjg2m5s@joaog-nb>
 <1b9852d1-4454-4f62-bd8a-fb6167dc0576@leemhuis.info>
 <20240617195358.v3ewnsu4jgkygvby@joaog-nb>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20240617195358.v3ewnsu4jgkygvby@joaog-nb>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1718695346;2050ca34;
X-HE-SMSGID: 1sJTAb-0005x8-Bf

On 17.06.24 21:53, João Paulo Gonçalves wrote:
> 
> On Mon, Jun 17, 2024 at 11:29:05AM +0200, Thorsten Leemhuis wrote:
>> In that case the thing that really
>> helps would be if you could use a git bisection to find the change that
>> causes this.
> 
> For me, spi stopped working in commit d153ff4056cb ("spi: omap2-mcspi:
> Add support for MULTI-mode").

Hmmm, Louis (which already was in the CC) posted a patch with a Fixes:
tag referencing that commit more than a month ago:

spi: omap2-mcspi: Ensure that CS is correctly asserted when switching
from MULTI mode to SINGLE mode
https://lore.kernel.org/all/20240506-fix-omap2-mcspi-v2-1-d9c77ba8b9c7@bootlin.com/

Unless I'm missing something, that patch did not make much progress
since then. But I wonder if that might help. Louis? FWIW, this thread
starts here with João problem description:
https://lore.kernel.org/all/20240612170030.3qatttsgrwjg2m5s@joaog-nb/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

