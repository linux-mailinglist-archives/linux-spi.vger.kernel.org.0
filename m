Return-Path: <linux-spi+bounces-5069-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F1D98B134
	for <lists+linux-spi@lfdr.de>; Tue,  1 Oct 2024 01:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC343B22AF9
	for <lists+linux-spi@lfdr.de>; Mon, 30 Sep 2024 23:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF6818EFF5;
	Mon, 30 Sep 2024 23:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlIFyWjQ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2622F198A0B;
	Mon, 30 Sep 2024 23:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727740287; cv=none; b=gys5zvI86nc5JSOdJ8MOa6pw3VFxERaQdkGfSkS9bc9N24TYRSa1F5pc6vRKD/xWBh1Agb+puSdCUsZE53g3a3EQxT4mhR7OHjKhb4PReP6I1Q2nPraO9t925wjGGeGGt+YTKJxW5/kT1kITg73wxHLmiYXbrrQA/HYxj3HoSOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727740287; c=relaxed/simple;
	bh=emCc3vhDE46ByrVx4QaFgAH7/jlJe0viJuSoIgQuEZA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M9+f7IbIYoICfkLmx/SzP7uu7L1rv+X5keXdq4KF0aiEN89UINPzjNecuMQDwNOmZQivQ0Edef1hQR8nLqXt0yupyxyyVqNWBjAB2VPhFeO1xOdEM/dzoB+DqHOmZhCniTCTd+ExKpX3k7aqe5eGpHFcFRIrvU1pZPh6L9TYs8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlIFyWjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CB7C4CED0;
	Mon, 30 Sep 2024 23:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727740285;
	bh=emCc3vhDE46ByrVx4QaFgAH7/jlJe0viJuSoIgQuEZA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=IlIFyWjQDNj3hP0mSxeGZ17Hq0qJ1ABXPPKdxiLii6NUvbqLlGxL9lsdXRzb7PB3G
	 YMaJMQ5EpO4AjRunm+WhmblqY9DJylbFDXPwNKqoE8jUg26gJhDp28gNtOkUnIqTo2
	 h8Rcb6N5Yy+j3ZGWe2r4N+ww5rlKES2YMrgg5hY5HS86YhLhxm1e7tczQ0Kxq5dBIe
	 a6qCof7cPxT7PWmZO8jGoXKsoHWfOy+ui7L98gIUVsR6bkRcQXSXnTMOtic3FBQcZu
	 B1be5fdMPA4Agoq4Q4llJUDeCKWbaDrLbh5ZHPBxFcUNJ3XEjnNg/Lmo0jskUREcqz
	 hvxo2q6Ndx9PA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 Dragan Simic <dsimic@manjaro.org>
Cc: heiko@sntech.de, oss@helene.moe, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <cover.1727337732.git.dsimic@manjaro.org>
References: <cover.1727337732.git.dsimic@manjaro.org>
Subject: Re: (subset) [PATCH 0/5] Improve error handling in Rockchip SPI
 drivers
Message-Id: <172774028424.2264837.4595727034314147956.b4-ty@kernel.org>
Date: Tue, 01 Oct 2024 00:51:24 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Thu, 26 Sep 2024 10:38:11 +0200, Dragan Simic wrote:
> This is a small series that improves error handling in the probe path
> of the Rockchip SPI drivers, by using dev_err_probe() properly in multiple
> places.  It also removes one unnecessary check of a function return value,
> and performs a bunch of small, rather trivial code cleanups, to make the
> code neater and a bit easier to read.
> 
> Dragan Simic (5):
>   spi: rockchip: Perform trivial code cleanups
>   spi: rockchip-sfc: Perform trivial code cleanups
>   spi: rockchip: Don't check for failed get_fifo_len()
>   spi: rockchip: Use dev_err_probe() in the probe path
>   spi: rockchip-sfc: Use dev_err_probe() in the probe path
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/5] spi: rockchip: Perform trivial code cleanups
      commit: d87ec94e48dd2da27fbe948f2dc6c8fedc98fff4
[2/5] spi: rockchip-sfc: Perform trivial code cleanups
      commit: 6c510eac1528d8939bad8b6df72c7b23ffec8c25
[5/5] spi: rockchip-sfc: Use dev_err_probe() in the probe path
      commit: 1482c40b440fa58f956bc3e1ef3426e0cdbc09e0

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


