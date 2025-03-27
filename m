Return-Path: <linux-spi+bounces-7345-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACC7A73583
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 16:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F8E03AA016
	for <lists+linux-spi@lfdr.de>; Thu, 27 Mar 2025 15:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB035188CCA;
	Thu, 27 Mar 2025 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mla9Bdys"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20B5186E20;
	Thu, 27 Mar 2025 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743088936; cv=none; b=DtPZTswuwXpQRecHNJ2VKaY4XRHwfOSQFj0/rZVYIobu7B09jh0fMoIt+wMXmkfjIL9bqsz3RxlBYGkjwrFsEW/M4bzW7qmoFPnq4EsI49EYI42exEB+YoUNOt/WMTXx6SLDOg8zo/5F2EIHaH8upxQvP7Q27nPZ8fAhlejoAnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743088936; c=relaxed/simple;
	bh=X0TLkhpwBXqRWu952jz+OM4dgjXpsJcCF9Zfi/SQ5fg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hTCal4K+LULPVf+Pxgruo7rhPnQoSbJ9M6a/8nKxrw4LOfIGxOS82IrMPWTnbswLjUjbV5xeL6wyf8cfsJB75IOzKk9cf5agVPjZjyFOc/sdaqFkO1C8ZjlsNuMfHAI4u1U4/qmRQqh0L7ghTXvlW8DNkXpih2BMui8x7v158XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mla9Bdys; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11236C4CEDD;
	Thu, 27 Mar 2025 15:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743088936;
	bh=X0TLkhpwBXqRWu952jz+OM4dgjXpsJcCF9Zfi/SQ5fg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mla9BdysKHyWjcp2BlpnUGLma9s9M2VOuYYxKlSOs7fnZtMeShRGW/e5q6l0SntFG
	 QW/d/nmOxstv50x5zq8ZCOcsnkUyytC20hjpXM8OSjfKS8UbtiZcJBd2apkKe79UoY
	 3gMUa06ZUKDXmtG/ihjH7OsxgjXjjzY0DaMu37qMSntBjFmjttVnHIZ9bcLeEnmQkt
	 ixz33HIAQtWceSs/OCVK1o0fWGzGAJrZHk3oiMrE/XPVFI+taot36j21F2W+1dshfS
	 duX0XBrnsLT3NW1JTh+4aIeTcf6XefmFG0LB6gPTbKehgmhfca4Bwsxl7q9U829Lwh
	 vt1o/Z5LWwz9g==
From: Mark Brown <broonie@kernel.org>
To: Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <b63db431cbf35223a4400e44c296293d32c4543c.1742998909.git.geert+renesas@glider.be>
References: <b63db431cbf35223a4400e44c296293d32c4543c.1742998909.git.geert+renesas@glider.be>
Subject: Re: [PATCH] spi: SPI_QPIC_SNAND should be tristate and depend on
 MTD
Message-Id: <174308893479.103696.13377418130348788517.b4-ty@kernel.org>
Date: Thu, 27 Mar 2025 15:22:14 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Wed, 26 Mar 2025 15:22:19 +0100, Geert Uytterhoeven wrote:
> SPI_QPIC_SNAND is the only driver that selects MTD instead of depending
> on it, which could lead to circular dependencies.  Moreover, as
> SPI_QPIC_SNAND is bool, this forces MTD (and various related symbols) to
> be built-in, as can be seen in an allmodconfig kernel.
> 
> Except for a missing semicolon, there is no reason why SPI_QPIC_SNAND
> cannot be tristate; all MODULE_*() boilerplate is already present.
> Hence make SPI_QPIC_SNAND tristate, let it depend on MTD, and add the
> missing semicolon.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: SPI_QPIC_SNAND should be tristate and depend on MTD
      commit: d32c4e58545f17caaa854415f854691e32d42075

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


