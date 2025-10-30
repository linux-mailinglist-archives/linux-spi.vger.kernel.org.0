Return-Path: <linux-spi+bounces-10912-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B63C1FDB7
	for <lists+linux-spi@lfdr.de>; Thu, 30 Oct 2025 12:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5EF4C34231E
	for <lists+linux-spi@lfdr.de>; Thu, 30 Oct 2025 11:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C174C2E5429;
	Thu, 30 Oct 2025 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sPGLMvX5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFEA2DEA74
	for <linux-spi@vger.kernel.org>; Thu, 30 Oct 2025 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761824427; cv=none; b=iyQxcp2bCFv+ATOJRWlu3jVGko4k+8jJLYtvMLFHshnseV4iXr+mNpp+enh48c7fWtharCHn2MRUn7NhIQfAW1faJO0hGhEEZDBdKbqo2JJoMIGd5kICc0mMMlb8yYbSlza499wHK4yjO5HiSdICGrWbQQTGlzuBxcrzMiEJSm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761824427; c=relaxed/simple;
	bh=eluOLefC42EoTVHchPTvbV3HCcSH5YiZprxrApibWPI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=dU2VaeGWUZ3IIld2HYWrAw0TFQb1FeoZ8DEenHSGEkyqKvy747oupwPk4JK9E+KIyhqx5cKCKQhOe98YQJa8OlRQenJidNn19i65NBrfJJTKBqDHngrIxLwFOoDA9aFEiw6zz+Ui0Td0kEoz/efu9PvzT+cCqgN89bO/skJLt/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sPGLMvX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA12C4CEF1;
	Thu, 30 Oct 2025 11:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761824427;
	bh=eluOLefC42EoTVHchPTvbV3HCcSH5YiZprxrApibWPI=;
	h=Subject:From:Date:To:From;
	b=sPGLMvX5Q+voqG19IHCfdFSigjFC7nx5/JjxKx3BV1oa5CwUmEE56teoKwfMJEUZc
	 085Q+GXUOImxrZzuSnf2tr4EBA1GMVH4eUXnCrcw/qbvMG/uJqgpMReMhpstrZwBgO
	 xLOHlwSqkf51BLaf6+0PcOmAxyZUnTrptXmVD0J8Vz0SJ2are4zLAKpePxRM2SaTcq
	 QaVJ/KVLxpzmBz+K8/lB5HsEdU4yWhR5gU5jUl74H/EoRygCdJ9rYt9+S1eIFLkF02
	 wiBkL3zG0JPuazmLfY6CQRobe7yT7FYc0r+B5CG8Pw4PIFVy+PhthqoJxc9UTkQSwk
	 iVgTPH6gGREaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EE4A73A72A5C;
	Thu, 30 Oct 2025 11:40:04 +0000 (UTC)
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
 <176182440373.3815727.252373023689999927.git-patchwork-summary@kernel.org>
Date: Thu, 30 Oct 2025 11:40:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: intel: Add support for Oak Stream SPI serial flash
  Submitter: Mika Westerberg <mika.westerberg@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1017049
  Lore link: https://lore.kernel.org/r/20251029065020.2920213-1-mika.westerberg@linux.intel.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



