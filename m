Return-Path: <linux-spi+bounces-6785-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDB5A32AF5
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 16:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E9B8188CDA3
	for <lists+linux-spi@lfdr.de>; Wed, 12 Feb 2025 15:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF3A214A86;
	Wed, 12 Feb 2025 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIH2xAPu"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872A621A424
	for <linux-spi@vger.kernel.org>; Wed, 12 Feb 2025 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739375793; cv=none; b=BWbHKPgHLK9u6Zu/4MJexW83iV5XII7SFyTbndmyN8SisoXFfaNOVAwloxGi/I5FLrVznEsFMl7w2rrV04gL5MRCew1722m8jE9UfYDAMjf8qIKbkCSubtQVNYBgm/vHyTQyebhYbH0xpbKa19NsXz8yP0nOfeEiEITx/uHcz+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739375793; c=relaxed/simple;
	bh=A977X2uk8bWmDPnQd9RVBplj0iSuPo0NL96hrORfl3w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=JCJmXaoiTlH5u+hj+lS/OgwqOtXqqReiV5vFtrGwPYUqtwOHx5V7usQfKCcoSb+JZh+cjaDLM/1r8be4Qpk0koXU+UEafQi4UAJXs+9CpY8ksD66u+fJYlLj5iyIZknu9Eovjmqy3AR4aAJ0QUFKQez/f7iouzwq8lHNKpxlO3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIH2xAPu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09744C4CEDF;
	Wed, 12 Feb 2025 15:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739375793;
	bh=A977X2uk8bWmDPnQd9RVBplj0iSuPo0NL96hrORfl3w=;
	h=Subject:From:Date:To:From;
	b=rIH2xAPucz8boQfpzqHdAsn89N73zMZm2dNa/kIeeLLDFbWvM+JdiGBBBr+2oFLXq
	 ctffh5RzGi+KVx2APoAEyjSNy5Ey56FSdqcQcazvYpSlTCbqu2hZ3BZx7wjfx+hvX+
	 1NA9bjUiDlUZRp1bk0jqRnAfwMEVWHQ6d4vkSHHJA2bPu6vKW26y2F3yqOhSsNkZcf
	 SC9/ugcrDIoHepNrK1KpoP8Y9msn2knZhjcL1PIaqR2fyI5S9zAdEl72BXS1PnNHuF
	 8/MEXPHxddYBLIz6QulnBWu34HAbXDL6xo2TjLvdlHKxU1UzKN58/mlukGJy6Plwal
	 h8GEArInztgkw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E91380CED8;
	Wed, 12 Feb 2025 15:57:03 +0000 (UTC)
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
 <173937582173.567541.2876032143870469542.git-patchwork-housekeeping@kernel.org>
Date: Wed, 12 Feb 2025 15:57:01 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Configure Clocks, Add Native Dma support. (2025-02-12T14:46:45)
  Superseding: [v1] Configure Clocks, Add Native Dma support. (2025-01-03T06:04:01):
    [V1,1/6] arm64: tegra: Configure QSPI clocks and add DMA
    [V1,2/6] spi: tegra210-quad: Update dummy sequence configuration
    [V1,3/6] spi: tegra210-quad: Fix X1_X2_X4 encoding and support x4 transfers
    [V1,4/6] spi: tegra210-quad: remove redundant error handling code
    [V1,5/6] spi: tegra210-quad: modify chip select (CS) deactivation
    [V1,6/6] spi: tegra210-quad: Introduce native DMA support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


