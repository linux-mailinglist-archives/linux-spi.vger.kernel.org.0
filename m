Return-Path: <linux-spi+bounces-1313-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C92F88533CC
	for <lists+linux-spi@lfdr.de>; Tue, 13 Feb 2024 15:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8540528DB15
	for <lists+linux-spi@lfdr.de>; Tue, 13 Feb 2024 14:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E52A5EE78;
	Tue, 13 Feb 2024 14:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMswy4Tu"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7085EE7C
	for <linux-spi@vger.kernel.org>; Tue, 13 Feb 2024 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836177; cv=none; b=DdkjB/r0Tf17ItxA7LZR1njoISX1MILaA2OSqGCxvbTD3DiCKKfSUlLppDVKQch/ycBiHvJea8cQx+4iE5vy5C7E9R9UR/EuM3AoWAAeSiJ5jHMlN3OZVhu7LLxMvojIeH+zaBe/Li3uqbmzDeyw3tFcJgZnAIpmjwsKNJVtzU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836177; c=relaxed/simple;
	bh=sfQkFUnrsK4f2vQYpErI2bGgeDtpi9DQy3ovva1xbsw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=dCJJ/KJuuyu5ij3JP/UP2nZuk/it6oduhtIiQN7vJ97ZXh6tF7vToLn1TMDj/y8NklEFVDEnSTKWFMuEQ8AecY0BZIQuWl5TmU27sWXtqAdxkIoBzC66xOr3c2VGi2mEHj6GLDOGm0UfyeILTmLS22fqG2itl+YdPp6c8avZR/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMswy4Tu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BE2BC433A6;
	Tue, 13 Feb 2024 14:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707836176;
	bh=sfQkFUnrsK4f2vQYpErI2bGgeDtpi9DQy3ovva1xbsw=;
	h=Subject:From:Date:To:From;
	b=rMswy4TuI878w8y35dxMbfZcutCED6kgJqfqyERZR4TFvvbla/K6OevJUO/lwMZqB
	 t/es1v2A28c8H4UkopZRxLIilV3FMGK4+vj+VKP3TZamIdkSOw98Xdojr9zZotZD+e
	 YoBVAxvCexp/ho6d7CSb6OR9uTbtQaRmDJQ2rcHJtcZ8uGy6N29EmAS2eFzLmFOG1E
	 izwmLRsBbK3MwyhOYk/7S2S5GjAg9Nu9Vl9xK1vul0UzZ2yrtHqYaUY0xSxfXrfkzX
	 NBDEpgxriUiSfmzGCXVkXl9LnIQMdc/8v09/G198Ah8YaraVLFqQq+eKLa4Nwk6sQ2
	 4VwD9+zeiA16A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E374D84BC6;
	Tue, 13 Feb 2024 14:56:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <170783617651.29571.4902016953191704050.git-patchwork-housekeeping@kernel.org>
Date: Tue, 13 Feb 2024 14:56:16 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] Virtio SPI Linux driver compliant to draft spec V10 (2024-02-13T13:53:48)
  Superseding: [v2] Virtio SPI Linux driver compliant to draft spec V10 (2024-01-04T13:01:27):
    [RFC,v2,1/3] virtio: Add ID for virtio SPI.
    [RFC,v2,2/3] virtio-spi: Add virtio-spi.h (V10 draft specification).
    [RFC,v2,3/3] SPI: Add virtio SPI driver (V10 draft specification).


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


