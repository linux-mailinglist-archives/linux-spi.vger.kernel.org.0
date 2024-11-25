Return-Path: <linux-spi+bounces-5837-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1204F9D8B58
	for <lists+linux-spi@lfdr.de>; Mon, 25 Nov 2024 18:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC024280FEC
	for <lists+linux-spi@lfdr.de>; Mon, 25 Nov 2024 17:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC11192589;
	Mon, 25 Nov 2024 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uwpYP2gM"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4529018C322
	for <linux-spi@vger.kernel.org>; Mon, 25 Nov 2024 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732555988; cv=none; b=L4hGaFauBGqMMrSPbOblXoJBgk55lta6CGNpiO7lY6nnkNZ0aVpf0Qcr5zkrFjXZkfcNLCrWy0HV+aHYBJga3L4XGP0fIvHN8k/bmiUEC+vaOhMm37V9wo6oKLK5UsWmkhtEpWlmuTQ7Z4ZyLHXW6bY8b+rIrs7TKns/C8YKfMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732555988; c=relaxed/simple;
	bh=rgXdPXgy9KawSZ18xCVqP4WoG/nIpMzTNCgS571wuV0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hVFH+fP6pUzR6qBBpnKy3JNvv+tqzP9GFU2uym6h4q2qZ5G79dhHp8tzTnBMyAF1l9u+xxr69wVpY6OmuheMPOq24pq+2uxtjpaRtsL5eWqdjUzPnBZPetxqAC8r30XmWMCDX2x2cqFgmEOzyim4CyF0YntQj+yYWuw9CKWjGUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uwpYP2gM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812AAC4CECF;
	Mon, 25 Nov 2024 17:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732555987;
	bh=rgXdPXgy9KawSZ18xCVqP4WoG/nIpMzTNCgS571wuV0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=uwpYP2gMjGDPAdGR+CT6Ev8fDmHfr+POTrSPzukF0ad2BRXQr/GTvTT6EZhNoFToS
	 8fp2QxLb9HEjUclzCBbHEf4V/5brtvs8nxXVP00d9kuOIQLRMGi4s/gfoBuLqMZUIB
	 7AUP+uuoBZxP5PsoxQ3PKEPCXKrHfqKQVbMYQ6Mk/HXYL6cvg+zKlUiMJ+8PYfIMIP
	 Ix89nnfuxoANqCDGpQ2E0hXjxySDI9Fbu89NMAy86eDDXxIUdNUsazErtr+Xa22ynm
	 WOBiCROkP+pAU46wKGi4MCXyY92c8LyjoxkdAzs0i+JqC/sJ65A7M97i+pMMN5fKYi
	 oUXi/dO6I+NTA==
From: Mark Brown <broonie@kernel.org>
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: linux-spi@vger.kernel.org, Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241122094224.226773-1-stanislaw.gruszka@linux.intel.com>
References: <20241122094224.226773-1-stanislaw.gruszka@linux.intel.com>
Subject: Re: [PATCH] spi: Fix acpi deferred irq probe
Message-Id: <173255598619.70089.17578974981255318592.b4-ty@kernel.org>
Date: Mon, 25 Nov 2024 17:33:06 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-9b746

On Fri, 22 Nov 2024 10:42:24 +0100, Stanislaw Gruszka wrote:
> When probing spi device take care of deferred probe of ACPI irq gpio
> similar like for OF/DT case.
> 
> >From practical standpoint this fixes issue with vsc-tp driver on
> Dell XP 9340 laptop, which try to request interrupt with spi->irq
> equal to -EPROBE_DEFER and fail to probe with the following error:
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: Fix acpi deferred irq probe
      commit: 9c69c8286754c61f95ea9189b2b5a794bdb07fed

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


