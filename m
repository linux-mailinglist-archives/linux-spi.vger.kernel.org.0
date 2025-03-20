Return-Path: <linux-spi+bounces-7247-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AEA4A6A68B
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 13:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19D7948485D
	for <lists+linux-spi@lfdr.de>; Thu, 20 Mar 2025 12:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7F2262A6;
	Thu, 20 Mar 2025 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XI8CWkdL"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A4E1EEE9
	for <linux-spi@vger.kernel.org>; Thu, 20 Mar 2025 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742475387; cv=none; b=l+HhiuDL2tI+1E6PVrwKCW6zNi6TPnYhSpA2rodP6iTn3w3gI58PfNbVF4sswzc6D+OtKMS8acO/dxgKMCQYi8xii71eauMJdZyF6gi9I1t7Zpc2Kfn+ZxVezmWxoWZWdOWZjXfS54WHzjWExfW0IstdRjxZGAqPoD/ojNAbr+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742475387; c=relaxed/simple;
	bh=mseQ49i7FFm178mu4KQjkM7Uva8+739jInuLi/nZilM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=F3KYcvRqSZSE8udJPICDr5/4sQYqd8QC7B35JbFB1riUWp7nWErHynL9uzBEqi5+2022akNu6QpD0IzYslrGJPSiNlfLNV54JxNE40oV55TvzKu6EndJN9N4fv50306g0SYmijeuCOZeTYGfbMKf+0TBdMFOg+g4H3vjIALlEeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XI8CWkdL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59D6C4CEDD;
	Thu, 20 Mar 2025 12:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742475386;
	bh=mseQ49i7FFm178mu4KQjkM7Uva8+739jInuLi/nZilM=;
	h=Subject:From:Date:To:From;
	b=XI8CWkdL1ioiW6GOqh7aeotfKvT9GYEpCEacdCcg7U2yD3ntdpOR5680oPLzf+c47
	 UCNPbDTZEXsI2p8M/YjBhoed8e0E1I0wuf3il2i9/adRL+S08Lf6f26OMIYEpPnTf/
	 GcAbH0pMn5k+zncKk8HKUiWNiNJw/OSTmZA7pa4ejoqJlWYSZrD7Sb6NnEDdxLbbiM
	 JoOdpYrAOLnWco9NL+jjWh6z2DE/hSie2VrYRdERm1Lkjx1zI11bec7vqmpJhsmT2n
	 EzEWsIDUB+pbtNAgyoe0vY30/5iWpHJj1oS2sY6B1igwMce5BsNGNp3GI14Py7AQPz
	 pt2eZH8A4tP9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB2683806654;
	Thu, 20 Mar 2025 12:57:03 +0000 (UTC)
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
 <174247542256.1757241.16800464314430053353.git-patchwork-housekeeping@kernel.org>
Date: Thu, 20 Mar 2025 12:57:02 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi-mem: Introduce a default ->exec_op() debug log (2025-03-20T11:56:44)
  Superseding: [v1] spi: spi-mem: Introduce a default ->exec_op() debug log (2025-03-05T20:11:40):
    spi: spi-mem: Introduce a default ->exec_op() debug log


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


