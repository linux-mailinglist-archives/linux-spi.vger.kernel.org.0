Return-Path: <linux-spi+bounces-11490-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FD1C824B1
	for <lists+linux-spi@lfdr.de>; Mon, 24 Nov 2025 20:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D269C4E8D95
	for <lists+linux-spi@lfdr.de>; Mon, 24 Nov 2025 19:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A0B2D7393;
	Mon, 24 Nov 2025 19:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lb51unhd"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE382D6E61
	for <linux-spi@vger.kernel.org>; Mon, 24 Nov 2025 19:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764012042; cv=none; b=WojosqUN/o1kTX7xJNqlhiXb0Mg4wQ1LD2yeD/geproCRoDIzdzcR4FGWKMlliIuvrqXFEfUTtMu/mH1fo0f6N563xdWHJH9yAbgTDTL9O+M9F1lrTW8cQNRGjZdsmJ6rrE/MJWnb/jeV1R0qm//XIuPze53aYl32NxuYl/NVSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764012042; c=relaxed/simple;
	bh=2Afi0Tz7xdx7gkXRm+bIGrjoVSh698Ux01H3wo3CZ+Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=tEWAfNrh1mcOJtIU1BekPfe6YbrkbY7MPP7ljAc+ESoao9jeDlivPgkBisivbKz6KeulyTTrIKj370Y1IBqqcuGXhhgW1Nz91mqxv2VZv+MvYyVF43E4HKhvBHE+29CGHdSRmFLGeykkJkcWfpNHLheN9kY+Z3fqA6bkd0go7Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lb51unhd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E714AC4CEF1;
	Mon, 24 Nov 2025 19:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764012041;
	bh=2Afi0Tz7xdx7gkXRm+bIGrjoVSh698Ux01H3wo3CZ+Y=;
	h=Subject:From:Date:To:From;
	b=lb51unhdaAm5r4sn6Mxufq6VJGsQmmDE/FGkw2hg254EblL9vsBKqwasq5kU1PFa2
	 dAk+G+7ZtcXLCtMwbTXIn1h1Xtte4Qxg2jwXe1iilifgMy9pvyug+2QXRewYYKnl1r
	 sYiHCj//J7vNs/SIBPvd9Vl0fnh6F+mAFYtnoSJRLAL6g3zMOfBGdoxUU80K3L4ijL
	 mqSupAWqFyBgwIKCsiJUJMK16GJq/b75NkxmhnvDn0kkEVQJLZEy1KljHoCUduKYxa
	 xTCnaplIYhq0L4v026Silvi2+xFRdB+AtziC2JQCRR7k127206qDo95ynLywGYLav8
	 R5ea4wIJe4qCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EEF5D3A86296;
	Mon, 24 Nov 2025 19:20:05 +0000 (UTC)
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
 <176401200438.51718.4263033564629731530.git-patchwork-summary@kernel.org>
Date: Mon, 24 Nov 2025 19:20:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [next,v2] spi: Fix potential uninitialized variable in probe()
  Submitter: Dan Carpenter <dan.carpenter@linaro.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1026837
  Lore link: https://lore.kernel.org/r/aSQPkfkiJ0w-FJMW@stanley.mountain


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



