Return-Path: <linux-spi+bounces-7070-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D88F0A55670
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 20:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DE8E175D21
	for <lists+linux-spi@lfdr.de>; Thu,  6 Mar 2025 19:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4091269AE0;
	Thu,  6 Mar 2025 19:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjpRfJoh"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7C420967A
	for <linux-spi@vger.kernel.org>; Thu,  6 Mar 2025 19:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741288799; cv=none; b=gmA8EcrFN6nwii54ZSgaDWmtt//NKI1orIqG8RV93sh0f57O8Iq04yCAnS8SSSSJSXu7yvGCadjZK7uX0eamLE7KqOyA7KHxHjt2TdOHCRinouOlJQho8R1fYGrvoQJrSDJhH2cBx0SVJs1qWPQSs49t7Ym7ueyNPTXPeNk36qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741288799; c=relaxed/simple;
	bh=YJN9Bd+mZtYpCb1G+XUo1vXAXzELRM90BzA3aNr9r6o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=fS005JtT6kGCHdNl0zTB9hV32fUmGC3/8GxRhfHdfbJ9R7e83mi8j4LHS5JC+Yx/1qUGQQmlsv7hWY7RvjfBMWGqzK/783EODnGzeTlzVKhO572UtqTjCJK74HKOY/x3hj2gNQJmuFfIh3odZFV5h7BqILh9V6V9o9vac85aqpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjpRfJoh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540EBC4CEE0;
	Thu,  6 Mar 2025 19:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741288798;
	bh=YJN9Bd+mZtYpCb1G+XUo1vXAXzELRM90BzA3aNr9r6o=;
	h=Subject:From:Date:To:From;
	b=CjpRfJohqfQsQTi/jK/RlwLq+gOftnaV+nbt4s9AjOPJhFBoZKFoYEb0MozoJDAkG
	 iQLiXz0GEQGvSd+NrW7R1OYvBXvew+NkB/8LhTk3qCdMV+FoMgnvq7oVO2+YpA1QDg
	 m5clGbHX3QBzkxpBXs/TLT7iW/nR+1HqU7xXE4rB9LVW794z5HLIlGmOPw7M8Qfuql
	 WynIm6vot3gCEFfbusPcIUYztOEB3yAcBePXnNemil3K1dF+DRQUwdoR6Bei/Lb8yE
	 K6UdwLnTw2GVVVlA1A8ZCABXvBc/rtzTMf4qKoojwxl3vo0G9ymXW6/e9L4YShFqVg
	 0dJi8j703bVbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B3AEE380CEE6;
	Thu,  6 Mar 2025 19:20:32 +0000 (UTC)
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
 <174128883128.1748733.4309582661276047321.git-patchwork-summary@kernel.org>
Date: Thu, 06 Mar 2025 19:20:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [-next] spi: stm32: Remove unnecessary print function dev_err()
  Submitter: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=940820
  Lore link: https://lore.kernel.org/r/20250306024716.27856-1-jiapeng.chong@linux.alibaba.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



