Return-Path: <linux-spi+bounces-5578-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9B19B91BB
	for <lists+linux-spi@lfdr.de>; Fri,  1 Nov 2024 14:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EA06B23647
	for <lists+linux-spi@lfdr.de>; Fri,  1 Nov 2024 13:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7302F4503C;
	Fri,  1 Nov 2024 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7oUxQUk"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484324B5AE;
	Fri,  1 Nov 2024 13:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730466961; cv=none; b=FHlUY3wrg05my0g7QyTG8YgImahARwd91OneEoFzRvXEIrW0sZ8PLutrWW29JRYcutFeZvZ7FSYfb6zSo2qtDqv2XndorWBf1+pVMFELB9wIAnw0TPASOxnDEn6Pbbs6krC3YEj4Tx8Y5QSk7zKmPrZtRDkX/EjVn3OUgEYXegw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730466961; c=relaxed/simple;
	bh=83dBsd5FNSBx9l+cQnxVLMQfc9PYaoBVeH8Qpu6dCL8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Iw34YqRGR5Qx6qPjml+xZwYtkXTZOtktV7bOjJO8Ox3xYk70JYqGOMypQZ6ykCijE280n7y4HL6VbWX8n92ZbGtSor1F6dSrUu02DIiqIz2VgOi0nBFDi8Oa4W36c0KENmwMqi0+AtqyxEMWijV+O7Vaswi0qiAktWP8e7SxPFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7oUxQUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E619C4CED4;
	Fri,  1 Nov 2024 13:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730466960;
	bh=83dBsd5FNSBx9l+cQnxVLMQfc9PYaoBVeH8Qpu6dCL8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=d7oUxQUk5BPrQwdKOn6vN/oJPox2Hjvzcf0tSFhmWCSiLsY6b5vAXxj5FkdhZnqzk
	 RYTCwtbyFP+bBSIbmfCA7d+iQcRKlX3TfxqsBu+ckU0BTKqqjsanskZdzCxcgGOzfH
	 1zpaKidNM+4+LCkesGBEvSUOpwSYmV+RvXPC69J5vcKYdM+D0nkjxqIh1X5CXAoLgK
	 knFFxcUJP5W/w+MibhJCXf82yNNWgEDxP+yFFuhQY9UjR45kmVeWHHpBbGZBLTaCeT
	 NRN7gdIJziMu4oXa77f/d0uNy+7omO3mRWOwtT0ZgZU3Pkymk/ZVwnZRhm5pjsamAc
	 sSi0L0UwVflTA==
From: Mark Brown <broonie@kernel.org>
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 linux-trace-kernel@vger.kernel.org, linux-spi@vger.kernel.org
In-Reply-To: <20241031111646.747692-2-u.kleine-koenig@baylibre.com>
References: <20241031111646.747692-2-u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH] spi: axi-spi-engine: Emit trace events for spi
 transfers
Message-Id: <173046695891.38603.7730462625881979641.b4-ty@kernel.org>
Date: Fri, 01 Nov 2024 13:15:58 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-9b746

On Thu, 31 Oct 2024 12:16:45 +0100, Uwe Kleine-König wrote:
> As this spi host controller driver implements the
> .transfer_one_message() callback, it has to care about these traces
> it-self. With the transfers being compiled it's difficult to determine
> where handling of one transfer ends and the next begins, so just
> generate the start events in batch before the hardware fifo is fed and
> the end events when their completion triggered.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: axi-spi-engine: Emit trace events for spi transfers
      commit: e36eba413b8e841e9e36e93188d82674ec7c79d1

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


