Return-Path: <linux-spi+bounces-8071-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F6BAB30E4
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 09:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9302718833BB
	for <lists+linux-spi@lfdr.de>; Mon, 12 May 2025 07:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D4B255F57;
	Mon, 12 May 2025 07:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvE1X7IL"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9C08BFF
	for <linux-spi@vger.kernel.org>; Mon, 12 May 2025 07:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747036584; cv=none; b=TESyEUTBsjZzbngYu1WfRX1+L1vEoXThsJWP8OxFND7YkA7YSzs+5xcvRcH6DbXTzMoJEvQvEBqEF6KrqBaLMNOAwXlj24+rjdYjlqTwKS+XRQr1xqPi38iS7rhcuvdrwHIB82jR8ld1esC8djxMocEWD8iM9v2OYjhwJtv0DPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747036584; c=relaxed/simple;
	bh=Nmf5u6kOlnm+GCS2/libJSuxPPCAqX6ttbb2gm9NnDY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=t4eEFSbyp94STHGY8ObZk0WoEUmOlQN11b1Xwz3xgC5tm46j2Uy2e1+vmLnk0sDYi5+j7m8BXzC0NDiqNVLkomQ9YyCXIoZb+s1BnREQJINrIDMy5+CSu5v1XGa7i4w3tzygfaYJZdhYQxSoSEMMwSqKrolvJc1Zfjm5TZRdaaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvE1X7IL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD240C4CEE7;
	Mon, 12 May 2025 07:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747036583;
	bh=Nmf5u6kOlnm+GCS2/libJSuxPPCAqX6ttbb2gm9NnDY=;
	h=Subject:From:Date:To:From;
	b=FvE1X7IL5k0ALNRM/OrF2ZgYIuxcQ1kjn+DoqmpgZdlBWVqbBmRHyldTt2pi5Bf0r
	 LNXBU9mxf7POYj8mXNAU/ex4emk/3PCeb+z8IsB0mYz5jIvGPn/znMSeoJlvdF5ukB
	 6J5vlOMiMFGq+klTu+wcHeh77FYs8YluXwV7XE3rGpi5CsJBOWZfFbEebvhqdMR2pI
	 luWsjFWN8u2Rn2EnmfD1DBoq53c8sc8pF1/anjpWIDJPLPZ3CIiNIcdS8CUI6l5vhW
	 05PrD3TbqLoxeBerC9Y+N8+rlZ4j7dG4blKr8xTRRmIz0JK00G6PzB28hmByTOLf/v
	 iN1haA0LZbpmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B0D4239D6548;
	Mon, 12 May 2025 07:57:02 +0000 (UTC)
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
 <174703662134.494493.16798540806819328408.git-patchwork-housekeeping@kernel.org>
Date: Mon, 12 May 2025 07:57:01 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: stm32-ospi: Make usage of reset_control_acquire/release() API (2025-05-12T07:01:04)
  Superseding: [v3] spi: stm32-ospi: Make usage of reset_control_acquire/release() API (2025-05-07T16:04:13):
    [v3] spi: stm32-ospi: Make usage of reset_control_acquire/release() API


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


