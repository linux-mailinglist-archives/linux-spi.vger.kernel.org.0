Return-Path: <linux-spi+bounces-1643-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A96758728EE
	for <lists+linux-spi@lfdr.de>; Tue,  5 Mar 2024 21:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55BF41F2B8E0
	for <lists+linux-spi@lfdr.de>; Tue,  5 Mar 2024 20:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024541292D7;
	Tue,  5 Mar 2024 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOSMhJWV"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E94D268
	for <linux-spi@vger.kernel.org>; Tue,  5 Mar 2024 20:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709671828; cv=none; b=l5FLC0eFdBqN7AdTrwn+6AsR6hZlglmnVOEsaihCU2zFXu2Zs1B5U9gSHzhQ3NAD/Pq+SKgiMb+2cRi/37bkJ9ZbPBTkMkFCDOewInyLHylJMtFBVTGe9iD3qMWwDmvMAphL2i+U4f1h5QrO+spvb8KdJBwW2tnk7itR/9okMYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709671828; c=relaxed/simple;
	bh=V/YcujL6bTfM0Jo6xsqjA1Nf1kUCWZMNI5rKsofIjVc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=mXQVOLJlNFVXPzUPDc6moJaNSyOAr0EYZ+1p8je+QWcOU8UgzJlvqCvMGdUeMIlIykByLgxEN2j7oGKuGk9lUpP1E/ZIeaGIW821i+BieqYRjW7sDVtqN58h2iiK/wdbq5fhW8rd16p/SHqZwS9CHmbdz1S//2PLkLrmbGfe9P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOSMhJWV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66BA3C433C7;
	Tue,  5 Mar 2024 20:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709671828;
	bh=V/YcujL6bTfM0Jo6xsqjA1Nf1kUCWZMNI5rKsofIjVc=;
	h=Subject:From:Date:To:From;
	b=FOSMhJWV2VMhhK/KCxjxRYx/P/5/Fbz5Hc4PlAJ64clNS8gfhL7MMz1rNbWjtkWYd
	 yMt3KwPy0iExxtYo6M6+D6pzS/R7ijssilqVlN3+x2840jW2FdzOhfr+GYSVRQHnnf
	 ODVht/ysiEIkW7KuZ19f9Y/lNV5NHYDL9GC6kTVmgtbTJWPOL6zFCOBZd416rD7ROY
	 M/xAYz2Vt2vFxMCiR72MagsWxWsYzOuCv009b3hIq+F12smGy2dZLsRIMYfNCE6hEY
	 6WUQdj/usKEq1Wsy7fWhY9ov045AViad5zqmkfFcuQmzLGWUafHcvj/MRecP1tcmzl
	 WkRYP9Tt+sgPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C0E6D9A4BB;
	Tue,  5 Mar 2024 20:50:28 +0000 (UTC)
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
 <170967182818.15786.13791312610696939052.git-patchwork-summary@kernel.org>
Date: Tue, 05 Mar 2024 20:50:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: dt-bindings: samsung: make dma properties not required
  Submitter: Tudor Ambarus <tudor.ambarus@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=831503
  Lore link: https://lore.kernel.org/r/20240301115546.2266676-1-tudor.ambarus@linaro.org

Series: spi: axi-spi-engine: small cleanups
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=832148
  Lore link: https://lore.kernel.org/r/20240304-mainline-axi-spi-engine-small-cleanups-v2-0-5b14ed729a31@baylibre.com
    Patches: [v2,1/3] spi: axi-spi-engine: remove p from struct spi_engine_message_state
             [v2,2/3] spi: axi-spi-engine: use __counted_by() attribute
             [v2,3/3] spi: axi-spi-engine: use struct_size() macro


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



