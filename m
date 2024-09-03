Return-Path: <linux-spi+bounces-4524-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A07969C28
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2024 13:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0741C2356C
	for <lists+linux-spi@lfdr.de>; Tue,  3 Sep 2024 11:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4441A42A0;
	Tue,  3 Sep 2024 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLNTMu0M"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CA51A0BE3
	for <linux-spi@vger.kernel.org>; Tue,  3 Sep 2024 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363626; cv=none; b=mFPe4g8/8aNEQ9S7Q19fCDFvpW+fQPHAAW/LxUvgUQLXdRiSIBta36XaL9SWrvzLr38AvtrGr5VPz9RRCoehZqhcdMN4FRMVenvdM5KjNNr1KLVHXWryFr2dDvcfWkVbtsYkz3Lp+ZdeenbQeIR2jO2Wc4Fud+wN8ypEwev4EaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363626; c=relaxed/simple;
	bh=oMmlP16rU94yVcdTGcEagpPVoA2nFJu3XTWHtXkR7L0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Liylgfc0oWfdvZcN9X32sGZrLbJJqo7wJQAUvXsLLdc6ggY5zbN8q+Xu/xskFMgZjkgQ9SVwD31l/B3k/mwRFwW+M9LUYvXlcvg7IdMufITlm/0tf0EYYnenFTws6G7hBZxVw45LcraTNgOq+uhwG0TtJLAjzaVIqJr7S5MOObA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLNTMu0M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A609C4CEC4;
	Tue,  3 Sep 2024 11:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725363626;
	bh=oMmlP16rU94yVcdTGcEagpPVoA2nFJu3XTWHtXkR7L0=;
	h=Subject:From:Date:To:From;
	b=LLNTMu0MzA9NEOdoNeT7fqCmR3kW1QSDVCdKXjGrttPbMnUUWYXIcsX2yAW2QGLiL
	 z+4dbV/dLJxzB78bjHJolrW198lzpu74gIPbVJMJp6tcGLeR6085yWE10XNlUGncn6
	 31Z3MxcQ4EHdnXKJqr0pmQ7FltKz2VhaY6W4tuiilYFb4EG5AMopLPX9JtMPP1b5B/
	 NZip+sx8Bc2JESztO9DybbQe/M+oH5m9IMG5ek+QNe/KtSVxDe1bca5xoRS7F7PuLD
	 xr5/UgRDYNM17A/YUuAXgZRdT6QgH3vuWNN1gH5Gw3rAsKnMucvk7yMbFe95h9zfId
	 NiHhN9HQ/2EcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A7483822D30;
	Tue,  3 Sep 2024 11:40:28 +0000 (UTC)
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
 <172536362687.268887.18154596875446666625.git-patchwork-summary@kernel.org>
Date: Tue, 03 Sep 2024 11:40:26 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: zynq-qspi: Replace kzalloc with kmalloc for buffer allocation
  Submitter: Kuan-Wei Chiu <visitorckw@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=879773
  Lore link: https://lore.kernel.org/r/20240814192839.345523-1-visitorckw@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



