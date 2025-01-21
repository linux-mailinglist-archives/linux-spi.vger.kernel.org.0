Return-Path: <linux-spi+bounces-6416-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF908A180A9
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jan 2025 16:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 927FF1885CB8
	for <lists+linux-spi@lfdr.de>; Tue, 21 Jan 2025 15:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AAB1F37D2;
	Tue, 21 Jan 2025 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T5lForn6"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0F01F236B;
	Tue, 21 Jan 2025 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737471938; cv=none; b=MNpX4TsW3mxc2LEq1U98KWBdrXmHUmhYXVYOv0E2PCxQr3V8UebHNMvKPeBHz82ieJaYc5YGZyyAw/dUFhwq/qdb/FLz//8HHyUtTWvwBbhGDdAIi4Lnmwx54716JyysbuJZA3WUf7kH+jX75HEvtmFJagN2fpUQ9UT+iSTvblM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737471938; c=relaxed/simple;
	bh=kNFxYizM37kG8z6naKIAqKCxTqkMAMEKBrRtctaLWlE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DSlQA2cgLQYFDSEg1bweuT0lX8cepgEdfI/Q4eSNGpo4GUsqznsjo6CHzWCMmHSAVDC1WvQbuflfHY9B1c2P5blFivSAZrwQnKd5iBgWykiYDMImiZmZMQNn6XalLdnuq/AZZhIoBubVCcppDo9gv+V9rUL0lekey8iZ3evgzvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T5lForn6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03DB5C4CEDF;
	Tue, 21 Jan 2025 15:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737471938;
	bh=kNFxYizM37kG8z6naKIAqKCxTqkMAMEKBrRtctaLWlE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=T5lForn6aNiNClKRYFyDVjBi9ScSKjv7MpR5FvT4LmBoMl+ubMOrpen+iwaodLYYv
	 0SWZjXJRC+tg5P71YktP1n1t6m6PdilPZ4cW5RXdcio/dSzogNu5BLRnhZW85qE69Q
	 ZElhNOOnl00/6UJG1K20vHJYrKw+oZsr105LZ7Kiy60gs3IDd8igZe5swVx7jxBlxp
	 /0BL/uzzJLZf32cmha7YmSzGK1g9jmj7oc1DtZ8wRVCJHF4Wt5bH0KVgYVCOOhS30r
	 zw0UBFHzgJGueAVA3gcRTxAQT5lZNS1/e0UQNRWosHr08aa3YuO9W9HTvCu12VFmof
	 qz+7zp+A5z77w==
From: Mark Brown <broonie@kernel.org>
To: Purushothama Siddaiah <psiddaiah@mvista.com>, 
 Corey Minyard <cminyard@mvista.com>, Lars Pedersen <lapeddk@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250117-spi-fix-omap2-optional-v1-1-e77d4ac6db6e@kernel.org>
References: <20250117-spi-fix-omap2-optional-v1-1-e77d4ac6db6e@kernel.org>
Subject: Re: [PATCH] spi: omap2-mcspi: Correctly handle
 devm_clk_get_optional() errors
Message-Id: <173747193673.38422.16913567747416591096.b4-ty@kernel.org>
Date: Tue, 21 Jan 2025 15:05:36 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Fri, 17 Jan 2025 16:16:03 +0000, Mark Brown wrote:
> devm_clk_get_optional() returns NULL for missing clocks and a PTR_ERR()
> if there is a clock but we fail to get it, but currently we only handle
> the latter case and do so as though the clock was missing.  If we get an
> error back we should handle that as an error since the clock exists but
> we failed to get it, if we get NULL then the clock doesn't exist and we
> should handle that.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: omap2-mcspi: Correctly handle devm_clk_get_optional() errors
      commit: a07eb4f67ed085f32002a1af2b6073546d67de3f

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


