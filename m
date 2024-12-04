Return-Path: <linux-spi+bounces-5912-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DDE9E457E
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2024 21:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A91D165C99
	for <lists+linux-spi@lfdr.de>; Wed,  4 Dec 2024 20:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7489E1F03C8;
	Wed,  4 Dec 2024 20:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RA7v6TH4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4F51C3BF0
	for <linux-spi@vger.kernel.org>; Wed,  4 Dec 2024 20:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733343553; cv=none; b=Og52TU7BQESWZwslJpJSss0qOK8TjQioLrpKVDvi8QZy/leh7FiSc19iaOr1Uk2IgzoOEwniKAW2EvIRQi+yCj7M8GBY8beJcBQoGlA2L5hjZCDAlwjwABMYG/JB+lT/KQoLEW9009cn64TqPSVo3mjTKF2daJpV0cNspwrn3EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733343553; c=relaxed/simple;
	bh=Skba4yu7A/+C06QCStvzke/FmqrcOoMM0MPh7ZJlTb0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Chf7QWZNRJ8yU63Qa71LkDU79l+0BdWTyl5wLi3Mr3TIsw65UWFlya9rVaqyZJN+4DVZvf0+Y8IAUmOdW4EUPtZ29ws2L5UeWjap5QgrjYNn5xu/a7TgpmD8+r1J/za2lTo7He9h1FnqmC4rZg7Xqo6hgo1sJ7HJqwOWCE4dJk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RA7v6TH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F0DC4CECD;
	Wed,  4 Dec 2024 20:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733343552;
	bh=Skba4yu7A/+C06QCStvzke/FmqrcOoMM0MPh7ZJlTb0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RA7v6TH41Gynk/zFr3ea2pk2NRo9cH1XsU9wCPGc83riLSO8NIwkg5502ci4Um3Y8
	 hjkVwRb8zhLfeLv56joXjCe6SlJdbcryaFn2+n2e7u5aPIA2XL6T1aHG9wlwj/9kmK
	 13er0DwQc34HiZzHrO4VAzeCDSpER0POBuwDmejY/8YlQgl2/eei56p9/vXFHFV6st
	 6L49SfAS+HZNgdelnTgZ4MPNEHG/ohj1DjmlmTGt6onv1QL3CP24ttQ8iPIqNXEI+U
	 1+xBMevwsONpRUgILJS1dDZYlfvpiDnhY534d2XJw6o15WnZVMGb6RSIStu0WAsFd/
	 tgUPDMyJIGEYQ==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, 
 Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: Gerhard Engleder <eg@keba.com>
In-Reply-To: <20241202194003.57679-1-gerhard@engleder-embedded.com>
References: <20241202194003.57679-1-gerhard@engleder-embedded.com>
Subject: Re: [PATCH] spi: spi-kspi2: Add KEBA SPI controller support
Message-Id: <173334355193.75146.10727406589387637552.b4-ty@kernel.org>
Date: Wed, 04 Dec 2024 20:19:11 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Mon, 02 Dec 2024 20:40:03 +0100, Gerhard Engleder wrote:
> The KEBA SPI controller is found in the system FPGA of KEBA PLC devices.
> It is used to connect the SPI flash chip of the FPGA and some SPI
> devices.
> 
> It is a simple SPI controller with configurable speed. The hardware
> supports only single byte transfers. There are no FIFOs or interrupts.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-kspi2: Add KEBA SPI controller support
      commit: 1a90aae3b25b72e639da6062e0dc5efb9cff58f1

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


