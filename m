Return-Path: <linux-spi+bounces-5943-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BA39E7A3C
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2024 21:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9FE285347
	for <lists+linux-spi@lfdr.de>; Fri,  6 Dec 2024 20:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2421FFC4B;
	Fri,  6 Dec 2024 20:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwP7nFDY"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695271C549C
	for <linux-spi@vger.kernel.org>; Fri,  6 Dec 2024 20:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733518580; cv=none; b=TwSVyjDTSnXtGGCzhlqlb0pPA513dwHX0wOYZ8Amcpq39wOi4CyFLNp86tBZvhvHMXB6eD2fxUSKh99/wvPlNevggCsSC6+f69FXwVYUBxNgf4teJJ+LPxjX9u3yYPpaCLXIVMfGAsxbnhk2MHoKfAdBgdudmY0bIvYIwP5BWpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733518580; c=relaxed/simple;
	bh=txNltQjIM6pJ5yOuuoMpVeAgdA/bzeCy9j7dEfB8xKE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=YuqPQSb71zQWgi6j1cNaCx4zB0MK9UrgKWM3HNBOInbqUufUCRb2FiZxH0jjABH2QZ/+zpfVrqLgHihbBeQNQrDTjC+3ZMJHKoqhScDQQrsJQYst3aQnJJPPUt0lZL6X5oo/gheOAi5xYTEapu50uLX/BYJ0gV1mnHYDZLV6kbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwP7nFDY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478BAC4CED1;
	Fri,  6 Dec 2024 20:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733518580;
	bh=txNltQjIM6pJ5yOuuoMpVeAgdA/bzeCy9j7dEfB8xKE=;
	h=Subject:From:Date:To:From;
	b=MwP7nFDYPkX82QTdpKtns+Au8V18uyv18IEITFpVPr+Fcmi6jZlBzJAOGI4tmVdIn
	 fSifarpr6ugKbGs74Nw0EC6E4YNG9/wf6VjpRJGhv8+X5Qah3dOT8Viq4SmzlxYB/Q
	 x6Bb7M3xxILDQ8v2R3xoq21uvfGc+BlG1cFxyzcobfPvQVjWokkpRXiN1Kq+my7V5c
	 NJkO4IyCj2Q6PrdPEO1/n50HJCPrrO0zl4cMWyPwMKfyJ8iMtdgq4/Ws/9r13bJplp
	 MPYJvbpC66Ub3N1I5+LZcPcmxtxyolyogVrlcQqaDA5ZoU26nXF+lTFyP7gYc4Yv5v
	 OkQiQR2QkuEsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D16380A95C;
	Fri,  6 Dec 2024 20:56:36 +0000 (UTC)
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
 <173351859496.2793219.13310214751141651438.git-patchwork-housekeeping@kernel.org>
Date: Fri, 06 Dec 2024 20:56:34 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] Add support for SAMA7D65 (2024-12-06T19:59:49)
  Superseding: [v1] Add support for SAMA7D65 (2024-11-19T16:40:06):
    [01/15] dt-bindings: ARM: at91: Document Microchip SAMA7D65 Curiosity
    [02/15] dt-bindings: mfd: atmel,sama5d2-flexcom: add microchip,sama7d65-flexcom
    [03/15] dt-bindings: atmel-sysreg: add sama7d65 RAM and PIT
    [04/15] dt-bindings: mmc: atmel,sama5d2-sdhci: add microchip,sama7d65-sdhci
    [05/15] dt-bindings: serial: atmel,at91-usart: add microchip,sama7d65-usart
    [06/15] dt-bindings: pinctrl: at91-pio4: add microchip,sama7d65-pinctrl
    [07/15] dt-bindings: clocks: atmel,at91sam9x5-sckc: add sama7d65
    [08/15] dt-bindings: clock: Add SAMA7D65 PMC compatible string
    [09/15] dt-bindings: clock: at91: Allow MCKs to be exported and referenced in DT
    [10/15] ARM: configs: at91: sama7: add new SoC config
    [11/15] ARM: dts: microchip: add sama7d65 SoC DT
    [12/15] ARM: dts: microchip: add support for sama7d65_curiosity board
    [13/15] clk: at91: clk-master: increase maximum number of clocks
    [14/15] clk: at91: clk-sam9x60-pll: increase maximum amount of plls
    [15/15] clk: at91: sama7d65: add sama7d65 pmc driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


