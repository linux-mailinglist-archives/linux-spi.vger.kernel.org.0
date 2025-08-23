Return-Path: <linux-spi+bounces-9625-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D151B3260E
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 02:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69A29A05F44
	for <lists+linux-spi@lfdr.de>; Sat, 23 Aug 2025 00:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9629213AD1C;
	Sat, 23 Aug 2025 00:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQSHuipt"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AF3136672
	for <linux-spi@vger.kernel.org>; Sat, 23 Aug 2025 00:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755910605; cv=none; b=eNmsqCTV0JoCxQMKgtXMaVnTaupKZGm1nQkueIInNusbMbjQSp7J5MNyzEGlNdUYBidb7x6tj87zWjaeYWtUVp/FBz5liXYxgC+cSM7XkG0aOlmBNUaOj1xaZnxcRyTpetdh45KdBv9Hr4ZdbIgFNn9qK2avQK3xuTaNg2VTSgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755910605; c=relaxed/simple;
	bh=tAZzVDabHyhFsVpBncLJRrPTLOqaAsYvZe8AFIyJIqI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=fXp/5zADa+vwkKV1pD4NuwH79PpyT5Rf5BmhXoATR79LUQiTLqLMeGhO2EN4oLQXiNbD487+NdOoLPrYDUiKTspS3cF7Hi3U/i92P3KqA0YFr+IHSB/iBN9MhrIuu0E1Qi4RJNgPJPUPZLhUa4Dn4qTZ+yP7ormh+QrNvjpnhAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQSHuipt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC87EC4CEED;
	Sat, 23 Aug 2025 00:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755910605;
	bh=tAZzVDabHyhFsVpBncLJRrPTLOqaAsYvZe8AFIyJIqI=;
	h=Subject:From:Date:To:From;
	b=SQSHuiptPfqVX1d6alY9wl1tVkjBPamBeksvkcQiLKIjDuczM7X19cprCVl5xCy3i
	 y4Q878cnuYNfYqXap4yZwvjqY3PzGjMPQ95QunpKRllpBGwcRWdoqNyv3zoWd4QlTv
	 Zocgvy/5e9N4PzM9TEygf6ABmrg41rAU7dckSl6lvHmxzP1UBJgGK5bxi0jRR60I+F
	 lGI/dcUtR4/vz4IVXAc2nNynqnfLF8+sg1F9mO2vJtcNArE5uQKp2MiN7Au++jO62A
	 NvBZWcGqPL4tRR+X07hi4hcn9jm0YOg3OS6L/j3mJczgSu1MZYizkGDY+uJAVues7o
	 PeRItdzVQVEew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD97383BF69;
	Sat, 23 Aug 2025 00:56:54 +0000 (UTC)
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
 <175591061337.2044946.18391023984866884520.git-patchwork-housekeeping@kernel.org>
Date: Sat, 23 Aug 2025 00:56:53 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: airoha: driver fixes & improvements (2025-08-23T00:16:13)
  Superseding: [v3] spi: airoha: driver fixes & improvements (2025-08-20T12:33:04):
    [v3,01/14] spi: airoha: return an error for continuous mode dirmap creation cases
    [v3,02/14] spi: airoha: remove unnecessary restriction length
    [v3,03/14] spi: airoha: add support of dual/quad wires spi modes
    [v3,04/14] spi: airoha: remove unnecessary switch to non-dma mode
    [v3,05/14] spi: airoha: unify dirmap read/write code
    [v3,06/14] spi: airoha: switch back to non-dma mode in the case of error
    [v3,07/14] spi: airoha: fix reading/writing of flashes with more than one plane per lun
    [v3,08/14] spi: airoha: support of dualio/quadio flash reading commands
    [v3,09/14] spi: airoha: allow reading/writing of oob area
    [v3,10/14] spi: airoha: buffer must be 0xff-ed before writing
    [v3,11/14] spi: airoha: avoid setting of page/oob sizes in REG_SPI_NFI_PAGEFMT
    [v3,12/14] spi: airoha: reduce the number of modification of REG_SPI_NFI_CNFG and REG_SPI_NFI_SECCUS_SIZE registers
    [v3,13/14] spi: airoha: set custom sector size equal to flash page size
    [v3,14/14] spi: airoha: avoid reading flash page settings from SNFI registers during driver startup


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


