Return-Path: <linux-spi+bounces-7438-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F9DA7E656
	for <lists+linux-spi@lfdr.de>; Mon,  7 Apr 2025 18:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A642A3AAD8F
	for <lists+linux-spi@lfdr.de>; Mon,  7 Apr 2025 16:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E998320DD42;
	Mon,  7 Apr 2025 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaeehSuo"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C171220D512;
	Mon,  7 Apr 2025 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744042549; cv=none; b=k4cqM/FR9xB+G3olHf30F39kcT+PYwVU9rJt+7nX0d1FLQbX+xTetNKuJ+oQ1jmNT1W7ZG4kM1/i6wh2lPcYTwz2E9lHsu35K2mpkvVxILrKhEfzjnrcLrTWbAINYs8I0FDslfGankjsj3an/szAgVZuF7HOGc9KV1VigzeFSpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744042549; c=relaxed/simple;
	bh=jwWjZ8IZRCm5Tpd6/wkXKA6CzPRNjvqTkb8nkw/MDRE=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=htpB/WH0o00JB8JK9cHNrlZs4IHg2SufV7t7kTqIxv73qwWQaF2nspudhdkwCTXpx2AWx1yniZq4oNIRq3opcfhVP2tZ8Wv8LKoxAkBMlqHS3bJoT66Zhf4j5zqWleR9tWTMg9ovlJ30S92/lvP7MiBkGiNiD7MF4DQ7jBwVKFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaeehSuo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838D0C4CEF2;
	Mon,  7 Apr 2025 16:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744042549;
	bh=jwWjZ8IZRCm5Tpd6/wkXKA6CzPRNjvqTkb8nkw/MDRE=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=UaeehSuoIdPpZ2OveKOrW7YPIfp77H8ruanKQCHSWRFzH+SSdpURMIwyukOBjUWYj
	 LOCmHvMCM2aKfKOz/TQU1LyeVuSnlmYuZMiCaIcHG7/6MlDAOSxhkyqGtzb/Uzf2QC
	 olJIHHRdaNRcOV88BwHdZzhtc0lX0wJ+O/4X96hfI+KYuW+MUzFra+nnEly/9jB6aB
	 looJj7TgmZ3izc0pJ+3VADkzsoYkCKAECTeOzUhFMIwGnb57w3Ir1Q1+2k9OMNSBTV
	 KW+uAPGkXKJKZ80n9HntXkHnPLe2Sxot6NY89itSfPSfsJdAaXJwBeLEEI7dY16ROf
	 Q6CHor7j/A/Ng==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20250331093915.4041600-1-andriy.shevchenko@linux.intel.com>
References: <20250331093915.4041600-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: Simplify conditionals in spi_set_cs()
Message-Id: <174404254825.780717.11094355641514951936.b4-ty@kernel.org>
Date: Mon, 07 Apr 2025 17:15:48 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Mon, 31 Mar 2025 12:39:15 +0300, Andy Shevchenko wrote:
> First of all, the (foo && bar) || (!foo && !bar) when foo and bar
> are booleans is equivalent to (foo == bar). Second, reuse variable
> that holds already the calculation of the SPI CS mode to be
> active-high. No functional changes intended.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Simplify conditionals in spi_set_cs()
      commit: 1f1d979fbf741c3608a344373f88444dc8749967

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


