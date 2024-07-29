Return-Path: <linux-spi+bounces-4058-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F03B93F9B9
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 17:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFA59B21E3F
	for <lists+linux-spi@lfdr.de>; Mon, 29 Jul 2024 15:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522FB16A947;
	Mon, 29 Jul 2024 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCCD3M2X"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EFB15F319;
	Mon, 29 Jul 2024 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267606; cv=none; b=PhUDA4+GMFHwFXKgH0YoFUGQIkikMCHVvtdJYLpn5+VxBHENWSuBf+sywfGnuU/JHR8hK4Mg+77WodCWVGLSlKyZmwe8a4935DjTWr7xxFSbcdO2OIQi2jtQ+CLj/8QEsPziMB+4kubcXUc10J6X0Uem1hn1S9UO/hnrNV2geWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267606; c=relaxed/simple;
	bh=47EqZfBaUe/5LonR+HQxJkr8GJZJS60ewq7NIhd/nQY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t/J84h7hN1YkYXzDgBZSkZLHygf6HQAeBzBt/zDRGHDfS1pTUAReao6eSMxJTtXh8BDOmF5EHMMjZzjJm7UixjWfoXguCiScHCTV0rHReE0Way15w8ESB9AyZFyoWQV1q1t2xP3s9sISks6OfuPSz2OgPSgMDzkaCV7i3NAImIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCCD3M2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A939BC32786;
	Mon, 29 Jul 2024 15:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722267605;
	bh=47EqZfBaUe/5LonR+HQxJkr8GJZJS60ewq7NIhd/nQY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JCCD3M2X08hIsWD0NTHNJPC3iNkh8XFv0Ujkge4MyfnAiiwLDHqOSLpmBME3kdR86
	 OFLhQRidGGw8nl/mcedKHMIVNoKayotbdji0BK5IB1EQyEG4Rau08hFhQ9mp27dw9E
	 7gVxG7ru2And1kFOJaO0ViKhHuC1Nkkmnz2FeXbXpq+flASpnbyBoaSTAJgtSwzq64
	 xZptaoCx/H99jIQjriT8S/+yTh8i6Qhrf8csxbi7vxlqanclJjaVBx6D9Bfs8x0xPj
	 WLWtJE4U77LWWTtmk5jsYk9hwAzRQ0NpSWZ78mf6Xc0ZnBvAikDBHhbHUyxa7Ep/Ki
	 RFVJQRN5RT2EQ==
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240723-spi-axi-spi-engine-opt-bpw-v1-1-2625ba4c4387@baylibre.com>
References: <20240723-spi-axi-spi-engine-opt-bpw-v1-1-2625ba4c4387@baylibre.com>
Subject: Re: [PATCH] spi: axi-spi-engine: don't emit XFER_BITS for empty
 xfer
Message-Id: <172226760441.71144.6653043973545579426.b4-ty@kernel.org>
Date: Mon, 29 Jul 2024 16:40:04 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Tue, 23 Jul 2024 13:36:47 -0500, David Lechner wrote:
> This adds a check on xfer->len to avoid emitting an XFER_BITS
> instruction for empty transfers in the AXI SPI Engine driver. This
> avoids unnecessary delays caused by executing an instruction that has
> no effect on the actual SPI transfer.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: axi-spi-engine: don't emit XFER_BITS for empty xfer
      commit: f8918ef1267edab4d9b2154c22a912c87cc66f66

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


