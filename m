Return-Path: <linux-spi+bounces-3543-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5869913CE2
	for <lists+linux-spi@lfdr.de>; Sun, 23 Jun 2024 18:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46D8CB20375
	for <lists+linux-spi@lfdr.de>; Sun, 23 Jun 2024 16:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60120181D14;
	Sun, 23 Jun 2024 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8sBxGcp"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF0B8BFA
	for <linux-spi@vger.kernel.org>; Sun, 23 Jun 2024 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719161485; cv=none; b=JsXJFiA39mwuM8OT6HCUSawMhyOkhr0kDrlH5ds7WED8x513jPL7mOHe6CbO2WGipE86lhn/68G91CNy9UOj/u+M7RCuZL81IislGrG08pQZHNAUGX1sPfB5Hy0/mfMx1tukFhmijzkKtouUkili4IfjvHDenxLhn1F+GExZUfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719161485; c=relaxed/simple;
	bh=U4K0h1U9FcTf64VrSmbw3rG0ziarOyFJHwwZhaBgW2k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=sn/H45Sb0h4UlgmEx1j2eyMmJs+acFBsuatSeRHQvPkBs9DYCGvkP+vogI/vmxttmiLYiB5AjJ/DrobtPVFT4ytQNUl1B5qAysudtjk20T7HirGSgnszYEuYK4UvmvVEMpfueFiXDdIC/xrusq22jyEdeFZP6nw9kQHPXdjuhjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8sBxGcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9D39C2BD10;
	Sun, 23 Jun 2024 16:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719161484;
	bh=U4K0h1U9FcTf64VrSmbw3rG0ziarOyFJHwwZhaBgW2k=;
	h=Subject:From:Date:To:From;
	b=J8sBxGcpXsT34zu77O/L4XSbFBq9uxK03ZhhYDL1koNItVxnBj9JcaiCLl4BzZcCv
	 cmi8eiAgU1nBcaIzhFcKHTtXrQSyy/kKBqqJD072NTaY9qlwYRqTD3hhwtP407MzkX
	 fGiixJoGLCKtwA+M7rf+Bwi89lFhs+PrP7fKqSfjrUcfS2+MMvstQE8BkFFyVahX2j
	 8IyJ9t286cE3/9vUDLOCai/okN1kiWEZvbc3c25oPBLeOftNH6Kgi5fhJUOpt1VYKC
	 sB52qPsbAWcqjSGEL0pzsRI5oZiLcoOBLiub1wudbPj6J06QC8UyIavqAHwF7cDdev
	 MGqjmWb1+iTSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADC75E7C4CA;
	Sun, 23 Jun 2024 16:51:24 +0000 (UTC)
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
 <171916148465.17958.11138576302697681914.git-patchwork-summary@kernel.org>
Date: Sun, 23 Jun 2024 16:51:24 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: add devm_spi_optimize_message() helper
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=864408
  Lore link: https://lore.kernel.org/r/20240621-devm_spi_optimize_message-v1-0-3f9dcba6e95e@baylibre.com
    Patches: [1/3] Documentation: devres: add missing SPI helpers
             [2/3] spi: add devm_spi_optimize_message() helper


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



