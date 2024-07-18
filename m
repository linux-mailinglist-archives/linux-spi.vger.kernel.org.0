Return-Path: <linux-spi+bounces-3899-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 875D09350B2
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jul 2024 18:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 380A61F2239F
	for <lists+linux-spi@lfdr.de>; Thu, 18 Jul 2024 16:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D9F13DDDF;
	Thu, 18 Jul 2024 16:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7SN0NhT"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29A67407A
	for <linux-spi@vger.kernel.org>; Thu, 18 Jul 2024 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721320241; cv=none; b=ETp3jjjN12g4+ojTgvlyVUM4QdzLtesUsc/FkQGvrUfRsKGZPho3Vwl2M2ZkN32aVmUZASYDb4Q4YuDt9CUoDPfORd4GQxjOBSueUeAsdj+yMKpLQwB6dVMze403jqB4aFsMRGmNmPqkKhnZ5UU0QkUsxs/JmPBgMJgRS2G3LXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721320241; c=relaxed/simple;
	bh=vtNFRm/64HaVDSkMzpJrODHIkYPK4iFFoSm+aNlrq2A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Es8bR+S9p3G5TIqPerFYzslqrR8iDbk2QaMVNCCupC05ZSxq87x4IMva9Hv6XKQmhcM72LXqLiQWdMGlZXlGSzoos5ZTM8EiOzzfyDSwnuIlYYod7COhx+VtjQbpX+H3SRO324JToBtUwo3ybImBqCt7g2A/S0XAwpYpzL9HPpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7SN0NhT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74933C116B1;
	Thu, 18 Jul 2024 16:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721320240;
	bh=vtNFRm/64HaVDSkMzpJrODHIkYPK4iFFoSm+aNlrq2A=;
	h=Subject:From:Date:To:From;
	b=c7SN0NhTIZ+xqYAbTqszDMP+3Hdeqj0/lePTj64rmfph9oo1NLxSV15Vp0dNSyqFs
	 O1xOmGGt7MPV6FhLTbLeq4uohPTflZreiIKw322EzNFBSf/u5VsLd1uZhKCBJ0eu9W
	 eYw7GKzjmt+Ktapz5L0rQd4K5YN30PWkez27KPQ/id9Ql1WyQLGo70/+e99fGbhC+r
	 QE1hkzU/Vm9WwYXAIlJwJZJzC1K8DL5bEbta5YIuCWrdIdO7W8HaOrNye9EHmG/jTl
	 lG8aZ0lUm9jrQ/kFGmOYilMvutKowf6FE0WGgaDUkjFs91Fx23HCnI/zoVTzZP0zTB
	 9lpFf7Bg1C+Ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54616C43443;
	Thu, 18 Jul 2024 16:30:40 +0000 (UTC)
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
 <172132024023.19997.11361660740555011979.git-patchwork-summary@kernel.org>
Date: Thu, 18 Jul 2024 16:30:40 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Fix incorrect bh2228fv compatible
  Submitter: Conor Dooley <conor@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=871938
  Lore link: https://lore.kernel.org/r/20240717-impotence-zippy-254b86593069@spud
    Patches: [v1,1/3] dt-bindings: trivial-devices: fix Rohm BH2228FV compatible string
             [v1,2/3] spi: spidev: add correct compatible for Rohm BH2228FV


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



