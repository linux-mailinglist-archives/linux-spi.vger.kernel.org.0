Return-Path: <linux-spi+bounces-12102-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F89CDA0A4
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 18:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 954FA3046EDB
	for <lists+linux-spi@lfdr.de>; Tue, 23 Dec 2025 17:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA5F346A15;
	Tue, 23 Dec 2025 17:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjGPEzKU"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5301F346A0F;
	Tue, 23 Dec 2025 17:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766509639; cv=none; b=TIwm/GN+mJtZBmzISUTk6J4Idoxh+KGj7gdU7wKCLt3nF9MFmEwRLdi2qf9R8Y518Khcc8Y/yCsLd06y+SxiQyjbE6dzYIp0dWda6AliYw+tCpnNsIMCtdFKYKotLeE+XNdu3uPyn/QQKMHDHkVxjSUTL1MFBsHD2V1Jxa3sIRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766509639; c=relaxed/simple;
	bh=7dsW4EYO/ScpJGoqC+hXgz0v3UGrcSwkuxIOEhr/P2c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DRkpIgl3uyqksGrS1t75Mh9Grs6dAzyQpjbRv6f3MrZJHcm+EpPXXRyeq6rIY49fHIS3ZREz+f1F53hLog3AbCrRyK2DMTs4/+X4fg3GjA4tdDcG1GVfvyCbcwo22Hk2VwEPUNH3faboUJ2WoON6IaWuRwlnzSckVnPoogXd6Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjGPEzKU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D08C113D0;
	Tue, 23 Dec 2025 17:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766509638;
	bh=7dsW4EYO/ScpJGoqC+hXgz0v3UGrcSwkuxIOEhr/P2c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RjGPEzKURdBHdBvF0vfSWZIIkzFQ9pdSH8YPRcXTF7QU8LHZTidJLb9qcmHwBHlck
	 5ywoHF5DXxGICN84APvyV0JU/dSmGZddWmnnUZ4aOGIZ0JIQvOP39zFv7znyjcg0T7
	 ZqBTxNfmZG3VZXswa5hCpyslEXFQ+FDwqe4VhivZEryJQwug3oVrj5xLt97xfD8MfT
	 OOw8lSkPbRq9bEwiikIwd487/CLlJNOpSuZi+0D8KQIe5YqxW3mg30R9jKCq1DMvFq
	 J8HsxsQiwo4rxqBjUxQ7G/cxGnk4new1Bft5ud2Q7sCClcBfxcJ8Bs9Rf6UgeaX978
	 x2g4wwAnJ5/2Q==
From: Mark Brown <broonie@kernel.org>
To: Mateusz Litwin <mateusz.litwin@nokia.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251218-cqspi_indirect_read_improve-v2-0-396079972f2a@nokia.com>
References: <20251218-cqspi_indirect_read_improve-v2-0-396079972f2a@nokia.com>
Subject: Re: [PATCH v2 0/2] spi: cadence-quadspi: Prevent indirect read
 timeouts
Message-Id: <176650963782.445653.10248419661863551247.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 17:07:17 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Thu, 18 Dec 2025 22:33:03 +0100, Mateusz Litwin wrote:
> On the Stratix10 platform, indirect reads can become very slow due to lost
> interrupts and/or missed `complete()` calls, causing
> `wait_for_completion_timeout()` to expire.
> 
> Three issues were identified:
> 1) A race condition exists between the read loop and IRQ `complete()`
>    call:
>    An IRQ can call `complete()` after the inner loop ends, but before
>    `reinit_completion()`, losing the completion event and leading to
>    `wait_for_completion_timeout()` expire. This function will not return
>    an error because `bytes_to_read` > 0 (indicating data is already in the
>    FIFO) and the final `ret` value is overwritten by
>    `cqspi_wait_for_bit()` return value (indicating request completion),
>    masking the timeout.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: cadence-quadspi: Prevent lost complete() call during indirect read
      commit: d67396c9d697041b385d70ff2fd59cb07ae167e8
[2/2] spi: cadence-quadspi: Improve CQSPI_SLOW_SRAM quirk if flash is slow
      commit: 5bfbbf0a49ee4b5dcf46a3bfd4cd860d72cc887d

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


