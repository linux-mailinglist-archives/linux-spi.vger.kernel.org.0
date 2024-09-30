Return-Path: <linux-spi+bounces-5062-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B11E698AF51
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 23:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A9DAB20C03
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 21:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D707187FF6;
	Mon, 30 Sep 2024 21:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLub11w1"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CAF18455C;
	Mon, 30 Sep 2024 21:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727732527; cv=none; b=AW3W8OymJ5a+3/hrfzNlRZz9Vlp4e1cI2T9PPtW/jjo9GEX/qW1Q3SRVCS9qAI6Mqatn+HswtEZbULrec0D9UTugPuulXFtxLPMWwWtKcb3TpRao/XJkY+a1yJ3t5MM00HypOyNjDzXRraTsDqneSo8wGy8lEWNecMqlgfbOIOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727732527; c=relaxed/simple;
	bh=McD0PPLjiwQhNMLldB9C6lK8T6YObT0WHb3qn6BQztw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sG0L9pOUMoiKsQIlCVwd3s7flg978uY9mQQBpGUipWt1YElQ5nZ/VY72v+fu0VB+TQ04fhBcc+149d7SmMdO2ruwm1OtiHT9iX1Cy58xAMNnu6RCpKiQZrDkWpqBNvoaTKDWJUJaNbY0pkNoo3Y5FrURei1CbRWihBxBk/Vbt7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLub11w1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A5F5C4CEC7;
	Mon, 30 Sep 2024 21:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727732526;
	bh=McD0PPLjiwQhNMLldB9C6lK8T6YObT0WHb3qn6BQztw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BLub11w1YJApgAOCcsuxt+wvn7pjKhEUo0lDZtXNOGx209M1pRP5Ru3jLIVNUkbG7
	 UICIWUIL52R01MfweJKsFG2IjmFFeOm6j3i1vzh2PUekcGoD3IghZiYXbIPfBpXw9o
	 8rFqKp5QibHIJsUu1NJoD4mYkUptuCg6U9DjPi7w5vmbkmr6pC1s/gJvRNPKe43TYj
	 9ITBM2MXY1xhFJGQfZbna/Xv13JkL6QNBzGuYJE33ZJt1ix/UmEW+vFwspM8YcaxJC
	 feikt7ZOzJTD8Yi25HaahXyYVtr6KZ6gWvxFDNa5fP4jJY4v7I62jVvNkkhTbdahd6
	 /sqmHrZMGXX1g==
From: Mark Brown <broonie@kernel.org>
To: linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Leilk Liu <leilk.liu@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
In-Reply-To: <9e736d33-b07f-40a0-8fb6-8c3212593b77@web.de>
References: <9e736d33-b07f-40a0-8fb6-8c3212593b77@web.de>
Subject: Re: [PATCH] spi: slave-mt27xx: Call clk_disable_unprepare() only
 once in mtk_spi_slave_probe()
Message-Id: <172773252496.2210210.475643542831503313.b4-ty@kernel.org>
Date: Mon, 30 Sep 2024 22:42:04 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Tue, 24 Sep 2024 20:56:08 +0200, Markus Elfring wrote:
> A clk_disable_unprepare(mdata->spi_clk) call was immediately used
> after a return value check for a devm_spi_register_controller() call
> in this function implementation.
> Thus call such a function only once instead directly before the check.
> 
> This issue was transformed by using the Coccinelle software.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: slave-mt27xx: Call clk_disable_unprepare() only once in mtk_spi_slave_probe()
      commit: 610442f85c12ff662e3dec50c53d92f7a8e5a783

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


