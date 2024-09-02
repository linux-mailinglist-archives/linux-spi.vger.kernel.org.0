Return-Path: <linux-spi+bounces-4516-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D43968D39
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 20:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F5028343E
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 18:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7814819CC14;
	Mon,  2 Sep 2024 18:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UG13USCb"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5192A19CC0D;
	Mon,  2 Sep 2024 18:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725301062; cv=none; b=GJMRrJvm9qh6t25BdVBkeEqCmf7RxtGL874Zjyrc+Exs9e5DJGQxv5m8YzG4Zb/AAafYoGE1mTjtbydUewF6dPP0WBO4QAm0PQsIMm84G5MqtqI8yZPJN/gDCMOs0PktEuz4lU1dPqIq9PyqloiihP/ZHyDwaQ76YJKy6pC8wPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725301062; c=relaxed/simple;
	bh=AVwxwmBeePTqCN4pf5eLvtb6MHFWxYD/GH+1usLVWzI=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OUK6OcUdSfXjgXWJkaY9hu1AJHNuZsAu1fLe6GW50aNfampOhZRJpiUdu8OWpZWZIyjzJTwDwCE2Sl4q2SEYP1ZregqVxw9kZeHSd2rKTELLq4hL1VNSCzrBE7daIZtnLEhw8L4TXNSpgZNuQsSNlMGuLxnGSBahpogbXWC8KXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UG13USCb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F2CC4CEC2;
	Mon,  2 Sep 2024 18:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725301060;
	bh=AVwxwmBeePTqCN4pf5eLvtb6MHFWxYD/GH+1usLVWzI=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=UG13USCb4WiPKsK5hKo0e2Q2F5AQXkG+BcrvDZVRaqacH6oH1JjtLDQ1JYa2ST7kr
	 GakGESD0fSAXtZVeG0rGyJVTTXx6oW+m4YZoNwu1Jjqxinjn+eNfYIF2AAE8D5jFd6
	 U5H5NK2JuETh87Bd+jd1BRfSQ3jt9fv69tV/Z1awr14FyNxChUBuwqnGns4eAffUHz
	 7FOgkfHDFZWKqyclOmjM62oqKb0FupHo0KZcMw0FAaywwPG83WaHjjfvexWJN+rIRp
	 rbIjNLRyQd/qJfGnda6PLZquA86adXgmXB6UqGp5TVoOZgTkek3YGzci0kmj2RvJZ5
	 Pd3a0bjiB+sYw==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240902102853.2476165-1-andriy.shevchenko@linux.intel.com>
References: <20240902102853.2476165-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/1] spi: ppc4xx: Revert "handle
 irq_of_parse_and_map() errors"
Message-Id: <172530105989.141806.10633264451123682243.b4-ty@kernel.org>
Date: Mon, 02 Sep 2024 19:17:39 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Mon, 02 Sep 2024 13:28:26 +0300, Andy Shevchenko wrote:
> The commit had been applied twice as
>   0f245463b01e ("spi: ppc4xx: handle irq_of_parse_and_map() errors")
> and
>   f1011ba20b83 ("spi: ppc4xx: handle irq_of_parse_and_map() errors")
> 
> This reverts commit f1011ba20b83da3ee70dcb4a6d9d282a718916fa.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: ppc4xx: Revert "handle irq_of_parse_and_map() errors"
      commit: 7f9f8c5939b1d729470a15480a4ffb0512d39d3a

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


