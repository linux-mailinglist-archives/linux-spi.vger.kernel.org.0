Return-Path: <linux-spi+bounces-246-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CDC80F1A0
	for <lists+linux-spi@lfdr.de>; Tue, 12 Dec 2023 16:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 353701C20972
	for <lists+linux-spi@lfdr.de>; Tue, 12 Dec 2023 15:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F92976DC8;
	Tue, 12 Dec 2023 15:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vC7vemrz"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AD561691
	for <linux-spi@vger.kernel.org>; Tue, 12 Dec 2023 15:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38636C433C7;
	Tue, 12 Dec 2023 15:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702396626;
	bh=pN99mBkxk6idygRJVtY8RovVVahjHXSTCXRkD7KszdI=;
	h=Subject:From:Date:To:From;
	b=vC7vemrzME9pJb0YX9Ht9mdRezTQAP4P6XxI9ypzwv9rBm03pm5aE7FcC9R2L/S5c
	 sR8GdPXtEIIkhfzhf6j8t0OLAnpu3c38cC/657a+wbR/IgyaylTngDIl7DA1qKZLs0
	 sosmelgm5FHmsZaUgNU70mIOpznsSSjgXQFc66pkdsmpXcKqqkUCjgPYXcCuMZpQ4K
	 WKSqwSBi7/KtqZo56jTYSr6oX17Q0wusfjsxSxBo9NcXDy8jzu+tJj4mL4cn5aEgoC
	 SqZSGHFdYwMpbpIMfGc2fsnlRK549gp7JRbarFLjAllTBW9kjLMUhrq56ZPRs1+6LZ
	 7J6C+c+c5dj5A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B441DFC906;
	Tue, 12 Dec 2023 15:57:06 +0000 (UTC)
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
 <170239662610.7376.15553111412405099280.git-patchwork-housekeeping@kernel.org>
Date: Tue, 12 Dec 2023 15:57:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v8] Introduce STM32 Firewall framework (2023-12-12T15:23:44)
  Superseding: [v7] Introduce STM32 Firewall framework (2023-12-11T18:30:34):
    [v7,01/13] dt-bindings: document generic access controllers
    [v7,02/13] dt-bindings: treewide: add access-controllers description
    [v7,03/13] dt-bindings: bus: document RIFSC
    [v7,04/13] dt-bindings: bus: document ETZPC
    [v7,05/13] firewall: introduce stm32_firewall framework
    [v7,06/13] of: property: fw_devlink: Add support for "access-controller"
    [v7,07/13] bus: rifsc: introduce RIFSC firewall controller driver
    [v7,08/13] arm64: dts: st: add RIFSC as an access controller for STM32MP25x boards
    [v7,09/13] bus: etzpc: introduce ETZPC firewall controller driver
    [v7,10/13] ARM: dts: stm32: add ETZPC as a system bus for STM32MP15x boards
    [v7,11/13] ARM: dts: stm32: put ETZPC as an access controller for STM32MP15x boards
    [v7,12/13] ARM: dts: stm32: add ETZPC as a system bus for STM32MP13x boards
    [v7,13/13] ARM: dts: stm32: put ETZPC as an access controller for STM32MP13x boards


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


