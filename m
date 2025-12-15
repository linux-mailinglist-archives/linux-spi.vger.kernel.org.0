Return-Path: <linux-spi+bounces-11906-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5D5CBE381
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 15:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CE8F302AAD5
	for <lists+linux-spi@lfdr.de>; Mon, 15 Dec 2025 14:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5064233469D;
	Mon, 15 Dec 2025 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Se0Bz+j9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277D3334695;
	Mon, 15 Dec 2025 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765807186; cv=none; b=ndRF7OAbb/NT/UkYTnSKLqcKZjyTA02NTh4USCLqXzViBpEuYoprynkwaqH9pmJjnu4v0KL/CwXiVTiYeXw0GhsmC64OxWyA3cThWjorMDZvz98OACKb68iDWvJ+df1gzFJRcK7S5S1VLJ82KwJ5eG+obko/4+hFqbRVeu/Mwrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765807186; c=relaxed/simple;
	bh=KOAvoqG7RnTWQZeujmBk7U/h4REQ9si9oHsscWJ0Z1E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Pa0C5nAsdMfpCHw7GZDo6Km/fn4G2w+mNmg/Q/clRJmNrq6UMQuvCSHZGWTNNDRM+54aleFftg1TQneiCRIkaeGZfnNFyXWXv1H9gQFXz8MlrTGJfqjUjuyR/gMYyQ7cdZwTW20AjoiL+UO6VjFffZbVPvrPzmiF2JMFIBzjf5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Se0Bz+j9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60CDC4CEFB;
	Mon, 15 Dec 2025 13:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765807186;
	bh=KOAvoqG7RnTWQZeujmBk7U/h4REQ9si9oHsscWJ0Z1E=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Se0Bz+j9E6Ig2JOTIrffmOVI26Cnyw2L6LpypgVoJlNUoPwpzTfglr1p3QLdiyEuX
	 iM0A3hf/cQcXntvR1aZP6Go7c5NjXUgtc6NWSrDU8+UVH54LuQOn+mQYdcUD8WACbL
	 TE+dod2OnSiKfWq3FeZ+ztrKGn+4yMArEbyj8flv2orfJcyDKGDqgZaBHKyiP7T9Gr
	 f44lBwS59EabRFjINjFb2wanSS26c8/cRLKEO0Mms2q0GrZoXLVuLDj4y/VsQnIaBq
	 lzouUHQDKs1j2sENAe8fv0Fh6G3khRj5w3Re7bClr0MLDjoYx4mUoy4WJaHzyIe+ja
	 K39NApFPNubhQ==
From: Mark Brown <broonie@kernel.org>
To: Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org
In-Reply-To: <eb35f168517cc402ef7e78f26da02863e2f45c03.1765612110.git.christophe.jaillet@wanadoo.fr>
References: <eb35f168517cc402ef7e78f26da02863e2f45c03.1765612110.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] spi: mpfs: Fix an error handling path in
 mpfs_spi_probe()
Message-Id: <176580718430.161463.4850754049730233485.b4-ty@kernel.org>
Date: Mon, 15 Dec 2025 22:59:44 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Sat, 13 Dec 2025 08:48:51 +0100, Christophe JAILLET wrote:
> mpfs_spi_init() calls mpfs_spi_enable_ints(), so mpfs_spi_disable_ints()
> should be called if an error occurs after calling mpfs_spi_init(), as
> already done in the remove function.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: mpfs: Fix an error handling path in mpfs_spi_probe()
      commit: a8a313612af7a55083ba5720f14f1835319debee

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


