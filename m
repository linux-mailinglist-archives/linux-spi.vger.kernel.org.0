Return-Path: <linux-spi+bounces-8979-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E968CAF0671
	for <lists+linux-spi@lfdr.de>; Wed,  2 Jul 2025 00:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DFF51C061FB
	for <lists+linux-spi@lfdr.de>; Tue,  1 Jul 2025 22:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFFC306DBA;
	Tue,  1 Jul 2025 22:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="seT1dNqR"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541BB306DB4;
	Tue,  1 Jul 2025 22:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751408150; cv=none; b=bq7R9xvPMR9jWEGhuJvnvfJcTWZJe0wpWLPS/zIiAkX57wN5SUmlSUhqE3JcQvG/muJsmLfAXwdmAVu8dmi9VNORWAfY+EyeXhrxdXv+2rUHKzVSeX4vASZ9H32UwJcwyZ5Mklj5GgjABcBE1m6KHhSaQvPuPzhP3uJxNrbMy5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751408150; c=relaxed/simple;
	bh=iOpsCmM3i8hcc7OLeyBEa+jHDCW59AkA6x9tZbiAt8M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MIdHQfBzjsv3sXN/jH4qr3GjbNKbiSRVsA6sFq/XZX//k0XWY4xkmeS35zlzVkY1AJk+tCPFQhz3E7jxgTQKZXDROOG35PkfVJUj8GKEDwbqRsTzD+st2hLVZ7UesYa/jggWBJ84OTZx+HFk8ljOUtPQ92oA8zahRzcDZJ3JCsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=seT1dNqR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1633AC4CEEE;
	Tue,  1 Jul 2025 22:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751408149;
	bh=iOpsCmM3i8hcc7OLeyBEa+jHDCW59AkA6x9tZbiAt8M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=seT1dNqR/7PMoij3HFmGGEQKos1aaO23CoQRISQ33RsrgWD+2cZKJL0uqmdjHcRCy
	 iX6M4ToLx7QfCLXmKVRcyErYw5qJY8W47yUuOpnisYPXG/V3H6PxRGFC+0CABvjNlV
	 HauyL3osB8xSqwQdkm0z8WDm4E0YTuwz0EwdgeehG0DzjM8tiNTNLA8HAg8lia0yAN
	 o3+erFF0cdbwCgJ/AyZZaDJcIYTpwg7qjI4C8yMMR7QvpFXEtP4BCBENkurtfEmDeb
	 rre1PVilqChDuNpnYRkLifBzKkqtlHqlREImet2ivmKZcHI72vfXUit+wTj5fQeJ33
	 gB2tqfcLD5ICA==
From: Mark Brown <broonie@kernel.org>
To: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: Alain Volmat <alain.volmat@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-spi@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel-janitors@vger.kernel.org
In-Reply-To: <2033b9fa-7b0f-4617-b94e-7b0a51c5c4b1@sabinyo.mountain>
References: <2033b9fa-7b0f-4617-b94e-7b0a51c5c4b1@sabinyo.mountain>
Subject: Re: [PATCH] spi: stm32: delete stray tabs in
 stm32h7_spi_data_idleness()
Message-Id: <175140814783.710092.4550416995647009913.b4-ty@kernel.org>
Date: Tue, 01 Jul 2025 23:15:47 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-cff91

On Mon, 30 Jun 2025 14:35:25 -0500, Dan Carpenter wrote:
> These lines were indented one tab more than they should be.  Delete
> the stray tabs.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: delete stray tabs in stm32h7_spi_data_idleness()
      commit: 244bc18e5f1875401a4af87d2eae3f9376d9d720

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


