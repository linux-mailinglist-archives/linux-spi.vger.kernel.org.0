Return-Path: <linux-spi+bounces-8124-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3CC8AB7EEA
	for <lists+linux-spi@lfdr.de>; Thu, 15 May 2025 09:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DB4E8669EB
	for <lists+linux-spi@lfdr.de>; Thu, 15 May 2025 07:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E911F2749DC;
	Thu, 15 May 2025 07:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nng7pcnp"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48EE2820C7
	for <linux-spi@vger.kernel.org>; Thu, 15 May 2025 07:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747294539; cv=none; b=nmlPMjukOjWRZI7lKJFS4emm4NB+KW20fWiUvGJ95fzTVGKA1UgaN4pTeNWGyfuk0ZSnjq5NdTHhwF22IeAsv+MmXJLQiO5vdekbJLXv7E9MgsT1pQyrYyqT/47xqxwwbfJfYAi+wkGWcCEcN4iPEppFA+N15zjEmpwvJ7q4x8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747294539; c=relaxed/simple;
	bh=HLhmaAVDgtBVF9ip7NojuON68hFLsBW7nd9NaOdwXhs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TcQoSs3kXOEX9JLTXHo8Kunkxj8yLIoCeEIOXPKXKk+mPfnVMG+B7H1VqnuWdMxhrkqGmpanklScLEKYPKOrh3CFYKV1zQXTohMcnT7LMblSpdd0y7LOuxmjYZ77SfSDYKO1CBBIyseC0QJsLTr2Udn37tFoT3kmIeMIu0akJ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nng7pcnp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0073C4CEE7;
	Thu, 15 May 2025 07:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747294539;
	bh=HLhmaAVDgtBVF9ip7NojuON68hFLsBW7nd9NaOdwXhs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Nng7pcnpl++cRrMtVI1MxFg2kEItpUT/I67jjhAbVNWMwPxmFgKi/Rin074+JLdrZ
	 GX4KFGYsmIplRaNnUyT5iLua3KmPGYmmvIos+rVvKHT9vfvvkI2tJqFCppCfbT22pv
	 0H8RZF+YNUYByCI1br3W9FP+GTf3VlBGR78s5vG/h6Y7gG48l8sFLz0AwzcLeVdIKn
	 0rgQ8ndMgBgweecS22Tf/AfRBRn71vPtAlcTXdpvc7X7C1MgnT/jfX9gqXyAsW9dnU
	 ArmCa7uISUwHV+7nXgDMhIwhOmPF20acdrsDWJSlSBKItr3KuFewfW0+hfG2cjFtBT
	 nJNFqPLJv0FHA==
From: Mark Brown <broonie@kernel.org>
To: Alessandro Grassi <alessandro.grassi@mailbox.org>
Cc: linux-spi@vger.kernel.org
In-Reply-To: <20250502095520.13825-1-alessandro.grassi@mailbox.org>
References: <20250502095520.13825-1-alessandro.grassi@mailbox.org>
Subject: Re: [PATCH] spi: spi-sun4i: fix early activation
Message-Id: <174729453833.272648.3762850474847867343.b4-ty@kernel.org>
Date: Thu, 15 May 2025 09:35:38 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Fri, 02 May 2025 11:55:20 +0200, Alessandro Grassi wrote:
> The SPI interface is activated before the CPOL setting is applied. In
> that moment, the clock idles high and CS goes low. After a short delay,
> CPOL and other settings are applied, which may cause the clock to change
> state and idle low. This transition is not part of a clock cycle, and it
> can confuse the receiving device.
> 
> To prevent this unexpected transition, activate the interface while CPOL
> and the other settings are being applied.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-sun4i: fix early activation
      commit: fb98bd0a13de2c9d96cb5c00c81b5ca118ac9d71

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


