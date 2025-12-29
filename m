Return-Path: <linux-spi+bounces-12167-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F0FCE7F86
	for <lists+linux-spi@lfdr.de>; Mon, 29 Dec 2025 20:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9ED92300548A
	for <lists+linux-spi@lfdr.de>; Mon, 29 Dec 2025 19:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D20A28B40E;
	Mon, 29 Dec 2025 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDvgsmPa"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB855285C99
	for <linux-spi@vger.kernel.org>; Mon, 29 Dec 2025 19:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767034809; cv=none; b=C1OdFByFMRztvBIW/XloTww3Dz+nhopiRfHZcFJjmMqNIb+7NCTaY8Q+8Z/6dSQQ1Ag9gjjsLPL9GWfFQnzBjz0Qp+qm9y2Bl4QCJswytextAKTZIYmEMw6g2GpwedWnFRsG1QSHVw1JFjOE7aj+IgBRzSq+KcBk3Ip0LA7jX38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767034809; c=relaxed/simple;
	bh=5YmHh5kE7KqIJxlD7lbGtHKwvW538hpDCHy/l6tPWpg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=oj31M3DmFjHAiV3ITnIPUqFEmwpXK6aT+JbQQrmWYBIQ9zlsv9OzYYE6kiaZTLvtlSzBF0EMgFtdsKDKGHdLe1+eVkGF7pzxCCksdEkDXSC5VRvESQFwf889h/PXApvTzJy0JjHJKM20+j2+5XdCunfdrD5gTfC0CD8auCBRlFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDvgsmPa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D816C4CEF7;
	Mon, 29 Dec 2025 19:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767034808;
	bh=5YmHh5kE7KqIJxlD7lbGtHKwvW538hpDCHy/l6tPWpg=;
	h=Subject:From:Date:To:From;
	b=uDvgsmPabFW/O3IvrC91GZA0bphuJ7m2QLyjST6z8XGLj6Q3N28Ua3lj7SAT10+wC
	 a6xxMnC7eI/JN0nKzBE0larsMIN+kAwep0NvmJO1xXPhIsGmXmlx/s/HItTwSuZbnT
	 wqGkySBfGUZsDy3xh/sm8SNMUE7cid6swi3I0/bxG7ZEiaZ/LqYpwPqq4EgIba8uHB
	 6t5+cfhsDqJxzPR6+eK0bKbpzuM1uCb3jMpallearZpncHjhayc9dqEdPgryQcTsPL
	 uX4dQmMf4GG8w68JyBa0ofgpvDoGomqez/nkuvEi6WWDqioz0sEic1y5p+Km+Ylh9n
	 Tc/fS2DCF8mJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 006533808200;
	Mon, 29 Dec 2025 18:56:51 +0000 (UTC)
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
 <176703461046.3031944.3034878829993125670.git-patchwork-housekeeping@kernel.org>
Date: Mon, 29 Dec 2025 18:56:50 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] Add support for Microchip LAN969x (2025-12-29T18:37:41)
  Superseding: [v3] Add support for Microchip LAN969x (2025-12-23T20:16:11):
    [v3,01/15] include: dt-bindings: add LAN969x clock bindings
    [v3,02/15] dt-bindings: usb: Add Microchip LAN969x support
    [v3,03/15] dt-bindings: mfd: atmel,sama5d2-flexcom: add microchip,lan9691-flexcom
    [v3,04/15] dt-bindings: serial: atmel,at91-usart: add microchip,lan9691-usart
    [v3,05/15] dt-bindings: spi: at91: add microchip,lan9691-spi
    [v3,06/15] dt-bindings: i2c: atmel,at91sam: add microchip,lan9691-i2c
    [v3,07/15] dt-bindings: rng: atmel,at91-trng: add microchip,lan9691-trng
    [v3,08/15] dt-bindings: crypto: atmel,at91sam9g46-aes: add microchip,lan9691-aes
    [v3,09/15] dt-bindings: crypto: atmel,at91sam9g46-sha: add microchip,lan9691-sha
    [v3,10/15] dt-bindings: dma: atmel: add microchip,lan9691-dma
    [v3,11/15] dt-bindings: net: mscc-miim: add microchip,lan9691-miim
    [v3,12/15] dt-bindings: pinctrl: pinctrl-microchip-sgpio: add LAN969x
    [v3,13/15] arm64: dts: microchip: add LAN969x support
    [v3,14/15] dt-bindings: arm: AT91: document EV23X71A board
    [v3,15/15] arm64: dts: microchip: add EV23X71A board


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


