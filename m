Return-Path: <linux-spi+bounces-12001-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 36067CCAD7C
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 09:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B32CA302B167
	for <lists+linux-spi@lfdr.de>; Thu, 18 Dec 2025 08:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA72338935;
	Thu, 18 Dec 2025 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLzkt0b0"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540E2337BBD;
	Thu, 18 Dec 2025 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766046101; cv=none; b=fpXfB17Ro6KMCg6T+bn+STPzUnjf7c+C3M6POXV+AUXbc7nzJmTDYfDlpxijiBPM68ndug4X5Vmnz6U8xUJnIUaoQ779rqfL60H8Y2VwLrk5caCKeHRgjJEukNbs2F3dFDWcZerVpwMoYF5sWJUJFvXbhxjzqMQJjPXPWsiE3Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766046101; c=relaxed/simple;
	bh=Hh/3/w5jCO1JSs8bn6HtL1yOfwiRbMzAmbaf4GEsClk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dny3n3zBG+8S4A9jyams3hG4L2TvY7proby4ERUAz5dKPJZ6F82mh6wUdPyEM5xWLBKbV7wth0XAjDMdDaqkWZXmp/vWNFu/n2e8tgugNJHUhWWWCeqgNO/hKCoA19fJg2bfbC8hDaPQe5LNvu3SdtpgXQhtPVdoh6lVvzNv8Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLzkt0b0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E56CC113D0;
	Thu, 18 Dec 2025 08:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766046100;
	bh=Hh/3/w5jCO1JSs8bn6HtL1yOfwiRbMzAmbaf4GEsClk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pLzkt0b05zdeneWZAOS+i5nfvIDmdV/9ApM+2e6gUIdeaPZ2lG6x2W5mmM8JMDIAU
	 CYGMR2n9oWe+MPyGf9An7YX3FGYT88M9Pdkt9ld2QAYnz6y/Rh5I7RCpTgPeQuYIpM
	 ug55lzQ2ftPWKd1IvFSfmgj5HT8zNIGH2a/bsx8orBkjaP4jFt4wah4MZYxSKMSM4d
	 zVraU49BDh0ke4hC7XGsan8v+5WAPZ3UZ1ZRnhgvsT2bC8OIVlHgGAIq/iLqR+Z9pD
	 1uKshmXYeR7uJgh0gDOadKwJNis2VTTd0jriBS82s76ldF9zRW1v2Y+F3beXOZVQQr
	 gUMk52RWeb5oA==
From: Mark Brown <broonie@kernel.org>
To: mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
 Chen Ni <nichen@iscas.ac.cn>
Cc: linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251216043210.1521722-1-nichen@iscas.ac.cn>
References: <20251216043210.1521722-1-nichen@iscas.ac.cn>
Subject: Re: [PATCH] spi: stm32-ospi: Remove unneeded semicolon
Message-Id: <176604609931.49312.660104330580864155.b4-ty@kernel.org>
Date: Thu, 18 Dec 2025 08:21:39 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Tue, 16 Dec 2025 12:32:10 +0800, Chen Ni wrote:
> Remove unnecessary semicolons reported by Coccinelle/coccicheck and the
> semantic patch at scripts/coccinelle/misc/semicolon.cocci.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32-ospi: Remove unneeded semicolon
      commit: d8ce99b0d384830b0eb6b907f5a428309c70af82

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


