Return-Path: <linux-spi+bounces-187-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B3180B433
	for <lists+linux-spi@lfdr.de>; Sat,  9 Dec 2023 13:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962F81C209BE
	for <lists+linux-spi@lfdr.de>; Sat,  9 Dec 2023 12:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3FC6ABB;
	Sat,  9 Dec 2023 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTwLMcMD"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E75D187C
	for <linux-spi@vger.kernel.org>; Sat,  9 Dec 2023 12:30:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2564C433C8;
	Sat,  9 Dec 2023 12:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702125036;
	bh=XRT/cv3fBxSUflS3ZmORCvFBGC0F3VAT47DfXQyREvU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CTwLMcMDFroNXU4kK/19XDeWGJAo5eyMkAk2Bq0EPMdg7QueOVDrSQbsfolVdkjTB
	 GDFt66VrOG5ZasAjCkizt/3lXqE6AHMhob35Gp3sScsPoqjy2ek9x9McDYRDINu86I
	 97Lf56MVLzqg3iU3O79YOoM53I8W1PZFiFXLydiKWjAVB+9MUa3+13tEJvgRIuQWkC
	 BJmPM+FGnoDJYDt784N2y9y75tg8Hk2eTE6nCf39dVQ9A1gqCtGrK47I5jcjJmSvzH
	 9JQhUj1stL0GvPPCd8+6vSBhQydIcQDDg3zUyCn2H1CSi21ywWGvQLWSkcS7vJtwaR
	 jQ9BzJJvnqDvw==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Rob Herring <robh@kernel.org>, linux-spi@vger.kernel.org
In-Reply-To: <20231208185927.14124-1-rdunlap@infradead.org>
References: <20231208185927.14124-1-rdunlap@infradead.org>
Subject: Re: [PATCH -next] spi: mpc52xx: explicitly include
 linux/platform_device.h
Message-Id: <170212503507.2923765.14903539617326201742.b4-ty@kernel.org>
Date: Sat, 09 Dec 2023 12:30:35 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Fri, 08 Dec 2023 10:59:27 -0800, Randy Dunlap wrote:
> Since linux/of_platform.h had included linux/platform_device.h
> and since that inclusion was removed, this driver now needs to include
> the latter header file explicitly to prevent build errors:
> 
> drivers/spi/spi-mpc52xx.c: In function 'mpc52xx_spi_probe':
> drivers/spi/spi-mpc52xx.c:396:20: error: invalid use of undefined type 'struct platform_device'
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mpc52xx: explicitly include linux/platform_device.h
      commit: 52c9a884c6388171f4c6cdafd9add042a7abec53

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


