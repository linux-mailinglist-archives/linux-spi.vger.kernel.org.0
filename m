Return-Path: <linux-spi+bounces-5833-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BCB9D87A7
	for <lists+linux-spi@lfdr.de>; Mon, 25 Nov 2024 15:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D55E168B12
	for <lists+linux-spi@lfdr.de>; Mon, 25 Nov 2024 14:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E90D1B3944;
	Mon, 25 Nov 2024 14:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqNN12an"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CAF1B3943;
	Mon, 25 Nov 2024 14:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543957; cv=none; b=bXJ97V4/F3Pednfb2TzzUT9m1t4k4G3Ektok7lnJsHkNmXTCpuWPWYHePUOq9x+Ms09HTz4IwvTVmU5HkFPI78RKVoyFc2gathZQEsfHUGjqpsa7hoYzkfvbav1Z8v1CMX2+LmsFzwSgnbXpk6kK2UeHZDZFSvKvIHXkL1m9E1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543957; c=relaxed/simple;
	bh=7GrKwdo+Ze02RMQOa0MhC0RENsxkBytNYFyBKpaDBzw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sn/AA+fX9u9uEks1QeqTDaJtHL2zAhmuqwsdeGgBOvGZd9qQ2SlxmJV+TrLNhPZI/pkaL8+cnPNVS3+N0vy6fzrJ7FuHEs5Qnmzv3mFtmeIBJV/qDpCQsuYXlaYi4P2/tYBeg4cA4k67I3wQCwrAibBqp+Z7PgD/H38XHJIi9xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqNN12an; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370F8C4CECE;
	Mon, 25 Nov 2024 14:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543957;
	bh=7GrKwdo+Ze02RMQOa0MhC0RENsxkBytNYFyBKpaDBzw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YqNN12anDTPC/J9xLvoC8O2JGI/txSR+lJGBk6Z8ijAnbaFajvSShjObNisz6U+pZ
	 pX+xn5ApwfQql496eArXVDVlFSnu8Z2LBa52RwR1dBgF2IzIxCrETR9HYZy1yQZeec
	 wbLQyab3nqsPTVO667W3HC0a3pOlFIyl0E6RJU84vyqYICqTOztq1FRjzUO8Tvz/6Z
	 YL/y5LDbBxhmbAEU1clHwm+g2zi70YZH+ENE8J/YnOqrvu67+ZvRxKMQB2nz+MFXO5
	 1NDFX+qhN4QbConZYck+ubB+fgOBC7UopooUB1QoUvH8DIN3v5wswEye4P6QN5olJN
	 jUR0thFQ9RrbQ==
From: Mark Brown <broonie@kernel.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, linux-spi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Cs=C3=B3k=C3=A1s=2C_Bence?= <csokas.bence@prolan.hu>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20241122141302.2599636-1-csokas.bence@prolan.hu>
References: <20241122141302.2599636-1-csokas.bence@prolan.hu>
Subject: Re: [PATCH] spi: atmel-quadspi: Fix register name in verbose
 logging function
Message-Id: <173254395595.42978.234561624552571601.b4-ty@kernel.org>
Date: Mon, 25 Nov 2024 14:12:35 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-9b746

On Fri, 22 Nov 2024 15:13:02 +0100, Csókás, Bence wrote:
> `atmel_qspi_reg_name()` is used for pretty-printing register offsets
> for verbose logging of register accesses. However, due to a typo
> (likely a copy-paste error), QSPI_RD's offset prnts as "MR", the
> name of the previous register. Fix this typo.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: atmel-quadspi: Fix register name in verbose logging function
      commit: 1c6f3eb4f394d8bb14b2b677151c347a0db088eb

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


