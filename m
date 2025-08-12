Return-Path: <linux-spi+bounces-9367-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFBEB22555
	for <lists+linux-spi@lfdr.de>; Tue, 12 Aug 2025 13:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24ACE169B01
	for <lists+linux-spi@lfdr.de>; Tue, 12 Aug 2025 11:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813CE2ED161;
	Tue, 12 Aug 2025 11:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4PDUbYy"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F562ECE85;
	Tue, 12 Aug 2025 11:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754996749; cv=none; b=H6oKDbxlwpZu6f5ighdJG26cIa5Bpww/2ryZsZacrnUbYfKngo6bvzJx9Nzhr8BhqI8goHLNfUXCGU7S64fgEHYf52xL+7++YDKmLesDiSXJzieUGp7eO+TZrBcIympwCnPh0l40HrNMbf08a2BjrhSJ3O3IwkdwJi8mj0IcW2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754996749; c=relaxed/simple;
	bh=g20C9K2TQXmv2/dkv5R+EPa+NT4O7i13vNHQ2DfdRqY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nihCqrl67FPTkP24kCm1HQ5u5P1ZVpv3hIAta/B3GYLPI/IfxCP3qFBOUlUSSACHtc7G6+6FSs2eU8pSOmYSZCN4emuy9Su+fqh5DDosHmvvCAy9KS5D/luV+thIi06M5JwwcgGEz2I93Vb7yTO8Sb7ZI9sOfXyibONJqK8xU20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4PDUbYy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8C9C4CEF0;
	Tue, 12 Aug 2025 11:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754996748;
	bh=g20C9K2TQXmv2/dkv5R+EPa+NT4O7i13vNHQ2DfdRqY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=L4PDUbYyXCZaP+y0X41IB6O+a9n+mRG7EXoDivcQK+cyshetoV7W8ljhfg3N8y6Cq
	 bXLm+iBCCdFhjZV+iw9NAdz4vFd5lEvUIAVz8D5mp3AHUgWbukbgcpbvTGqYSWKMLx
	 4nmx40qbFh7FpVrEAaxEcyrgmkeMLm4Ct8EH/BPAHXGK4VbWn4F9DlJ1ozKwBjiLLg
	 DLavmjcazUmFT2K+IYBPlcSPJYHKq2FcSUIlnznTaEjoFAdixm6jhzKCnT7niPPWnO
	 52LWhHuh+d/pyg4UHIay7+ppvbLTqf0dpyPaMAC4Iwhu4MLGlk55tbEpima8hEuREx
	 vBJobPfiAJHwA==
From: Mark Brown <broonie@kernel.org>
To: lhjeff911@gmail.com, "Darshan R." <rathod.darshan.0896@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250728124104.6370-1-rathod.darshan.0896@gmail.com>
References: <20250728124104.6370-1-rathod.darshan.0896@gmail.com>
Subject: Re: [PATCH] spi: sunplus: sp7021: Clean up coding style
Message-Id: <175499674777.16293.15470606723953307689.b4-ty@kernel.org>
Date: Tue, 12 Aug 2025 12:05:47 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Mon, 28 Jul 2025 12:41:04 +0000, Darshan R. wrote:
> This patch tidies up minor coding style deviations within the Sunplus SP7021 SPI driver, ensuring closer adherence to established kernel coding guidelines.
> 
> Specifically, it addresses:
> - Correction of a whitespace inconsistency before a comma in `writel()` calls.
> - Alignment of function parameter indentation for `struct spi_transfer *xfer` in `sp7021_spi_host_transfer_one()` and `sp7021_spi_target_transfer_one()`.
> 
> While purely cosmetic, these adjustments contribute to improved code readability and maintainability, making future development and review easier.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: sunplus: sp7021: Clean up coding style
      commit: f1ac30a862cc5d53392d59f42b513e79948acb18

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


