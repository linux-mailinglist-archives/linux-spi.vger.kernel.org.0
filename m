Return-Path: <linux-spi+bounces-8344-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD28AAC92DE
	for <lists+linux-spi@lfdr.de>; Fri, 30 May 2025 18:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9885C7AEE98
	for <lists+linux-spi@lfdr.de>; Fri, 30 May 2025 15:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9972F235055;
	Fri, 30 May 2025 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qJmR0BlZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7599A20AF98
	for <linux-spi@vger.kernel.org>; Fri, 30 May 2025 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748620796; cv=none; b=bLUt1F6occd5f4PgZdUK0DtmDPfpQ+IrG22wUM6YQkKj+bVyKolPiA6OD0I82R8Dhj94DlAc4gDCcahWphagtd1UYiP5h7BN65d0t40Rsx5Dplnsn5gU1kcJ9ftI+i3M7v+eu2GCGcN6ZVnV84fPugXdp8R+kffFgX0NcjFwc6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748620796; c=relaxed/simple;
	bh=J7jDZ80s6T/nmMCaWX6l4WtG7fT/I+mAKlmbnesJ3wE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=VbZuQvC+2k1D/CyCUT3qr8Gv+yrZrNk3IN/QxcT3tbclur8LDZl2l7tYkkOGVcPn0p+8E5lOi/+GKTywbE+ZVsFHO/PWd9fdkXzD6PxRP4NxyMxwQl8ifJtTqIyfj7kHEBfV/IFpDhUTplTzdE2+FyikHZbTI3Vgnu/B2DMdFAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qJmR0BlZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1ADFC4CEE9;
	Fri, 30 May 2025 15:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748620794;
	bh=J7jDZ80s6T/nmMCaWX6l4WtG7fT/I+mAKlmbnesJ3wE=;
	h=Subject:From:Date:To:From;
	b=qJmR0BlZPKkZAjMlNfENXm84O0WvpBElY421UGvprOjhyV/RQyXkH8ht41mQMDefF
	 6Xm6NjP3AVWxBlhk/kimuTaV5UnvnvgDpRPPaMFICgCmrit/1T0L13Gb8F0EPObYoq
	 giRkJqGIM9pR49pI6mZ+Os8Xszat/nfLmdoH1+8rkz4HepQsvdILLhgk01z/JX/GJR
	 NjL0Lj6oOcb9DBIlik+Xb0g/4LXWL5FXTp2ATdKWgbRCGWt86s0D6RM/E7y/enFuQj
	 dzNHC9PwXe1OoPDjnMtopopV1oGgW3JxN30vHOItrGRwLUiZwoE7zPvA/p/4N0H+hA
	 jzYcELidVbEbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 74B1839F1DF2;
	Fri, 30 May 2025 16:00:29 +0000 (UTC)
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
 <174862082794.4001687.13794103392391270622.git-patchwork-summary@kernel.org>
Date: Fri, 30 May 2025 16:00:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: bcm63xx-spi: fix shared reset
  Submitter: Álvaro Fernández Rojas <noltari@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=967337
  Lore link: https://lore.kernel.org/r/20250529130915.2519590-2-noltari@gmail.com

Patch: spi: bcm63xx-hsspi: fix shared reset
  Submitter: Álvaro Fernández Rojas <noltari@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=967338
  Lore link: https://lore.kernel.org/r/20250529130915.2519590-3-noltari@gmail.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



