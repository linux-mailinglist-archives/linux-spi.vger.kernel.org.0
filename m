Return-Path: <linux-spi+bounces-5198-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB66998CAE
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 18:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B5B71C23D86
	for <lists+linux-spi@lfdr.de>; Thu, 10 Oct 2024 16:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAA31CDA36;
	Thu, 10 Oct 2024 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdGULnfa"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FDB1CDA2E;
	Thu, 10 Oct 2024 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576180; cv=none; b=MVWQOqcLqV/qThL1NNCKq+UC3arENi3Zcn5Ofk4ig/kOep5wyNsvmiB4z4crlOHATg1lYApnr6NEzD3kZywz2eu/NGUOjtClNDnadamYmRmTcBJs82fPjCTYUGKdWpZmvam1JfM4Llp0zPBujmkIEsWvFQP+uMeFp717W8eJPhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576180; c=relaxed/simple;
	bh=qO2e+Fo8aDijI9cY8k1x9aHsA25fUoVeZlkJc7wbkm0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mvZKTve74flOzD4Vf9BlegiuWyjMyi1SARi9fB37aBZu7GY2h+zML2O+6+TotPcqOnnhvn6B8f1FXb6qe1E037HYzpz+DuN9GPTF2slAjyzZrrFRpwJ7Jqpa4oYyB1GiVyf286cEwV+PDU8j4VgokbAt3BkT3qT0OwqWG/hJAcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdGULnfa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4D1C4CEC5;
	Thu, 10 Oct 2024 16:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728576180;
	bh=qO2e+Fo8aDijI9cY8k1x9aHsA25fUoVeZlkJc7wbkm0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=GdGULnfau88P5RpasMhVI2WJ7T9sAHMpAcQe+3+pKL7eA7xBHjWhICKBDFt36aoZE
	 R5tCbWoGciIzvhJvhx6R3C/Vn9JSPfiVSeFbRtulvC7pEY/CycmI42a2X0vErJF4oj
	 H4DQ8tNy5ttYtKz8rQ9bbwak2ELzosXkzHU0ATuRG7rb8+UgXRQF2p1H+vg/I6WJ5Y
	 QF8JP85txIPsFym8LJ8Ry/LbRHJxVGduQreUi3DOtA9D0OxDAIQnD+f9Uta9OyG8xR
	 Db8Mfa9qgnusS9T/joPgXrfLyyM9Rna5vWecgs0bcOTBZWgYVDNsbi+fvC3EHdwSYg
	 hF76oEvk0mmXg==
From: Mark Brown <broonie@kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Alain Volmat <alain.volmat@foss.st.com>
Cc: linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20241009-spi-mp25-device-fix-v1-1-8e5ca7db7838@foss.st.com>
References: <20241009-spi-mp25-device-fix-v1-1-8e5ca7db7838@foss.st.com>
Subject: Re: [PATCH] spi: stm32: fix missing device mode capability in
 stm32mp25
Message-Id: <172857617679.3841267.4084268172252047791.b4-ty@kernel.org>
Date: Thu, 10 Oct 2024 17:02:56 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-99b12

On Wed, 09 Oct 2024 18:15:52 +0200, Alain Volmat wrote:
> The STM32MP25 SOC has capability to behave in device mode however
> missing .has_device_mode within its stm32mp25_spi_cfg structure leads
> to not being able to enable the device mode.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: fix missing device mode capability in stm32mp25
      commit: b5a468199b995bd8ee3c26f169a416a181210c9e

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


