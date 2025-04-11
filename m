Return-Path: <linux-spi+bounces-7556-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A627AA85DFE
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 15:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA6D3AA8CD
	for <lists+linux-spi@lfdr.de>; Fri, 11 Apr 2025 12:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6372367A9;
	Fri, 11 Apr 2025 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aN/PSH0V"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157AE1372
	for <linux-spi@vger.kernel.org>; Fri, 11 Apr 2025 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744376212; cv=none; b=uWABPnM8yjeeddFXe3YiXmZGzKM6LAuh2B0RKW6wM1zftPIMPZZg382YewEjrR2m/cd/xYBKM52Z9boUxrRgJrU4j8TMJ4slWYin1Rr8DLg030637VmkuI+m5TExGtZeZ0LyCGHtDx63zvVupGnpyUFIY6fW3AfdjW8NdkQt/oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744376212; c=relaxed/simple;
	bh=nG2LzA2I4qlRbkoO5Nz3g4ukKunfpHZgp4rJMsBGjp0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ZLP4KqHwpOGlGBhTD7uGPvVq0FYMrMxAk6qLxhUTtCuOrobDEYorfDUaLppuDbcd74JCuhNmSAavGGkKN3YvY+lqPhkHf2crewE26v3DOGQ6AMfPxXIDRK0n0zsmDp7LuL1kGsIan7GeLj+2dSCny3knyLxqp+3gonEf/KqywiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aN/PSH0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2991C4CEE2;
	Fri, 11 Apr 2025 12:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744376211;
	bh=nG2LzA2I4qlRbkoO5Nz3g4ukKunfpHZgp4rJMsBGjp0=;
	h=Subject:From:Date:To:From;
	b=aN/PSH0VVGbEJmbQWwD8xHrHYaEmAUhzXhsr2q+mkE1mBfbX34/4WJeSM3pKaC/56
	 63LS4/wMf8uh3HbSykDvWBIz+95Zs8ru+56iuX5tA0j6lsMjZWkrXyNFa3BZYRlia/
	 3gdXaFlLfKt9V/y0t7Vet8W52J/lF+l3a6bxlH/xjJZKNo4HDvPLOKzUQ1AS/1dyeW
	 VSmMTDtuMkYilsEyKfOX3RqahiN5qaDCQrd7Mc4VuWIosXmk/OVb72PJmH4O9Ly6UI
	 9Zl2NFCwMfxjh+aGn/TTOqkqesoUvZhwDg9tzUTXxRjgJ2pM7H7QgdIFK4TCqhCTi2
	 WJU1cWmhB6dow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE9638111DF;
	Fri, 11 Apr 2025 12:57:30 +0000 (UTC)
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
 <174437624931.259015.18135793000363192799.git-patchwork-housekeeping@kernel.org>
Date: Fri, 11 Apr 2025 12:57:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] reset: Add devm_reset_control_array_get_exclusive_released() (2025-04-11T12:41:09)
  Superseding: [v1] reset: Add devm_reset_control_array_get_exclusive_released() (2025-04-10T12:23:45):
    [1/2] reset: Add devm_reset_control_array_get_exclusive_released()
    [2/2] spi: stm32-ospi: Make usage of reset_control_acquire/release() API


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


