Return-Path: <linux-spi+bounces-11904-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9FACBEDF2
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 17:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F1B5303C82A
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 16:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF9D33372E;
	Mon, 15 Dec 2025 13:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRvTVGsi"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D00333729;
	Mon, 15 Dec 2025 13:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807183; cv=none; b=nap/JrrqMRzHMSEx+8aJNryq2qn4XwGL3iBkXYpDADd6oTDFQzrlbL5GvDVuU9P6gSW2HrHdbZMwYqa83b3RmLpj7O5i04MeNw8w4dTF84U+D0oKP1oYzaJZQk8W0JnU3FjnTAPrwaxfE6zJLPGqV9j/3NAUu9M7y2KP1561Guo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807183; c=relaxed/simple;
	bh=PewTW4AaNuO1z6+tza9d8jJJPxcvQt9Iln1/7W2lyJk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a0vhBW0IT0OQDwEkhVvbTkFzvpi+G89D7JBX1xKEnnOPal3Y/uRCPu6gqBUbLrfBGR2w0AjgqjpKSiY9Sxw5Xw/57+aLoEcvpkYxsFCSNNyaJJ9bcmEblGWnSiDaw7POW2eTeSji4o/sZxfETn/ImkRufVpV34L/ngZp7WwLcnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRvTVGsi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D32EEC4CEF5;
	Mon, 15 Dec 2025 13:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807182;
	bh=PewTW4AaNuO1z6+tza9d8jJJPxcvQt9Iln1/7W2lyJk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VRvTVGsizZctuDZ6e+dn/YLRjInt6Z5rTd5T5RVHKnuOzjuEGSd0CqRqizhGIFhpo
	 7iW6x8T5Adx5oFFMw1AnkcCVO8MX0NmwkSWXMp1RwTbscnJaLU3oyICMvxORT4DrFq
	 7XparywzC4JMpe/m34zNTZ6lOWPJb764BFuuU1VypF5h4fR3/uq6rxyIT+p/lDTQXW
	 /seRNrlSJ+8WMkibUNuEHLz6stcnj8EUJQ8AESDCLgUCxaShMBAA0byouQXnB8QSKa
	 MdRO664hE5bxE0ZPIxlPjE70hUiM849R0lb78+5nKKjOkibkDTS+B/2FqCB/5yUVGI
	 kzHpDx48lDQvw==
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Christophe Leroy <chleroy@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "florent . trinh-thai @ cs-soprasteria . com" <florent.trinh-thai@cs-soprasteria.com>, 
 stable@vger.kernel.org, Alexander Sverdlin <alexander.sverdlin@gmail.com>
In-Reply-To: <3c4d81c3923c93f95ec56702a454744a4bad3cfc.1763627618.git.christophe.leroy@csgroup.eu>
References: <3c4d81c3923c93f95ec56702a454744a4bad3cfc.1763627618.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] spi: fsl-cpm: Check length parity before switching
 to 16 bit mode
Message-Id: <176580718122.161463.3716236495970643565.b4-ty@kernel.org>
Date: Mon, 15 Dec 2025 22:59:41 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Thu, 20 Nov 2025 09:34:49 +0100, Christophe Leroy wrote:
> Commit fc96ec826bce ("spi: fsl-cpm: Use 16 bit mode for large transfers
> with even size") failed to make sure that the size is really even
> before switching to 16 bit mode. Until recently the problem went
> unnoticed because kernfs uses a pre-allocated bounce buffer of size
> PAGE_SIZE for reading EEPROM.
> 
> But commit 8ad6249c51d0 ("eeprom: at25: convert to spi-mem API")
> introduced an additional dynamically allocated bounce buffer whose size
> is exactly the size of the transfer, leading to a buffer overrun in
> the fsl-cpm driver when that size is odd.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: fsl-cpm: Check length parity before switching to 16 bit mode
      commit: 1417927df8049a0194933861e9b098669a95c762

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


