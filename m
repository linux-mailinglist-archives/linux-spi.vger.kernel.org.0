Return-Path: <linux-spi+bounces-9516-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE943B2B279
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 22:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DBCB1BA2469
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 20:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A0A222578;
	Mon, 18 Aug 2025 20:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQEVHSl+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07181E51FB;
	Mon, 18 Aug 2025 20:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755549350; cv=none; b=B/kimMFfhdtgJtSFuTFt8rfP5py4gZvV2C/Tc/a/X3xiov6GI0qUgxATVmuoGbjshpxS/aGcVwz4adhhXSfugWGfYrCbKZoM5861/BwEqZzYBLoskyDE0AV/mdVfZwSReevp1r9DR0nMjOgDo3vbSooHKd0Y51/dquDV4ZmY014=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755549350; c=relaxed/simple;
	bh=om2cfshnlMUz7DuvRjvZA14In9sewmxBtmoNs13zHqw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KYJJumbySV3UDGTp8wvIZVySvDKqT3O4KYSwVIzgZBdeHpQPcEjKtT2mJ64CA9MdioZUMf6VUH2IbYbX5LxSi2BOsvYWgpZ4qd5cLKv8B6r7qQu8aIAUGJlfkMvj4KWkos6kPs/7gRBpkngPLfuRUAqVWCMwhd/UHzR6CxVcQDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQEVHSl+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1177C4CEEB;
	Mon, 18 Aug 2025 20:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755549349;
	bh=om2cfshnlMUz7DuvRjvZA14In9sewmxBtmoNs13zHqw=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=uQEVHSl+duq+dWLUD9eW7eVtnhv2PmtTTxGShiVKLaoXm1AZwNzmFVVwBWbNLfnKg
	 94Rptxkq/91UxwElGtWNKiw3S7i/v4rMR6FWZ1ZU6f3UTJDV4YDtGBJ0ulG1WCgOz1
	 DSfa1jXtrrqlrbJE3cTEvmqjW4E2SWvBobJJfxl9qWfPRA16kgHJSoJ3jTGBtyUbUZ
	 0LNddIr0zP9JhbNdc9h62WWL6M/vUZYDls/huH7FMIPUj5utoSBbq8q1m+fUwsl8aF
	 N8Sv1p/4cz8QAo5VRqq6szY9e76eJ2vUc4mEZbqVB2J7MYIXScGH1mPu08d67/1H49
	 XmSHZe5KSNIgw==
From: Mark Brown <broonie@kernel.org>
To: Frank Li <Frank.Li@nxp.com>, Avi Fishman <avifishman70@gmail.com>, 
 Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>, 
 Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>, 
 Benjamin Fair <benjaminfair@google.com>, 
 Linus Walleij <linus.walleij@linaro.org>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250815082118.586422-1-rongqianfeng@vivo.com>
References: <20250815082118.586422-1-rongqianfeng@vivo.com>
Subject: Re: [PATCH 0/3] spi: use min_t() to improve code
Message-Id: <175554934664.130972.8355246635589446804.b4-ty@kernel.org>
Date: Mon, 18 Aug 2025 21:35:46 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Fri, 15 Aug 2025 16:21:14 +0800, Qianfeng Rong wrote:
> Use min_t() to reduce the code and improve readability.
> 
> No functional changes.
> 
> Qianfeng Rong (3):
>   spi: spi-fsl-lpspi: use min_t() to improve code
>   spi: npcm-fiu: use min_t() to improve code
>   spi: spl022: use min_t() to improve code
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/3] spi: spi-fsl-lpspi: use min_t() to improve code
      commit: a750050349ea138e3e86c66a8a41de736619b9de
[2/3] spi: npcm-fiu: use min_t() to improve code
      commit: 1bdc716023a78c2c41fdcb3fc37f09da1be4b7df
[3/3] spi: spl022: use min_t() to improve code
      commit: 90179609efa421b1ccc7d8eafbc078bafb25777c

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


