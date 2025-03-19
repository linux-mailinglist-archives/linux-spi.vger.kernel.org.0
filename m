Return-Path: <linux-spi+bounces-7231-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A18BBA69676
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 18:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1A6519C3E65
	for <lists+linux-spi@lfdr.de>; Wed, 19 Mar 2025 17:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD6A18DF93;
	Wed, 19 Mar 2025 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKz1AuTs"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE79B2054EF
	for <linux-spi@vger.kernel.org>; Wed, 19 Mar 2025 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742405397; cv=none; b=Lt3ejR8+VR008EiNgFM/OlM9tOLjTJMj2kaOruV5bE75PKT+mxjw9eEPuYcinGTHfhzvqA2LghCtAiigIqo31lwLOi6zPhdLzTLlMlPRrDVeyE9wnSZjeAQ9fCQh1F22fAJn6YFukX2Y+6JIQRKOkvC6a3/DdEMWglFJf6/EA88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742405397; c=relaxed/simple;
	bh=x0q8bURxVLJ7Kf8kf7LfpurOpauxR5vQsVuol0ArMOU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=MO/2UXN2rt5TV6SBnEv5g3ue7rw38DEOF1w7ipJdWlVTSKEkkmrjlBnpBFWw+KxEvVpjCwkqAwTPqSld/3U9k2WC50gmtC5lyFZycINNl37e8yPyk+qr5C5W7DnwfT1iEgbDZufQIJ0uqTsB31ipvpYIFqebOYBTDlaV6vTXs5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKz1AuTs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C1D8C4CEE4;
	Wed, 19 Mar 2025 17:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742405395;
	bh=x0q8bURxVLJ7Kf8kf7LfpurOpauxR5vQsVuol0ArMOU=;
	h=Subject:From:Date:To:From;
	b=hKz1AuTs/HBtEse7UMZso9fJRjJgnaqljUurxUCNnNNQ3vsRxmrB7Eb7VXWKIdu7W
	 pHlLftElf2F+gqTow1Cl/C/4xgjfPXazb9duTEN3kEe/278Beu9mXR3pwBUN+etRZV
	 Gh/rBrVm7jvvxl0HZthgRMzR9/qspIw5FScqkav8Kvgjjea8jBr8IKqrdEpHXYaGt3
	 27YdVjRIXzTx1p9m0X3hPhOY1hShVX0jKq6Fe4aiqsUXv9lOt08hHsGtXzpUTyUluS
	 XOOS2uwv4Lgu9d1bs9AD4vwVKYs+5uztSDkGpwjmAG/63q9yOhiO3dNK2bpm2y5cOS
	 Qk/RMra0GXZsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3DE50380CFFE;
	Wed, 19 Mar 2025 17:30:32 +0000 (UTC)
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
 <174240543060.1125754.16590384105502908518.git-patchwork-summary@kernel.org>
Date: Wed, 19 Mar 2025 17:30:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: Fix reference count leak in slave_show()
  Submitter: Miaoqian Lin <linmq006@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=945416
  Lore link: https://lore.kernel.org/r/20250319032305.70340-1-linmq006@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



