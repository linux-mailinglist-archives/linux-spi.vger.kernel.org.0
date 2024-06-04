Return-Path: <linux-spi+bounces-3221-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 213198FBD76
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jun 2024 22:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9364281CBA
	for <lists+linux-spi@lfdr.de>; Tue,  4 Jun 2024 20:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B288417C96;
	Tue,  4 Jun 2024 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcvGr9R8"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDD914B945
	for <linux-spi@vger.kernel.org>; Tue,  4 Jun 2024 20:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717533631; cv=none; b=j4BmvjYasu4CJ5xnu+22L39l35SIbPAszR38CEDrmktiw7XjQCGFav0GrdH+yNuVkEgjHx4kPn2a1KYGWQeylyVwi5HN6ej6eD7XQIYec9fUokr/4r9uiX2LRTaE2llw8/Ea7gwRn5nGIfJw+fR+Z+2J0UYzCNCCvY3f3E444P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717533631; c=relaxed/simple;
	bh=uBXt1qLAWEZhV8H3Jbsla48Sm0jLWwAm6s36pCCsZT4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ll7GF9KOUoDnzppfvfR16SZXOFvn+WtVGMS+im54s6yBQWEKiFl5wtI+tqpJ27h0WsZw34DIAEBR+tT192yrTRTOdyulyIGsLNVUkBlx0ZmbLQCSNw7K0Z7RJ3kzFcmh9XLzf9rXmGFw2EbrdMtKsTWnTzMk15ncsvWY2SB2iXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcvGr9R8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2579C3277B;
	Tue,  4 Jun 2024 20:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717533630;
	bh=uBXt1qLAWEZhV8H3Jbsla48Sm0jLWwAm6s36pCCsZT4=;
	h=Subject:From:Date:To:From;
	b=hcvGr9R8+H2+rhdR6ggnjrP+2EIfze7hXCdq7eqwlzqNzFSIim/WhPnuFgNIH3fCX
	 F4eXwQmTbMR3PsegLr0iXnOkiqpBlmp9L0JqE6rg9ORcIDCe5Z0kvRPW52PKttmHiA
	 lusLl3VDqveediRGoZHPyBUJcar8eGJz+U3fs4XTj+kr/eNrg3BX1M8YXoYR8enQNO
	 zRARiS2aqsBC6a7fBebBtYO+985QlsH7VkPBjKvnmn2ht4LZmFtUmxOf85nZNaAbvD
	 bc+gzDzFjvkNS/NNh6hLGSbUpmfzdJz7Y5NRJE2yvB5Md86CL9+zpWWByZuapWnJPU
	 afOXUqcXKY2SA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 960CEC43333;
	Tue,  4 Jun 2024 20:40:30 +0000 (UTC)
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
 <171753363061.4603.11227387382849475681.git-patchwork-summary@kernel.org>
Date: Tue, 04 Jun 2024 20:40:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: cs42l43: Correct SPI root clock speed
  Submitter: Charles Keepax <ckeepax@opensource.cirrus.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=858677
  Lore link: https://lore.kernel.org/r/20240604131704.3227500-1-ckeepax@opensource.cirrus.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



