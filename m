Return-Path: <linux-spi+bounces-6242-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0807A03E68
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2025 12:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705743A4F3A
	for <lists+linux-spi@lfdr.de>; Tue,  7 Jan 2025 11:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B271EF09B;
	Tue,  7 Jan 2025 11:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZuPGrj1r"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D101EBA08;
	Tue,  7 Jan 2025 11:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251109; cv=none; b=bFFZjqdcpM9FVZJd/bganyB0BZJYe3HAzN0ihEiGzhLIw0bThH8jQhVKjOkDTWLxGK0plQuvcY35mevvcODfGkUPMgMblpxHE4E7eIdU9434hHGELcNEz49iEnmW+oeodralcUC5hmfGPRyy8XWyHQfsOETSQ87al/s/jZFFLSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251109; c=relaxed/simple;
	bh=95m0Js+/SbOtxK/VEzd6QhOdHqIwTJTJuHB/Mtrclac=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V95LYlB/c9jrUhIV9Mc55yLGkyVxcGruzICF7y7oEyLxyhtpF7ZH34g3YG18OUE2yqc0iJAQvXwrYFMFokN8V+zfFufk4aQJ4gaUHBv/40jkSN4+IHQvkNr2gofffl80bhPfXfH1cNlfBJ2Lup5MkSwrgLw/U3+KIos1RP/UWFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZuPGrj1r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DEEC4CEE1;
	Tue,  7 Jan 2025 11:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736251107;
	bh=95m0Js+/SbOtxK/VEzd6QhOdHqIwTJTJuHB/Mtrclac=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZuPGrj1ryUqiO+kBP+STztuzo+7NDEEUI9SffeRaV9lodNq6AvuPKQjuQ6ywD3GoP
	 d9xqxMlwv3Quy2PKydWQOG0LIIty/wr/0Il4If3Vf633pEWyEglw2C+PokZq77lQvq
	 JFtuLbcfueiAMtNTbKMXdhrrr8YcrmHpOY3PR6hdjOos9qfEIAGtMd0Zkoms1bjaRq
	 aTZGL46CQ/3KpT0Ix4JGcjcdcdXriFYWL/j/5ZHnwcE1V8GK8g7RRDlTnVjkgpD5Qu
	 VrkjQZ60t5P9DC9GatLAWmdjJ8Yp6eGW3afSd92HscqJU9sA15I/7M0flPYptJejjt
	 gsuL9RDFdzhpw==
From: Mark Brown <broonie@kernel.org>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 vigneshr@ti.com, p-mantena@ti.com
In-Reply-To: <20250102120544.1407152-1-s-k6@ti.com>
References: <20250102120544.1407152-1-s-k6@ti.com>
Subject: Re: [PATCH] spi: cadence-quadspi: Enable SPI_TX_QUAD
Message-Id: <173625110592.23847.8509380937687845374.b4-ty@kernel.org>
Date: Tue, 07 Jan 2025 11:58:25 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Thu, 02 Jan 2025 17:35:44 +0530, Santhosh Kumar K wrote:
> Enable the SPI_TX_QUAD mode bit in the host->mode_bits to support
> data transmission over four lines to improve the performance.
> 
> Tested the functionality on AM62Lx EVM (W25N01JW) in 1S-4S-4S mode.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cadence-quadspi: Enable SPI_TX_QUAD
      commit: 1e293574c6f5d5d87acd7d64415eae055d0672e7

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


