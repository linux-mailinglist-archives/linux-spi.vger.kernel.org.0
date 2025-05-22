Return-Path: <linux-spi+bounces-8242-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F65AC0DC3
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 16:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B47D3AEC23
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 14:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BA628C2B6;
	Thu, 22 May 2025 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9EBHbiC"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2769928C02B;
	Thu, 22 May 2025 14:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747923070; cv=none; b=IkO6REKvQs8jQswKvfzsl5emJVXS9m5d6pVBSJ6uNpa8J0/UMLSj464K6Kt5OTXHqlLQVdC4huBdxjq5P/aiiBfMHznhT9I4BTsAVS/0O/pCijZXSieLdhSdD9RMw7o5/Y6QzhGEypbeEkY51aMMB0I7v4aVNdvXoeDjdNTcXeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747923070; c=relaxed/simple;
	bh=/MBfOwcREwPbqSvoK6aidbf9sfzyKPYatjhjOUfkFmw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=sisuAZnFoZUxAyWJZyp9nprfHkD/MfLlNj8mSEVO99fmaX2pkk5Y8ylREzp7Rl1aS9c46TrtEdPD5OGk5QN+5xFSa1fnJx0FxfK4aEHPh7oItQUGuqtYJBMwRUYv9s8+baqxQMG7tvjdbnmtz/fB1SW9T29jzi2cgFJGvGBtijI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9EBHbiC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF798C4CEE4;
	Thu, 22 May 2025 14:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747923069;
	bh=/MBfOwcREwPbqSvoK6aidbf9sfzyKPYatjhjOUfkFmw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=O9EBHbiCjfP7MpfRFP+1niuVuIzpY0P5yAFYl/AEv8xFV2GifjxJ8jq6vs1WSVMEp
	 xKKdRoZD6A4qI4W2+P8GM3cSO1+pehScrjN8WMdD8DiW5D5Hf2zK/en872JfQhdVLB
	 HFe/x9hCnZc3qpBtICDq5EorRkHfW7WNq6VMa5KeD1utpDblQ1724mIeBoi/4E0nEp
	 CQhEdeAaAWf6FHzfl7YnMQ8QJbvSy6Czo0L5bwie+0hdbLtDNLJ5vpJCBF8xugwH8E
	 Ul2eq1XxoNJIylEVCIa9KtLZCqkARFQX/lNB/Q5iopI17708PRCyhENn6gPyYBS5Dk
	 3cZHGVZ8gAa2A==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2025052230-fidgeting-stooge-66f5@gregkh>
References: <2025052230-fidgeting-stooge-66f5@gregkh>
Subject: Re: [PATCH] spi: use container_of_cont() for to_spi_device()
Message-Id: <174792306871.93788.12995435193325087617.b4-ty@kernel.org>
Date: Thu, 22 May 2025 15:11:08 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c25d1

On Thu, 22 May 2025 12:47:31 +0200, Greg Kroah-Hartman wrote:
> Some places in the spi core pass in a const pointer to a device and the
> default container_of() casts that away, which is not a good idea.
> Preserve the proper const attribute by using container_of_const() for
> to_spi_device() instead, which is what it was designed for.
> 
> Note, this removes the NULL check for a device pointer in the call, but
> no one was ever checking for that return value, and a device pointer
> should never be NULL overall anyway, so this should be a safe change.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: use container_of_cont() for to_spi_device()
      commit: 1007ae0d464ceb55a3740634790521d3543aaab9

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


