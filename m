Return-Path: <linux-spi+bounces-5610-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF0D9BBB1D
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2024 18:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C51282071
	for <lists+linux-spi@lfdr.de>; Mon,  4 Nov 2024 17:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37C61CB530;
	Mon,  4 Nov 2024 17:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jc7tdfaC"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828771CB522;
	Mon,  4 Nov 2024 17:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739941; cv=none; b=nD05aqzx42JoLhmx4+F0cWgDlEtZXw+nKio/VhHJfNzSGf0ZJOEyDVqyWdETNF281MhbvsQP5zsqS6EG3hsf9hyhVZAuyaMGWk6cRlde0y8kjqkkZ0z65rD8tDRZHymH5SKM9DS3RffCktqDrJfxM7f173Tg7F+BzC23a57i3SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739941; c=relaxed/simple;
	bh=7NlkNOFSZHWxBgrceA+8Xi6+Fih243xDHsjh+NFzwXw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BCmwZSBvHo7H6aIAO7TMvZk67jMWpaL4Rl2aJUkacFXJs7z+fdApkgycNwKl6EHIihTfXiAInJJl2fQB9S+wbeklXanMnzkTkd4Ia6MpcMH5bRTsEwdBwMT4Hw5LS7hRGOgylt3HM7nmrQiAM4FQidfI2Byh5pRCbfIlGOPSczs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jc7tdfaC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B52C4CECE;
	Mon,  4 Nov 2024 17:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730739940;
	bh=7NlkNOFSZHWxBgrceA+8Xi6+Fih243xDHsjh+NFzwXw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jc7tdfaCUbz5xxNV6QTnI7Cg8eZwNj3qdy+EaEkuruj9XNRj0oDfZo+O0G02U1ao3
	 jsN3V/nT92qkUyXJ0l8DYE2YEvz0XS4pSiLORiJG/tJ0oUZLrNfA7Wtus/DPv0162t
	 JRzsnZxLyh1mxUTUlWftWDzdpCFIBk+FN+TapN/sieuCjuOv6fSL+KC2D0gRmrqJFB
	 xaJVKaBxsPsB+wxnyvrggHPga4lK6nX8UFS5QDJK3TFJyKaDR4BClzMfYpoq+br4CK
	 G0ht3tDdks2YNaRsiwClHqHq3Dw+JBaeeJdM9isZFNiXT1ciy8LtI8IgvVEfHdbNZs
	 Ey7+wB5ZIsc6w==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Raju Rangoju <Raju.Rangoju@amd.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20241104062327.1228521-1-Raju.Rangoju@amd.com>
References: <20241104062327.1228521-1-Raju.Rangoju@amd.com>
Subject: Re: [PATCH] MAINTAINERS: update AMD SPI maintainer
Message-Id: <173073993911.77571.9752554985981220847.b4-ty@kernel.org>
Date: Mon, 04 Nov 2024 17:05:39 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Mon, 04 Nov 2024 11:53:27 +0530, Raju Rangoju wrote:
> 'Sanjay R Mehta' is no longer with AMD, I will take over as the
> maintainer of the AMD SPI driver moving forward.
> 
> I request to be added as the new maintainer.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] MAINTAINERS: update AMD SPI maintainer
      commit: ebdcba2126a817da4efc085c9d4dce0c51942eba

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


