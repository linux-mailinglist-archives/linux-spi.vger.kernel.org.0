Return-Path: <linux-spi+bounces-8978-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F651AF0670
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 00:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9088D1C0461B
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 22:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4469A302CDD;
	Tue,  1 Jul 2025 22:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cq4PLqhB"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D282302CDB;
	Tue,  1 Jul 2025 22:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751408148; cv=none; b=UfBrmRDCvAF4bfZK730Xkbgajb1KmNCKirfUqBqkfIqCrA35R1ZaF0C5GH8DzKITtzMsrL/QG47kndvrmftVRbToTAL5eVFiEl+4Q1k9OXqFjCsruKOlnx/cXjjAIgIapoWv0yEyVIJ22hGL9h6lhiVM7FoltGHaqUTBtx8c9Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751408148; c=relaxed/simple;
	bh=1V9bluvj6qQ90+PrLqZ0V8vdxa8GaJjq9j4rh/X5piw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iI4hBdsOllU2+RL8yUB5j2VUPPaFuVbrgCLsQQ35Z4sU5fxUYsvPu83WRPtd0ixA0vC/9z4hJZPV1eGYNww5NShqLpyaSA54rOYJUNLKZTf8Nq2/6EtcP1IITsECeyYaeUSmMX84ZsY8bcgNmBv/d8TwyM31ml62T33enVeNF5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cq4PLqhB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002AEC4CEEB;
	Tue,  1 Jul 2025 22:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751408147;
	bh=1V9bluvj6qQ90+PrLqZ0V8vdxa8GaJjq9j4rh/X5piw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cq4PLqhBNXHPRoseG61W93iWlprbyQW36RTApzIjVnz5kYav6/kgFrWTTZvIsG5nm
	 dalNoS4X9NsbzXZX5ylxeER34FL6ZwzgcxAhw6cpai9ZNmEhFLc2TDbvQMseEoKCyl
	 lhkStm9uRunHaQXLtsWAjItmhmcwmsnh8UAXNUB+4vpXSv72Tta1D5TrWWeDSdqEWY
	 nGkq5IntSVX0Jf5CXcdFR+c97TDOwbswm0F42+9fap/0a6iZFtpwZbaDdzZf9JD4SE
	 ncjhdj3vypRpxv6Gvz4hYKdlApTqBhFUdC+ghUYHeKKqh0akkrrSL2+4CDf/Flwjh0
	 3+FBqBlRlJiow==
From: Mark Brown <broonie@kernel.org>
To: Alain Volmat <alain.volmat@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Cc: linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Dan Carpenter <dan.carpenter@linaro.org>
In-Reply-To: <20250630-spi-fix-v2-1-4680939e2a3e@foss.st.com>
References: <20250630-spi-fix-v2-1-4680939e2a3e@foss.st.com>
Subject: Re: [PATCH v2] spi: stm32: fix sram pool free in probe error path
Message-Id: <175140814573.710092.14100565010751985098.b4-ty@kernel.org>
Date: Tue, 01 Jul 2025 23:15:45 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-cff91

On Mon, 30 Jun 2025 14:59:23 +0200, Clément Le Goffic wrote:
> Add a test to check whether the sram_pool is NULL before freeing it.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: fix sram pool free in probe error path
      commit: f4d8438e6a402ad40cf4ccb6e2d2417d9ed47821

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


