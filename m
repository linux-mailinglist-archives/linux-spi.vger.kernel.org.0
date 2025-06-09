Return-Path: <linux-spi+bounces-8407-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC160AD26CB
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 21:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DF4A165DCA
	for <lists+linux-spi@lfdr.de>; Mon,  9 Jun 2025 19:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B23E21D595;
	Mon,  9 Jun 2025 19:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPHRbBW+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D749319F135;
	Mon,  9 Jun 2025 19:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749497622; cv=none; b=sSfWlAMjWxSKOTH1KcQDkruuOmrJVBD8JovtfNNCrw5fqFYPrwz05E59dyBDjQ6SjswIij1z/hCmn7LREcQEfZZzr1mrS2eIM/RuY7Z1lKqjYPybKU2Clj9Xjyq7SvNQB5U8lmjh7M444/1ConXI2NUPN4WkukwS2JSXd/lKCrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749497622; c=relaxed/simple;
	bh=8brKecVuvoIHo4faTS4qU03vkO3sVX0GBCpsE0YwiJI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=RI/ksyZeqoQj/E9blFgMP+Mf7/0pw6qest3XQj8NQHq2NAt6dej6DC3wu1+IogrA6Hiafc0hG9iboqEF6Ug88gQ0C19U498zXM82t/hh/NmD6nm7ZKMoll8aUzVEfqvfFMywO77mnEpZx5ksEpEZKJF7LlY2SntU+X36G/Mn2IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPHRbBW+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD30C4CEEB;
	Mon,  9 Jun 2025 19:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749497622;
	bh=8brKecVuvoIHo4faTS4qU03vkO3sVX0GBCpsE0YwiJI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JPHRbBW+6o7hCF/rretPK8Fd8mYgtfSi6r9mEsf5dWETA3XkHy1JsHUG/uPbVpE3q
	 0aAf3FiJU6t+g9pOQNN38isOEIpeAYb8lSvcWfXEhFVC4uMRJMzrdvoZ0wvngkeQwG
	 uumGElx9PT8QlDIRvs2UQI5lmYe9IdyZiSbdjjkaFQuixFyY6CHKNhxBsQwMb9yfus
	 ow653GAYvLvM08es10JOZThS+rghLh2aH6BJRe7ccy1AC25RFtKKb7YJuzS0vcy+gd
	 xO8cX796dvJeDTe1Fl2am8dXeTBaLCrcR2Rftg+bwq0r6eKDaVwLC7aM/RPbv3PABi
	 PrQCoO7AcksUQ==
From: Mark Brown <broonie@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org
In-Reply-To: <20250411-b4-upstream_ospi_reset_update-v2-0-4de7f5dd2a91@foss.st.com>
References: <20250411-b4-upstream_ospi_reset_update-v2-0-4de7f5dd2a91@foss.st.com>
Subject: Re: [PATCH v2 0/2] reset: Add
 devm_reset_control_array_get_exclusive_released()
Message-Id: <174949762071.256775.12630399981085475300.b4-ty@kernel.org>
Date: Mon, 09 Jun 2025 20:33:40 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Fri, 11 Apr 2025 14:41:09 +0200, Patrice Chotard wrote:
> Add the released variant of devm_reset_control_array_get_exclusive().
> Needed by spi-smt32-ospi driver as same reset line is also used also
> by stm32-omm driver.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Changes in v2:
>   - Rebased on spi/for-next (7a978d8fcf57).
>   - Remove useless check on reset.
>   - Add error handling on reset_control_acquire().
>   - Link to v1: https://lore.kernel.org/all/20250410-b4-upstream_ospi_reset_update-v1-0-74126a8ceb9c@foss.st.com/
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] reset: Add devm_reset_control_array_get_exclusive_released()
      (no commit info)
[2/2] spi: stm32-ospi: Make usage of reset_control_acquire/release() API
      commit: cf2c3eceb757e3f28e6f1034f9bc178e1535f5cc

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


