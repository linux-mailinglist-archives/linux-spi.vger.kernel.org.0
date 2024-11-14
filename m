Return-Path: <linux-spi+bounces-5701-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A065A9C8BBE
	for <lists+linux-spi@lfdr.de>; Thu, 14 Nov 2024 14:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43640B2E883
	for <lists+linux-spi@lfdr.de>; Thu, 14 Nov 2024 13:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D33D1FAC3D;
	Thu, 14 Nov 2024 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKs5uRia"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58381383A5
	for <linux-spi@vger.kernel.org>; Thu, 14 Nov 2024 13:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731589816; cv=none; b=EuOJqcRTP55Y9Fuvc2897CwA0pxK2l47RF9akdKkZaPm8vlKbkwMMIuBm447eXlhKXId19QdbrVG//PxfwX4XpAnroMQbhTESVlcm+as8xdjdc0ogbty/tF4VCwXkrGvEN/1Lp0gTqC8gdy7TIjXmzVwZ6yYZ6IywG6G6DNeC2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731589816; c=relaxed/simple;
	bh=BCN5GcawwkqtDjzlSEJHl+7LptSlH3IF6YxypnT4sFE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=rRWS/nLNKUXm2PkfWHJux+N+fRpUXVf4RNiK+BO2yd9Ki84+8A7aS3npL01y52X52Nh0nK/Z03854BR6aWzbEsl/LiPR94KRHegVgeRU5jB4A4xbORdeLAk1oiktg9LP32SG6KQ84HR+eDwhalkbS2SODZtfQt/STtRec6W/DxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKs5uRia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DCDC4CECD;
	Thu, 14 Nov 2024 13:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731589815;
	bh=BCN5GcawwkqtDjzlSEJHl+7LptSlH3IF6YxypnT4sFE=;
	h=Subject:From:Date:To:From;
	b=gKs5uRianxHS7h9s5cGtC/6IM5mGXVAOn1ivW+X/FizR02q40jxJ5tbYZuiBLxjh/
	 LNvZ7Gn7qeQydQDFsiSNlNhQbObqOjQdNZ9ujPbakpnblISvCjEh4cDBFHokRvAdOU
	 IkKkGGnJwRjMH7a7K3WddfVYxNngkJJvLPZkwDyoEdK25GFa7IWQtvudKMNY6/4CjA
	 YwadLqJ8W++/xu9Ebd/Ynj+/B3n/J0cOHNtpxqCiNh7WcqE+h5rrBYrMXP4UyPZl77
	 IxzWL5dDjK+ZOtikXcxRcTBJ8HLzz4YMCBWpzS0DHWceuziU9z3k8gUkJaulbuk2UC
	 XhHm1AbneDz+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7434D3809A80;
	Thu, 14 Nov 2024 13:10:27 +0000 (UTC)
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
 <173158982599.1921561.12326924104683615769.git-patchwork-summary@kernel.org>
Date: Thu, 14 Nov 2024 13:10:25 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: imx: support word delay in ecspi
  Submitter: Jonas Rebmann <jre@pengutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=909269
  Lore link: https://lore.kernel.org/r/20241113-imx-spi-word-delay-v2-0-2b65b737bf29@pengutronix.de
    Patches: [v2,1/2] spi: imx: pass struct spi_transfer to prepare_transfer()
             [v2,2/2] spi: imx: support word delay


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



