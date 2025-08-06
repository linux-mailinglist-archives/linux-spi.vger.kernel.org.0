Return-Path: <linux-spi+bounces-9303-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E29F3B1C615
	for <lists+linux-spi@lfdr.de>; Wed,  6 Aug 2025 14:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F236556347C
	for <lists+linux-spi@lfdr.de>; Wed,  6 Aug 2025 12:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9933D26E146;
	Wed,  6 Aug 2025 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PflecqRw"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749B8CA5E
	for <linux-spi@vger.kernel.org>; Wed,  6 Aug 2025 12:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754484009; cv=none; b=lhJJSeCrv3bu+25he5NpgCn2+HO/nOyDLWRGH5zkdJfyZ+NPFn4cFg6mWWhLKgckzEgQSSJPHkwyDI+IAWMudT0bXGXCwzT+B8g0wL2ut1ZIakTcN2nQov0+NxY8EZzDg4n7Bza2PZ/KbAljINQe8iC+/qPAAff3lPa19pM3ciY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754484009; c=relaxed/simple;
	bh=rjAW/WkSN+6PhBDv4N/v50lsh0QoOwVTvZepWS+Aemg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=WMi6uoAJGlXqapzNSmg7eA88z6pRDC+dvJMKZ7pYoXgZIdHbambnegiQWcPTYQGOEx9Rf9uCZsmWkEdVzr76dEJ881NBmlQtqkOWGsAk3n66eYAbNq0NrbLw+3xyyOKUgwX024QjckK+6arHoIsdTQXSw/+wya0KwOvSCgMBHqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PflecqRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA7FC4CEE7;
	Wed,  6 Aug 2025 12:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754484009;
	bh=rjAW/WkSN+6PhBDv4N/v50lsh0QoOwVTvZepWS+Aemg=;
	h=Subject:From:Date:To:From;
	b=PflecqRw9rpw4ZGNI20U3WctqoZKt3IYyQhq4TaC/WRDsmA9zqmtK1h/FGAdp1ACe
	 DjYYRbCfCQBt4EEmtOxCiXOs/tCrJSMrIdyyAyABERvYtQtOpJXC18YiweHGiI97Bh
	 bOqaTbxgIK80Ts/FBy97qvwF8T8EkP9XOhiOC9e04e49qsgx1s1YEd5NhcB92ZEdTT
	 ZX0jSB2aKSgbWi3aZ8tVCZ61v6EqSot+PBHUqgF9BOx7UCg6G7EXroijmZEXUZqjXf
	 yu4VfbcIxCsxSLuA2OcCs7xpP4GZlGjHf5pZt1yFbXdeOgkfKLt+VOUvjySnxjTpor
	 QyOcd6Eo4VA5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EE8DC383BF63;
	Wed,  6 Aug 2025 12:40:23 +0000 (UTC)
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
 <175448402248.2773882.14177659866632294359.git-patchwork-summary@kernel.org>
Date: Wed, 06 Aug 2025 12:40:22 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-mem: Add missing kdoc argument
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=988075
  Lore link: https://lore.kernel.org/r/20250804095013.409700-1-miquel.raynal@bootlin.com

Patch: spi: spi-qpic-snand: use correct CW_PER_PAGE value for OOB write
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=987597
  Lore link: https://lore.kernel.org/r/20250801-qpic-snand-oob-cwpp-fix-v1-1-f5a41b86af2e@gmail.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



