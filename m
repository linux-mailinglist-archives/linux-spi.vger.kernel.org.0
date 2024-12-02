Return-Path: <linux-spi+bounces-5879-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E37499E0B36
	for <lists+linux-spi@lfdr.de>; Mon,  2 Dec 2024 19:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C80CB3C613
	for <lists+linux-spi@lfdr.de>; Mon,  2 Dec 2024 16:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133261DA636;
	Mon,  2 Dec 2024 16:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KfKDV+/r"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6F31DA60F;
	Mon,  2 Dec 2024 16:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733158268; cv=none; b=hpjjr8cBWT7UHRF6WmAjcoUNKuq7Z3Xaf6KBRjOg9DLEfw4WW1wVup5PjwJNGSz6JAb6rpMByT0O5dAwnwPxDNa8fvV4/EL7Hd6h485NG0LXROM+U+Y0I9wObp2g0P2A7mRXWLLDIEJqtwUGhwVRsdfooL5BM7c4mT1+mENvcNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733158268; c=relaxed/simple;
	bh=fBUEMjz+0P/kF8pp0HP+LWj3OKJjqJ67h1+3fPoQwrw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YcY6CG0L7OPnhqeMZWyUaNB51LLnJbN4jjYEN2FnOyYoNjg0AAc1Wla3kn8N8vNRlz3mIEfDf8ibhyhuP3PTQ+Wohtdmlas4k+4aQepUiihQCKUu0epuYDq8T1vw6svseV6h02cPC7AZ38ZByJRaZGeC4oJbFeOOgC7rv1IVdpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KfKDV+/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36240C4CED1;
	Mon,  2 Dec 2024 16:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733158267;
	bh=fBUEMjz+0P/kF8pp0HP+LWj3OKJjqJ67h1+3fPoQwrw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KfKDV+/rlMGK8H2CF9MyexBUGel/hkJXods3v8auZlpsrKq3OhE34ojMlXAeK2V8e
	 Az7Qc3d20kDInAAGTwOGuOGKcMUhw+bEGRotkX4WfaUGIDz1DmylaiBBOgfMqDEne0
	 EfngdNgQ1yb5US24I24yTs+cI2FoqS5bYfO4qB9IP6yz9NF+RgzuygwHnfqCserh4E
	 KBF5cXNQSt35fnX62Njx/rlnzisDb5LUhdoJYkdoDJSqUur6S1wjFx8ArUqDN8V3gN
	 0vNthRTDU0M3R7YmvbxWh/LERf21LkQoQHNwpvqJc26OWiXg3vN/J8OH/8iWXTKCCx
	 7J06PCyBsobJQ==
From: Mark Brown <broonie@kernel.org>
To: Jon Lin <jon.lin@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 heiko@sntech.de, linux-arm-kernel@lists.infradead.org, 
 linux-spi@vger.kernel.org
In-Reply-To: <20241120012208.1193034-1-jon.lin@rock-chips.com>
References: <20241120012208.1193034-1-jon.lin@rock-chips.com>
Subject: Re: [PATCH] spi: rockchip-sfc: Support ACPI
Message-Id: <173315826479.126887.9104664888049077624.b4-ty@kernel.org>
Date: Mon, 02 Dec 2024 16:51:04 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Wed, 20 Nov 2024 09:22:08 +0800, Jon Lin wrote:
> Compatible with ACPI.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: rockchip-sfc: Support ACPI
      commit: e39531352aed30156b270a61ba075e5b8d3b8498

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


