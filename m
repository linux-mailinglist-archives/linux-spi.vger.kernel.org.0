Return-Path: <linux-spi+bounces-3130-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064728D3D7D
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 19:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B796D1C2201C
	for <lists+linux-spi@lfdr.de>; Wed, 29 May 2024 17:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955EE15B547;
	Wed, 29 May 2024 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xamwzd6n"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F01C15AAC8
	for <linux-spi@vger.kernel.org>; Wed, 29 May 2024 17:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717004432; cv=none; b=gTQOkmV1O4rKeGymk2pKHElhURBO/lylR2uz3TxDfWREPr7xcSWGE2IsxNEu1Yl2bl5Q+wkKh1Q9cvzHzMf31DS5avLLUgEnibEErqmCkVx+cSz8q79QUTQeAHg3/Cu3esbEC3+uCdsyna8Hv+d96QHuzWjYC7iUYwop64n5Aew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717004432; c=relaxed/simple;
	bh=OcxmxEhbsGivDBeMwc2qgTy/VUeWIy5+aa4tdfa44t8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=WSOl9ahAjurv/ZAjBztEMzBNCs82BUgQ7Ld2RFAcwxuPYLbbzS0KJVZF461M9whVtmZ6fQSqwDQyO42A1DqbEtaqtQe+DKzztR0lkpDoONdzX3oCRhFrTwgiY51nTT7T/UOs3SOSYln+btv1ZUNI5/BffqWWYdaeS9D7pslPX4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xamwzd6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E78DAC113CC;
	Wed, 29 May 2024 17:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717004431;
	bh=OcxmxEhbsGivDBeMwc2qgTy/VUeWIy5+aa4tdfa44t8=;
	h=Subject:From:Date:To:From;
	b=Xamwzd6nRQrIzYSgd+vmPty8QxfxsfZnSxAE594jPazdf7+WG1iXO22E/VZ4DRCnR
	 /vU+nDxuXL0koGsgpr2d+0hyzCHr1xEwRRX8I4rqqrcnNXHViEXq7FQ9+fVOXfrzPl
	 uc2W8N6d7V89uoVH3nw1I6T3X8AIH4lLibX2Rt+mHscIV20tHI6SrJgP0pVHxrFbRv
	 vRDEqWDdj7/zheliKQa+AtJly6BDaJPhcs8uUBiVcHuj96VXP66aeWG3aRNJaIAlfR
	 rZINK55BytOCmNR/3nwtVnccZ5Kxo3AlCwPXH1B3mX+XcOjGsWQ0KFdJlCoM15YOSF
	 lVT5vJKnyDZHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CAF4ACF21E0;
	Wed, 29 May 2024 17:40:31 +0000 (UTC)
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
 <171700443174.14686.24837275519493920.git-patchwork-summary@kernel.org>
Date: Wed, 29 May 2024 17:40:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: Assign dummy scatterlist to unidirectional transfers
  Submitter: Nícolas F. R. A. Prado <nfraprado@collabora.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=857048
  Lore link: https://lore.kernel.org/r/20240529-dma-oops-dummy-v1-1-bb43aacfb11b@collabora.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



