Return-Path: <linux-spi+bounces-6845-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBADA382E6
	for <lists+linux-spi@lfdr.de>; Mon, 17 Feb 2025 13:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC10F16F4CF
	for <lists+linux-spi@lfdr.de>; Mon, 17 Feb 2025 12:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FDB21A43D;
	Mon, 17 Feb 2025 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYIafrZT"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C88A21A42D;
	Mon, 17 Feb 2025 12:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739795069; cv=none; b=eN8YwabBDcxI9Ze/UCJMAPOpil6vQjgw8qf54iInMnBLcXLSRWxKvnPSl7KhsdFsuoXsE2U8AeA1MQVuvME3luWte3dfKf8XjB4HpNqzmh/Yi3jFG5JfKFI7KfdbMCiHNnWEG6t5UYgqUMmTsehkyq1pql9s0X4maKTgN/ClBSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739795069; c=relaxed/simple;
	bh=SRf3YTxjAgDKnlVnA2yMsMyx4krYxITlV7fjszM2wpQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nukZzDpAMmY1wUK+DLYBYWmMxG8zplj+15MuLf3HhMVGx3kJd8LYrpDdUKf0d9GT7LPSVrN/viN7TnJvwVQJiQTMQThnXCabyaa/CF0TGJy8AT4cUu9XcaLDPKViBrRBU+z1NZZRiUjtwYDv1sjL9lav/Ly+Kyc74ET2Gia0M4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYIafrZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1529FC4CEE2;
	Mon, 17 Feb 2025 12:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739795068;
	bh=SRf3YTxjAgDKnlVnA2yMsMyx4krYxITlV7fjszM2wpQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VYIafrZTNqrpAEm/GlFH8W+ongC8veNkKp9X8lZpw1+bhZwd/a36A5Dcn6Zgxsmmx
	 mHQ2ke3YckKd6qD/o7HubyHRtsONGwmgFXgV346TDsK9A0ytAe8CwmE0pUV0SThWGi
	 sJ7UmiK5NGvGfrSkpgn88190RIUwZwIXWd8QsbUSJ0wojZ50EuqWEt4z7wtUlpZRYj
	 0lOIHwbcw7ZhZRPdEkoOOZJyfC0l/p4gBFBaylbrgNRP4Si+ULBAj/zkVUWVi1PY2X
	 6I8ujz6tWY3OaiVg4IeI033IsVqTeGAjDMWCwvGxkLSL9x596XuSfgxhw6qfLnZ0su
	 kwSeig9KuTxfg==
From: Mark Brown <broonie@kernel.org>
To: Andi Shyti <andi.shyti@kernel.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250213-gs101-spi-r-v1-1-1e3ab8096873@linaro.org>
References: <20250213-gs101-spi-r-v1-1-1e3ab8096873@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: add tambarus as R for Samsung SPI
Message-Id: <173979506779.23527.16029570776047261205.b4-ty@kernel.org>
Date: Mon, 17 Feb 2025 12:24:27 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 13 Feb 2025 08:03:41 +0000, Tudor Ambarus wrote:
> I'm currently working on a Samsung SoC which includes SPI.
> I'd like to be Cc'ed to further contributions and help on reviewing
> them. Add me as reviewer.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] MAINTAINERS: add tambarus as R for Samsung SPI
      commit: 3d7a20f9ba7b09a35df4bdb5f0ddb2a0c8a4f39e

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


