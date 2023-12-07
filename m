Return-Path: <linux-spi+bounces-167-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B130808959
	for <lists+linux-spi@lfdr.de>; Thu,  7 Dec 2023 14:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76DF01C20B35
	for <lists+linux-spi@lfdr.de>; Thu,  7 Dec 2023 13:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2631540BF0;
	Thu,  7 Dec 2023 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjLPZIg8"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070193DB99;
	Thu,  7 Dec 2023 13:38:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7E5C433C7;
	Thu,  7 Dec 2023 13:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701956337;
	bh=LrKFalPpX4ro1UCj+XeZRPkOqxKYC9UU2FyCF0mGy08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kjLPZIg8FFgsaWRJGrgM6lwAFRaMTuWNUEdoEZvWuxAYsk5rD+M9zXvKHaXN1xlrS
	 hXU/HzHP6fXanl92P/HT69g0DluwYbE+xs8k7PpcJ2g50JRXKnct5IOFVJ0TtPo+dm
	 pLPZxW2WmIq67oYfevuMMtKStccsxVUdN7fZqGVpgksCsyRPTkrDtHNZyG2ODFUjsw
	 1mcvjtPeWPGKEj4DxkbdpVd4shxELDPBf+Uq9viCxEFQid8zyP1ekkbsfPmESx8jna
	 /On7CAGQCWJntcZabaDryMMDMWorCO6m+gEZjEAQ6MIGGThmYxQ2cfF5IQHlPzG4Bh
	 TS2sianKt7+dQ==
Date: Thu, 7 Dec 2023 13:38:49 +0000
From: Lee Jones <lee@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: tudor.ambarus@linaro.org, pratyush@kernel.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	sbinding@opensource.cirrus.com, james.schulman@cirrus.com,
	david.rhodes@cirrus.com, rf@opensource.cirrus.com, perex@perex.cz,
	tiwai@suse.com, Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	michael@walle.cc, linux-mtd@lists.infradead.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, michal.simek@amd.com,
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
	git@amd.com, amitrkcian2002@gmail.com
Subject: [GIT PULL] Immutable branch between MFD and SPI due for the v6.8
 merge window
Message-ID: <20231207133849.GB8867@google.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <20231125092137.2948-2-amit.kumar-mahapatra@amd.com>
 <170142465659.3329910.8527538140063947758.b4-ty@kernel.org>
 <395caa58-a8a0-4c75-85d3-4fa0f6f4a9ba@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <395caa58-a8a0-4c75-85d3-4fa0f6f4a9ba@sirena.org.uk>

Good afternoon Mark,

> Is there a signed tag available for this - without this change the
> subsequent SPI changes introduce a build breakage.

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-spi-v6.8

for you to fetch changes up to 4ae08845db4c1f759b8382bc7527ab8249230e7f:

  mfd: tps6594: Use spi_get_chipselect() API to access spi->chip_select (2023-12-07 13:36:29 +0000)

----------------------------------------------------------------
Immutable branch between MFD and SPI due for the v6.8 merge window

----------------------------------------------------------------
Amit Kumar Mahapatra (1):
      mfd: tps6594: Use spi_get_chipselect() API to access spi->chip_select

 drivers/mfd/tps6594-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Lee Jones [李琼斯]

