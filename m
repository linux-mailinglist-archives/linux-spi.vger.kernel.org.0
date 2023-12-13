Return-Path: <linux-spi+bounces-263-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7AB8119B4
	for <lists+linux-spi@lfdr.de>; Wed, 13 Dec 2023 17:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDEF0B2095C
	for <lists+linux-spi@lfdr.de>; Wed, 13 Dec 2023 16:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00BA35F10;
	Wed, 13 Dec 2023 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xvg1ncU+"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D182FC21
	for <linux-spi@vger.kernel.org>; Wed, 13 Dec 2023 16:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22264C433C7;
	Wed, 13 Dec 2023 16:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702485624;
	bh=CeuGR5aJ6Z34Jm8mBPKJuP3fMa28meOiz4zcrzPcu1U=;
	h=Subject:From:Date:To:From;
	b=Xvg1ncU+TI3QK8T7Qt4eo1q8Ps92/RMGt2AUossTEl6g8sjsoPS/78kdbLmiVuy7s
	 nqlCEthNSXBMNhf2zjbhsl/eedTdAdEsLJqc7zXuQO3sVJeACLr2j804VDi553kASd
	 jBiOXhQ89ti2QUauTv9PvuogE0e69Q4XM+ekBohFua8DTDUkoBVGwOrcFNUNQx4T14
	 1ef7ufrU+CsA1mtTV0+bnInzRaxKneD0ARfJVAakKIlqFFe9imQUHfmQM48DAlQ/se
	 baWAvKYRWwPXCeLxPGg9Gm84InWPn/sJ68lftmp2FtMS0Fp/Nq8QsydqYbRvQ34GQ8
	 b3OCZBGnvq9AQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04369DD4EF0;
	Wed, 13 Dec 2023 16:40:23 +0000 (UTC)
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
 <170248562393.26473.7361046688933771356.git-patchwork-summary@kernel.org>
Date: Wed, 13 Dec 2023 16:40:23 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Remove Intel Thunder Bay SOC support
  Submitter: Srikandan, Nandhini <nandhini.srikandan@intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=809541
  Lore link: https://lore.kernel.org/r/20231213060836.29203-1-nandhini.srikandan@intel.com
    Patches: [v1,1/2] spi: dw: Remove Intel Thunder Bay SOC support
             [v1,2/2] spi: dw: Remove Intel Thunder Bay SOC support


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



