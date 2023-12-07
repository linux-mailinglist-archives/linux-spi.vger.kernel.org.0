Return-Path: <linux-spi+bounces-176-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5BE809582
	for <lists+linux-spi@lfdr.de>; Thu,  7 Dec 2023 23:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C1A41C20B7B
	for <lists+linux-spi@lfdr.de>; Thu,  7 Dec 2023 22:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DD04EB52;
	Thu,  7 Dec 2023 22:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3lKqe5U"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EB458AAD
	for <linux-spi@vger.kernel.org>; Thu,  7 Dec 2023 22:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C62CC433C8;
	Thu,  7 Dec 2023 22:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701988824;
	bh=8ingoRqOoVR06Sn0rffvKMzmnmVO4wpME2XZhoIwUc0=;
	h=Subject:From:Date:To:From;
	b=T3lKqe5U4gHeU75BgUSTQ+GjG+6iW9DDVDyYCKSQOtpppBziNyHi9CTHmsAr2m+Rq
	 dwVQEHKGrqH71skS9sj78F6I5Bz9KLDfgBUSP8emmO1VDX5IIM+BG/E7aEs6XHjaiX
	 BYVM/S3GkIcujmjE9GldUyP5/JQ57CkRw9eMM0zC+LXYQpKeKUWW+yQ3TsVQge0kYu
	 kuOQ5aCiO4mMGFQGEy2EUCVVPHH9IvQWfpsnWUHON/r+milbKi3w+ROVTWlMib168y
	 NkkZKsVHAayhao+ziqy02XoU0+ImDDNP1DoJD3743ZoUjUVkCeybQpwVX271T7uzPr
	 7j3cFQ9og539Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F2CDDC43170;
	Thu,  7 Dec 2023 22:40:23 +0000 (UTC)
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
 <170198882393.5857.14658536394629029454.git-patchwork-summary@kernel.org>
Date: Thu, 07 Dec 2023 22:40:23 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: Add support for stacked/parallel memories
  Submitter: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
  Committer: Lee Jones <lee@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=804173
  Lore link: https://lore.kernel.org/r/20231125092137.2948-1-amit.kumar-mahapatra@amd.com
    Patches: [v11,01/10] mfd: tps6594: Use set/get APIs to access spi->chip_select
             [v11,02/10] ALSA: hda/cs35l56: Use set/get APIs to access spi->chip_select
             [v11,03/10] spi: Add multi-cs memories support in SPI core


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



