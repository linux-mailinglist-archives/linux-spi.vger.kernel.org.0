Return-Path: <linux-spi+bounces-4096-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77699416C0
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 18:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 611D7282E5C
	for <lists+linux-spi@lfdr.de>; Tue, 30 Jul 2024 16:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D03183CA1;
	Tue, 30 Jul 2024 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHOQaj++"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1078A187FFB;
	Tue, 30 Jul 2024 16:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722355413; cv=none; b=jcCoqCagj6mvosU0MDGDvDt47xpP430wU1/H8gzISFZCRRh5CJXzU8aC52BOK+RFII8GV8+9DbOlLb6f5X44/DZ7AOl5thdf1wWkd0Wt1C7vrcTwcIcg5r9C4HJvE7YB/2FFpvX7vtvwKeSTA4ekc32zP9VhOW+foX269Xh5rPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722355413; c=relaxed/simple;
	bh=RPtDT4R8CbQKDos6BAV/fwImTeno+coof9EPnsGzwsE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hC64ZxLgsnhSR0GzQqsLhRaVZXysuP3ZEoyK4xiEY+G0wQTCY44VQAXhlzP8hd5/pbiLtI5Gw67jWMzg/HOwQZABkZDnRynac0aR4HzP6ps5PXp3vzLTXcrNex+eGE6CdybO3TgpOrRK52jcPpy+lCMjCzQl4QvvHWHJR1XozB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHOQaj++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460C0C4AF10;
	Tue, 30 Jul 2024 16:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722355412;
	bh=RPtDT4R8CbQKDos6BAV/fwImTeno+coof9EPnsGzwsE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=LHOQaj++Amqup2mv+o2VvKI5XxVkLvhT7O2sOin6RgYlon7JQvYNiQG7UWuOiuY6q
	 0CadX/X8mvTuTgetjJZlNr0GZ7h+PqTECKQXHsVkbpVUtZTA5QTszqVEkoM9J9UNPf
	 cO3znnhp4AEC5SUlCqYFByJNzZnRKq6vQt/6TsXzYvlXzwXYI4YofGop+HZdimmLgq
	 leN1UShxvSZ2De1LADpUlGAoS4HYXOmzIAMoy/fJQ7VlyCHNjLhOCCfz4acQv9bdZT
	 c9P+QxcgRFN3+JAvi/nSiyVYmBCxTPRnYkXR9seBiWO6No9T/dJuejloiokfgWZ5Ct
	 0QW9Poa991gIg==
From: Mark Brown <broonie@kernel.org>
To: f.fangjian@huawei.com, Devyn Liu <liudingyuan@huawei.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 jonathan.cameron@huawei.com, salil.mehta@huawei.com, 
 shameerali.kolothum.thodi@huawei.com, shiju.jose@huawei.com, 
 liuyonglong@huawei.com, yangyicong@huawei.com, yisen.zhuang@huawei.com, 
 kong.kongxinwei@hisilicon.com
In-Reply-To: <20240730032040.3156393-1-liudingyuan@huawei.com>
References: <20240730032040.3156393-1-liudingyuan@huawei.com>
Subject: Re: [PATCH 0/2] spi: hisi-kunpeng: Set verification for speed_hz
 and max_frequency
Message-Id: <172235541000.81832.8279048071901516716.b4-ty@kernel.org>
Date: Tue, 30 Jul 2024 17:03:30 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Tue, 30 Jul 2024 11:20:38 +0800, Devyn Liu wrote:
> The speed_hz is specified by user, while the max_frequency is a
> firmware-provided parameter for the SPI controller. Both are used
> in the calculation of clk_div. To avoid calculation results outside
> of a reasonable range and to prevent division by zero errors,
> configuration for validation of speed_hz and max_frequency is added
> in the code.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: hisi-kunpeng: Add validation for the minimum value of speed_hz
      commit: c3c4f22b7c814a6ee485ce294065836f8ede30fa
[2/2] spi: hisi-kunpeng: Add verification for the max_frequency provided by the firmware
      commit: 5127c42c77de18651aa9e8e0a3ced190103b449c

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


