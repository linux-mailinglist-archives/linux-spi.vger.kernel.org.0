Return-Path: <linux-spi+bounces-5992-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D841C9EB192
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2024 14:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3F13188D2C4
	for <lists+linux-spi@lfdr.de>; Tue, 10 Dec 2024 13:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861131BC07E;
	Tue, 10 Dec 2024 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cZHyQRb0"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4C61B85D1;
	Tue, 10 Dec 2024 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733835657; cv=none; b=G3HZj+KPyMaxIhdRAAG64LF+L1Mw46RM1f181s1pR4T1CNz98murJONjFbNaBRXj6D/WwVRSOxUU05L3L7GgvAReQHQtCMfs/QguFhPZpCVXv2IoeLlmbbCYCb4B7FFhaWvi1nVaq4mThfUaqTLHRXOnPOQBWF5DUHd4mzkmBT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733835657; c=relaxed/simple;
	bh=zEwmhiXWSNdbVox4v1ywGDTEkwYo+ZA+AQNMZDvtC0U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GOhDLq3yx62Skz64Avy5UAyHcq9p6IwRbqCFaV+LwKEzY3LyNBmPh50JV74iWQeMap5OGD+wH1uC8PK0XdXZuLM8VFHMkgB5aCMJWvquWLL36l0NgQYz6ah7yCBVx7YHVlL4CnZbhU+BY9RN4eb6obO+nxTyjfqyRtyeR2zTpn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cZHyQRb0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982D1C4CEDE;
	Tue, 10 Dec 2024 13:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733835656;
	bh=zEwmhiXWSNdbVox4v1ywGDTEkwYo+ZA+AQNMZDvtC0U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=cZHyQRb09aVdckaqkajo4eVvvzHyNC8KLVkdZP6Yf6i4/uPqc7gFZGQ8MCOo7O2E/
	 XSaNPzGv8jbL8bfjO6sZuNk65bMm4nqT/3u90zls+2YoVwfujB1EuyToPt09NU6ZHF
	 JR0gAAp2xG2EF4+JI+W2TsEObUJjuioGJ1tI2WaD1nWBP6OXjgU1ON/KiyeDcibd8J
	 /uOwC/lHNPX2J4RbKcQVp7DJrj0piWQ6OVXqrZj7nrbvPHNaeglnHhMCBYbiGbEzrD
	 4R1NkJsJ0z5+R321AlES+nFWpAhpfzBlzvHU949s8THLJNUj2m2vyV8NJ5T4jPZftd
	 qN4vUGUNWbwBw==
From: Mark Brown <broonie@kernel.org>
To: michal.simek@amd.com, linus.walleij@linaro.org, 
 Mingwei Zheng <zmw12306@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Jiasheng Jiang <jiashengjiangcool@gmail.com>
In-Reply-To: <20241207013258.3615645-1-zmw12306@gmail.com>
References: <20241207013258.3615645-1-zmw12306@gmail.com>
Subject: Re: [PATCH] spi: zynq-qspi: Add check for clk_enable()
Message-Id: <173383565535.34030.14188162384074341857.b4-ty@kernel.org>
Date: Tue, 10 Dec 2024 13:00:55 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Fri, 06 Dec 2024 20:32:58 -0500, Mingwei Zheng wrote:
> Add check for the return value of clk_enable() to catch the potential
> error.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: zynq-qspi: Add check for clk_enable()
      commit: 8332e667099712e05ec87ba2058af394b51ebdc9

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


