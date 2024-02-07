Return-Path: <linux-spi+bounces-1162-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D614084CAF8
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 13:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7618AB21791
	for <lists+linux-spi@lfdr.de>; Wed,  7 Feb 2024 12:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B3B76041;
	Wed,  7 Feb 2024 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vMW6QTJn"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4914A59B60
	for <linux-spi@vger.kernel.org>; Wed,  7 Feb 2024 12:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707310593; cv=none; b=MntFkFaRupqMvfUXLVMScspM1PvAsSmWcGsY2rB1TFMRgWYaSWWO2YOE79wglifBCb9K3B9ax0ILTbtAoeFYQ3b74dWypG8m70xQpfavHNQDhZx/miz9RdJCN9iqb8FkZmhsYFEKsah4S5fnzj6cS8cZPjOHdxXcJuId9jctCz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707310593; c=relaxed/simple;
	bh=qCJ2FdV8tkFCqBFxC6laKiQOs4JeEBFi3rynd+RAxeY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=WabkkWN120gpveThHFK43Yn37bVBniEYNKKNAfLErDax5BfD3nwUW7LYXAkHUXOWFd+G8ieuh0SVfjSb/F7TzjCQQZRQTi8Ie5lclDm6WbIAYqFQBMz8n5E9AP0JoWSb/ZOChTkaz+l7n7LF5Y4CmEpKBygHp+Y70YHtE8rvhbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vMW6QTJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CD9CC433C7;
	Wed,  7 Feb 2024 12:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707310593;
	bh=qCJ2FdV8tkFCqBFxC6laKiQOs4JeEBFi3rynd+RAxeY=;
	h=Subject:From:Date:To:From;
	b=vMW6QTJna73+/soPycvHGEjGePDOcO0TS0VAXnCk6ecWvHi/qVad3YvcuCCD46dpB
	 x0RpqWvVK7FozU1AawKMiXYUyNLenaGvziQo6+kb6n0vL4pNrkc3yIFi79GwxNcEbB
	 k+HDJLQb0tQ2G+XWI2AwxSd6ArvqJXSiQebyfsOVO5xnybGKk1z4DQkAXHFZGwXu1/
	 NOhfTCVOyPgLnm1uBJa4awk48HpNvhlWS6L1WVi5MoOu1+pleMMPXr9QQCshlJVKj0
	 h/cNczZ1r5NU7vQzvME6B4ggoBX4qg4GYwjemcTWm+L0prF2IwuSLqz+kvsAuEjdXI
	 AmhKeRMZT0X1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01DF0E2F2F1;
	Wed,  7 Feb 2024 12:56:33 +0000 (UTC)
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
 <170731059300.25612.7518480793060410445.git-patchwork-housekeeping@kernel.org>
Date: Wed, 07 Feb 2024 12:56:33 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] spi: s3c64xx: straightforward cleanup (2024-02-07T12:04:14)
  Superseding: [v4] spi: s3c64xx: straightforward cleanup (2024-02-05T12:44:57):
    [v4,01/16] spi: s3c64xx: explicitly include <linux/io.h>
    [v4,02/16] spi: s3c64xx: explicitly include <linux/bits.h>
    [v4,03/16] spi: s3c64xx: avoid possible negative array index
    [v4,04/16] spi: s3c64xx: fix typo, s/configuartion/configuration
    [v4,05/16] spi: s3c64xx: sort headers alphabetically
    [v4,06/16] spi: s3c64xx: remove unneeded (void *) casts in of_match_table
    [v4,07/16] spi: s3c64xx: remove else after return
    [v4,08/16] spi: s3c64xx: move common code outside if else
    [v4,09/16] spi: s3c64xx: check return code of dmaengine_slave_config()
    [v4,10/16] spi: s3c64xx: propagate the dma_submit_error() error code
    [v4,11/16] spi: s3c64xx: rename prepare_dma() to s3c64xx_prepare_dma()
    [v4,12/16] spi: s3c64xx: return ETIMEDOUT for wait_for_completion_timeout()
    [v4,13/16] spi: s3c64xx: drop blank line between declarations
    [v4,14/16] spi: s3c64xx: downgrade dev_warn to dev_dbg for optional dt props
    [v4,15/16] spi: s3c64xx: remove duplicated definition
    [v4,16/16] spi: s3c64xx: drop a superfluous bitwise NOT operation


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


