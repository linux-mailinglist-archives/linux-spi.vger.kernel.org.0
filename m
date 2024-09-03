Return-Path: <linux-spi+bounces-4547-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D1496A4F1
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2024 19:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06091F26355
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2024 17:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47ACE1799B;
	Tue,  3 Sep 2024 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBLrcyHo"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235D71C14
	for <linux-spi@vger.kernel.org>; Tue,  3 Sep 2024 17:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725382859; cv=none; b=VG3dXnLMDWhSFnnKwbwU2UD8YmlrjlJ19nz87mj83M5yqqNnzqGW9fNl3wnnzvXGLeWyi/VAnT8C4+5+Hc1iA3F29Vcp4huXrsdhydN7LapAde/+HgFG7rRwnGHi6ArEgM4ZXjtkD13e2MMh9mAPumCLgjHi1LnLjC8pixCxzkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725382859; c=relaxed/simple;
	bh=PIJu41yn4Sd5U8mu8S6DzRgQCPut4PokxRbuG1jFcJY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=e/enSQjezssd7to7hc8SrG2JXSPiv1DZwS2boiu3rZ41sIKLpLgq7RU+6oXs4LXtgJptdmM59k17dafhphrGJpepWUhcyBwpj+Bf+H4MTZ/9olSPR+0KjhlTMZelBx6UwGRuKdPLlUX7otuKkWaZOBOti/KuHiq75tNz2IpQ9lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBLrcyHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 860F4C4CEC4;
	Tue,  3 Sep 2024 17:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725382858;
	bh=PIJu41yn4Sd5U8mu8S6DzRgQCPut4PokxRbuG1jFcJY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GBLrcyHorxNdqHFAO8G+tf4khZFqCwawwdWD8cDZt6r8BFe9I0nur/q5ILnAA2Opg
	 DthTa1uUqDIYa/yAlomYUjORTpkhBQBcwEnzQX1K+NwotrkjSU1zvHaD63sLNooz0N
	 cXtQykk2fja9XhpfjI+NNyieoeccJRXWioALXnU7xyKw0dORDGBtMVUMhB36M7Rcx2
	 EOnhT3aythFdv8ZRGzVefZKJ54WQ3doPfwcyqlwNdJOpSwNPtGXEqZKRld88HAkR6f
	 DhWUngeADfk8Jw20D4WDNn7PK1aHtdXYPfGqODZg3YpzeOZTjDsizwOGGvC009lsLX
	 5KHIGkw2PKquA==
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <festevam@gmail.com>, Heiko Stuebner <heiko@sntech.de>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org
In-Reply-To: <54bbb9d8a8db7e52d13e266f2d4a9bcd8b42a98a.1725366625.git.geert+renesas@glider.be>
References: <54bbb9d8a8db7e52d13e266f2d4a9bcd8b42a98a.1725366625.git.geert+renesas@glider.be>
Subject: Re: [PATCH] spi: spidev: Add missing spi_device_id for jg10309-01
Message-Id: <172538285727.89477.10527490026627155111.b4-ty@kernel.org>
Date: Tue, 03 Sep 2024 18:00:57 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Tue, 03 Sep 2024 14:32:27 +0200, Geert Uytterhoeven wrote:
> When the of_device_id entry for "elgin,jg10309-01" was added, the
> corresponding spi_device_id was forgotten, causing a warning message
> during boot-up:
> 
>     SPI driver spidev has no spi_device_id for elgin,jg10309-01
> 
> Fix module autoloading and shut up the warning by adding the missing
> entry.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spidev: Add missing spi_device_id for jg10309-01
      commit: 5478a4f7b94414def7b56d2f18bc2ed9b0f3f1f2

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


