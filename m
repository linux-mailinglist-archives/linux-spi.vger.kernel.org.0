Return-Path: <linux-spi+bounces-1798-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5760887B30F
	for <lists+linux-spi@lfdr.de>; Wed, 13 Mar 2024 21:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8982F1C21091
	for <lists+linux-spi@lfdr.de>; Wed, 13 Mar 2024 20:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4C04CB35;
	Wed, 13 Mar 2024 20:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/9NWNLK"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFF946556
	for <linux-spi@vger.kernel.org>; Wed, 13 Mar 2024 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710363390; cv=none; b=cfiimQR1r42w2rnNmkaqNNZ2Rw9hgtwjxOPu92WbX425B+cj2cp0kmqV+0i9wwkBDyULAq4++lQRrZ4Pw6UI3DW/s5BL8uEvtg5bzcqJEe8rBd1aZM3+SfC8NEM6BNlqX+tkVp0jTBUHpjpJ0molBKz6i/pIzK6PcLiGl0JkHEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710363390; c=relaxed/simple;
	bh=NKTAbqkYX1OJAYeeRnB6hl1PNmiurph8AFSn6fpD/wA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=liHBeADh0hVaxthHdY9jWVhMEia7LxDUhK8Pgwssmm1gBzj8UM0TGg82hfjV9Fe3ok8v+5sAJWpP/ipmGOJkHlbCgf9g6jwSaB2Ig7sSaj5GcKVkwuCz8+ULZGHOIYqSDQpfsB8IobDxMhSY5xonfrnWe5YGhl8g11aUcI85Prg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/9NWNLK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 845D8C433F1;
	Wed, 13 Mar 2024 20:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710363389;
	bh=NKTAbqkYX1OJAYeeRnB6hl1PNmiurph8AFSn6fpD/wA=;
	h=Subject:From:Date:To:From;
	b=g/9NWNLKQ7HZHqHWhlbymUOK5Gd6lhT4V28vmHEz/3wRwwwBkkDhXLR4dm5idWRAR
	 aciINKAJLEqwTlk5Ez76Kgubl5lvRJMWbhKKI1/L5ZNs1YHKFsVp+Yb+yhjZO3kRTs
	 v0vyND3HMFdMllIXmnPRAD+VbfyXoS+Q2qMHzTtOOYjOcgAIx0ILquU0zaD2aoTm2w
	 GIjh+kvQlNetdfeXoP7bQLi63d8xktFCU+ZswxSGfN9BKCb7TOXtitGz9xsbk54LNN
	 iVT7Ls5mfDSzmq2b09JFyoi6jeZQhU50uNs4PlfXWZrUXNjRPC/IwtQa9GztSdEjAD
	 FVlMsof8AEN9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60EC6D95054;
	Wed, 13 Mar 2024 20:56:29 +0000 (UTC)
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
 <171036338932.30943.8300065881711266838.git-patchwork-housekeeping@kernel.org>
Date: Wed, 13 Mar 2024 20:56:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: Fix error code checking in spi_mem_exec_op() (2024-03-13T19:45:30)
  Superseding: [v1] spi: Fix error code checking in spi_mem_exec_op() (2024-03-13T17:10:49):
    spi: Fix error code checking in spi_mem_exec_op()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


