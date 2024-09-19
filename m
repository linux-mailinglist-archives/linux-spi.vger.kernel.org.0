Return-Path: <linux-spi+bounces-4886-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A8297CA8A
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 15:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50F81B2393F
	for <lists+linux-spi@lfdr.de>; Thu, 19 Sep 2024 13:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC94319E7E2;
	Thu, 19 Sep 2024 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uF08ndPh"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CA71CA9E
	for <linux-spi@vger.kernel.org>; Thu, 19 Sep 2024 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726754115; cv=none; b=oJC4OXj7THpOgAwiSgI9NVPksdgWlmUNKVeceVHriB1KysIf6RAODfh2yUs21226k1I/sUaU8ITF26Z+yvfW8v19vGrlRrRkX3qlLQ71tAmdLAF7m16MxFW5i/4h0jllm0+GLIL3T7pXj3iStoSfpV7cyMIu+uI89JD8xmCaeQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726754115; c=relaxed/simple;
	bh=12FkVePwYkhQZMCvsXixIY8FJeZ1hRWqQFXOPgw4dqY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N8DdI5EoNDdcmU2H73jPi+I5PN3EmLY1QyoXJd/enIlvsZRFBv0eoCCNTgiU6Af1lZlHRT7OwUeTCqsZBEh7F//aj8PhqwBqAO9S/WB9MpF7YjxSTIKOjRrQPDn+ZwqGC6wUE7MSgo7aLfChTmTfqSuSoYMKnnqw4seuIq/nVg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uF08ndPh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C068C4CEC4;
	Thu, 19 Sep 2024 13:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726754115;
	bh=12FkVePwYkhQZMCvsXixIY8FJeZ1hRWqQFXOPgw4dqY=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=uF08ndPhhOVE/3Nu61yA1wiPHZPrnLGeVo95vQ1HdeiN0/xYaCal5qSfuNuvgLGBd
	 F0I07CKoblSSSz/JtjyPFRZkc8DEEQky2VCW0ZOnz0Giwlg/yGlKMvaq2BkLI1Rmbv
	 bZjprfik7zOdKIArVWTNznJN80Bs2gSXfZvxl9oAL9NxoiI3Tzm2jZc7SEpG+F2foL
	 4koJSbSNsDre6LoIxWLGfFkBvBA3mcMThIRqIwXXyFwSAWgnrNr8c9mgG/pEgfo3te
	 Vy3kwlEOcCmPMeqsjrO+t1ZtJt3DqAH+IIaaYtK1Pl3WelhTGXQcOgxVxKn1Xmgzc/
	 ku2tpA5lz9lZQ==
From: Mark Brown <broonie@kernel.org>
To: nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
 claudiu.beznea@tuxon.dev, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20240906023956.1004440-1-ruanjinjie@huawei.com>
References: <20240906023956.1004440-1-ruanjinjie@huawei.com>
Subject: Re: [PATCH] spi: atmel-quadspi: Undo runtime PM changes at driver
 exit time
Message-Id: <172675411275.1834907.15825578250725045673.b4-ty@kernel.org>
Date: Thu, 19 Sep 2024 15:55:12 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Fri, 06 Sep 2024 10:39:56 +0800, Jinjie Ruan wrote:
> It's important to undo pm_runtime_use_autosuspend() with
> pm_runtime_dont_use_autosuspend() at driver exit time unless driver
> initially enabled pm_runtime with devm_pm_runtime_enable()
> (which handles it for you).
> 
> Hence, call pm_runtime_dont_use_autosuspend() at driver exit time
> to fix it.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: atmel-quadspi: Undo runtime PM changes at driver exit time
      commit: 438efb23f9581659495b85f1f6c7d5946200660c

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


