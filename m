Return-Path: <linux-spi+bounces-11202-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E105EC5CB73
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 11:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C57D0342069
	for <lists+linux-spi@lfdr.de>; Fri, 14 Nov 2025 10:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9163101A2;
	Fri, 14 Nov 2025 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReEmj87S"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE92B30E854
	for <linux-spi@vger.kernel.org>; Fri, 14 Nov 2025 10:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763117864; cv=none; b=FGB1YQ4Gn44O4uvCiy147qnM157+YV/VQqgMzx0BgfuH+iLq06kn7FsovzEttmPUHpGV+xsvxoEvucPNQzG+OxghIr1xUajYudJEjDHcm6oOnzdVw5d9o1ssJrkkY0nK7zBzsH6J4u/dfwRMUIgmgIFc88AloZRMC2H5/VFABJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763117864; c=relaxed/simple;
	bh=Cvr0UWvwF20+Bo0o2b1f1rpv8w3yEDsT9xRH8hoINMY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=i50o8+pjtFm1gvZ1wHzuwQXzShKl5OUeWXcnlq5QAuOswpPNCIT6C51FbylD4wGSIokZDfodhbeIyVo1aUU1Wasg5yxVoBp9igHbP4UMrU8cCCAoC8BnZN7H/BWXJQGUV1z5PFOuZZc8oYCdlkbUlKDxT/304U6bnQLjXuEwYmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReEmj87S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47CE5C4CEF8;
	Fri, 14 Nov 2025 10:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763117863;
	bh=Cvr0UWvwF20+Bo0o2b1f1rpv8w3yEDsT9xRH8hoINMY=;
	h=Subject:From:Date:To:From;
	b=ReEmj87SB2FfK9n9fWtqfxgfPflbhUn5KIvfWe0ovdkk5FtSdj0E9AbNKWlWpDWtp
	 tVm+CYhR8ayi5szK+9E64u+X1f56dv+2WTqt4bWqVUNy94V9DKOqH2TSGGhOZtuM2Q
	 BPY3QI0wVaAYffWmzMTie7CqBMJWlMOpSNW6Cs7pI9rEJlbzG5eLLHpnIJPc40M5fz
	 Gt3V+uuhcnuzs6f4981NTpgQWnq/xpoFSCwMTaz4sf8wv4AB7siEumiex3bisRVr1S
	 C89j/5qIVPWoas1NbdSZ02qIM/EZXhwnqhdHr/XON4jpfRWDa79BrVG5+Jhva2kwl3
	 SU0j6ESKFjvDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E9F380A94C;
	Fri, 14 Nov 2025 10:57:13 +0000 (UTC)
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
 <176311783185.1605347.12978872917519007013.git-patchwork-housekeeping@kernel.org>
Date: Fri, 14 Nov 2025 10:57:11 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] Add support for Microchip CoreSPI Controller (2025-11-14T10:45:42)
  Superseding: [v3] Add support for Microchip CoreSPI Controller (2025-11-07T12:21:01):
    [v3,1/3] spi: microchip: rename driver file and internal identifiers
    [v3,2/3] spi: dt-binding: document Microchip CoreSPI
    [v3,3/3] spi: add support for microchip "soft" spi controller

Latest series: [v2] spi: aspeed: Add AST2700 SoC support and Quad SPI handling update (2025-11-14T10:10:38)
  Superseding: [v1] spi: aspeed: Add AST2700 SoC support and Quad SPI handling update (2025-11-13T08:53:28):
    [1/4] dt-bindings: spi: aspeed,ast2600-fmc: Add AST2700 SoC support
    [2/4] spi: aspeed: Enable Quad SPI mode for page program
    [3/4] spi: aspeed: Use phys_addr_t for bus addresses to support 64-bit platforms
    [4/4] spi: aspeed: Add support for the AST2700 SPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


