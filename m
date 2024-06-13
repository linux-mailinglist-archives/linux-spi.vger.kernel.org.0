Return-Path: <linux-spi+bounces-3393-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1467A906748
	for <lists+linux-spi@lfdr.de>; Thu, 13 Jun 2024 10:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC84F1F23641
	for <lists+linux-spi@lfdr.de>; Thu, 13 Jun 2024 08:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDA713DDDB;
	Thu, 13 Jun 2024 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5EmflpY"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEF013DDBA;
	Thu, 13 Jun 2024 08:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268157; cv=none; b=e1iyTJZi5WxfpCvgT2Y9ngKJdVmkEtRQP61MUzdeEPRX9xbC6fROWJUNW9A10sZsUklSD/KQcukaOBwCwIo5NA5eD+CzEa+lrAuoMfHU4zdjrUA4LjeI4ETgoF2wPC0+AA1jXE6g/z0qfi1e1hlrp/a9h/1kXMmR6MvUFoHOgVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268157; c=relaxed/simple;
	bh=oi5/9POK1vEMCK0p3ow/Sp1STduZ+j0IpQ4ogJhDSuE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TQn8JGL4JFs2Vvpfk4R54C5Qa9X+Ky8xX7e2+vINl2EYCw7Gj8sqjLNVVd/NN+QKRsktZ6922lJW7JwjRlJNc/UG8MwgjFtlXpArmJK72/CAyEs7KVbmy97HBLAy0znFknbcXZ1YF3ejksnjb+yE+7LO1o6Z0xDhYMcaphiYolg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5EmflpY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A7BC4AF1A;
	Thu, 13 Jun 2024 08:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718268157;
	bh=oi5/9POK1vEMCK0p3ow/Sp1STduZ+j0IpQ4ogJhDSuE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=O5EmflpYmfNeZF0mhO8ZHCRMrTMseABNxdFZVc6x0PPZlvXSWwEQJ3Y4GylcKUGNi
	 JatpxUFH62QeacYlRQXMLn7C3wbIr4OhDqXswGqQYp5AlpehNO8TjWlro1ePs26Nrl
	 VGNXL8yWNSRhAjsojS83PXOP214FItOhLtm/NozVjwdRQtm4dnI3/7JItP10Y9kePl
	 KTMS5FMuYJ59PWisKx3ud8SP0o0LW7i+xm3JSQVEIaV7O5KcUOoIwCH9pBE1noSyXb
	 UA/D85hiABWwgWhIj+hJxudbTE16pLJDzfsVBeYxgCQBS6bJPE1K2BrF9mMek2Lloc
	 FlmR/6f2QSzIQ==
From: Mark Brown <broonie@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sunny Luo <sunny.luo@amlogic.com>
In-Reply-To: <20240612-spi_lbc-v1-1-d52e8c8011bd@amlogic.com>
References: <20240612-spi_lbc-v1-1-d52e8c8011bd@amlogic.com>
Subject: Re: [PATCH] spi: meson-spicc: add spicc loopback mode
Message-Id: <171826815548.249668.9109171570822609949.b4-ty@kernel.org>
Date: Thu, 13 Jun 2024 09:42:35 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev-4c370

On Wed, 12 Jun 2024 17:44:50 +0800, Xianwei Zhao wrote:
> Add spicc loopback mode for debugging convenience.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: meson-spicc: add spicc loopback mode
      commit: 313d2c9d1252185721cad4f8c57099840d6c9958

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


