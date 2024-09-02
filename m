Return-Path: <linux-spi+bounces-4519-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D661968E04
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 20:57:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 019941F22274
	for <lists+linux-spi@lfdr.de>; Mon,  2 Sep 2024 18:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9801A3A8E;
	Mon,  2 Sep 2024 18:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgWGotzW"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C6A1A3ABA
	for <linux-spi@vger.kernel.org>; Mon,  2 Sep 2024 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725303419; cv=none; b=iRZvNdwjS8xZ4/DFvnltFxf3SuWU7CGgFz0CR7gbyk9aZ+Tvs3muWxMhz3zsvRS3cdYkjRwPY+Ixe7wq5dH5AnLRmxu2q9kT7kS7at4woRsBLGq6U6C1/4o6G04ktYp54e+z73+dcJhj3PmAjQDW7XBY7RdQbhvVR1CwzNrGrno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725303419; c=relaxed/simple;
	bh=iaBg5d/iPTPVmZ9N1sE+WJ7xGycnMb+zoHiUYbt5Aic=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=fOJQy96L9q4nmdKQmzfg6VaaRY0x8lQFMMWgjD/GFer5C0ZUj9mnD81ygF7yo37rZ/GKytf6EMqpKMp2JdX/ta3BYSZ54imDgz4YWHDos2hNF5+gRnScUewAVMruSMrDVYkV1wy1mLG2pz+zYqKtGNENo5+3Y94h0CekO9K0yK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgWGotzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0EBC4CEC2;
	Mon,  2 Sep 2024 18:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725303418;
	bh=iaBg5d/iPTPVmZ9N1sE+WJ7xGycnMb+zoHiUYbt5Aic=;
	h=Subject:From:Date:To:From;
	b=cgWGotzWDzURQeq+zWSg1W9vsGY+0k2aVNzve5b57/HKcok5WBzw1c9HXJaUUTpNQ
	 keCTXcxYotwEyRm+T1q9Yw18Hyl6WQbW7LLUbAZdJmxYBx21ikL17SIS7IDB1CZvMw
	 +I8oaACvONeh/Ob9nvAevavJa7DysKOhZNpp8qCwAhTD2x7sI5kXj3dmYjqm/uwdSm
	 CIF2DoMdz8u0v2mTBNDImQKTPUUlfW2p/nv4wocpUMHenI6IyMvVEk9Zc0HqX/TkCk
	 RSO3riA59UsBeyMvcl/U4VEvFnRdV9r7Wo3ULOkwtWxBGUg3CHlSrItBgavlcOR+DD
	 7flWszOU9JHkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B298D3805D82;
	Mon,  2 Sep 2024 18:56:59 +0000 (UTC)
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
 <172530341831.3964593.6587357324520184551.git-patchwork-housekeeping@kernel.org>
Date: Mon, 02 Sep 2024 18:56:58 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: mxs: Switch to RUNTIME/SYSTEM_SLEEP_PM_OPS() (2024-09-02T18:46:55)
  Superseding: [v1] spi: mxs: Switch to RUNTIME/SYSTEM_SLEEP_PM_OPS() (2024-08-07T19:19:22):
    spi: mxs: Switch to RUNTIME/SYSTEM_SLEEP_PM_OPS()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


