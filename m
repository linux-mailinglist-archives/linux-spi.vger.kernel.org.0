Return-Path: <linux-spi+bounces-5697-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5699C7A35
	for <lists+linux-spi@lfdr.de>; Wed, 13 Nov 2024 18:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674B01F2379D
	for <lists+linux-spi@lfdr.de>; Wed, 13 Nov 2024 17:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF768204085;
	Wed, 13 Nov 2024 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3d3QOWV"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB202022E4
	for <linux-spi@vger.kernel.org>; Wed, 13 Nov 2024 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520027; cv=none; b=lh2fdbjWVB9NxtH2Zi1hP1BhlRn3KwW2+UdPSUU2Ni0m/m2YLE//YTzdPuweUjSVmcwCcOORiL/YNOSqonk4ZJuE1+EhM9+M9Nol0V83Pfylx8m113Vt/7YEnYoWA2gn9H26uz5djejsdLO55NMyTBmExy7xYx9lrEaGMm1JeiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520027; c=relaxed/simple;
	bh=4v5Mmo8OF0Ti0sZlpsCdpR5Av49zkOc3qGcMOuOOmQo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qCVvSmegvzfpNUeZY4c8CjAhVS1IffUIoqW2L4IBAOmxnqXWSPdhwTr36Ynv3JFSf3lSjkkH85hYfNUCVx1H+pcZT6a4JDrHTmonj6pSn7F7SDhgmNZI+Pr7kYFqtNy7TgPyZRuXvdon2FFhLAOF5mfFvpENeBrnUQu1urrdBUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3d3QOWV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AF3C4CEC3;
	Wed, 13 Nov 2024 17:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731520027;
	bh=4v5Mmo8OF0Ti0sZlpsCdpR5Av49zkOc3qGcMOuOOmQo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=L3d3QOWVpy1Xg6XnAUbCwK8UQMNzSXBa5aneEOPVLzTE8UiQj2lrViBe6l1GNadTa
	 SR9D4/njZnPhih6pJNy+9xNjTQVlhY0svB+XZS8H1S5EhZUUiyYXe8ccljVYA6Unz0
	 FEN69TS7rQXj4p47AJrX6tf5Z9CWzv7WC0rPNXt2SzbJrI+DSViw2KHiSpTXTZQZTN
	 M9N5K1mkGCIU37QG5Yz+9ZDu3U2WtISnc3PUVwfm6V+/o8xWnSWvxu0e3IP6L9V/Rk
	 ELwqqkde5prtWpfj77/kpNmRAxdhA72WzrWpjeqIaZmVkFbLj2broHyRX7k763/i+E
	 kIVnc5jyopHlg==
From: Mark Brown <broonie@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, linux-spi@vger.kernel.org
In-Reply-To: <20241112131434.678882-1-ckeepax@opensource.cirrus.com>
References: <20241112131434.678882-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH] spi: cs42l43: Add GPIO speaker id support to the
 bridge configuration
Message-Id: <173152002636.472003.18009169279891105746.b4-ty@kernel.org>
Date: Wed, 13 Nov 2024 17:47:06 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-355e8

On Tue, 12 Nov 2024 13:14:34 +0000, Charles Keepax wrote:
> OEMs can use the spk-id-gpios ACPI property to indicate the type of
> speakers fitted to a device.
> 
> Attempt to read a spk-id value using the GPIO method when a usable
> spk-id value is not obtained from the 01fa-spk-id-val ACPI property.
> 
> Obtaining the spk-id value has been moved earlier in the function to the
> other sidecar block, so that an -EPROBE_DEFER from a GPIO driver is
> handled more efficiently.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: cs42l43: Add GPIO speaker id support to the bridge configuration
      commit: f3c605147741e0ad8f1c51a7decef2040debfd16

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


