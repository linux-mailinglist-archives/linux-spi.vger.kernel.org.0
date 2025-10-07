Return-Path: <linux-spi+bounces-10447-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E340BBC23BA
	for <lists+linux-spi@lfdr.de>; Tue, 07 Oct 2025 19:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52CE83AF72D
	for <lists+linux-spi@lfdr.de>; Tue,  7 Oct 2025 17:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728742E8B9D;
	Tue,  7 Oct 2025 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaI846wV"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491A84A00;
	Tue,  7 Oct 2025 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759857347; cv=none; b=qanrb8fdGgvuGUVIU0/MKmilt2TP/8kbkqUxxRXfNGIrSd/m0TkRB9MLeN8XHfDn6LjG8S5qq85GKoZKC9JAHFqK4YZluFpRG1aIS7AK/L0Gd6EfYafIbdhjfm2v1NuHQQck/0/EiZv+k4ONro5ixKcd0x9Ic1oIAtbMST4l/5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759857347; c=relaxed/simple;
	bh=54VUXJsr40swzFiGW3a+jio0HtAuQrX253kYi7YZvrg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sSOUh+gS/p2l2TScEa2dK8ONpsYhedz6SMw5K5TJXG/sidzD9hHApKCBVWyVqD7ELCyzr/pNP9cH3I9O47prZ0qQglpJwYccpk1quI2kUQ9a0LTQO65Rc4R6Zdrpgv/ga97RzFNoXBfH+EjH5kTmIsjCnK6IfSCLHg9EPuPceZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaI846wV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB69DC4CEF1;
	Tue,  7 Oct 2025 17:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759857346;
	bh=54VUXJsr40swzFiGW3a+jio0HtAuQrX253kYi7YZvrg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=FaI846wVIKWvWcjhUDwJ+v1moKAYYWxB0ZEwKqV2OVH9Zy7cDbehgZYz9syprqp0r
	 HghhwncKvffnQ9UhOSJsnAblg31xsVXdfQpheDoIWqn1J8EqIgXMvjTJuX9OnWRmCA
	 f7PjLGMAQcXQHIp1H8epyNSdp16c8xvRG0wQa/fP8YxSeqtwU80LfIBaq/90Dxt0vM
	 SBPGt6smMfxYBLGWuS9gaRVvRugThniUg2ph7Khr1DFpKBQtDZuaq2ahji5z7Zj+cK
	 a0qm5QK+bqfGvBDjLDD6uGvm8ZycuGBl2YKjpvj+TGPW0QDi7Qmo3HLb2qr6DKFDTC
	 1nKPLxT9jcf4g==
From: Mark Brown <broonie@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Artem Shimko <a.shimko.dev@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251007101134.1912895-1-a.shimko.dev@gmail.com>
References: <20251007101134.1912895-1-a.shimko.dev@gmail.com>
Subject: Re: [PATCH] spi: dw-mmio: add error handling for
 reset_control_deassert()
Message-Id: <175985734568.150481.3995901649294833020.b4-ty@kernel.org>
Date: Tue, 07 Oct 2025 18:15:45 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Tue, 07 Oct 2025 13:11:33 +0300, Artem Shimko wrote:
> Currently reset_control_deassert() is called without checking its
> return value. This can lead to silent failures when reset deassertion
> fails.
> 
> Add proper error handling to:
> 1. Check the return value of reset_control_deassert()
> 2. Return the error to the caller
> 3. Provide meaningful error message using dev_err_probe()
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dw-mmio: add error handling for reset_control_deassert()
      commit: 18a5f1af596e6ba22cd40ada449063041f3ce6d4

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


