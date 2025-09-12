Return-Path: <linux-spi+bounces-10000-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94567B540F6
	for <lists+linux-spi@lfdr.de>; Fri, 12 Sep 2025 05:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD92AA5D51
	for <lists+linux-spi@lfdr.de>; Fri, 12 Sep 2025 03:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5EC23AE66;
	Fri, 12 Sep 2025 03:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATsfH3F4"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84642AC17;
	Fri, 12 Sep 2025 03:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757647847; cv=none; b=Dqk11QQzEIg2ajTxiEekjbfafIunNlSxTclDjMwQ/1gn2IAdAXC7cmQMrigISsyBUsLzjnBtJyfB6x6ogVaYhz8p60RqDPF8WyJ1xjai71OAyVpmrIqQSBzT4wq05akjMY2E2c6ZXsF3YHWG6kyNcDyENa5q/PzjsvBWQywMjY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757647847; c=relaxed/simple;
	bh=9xGGJ/YZo6Ecn4Y6YkJ4vBA5TNvPfeK109wJBAKI29U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=qFdLUjnCSMZlIOZy5FIffrLIc7qLkDlZ8VON/FKS/g6H3C5P5PhCqRXwD0X/17q7fpV+kdHjCErRhGkBK++T2NkP6oguSfEbTMqVwyh2W1ZH7oXmzUYW3E8qGKEweCJglx5SLkqNS/Sb+ymZ3R14krDxqQ9MtfYNpwNRLeIwiqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATsfH3F4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E923C4CEF0;
	Fri, 12 Sep 2025 03:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757647847;
	bh=9xGGJ/YZo6Ecn4Y6YkJ4vBA5TNvPfeK109wJBAKI29U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ATsfH3F4wlIfW/W3eyEnlyq3mph7m8WvY+eM734N9vCya7aKDZpDoMk4AfK3cip6B
	 VKqz2Mc+n04SFbNaHtt//GxBEI+zKhNJb8oEiqPdb+HVAlMFNglJHPTftoHAKHqMVF
	 rSeHM3/3qTZw1OrVmgq9bqin/1cH+mQ1ABYLzCOjJ9esBG3SoWhN0agfovpPSRiiMc
	 RiBXCRqu83ar+2WLBrhfIgsuJ0QOaAvhiRlfVi6Pbw6Wrbxl1lY7aTQ2fv89xObHta
	 QMl2VgAhs2T8LKLG9ZDMYcIw50qO2MeHWVbuk9ERfj2Agl4SID1BSYiAxfS8V9+Uvk
	 fulG/v11Yj5qw==
From: Mark Brown <broonie@kernel.org>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20250815-spi-axi-spi-enigne-improve-version-checks-v1-0-13bde357d5b6@baylibre.com>
References: <20250815-spi-axi-spi-enigne-improve-version-checks-v1-0-13bde357d5b6@baylibre.com>
Subject: Re: [PATCH 0/2] spi: axi-spi-engine: improve version checks
Message-Id: <175764784618.273328.9458661853370548581.b4-ty@kernel.org>
Date: Fri, 12 Sep 2025 04:30:46 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-56183

On Fri, 15 Aug 2025 12:40:01 -0500, David Lechner wrote:
> We have a pending major version bump for the axi-spi-engine so to
> prepare for that, improve the existing version checks for feature
> enablement.
> 
> Unless Nuno knows something I don't, it should be fine for the header
> file patch to go through the SPI tree.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] include: adi-axi-common: add version check function
      commit: 67a529b7d3c50a56c162476509361f4fe11350dd
[2/2] spi: axi-spi-engine: use adi_axi_pcore_ver_gteq()
      commit: 30db1b21fa37a2f37c7f4d71864405a05e889833

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


