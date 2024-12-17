Return-Path: <linux-spi+bounces-6088-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4E39F4FA3
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2024 16:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62FC6164AE6
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2024 15:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C535B1F75B5;
	Tue, 17 Dec 2024 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3ch5wMR"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC981F75B3
	for <linux-spi@vger.kernel.org>; Tue, 17 Dec 2024 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734449832; cv=none; b=RjfTrRoT9CFTkkPQ0j28esN/4I/TxBjlDo4BrNC1Iu+A64qFrJjBsWYG4lk7mQoN94AwKPAFLuiWq7F26cUGq4iFQZtmUCvbrsYbfuqhpJwSVrDZbYXvsMqFy0m29V74i0jR3TgAPqWXQs8nIu8MRjpj4MXm88gyZTiqqmvnXC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734449832; c=relaxed/simple;
	bh=uUAlpguiaFNHmx1+DoQ3ODGuAhImsq5zAOCsej8Sr9g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lGg9nVLCwksNSYYJLahNqlgJY4263iAb2RVOzj+zmveiEYuzgzMzXANfwDwPGTsK4wmY/KJW3IrOFihsxxtiqky+ZnfNU0Kwu2B5zzWmdAdZy0kCMomcyJL6xbHkm2BBGZCSAAltOhJ9FIYgpJ6y40VBUeysUw6Dtequo/6oQrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3ch5wMR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2187C4CED3;
	Tue, 17 Dec 2024 15:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734449832;
	bh=uUAlpguiaFNHmx1+DoQ3ODGuAhImsq5zAOCsej8Sr9g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=I3ch5wMRAkoiZYH5Pc3yv0cH2NBbOTeJMyu9oNDDIXnAJjWiZhq5nRXBee9irr5fA
	 mFuf8S9AlQ/YhbzpNurnfaIOLrhrmPZOmLEFsmIR9dBoCXK0Dg6EnMmcMfyPd1ogNt
	 EBOQSwAdvAMIVkJCamCoyWbym+i9tX5aAeumBNKmsN+p0PlRbP3NpszIWhYPt0O2fm
	 TkG0gB+LQP2ECSte1QfUdt2y/7Jh9j/FA0nMo26l+sAliimR8+mbiMfrjt+JM9HEhr
	 6WZOguSw4M3Qx9DEOnBVhmB+S/3oNwtvbKM4KSItYwvIgbnyx2SmstL054kx8eJG5N
	 NEV4uYmvmHP/w==
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-spi@vger.kernel.org
In-Reply-To: <20241217114226.1223724-2-u.kleine-koenig@baylibre.com>
References: <20241217114226.1223724-2-u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH] spi: spidev: Align ordering of spidev_spi_ids[] and
 spidev_dt_ids[]
Message-Id: <173444983158.69458.6468876206975684498.b4-ty@kernel.org>
Date: Tue, 17 Dec 2024 15:37:11 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-9b746

On Tue, 17 Dec 2024 12:42:25 +0100, Uwe Kleine-König wrote:
> There is a 1:1 correspondance between the list of spi device-ids and the
> devicetree compatibles. The latter is ordered alphabetically by vendor
> and device. To simplify keeping the two lists in sync, mention the
> vendor in a comment for the spi device-ids and order alphabetically,
> too.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: spidev: Align ordering of spidev_spi_ids[] and spidev_dt_ids[]
      commit: e490ceff433fbc111404ce040bd9e8f41f12af16

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


