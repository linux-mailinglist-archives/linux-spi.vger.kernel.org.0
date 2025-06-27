Return-Path: <linux-spi+bounces-8825-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66416AEBCAA
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 17:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA6C03BC76A
	for <lists+linux-spi@lfdr.de>; Fri, 27 Jun 2025 15:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C588C2E337C;
	Fri, 27 Jun 2025 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaGHaJMK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16F219E990
	for <linux-spi@vger.kernel.org>; Fri, 27 Jun 2025 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751039887; cv=none; b=HfUfCHKj3oPT01b2KX8GsZXjVMcVercst6jfmBq3DcuA0VJ72VifzMjXviK6Tg5boMVS9OT/S2lie0PeRSbcyLVgTWinHGvcydk0HrYlD107l7Dptp/pNFqN7P0YVrdETq9OWXRx2CNGsHkrs0FNt43a5CtDAIUUOl6oZBxecgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751039887; c=relaxed/simple;
	bh=OTILN+oYjBIe3c4sg309EcwTQwri/0Aj9BJelN0HnKQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=LkH3iznd5okGpTiWQ1IqdWJJXh7J4TXDk/tCpaO67uKH6ZTK2owA2rmawvWIsVLEa4a4OuzvpuY7I1r5FcBlgST4KTiTPvIRJV6fWqc0hbv+K1b0v7ObnIr2TQJH5Il0N/L3Ardwi8JcoPVQrrAzTz54wc7rLQ/8mxRpi64eeDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaGHaJMK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C19DC4CEE3;
	Fri, 27 Jun 2025 15:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751039887;
	bh=OTILN+oYjBIe3c4sg309EcwTQwri/0Aj9BJelN0HnKQ=;
	h=Subject:From:Date:To:From;
	b=UaGHaJMKiS1q4c77FXTYbcB8xkjxA3y9MSBTUbyLGt3mBE59BsMbURFnrcHtl1M+w
	 bhdJID/Vn84Mxt1nVLvFcAHzeJ64c6+V9mxpV3hqK0VNCfqIrJ332ABFEDrRRntPsR
	 yA6IOQE5Ial01dN4MiiNzJt5GV6knWLEfC2T6aiGxy+exPdUbjR3ma0g4cTpx3yEtH
	 uC2xcKHj12+cJqIElbZm9s7oQDDmWyEOU5JCWlxYj363SlL3LyApTCWtSZeLrgp4A9
	 pdEP2WZRsZwDE+0pDf5Gv4s6QbUOud3aVaU5yqMGCaw7Dl34s9Y6HONF+QmLTclREZ
	 eOsncfVS+KwUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71120380DBEE;
	Fri, 27 Jun 2025 15:58:34 +0000 (UTC)
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
 <175103991297.1974755.9900648152805033185.git-patchwork-housekeeping@kernel.org>
Date: Fri, 27 Jun 2025 15:58:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v7] clk: clk-axi-clkgen: improvements and some fixes (2025-06-27T14:59:11)
  Superseding: [v7] clk: clk-axi-clkgen: improvements and some fixes (2025-06-11T16:15:33):
    [v7,1/7] clk: clk-axi-clkgen: fix fpfd_max frequency for zynq
    [v7,2/7] clk: clk-axi-clkgen: make sure to include mod_devicetable.h
    [v7,3/7] include: linux: move adi-axi-common.h out of fpga
    [v7,4/7] include: adi-axi-common: add new helper macros
    [v7,5/7] clk: clk-axi-clkgen: detect axi_clkgen_limits at runtime
    [v7,6/7] clk: clk-axi-clkgen move to min/max()
    [v7,7/7] clk: clk-axi-clkgen: fix coding style issues


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


