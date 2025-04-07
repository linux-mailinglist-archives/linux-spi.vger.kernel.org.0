Return-Path: <linux-spi+bounces-7437-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55991A7E651
	for <lists+linux-spi@lfdr.de>; Mon,  7 Apr 2025 18:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55589189BFD0
	for <lists+linux-spi@lfdr.de>; Mon,  7 Apr 2025 16:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC54520CCF3;
	Mon,  7 Apr 2025 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtbHGJ6v"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A5B2080C7;
	Mon,  7 Apr 2025 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042548; cv=none; b=kwr9Uv0ydbMh1K2t3Uz5FKq5z40wK6ZOEBTrK8uR70u1oaeLYN+RJimTFEfnVKRW5PeyxB+bqdOcmWX6uq01aL1hk7kp3JGhYFVVjs66WGMtAesJcWxXlJYkY5zmieALhwVRVz4SqOF64tSmM/GGRdnWTqvXkgjSaB0Z/Pipo7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042548; c=relaxed/simple;
	bh=jombHbNVEOCAWGip74Dnz/uQIXJRv6AQc4zOVPtINCQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LnGwTNwVztBdGa8p3mo3eDtwIzUk47h4lps2Lrdm8ujO+gUk1MA84gyRcIrdETfaH/NZoWaLORlPiBD4ZKdnFABUpVoOoOwZI9Xgym1ypkMhZkmuuYziLrmSsF1vS7AwtjQNw5fn7iZJCGGUXKZoE6N0GSaJwrg3c2+0eysarFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtbHGJ6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D3FC4CEEC;
	Mon,  7 Apr 2025 16:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744042548;
	bh=jombHbNVEOCAWGip74Dnz/uQIXJRv6AQc4zOVPtINCQ=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=CtbHGJ6vATer0WOXT2bbjoxtVaTDd4OueRoFdb0Tfzt0px2a446r0eSyCbxgDz2EL
	 CqupXYOCwb/05CspNLE9ShUTWC5gf0sAotfAxDt5p2N75u/kgwY/ANP2XGhed0/ZcR
	 qnzjSjDZFjIL10Q1MtS3pdqFT2GDog7wgL0BwitJbilZwq3lig16Ge1iBO+UxQ/KfS
	 YI+D0yfSDBkKyTDV5mqKaXslMv8qi50N+qjXhlvYN5PgTo10WlN/n0AJoB0zTBXoZd
	 3HyX4lG3xnEq9ruNOCAiZ7E6NfAchXtZlZm1+j0qTiudu++CbAjwdRNbtM88Heq6J2
	 v3Wz5DJ/JuyAA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250331103609.4160281-1-andriy.shevchenko@linux.intel.com>
References: <20250331103609.4160281-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] spi: Group CS related fields in struct
 spi_device
Message-Id: <174404254713.780717.12583188125245773601.b4-ty@kernel.org>
Date: Mon, 07 Apr 2025 17:15:47 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Mon, 31 Mar 2025 13:35:59 +0300, Andy Shevchenko wrote:
> The CS related fields are sparse in the struct spi_device. Group them.
> While at it, fix the comment style of cs_index_mask.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Group CS related fields in struct spi_device
      commit: dd8a9807fa03666bff52cb28472fb227eaac36c9

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


