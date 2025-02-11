Return-Path: <linux-spi+bounces-6767-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ED1A314C7
	for <lists+linux-spi@lfdr.de>; Tue, 11 Feb 2025 20:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F3403A3CE1
	for <lists+linux-spi@lfdr.de>; Tue, 11 Feb 2025 19:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FF9262D33;
	Tue, 11 Feb 2025 19:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgYfy6en"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C905C2638B5;
	Tue, 11 Feb 2025 19:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739301234; cv=none; b=TLRxK1P6PbDfYPb1z7kLjNE1uvyf3SwV5dsp1KTFQZFv3RpO3/llkKMW322F3f3pZ5mlwN74jhyGg/fSNSVDfdIZeVlsvOy6qu63mwxC5imP1mgblU5ng5Fno6IWTM5bxP1uUUekc/UXeUjsUAlRH9r0av72RONDltISuzXVmSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739301234; c=relaxed/simple;
	bh=FrEJd9jXepdUuhDPmxH5Vj3+n9U4/VIxGBQQAZktwuQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mTnfQsxSFYiUD2aX/tLP4hiFb8SpPxM4L/s1FzVvlOk4lHVNF4JLhZQ6MRLHhSx7/Xc4L+KuPiRrKtuecVBt0IlKQN69xZP7tpww3iXZWFOBGTUuCsAjDkELhCdWbFH9sWr08y8ZV8RHoRWQoWGZngX9aG6NTTXUxW+RrwkpIBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgYfy6en; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882F4C4CEE4;
	Tue, 11 Feb 2025 19:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739301234;
	bh=FrEJd9jXepdUuhDPmxH5Vj3+n9U4/VIxGBQQAZktwuQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kgYfy6encDJA2aRUzq86NpQw/4OFXh9ciIzDH1ManFoPdJaXAt6dE3REa13eS28zR
	 RCl6j5CvpDa0s0EjWaPcABbBQZ/JaCql/UOsk1NxXVgNwxiSqffcAtBewrlyL3WY3g
	 xgZ330FPAc6jj7D6FvppYAXYVhRPgCKvyebI9q59B55/KB51E2rn767JLrc36GGlke
	 aoA9+89/O2M9O2Vas8j067Hd1MHULNk6r7tN67jvIV6EBRYlfW6sRE2bMUHHhyBiRY
	 Zci2NIsAqsGzghYbxlJnIoHUhhs8mUHHGHyWo1A71UoYzwJ9Wtq9v1os6fwMuaJgsx
	 LxTBbOxvJmpqg==
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
In-Reply-To: <20250210-spi-offload-extra-headers-v1-0-0f3356362254@baylibre.com>
References: <20250210-spi-offload-extra-headers-v1-0-0f3356362254@baylibre.com>
Subject: Re: [PATCH 0/2] spi: offload: extra headers
Message-Id: <173930123330.78619.3960614397215392494.b4-ty@kernel.org>
Date: Tue, 11 Feb 2025 19:13:53 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Mon, 10 Feb 2025 17:16:13 -0600, David Lechner wrote:
> Following up from some late feedback, a couple patches adding extra
> headers to a few SPI offload files.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: offload: types: include linux/bits.h
      commit: fcd7ace9a725ae034ff9f24cb94c9fe12a1f02da
[2/2] spi: spi-offload-trigger-pwm: add extra headers
      commit: ff4d4158ef9143327a42f7be4298751cb0d1be69

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


