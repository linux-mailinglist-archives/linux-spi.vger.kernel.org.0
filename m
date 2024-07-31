Return-Path: <linux-spi+bounces-4113-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5859433C1
	for <lists+linux-spi@lfdr.de>; Wed, 31 Jul 2024 17:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD0CD281F36
	for <lists+linux-spi@lfdr.de>; Wed, 31 Jul 2024 15:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249A91B581A;
	Wed, 31 Jul 2024 15:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OGkupJsb"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC83C168B8;
	Wed, 31 Jul 2024 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722441536; cv=none; b=qDbsPHj5q9WMqVGpcSmTrhKrfZ4yhx6xjeM8AjczEuHDoc+qzWYnYEmktYqDH6p3doAntPfOZzNzpsND0WIXRtz7doP/JPwxSrjbBqFcFTSQHxNsgvpe45Sq68UbSStjg0jEenbUaKAYW8pnoZTbHRCjMcsrpWNRB0ASIUBwNss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722441536; c=relaxed/simple;
	bh=IHmZR7O6v1K0g1d6gC55h2MygwSRKHumEEBEnZq+6js=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nyMPxnci58x3fWfe5bIG8KqEcNqu/WoxgWAzfjpJMhemKfuFsXg4YxIrAS0/hBPgBvwZMyIeHWNE52L3g8pOi3qBNJRM5bbKyNQ7HypJ8PkBI8Ws0ZmjMIr5KBVGkImL9U0TMPldPeVZDYIF16F1IR1WrNofqyqx8HdOfV8PPlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OGkupJsb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2486DC116B1;
	Wed, 31 Jul 2024 15:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722441535;
	bh=IHmZR7O6v1K0g1d6gC55h2MygwSRKHumEEBEnZq+6js=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=OGkupJsbN6eG833QhmSd7mbIP20sJK/NvSK+DSqzexEcqp/u8ezhD+WPAgoSQ07Ir
	 +qZ9u8GSOqjUco8s2+Lg64ESA0LCt0Ttr5gpzRUi7bHMgxi3Smu8bEaKdO3v3AvXNI
	 w6SK3r2O7cWRXWT2pvVtdbBk3A+6vsMfiuAMDaWic8E9QwE2XvLW5z2UeZZARrmE0d
	 2RKvKJZ99kVDsbDiISr+dM45eAuE8AnN2ONMK0i0H/JrKgWi+H251dcARXc1xSQQKC
	 hjTF/WlyxKD5ZV4sMZgMCl97Zj6RYou9HZA+WWNZXE6rgGZFxNc5qo5iN3vWXglqqr
	 pe2985Xg/aHAQ==
From: Mark Brown <broonie@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, 
 linux-spi@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, 
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org
In-Reply-To: <20240731072955.224125-1-biju.das.jz@bp.renesas.com>
References: <20240731072955.224125-1-biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH] spi: rpc-if: Add missing MODULE_DEVICE_TABLE
Message-Id: <172244153388.94084.18090367156896125533.b4-ty@kernel.org>
Date: Wed, 31 Jul 2024 16:58:53 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-37811

On Wed, 31 Jul 2024 08:29:53 +0100, Biju Das wrote:
> Add missing MODULE_DEVICE_TABLE definition for automatic loading of the
> driver when it is built as a module.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: rpc-if: Add missing MODULE_DEVICE_TABLE
      commit: 0880f669436028c5499901e5acd8f4b4ea0e0c6a

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


