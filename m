Return-Path: <linux-spi+bounces-5650-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 573629C0E11
	for <lists+linux-spi@lfdr.de>; Thu,  7 Nov 2024 19:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EDA61F22E7D
	for <lists+linux-spi@lfdr.de>; Thu,  7 Nov 2024 18:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E155155398;
	Thu,  7 Nov 2024 18:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gj7Si3oG"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1E838DC8
	for <linux-spi@vger.kernel.org>; Thu,  7 Nov 2024 18:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731005421; cv=none; b=S8tClJHaHAmf8tDCFP8uFggsEbtN8ai3FO4VUjb6zVZlzZ/+MDVpSAj0k6bmUF+EyAjnH3o3mLqsjy/BjWoXwJKPLTlxqUvWusKkeIg6aOTjTFeQibtL8gLkpTYymaEvxvcxbrRPDTqATVt3oNIjfpqCD7RLHvBTh3kQSRsf6Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731005421; c=relaxed/simple;
	bh=l38Nc8GmbaO4vwEVW4dWFT01YBx0Q+9bvK1/Q/BQUhA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=kOOeYP0c78/z1+bE9uz8iHaMarMRC3/rJooLDo1MHOPTN94M2lLSWtGA0K2FBCsWb0spHU280Fj5JyCZZpHHfRdyASJ3u+vZ39TPqthxa4rQDCzW5RSlvcHt7TeG9pfvDIku130qBaT72nCNV2FjQz3Nrt9/SOGeSgB5WXeTe2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gj7Si3oG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E88C4CECC;
	Thu,  7 Nov 2024 18:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731005421;
	bh=l38Nc8GmbaO4vwEVW4dWFT01YBx0Q+9bvK1/Q/BQUhA=;
	h=Subject:From:Date:To:From;
	b=Gj7Si3oGH8KTuMT8phyQIqndYp0me6LlL15LBaGkiizhep+Va68soLNzafd9QkMpP
	 WLfE1PPuwJCZE5OltTZEU9bZUbWFUYX1b27B1hLbULGJ1hX/iehdfQuMHKtLl54j0i
	 GDsaUMh2wkSSOnLwxNvmWTxFMENanvzV+G2aVjns8H+7AJhfJZzZEi9WtmYXXhTNp9
	 NIIQMuKAUWyDKyMi8Sjj8LEP8wlS1tUQVXrTKDaDIYBqmPA9VTSzMFwHMb0gJpJfSu
	 053uwkx3OGPteZB3V2SbESgOAfQ9JfmQ9Ns5neE2NCgYoxHQQ9tTqhhKEVzBPajtBt
	 RjTxcrq1r/gAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 44F3D3809A80;
	Thu,  7 Nov 2024 18:50:31 +0000 (UTC)
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
 <173100542996.2059209.11465134195072201057.git-patchwork-summary@kernel.org>
Date: Thu, 07 Nov 2024 18:50:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spidev_test: add support for word delay
  Submitter: Jonas Rebmann <jre@pengutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=907434
  Lore link: https://lore.kernel.org/r/20241107-spidev-test-word-delay-v1-1-d4bba5569e39@pengutronix.de


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



