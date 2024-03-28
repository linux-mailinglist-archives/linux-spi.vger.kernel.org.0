Return-Path: <linux-spi+bounces-2085-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79560890BA8
	for <lists+linux-spi@lfdr.de>; Thu, 28 Mar 2024 21:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33DB5299AF5
	for <lists+linux-spi@lfdr.de>; Thu, 28 Mar 2024 20:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C840113A890;
	Thu, 28 Mar 2024 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nysvQVyB"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E6313AD13
	for <linux-spi@vger.kernel.org>; Thu, 28 Mar 2024 20:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658431; cv=none; b=O/mNVBfw6Da2dSJp43v8+OxjiwN92FzzrgvjqnXCG3iQIeNvSibkFI79X9cPPoCXShQmE9aeKoTu+wjahws52YOdTo7/DAtmDwty2Rtm3eKhFRpqkH4XevPgk2wBERv5PACu0eM9vNHmYNYSqtA0rn/w+jGD6HVbeAJFi1yJD00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658431; c=relaxed/simple;
	bh=iy+QaJsJluUtoIrokQhj8+5Mp9wy4C24QgTXN5DxYEc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=QqBhvoTT4scEIJGnXllXlJsk+lvHyq+0cmr/qOcLBk370l6NDzXjFZYhzvPQnj8JiwWmaP8W5h2nkb8PXP30L6L0S495SHE3RfjoZKUFd7QHrVb7ZOkS4c98/Za7Z2iH8IwT5jV8ySodESdlimbbJVfLCdxqps+cOp4oIEyGQ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nysvQVyB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5BE06C433C7;
	Thu, 28 Mar 2024 20:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711658430;
	bh=iy+QaJsJluUtoIrokQhj8+5Mp9wy4C24QgTXN5DxYEc=;
	h=Subject:From:Date:To:From;
	b=nysvQVyB9Fx7sL6UMb3Hd5PHRiGYUlBeTKYsbrqVZY/KD6uOJv5WiTAJtsi5r3tLN
	 MzJFdfGEsVZQPCki2n4RwPQ0DCHXuubs39esZksdQ9LUUS1A2Cwk/9nq6DEdtkjIJ6
	 28C/sNI6Sn7pcwGBgFKwNlg3Dli9V1jXqFOnoVSylU2+Isq+roFUawvY/Gdd7ULCqo
	 cQWd/9+8rFbWS7heMf8XltxT1NTlaQ1zKBKELatVUFgNaqcEG5JlNk4TsrnCv23c1Q
	 pHub1NuqKf+Ih07a4W7/p942in8V+uTVY9KgX2kxqWXIkYM/kd/Tph2H6qMzNacPd9
	 dw4BEET3gwStw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E93FD2D0EB;
	Thu, 28 Mar 2024 20:40:30 +0000 (UTC)
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
 <171165843019.18759.3608416080671993930.git-patchwork-summary@kernel.org>
Date: Thu, 28 Mar 2024 20:40:30 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [1/3] spi: loopback-test: drop driver owner assignment
  Submitter: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=839001
  Lore link: https://lore.kernel.org/r/20240327174737.519637-1-krzysztof.kozlowski@linaro.org
    Patches: [1/3] spi: loopback-test: drop driver owner assignment
             [2/3] spi: coldfire-qspi: drop driver owner assignment
             [3/3] spi: fsl-dspi: drop driver owner assignment


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



