Return-Path: <linux-spi+bounces-8312-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1D3AC4F6E
	for <lists+linux-spi@lfdr.de>; Tue, 27 May 2025 15:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E043ACF9E
	for <lists+linux-spi@lfdr.de>; Tue, 27 May 2025 13:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B961EF09D;
	Tue, 27 May 2025 13:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIFMql/g"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D26B3FC7;
	Tue, 27 May 2025 13:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748351741; cv=none; b=N6lJPgkWLNgbdv1MiocylprDmVDuIGKYreAGC6w2UpPhCoA+5Dg5Aa0n6hfe+L+w3Q3hTDB6jh4Us/Q7F6MmAdyE0hYwbXWaOn317YzNKb9YBV6nbb/yCmvSIw7DGbEYq3aJYQhxhPbTZ9BHsx90xL4ixcJtceNG537KBLAwCi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748351741; c=relaxed/simple;
	bh=8yEeMcJRVwvHJkTGeiaTnqVQDZ5fVN9j2K8jAscVqmU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cu+29vHjPZ3rWku2oVeP5w7/cawPIKRYVjbkSjT7ct0IKPmYVYDb1qqOVokzEDfdWKJEm+FAumXAxtMNCGdv8qM0sLdJu3N4HyVXv4Ix0Yrp6bMWRNrX0Y0UuHNb2rLrfHxWSBiob/tHGm7BoFnzDkZ7bjGfNwSxy88UPRVwPgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIFMql/g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7105C4CEE9;
	Tue, 27 May 2025 13:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748351740;
	bh=8yEeMcJRVwvHJkTGeiaTnqVQDZ5fVN9j2K8jAscVqmU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=HIFMql/gFUUkSVav+KN8QcICDua4bXdvQwBexm8IU0QsHEdCNsrm2X8nLJn5LnOzX
	 E8P7u1D3NjzUCwS/Q1rowwyj6fvQCW0S6Lq8yPCAnb3u6gf8CF2O4MnHRvmxC7ItUK
	 gQCHGNezt6/bybvobgo2xGLM7+7AnhHcpstjb/QqaigpzrebtDf+uUroxe1wnPQn4H
	 XYGzwf6WBrIGJ+3xAAKYBsG8qw6RuPqS0UQ/3cWz++ZUjJ9oSM2RnraWP9ZOQNbZBc
	 kz9Ca7GG706vnerud0ONPLjWbjZGiY676A1yAUTGSox+c78YqbGY/m6Vh4zHoHeU1r
	 2PPMqv9HsnmAQ==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: UNGLinuxDriver@microchip.com
In-Reply-To: <20250527103244.26861-1-thangaraj.s@microchip.com>
References: <20250527103244.26861-1-thangaraj.s@microchip.com>
Subject: Re: [PATCH v1 for-next] spi: spi-pci1xxxx: Fix Probe failure with
 Dual SPI instance with INTx interrupts
Message-Id: <174835173941.43742.10482177523404609545.b4-ty@kernel.org>
Date: Tue, 27 May 2025 14:15:39 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Tue, 27 May 2025 16:02:44 +0530, Thangaraj Samynathan wrote:
> Fixes a probe failure that occurs when dual SPI controllers are
> enabled and INTx interrupts are used. Reduces the minimum required
> number of interrupt vectors to 1 and registers a shared ISR when
> the allocated vectors are fewer than the number of controllers.
> This change ensures that the probe succeeds even with limited
> vectors, restoring INTx functionality when multiple SPI
> controllers are present.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spi-pci1xxxx: Fix Probe failure with Dual SPI instance with INTx interrupts
      commit: b4608e944177531334a79f3df2cd14275b47808c

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


