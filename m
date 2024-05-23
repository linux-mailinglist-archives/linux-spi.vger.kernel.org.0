Return-Path: <linux-spi+bounces-3054-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA468CD7E0
	for <lists+linux-spi@lfdr.de>; Thu, 23 May 2024 17:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C53E1F23014
	for <lists+linux-spi@lfdr.de>; Thu, 23 May 2024 15:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7811401F;
	Thu, 23 May 2024 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrUdS0vO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2730017C66
	for <linux-spi@vger.kernel.org>; Thu, 23 May 2024 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479775; cv=none; b=UQTt4jXWthue/SobyWJdo/yYLswx1hE74+r2OSa0qulylF4cnVZ8TNdl/TWd4/448T7S1S4BOdzWJU4Eaj//F/klSJiLXrnLDEMG+e46e0XKOZOcgfeGPPF6TmQL1x88iWsrsu3RvYdVuhKexhuKItlyVrS7rwc9pnA54Vj5XAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479775; c=relaxed/simple;
	bh=XvmEDDUHlsY6mU7seNbHovJY2X6+z5HZts8QvBbsPp8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NVDm1mzbOuhFAcC43i4j6YN2L1msFNkAdHMT4PA+03+k/6L6NZfWyaDR/1Du2X6PTPtFUyNC6/o8CMBWI16JntgL+gvzqCq1FU1NLHViPbzaiXkdtW6YRjSn1L+pDROIID4m2rJysxDyH3ubigEnBmEb6BPQLFNSiiGx0P3AWXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrUdS0vO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9BC2C32782;
	Thu, 23 May 2024 15:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716479774;
	bh=XvmEDDUHlsY6mU7seNbHovJY2X6+z5HZts8QvBbsPp8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RrUdS0vOunXE6i1fR1kAkBcgYN2SGkZ2X3fEdJrN3IOwGwqExrVimGrBzdg8iSD2W
	 KKmglq1XNECQy5By63cCLixmCT4MLgEk0cx/gDuahg/g0fHDLGuRfaez3o3645Uqkc
	 XlhZiBclHH8e/e1uFX0zUQoUmcxtjQwr1sNGCHPvelYUnSzN5mWz6NZANNoJOftrYk
	 kdoEW+vRkybNTBTv9HmkSqmUgutTvFB5G1rn1Q/aCPG3dNSCupAtxqBDsz34BQGhgT
	 PT0SSS/1j8HTWWkwfU15uS82AOZDDX0/7kxCDi5FMEEPYaluojmnz2L2jaD5Fq1vI6
	 8LLYpZM8BJpIw==
From: Mark Brown <broonie@kernel.org>
To: Alain Volmat <alain.volmat@foss.st.com>, 
 Ben Wolsieffer <ben.wolsieffer@hefring.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-spi@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, 
 =?utf-8?q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>
In-Reply-To: <20240523103326.792907-2-u.kleine-koenig@pengutronix.de>
References: <20240523103326.792907-2-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] spi: stm32: Revert change that enabled controller
 before asserting CS
Message-Id: <171647977254.55224.3637394907544576771.b4-ty@kernel.org>
Date: Thu, 23 May 2024 16:56:12 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14-dev-621fa

On Thu, 23 May 2024 12:33:25 +0200, Uwe Kleine-König wrote:
> On stm32mp157 enabling the controller before asserting CS makes the
> hardware trigger spurious interrupts in a tight loop and the transfers
> fail. Revert the commit that swapped the order of enable and CS. This
> reintroduces the problem that swapping was supposed to fix, which
> however is less grave.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: Revert change that enabled controller before asserting CS
      commit: a827ad9b3c2fc243e058595533f91ce41a312527

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


