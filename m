Return-Path: <linux-spi+bounces-9518-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0C3B2B29E
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 22:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE0D77B651F
	for <lists+linux-spi@lfdr.de>; Mon, 18 Aug 2025 20:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2DF258EDE;
	Mon, 18 Aug 2025 20:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTgJQZLa"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2481E3451B8
	for <linux-spi@vger.kernel.org>; Mon, 18 Aug 2025 20:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755549623; cv=none; b=qHjlt4V33fKud1Fn4uvaniOUQY6iEuxaC43C1iI9PpnEE7xtXMpICwHu9e7l13mxtCIMDdgjztqRX1tYzrR9lzuJr5x7OqXyqcFPs+RQKBRlUFAVOy9/T3m8b2oo242E357uQyKYIeoVKblGQ90R4dmYOVWPOFIIk9vyycnYApU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755549623; c=relaxed/simple;
	bh=NPuS7Snf13QpiEfCPSjaIPhpDDwaXRQI1GDHVRYFOTo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=sLTiFAGj3apVyUWg/musiMLzwn/LbSybMefvUKMq0ctsijtoUVjRRhEbXxl70OSvNFGLSK3bNF/2hQua1YsTxYM3npAQUyAbk2hDl8ubwbgq2vpCccxiOiKZYVy2q9Ap7cL6Hao7xPbYb+szpDvtathJ7+yevd76Xct63ETLr88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTgJQZLa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8D0C4CEEB;
	Mon, 18 Aug 2025 20:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755549622;
	bh=NPuS7Snf13QpiEfCPSjaIPhpDDwaXRQI1GDHVRYFOTo=;
	h=Subject:From:Date:To:From;
	b=fTgJQZLa2ZlzQrdgf0afzEeb3+tE4WBwY4GhJMjEcBgy4D1OjbgwrbDezOCC4234M
	 X4hn6Mzr3qcquwv2IPU1fBtMs5p0aUNyOrb+XKnKRV20zUQXCqiM0keDJjXU5iQoQu
	 QgERbup85sE5+mvfxw1OjmJkY4X5gs8R8NRlxnJKK+gxRyEvhYKlGrEeoToQLY+rGl
	 ujT4jie9ezE+lOUqUhBAsQOLncsvgWJjiVw7F7j2ke1SsL3dpNPFz3c3/hpiw/4Y6u
	 mHRJPjnLiTvm6KsZOz9NYwhML+70iZW4bgv3//n9M2Hc7Zmk+kFOJH8/4Wz1DeA1i/
	 9f5rcVuIEaybg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EE8BD383BF4E;
	Mon, 18 Aug 2025 20:40:33 +0000 (UTC)
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
 <175554963259.2904664.4871044492964048139.git-patchwork-summary@kernel.org>
Date: Mon, 18 Aug 2025 20:40:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: offload-trigger: followup
  Submitter: David Lechner <dlechner@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=991992
  Lore link: https://lore.kernel.org/r/20250815-spi-offload-trigger-followup-v1-0-8ec5413a8383@baylibre.com
    Patches: [1/2] MAINTAINERS: merge TRIGGER SOURCE sections
             [2/2] spi: offload trigger: adi-util-sigma-delta: clean up imports

Series: spi: use min_t() to improve code
  Submitter: Qianfeng Rong <rongqianfeng@vivo.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=991836
  Lore link: https://lore.kernel.org/r/20250815082118.586422-1-rongqianfeng@vivo.com
    Patches: [1/3] spi: spi-fsl-lpspi: use min_t() to improve code
             [2/3] spi: npcm-fiu: use min_t() to improve code
             [3/3] spi: spl022: use min_t() to improve code


Total patches: 5

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



