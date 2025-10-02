Return-Path: <linux-spi+bounces-10432-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A9BBB46CD
	for <lists+linux-spi@lfdr.de>; Thu, 02 Oct 2025 18:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3EB43B802F
	for <lists+linux-spi@lfdr.de>; Thu,  2 Oct 2025 16:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4228B2B9A7;
	Thu,  2 Oct 2025 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLYlYaMf"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C85727453
	for <linux-spi@vger.kernel.org>; Thu,  2 Oct 2025 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420814; cv=none; b=XqxFDRZymiQ0Oo4ou79iPlIDvmFcnQSjKBDd0T7/WNaHj4E1GeuESC94O+WtKQYE9JRgk7SN4emUQqXgMZOpNNsllaDxYl649c/cg4rs0XoYC8K9URk0mOPV7Eh5jMwW51nRqeihCYN8H6LAqipwvH65gyKPaKB7D5ZHjuKdTXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420814; c=relaxed/simple;
	bh=g5MPoJfS8YtFNIpqY/njfi1znY9aol3IG8h32CcwD6A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=gkIUREDxxER93j+RNu5uYl22aMSH/lwca3DEh/F+OxkFjbvHZ9j9ObYggTn3JmOG1zuXhCGihEZlP6xo3WZMqQBty/hchQ/aocFjnFbm0YAr92SVa6RKuSI8ElDjG1PqIKKqjUxpp4lwVLgG3CV89NPiCiUWnT+QNTAI4/S6spc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLYlYaMf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5EB1C4CEF9;
	Thu,  2 Oct 2025 16:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759420813;
	bh=g5MPoJfS8YtFNIpqY/njfi1znY9aol3IG8h32CcwD6A=;
	h=Subject:From:Date:To:From;
	b=JLYlYaMfGeqGRO8SF/hJgyJXLAQtfEnPhfy6E+Vb68unrQbUUyGw/WoODafePi5zk
	 IyEgVBot3iTo1ki6vu158qieAPssMCOW1BF6/a3mZVzdW7rEbevdeWGDDO+8zAAe0A
	 DHG5ZbXq8NiG1LiFz0fdhxX8Ik1lkOw4i9Jx2YbHJ/ovw10p7cYiFB80m0J6fQbCF5
	 ycyUYh9jfpwf7rhhDiAIQzz0ZN8h9N8SL0Y+Fg8mN6Sb/B/2ITQU804dyODspT+HLk
	 /GE1Bg+fw2URJ+o6KfwVq/6IKai/le9ZsiiO/2ytwBh66y0kFEVOeJdJApCzf6CWYO
	 vDHFv8QSqXHbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EF64A39D0C1A;
	Thu,  2 Oct 2025 16:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <175942080545.2969172.11313089256076089524.git-patchwork-summary@kernel.org>
Date: Thu, 02 Oct 2025 16:00:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [v1,1/2] spi: dt-bindings: cadence: add soc-specific compatible strings for zynqmp and versal-net
  Submitter: Conor Dooley <conor@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1007788
  Lore link: https://lore.kernel.org/r/20251001-basics-grafting-a1a214ef65ac@spud
    Patches: [v1,1/2] spi: dt-bindings: cadence: add soc-specific compatible strings for zynqmp and versal-net


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



