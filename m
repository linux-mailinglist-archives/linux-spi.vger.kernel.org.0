Return-Path: <linux-spi+bounces-6146-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 012719F9C7D
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2024 22:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60CEA163507
	for <lists+linux-spi@lfdr.de>; Fri, 20 Dec 2024 21:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68087223E7D;
	Fri, 20 Dec 2024 21:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBllFPBX"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439E0157A48
	for <linux-spi@vger.kernel.org>; Fri, 20 Dec 2024 21:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734731783; cv=none; b=lyXPfmBSmaC0iI1RgYSixcU8g19M9v0mcUkxSdMfYXZ5C3aAfHGzDugrQ0ZnYK0r3uhakRJuM432+hA8Y93odubZ02R2JGu2Yutwm7relxbZqalmgID6TC9xDIMi0a6Q0w2YsSyaxVaAQSHR1UP91roYdVtBBoVSd40rEnisjdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734731783; c=relaxed/simple;
	bh=mcDVclNKItvKFrm0OS/CIE6vHsjMWd5nDyWCeqsau2g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=gAG/DtbLh91TT/kiFZQi9zgUtdk7SM75O19GWa+FZcTdZ7AeJ+txNrFGIhSCFp5rudGMmS1pCOPZ+Hdpjy8O65hiRz1CNkstbwXB/7Yu/jPEkoPlojacrdnxr5VeDGMvcF66LonC3TljCejUOu6GzqMVgphr6hjUJYXe2YhGbE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBllFPBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49FBC4CECD;
	Fri, 20 Dec 2024 21:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734731782;
	bh=mcDVclNKItvKFrm0OS/CIE6vHsjMWd5nDyWCeqsau2g=;
	h=Subject:From:Date:To:From;
	b=VBllFPBX2SYieRzc/iS0ipEux4MsQV+NaN/WcRvJR7pR8kfiYUJLdElZLo3RR3qwf
	 WhPr+oa163ToVSlxI1Whj7s5WpWj3MNO5RoLZ2VcYl+CWetHI9C3COQwEgfsm7NJyS
	 0lqf0A+nde+B+69/3WaNzwQPhMcMPaIFYdKN3ieia60OsYfZCoAIffWdROZnKXfUqz
	 1YQu/6tMK3g2C67Kkc1wco1BgFdEOAGNqJO/3v7UAGt0Usi2bLO9+zDTuYGyUezxJn
	 kOsBct84IPd7frVKtvA5v7pKwvU+4+sOPdIDNf72mmdGU8nR1RYBLphlfOFts3c8rk
	 o7OOq0l3NLMfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B2EE53806656;
	Fri, 20 Dec 2024 21:56:41 +0000 (UTC)
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
 <173473180021.3032131.10804435342606060395.git-patchwork-housekeeping@kernel.org>
Date: Fri, 20 Dec 2024 21:56:40 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] Add support for SAMA7D65 (2024-12-20T21:07:01)
  Superseding: [v3] Add support for SAMA7D65 (2024-12-06T19:59:49):
    [v3,01/13] dt-bindings: ARM: at91: Document Microchip SAMA7D65 Curiosity
    [v3,02/13] dt-bindings: mfd: atmel,sama5d2-flexcom: add microchip,sama7d65-flexcom
    [v3,03/13] dt-bindings: atmel-sysreg: add sama7d65 RAM and PIT
    [v3,04/13] dt-bindings: serial: atmel,at91-usart: add microchip,sama7d65-usart
    [v3,05/13] dt-bindings: pinctrl: at91-pio4: add microchip,sama7d65-pinctrl
    [v3,06/13] dt-bindings: clocks: atmel,at91sam9x5-sckc: add sama7d65
    [v3,07/13] dt-bindings: clock: Add SAMA7D65 PMC compatible string
    [v3,08/13] clk: at91: sama7d65: add sama7d65 pmc driver
    [v3,09/13] ARM: dts: microchip: add sama7d65 SoC DT
    [v3,10/13] ARM: dts: at91: Add sama7d65 pinmux
    [v3,11/13] ARM: dts: microchip: add support for sama7d65_curiosity board
    [v3,12/13] ARM: configs: at91: sama7: add new SoC config
    [v3,13/13] ARM: at91: add new SoC sama7d65


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


