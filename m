Return-Path: <linux-spi+bounces-1982-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9370488AEBC
	for <lists+linux-spi@lfdr.de>; Mon, 25 Mar 2024 19:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB55300F19
	for <lists+linux-spi@lfdr.de>; Mon, 25 Mar 2024 18:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A030C12C7FF;
	Mon, 25 Mar 2024 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yrs8azSZ"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACEE12C7FA
	for <linux-spi@vger.kernel.org>; Mon, 25 Mar 2024 18:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391467; cv=none; b=mFFtzleqR0AbWp8/yJvI+ETDpgTPEFFF83hY7LO5mKyDrLjKQ2T3ja+nZm1erXK43UBcLyFark7gU7jiRvvMYJLdO15G11yIojDisfYgI0xN4Hl+cZKfLm7fH7z+BIsKl3jGyBgOG0N3GcHZa/sZqF1IaxzUsDMJYTltSnm/tic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391467; c=relaxed/simple;
	bh=FYJINQKzIOXm8XldxEkL+gFCruJ56pcdrJoIaR3lyBw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=U9BV4mghHQ6Ze4tWKIV/aGxE2i+csWZ7H1Ptl2u4o8l5tfJR/msUUlCHGSbjJBoc1iWojBCR6YjbpdumnOSOjqgesZ2cnpR4hcTv3vs9lnkUA//Rhl+Wotk+/LFPfEVtpswjH1t/VcL2fmyIktpEhhc3wwKdQd82dWyAhm837Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yrs8azSZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17BF9C433F1;
	Mon, 25 Mar 2024 18:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711391467;
	bh=FYJINQKzIOXm8XldxEkL+gFCruJ56pcdrJoIaR3lyBw=;
	h=Subject:From:Date:To:From;
	b=Yrs8azSZy+5h614SDjJeSbU8QGAJcW2qVxAxuefzj8YdWIPW0JJxXdNhv2++Yveuh
	 bovTur8JPGi3Tas6asE/MiKZrFBRqvKCweKPtme++VpO/wr2vItu9/j7xmftJIpuxN
	 D5LwKzn/PUGJaCEFJMhS4QYGSEPrBtrZplYOCVHhbDZ/jzwk59BO6hz3V/R0/1ioHa
	 9NFn7WLHhYyk7Bpk+Wygx8pE+qhyur8JRcGSVfKu9BhoJc9aiHI6UX/eO2MXNtOoWM
	 pgdA1HFakrlfckD2XbboWPpGlU5xxVKN1+G3/snsBUKfgOGfqf4YD9ISxJBMXvU2G1
	 oU6nX/9E9MgIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07F84D2D0EA;
	Mon, 25 Mar 2024 18:31:07 +0000 (UTC)
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
 <171139146702.30782.6666835133761677912.git-patchwork-summary@kernel.org>
Date: Mon, 25 Mar 2024 18:31:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Fixes NULL pointer access in spi-mt65xx.c
  Submitter: Fei Shao <fshao@chromium.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=836944
  Lore link: https://lore.kernel.org/r/20240321070942.1587146-1-fshao@chromium.org
    Patches: [v2,1/2] spi: spi-mt65xx: Fix NULL pointer access in interrupt handler
             [v2,2/2] spi: spi-mt65xx: Rename a variable in interrupt handler

Patch: [v2] spi: mt7621: allow GPIO chip select lines
  Submitter: Justin Swartz <justin.swartz@risingedge.co.za>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=835783
  Lore link: https://lore.kernel.org/r/20240316010302.20776-1-justin.swartz@risingedge.co.za


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



