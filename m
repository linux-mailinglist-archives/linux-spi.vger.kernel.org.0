Return-Path: <linux-spi+bounces-4802-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 587CF976F21
	for <lists+linux-spi@lfdr.de>; Thu, 12 Sep 2024 18:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF95FB25901
	for <lists+linux-spi@lfdr.de>; Thu, 12 Sep 2024 16:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02E81BE22C;
	Thu, 12 Sep 2024 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hfpx0Rk5"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6761BCA18
	for <linux-spi@vger.kernel.org>; Thu, 12 Sep 2024 16:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726159830; cv=none; b=PI4aGxV3b9MJ2Bs4vxyMKZOpl/4JX3cPyZvnuCFmJ19tBNF4KWYy5EnnitvvnYaKVjuBImEdzhTbtUY61Pkt6AcOstsiNh87X+weGwKoFjs/EP2RPthPMeBtSJqREwu5UVRQxeCi5GEfJHaeZv+3WFsHoWruLrYBPI97C0jScXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726159830; c=relaxed/simple;
	bh=As854ScqtSJQDOHvWH5YG5Lwu3y5i41gsNj/bVH9IsA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=psbpF1AG7dsunXLusGi9+d6R46k1cN7az3cuLAtdrHvSNTcxRbKd2LGgkopEfwmd9BGGr5BtPIVTvCV+ERSoTT1OQk52G3rxL4bTg+2ILymJdAgpQqdlj5zNkxE6aqSHxoH3OuRDbj93gaeiK1MXfTufLMJH9xW3noXB8B6jqpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hfpx0Rk5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37382C4CEC3;
	Thu, 12 Sep 2024 16:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726159830;
	bh=As854ScqtSJQDOHvWH5YG5Lwu3y5i41gsNj/bVH9IsA=;
	h=Subject:From:Date:To:From;
	b=Hfpx0Rk5GHN7pVyjsb0SdQs7f4UkbC+QO4KW471SSkSGJXg1tVEt/QFysbu7dEYUY
	 uaIbooOuyrTzQOULkglIh+GTLsjjGjQCou5fUw0eAnTD729yhkJqrWZhbvQg3xb403
	 klJrWIrpG+wmt6WHOtOEhiXWrpcYV4R4KY7224BQT5za86uI7M4sGBVOtbRQzPhDg6
	 INOKBdHWRE6SvP3E/1w5fj+OvbhDpHCUcYLNaTVxk6AueXzamsQ0Z8XtCW+cwopw9H
	 491m7fDGPx0awJUw1zUoNrHF5ehdD/iZPIsTvdHyizu45cxqumZTY3G/RquR939g5j
	 lh9aXlkMrvqqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 757783822D1B;
	Thu, 12 Sep 2024 16:50:32 +0000 (UTC)
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
 <172615983088.1657713.9341151047657259422.git-patchwork-summary@kernel.org>
Date: Thu, 12 Sep 2024 16:50:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: nxp-fspi: fix the KASAN report out-of-bounds bug
  Submitter: Han Xu <han.xu@nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=889495
  Lore link: https://lore.kernel.org/r/20240911211146.3337068-1-han.xu@nxp.com

Patch: [-next,v5] spi: geni-qcom: Use devm functions to simplify code
  Submitter: Jinjie Ruan <ruanjinjie@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=889674
  Lore link: https://lore.kernel.org/r/20240912091701.3720857-1-ruanjinjie@huawei.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



