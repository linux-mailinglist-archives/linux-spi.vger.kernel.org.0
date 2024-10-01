Return-Path: <linux-spi+bounces-5079-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2882298C4C3
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2024 19:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A79D1C2236C
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2024 17:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD2A1C242E;
	Tue,  1 Oct 2024 17:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lH4Uc6bR"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B641A18E02D;
	Tue,  1 Oct 2024 17:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727804795; cv=none; b=Ui6x7B7hv9tqT4blzNml4lWwlU4jCq20Sk5fN/khQ8Lu6uPxaSxU0MHpo9fqhAaJuqvYMlGxfujf7nDrKomvHOMq86DdP5jVtr+bjDqGhdfrfumi02xGkjvMzV5pP1sFXKxEmwqRBqfTqYQ4Ar9XB/47/tcUaPe/srkAMG2jcTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727804795; c=relaxed/simple;
	bh=0ls6ZbdepPVe0HnUrUsV6vDz/po+cPzS1DmD58fPBMY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LiA3GTr2yZ4Qy8YO86BEqPO+o+87eCGeZh5VHS1SDl/T1P0Hist8uJgE0DQ5HcqwtX0DhkF6b0/Yri6GSrPsqHxjLg2xUh3D5Eq/67ZusyBR4YMPKwswxaOs7d8vw2UWjQiMu8LLifm5v4YcA+MqR3/87wPsxQcDbw1CpTQbrZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lH4Uc6bR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC87EC4CEC6;
	Tue,  1 Oct 2024 17:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727804795;
	bh=0ls6ZbdepPVe0HnUrUsV6vDz/po+cPzS1DmD58fPBMY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lH4Uc6bRXb0uMdhDVB4LlevGEBgzJ/+wqKtsQK/HB1MyhPq585tgSE9q6zoHiPX+e
	 XCzlxvz9m6J7aBtn1y9GrCnJ3KKbKl/F+2BebzZqUNfhK3wY+7KRV52xVuVgrk7kM4
	 gfvAJJ59vzJbr8nSbEWI0IPojAug+rWdr6IBztanLn3YchZBNuYvhhYvB/hc6C9JAE
	 v/jZKvuCw9hjTfq4YVLUsGewb63Y38j22YkC0nU7RSU4YpZLRI4r9bxnqTgXWx5Z/2
	 jzdYnD8xUteEq5zN+hIE9BBcDbFKzN55OnF1KO2lK/O/JSmLEHlnoDhtF1mT0Nn7Yr
	 FyD1lT+J1M2cg==
From: Mark Brown <broonie@kernel.org>
To: Carlos Song <carlos.song@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Shawn Guo <shawnguo@kernel.org>, 
 Stefan Wahren <wahrenst@gmx.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 "imx @ lists . linux . dev" <imx@lists.linux.dev>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>
In-Reply-To: <20240930093056.93418-1-wahrenst@gmx.net>
References: <20240930093056.93418-1-wahrenst@gmx.net>
Subject: Re: [PATCH 0/3] spi: spi-fsl-lpspi: Some calculation improvements
Message-Id: <172780479237.2295744.8404321620319952490.b4-ty@kernel.org>
Date: Tue, 01 Oct 2024 18:46:32 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Mon, 30 Sep 2024 11:30:53 +0200, Stefan Wahren wrote:
> This series contains some improvements for spi-fsl-lpspi which are
> related to the calculations within fsl_lpspi_set_bitrate.
> 
> Stefan Wahren (3):
>   spi: spi-fsl-lpspi: Adjust type of scldiv
>   spi: spi-fsl-lpspi: Fix specifiers in fsl_lpspi_set_bitrate
>   spi: spi-fsl-lpspi: support effective_speed_hz
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: spi-fsl-lpspi: Adjust type of scldiv
      commit: fa8ecda9876ac1e7b29257aa82af1fd0695496e2
[2/3] spi: spi-fsl-lpspi: Fix specifiers in fsl_lpspi_set_bitrate
      commit: 7086f49dc442837996c08350a4d590e790b499db
[3/3] spi: spi-fsl-lpspi: support effective_speed_hz
      commit: 667b5e803a94f1ce48ac85b3fef94891a8d40ccf

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


