Return-Path: <linux-spi+bounces-8466-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F46AD5CC1
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jun 2025 18:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B50AE7A3401
	for <lists+linux-spi@lfdr.de>; Wed, 11 Jun 2025 16:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4EE213252;
	Wed, 11 Jun 2025 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIPMH5fW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473ED2E610F
	for <linux-spi@vger.kernel.org>; Wed, 11 Jun 2025 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749660969; cv=none; b=pSJVxZtm64LP6NIFk7k9zVcaTT0FDn/Sk6FIF7KDxwMJRp9UM07balHePIooTE+Ot7DoNPd+c4uUpDrZgM4CLvrRP50V3rXTF+68yHL0+PXq9EdmnITfwKA/yHzfop7gLJu/12+/xhi8NeNGnCKUhdj9BBSqWh7ntKE4KnKofcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749660969; c=relaxed/simple;
	bh=H3tgxhRTIz418jzrneB3jZNCX4VgfVl2MggGvbktzW4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=d1QMWsTvv4DeY45RVp1MpR4ZGlzfKdoK+5dg2jqiwGWO1L+r+eTEz0U3gAbPFU6VmIOrcDOZixjZwimLJHubZkjqh6fHiVPPZ04XlvKVqOYwkvGkMstG7otN0Ey9PEI4gxF0BAJdZzrvtzBIrpx3Ap/7qhx6CxMtvwzpWlY8oG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIPMH5fW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DC2C4CEE3;
	Wed, 11 Jun 2025 16:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749660968;
	bh=H3tgxhRTIz418jzrneB3jZNCX4VgfVl2MggGvbktzW4=;
	h=Subject:From:Date:To:From;
	b=jIPMH5fWLOCVj6rZgiFlFqFLfYC8LsbEFzxRfKQiCfCyS1pvOjMEccULQy54P87Hb
	 WwHLG1jql0TGGKKNNv+CRtfr2HtdTdDlOhuZHGvy6AWlozfVN7xgezDYjVfFai1awC
	 SdCw2FgZLBCINRbmcw/4IRzmPJrYKlBHy6YHMMOUfcJhDyEQvgT3vCB1qbLfrXVY3R
	 pFfXFPDDZ6OwzUNvpJYhTKsZE/5ezmhEOZB6oxk1iFaOB+p0j96YnqS0W2EnOQMilq
	 j0ZV6FpeObphBvlxdrASYwHQRk1ydKxl2Ns5vktmLhwPHAke7RCukzwsDLzLIAQz/h
	 faCub13PZlnxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F1B380DBE9;
	Wed, 11 Jun 2025 16:56:40 +0000 (UTC)
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
 <174966099886.3406693.15029571407574893289.git-patchwork-housekeeping@kernel.org>
Date: Wed, 11 Jun 2025 16:56:38 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v7] clk: clk-axi-clkgen: improvements and some fixes (2025-06-11T16:15:33)
  Superseding: [v6] clk: clk-axi-clkgen: improvements and some fixes (2025-05-19T15:41:09):
    [v6,1/7] clk: clk-axi-clkgen: fix fpfd_max frequency for zynq
    [v6,2/7] clk: clk-axi-clkgen: make sure to include mod_devicetable.h
    [v6,3/7] include: linux: move adi-axi-common.h out of fpga
    [v6,4/7] include: adi-axi-common: add new helper macros
    [v6,5/7] clk: clk-axi-clkgen: detect axi_clkgen_limits at runtime
    [v6,6/7] clk: clk-axi-clkgen move to min/max()
    [v6,7/7] clk: clk-axi-clkgen: fix coding style issues


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


