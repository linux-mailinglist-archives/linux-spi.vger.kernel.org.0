Return-Path: <linux-spi+bounces-6731-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6034A2F297
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2025 17:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A743A2B69
	for <lists+linux-spi@lfdr.de>; Mon, 10 Feb 2025 16:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0C024F583;
	Mon, 10 Feb 2025 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNeMvnBo"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE519244195
	for <linux-spi@vger.kernel.org>; Mon, 10 Feb 2025 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203808; cv=none; b=lHprVpLvwg82/EEJ5YsPz/9Lk+UyfhKMnt/9reZtZ4bHd2yo3aR5g1tg8Dts6yipTpgOLO9cqn/AwJvhmeES4W6hkvP1RwNSidzYtf8own8MXNK1R/PgnbzxD7D7JjDlYVBHLX/b+kPT4btLWLOGjUiIrdDXvQXp64uKvNQ+YO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203808; c=relaxed/simple;
	bh=Ghc6pKTXNVNbF9Y2maVY2XkIGO2bMBNP6gVxcdLu+8Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=BQf9QfnBMa9EU4yBBOT83AzXDNbgK20/RRGA94WSSEO3bb2RaxX27cRFkx7xy3Hkyom9Sdw33VmZsZjjkn74BqApuq2hOf8KKlcQfnYUAI2o0SQfhAALWh0ejgThHhwTes93nPyUOyvL5ifvw+wCpUaw99VY8anwhuqeK/xgfkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNeMvnBo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E3FC4CED1;
	Mon, 10 Feb 2025 16:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739203807;
	bh=Ghc6pKTXNVNbF9Y2maVY2XkIGO2bMBNP6gVxcdLu+8Q=;
	h=Subject:From:Date:To:From;
	b=oNeMvnBoR6GoKSAU16/9MlkalrXi5+xVapBIqEfSnZWuN6onf0z5u7db+y8YT1O6q
	 XBuqEFGN8KLe0bNDh2Wc804mIbuR13pdy/TSCZtANK0xt8uLuMtV0y+KUJh5bv5zEC
	 pW2X1fh4pY4/UNIevwEBZDBi7fY/MpBMLQuCojWbrwkod5WSzMnJ9HZAru3TbX5HW6
	 5b+1TF3i5C6NsiqOYIJoInIUwQx/Ut3kOMwBVNMVp/RDTEWYUBY9izWyS4g+QyoxnF
	 C4qY3ociKjGMjJtkgO/NeJYqDKRukmmZw/moV34maZerO4yRcsOeI4S+cmzWkVSBoV
	 6cmOQyktye9Hg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B299380AA66;
	Mon, 10 Feb 2025 16:10:37 +0000 (UTC)
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
 <173920383591.3808816.7136548344923544769.git-patchwork-summary@kernel.org>
Date: Mon, 10 Feb 2025 16:10:35 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: axi-spi-engine: add offload support
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=931743
  Lore link: https://lore.kernel.org/r/20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com
    Patches: [v8,01/17] spi: add basic support for SPI offloading
             [v8,02/17] spi: offload: add support for hardware triggers
             [v8,03/17] dt-bindings: trigger-source: add generic PWM trigger source
             [v8,04/17] spi: offload-trigger: add PWM trigger driver
             [v8,05/17] spi: add offload TX/RX streaming APIs
             [v8,06/17] spi: dt-bindings: axi-spi-engine: add SPI offload properties
             [v8,07/17] spi: axi-spi-engine: implement offload support


Total patches: 7

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



