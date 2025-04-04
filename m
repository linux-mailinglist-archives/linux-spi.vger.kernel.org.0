Return-Path: <linux-spi+bounces-7403-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB12A7C077
	for <lists+linux-spi@lfdr.de>; Fri,  4 Apr 2025 17:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3455C189BFB3
	for <lists+linux-spi@lfdr.de>; Fri,  4 Apr 2025 15:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084151F4E5D;
	Fri,  4 Apr 2025 15:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfQFiC9b"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47F71E5B6C;
	Fri,  4 Apr 2025 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743780027; cv=none; b=fF1rlUtVVOpzLh5KpgCmK5xRDaymhFvX7U+hUY44vnJjSUVZqHonQT4LnlbnHHbjvCJyzeujoQuD3BkXz1wKNkJO0D8AaXUBC5UvGe2mAehngfQT2IA4zLwtkQGe7Obj73npwEJicKIt2GKGBYuNOXyMHiaeKEZme6ZXR62jPxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743780027; c=relaxed/simple;
	bh=wXfM6QyWAvK68QTm/0iU77QM/D2h3ToTPakJYOIk9MQ=;
	h=Message-ID:From:To:Cc:Subject:Date; b=i+cwTGX87fRGpeuCTdoPaE/ZlJOMfzVz7cQosOKZq3w7N9yr+eHY7k6hZSe7dAzIC3WzCW0Vri89ABQwl0QY5JxAXMmc6W0vFrmyx/dwyYwO5Z37X74e3a7ODR9T/T+o5NgJ6qRWpPT9+1DAUmQgBnxzHZVrrjBNkNRMSTz/FyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfQFiC9b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A27C4CEDD;
	Fri,  4 Apr 2025 15:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743780027;
	bh=wXfM6QyWAvK68QTm/0iU77QM/D2h3ToTPakJYOIk9MQ=;
	h=From:To:Cc:Subject:Date:From;
	b=TfQFiC9bjaD53D1NaITDLMZKbXBpFKEeU+PwHXR8NFnQnUBQk0DEALQpNje1pBB3M
	 tjSX280cQI7J92QMo8BYbnpmhXvLNmg9gMqqP2VwNGo0p6LlryoADFXGjeRfesO79p
	 zNiuBWmOnIi1T7F3Kv8aojtQnPqFe6NEzhsDWGlY1X/O7VaNllKJ1nOafz7QwixlVO
	 3dfCcQnnAcLrKW04+uVqRfb0XSbwf9KdUXiBXsJn53A+eDfoiplDGDetOcv378MqGq
	 ShlaM5e/4gD5PLxxFShmdUhDx0HwbqX62TvwiD++XBUpf68LZp5YmUd4IXAIpwJnJH
	 EMwlrQHz5uItA==
Message-ID: <1fac1505c004071e4ad79df7e733d422.broonie@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v6.15-merge-window
Date: Fri, 04 Apr 2025 16:20:13 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit ee2ecf2cf501eaa69dcd723d76b434767195b64e:

  spi: dt-bindings: cdns,qspi-nor: Improve (2025-03-20 15:35:31 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.15-merge-window

for you to fetch changes up to e19c1272c80a5ecce387c1b0c3b995f4edf9c525:

  spi: bcm2835: Restore native CS probing when pinctrl-bcm2835 is absent (2025-04-02 12:55:32 +0100)

----------------------------------------------------------------
spi: Fixes for v6.15

A small collection of fixes that came in during the merge window,
everything is driver specific with nothing standing out particularly

----------------------------------------------------------------
Florian Fainelli (2):
      spi: bcm2835: Do not call gpiod_put() on invalid descriptor
      spi: bcm2835: Restore native CS probing when pinctrl-bcm2835 is absent

Geert Uytterhoeven (1):
      spi: SPI_QPIC_SNAND should be tristate and depend on MTD

Han Xu (1):
      spi: fsl-qspi: use devm function instead of driver remove

Josh Poimboeuf (1):
      spi: cadence: Fix out-of-bounds array access in cdns_mrvl_xspi_setup_clock()

Luis de Arquer (1):
      spi-rockchip: Fix register out of bounds access

Miquel Raynal (1):
      spi: cadence-qspi: revert "Improve spi memory performance"

 drivers/spi/Kconfig               |  4 ++--
 drivers/spi/spi-bcm2835.c         | 18 ++++++++++++++++--
 drivers/spi/spi-cadence-quadspi.c |  2 +-
 drivers/spi/spi-cadence-xspi.c    |  2 +-
 drivers/spi/spi-fsl-qspi.c        | 31 +++++++++++++++++--------------
 drivers/spi/spi-qpic-snand.c      |  2 +-
 drivers/spi/spi-rockchip.c        |  2 +-
 7 files changed, 39 insertions(+), 22 deletions(-)

