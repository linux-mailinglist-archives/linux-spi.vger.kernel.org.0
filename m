Return-Path: <linux-spi+bounces-365-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B278254B7
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jan 2024 14:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 144361F2232D
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jan 2024 13:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD5B2D62F;
	Fri,  5 Jan 2024 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meuRyhQ+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46702D62C
	for <linux-spi@vger.kernel.org>; Fri,  5 Jan 2024 13:56:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 164C2C433C9;
	Fri,  5 Jan 2024 13:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704462991;
	bh=ebtRfkw7yiqdVOi7J7lOPrI3ufe/+hCZt4k/abw2RBQ=;
	h=Subject:From:Date:To:From;
	b=meuRyhQ+cvzsiDAu11lTAa6ln0A5ioADI6i2/GD3orPz1Q4pOWdrsbhTAPEUp3nXK
	 6HFoJLabXnz1uEdbNSOGVQIEp3X71dVjygEqVm87eMy+WCCoK0uCsV0tCBN4pm1POH
	 0p45aNGiDrdQc0h1R3W6DvdcY8kj+WU1JUCta5f0xJvyNwE1mQtH/nQ7PKcauWir1l
	 SSUfTTHkJbpBcxQNspAOgctR5Ez4ZUzOnpg0HeoYPB2PWm8hweusNGzlqX1fYZhD4/
	 pjUKq8nIQwtj1lJsXFT0h+VD01yaK+eqN8tpVbekWSStbi9BIscuHqbnJkYtqxVwAm
	 WYjKspAS0tH+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 03048C4167E;
	Fri,  5 Jan 2024 13:56:31 +0000 (UTC)
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
 <170446299100.27040.15746653365175138465.git-patchwork-housekeeping@kernel.org>
Date: Fri, 05 Jan 2024 13:56:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v9] Introduce STM32 Firewall framework (2024-01-05T13:03:51)
  Superseding: [v8] Introduce STM32 Firewall framework (2023-12-12T15:23:44):
    [v8,01/13] dt-bindings: document generic access controllers
    [v8,02/13] dt-bindings: treewide: add access-controllers description
    [v8,03/13] dt-bindings: bus: document RIFSC
    [v8,04/13] dt-bindings: bus: document ETZPC
    [v8,05/13] firewall: introduce stm32_firewall framework
    [v8,06/13] of: property: fw_devlink: Add support for "access-controller"
    [v8,07/13] bus: rifsc: introduce RIFSC firewall controller driver
    [v8,08/13] arm64: dts: st: add RIFSC as an access controller for STM32MP25x boards
    [v8,09/13] bus: etzpc: introduce ETZPC firewall controller driver
    [v8,10/13] ARM: dts: stm32: add ETZPC as a system bus for STM32MP15x boards
    [v8,11/13] ARM: dts: stm32: put ETZPC as an access controller for STM32MP15x boards
    [v8,12/13] ARM: dts: stm32: add ETZPC as a system bus for STM32MP13x boards
    [v8,13/13] ARM: dts: stm32: put ETZPC as an access controller for STM32MP13x boards


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


