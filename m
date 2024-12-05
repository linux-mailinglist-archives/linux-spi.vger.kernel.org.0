Return-Path: <linux-spi+bounces-5920-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 261129E5777
	for <lists+linux-spi@lfdr.de>; Thu,  5 Dec 2024 14:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB6B2892C2
	for <lists+linux-spi@lfdr.de>; Thu,  5 Dec 2024 13:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD74218E99;
	Thu,  5 Dec 2024 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1eczRBk"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03CD1773A;
	Thu,  5 Dec 2024 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733406102; cv=none; b=bmrSoCHrgWrcN/GOnIrOW7hYWyKyibMDe9fabDsT0C/L9bIi+PkS1e4kMffTB6LRmEPRn+SZ+luY+k7BliXBkp0vY5Va0eVKjnlohPNxD2NzmA7qKvbRljykT2SJyO3QNilpfpPjOj5LS5h0xXAkG3kKgP/O0TZl9sLC0XVcf0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733406102; c=relaxed/simple;
	bh=D0zNP/dtrzxCy4UUhUhhehlahcy0WPMKmv/hwehO7o0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WL3AKvmj4geIAtVVAQoeWE9OWpuc7Lc5DnCtcuUDled3RuiZP/5jyF1576a4OOA4oXHZ3N89FS5kPLt5Hexu7EnQrPMEB6oBI88hJXxjN6fA+KKs/oEVqBg3zoqKRl8uVcJoB6Erg34BgpYdNlb+zw9bUQGtsZy+pG805l6mz+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1eczRBk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFF8C4CED1;
	Thu,  5 Dec 2024 13:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733406100;
	bh=D0zNP/dtrzxCy4UUhUhhehlahcy0WPMKmv/hwehO7o0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=J1eczRBkYMLT8i46oPNC1QqKsY794xQXpuoH3AcopHhgiwTKiUMfWNHQOQo+y0erm
	 FAwo7U1qvelmf6Z8fQm/riKzW2Nczu42yF4lh2ghD4xXEPZtwGTwH2P7pgYRQ6b6QC
	 8A8o1WKTkM5xDg7F1/QvC4At/+tOAIkibkuJahPOcbM6zK+AnvMh3QL9IX9bd1JnaF
	 cuP4C9YAdXV6zAkXbSKV2JWd17F1qIfz+zWs2/GpNRMN3p9tCXTT8Y82fN9GyioBZv
	 xkhAkPjVQb5Ma2a45tkpvOXqZLRyJIB2G/9IXXeu9vwzpizXyaUfpBE27inLMRI08s
	 ikywjHpdjNmAw==
From: Mark Brown <broonie@kernel.org>
To: psiddaiah@mvista.com
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 cminyard@mvista.com
In-Reply-To: <20241205070426.1861048-1-psiddaiah@mvista.com>
References: <20241205070426.1861048-1-psiddaiah@mvista.com>
Subject: Re: [PATCH] spi: omap2-mcspi: Fix the IS_ERR() bug for
 devm_clk_get_optional_enabled()
Message-Id: <173340609921.87421.2165857099937592834.b4-ty@kernel.org>
Date: Thu, 05 Dec 2024 13:41:39 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 05 Dec 2024 12:34:26 +0530, psiddaiah@mvista.com wrote:
> The devm_clk_get_optional_enabled() function returns error
> pointers(PTR_ERR()). So use IS_ERR() to check it.
> 
> Verified on K3-J7200 EVM board, without clock node mentioned
> in the device tree.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: omap2-mcspi: Fix the IS_ERR() bug for devm_clk_get_optional_enabled()
      commit: 4c6ac5446d060f0bf435ccc8bc3aa7b7b5f718ad

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


