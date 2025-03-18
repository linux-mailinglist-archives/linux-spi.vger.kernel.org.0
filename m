Return-Path: <linux-spi+bounces-7199-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99972A677A3
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 16:23:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C7F3B7BD0
	for <lists+linux-spi@lfdr.de>; Tue, 18 Mar 2025 15:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5140020DD7B;
	Tue, 18 Mar 2025 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gElGlAtu"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28242207650;
	Tue, 18 Mar 2025 15:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742311375; cv=none; b=Rb+xxpK0hsMSX3SE2xMqdiM/uAuH68i57O34/KxcsZxJmaLZ/oL966GfFLgkbrhzmPLiJ/BCpRvqInF8VKItSB8GkBU2ti0v+POyIQJc+FF+2GnUkjC6rnODP/IDNG7C+izQ7Y6Bk11Oul55SvLBXsi3Ush1TxCXQfxx3oku1/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742311375; c=relaxed/simple;
	bh=ExbiN67x9Jf7lCjrAIardU0iY1Vq5vkYWTWumMPVBYE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Za/cG7cvQ1rXhwcxtyl+V3XRphdNu3F2FtyEPaqtAFF03BG7na1bAMygtR8/IJFrtQuoK3HLv+4Zq1/sCcwK9ir7udDv5wS135y8e94RyrU1KJQUh66EcE+W8b4FY4DAwWaTRuXhR1za4tgXSaKgCoaWMmBPVfOyqJIvmRJ1pn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gElGlAtu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F37FC4CEE3;
	Tue, 18 Mar 2025 15:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742311374;
	bh=ExbiN67x9Jf7lCjrAIardU0iY1Vq5vkYWTWumMPVBYE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gElGlAtuBQh2EcWHBKJuqFKO7l5pahbGlX7203e5+cLgoTJA6n7N1yae5u97XsOTu
	 L/yvw9/QivhRC0iVgxM5CjLaNF+eDUrJPlXwLKwErc0HrNEOqdsw4hDRT2JWYnraE+
	 2PWpyjHnTRGUtnzktpKGZam3RZnAe83qOJxdanN0b53NhAvu0u9cy9+yAl0tv4kdmw
	 at7gHMirGo+d6WC0tRpbhBZ7N7Guh94l4193WkrHsqlLo32glUHTQdY84T16fbSKge
	 dQoMJyVz8zN04ywNr6Pie4JkwXiBXWGgpq1Hi5fsgl7QJYnAOs5WhpwUPA60sYrI05
	 7da0PfPrE0W0A==
From: Mark Brown <broonie@kernel.org>
To: Longbin Li <looong.bin@gmail.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <79c71b81-73a9-407d-be6f-481da27180bc@stanley.mountain>
References: <79c71b81-73a9-407d-be6f-481da27180bc@stanley.mountain>
Subject: Re: [PATCH 0/2] spi: sg2044-nor: fix a couple static checker bugs
Message-Id: <174231137374.151099.386870711250177057.b4-ty@kernel.org>
Date: Tue, 18 Mar 2025 15:22:53 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-1b0d6

On Fri, 14 Mar 2025 13:10:04 +0300, Dan Carpenter wrote:
> Here are two fixes for Smatch warnings.
> 
> Dan Carpenter (2):
>   spi: sg2044-nor: fix signedness bug in sg2044_spifmc_write()
>   spi: sg2044-nor: Fix uninitialized variable in probe
> 
> drivers/spi/spi-sg2044-nor.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: sg2044-nor: fix signedness bug in sg2044_spifmc_write()
      commit: 16c6cac2463d57d3dc15057937fd7aedacff656e
[2/2] spi: sg2044-nor: fix uninitialized variable in probe
      commit: a1d8f70954f69e333b252795808164839bb2e7cf

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


