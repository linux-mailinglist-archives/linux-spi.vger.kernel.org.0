Return-Path: <linux-spi+bounces-10518-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 616D9BCB95A
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 05:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 171AE4E0454
	for <lists+linux-spi@lfdr.de>; Fri, 10 Oct 2025 03:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E3E1459F6;
	Fri, 10 Oct 2025 03:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nmzR53on"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DB03FB31
	for <linux-spi@vger.kernel.org>; Fri, 10 Oct 2025 03:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760068613; cv=none; b=aHuJfxgUNoMIzMgpLY7hoA4PfYP02UHwiF3ee/vG2goyZxar+WhNmPhqDciqLwdkwCu2YN0MFkDO7S9Ewh/Psb0AOtu2n/ma2ixmF4BJiPY/LxYtR/OnIWPEcXpTobJyUSFZp5/n2o+7Sr5wmzLYh725+GCkIRX7G9YjVTfHbIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760068613; c=relaxed/simple;
	bh=uAGP0gWgdbIW14TBOAai9ssiGyx9Jfr4S0L9ENh5YHU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=nP38oB6fzaDmFT3MMSIpqvsOk5mODC04juOcJtXnZMkPnypysBtsujlv7cOf82j+ZyathWnZSk4uWAOcXMjspVR/HNnr5QDwWKIH5Q9Mk6e288yx9UIq3YFvChRX+h8qEMwF12mYJbaBj6ETFljvMVuPUEozlk+LrZ5nTYCsqh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nmzR53on; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DAB3C4CEF1;
	Fri, 10 Oct 2025 03:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760068611;
	bh=uAGP0gWgdbIW14TBOAai9ssiGyx9Jfr4S0L9ENh5YHU=;
	h=Subject:From:Date:To:From;
	b=nmzR53on7U9oKubcgP28ts+tKsmtqrB/Qi3u0sjIUDEvy7Gm4OjqiHqYllz2D7FTY
	 hGli9Q1xbwmkTcLlnO9VILBxEdBo/HyPsYtasaacrTF/eGa6UOmUf2BekgX0L7SLlq
	 ORqkRhVEn5qVnQkEMGM9Mo2TCN01TUJxccozo0yuJiWyUz2eE6FtlnQlINXIJqjkk4
	 /++DAvzkGFijxED8iSj2qycjEuBnFXPPx0lUDnrAHOJvgFHziuvkCMAiug4saerdff
	 NPmJ4A/rs0cvMie6PYlkFM0Orp1SWykwhpr4EUc6me8XbuezpU7s/RsdHjMCR/fJkF
	 MMTDTaQOyIDjQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C933A55FB7;
	Fri, 10 Oct 2025 03:56:40 +0000 (UTC)
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
 <176006859895.417140.8659616832079869693.git-patchwork-housekeeping@kernel.org>
Date: Fri, 10 Oct 2025 03:56:38 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v7] spi: airoha: driver fixes & improvements (2025-10-10T03:31:19)
  Superseding: [v6] spi: airoha: driver fixes & improvements (2025-10-01T22:23:33):
    [v6,01/13] spi: airoha: return an error for continuous mode dirmap creation cases
    [v6,02/13] spi: airoha: remove unnecessary restriction length
    [v6,03/13] spi: airoha: add support of dual/quad wires spi modes to exec_op() handler
    [v6,04/13] spi: airoha: remove unnecessary switch to non-dma mode
    [v6,05/13] spi: airoha: switch back to non-dma mode in the case of error
    [v6,06/13] spi: airoha: fix reading/writing of flashes with more than one plane per lun
    [v6,07/13] spi: airoha: unify dirmap read/write code
    [v6,08/13] spi: airoha: support of dualio/quadio flash reading commands
    [v6,09/13] spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
    [v6,10/13] spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and REG_SPI_NFI_SECCUS_SIZE registers
    [v6,11/13] spi: airoha: set custom sector size equal to flash page size
    [v6,12/13] spi: airoha: avoid reading flash page settings from SNFI registers during driver startup
    [v6,13/13] spi: airoha: buffer must be 0xff-ed before writing


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


