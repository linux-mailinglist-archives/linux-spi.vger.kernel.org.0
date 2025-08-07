Return-Path: <linux-spi+bounces-9310-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 393DAB1D3E7
	for <lists+linux-spi@lfdr.de>; Thu,  7 Aug 2025 10:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7EA45844EE
	for <lists+linux-spi@lfdr.de>; Thu,  7 Aug 2025 08:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC05423F405;
	Thu,  7 Aug 2025 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0DF7Yd9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CDD259498
	for <linux-spi@vger.kernel.org>; Thu,  7 Aug 2025 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553561; cv=none; b=FKujrBcFBmTY7fBsY3ALkmruZoS75glYaxfewIJ4b8tF8igRA75WBdceHJxmrPqfc3AgCziyVsCf6vs1GSPJZ1tFOCnYzt8slV7/xGl0Cd/EPa81FgiB1qfwyHryicphHHFMrrmkd8HrFO6enjsdszrM3LU971paDjcpG/IxgPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553561; c=relaxed/simple;
	bh=2HqALpYvkvFXmYpqVr2LlXwpxeg5XRTdPEEO1p3lkeg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ZYLqUAkgGaseMK3BXmlANKqnLI1oDnKfVSUbGp7ldjCQN5wityVcUXnV1BUgULsWglW/WBAG22kSVAD2kUmi0qALR6Y79qeei1qS0ZuaQKXWEvzNGoCul0rvweyZhRWZDc8Z428ZS4mYBzvAF+0Oh0K6fsub4qfHhh7EM6l6+lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0DF7Yd9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59038C4CEEB;
	Thu,  7 Aug 2025 07:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754553561;
	bh=2HqALpYvkvFXmYpqVr2LlXwpxeg5XRTdPEEO1p3lkeg=;
	h=Subject:From:Date:To:From;
	b=Z0DF7Yd9wqo83da5tA/ncFfFz6ejg6bn9seI7LZAuSpWn/8hJHQ3jbtRnDMsLvary
	 AAGibH3BUfsvsETF+emsw0hDgU64dGrsb82mFk89cBWYtN53I/17pdy8ZEHTxYwzFx
	 glisu3YJrXxStYWQ1rB4XJimyzDT/hYIYtCBd+5j+Jg8r8/Wt7+AqMNviqTUKK5Jdk
	 /nCq2kkQ0PI44oVM85S0RxkFaa8Xl1UmNEjTmCFQMTmkMg8wCrMG1ONnuKiRYkrpkC
	 euGc3bTBqGZ6eaMZueFUvfCJ6U4iEPYO2tKaiiEoyCoMPoDgOuxzjJHoAstdZ/2M+b
	 H72pFziFDhhnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CEF383BF56;
	Thu,  7 Aug 2025 07:59:36 +0000 (UTC)
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
 <175455357486.3457833.11641129490330857882.git-patchwork-housekeeping@kernel.org>
Date: Thu, 07 Aug 2025 07:59:34 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v8] Virtio SPI Linux driver (2025-08-07T07:29:33)
  Superseding: [v7] Virtio SPI Linux driver (2025-07-25T09:41:41):
    [RFC,v7,1/3] virtio: Add ID for virtio SPI
    [RFC,v7,2/3] virtio-spi: Add virtio-spi.h
    [RFC,v7,3/3] SPI: Add virtio SPI driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


