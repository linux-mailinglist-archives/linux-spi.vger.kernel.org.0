Return-Path: <linux-spi+bounces-9399-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB02B252AC
	for <lists+linux-spi@lfdr.de>; Wed, 13 Aug 2025 19:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C97CE2A08CF
	for <lists+linux-spi@lfdr.de>; Wed, 13 Aug 2025 17:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A1C2989BC;
	Wed, 13 Aug 2025 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6Up0lwe"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9F91D63C5
	for <linux-spi@vger.kernel.org>; Wed, 13 Aug 2025 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755107817; cv=none; b=j85yGik6deyKGXvzcOMshj0DppqZV592igWDxMGV9t5ek54svaxhC3uK6lzrYCbyjsilbd4I81zT7HJzdaxQ4xrXQEFCskG3vWx5OjKvGh9Tix/C30xyIQ5Laj36bteyR7yEsBZ1IHiKuVAV9Hub5FPrg3ckbKQ+5xlIka8NEMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755107817; c=relaxed/simple;
	bh=rtz/m1tGQu1zFUp6SX6hq31dGt+XenhcnRc4Im4QqLk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=JxJpuN0D3Wkfk0fzTYw4i5KJ37nb2+7ShpdZmObqKmHKxoXs6EzAK3rXmEnPU8RktaH6O+kL+CQP2I1ku0WUrDSdnPHwisXwYAX5Qx5tZQIgHGmEK1SL0e+22naTZ/zAYiZ5vllqHEafjwP/teWcictlU8dBJlPOJIDBRC7UGmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6Up0lwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEB2C4CEEB;
	Wed, 13 Aug 2025 17:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755107816;
	bh=rtz/m1tGQu1zFUp6SX6hq31dGt+XenhcnRc4Im4QqLk=;
	h=Subject:From:Date:To:From;
	b=E6Up0lweeDKeixCblLLNT/uKRoof7HBqbER4LkwojOFI6cTE1dJwiS7Sj1rHhqCfF
	 Jo09saOy62YcpD0kuejKoRhJd4aJoi5L6NSkYSBiis86mQTox02rAN3VOFOy37jFiN
	 aK40Voyb2BnWtoAkUMtvQHYhTsAo/5D/69xtQlXUw+ip5Yteu3FWH7GFltFORhSPlk
	 IybJv4XjvhGnXyth74oJw5qpUaa1Xyri81zWyd4fbbiwbmOUERp4BAY6L5o7+g1gT9
	 PUJIl4BAiMAR5qtQtE3ygzVCxQVlzuZtnI+UZZtkIAKoRW2osClKdl66hMjbXO3Jy0
	 qMYkkpUsAfhUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF0D39D0C37;
	Wed, 13 Aug 2025 17:57:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <175510782758.3692120.15838363328357930519.git-patchwork-housekeeping@kernel.org>
Date: Wed, 13 Aug 2025 17:57:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v9] arm64: lan969x: Add support for Microchip LAN969x SoC (2025-08-13T17:44:36)
  Superseding: [v8] arm64: lan969x: Add support for Microchip LAN969x SoC (2025-07-02T18:35:58):
    [v8,01/10] arm64: Add config for Microchip SoC platforms
    [v8,02/10] ARM: at91: select ARCH_MICROCHIP
    [v8,03/10] arm64: lan969x: Add support for Microchip LAN969x SoC
    [v8,04/10] mfd: at91-usart: Make it selectable for ARCH_MICROCHIP
    [v8,05/10] tty: serial: atmel: make it selectable for ARCH_MICROCHIP
    [v8,06/10] spi: atmel: make it selectable for ARCH_MICROCHIP
    [v8,07/10] i2c: at91: make it selectable for ARCH_MICROCHIP
    [v8,08/10] dma: xdmac: make it selectable for ARCH_MICROCHIP
    [v8,09/10] char: hw_random: atmel: make it selectable for ARCH_MICROCHIP
    [v8,10/10] crypto: atmel-aes: make it selectable for ARCH_MICROCHIP


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


