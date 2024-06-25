Return-Path: <linux-spi+bounces-3589-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E5891737E
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 23:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C21A1F21E2B
	for <lists+linux-spi@lfdr.de>; Tue, 25 Jun 2024 21:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A6617920E;
	Tue, 25 Jun 2024 21:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ONIsQgrd"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E8717B516
	for <linux-spi@vger.kernel.org>; Tue, 25 Jun 2024 21:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719351033; cv=none; b=QASdrfOvfYBx5+rR+Bl1y0qy8Kt+CJ4SdVFSfxr+aBjxlcNUmJCFM+Z67F0DB0+HpN7iJnsml2ZFSRx2WjaE6OvM9PWxUa+GwsTeatwNql0lQL9MlVKsJAzKzBzU+9irT+GKsGyoPVXDDhvXjqPl8tE0d1QzDDGSXcSoDgI00z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719351033; c=relaxed/simple;
	bh=WZfwEP/6zGLgD7vxzh6eTcMTUUYTLqSJ5E3jI6TgIbc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=oJjZdXB/9v9Xqc2AGc5k0AaBsFZEM2xT+vqEbHh51YUU0CNXO2puNSaY+wuXA3mLSpmoi5f0wpTI3CiZUJLpuAWzvuXOJSZTZvBy//5rezPDfVyqx0aC53s7rSZ/syY/jfPotseGA4eHWRLTyWKDnprJMqY5sSw9TsWFsOdY644=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ONIsQgrd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70C27C32781;
	Tue, 25 Jun 2024 21:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719351032;
	bh=WZfwEP/6zGLgD7vxzh6eTcMTUUYTLqSJ5E3jI6TgIbc=;
	h=Subject:From:Date:To:From;
	b=ONIsQgrd9FdUzqUmwx+bo1sEvOKv2S4Ro+TAF+eVv8FfBisbQu/Xoq37uWRnLIPTb
	 mzxXeoIMl9CXFtWagglUx3MlWB5T1j31mbGowKsQYmHuQw+Zf49D6OWl2UGSCI1Q9b
	 LNmZQ8x8au0FOS9BGeBjqLG/hmNKqpGgoR4kpFcJvREV121b2UDejPRBfP+Dr7ufTn
	 dtE+Kh6NsT3EUQXhzXVgQhh+sMjg+5MFQAB7II4Q8q+8feRBTSbbBY0zgtMiEOkYcp
	 /Xr4ljPyJRQ+xlSQqLlC1RnErkwvfwTDUYxBn1rl3AMkDW64lgspDDExJWCNN22vGJ
	 tDh13RlQQaZ3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BA19C41677;
	Tue, 25 Jun 2024 21:30:32 +0000 (UTC)
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
 <171935103230.25823.7825069376099422842.git-patchwork-summary@kernel.org>
Date: Tue, 25 Jun 2024 21:30:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [1/2] spi: spi-imx: Pass pm_ptr()
  Submitter: Fabio Estevam <festevam@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=865463
  Lore link: https://lore.kernel.org/r/20240625183919.368770-1-festevam@gmail.com
    Patches: [1/2] spi: spi-imx: Pass pm_ptr()
             [2/2] spi: spi-fsl-lpspi: Pass pm_ptr()


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



