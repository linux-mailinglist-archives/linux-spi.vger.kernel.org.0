Return-Path: <linux-spi+bounces-151-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 530FB8058FB
	for <lists+linux-spi@lfdr.de>; Tue,  5 Dec 2023 16:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 839581C20FBA
	for <lists+linux-spi@lfdr.de>; Tue,  5 Dec 2023 15:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7687F5F1ED;
	Tue,  5 Dec 2023 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBJ0YZ0Y"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EAE5F1EB;
	Tue,  5 Dec 2023 15:41:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC09C433C8;
	Tue,  5 Dec 2023 15:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701790885;
	bh=pVtMVHdsKsdy3G3SCoMfkdUIfJsu3xD8KndVjlc18c4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cBJ0YZ0Ygp1KLJOema0kjtJukrhA5+jXvVT0k2cH8NsWJlGvY57jpI4i8xKnY775/
	 TzM+O9QFb1teVWPPxXIQ4M/GMQrx1/iyDXcYK9bwTBRQ2UILQetVNl8JlIdzuDOIM2
	 AC30yuEr2c9t7IPeJsQzT6LGniBPumkEjsvDQ/fSkvc1IZlXCwqQaFIyGczxVp0ZrI
	 pjjJ3CaqQeLS3JFgJfJXpKiRdxDN49kpYEFpP8el59V74Vz1D59IVuQHuPL9ADu0Fd
	 /VAVNkrT5TDfWVLhr+pICqPOxaQcU4JLfAaFPjdVduqAwVpeaC8e+ge52yVsW52VUu
	 2KKIHcsq5CUsA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Ryan Wanner <ryan.wanner@microchip.com>, 
 Ronald Wahl <ronald.wahl@raritan.com>, 
 David Laight <David.Laight@ACULAB.COM>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
In-Reply-To: <20231205083102.16946-1-miquel.raynal@bootlin.com>
References: <20231205083102.16946-1-miquel.raynal@bootlin.com>
Subject: Re: [PATCH] spi: atmel: Prevent spi transfers from being killed
Message-Id: <170179088280.846111.402175605685351431.b4-ty@kernel.org>
Date: Tue, 05 Dec 2023 15:41:22 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Tue, 05 Dec 2023 09:31:02 +0100, Miquel Raynal wrote:
> Upstream commit e0205d6203c2 ("spi: atmel: Prevent false timeouts on
> long transfers") has tried to mitigate the problem of getting spi
> transfers canceled because they were lasting too long. On slow buses,
> transfers in the MiB range can take more than one second and thus a
> calculation was added to progressively increment the timeout value. In
> order to not be too problematic from a user point of view (waiting dozen
> of seconds or even minutes), the wait call was turned interruptible.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: atmel: Prevent spi transfers from being killed
      commit: 890188d2d7e4ac6c131ba166ca116cb315e752ee

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


