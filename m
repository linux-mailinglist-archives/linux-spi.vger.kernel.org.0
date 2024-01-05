Return-Path: <linux-spi+bounces-374-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC4A825A53
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jan 2024 19:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B902285BC0
	for <lists+linux-spi@lfdr.de>; Fri,  5 Jan 2024 18:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1D735EFF;
	Fri,  5 Jan 2024 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pNeIiDBr"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FF135EFC
	for <linux-spi@vger.kernel.org>; Fri,  5 Jan 2024 18:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4DF8C433CA;
	Fri,  5 Jan 2024 18:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704480025;
	bh=zSOR9yJxJOuglPQPDTAG1sZ6cbC6m7baHGTa5w6w3EY=;
	h=Subject:From:Date:To:From;
	b=pNeIiDBr01s9aa9cBPJ09atI4DPRansi4kV9nRDOqNURCwJInK6j719Sm6gWhtuC+
	 2Uz2A4gO0nLzotY/edMqPqbqWWlEm5CHNKDf/DyhpJxIV+s2CxMmGiIvhTEiYBJSrg
	 d8LuuXHrfrdos6K7vmbLUGYe2N4rLl1Qis6AbWarDulpxfhnlHAElwELohCV5UqlFd
	 Gg729mawunhqwXi6U5iCtAeY7ASURKZA7ut6xMS3KY7jEYBMqqTV/0IWVTfsMQz2i/
	 vt/vg4f7bhnbNc90YBkuK7spFsKClM8dEPfrHamwSll6lmt+78kBp7rkH+2iwnztRl
	 IZr6/PPSgNftw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86633DCB6D8;
	Fri,  5 Jan 2024 18:40:25 +0000 (UTC)
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
 <170448002549.27587.13430350654672483582.git-patchwork-summary@kernel.org>
Date: Fri, 05 Jan 2024 18:40:25 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: coldfire-qspi: Remove an erroneous clk_disable_unprepare() from the remove function
  Submitter: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=814684
  Lore link: https://lore.kernel.org/r/6670aed303e1f7680e0911387606a8ae069e2cef.1704464447.git.christophe.jaillet@wanadoo.fr


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



