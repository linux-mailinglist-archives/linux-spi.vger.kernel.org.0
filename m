Return-Path: <linux-spi+bounces-6523-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA86A20696
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jan 2025 09:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A671188A61C
	for <lists+linux-spi@lfdr.de>; Tue, 28 Jan 2025 08:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4328A1DEFF5;
	Tue, 28 Jan 2025 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxCvaOLm"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E93F4A1D
	for <linux-spi@vger.kernel.org>; Tue, 28 Jan 2025 08:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738054568; cv=none; b=fdtZ+IsOA6Tx4ZEqnMv7qWTC8Vncmgdhnbu4cJFg6yQQl6UU5X4ZeoOclbY+85D7a+rMm3T8RNlBtEiiQroVWlZIOqxNu2GpmhNCcPMAjNLTIyW4O89la3a/hZXGVmRWJCEC28QvWx2lzPAA7KdFe1dgKEOK83vEdi+exJbeA/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738054568; c=relaxed/simple;
	bh=Hafk3TlBe5SNf0n/eZ92y3fbXwuDAUuLHKjGMbj2lFs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=BsBXyCWmGV9VY7HdXP0tB0eJISV+3ZicEXNjRJJEDRIOclVzfR4LC0it5fBUd8i8vfIoBRK7nu3bVioJFfKpWS+h3kxRPvF6fp+EwOERtJ5zD81aG93CPliDT2jQNk77n+G4PzNwYkSPDBAUhBljquFZtnGHDlttUR9WW4ZX0ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PxCvaOLm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF88C4CEE1;
	Tue, 28 Jan 2025 08:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738054567;
	bh=Hafk3TlBe5SNf0n/eZ92y3fbXwuDAUuLHKjGMbj2lFs=;
	h=Subject:From:Date:To:From;
	b=PxCvaOLm94KnZqD/p7O30/ERMt+mX/I1x1OmyMakYs+SaQ2EdzoVhkjroBfIOMRXb
	 8vxpBKysrY4+mbjkAj46DHgHo6UxQKgaPqGwYoVlm8KvyloNXw5IKH48G9U+XUuQPM
	 SIciMxw2lJsNBIyfTgUQV1R/VnlUOPBcBKxldDsmb1Zt4UgzuCvSbhaDfO3j49qKDC
	 Df1jpGK9wcqjTEk4KFWGHySUQZY1mCbqgWt8E+1dZUXfSiaeY4LaCEWtOwhxs6jBrb
	 imQS1aOFHEFm2enXnUzfE9DXy12fKggHiNUWdltqPhgI9NDWAoPY3s5nCGJjQ5KOJa
	 Okb27M1lY6E9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71350380AA63;
	Tue, 28 Jan 2025 08:56:34 +0000 (UTC)
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
 <173805459293.3718523.11603171347210786544.git-patchwork-housekeeping@kernel.org>
Date: Tue, 28 Jan 2025 08:56:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Add STM32MP25 SPI NOR support (2025-01-28T08:17:29)
  Superseding: [v1] Add STM32MP25 SPI NOR support (2025-01-22T14:10:36):
    [1/9] dt-bindings: spi: Add STM32 OSPI controller
    [2/9] spi: stm32: Add OSPI driver
    [3/9] dt-bindings: misc: Add STM32 Octo Memory Manager controller
    [4/9] misc: Add STM32 Octo Memory Manager driver
    [5/9] arm64: dts: st: Add OMM node on stm32mp251
    [6/9] arm64: dts: st: Add ospi port1 pinctrl entries in stm32mp25-pinctrl.dtsi
    [7/9] arm64: dts: st: Add SPI NOR flash support on stm32mp257f-ev1 board
    [8/9] arm64: defconfig: Enable STM32 Octo Memory Manager driver
    [9/9] arm64: defconfig: Enable STM32 OctoSPI driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


