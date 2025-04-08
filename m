Return-Path: <linux-spi+bounces-7459-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC34EA81019
	for <lists+linux-spi@lfdr.de>; Tue,  8 Apr 2025 17:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AD4B500109
	for <lists+linux-spi@lfdr.de>; Tue,  8 Apr 2025 15:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA0722B8A1;
	Tue,  8 Apr 2025 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPTwLkTb"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE67B22B59C;
	Tue,  8 Apr 2025 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126060; cv=none; b=hhp4SP8rcS9bs3TcbtxbsndOg571ROd/dwTgNHVKN3uYjrbNdEimya0KjB7H39/TbFpiKBGcBC0EH3t5TJ2Vl3j/nlE6yZEEuJ7VwXheHo1WkDlgNvKeVECGU5ivmQg8mteRQA3dLzLhfBFS3zGf1oGCDM0bGbcDERBcWPumxHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126060; c=relaxed/simple;
	bh=W1CFzyy/AXK5JPPtspX+yBlSeTf1dD0b0c5JliaMf7E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Lk3K4Nq/y2P0u+F3Z24UjthgfT588XYi9MoxrmyNo5a1VFLg+GN9DENlffWN2VIAmZAxAjccbqiD1995mb2EZhe+NvVj1veeu7tJ/dpeDrHmBbsxVmCdM/ZAFuOZcs3hjbrAQSTA6jbts/bKcd5x16JTLkihQlh20iKdJ4Xldow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPTwLkTb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D77C4CEE5;
	Tue,  8 Apr 2025 15:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744126060;
	bh=W1CFzyy/AXK5JPPtspX+yBlSeTf1dD0b0c5JliaMf7E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=vPTwLkTb+aUIcALOLlkMrBu+zjpup28Cou2fsYHTjWp73TxT3H3WotiXGRIukUBDy
	 j4/WwOdh824zq+A+3dP5/GgwrsO9NfM5tqojSW5cMCVjeckRb9yZuYJYk+NlIZpvs+
	 eFfzEmiZuIlvK2Pj3uZoTbVO+Uj9E90q0imX5kb4Pt2KIXwt13IkWW0sZ8xOSAnVLh
	 Lc2Fujh6fX/S2aWmGsten0n/me+CzRDBWPMOsja4X0aCP1IpnZZqF6BYyYb9hbj+eF
	 TKFuM9pvBmiDcwteINFd4IzpSwXXg+TRUYwNOwapdtWJHVUtpKSC1lPIb/gY8J8aAS
	 yXvuXr9sZqvuA==
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
In-Reply-To: <20250408-gpiochip-set-rv-spi-v1-1-597660766654@linaro.org>
References: <20250408-gpiochip-set-rv-spi-v1-1-597660766654@linaro.org>
Subject: Re: [PATCH] spi: xcomm: use new GPIO line value setter callbacks
Message-Id: <174412605870.2182722.17439472772592331857.b4-ty@kernel.org>
Date: Tue, 08 Apr 2025 16:27:38 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Tue, 08 Apr 2025 09:39:56 +0200, Bartosz Golaszewski wrote:
> struct gpio_chip now has callbacks for setting line values that return
> an integer, allowing to indicate failures. Convert the driver to using
> them.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: xcomm: use new GPIO line value setter callbacks
      commit: 5e21900ef64244fadeddc9015e8b8307d116764a

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


