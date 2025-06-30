Return-Path: <linux-spi+bounces-8898-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAA3AEDBA8
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 13:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E2493ABEEF
	for <lists+linux-spi@lfdr.de>; Mon, 30 Jun 2025 11:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF4625DD07;
	Mon, 30 Jun 2025 11:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0Zw6FpW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD8E242D83
	for <linux-spi@vger.kernel.org>; Mon, 30 Jun 2025 11:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751284316; cv=none; b=rEYw5PTURv3hxFnN/7n3gxNkg321Z7VT9pHcTMFNMZT1jOWUt3M2yiPgnsYgPV1+n0yZ53+Q0xV6pGa06Sf2k1ZagIjcSF4JheVY7Zbvoy38jziiayT+ypzBMYR6iuGMTf4FwOWIiw9ZVt7vkcrMW+eWb6+3KtpXFE+E8SEvap4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751284316; c=relaxed/simple;
	bh=woXSC+rx84spto4KE4h6UU7x1LUKrlTZDjo49sZ9rzQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=d8GJw7Go4ZKzbj7i7d35pErqsUzBqwdWlpbrv6KQldHPpxNZKCqYZSfdU+to59MPD9QFWvPqSpZXTAitGKgfA9NAQTvg6/vHE5dILBgeZI5xp6NA91nKdSl7Y3Rov/IOFZR/godRbDXl1TTfXz9Ay6ca1hLOCGPDofSal4f0d3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0Zw6FpW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F31AC4CEE3;
	Mon, 30 Jun 2025 11:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751284316;
	bh=woXSC+rx84spto4KE4h6UU7x1LUKrlTZDjo49sZ9rzQ=;
	h=Subject:From:Date:To:From;
	b=l0Zw6FpWG9z79pkaHbwCNmPv5tJ0GXm+vbh+KUmwmcuqqPbX4FGd7fmKk0KHkyZ6e
	 9XnqXxRkTRUlCIHTIFKlkN6huy8xqwj1cql5YCQUnBjTXbtQj8Uw5/iPaw8d4iF1C0
	 nbTLkYqIB4xlDJzSLRTp2t0dAho1PVN1h8LMO8n/QTuckKaHMisudKInbgETys3YzX
	 7k+BLkAqH+MNA2kuyiIMbF/8P3QlQ41JkFIN2Al/3R47KFQmZArWxdlX0CtEvyiRht
	 9ADB+qNT7QlcVWTG2Df+7C4WoGAH8mEO8cNEmdws132u18UMdeh/MHXvKPuBnEIoxe
	 AH1cdauSavLnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B1945383BA00;
	Mon, 30 Jun 2025 11:52:22 +0000 (UTC)
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
 <175128434116.3350170.5700614330186146317.git-patchwork-summary@kernel.org>
Date: Mon, 30 Jun 2025 11:52:21 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: spi-fsl-dspi: Target mode improvements
  Submitter: James Clark <james.clark@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=976574
  Lore link: https://lore.kernel.org/r/20250627-james-nxp-spi-dma-v4-0-178dba20c120@linaro.org
    Patches: [v4,1/6] spi: spi-fsl-dspi: Clear completion counter before initiating transfer

Patch: [next,v2] spi: Raise limit on number of chip selects to 24
  Submitter: Marc Kleine-Budde <mkl@pengutronix.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=977072
  Lore link: https://lore.kernel.org/r/20250629-spi-increase-number-of-cs-v2-1-85a0a09bab32@pengutronix.de


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



