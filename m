Return-Path: <linux-spi+bounces-6865-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E50A8A3AAED
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2025 22:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00035188C4B5
	for <lists+linux-spi@lfdr.de>; Tue, 18 Feb 2025 21:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6661D9595;
	Tue, 18 Feb 2025 21:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYtmVXqZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528A11CDA0B;
	Tue, 18 Feb 2025 21:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739914233; cv=none; b=h96hKusrbjdpibFZ8MQTP6BO4Q7W/xH33bJVW4lPM99510hhhLVsIihFmAgHgZwQxBBxlvOUyyhrMkkHoMHJc/nh2EZSBIy+ZtVy+BXZw3/Dg0M0zUY+0b3VtGwMYGTblXKqJQvv4dkyruSt+JpjvY8I2qYYy2q9bCgPO6CNlis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739914233; c=relaxed/simple;
	bh=xTa/0OwWZJ4BHR0ud2dUS1dB2jaa8N5kkkcbjzF4Os0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EnNf5qwKM02r3SysEl3OOeINPjKYyGfIzoTi+MzOGG+Fo0z962h3+j43V04Eo++2xyZh6LzGWTdeHRoreOX5WpFZzKeISkDk1t23m2TgZ51APVCPTgXUjWIoqe6JEKR4Gmhmn0y6L7uyYTXo88/1DLlAflPG0Wk2P4VR102ZUtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYtmVXqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8A6C4CEE8;
	Tue, 18 Feb 2025 21:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739914233;
	bh=xTa/0OwWZJ4BHR0ud2dUS1dB2jaa8N5kkkcbjzF4Os0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=bYtmVXqZym8wab8Y/7uCcT0VALemF8xHwzf20/ocZ+Xj3DVpYcVh01qKOqzvHCu0o
	 mpJ/dRmH+kpkifuXUfhffGn8RDTs+WMXsP1aLL0pt0GKsPOd8lFtCQR/LQX2U54Q0W
	 6fE3lWBhEFepM/tPAf+8sJHASaPzjqwcA5tSWIHlX7U5rJgX+T5cl6mOVu6bCBQIcv
	 kcO0M2dnOaWpI64hm/xcirStHWtgpvdzE/U0MOFHqq6U3/jialo+7qaCny30asB5N/
	 GN0WFvHw8+4fgxft+5GlR21Yul1mLnbqJc5LR7nFDXHfwyaF0Wi7hXFVC4FA3+P69X
	 nBTW1esinGBdw==
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Nuno Sa <nuno.sa@analog.com>, linux-spi@vger.kernel.org, 
 Lukas Bulwahn <lbulwahn@redhat.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Lukas Bulwahn <lukas.bulwahn@redhat.com>
In-Reply-To: <20250217092851.17619-1-lukas.bulwahn@redhat.com>
References: <20250217092851.17619-1-lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: adjust the file entry in SPI OFFLOAD
Message-Id: <173991423052.1713526.6394807497548942772.b4-ty@kernel.org>
Date: Tue, 18 Feb 2025 21:30:30 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-42535

On Mon, 17 Feb 2025 10:28:51 +0100, Lukas Bulwahn wrote:
> Commit 8e02d1886988 ("spi: add basic support for SPI offloading") adds a
> new MAINTAINERS section referring to the non-existent file
> include/linux/spi/spi-offload.h rather than referring to the files added
> with this commit in the directory include/linux/spi/offload/.
> 
> Adjust the file reference to the intended directory.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] MAINTAINERS: adjust the file entry in SPI OFFLOAD
      commit: d1a09c610027e446ed30c21f61c2f2443bf92a3f

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


