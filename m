Return-Path: <linux-spi+bounces-11898-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFE3CBE964
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 16:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BD6B301D614
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 15:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4E03321CB;
	Mon, 15 Dec 2025 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSKRkvrJ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4388B3321C5;
	Mon, 15 Dec 2025 13:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807174; cv=none; b=TycpiE9Ez8sgYy176kutFq0bntcNzS89wvMdwPL4D45DQaCWgIQ3baCJH4XNkuI1wLhZ5laGV3sMT+uDGFvUWogxsmlxoI6zuR/eeEJYsBWQvCOolMULfNoCtHZp5A45P7zSIMYFikuP/Ya2qfe4VHBv7kerTMkv26N5YU5UXzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807174; c=relaxed/simple;
	bh=mUdPC/Zc8jOj+LQYMtJZ0IsCJFmwN6mnkenGPRzbU6c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FIXdDTchHcM0UDxL2jZnFfFfW5M/tMlLcg69bQtyz6V93WiJ5mjJk6gx9aFHICbAnWZOD8KNEL6z5ILlV6bz5nzY3mlUpsTrEy2QQKmf83+SWvO8XWYkSuA5RBpK8YGC+ZuUOKjMG6HOmx9SNtUdMBxsmMexuYqF+oNWYsrsT4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSKRkvrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0B4C4CEF5;
	Mon, 15 Dec 2025 13:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807174;
	bh=mUdPC/Zc8jOj+LQYMtJZ0IsCJFmwN6mnkenGPRzbU6c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZSKRkvrJSLy3JMUHG9kXP2Oj5isQuIIEsPOnAu7lX9qP/SyIaksgWPQdb9t1rk4Hz
	 WyMYDqUp83ieEQcZ0KPTcx6dtoJp3zZ9PyUqTB5n9BeiQ+FNwoQY+f7bkGWL/JeLaT
	 d2hqwMcOoizEkiM40Yq1LELy1I0+2yS2EvVEuDJzMujcrd4L8oj9c74kWwfHHqoukn
	 V2JCtApgI1bJVgjMowxh/gQk/UOkK6JxtouZZPf4BnXRmc6tjJMsR1LokPLq5KKsH8
	 q1aZb+9muIzvUBG8ckq/O0eSdDjw1DTU1Q5XFbRJv8Sn8mMxW3hk2DAPIYt2DXbt/e
	 c4gqMPz2Plumw==
From: Mark Brown <broonie@kernel.org>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251201134229.600817-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20251201134229.600817-1-cosmin-gabriel.tanislav.xa@renesas.com>
Subject: Re: (subset) [PATCH 00/13] Add DMA support for RZ/T2H RSPI
Message-Id: <176580717199.161463.3915595459908387302.b4-ty@kernel.org>
Date: Mon, 15 Dec 2025 22:59:31 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Mon, 01 Dec 2025 15:42:16 +0200, Cosmin Tanislav wrote:
> The DMA controller can be used to transfer data to and from the SPI
> controller without involving the CPU for each word of a SPI transfer.
> 
> Add support for DMA mode, and do some other cleanups while touching the
> same code.
> 
> The dts changes in this series depend on the DMA series [1].
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[01/13] spi: rzv2h-rspi: fix rzv2h_rspi_transfer_one() indentation
        commit: fb0140774aff45b8dc326987cc1da89484ecb081
[02/13] spi: rzv2h-rspi: remove call to spi_finalize_current_transfer()
        commit: 9e4830b35dc0d522f45e1ec3ee5b1ff1648afe1b
[03/13] spi: rzv2h-rspi: do not set SPI_TRANS_FAIL_IO
        commit: 218917659df165cff72439480929e68a6e127b55
[04/13] spi: rzv2h-rspi: use device-managed APIs
        commit: b73ac782828f27c2217a17bd26aa8710769f032d
[05/13] spi: rzv2h-rspi: store RX interrupt in state
        commit: 28b590bd4c6a051ec61cf286a46a8b14846e6fcf
[06/13] spi: rzv2h-rspi: set MUST_RX/MUST_TX
        commit: 6f9026b5a18acdf190d1622831b100aacfca0eb3
[07/13] spi: rzv2h-rspi: set TX FIFO threshold to 0
        commit: a886baaaa6e12a9b7d5a9687d11d3b895f1b87c9
[08/13] spi: rzv2h-rspi: enable TX buffer empty interrupt
        commit: d49eea07de5851e1b8941ad6b6179be7ec36a986
[09/13] spi: rzv2h-rspi: split out PIO transfer
        commit: 1e5e10df8b9be71ca64435cbe7c96b189e5ee293
[10/13] dt-bindings: spi: renesas,rzv2h-rspi: document optional support for DMA
        commit: 163345e356722e98ba57cd120787d6e991da7b1d
[11/13] spi: rzv2h-rspi: add support for DMA mode
        commit: fa08b566860bca8ebf9300090b85174c34de7ca5

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


