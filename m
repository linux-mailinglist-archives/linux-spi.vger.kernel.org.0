Return-Path: <linux-spi+bounces-48-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712C17FA6CF
	for <lists+linux-spi@lfdr.de>; Mon, 27 Nov 2023 17:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8611C20B7D
	for <lists+linux-spi@lfdr.de>; Mon, 27 Nov 2023 16:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DB731580;
	Mon, 27 Nov 2023 16:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PN9GONCj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EBE2D04E;
	Mon, 27 Nov 2023 16:48:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D64C433C9;
	Mon, 27 Nov 2023 16:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701103713;
	bh=Nn4/UuI6Ix0dBgQDmyVMqZlqto71ehEGJxkHAIgkiUg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PN9GONCjG2BXlqUaQkTYtBjiUaVwvVys6JMXLc4pjgAcYoHoLUIa4+W1j7mpxAuxY
	 gO61pU3Xc+G/TlhKBm8OT9EiASKKvdi7WeuX/9pE7+A5Ky1+ZjFNzkEy9Abwfo5eTE
	 2Sr5wRM5rnpGaVaVdoQLY+uxuFcQEClBGP/GwsM3d0dNk84XXzJmjF9xXHdFB5EX4v
	 M7d3Tk2ldhh4rrsNwtwu/byI9VrGnzE5BRgWgELO7jSqjgl/c68OrdU/VtDWGBnb+w
	 1lRDQJj8lVN8q2YzCo2jNClWeb4OtTlXnCeSAS3Vj6IUrgWVrbZ8h2eaXnr1QNYj07
	 CxUaXybBhhG8A==
From: Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, Karol Gugala <kgugala@antmicro.com>, 
 Mateusz Holenko <mholenko@antmicro.com>, Gabriel Somlo <gsomlo@gmail.com>, 
 Joel Stanley <joel@jms.id.au>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Lee Jones <lee@kernel.org>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, Andrew Davis <afd@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20231117161006.87734-1-afd@ti.com>
References: <20231117161006.87734-1-afd@ti.com>
Subject: Re: (subset) [PATCH RFC 0/5] Deprecate register_restart_handler()
Message-Id: <170110370952.2695179.559211126183016709.b4-ty@kernel.org>
Date: Mon, 27 Nov 2023 16:48:29 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Fri, 17 Nov 2023 10:10:01 -0600, Andrew Davis wrote:
> Explanation is in patch #1.
> 
> The rest of this series is a set of representative examples of converting
> away from the old API. They should be valid and can be taken by their
> respective maintainers even if patch #1 doesn't find acceptance.
> 
> Thanks,
> Andrew
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[4/5] spi: sprd: adi: Use devm_register_restart_handler()
      commit: 8e6a43961f24cf841d3c0d199521d0b284d948b9

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


