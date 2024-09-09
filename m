Return-Path: <linux-spi+bounces-4751-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEA5972154
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 19:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 469D0B225E8
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 17:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926091741EF;
	Mon,  9 Sep 2024 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFPbyTsH"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E47256766
	for <linux-spi@vger.kernel.org>; Mon,  9 Sep 2024 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725904228; cv=none; b=hwztJt9RnYFWWLVSVnvwCO8KKSV1DJ+CcMpP3C94X2QHj5VKPO9q/8iFXS/f0q4Zhjbj5fDMUbCTOvHCS9SJiQQSdcL0lOERzHYhOZiqPR0TosyGZdSIxBLdZxORhdrcton/8V/ScqFkZdvDCDVOi9iGDAxi6EU+p3gSVvPtPKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725904228; c=relaxed/simple;
	bh=k9vtCpzRc4xZaklzzDG5EkKiKJALEiTZ4FfvOKg1JaE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=uLdB9T2r9QRcHoA25ZZkFMWvmnUO4gAAd8nKthOlbv0s9DzH05t359iSHU8VVOoMQWvi9WOM6YufVuDNjyqbezKmAStYfvrCrEOG+m3tL3F2Pa4NVJ1UrdcVf9OZbsrwlnHGzilK+AvyWw6MLZnV8cZ1R6dQWgSKWRuirZ2sjhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFPbyTsH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE541C4CEC5;
	Mon,  9 Sep 2024 17:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725904227;
	bh=k9vtCpzRc4xZaklzzDG5EkKiKJALEiTZ4FfvOKg1JaE=;
	h=Subject:From:Date:To:From;
	b=WFPbyTsHGoZ9FbQM8BcbedqTh/2eXZXACAGMtfeqQPXfgF7oSDvNLzvVoe+gnnqzv
	 Mbj/VeqK5p8JVCPEH8OH+Tp5xk/FAQZkQiKejKVYlSdHjKL7y+uLVbiAisz17Xoqrs
	 RFJOZPAdZKAbICT//SBYbCchMlDgC5X1r6dwNrd+s5xSTirPYwYTPAYvo5FHzokSzD
	 k5qKir9PQS1CW3VQS505Cbd8Ob37yzI614sbiAqJxP6V/99lwLMAXNvlmeaDSJvhVT
	 63mIj0agKVgN5dFdGGFKfDbPvmd2hD5NVmzvv/fYmyCJYFGBEDmmGVVkHBV89l7203
	 bzD12oGr73l8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F07763806654;
	Mon,  9 Sep 2024 17:50:29 +0000 (UTC)
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
 <172590422863.3876618.4097054664481142173.git-patchwork-summary@kernel.org>
Date: Mon, 09 Sep 2024 17:50:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: geni-qcom: Undo runtime PM changes at driver exit time
  Submitter: Jinjie Ruan <ruanjinjie@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=888435
  Lore link: https://lore.kernel.org/r/20240909132810.1296786-1-ruanjinjie@huawei.com
    Patches: [v4,1/3] spi: geni-qcom: Undo runtime PM changes at driver exit time
             [v4,2/3] spi: geni-qcom: Fix incorrect free_irq() sequence


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



