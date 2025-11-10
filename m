Return-Path: <linux-spi+bounces-11150-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DCBC49CCE
	for <lists+linux-spi@lfdr.de>; Tue, 11 Nov 2025 00:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8182D3AD24B
	for <lists+linux-spi@lfdr.de>; Mon, 10 Nov 2025 23:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD4D2FD689;
	Mon, 10 Nov 2025 23:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qspanHx2"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51DD242D78;
	Mon, 10 Nov 2025 23:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762818010; cv=none; b=YNqA0BBXH2wdh6w0o3DNqsTP49MVM5PAO7Q0fUpmw52e6HqQ+xYGTHq1cWTZI6imN84WTuJxy9JCyXikpnaK20wjwBMllDrmTCHI2qy3JoQ9BD9gS1L7pj6OWm3ZELBerQFRJm5LPjJcpzQSAis6sU7eVsHIYeT4GzugBYnuKTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762818010; c=relaxed/simple;
	bh=007dc7pb32zadQW1VaD/UBUVaq3PK5kpl4BrOBTaDaI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oMwy6CPuzmW4ZGzRPXI6Rj0PLLytMUxeff9J5cN8I+kmqtei9yZM9Wk+992whtEBd9GGp6yvk4iiaLySR47nodetUiby0Sy/SFrhxpxygpYg9yNCIt3hDbRAY7Ux0aqX1IG8F/pRLHlQM/bqERvA9YxPAD4kphoKcCWWseNtcBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qspanHx2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C533C4CEFB;
	Mon, 10 Nov 2025 23:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762818010;
	bh=007dc7pb32zadQW1VaD/UBUVaq3PK5kpl4BrOBTaDaI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qspanHx2NN2vY8Zsy5vA6nBRqH1aJJHsip/l3E5EqAGDiSJEJFOQ9W3keb/ZXYXce
	 OsaayCr0wGnEEmKB+g51fEkfPNcvQ+wM/01227jV1S8rhsgJoh9wWBNOCLMLHISEti
	 LA5tZpcvJcQge8uDpE982V8O71S8Cq3HaEjW6i/1RMhsMlCFwo6hXyl80i5SUjuchX
	 URsdQQVvBPMGGDQBoafo1OsX5bzoz60r5Rxr2yNprAXEaSwJt6FPwGhI8MiXz3t2cC
	 EVPSpgDF4aD9qcwuWmpme8rffbxLvkdDlsiQ6n9lz2+MHeEgOfLJPDJraF5UtMqF6S
	 XqL0sB/g2fC2A==
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andy@kernel.org>, 
 Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org
In-Reply-To: <20251109155340.26199-1-johannes.goede@oss.qualcomm.com>
References: <20251109155340.26199-1-johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH] spi: Add TODO comment about ACPI GPIO setup
Message-Id: <176281800819.170916.14052253734364037167.b4-ty@kernel.org>
Date: Mon, 10 Nov 2025 23:40:08 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-a6db3

On Sun, 09 Nov 2025 16:53:39 +0100, Hans de Goede wrote:
> Add a TODO comment that ideally the ACPI/gpiolib core code should take care
> of setting GPIO direction and/or bias according to ACPI GPIO resources.
> 
> If this TODO gets implemented then the acpi_dev_gpio_irq_get() call in
> acpi_register_spi_device() can be dropped.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Add TODO comment about ACPI GPIO setup
      commit: 66e9feb03e7cf8983b1d0c540e2dad90d5146d48

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


