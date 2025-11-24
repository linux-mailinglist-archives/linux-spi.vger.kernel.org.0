Return-Path: <linux-spi+bounces-11482-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A4CC81601
	for <lists+linux-spi@lfdr.de>; Mon, 24 Nov 2025 16:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 16D2D3419AB
	for <lists+linux-spi@lfdr.de>; Mon, 24 Nov 2025 15:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31045313E0E;
	Mon, 24 Nov 2025 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5ryJAFd"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D37287246;
	Mon, 24 Nov 2025 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763998361; cv=none; b=muNqTWSyNhT+YIZMM5tepHsM9ez16clSjhe5t/DQrrF//MjSgnZKmMj5zIxN7qXzOZx3tQXXXYQbFing/+YvVu2aX+yG0JtVHbkJwKGea1xZoAlKv5wCHZhxw2MfBImcHCAthANayx99t1MVW6E+3n/l0rAOAj0X8evdz2QBXfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763998361; c=relaxed/simple;
	bh=XE2VwP4AbYBgZ19uO3JyCWY54UU1ToeK2DpAkXVdP74=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PGq3he57yEd3keHRcvUwSww5ZYrrpxJIXyhwHIZafJ8MYaZR1Fn9UtW09QyVq191ndlZTBsNXVDBM2IWyjiIDx+deOTtlONI4WQMB772Ls9cS7REusXb7Ef1mKEpFIUlMzDRlr/wqEX+ScFf93zbQhXKrBrNXxEWa+Ii+0gjBEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5ryJAFd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19DAC4CEF1;
	Mon, 24 Nov 2025 15:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763998360;
	bh=XE2VwP4AbYBgZ19uO3JyCWY54UU1ToeK2DpAkXVdP74=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=A5ryJAFdjopY/xzg8oq6Qqg0D/jtyEXKzZWE+A0osBdhYqy2HYpmM8p990wqN3N+d
	 frB1OXVGDrXUK+xTPsT576OKaZzmWPLcoUiY5Ll3VfjPzSmumMjEd3W/I2RVI95gB6
	 BCHiDfdztLWxB2yQytTf/k94jmklRFi5LBjDQHyF1lxmSDWMPM3M1T2V0QWdXzMc24
	 EeX402VyrODQL7aX5pORn27rVnk3nqyfiFG7whm3bcFWDd0y2Ze1icPVTz2yvkvXqq
	 NpbMFAaeJEzoR3eus7nIVQpd7sIEhbxXhTY7Y8Hv3jz/98NWo7G+QtAaxioB3iKEmX
	 6Eamp9W9LJ3Jg==
From: Mark Brown <broonie@kernel.org>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: mmkurbanov@sberdevices.ru, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251124015852.937-1-vulab@iscas.ac.cn>
References: <20251124015852.937-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] spi: amlogic-spifc-a1: Handle devm_pm_runtime_enable()
 errors
Message-Id: <176399835966.59465.258446054961487669.b4-ty@kernel.org>
Date: Mon, 24 Nov 2025 15:32:39 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Mon, 24 Nov 2025 09:58:52 +0800, Haotian Zhang wrote:
> devm_pm_runtime_enable() can fail due to memory allocation. The current
> code ignores its return value, potentially causing runtime PM operations
> to fail silently after autosuspend configuration.
> 
> Check the return value of devm_pm_runtime_enable() and return on failure.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: amlogic-spifc-a1: Handle devm_pm_runtime_enable() errors
      commit: a90903c2a3c38bce475f46ea3f93dbf6a9971553

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


