Return-Path: <linux-spi+bounces-4101-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C54942052
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 21:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CAF51C23817
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 19:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20F418A6BC;
	Tue, 30 Jul 2024 19:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFGn7CRr"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992461482F3;
	Tue, 30 Jul 2024 19:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722366519; cv=none; b=ZLoEvw3HoDgF7fgySnjGIdMyVB0yNZtbtLk3+1p0jSKz3oxIYZAMvUh2W5Egy/2j+O3yUji+HnfoQGxzYWvtfLe5uZMQBZTk958IucjGevrLFsVDFh0xmXVrXWCEEElJXE+lZRj/zyCVQtpvR7GPRW94kuEGhchFMaCNPxKZ3mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722366519; c=relaxed/simple;
	bh=ftZxzUR/vz0LHAJzG445pNqWrW9qdUOSvIIBI8lKJHo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AdNMI6fb6Q0qVdSd4OQFfO1Uy7O7GXYiWfCSHnsHqhgWy0kbiRQ9Pf9qZGzcvVqyOx2pEcVI8VTfUCMr2L5xZrNn+GeD2StUKwIEwiQCM5J+mDEfsg1kYY8Dhr6QdW3QurkhRT+OH8NNUmup3MVgLwhie6mKbQDLU/CfW7mFbxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFGn7CRr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2523CC32782;
	Tue, 30 Jul 2024 19:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722366519;
	bh=ftZxzUR/vz0LHAJzG445pNqWrW9qdUOSvIIBI8lKJHo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OFGn7CRraHlTTJ1hzovG+pk3kow44MYhL4ZeQNK8GQzozVyXRgmdMhospZa/pMeDL
	 7bQ6V9B86d1Dk4j6O2wniXMK9XFLddBkaVf8NDi3LNp/LqSIHkw5DtvZ53sR+b2wgO
	 c8dfbIYOblWK1jVjZcO/EOxycuYa7khlk0UmahMclYmzpPy+mAyLnXdoqKnBSziH8x
	 qzxb0xvmaKLuLq7CnDGdWhkuAbenMs91qnew4TuCo4tDE6wX3lcjhohr/VqvcKB35Z
	 0QaR4eMd2nn2I4e/Glb5xvt7M/V0lEHOPonu5vb268GMOwrrDVaXKVEMkWKjYWh9Zx
	 kkXs+yw5luzeQ==
From: Mark Brown <broonie@kernel.org>
To: Maxime Ripard <mripard@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <cb571d4128f41175f31319cd9febc829417ea167.1722346539.git.geert+renesas@glider.be>
References: <cb571d4128f41175f31319cd9febc829417ea167.1722346539.git.geert+renesas@glider.be>
Subject: Re: [PATCH] spi: spidev: Add missing spi_device_id for bh2228fv
Message-Id: <172236651785.95648.14253636888913221016.b4-ty@kernel.org>
Date: Tue, 30 Jul 2024 20:08:37 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Tue, 30 Jul 2024 15:35:47 +0200, Geert Uytterhoeven wrote:
> When the of_device_id entry for "rohm,bh2228fv" was added, the
> corresponding spi_device_id was forgotten, causing a warning message
> during boot-up:
> 
>     SPI driver spidev has no spi_device_id for rohm,bh2228fv
> 
> Fix module autoloading and shut up the warning by adding the missing
> entry.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spidev: Add missing spi_device_id for bh2228fv
      commit: e4c4638b6a10427d30e29d22351c375886025f47

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


