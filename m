Return-Path: <linux-spi+bounces-11176-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE29C53C85
	for <lists+linux-spi@lfdr.de>; Wed, 12 Nov 2025 18:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 37B59343E98
	for <lists+linux-spi@lfdr.de>; Wed, 12 Nov 2025 17:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4F7347FEC;
	Wed, 12 Nov 2025 17:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzZ4hmIt"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A5E347BDD;
	Wed, 12 Nov 2025 17:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762969764; cv=none; b=k+cp3+zwV9rx4aQVnwMuP9jmyTdUJBorf41FZt167S/HHVIJvp0P/yHAZCIyIpT0sJpUNWmUn4YjNnWAPoIgZg0pWBa+2nNt04ROOsF9k20Vzf9HkE+y114Up1r4gPemiemn04mmJD92OxSn8XMy06M30+uBIBJhCV3f5t+FNEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762969764; c=relaxed/simple;
	bh=6vy0ElT/Q0TyjMx1ZDJ9J63lSlYEuag73UWY0ZaJ71M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HnZKpfqBArjehDAy2SVpPHZFsERfK/jzw5FXYJCt0Fuh8PWWji/ox1oJNuvysBH7nYsjJ7SvZoF7OBkEbDoOukYDMbMx58nX04DiQPTYE7g8ZmxdEy9Uawjh0JqEIgQ0DZY7OGYsJQPf72fa+SL+oiuYB/XGYzLFlDgiEVl8QAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzZ4hmIt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEC4C113D0;
	Wed, 12 Nov 2025 17:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762969764;
	bh=6vy0ElT/Q0TyjMx1ZDJ9J63lSlYEuag73UWY0ZaJ71M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=PzZ4hmItEEPta7eH1rHr9//KQTJw84VoUQUd5m05JBz/dN8R5h59WxOKyx2Of+tlP
	 uL6uUlp/O67UIEqWe4gJ5npGt2G84hbxkwSyyr0WgH9XdCELBaVRcyw4CsV98e6eHF
	 3HJj9+Y8E1vLgMqsH2xzanocd8YQzGjhCqW1VkyZN4q5RxqUSnh+8GIbk/TaIehptT
	 kvmv40OZ5j9/q+enp2yURa5AewL44pyzin90v5bHRfycQxMpSwsEDXs7Su1sy0+COr
	 FCyS+EdV0tsDU+2XCx9sZXQzxjLeOFumV9/884zwyL3ydIAQJMfe3ceHduU1DbENYz
	 9hx/1Qm9+tIgg==
From: Mark Brown <broonie@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au, 
 venture@google.com, yuenn@google.com, benjaminfair@google.com, 
 andrew@codeconstruct.com.au, Tomer Maimon <tmaimon77@gmail.com>
Cc: openbmc@lists.ozlabs.org, devicetree@vger.kernel.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251112150950.1680154-1-tmaimon77@gmail.com>
References: <20251112150950.1680154-1-tmaimon77@gmail.com>
Subject: Re: [PATCH v2] spi: dt-bindings: nuvoton,npcm-pspi: Convert to DT
 schema
Message-Id: <176296976083.48834.13469679974248275009.b4-ty@kernel.org>
Date: Wed, 12 Nov 2025 17:49:20 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-88d78

On Wed, 12 Nov 2025 17:09:50 +0200, Tomer Maimon wrote:
> Convert the Nuvoton NPCM PSPI binding to DT schema format.
> 
> Also update the binding to fix shortcoming:
>  * Drop clock-frequency property: it is never read in the NPCM PSPI
>    driver and has no effect.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: nuvoton,npcm-pspi: Convert to DT schema
      commit: 1d562ba0aa7df81335bf96c02be77efe8d5bab87

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


