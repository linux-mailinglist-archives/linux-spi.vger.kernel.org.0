Return-Path: <linux-spi+bounces-12410-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DE7D2458A
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 13:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64DBD3029D30
	for <lists+linux-spi@lfdr.de>; Thu, 15 Jan 2026 11:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DD1393DEE;
	Thu, 15 Jan 2026 11:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgNIdfdj"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33093803DA
	for <linux-spi@vger.kernel.org>; Thu, 15 Jan 2026 11:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768478396; cv=none; b=YCYOQaOFmybN/YzRqdMQGtA8nzDeHj1wcbiRpGA9O0ygEp/RNziRrVWdvSVXRI3Lbq2vcPKVMIHeIWUy5H+vvHyD1OxDFigI3J47kP7p+cpEDhtNJl8A2EEoGn8T+rg+SAbJ5WYWMdUY6JbAkP834tGrm2uJ9ym+tHN63dkV5f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768478396; c=relaxed/simple;
	bh=VBqZ4AP0URlwtW5o4HPpw1u6/hirf8ti7XZlA0nX5F8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=kS1fQKcO1mD/Hg+Vs2YGbqarRe3UiS21Cadb5GPyGrOMDN6ujQnGfasDJ7Eg4FZn5o2+5i266zg18asAqmyTTeodqI4jlEpiIlMiCbMZRajU3F+Fe5yYo/aC2WKtps9CRJ/zgegpbRnuIGaKd3pEAGHKJvyknDEGbaLLsu3Zy/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgNIdfdj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F6DC116D0;
	Thu, 15 Jan 2026 11:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768478396;
	bh=VBqZ4AP0URlwtW5o4HPpw1u6/hirf8ti7XZlA0nX5F8=;
	h=Subject:From:Date:To:From;
	b=cgNIdfdjuvgmrJpc3+0zC5fQyqepys001IN/Vf6jKJmT6Fx1tyVK4s/uelLuavmAJ
	 8ip6otDAJ5nqlLcILMA1CTgtStlVAIDjBiQphU9K8FpGBoPnp+zz61mV1VKtrGBrFO
	 XFa7Om82KXXEcX+bqqduZtf/RpcFVfd58Y7XYArCj/usgDhf+S1CCUGAZ9LwUr23/t
	 fa8ek8nOjg+KbA4HQP7X6Pugm6hjS2qfaxiFKfwjmfHv1w1FfeqkWPVYLwCYbQEqBU
	 L+PRCvgAW2+DgeaL5kgpng3qF9TqYk69fZjYev3S48GdrAt5kLyp1bBOzEIxE4uszI
	 Pde1DxdXocfgQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5BBF3809A82;
	Thu, 15 Jan 2026 11:56:29 +0000 (UTC)
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
 <176847818843.3962684.17746972956782306110.git-patchwork-housekeeping@kernel.org>
Date: Thu, 15 Jan 2026 11:56:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] Add support for Microchip LAN969x (2026-01-15T11:37:25)
  Superseding: [v4] Add support for Microchip LAN969x (2025-12-29T18:37:41):
    [v4,01/15] dt-bindings: usb: Add Microchip LAN969x support
    [v4,02/15] dt-bindings: mfd: atmel,sama5d2-flexcom: add microchip,lan9691-flexcom
    [v4,03/15] dt-bindings: serial: atmel,at91-usart: add microchip,lan9691-usart
    [v4,04/15] dt-bindings: spi: at91: add microchip,lan9691-spi
    [v4,05/15] dt-bindings: i2c: atmel,at91sam: add microchip,lan9691-i2c
    [v4,06/15] dt-bindings: rng: atmel,at91-trng: add microchip,lan9691-trng
    [v4,07/15] dt-bindings: crypto: atmel,at91sam9g46-aes: add microchip,lan9691-aes
    [v4,08/15] dt-bindings: crypto: atmel,at91sam9g46-sha: add microchip,lan9691-sha
    [v4,09/15] dt-bindings: dma: atmel: add microchip,lan9691-dma
    [v4,10/15] dt-bindings: net: mscc-miim: add microchip,lan9691-miim
    [v4,11/15] dt-bindings: pinctrl: pinctrl-microchip-sgpio: add LAN969x
    [v4,12/15] arm64: dts: microchip: add LAN969x clock header file
    [v4,13/15] arm64: dts: microchip: add LAN969x support
    [v4,14/15] dt-bindings: arm: AT91: document EV23X71A board
    [v4,15/15] arm64: dts: microchip: add EV23X71A board


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


