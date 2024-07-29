Return-Path: <linux-spi+bounces-4059-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 479F593F9BC
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 17:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2E7E283442
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 15:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CE316F278;
	Mon, 29 Jul 2024 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5YC4LwO"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F3B15B541;
	Mon, 29 Jul 2024 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267608; cv=none; b=gs1AaD69CvEuMpztmklLkGaB3qKIWbpVs2sshXZXAMk1dMETcGUqIitC3Fj5HlPom/mBVuYeongFJJ7/8x+6+bSZSDuY4wqH2nMjZQY2rMHCvsbheHFlP85Kry9jVZroeeN+Y+qr2HNR6pI0LeizIXUXmtxDFGWfIUtdD7daIOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267608; c=relaxed/simple;
	bh=tRHpiJTBAYvyQSKn6PwVqSNlt1TDoBJplMdq03PMhts=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nUjGZI4+d1Gl4lel/FsCN8b4lYCboNPIzbcUq1AxWc9RXJaUOXy2I5CiRGUCdaaHd+03CVNzD17jdOM7nBju4GUGmi3dvA29DG5ywbDYDezqevjN921g8IjavGUMK29YKFPJqNgu/scX0qd/1ZCknlZEBRj2JW9tG4PSY7/lFTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5YC4LwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391CAC4AF16;
	Mon, 29 Jul 2024 15:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722267607;
	bh=tRHpiJTBAYvyQSKn6PwVqSNlt1TDoBJplMdq03PMhts=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=k5YC4LwOllaPsVDAUS5T7CWlc+pUAWBsXAwWYYe6T+WYEy5Bgc4YreJrCqlZpW1XW
	 LyxTEzme8MxxtH2wTNNSVU8mHkdNYJR4cOLJsmbdaxByHD0WRpW6pRI+gaLx4shxg0
	 n/IA5ldGalLrgHmmxaZ4N9v5xx5P5OTUnUMbYD9MoXZSQIc6+NHPSPfZM8pg98CTRu
	 dppncacZx0fVU5pVagqBH9TL6jSaCXr9jtmhz5R/5/hgXABVcUfOk4TlAp4dc/jxLI
	 MAyjNOaWGfGOT2CgGwPxsdqnBI6nxRn3q/J3bKQR/sQwZLmRvjs7ufPPL/eprInKYv
	 N8tvUH4fgYQWA==
From: Mark Brown <broonie@kernel.org>
To: jwboyer@linux.vnet.ibm.com, weo@reccoware.de, sfalco@harris.com, 
 sr@denx.de, dbrownell@users.sourceforge.net, Ma Ke <make24@iscas.ac.cn>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240724084047.1506084-1-make24@iscas.ac.cn>
References: <20240724084047.1506084-1-make24@iscas.ac.cn>
Subject: Re: [PATCH v4] spi: ppc4xx: handle irq_of_parse_and_map() errors
Message-Id: <172226760595.71144.13510323599368678305.b4-ty@kernel.org>
Date: Mon, 29 Jul 2024 16:40:05 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Wed, 24 Jul 2024 16:40:47 +0800, Ma Ke wrote:
> Zero and negative number is not a valid IRQ for in-kernel code and the
> irq_of_parse_and_map() function returns zero on error.  So this check for
> valid IRQs should only accept values > 0.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: ppc4xx: handle irq_of_parse_and_map() errors
      commit: 0f245463b01ea254ae90e1d0389e90b0e7d8dc75

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


