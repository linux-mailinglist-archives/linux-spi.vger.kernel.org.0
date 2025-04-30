Return-Path: <linux-spi+bounces-7807-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B15AA5859
	for <lists+linux-spi@lfdr.de>; Thu,  1 May 2025 00:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 939443A551F
	for <lists+linux-spi@lfdr.de>; Wed, 30 Apr 2025 22:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34EB23183D;
	Wed, 30 Apr 2025 22:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kx++A0bM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB55A23183A;
	Wed, 30 Apr 2025 22:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746053532; cv=none; b=ZsKcDCm7kxke7CNSG1/9QVi30Q01Hy2SVJ1nTo5C/cAirvjSkcPm9qKSwu52MLEnFCQQ4nSYJ9HkY+8hkJU/2pn2zvGRXLRXnshyUJJoZY8bBW/TVQQIldZKXA/JsGoAUKcbLjPiWHgEQlxuqnxsRrrI5srroGXf+Ycwt3HHbpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746053532; c=relaxed/simple;
	bh=/uzG+0J1HnGhNby4Om5wzthNiZIMfHMbWZZ5tRCOTB4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fT9ZG1vR1jNW21C/Yp206bsrFG4nYdYQE1KfZx7B7pYgdoXsDpd9+BUnuGEVNr+20Irs7xfwOuCYArxqyTMwPkcV57PLxZ0Mk94NC2SgJUsIkix6EHWBAy8/NnrDO4JBfrzK7Pi2Svb1HBqYq7UtYv2/qmpnLGQggZmAv6U6MkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kx++A0bM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A094C4CEED;
	Wed, 30 Apr 2025 22:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746053532;
	bh=/uzG+0J1HnGhNby4Om5wzthNiZIMfHMbWZZ5tRCOTB4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kx++A0bMp7gAM6ju2u/JEMU3HBD5tNVyp+MMhAgduE0m+pXLh+0JjY4rRAqe02j0e
	 Y8el2A7TmjkJpk6Cd5IcHHFTVzi2uv73oS9cPNehwxqdBKEZgVWDNzZPDQmTcCVNRR
	 vNvSH8FDMhTqJi4D8OhS074r43f06Hqot5SuLbQF9zVvlAe26lYO01+ux6LQbqTqbW
	 AvEhXSBhNLbWTS5aYpUNXlKxqR9RhWg3agUYpi5AqLD0OsupVwoYCwSTL47bsBWQai
	 Rs7fcw21QxdNiGeTUoV2PqEmFU697WmxHUJfpsxMHlrsdeWi/Mov3q0nLwpSBy4H73
	 nrnOyWYUxpX9g==
From: Mark Brown <broonie@kernel.org>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250428-adi-main-v1-0-4b8a1b88a212@baylibre.com>
References: <20250428-adi-main-v1-0-4b8a1b88a212@baylibre.com>
Subject: Re: [PATCH 0/4] spi: axi-spi-engine: offload instruction
 optimization
Message-Id: <174605353016.3987999.5121261741483294102.b4-ty@kernel.org>
Date: Thu, 01 May 2025 07:52:10 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Mon, 28 Apr 2025 15:58:55 -0500, David Lechner wrote:
> In order to achieve a 4 MSPS rate on a 16-bit ADC with a 80 MHz SCLK
> using the SPI offload feature of the AXI SPI Engine, we need to shave
> off some time that is spent executing unnecessary instructions. There
> are a few one-time setup instructions that can be moved so that they
> execute only once when the SPI offload trigger is enabled rather than
> repeating each time the offload is triggered. Additionally, a recent
> change to the IP block allows dropping the SYNC instruction completely.
> With these changes, we are left with only the 3 instructions that are
> needed to to assert CS, transfer the data, and deassert CS. This makes
> 3 + 16 * 12.5 ns = 237.5 ns < 250 ns which is comfortably within the
> available time period.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/4] spi: axi-spi-engine: wait for completion in setup
      commit: 1d0ee0c9df31c9fd1e4f8d7e2464e36fbf6e3f75
[2/4] spi: axi-spi-engine: don't repeat mode config for offload
      commit: 8fc13b822c74a46587c0d8aae4ea0820b6bdb933
[3/4] spi: axi-spi-engine: optimize bits_per_word for offload
      commit: 087591c9e4fde86fe2971c34a2745c208103248e
[4/4] spi: axi-spi-engine: omit SYNC from offload instructions
      commit: e6702c44c2adb28b62f81de498e9b1e4562ce660

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


