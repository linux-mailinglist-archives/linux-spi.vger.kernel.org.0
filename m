Return-Path: <linux-spi+bounces-6081-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 558249F4C7F
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2024 14:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E6B118930DC
	for <lists+linux-spi@lfdr.de>; Tue, 17 Dec 2024 13:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CD81F3D2C;
	Tue, 17 Dec 2024 13:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJLeUBj/"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABF61F37C3
	for <linux-spi@vger.kernel.org>; Tue, 17 Dec 2024 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734442259; cv=none; b=r10Uj3qmOR5iQtfRUIXxpb+rqynALAasnxJJu2diSgtZeXxbW+qqJl74oDsyQG/u69JexQOycvBsXw4Ugusu6hDq2B5p4ONE5VqpuBacEX3qXa2LOwjjjsbJEFpg1DRXFNOMiktNUQP0FWu78yWcqgJ7jwyoSpUL1MTfAom/ynA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734442259; c=relaxed/simple;
	bh=03UCX1acxK+DxquyL2BZyzUvNhxi5xSdSIJh3nDm2xI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ubhmmldtLIQXpVItDfkGT8zm77O02rdJiRkHxXNWczVl+tHgtAL1nJbL9jQ36FrN5/xNIR4PpRPn1IjcJJ7RES/T+vTEZ4XTsyehm1pO/OCH05Pddnsp1bFuseSZqR6e+SQnnqbiBOeS3Ffdfs2L2aSUj6ve+Qg1weFC0p45Dug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJLeUBj/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8E0C4CED3;
	Tue, 17 Dec 2024 13:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734442258;
	bh=03UCX1acxK+DxquyL2BZyzUvNhxi5xSdSIJh3nDm2xI=;
	h=Subject:From:Date:To:From;
	b=hJLeUBj/D5TSK+/9MNFdSo9EN7fj8qQDQGuUA8j1JIjqpOWcTHy6zNoI8TK++7aol
	 cWnvGPcSzOtSA+nwQ9OE7dJcYJ9iSzgEbDYwynJedgnbmcK2ojBmuUccA162rIc0rw
	 ygxSX/c02uZifrVWcpBFy2cB13HoGlIv7uiTxcWNfe5K1nw72jmg6ilLBO+hV1g7PC
	 mz+q3xCIPgkw1CukPoLyLnvCusTbbU3p8AhT6J2iJDS+OeN+d3lpf/cwzm2dH3wGao
	 WJXteHpEgwCBJTo1ncH5xUiPKIkwcAvqF1ewcYixpNZA4Tt1UeyhAVtpBu+dkwuOd+
	 Mtq/z9IQTQvrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 003633806656;
	Tue, 17 Dec 2024 13:31:16 +0000 (UTC)
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
 <173444227560.897448.5832278051340583017.git-patchwork-summary@kernel.org>
Date: Tue, 17 Dec 2024 13:31:15 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: rockchip-sfc: Support pm ops
  Submitter: Jon Lin <jon.lin@rock-chips.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=915686
  Lore link: https://lore.kernel.org/r/20241208130311.1324024-1-jon.lin@rock-chips.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



